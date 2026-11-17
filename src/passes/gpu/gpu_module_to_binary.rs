use alloc::borrow::ToOwned;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Extended};

use crate::{Body, OpData, OpId, Quiet, Rewriter, Run, escape};

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

#[crate::pass("gpu-module-to-binary", extra = ["toolkit", "l", "opts", "section"])]
pub struct GpuModuleToBinary {
    #[opt("format", default = CompilationFormat::Fatbin, from_str)]
    #[cfg_attr(not(feature = "target.spirv"), allow(dead_code, reason = "no target that emits here"))]
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
            data.set("offloadingHandler", Attribute::Extended { ext: alloc::boxed::Box::new(Extended { name: String::from("gpu.select_object").into(), body: None, params: Vec::new() }), ty: None });
            rw.create(data, &[]);
            rw.erase_op(m);
        }
        Ok(())
    }
}

impl GpuModuleToBinary {
    fn object<'a>(&self, body: &Body<'a>, m: OpId, t: &Attribute<'a>) -> Result<Attribute<'a>, Error> {
        let inner: Vec<OpId> = body.ops(body.top_block(m)).collect();
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

    #[cfg_attr(not(feature = "target.spirv"), allow(dead_code, reason = "no target that emits here"))]
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
        Attribute::Extended { ext: alloc::boxed::Box::new(Extended { name: String::from("gpu.object").into(), body: Some(body.into()), params: Vec::new() }), ty: None }
    }
}
