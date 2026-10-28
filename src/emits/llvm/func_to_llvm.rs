//! `func` ⇒ `llvm`, as `FuncToLLVM.cpp`.

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use crate::patterns;
use mlirformat::{Attribute, Dim, NamedAttr, Shaped, ShapedKind, Type};

use crate::{ConversionRewriter, LlvmConverter, LlvmOptions, MemrefLayout, OpData, OpId, SignatureConversion, ValueId, Visibility};
use mlirformat::llvm_types::LlvmType;

/// The func ⇒ llvm patterns.
pub struct FuncToLlvm;

/// What a function's arguments and results turn into.
struct Signature<'a> {
    llvm: Type<'a>,
    conversion: SignatureConversion<'a>,
}

#[patterns(converter, options = LlvmOptions)]
impl FuncToLlvm {
    fn memref<'t, 'a>(t: &'t Type<'a>) -> Option<&'t Shaped<'a>> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef => Some(s),
            _ => None,
        }
    }

    /// `structFuncArgTypeConverter` / `barePtrFuncArgTypeConverter`.
    fn arg_types<'a>(cr: &ConversionRewriter<'_, 'a, '_>, opts: LlvmOptions, t: &Type<'a>, bare: bool) -> Option<Vec<Type<'a>>> {
        let tc = cr.type_converter()?;
        if let Some(s) = Self::memref(t) {
            if bare {
                return Self::bare_ptr(cr, opts, s).map(|p| vec![p]);
            }
            if s.shape.is_none() {
                tc.convert(&s.elem)?;
                return Some(vec![opts.index(), LlvmType::ptr()]);
            }
            let ok = tc.convert(&s.elem).is_some();
            return opts.descriptor_fields(s, ok, true);
        }
        tc.convert_types(t)
    }

    /// `convertMemRefToBarePtr`: static shape, static strides and offset.
    fn bare_ptr<'a>(cr: &ConversionRewriter<'_, 'a, '_>, opts: LlvmOptions, s: &Shaped<'a>) -> Option<Type<'a>> {
        cr.type_converter()?.convert(&s.elem)?;
        let shape = s.shape.as_ref()?;
        if shape.iter().any(|d| !matches!(d, mlirformat::Dim::Static(_))) {
            return None;
        }
        let (strides, offset) = s.strides_and_offset()?;
        if strides.contains(&Dim::DYNAMIC) || offset == Dim::DYNAMIC {
            return None;
        }
        Some(LlvmType::Ptr(opts.address_space(s)?).into())
    }

    /// `packFunctionResults` with the calling convention's memref rule; also each result's
    /// converted types.
    fn pack_results<'a>(cr: &ConversionRewriter<'_, 'a, '_>, opts: LlvmOptions, types: &[Type<'a>], bare: bool) -> Option<(Type<'a>, Vec<Vec<Type<'a>>>)> {
        let tc = cr.type_converter()?;
        let mut groups = Vec::new();
        for t in types {
            let g = match Self::memref(t) {
                Some(s) if bare => vec![Self::bare_ptr(cr, opts, s)?],
                _ => tc.convert_types(t)?,
            };
            groups.push(g);
        }
        let flat: Vec<Type<'a>> = groups.iter().flatten().cloned().collect();
        let packed = match flat.len() {
            0 => return None,
            1 => flat[0].clone(),
            _ => LlvmType::literal(flat),
        };
        Some((packed, groups))
    }

    /// `convertFunctionSignature`.
    fn signature<'a>(cr: &ConversionRewriter<'_, 'a, '_>, opts: LlvmOptions, inputs: &[Type<'a>], results: &[Type<'a>], vararg: bool, bare: bool) -> Option<Signature<'a>> {
        let mut conversion = SignatureConversion::new(inputs.len());
        for (i, t) in inputs.iter().enumerate() {
            let conv = Self::arg_types(cr, opts, t, bare)?;
            conversion.add_inputs(i, conv);
        }
        let ret = if results.is_empty() { LlvmType::void() } else { Self::pack_results(cr, opts, results, bare)?.0 };
        let llvm = LlvmType::Func { ret: ret.into(), params: conversion.converted_types().to_vec(), vararg }.into();
        Some(Signature { llvm, conversion })
    }

    fn function_type<'a>(cr: &ConversionRewriter<'_, 'a, '_>, op: OpId) -> Option<mlirformat::FunctionType<'a>> {
        match cr.rw.body[op].get("function_type")? {
            Attribute::Type(Type::Function(f)) => Some(f.clone()),
            _ => None,
        }
    }

    /// `filterFuncAttributes`: the discardable attributes but linkage, varargs and readnone.
    fn func_attrs<'a>(cr: &ConversionRewriter<'_, 'a, '_>, op: OpId) -> Vec<NamedAttr<'a>> {
        cr.rw.body.discardable(op).into_iter().filter(|a| !matches!(&*a.name, "llvm.linkage" | "func.varargs" | "llvm.readnone")).collect()
    }

    /// `LLVMFuncOp::build`: name, type, linkage, cconv and the extra attributes.
    fn llvm_func_data<'a>(name: &str, ty: Type<'a>, linkage: &str, attrs: Vec<NamedAttr<'a>>, loc: Option<mlirformat::Str<'a>>) -> OpData<'a> {
        let mut d = OpData::build("llvm.func").with("sym_name", Attribute::str(name)).with("function_type", Attribute::Type(ty)).with("linkage", Attribute::dialect("llvm.linkage", &format!("<{linkage}>")));
        for a in attrs {
            d.set(&a.name, a.value.unwrap_or(Attribute::Unit));
        }
        d.loc = loc;
        d
    }

    #[lowering("func.func")]
    fn func(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], opts: LlvmOptions) -> bool {
        let Some(fty) = Self::function_type(cr, op) else { return false };
        let b = &*cr.rw.body;
        let vararg = matches!(b[op].get("func.varargs"), Some(Attribute::Bool(true)));
        let bare = opts.bare_ptr || b[op].get("llvm.bareptr").is_some();
        let Some(sig) = Self::signature(cr, opts, &fty.inputs, &fty.results, vararg, bare) else { return false };
        let b = &*cr.rw.body;
        let c_iface = !bare && b[op].get("llvm.emit_c_interface").is_some();
        if c_iface && vararg {
            return false;
        }
        let linkage = match b[op].get("llvm.linkage") {
            Some(Attribute::Extended { ext, .. }) => String::from(ext.body.as_deref().unwrap_or("<external>").trim_matches(|c| c == '<' || c == '>')),
            Some(_) => return false,
            None => String::from("external"),
        };
        let readnone = b[op].get("llvm.readnone").is_some();
        let name = String::from(b.sym_name(op).unwrap_or(""));
        let visibility = b.visibility(op);
        let attrs = Self::func_attrs(cr, op);
        let loc = cr.rw.body[op].loc.clone();
        let arg_attrs = cr.rw.body[op].get("arg_attrs").cloned();
        let res_attrs = cr.rw.body[op].get("res_attrs").cloned();
        let mut data = Self::llvm_func_data(&name, sig.llvm.clone(), &linkage, attrs, loc.clone());
        if visibility != Visibility::Public {
            data.set("sym_visibility", Attribute::str(if visibility == Visibility::Private { "private" } else { "nested" }));
        }
        if readnone {
            data.set("memory_effects", Attribute::dialect("llvm.memory_effects", "<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>"));
        }
        if let (Some(r), 1) = (res_attrs, fty.results.len()) {
            data.set("res_attrs", r);
        }
        if let Some(Attribute::Array(dicts)) = arg_attrs {
            let n = sig.conversion.converted_types().len();
            let mut new: Vec<Attribute> = vec![Attribute::Dict(Vec::new()); n];
            for (i, d) in dicts.into_iter().enumerate() {
                let Some(&crate::InputMap::New { at, count }) = sig.conversion.mapping(i) else { continue };
                if count == 1 {
                    new[at] = Self::convert_arg_attrs(cr, d);
                }
            }
            if !new.is_empty() {
                data.set("arg_attrs", Attribute::Array(new));
            }
        }
        cr.rw.set_before(op);
        let new = cr.rw.create_with(data, &[], |b, f| {
            b.add_region(f);
        });
        let (from, into) = (cr.rw.body[op].regions[0], cr.rw.body[new].regions[0]);
        cr.inline_region(from, into, None);
        if let Some(&entry) = cr.rw.body[into].blocks.first() {
            let current = cr.current;
            cr.apply_signature_conversion(entry, &sig.conversion, current);
        }
        if c_iface {
            cr.rw.set_after(new);
            if cr.rw.body[into].blocks.is_empty() {
                Self::wrap_external(cr, opts, &name, &fty, op, new, loc);
            } else {
                Self::wrap_for_callers(cr, opts, &name, &fty, op, new, loc);
            }
        }
        cr.erase(op);
        true
    }

    /// `llvm.byval` / `llvm.byref` / `llvm.sret` / `llvm.inalloca` take converted types.
    fn convert_arg_attrs<'a>(cr: &ConversionRewriter<'_, 'a, '_>, d: Attribute<'a>) -> Attribute<'a> {
        let Attribute::Dict(entries) = d else { return d };
        let tc = cr.type_converter();
        Attribute::Dict(
            entries
                .into_iter()
                .map(|n| match (&*n.name, &n.value) {
                    ("llvm.byval" | "llvm.byref" | "llvm.sret" | "llvm.inalloca", Some(Attribute::Type(t))) => {
                        let c = tc.and_then(|tc| tc.convert(t)).unwrap_or_else(|| t.clone());
                        NamedAttr { name: n.name, value: Some(Attribute::Type(c)) }
                    }
                    _ => n,
                })
                .collect(),
        )
    }

    /// `convertFunctionTypeCWrapper`: memrefs by pointer; a struct result returned through a
    /// leading pointer argument.
    fn c_wrapper_type<'a>(cr: &ConversionRewriter<'_, 'a, '_>, opts: LlvmOptions, fty: &mlirformat::FunctionType<'a>) -> Option<(Type<'a>, Option<Type<'a>>)> {
        let tc = cr.type_converter()?;
        let mut ret = if fty.results.is_empty() { LlvmType::void() } else { Self::pack_results(cr, opts, &fty.results, false)?.0 };
        let mut params = Vec::new();
        let structured = matches!(LlvmType::try_from(&ret), Ok(LlvmType::Struct { .. })).then(|| ret.clone());
        if structured.is_some() {
            params.push(LlvmType::ptr());
            ret = LlvmType::void();
        }
        for t in &fty.inputs {
            let c = tc.convert(t).filter(LlvmType::compatible)?;
            params.push(if Self::memref(t).is_some() { LlvmType::ptr() } else { c });
        }
        Some((LlvmType::Func { ret: ret.into(), params, vararg: false }.into(), structured))
    }

    /// The `_mlir_ciface_` wrapper of `orig`, with `filterFuncAttributes` and
    /// `propagateArgResAttrs`.
    fn wrapper<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, orig: OpId, name: &str, ty: Type<'a>, structured: bool, loc: Option<mlirformat::Str<'a>>) -> OpId {
        let attrs = Self::func_attrs(cr, orig);
        let mut data = Self::llvm_func_data(&format!("_mlir_ciface_{name}"), ty, "external", attrs, loc);
        let o = &cr.rw.body[orig];
        let (args, res) = (o.get("arg_attrs").cloned(), o.get("res_attrs").cloned());
        match (structured, args) {
            (false, args) => {
                if let Some(r) = res {
                    data.set("res_attrs", r);
                }
                if let Some(a) = args {
                    data.set("arg_attrs", a);
                }
            }
            (true, Some(Attribute::Array(a))) => {
                data.set("arg_attrs", Attribute::Array(core::iter::once(Attribute::Dict(Vec::new())).chain(a).collect()));
            }
            (true, _) => {}
        }
        match cr.rw.body.visibility(orig) {
            Visibility::Public => {}
            v => data.set("sym_visibility", Attribute::str(if v == Visibility::Private { "private" } else { "nested" })),
        }
        cr.rw.create_with(data, &[], |b, f| {
            b.add_region(f);
        })
    }

    /// The entry block of `f`, with `f`'s parameter types as arguments.
    fn entry_block<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, f: OpId, ty: &Type<'a>) -> crate::BlockId {
        let Ok(LlvmType::Func { params, .. }) = LlvmType::try_from(ty) else { unreachable!("llvm.func type") };
        let r = cr.rw.body[f].regions[0];
        let loc = cr.rw.body[f].loc.clone();
        let args: Vec<_> = params.into_iter().map(|t| (t, loc.clone())).collect();
        cr.rw.body.add_block(r, &args)
    }

    fn load<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, ty: Type<'a>, ptr: ValueId) -> ValueId {
        cr.build(OpData::build("llvm.load").operands(&[ptr]).with("ordering", Attribute::i64(0)), ty)
    }

    fn store<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, v: ValueId, ptr: ValueId) {
        cr.rw.create(OpData::build("llvm.store").operands(&[v, ptr]).with("ordering", Attribute::i64(0)), &[]);
    }

    fn alloca<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, elem: Type<'a>, n: ValueId) -> ValueId {
        cr.build(OpData::build("llvm.alloca").operands(&[n]).with("elem_type", Attribute::Type(elem)), LlvmType::ptr())
    }

    /// `wrapForExternalCallers`: `_mlir_ciface_f` loads the memref descriptors its pointer
    /// arguments point to and calls `f`.
    fn wrap_for_callers<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, opts: LlvmOptions, name: &str, fty: &mlirformat::FunctionType<'a>, orig: OpId, f: OpId, loc: Option<mlirformat::Str<'a>>) {
        let Some((wty, structured)) = Self::c_wrapper_type(cr, opts, fty) else { return };
        let w = Self::wrapper(cr, orig, name, wty.clone(), structured.is_some(), loc);
        let entry = Self::entry_block(cr, w, &wty);
        let saved = cr.rw.ip;
        cr.rw.set_end(entry);
        let offset = usize::from(structured.is_some());
        let mut args = Vec::new();
        for (i, t) in fty.inputs.iter().enumerate() {
            let arg = cr.rw.body[entry].args[i + offset];
            if let Some(s) = Self::memref(t) {
                let Some(desc) = LlvmConverter::convert_memref(opts, s) else { return };
                let loaded = Self::load(cr, desc, arg);
                if s.shape.is_some() {
                    let rank = s.shape.as_ref().map_or(0, Vec::len);
                    args.extend(cr.unpack_desc(loaded, rank));
                } else {
                    args.push(cr.extract(loaded, &[0]));
                    args.push(cr.extract(loaded, &[1]));
                }
                continue;
            }
            args.push(arg);
        }
        let results: Vec<Type<'a>> = match LlvmType::try_from(&cr.rw.body[f].get("function_type").cloned().map_or(LlvmType::void(), |a| if let Attribute::Type(t) = a { t } else { LlvmType::void() })) {
            Ok(LlvmType::Func { ret, .. }) if !matches!(*ret, Type::Extended(ref e) if e.name == "llvm.void") => vec![*ret],
            _ => Vec::new(),
        };
        let call = cr.llvm_call(name, &args, &results);
        let res = cr.rw.body[call].results.clone();
        if structured.is_some() {
            let out = cr.rw.body[entry].args[0];
            Self::store(cr, res[0], out);
            cr.rw.create(OpData::build("llvm.return"), &[]);
        } else {
            cr.rw.create(OpData::build("llvm.return").operands(&res), &[]);
        }
        cr.rw.ip = saved;
    }

    /// `wrapExternalFunction`: `f` becomes private and forwards to `_mlir_ciface_f`, passing
    /// memref descriptors through `alloca`'d memory.
    fn wrap_external<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, opts: LlvmOptions, name: &str, fty: &mlirformat::FunctionType<'a>, orig: OpId, f: OpId, loc: Option<mlirformat::Str<'a>>) {
        let Some((wty, structured)) = Self::c_wrapper_type(cr, opts, fty) else { return };
        Self::wrapper(cr, orig, name, wty.clone(), structured.is_some(), loc);
        cr.rw.body[f].set("linkage", Attribute::dialect("llvm.linkage", "<private>"));
        let fty_llvm = match cr.rw.body[f].get("function_type") {
            Some(Attribute::Type(t)) => t.clone(),
            _ => return,
        };
        let entry = Self::entry_block(cr, f, &fty_llvm);
        let saved = cr.rw.ip;
        cr.rw.set_start(entry);
        let idx = opts.index();
        let mut args = Vec::new();
        let mut rest: Vec<ValueId> = cr.rw.body[entry].args.clone();
        if let Some(st) = &structured {
            let one = cr.index_const(&idx, 1);
            let r = Self::alloca(cr, st.clone(), one);
            args.push(r);
        }
        for t in &fty.inputs {
            if let Some(s) = Self::memref(t) {
                let n = s.shape.as_ref().map_or(2, |sh| 3 + 2 * sh.len());
                let fields: Vec<ValueId> = rest.drain(..n).collect();
                let Some(desc) = LlvmConverter::convert_memref(opts, s) else { return };
                let packed = if s.shape.is_some() { cr.pack_desc(desc.clone(), n.saturating_sub(3) / 2, &fields) } else { cr.rw.pack_unranked(desc.clone(), &fields) };
                let one = cr.index_const(&idx, 1);
                let a = Self::alloca(cr, desc, one);
                Self::store(cr, packed, a);
                args.push(a);
            } else {
                args.push(rest.remove(0));
            }
        }
        let results: Vec<Type<'a>> = match LlvmType::try_from(&wty) {
            Ok(LlvmType::Func { ret, .. }) if !matches!(*ret, Type::Extended(ref e) if e.name == "llvm.void") => vec![*ret],
            _ => Vec::new(),
        };
        let call = cr.llvm_call(&format!("_mlir_ciface_{name}"), &args, &results);
        if let Some(st) = structured {
            let r = Self::load(cr, st, args[0]);
            cr.rw.create(OpData::build("llvm.return").operands(&[r]), &[]);
        } else {
            let res = cr.rw.body[call].results.clone();
            cr.rw.create(OpData::build("llvm.return").operands(&res), &[]);
        }
        cr.rw.ip = saved;
    }

    /// `copyUnrankedDescriptor`: the ranked descriptor behind `desc` copied to `malloc`'d
    /// (`to_dynamic`) or `alloca`'d memory, the source then freed.
    fn copy_unranked<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, opts: LlvmOptions, s: &Shaped<'a>, desc: ValueId, to_dynamic: bool, at: OpId) -> Option<ValueId> {
        opts.address_space(s)?;
        let idx = opts.index();
        let module = cr.module_of(at)?;
        match to_dynamic {
            true => cr.llvm_func(module, "malloc", vec![idx.clone()], LlvmType::ptr(), false)?,
            false => cr.llvm_func(module, "free", vec![LlvmType::ptr()], LlvmType::void(), false)?,
        };
        // `UnrankedMemRefDescriptor::computeSize`: 2 * sizeof(ptr) + (1 + 2 * rank) * sizeof(index).
        let one = cr.index_const(&idx, 1);
        let two = cr.index_const(&idx, 2);
        let index_size = cr.index_const(&idx, i64::from(opts.index_bitwidth.div_ceil(8)));
        let ptr_size = cr.index_const(&idx, 8);
        let arith = |cr: &mut ConversionRewriter<'_, 'a, '_>, name: &str, a: ValueId, b: ValueId| cr.build(OpData::build(name).operands(&[a, b]), idx.clone());
        let double_ptr = arith(cr, "llvm.mul", two, ptr_size);
        let rank = cr.extract(desc, &[0]);
        let double_rank = arith(cr, "llvm.mul", two, rank);
        let inc = arith(cr, "llvm.add", double_rank, one);
        let rank_size = arith(cr, "llvm.mul", inc, index_size);
        let size = arith(cr, "llvm.add", double_ptr, rank_size);
        let memory = if to_dynamic {
            let c = cr.llvm_call("malloc", &[size], &[LlvmType::ptr()]);
            cr.rw.body[c].results[0]
        } else {
            cr.build(OpData::build("llvm.alloca").operands(&[size]).with("elem_type", Attribute::Type(Type::int(8))), LlvmType::ptr())
        };
        let source = cr.extract(desc, &[1]);
        cr.rw.create(OpData::build("llvm.intr.memcpy").operands(&[memory, source, size]).with("isVolatile", Attribute::Bool(false)), &[]);
        if !to_dynamic {
            cr.llvm_call("free", &[source], &[]);
        }
        let ty = LlvmConverter::convert_memref(opts, s)?;
        let p = cr.poison(ty);
        let rank = cr.extract(desc, &[0]);
        let p = cr.insert_value(p, rank, &[0]);
        Some(cr.insert_value(p, memory, &[1]))
    }

    #[lowering("func.constant", plain)]
    fn constant(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(tc) = cr.type_converter() else { return false };
        let Some(ty) = tc.convert(&cr.rw.body[cr.rw.body[op].results[0]].ty.clone()).filter(LlvmType::compatible) else { return false };
        let Some(value) = cr.rw.body[op].get("value").cloned() else { return false };
        let mut data = OpData::build("llvm.mlir.addressof").with("global_name", value);
        for a in cr.all_attrs(op).into_iter().filter(|a| a.name != "value") {
            data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
        }
        cr.replace_new(op, data, &[ty]);
        true
    }

    /// `promoteOperands`: memref descriptors unpacked into their fields (or the aligned
    /// pointer, bare); everything else as converted.
    fn promote(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], bare: bool) -> Option<Vec<ValueId>> {
        let originals = cr.rw.body[op].operands.clone();
        let mut out = Vec::new();
        for (o, adapted) in originals.into_iter().zip(operands) {
            let ty = cr.rw.body[o].ty.clone();
            match Self::memref(&ty) {
                Some(s) if bare => {
                    if s.shape.is_none() {
                        return None;
                    }
                    out.push(cr.extract(adapted[0], &[1]));
                }
                Some(s) if s.shape.is_none() => {
                    out.push(cr.extract(adapted[0], &[0]));
                    out.push(cr.extract(adapted[0], &[1]));
                }
                Some(s) => {
                    let rank = s.shape.as_ref().map_or(0, Vec::len);
                    out.extend(cr.unpack_desc(adapted[0], rank));
                }
                None => out.extend(adapted.iter().copied()),
            }
        }
        Some(out)
    }

    /// `CallOpInterfaceLowering`.
    fn call_impl(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], opts: LlvmOptions, bare: bool, indirect: bool) -> bool {
        let result_types = cr.rw.body.types(&cr.rw.body[op].results.clone());
        let packed = if result_types.is_empty() {
            None
        } else {
            match Self::pack_results(cr, opts, &result_types, bare) {
                Some(p) => Some(p),
                None => return false,
            }
        };
        let Some(promoted) = Self::promote(cr, op, operands, bare) else { return false };
        let mut data = OpData::build("llvm.call").operands(&promoted).segments(&[promoted.len(), 0]);
        for a in cr.all_attrs(op) {
            data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
        }
        if indirect {
            data.remove("callee");
        }
        data.set("op_bundle_sizes", Attribute::DenseArray { ty: Type::int(32), values: Vec::new() });
        let types: Vec<Type> = packed.iter().map(|p| p.0.clone()).collect();
        let call = cr.rw.create(data, &types);
        let mut results = Vec::new();
        if let Some((_, groups)) = packed {
            let n: usize = groups.iter().map(Vec::len).sum();
            let r = cr.rw.body[call].results[0];
            let mut k = 0i64;
            for g in &groups {
                let mut group = Vec::new();
                for _ in g {
                    group.push(if n == 1 { r } else { cr.extract(r, &[k]) });
                    k += 1;
                }
                results.push(group);
            }
            for (i, group) in results.iter_mut().enumerate() {
                match Self::memref(&result_types[i]) {
                    Some(s) if bare && s.shape.is_some() => {
                        let Some(desc) = LlvmConverter::convert_memref(opts, s) else { return false };
                        let Some(d) = cr.desc_from_static(opts, s, desc, group[0], group[0]) else { return false };
                        *group = vec![d];
                    }
                    Some(s) if s.shape.is_none() => {
                        let Some(d) = Self::copy_unranked(cr, opts, s, group[0], false, op) else { return false };
                        *group = vec![d];
                    }
                    _ => {}
                }
            }
        }
        cr.replace(op, results);
        true
    }

    #[lowering("func.call")]
    fn call(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], opts: LlvmOptions) -> bool {
        let callee = match cr.rw.body[op].get("callee") {
            Some(Attribute::SymbolRef(p)) => p.last().map(|s| String::from(&**s)),
            _ => None,
        };
        let module = cr.module_of(op);
        let bare = opts.bare_ptr || module.zip(callee).and_then(|(m, c)| cr.rw.body.lookup(m, &c)).is_some_and(|f| cr.rw.body[f].get("llvm.bareptr").is_some());
        Self::call_impl(cr, op, operands, opts, bare, false)
    }

    #[lowering("func.return")]
    fn ret<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], opts: LlvmOptions) -> bool {
        let func = {
            let mut at = cr.rw.body.parent_op(op);
            while let Some(o) = at.filter(|o| cr.rw.body[*o].name != "llvm.func") {
                at = cr.rw.body.parent_op(o);
            }
            at
        };
        let bare = opts.bare_ptr || func.is_some_and(|f| cr.rw.body[f].get("llvm.bareptr").is_some());
        let originals = cr.rw.body[op].operands.clone();
        let mut updated = Vec::new();
        for (o, adapted) in originals.iter().zip(operands) {
            let ty = cr.rw.body[*o].ty.clone();
            match Self::memref(&ty) {
                Some(_) if bare && ty_unranked(&ty) => return false,
                Some(s) if s.shape.is_none() => match Self::copy_unranked(cr, opts, s, adapted[0], true, op) {
                    Some(d) => updated.push(d),
                    None => return false,
                },
                Some(s) if bare && s.strides_and_offset().is_some_and(|(st, o)| !st.contains(&Dim::DYNAMIC) && o != Dim::DYNAMIC) && s.shape.as_ref().is_some_and(|sh| sh.iter().all(|d| matches!(d, mlirformat::Dim::Static(_)))) => updated.push(cr.extract(adapted[0], &[0])),
                _ => updated.extend(adapted.iter().copied()),
            }
        }
        let attrs = cr.all_attrs(op);
        let with_attrs = |mut d: OpData<'a>| -> OpData<'a> {
            for a in &attrs {
                d.set(&a.name, a.value.clone().unwrap_or(Attribute::Unit));
            }
            d
        };
        if updated.len() <= 1 {
            cr.replace_new(op, with_attrs(OpData::build("llvm.return").operands(&updated)), &[]);
            return true;
        }
        let types = cr.rw.body.types(&originals);
        let Some((packed, _)) = Self::pack_results(cr, opts, &types, bare) else { return false };
        let mut p = cr.poison(packed);
        for (i, v) in updated.into_iter().enumerate() {
            p = cr.insert_value(p, v, &[i as i64]);
        }
        cr.replace_new(op, with_attrs(OpData::build("llvm.return").operands(&[p])), &[]);
        true
    }

    /// `populateFuncToLLVMConversionPatterns`.
    /// `CallIndirectOpLowering`.
    #[lowering("func.call_indirect")]
    fn call_indirect(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], opts: LlvmOptions) -> bool {
        Self::call_impl(cr, op, o, opts, false, true)
    }

}

fn ty_unranked(t: &Type<'_>) -> bool {
    matches!(t, Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_none())
}
