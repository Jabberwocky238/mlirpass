//! `gpu-module-to-binary`: each `gpu.module` with targets ⇒ a `gpu.binary` of one `#gpu.object` per target.
//!
//! A `#spirv.target_env` serializes the module's `spirv.module` (`SPIRVTarget::serializeToObject`). A module whose
//! kernels are machine code already (`rdna2.kernel`, `agx.kernel`, `xe3.kernel`: lowered by `convert-gpu-to-<isa>`
//! and allocated) is encoded here without LLVM: its object's bytes are the kernels one after another (each at its
//! alignment, its padding after it),
//! `properties` each kernel's offset, size and what the driver needs to run it. Anything else needs LLVM (NVVM, ROCDL
//! from LLVM IR, XeVM) and is refused.

use alloc::borrow::ToOwned;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Extended};

use crate::{Body, OpData, OpId, Quiet, Rewriter, Run, escape};

/// `gpu::CompilationTarget`: what an object holds.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Default)]
pub enum CompilationFormat {
    Offloading,
    Assembly,
    Binary,
    #[default]
    Fatbin,
    Llvm,
}

impl core::str::FromStr for CompilationFormat {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, ()> {
        Ok(match s {
            "llvm" => Self::Llvm,
            "offloading" => Self::Offloading,
            "assembly" | "isa" => Self::Assembly,
            "binary" | "bin" => Self::Binary,
            "fatbin" => Self::Fatbin,
            _ => return Err(()),
        })
    }
}

/// `gpu-module-to-binary`.
#[crate::pass("gpu-module-to-binary", extra = ["toolkit", "l", "opts", "section"])]
pub struct GpuModuleToBinary {
    #[opt("format", default = CompilationFormat::Fatbin, from_str)]
    #[cfg_attr(not(any(feature = "target.spirv", feature = "target.rdna2", feature = "target.agx", feature = "target.xe3")), allow(dead_code, reason = "no target that emits here"))]
    format: CompilationFormat,
}

impl Run for GpuModuleToBinary {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let top = body.top_block(op);
        let modules: Vec<OpId> = body.ops(top).filter(|m| body[*m].name == "gpu.module").collect();
        for m in modules {
            let name = body[m].get("sym_name").cloned().ok_or_else(|| Error("gpu.module without a name".to_owned()))?;
            let targets = match body[m].get("targets") {
                Some(Attribute::Array(t)) if !t.is_empty() => t.clone(),
                _ => return Err(Error("the module has no target attributes".to_owned())),
            };
            let mut objects = Vec::new();
            for t in &targets {
                objects.push(self.object(body, m, t)?);
            }
            let mut quiet = Quiet;
            let mut rw = Rewriter::new(body, &mut quiet);
            rw.set_before(m);
            let mut data = OpData::build("gpu.binary");
            data.set("sym_name", name);
            data.set("objects", Attribute::Array(objects));
            data.set("offloadingHandler", Attribute::Extended { ext: Extended { name: String::from("gpu.select_object").into(), body: None, params: Vec::new() }, ty: None });
            rw.create(data, &[]);
            rw.erase_op(m);
        }
        Ok(())
    }
}

impl GpuModuleToBinary {
    /// Module `m`'s object for target `t`.
    fn object<'a>(&self, body: &Body<'a>, m: OpId, t: &Attribute<'a>) -> Result<Attribute<'a>, Error> {
        let inner: Vec<OpId> = body.ops(body.top_block(m)).collect();
        #[cfg(feature = "target.rdna2")]
        if inner.iter().any(|o| body[*o].name == <crate::Rdna2Kernel as mlirformat::Op>::NAME) {
            let codes = crate::Emit::emit(&crate::Rdna2Emit, body, m)?;
            return self.native(t, codes.into_iter().map(|k| (k.name, k.align, k.pad, k.bytes, alloc::vec![("params", u64::from(k.params)), ("sgprs", u64::from(k.sgprs)), ("vgprs", u64::from(k.vgprs))])));
        }
        #[cfg(feature = "target.agx")]
        if inner.iter().any(|o| body[*o].name == <crate::AgxKernel as mlirformat::Op>::NAME) {
            let codes = crate::Emit::emit(&crate::AgxEmit, body, m)?;
            return self.native(t, codes.into_iter().map(|k| (k.name, k.align, 0, k.bytes, alloc::vec![("params", u64::from(k.params)), ("gprs", u64::from(k.gprs))])));
        }
        #[cfg(feature = "target.xe3")]
        if inner.iter().any(|o| body[*o].name == <crate::Xe3Kernel as mlirformat::Op>::NAME) {
            use crate::Heads;
            let mut kernels = Vec::new();
            for k in crate::Kernels::all(body, m, <crate::Xe3Kernel as mlirformat::Op>::NAME) {
                let h = body.head::<crate::Xe3Kernel>(k)?;
                let code = crate::Xe3Code::of(body, k)?;
                let info = alloc::vec![("simd", u64::from(h.simd.unwrap_or(0))), ("inputs", u64::from(h.inputs.unwrap_or(0))), ("threads", u64::from(h.threads.unwrap_or(1))), ("shared", u64::from(h.shared.unwrap_or(0)))];
                // the Kernel Start Pointer's alignment (64 bytes)
                kernels.push((code.name, h.align.unwrap_or(64), h.pad.unwrap_or(0), code.bytes, info));
            }
            return self.native(t, kernels.into_iter());
        }
        #[cfg(feature = "target.spirv")]
        if matches!(t, Attribute::Extended { ext, .. } if ext.name == "spirv.target_env") {
            let spirv = inner.iter().copied().find(|o| body[*o].name == "spirv.module").ok_or_else(|| Error("gpu.module without a spirv.module".to_owned()))?;
            let words = crate::Emit::emit(&crate::SpirvBinary::default(), body, spirv)?;
            let bytes: Vec<u8> = words.iter().flat_map(|w| w.to_le_bytes()).collect();
            return Ok(Self::make(t, None, self.format, &bytes));
        }
        let _ = inner;
        Err(Error(format!("gpu-module-to-binary: {t} needs LLVM")))
    }

    /// `#gpu.object<target, [properties = {...},] [format =] "bytes">`.
    #[cfg_attr(not(any(feature = "target.spirv", feature = "target.rdna2", feature = "target.agx", feature = "target.xe3")), allow(dead_code, reason = "no target that emits here"))]
    fn make<'a>(t: &Attribute<'_>, properties: Option<Attribute<'_>>, format: CompilationFormat, bytes: &[u8]) -> Attribute<'a> {
        let key = match format {
            CompilationFormat::Fatbin => "",
            CompilationFormat::Offloading => "offload = ",
            CompilationFormat::Assembly => "assembly = ",
            CompilationFormat::Binary => "bin = ",
            CompilationFormat::Llvm => "llvm = ",
        };
        let props = properties.map(|p| format!("properties = {p}, ")).unwrap_or_default();
        let body = format!("<{t}, {props}{key}\"{}\">", escape(bytes));
        Attribute::Extended { ext: Extended { name: String::from("gpu.object").into(), body: Some(body.into()), params: Vec::new() }, ty: None }
    }

    /// Kernels of machine code (name, alignment, padding after, bytes, what the driver needs) one after another: the
    /// object, `properties` each kernel's `offset`, `size` and the rest.
    #[cfg(any(feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"))]
    fn native<'a>(&self, t: &Attribute<'a>, kernels: impl Iterator<Item = (String, u64, u64, Vec<u8>, Vec<(&'static str, u64)>)>) -> Result<Attribute<'a>, Error> {
        if !matches!(self.format, CompilationFormat::Fatbin | CompilationFormat::Binary) {
            return Err(Error("gpu-module-to-binary: a GPU's machine code is binary only".to_owned()));
        }
        let mut bytes: Vec<u8> = Vec::new();
        let mut props = Vec::new();
        let int = |n: u64| Attribute::Int { lit: format!("{n}").into(), ty: Some(mlirformat::Type::int(64)) };
        for (name, align, pad, code, info) in kernels {
            let at = bytes.len().next_multiple_of(align.max(1) as usize);
            bytes.resize(at, 0);
            bytes.extend(&code);
            bytes.resize(bytes.len() + pad as usize, 0);
            let entry = [("offset", at as u64), ("size", code.len() as u64)].into_iter().chain(info);
            let entry = Attribute::Dict(entry.map(|(n, v)| mlirformat::NamedAttr { name: String::from(n).into(), value: Some(int(v)) }).collect());
            props.push(mlirformat::NamedAttr { name: name.into(), value: Some(entry) });
        }
        Ok(Self::make(t, Some(Attribute::Dict(props)), self.format, &bytes))
    }
}
