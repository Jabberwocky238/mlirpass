//! `convert-gpu-to-spirv`.

use crate::{GpuSpirvOptions, GpuToSpirv};
use alloc::format;
use alloc::vec::Vec;
use mlirformat::{Attribute, Type};
use crate::{OpData, OpId};

/// `convert-gpu-to-spirv`.
#[crate::pass("convert-gpu-to-spirv", on = "builtin.module")]
pub struct ConvertGpuToSpirv {
    #[opt("use-64bit-index")]
    index64: bool,
}

impl ConvertGpuToSpirv {
    /// `lookupTargetEnvOrDefault`: the module's own `targets` first.
    fn target_env(body: &crate::Body<'_>, gm: OpId) -> crate::TargetEnv {
        if let Some(Attribute::Array(ts)) = body[gm].get("targets")
            && let Some(env) = ts.iter().find_map(|t| crate::TargetEnv::parse(&format!("{t}")).filter(|_| format!("{t}").starts_with("#spirv.target_env")))
        {
            return env;
        }
        crate::TargetEnv::lookup(body, gm)
    }
}

impl crate::Run for ConvertGpuToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
        let modules: Vec<OpId> = body.ops_in(op).into_iter().filter(|o| body[*o].name == "gpu.module").collect();
        let mut clones = Vec::new();
        for gm in &modules {
            let kernel = Self::target_env(body, *gm).allows_cap("Kernel");
            let c = body.clone_op(*gm, &mut crate::Mapping::default());
            if kernel {
                let blk = body.top_block(*gm);
                body.insert(c, blk, Some(0));
            } else {
                body.insert_before(c, *gm);
            }
            clones.push(c);
        }
        for gm in clones {
            let env = Self::target_env(body, gm);
            let api = if env.allows_cap("Kernel") { crate::ClientApi::OpenCl } else { crate::ClientApi::Vulkan };
            if let Some(bad) = api.map_memory_spaces(body, gm).first() {
                return Err(mlirformat::Error(format!("'{}' op failed to legalize memory space", body[*bad].name)));
            }
            let opts = crate::SpirvOptions { index64: self.index64, ..crate::SpirvOptions::default() };
            let types = crate::SpirvTypes { env: &env, opts };
            let mut tc = types.converter();
            crate::WmmaToSpirv::convert_types(&mut tc);
            // `populateGPUNamedBarrierToSPIRVTypeConversion`.
            tc.conversion(|t| matches!(t, mlirformat::Type::Extended(e) if e.name == "gpu.named_barrier").then(|| Some(alloc::vec![mlirformat::spirv_types::SpirvType::NamedBarrier.into()])));
            let gpu = GpuSpirvOptions { index64: self.index64, shader: env.allows_cap("Shader"), kernel: env.allows_cap("Kernel"), interface_abi: env.shader(), subgroup_size: env.subgroup_size(), addressing: env.addressing_model(self.index64) };
            let mut patterns = crate::ConversionPatterns::default();
            let i = patterns.converter(&tc);
            GpuToSpirv::populate(&mut patterns, i, gpu);
            crate::WmmaToSpirv::populate(&mut patterns, i, crate::MemrefSpirvOptions { index64: self.index64, kernel: env.allows_cap("Kernel"), bool_bits: 8 });
            crate::ScfToSpirv::populate(&mut patterns, i);
            crate::ArithToSpirv::populate(&mut patterns, i, crate::ArithSpirvOptions { no_wrap: env.allows_ext("SPV_KHR_no_integer_wrap_decoration"), emulate_floats: true });
            crate::MemrefToSpirv::populate(&mut patterns, i, crate::MemrefSpirvOptions { index64: self.index64, kernel: env.allows_cap("Kernel"), bool_bits: 8 });
            crate::FuncToSpirv::populate(&mut patterns, i);
            crate::VectorToSpirv::populate(&mut patterns, i, crate::VectorSpirvOptions { index64: self.index64, kernel: env.allows_cap("Kernel") });
            let target = env.conversion_target();
            crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[gm], crate::Mode::Full)?;
        }
        for gm in modules {
            if !Self::target_env(body, gm).allows_cap("Kernel") {
                continue;
            }
            let funcs: Vec<OpId> = body.ops_in(gm).into_iter().filter(|o| body[*o].name == "gpu.func").collect();
            for f in funcs {
                let mut data = OpData::build("func.func");
                for a in ["sym_name", "function_type"] {
                    data.set(a, body[f].get(a).cloned().unwrap_or(Attribute::Unit));
                }
                data.set("gpu.kernel", Attribute::Unit);
                let Some(Attribute::Type(Type::Function(fty))) = body[f].get("function_type").cloned() else { continue };
                let new = body.create(data, &[]);
                let r = body.add_region(new);
                let args: Vec<_> = fty.inputs.iter().map(|t| (t.clone(), body[f].loc.clone())).collect();
                let blk = body.add_block(r, &args);
                let ret = body.create(OpData::build("func.return"), &[]);
                body.insert(ret, blk, None);
                body.insert_before(new, f);
                body.erase(f);
            }
        }
        Ok(())
    }
}
