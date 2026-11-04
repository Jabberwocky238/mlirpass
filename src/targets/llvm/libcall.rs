//! Math as device library calls, as `OpToFuncCallLowering.h` with `ScalarizeVectorOpLowering`:
//! shared by the NVVM (`__nv_*`) and ROCDL (`__ocml_*`) lowerings.

use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, FloatKind, ShapedKind, Type};

use crate::{ConversionRewriter, Fmf, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The functions an op calls per operand type (empty: none).
#[derive(Debug, Clone, Copy)]
pub struct LibFns {
    pub f32: &'static str,
    pub f64: &'static str,
    pub f32_approx: &'static str,
    pub f16: &'static str,
    pub i32: &'static str,
}

impl LibFns {
    pub const fn float(f32: &'static str, f64: &'static str) -> Self {
        Self { f32, f64, f32_approx: "", f16: "", i32: "" }
    }

    pub const fn approx(f32: &'static str, f64: &'static str, f32_approx: &'static str) -> Self {
        Self { f32, f64, f32_approx, f16: "", i32: "" }
    }

    /// f32, f64 and f16 functions (`populateOpPatterns` of MathToROCDL).
    pub const fn half(f32: &'static str, f64: &'static str, f16: &'static str) -> Self {
        Self { f32, f64, f32_approx: "", f16, i32: "" }
    }

    pub const fn int(i32: &'static str) -> Self {
        Self { f32: "", f64: "", f32_approx: "", f16: "", i32 }
    }

    /// `getFunctionName`.
    fn name(&self, t: &Type<'_>, approx: bool) -> &'static str {
        match t {
            Type::Float(FloatKind::F16) => self.f16,
            Type::Float(FloatKind::F32) if approx && !self.f32_approx.is_empty() => self.f32_approx,
            Type::Float(FloatKind::F32) => self.f32,
            Type::Float(FloatKind::F64) => self.f64,
            Type::Integer { width: 32, .. } => self.i32,
            _ => "",
        }
    }
}

impl<'a> Cr<'_, 'a, '_> {
    /// The nearest function-like op around `op`.
    pub fn parent_function(&self, op: OpId) -> Option<OpId> {
        let b = &*self.rw.body;
        let mut at = b.parent_op(op);
        while let Some(o) = at {
            if b.has(o, crate::Trait::FunctionOpInterface) {
                return Some(o);
            }
            at = b.parent_op(o);
        }
        None
    }

    /// `SymbolTable::lookupNearestSymbolFrom` of an `llvm.func`.
    fn nearest_llvm_func(&self, op: OpId, name: &str) -> Option<OpId> {
        let b = &*self.rw.body;
        let mut at = b.parent_op(op);
        while let Some(o) = at {
            if b.is_symbol_table(o) {
                return b.lookup(o, name).filter(|f| b[*f].name == "llvm.func");
            }
            at = b.parent_op(o);
        }
        None
    }

    /// `appendOrGetFuncOp`: a declaration right before the enclosing function.
    pub fn declare_before_function(&mut self, op: OpId, name: &str, ty: Type<'a>) -> Option<()> {
        if self.nearest_llvm_func(op, name).is_some() {
            return Some(());
        }
        let parent = self.parent_function(op)?;
        let saved = self.rw.ip;
        self.rw.set_before(parent);
        let loc = self.rw.body[op].loc.as_deref().and_then(crate::file_line_col).map(Into::into);
        let mut data = OpData::build("llvm.func").with("sym_name", Attribute::str(name)).with("function_type", Attribute::Type(ty)).with("linkage", Attribute::dialect("llvm.linkage", "<external>"));
        data.loc = Some(loc.unwrap_or_else(|| "unknown".into()));
        self.rw.create_with(data, &[], |b, f| {
            b.add_region(f);
        });
        self.rw.ip = saved;
        Some(())
    }

    /// `scalarizeVectorOpHelper`: `op` once per element of 1-d `vty`.
    fn scalarize_1d(&mut self, op: OpId, operands: &[ValueId], vty: Type<'a>) -> ValueId {
        let Type::Shaped(s) = &vty else { return operands[0] };
        let n: i64 = s.dims().unwrap_or_default().iter().product();
        let elem = (*s.elem).clone();
        let idx = self.type_converter().and_then(|tc| tc.convert(&Type::Index)).unwrap_or(Type::int(64));
        let name = self.rw.body[op].name.clone();
        let attrs = self.all_attrs(op);
        let mut r = self.poison(vty.clone());
        for i in 0..n {
            let index = self.llvm_constant(Attribute::of_int(i.into(), idx.clone()), idx.clone());
            let scalars: Vec<ValueId> = operands
                .iter()
                .map(|v| if matches!(&self.rw.body[*v].ty, Type::Shaped(s) if s.kind == ShapedKind::Vector) { self.build(OpData::build("llvm.extractelement").operands(&[*v, index]), elem.clone()) } else { *v })
                .collect();
            let mut data = OpData::build(&name).operands(&scalars);
            for a in &attrs {
                data.set(&a.name, a.value.clone().unwrap_or(Attribute::Unit));
            }
            let x = self.build(data, elem.clone());
            r = self.build(OpData::build("llvm.insertelement").operands(&[r, x, index]), vty.clone());
        }
        r
    }

    /// `impl::scalarizeVectorOp`: a vector op unrolled into scalar ones (through the outer
    /// dimensions of an n-d one).
    pub fn scalarize(&mut self, op: OpId, operands: &[ValueId]) -> bool {
        let types = self.rw.body.types(operands);
        if types.iter().any(|t| matches!(t, Type::Shaped(s) if s.kind == ShapedKind::Vector)) {
            let res = self.rw.body[self.rw.body[op].results[0]].ty.clone();
            let Some(vty) = self.converted(&res) else { return false };
            self.rw.set_before(op);
            let r = self.scalarize_1d(op, operands, vty);
            self.replace_values(op, &[r]);
            return true;
        }
        if types.iter().any(|t| matches!(LlvmType::try_from(t), Ok(LlvmType::Array(..)))) {
            self.rw.set_before(op);
            return self.unroll_vectors(op, operands, |cr, ty, pieces| cr.scalarize_1d(op, pieces, ty));
        }
        false
    }

    /// `OpToFuncCallLowering` (after [`scalarize`](Self::scalarize), a pattern of its own): `op` as a call of the function `fns` names for its operand
    /// type, f16 / bf16 through f32, an `i1` result through an `i32` one.
    pub fn lib_call(&mut self, op: OpId, operands: &[ValueId], fns: &LibFns) -> bool {
        let res = self.rw.body[self.rw.body[op].results[0]].ty.clone();
        let boolean = matches!(res, Type::Integer { width: 1, .. });
        if self.parent_function(op).is_none() {
            return false;
        }
        self.rw.set_before(op);
        let f32t = Type::Float(FloatKind::F32);
        let mut casted = Vec::new();
        for v in operands {
            let t = self.rw.body[*v].ty.clone();
            let keep = !matches!(t, Type::Float(FloatKind::F16 | FloatKind::BF16)) || (!fns.f16.is_empty() && t == Type::Float(FloatKind::F16));
            casted.push(if keep { *v } else { self.build(OpData::build("llvm.fpext").operands(&[*v]), f32t.clone()) });
        }
        let cty = self.rw.body[casted[0]].ty.clone();
        let rty = if boolean { Type::int(32) } else { cty.clone() };
        let approx = Fmf::of(self, op).afn();
        let name = fns.name(&cty, approx);
        if name.is_empty() {
            return false;
        }
        let fty: Type<'a> = LlvmType::Func { ret: rty.clone().into(), params: self.rw.body.types(&casted), vararg: false }.into();
        if self.declare_before_function(op, name, fty).is_none() {
            return false;
        }
        let call = self.llvm_call(name, &casted, &[rty.clone()]);
        let r = self.rw.body[call].results[0];
        let orig = self.rw.body[operands[0]].ty.clone();
        let out = if rty == orig {
            r
        } else if boolean {
            let zero = self.llvm_constant(Attribute::of_int(0, Type::int(32)), Type::int(32));
            self.build(OpData::build("llvm.icmp").operands(&[r, zero]).with("predicate", Attribute::i64(1)), Type::int(1))
        } else {
            self.build(OpData::build("llvm.fptrunc").operands(&[r]), orig)
        };
        self.replace_values(op, &[out]);
        true
    }
}

/// The first `"file":line:col` in raw location text (`findInstanceOfOrUnknown<FileLineColLoc>`).
pub fn file_line_col(loc: &str) -> Option<String> {
    let b = loc.as_bytes();
    let mut i = 0;
    while let Some(q) = loc[i..].find('"').map(|q| q + i) {
        let mut j = q + 1;
        while j < b.len() && b[j] != b'"' {
            j += if b[j] == b'\\' { 2 } else { 1 };
        }
        let rest = &loc[(j + 1).min(loc.len())..];
        let nums: Vec<&str> = rest.splitn(3, ':').skip(1).take(2).collect();
        if nums.len() == 2 {
            let line = nums[0];
            let col: String = nums[1].chars().take_while(char::is_ascii_digit).collect();
            if !line.is_empty() && line.chars().all(|c| c.is_ascii_digit()) && !col.is_empty() {
                return Some(alloc::format!("{}:{line}:{col}", &loc[q..=j]));
            }
        }
        i = j + 1;
        if i >= loc.len() {
            break;
        }
    }
    None
}
