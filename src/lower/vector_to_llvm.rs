//! `vector` ⇒ `llvm`, the conversion patterns of `ConvertVectorToLLVM.cpp`.

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;
use core::cell::Cell;

use mlirpass_macros::patterns;
use mlirformat::{Attribute, Dim, FloatKind, Shaped, ShapedKind, Type};

use super::memref_to_llvm::{Cr, Gep, MemrefToLlvm as M};
use crate::{LlvmOptions, OpData, OpId, ValueId, DYNAMIC};
use mlirformat::llvm_types::LlvmType;

/// The vector ⇒ llvm patterns.
pub struct VectorToLlvm;

/// `populateVectorToLLVMConversionPatterns`'s knobs.
#[derive(Clone, Copy)]
pub struct VectorOptions<'c> {
    pub llvm: LlvmOptions,
    pub reassociate_fp_reductions: bool,
    pub force_32bit_indices: bool,
    pub use_vector_alignment: bool,
    /// `ensureSymbolNameIsUnique`'s counter, for `vector.print` strings.
    pub counter: &'c Cell<u32>,
}

#[patterns(converter, options = VectorOptions<'p>)]
impl VectorToLlvm {
    fn vector<'t, 'a>(t: &'t Type<'a>) -> Option<&'t Shaped<'a>> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => Some(s),
            _ => None,
        }
    }

    fn vrank(s: &Shaped<'_>) -> usize {
        s.shape.as_ref().map_or(0, Vec::len)
    }

    fn scalable(s: &Shaped<'_>) -> bool {
        s.shape.iter().flatten().any(|d| matches!(d, Dim::Scalable(_)))
    }

    fn dim(d: &Dim) -> i64 {
        match d {
            Dim::Static(n) | Dim::Scalable(n) => *n,
            Dim::Dynamic => DYNAMIC,
        }
    }

    fn result_type<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Type<'a> {
        cr.rw.body[cr.rw.body[op].results[0]].ty.clone()
    }

    fn operand_type<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, i: usize) -> Type<'a> {
        cr.rw.body[cr.rw.body[op].operands[i]].ty.clone()
    }

    fn convert<'a>(cr: &Cr<'_, 'a, '_>, t: &Type<'a>) -> Option<Type<'a>> {
        cr.type_converter()?.convert(t)
    }

    fn i_const<'a>(cr: &mut Cr<'_, 'a, '_>, v: i64, attr_ty: Type<'a>, ty: Type<'a>) -> ValueId {
        cr.llvm_constant(Attribute::Int { lit: format!("{v}").into(), ty: Some(attr_ty) }, ty)
    }

    /// An i64-typed `llvm.mlir.constant` of index value `v` (`insertOne` / `extractOne`).
    fn idx_const<'a>(cr: &mut Cr<'_, 'a, '_>, opts: LlvmOptions, v: i64) -> ValueId {
        Self::i_const(cr, v, Type::Index, opts.index())
    }

    fn insert_one<'a>(cr: &mut Cr<'_, 'a, '_>, opts: LlvmOptions, agg: ValueId, v: ValueId, ty: Type<'a>, rank: usize, pos: i64) -> ValueId {
        if rank == 1 {
            let c = Self::idx_const(cr, opts, pos);
            return cr.build(OpData::build("llvm.insertelement").operands(&[agg, v, c]), ty);
        }
        cr.insert_value(agg, v, &[pos])
    }

    fn extract_one<'a>(cr: &mut Cr<'_, 'a, '_>, opts: LlvmOptions, v: ValueId, ty: Type<'a>, rank: usize, pos: i64) -> ValueId {
        if rank <= 1 {
            let c = Self::idx_const(cr, opts, pos);
            return cr.build(OpData::build("llvm.extractelement").operands(&[v, c]), ty);
        }
        cr.extract(v, &[pos])
    }

    /// `getPreferredAlignment` under LLVM's default data layout.
    fn preferred_alignment(opts: LlvmOptions, t: &Type<'_>) -> Option<i64> {
        if let Ok(LlvmType::Ptr(_)) = LlvmType::try_from(t) {
            return Some(8);
        }
        Some(match t {
            Type::Index => i64::from(opts.index_bitwidth.div_ceil(8)).max(1),
            Type::Integer { width, .. } => match *width {
                0..=8 => 1,
                9..=16 => 2,
                17..=32 => 4,
                33..=64 => 8,
                _ => 16,
            },
            Type::Float(k) => match k {
                FloatKind::F16 | FloatKind::BF16 => 2,
                FloatKind::F32 => 4,
                FloatKind::F64 => 8,
                _ => 16,
            },
            Type::Shaped(s) if s.kind == ShapedKind::Vector => {
                let n: i64 = s.shape.iter().flatten().map(Self::dim).product();
                let bits = i64::from(crate::bit_width(&s.elem)?) * n;
                (((bits + 7) / 8).max(1) as u64).next_power_of_two() as i64
            }
            _ => return None,
        })
    }

    /// `getVectorToLLVMAlignment`.
    fn alignment<'a>(cr: &Cr<'_, 'a, '_>, o: VectorOptions<'_>, op: OpId, vector: &Type<'a>, memref: &Shaped<'a>) -> Option<i64> {
        if let Some(a) = cr.rw.body[op].get("alignment").and_then(M::int).filter(|a| *a != 0) {
            return Some(a);
        }
        if o.use_vector_alignment {
            let c = Self::convert(cr, vector)?;
            Self::preferred_alignment(o.llvm, &c)
        } else {
            let c = Self::convert(cr, &memref.elem)?;
            Self::preferred_alignment(o.llvm, &c)
        }
    }

    /// `isMemRefTypeSupported`: unit innermost stride and an integer address space.
    fn memref_supported(opts: LlvmOptions, s: &Shaped<'_>) -> bool {
        opts.address_space(s).is_some() && opts.strides_and_offset(s).is_some_and(|(st, _)| st.last().is_none_or(|l| *l == 1))
    }

    fn i32_attr<'a>(v: i64) -> Attribute<'a> {
        Attribute::Int { lit: format!("{v}").into(), ty: Some(Type::int(32)) }
    }

    #[lowering("vector.bitcast")]
    fn bitcast<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorOptions<'_>) -> bool {
        let rt = Self::result_type(cr, op);
        if Self::vector(&rt).is_none_or(|s| Self::vrank(s) > 1) {
            return false;
        }
        let Some(t) = Self::convert(cr, &rt) else { return false };
        cr.replace_new(op, OpData::build("llvm.bitcast").operands(&[operands[0][0]]), &[t]);
        true
    }

    /// `vector.load` / `maskedload` / `store` / `maskedstore`.
    #[lowering("vector.load", "vector.maskedload", "vector.store", "vector.maskedstore")]
    fn load_store<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorOptions<'_>) -> bool {
        let name = String::from(&*cr.rw.body[op].name);
        // Operands: `store` (value, base, indices...); the others (base, indices..., [mask,
        // pass_thru | value]).
        let base_at = usize::from(name == "vector.store");
        let Some(m) = M::operand_memref(cr, op, base_at) else { return false };
        let vt = match &*name {
            "vector.store" => Self::operand_type(cr, op, 0),
            "vector.maskedstore" => Self::operand_type(cr, op, operands.len() - 1),
            _ => Self::result_type(cr, op),
        };
        let Some(vs) = Self::vector(&vt) else { return false };
        if Self::vrank(vs) > 1 {
            return false;
        }
        let Some(align) = Self::alignment(cr, o, op, &vt, &m) else { return false };
        let Some(lt) = Self::convert(cr, &vt) else { return false };
        let rank = M::rank(&m);
        let indices: Vec<ValueId> = operands[base_at + 1..base_at + 1 + rank].iter().flatten().copied().collect();
        let Some(ptr) = M::strided_ptr(cr, o.llvm, &m, operands[base_at][0], &indices, 0) else { return false };
        let rest: Vec<ValueId> = operands[base_at + 1 + rank..].iter().flatten().copied().collect();
        let nontemporal = matches!(cr.rw.body[op].get("nontemporal"), Some(Attribute::Bool(true)));
        let mem = |mut d: OpData<'a>| -> OpData<'a> {
            if align != 0 {
                d.set("alignment", Attribute::i64(align));
            }
            if nontemporal {
                d.set("nontemporal", Attribute::Unit);
            }
            d
        };
        match &*name {
            "vector.load" => {
                cr.replace_new(op, mem(OpData::build("llvm.load").operands(&[ptr])), &[lt]);
            }
            "vector.store" => {
                cr.replace_new(op, mem(OpData::build("llvm.store").operands(&[operands[0][0], ptr])), &[]);
            }
            "vector.maskedload" => {
                let d = OpData::build("llvm.intr.masked.load").operands(&[ptr, rest[0], rest[1]]).with("alignment", Self::i32_attr(align));
                cr.replace_new(op, d, &[lt]);
            }
            _ => {
                let d = OpData::build("llvm.intr.masked.store").operands(&[rest[1], ptr, rest[0]]).with("alignment", Self::i32_attr(align));
                cr.replace_new(op, d, &[]);
            }
        }
        true
    }

    /// `getIndexedPtrs`: a vector of element pointers.
    fn indexed_ptrs<'a>(cr: &mut Cr<'_, 'a, '_>, o: VectorOptions<'_>, m: &Shaped<'a>, vs: &Shaped<'a>, base: ValueId, index: ValueId) -> Option<ValueId> {
        let d = vs.shape.as_ref()?.first()?.clone();
        let ptrs = Type::Shaped(Shaped { kind: ShapedKind::Vector, shape: Some(vec![d]), elem: Type::from(LlvmType::Ptr(o.llvm.address_space(m)?)).into(), extras: Vec::new() });
        let elem = M::elem(cr, &m.elem)?;
        Some(M::gep(cr, ptrs, elem, base, &[Gep::V(index)], 0))
    }

    /// `vector.gather` / `vector.scatter`.
    #[lowering("vector.gather", "vector.scatter")]
    fn gather_scatter<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorOptions<'_>) -> bool {
        let scatter = cr.rw.body[op].name == "vector.scatter";
        let Some(m) = M::operand_memref(cr, op, 0) else { return false };
        if !Self::memref_supported(o.llvm, &m) {
            return false;
        }
        let vt = if scatter { Self::operand_type(cr, op, operands.len() - 1) } else { Self::result_type(cr, op) };
        let Some(vs) = Self::vector(&vt).cloned() else { return false };
        if Self::vrank(&vs) > 1 {
            return false;
        }
        let Some(align) = Self::alignment(cr, o, op, &vt, &m) else { return false };
        let rank = M::rank(&m);
        let offsets: Vec<ValueId> = operands[1..1 + rank].iter().flatten().copied().collect();
        let Some(ptr) = M::strided_ptr(cr, o.llvm, &m, operands[0][0], &offsets, 0) else { return false };
        let rest: Vec<ValueId> = operands[1 + rank..].iter().flatten().copied().collect();
        let Some(ptrs) = Self::indexed_ptrs(cr, o, &m, &vs, ptr, rest[0]) else { return false };
        if scatter {
            let d = OpData::build("llvm.intr.masked.scatter").operands(&[rest[2], ptrs, rest[1]]).with("alignment", Self::i32_attr(align));
            cr.replace_new(op, d, &[]);
        } else {
            let Some(lt) = Self::convert(cr, &vt) else { return false };
            let d = OpData::build("llvm.intr.masked.gather").operands(&[ptrs, rest[1], rest[2]]).with("alignment", Self::i32_attr(align));
            cr.replace_new(op, d, &[lt]);
        }
        true
    }

    /// `vector.expandload` / `vector.compressstore`: (base, indices..., mask, pass_thru |
    /// value); an alignment other than 1 goes on the pointer's argument attributes.
    #[lowering("vector.expandload", "vector.compressstore")]
    fn expand_compress<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorOptions<'_>) -> bool {
        let compress = cr.rw.body[op].name == "vector.compressstore";
        let Some(m) = M::operand_memref(cr, op, 0) else { return false };
        let rank = M::rank(&m);
        let indices: Vec<ValueId> = operands[1..1 + rank].iter().flatten().copied().collect();
        let Some(ptr) = M::strided_ptr(cr, o.llvm, &m, operands[0][0], &indices, 0) else { return false };
        let rest: Vec<ValueId> = operands[1 + rank..].iter().flatten().copied().collect();
        let align = cr.rw.body[op].get("alignment").and_then(M::int).unwrap_or(1);
        let with_align = |d: OpData<'a>, at: usize| -> OpData<'a> {
            if align == 1 {
                return d;
            }
            let mut dicts = vec![Attribute::Dict(Vec::new()); 3];
            dicts[at] = Attribute::Dict(vec![mlirformat::NamedAttr { name: "llvm.align".into(), value: Some(Attribute::i64(align)) }]);
            d.with("arg_attrs", Attribute::Array(dicts))
        };
        if compress {
            cr.replace_new(op, with_align(OpData::build("llvm.intr.masked.compressstore").operands(&[rest[1], ptr, rest[0]]), 1), &[]);
        } else {
            let rt = Self::result_type(cr, op);
            let Some(lt) = Self::convert(cr, &rt) else { return false };
            cr.replace_new(op, with_align(OpData::build("llvm.intr.masked.expandload").operands(&[ptr, rest[0], rest[1]]), 0), &[lt]);
        }
        true
    }

    /// The combining kind of a `#vector.kind<...>` attribute.
    fn kind<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Option<String> {
        match cr.rw.body[op].get("kind")? {
            Attribute::Extended { ext, .. } => Some(String::from(ext.body.as_deref()?.trim_matches(|c| c == '<' || c == '>'))),
            _ => None,
        }
    }

    fn fmf<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, reassoc: bool) -> Attribute<'a> {
        let a = super::llvm_fastmath(cr.rw.body[op].get("fastmath"));
        if !reassoc {
            return a;
        }
        let body = match &a {
            Attribute::Extended { ext, .. } => String::from(ext.body.as_deref().unwrap_or("<none>")),
            _ => String::from("<none>"),
        };
        let mut flags: Vec<&str> = body.trim_matches(|c| c == '<' || c == '>').split(',').map(str::trim).filter(|f| !f.is_empty() && *f != "none").collect();
        if !flags.contains(&"reassoc") {
            flags.push("reassoc");
        }
        let order = ["nnan", "ninf", "nsz", "arcp", "contract", "afn", "reassoc"];
        flags.sort_by_key(|f| order.iter().position(|o| o == f));
        let text = if flags.len() == 7 { String::from("fast") } else { flags.join(", ") };
        Attribute::dialect("llvm.fastmath", &format!("<{text}>"))
    }

    /// The neutral element of a reduction `what` on `ty` (`createReductionNeutralValue`).
    fn neutral<'a>(cr: &mut Cr<'_, 'a, '_>, ty: &Type<'a>, what: &str) -> ValueId {
        let w = crate::bit_width(ty).unwrap_or(64);
        let value = match what {
            "zero" if matches!(ty, Type::Float(_)) => Attribute::Float { lit: "0.000000e+00".into(), ty: Some(ty.clone()) },
            "zero" => Attribute::Int { lit: "0".into(), ty: Some(ty.clone()) },
            "fpone" => Attribute::Float { lit: "1.000000e+00".into(), ty: Some(ty.clone()) },
            "intone" => Attribute::Int { lit: "1".into(), ty: Some(ty.clone()) },
            "allones" | "uintmax" => Attribute::Int { lit: "-1".into(), ty: Some(ty.clone()) },
            "sintmin" => Attribute::Int { lit: format!("{}", -(1i128 << (w - 1))).into(), ty: Some(ty.clone()) },
            "sintmax" => Attribute::Int { lit: format!("{}", (1i128 << (w - 1)) - 1).into(), ty: Some(ty.clone()) },
            "uintmin" => Attribute::Int { lit: "0".into(), ty: Some(ty.clone()) },
            // fpmin / fpmax: a quiet NaN, positive or negative.
            n => {
                let neg = n == "fpmax";
                let hex = match w {
                    16 if matches!(ty, Type::Float(FloatKind::BF16)) => if neg { "0xFFC0" } else { "0x7FC0" },
                    16 => if neg { "0xFE00" } else { "0x7E00" },
                    32 => if neg { "0xFFC00000" } else { "0x7FC00000" },
                    _ => if neg { "0xFFF8000000000000" } else { "0x7FF8000000000000" },
                };
                Attribute::Float { lit: hex.into(), ty: Some(ty.clone()) }
            }
        };
        cr.llvm_constant(value, ty.clone())
    }

    #[lowering("vector.reduction")]
    fn reduction<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorOptions<'_>) -> bool {
        let Some(kind) = Self::kind(cr, op) else { return false };
        let elt = Self::result_type(cr, op);
        let Some(lt) = Self::convert(cr, &elt) else { return false };
        let v = operands[0][0];
        let acc = operands.get(1).map(|a| a[0]);
        let int = matches!(elt, Type::Index | Type::Integer { .. });
        let un = |cr: &mut Cr<'_, 'a, '_>, name: &str, extra: Option<Attribute<'a>>| {
            let mut d = OpData::build(name).operands(&[v]);
            if let Some(f) = extra {
                d.set("fastmathFlags", f);
            }
            cr.build(d, lt.clone())
        };
        let result = if int {
            let (intr, scalar, pred) = match &*kind {
                "add" => ("add", Some("llvm.add"), None),
                "mul" => ("mul", Some("llvm.mul"), None),
                "minui" => ("umin", None, Some(7)),
                "minsi" => ("smin", None, Some(3)),
                "maxui" => ("umax", None, Some(9)),
                "maxsi" => ("smax", None, Some(5)),
                "and" => ("and", Some("llvm.and"), None),
                "or" => ("or", Some("llvm.or"), None),
                "xor" => ("xor", Some("llvm.xor"), None),
                _ => return false,
            };
            let r = un(cr, &format!("llvm.intr.vector.reduce.{intr}"), None);
            match (acc, scalar, pred) {
                (Some(a), Some(s), _) => cr.build(OpData::build(s).operands(&[a, r]), lt.clone()),
                (Some(a), None, Some(p)) => {
                    let c = cr.build(OpData::build("llvm.icmp").operands(&[a, r]).with("predicate", Attribute::i64(p)), Type::int(1));
                    cr.build(OpData::build("llvm.select").operands(&[c, a, r]), lt.clone())
                }
                _ => r,
            }
        } else {
            if !matches!(elt, Type::Float(_)) {
                return false;
            }
            let fmf = Self::fmf(cr, op, o.reassociate_fp_reductions);
            match &*kind {
                "add" | "mul" => {
                    let a = match acc {
                        Some(a) => a,
                        None => Self::neutral(cr, &lt, if kind == "add" { "zero" } else { "fpone" }),
                    };
                    let name = if kind == "add" { "llvm.intr.vector.reduce.fadd" } else { "llvm.intr.vector.reduce.fmul" };
                    cr.build(OpData::build(name).operands(&[a, v]).with("fastmathFlags", fmf), lt.clone())
                }
                k @ ("minimumf" | "maximumf" | "minnumf" | "maxnumf") => {
                    let (intr, scalar) = match k {
                        "minimumf" => ("fminimum", "llvm.intr.minimum"),
                        "maximumf" => ("fmaximum", "llvm.intr.maximum"),
                        "minnumf" => ("fmin", "llvm.intr.minnum"),
                        _ => ("fmax", "llvm.intr.maxnum"),
                    };
                    let r = un(cr, &format!("llvm.intr.vector.reduce.{intr}"), Some(fmf));
                    match acc {
                        Some(a) => cr.build(OpData::build(scalar).operands(&[r, a]), lt.clone()),
                        None => r,
                    }
                }
                _ => return false,
            }
        };
        cr.replace(op, vec![vec![result]]);
        true
    }

    /// `MaskedReductionOpConversion`: a `vector.mask` around a `vector.reduction`.
    #[lowering("vector.mask")]
    fn masked_reduction<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorOptions<'_>) -> bool {
        let region = cr.rw.body[op].regions[0];
        let Some(&block) = cr.rw.body[region].blocks.first() else { return false };
        let Some(&red) = cr.rw.body[block].ops.first() else { return false };
        if cr.rw.body[red].name != "vector.reduction" {
            return false;
        }
        let Some(kind) = Self::kind(cr, red) else { return false };
        let elt = Self::result_type(cr, red);
        let Some(lt) = Self::convert(cr, &elt) else { return false };
        // The reduction's own (unconverted) operands, as the C++ pattern uses them.
        let v = cr.rw.body[red].operands[0];
        let acc = cr.rw.body[red].operands.get(1).copied();
        let mask = operands[0][0];
        let fmf = super::llvm_fastmath(cr.rw.body[red].get("fastmath"));
        let int = matches!(elt, Type::Index | Type::Integer { .. });
        let vp = |cr: &mut Cr<'_, 'a, '_>, name: &str, neutral: &str| -> ValueId {
            let a = match acc {
                Some(a) => a,
                None => Self::neutral(cr, &lt, neutral),
            };
            let vt = cr.rw.body[v].ty.clone();
            let n = Self::vector(&vt).and_then(|s| s.shape.as_ref()?.first().cloned()).unwrap_or(Dim::Static(1));
            let base = Self::i_const(cr, Self::dim(&n), Type::int(32), Type::int(32));
            let len = if matches!(n, Dim::Scalable(_)) {
                let vscale = cr.build(OpData::build("vector.vscale"), Type::Index);
                let cast = cr.build(OpData::build("arith.index_cast").operands(&[vscale]), Type::int(32));
                cr.build(OpData::build("arith.muli").operands(&[base, cast]), Type::int(32))
            } else {
                base
            };
            cr.build(OpData::build(&format!("llvm.intr.vp.reduce.{name}")).operands(&[a, v, mask, len]), lt.clone())
        };
        let result = match (&*kind, int) {
            ("add", true) => vp(cr, "add", "zero"),
            ("add", false) => vp(cr, "fadd", "zero"),
            ("mul", true) => vp(cr, "mul", "intone"),
            ("mul", false) => vp(cr, "fmul", "fpone"),
            ("minui", _) => vp(cr, "umin", "uintmax"),
            ("minsi", _) => vp(cr, "smin", "sintmax"),
            ("maxui", _) => vp(cr, "umax", "uintmin"),
            ("maxsi", _) => vp(cr, "smax", "sintmin"),
            ("and", _) => vp(cr, "and", "allones"),
            ("or", _) => vp(cr, "or", "zero"),
            ("xor", _) => vp(cr, "xor", "zero"),
            ("minnumf", _) => vp(cr, "fmin", "fpmax"),
            ("maxnumf", _) => vp(cr, "fmax", "fpmin"),
            (k @ ("maximumf" | "minimumf"), _) => {
                // `lowerMaskedReductionWithRegular`: masked-off lanes get a neutral value.
                let vt = cr.rw.body[v].ty.clone();
                let (bits, lit) = match (k, crate::bit_width(&lt)) {
                    ("maximumf", Some(16)) => (16, "-5.960460e-08"),
                    ("maximumf", Some(64)) => (64, "-4.940660e-324"),
                    ("maximumf", _) => (32, "-1.401300e-45"),
                    (_, Some(16)) => (16, "6.550400e+04"),
                    (_, Some(64)) => (64, "1.7976931348623157E+308"),
                    _ => (32, "3.40282347E+38"),
                };
                let _ = bits;
                let dense = Attribute::Builtin { name: "dense".into(), body: format!("<{lit}>").into(), ty: Some(vt.clone()) };
                let neutral = cr.llvm_constant(dense, vt.clone());
                let sel = cr.build(OpData::build("llvm.select").operands(&[mask, v, neutral]), vt);
                let (intr, scalar) = if k == "maximumf" { ("fmaximum", "llvm.intr.maximum") } else { ("fminimum", "llvm.intr.minimum") };
                let r = cr.build(OpData::build(&format!("llvm.intr.vector.reduce.{intr}")).operands(&[sel]).with("fastmathFlags", fmf), lt.clone());
                match acc {
                    Some(a) => cr.build(OpData::build(scalar).operands(&[r, a]), lt.clone()),
                    None => r,
                }
            }
            _ => return false,
        };
        let _ = o;
        cr.replace(op, vec![vec![result]]);
        true
    }

    fn mask_list<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, name: &str) -> Vec<i64> {
        match cr.rw.body[op].get(name) {
            Some(Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse().unwrap_or(0)).collect(),
            _ => Vec::new(),
        }
    }

    fn i32_array<'a>(v: &[i64]) -> Attribute<'a> {
        Attribute::DenseArray { ty: Type::int(32), values: v.iter().map(|x| format!("{x}").into()).collect() }
    }

    #[lowering("vector.shuffle")]
    fn shuffle<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorOptions<'_>) -> bool {
        let (t1, t2, rt) = (Self::operand_type(cr, op, 0), Self::operand_type(cr, op, 1), Self::result_type(cr, op));
        let Some(lt) = Self::convert(cr, &rt) else { return false };
        let mask = Self::mask_list(cr, op, "mask");
        let rank = Self::vector(&rt).map_or(0, Self::vrank);
        let (v1, v2) = (operands[0][0], operands[1][0]);
        if rank <= 1 && t1 == t2 {
            cr.replace_new(op, OpData::build("llvm.shufflevector").operands(&[v1, v2]).with("mask", Self::i32_array(&mask)), &[lt]);
            return true;
        }
        let v1_dim = Self::vector(&t1).and_then(|s| s.shape.as_ref()?.first().map(Self::dim)).unwrap_or(1);
        let elt = match LlvmType::try_from(&lt) {
            Ok(LlvmType::Array(_, e)) => *e,
            _ => match Self::vector(&lt) {
                Some(s) => (*s.elem).clone(),
                None => return false,
            },
        };
        let mut ins = cr.poison(lt.clone());
        for (pos, &e) in mask.iter().enumerate() {
            let (value, e) = if e >= v1_dim { (v2, e - v1_dim) } else { (v1, e) };
            let x = Self::extract_one(cr, o.llvm, value, elt.clone(), rank, e);
            ins = Self::insert_one(cr, o.llvm, ins, x, lt.clone(), rank, pos as i64);
        }
        cr.replace(op, vec![vec![ins]]);
        true
    }

    /// The `static_position` of an extract / insert, with dynamic entries from `dynamic`.
    fn positions<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, dynamic: &[ValueId]) -> Vec<Result<i64, ValueId>> {
        let mut d = dynamic.iter();
        Self::mask_list(cr, op, "static_position").into_iter().map(|p| if p == DYNAMIC { Err(*d.next().expect("dynamic position")) } else { Ok(p) }).collect()
    }

    /// `getAsLLVMValue`: a constant position becomes an `i64` constant.
    fn position_value<'a>(cr: &mut Cr<'_, 'a, '_>, p: Result<i64, ValueId>) -> ValueId {
        match p {
            Ok(c) => Self::i_const(cr, c, Type::int(64), Type::int(64)),
            Err(v) => v,
        }
    }

    #[lowering("vector.extract")]
    fn extract<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorOptions<'_>) -> bool {
        let rt = Self::result_type(cr, op);
        if Self::convert(cr, &rt).is_none() {
            return false;
        }
        let st = Self::operand_type(cr, op, 0);
        let src_rank = Self::vector(&st).map_or(0, Self::vrank);
        let dynamic: Vec<ValueId> = operands[1..].iter().flatten().copied().collect();
        let mut pos = Self::positions(cr, op, &dynamic);
        let aggregate = src_rank >= 2;
        let scalar = pos.len() == src_rank;
        if src_rank == 0 {
            pos.push(Ok(0));
        }
        let mut x = operands[0][0];
        if aggregate {
            let p = if scalar { &pos[..pos.len() - 1] } else { &pos[..] };
            let Some(consts) = p.iter().map(|r| r.ok()).collect::<Option<Vec<i64>>>() else { return false };
            x = cr.extract(x, &consts);
        }
        if scalar {
            let last = *pos.last().expect("position");
            let idx = Self::position_value(cr, last);
            let et = match Self::vector(&cr.rw.body[x].ty.clone()) {
                Some(s) => (*s.elem).clone(),
                None => return false,
            };
            x = cr.build(OpData::build("llvm.extractelement").operands(&[x, idx]), et);
        }
        let _ = o;
        cr.replace(op, vec![vec![x]]);
        true
    }

    #[lowering("vector.insert")]
    fn insert<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorOptions<'_>) -> bool {
        let dt = Self::operand_type(cr, op, 1);
        let Some(lt) = Self::convert(cr, &dt) else { return false };
        let rank = Self::vector(&dt).map_or(0, Self::vrank);
        let dynamic: Vec<ValueId> = operands[2..].iter().flatten().copied().collect();
        let pos = Self::positions(cr, op, &dynamic);
        let nested = matches!(LlvmType::try_from(&lt), Ok(LlvmType::Array(..)));
        let innermost = pos.len() == rank;
        let outer = if innermost { &pos[..pos.len().saturating_sub(1)] } else { &pos[..] };
        let scalar_pos = if rank == 0 { Some(Ok(0)) } else if innermost { pos.last().copied() } else { None };
        let (value, dest) = (operands[0][0], operands[1][0]);
        let mut agg = value;
        if innermost {
            if nested {
                let Some(consts) = outer.iter().map(|r| r.ok()).collect::<Option<Vec<i64>>>() else { return false };
                agg = cr.extract(dest, &consts);
            } else {
                agg = dest;
            }
            let idx = Self::position_value(cr, scalar_pos.expect("innermost"));
            let ty = cr.rw.body[agg].ty.clone();
            agg = cr.build(OpData::build("llvm.insertelement").operands(&[agg, value, idx]), ty);
        }
        let mut result = agg;
        if nested {
            let Some(consts) = outer.iter().map(|r| r.ok()).collect::<Option<Vec<i64>>>() else { return false };
            result = cr.insert_value(dest, agg, &consts);
        }
        cr.replace(op, vec![vec![result]]);
        true
    }

    #[lowering("vector.fma")]
    fn fma<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorOptions<'_>) -> bool {
        let rt = Self::result_type(cr, op);
        if Self::vector(&rt).is_none_or(|s| Self::vrank(s) > 1) {
            return false;
        }
        let ty = cr.rw.body[operands[0][0]].ty.clone();
        let d = OpData::build("llvm.intr.fmuladd").operands(&[operands[0][0], operands[1][0], operands[2][0]]);
        cr.replace_new(op, d, &[ty]);
        true
    }

    #[lowering("vector.scalable.insert")]
    fn scalable_insert<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorOptions<'_>) -> bool {
        let Some(pos) = cr.rw.body[op].get("pos").and_then(M::int) else { return false };
        let ty = cr.rw.body[operands[1][0]].ty.clone();
        cr.replace_new(op, OpData::build("llvm.intr.vector.insert").operands(&[operands[1][0], operands[0][0]]).with("pos", Attribute::i64(pos)), &[ty]);
        true
    }

    #[lowering("vector.scalable.extract")]
    fn scalable_extract<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorOptions<'_>) -> bool {
        let Some(pos) = cr.rw.body[op].get("pos").and_then(M::int) else { return false };
        let rt = Self::result_type(cr, op);
        let Some(lt) = Self::convert(cr, &rt) else { return false };
        cr.replace_new(op, OpData::build("llvm.intr.vector.extract").operands(&[operands[0][0]]).with("pos", Attribute::i64(pos)), &[lt]);
        true
    }

    /// `computeContiguousStrides`.
    fn contiguous_strides(opts: LlvmOptions, s: &Shaped<'_>) -> Option<Vec<i64>> {
        let (strides, _) = opts.strides_and_offset(s)?;
        if strides.last().is_some_and(|l| *l != 1) {
            return None;
        }
        if M::identity_layout(s) {
            return Some(strides);
        }
        let sizes = M::dims(s);
        for i in 0..strides.len().saturating_sub(1) {
            if sizes[i + 1] == DYNAMIC || strides[i] == DYNAMIC || strides[i + 1] == DYNAMIC || strides[i] != strides[i + 1] * sizes[i + 1] {
                return None;
            }
        }
        Some(strides)
    }

    #[lowering("vector.type_cast")]
    fn type_cast<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorOptions<'_>) -> bool {
        let (Some(src), Some(dst)) = (M::operand_memref(cr, op, 0), M::result_memref(cr, op)) else { return false };
        if M::dims(&src).contains(&DYNAMIC) || M::dims(&dst).contains(&DYNAMIC) || src.shape.is_none() || dst.shape.is_none() {
            return false;
        }
        let desc = operands[0][0];
        if !matches!(LlvmType::try_from(&cr.rw.body[desc].ty), Ok(LlvmType::Struct { .. })) {
            return false;
        }
        let Some(ty) = crate::LlvmConverter::convert_memref(o.llvm, &dst) else { return false };
        if Self::contiguous_strides(o.llvm, &src).is_none() {
            return false;
        }
        let Some(ts) = Self::contiguous_strides(o.llvm, &dst) else { return false };
        if ts.contains(&DYNAMIC) {
            return false;
        }
        let i64t = Type::int(64);
        let mut d = cr.poison(ty);
        let a = cr.extract(desc, &[0]);
        d = cr.insert_value(d, a, &[0]);
        let p = cr.extract(desc, &[1]);
        d = cr.insert_value(d, p, &[1]);
        let z = Self::i_const(cr, 0, Type::Index, i64t.clone());
        d = cr.insert_value(d, z, &[2]);
        for (i, size) in M::dims(&dst).into_iter().enumerate() {
            let s = Self::i_const(cr, size, Type::Index, i64t.clone());
            d = cr.insert_value(d, s, &[3, i as i64]);
            let st = Self::i_const(cr, ts[i], Type::Index, i64t.clone());
            d = cr.insert_value(d, st, &[4, i as i64]);
        }
        cr.replace(op, vec![vec![d]]);
        true
    }

    #[lowering("vector.create_mask", untyped)]
    fn create_mask<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorOptions<'_>) -> bool {
        let rt = Self::result_type(cr, op);
        let Some(s) = Self::vector(&rt).cloned() else { return false };
        if Self::vrank(&s) != 1 || !Self::scalable(&s) {
            return false;
        }
        let it = Type::int(if o.force_32bit_indices { 32 } else { 64 });
        let d = s.shape.as_ref().expect("rank 1")[0].clone();
        let vt = Type::Shaped(Shaped { kind: ShapedKind::Vector, shape: Some(vec![d]), elem: it.clone().into(), extras: Vec::new() });
        let indices = cr.build(OpData::build("llvm.intr.stepvector"), vt.clone());
        let bound = operands[0][0];
        let bt = cr.rw.body[bound].ty.clone();
        let bound = match (crate::bit_width(&bt), &bt) {
            (_, Type::Index) => cr.build(OpData::build("arith.index_cast").operands(&[bound]), it.clone()),
            (Some(w), _) if w > crate::bit_width(&it).unwrap_or(64) => cr.build(OpData::build("arith.trunci").operands(&[bound]), it.clone()),
            (Some(w), _) if w < crate::bit_width(&it).unwrap_or(64) => cr.build(OpData::build("arith.extsi").operands(&[bound]), it.clone()),
            _ => bound,
        };
        let bounds = cr.build(OpData::build("vector.broadcast").operands(&[bound]), vt);
        let cmp = OpData::build("arith.cmpi").operands(&[indices, bounds]).with("predicate", Attribute::i64(2));
        let mt = Type::Shaped(Shaped { elem: Type::int(1).into(), ..s.clone() });
        let c = cr.build(cmp, mt);
        cr.replace(op, vec![vec![c]]);
        true
    }

    fn call_void<'a>(cr: &mut Cr<'_, 'a, '_>, module: OpId, name: &str, args: &[ValueId], params: Vec<Type<'_>>) -> Option<()> {
        let params: Vec<Type> = params.into_iter().map(|t| Type::owned(&t)).collect();
        cr.llvm_func(module, name, params, LlvmType::void(), false)?;
        cr.llvm_call(name, args, &[]);
        Some(())
    }

    #[lowering("vector.print")]
    fn print<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorOptions<'_>) -> bool {
        let Some(module) = cr.module_of(op) else { return false };
        if let Some(src) = operands.first().map(|v| v[0]) {
            let pt = Self::operand_type(cr, op, 0);
            if Self::vector(&pt).is_some() {
                return false;
            }
            if Self::print_scalar(cr, module, &pt, src).is_none() {
                return false;
            }
        }
        let punct = match cr.rw.body[op].get("punctuation") {
            Some(Attribute::Extended { ext, .. }) => String::from(ext.body.as_deref().unwrap_or("").trim_matches(|c| c == '<' || c == '>')),
            _ => String::from("newline"),
        };
        if let Some(Attribute::Str { lit, .. }) = cr.rw.body[op].get("stringLiteral").cloned() {
            let bytes = super::unescape(&lit);
            if cr.print_str_call(module, "vector_print_str", &bytes, "printString", o.counter).is_none() {
                return false;
            }
        } else if punct != "no_punctuation" {
            let name = match &*punct {
                "close" => "printClose",
                "open" => "printOpen",
                "comma" => "printComma",
                _ => "printNewline",
            };
            if Self::call_void(cr, module, name, &[], Vec::new()).is_none() {
                return false;
            }
        }
        cr.erase(op);
        true
    }

    /// `emitScalarPrint`.
    fn print_scalar<'a>(cr: &mut Cr<'_, 'a, '_>, module: OpId, pt: &Type<'_>, value: ValueId) -> Option<()> {
        Self::convert(cr, &Type::owned(pt))?;
        let i64t = Type::int(64);
        let (name, conv): (&str, Option<(&str, Type)>) = match pt {
            Type::Float(FloatKind::F32) => ("printF32", None),
            Type::Float(FloatKind::F64) => ("printF64", None),
            Type::Float(FloatKind::F16) => ("printF16", Some(("llvm.bitcast", Type::int(16)))),
            Type::Float(FloatKind::BF16) => ("printBF16", Some(("llvm.bitcast", Type::int(16)))),
            Type::Index => ("printU64", None),
            Type::Integer { width, signedness } => {
                if *width > 64 {
                    return None;
                }
                if *signedness == mlirformat::Signedness::Unsigned {
                    ("printU64", (*width < 64).then(|| ("arith.extui", i64t.clone())))
                } else if *width == 1 {
                    ("printI64", Some(("arith.extui", i64t.clone())))
                } else {
                    ("printI64", (*width < 64).then(|| ("arith.extsi", i64t.clone())))
                }
            }
            _ => return None,
        };
        let param = match name {
            "printF32" => Type::Float(FloatKind::F32),
            "printF64" => Type::Float(FloatKind::F64),
            "printF16" | "printBF16" => Type::int(16),
            _ => i64t,
        };
        cr.llvm_func(module, name, vec![param], LlvmType::void(), false)?;
        let v = match conv {
            Some((op, t)) => cr.build(OpData::build(op).operands(&[value]), t),
            None => value,
        };
        cr.llvm_call(name, &[v], &[]);
        Some(())
    }

    /// `VectorBroadcastScalarToLowRankLowering` and `...ToNdLowering`.
    #[lowering("vector.broadcast")]
    fn broadcast<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorOptions<'_>) -> bool {
        let st = Self::operand_type(cr, op, 0);
        if Self::vector(&st).is_some() {
            return false;
        }
        let rt = Self::result_type(cr, op);
        let Some(rs) = Self::vector(&rt).cloned() else { return false };
        let Some(lt) = Self::convert(cr, &rt) else { return false };
        let src = operands[0][0];
        let zero_i32 = |cr: &mut Cr<'_, 'a, '_>| Self::i_const(cr, 0, Type::int(32), Type::int(32));
        let shape = rs.shape.clone().unwrap_or_default();
        if shape.len() <= 1 {
            let poison = cr.poison(lt.clone());
            let zero = zero_i32(cr);
            let v = cr.build(OpData::build("llvm.insertelement").operands(&[poison, src, zero]), lt.clone());
            if shape.is_empty() {
                cr.replace(op, vec![vec![v]]);
                return true;
            }
            let width = Self::dim(&shape[0]);
            // `createOrFold`: a one-lane shuffle of lane 0 is its first operand.
            let r = if width == 1 { v } else { cr.build(OpData::build("llvm.shufflevector").operands(&[v, poison]).with("mask", Self::i32_array(&vec![0; width as usize])), lt.clone()) };
            cr.replace(op, vec![vec![r]]);
            return true;
        }
        let mut sizes = Vec::new();
        let mut t = lt.clone();
        while let Ok(LlvmType::Array(n, e)) = LlvmType::try_from(&t) {
            sizes.push(n);
            t = *e;
        }
        let one_d = t;
        let mut desc = cr.poison(lt);
        let vdesc = cr.poison(one_d.clone());
        let zero = zero_i32(cr);
        let mut v = cr.build(OpData::build("llvm.insertelement").operands(&[vdesc, src, zero]), one_d.clone());
        let width = Self::dim(shape.last().expect("rank > 1"));
        v = cr.build(OpData::build("llvm.shufflevector").operands(&[v, v]).with("mask", Self::i32_array(&vec![0; width as usize])), one_d);
        let mut pos = vec![0i64; sizes.len()];
        'outer: loop {
            desc = cr.insert_value(desc, v, &pos);
            for d in (0..sizes.len()).rev() {
                pos[d] += 1;
                if (pos[d] as u64) < sizes[d] {
                    continue 'outer;
                }
                pos[d] = 0;
            }
            break;
        }
        cr.replace(op, vec![vec![desc]]);
        true
    }

    #[lowering("vector.interleave")]
    fn interleave<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorOptions<'_>) -> bool {
        let rt = Self::result_type(cr, op);
        let Some(rs) = Self::vector(&rt).cloned() else { return false };
        if Self::vrank(&rs) != 1 {
            return false;
        }
        let Some(lt) = Self::convert(cr, &rt) else { return false };
        let (l, r) = (operands[0][0], operands[1][0]);
        if Self::scalable(&rs) {
            cr.replace_new(op, OpData::build("llvm.intr.vector.interleave2").operands(&[l, r]), &[lt]);
            return true;
        }
        let n = Self::dim(&rs.shape.as_ref().expect("rank 1")[0]);
        let mask: Vec<i64> = (0..n / 2).flat_map(|i| [i, n / 2 + i]).collect();
        cr.replace_new(op, OpData::build("llvm.shufflevector").operands(&[l, r]).with("mask", Self::i32_array(&mask)), &[lt]);
        true
    }

    #[lowering("vector.deinterleave")]
    fn deinterleave<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: VectorOptions<'_>) -> bool {
        let rt = Self::result_type(cr, op);
        let st = Self::operand_type(cr, op, 0);
        let Some(rs) = Self::vector(&rt).cloned() else { return false };
        if Self::vrank(&rs) != 1 {
            return false;
        }
        let Some(lt) = Self::convert(cr, &rt) else { return false };
        let src = operands[0][0];
        if Self::scalable(&rs) {
            let packed = LlvmType::literal(vec![lt.clone(), lt]);
            let i = cr.build(OpData::build("llvm.intr.vector.deinterleave2").operands(&[src]), packed);
            let even = cr.extract(i, &[0]);
            let odd = cr.extract(i, &[1]);
            cr.replace(op, vec![vec![even], vec![odd]]);
            return true;
        }
        let n = Self::vector(&st).and_then(|s| s.shape.as_ref()?.first().map(Self::dim)).unwrap_or(0);
        let even: Vec<i64> = (0..n).filter(|i| i % 2 == 0).collect();
        let odd: Vec<i64> = (0..n).filter(|i| i % 2 == 1).collect();
        let poison = cr.poison(st);
        let e = cr.build(OpData::build("llvm.shufflevector").operands(&[src, poison]).with("mask", Self::i32_array(&even)), lt.clone());
        let o = cr.build(OpData::build("llvm.shufflevector").operands(&[src, poison]).with("mask", Self::i32_array(&odd)), lt);
        cr.replace(op, vec![vec![e], vec![o]]);
        true
    }

    #[lowering("vector.from_elements")]
    fn from_elements<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorOptions<'_>) -> bool {
        let rt = Self::result_type(cr, op);
        if Self::vector(&rt).is_none_or(|s| Self::vrank(s) > 1) {
            return false;
        }
        let Some(lt) = Self::convert(cr, &rt) else { return false };
        let mut r = cr.poison(lt.clone());
        for (i, v) in operands.iter().flatten().enumerate() {
            let c = Self::i_const(cr, i as i64, o.llvm.index(), o.llvm.index());
            r = cr.build(OpData::build("llvm.insertelement").operands(&[r, *v, c]), lt.clone());
        }
        cr.replace(op, vec![vec![r]]);
        true
    }

    #[lowering("vector.to_elements")]
    fn to_elements<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: VectorOptions<'_>) -> bool {
        let src = operands[0][0];
        let mut results = Vec::new();
        for (i, r) in cr.rw.body[op].results.clone().into_iter().enumerate() {
            if cr.rw.body[r].uses.is_empty() {
                results.push(Vec::new());
                continue;
            }
            let c = Self::i_const(cr, i as i64, o.llvm.index(), o.llvm.index());
            let rt = cr.rw.body[r].ty.clone();
            let Some(lt) = Self::convert(cr, &rt) else { return false };
            results.push(vec![cr.build(OpData::build("llvm.extractelement").operands(&[src, c]), lt)]);
        }
        cr.replace(op, results);
        true
    }

    #[lowering("vector.step")]
    fn step<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], _: VectorOptions<'_>) -> bool {
        let rt = Self::result_type(cr, op);
        if Self::vector(&rt).is_none_or(|s| !Self::scalable(s)) {
            return false;
        }
        let Some(lt) = Self::convert(cr, &rt) else { return false };
        cr.replace_new(op, OpData::build("llvm.intr.stepvector"), &[lt]);
        true
    }

    #[lowering("vector.vscale")]
    fn vscale<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], o: VectorOptions<'_>) -> bool {
        cr.replace_new(op, OpData::build("llvm.intr.vscale"), &[o.llvm.index()]);
        true
    }

}
