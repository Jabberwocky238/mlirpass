use crate::{ClientApi, TargetEnv};

#[crate::pass("map-memref-spirv-storage-class")]
pub struct MapMemrefSpirvStorageClass {
    #[opt("client-api", default = alloc::string::String::from("vulkan"))]
    client_api: alloc::string::String,
}

impl crate::Run for MapMemrefSpirvStorageClass {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let mut api = match &*self.client_api {
            "vulkan" => ClientApi::Vulkan,
            "opencl" => ClientApi::OpenCl,
            a => return Err(mlirformat::Error(alloc::format!("Invalid clienAPI: {a}"))),
        };
        let mut at = Some(op);
        while let Some(o) = at {
            if body.is_symbol_table(o)
                && let Some(t) = body[o].get("spirv.target_env").and_then(|a| TargetEnv::parse(&alloc::format!("{a}")))
            {
                if t.allows_cap("Kernel") {
                    api = ClientApi::OpenCl;
                } else if t.allows_cap("Shader") {
                    api = ClientApi::Vulkan;
                }
                break;
            }
            at = body.parent_op(o);
        }
        match api.map_memory_spaces(body, op).first() {
            Some(bad) => Err(mlirformat::Error(alloc::format!("'{}' op failed to legalize memory space", body[*bad].name))),
            None => Ok(()),
        }
    }
}
