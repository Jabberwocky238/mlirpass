//! The SPIR-V target environment (`TargetAndABI.cpp`): what a `#spirv.target_env` allows, and
//! what ops and types need of it (`SPIRVConversionTarget::isLegalOp`, the type capability and
//! extension visitors of `SPIRVTypes.cpp`).

use alloc::collections::BTreeSet;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::spirv_types::SpirvType;
use mlirformat::{Attribute, Dim, FloatKind, ShapedKind, Type};

use super::{Arg, Avail, EnumSpec, OpSpec};
use crate::{Body, OpId};

/// A conjunction of disjunctions: each inner list needs one of its names.
pub type Needs = Vec<Vec<String>>;

/// ⭐ `spirv::TargetEnv`.
#[derive(Debug, Clone)]
pub struct TargetEnv {
    /// The minor of SPIR-V `1.x`.
    pub version: u8,
    /// The capabilities given, as written.
    pub given_caps: Vec<String>,
    pub given_exts: Vec<String>,
    caps: BTreeSet<String>,
    exts: BTreeSet<String>,
    /// The `#spirv.target_env<...>` text (the default's when none is found).
    pub text: String,
}

/// `getImpliedExtensions`: what each version brings without asking.
const IMPLIED_EXTS: &[(u8, &[&str])] = &[
    (3, &["SPV_KHR_shader_draw_parameters", "SPV_KHR_16bit_storage", "SPV_KHR_device_group", "SPV_KHR_multiview", "SPV_KHR_storage_buffer_storage_class", "SPV_KHR_variable_pointers"]),
    (4, &["SPV_KHR_no_integer_wrap_decoration", "SPV_GOOGLE_decorate_string", "SPV_GOOGLE_hlsl_functionality1", "SPV_KHR_float_controls"]),
    (5, &["SPV_KHR_8bit_storage", "SPV_EXT_descriptor_indexing", "SPV_EXT_shader_viewport_index_layer", "SPV_EXT_physical_storage_buffer", "SPV_KHR_physical_storage_buffer", "SPV_KHR_vulkan_memory_model"]),
    (6, &["SPV_KHR_non_semantic_info", "SPV_KHR_integer_dot_product", "SPV_KHR_terminate_invocation", "SPV_EXT_demote_to_helper_invocation"]),
];

/// `getDefaultTargetEnv`: SPIR-V 1.0, `Shader`, default resource limits.
const DEFAULT_TARGET_ENV: &str = "#spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>";

impl TargetEnv {
    /// The `vce` triple of a `#spirv.target_env` / `#spirv.vce` attribute's text.
    fn vce(text: &str) -> Option<(u8, Vec<String>, Vec<String>)> {
        let at = text.find("#spirv.vce<")? + "#spirv.vce<".len();
        let body = &text[at..];
        let (version, rest) = body.split_once(',')?;
        let minor = version.trim().strip_prefix("v1.")?.parse().ok()?;
        let mut lists = rest.split(']').filter_map(|l| l.trim_start_matches([',', ' ']).strip_prefix('[')).map(|l| l.split(',').map(str::trim).filter(|s| !s.is_empty()).map(String::from).collect::<Vec<_>>());
        Some((minor, lists.next()?, lists.next()?))
    }

    /// The target `text` (`#spirv.target_env<...>`) describes.
    pub fn parse(text: &str) -> Option<Self> {
        let (version, given_caps, given_exts) = Self::vce(text)?;
        let mut exts: BTreeSet<String> = given_exts.iter().cloned().collect();
        for (v, es) in IMPLIED_EXTS {
            if *v <= version {
                exts.extend(es.iter().map(|e| String::from(*e)));
            }
        }
        let mut caps = BTreeSet::new();
        let cap_enum = EnumSpec::of("Capability");
        let mut work = given_caps.clone();
        while let Some(c) = work.pop() {
            if caps.insert(c.clone()) {
                work.extend(cap_enum.and_then(|e| e.case(&c)).map(|c| c.implies.iter().map(|i| String::from(*i)).collect::<Vec<_>>()).unwrap_or_default());
            }
        }
        Some(Self { version, given_caps, given_exts, caps, exts, text: String::from(text) })
    }

    pub fn default_env() -> Self {
        Self::parse(DEFAULT_TARGET_ENV).expect("the default target env parses")
    }

    /// `lookupTargetEnvOrDefault`: the `spirv.target_env` of the nearest symbol table at or
    /// above `op` that has one.
    pub fn lookup(body: &Body<'_>, op: OpId) -> Self {
        let mut at = Some(op);
        while let Some(o) = at {
            if body.is_symbol_table(o)
                && let Some(a) = body[o].get("spirv.target_env")
                && let Some(t) = Self::parse(&format!("{a}"))
            {
                return t;
            }
            at = body.parent_op(o);
        }
        Self::default_env()
    }

    /// `TargetEnv::allows(ArrayRef<Capability>)`: the first of `ors` the target has.
    pub fn first_cap<'s>(&self, ors: &'s [String]) -> Option<&'s String> {
        ors.iter().find(|c| self.allows_cap(c))
    }

    pub fn first_ext<'s>(&self, ors: &'s [String]) -> Option<&'s String> {
        ors.iter().find(|e| self.allows_ext(e))
    }

    /// `getRecursiveImpliedCapabilities`: breadth first.
    pub fn implied(cap: &str) -> Vec<String> {
        let e = EnumSpec::of("Capability");
        let direct = |c: &str| e.and_then(|e| e.case(c)).map(|c| c.implies.iter().map(|i| String::from(*i)).collect::<Vec<_>>()).unwrap_or_default();
        let mut all = direct(cap);
        let mut i = 0;
        while i < all.len() {
            for c in direct(&all[i]) {
                if !all.contains(&c) {
                    all.push(c);
                }
            }
            i += 1;
        }
        all
    }

    /// `lookupTargetEnv`: the nearest `spirv.target_env`, if any.
    pub fn find(body: &Body<'_>, op: OpId) -> Option<Self> {
        let mut at = Some(op);
        while let Some(o) = at {
            if body.is_symbol_table(o)
                && let Some(t) = body[o].get("spirv.target_env").and_then(|a| Self::parse(&format!("{a}")))
            {
                return Some(t);
            }
            at = body.parent_op(o);
        }
        None
    }

    /// The resource limits' `subgroup_size` (32 by default).
    pub fn subgroup_size(&self) -> u32 {
        self.text.split("subgroup_size").nth(1).and_then(|r| r.trim_start_matches([' ', '=']).split(|c: char| !c.is_ascii_digit()).next()?.parse().ok()).unwrap_or(32)
    }

    pub fn allows_cap(&self, c: &str) -> bool {
        self.caps.contains(c)
    }

    pub fn allows_ext(&self, e: &str) -> bool {
        self.exts.contains(e)
    }

    /// `checkCapabilityRequirements` and `checkExtensionRequirements` together.
    pub fn satisfies(&self, caps: &Needs, exts: &Needs) -> bool {
        caps.iter().all(|ors| ors.iter().any(|c| self.allows_cap(c))) && exts.iter().all(|ors| ors.iter().any(|e| self.allows_ext(e)))
    }

    /// `needsInterfaceVarABIAttrs`: the first of `Kernel` / `Shader` the target lists.
    pub fn shader(&self) -> bool {
        self.given_caps.iter().find(|c| *c == "Kernel" || *c == "Shader").is_some_and(|c| c == "Shader")
    }

    // ---- types -------------------------------------------------------------------------

    /// `getAddressingModel`: by the first of `Kernel` (`Physical32` / `Physical64`) and
    /// `PhysicalStorageBufferAddresses` among the given capabilities, else `Logical`.
    pub fn addressing_model(&self, index64: bool) -> &'static str {
        for c in &self.given_caps {
            match &**c {
                "Kernel" => return if index64 { "Physical64" } else { "Physical32" },
                "PhysicalStorageBufferAddresses" => return "PhysicalStorageBuffer64",
                _ => {}
            }
        }
        "Logical"
    }

    /// `spirv::ScalarType::classof`.
    pub fn is_scalar(t: &Type<'_>) -> bool {
        match t {
            Type::Integer { width, .. } => matches!(width, 1 | 8 | 16 | 32 | 64),
            Type::Float(k) => matches!(k, FloatKind::F16 | FloatKind::BF16 | FloatKind::F32 | FloatKind::F64),
            _ => false,
        }
    }

    /// `CompositeType::isValid(VectorType)`.
    pub fn is_valid_vector(t: &Type<'_>) -> bool {
        matches!(t, Type::Shaped(s) if s.kind == ShapedKind::Vector && matches!(s.shape.as_deref(), Some([Dim::Static(2 | 3 | 4 | 8 | 16)])) && Self::is_scalar(&s.elem))
    }

    /// `isa<spirv::SPIRVType>`.
    pub fn is_spirv_type(t: &Type<'_>) -> bool {
        Self::is_scalar(t) || Self::is_valid_vector(t) || matches!(t, Type::Extended(e) if e.name.starts_with("spirv."))
    }

    /// The case `name` of enum `class`'s needs.
    fn case_needs(class: &str, name: &str, caps: &mut Needs, exts: &mut Needs) {
        if let Some(c) = EnumSpec::of(class).and_then(|e| e.case(name)) {
            Self::avail_needs(&c.avail, caps, exts);
        }
    }

    fn avail_needs(a: &Avail<'_>, caps: &mut Needs, exts: &mut Needs) {
        caps.extend(a.caps.iter().map(|g| g.iter().map(|c| String::from(*c)).collect()));
        exts.extend(a.exts.iter().map(|g| g.iter().map(|e| String::from(*e)).collect()));
    }

    /// What type `t` needs in storage class `storage` (`getCapabilities` / `getExtensions`).
    pub fn type_needs(t: &Type<'_>, storage: Option<&str>, caps: &mut Needs, exts: &mut Needs) {
        let one = |v: &[&str]| v.iter().map(|s| String::from(*s)).collect::<Vec<_>>();
        match t {
            Type::Integer { .. } | Type::Float(_) => {
                let w = t.bit_width().unwrap_or(32);
                if matches!(t, Type::Float(FloatKind::BF16)) {
                    exts.push(one(&["SPV_KHR_bfloat16"]));
                }
                match storage {
                    Some("PushConstant" | "StorageBuffer" | "Uniform") if w == 8 => exts.push(one(&["SPV_KHR_8bit_storage"])),
                    Some("PushConstant" | "StorageBuffer" | "Uniform" | "Input" | "Output") if w == 16 => exts.push(one(&["SPV_KHR_16bit_storage"])),
                    _ => {}
                }
                let storage_cap = match (storage, w) {
                    (Some("PushConstant"), 8) => Some("StoragePushConstant8"),
                    (Some("PushConstant"), 16) => Some("StoragePushConstant16"),
                    (Some("StorageBuffer"), 8) => Some("StorageBuffer8BitAccess"),
                    (Some("StorageBuffer"), 16) => Some("StorageBuffer16BitAccess"),
                    (Some("Uniform"), 8) => Some("UniformAndStorageBuffer8BitAccess"),
                    (Some("Uniform"), 16) => Some("StorageUniform16"),
                    (Some("Input" | "Output"), 16) => Some("StorageInputOutput16"),
                    _ => None,
                };
                if let Some(c) = storage_cap {
                    caps.push(one(&[c]));
                    return;
                }
                let cap = match (t, w) {
                    (Type::Integer { .. }, 8) => Some("Int8"),
                    (Type::Integer { .. }, 16) => Some("Int16"),
                    (Type::Integer { .. }, 64) => Some("Int64"),
                    (Type::Float(FloatKind::BF16), _) => Some("BFloat16TypeKHR"),
                    (Type::Float(_), 16) => Some("Float16"),
                    (Type::Float(_), 64) => Some("Float64"),
                    _ => None,
                };
                caps.extend(cap.map(|c| one(&[c])));
            }
            Type::Shaped(s) if s.kind == ShapedKind::Vector => {
                Self::type_needs(&s.elem, storage, caps, exts);
                if matches!(t.element_count(), Some(8 | 16)) {
                    caps.push(one(&["Vector16"]));
                }
            }
            t => match SpirvType::try_from(t) {
                Ok(SpirvType::Array { elem, .. }) => Self::type_needs(&elem, storage, caps, exts),
                Ok(SpirvType::RuntimeArray { elem, .. }) => {
                    Self::type_needs(&elem, storage, caps, exts);
                    caps.push(one(&["Shader"]));
                }
                Ok(SpirvType::Matrix { column, .. }) => {
                    Self::type_needs(&column, storage, caps, exts);
                    caps.push(one(&["Matrix"]));
                }
                Ok(SpirvType::Struct { members: Some(ms), .. }) => ms.iter().for_each(|m| Self::type_needs(&m.ty, storage, caps, exts)),
                Ok(SpirvType::Ptr { pointee, storage: sc }) => {
                    Self::type_needs(&pointee, Some(&sc), caps, exts);
                    Self::case_needs("StorageClass", &sc, caps, exts);
                }
                Ok(SpirvType::SampledImage(i)) => Self::type_needs(&i, storage, caps, exts),
                Ok(SpirvType::Image { elem, params }) => {
                    let (mut c, mut e) = (Needs::new(), Needs::new());
                    Self::case_needs("Dim", &params[0], &mut c, &mut e);
                    Self::case_needs("ImageFormat", &params[5], &mut c, &mut e);
                    caps.extend(c);
                    Self::type_needs(&elem, storage, caps, exts);
                }
                Ok(SpirvType::CoopMatrix { elem, .. }) => {
                    Self::type_needs(&elem, storage, caps, exts);
                    exts.push(one(&["SPV_KHR_cooperative_matrix"]));
                    caps.push(one(&["CooperativeMatrixKHR"]));
                }
                Ok(SpirvType::TensorArm { elem, .. }) => {
                    Self::type_needs(&elem, storage, caps, exts);
                    exts.push(one(&["SPV_ARM_tensors"]));
                    caps.push(one(&["TensorsARM"]));
                }
                _ => {}
            },
        }
    }

    /// Whether type `t` (in `storage`) is available.
    pub fn allows_type(&self, t: &Type<'_>, storage: Option<&str>) -> bool {
        let (mut caps, mut exts) = (Needs::new(), Needs::new());
        Self::type_needs(t, storage, &mut caps, &mut exts);
        self.satisfies(&caps, &exts)
    }

    // ---- ops ---------------------------------------------------------------------------

    /// What op `op` needs: its own availability and that of the enum values it holds.
    pub(crate) fn op_needs(body: &Body<'_>, op: OpId, spec: &OpSpec<'_>) -> (Option<u8>, Option<u8>, Needs, Needs) {
        let (mut lo, mut hi) = (spec.avail.min, spec.avail.max);
        // `SelectOp::getMinVersion` (C++): a scalar condition picking whole composites is 1.4.
        if spec.name == "spirv.Select" {
            let cond = &body[body[op].operands[0]].ty;
            let res = &body[body[op].results[0]].ty;
            let composite = Self::is_valid_vector(res) || SpirvType::try_from(res).is_ok_and(|t| matches!(t, SpirvType::Array { .. } | SpirvType::Struct { .. } | SpirvType::Matrix { .. } | SpirvType::CoopMatrix { .. }));
            lo = Some(if Self::is_scalar(cond) && composite { 4 } else { 0 });
        }
        let (mut caps, mut exts) = (Needs::new(), Needs::new());
        Self::avail_needs(&spec.avail, &mut caps, &mut exts);
        for a in spec.args {
            let Arg::Attr(n, _, Some(class)) = a else { continue };
            let (Some(attr), Some(e)) = (body[op].get(n), EnumSpec::of(class)) else { continue };
            let Some(v) = EnumSpec::attr_value(attr) else { continue };
            for c in e.cases_of(v) {
                lo = match (lo, c.avail.min) {
                    (Some(a), Some(b)) => Some(a.max(b)),
                    (a, b) => a.or(b),
                };
                hi = match (hi, c.avail.max) {
                    (Some(a), Some(b)) => Some(a.min(b)),
                    (a, b) => a.or(b),
                };
                Self::avail_needs(&c.avail, &mut caps, &mut exts);
            }
        }
        (lo, hi, caps, exts)
    }

    /// `SPIRVConversionTarget::isLegalOp`.
    pub fn op_legal(&self, body: &Body<'_>, op: OpId) -> bool {
        let Some(spec) = OpSpec::of(&body[op].name) else { return false };
        let (lo, hi, caps, exts) = Self::op_needs(body, op, spec);
        if lo.is_some_and(|v| v > self.version) || hi.is_some_and(|v| v < self.version) || !self.satisfies(&caps, &exts) {
            return false;
        }
        let d = &body[op];
        let mut types: Vec<Type<'_>> = d.operands.iter().chain(&d.results).map(|v| body[*v].ty.clone()).collect();
        if types.iter().any(|t| !Self::is_spirv_type(t)) {
            return false;
        }
        if d.name == "spirv.GlobalVariable"
            && let Some(Attribute::Type(t)) = d.get("type")
        {
            types.push(t.clone());
        }
        types.iter().all(|t| self.allows_type(t, None))
    }
}
