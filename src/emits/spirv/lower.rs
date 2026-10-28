//! What the lowerings to `spirv` share (`SPIRVConversion.cpp`, `MapMemRefStorageClassPass.cpp`):
//! constants, builtin variables, and memref memory spaces as storage classes.

use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::spirv_types::SpirvType;
use mlirformat::{Attribute, NamedAttr, Shaped, ShapedKind, Type};

use crate::{Body, ConversionRewriter, OpData, OpId, ValueId};

/// Which client API's memory spaces (`mapMemorySpaceToVulkanStorageClass` / `..OpenCL..`).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ClientApi {
    Vulkan,
    OpenCl,
}

impl ClientApi {
    /// The storage class of memory space `space` (`None`: the default one).
    pub fn storage_class(self, space: Option<&Attribute<'_>>) -> Option<&'static str> {
        let Some(space) = space else {
            return Some(match self {
                ClientApi::Vulkan => "StorageBuffer",
                ClientApi::OpenCl => "CrossWorkgroup",
            });
        };
        let Attribute::Int { lit, .. } = space else { return None };
        let n: i64 = lit.parse().ok()?;
        let vulkan = [(0, "StorageBuffer"), (1, "Generic"), (3, "Workgroup"), (4, "Uniform"), (5, "Private"), (6, "Function"), (7, "PushConstant"), (8, "UniformConstant"), (9, "Input"), (10, "Output"), (11, "PhysicalStorageBuffer"), (12, "Image")];
        let opencl = [(0, "CrossWorkgroup"), (1, "Generic"), (3, "Workgroup"), (4, "UniformConstant"), (5, "Private"), (6, "Function"), (7, "Image")];
        let table: &[(i64, &str)] = if self == ClientApi::Vulkan { &vulkan } else { &opencl };
        table.iter().find(|(k, _)| *k == n).map(|(_, s)| *s)
    }

    /// `t` with every memref's memory space a storage class; `None` when one has no mapping.
    pub fn map_type<'a>(self, t: &Type<'a>) -> Option<Type<'a>> {
        Some(match t {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef => {
                if matches!(s.memory_space(), Some(Attribute::Extended { ext, .. }) if ext.name == "spirv.storage_class") {
                    return Some(t.clone());
                }
                let sc = self.storage_class(s.memory_space())?;
                let mut extras: Vec<Attribute<'a>> = s.extras.iter().filter(|a| a.is_layout()).cloned().collect();
                extras.push(Attribute::dialect("spirv.storage_class", &format!("<{sc}>")));
                Type::Shaped(Shaped { extras, elem: self.map_type(&s.elem)?.into(), ..s.clone() })
            }
            Type::Shaped(s) => Type::Shaped(Shaped { elem: self.map_type(&s.elem)?.into(), ..s.clone() }),
            Type::Function(f) => Type::Function(mlirformat::FunctionType { inputs: f.inputs.iter().map(|t| self.map_type(t)).collect::<Option<_>>()?, results: f.results.iter().map(|t| self.map_type(t)).collect::<Option<_>>()? }),
            Type::Tuple(ts) => Type::Tuple(ts.iter().map(|t| self.map_type(t)).collect::<Option<_>>()?),
            t => t.clone(),
        })
    }

    fn map_attr<'a>(self, a: &Attribute<'a>) -> Option<Attribute<'a>> {
        Some(match a {
            Attribute::Type(t) => Attribute::Type(self.map_type(t)?),
            Attribute::Array(es) => Attribute::Array(es.iter().map(|e| self.map_attr(e)).collect::<Option<_>>()?),
            Attribute::Dict(es) => Attribute::Dict(es.iter().map(|e| Some(NamedAttr { name: e.name.clone(), value: match &e.value {
                        Some(v) => Some(self.map_attr(v)?),
                        None => None,
                    } })).collect::<Option<_>>()?),
            a => a.clone(),
        })
    }

    /// `convertMemRefTypesAndAttrs`: every type in and under `op` (values, block arguments,
    /// attributes) with memory spaces as storage classes. The ops it cannot map stay, and
    /// are returned (`failed to legalize memory space`).
    pub fn map_memory_spaces(self, body: &mut Body<'_>, op: OpId) -> Vec<OpId> {
        let mut failed = Vec::new();
        for o in body.ops_in(op) {
            let mut ok = true;
            for v in body[o].results.clone() {
                match self.map_type(&body[v].ty) {
                    Some(t) => body[v].ty = t,
                    None => ok = false,
                }
            }
            for r in body[o].regions.clone() {
                for b in body[r].blocks.clone() {
                    for a in body[b].args.clone() {
                        match self.map_type(&body[a].ty) {
                            Some(t) => body[a].ty = t,
                            None => ok = false,
                        }
                    }
                }
            }
            if let Some(p) = body[o].properties.clone() {
                match self.map_attr(&p) {
                    Some(p) => body[o].properties = Some(p),
                    None => ok = false,
                }
            }
            for i in 0..body[o].attributes.len() {
                if let Some(v) = body[o].attributes[i].value.clone() {
                    match self.map_attr(&v) {
                        Some(v) => body[o].attributes[i].value = Some(v),
                        None => ok = false,
                    }
                }
            }
            if !ok {
                failed.push(o);
            }
        }
        failed
    }
}

impl<'a> ConversionRewriter<'_, 'a, '_> {
    /// A `spirv.Constant` of `value` typed `ty`.
    pub fn spirv_const(&mut self, ty: Type<'a>, value: Attribute<'a>) -> ValueId {
        self.build(OpData::build("spirv.Constant").with("value", value), ty)
    }

    /// The nearest symbol table above `op` and its first block.
    fn symbol_table_block(&self, op: OpId) -> Option<crate::BlockId> {
        let b = &self.rw.body;
        let mut at = b.parent_op(op);
        while let Some(o) = at {
            if b.is_symbol_table(o) {
                return b[b[o].regions[0]].blocks.first().copied();
            }
            at = b.parent_op(o);
        }
        None
    }

    /// `getBuiltinVariableValue`: the builtin variable (created at the start of the nearest
    /// symbol table when missing, named `__builtin__<B>__`) loaded.
    pub fn builtin_value(&mut self, op: OpId, builtin: &str, int: Type<'a>) -> Option<ValueId> {
        let block = self.symbol_table_block(op)?;
        let existing = self.rw.body[block].ops.iter().copied().find(|o| {
            let d = &self.rw.body[*o];
            d.name == "spirv.GlobalVariable" && matches!(d.get("built_in"), Some(Attribute::Str { lit, .. }) if &**lit == builtin)
        });
        let var = match existing {
            Some(v) => v,
            None => {
                let ty = match builtin {
                    "NumWorkgroups" | "WorkgroupSize" | "WorkgroupId" | "LocalInvocationId" | "GlobalInvocationId" => Type::vector(&[3], &[false], int.clone()),
                    "SubgroupId" | "NumSubgroups" | "SubgroupSize" | "SubgroupLocalInvocationId" => int.clone(),
                    _ => return None,
                };
                let ptr = SpirvType::ptr(ty, "Input");
                let saved = self.rw.ip;
                self.rw.set_start(block);
                let name = format!("__builtin__{builtin}__");
                let v = self.rw.create(OpData::build("spirv.GlobalVariable").with("built_in", Attribute::str(builtin)).with("sym_name", Attribute::str(&name)).with("type", Attribute::Type(ptr)), &[]);
                self.rw.ip = saved;
                v
            }
        };
        let Some(Attribute::Type(ptr)) = self.rw.body[var].get("type").cloned() else { return None };
        let Some(Attribute::Str { lit, .. }) = self.rw.body[var].get("sym_name").cloned() else { return None };
        let addr = self.build(OpData::build("spirv.mlir.addressof").with("variable", Attribute::SymbolRef(alloc::vec![lit])), ptr.clone());
        let loaded = match SpirvType::try_from(&ptr) {
            Ok(SpirvType::Ptr { pointee, .. }) => (*pointee).clone(),
            _ => return None,
        };
        Some(self.build(OpData::build("spirv.Load").operands(&[addr]), loaded))
    }

    /// A `#spirv.<mnemonic><case>` enum attribute.
    pub fn spirv_enum(mnemonic: &str, case: &str) -> Attribute<'a> {
        Attribute::dialect(&format!("spirv.{mnemonic}"), &format!("<{case}>"))
    }
}

/// `String` for symbol names.
pub fn symbol_text(a: &Attribute<'_>) -> Option<String> {
    match a {
        Attribute::Str { lit, .. } => Some(String::from(&**lit)),
        Attribute::SymbolRef(p) => Some(String::from(&*p[0])),
        _ => None,
    }
}
