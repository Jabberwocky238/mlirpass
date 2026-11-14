impl crate::Passes {
    pub fn upstream() -> Self {
        let mut p = Self::new();
        p.with(Self::add_upstream);
        p
    }

    pub fn add_upstream(&mut self) {
        let p = self;
        #[cfg(feature = "dialect.affine")]
        p.register::<crate::ConvertAffineForToGpu>();
        #[cfg(feature = "dialect.affine")]
        p.register::<crate::LowerAffine>();
        #[cfg(feature = "target.agx")]
        p.register::<crate::AgxEnd>();
        #[cfg(feature = "target.agx")]
        p.register::<crate::AgxLayout>();
        #[cfg(feature = "target.agx")]
        p.register::<crate::AgxRegalloc>();
        #[cfg(feature = "target.agx")]
        p.register::<crate::AgxWait>();
        #[cfg(all(feature = "dialect.amdgpu", feature = "target.llvm"))]
        p.register::<crate::ConvertAmdgpuToRocdl>();
        #[cfg(feature = "target.apple9")]
        p.register::<crate::Apple9Control>();
        #[cfg(feature = "target.apple9")]
        p.register::<crate::Apple9Regalloc>();
        #[cfg(feature = "target.apple9")]
        p.register::<crate::Apple9Wait>();
        #[cfg(all(all(feature = "dialect.arith", any(feature = "target.emitc", feature = "target.llvm", feature = "target.spirv")), all(feature = "dialect.amdgpu", feature = "dialect.vector")))]
        p.register::<crate::ConvertArithToAmdgpu>();
        #[cfg(all(all(feature = "dialect.arith", any(feature = "target.emitc", feature = "target.llvm", feature = "target.spirv")), feature = "target.emitc"))]
        p.register::<crate::ConvertArithToEmitc>();
        #[cfg(all(all(feature = "dialect.arith", any(feature = "target.emitc", feature = "target.llvm", feature = "target.spirv")), feature = "target.llvm"))]
        p.register::<crate::ConvertArithToLlvm>();
        #[cfg(all(all(feature = "dialect.arith", any(feature = "target.emitc", feature = "target.llvm", feature = "target.spirv")), feature = "target.spirv"))]
        p.register::<crate::ConvertArithToSpirv>();
        #[cfg(feature = "dialect.bufferization")]
        p.register::<crate::BufferResultsToOutParams>();
        #[cfg(feature = "dialect.bufferization")]
        p.register::<crate::ConvertBufferizationToMemref>();
        #[cfg(feature = "dialect.bufferization")]
        p.register::<crate::DropEquivalentBufferResults>();
        #[cfg(feature = "dialect.bufferization")]
        p.register::<crate::OneShotBufferize>();
        #[cfg(feature = "dialect.bufferization")]
        p.register::<crate::PromoteBuffersToStack>();
        #[cfg(all(feature = "dialect.cf", feature = "target.llvm"))]
        p.register::<crate::ConvertCfToLlvm>();
        #[cfg(all(feature = "dialect.cf", feature = "target.spirv"))]
        p.register::<crate::ConvertCfToSpirv>();
        #[cfg(all(feature = "dialect.cf", all(feature = "dialect.scf", feature = "dialect.func")))]
        p.register::<crate::LiftCfToScf>();
        #[cfg(feature = "dialect.complex")]
        p.register::<crate::ConvertComplexToLibm>();
        #[cfg(all(feature = "dialect.complex", feature = "target.llvm"))]
        p.register::<crate::ConvertComplexToLlvm>();
        #[cfg(all(feature = "dialect.complex", all(feature = "dialect.func", feature = "dialect.arith")))]
        p.register::<crate::ConvertComplexToRocdlLibraryCalls>();
        #[cfg(all(feature = "dialect.complex", feature = "target.spirv"))]
        p.register::<crate::ConvertComplexToSpirv>();
        #[cfg(feature = "dialect.complex")]
        p.register::<crate::ConvertComplexToStandard>();
        #[cfg(feature = "target.emitc")]
        p.register::<crate::ConvertToEmitc>();
        #[cfg(all(all(feature = "dialect.func", any(feature = "target.emitc", feature = "target.llvm", feature = "target.spirv")), feature = "target.emitc"))]
        p.register::<crate::ConvertFuncToEmitc>();
        #[cfg(all(all(feature = "dialect.func", any(feature = "target.emitc", feature = "target.llvm", feature = "target.spirv")), feature = "target.llvm"))]
        p.register::<crate::ConvertFuncToLlvm>();
        #[cfg(all(all(feature = "dialect.func", any(feature = "target.emitc", feature = "target.llvm", feature = "target.spirv")), feature = "target.spirv"))]
        p.register::<crate::ConvertFuncToSpirv>();
        #[cfg(all(feature = "dialect.gpu", feature = "target.agx"))]
        p.register::<crate::ConvertGpuToAgx>();
        #[cfg(all(feature = "dialect.gpu", feature = "target.apple9"))]
        p.register::<crate::ConvertGpuToApple9>();
        #[cfg(all(feature = "dialect.gpu", feature = "target.llvm"))]
        p.register::<crate::ConvertGpuToLlvmSpv>();
        #[cfg(all(feature = "dialect.gpu", all(feature = "target.llvm", feature = "dialect.nvvm")))]
        p.register::<crate::ConvertGpuToNvvm>();
        #[cfg(all(feature = "dialect.gpu", feature = "target.rdna2"))]
        p.register::<crate::ConvertGpuToRdna2>();
        #[cfg(all(feature = "dialect.gpu", all(feature = "target.llvm", feature = "dialect.amdgpu", feature = "dialect.math")))]
        p.register::<crate::ConvertGpuToRocdl>();
        #[cfg(all(feature = "dialect.gpu", all(feature = "target.spirv", feature = "dialect.func", feature = "dialect.scf", feature = "dialect.vector")))]
        p.register::<crate::ConvertGpuToSpirv>();
        #[cfg(all(feature = "dialect.gpu", feature = "target.xe3"))]
        p.register::<crate::ConvertGpuToXe3>();
        #[cfg(all(feature = "dialect.gpu", any(feature = "target.agx", feature = "target.apple9", feature = "target.rdna2", feature = "target.xe3")))]
        p.register::<crate::GpuInlineCalls>();
        #[cfg(feature = "dialect.gpu")]
        p.register::<crate::GpuKernelOutlining>();
        #[cfg(feature = "dialect.gpu")]
        p.register::<crate::GpuLaunchSinkIndexComputations>();
        #[cfg(feature = "dialect.gpu")]
        p.register::<crate::GpuModuleToBinary>();
        #[cfg(feature = "dialect.gpu")]
        p.register::<crate::XevmAttachTarget>();
        #[cfg(all(all(feature = "dialect.index", any(feature = "target.llvm", feature = "target.spirv")), feature = "target.llvm"))]
        p.register::<crate::ConvertIndexToLlvm>();
        #[cfg(all(all(feature = "dialect.index", any(feature = "target.llvm", feature = "target.spirv")), feature = "target.spirv"))]
        p.register::<crate::ConvertIndexToSpirv>();
        #[cfg(feature = "dialect.linalg")]
        p.register::<crate::ConvertElementwiseToLinalg>();
        #[cfg(feature = "dialect.linalg")]
        p.register::<crate::ConvertLinalgToAffineLoops>();
        #[cfg(feature = "dialect.linalg")]
        p.register::<crate::ConvertLinalgToLoops>();
        #[cfg(feature = "dialect.linalg")]
        p.register::<crate::ConvertLinalgToParallelLoops>();
        #[cfg(feature = "dialect.linalg")]
        p.register::<crate::LinalgFoldUnitExtentDims>();
        #[cfg(feature = "target.llvm")]
        p.register::<crate::ConvertToLlvm>();
        #[cfg(feature = "target.llvm")]
        p.register::<crate::RequestCWrappers>();
        #[cfg(feature = "target.llvm")]
        p.register::<crate::SetLlvmModuleDataLayout>();
        #[cfg(all(feature = "dialect.math", feature = "target.emitc"))]
        p.register::<crate::ConvertMathToEmitc>();
        #[cfg(feature = "dialect.math")]
        p.register::<crate::ConvertMathToFuncs>();
        #[cfg(feature = "dialect.math")]
        p.register::<crate::ConvertMathToLibm>();
        #[cfg(all(feature = "dialect.math", feature = "target.llvm"))]
        p.register::<crate::ConvertMathToLlvm>();
        #[cfg(all(feature = "dialect.math", feature = "target.llvm"))]
        p.register::<crate::ConvertMathToRocdl>();
        #[cfg(all(feature = "dialect.math", feature = "target.spirv"))]
        p.register::<crate::ConvertMathToSpirv>();
        #[cfg(all(feature = "dialect.math", feature = "target.llvm"))]
        p.register::<crate::ConvertMathToXevm>();
        #[cfg(all(feature = "dialect.memref", feature = "target.emitc"))]
        p.register::<crate::ConvertMemrefToEmitc>();
        #[cfg(all(feature = "dialect.memref", feature = "target.spirv"))]
        p.register::<crate::ConvertMemrefToSpirv>();
        #[cfg(feature = "dialect.memref")]
        p.register::<crate::ExpandStridedMetadata>();
        #[cfg(all(feature = "dialect.memref", feature = "target.llvm"))]
        p.register::<crate::FinalizeMemrefToLlvm>();
        #[cfg(feature = "dialect.memref")]
        p.register::<crate::FoldMemrefAliasOps>();
        #[cfg(all(feature = "dialect.memref", feature = "target.spirv"))]
        p.register::<crate::MapMemrefSpirvStorageClass>();
        #[cfg(feature = "dialect.memref")]
        p.register::<crate::ResolveRankedShapedTypeResultDims>();
        #[cfg(feature = "dialect.memref")]
        p.register::<crate::ResolveShapedTypeResultDims>();
        #[cfg(all(feature = "dialect.nvgpu", feature = "target.llvm"))]
        p.register::<crate::ConvertNvgpuToNvvm>();
        #[cfg(all(feature = "dialect.nvvm", feature = "target.llvm"))]
        p.register::<crate::ConvertNvvmToLlvm>();
        #[cfg(feature = "target.rdna2")]
        p.register::<crate::Rdna2Layout>();
        #[cfg(feature = "target.rdna2")]
        p.register::<crate::Rdna2Pad>();
        #[cfg(feature = "target.rdna2")]
        p.register::<crate::Rdna2Pm4>();
        #[cfg(feature = "target.rdna2")]
        p.register::<crate::Rdna2Regalloc>();
        #[cfg(feature = "target.rdna2")]
        p.register::<crate::Rdna2Waitcnt>();
        #[cfg(all(feature = "dialect.scf", all(feature = "dialect.gpu", feature = "dialect.affine")))]
        p.register::<crate::ConvertParallelLoopsToGpu>();
        #[cfg(feature = "dialect.scf")]
        p.register::<crate::ConvertScfToCf>();
        #[cfg(all(feature = "dialect.scf", feature = "target.emitc"))]
        p.register::<crate::ConvertScfToEmitc>();
        #[cfg(all(feature = "dialect.scf", all(feature = "target.spirv", feature = "dialect.arith", feature = "dialect.func", feature = "dialect.index", feature = "dialect.memref")))]
        p.register::<crate::ConvertScfToSpirv>();
        #[cfg(all(feature = "dialect.scf", all(feature = "dialect.gpu", feature = "dialect.affine")))]
        p.register::<crate::GpuMapParallelLoops>();
        #[cfg(feature = "dialect.shape")]
        p.register::<crate::ConvertShapeToStd>();
        #[cfg(all(any(feature = "target.spirv", feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"), any(feature = "target.agx", feature = "target.rdna2", feature = "target.xe3")))]
        p.register::<crate::ConvertSpirvEntryPoints>();
        #[cfg(all(any(feature = "target.spirv", feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"), feature = "target.spirv"))]
        p.register::<crate::DecorateSpirvCompositeTypeLayout>();
        #[cfg(all(any(feature = "target.spirv", feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"), feature = "target.spirv"))]
        p.register::<crate::SpirvAttachTarget>();
        #[cfg(all(any(feature = "target.spirv", feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"), feature = "target.spirv"))]
        p.register::<crate::SpirvCanonicalizeGl>();
        #[cfg(all(any(feature = "target.spirv", feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"), feature = "target.spirv"))]
        p.register::<crate::SpirvLowerAbiAttrs>();
        #[cfg(all(any(feature = "target.spirv", feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"), feature = "target.spirv"))]
        p.register::<crate::SpirvPromoteToReplicatedConstants>();
        #[cfg(all(any(feature = "target.spirv", feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"), feature = "target.spirv"))]
        p.register::<crate::SpirvRewriteInserts>();
        #[cfg(all(any(feature = "target.spirv", feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"), feature = "target.spirv"))]
        p.register::<crate::SpirvUnifyAliasedResource>();
        #[cfg(all(any(feature = "target.spirv", feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"), feature = "target.spirv"))]
        p.register::<crate::SpirvUpdateVce>();
        #[cfg(all(any(feature = "target.spirv", feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"), feature = "target.spirv"))]
        p.register::<crate::SpirvWebgpuPrepare>();
        #[cfg(all(all(feature = "dialect.tensor", any(feature = "dialect.linalg", all(feature = "target.spirv", feature = "dialect.memref", feature = "dialect.func"))), feature = "dialect.linalg"))]
        p.register::<crate::ConvertTensorToLinalg>();
        #[cfg(all(all(feature = "dialect.tensor", any(feature = "dialect.linalg", all(feature = "target.spirv", feature = "dialect.memref", feature = "dialect.func"))), all(feature = "target.spirv", feature = "dialect.memref", feature = "dialect.func")))]
        p.register::<crate::ConvertTensorToSpirv>();
        #[cfg(feature = "dialect.tosa")]
        p.register::<crate::TosaToArithPass>();
        #[cfg(feature = "dialect.tosa")]
        p.register::<crate::TosaToLinalgPass>();
        #[cfg(feature = "dialect.tosa")]
        p.register::<crate::TosaToLinalgNamedPass>();
        #[cfg(feature = "dialect.tosa")]
        p.register::<crate::TosaToScfPass>();
        #[cfg(feature = "dialect.tosa")]
        p.register::<crate::TosaToTensorPass>();
        p.register::<crate::Canonicalize>();
        p.register::<crate::Cse>();
        p.register::<crate::Inline>();
        p.register::<crate::LoopInvariantCodeMotion>();
        p.register::<crate::Mem2Reg>();
        p.register::<crate::ReconcileUnrealizedCasts>();
        p.register::<crate::RemoveDeadValues>();
        p.register::<crate::Sccp>();
        p.register::<crate::Sroa>();
        p.register::<crate::StripDebugInfo>();
        p.register::<crate::SymbolDce>();
        p.register::<crate::SymbolPrivatize>();
        #[cfg(all(all(feature = "dialect.ub", any(feature = "target.llvm", feature = "target.spirv")), feature = "target.llvm"))]
        p.register::<crate::ConvertUbToLlvm>();
        #[cfg(all(all(feature = "dialect.ub", any(feature = "target.llvm", feature = "target.spirv")), feature = "target.spirv"))]
        p.register::<crate::ConvertUbToSpirv>();
        #[cfg(all(feature = "dialect.vector", feature = "target.llvm"))]
        p.register::<crate::ConvertVectorToLlvm>();
        #[cfg(feature = "dialect.vector")]
        p.register::<crate::ConvertVectorToScf>();
        #[cfg(all(feature = "dialect.vector", feature = "target.spirv"))]
        p.register::<crate::ConvertVectorToSpirv>();
        #[cfg(all(feature = "dialect.vector", feature = "dialect.xegpu"))]
        p.register::<crate::ConvertVectorToXegpu>();
        #[cfg(feature = "target.xe3")]
        p.register::<crate::Xe3Branches>();
        #[cfg(feature = "target.xe3")]
        p.register::<crate::Xe3Control>();
        #[cfg(feature = "target.xe3")]
        p.register::<crate::Xe3End>();
        #[cfg(feature = "target.xe3")]
        p.register::<crate::Xe3Layout>();
        #[cfg(feature = "target.xe3")]
        p.register::<crate::Xe3Pad>();
        #[cfg(feature = "target.xe3")]
        p.register::<crate::Xe3Regalloc>();
        #[cfg(feature = "target.xe3")]
        p.register::<crate::Xe3Swsb>();
        #[cfg(all(feature = "dialect.xegpu", feature = "target.llvm"))]
        p.register::<crate::ConvertXegpuToXevm>();
        #[cfg(all(feature = "dialect.xevm", feature = "target.llvm"))]
        p.register::<crate::ConvertXevmToLlvm>();
    }
}
