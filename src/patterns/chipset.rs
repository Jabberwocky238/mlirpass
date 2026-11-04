//! `amdgpu::Chipset`: the AMD GPU a lowering targets (`gfx<major><minor><stepping>`).

/// `amdgpu::Chipset`.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct Chipset {
    pub major: u32,
    pub minor: u32,
    pub stepping: u32,
}

impl TryFrom<&str> for Chipset {
    type Error = ();

    /// `Chipset::parse`: `gfx`, a decimal major, then one hex digit each of minor and stepping.
    fn try_from(name: &str) -> Result<Self, ()> {
        let n = name.strip_prefix("gfx").ok_or(())?;
        if n.len() < 3 || !n.is_ascii() {
            return Err(());
        }
        let (rest, stepping) = n.split_at(n.len() - 1);
        let (major, minor) = rest.split_at(rest.len() - 1);
        Ok(Self { major: major.parse().map_err(|_| ())?, minor: u32::from_str_radix(minor, 16).map_err(|_| ())?, stepping: u32::from_str_radix(stepping, 16).map_err(|_| ())? })
    }
}

impl Chipset {
    pub const fn new(major: u32, minor: u32, stepping: u32) -> Self {
        Self { major, minor, stepping }
    }
}
