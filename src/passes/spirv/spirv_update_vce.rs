//! `spirv-update-vce`.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use mlirformat::{Attribute, Error, Type};
use crate::{EnumSpec, Needs, OpSpec, TargetEnv};
use crate::{Body, OpId};

/// `spirv-update-vce`: the minimal version, capabilities and extensions the module needs.
#[crate::pass("spirv-update-vce", on = "spirv.module")]
pub fn spirv_update_vce<'a>(body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
    let env = TargetEnv::find(body, module).ok_or_else(|| Error(String::from("missing 'spirv.target_env' attribute")))?;
    let mut version = 0u8;
    let (mut caps, mut exts): (Vec<String>, Vec<String>) = (Vec::new(), Vec::new());
    let mut order = Vec::new();
    body.walk_post(module, &mut |o| order.push(o));
    let pick = |name: &str, needs: &Needs, caps: bool, out: &mut Vec<String>| -> Result<(), Error> {
        for ors in needs {
            let chosen = if caps { env.first_cap(ors) } else { env.first_ext(ors) };
            let Some(c) = chosen else {
                return Err(Error(format!("'{name}' requires at least one {} in [{}] but none allowed in target environment", if caps { "capability" } else { "extension" }, ors.join(", "))));
            };
            if !out.contains(c) {
                out.push(c.clone());
            }
        }
        Ok(())
    };
    for o in order {
        let name = String::from(&*body[o].name);
        if let Some(spec) = OpSpec::of(&name) {
            let (lo, _, c, e) = TargetEnv::op_needs(body, o, spec);
            if let Some(v) = lo {
                version = version.max(v);
                if version > env.version {
                    return Err(Error(format!("'{name}' requires min version v1.{version} but target environment allows up to v1.{}", env.version)));
                }
            }
            pick(&name, &e, false, &mut exts)?;
            pick(&name, &c, true, &mut caps)?;
        }
        let d = &body[o];
        // `bind(set, binding)` needs Shader; linkage attributes their linkage type's needs.
        if name == "spirv.GlobalVariable" && (d.get("binding").is_some() || d.get("descriptor_set").is_some()) {
            pick(&name, &alloc::vec![alloc::vec![String::from("Shader")]], true, &mut caps)?;
        }
        if matches!(&*name, "spirv.GlobalVariable" | "spirv.func")
            && let Some(Attribute::Extended { ext, .. }) = d.get("linkage_attributes")
            && let Some(kind) = ext.body.as_deref().and_then(|b| b.split("linkage_type = <").nth(1)).and_then(|r| r.split('>').next())
            && let Some(case) = EnumSpec::of("LinkageType").and_then(|e| e.case(kind.trim()))
        {
            let to_needs = |groups: &[&[&str]]| -> Needs { groups.iter().map(|g| g.iter().map(|c| String::from(*c)).collect()).collect() };
            pick(&name, &to_needs(case.avail.caps), true, &mut caps)?;
            pick(&name, &to_needs(case.avail.exts), false, &mut exts)?;
        }
        let mut types: Vec<Type<'_>> = d.operands.iter().chain(&d.results).map(|v| body[*v].ty.clone()).collect();
        if name == "spirv.GlobalVariable"
            && let Some(Attribute::Type(t)) = d.get("type")
        {
            types.push(t.clone());
        }
        // `FunctionOpInterface` ops (`spirv.func`, `spirv.ARM.Graph`): their signature.
        if let Some(Attribute::Type(Type::Function(f))) = d.get("function_type")
        {
            types.extend(f.inputs.iter().chain(&f.results).cloned());
        }
        for t in &types {
            let (mut c, mut e) = (Needs::new(), Needs::new());
            TargetEnv::type_needs(t, None, &mut c, &mut e);
            pick(&name, &e, false, &mut exts)?;
            pick(&name, &c, true, &mut caps)?;
        }
    }
    let mut implied = Vec::new();
    for c in &caps {
        for i in TargetEnv::implied(c) {
            if !implied.contains(&i) {
                implied.push(i);
            }
        }
    }
    for i in implied {
        if !caps.contains(&i) {
            caps.push(i);
        }
    }
    for c in &caps {
        if let Some(v) = EnumSpec::of("Capability").and_then(|e| e.case(c)).and_then(|c| c.avail.min) {
            version = version.max(v);
            if version > env.version {
                return Err(Error(format!("Capability '{c}' requires min version v1.{version} but target environment allows up to v1.{}", env.version)));
            }
        }
    }
    let vce = Attribute::dialect("spirv.vce", &format!("<v1.{version}, [{}], [{}]>", caps.join(", "), exts.join(", ")));
    body[module].set("vce_triple", vce);
    Ok(())
}
