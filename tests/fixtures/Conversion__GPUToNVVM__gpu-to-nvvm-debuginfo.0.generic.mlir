#loc6 = loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":30:3)
#loc7 = loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":30:31)
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_1"}> ({
    "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<28 x i8>, linkage = #llvm.linkage<internal>, sym_name = "printfFormat_0", value = "Hello, world with location\0A\00", visibility_ = 0 : i64}> ({
    }) : () -> () loc(#loc2)
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "vprintf", visibility_ = 0 : i64}> ({
    }) : () -> () loc(#loc2)
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "test_const_printf_with_loc", visibility_ = 0 : i64}> ({
      %2 = "llvm.mlir.addressof"() <{global_name = @printfFormat_0}> : () -> !llvm.ptr loc(#loc9)
      %3 = "llvm.getelementptr"(%2) <{elem_type = !llvm.array<28 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr loc(#loc9)
      %4 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64 loc(#loc9)
      %5 = "llvm.alloca"(%4) <{elem_type = !llvm.struct<()>}> : (i64) -> !llvm.ptr loc(#loc9)
      %6 = "llvm.call"(%3, %5) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @vprintf, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> i32 loc(#loc9)
      "llvm.return"() : () -> () loc(#loc4)
    }) : () -> () loc(#loc3)
  }) : () -> () loc(#loc1)
  "gpu.module"() <{sym_name = "test_module_2"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "__nv_abs", visibility_ = 0 : i64}> ({
    }) : () -> () loc(#loc2)
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "gpu_abs_with_loc", visibility_ = 0 : i64}> ({
    ^bb0(%arg1: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":30:31)):
      %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @__nv_abs, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i32 loc(#loc9)
      "llvm.return"(%1) : (i32) -> () loc(#loc8)
    }) {llvm.emit_c_interface} : () -> () loc(#loc6)
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_abs_with_loc", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":30:3)):
      %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_abs_with_loc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i32 loc(#loc6)
      "llvm.return"(%0) : (i32) -> () loc(#loc6)
    }) {llvm.emit_c_interface} : () -> () loc(#loc6)
  }) : () -> () loc(#loc5)
}) : () -> () loc(#loc)
#di_file = #llvm.di_file<"foo.mlir" in "/tmp/">
#loc = loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":0:0)
#loc1 = loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":17:1)
#loc2 = loc("foo.mlir":0:0)
#loc3 = loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":21:3)
#loc4 = loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":23:5)
#loc5 = loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":28:1)
#loc8 = loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":32:5)
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C, file = #di_file, producer = "MLIR", isOptimized = true, emissionKind = Full>
#di_subprogram = #llvm.di_subprogram<compileUnit = #di_compile_unit, scope = #di_file, name = "test_const_printf_with_loc", file = #di_file, subprogramFlags = Definition>
#loc9 = loc(fused<#di_subprogram>[#loc2])

