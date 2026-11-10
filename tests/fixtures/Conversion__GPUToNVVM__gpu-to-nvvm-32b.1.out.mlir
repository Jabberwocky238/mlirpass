module {
  gpu.module @test_module_0 {
    llvm.func @gpu_index_ops() -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> {
      %0 = nvvm.read.ptx.sreg.tid.x : i32
      %1 = nvvm.read.ptx.sreg.tid.y : i32
      %2 = nvvm.read.ptx.sreg.tid.z : i32
      %3 = nvvm.read.ptx.sreg.ntid.x : i32
      %4 = nvvm.read.ptx.sreg.ntid.y : i32
      %5 = nvvm.read.ptx.sreg.ntid.z : i32
      %6 = nvvm.read.ptx.sreg.ctaid.x : i32
      %7 = nvvm.read.ptx.sreg.ctaid.y : i32
      %8 = nvvm.read.ptx.sreg.ctaid.z : i32
      %9 = nvvm.read.ptx.sreg.nctaid.x : i32
      %10 = nvvm.read.ptx.sreg.nctaid.y : i32
      %11 = nvvm.read.ptx.sreg.nctaid.z : i32
      %12 = nvvm.read.ptx.sreg.laneid range <i32, 0, 32> : i32
      %13 = llvm.mlir.poison : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
      %14 = llvm.insertvalue %0, %13[0] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %15 = llvm.insertvalue %1, %14[1] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %16 = llvm.insertvalue %2, %15[2] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %17 = llvm.insertvalue %3, %16[3] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %18 = llvm.insertvalue %4, %17[4] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %19 = llvm.insertvalue %5, %18[5] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %20 = llvm.insertvalue %6, %19[6] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %21 = llvm.insertvalue %7, %20[7] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %22 = llvm.insertvalue %8, %21[8] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %23 = llvm.insertvalue %9, %22[9] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %24 = llvm.insertvalue %10, %23[10] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %25 = llvm.insertvalue %11, %24[11] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      %26 = llvm.insertvalue %12, %25[12] : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)> 
      llvm.return %26 : !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)>
    }
  }
  gpu.module @test_module_1 {
    llvm.func @gpu_index_comp(%arg0: i32) -> i32 {
      %0 = llvm.add %arg0, %arg0 : i32
      llvm.return %0 : i32
    }
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["gpu.module"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_conversion_patterns to %0 {
        transform.apply_conversion_patterns.dialect_to_llvm "arith"
        transform.apply_conversion_patterns.dialect_to_llvm "cf"
        transform.apply_conversion_patterns.vector.vector_to_llvm
        transform.apply_conversion_patterns.func.func_to_llvm
        transform.apply_conversion_patterns.dialect_to_llvm "memref"
        transform.apply_conversion_patterns.gpu.gpu_to_nvvm {benefit = 10 : i16}
        transform.apply_conversion_patterns.gpu.gpu_wmma_to_nvvm
        transform.apply_conversion_patterns.gpu.gpu_subgroup_reduce_to_nvvm {has_redux = true}
        transform.apply_conversion_patterns.nvgpu.nvgpu_to_nvvm
      } with type_converter {
        transform.apply_conversion_patterns.memref.memref_to_llvm_type_converter {index_bitwidth = 32 : i64, use_opaque_pointers = true}
      } {illegal_dialects = ["gpu"], illegal_ops = ["llvm.cos", "llvm.exp", "llvm.exp2", "llvm.fabs", "llvm.fceil", "llvm.ffloor", "llvm.log", "llvm.log10", "llvm.log2", "llvm.pow", "llvm.sin", "llvm.sqrt"], legal_dialects = ["llvm", "memref", "nvvm"], legal_ops = ["gpu.module", "gpu.yield"], partial_conversion} : !transform.any_op
      transform.yield 
    }
  }
}

