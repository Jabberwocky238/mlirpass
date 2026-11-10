#loc6 = loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":30:3)
#loc7 = loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":30:31)
module {
  gpu.module @test_module_1 {
    llvm.mlir.global internal constant @printfFormat_0("Hello, world with location\0A\00") {addr_space = 0 : i32} loc(#loc2)
    llvm.func @vprintf(!llvm.ptr, !llvm.ptr) -> i32 loc(#loc2)
    llvm.func @test_const_printf_with_loc() {
      %0 = llvm.mlir.addressof @printfFormat_0 : !llvm.ptr loc(#loc9)
      %1 = llvm.getelementptr %0[0, 0] : (!llvm.ptr) -> !llvm.ptr, !llvm.array<28 x i8> loc(#loc9)
      %2 = llvm.mlir.constant(1 : index) : i64 loc(#loc9)
      %3 = llvm.alloca %2 x !llvm.struct<()> : (i64) -> !llvm.ptr loc(#loc9)
      %4 = llvm.call @vprintf(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i32 loc(#loc9)
      llvm.return loc(#loc4)
    } loc(#loc3)
  } loc(#loc1)
  gpu.module @test_module_2 {
    llvm.func @__nv_abs(i32) -> i32 loc(#loc2)
    llvm.func @gpu_abs_with_loc(%arg0: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":30:31)) -> i32 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @__nv_abs(%arg0) : (i32) -> i32 loc(#loc9)
      llvm.return %0 : i32 loc(#loc8)
    } loc(#loc6)
    llvm.func @_mlir_ciface_gpu_abs_with_loc(%arg0: i32 loc("/home/zq/coding/clone/llvm-project-23.1.5/mlir/test/Conversion/GPUToNVVM/gpu-to-nvvm-debuginfo.mlir":30:3)) -> i32 attributes {llvm.emit_c_interface} {
      %0 = llvm.call @gpu_abs_with_loc(%arg0) : (i32) -> i32 loc(#loc6)
      llvm.return %0 : i32 loc(#loc6)
    } loc(#loc6)
  } loc(#loc5)
} loc(#loc)
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

