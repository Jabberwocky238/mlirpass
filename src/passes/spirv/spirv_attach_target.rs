//! `spirv-attach-target`.

use crate::{Regex};
use alloc::format;
use alloc::vec::Vec;
use mlirformat::{Attribute, Error};
use crate::{Body, OpId};

/// `spirv-attach-target`: a `#spirv.target_env` appended to the `targets` of each
/// `gpu.module` whose name `module` matches.
#[crate::pass("spirv-attach-target")]
pub struct SpirvAttachTarget {
    #[opt("module")]
    module: alloc::string::String,
    #[opt("ver", default = alloc::string::String::from("v1.0"))]
    ver: alloc::string::String,
    #[opt("caps")]
    caps: Vec<alloc::string::String>,
    #[opt("exts")]
    exts: Vec<alloc::string::String>,
    #[opt("client_api", default = alloc::string::String::from("Unknown"))]
    client_api: alloc::string::String,
    #[opt("vendor", default = alloc::string::String::from("Unknown"))]
    vendor: alloc::string::String,
    #[opt("device_type", default = alloc::string::String::from("Unknown"))]
    device_type: alloc::string::String,
    #[opt("device_id", default = -1)]
    device_id: i64,
}

impl crate::Run for SpirvAttachTarget {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let known = |class: &str, name: &str| crate::EnumSpec::of(class).is_some_and(|e| e.value(name).is_some());
        let fail = || Error(alloc::string::String::from("spirv-attach-target: invalid option"));
        for (class, v) in [("Version", &self.ver), ("ClientAPI", &self.client_api), ("Vendor", &self.vendor), ("DeviceType", &self.device_type)] {
            if !known(class, v) {
                return Err(fail());
            }
        }
        let caps: Vec<&str> = self.caps.iter().map(|c| &**c).filter(|c| known("Capability", c)).collect();
        let exts: Vec<&str> = self.exts.iter().map(|c| &**c).filter(|c| known("Extension", c)).collect();
        let mut text = format!("<#spirv.vce<{}, [{}], [{}]>, ", self.ver, caps.join(", "), exts.join(", "));
        if self.client_api != "Unknown" {
            text += &format!("{}, ", self.client_api);
        }
        if self.vendor != "Unknown" {
            text += &format!("{}:{}", self.vendor, self.device_type);
            if self.device_id >= 0 {
                text += &format!(":{}", self.device_id);
            }
            text += ", ";
        }
        text += "#spirv.resource_limits<>>";
        let target = Attribute::dialect("spirv.target_env", &text);
        let matcher = Regex(self.module.as_bytes());
        let mut modules = Vec::new();
        body.walk(op, &mut |o| {
            if body[o].name == "gpu.module" {
                modules.push(o);
            }
        });
        for m in modules {
            let name = body[m].get("sym_name").and_then(crate::spirv_symbol_text).unwrap_or_default();
            if !self.module.is_empty() && !matcher.search(&name) {
                continue;
            }
            let mut targets = match body[m].get("targets") {
                Some(Attribute::Array(ts)) => ts.clone(),
                _ => Vec::new(),
            };
            targets.push(target.clone());
            targets.dedup();
            body[m].set("targets", Attribute::Array(targets));
        }
        Ok(())
    }
}
