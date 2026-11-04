//! `xevm` ⇒ `llvm`, as `XeVMToLLVM.cpp`: each op a call of the OpenCL builtin it is (Itanium-mangled), declared in the
//! module with the SPIR calling convention and the attributes the builtin has; cache controls as the
//! `xevm.DecorationCacheControl` the SPIR-V backend reads.

use alloc::borrow::Cow;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm::{AllocaOp, BitcastOp, InsertElementOp, LoadOp, StoreOp, UndefOp};
use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Dim, FloatKind, NamedAttr, Shaped, ShapedKind, Type};

use crate::patterns;
use crate::{ConversionRewriter, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `getL1CacheControl` / `getL3CacheControl` of a load (`xevm.load_cache_control`).
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum LoadCacheControl {
    L1ucL2ucL3uc,
    L1ucL2ucL3c,
    L1ucL2cL3uc,
    L1ucL2cL3c,
    L1cL2ucL3uc,
    L1cL2ucL3c,
    L1cL2cL3uc,
    L1cL2cL3c,
    L1sL2ucL3uc,
    L1sL2ucL3c,
    L1sL2cL3uc,
    L1sL2cL3c,
    InvalidateRead,
}

impl LoadCacheControl {
    /// The cases by their assembly names (`XeVMOps.td`).
    const NAMES: [(&'static str, Self); 13] = [
        ("L1uc_L2uc_L3uc", Self::L1ucL2ucL3uc),
        ("L1uc_L2uc_L3c", Self::L1ucL2ucL3c),
        ("L1uc_L2c_L3uc", Self::L1ucL2cL3uc),
        ("L1uc_L2c_L3c", Self::L1ucL2cL3c),
        ("L1c_L2uc_L3uc", Self::L1cL2ucL3uc),
        ("L1c_L2uc_L3c", Self::L1cL2ucL3c),
        ("L1c_L2c_L3uc", Self::L1cL2cL3uc),
        ("L1c_L2c_L3c", Self::L1cL2cL3c),
        ("L1s_L2uc_L3uc", Self::L1sL2ucL3uc),
        ("L1s_L2uc_L3c", Self::L1sL2ucL3c),
        ("L1s_L2c_L3uc", Self::L1sL2cL3uc),
        ("L1s_L2c_L3c", Self::L1sL2cL3c),
        ("ir", Self::InvalidateRead),
    ];

    /// L1: 1 uncached, 2 cached, 3 streaming, 4 invalidate after read.
    fn l1(self) -> i32 {
        use LoadCacheControl::*;
        match self {
            L1ucL2ucL3uc | L1ucL2ucL3c | L1ucL2cL3uc | L1ucL2cL3c => 1,
            L1cL2ucL3uc | L1cL2ucL3c | L1cL2cL3uc | L1cL2cL3c => 2,
            L1sL2ucL3uc | L1sL2ucL3c | L1sL2cL3uc | L1sL2cL3c => 3,
            InvalidateRead => 4,
        }
    }

    /// L3: 1 uncached, 2 cached, 4 invalidate after read.
    fn l3(self) -> i32 {
        use LoadCacheControl::*;
        match self {
            L1ucL2ucL3uc | L1ucL2cL3uc | L1cL2ucL3uc | L1cL2cL3uc | L1sL2ucL3uc | L1sL2cL3uc => 1,
            L1ucL2ucL3c | L1ucL2cL3c | L1cL2ucL3c | L1cL2cL3c | L1sL2ucL3c | L1sL2cL3c => 2,
            InvalidateRead => 4,
        }
    }
}

/// `getL1CacheControl` / `getL3CacheControl` of a store (`xevm.store_cache_control`).
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum StoreCacheControl {
    L1ucL2ucL3uc,
    L1ucL2ucL3wb,
    L1ucL2wbL3uc,
    L1ucL2wbL3wb,
    L1wtL2ucL3uc,
    L1wtL2ucL3wb,
    L1wtL2wbL3uc,
    L1wtL2wbL3wb,
    L1sL2ucL3uc,
    L1sL2ucL3wb,
    L1sL2wbL3uc,
    L1sL2wbL3wb,
    L1wbL2ucL3uc,
    L1wbL2wbL3uc,
    L1wbL2ucL3wb,
}

impl StoreCacheControl {
    const NAMES: [(&'static str, Self); 15] = [
        ("L1uc_L2uc_L3uc", Self::L1ucL2ucL3uc),
        ("L1uc_L2uc_L3wb", Self::L1ucL2ucL3wb),
        ("L1uc_L2wb_L3uc", Self::L1ucL2wbL3uc),
        ("L1uc_L2wb_L3wb", Self::L1ucL2wbL3wb),
        ("L1wt_L2uc_L3uc", Self::L1wtL2ucL3uc),
        ("L1wt_L2uc_L3wb", Self::L1wtL2ucL3wb),
        ("L1wt_L2wb_L3uc", Self::L1wtL2wbL3uc),
        ("L1wt_L2wb_L3wb", Self::L1wtL2wbL3wb),
        ("L1s_L2uc_L3uc", Self::L1sL2ucL3uc),
        ("L1s_L2uc_L3wb", Self::L1sL2ucL3wb),
        ("L1s_L2wb_L3uc", Self::L1sL2wbL3uc),
        ("L1s_L2wb_L3wb", Self::L1sL2wbL3wb),
        ("L1wb_L2uc_L3uc", Self::L1wbL2ucL3uc),
        ("L1wb_L2wb_L3uc", Self::L1wbL2wbL3uc),
        ("L1wb_L2uc_L3wb", Self::L1wbL2ucL3wb),
    ];

    /// L1: 1 uncached, 2 write-through, 3 streaming, 4 write-back.
    fn l1(self) -> i32 {
        use StoreCacheControl::*;
        match self {
            L1ucL2ucL3uc | L1ucL2ucL3wb | L1ucL2wbL3uc | L1ucL2wbL3wb => 1,
            L1wtL2ucL3uc | L1wtL2ucL3wb | L1wtL2wbL3uc | L1wtL2wbL3wb => 2,
            L1sL2ucL3uc | L1sL2ucL3wb | L1sL2wbL3uc | L1sL2wbL3wb => 3,
            L1wbL2ucL3uc | L1wbL2wbL3uc | L1wbL2ucL3wb => 4,
        }
    }

    /// L3: 1 uncached, 2 write-back.
    fn l3(self) -> i32 {
        use StoreCacheControl::*;
        match self {
            L1ucL2ucL3uc | L1ucL2wbL3uc | L1wtL2ucL3uc | L1wtL2wbL3uc | L1sL2ucL3uc | L1sL2wbL3uc | L1wbL2ucL3uc | L1wbL2wbL3uc => 1,
            L1ucL2ucL3wb | L1ucL2wbL3wb | L1wtL2ucL3wb | L1wtL2wbL3wb | L1sL2ucL3wb | L1sL2wbL3wb | L1wbL2ucL3wb => 2,
        }
    }
}

/// A case of an enum attribute `#dialect.name<case>` among `names`.
fn case_of<T: Copy>(a: &Attribute<'_>, names: &[(&'static str, T)]) -> Option<T> {
    let Attribute::Extended { ext, .. } = a else { return None };
    let body = ext.body.as_deref()?.strip_prefix('<')?.strip_suffix('>')?.trim();
    names.iter().find(|(n, _)| *n == body).map(|(_, v)| *v)
}

impl TryFrom<&Attribute<'_>> for LoadCacheControl {
    type Error = ();
    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        case_of(a, &Self::NAMES).ok_or(())
    }
}

impl TryFrom<&Attribute<'_>> for StoreCacheControl {
    type Error = ();
    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        case_of(a, &Self::NAMES).ok_or(())
    }
}

/// A cache control: a load's or a store's, the decorations' key and levels.
#[derive(Clone, Copy)]
enum CacheControl {
    Load(LoadCacheControl),
    Store(StoreCacheControl),
}

impl CacheControl {
    /// `getCacheControlMetadata`: `[[key, 0, L1, 0], [key, 1, L3, 0]]` (key 6442 a load's, 6443 a store's).
    fn metadata(self) -> Attribute<'static> {
        let (key, l1, l3) = match self {
            CacheControl::Load(c) => (6442, c.l1(), c.l3()),
            CacheControl::Store(c) => (6443, c.l1(), c.l3()),
        };
        let i32s = |v: [i32; 4]| Attribute::Array(v.iter().map(|x| Attribute::of_int(i128::from(*x).into(), Type::int(32))).collect());
        Attribute::Array(vec![i32s([key, 0, l1, 0]), i32s([key, 1, l3, 0])])
    }
}

/// `xevm::ElemType` (an mma's precisions, `#xevm.mma_types<d = .., a = .., b = .., c = ..>`).
#[derive(Clone, Copy, PartialEq, Eq)]
enum ElemType {
    Bf16,
    F16,
    S8,
    U8,
    S4,
    U4,
    Tf32,
    F32,
    S32,
}

impl ElemType {
    const NAMES: [(&'static str, Self); 9] = [("bf16", Self::Bf16), ("f16", Self::F16), ("s8", Self::S8), ("u8", Self::U8), ("s4", Self::S4), ("u4", Self::U4), ("tf32", Self::Tf32), ("f32", Self::F32), ("s32", Self::S32)];

    fn name(self) -> &'static str {
        Self::NAMES.iter().find(|(_, v)| *v == self).map_or("", |(n, _)| n)
    }

    /// `getNumOperandsPerDword`
    fn per_dword(self) -> Option<i32> {
        match self {
            ElemType::Tf32 => Some(1),
            ElemType::Bf16 | ElemType::F16 => Some(2),
            ElemType::U8 | ElemType::S8 => Some(4),
            _ => None,
        }
    }

    /// The precisions d, a, b, c of `#xevm.mma_types<..>`.
    fn mma(a: &Attribute<'_>) -> Option<[Self; 4]> {
        let Attribute::Extended { ext, .. } = a else { return None };
        let body = ext.body.as_deref()?.strip_prefix('<')?.strip_suffix('>')?;
        let get = |key: &str| {
            body.split(',').find_map(|kv| {
                let (k, v) = kv.split_once('=')?;
                (k.trim() == key).then(|| Self::NAMES.iter().find(|(n, _)| *n == v.trim()).map(|(_, t)| *t)).flatten()
            })
        };
        Some([get("d")?, get("a")?, get("b")?, get("c")?])
    }
}

/// `xevm::MemScope` (`#xevm.mem_scope<..>`): an OpenCL fence's scope, where it has one.
#[derive(Clone, Copy)]
enum MemScope {
    Lane,
    Subgroup,
    Workgroup,
    Cluster,
    Device,
    System,
}

impl MemScope {
    const NAMES: [(&'static str, Self); 6] = [("lane", Self::Lane), ("subgroup", Self::Subgroup), ("workgroup", Self::Workgroup), ("cluster", Self::Cluster), ("device", Self::Device), ("system", Self::System)];

    /// OpenCL's `memory_scope`: 1 work group, 2 device; none for the others.
    fn opencl(self) -> Option<i32> {
        match self {
            MemScope::Workgroup => Some(1),
            MemScope::Device => Some(2),
            MemScope::Lane | MemScope::Subgroup | MemScope::Cluster | MemScope::System => None,
        }
    }
}

/// `xevm::AddrSpace` (`#xevm.addr_space<..>`).
#[derive(Clone, Copy)]
enum AddrSpace {
    Private,
    Global,
    Constant,
    Shared,
    Generic,
}

impl AddrSpace {
    const NAMES: [(&'static str, Self); 5] = [("private", Self::Private), ("global", Self::Global), ("constant", Self::Constant), ("shared", Self::Shared), ("generic", Self::Generic)];

    /// OpenCL's fence flags: `CLK_LOCAL_MEM_FENCE` 1, `CLK_GLOBAL_MEM_FENCE` 2; none for the others.
    fn fence_flags(self) -> Option<i32> {
        match self {
            AddrSpace::Shared => Some(1),
            AddrSpace::Global => Some(2),
            AddrSpace::Private | AddrSpace::Constant | AddrSpace::Generic => None,
        }
    }
}

/// `LLVM::MemoryEffectsAttr` of the builtins: nothing touched, or only their arguments' memory read.
#[derive(Clone, Copy)]
enum Memory {
    None,
    ArgRead,
}

impl From<Memory> for Attribute<'static> {
    fn from(m: Memory) -> Self {
        let arg = match m {
            Memory::None => "none",
            Memory::ArgRead => "read",
        };
        Attribute::dialect("llvm.memory_effects", &format!("<other = none, argMem = {arg}, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>"))
    }
}

/// `LLVMFuncAttributeOptions`: what a builtin is (it never unwinds; maybe returns, maybe convergent, its memory).
#[derive(Clone, Copy)]
struct FnAttrs {
    convergent: bool,
    will_return: bool,
    memory: Option<Memory>,
}

impl FnAttrs {
    /// `noUnwindAttrs`
    const NO_UNWIND: FnAttrs = FnAttrs { convergent: false, will_return: false, memory: None };
    /// `noUnwindWillReturnAttrs`
    const WILL_RETURN: FnAttrs = FnAttrs { convergent: false, will_return: true, memory: None };
    /// `convergentNoUnwindWillReturnAttrs`
    const CONVERGENT: FnAttrs = FnAttrs { convergent: true, will_return: true, memory: None };

    fn with(self, memory: Memory) -> Self {
        FnAttrs { memory: Some(memory), ..self }
    }
}

/// The Itanium mangling of a builtin's parameter type (`getTypeMangling`): `isUnsigned` integers as unsigned.
fn mangled(t: &Type<'_>, unsigned: bool) -> String {
    match t {
        Type::Shaped(Shaped { kind: ShapedKind::Vector, shape: Some(dims), elem, .. }) => {
            let n: i64 = dims.iter().map(|d| if let Dim::Static(n) = d { *n } else { 0 }).product();
            format!("Dv{n}_{}", mangled(elem, unsigned))
        }
        Type::Float(FloatKind::F16) => String::from("Dh"),
        Type::Float(FloatKind::F32) => String::from("f"),
        Type::Float(FloatKind::F64) => String::from("d"),
        Type::Integer { width, .. } => String::from(match (width, unsigned) {
            (8, true) => "h",
            (8, false) => "c",
            (16, true) => "t",
            (16, false) => "s",
            (32, true) => "j",
            (32, false) => "i",
            (64, true) => "m",
            _ => "l",
        }),
        _ => String::new(),
    }
}

/// `mangle`: `_Z<len><name>` and the parameters' manglings, a repeated non-scalar one as a substitution (`S_`,
/// `S0_`, ..).
fn mangle(name: &str, types: &[Type<'_>], unsigned: &[bool]) -> String {
    let mut s = format!("_Z{}{name}", name.len());
    let mut seen: Vec<&Type<'_>> = Vec::new();
    for (i, t) in types.iter().enumerate() {
        if let Some(k) = seen.iter().position(|u| *u == t) {
            s.push('S');
            if k > 0 {
                s.push_str(&format!("{}", k - 1));
            }
            s.push('_');
        } else {
            if !matches!(t, Type::Integer { .. } | Type::Float(_)) {
                seen.push(t);
            }
            s.push_str(&mangled(t, unsigned.get(i).copied().unwrap_or(false)));
        }
    }
    s
}

/// An integer attribute's value (an `i1` one as 0 / 1).
fn int(a: &Attribute<'_>) -> Option<i64> {
    match a {
        Attribute::Int { lit, .. } => lit.parse().ok(),
        Attribute::Bool(b) => Some(i64::from(*b)),
        _ => None,
    }
}

/// A vector type's elements and their count.
fn vector<'a>(t: &Type<'a>) -> Option<(Type<'a>, i64)> {
    let Type::Shaped(Shaped { kind: ShapedKind::Vector, shape: Some(dims), elem, .. }) = t else { return None };
    let n = dims.iter().map(|d| if let Dim::Static(n) = d { *n } else { 0 }).product();
    Some(((**elem).clone(), n))
}

fn vector_of<'a>(n: i64, elem: Type<'a>) -> Type<'a> {
    Type::Shaped(Shaped { kind: ShapedKind::Vector, shape: Some(vec![Dim::Static(n)]), elem: elem.into(), extras: Vec::new() })
}

/// A builtin called: its name, result, parameters, their attributes (`(index, name)`), what it is.
struct DeviceFn<'s, 'a> {
    name: &'s str,
    ret: Type<'a>,
    params: Vec<Type<'a>>,
    param_attrs: &'s [(usize, &'static str)],
    attrs: FnAttrs,
}

impl<'a> DeviceFn<'_, 'a> {
    /// `createDeviceFunctionCall`: the builtin declared in the module around `op` (`spir_funccc`, its attributes;
    /// again on an existing declaration) and called with `args`, the call carrying the declaration's attributes.
    fn call(&self, cr: &mut Cr<'_, 'a, '_>, op: OpId, args: &[ValueId]) -> Option<OpId> {
        let module = cr.module_of(op)?;
        let f = cr.llvm_func(module, self.name, self.params.clone(), self.ret.clone(), false)?;
        let mut fn_attrs: Vec<(&'static str, Attribute<'a>)> = vec![("CConv", Attribute::dialect("llvm.cconv", "<spir_funccc>"))];
        if self.attrs.convergent {
            fn_attrs.push(("convergent", Attribute::Unit));
        }
        fn_attrs.push(("no_unwind", Attribute::Unit));
        if self.attrs.will_return {
            fn_attrs.push(("will_return", Attribute::Unit));
        }
        if let Some(m) = self.attrs.memory {
            fn_attrs.push(("memory_effects", m.into()));
        }
        if !self.param_attrs.is_empty() {
            let dicts = (0..self.params.len())
                .map(|i| {
                    let mut names: Vec<&str> = self.param_attrs.iter().filter(|(k, _)| *k == i).map(|(_, n)| *n).collect();
                    names.sort_unstable();
                    names.dedup();
                    Attribute::Dict(names.into_iter().map(|n| NamedAttr { name: Cow::Borrowed(n), value: None }).collect())
                })
                .collect();
            fn_attrs.push(("arg_attrs", Attribute::Array(dicts)));
        }
        cr.modify(f, |b| {
            for (n, a) in &fn_attrs {
                b[f].set(n, a.clone());
            }
        });
        let results: Vec<Type<'a>> = if matches!(LlvmType::try_from(&self.ret), Ok(LlvmType::Void)) { Vec::new() } else { vec![self.ret.clone()] };
        let call = cr.llvm_call(self.name, args, &results);
        // `callOp->setAttrs(funcOp->getAttrs())`: the declaration's properties the call has, the rest discardable
        let fty: Type<'a> = LlvmType::Func { ret: self.ret.clone().into(), params: self.params.clone(), vararg: false }.into();
        let mut call_attrs = fn_attrs;
        call_attrs.push(("function_type", Attribute::Type(fty)));
        call_attrs.push(("linkage", Attribute::dialect("llvm.linkage", "<external>")));
        call_attrs.push(("sym_name", Attribute::str(self.name)));
        call_attrs.push(("visibility_", Attribute::i64(0)));
        cr.modify(call, |b| {
            for (n, a) in call_attrs {
                b[call].set(n, a);
            }
        });
        Some(call)
    }
}

/// The xevm ⇒ llvm patterns.
pub struct XevmToLlvm;

impl XevmToLlvm {
    /// `populateXeVMToLLVMConversionPatterns`' target: the xevm ops illegal, llvm's legal but a load or store with a
    /// `cache_control` (it becomes the decorations).
    pub fn target(target: &mut crate::ConversionTarget<'_>) {
        target.dialect("llvm", crate::Action::Dynamic(alloc::boxed::Box::new(|b: &crate::Body<'_>, o: OpId| Some(b[o].get("cache_control").is_none()))));
        target.illegal_dialect("xevm");
    }
}

#[patterns]
impl XevmToLlvm {
    /// A `llvm.mlir.constant` of type `ty`.
    fn constant(cr: &mut Cr<'_, '_, '_>, v: i64, ty: Type<'static>) -> ValueId {
        cr.llvm_constant(Attribute::of_int(i128::from(v).into(), ty.clone()), ty)
    }

    /// The cache control decorations on `call`, when the op has one.
    fn decorate(cr: &mut Cr<'_, '_, '_>, call: OpId, cc: Option<CacheControl>) {
        if let Some(cc) = cc {
            cr.modify(call, |b| b[call].set("xevm.DecorationCacheControl", cc.metadata()));
        }
    }

    /// `LoadStorePrefetchToOCLPattern`: a 2D block load, store or prefetch as `intel_sub_group_2d_block_*`, the
    /// coordinates a `vector<2xi32>`; a load's and a store's data through an alloca.
    #[convert("xevm.blockload2d", "xevm.blockstore2d", "xevm.blockprefetch2d")]
    fn block2d(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let operands = cr.rw.body[op].operands.to_vec();
        let name = cr.rw.body[op].name.clone();
        let (load, store) = (name == "xevm.blockload2d", name == "xevm.blockstore2d");
        let attr = |cr: &Cr<'_, '_, '_>, n: &str| cr.rw.body[op].get(n).and_then(int);
        let (Some(bits), Some(tw), Some(th)) = (attr(cr, "elem_size_in_bits"), attr(cr, "tile_width"), attr(cr, "tile_height")) else { return false };
        let v_blocks = if store { 1 } else { attr(cr, "v_blocks").unwrap_or(1) };
        let (transpose, pack) = (attr(cr, "transpose").unwrap_or(0) != 0, attr(cr, "pack_register").unwrap_or(0) != 0);
        let cc = cr.rw.body[op].get("cache_control").and_then(|a| if store { StoreCacheControl::try_from(a).ok().map(CacheControl::Store) } else { LoadCacheControl::try_from(a).ok().map(CacheControl::Load) });
        let vec_ty = if load { Some(cr.rw.body[cr.rw.body[op].results[0]].ty.clone()) } else if store { Some(cr.rw.body[operands[6]].ty.clone()) } else { None };
        let i32t = Type::int(32);
        let v2 = vector_of(2, i32t.clone());
        let undef = cr.emit(&UndefOp::new(v2.clone()));
        let zero = Self::constant(cr, 0, i32t.clone());
        let one = Self::constant(cr, 1, i32t.clone());
        let c0 = cr.emit(&InsertElementOp::new(undef.into(), operands[4].into(), zero.into(), i32t.clone(), i32t.clone(), v2.clone()));
        let coord = cr.emit(&InsertElementOp::new(c0.into(), operands[5].into(), one.into(), i32t.clone(), i32t.clone(), v2.clone()));
        let mut args = vec![operands[0], operands[1], operands[2], operands[3], coord];
        let (mut fname, mut width_id) = (String::from("intel_sub_group_2d_block_"), String::new());
        let mut fattrs = FnAttrs::WILL_RETURN;
        let param_attrs: &[(usize, &'static str)];
        let mut dst = None;
        match vec_ty.as_ref().and_then(vector) {
            None => {
                fname.push_str("prefetch");
                param_attrs = &[(0, "llvm.nonnull")];
                fattrs = FnAttrs::NO_UNWIND.with(Memory::ArgRead);
            }
            Some((elem, n)) => {
                let count = Self::constant(cr, n, i32t.clone());
                let ptr = cr.emit(&AllocaOp::new(count.into(), None, Attribute::Type(elem.clone()), false, i32t.clone(), LlvmType::ptr()));
                args.push(ptr);
                if load {
                    fname.push_str("read");
                    width_id = mangled(&elem, true);
                    if pack {
                        fname.push_str("_transform");
                    } else if transpose {
                        fname.push_str("_transpose");
                    }
                    dst = Some(ptr);
                    param_attrs = &[(0, "llvm.nonnull"), (0, "llvm.readonly"), (5, "llvm.nonnull"), (5, "llvm.writeonly")];
                } else {
                    fname.push_str("write");
                    let ew = match &elem {
                        Type::Integer { width, .. } => *width,
                        Type::Float(FloatKind::F16 | FloatKind::BF16) => 16,
                        Type::Float(FloatKind::F32) => 32,
                        _ => 8,
                    };
                    width_id = String::from(match ew {
                        32 => "j",
                        16 => "t",
                        _ => "h",
                    });
                    let vt = vec_ty.clone().unwrap_or(Type::NoneType);
                    cr.rw.emit(&StoreOp::new(operands[6].into(), ptr.into(), None, false, false, false, None, None, None, None, None, None, vt, LlvmType::ptr()));
                    param_attrs = &[(0, "llvm.nonnull"), (0, "llvm.writeonly"), (5, "llvm.nonnull"), (5, "llvm.readonly")];
                }
            }
        }
        let fname = format!("{fname}_{bits}b_{th}r{tw}x{v_blocks}c");
        let p = if dst.is_some() || store { "P" } else { "" };
        let mangled_name = format!("_Z{}{fname}PU3AS1viiiDv2_i{p}{width_id}", fname.len());
        let params: Vec<Type<'_>> = args.iter().map(|a| cr.rw.body[*a].ty.clone()).collect();
        let f = DeviceFn { name: &mangled_name, ret: LlvmType::void(), params, param_attrs, attrs: fattrs };
        let Some(call) = f.call(cr, op, &args) else { return false };
        Self::decorate(cr, call, cc);
        match (dst, vec_ty) {
            (Some(ptr), Some(vt)) => {
                let v = cr.emit(&LoadOp::new(ptr.into(), None, false, false, false, false, None, None, None, None, None, None, None, LlvmType::ptr(), vt));
                cr.replace(op, vec![vec![v]]);
            }
            _ => cr.erase(op),
        }
        true
    }

    /// `BlockLoadStore1DToOCLPattern`: `intel_sub_group_block_{read,write}_u<elem><n>` on the pointer's address space.
    #[convert("xevm.blockload", "xevm.blockstore")]
    fn block1d(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let store = cr.rw.body[op].name == "xevm.blockstore";
        let operands = cr.rw.body[op].operands.to_vec();
        let ptr_ty = cr.rw.body[operands[0]].ty.clone();
        let Ok(LlvmType::Ptr(space)) = LlvmType::try_from(&ptr_ty) else { return false };
        let val_ty = if store { cr.rw.body[operands[1]].ty.clone() } else { cr.rw.body[cr.rw.body[op].results[0]].ty.clone() };
        let (elem, n) = vector(&val_ty).map_or((val_ty.clone(), None), |(e, n)| (e, Some(n)));
        let mut fname = format!("intel_sub_group_block_{}_u{}", if store { "write" } else { "read" }, mangled(&elem, false));
        if let Some(n) = n {
            fname.push_str(&format!("{n}"));
        }
        let mut name = format!("_Z{}{fname}PU3AS{space}{}", fname.len(), mangled(&elem, true));
        if store {
            name.push_str(&mangled(&val_ty, true));
        }
        let (args, params, ret) = if store { (operands.clone(), vec![ptr_ty, val_ty], LlvmType::void()) } else { (vec![operands[0]], vec![ptr_ty], val_ty) };
        let cc = cr.rw.body[op].get("cache_control").and_then(|a| if store { StoreCacheControl::try_from(a).ok().map(CacheControl::Store) } else { LoadCacheControl::try_from(a).ok().map(CacheControl::Load) });
        let f = DeviceFn { name: &name, ret, params, param_attrs: &[], attrs: FnAttrs::WILL_RETURN };
        let Some(call) = f.call(cr, op, &args) else { return false };
        Self::decorate(cr, call, cc);
        if store {
            cr.erase(op);
        } else {
            let v = cr.rw.body[call].results[0];
            cr.replace(op, vec![vec![v]]);
        }
        true
    }

    /// `MMAToOCLPattern`: `intel_sub_group_<a>_<b>_matrix_mad_k<8 · per dword>`, A packed into i16 (f32 for tf32),
    /// B into i32 (f32 for tf32), a bf16 accumulator as i16.
    #[convert("xevm.mma")]
    fn mma(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let operands = cr.rw.body[op].operands.to_vec();
        let [a, b, c] = operands[..] else { return false };
        let Some([d_ty, a_ty, b_ty, c_ty]) = cr.rw.body[op].get("types").and_then(ElemType::mma) else { return false };
        if c_ty != d_ty || !matches!(c_ty, ElemType::S32 | ElemType::F32 | ElemType::F16 | ElemType::Bf16) || matches!(a_ty, ElemType::S32 | ElemType::F32) || matches!(b_ty, ElemType::S32 | ElemType::F32) {
            return false;
        }
        let Some(per_dword) = a_ty.per_dword() else { return false };
        let packed = |t: ElemType, bits: u32| if t == ElemType::Tf32 { Type::Float(FloatKind::F32) } else { Type::int(bits) };
        let cast = |cr: &mut Cr<'_, '_, '_>, v: ValueId, to: Type<'_>| -> ValueId {
            let ty = cr.rw.body[v].ty.clone();
            let Some((elem, n)) = vector(&ty) else { return v };
            let bits = |t: &Type<'_>| match t {
                Type::Integer { width, .. } => *width,
                Type::Float(FloatKind::F16 | FloatKind::BF16) => 16,
                Type::Float(FloatKind::F64) => 64,
                _ => 32,
            };
            let new = vector_of(n * i64::from(bits(&elem)) / i64::from(bits(&to)), to);
            if new == ty { v } else { cr.emit(&BitcastOp::new(v.into(), ty, new)) }
        };
        let a = cast(cr, a, packed(a_ty, 16));
        let b = cast(cr, b, packed(b_ty, 32));
        let c_orig = cr.rw.body[c].ty.clone();
        let Some((c_elem, c_n)) = vector(&c_orig) else { return false };
        let c_new = if c_elem == Type::Float(FloatKind::BF16) { vector_of(c_n, Type::int(16)) } else { c_orig.clone() };
        let c = if c_new != c_orig { cr.emit(&BitcastOp::new(c.into(), c_orig.clone(), c_new.clone())) } else { c };
        let fname = format!("intel_sub_group_{}_{}_matrix_mad_k{}", a_ty.name(), b_ty.name(), 8 * per_dword);
        let params: Vec<Type<'_>> = [a, b, c].iter().map(|v| cr.rw.body[*v].ty.clone()).collect();
        let name = mangle(&fname, &params, &[]);
        let f = DeviceFn { name: &name, ret: c_new.clone(), params, param_attrs: &[], attrs: FnAttrs::CONVERGENT.with(Memory::None) };
        let Some(call) = f.call(cr, op, &[a, b, c]) else { return false };
        let mut r = cr.rw.body[call].results[0];
        if c_new != c_orig {
            r = cr.emit(&BitcastOp::new(r.into(), c_new, c_orig));
        }
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `PrefetchToOCLPattern`: `prefetch(ptr, 1)`.
    #[convert("xevm.prefetch")]
    fn prefetch(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let ptr = cr.rw.body[op].operands[0];
        let one = Self::constant(cr, 1, Type::int(64));
        let params = vec![cr.rw.body[ptr].ty.clone(), Type::int(64)];
        let cc = cr.rw.body[op].get("cache_control").and_then(|a| LoadCacheControl::try_from(a).ok().map(CacheControl::Load));
        let f = DeviceFn { name: "_Z8prefetchPU3AS1Kcm", ret: LlvmType::void(), params, param_attrs: &[], attrs: FnAttrs::NO_UNWIND.with(Memory::ArgRead) };
        let Some(call) = f.call(cr, op, &[ptr, one]) else { return false };
        Self::decorate(cr, call, cc);
        cr.erase(op);
        true
    }

    /// `MemfenceToOCLPattern`: `atomic_work_item_fence(flags, acq_rel, scope)`, shared or global, work group or
    /// device.
    #[convert("xevm.memfence")]
    fn memfence(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let space = cr.rw.body[op].get("addrspace").map_or(Some(AddrSpace::Generic), |a| case_of(a, &AddrSpace::NAMES));
        let scope = cr.rw.body[op].get("scope").and_then(|a| case_of(a, &MemScope::NAMES));
        let (Some(flags), Some(scope)) = (space.and_then(AddrSpace::fence_flags), scope.and_then(MemScope::opencl)) else { return false };
        let i32t = Type::int(32);
        let acq_rel = Self::constant(cr, 4, i32t.clone());
        let s = Self::constant(cr, i64::from(scope), i32t.clone());
        let f_ = Self::constant(cr, i64::from(flags), i32t.clone());
        let params = vec![i32t.clone(); 3];
        let name = mangle("atomic_work_item_fence", &params, &[]);
        let f = DeviceFn { name: &name, ret: LlvmType::void(), params, param_attrs: &[], attrs: FnAttrs::NO_UNWIND };
        if f.call(cr, op, &[f_, acq_rel, s]).is_none() {
            return false;
        }
        cr.erase(op);
        true
    }

    /// `LaunchConfigOpToOCLPattern`: `get_local_id` / `get_local_size` / `get_group_id` / `get_num_groups` of the
    /// dimension, an unsigned i32.
    #[convert("xevm.local_id.x", "xevm.local_id.y", "xevm.local_id.z", "xevm.local_size.x", "xevm.local_size.y", "xevm.local_size.z", "xevm.group_id.x", "xevm.group_id.y", "xevm.group_id.z", "xevm.group_count.x", "xevm.group_count.y", "xevm.group_count.z")]
    fn launch(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let name = cr.rw.body[op].name.clone();
        let Some((base, dim)) = name.strip_prefix("xevm.").and_then(|n| n.rsplit_once('.')) else { return false };
        let base = match base {
            "local_id" => "get_local_id",
            "local_size" => "get_local_size",
            "group_id" => "get_group_id",
            _ => "get_num_groups",
        };
        let dim = match dim {
            "x" => 0,
            "y" => 1,
            _ => 2,
        };
        let i32t = Type::int(32);
        let d = Self::constant(cr, dim, i32t.clone());
        let fname = mangle(base, core::slice::from_ref(&i32t), &[true]);
        let ret = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let f = DeviceFn { name: &fname, ret, params: vec![i32t], param_attrs: &[], attrs: FnAttrs::WILL_RETURN };
        let Some(call) = f.call(cr, op, &[d]) else { return false };
        cr.modify(call, |b| b[call].set("memory_effects", Memory::None.into()));
        let v = cr.rw.body[call].results[0];
        cr.replace(op, vec![vec![v]]);
        true
    }

    /// `SubgroupOpWorkitemOpToOCLPattern`: `get_sub_group_local_id` / `get_sub_group_id` / `get_sub_group_size`.
    #[convert("xevm.lane_id", "xevm.subgroup_id", "xevm.subgroup_size")]
    fn subgroup(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let base = match &*cr.rw.body[op].name {
            "xevm.lane_id" => "get_sub_group_local_id",
            "xevm.subgroup_id" => "get_sub_group_id",
            _ => "get_sub_group_size",
        };
        let fname = mangle(base, &[], &[]);
        let ret = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let f = DeviceFn { name: &fname, ret, params: Vec::new(), param_attrs: &[], attrs: FnAttrs::WILL_RETURN };
        let Some(call) = f.call(cr, op, &[]) else { return false };
        cr.modify(call, |b| b[call].set("memory_effects", Memory::None.into()));
        let v = cr.rw.body[call].results[0];
        cr.replace(op, vec![vec![v]]);
        true
    }

    /// `LLVMLoadStoreToOCLPattern`: an `llvm.load` / `llvm.store` with a `cache_control` keeps it as the decorations.
    #[convert("llvm.load", "llvm.store")]
    fn llvm_mem(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(a) = cr.rw.body[op].get("cache_control").cloned() else { return false };
        let cc = if cr.rw.body[op].name == "llvm.load" { LoadCacheControl::try_from(&a).ok().map(CacheControl::Load) } else { StoreCacheControl::try_from(&a).ok().map(CacheControl::Store) };
        let Some(cc) = cc else { return false };
        cr.modify(op, |b| {
            b[op].set("xevm.DecorationCacheControl", cc.metadata());
            b[op].remove("cache_control");
        });
        true
    }
}
