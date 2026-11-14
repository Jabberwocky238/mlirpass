#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct Chipset {
    pub major: u32,
    pub minor: u32,
    pub stepping: u32,
}

impl TryFrom<&str> for Chipset {
    type Error = ();

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

    pub fn has_dot1(self) -> bool {
        match self.major {
            9 => self >= Chipset::new(9, 0, 6),
            10 if self.minor == 1 => matches!(self.stepping, 1 | 2),
            10 => self.minor >= 3,
            _ => false,
        }
    }

    pub fn has_dot7(self) -> bool {
        self.major >= 11 || self.has_dot1()
    }

    pub fn has_dot8(self) -> bool {
        self.major >= 11
    }

    pub fn has_dot9(self) -> bool {
        self.major == 11 || (self.major == 12 && self.minor == 0)
    }

    pub fn has_dot10(self) -> bool {
        self.has_dot9() || self.has_dot1()
    }

    pub fn has_dot11(self) -> bool {
        (self.major == 11 && self.minor == 7) || (self.major == 12 && self.minor == 0)
    }

    pub fn has_dot12(self) -> bool {
        self == Chipset::new(9, 5, 0) || self.has_dot9()
    }
}
