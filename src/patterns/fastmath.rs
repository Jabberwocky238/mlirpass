//! `arith::FastMathFlags`, shared by the lowerings that read an op's `fastmath`.

use alloc::vec::Vec;

use mlirformat::Attribute;

use crate::{ConversionRewriter, OpId};

/// `arith::FastMathFlags`, as bits in their enum order.
#[derive(Clone, Copy, PartialEq, Eq)]
pub struct Fmf(u8);

impl Fmf {
    const NAMES: [&'static str; 7] = ["reassoc", "nnan", "ninf", "nsz", "arcp", "contract", "afn"];
    pub const NONE: Fmf = Fmf(0);
    const NNAN_NINF: u8 = 0b110;
    const AFN: u8 = 0b100_0000;

    pub fn of(cr: &ConversionRewriter<'_, '_, '_>, op: OpId) -> Self {
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("fastmath") else { return Self::NONE };
        let body = ext.body.as_deref().unwrap_or("<none>");
        let mut bits = 0u8;
        for f in body.trim_matches(|c| c == '<' || c == '>').split(',').map(str::trim) {
            if f == "fast" {
                bits = 0x7f;
            } else if let Some(i) = Self::NAMES.iter().position(|n| *n == f) {
                bits |= 1 << i;
            }
        }
        Self(bits)
    }

    /// `bitEnumClear(fmf, nnan | ninf)`.
    pub fn without_nan_inf(self) -> Self {
        Self(self.0 & !Self::NNAN_NINF)
    }

    /// `bitEnumContainsAll(fmf, nnan | ninf)`.
    pub fn finite(self) -> bool {
        self.0 & Self::NNAN_NINF == Self::NNAN_NINF
    }

    pub fn attr<'a>(self) -> Attribute<'a> {
        let body = match self.0 {
            0 => alloc::string::String::from("<none>"),
            0x7f => alloc::string::String::from("<fast>"),
            b => alloc::format!("<{}>", Self::NAMES.iter().enumerate().filter(|(i, _)| b & (1 << i) != 0).map(|(_, n)| *n).collect::<Vec<_>>().join(",")),
        };
        Attribute::dialect("arith.fastmath", &body)
    }

    /// `bitEnumContainsAll(fmf, afn)`.
    pub fn afn(self) -> bool {
        self.0 & Self::AFN != 0
    }
}
