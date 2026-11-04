//! `gpu-kernel-outlining`.

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;
use mlirformat::{Attribute, Error};
use crate::{Body, Mapping, OpData, OpId, Trait};

/// `gpu-kernel-outlining`.
#[crate::pass("gpu-kernel-outlining", on = "builtin.module")]
pub struct GpuKernelOutlining {
    #[opt("data-layout-str")]
    data_layout: String,
}

impl GpuKernelOutlining {
    /// A `#dlti.dl_spec` as MLIR prints it: each `#dlti.dl_entry<key, value>` as
    /// `key = value`, the value printed back.
    fn canonical_dl_spec(text: &str) -> String {
        let Some(inner) = text.trim().strip_prefix("#dlti.dl_spec<").and_then(|t| t.strip_suffix('>')) else { return String::from(text) };
        let mut entries = Vec::new();
        let mut rest = inner.trim();
        while let Some(e) = rest.strip_prefix("#dlti.dl_entry<") {
            let (mut depth, mut end) = (1, e.len());
            for (i, c) in e.char_indices() {
                depth += match c {
                    '<' | '(' | '[' => 1,
                    '>' | ')' | ']' => -1,
                    _ => 0,
                };
                if depth == 0 {
                    end = i;
                    break;
                }
            }
            let Some((k, v)) = e[..end].split_once(',') else { return String::from(text) };
            let value = mlirformat::Parser::read(v.trim(), |p| p.attr()).map(|a| format!("{a}")).unwrap_or_else(|_| String::from(v.trim()));
            entries.push(format!("{} = {value}", k.trim()));
            rest = e[(end + 1).min(e.len())..].trim_start_matches([',', ' ']);
        }
        if !rest.is_empty() || entries.is_empty() {
            return String::from(text);
        }
        format!("#dlti.dl_spec<{}>", entries.join(", "))
    }
}

impl crate::Run for GpuKernelOutlining {
    fn run<'a>(&self, body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
        let layout = if self.data_layout.is_empty() {
            None
        } else {
            let text = Self::canonical_dl_spec(&self.data_layout);
            Some(mlirformat::Parser::read(&text, |p| p.attr()).map_err(|e| Error(format!("{e}")))?.owned())
        };
        let top = body.top_block(module);
        let mut modified = false;
        for f in body[top].ops.clone() {
            if !body.has(f, Trait::SymbolOpInterface) {
                continue;
            }
            let at = body[top].ops.get(body.position(f) + 1).copied();
            let mut launches = Vec::new();
            body.walk_post(f, &mut |o| {
                if body[o].name == "gpu.launch" {
                    launches.push(o);
                }
            });
            for l in launches {
                let sym = |a: Option<&Attribute<'_>>| match a {
                    Some(Attribute::SymbolRef(p)) => p.last().map(|s| String::from(&**s)),
                    _ => None,
                };
                let name = sym(body[l].get("function")).unwrap_or_else(|| {
                    let mut p = body.parent_op(l);
                    while let Some(o) = p.filter(|o| !body.has(*o, Trait::SymbolOpInterface)) {
                        p = body.parent_op(o);
                    }
                    format!("{}_kernel", p.and_then(|o| body.sym_name(o)).unwrap_or(""))
                });
                let (func, operands) = body.outline_kernel(l, &name);
                // `createKernelModule`: an existing module of the launch's `module`, else a new
                // one named after the kernel; with the symbols the kernel references.
                let wanted = sym(body[l].get("module"));
                let existing = wanted.as_deref().and_then(|m| body.lookup(module, m)).filter(|o| body[*o].name == "gpu.module");
                let kmod = existing.unwrap_or_else(|| {
                    let mut d = OpData::build("gpu.module").with("sym_name", Attribute::str(wanted.as_deref().unwrap_or(&name)));
                    d.loc = body[func].loc.clone();
                    let m = body.create(d, &[]);
                    let r = body.add_region(m);
                    body.add_block(r, &[]);
                    m
                });
                if let Some(dl) = &layout {
                    body[kmod].set("dlti.dl_spec", dl.clone());
                }
                let fname = body.unique_symbol(kmod, &name, None);
                body[func].set("sym_name", Attribute::str(&fname));
                let kblock = body.top_block(kmod);
                body.insert(func, kblock, None);
                let mut work = vec![func];
                while let Some(o) = work.pop() {
                    for u in body.symbol_uses(o).unwrap_or_default() {
                        let Some(leaf) = u.path.last().map(|s| String::from(&**s)) else { continue };
                        if body.lookup(kmod, &leaf).is_some() {
                            continue;
                        }
                        let Some(def) = body.lookup(module, &leaf) else { continue };
                        let c = body.clone_op(def, &mut Mapping::default());
                        body.insert(c, kblock, None);
                        work.push(c);
                    }
                }
                if existing.is_none() {
                    let mname = body.unique_symbol(module, &String::from(body.sym_name(kmod).unwrap_or_default()), Some(kmod));
                    body[kmod].set("sym_name", Attribute::str(&mname));
                    match at {
                        Some(a) => body.insert_before(kmod, a),
                        None => body.insert(kmod, top, None),
                    }
                }
                let mname = String::from(body.sym_name(kmod).unwrap_or_default());
                body.launch_func(l, &mname, &fname, &operands);
                modified = true;
            }
        }
        if modified {
            body[module].attributes.retain(|a| a.name != "gpu.container_module");
            body[module].attributes.push(mlirformat::NamedAttr { name: "gpu.container_module".into(), value: None });
        }
        Ok(())
    }
}
