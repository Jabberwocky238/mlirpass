use alloc::vec::Vec;

use mlirformat::{Attribute, Type};

use crate::patterns;
use crate::{ConversionRewriter, ConversionTarget, OpData, OpId, TypeConverter, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

pub struct ScfStructural;

#[patterns(converter)]
impl ScfStructural {
    #[convert("scf.for")]
    fn for_op(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let ([lb], [ub], [step]) = (o[0].as_slice(), o[1].as_slice(), o[2].as_slice()) else { return false };
        let mut operands = Vec::from([*lb, *ub, *step]);
        operands.extend(o[3..].concat());
        Self::structural(cr, op, operands, true)
    }

    #[convert("scf.if")]
    fn if_op(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [c] = o[0].as_slice() else { return false };
        Self::structural(cr, op, Vec::from([*c]), false)
    }

    #[convert("scf.while")]
    fn while_op(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::structural(cr, op, o.concat(), true)
    }

    #[convert("scf.index_switch")]
    fn index_switch(cr: &mut Cr<'_, '_, '_>, op: OpId, _o: &[Vec<ValueId>]) -> bool {
        let arg = cr.rw.body[op].operands[0];
        Self::structural(cr, op, Vec::from([arg]), false)
    }

    #[convert("scf.yield")]
    fn yield_op(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        cr.replace_new(op, OpData::build("scf.yield").operands(&o.concat()), &[]);
        true
    }

    #[convert("scf.condition")]
    fn condition(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let flat = o.concat();
        cr.modify(op, |b| b.set_operands(op, flat));
        true
    }
}

impl ScfStructural {
    fn structural(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: Vec<ValueId>, convert_regions: bool) -> bool {
        let Some(tc) = cr.type_converter() else { return false };
        let Some(current) = cr.current else { return false };
        let mut groups = Vec::new();
        for r in cr.rw.body[op].results.clone() {
            let Some(ts) = tc.convert_types(&cr.rw.body[r].ty) else { return false };
            groups.push(ts);
        }
        let regions = cr.rw.body[op].regions.to_vec();
        if convert_regions {
            for r in &regions {
                if cr.convert_region_types(*r, current, None).is_none() {
                    return false;
                }
            }
        }
        let name = cr.rw.body[op].name.clone();
        let mut data = OpData::build(&name).operands(&operands);
        for a in cr.rw.body[op].attributes.clone() {
            data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
        }
        let flat: Vec<Type<'_>> = groups.concat();
        let n = regions.len();
        cr.rw.set_before(op);
        let new = cr.rw.create_with(data, &flat, |b, k| {
            for _ in 0..n {
                b.add_region(k);
            }
        });
        for (i, r) in regions.iter().enumerate() {
            let into = cr.rw.body[new].regions[i];
            cr.inline_region(*r, into, None);
        }
        let mut results = cr.rw.body[new].results.iter().copied();
        let grouped = groups.iter().map(|g| results.by_ref().take(g.len()).collect()).collect();
        cr.replace(op, grouped);
        true
    }

    pub fn target<'c>(target: &mut ConversionTarget<'c>, tc: &'c TypeConverter<'c>) {
        for name in ["scf.for", "scf.if", "scf.index_switch", "scf.yield", "scf.while", "scf.condition"] {
            target.dynamic_op(name, move |b, o| Some(tc.scf_structural_legal(b, o)));
        }
    }
}
