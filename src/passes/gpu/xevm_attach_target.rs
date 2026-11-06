//! `xevm-attach-target`.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error};

use crate::{Body, OpId, Regex};

/// `xevm-attach-target`: an `#xevm.target` appended to the `targets` of each `gpu.module`
/// directly in the op's regions whose name `module` matches.
#[crate::pass("xevm-attach-target")]
pub struct XevmAttachTarget {
    #[opt("module")]
    module: String,
    #[opt("triple", default = String::from("spirv64-unknown-unknown"))]
    triple: String,
    #[opt("chip", default = String::from("bmg"))]
    chip: String,
    #[opt("O", default = 2)]
    opt_level: i64,
    #[opt("l")]
    libs: Vec<String>,
    #[opt("cmd-options")]
    cmd_options: String,
}

impl XevmAttachTarget {
    /// `XeVMTargetAttr`'s `struct(...)` form: the parameters that are not their defaults.
    fn target(&self) -> Attribute<'static> {
        let quoted = |s: &str| format!("\"{}\"", s.replace('\\', "\\\\").replace('"', "\\\""));
        let mut params = Vec::new();
        if self.opt_level != 2 {
            params.push(format!("O = {}", self.opt_level));
        }
        if self.triple != "spirv64-unknown-unknown" {
            params.push(format!("triple = {}", quoted(&self.triple)));
        }
        if self.chip != "bmg" {
            params.push(format!("chip = {}", quoted(&self.chip)));
        }
        // `gpu::TargetOptions::tokenizeCmdOptions`: whitespace-separated words.
        let words: Vec<String> = self.cmd_options.split_whitespace().map(quoted).collect();
        if !words.is_empty() {
            params.push(format!("flags = {{\"cmd-options\" = [{}]}}", words.join(", ")));
        }
        if !self.libs.is_empty() {
            params.push(format!("linkFiles = [{}]", self.libs.iter().map(|l| quoted(l)).collect::<Vec<_>>().join(", ")));
        }
        let body = if params.is_empty() { String::new() } else { format!("<{}>", params.join(", ")) };
        Attribute::dialect("xevm.target", &body)
    }
}

impl crate::Run for XevmAttachTarget {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let target = self.target();
        let matcher = Regex(self.module.as_bytes());
        let mut modules = Vec::new();
        for r in body[op].regions.clone() {
            for b in body[r].blocks.clone() {
                modules.extend(body.ops(b).filter(|o| body[*o].name == "gpu.module"));
            }
        }
        for m in modules {
            let name = body.sym_name(m).map(String::from).unwrap_or_default();
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
