//! `DataLayout`, as `DataLayoutInterfaces.cpp`: sizes and alignments of types. The default layout,
//! and of a `dlti.dl_spec` its pointer entries and endianness (no `llvm.data_layout` string).

use alloc::collections::BTreeMap;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, ShapedKind, Type};

use crate::{Body, OpId};

/// ⭐ A data layout; [`Default`]: what MLIR assumes with no spec.
#[derive(Debug, Clone, PartialEq, Eq, Default)]
pub struct DataLayout {
    /// `!llvm.ptr<space>` entries: (size, ABI alignment), in bits.
    pointers: BTreeMap<u32, (u64, u64)>,
    /// `"dlti.endianness" = "big"`.
    big_endian: bool,
}

impl DataLayout {
    /// `DataLayout::closest(op)`: the `dlti.dl_spec` of `op` or its nearest ancestor.
    pub fn closest(body: &Body<'_>, op: OpId) -> Self {
        let mut at = Some(op);
        while let Some(o) = at {
            if let Some(Attribute::Extended { ext, .. }) = body[o].get("dlti.dl_spec") {
                return Self::of_spec(ext.body.as_deref().unwrap_or(""));
            }
            at = body.parent_op(o);
        }
        Self::default()
    }

    /// The entries of a `#dlti.dl_spec<...>` body this layout knows.
    fn of_spec(spec: &str) -> Self {
        let mut dl = Self { big_endian: spec.contains(r#""dlti.endianness" = "big""#), ..Self::default() };
        for (_, rest) in spec.match_indices("!llvm.ptr").map(|(i, _)| ((), &spec[i + "!llvm.ptr".len()..])) {
            let (space, rest) = match rest.strip_prefix('<') {
                Some(r) => {
                    let end = r.find('>').unwrap_or(0);
                    (r[..end].trim().parse().unwrap_or(0), &r[end + 1..])
                }
                None => (0, rest),
            };
            let Some(values) = rest.trim_start().strip_prefix("= dense<") else { continue };
            let values = values.split('>').next().unwrap_or("").trim_matches(|c| c == '[' || c == ']');
            let bits: Vec<u64> = values.split(',').filter_map(|v| v.trim().parse().ok()).collect();
            if let Some(&size) = bits.first() {
                dl.pointers.insert(space, (size, bits.get(1).copied().unwrap_or(size)));
            }
        }
        dl
    }

    /// Whether the spec says `"dlti.endianness" = "big"`.
    pub fn big_endian(&self) -> bool {
        self.big_endian
    }

    /// `getTypeSizeInBits`; panics where MLIR reports a missing layout.
    pub fn size_in_bits(&self, ty: &Type<'_>) -> u64 {
        self.try_bits(ty).unwrap_or_else(|| Self::missing(ty))
    }

    /// `getTypeSize`, in bytes.
    pub fn size(&self, ty: &Type<'_>) -> u64 {
        self.size_in_bits(ty).div_ceil(8)
    }

    /// `getTypeABIAlignment`, in bytes.
    pub fn abi_align(&self, ty: &Type<'_>) -> u64 {
        self.try_abi_align(ty).unwrap_or_else(|| Self::missing(ty))
    }

    /// `getTypePreferredAlignment`, in bytes.
    pub fn preferred_align(&self, ty: &Type<'_>) -> u64 {
        self.try_preferred_align(ty).unwrap_or_else(|| Self::missing(ty))
    }

    /// `reportMissingDataLayout`.
    fn missing(ty: &Type<'_>) -> ! {
        panic!("neither the scoping op nor the type class provide data layout information for {ty}")
    }

    fn try_size(&self, ty: &Type<'_>) -> Option<u64> {
        Some(self.try_bits(ty)?.div_ceil(8))
    }

    fn try_bits(&self, ty: &Type<'_>) -> Option<u64> {
        Some(match ty {
            Type::Integer { width, .. } => u64::from(*width),
            Type::Float(_) => u64::from(ty.bit_width()?),
            // `index` is an integer of the default index bitwidth.
            Type::Index => 64,
            Type::Complex(et) => {
                let inner = self.try_bits(et)?;
                inner.next_multiple_of(self.try_preferred_align(et)? * 8) + inner
            }
            // Rounded up to a power of two elements in the innermost dimension.
            Type::Shaped(s) if s.kind == ShapedKind::Vector => {
                let dims = s.dims()?;
                let (n, last) = (dims.iter().product::<i64>() as u64, *dims.last()? as u64);
                n / last * last.next_power_of_two() * self.try_size(&s.elem)? * 8
            }
            _ => match LlvmType::try_from(ty).ok()? {
                LlvmType::Ptr(space) => self.pointers.get(&space).map_or(64, |p| p.0),
                LlvmType::Array(n, et) => self.try_size(&et)?.next_multiple_of(self.try_abi_align(&et)?) * n * 8,
                LlvmType::Struct { packed, body: Some(body), .. } => {
                    let (mut size, mut align) = (0u64, 1);
                    for e in &body {
                        let a = if packed { 1 } else { self.try_abi_align(e)? };
                        size = size.next_multiple_of(a) + self.try_size(e)?;
                        align = align.max(a);
                    }
                    size.next_multiple_of(align) * 8
                }
                _ => return None,
            },
        })
    }

    fn try_abi_align(&self, ty: &Type<'_>) -> Option<u64> {
        Some(match ty {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => self.try_size(ty)?.next_power_of_two(),
            Type::Float(_) => self.try_size(ty)?.next_power_of_two(),
            Type::Index => self.try_abi_align(&Type::int(64))?,
            // Integers of 64 bits and more are 4-aligned by default.
            Type::Integer { width, .. } if *width < 64 => u64::from(width.div_ceil(8)).next_power_of_two(),
            Type::Integer { .. } => 4,
            Type::Complex(et) => self.try_abi_align(et)?,
            _ => match LlvmType::try_from(ty).ok()? {
                LlvmType::Ptr(space) => self.pointers.get(&space).map_or(8, |p| p.1 / 8),
                LlvmType::Array(_, et) => self.try_abi_align(&et)?,
                LlvmType::Struct { packed: true, body: Some(_), .. } => 1,
                LlvmType::Struct { body: Some(body), .. } => body.iter().try_fold(1, |a, e| Some(a.max(self.try_abi_align(e)?)))?,
                _ => return None,
            },
        })
    }

    fn try_preferred_align(&self, ty: &Type<'_>) -> Option<u64> {
        match ty {
            Type::Integer { .. } => Some(self.try_size(ty)?.next_power_of_two()),
            Type::Index => self.try_preferred_align(&Type::int(64)),
            Type::Complex(et) => self.try_preferred_align(et),
            _ => self.try_abi_align(ty),
        }
    }
}
