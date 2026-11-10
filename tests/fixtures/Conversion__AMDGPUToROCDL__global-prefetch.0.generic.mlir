"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x64xf16, #gpu.address_space<global>>, i64, i64) -> (), sym_name = "glb_prefetch0"}> ({
  ^bb0(%arg9: memref<64x64xf16, #gpu.address_space<global>>, %arg10: i64, %arg11: i64):
    %18 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<64x64xf16, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "llvm.extractvalue"(%18) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %20 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %21 = "llvm.mul"(%arg10, %20) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %22 = "llvm.add"(%21, %arg11) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %23 = "llvm.getelementptr"(%19, %22) <{elem_type = f16, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    "rocdl.global.prefetch"(%23) <{cachePolicy = #rocdl<gfx12_cache_policy lu>}> : (!llvm.ptr<1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64x64xf16, #gpu.address_space<global>>, i64, i64) -> (), sym_name = "glb_prefetch1"}> ({
  ^bb0(%arg6: memref<64x64xf16, #gpu.address_space<global>>, %arg7: i64, %arg8: i64):
    %12 = "builtin.unrealized_conversion_cast"(%arg6) : (memref<64x64xf16, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %13 = "llvm.extractvalue"(%12) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %14 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %15 = "llvm.mul"(%arg7, %14) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %16 = "llvm.add"(%15, %arg8) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %17 = "llvm.getelementptr"(%13, %16) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    "rocdl.global.prefetch"(%17) <{cachePolicy = #rocdl<gfx12_cache_policy ht|scope_se>}> : (!llvm.ptr<1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64x64xf16, #gpu.address_space<global>>, i64, i64) -> (), sym_name = "glb_prefetch2"}> ({
  ^bb0(%arg3: memref<64x64xf16, #gpu.address_space<global>>, %arg4: i64, %arg5: i64):
    %6 = "builtin.unrealized_conversion_cast"(%arg3) : (memref<64x64xf16, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %7 = "llvm.extractvalue"(%6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %8 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %9 = "llvm.mul"(%arg4, %8) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %10 = "llvm.add"(%9, %arg5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %11 = "llvm.getelementptr"(%7, %10) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    "rocdl.global.prefetch"(%11) <{cachePolicy = #rocdl<gfx12_cache_policy scope_dev>}> : (!llvm.ptr<1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<64x64xf16, #gpu.address_space<global>>, i64, i64) -> (), sym_name = "glb_prefetch3"}> ({
  ^bb0(%arg0: memref<64x64xf16, #gpu.address_space<global>>, %arg1: i64, %arg2: i64):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<64x64xf16, #gpu.address_space<global>>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
    %2 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %3 = "llvm.mul"(%arg1, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %4 = "llvm.add"(%3, %arg2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %5 = "llvm.getelementptr"(%1, %4) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>
    "rocdl.global.prefetch"(%5) <{cachePolicy = #rocdl<gfx12_cache_policy nt_rt|scope_se>}> : (!llvm.ptr<1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

