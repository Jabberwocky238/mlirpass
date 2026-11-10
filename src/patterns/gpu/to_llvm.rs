//! `gpu` ⇒ `llvm` shared by the vendor lowerings, as `GPUOpsLowering.cpp`: `gpu.func` (with its
//! attributions), `gpu.return` and `gpu.printf` as a call.

use alloc::borrow::Cow;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Dim, NamedAttr, Shaped, ShapedKind, Type};

use crate::patterns;
use crate::{CConv, ConversionRewriter, LlvmConverter, LlvmOptions, MemrefToLlvm, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `GPUPrintfOpToLLVMCallLowering`'s parameters: the format string's address space, the
/// callee's calling convention and name.
#[derive(Debug, Clone, Copy)]
pub struct PrintfCall {
    pub space: u32,
    pub cconv: CConv,
    pub name: &'static str,
}

/// Which `gpu.printf` lowering a vendor uses.
#[derive(Debug, Clone, Copy)]
pub enum Printf {
    /// `GPUPrintfOpToLLVMCallLowering`.
    Call(PrintfCall),
    /// `GPUPrintfOpToVPrintfLowering`: `vprintf(format, args)`, the arguments packed on the stack.
    VPrintf,
    /// `GPUPrintfOpToHIPLowering`: the `__ockl_printf_*` hostcalls.
    Hip,
}

/// `GPUFuncOpLoweringOptions` with the converter's options and the printf lowering in use.
#[derive(Debug, Clone, Copy)]
pub struct GpuLlvmOptions {
    pub llvm: LlvmOptions,
    /// `allocaAddrSpace`: where private attributions are `alloca`'d.
    pub alloca_space: u32,
    /// `workgroupAddrSpace`.
    pub workgroup_space: u32,
    /// `kernelAttributeName`: a unit attribute marking kernels.
    pub kernel_attr: Option<&'static str>,
    /// `kernelBlockSizeAttributeName`: the known block size again, under this name.
    pub block_size_attr: Option<&'static str>,
    /// `kernelClusterSizeAttributeName`.
    pub cluster_size_attr: Option<&'static str>,
    pub kernel_cconv: CConv,
    pub func_cconv: CConv,
    /// `encodeWorkgroupAttributionsAsArguments`: `llvm.ptr` arguments instead of globals.
    pub workgroup_args: bool,
    pub printf: Option<Printf>,
    /// `GPUDynamicSharedMemoryOpLowering`'s alignment in bits, where it is used.
    pub dynamic_shmem_align: Option<u32>,
}

/// The gpu ⇒ llvm patterns every vendor shares.
pub struct GpuToLlvm;

/// The argument attributes copied onto every argument an input becomes, and those copied onto
/// its pointers only.
const COPIED: [&str; 3] = ["llvm.returned", "llvm.noundef", "llvm.inreg"];
const POINTER_COPIED: [&str; 11] = ["llvm.noalias", "llvm.nocapture", "llvm.nofree", "llvm.align", "llvm.readonly", "llvm.writeonly", "llvm.readnone", "llvm.nonnull", "llvm.dereferenceable", "llvm.dereferenceable_or_null", "llvm.workgroup_attribution"];

/// A static memref attribution: its type and element count.
struct Attribution<'a> {
    ty: Shaped<'a>,
    elems: i64,
    elem: Type<'a>,
}

impl<'a> Attribution<'a> {
    fn of(cr: &Cr<'_, 'a, '_>, t: &Type<'a>) -> Option<Self> {
        let Type::Shaped(s) = t else { return None };
        if s.kind != ShapedKind::MemRef {
            return None;
        }
        let elems = s.shape.as_ref()?.iter().map(|d| if let Dim::Static(n) = d { Some(*n) } else { None }).product::<Option<i64>>()?;
        let elem = cr.type_converter()?.convert(&s.elem)?;
        Some(Self { ty: s.clone(), elems, elem })
    }

    /// `MemRefDescriptor::fromStaticShape` over `ptr`.
    fn descriptor(&self, cr: &mut Cr<'_, 'a, '_>, o: LlvmOptions, ptr: ValueId) -> Option<ValueId> {
        let desc = LlvmConverter::convert_memref(o, &self.ty)?;
        cr.desc_from_static(o, &self.ty, desc, ptr, ptr)
    }
}

#[patterns(converter, options = GpuLlvmOptions)]
impl GpuToLlvm {
    /// `GPUDynamicSharedMemoryOpLowering`: the `memref<0xT>` of a zero-sized global of the
    /// module (one already there with the space and alignment, else a new
    /// `__dynamic_shmem__<n>` at the module's start).
    #[convert("gpu.dynamic_shared_memory")]
    fn dynamic_shared_memory(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuLlvmOptions) -> bool {
        let Some(bits) = o.dynamic_shmem_align else { return false };
        let b = &*cr.rw.body;
        let Type::Shaped(s) = b[b[op].results[0]].ty.clone() else { return false };
        let Some(elem) = MemrefToLlvm::elem(cr, &s.elem) else { return false };
        let zero = Shaped { shape: Some(vec![mlirformat::Dim::Static(0)]), elem: elem.clone().into(), extras: s.extras.iter().filter(|x| !x.is_layout()).cloned().collect(), ..s.clone() };
        let Some(desc_ty) = cr.converted(&Type::Shaped(zero.clone())) else { return false };
        let Some(LlvmType::Ptr(space)) = LlvmType::try_from(&desc_ty).ok().and_then(|t| if let LlvmType::Struct { body: Some(f), .. } = t { f.first().and_then(|p| LlvmType::try_from(p).ok()) } else { None }) else { return false };
        let align = i64::from(bits / zero.elem.bit_width().unwrap_or(8).max(1));
        let b = &*cr.rw.body;
        let mut module = b.parent_op(op);
        while let Some(m) = module.filter(|m| b[*m].name != "gpu.module") {
            module = b.parent_op(m);
        }
        let Some(module) = module else { return false };
        let top = b.top_block(module);
        let array = LlvmType::array(0, elem.clone());
        let globals: Vec<OpId> = b.ops(top).filter(|g| b[*g].name == "llvm.mlir.global").collect();
        let int = |a: Option<&Attribute<'_>>| a.and_then(MemrefToLlvm::int).unwrap_or(0);
        let existing = globals.iter().copied().find(|g| b[*g].get("global_type") == Some(&Attribute::Type(array.clone())) && int(b[*g].get("addr_space")) == i64::from(space) && int(b[*g].get("alignment")) == align);
        let name = match existing {
            Some(g) => String::from(b.sym_name(g).unwrap_or("")),
            None => {
                let taken: Vec<&str> = globals.iter().filter_map(|g| b.sym_name(*g)).collect();
                let name = (0..).map(|i| format!("__dynamic_shmem__{i}")).find(|n| !taken.contains(&n.as_str())).expect("a free name");
                let loc = b[op].loc.clone();
                let saved = cr.rw.ip;
                cr.rw.set_start(top);
                let mut data = OpData { loc, ..OpData::build("llvm.mlir.global") }
                    .with("addr_space", Attribute::of_int(space.into(), Type::int(32)))
                    .with("global_type", Attribute::Type(array))
                    .with("linkage", Attribute::dialect("llvm.linkage", "<internal>"))
                    .with("sym_name", Attribute::str(&name));
                if align != 0 {
                    data.set("alignment", Attribute::i64(align));
                }
                cr.rw.create_with(data, &[], |b, g| {
                    b.add_region(g);
                });
                cr.rw.ip = saved;
                name
            }
        };
        cr.rw.set_before(op);
        let ptr: Type<'_> = LlvmType::Ptr(space).into();
        let base = cr.build(OpData::build("llvm.mlir.addressof").with("global_name", Attribute::SymbolRef(vec![name.into()])), ptr.clone());
        let shmem = MemrefToLlvm::gep(cr, ptr, elem, base, &[crate::patterns::LlvmGep::C(0)], 0);
        let Some((sizes, strides, _)) = MemrefToLlvm::desc_sizes(cr, o.llvm, &zero, &[], true) else { return false };
        let Some(d) = MemrefToLlvm::create_desc(cr, o.llvm, &zero, shmem, shmem, &sizes, &strides) else { return false };
        cr.replace(op, vec![vec![d]]);
        true
    }

    fn count(a: Option<&Attribute<'_>>) -> usize {
        match a {
            Some(Attribute::Int { lit, .. }) => lit.parse().unwrap_or(0),
            _ => 0,
        }
    }

    /// The `i`th dictionary of an `arg_attrs`-like array (empty past its end).
    fn dict<'a>(a: Option<&Attribute<'a>>, i: usize) -> Vec<NamedAttr<'a>> {
        match a {
            Some(Attribute::Array(ds)) => match ds.get(i) {
                Some(Attribute::Dict(d)) => d.clone(),
                _ => Vec::new(),
            },
            _ => Vec::new(),
        }
    }

    /// `GPUFuncOpLowering`.
    #[convert("gpu.func")]
    fn func<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuLlvmOptions) -> bool {
        let b = &*cr.rw.body;
        let Some(Attribute::Type(Type::Function(fty))) = b[op].get("function_type").cloned() else { return false };
        let Some(&entry) = b[b[op].regions[0]].blocks.first() else { return false };
        let n_in = fty.inputs.len();
        let n_wg = Self::count(b[op].get("workgroup_attributions"));
        let block_types = b.types(&b[entry].args);
        let wg: Option<Vec<Attribution<'a>>> = block_types[n_in..n_in + n_wg].iter().map(|t| Attribution::of(cr, t)).collect();
        let private: Option<Vec<Attribution<'a>>> = block_types[n_in + n_wg..].iter().map(|t| Attribution::of(cr, t)).collect();
        let (Some(wg), Some(private)) = (wg, private) else { return false };
        // The workgroup pointers go after the proper arguments, as `insertArguments` puts them.
        let wg_ptr: Type<'a> = LlvmType::Ptr(o.workgroup_space).into();
        let n_ptr = if o.workgroup_args { n_wg } else { 0 };
        let inputs: Vec<Type<'a>> = fty.inputs.iter().cloned().chain(core::iter::repeat_n(wg_ptr.clone(), n_ptr)).collect();
        let Some(mut sig) = cr.llvm_signature_of(o.llvm, &inputs, block_types.len() + n_ptr, &fty.results, false, o.llvm.bare_ptr) else { return false };

        let b = &*cr.rw.body;
        let name = String::from(b.sym_name(op).unwrap_or(""));
        let loc = b[op].loc.clone();
        let kernel = b[op].gpu_kernel();
        let mut arg_attrs: Vec<Vec<NamedAttr<'a>>> = (0..n_in).map(|i| Self::dict(b[op].get("arg_attrs"), i)).collect();
        for a in &wg[..n_ptr] {
            let attribution = Attribute::dialect("llvm.mlir.workgroup_attribution", &format!("<{} : i64, {}>", a.elems, a.elem));
            arg_attrs.push(vec![NamedAttr { name: "llvm.noalias".into(), value: None }, NamedAttr { name: "llvm.workgroup_attribution".into(), value: Some(attribution) }]);
        }
        let private_align: Vec<Option<Attribute<'a>>> = (0..private.len()).map(|i| Self::dict(b[op].get("private_attrib_attrs"), i).into_iter().find(|a| a.name == "llvm.align").and_then(|a| a.value)).collect();
        let wg_align: Vec<Option<Attribute<'a>>> = (0..n_wg).map(|i| Self::dict(b[op].get("workgroup_attrib_attrs"), i).into_iter().find(|a| a.name == "llvm.align").and_then(|a| a.value)).collect();
        let mut data = OpData::build("llvm.func").with("sym_name", Attribute::str(&name)).with("function_type", Attribute::Type(sig.llvm.clone())).with("linkage", Attribute::dialect("llvm.linkage", "<external>")).with("CConv", (if kernel { o.kernel_cconv } else { o.func_cconv }).into());
        let known = |n: &str| b[op].get(n).cloned();
        let (block, grid, cluster) = (known("known_block_size"), known("known_grid_size"), known("known_cluster_size"));
        // `lowerDiscardableAttrsForLLVMFunc`: of the discardable attributes, an `llvm.X` with X
        // an `llvm.func` attribute becomes that attribute, a bare X is dropped, the rest carry
        // over.
        let llvm_func = cr.rw.body.ctx.opt.op_info("llvm.func").map_or(&[][..], |i| i.inherent);
        for a in cr.rw.body.discardable(op) {
            if llvm_func.contains(&&*a.name) {
                continue;
            }
            let name = a.name.strip_prefix("llvm.").filter(|n| llvm_func.contains(n)).unwrap_or(&a.name);
            data.set(name, a.value.unwrap_or(Attribute::Unit));
        }
        for (n, v) in [("gpu.known_block_size", &block), ("gpu.known_grid_size", &grid), ("gpu.known_cluster_size", &cluster)] {
            if let Some(v) = v {
                data.set(n, v.clone());
            }
        }
        if kernel {
            data.set("gpu.kernel", Attribute::Unit);
            if let Some(k) = o.kernel_attr {
                data.set(k, Attribute::Unit);
            }
            for (n, v) in [(o.block_size_attr, &block), (o.cluster_size_attr, &cluster)] {
                if let (Some(n), Some(v)) = (n, v) {
                    data.set(n, v.clone());
                }
            }
        }
        data.loc = loc.clone();
        cr.rw.set_before(op);
        // Without pointer arguments, workgroup attributions are internal globals.
        let mut globals = Vec::new();
        if !o.workgroup_args {
            for (i, a) in wg.iter().enumerate() {
                let g = format!("__wg_{name}_{i}");
                let mut gd = OpData::build("llvm.mlir.global").with("global_type", Attribute::Type(LlvmType::array(a.elems as u64, a.elem.clone()))).with("linkage", Attribute::dialect("llvm.linkage", "<internal>")).with("sym_name", Attribute::str(&g)).with("addr_space", Attribute::of_int(o.workgroup_space.into(), Type::int(32)));
                if let Some(al) = &wg_align[i] {
                    gd.set("alignment", al.clone());
                }
                gd.loc = loc.clone();
                cr.rw.create_with(gd, &[], |b, g| {
                    b.add_region(g);
                });
                globals.push(g);
            }
        }
        let new = cr.rw.create_with(data, &[], |b, f| {
            b.add_region(f);
        });

        // The attributions' descriptors at the start of the old entry block.
        let mut ptrs = Vec::new();
        for i in 0..n_ptr {
            let v = cr.rw.body.insert_arg(entry, n_in + i, wg_ptr.clone(), loc.clone());
            ptrs.push(v);
        }
        cr.rw.set_start(entry);
        let n_proper = n_in + n_ptr;
        for (i, a) in wg.iter().enumerate() {
            let ptr = match ptrs.get(i) {
                Some(p) => *p,
                None => {
                    let ty: Type<'a> = LlvmType::Ptr(o.workgroup_space).into();
                    let addr = cr.build(OpData::build("llvm.mlir.addressof").with("global_name", Attribute::SymbolRef(vec![Cow::Owned(globals[i].clone())])), ty.clone());
                    let arr = LlvmType::array(a.elems as u64, a.elem.clone());
                    cr.build(OpData::build("llvm.getelementptr").operands(&[addr]).with("elem_type", Attribute::Type(arr)).with("rawConstantIndices", Attribute::dense_i32(&[0, 0])), ty)
                }
            };
            let Some(d) = a.descriptor(cr, o.llvm, ptr) else { return false };
            sig.conversion.remap_values(n_proper + i, vec![d]);
        }
        for (i, a) in private.iter().enumerate() {
            let n = cr.llvm_constant(Attribute::of_int(a.elems.into(), Type::int(64)), Type::int(64));
            let mut alloca = OpData::build("llvm.alloca").operands(&[n]).with("elem_type", Attribute::Type(a.elem.clone()));
            if let Some(al) = &private_align[i] {
                alloca.set("alignment", al.clone());
            }
            let p = cr.build(alloca, LlvmType::Ptr(o.alloca_space).into());
            let Some(d) = a.descriptor(cr, o.llvm, p) else { return false };
            sig.conversion.remap_values(n_proper + n_wg + i, vec![d]);
        }

        let (from, into) = (cr.rw.body[op].regions[0], cr.rw.body[new].regions[0]);
        cr.inline_region(from, into, None);
        let Some(conv) = cr.current else { return false };
        if cr.convert_region_types(into, conv, Some(&sig.conversion)).is_none() {
            return false;
        }
        Self::copy_arg_attrs(cr, new, &sig, &arg_attrs);
        cr.erase(op);
        true
    }

    /// The input argument attributes the lowered arguments keep (`copyAttribute` /
    /// `copyPointerAttribute`).
    fn copy_arg_attrs<'a>(cr: &mut Cr<'_, 'a, '_>, f: OpId, sig: &crate::LlvmSignature<'a>, arg_attrs: &[Vec<NamedAttr<'a>>]) {
        let types = sig.conversion.converted_types();
        let mut out: Vec<Vec<NamedAttr<'a>>> = vec![Vec::new(); types.len()];
        for (i, attrs) in arg_attrs.iter().enumerate() {
            let Some(&crate::InputMap::New { at, count }) = sig.conversion.mapping(i) else { continue };
            let is_ptr = |j: usize| matches!(LlvmType::try_from(&types[j]), Ok(LlvmType::Ptr(_)));
            let to_ptr = (at..at + count).any(is_ptr);
            for a in attrs {
                if COPIED.contains(&&*a.name) {
                    (at..at + count).for_each(|j| out[j].push(a.clone()));
                } else if to_ptr && POINTER_COPIED.contains(&&*a.name) && !(count > 1 && a.name == "llvm.noalias") {
                    (at..at + count).filter(|j| is_ptr(*j)).for_each(|j| out[j].push(a.clone()));
                }
            }
        }
        if out.iter().all(Vec::is_empty) {
            return;
        }
        let array = Attribute::Array(
            out.into_iter()
                .map(|mut d| {
                    d.sort_by(|x, y| x.name.cmp(&y.name));
                    Attribute::Dict(d)
                })
                .collect(),
        );
        cr.modify(f, |b| b[f].set("arg_attrs", array));
    }

    /// `GPUReturnOpLowering`.
    #[convert("gpu.return")]
    fn ret(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: GpuLlvmOptions) -> bool {
        cr.llvm_return(op, operands, o.llvm, o.llvm.bare_ptr)
    }

    /// MLIR's string escaping (`llvm::printEscapedString`) of raw bytes.
    fn escaped(bytes: &[u8]) -> String {
        let mut lit = String::with_capacity(bytes.len());
        for &b in bytes {
            match b {
                b'\\' => lit.push_str("\\\\"),
                b' '..=b'~' if b != b'"' => lit.push(b as char),
                b => lit.push_str(&format!("\\{b:02X}")),
            }
        }
        lit
    }

    /// `getOrCreateStringConstant`: a constant internal global of `bytes` and a NUL in
    /// address space `space`, reused when one holds them already.
    pub(crate) fn string_constant<'a>(cr: &mut Cr<'_, 'a, '_>, module: OpId, prefix: &str, bytes: &[u8], space: u32, loc: Option<mlirformat::Str<'a>>) -> (String, Type<'a>) {
        let mut data = bytes.to_vec();
        data.push(0);
        let ty = LlvmType::array(data.len() as u64, Type::int(8));
        let value = Attribute::Str { lit: Cow::Owned(Self::escaped(&data)), ty: None };
        let block = cr.rw.body.top_block(module);
        let space_attr = Attribute::of_int(space.into(), Type::int(32));
        let b = &*cr.rw.body;
        let found = b.ops(block).find(|g| {
            let g = &b[*g];
            g.name == "llvm.mlir.global" && g.get("global_type") == Some(&Attribute::Type(ty.clone())) && g.get("constant").is_some() && g.get("value") == Some(&value) && g.get("alignment").is_none_or(|a| a == &Attribute::of_int(0, Type::int(64))) && g.get("addr_space").map_or(space == 0, |a| a == &space_attr)
        });
        if let Some(g) = found {
            return (String::from(b.sym_name(g).unwrap_or("")), ty);
        }
        let name = (0..).map(|i| format!("{prefix}{i}")).find(|n| cr.rw.body.lookup(module, n).is_none()).unwrap_or_default();
        let saved = cr.rw.ip;
        cr.rw.set_start(block);
        let g = OpData { loc, ..OpData::build("llvm.mlir.global").flag("constant").with("global_type", Attribute::Type(ty.clone())).with("linkage", Attribute::dialect("llvm.linkage", "<internal>")).with("sym_name", Attribute::str(&name)).with("value", value).with("addr_space", space_attr) };
        cr.rw.create_with(g, &[], |b, g| {
            b.add_region(g);
        });
        cr.rw.ip = saved;
        (name, ty)
    }

    /// `GPUPrintfOpToLLVMCallLowering`: a call of the printf `o.printf` names on the format
    /// string's global and the arguments.
    #[convert("gpu.printf")]
    fn printf<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: GpuLlvmOptions) -> bool {
        let p = match o.printf {
            Some(Printf::Call(p)) => p,
            Some(Printf::VPrintf) => return Self::vprintf(cr, op, operands),
            Some(Printf::Hip) => return Self::hip_printf(cr, op, operands),
            None => return false,
        };
        let Some(module) = cr.module_of(op) else { return false };
        let Some(Attribute::Str { lit, .. }) = cr.rw.body[op].get("format") else { return false };
        let bytes = crate::unescape(lit);
        let ptr: Type<'a> = LlvmType::Ptr(p.space).into();
        let fty: Type<'a> = LlvmType::Func { ret: Type::int(32).into(), params: vec![ptr.clone()], vararg: true }.into();
        // `getOrDefineFunction`: an existing declaration whatever its type.
        let f = match cr.rw.body.lookup(module, p.name).filter(|f| cr.rw.body[*f].name == "llvm.func") {
            Some(f) => f,
            None => match cr.llvm_func(module, p.name, vec![ptr.clone()], Type::int(32), true) {
                Some(f) => f,
                None => return false,
            },
        };
        let callee_ty = match cr.rw.body[f].get("function_type") {
            Some(Attribute::Type(t)) => t.clone(),
            _ => fty,
        };
        cr.modify(f, |b| b[f].set("CConv", p.cconv.into()));
        let loc = cr.rw.body[op].loc.clone();
        let (global, arr) = Self::string_constant(cr, module, "printfFormat_", &bytes, p.space, loc);
        cr.rw.set_before(op);
        let addr = cr.build(OpData::build("llvm.mlir.addressof").with("global_name", Attribute::SymbolRef(vec![Cow::Owned(global)])), ptr.clone());
        let start = cr.build(OpData::build("llvm.getelementptr").operands(&[addr]).with("elem_type", Attribute::Type(arr)).with("rawConstantIndices", Attribute::dense_i32(&[0, 0])), ptr);
        let mut args = vec![start];
        args.extend(operands.iter().flatten().copied());
        let ret = match LlvmType::try_from(&callee_ty) {
            Ok(LlvmType::Func { ret, .. }) if !matches!(LlvmType::try_from(&*ret), Ok(LlvmType::Void)) => vec![*ret],
            _ => Vec::new(),
        };
        let call = cr.llvm_call(p.name, &args, &ret);
        cr.modify(call, |b| {
            b[call].set("CConv", p.cconv.into());
            b[call].set("var_callee_type", Attribute::Type(callee_ty));
        });
        cr.erase(op);
        true
    }

    /// `GPUPrintfOpToHIPLowering`: `__ockl_printf_begin`, the format string, then the arguments
    /// seven at a time, as `i64`s.
    fn hip_printf<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(module) = cr.module_of(op) else { return false };
        let Some(Attribute::Str { lit, .. }) = cr.rw.body[op].get("format") else { return false };
        let bytes = crate::unescape(lit);
        let args: Vec<ValueId> = operands.iter().flatten().copied().collect();
        let (i32t, i64t, ptr) = (Type::int(32), Type::int(64), LlvmType::ptr());
        let loc = cr.rw.body[op].loc.clone();
        let define = |cr: &mut Cr<'_, 'a, '_>, name: &str, params: Vec<Type<'a>>| -> bool {
            if cr.rw.body.lookup(module, name).is_some() {
                return true;
            }
            match cr.llvm_func(module, name, params, Type::int(64), false) {
                Some(f) => {
                    cr.rw.body[f].loc = loc.clone();
                    true
                }
                None => false,
            }
        };
        if !define(cr, "__ockl_printf_begin", vec![i64t.clone()]) {
            return false;
        }
        if !args.is_empty() {
            let mut p = vec![i64t.clone(), i32t.clone()];
            p.extend(core::iter::repeat_n(i64t.clone(), 7));
            p.push(i32t.clone());
            if !define(cr, "__ockl_printf_append_args", p) {
                return false;
            }
        }
        if !define(cr, "__ockl_printf_append_string_n", vec![i64t.clone(), ptr.clone(), i64t.clone(), i32t.clone()]) {
            return false;
        }
        cr.rw.set_before(op);
        fn c<'a>(cr: &mut Cr<'_, 'a, '_>, v: i64, t: &Type<'a>) -> ValueId {
            cr.llvm_constant(Attribute::of_int(v.into(), Type::int(t.bit_width().unwrap_or(64))), t.clone())
        }
        let zero64 = c(cr, 0, &i64t);
        let begin = cr.llvm_call("__ockl_printf_begin", &[zero64], &[i64t.clone()]);
        let mut desc = cr.rw.body[begin].results[0];
        let (global, arr) = Self::string_constant(cr, module, "printfFormat_", &bytes, 0, loc.clone());
        cr.rw.set_before(op);
        let addr = cr.build(OpData::build("llvm.mlir.addressof").with("global_name", Attribute::SymbolRef(vec![Cow::Owned(global)])), ptr.clone());
        let start = cr.build(OpData::build("llvm.getelementptr").operands(&[addr]).with("elem_type", Attribute::Type(arr)).with("rawConstantIndices", Attribute::dense_i32(&[0, 0])), ptr);
        let len = c(cr, bytes.len() as i64 + 1, &i64t);
        let one = c(cr, 1, &i32t);
        let zero = c(cr, 0, &i32t);
        let last = if args.is_empty() { one } else { zero };
        let call = cr.llvm_call("__ockl_printf_append_string_n", &[desc, start, len, last], &[i64t.clone()]);
        desc = cr.rw.body[call].results[0];
        for (g, chunk) in args.chunks(7).enumerate() {
            let n = c(cr, chunk.len() as i64, &i32t);
            let mut call_args = vec![desc, n];
            for a in chunk {
                let mut v = *a;
                let t = cr.rw.body[v].ty.clone();
                if let Type::Float(k) = t {
                    if k != mlirformat::FloatKind::F64 {
                        v = cr.build(OpData::build("llvm.fpext").operands(&[v]), Type::Float(mlirformat::FloatKind::F64));
                    }
                    v = cr.build(OpData::build("llvm.bitcast").operands(&[v]), i64t.clone());
                }
                if cr.rw.body[v].ty.bit_width() != Some(64) {
                    v = cr.build(OpData::build("llvm.zext").operands(&[v]), i64t.clone());
                }
                call_args.push(v);
            }
            call_args.extend(core::iter::repeat_n(zero64, 7 - chunk.len()));
            call_args.push(if (g + 1) * 7 >= args.len() { one } else { zero });
            let call = cr.llvm_call("__ockl_printf_append_args", &call_args, &[i64t.clone()]);
            desc = cr.rw.body[call].results[0];
        }
        cr.erase(op);
        true
    }

    /// `GPUPrintfOpToVPrintfLowering`.
    fn vprintf<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(module) = cr.module_of(op) else { return false };
        let Some(Attribute::Str { lit, .. }) = cr.rw.body[op].get("format") else { return false };
        let bytes = crate::unescape(lit);
        let ptr: Type<'a> = LlvmType::ptr();
        // `findInstanceOfOrUnknown<FileLineColLoc>`: debug info inside a function cannot be used outside it.
        let gloc: Option<mlirformat::Str<'a>> = Some(cr.rw.body[op].loc.as_deref().and_then(crate::file_line_col).unwrap_or_else(|| String::from("unknown")).into());
        if cr.rw.body.lookup(module, "vprintf").is_none() {
            let Some(f) = cr.llvm_func(module, "vprintf", vec![ptr.clone(), ptr.clone()], Type::int(32), false) else { return false };
            cr.rw.body[f].loc = gloc.clone();
        }
        let (global, arr) = Self::string_constant(cr, module, "printfFormat_", &bytes, 0, gloc);
        cr.rw.set_before(op);
        let addr = cr.build(OpData::build("llvm.mlir.addressof").with("global_name", Attribute::SymbolRef(vec![Cow::Owned(global)])), ptr.clone());
        let start = cr.build(OpData::build("llvm.getelementptr").operands(&[addr]).with("elem_type", Attribute::Type(arr)).with("rawConstantIndices", Attribute::dense_i32(&[0, 0])), ptr.clone());
        let mut types = Vec::new();
        let mut args = Vec::new();
        for v in operands.iter().flatten().copied() {
            let ty = cr.rw.body[v].ty.clone();
            if matches!(ty, Type::Float(_)) {
                let f64t = Type::Float(mlirformat::FloatKind::F64);
                args.push(cr.build(OpData::build("llvm.fpext").operands(&[v]), f64t.clone()));
                types.push(f64t);
            } else {
                args.push(v);
                types.push(ty);
            }
        }
        let st = LlvmType::literal(types);
        let one = cr.llvm_constant(Attribute::index(1), Type::int(64));
        let alloc = cr.build(OpData::build("llvm.alloca").operands(&[one]).with("elem_type", Attribute::Type(st.clone())), ptr.clone());
        for (i, a) in args.into_iter().enumerate() {
            let p = cr.build(OpData::build("llvm.getelementptr").operands(&[alloc]).with("elem_type", Attribute::Type(st.clone())).with("rawConstantIndices", Attribute::dense_i32(&[0, i as i32])), ptr.clone());
            cr.rw.create(OpData::build("llvm.store").operands(&[a, p]).with("ordering", Attribute::i64(0)), &[]);
        }
        cr.llvm_call("vprintf", &[start, alloc], &[Type::int(32)]);
        cr.erase(op);
        true
    }
}
