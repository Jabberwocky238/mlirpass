#[allow(unused_imports, reason = "the alloc prelude")]
use alloc::{borrow::ToOwned, boxed::Box, format, string::{String, ToString}, vec, vec::Vec};

use mlirformat::{Attribute, Error, NamedAttr};

use super::{Cond, Dpas, Elem, File, Inst, MathFn, Opcode, Operand, Pipe, Pred, Region, SbidMode, SendInfo, Sfid, Swsb, SyncFn};

macro_rules! names {
    ($($ty:ident { $($v:ident $s:literal),* $(,)? })*) => {$(
        impl From<$ty> for &str {
            fn from(v: $ty) -> Self {
                match v { $($ty::$v => $s),* }
            }
        }

        impl TryFrom<&str> for $ty {
            type Error = Error;

            fn try_from(s: &str) -> Result<$ty, Error> {
                match s {
                    $($s => Ok($ty::$v),)*
                    _ => Err(Error(format!(concat!("not a ", stringify!($ty), ": {}"), s))),
                }
            }
        }
    )*};
}

names! {
    Elem { UB "ub", UW "uw", UD "ud", UQ "uq", B "b", W "w", D "d", Q "q", HF "hf", F "f", DF "df", BF "bf", UV "uv", V "v", VF "vf" }
    Cond { None "none", Z "z", Nz "nz", Gt "gt", Ge "ge", Lt "lt", Le "le", Ov "ov", Un "un" }
    Pred { None "none", Normal "normal", Any "any", All "all" }
    MathFn { Inv "inv", Log "log", Exp "exp", Sqrt "sqrt", Rsq "rsq", Sin "sin", Cos "cos", IntDivBoth "intdiv",
             IntDivQuotient "intdivq", IntDivRemainder "intdivr", Invm "invm", Rsqrtm "rsqrtm" }
    SyncFn { Nop "nop", AllRd "allrd", AllWr "allwr", Fence "fence", Bar "bar", Host "host" }
    Sfid { Null "null", Sampler "sampler", Gateway "gateway", Render "render", Urb "urb", Btd "btd", Pixel "pixel",
           Tgm "tgm", Slm "slm", Ugm "ugm" }
    Pipe { None "", Float "F", Int "I", Long "L", Math "M", Scalar "S", All "A" }
}

impl TryFrom<&str> for Opcode {
    type Error = Error;

    fn try_from(s: &str) -> Result<Opcode, Error> {
        Opcode::ALL.iter().copied().find(|o| o.mnemonic() == s).ok_or_else(|| Error(format!("not an EU opcode: {s}")))
    }
}

impl core::fmt::Display for Operand {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        let ty: &str = self.ty.into();
        if self.file == File::Imm {
            return write!(f, "{:#x}:{ty}", self.imm);
        }
        if self.negate {
            f.write_str("-")?;
        }
        if self.abs {
            f.write_str("(abs)")?;
        }
        match self.file {
            File::Grf => write!(f, "r{}", self.nr)?,
            _ if self.nr == super::Arf::NULL => f.write_str("null")?,
            _ => write!(f, "arf{:#x}", self.nr)?,
        }
        if self.subnr != 0 {
            write!(f, ".{}", self.subnr)?;
        }
        let r = self.region;
        write!(f, "<{};{},{}>:{ty}", r.vstride, r.width, r.hstride)
    }
}

impl TryFrom<&str> for Operand {
    type Error = Error;

    fn try_from(s: &str) -> Result<Operand, Error> {
        let bad = || Error(format!("bad operand {s}"));
        let (body, ty) = match s.rsplit_once(':') {
            Some((b, t)) => (b, Elem::try_from(t)?),
            None => (s, Elem::UD),
        };
        let num = |t: &str| -> Result<u64, Error> {
            match t.strip_prefix("0x") {
                Some(h) => u64::from_str_radix(h, 16).map_err(|_| bad()),
                None => t.parse::<i64>().map(|v| v as u64).map_err(|_| bad()),
            }
        };
        if body.trim_start_matches('-').starts_with(|c: char| c.is_ascii_digit()) {
            let bits = num(body)?;
            let bits = if ty.size() < 8 { bits & ((1u64 << (8 * ty.size())) - 1) } else { bits };
            return Ok(Operand::imm(ty, bits));
        }
        let (negate, body) = body.strip_prefix('-').map_or((false, body), |b| (true, b));
        let (abs, body) = body.strip_prefix("(abs)").map_or((false, body), |b| (true, b));
        let (reg, region) = match body.split_once('<') {
            Some((r, g)) => (r, Some(g.strip_suffix('>').ok_or_else(bad)?)),
            None => (body, None),
        };
        let (reg, sub) = match reg.split_once('.') {
            Some((r, n)) => (r, n.parse::<u8>().map_err(|_| bad())?),
            None => (reg, 0),
        };
        let mut o = match reg {
            "null" => Operand::null(),
            _ if reg.starts_with("arf") => Operand::arf(num(&reg[3..])? as u8, ty),
            _ => Operand::grf(reg.strip_prefix('r').ok_or_else(bad)?.parse().map_err(|_| bad())?, ty),
        }
        .ty(ty)
        .sub(sub);
        let n = |t: &str| t.trim().parse::<u8>().map_err(|_| bad());
        if let Some(g) = region {
            o.region = match g.split_once(';') {
                Some((v, wh)) => {
                    let (w, h) = wh.split_once(',').ok_or_else(bad)?;
                    Region::new(n(v)?, n(w)?, n(h)?)
                }
                None => Region::new(0, 1, n(g)?),
            };
        }
        o.negate = negate;
        o.abs = abs;
        Ok(o)
    }
}

impl core::fmt::Display for Swsb {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        let mut parts = Vec::new();
        if self.regdist != 0 {
            parts.push(format!("{}@{}", <&str>::from(self.pipe), self.regdist));
        }
        match self.mode {
            SbidMode::Null => {}
            SbidMode::Set => parts.push(format!("${}", self.sbid)),
            SbidMode::Dst => parts.push(format!("${}.dst", self.sbid)),
            SbidMode::Src => parts.push(format!("${}.src", self.sbid)),
        }
        f.write_str(&parts.join(","))
    }
}

impl TryFrom<&str> for Swsb {
    type Error = Error;

    fn try_from(s: &str) -> Result<Swsb, Error> {
        let bad = || Error(format!("bad swsb {s}"));
        let mut w = Swsb::NONE;
        for p in s.split(',') {
            if let Some(sb) = p.strip_prefix('$') {
                let (n, mode) = match sb.split_once('.') {
                    Some((n, "dst")) => (n, SbidMode::Dst),
                    Some((n, "src")) => (n, SbidMode::Src),
                    None => (sb, SbidMode::Set),
                    _ => return Err(bad()),
                };
                (w.sbid, w.mode) = (n.parse().map_err(|_| bad())?, mode);
            } else {
                let (pipe, n) = p.split_once('@').ok_or_else(bad)?;
                (w.pipe, w.regdist) = (Pipe::try_from(pipe)?, n.parse().map_err(|_| bad())?);
            }
        }
        Ok(w)
    }
}

struct Attrs<'a>(Vec<NamedAttr<'a>>);

impl<'a> Attrs<'a> {
    fn put(&mut self, name: &'a str, value: Attribute<'a>) {
        self.0.push(NamedAttr { name: name.into(), value: Some(value) });
    }

    fn int(&mut self, name: &'a str, v: i128) {
        let lit = if name.contains("desc") { format!("{v:#010x}") } else { v.to_string() };
        self.put(name, Attribute::Int { lit: lit.into(), ty: None });
    }

    fn str(&mut self, name: &'a str, v: impl Into<String>) {
        self.put(name, Attribute::Str { lit: v.into().into(), ty: None });
    }

    fn unit(&mut self, name: &'a str, on: bool) {
        if on {
            self.0.push(NamedAttr { name: name.into(), value: None });
        }
    }
}

struct Read<'r, 'a>(&'r [NamedAttr<'a>]);

impl Read<'_, '_> {
    fn get(&self, name: &str) -> Option<&Attribute<'_>> {
        self.0.iter().find(|a| a.name == name).map(|a| a.value.as_ref().unwrap_or(&Attribute::Unit))
    }

    fn int(&self, name: &str) -> Result<Option<i128>, Error> {
        match self.get(name) {
            None => Ok(None),
            Some(Attribute::Int { lit, .. }) => {
                let (neg, l) = lit.strip_prefix('-').map_or((false, &**lit), |l| (true, l));
                let v = match l.strip_prefix("0x") {
                    Some(h) => i128::from_str_radix(h, 16),
                    None => l.parse(),
                }
                .map_err(|_| Error(format!("{name}: bad integer {lit}")))?;
                Ok(Some(if neg { -v } else { v }))
            }
            Some(a) => Err(Error(format!("{name}: {a} is not an integer"))),
        }
    }

    fn str(&self, name: &str) -> Result<Option<&str>, Error> {
        match self.get(name) {
            None => Ok(None),
            Some(Attribute::Str { lit, .. }) => Ok(Some(lit)),
            Some(a) => Err(Error(format!("{name}: {a} is not a string"))),
        }
    }

    fn flag(&self, name: &str) -> bool {
        matches!(self.get(name), Some(Attribute::Unit | Attribute::Bool(true)))
    }
}

const KNOWN: &[&str] = &[
    "exec", "chan", "dst", "src0", "src1", "src2", "sat", "w", "atomic", "cond", "flag", "pred", "pred_inv", "swsb", "fn",
    "bfn", "sfid", "desc", "ex_desc", "src1_len", "eot", "ex_bso", "sdepth", "rcount", "src1_subbyte", "src2_subbyte",
    "jip", "uip", "branch_ctrl",
];

impl Inst {
    pub fn op<'a>(&self) -> (String, Vec<NamedAttr<'a>>) {
        let mut a = Attrs(Vec::new());
        let d = Inst::new(self.op, self.exec_size);
        a.int("exec", self.exec_size.into());
        if self.chan_offset != 0 {
            a.int("chan", self.chan_offset.into());
        }
        if self.dst != d.dst {
            a.str("dst", self.dst.to_string());
        }
        for (i, name) in ["src0", "src1", "src2"].into_iter().enumerate() {
            if self.src[i] != d.src[i] {
                a.str(name, self.src[i].to_string());
            }
        }
        a.unit("sat", self.saturate);
        a.unit("w", self.no_mask);
        a.unit("atomic", self.atomic);
        if self.cond != Cond::None {
            a.str("cond", <&str>::from(self.cond));
        }
        if self.pred != Pred::None {
            a.str("pred", <&str>::from(self.pred));
        }
        a.unit("pred_inv", self.pred_inv);
        if self.flag != (0, 0) || self.cond != Cond::None || self.pred != Pred::None {
            a.str("flag", format!("f{}.{}", self.flag.0, self.flag.1));
        }
        if self.swsb != Swsb::NONE {
            a.str("swsb", self.swsb.to_string());
        }
        match (self.op, self.math) {
            (Opcode::Math, Some(m)) => a.str("fn", <&str>::from(m)),
            (Opcode::Sync, _) => a.str("fn", <&str>::from(self.sync)),
            _ => {}
        }
        if self.bfn_ctrl != 0 {
            a.int("bfn", self.bfn_ctrl.into());
        }
        if matches!(self.op, Opcode::Send | Opcode::Sendc) {
            let s = self.send;
            let sfid = Sfid::try_from(s.sfid).map_or_else(|_| s.sfid.to_string(), |f| <&str>::from(f).to_owned());
            a.str("sfid", sfid);
            a.int("desc", s.desc.into());
            if s.ex_desc != 0 {
                a.int("ex_desc", s.ex_desc.into());
            }
            if s.src1_len != 0 {
                a.int("src1_len", s.src1_len.into());
            }
            a.unit("eot", s.eot);
            a.unit("ex_bso", s.ex_bso);
        }
        if self.op == Opcode::Dpas {
            let p = self.dpas;
            a.int("sdepth", p.sdepth.into());
            a.int("rcount", p.rcount.into());
            if p.src1_subbyte != 0 {
                a.int("src1_subbyte", p.src1_subbyte.into());
            }
            if p.src2_subbyte != 0 {
                a.int("src2_subbyte", p.src2_subbyte.into());
            }
        }
        if self.jip != 0 {
            a.int("jip", self.jip.into());
        }
        if self.uip != 0 {
            a.int("uip", self.uip.into());
        }
        a.unit("branch_ctrl", self.branch_ctrl);
        (format!("xe3.eu.{}", self.op.mnemonic()), a.0)
    }
}

impl TryFrom<(&str, &[NamedAttr<'_>])> for Inst {
    type Error = Error;

    fn try_from((name, attrs): (&str, &[NamedAttr<'_>])) -> Result<Inst, Error> {
        let mnemonic = name.strip_prefix("xe3.eu.").ok_or_else(|| Error(format!("{name}: not an xe3.eu op")))?;
        if let Some(a) = attrs.iter().find(|a| !KNOWN.contains(&&*a.name)) {
            return Err(Error(format!("{name}: unknown attribute {}", a.name)));
        }
        let r = Read(attrs);
        let small = |n: &str| -> Result<Option<u8>, Error> { r.int(n)?.map(|v| u8::try_from(v).map_err(|_| Error(format!("{name}: {n} out of range")))).transpose() };
        let mut i = Inst::new(Opcode::try_from(mnemonic)?, small("exec")?.ok_or_else(|| Error(format!("{name}: no exec size")))?);
        i.chan_offset = small("chan")?.unwrap_or(0);
        if let Some(d) = r.str("dst")? {
            i.dst = Operand::try_from(d)?;
        }
        for (k, n) in ["src0", "src1", "src2"].into_iter().enumerate() {
            if let Some(s) = r.str(n)? {
                i.src[k] = Operand::try_from(s)?;
            }
        }
        i.saturate = r.flag("sat");
        i.no_mask = r.flag("w");
        i.atomic = r.flag("atomic");
        if let Some(c) = r.str("cond")? {
            i.cond = Cond::try_from(c)?;
        }
        if let Some(p) = r.str("pred")? {
            i.pred = Pred::try_from(p)?;
        }
        i.pred_inv = r.flag("pred_inv");
        if let Some(fl) = r.str("flag")? {
            let bad = || Error(format!("{name}: bad flag {fl}"));
            let (n, s) = fl.strip_prefix('f').and_then(|f| f.split_once('.')).ok_or_else(bad)?;
            i.flag = (n.parse().map_err(|_| bad())?, s.parse().map_err(|_| bad())?);
        }
        if let Some(s) = r.str("swsb")? {
            i.swsb = Swsb::try_from(s)?;
        }
        match (i.op, r.str("fn")?) {
            (Opcode::Math, Some(f)) => i.math = Some(MathFn::try_from(f)?),
            (Opcode::Sync, Some(f)) => i.sync = SyncFn::try_from(f)?,
            (_, None) => {}
            (_, Some(f)) => return Err(Error(format!("{name}: fn {f} on an op without one"))),
        }
        i.bfn_ctrl = small("bfn")?.unwrap_or(0);
        if let Some(s) = r.str("sfid")? {
            let sfid = Sfid::try_from(s).map(|f| f as u8).or_else(|e| s.parse::<u8>().map_err(|_| e))?;
            let word = |n: &str| -> Result<u32, Error> { Ok(r.int(n)?.unwrap_or(0) as u32) };
            i.send = SendInfo { sfid, desc: word("desc")?, ex_desc: word("ex_desc")?, src1_len: small("src1_len")?.unwrap_or(0), eot: r.flag("eot"), ex_bso: r.flag("ex_bso") };
        }
        if i.op == Opcode::Dpas {
            let d = Dpas::DEFAULT;
            i.dpas = Dpas {
                sdepth: small("sdepth")?.unwrap_or(d.sdepth),
                rcount: small("rcount")?.unwrap_or(d.rcount),
                src1_subbyte: small("src1_subbyte")?.unwrap_or(0),
                src2_subbyte: small("src2_subbyte")?.unwrap_or(0),
            };
        }
        i.jip = r.int("jip")?.unwrap_or(0) as i32;
        i.uip = r.int("uip")?.unwrap_or(0) as i32;
        i.branch_ctrl = r.flag("branch_ctrl");
        Ok(i)
    }
}

impl TryFrom<u8> for Sfid {
    type Error = Error;

    fn try_from(v: u8) -> Result<Sfid, Error> {
        [Sfid::Null, Sfid::Sampler, Sfid::Gateway, Sfid::Render, Sfid::Urb, Sfid::Btd, Sfid::Pixel, Sfid::Tgm, Sfid::Slm, Sfid::Ugm]
            .into_iter()
            .find(|f| *f as u8 == v)
            .ok_or_else(|| Error(format!("not a shared function id: {v}")))
    }
}
