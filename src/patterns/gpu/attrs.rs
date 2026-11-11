//! The `gpu` dialect's enum attributes (`#gpu<dim x>`, `#gpu<shuffle_mode xor>`).

use mlirformat::Attribute;

/// The case of a `#gpu<kind case>` attribute among `names`.
fn case_of<T: Copy>(a: &Attribute<'_>, kind: &str, names: &[(&'static str, T)]) -> Option<T> {
    let Attribute::Extended { ext, .. } = a else { return None };
    if ext.name != "gpu" {
        return None;
    }
    let case = ext.body.as_deref()?.strip_prefix('<')?.strip_suffix('>')?.trim().strip_prefix(kind)?.trim();
    names.iter().find(|(n, _)| *n == case).map(|(_, v)| *v)
}

/// `gpu::Dimension`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Dimension {
    X = 0,
    Y = 1,
    Z = 2,
}

impl Dimension {
    const NAMES: [(&'static str, Self); 3] = [("x", Self::X), ("y", Self::Y), ("z", Self::Z)];
}

impl TryFrom<&Attribute<'_>> for Dimension {
    type Error = ();
    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        case_of(a, "dim", &Self::NAMES).ok_or(())
    }
}

/// `gpu::ShuffleMode`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ShuffleMode {
    Xor,
    Up,
    Down,
    Idx,
}

impl ShuffleMode {
    const NAMES: [(&'static str, Self); 4] = [("xor", Self::Xor), ("up", Self::Up), ("down", Self::Down), ("idx", Self::Idx)];
}

impl TryFrom<&Attribute<'_>> for ShuffleMode {
    type Error = ();
    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        case_of(a, "shuffle_mode", &Self::NAMES).ok_or(())
    }
}

/// `gpu::AllReduceOperation`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum AllReduceOp {
    Add,
    Mul,
    MinUi,
    MinSi,
    MinNumF,
    MaxUi,
    MaxSi,
    MaxNumF,
    And,
    Or,
    Xor,
    MinimumF,
    MaximumF,
}

impl AllReduceOp {
    const NAMES: [(&'static str, Self); 13] = [
        ("add", Self::Add),
        ("mul", Self::Mul),
        ("minui", Self::MinUi),
        ("minsi", Self::MinSi),
        ("minnumf", Self::MinNumF),
        ("maxui", Self::MaxUi),
        ("maxsi", Self::MaxSi),
        ("maxnumf", Self::MaxNumF),
        ("and", Self::And),
        ("or", Self::Or),
        ("xor", Self::Xor),
        ("minimumf", Self::MinimumF),
        ("maximumf", Self::MaximumF),
    ];

    /// The case's name, as `vector::CombiningKind` spells it too.
    pub fn name(self) -> &'static str {
        Self::NAMES.iter().find(|(_, v)| *v == self).map_or("", |(n, _)| n)
    }
}

impl TryFrom<&Attribute<'_>> for AllReduceOp {
    type Error = ();
    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        case_of(a, "all_reduce_op", &Self::NAMES).ok_or(())
    }
}

/// `gpu::BroadcastType`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BroadcastType {
    FirstActiveLane,
    AnyLane,
    SpecificLane,
}

impl BroadcastType {
    const NAMES: [(&'static str, Self); 3] = [("first_active_lane", Self::FirstActiveLane), ("any_lane", Self::AnyLane), ("specific_lane", Self::SpecificLane)];
}

impl TryFrom<&Attribute<'_>> for BroadcastType {
    type Error = ();
    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        case_of(a, "broadcast", &Self::NAMES).ok_or(())
    }
}

/// The case of a `#gpu.<mnemonic><case>` attribute among `names`.
#[cfg(all(feature = "target.llvm", feature = "dialect.amdgpu", feature = "dialect.math"))]
fn mnemonic_case_of<T: Copy>(a: &Attribute<'_>, name: &str, names: &[(&'static str, T)]) -> Option<T> {
    let Attribute::Extended { ext, .. } = a else { return None };
    if ext.name != name {
        return None;
    }
    let case = ext.body.as_deref()?.strip_prefix('<')?.strip_suffix('>')?.trim();
    names.iter().find(|(n, _)| *n == case).map(|(_, v)| *v)
}

/// `gpu::BarrierScope` (`#gpu.barrier_scope<..>`).
#[cfg(all(feature = "target.llvm", feature = "dialect.amdgpu", feature = "dialect.math"))]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum BarrierScope {
    Subgroup,
    Workgroup,
    Cluster,
}

#[cfg(all(feature = "target.llvm", feature = "dialect.amdgpu", feature = "dialect.math"))]
impl BarrierScope {
    const NAMES: [(&'static str, Self); 3] = [("subgroup", Self::Subgroup), ("workgroup", Self::Workgroup), ("cluster", Self::Cluster)];
}

#[cfg(all(feature = "target.llvm", feature = "dialect.amdgpu", feature = "dialect.math"))]
impl TryFrom<&Attribute<'_>> for BarrierScope {
    type Error = ();
    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        mnemonic_case_of(a, "gpu.barrier_scope", &Self::NAMES).ok_or(())
    }
}

/// `gpu::AddressSpace` (`#gpu.address_space<..>`).
#[cfg(all(feature = "target.llvm", feature = "dialect.amdgpu", feature = "dialect.math"))]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum AddressSpace {
    Global,
    Workgroup,
    Private,
    Constant,
}

#[cfg(all(feature = "target.llvm", feature = "dialect.amdgpu", feature = "dialect.math"))]
impl AddressSpace {
    const NAMES: [(&'static str, Self); 4] = [("global", Self::Global), ("workgroup", Self::Workgroup), ("private", Self::Private), ("constant", Self::Constant)];
}

#[cfg(all(feature = "target.llvm", feature = "dialect.amdgpu", feature = "dialect.math"))]
impl TryFrom<&Attribute<'_>> for AddressSpace {
    type Error = ();
    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        mnemonic_case_of(a, "gpu.address_space", &Self::NAMES).ok_or(())
    }
}
