use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Dim, Shaped, ShapedKind, Type};

use crate::{ConversionRewriter, LlvmConverter, LlvmOptions, MemrefLayout, OpData, OpId, SignatureConversion, ValueId};

pub struct LlvmSignature<'a> {
    pub llvm: Type<'a>,
    pub conversion: SignatureConversion<'a>,
}

fn memref<'t, 'a>(t: &'t Type<'a>) -> Option<&'t Shaped<'a>> {
    match t {
        Type::Shaped(s) if s.kind == ShapedKind::MemRef => Some(s),
        _ => None,
    }
}

impl<'a> ConversionRewriter<'_, 'a, '_> {
    pub fn llvm_arg_types(&self, opts: LlvmOptions, t: &Type<'a>, bare: bool) -> Option<Vec<Type<'a>>> {
        let tc = self.type_converter()?;
        if let Some(s) = memref(t) {
            if bare {
                return self.llvm_bare_ptr(opts, s).map(|p| vec![p]);
            }
            if s.shape.is_none() {
                tc.convert(&s.elem)?;
                return Some(vec![opts.index(), LlvmType::ptr()]);
            }
            let ok = tc.convert(&s.elem).is_some();
            return opts.descriptor_fields(s, ok, true);
        }
        tc.convert_types(t)
    }

    pub fn llvm_bare_ptr(&self, opts: LlvmOptions, s: &Shaped<'a>) -> Option<Type<'a>> {
        self.type_converter()?.convert(&s.elem)?;
        let shape = s.shape.as_ref()?;
        if shape.iter().any(|d| !matches!(d, Dim::Static(_))) {
            return None;
        }
        let (strides, offset) = s.strides_and_offset()?;
        if strides.contains(&Dim::DYNAMIC) || offset == Dim::DYNAMIC {
            return None;
        }
        Some(LlvmType::Ptr(opts.address_space(s)?).into())
    }

    pub fn llvm_pack_results(&self, opts: LlvmOptions, types: &[Type<'a>], bare: bool) -> Option<(Type<'a>, Vec<Vec<Type<'a>>>)> {
        let tc = self.type_converter()?;
        let mut groups = Vec::new();
        for t in types {
            let g = match memref(t) {
                Some(s) if bare => vec![self.llvm_bare_ptr(opts, s)?],
                _ => tc.convert_types(t)?,
            };
            groups.push(g);
        }
        let flat: Vec<Type<'a>> = groups.iter().flatten().cloned().collect();
        let packed = match flat.len() {
            0 => return None,
            1 => flat[0].clone(),
            _ => LlvmType::literal(flat),
        };
        Some((packed, groups))
    }

    pub fn llvm_signature(&self, opts: LlvmOptions, inputs: &[Type<'a>], results: &[Type<'a>], vararg: bool, bare: bool) -> Option<LlvmSignature<'a>> {
        self.llvm_signature_of(opts, inputs, inputs.len(), results, vararg, bare)
    }

    pub fn llvm_signature_of(&self, opts: LlvmOptions, inputs: &[Type<'a>], block_args: usize, results: &[Type<'a>], vararg: bool, bare: bool) -> Option<LlvmSignature<'a>> {
        let mut conversion = SignatureConversion::new(block_args);
        for (i, t) in inputs.iter().enumerate() {
            let conv = self.llvm_arg_types(opts, t, bare)?;
            conversion.add_inputs(i, conv);
        }
        let ret = if results.is_empty() { LlvmType::void() } else { self.llvm_pack_results(opts, results, bare)?.0 };
        let llvm = LlvmType::Func { ret: ret.into(), params: conversion.converted_types().to_vec(), vararg }.into();
        Some(LlvmSignature { llvm, conversion })
    }

    pub fn copy_unranked(&mut self, opts: LlvmOptions, s: &Shaped<'a>, desc: ValueId, to_dynamic: bool, at: OpId) -> Option<ValueId> {
        opts.address_space(s)?;
        let idx = opts.index();
        let module = self.module_of(at)?;
        match to_dynamic {
            true => self.llvm_func(module, "malloc", vec![idx.clone()], LlvmType::ptr(), false)?,
            false => self.llvm_func(module, "free", vec![LlvmType::ptr()], LlvmType::void(), false)?,
        };
        let one = self.index_const(&idx, 1);
        let two = self.index_const(&idx, 2);
        let index_size = self.index_const(&idx, i64::from(opts.index_bitwidth.div_ceil(8)));
        let ptr_size = self.index_const(&idx, 8);
        let arith = |cr: &mut Self, name: &str, a: ValueId, b: ValueId| cr.build(OpData::build(name).operands(&[a, b]), idx.clone());
        let double_ptr = arith(self, "llvm.mul", two, ptr_size);
        let rank = self.extract(desc, &[0]);
        let double_rank = arith(self, "llvm.mul", two, rank);
        let inc = arith(self, "llvm.add", double_rank, one);
        let rank_size = arith(self, "llvm.mul", inc, index_size);
        let size = arith(self, "llvm.add", double_ptr, rank_size);
        let memory = if to_dynamic {
            let c = self.llvm_call("malloc", &[size], &[LlvmType::ptr()]);
            self.rw.body[c].results[0]
        } else {
            self.build(OpData::build("llvm.alloca").operands(&[size]).with("elem_type", Attribute::Type(Type::int(8))), LlvmType::ptr())
        };
        let source = self.extract(desc, &[1]);
        self.rw.create(OpData::build("llvm.intr.memcpy").operands(&[memory, source, size]).with("isVolatile", Attribute::Bool(false)), &[]);
        if !to_dynamic {
            self.llvm_call("free", &[source], &[]);
        }
        let ty = LlvmConverter::convert_memref(opts, s)?;
        let p = self.poison(ty);
        let rank = self.extract(desc, &[0]);
        let p = self.insert_value(p, rank, &[0]);
        Some(self.insert_value(p, memory, &[1]))
    }

    pub fn llvm_return(&mut self, op: OpId, operands: &[Vec<ValueId>], opts: LlvmOptions, bare: bool) -> bool {
        let originals = self.rw.body[op].operands.clone();
        let mut updated = Vec::new();
        for (o, adapted) in originals.iter().zip(operands) {
            let ty = self.rw.body[*o].ty.clone();
            match memref(&ty) {
                Some(s) if bare && s.shape.is_none() => return false,
                Some(s) if s.shape.is_none() => match self.copy_unranked(opts, s, adapted[0], true, op) {
                    Some(d) => updated.push(d),
                    None => return false,
                },
                Some(s) if bare && self.llvm_bare_ptr(opts, s).is_some() => updated.push(self.extract(adapted[0], &[0])),
                _ => updated.extend(adapted.iter().copied()),
            }
        }
        let attrs = self.all_attrs(op);
        let with_attrs = |mut d: OpData<'a>| -> OpData<'a> {
            for a in &attrs {
                d.set(&a.name, a.value.clone().unwrap_or(Attribute::Unit));
            }
            d
        };
        if updated.len() <= 1 {
            self.replace_new(op, with_attrs(OpData::build("llvm.return").operands(&updated)), &[]);
            return true;
        }
        let types = self.rw.body.types(&originals);
        let Some((packed, _)) = self.llvm_pack_results(opts, &types, bare) else { return false };
        let mut p = self.poison(packed);
        for (i, v) in updated.into_iter().enumerate() {
            p = self.insert_value(p, v, &[i as i64]);
        }
        self.replace_new(op, with_attrs(OpData::build("llvm.return").operands(&[p])), &[]);
        true
    }
}
