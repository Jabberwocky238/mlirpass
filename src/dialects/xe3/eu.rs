//! Xe2 / Xe3 EU instructions (Lunar Lake, Battlemage, Panther Lake): the instruction as data (`Inst`, what an
//! `xe3.eu.*` op says, see `asm.rs`) and its native 128-bit encoding (`Inst::encode`). Bit positions are Mesa's `src/intel/compiler/gen/xe.json` ("Xe2", which is
//! "Xe" with its overrides); the rules for filling them follow Mesa's `gen_encoding.cpp`. Compacted (64-bit) forms
//! are not produced.
//!
//! Registers: a GRF is 64 bytes, there are 128 of them (256 with the large GRF mode); `subnr` is in bytes.

#[allow(unused_imports, reason = "the alloc prelude")]
use alloc::{borrow::ToOwned, boxed::Box, format, string::{String, ToString}, vec, vec::Vec};

/// A register type (Mesa `gen_reg_type`): bits 1:0 size (8 << x bits), bits 3:2 base (uint / sint / float /
/// bfloat), bit 4 vector immediate.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[repr(u8)]
pub enum Elem {
    UB = 0b00000,
    UW = 0b00001,
    UD = 0b00010,
    UQ = 0b00011,
    B = 0b00100,
    W = 0b00101,
    D = 0b00110,
    Q = 0b00111,
    HF = 0b01001,
    F = 0b01010,
    DF = 0b01011,
    BF = 0b01101,
    /// 8 x u4 immediate
    UV = 0b10001,
    /// 8 x i4 immediate
    V = 0b10101,
    /// 4 x restricted 8-bit float immediate
    VF = 0b11010,
}

impl Elem {
    pub const fn size(self) -> u32 {
        match self {
            Elem::UV | Elem::V | Elem::VF => 4,
            t => 1 << (t as u8 & 3),
        }
    }

    pub const fn is_float(self) -> bool {
        (self as u8 & 0b01000) != 0 && (self as u8 & 0b10000) == 0
    }

    /// The 4-bit type field of one / two source instructions.
    const fn code(self) -> u64 {
        match self {
            Elem::UV | Elem::V | Elem::VF => (self as u8 & !(0b10000 | 0b00011)) as u64,
            t => (t as u8 & 0b01111) as u64,
        }
    }

    /// The 3-bit type field of three source instructions (the exec data type bit tells float from int).
    const fn code3(self) -> u64 {
        match self {
            Elem::UB => 0b000,
            Elem::UW => 0b001,
            Elem::UD => 0b010,
            Elem::UQ => 0b011,
            Elem::B => 0b100,
            Elem::W => 0b101,
            Elem::D => 0b110,
            Elem::Q => 0b111,
            Elem::HF => 0b001,
            Elem::F => 0b010,
            Elem::DF => 0b011,
            Elem::BF => 0b101,
            Elem::UV | Elem::V | Elem::VF => panic!("vector immediate in a three source instruction"),
        }
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum File {
    Arf,
    Grf,
    Imm,
}

/// Architecture register numbers (the high nibble picks the register, the low one its number).
pub struct Arf;

impl Arf {
    pub const NULL: u8 = 0x00;
    pub const ADDRESS: u8 = 0x10;
    pub const ACCUMULATOR: u8 = 0x20;
    pub const FLAG: u8 = 0x30;
    pub const MASK: u8 = 0x40;
    pub const SCALAR: u8 = 0x60;
    pub const STATE: u8 = 0x70;
    pub const CONTROL: u8 = 0x80;
    pub const NOTIFICATION_COUNT: u8 = 0x90;
    pub const IP: u8 = 0xa0;
    pub const TDR: u8 = 0xb0;
    pub const TIMESTAMP: u8 = 0xc0;
}

/// A source region `<vstride;width,hstride>` (in elements); a destination uses only `hstride`.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Region {
    pub vstride: u8,
    pub width: u8,
    pub hstride: u8,
}

impl Region {
    pub const fn new(vstride: u8, width: u8, hstride: u8) -> Region {
        Region { vstride, width, hstride }
    }
    /// `<0;1,0>`: one value for every channel.
    pub const SCALAR: Region = Region::new(0, 1, 0);

    /// Elements from one channel to the next (within a row).
    pub const fn step(self) -> u8 {
        if self.width == 1 { self.vstride } else { self.hstride }
    }
}

#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Operand {
    pub file: File,
    pub ty: Elem,
    pub nr: u8,
    /// byte offset in the register
    pub subnr: u8,
    pub region: Region,
    pub negate: bool,
    pub abs: bool,
    /// immediate bits (File::Imm)
    pub imm: u64,
}

impl Operand {
    /// `r<nr>` as `ty`, with the region a SIMD instruction reads contiguous elements with (`<w;w,1>` of a full
    /// register's worth would be the same; `<1;1,0>` is how Mesa writes it for any width).
    pub const fn grf(nr: u8, ty: Elem) -> Operand {
        Operand {
            file: File::Grf,
            ty,
            nr,
            subnr: 0,
            region: Region::new(1, 1, 0),
            negate: false,
            abs: false,
            imm: 0,
        }
    }

    pub const fn arf(nr: u8, ty: Elem) -> Operand {
        Operand { file: File::Arf, ..Operand::grf(nr, ty) }
    }

    pub const fn null() -> Operand {
        Operand::arf(Arf::NULL, Elem::UD)
    }

    pub const fn imm(ty: Elem, bits: u64) -> Operand {
        Operand { file: File::Imm, imm: bits, region: Region::SCALAR, ..Operand::grf(0, ty) }
    }

    /// Byte offset `subnr` into the register.
    pub const fn sub(mut self, subnr: u8) -> Operand {
        self.subnr = subnr;
        self
    }

    pub const fn ty(mut self, ty: Elem) -> Operand {
        self.ty = ty;
        self
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Format {
    One,
    Two,
    Three,
    Send,
    Branch1,
    Branch2,
    Nop,
    /// DPAS: three sources, the systolic depth and repeat count in place of the regions
    Dpas,
}

macro_rules! opcodes {
    ($($name:ident = $hw:expr, $format:ident;)*) => {
        /// Xe2 / Xe3 opcodes (Mesa gen_opcodes.py, the "xe2" column).
        #[derive(Clone, Copy, Debug, PartialEq, Eq)]
        pub enum Opcode { $($name),* }

        impl Opcode {
            pub const fn hw(self) -> u64 {
                match self { $(Opcode::$name => $hw),* }
            }
            pub const fn format(self) -> Format {
                match self { $(Opcode::$name => Format::$format),* }
            }

            /// Every opcode.
            pub const ALL: &[Opcode] = &[$(Opcode::$name),*];

            /// The mnemonic (lower case; `NopOp` is `nop`, `Nop` the illegal opcode's format).
            pub fn mnemonic(self) -> String {
                #[allow(unreachable_patterns, reason = "NopOp is spelled nop")]
                match self {
                    Opcode::NopOp => "nop".into(),
                    $(Opcode::$name => stringify!($name).to_ascii_lowercase()),*
                }
            }
        }
    };
}

opcodes! {
    Illegal = 0, Nop;
    Bfrev = 119, One;
    Cbit = 77, One;
    Fbh = 75, One;
    Fbl = 76, One;
    Frc = 67, One;
    Lzd = 74, One;
    Mov = 97, One;
    Not = 100, One;
    Rndd = 69, One;
    Rnde = 70, One;
    Rndu = 68, One;
    Rndz = 71, One;
    Sync = 1, One;
    Wait = 48, One;
    Add = 64, Two;
    Addc = 78, Two;
    And = 101, Two;
    Asr = 108, Two;
    Avg = 66, Two;
    Bfi1 = 121, Two;
    Cmp = 112, Two;
    Cmpn = 113, Two;
    Mac = 72, Two;
    Mach = 73, Two;
    Macl = 83, Two;
    Math = 56, Two;
    Movi = 99, Two;
    Mul = 65, Two;
    Or = 102, Two;
    Rol = 111, Two;
    Ror = 110, Two;
    Sel = 98, Two;
    Shl = 105, Two;
    Shr = 104, Two;
    Smov = 106, Two;
    Srnd = 84, Two;
    Subb = 79, Two;
    Xor = 103, Two;
    Add3 = 82, Three;
    Bfe = 120, Three;
    Bfi2 = 122, Three;
    Bfn = 107, Three;
    Csel = 114, Three;
    Dp4a = 88, Three;
    Mad = 91, Three;
    Dpas = 89, Dpas;
    Madm = 93, Three;
    Send = 49, Send;
    Sendc = 50, Send;
    Brd = 33, Branch1;
    Call = 44, Branch1;
    Calla = 43, Branch1;
    Endif = 37, Branch1;
    Jmpi = 32, Branch1;
    Join = 47, Branch1;
    Ret = 45, Branch1;
    While = 39, Branch1;
    Brc = 35, Branch2;
    Break = 40, Branch2;
    Continue = 41, Branch2;
    Else = 36, Branch2;
    Goto = 46, Branch2;
    Halt = 42, Branch2;
    If = 34, Branch2;
    NopOp = 96, Nop;
}

impl Opcode {
    fn has_dst(self) -> bool {
        !matches!(self.format(), Format::Branch1 | Format::Branch2 | Format::Nop) && !matches!(self, Opcode::Sync | Opcode::Smov)
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Default)]
#[repr(u8)]
pub enum Cond {
    #[default]
    None = 0,
    Z = 1,
    Nz = 2,
    Gt = 3,
    Ge = 4,
    Lt = 5,
    Le = 6,
    Ov = 8,
    Un = 9,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Default)]
#[repr(u8)]
pub enum Pred {
    #[default]
    None = 0,
    Normal = 1,
    /// any channel of the execution group (Xe2: one predicate for the whole instruction)
    Any = 2,
    All = 3,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[repr(u8)]
pub enum MathFn {
    Inv = 1,
    Log = 2,
    Exp = 3,
    Sqrt = 4,
    Rsq = 5,
    Sin = 6,
    Cos = 7,
    // no POW (10) or FDIV (9) since Xe-HPG: pow is exp(y * log(x))
    IntDivBoth = 11,
    IntDivQuotient = 12,
    IntDivRemainder = 13,
    Invm = 14,
    Rsqrtm = 15,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
#[repr(u8)]
pub enum SyncFn {
    Nop = 0x0,
    AllRd = 0x2,
    AllWr = 0x3,
    Fence = 0xd,
    Bar = 0xe,
    Host = 0xf,
}

/// The ALU pipe an in-order dependency is on.
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Default)]
pub enum Pipe {
    /// the previous instruction's pipe (no pipe given)
    #[default]
    None,
    Float,
    Int,
    Long,
    Math,
    Scalar,
    All,
}

/// Software scoreboard (Xe2: 32 SBIDs, register distances up to 7).
#[derive(Clone, Copy, Debug, PartialEq, Eq, Default)]
pub struct Swsb {
    /// wait until the instruction `regdist` back on `pipe` has finished (0: none)
    pub regdist: u8,
    pub pipe: Pipe,
    pub sbid: u8,
    pub mode: SbidMode,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Default)]
pub enum SbidMode {
    #[default]
    Null,
    /// wait until the out-of-order instruction with `sbid` has read its sources
    Src,
    /// wait until it has written its destination
    Dst,
    /// this (out-of-order) instruction takes `sbid`
    Set,
}

impl Swsb {
    pub const NONE: Swsb = Swsb { regdist: 0, pipe: Pipe::None, sbid: 0, mode: SbidMode::Null };

    pub const fn regdist(pipe: Pipe, n: u8) -> Swsb {
        Swsb { regdist: n, pipe, sbid: 0, mode: SbidMode::Null }
    }

    /// Mesa gen_swsb_encode, ver >= 20.
    fn encode(self, op: Opcode) -> u64 {
        let pipe = match self.pipe {
            Pipe::Float => 0x10,
            Pipe::Int => 0x18,
            Pipe::Long => 0x20,
            Pipe::Math => 0x28,
            Pipe::Scalar => 0x30,
            Pipe::All => 0x08,
            Pipe::None => 0,
        };
        let (rd, sbid) = (self.regdist as u64, self.sbid as u64);
        match self.mode {
            SbidMode::Null => pipe | rd,
            _ if rd != 0 => {
                let mode = match self.mode {
                    _ if matches!(op, Opcode::Dpas) => match self.mode {
                        SbidMode::Set => 0b01,
                        SbidMode::Src => 0b10,
                        _ => 0b11,
                    },
                    SbidMode::Set => {
                        debug_assert!(matches!(op, Opcode::Send | Opcode::Sendc));
                        match self.pipe {
                            Pipe::Int => 0b11,
                            Pipe::Float => 0b10,
                            _ => 0b01,
                        }
                    }
                    _ if self.pipe == Pipe::All => 0b11,
                    SbidMode::Src => 0b10,
                    _ => 0b01,
                };
                mode << 8 | rd << 5 | sbid
            }
            SbidMode::Set => sbid | 0xc0,
            SbidMode::Dst => sbid | 0x80,
            SbidMode::Src => sbid | 0xa0,
        }
    }
}

/// The shape of a DPAS (Mesa `gen_inst.dpas`): `dst = src0 + src1 * src2` over a systolic array `sdepth` deep,
/// repeated `rcount` times (rows of the result). src1 is B (`sdepth` registers of packed K pairs / quads, one column
/// per channel), src2 is A (`rcount` rows of `sdepth` dwords).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Dpas {
    /// 2, 4, 8 or 16 (Xe2 / Xe3: 8)
    pub sdepth: u8,
    /// 1 ..= 8
    pub rcount: u8,
    /// sub-byte precision of src1 / src2 (0: none, 1: u4 / s4, 2: u2 / s2)
    pub src1_subbyte: u8,
    pub src2_subbyte: u8,
}

impl Dpas {
    pub const DEFAULT: Dpas = Dpas { sdepth: 8, rcount: 8, src1_subbyte: 0, src2_subbyte: 0 };

    /// Mesa `encode_sdepth`.
    const fn sdepth_code(self) -> u64 {
        match self.sdepth {
            16 => 0,
            2 => 1,
            4 => 2,
            8 => 3,
            _ => panic!("systolic depth is 2, 4, 8 or 16"),
        }
    }
}

/// What a SEND carries besides its operands.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Default)]
pub struct SendInfo {
    pub sfid: u8,
    /// message descriptor (see `msg`)
    pub desc: u32,
    /// extended descriptor (immediate); bits 10:0 must be zero: bits 10:6 are where `src1_len` goes
    pub ex_desc: u32,
    /// registers in src1
    pub src1_len: u8,
    pub eot: bool,
    /// extended descriptor is bindless surface offset (ExBSO)
    pub ex_bso: bool,
}

#[derive(Clone, Copy, Debug, PartialEq)]
pub struct Inst {
    pub op: Opcode,
    pub exec_size: u8,
    /// first channel (multiple of 8)
    pub chan_offset: u8,
    pub cond: Cond,
    pub pred: Pred,
    pub pred_inv: bool,
    /// flag register (f0 / f1 / ...) and subregister for `pred` and `cond`
    pub flag: (u8, u8),
    pub saturate: bool,
    /// write all channels, ignoring the execution mask (`(W)`)
    pub no_mask: bool,
    pub atomic: bool,
    pub swsb: Swsb,
    pub dst: Operand,
    pub src: [Operand; 3],
    pub math: Option<MathFn>,
    pub sync: SyncFn,
    pub bfn_ctrl: u8,
    pub send: SendInfo,
    pub dpas: Dpas,
    /// branches: jump targets, in bytes from this instruction
    pub jip: i32,
    pub uip: i32,
    pub branch_ctrl: bool,
}

impl Inst {
    pub const fn new(op: Opcode, exec_size: u8) -> Inst {
        Inst {
            op,
            exec_size,
            chan_offset: 0,
            cond: Cond::None,
            pred: Pred::None,
            pred_inv: false,
            flag: (0, 0),
            saturate: false,
            no_mask: false,
            atomic: false,
            swsb: Swsb::NONE,
            dst: Operand::null(),
            src: [Operand::null(); 3],
            math: None,
            sync: SyncFn::Nop,
            bfn_ctrl: 0,
            send: SendInfo { sfid: 0, desc: 0, ex_desc: 0, src1_len: 0, eot: false, ex_bso: false },
            dpas: Dpas::DEFAULT,
            jip: 0,
            uip: 0,
            branch_ctrl: false,
        }
    }

    /// The native (uncompacted) 16 bytes.
    pub fn encode(&self) -> [u8; 16] {
        let mut e = Enc([0; 2]);
        e.inst(self);
        (u128::from(e.0[1]) << 64 | u128::from(e.0[0])).to_le_bytes()
    }
}

/// Bit fields of the native Xe2 instruction: (high bit, low bit). The whole table, used or not.
#[allow(dead_code)]
mod f {
    pub type F = (u32, u32);
    pub const HW_OPCODE: F = (6, 0);
    pub const SWSB: F = (17, 8);
    pub const EXEC_SIZE: F = (20, 18);
    pub const FLAG_SUBNR: F = (21, 21);
    pub const FLAG_NR: F = (23, 22);
    pub const CHAN_OFFSET: F = (25, 24);
    pub const PRED_CONTROL: F = (27, 26);
    pub const PRED_INV: F = (28, 28);
    pub const DEBUG_CONTROL: F = (30, 30);
    pub const NO_MASK: F = (31, 31);
    pub const ATOMIC_CONTROL: F = (32, 32);
    pub const BRANCH_CONTROL: F = (33, 33);
    pub const DST_OPERAND_EXTRA: F = (33, 33);
    pub const SATURATE: F = (34, 34);
    pub const DST_ADDRESS_MODE: F = (35, 35);
    pub const DST_TYPE: F = (39, 36);
    pub const SRC0_TYPE: F = (43, 40);
    pub const SRC0_ABS: F = (44, 44);
    pub const SRC0_NEGATE: F = (45, 45);
    pub const SRC0_IS_IMM: F = (46, 46);
    pub const SRC1_IS_IMM: F = (47, 47);
    pub const DST_HSTRIDE: F = (49, 48);
    pub const DST_OPERAND: F = (63, 50);
    pub const SRC0_HSTRIDE: F = (65, 64);
    pub const SRC0_OPERAND: F = (79, 66);
    pub const SRC0_ADDRESS_MODE: F = (80, 80);
    pub const SRC0_WIDTH: F = (83, 81);
    pub const SRC0_VSTRIDE: F = (86, 84);
    pub const SRC0_OPERAND_EXTRA: F = (87, 87);
    pub const SRC1_TYPE: F = (91, 88);
    pub const COND_MODIFIER: F = (95, 92);
    pub const SRC1_HSTRIDE: F = (97, 96);
    pub const SRC1_OPERAND: F = (111, 98);
    pub const SRC1_ADDRESS_MODE: F = (112, 112);
    pub const SRC1_WIDTH: F = (115, 113);
    pub const SRC1_VSTRIDE: F = (118, 116);
    pub const SRC1_ABS: F = (120, 120);
    pub const SRC1_NEGATE: F = (121, 121);
    pub const IMM_LO_32: F = (127, 96);
    pub const IMM_HI_32: F = (95, 64);

    pub const THREE_DST_TYPE: F = (38, 36);
    pub const THREE_EXEC_DATA_TYPE: F = (39, 39);
    pub const THREE_SRC0_TYPE: F = (42, 40);
    /// two pieces: (43) high, (35) low
    pub const THREE_SRC0_VSTRIDE: [F; 2] = [(43, 43), (35, 35)];
    pub const THREE_SRC2_IS_IMM: F = (47, 47);
    pub const THREE_DST_HSTRIDE: F = (48, 48);
    pub const THREE_DST_OPERAND: F = (63, 50);
    pub const THREE_SRC0_HSTRIDE: F = (65, 64);
    pub const THREE_SRC0_OPERAND: F = (79, 66);
    pub const THREE_SRC2_TYPE: F = (82, 80);
    pub const THREE_SRC2_ABS: F = (84, 84);
    pub const THREE_SRC2_NEGATE: F = (85, 85);
    pub const THREE_SRC1_ABS: F = (86, 86);
    pub const THREE_SRC1_NEGATE: F = (87, 87);
    pub const THREE_SRC1_TYPE: F = (90, 88);
    pub const THREE_SRC1_VSTRIDE: [F; 2] = [(91, 91), (83, 83)];
    pub const THREE_SRC1_HSTRIDE: F = (97, 96);
    pub const THREE_SRC1_OPERAND: F = (111, 98);
    pub const THREE_SRC2_HSTRIDE: F = (113, 112);
    pub const THREE_SRC2_OPERAND: F = (127, 114);
    pub const THREE_SRC0_IMM: F = (79, 64);
    pub const THREE_SRC2_IMM: F = (127, 112);

    pub const MATH_FC: F = (95, 92);
    pub const SYNC_CTRL: F = (95, 92);
    pub const BFN_COND_MODIFIER: F = (45, 44);

    pub const DPAS_RCOUNT: F = (45, 43);
    pub const DPAS_SDEPTH: F = (49, 48);
    pub const DPAS_SRC2_SUBBYTE: F = (85, 84);
    pub const DPAS_SRC1_SUBBYTE: F = (87, 86);
    pub const BFN_FUNC_CONTROL: [F; 2] = [(95, 92), (87, 84)];

    pub const SEND_EOT: F = (34, 34);
    pub const SEND_EX_BSO: F = (39, 39);
    pub const SEND_DESC_IS_REG: F = (48, 48);
    pub const SEND_EX_DESC_IS_REG: F = (49, 49);
    pub const SEND_SFID: F = (95, 92);
    pub const SEND_SRC1_LEN: F = (103, 99);
}

struct Enc([u64; 2]);

impl Enc {
    /// log2 + 1 of a power of two (0 stays 0): Mesa `cvt`.
    fn cvt(v: u8) -> u64 {
        if v == 0 { 0 } else { v.trailing_zeros() as u64 + 1 }
    }

    /// Mesa ENCODE_VSTRIDE_3SRC: 0, 1 (also for 2), 4, 8 (also for 16).
    fn vstride3(v: u8) -> u64 {
        match v {
            0 => 0,
            1 | 2 => 1,
            4 => 2,
            _ => 3,
        }
    }

    #[inline]
    fn set(&mut self, (hi, lo): f::F, v: u64) {
        debug_assert!(hi / 64 == lo / 64, "field crosses a qword");
        let w = hi - lo + 1;
        debug_assert!(w == 64 || v >> w == 0, "value {v:#x} too wide for bits {hi}:{lo}");
        let mask = if w == 64 { u64::MAX } else { ((1u64 << w) - 1) << (lo % 64) };
        let q = &mut self.0[(hi / 64) as usize];
        *q = (*q & !mask) | (v << (lo % 64));
    }

    /// A field in two pieces: the low bits go in `parts[1]`, the rest in `parts[0]`.
    fn set2(&mut self, parts: [f::F; 2], v: u64) {
        let lo_bits = parts[1].0 - parts[1].1 + 1;
        self.set(parts[1], v & ((1 << lo_bits) - 1));
        self.set(parts[0], v >> lo_bits);
    }

    /// A sub-range of a field, relative to its low bit.
    fn sub(field: f::F, hi: u32, lo: u32) -> f::F {
        (field.1 + hi, field.1 + lo)
    }

    fn direct(&mut self, field: f::F, o: &Operand, skip_subnr: bool) {
        self.set(Self::sub(field, 0, 0), (o.file == File::Grf) as u64);
        if !skip_subnr {
            self.set(Self::sub(field, 5, 1), (o.subnr >> 1) as u64);
        }
        self.set(Self::sub(field, 13, 6), o.nr as u64);
    }

    fn vstride(v: u8) -> u64 {
        // one-dimensional (0xff) is 0xf, masked to the 3 bits Xe2 has
        (if v == 0xff { 0xf } else { Self::cvt(v) }) & 0x7
    }

    fn inst(&mut self, i: &Inst) {
        let format = i.op.format();
        self.set(f::HW_OPCODE, i.op.hw());
        self.set(f::SWSB, i.swsb.encode(i.op));
        self.set(f::EXEC_SIZE, if i.exec_size == 0 { 0 } else { Self::cvt(i.exec_size) - 1 });
        self.set(f::FLAG_SUBNR, i.flag.1 as u64);
        self.set(f::FLAG_NR, i.flag.0 as u64);
        self.set(f::PRED_CONTROL, i.pred as u64);
        self.set(f::PRED_INV, i.pred_inv as u64);
        self.set(f::NO_MASK, i.no_mask as u64);
        self.set(f::ATOMIC_CONTROL, i.atomic as u64);
        self.set(f::CHAN_OFFSET, (i.chan_offset / 8) as u64);

        if matches!(format, Format::One | Format::Two | Format::Dpas) || (format == Format::Three && i.op != Opcode::Bfn) {
            self.set(f::SATURATE, i.saturate as u64);
        }
        if i.op == Opcode::Math {
            self.set(f::MATH_FC, i.math.expect("math without a function") as u64);
        } else if i.op == Opcode::Sync {
            self.set(f::SYNC_CTRL, i.sync as u64);
        } else if i.op == Opcode::Bfn {
            let c = match i.cond {
                Cond::Z => 1,
                Cond::Gt => 2,
                Cond::Lt => 3,
                _ => 0,
            };
            self.set(f::BFN_COND_MODIFIER, c);
        } else {
            let has_cond = match format {
                // a 64-bit immediate overlays the field
                Format::One => !(i.src[0].file == File::Imm && i.src[0].ty.size() >= 8),
                Format::Two | Format::Three | Format::Dpas => true,
                _ => false,
            };
            if has_cond {
                self.set(f::COND_MODIFIER, i.cond as u64);
            }
        }

        match format {
            Format::One | Format::Two => {
                if i.op.has_dst() {
                    let d = &i.dst;
                    self.set(f::DST_TYPE, d.ty.code());
                    self.direct(f::DST_OPERAND, d, false);
                    self.set(f::DST_OPERAND_EXTRA, (d.subnr & 1) as u64);
                }
                // a destination stride of 0 does not exist: 0 is the operand constructors' default, meaning 1
                self.set(f::DST_HSTRIDE, Self::cvt(i.dst.region.hstride.max(1)));
                self.set(f::SRC0_TYPE, i.src[0].ty.code());
                let mut imm = None;
                let s0 = &i.src[0];
                if s0.file == File::Imm {
                    imm = Some(s0);
                    self.set(f::SRC0_IS_IMM, 1);
                } else {
                    self.set(f::SRC0_NEGATE, s0.negate as u64);
                    self.set(f::SRC0_ABS, s0.abs as u64);
                    self.direct(f::SRC0_OPERAND, s0, false);
                    self.set(f::SRC0_OPERAND_EXTRA, (s0.subnr & 1) as u64);
                    self.set(f::SRC0_VSTRIDE, Self::vstride(s0.region.vstride));
                    self.set(f::SRC0_WIDTH, Self::cvt(s0.region.width) - 1);
                    self.set(f::SRC0_HSTRIDE, Self::cvt(s0.region.hstride));
                }
                if format == Format::Two {
                    let s1 = &i.src[1];
                    self.set(f::SRC1_TYPE, s1.ty.code());
                    if s1.file == File::Imm {
                        assert!(imm.is_none(), "two immediates");
                        imm = Some(s1);
                        self.set(f::SRC1_IS_IMM, 1);
                    } else {
                        self.set(f::SRC1_NEGATE, s1.negate as u64);
                        self.set(f::SRC1_ABS, s1.abs as u64);
                        self.direct(f::SRC1_OPERAND, s1, false);
                        self.set(f::SRC1_VSTRIDE, Self::vstride(s1.region.vstride));
                        self.set(f::SRC1_WIDTH, Self::cvt(s1.region.width) - 1);
                        self.set(f::SRC1_HSTRIDE, Self::cvt(s1.region.hstride));
                    }
                }
                if let Some(o) = imm {
                    self.set(f::IMM_LO_32, o.imm & 0xffff_ffff);
                    if o.ty.size() > 4 {
                        self.set(f::IMM_HI_32, o.imm >> 32);
                    }
                }
            }
            Format::Three => {
                let [s0, s1, s2] = &i.src;
                self.set(f::THREE_EXEC_DATA_TYPE, i.dst.ty.is_float() as u64);
                self.set(f::THREE_DST_TYPE, i.dst.ty.code3());
                self.set(f::THREE_SRC0_TYPE, s0.ty.code3());
                self.set(f::THREE_SRC1_TYPE, s1.ty.code3());
                self.set(f::THREE_SRC2_TYPE, s2.ty.code3());
                self.direct(f::THREE_DST_OPERAND, &i.dst, false);
                self.set(f::THREE_DST_HSTRIDE, (i.dst.region.hstride.max(1) != 1) as u64);
                if s0.file == File::Imm {
                    self.set(f::SRC0_IS_IMM, 1);
                    self.set(f::THREE_SRC0_IMM, s0.imm & 0xffff);
                } else {
                    self.direct(f::THREE_SRC0_OPERAND, s0, false);
                    self.set2(f::THREE_SRC0_VSTRIDE, Self::vstride3(s0.region.vstride));
                    self.set(f::THREE_SRC0_HSTRIDE, Self::cvt(s0.region.hstride));
                }
                self.direct(f::THREE_SRC1_OPERAND, s1, false);
                self.set2(f::THREE_SRC1_VSTRIDE, Self::vstride3(s1.region.vstride));
                self.set(f::THREE_SRC1_HSTRIDE, Self::cvt(s1.region.hstride));
                if s2.file == File::Imm {
                    self.set(f::THREE_SRC2_IS_IMM, 1);
                    self.set(f::THREE_SRC2_IMM, s2.imm & 0xffff);
                } else {
                    // src2 has only a horizontal stride: the region's step from one channel to the next
                    self.direct(f::THREE_SRC2_OPERAND, s2, false);
                    self.set(f::THREE_SRC2_HSTRIDE, Self::cvt(s2.region.step()));
                }
                if i.op != Opcode::Bfn {
                    self.set(f::SRC0_NEGATE, s0.negate as u64);
                    self.set(f::THREE_SRC1_NEGATE, s1.negate as u64);
                    self.set(f::THREE_SRC2_NEGATE, s2.negate as u64);
                    self.set(f::SRC0_ABS, s0.abs as u64);
                    self.set(f::THREE_SRC1_ABS, s1.abs as u64);
                    self.set(f::THREE_SRC2_ABS, s2.abs as u64);
                } else {
                    self.set2(f::BFN_FUNC_CONTROL, i.bfn_ctrl as u64);
                }
            }
            Format::Dpas => {
                let [s0, s1, s2] = &i.src;
                self.set(f::DPAS_RCOUNT, (i.dpas.rcount - 1) as u64);
                self.set(f::DPAS_SDEPTH, i.dpas.sdepth_code());
                self.set(f::THREE_EXEC_DATA_TYPE, i.dst.ty.is_float() as u64);
                self.set(f::THREE_DST_TYPE, i.dst.ty.code3());
                self.set(f::THREE_SRC0_TYPE, s0.ty.code3());
                self.set(f::THREE_SRC1_TYPE, s1.ty.code3());
                self.set(f::THREE_SRC2_TYPE, s2.ty.code3());
                self.set(f::DPAS_SRC1_SUBBYTE, i.dpas.src1_subbyte as u64);
                self.set(f::DPAS_SRC2_SUBBYTE, i.dpas.src2_subbyte as u64);
                self.direct(f::THREE_DST_OPERAND, &i.dst, false);
                self.direct(f::THREE_SRC0_OPERAND, s0, false);
                self.direct(f::THREE_SRC1_OPERAND, s1, false);
                self.direct(f::THREE_SRC2_OPERAND, s2, false);
            }
            Format::Send => {
                let s = &i.send;
                self.set(f::SEND_EOT, s.eot as u64);
                self.set(f::SEND_SFID, s.sfid as u64);
                self.direct(f::DST_OPERAND, &i.dst, true);
                self.direct(f::SRC0_OPERAND, &i.src[0], true);
                self.direct(f::SRC1_OPERAND, &i.src[1], true);
                // UGM on Xe2 always has ExBSO (BSpec 56890): the bit does not exist there
                if s.ex_bso && s.sfid != crate::Sfid::Ugm as u8 {
                    self.set(f::SEND_EX_BSO, 1);
                }
                // with an immediate extended descriptor, src1's length is its bits 10:6 (the same bits)
                self.set(f::SEND_SRC1_LEN, s.src1_len as u64);
                let d = s.desc as u64;
                self.set((123, 122), (d >> 30) & 0x3);
                self.set((71, 67), (d >> 25) & 0x1f);
                self.set((55, 51), (d >> 20) & 0x1f);
                self.set((121, 113), (d >> 11) & 0x1ff);
                self.set((91, 81), d & 0x7ff);
                let x = s.ex_desc as u64;
                debug_assert!(x & 0x7ff == 0, "ex_desc bits 10:0 must be zero (src1_len has its own field)");
                self.set((127, 124), (x >> 28) & 0xf);
                self.set((97, 96), (x >> 26) & 0x3);
                self.set((65, 64), (x >> 24) & 0x3);
                self.set((47, 35), (x >> 11) & 0x1fff);
            }
            Format::Branch1 | Format::Branch2 => {
                if i.op != Opcode::Join {
                    self.set(f::BRANCH_CONTROL, i.branch_ctrl as u64);
                }
                let s0 = &i.src[0];
                // a register target (jmpi / call / ret ...): src0 a GRF or an ARF other than null; else jip / uip
                let reg = s0.file == File::Grf || (s0.file == File::Arf && s0.nr != Arf::NULL);
                if reg {
                    self.set(f::SRC0_TYPE, s0.ty.code());
                    self.direct(f::SRC0_OPERAND, s0, false);
                } else {
                    self.set(f::SRC0_IS_IMM, 1);
                    self.set(f::IMM_LO_32, i.jip as u32 as u64);
                    if format == Format::Branch2 {
                        self.set(f::SRC1_IS_IMM, 1);
                        self.set(f::IMM_HI_32, i.uip as u32 as u64);
                    }
                }
            }
            Format::Nop => {}
        }
    }
}
