use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::spirv_types::{SpirvMember, SpirvType};
use mlirformat::{Attribute, Error, FunctionType, ShapedKind, Type};

use super::{EnumSpec, TargetEnv};
use crate::{Body, OpData, OpId};

pub struct VulkanLayout;

impl VulkanLayout {
    pub fn decorate<'a>(t: &Type<'a>) -> Option<(Type<'a>, u64, u64)> {
        if TargetEnv::is_scalar(t) {
            let w = u64::from(t.bit_width()?);
            let a = if w == 1 { 1 } else { w / 8 };
            return Some((t.clone(), a, a));
        }
        if let Type::Shaped(s) = t
            && s.kind == ShapedKind::Vector
        {
            let n = t.element_count()? as u64;
            let (e, size, align) = Self::decorate(&s.elem)?;
            return Some((Type::vector(&[n as i64], &[false], e), size * n, if n == 2 { align * 2 } else { align * 4 }));
        }
        match SpirvType::try_from(t).ok()? {
            SpirvType::Struct { name: None, members: Some(ms), .. } if ms.is_empty() => Some((t.clone(), 0, 1)),
            SpirvType::Struct { name: None, members: Some(ms), .. } => {
                let (mut at, mut align) = (0u64, 1u64);
                let mut out = Vec::new();
                for m in &ms {
                    let (mt, size, a) = Self::decorate(&m.ty)?;
                    at = at.div_ceil(a) * a;
                    out.push(SpirvMember { ty: mt, offset: Some(at as u32), decorations: m.decorations.clone() });
                    at = at.saturating_add(size);
                    align = align.max(a);
                }
                let st = SpirvType::Struct { name: None, members: Some(out), decorations: Vec::new() };
                Some((st.into(), at.div_ceil(align) * align, align))
            }
            SpirvType::Array { len, elem, .. } => {
                let (e, size, a) = Self::decorate(&elem)?;
                Some((SpirvType::array(len, e, size as u32), size * u64::from(len), a))
            }
            SpirvType::RuntimeArray { elem, .. } => {
                let (e, size, a) = Self::decorate(&elem)?;
                Some((SpirvType::rtarray(e, size as u32), u64::MAX, a))
            }
            SpirvType::Matrix { cols, column } => {
                let rows = column.element_count()? as u64;
                let (_, es, a) = Self::decorate(column.element_type())?;
                Some((t.clone(), es * rows * u64::from(cols), a))
            }
            _ => None,
        }
    }
}

#[derive(Default)]
struct EntryAbi {
    workgroup_size: Option<Vec<i64>>,
    subgroup_size: Option<i64>,
    target_width: Option<i64>,
}

impl EntryAbi {
    fn parse(a: &Attribute<'_>) -> Self {
        let text = format!("{a}");
        let field = |n: &str| text.split(n).nth(1).map(|r| String::from(r.trim_start_matches([' ', '='])));
        let int = |n: &str| field(n).and_then(|r| r.split(|c: char| !c.is_ascii_digit() && c != '-').next()?.parse().ok());
        let workgroup_size = field("workgroup_size").and_then(|r| r.strip_prefix('[')?.split(']').next().map(|l| l.split(',').filter_map(|x| x.trim().parse().ok()).collect()));
        Self { workgroup_size, subgroup_size: int("subgroup_size"), target_width: int("target_width") }
    }

    fn attr<'a>(&self) -> Option<Attribute<'a>> {
        let mut parts = Vec::new();
        if let Some(w) = &self.workgroup_size {
            parts.push(format!("workgroup_size = [{}]", w.iter().map(|x| format!("{x}")).collect::<Vec<_>>().join(", ")));
        }
        parts.extend(self.subgroup_size.map(|s| format!("subgroup_size = {s}")));
        parts.extend(self.target_width.map(|s| format!("target_width = {s}")));
        (!parts.is_empty()).then(|| Attribute::dialect("spirv.entry_point_abi", &format!("<{}>", parts.join(", "))))
    }
}

pub(crate) struct Abi;

impl Abi {
    fn int_attr<'a>(v: i64) -> Attribute<'a> {
        Attribute::integer(i128::from(v), Type::int(32))
    }

    fn interface_var(a: &Attribute<'_>) -> Option<(i64, i64, Option<String>)> {
        let text = format!("{a}");
        let (nums, rest) = text.split_once('(')?.1.split_once(')')?;
        let (set, binding) = nums.split_once(',')?;
        let sc = rest.trim_start_matches([',', ' ']).trim_end_matches('>').trim();
        Some((set.trim().parse().ok()?, binding.trim().parse().ok()?, (!sc.is_empty()).then(|| String::from(sc))))
    }

    fn arg_abi<'a>(body: &Body<'a>, f: OpId, i: usize) -> Option<Attribute<'a>> {
        let Some(Attribute::Array(ds)) = body[f].get("arg_attrs") else { return None };
        let Some(Attribute::Dict(d)) = ds.get(i) else { return None };
        d.iter().find(|e| e.name == "spirv.interface_var_abi").and_then(|e| e.value.clone())
    }

    fn scalar_or_vector(t: &Type<'_>) -> bool {
        TargetEnv::is_scalar(t) || TargetEnv::is_valid_vector(t)
    }

    fn global<'a>(body: &mut Body<'a>, f: OpId, i: usize, arg_ty: &Type<'a>, abi: &Attribute<'a>) -> Option<OpId> {
        let (set, binding, sc) = Self::interface_var(abi)?;
        let name = format!("{}_arg_{i}", super::lower::symbol_text(body[f].get("sym_name")?)?);
        let ptr = if Self::scalar_or_vector(arg_ty) {
            let st = SpirvType::Struct { name: None, members: Some(vec![SpirvMember { ty: arg_ty.clone(), offset: None, decorations: Vec::new() }]), decorations: Vec::new() };
            SpirvType::ptr(st.into(), &sc?)
        } else {
            arg_ty.clone()
        };
        let Ok(SpirvType::Ptr { pointee, storage }) = SpirvType::try_from(&ptr) else { return None };
        let ty = if matches!(SpirvType::try_from(&*pointee), Ok(SpirvType::SampledImage(_))) { ptr } else { SpirvType::ptr(VulkanLayout::decorate(&pointee)?.0, &storage) };
        let data = OpData::build("spirv.GlobalVariable").with("binding", Self::int_attr(binding)).with("descriptor_set", Self::int_attr(set)).with("sym_name", Attribute::str(&name)).with("type", Attribute::Type(ty));
        let g = body.create(data, &[]);
        body.insert_before(g, f);
        Some(g)
    }

    pub(crate) fn interface_vars(body: &mut Body<'_>, f: OpId) -> Result<(), Error> {
        let Some(Attribute::Type(Type::Function(fty))) = body[f].get("function_type").cloned() else { return Err(Error(String::from("spirv.func without a type"))) };
        let abis: Vec<_> = (0..fty.inputs.len()).map(|i| Self::arg_abi(body, f, i)).collect();
        if abis.iter().any(Option::is_none) {
            return if abis.iter().any(Option::is_some) { Err(Error(String::from("failed to legalize operation 'spirv.func'"))) } else { Ok(()) };
        }
        let entry = body[body[f].regions[0]].blocks[0];
        let mut at = body.first_op(entry);
        let place = |body: &mut Body<'_>, o: OpId, at: Option<OpId>| match at {
            Some(b) => body.insert_before(o, b),
            None => body.insert(o, entry, None),
        };
        let args = body[entry].args.clone();
        for (i, (t, abi)) in fty.inputs.iter().zip(abis).enumerate() {
            let g = Self::global(body, f, i, t, &abi.expect("checked")).ok_or_else(|| Error(String::from("failed to legalize operation 'spirv.func'")))?;
            let (Some(Attribute::Type(gt)), Some(name)) = (body[g].get("type").cloned(), body[g].get("sym_name").and_then(super::lower::symbol_text)) else { unreachable!() };
            let addr = body.create(OpData::build("spirv.mlir.addressof").with("variable", Attribute::SymbolRef(vec![name.into()])), core::slice::from_ref(&gt));
            place(body, addr, at);
            let mut repl = body[addr].results[0];
            if Self::scalar_or_vector(t) {
                let zero = body.create(OpData::build("spirv.Constant").with("value", Self::int_attr(0)), &[Type::int(32)]);
                place(body, zero, at);
                let Ok(SpirvType::Ptr { storage, .. }) = SpirvType::try_from(&gt) else { unreachable!() };
                let ac = body.create(OpData::build("spirv.AccessChain").operands(&[repl, body[zero].results[0]]), &[SpirvType::ptr(t.clone(), &storage)]);
                place(body, ac, at);
                let ld = body.create(OpData::build("spirv.Load").operands(&[body[ac].results[0]]), core::slice::from_ref(t));
                place(body, ld, at);
                repl = body[ld].results[0];
            }
            if body[repl].ty != *t && !body[args[i]].uses.is_empty() {
                let bc = body.create(OpData::build("spirv.Bitcast").operands(&[repl]), core::slice::from_ref(t));
                let def = body.def_op(repl).expect("defined");
                let next = body.next_op(def);
                place(body, bc, next);
                repl = body[bc].results[0];
            }
            body.replace_all_uses(args[i], repl);
            at = body.next_op(body.def_op(repl).expect("defined"));
        }
        for i in (0..body[entry].args.len()).rev() {
            body.erase_arg(entry, i);
        }
        body[f].set("function_type", Attribute::Type(Type::Function(alloc::boxed::Box::new(FunctionType { inputs: Vec::new(), results: Vec::new() }))));
        body[f].remove("arg_attrs");

        Ok(())
    }

    pub(crate) fn graph_vars(body: &mut Body<'_>, g: OpId) -> Result<(), Error> {
        let failed = || Error(String::from("failed to legalize operation 'spirv.ARM.Graph'"));
        fn abis<'a>(body: &Body<'a>, g: OpId, key: &str) -> Vec<Option<Attribute<'a>>> {
            match body[g].get(key) {
                Some(Attribute::Array(ds)) => ds.iter().map(|d| match d {
                    Attribute::Dict(d) => d.iter().find(|e| e.name == "spirv.interface_var_abi").and_then(|e| e.value.clone()),
                    _ => None,
                }).collect(),
                _ => Vec::new(),
            }
        }
        let Some(Attribute::Type(Type::Function(fty))) = body[g].get("function_type").cloned() else { return Err(failed()) };
        let (args, results) = (abis(body, g, "arg_attrs"), abis(body, g, "res_attrs"));
        if args.iter().chain(&results).all(Option::is_none) {
            return Ok(());
        }
        if !matches!(body[g].get("entry_point"), Some(Attribute::Bool(true))) {
            return Err(failed());
        }
        let name = body[g].get("sym_name").and_then(super::lower::symbol_text).ok_or_else(failed)?;
        let mut vars = Vec::new();
        for (kind, types, abis) in [("arg", &fty.inputs, &args), ("res", &fty.results, &results)] {
            for (i, t) in types.iter().enumerate() {
                let abi = abis.get(i).cloned().flatten().ok_or_else(failed)?;
                let (set, binding, sc) = Self::interface_var(&abi).ok_or_else(failed)?;
                let var = format!("{name}_{kind}_{i}");
                let ty = SpirvType::ptr(t.clone(), sc.as_deref().unwrap_or("UniformConstant"));
                let data = OpData::build("spirv.GlobalVariable").with("binding", Self::int_attr(binding)).with("descriptor_set", Self::int_attr(set)).with("sym_name", Attribute::str(&var)).with("type", Attribute::Type(ty));
                let o = body.create(data, &[]);
                body.insert_before(o, g);
                vars.push(Attribute::SymbolRef(vec![var.into()]));
            }
        }
        body[g].remove("arg_attrs");
        body[g].remove("res_attrs");
        let ep = body.create(OpData::build("spirv.ARM.GraphEntryPoint").with("fn", Attribute::SymbolRef(vec![name.into()])).with("interface", Attribute::Array(vars)), &[]);
        body.insert_before(ep, g);
        Ok(())
    }

    pub(crate) fn entry_point(body: &mut Body<'_>, module: OpId, f: OpId, env: &TargetEnv) -> Result<(), Error> {
        let Some(attr) = body[f].get("spirv.entry_point_abi").cloned() else { return Ok(()) };
        let mut abi = EntryAbi::parse(&attr);
        let name = super::lower::symbol_text(body[f].get("sym_name").expect("named")).expect("a name");
        let block = body.top_block(module);
        let mut vars: Vec<String> = Vec::new();
        for o in body.ops_in(f) {
            if body[o].name != "spirv.mlir.addressof" {
                continue;
            }
            let Some(v) = body[o].get("variable").and_then(super::lower::symbol_text) else { continue };
            let storage = body.block_ops(block).iter().find(|g| body[**g].get("sym_name").and_then(super::lower::symbol_text).as_deref() == Some(&v)).and_then(|g| match body[*g].get("type") {
                Some(Attribute::Type(t)) => match SpirvType::try_from(t) {
                    Ok(SpirvType::Ptr { storage, .. }) => Some(storage),
                    _ => None,
                },
                _ => None,
            });
            if (env.version >= 4 || matches!(storage.as_deref(), Some("Input" | "Output"))) && !vars.contains(&v) {
                vars.push(v);
            }
        }
        let model = env.given_caps.iter().find_map(|c| match &**c {
            "Kernel" => Some("Kernel"),
            "Shader" => Some("GLCompute"),
            _ => None,
        });
        let Some(model) = model else { return Err(Error(String::from("lower entry point failure: could not select execution model based on 'spirv.target_env'"))) };
        let sym = |n: &str| Attribute::SymbolRef(vec![String::from(n).into()]);
        let ep = OpData::build("spirv.EntryPoint").with("execution_model", Attribute::dialect("spirv.execution_model", &format!("<{model}>"))).with("fn", sym(&name)).with("interface", Attribute::Array(vars.iter().map(|v| sym(v)).collect()));
        let o = body.create(ep, &[]);
        body.insert(o, block, None);
        let mode_allowed = |m: &str| EnumSpec::of("ExecutionMode").and_then(|e| e.case(m)).is_none_or(|c| c.avail.caps.iter().all(|ors| ors.iter().any(|x| env.allows_cap(x))));
        let mode = |body: &mut Body<'_>, m: &str, values: Vec<i64>| {
            let d = OpData::build("spirv.ExecutionMode").with("execution_mode", Attribute::dialect("spirv.execution_mode", &format!("<{m}>"))).with("fn", sym(&name)).with("values", Attribute::Array(values.into_iter().map(Self::int_attr).collect()));
            let o = body.create(d, &[]);
            body.insert(o, block, None);
        };
        if let Some(w) = abi.workgroup_size.clone()
            && mode_allowed("LocalSize")
        {
            mode(body, "LocalSize", w);
            abi.workgroup_size = None;
        }
        if let Some(s) = abi.subgroup_size
            && mode_allowed("SubgroupSize")
        {
            mode(body, "SubgroupSize", vec![s]);
            abi.subgroup_size = None;
        }
        if let Some(t) = abi.target_width
            && mode_allowed("SignedZeroInfNanPreserve")
        {
            mode(body, "SignedZeroInfNanPreserve", vec![t]);
            abi.target_width = None;
        }
        match abi.attr() {
            Some(a) => body[f].set("spirv.entry_point_abi", a),
            None => {
                body[f].remove("spirv.entry_point_abi");
            }
        }
        Ok(())
    }
}
