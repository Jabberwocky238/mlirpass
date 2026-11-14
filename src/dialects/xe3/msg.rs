#[allow(unused_imports, reason = "the alloc prelude")]
use alloc::{borrow::ToOwned, boxed::Box, format, string::{String, ToString}, vec, vec::Vec};

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[repr(u8)]
pub enum Sfid {
    Null = 0,
    Sampler = 2,
    Gateway = 3,
    Render = 5,
    Urb = 6,
    Btd = 7,
    Pixel = 11,
    Tgm = 13,
    Slm = 14,
    Ugm = 15,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[repr(u8)]
pub enum LscOp {
    Load = 0,
    LoadCmask = 2,
    Store = 4,
    StoreCmask = 6,
    AtomicInc = 8,
    AtomicDec = 9,
    AtomicLoad = 10,
    AtomicStore = 11,
    AtomicAdd = 12,
    AtomicSub = 13,
    AtomicMin = 14,
    AtomicMax = 15,
    AtomicUmin = 16,
    AtomicUmax = 17,
    AtomicCmpxchg = 18,
    AtomicFadd = 19,
    AtomicAnd = 24,
    AtomicOr = 25,
    AtomicXor = 26,
    Fence = 31,
}

impl Sfid {
    pub fn of(shared: Option<bool>) -> Sfid {
        if shared == Some(true) { Sfid::Slm } else { Sfid::Ugm }
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[repr(u8)]
pub enum AddrSurface {
    Flat = 0,
    Bss = 1,
    Ss = 2,
    Bti = 3,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[repr(u8)]
pub enum AddrSize {
    A16 = 1,
    A32 = 2,
    A64 = 3,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[repr(u8)]
pub enum DataSize {
    D8 = 0,
    D16 = 1,
    D32 = 2,
    D64 = 3,
    D8U32 = 4,
    D16U32 = 5,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[repr(u8)]
pub enum VectSize {
    V1 = 0,
    V2 = 1,
    V3 = 2,
    V4 = 3,
    V8 = 4,
    V16 = 5,
    V32 = 6,
    V64 = 7,
}

pub struct CacheStore;

impl CacheStore {
    pub const DEFAULT: u8 = 0;
    pub const L1UC_L3UC: u8 = 2;
    pub const L1UC_L3WB: u8 = 4;
    pub const L1WT_L3UC: u8 = 6;
    pub const L1WT_L3WB: u8 = 8;
    pub const L1S_L3UC: u8 = 10;
    pub const L1S_L3WB: u8 = 12;
    pub const L1WB_L3WB: u8 = 14;
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Lsc {
    pub op: LscOp,
    pub surface: AddrSurface,
    pub addr_size: AddrSize,
    pub data_size: DataSize,
    pub cache: u8,
    pub vect_size: VectSize,
    pub transpose: bool,
    pub cmask: u8,
}

impl Lsc {
    pub const fn desc(&self) -> u32 {
        let mut d = (self.op as u32) | (self.surface as u32) << 29 | (self.addr_size as u32) << 7;
        d |= (self.data_size as u32) << 9 | (self.cache as u32) << 16;
        if matches!(self.op, LscOp::LoadCmask | LscOp::StoreCmask) {
            d |= (self.cmask as u32) << 12;
        } else {
            d |= (self.vect_size as u32) << 12 | (self.transpose as u32) << 15;
        }
        d
    }
}

impl super::SendInfo {
    pub const fn lengths(desc: u32, mlen: u32, rlen: u32) -> u32 {
        desc | (mlen & 0xf) << 25 | (rlen & 0x1f) << 20
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Sampler {
    pub msg_type: u8,
    pub simd_mode: u8,
    pub bti: u8,
    pub sampler: u8,
    pub return_hp: bool,
}

impl Sampler {
    pub const fn desc(&self) -> u32 {
        (self.bti as u32)
            | (self.sampler as u32 & 0xf) << 8
            | (self.msg_type as u32 & 0x1f) << 12
            | (self.simd_mode as u32 & 0x3) << 17
            | (self.simd_mode as u32 >> 2) << 29
            | (self.return_hp as u32) << 30
            | (self.msg_type as u32 >> 5) << 31
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Render {
    pub bti: u8,
    pub msg_ctrl: u8,
    pub msg_type: u8,
    pub coarse_write: bool,
}

impl Render {
    pub const fn desc(&self) -> u32 {
        (self.bti as u32) | (self.msg_ctrl as u32 & 0x3f) << 8 | (self.msg_type as u32 & 0xf) << 14 | (self.coarse_write as u32) << 18
    }
}
