use mlirformat::{Attribute, Const, Type};

use crate::{ApInt, Body, Fold, Folded, OpData, OpId};

const INDEX_BITS: u32 = 64;
const NARROW_BITS: u32 = 32;

#[derive(Clone, Copy)]
enum Binary {
    Add,
    Sub,
    Mul,
    DivS,
    DivU,
    RemS,
    RemU,
    MaxS,
    MaxU,
    MinS,
    MinU,
    Shl,
    ShrS,
    ShrU,
    And,
    Or,
    Xor,
}

impl Binary {
    const TABLE: [(&str, Binary); 17] = [
        ("index.add", Binary::Add),
        ("index.sub", Binary::Sub),
        ("index.mul", Binary::Mul),
        ("index.divs", Binary::DivS),
        ("index.divu", Binary::DivU),
        ("index.rems", Binary::RemS),
        ("index.remu", Binary::RemU),
        ("index.maxs", Binary::MaxS),
        ("index.maxu", Binary::MaxU),
        ("index.mins", Binary::MinS),
        ("index.minu", Binary::MinU),
        ("index.shl", Binary::Shl),
        ("index.shrs", Binary::ShrS),
        ("index.shru", Binary::ShrU),
        ("index.and", Binary::And),
        ("index.or", Binary::Or),
        ("index.xor", Binary::Xor),
    ];

    fn of(name: &str) -> Option<Self> {
        Self::TABLE.iter().find(|(n, _)| *n == name).map(|(_, k)| *k)
    }

    fn unchecked(self) -> bool {
        matches!(self, Binary::Add | Binary::Sub | Binary::Mul)
    }

    fn apply(self, a: ApInt, b: ApInt) -> Option<ApInt> {
        let bits = a.width;
        Some(match self {
            Binary::Add => a.add(b),
            Binary::Sub => a.sub(b),
            Binary::Mul => a.mul(b),
            Binary::DivS => a.sdiv(b)?,
            Binary::DivU => a.udiv(b)?,
            Binary::RemS => a.srem(b)?,
            Binary::RemU => a.urem(b)?,
            Binary::MaxS => if a.scmp(b).is_ge() { a } else { b },
            Binary::MaxU => if a.ucmp(b).is_ge() { a } else { b },
            Binary::MinS => if a.scmp(b).is_le() { a } else { b },
            Binary::MinU => if a.ucmp(b).is_le() { a } else { b },
            Binary::Shl | Binary::ShrS | Binary::ShrU if b.unsigned() >= u128::from(bits) => return None,
            Binary::Shl => a.shl(b.unsigned() as u32),
            Binary::ShrS => a.ashr(b.unsigned() as u32),
            Binary::ShrU => a.lshr(b.unsigned() as u32),
            Binary::And => a.and(b),
            Binary::Or => a.or(b),
            Binary::Xor => a.xor(b),
        })
    }
}

pub struct IndexCanon;

impl IndexCanon {
    fn int(a: Option<&Attribute<'_>>) -> Option<ApInt> {
        Const::try_from(a?).ok().filter(|k| !k.elements)?.as_int()
    }

    pub fn fold<'a>(b: &mut Body<'a>, op: OpId, c: &[Option<Attribute<'a>>]) -> Fold<'a> {
        if b[op].name == "index.constant" {
            return b[op].get("value").cloned().map_or(Fold::Failed, |v| Folded::Attr(v).into());
        }
        let Some(k) = Binary::of(&b[op].name) else { return Fold::Failed };
        let (l, r) = (Self::int(c.first().and_then(Option::as_ref)), Self::int(c.get(1).and_then(Option::as_ref)));
        if let (Some(l), Some(r)) = (l, r) {
            let (l, r) = (l.sext(INDEX_BITS), r.sext(INDEX_BITS));
            let wide = k.apply(l, r);
            let checked = k.unchecked() || match (wide, k.apply(l.trunc(NARROW_BITS), r.trunc(NARROW_BITS))) {
                (Some(w), Some(n)) => w.trunc(NARROW_BITS) == n,
                _ => false,
            };
            if let Some(w) = wide.filter(|_| checked) {
                return Folded::Attr(Attribute::index(w.signed() as i64)).into();
            }
        }
        let x = b[op].operands[0];
        match (k, r) {
            (Binary::Add | Binary::Sub, Some(r)) if r.is_zero() => Folded::Value(x).into(),
            (Binary::Mul, Some(r)) if r.is_one() => Folded::Value(x).into(),
            _ => Fold::Failed,
        }
    }

    pub fn materialize<'a>(value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
        let k = Const::try_from(value).ok().filter(|k| !k.elements && k.ty == Type::Index)?;
        (*ty == Type::Index).then(|| OpData::build("index.constant").with("value", k.into()))
    }
}
