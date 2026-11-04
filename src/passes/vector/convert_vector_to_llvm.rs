//! `convert-vector-to-llvm`.

use crate::{llvm_target};
use crate::{LlvmConverter, LlvmOptions, VectorOptions, VectorToLlvm};
#[cfg(feature = "dialect.x86vector")]
use crate::X86ToLlvm;
use alloc::format;
use alloc::string::String;
use crate::pass;
use mlirformat::Error;
use crate::{Body, ConversionConfig, ConversionPatterns, Converter, Lowering, Mode, OpId, Run, transfer_read_to_load, transfer_write_to_store};

/// `convert-vector-to-llvm`: the vector-to-vector lowerings greedily, then the conversion.
#[pass("convert-vector-to-llvm", check = Self::check)]
pub struct ConvertVectorToLlvm {
    #[opt("reassociate-fp-reductions")]
    reassociate: bool,
    #[opt("force-32bit-vector-indices", default = true)]
    force32: bool,
    #[opt("use-vector-alignment")]
    vector_alignment: bool,
    #[opt("vector-contract-lowering", default = "dot".into())]
    contract_lowering: String,
    #[opt("vector-transpose-lowering", default = "eltwise".into())]
    transpose_lowering: String,
    #[opt("enable-amx")]
    amx: bool,
    #[opt("enable-arm-neon")]
    arm_neon: bool,
    #[opt("enable-arm-sve")]
    arm_sve: bool,
    #[opt("enable-arm-i8mm")]
    arm_i8mm: bool,
    #[opt("enable-arm-bf16")]
    arm_bf16: bool,
    #[opt("enable-x86vector")]
    x86vector: bool,
    counter: core::sync::atomic::AtomicU32,
}

impl ConvertVectorToLlvm {
    /// What is not ported makes the pass unsupported, not wrong.
    fn check(&self) -> Result<(), Error> {
        let flags = [("enable-arm-neon", self.arm_neon), ("enable-arm-sve", self.arm_sve), ("enable-arm-i8mm", self.arm_i8mm), ("enable-arm-bf16", self.arm_bf16)];
        if let Some((f, _)) = flags.iter().find(|f| f.1) {
            return Err(Error(format!("convert-vector-to-llvm: {f} is not ported")));
        }
        for (k, v, default) in [("vector-contract-lowering", &self.contract_lowering, "dot"), ("vector-transpose-lowering", &self.transpose_lowering, "eltwise")] {
            if v != default {
                return Err(Error(format!("convert-vector-to-llvm: {k} is not ported")));
            }
        }
        Ok(())
    }
}

impl Run for ConvertVectorToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let pre = crate::vector_pre_patterns(self.force32);
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &pre, &crate::GreedyConfig::default());
        }
        let opts = LlvmOptions::default();
        // (the CPU dialects' lowerings are x86vector's: without it, asking for them is an error)
        #[cfg(not(feature = "dialect.x86vector"))]
        if self.x86vector || self.amx {
            return Err(Error(alloc::string::String::from("convert-vector-to-llvm: enable-x86vector / enable-amx need the dialect.x86vector feature")));
        }
        #[allow(unused_mut)]
        let mut tc = LlvmConverter::build(opts);
        #[cfg(feature = "dialect.x86vector")]
        if self.amx {
            X86ToLlvm::convert_tiles(&mut tc);
        }
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        patterns.add(Lowering { root: "vector.transfer_read", benefit: 1, f: |cr, op, _| transfer_read_to_load(cr, op, None) });
        patterns.add(Lowering { root: "vector.transfer_write", benefit: 1, f: |cr, op, _| transfer_write_to_store(cr, op, None) });
        VectorToLlvm::populate(&mut patterns, i, VectorOptions { llvm: opts, reassociate_fp_reductions: self.reassociate, force_32bit_indices: self.force32, use_vector_alignment: self.vector_alignment, counter: &self.counter });
        // The CPU dialects (`enable-x86vector`, `enable-amx`) lower to intrinsic calls.
        #[cfg(feature = "dialect.x86vector")]
        X86ToLlvm::populate(&mut patterns, i, opts, self.x86vector, self.amx);
        let mut target = llvm_target();
        target.legal_dialect("arith").legal_dialect("memref");
        if self.x86vector {
            target.illegal_dialect("x86vector");
        }
        if self.amx {
            target.illegal_dialect("amx");
        }
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
