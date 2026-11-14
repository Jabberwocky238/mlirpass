use alloc::vec::Vec;

use mlirformat::arith::{CmpFPredicate, CmpIPredicate};
use mlirformat::{Attribute, Type};

use crate::{Attrs, ConversionRewriter, OpData, OpId, ValueId, patterns};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

pub struct SpirvToArith;

#[patterns]
#[map("spirv.FAdd" => "arith.addf", via = Self::plain)]
#[map("spirv.FSub" => "arith.subf", via = Self::plain)]
#[map("spirv.FMul" => "arith.mulf", via = Self::plain)]
#[map("spirv.FDiv" => "arith.divf", via = Self::plain)]
#[map("spirv.FNegate" => "arith.negf", via = Self::plain)]
#[map("spirv.IAdd" => "arith.addi", via = Self::plain)]
#[map("spirv.ISub" => "arith.subi", via = Self::plain)]
#[map("spirv.IMul" => "arith.muli", via = Self::plain)]
#[map("spirv.BitwiseAnd" => "arith.andi", via = Self::plain)]
#[map("spirv.BitwiseOr" => "arith.ori", via = Self::plain)]
#[map("spirv.BitwiseXor" => "arith.xori", via = Self::plain)]
#[map("spirv.ShiftLeftLogical" => "arith.shli", via = Self::plain)]
#[map("spirv.ShiftRightLogical" => "arith.shrui", via = Self::plain)]
#[map("spirv.ShiftRightArithmetic" => "arith.shrsi", via = Self::plain)]
#[map("spirv.Select" => "arith.select", via = Self::plain)]
#[map("spirv.ConvertFToS" => "arith.fptosi", via = Self::plain)]
#[map("spirv.ConvertFToU" => "arith.fptoui", via = Self::plain)]
#[map("spirv.ConvertSToF" => "arith.sitofp", via = Self::plain)]
#[map("spirv.ConvertUToF" => "arith.uitofp", via = Self::plain)]
#[map("spirv.Bitcast" => "arith.bitcast", via = Self::plain)]
#[map("spirv.GL.Floor" => "math.floor", via = Self::plain)]
#[map("spirv.GL.Ceil" => "math.ceil", via = Self::plain)]
#[map("spirv.GL.FAbs" => "math.absf", via = Self::plain)]
#[map("spirv.GL.Sqrt" => "math.sqrt", via = Self::plain)]
#[map("spirv.GL.Fma" => "math.fma", via = Self::plain)]
#[map("spirv.GL.RoundEven" => "math.roundeven", via = Self::plain)]
#[map("spirv.GL.FMin" => "arith.minnumf", via = Self::plain)]
#[map("spirv.GL.FMax" => "arith.maxnumf", via = Self::plain)]
#[map("spirv.GL.SMin" => "arith.minsi", via = Self::plain)]
#[map("spirv.GL.SMax" => "arith.maxsi", via = Self::plain)]
#[map("spirv.GL.UMin" => "arith.minui", via = Self::plain)]
#[map("spirv.GL.UMax" => "arith.maxui", via = Self::plain)]
#[map("spirv.CompositeConstruct" => "vector.from_elements", via = Self::plain)]
#[map("spirv.FOrdEqual" => "arith.cmpf", via = Self::cmp(CmpFPredicate::oeq as i64))]
#[map("spirv.FOrdNotEqual" => "arith.cmpf", via = Self::cmp(CmpFPredicate::one as i64))]
#[map("spirv.FOrdLessThan" => "arith.cmpf", via = Self::cmp(CmpFPredicate::olt as i64))]
#[map("spirv.FOrdLessThanEqual" => "arith.cmpf", via = Self::cmp(CmpFPredicate::ole as i64))]
#[map("spirv.FOrdGreaterThan" => "arith.cmpf", via = Self::cmp(CmpFPredicate::ogt as i64))]
#[map("spirv.FOrdGreaterThanEqual" => "arith.cmpf", via = Self::cmp(CmpFPredicate::oge as i64))]
#[map("spirv.FUnordNotEqual" => "arith.cmpf", via = Self::cmp(CmpFPredicate::une as i64))]
#[map("spirv.IEqual" => "arith.cmpi", via = Self::cmp(CmpIPredicate::eq as i64))]
#[map("spirv.INotEqual" => "arith.cmpi", via = Self::cmp(CmpIPredicate::ne as i64))]
#[map("spirv.SLessThan" => "arith.cmpi", via = Self::cmp(CmpIPredicate::slt as i64))]
#[map("spirv.SLessThanEqual" => "arith.cmpi", via = Self::cmp(CmpIPredicate::sle as i64))]
#[map("spirv.SGreaterThan" => "arith.cmpi", via = Self::cmp(CmpIPredicate::sgt as i64))]
#[map("spirv.SGreaterThanEqual" => "arith.cmpi", via = Self::cmp(CmpIPredicate::sge as i64))]
#[map("spirv.ULessThan" => "arith.cmpi", via = Self::cmp(CmpIPredicate::ult as i64))]
#[map("spirv.UGreaterThan" => "arith.cmpi", via = Self::cmp(CmpIPredicate::ugt as i64))]
impl SpirvToArith {
    fn plain(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        cr.replace_new(op, OpData::build(to).operands(&ops), &[ty]);
        true
    }

    fn cmp(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str, pred: i64) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let p = Attribute::Int { lit: alloc::format!("{pred}").into(), ty: Some(Type::int(64)) };
        cr.replace_new(op, OpData::build(to).operands(&ops).with("predicate", p), &[ty]);
        true
    }

    fn indices<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, name: &str) -> Option<Attribute<'a>> {
        let Attribute::Array(v) = cr.rw.body[op].get(name)? else { return None };
        let v: Vec<i64> = v.iter().map(Attrs::as_int).collect::<Result<_, _>>().ok()?;
        Some(Attribute::dense_i64(&v))
    }

    #[convert("spirv.Constant")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let Some(v) = cr.rw.body[op].get("value").cloned() else { return false };
        cr.replace_new(op, OpData::build("arith.constant").with("value", v), &[ty]);
        true
    }

    #[convert("spirv.CompositeExtract")]
    fn extract(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let (Some(ops), Some(at)) = (Cr::one_to_one(operands), Self::indices(cr, op, "indices")) else { return false };
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        cr.replace_new(op, OpData::build("vector.extract").operands(&ops).with("static_position", at), &[ty]);
        true
    }

    #[convert("spirv.VectorShuffle")]
    fn shuffle(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let (Some(ops), Some(mask)) = (Cr::one_to_one(operands), Self::indices(cr, op, "components")) else { return false };
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        cr.replace_new(op, OpData::build("vector.shuffle").operands(&ops).with("mask", mask), &[ty]);
        true
    }
}
