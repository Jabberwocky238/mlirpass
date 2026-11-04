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
