#loc7 = loc("/home/zq/coding/llvm-project/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":30:31)
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.printf"() <{format = "Hello, world with location\0A"}> : () -> () loc(#loc9)
      "gpu.return"() : () -> () loc(#loc4)
    }) {sym_name = "test_const_printf_with_loc", workgroup_attributions = 0 : i64} : () -> () loc(#loc2)
  }) : () -> () loc(#loc1)
  "gpu.module"() <{sym_name = "test_module_2"}> ({
    "func.func"() <{function_type = (i32) -> i32, sym_name = "gpu_abs_with_loc"}> ({
    ^bb0(%arg0: i32 loc("/home/zq/coding/llvm-project/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":30:31)):
      %0 = "math.absi"(%arg0) : (i32) -> i32 loc(#loc9)
      "func.return"(%0) : (i32) -> () loc(#loc8)
    }) : () -> () loc(#loc6)
  }) : () -> () loc(#loc5)
}) : () -> () loc(#loc)
#di_file = #llvm.di_file<"foo.mlir" in "/tmp/">
#loc = loc("/home/zq/coding/llvm-project/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":0:0)
#loc1 = loc("/home/zq/coding/llvm-project/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":17:1)
#loc2 = loc("/home/zq/coding/llvm-project/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":21:3)
#loc3 = loc("foo.mlir":0:0)
#loc4 = loc("/home/zq/coding/llvm-project/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":23:5)
#loc5 = loc("/home/zq/coding/llvm-project/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":28:1)
#loc6 = loc("/home/zq/coding/llvm-project/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":30:3)
#loc8 = loc("/home/zq/coding/llvm-project/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":32:5)
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C, file = #di_file, producer = "MLIR", isOptimized = true, emissionKind = Full>
#di_subprogram = #llvm.di_subprogram<compileUnit = #di_compile_unit, scope = #di_file, name = "test_const_printf_with_loc", file = #di_file, subprogramFlags = Definition>
#loc9 = loc(fused<#di_subprogram>[#loc3])

