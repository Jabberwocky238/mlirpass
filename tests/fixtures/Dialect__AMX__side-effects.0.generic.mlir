"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32x32xbf16>, memref<2x16x32xbf16>) -> memref<16x32xf32>, sym_name = "do_not_fold_tiles"}> ({
  ^bb0(%arg0: memref<2x32x32xbf16>, %arg1: memref<2x16x32xbf16>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<2x16x32xbf16>) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<2x32x32xbf16>) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "builtin.unrealized_conversion_cast"(%3) : (index) -> i64
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.constant"() <{value = 16 : index}> : () -> index
    %7 = "builtin.unrealized_conversion_cast"(%6) : (index) -> i64
    %8 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xf32>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (memref<16x32xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %11 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %12 = "llvm.call_intrinsic"(%10, %11) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilezero.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i16, i16) -> !llvm.x86_amx
    %13 = "builtin.unrealized_conversion_cast"(%12) : (!llvm.x86_amx) -> !amx.tile<16x16xf32>
    %14 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %15 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %16 = "llvm.call_intrinsic"(%14, %15) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilezero.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i16, i16) -> !llvm.x86_amx
    %17 = "builtin.unrealized_conversion_cast"(%16) : (!llvm.x86_amx) -> !amx.tile<16x16xf32>
    %18:2 = "scf.for"(%3, %5, %2, %13, %17) ({
    ^bb0(%arg2: index, %arg3: !amx.tile<16x16xf32>, %arg4: !amx.tile<16x16xf32>):
      %37 = "builtin.unrealized_conversion_cast"(%arg4) : (!amx.tile<16x16xf32>) -> !llvm.x86_amx
      %38 = "builtin.unrealized_conversion_cast"(%arg3) : (!amx.tile<16x16xf32>) -> !llvm.x86_amx
      %39 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
      %40 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
      %41 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
      %42 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
      %43 = "llvm.mlir.constant"() <{value = 1024 : index}> : () -> i64
      %44 = "llvm.mul"(%39, %43) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %45 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %46 = "llvm.mul"(%4, %45) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %47 = "llvm.add"(%44, %46) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %48 = "llvm.add"(%47, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %49 = "llvm.getelementptr"(%42, %48) <{elem_type = bf16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      %50 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
      %51 = "llvm.call_intrinsic"(%40, %41, %49, %50) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
      %52 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
      %53 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
      %54 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
      %55 = "llvm.mlir.constant"() <{value = 1024 : index}> : () -> i64
      %56 = "llvm.mul"(%39, %55) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %57 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %58 = "llvm.mul"(%7, %57) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %59 = "llvm.add"(%56, %58) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %60 = "llvm.add"(%59, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %61 = "llvm.getelementptr"(%54, %60) <{elem_type = bf16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      %62 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
      %63 = "llvm.call_intrinsic"(%52, %53, %61, %62) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
      %64 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
      %65 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
      %66 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
      %67 = "llvm.mlir.constant"() <{value = 512 : index}> : () -> i64
      %68 = "llvm.mul"(%39, %67) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %69 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %70 = "llvm.mul"(%4, %69) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %71 = "llvm.add"(%68, %70) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %72 = "llvm.add"(%71, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %73 = "llvm.getelementptr"(%66, %72) <{elem_type = bf16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      %74 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
      %75 = "llvm.call_intrinsic"(%64, %65, %73, %74) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
      %76 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
      %77 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
      %78 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
      %79 = "llvm.mlir.constant"() <{value = 512 : index}> : () -> i64
      %80 = "llvm.mul"(%39, %79) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %81 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
      %82 = "llvm.mul"(%4, %81) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %83 = "llvm.add"(%80, %82) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %84 = "llvm.add"(%83, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %85 = "llvm.getelementptr"(%78, %84) <{elem_type = bf16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      %86 = "llvm.mlir.constant"() <{value = 64 : i64}> : () -> i64
      %87 = "llvm.call_intrinsic"(%76, %77, %85, %86) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tileloadd64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (i16, i16, !llvm.ptr, i64) -> !llvm.x86_amx
      %88 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
      %89 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
      %90 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
      %91 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
      %92 = "llvm.call_intrinsic"(%88, %91, %89, %38, %51, %75) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tdpbf16ps.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> : (i16, i16, i16, !llvm.x86_amx, !llvm.x86_amx, !llvm.x86_amx) -> !llvm.x86_amx
      %93 = "builtin.unrealized_conversion_cast"(%92) : (!llvm.x86_amx) -> !amx.tile<16x16xf32>
      %94 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
      %95 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
      %96 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
      %97 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
      %98 = "llvm.call_intrinsic"(%94, %97, %95, %37, %63, %87) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tdpbf16ps.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> : (i16, i16, i16, !llvm.x86_amx, !llvm.x86_amx, !llvm.x86_amx) -> !llvm.x86_amx
      %99 = "builtin.unrealized_conversion_cast"(%98) : (!llvm.x86_amx) -> !amx.tile<16x16xf32>
      "scf.yield"(%93, %99) : (!amx.tile<16x16xf32>, !amx.tile<16x16xf32>) -> ()
    }) : (index, index, index, !amx.tile<16x16xf32>, !amx.tile<16x16xf32>) -> (!amx.tile<16x16xf32>, !amx.tile<16x16xf32>)
    %19 = "builtin.unrealized_conversion_cast"(%18#1) : (!amx.tile<16x16xf32>) -> !llvm.x86_amx
    %20 = "builtin.unrealized_conversion_cast"(%18#0) : (!amx.tile<16x16xf32>) -> !llvm.x86_amx
    %21 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %22 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %23 = "llvm.extractvalue"(%9) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %24 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %25 = "llvm.mul"(%4, %24) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %26 = "llvm.add"(%25, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %27 = "llvm.getelementptr"(%23, %26) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %28 = "llvm.mlir.constant"() <{value = 128 : i64}> : () -> i64
    "llvm.call_intrinsic"(%21, %22, %27, %28, %20) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    %29 = "llvm.mlir.constant"() <{value = 16 : i16}> : () -> i16
    %30 = "llvm.mlir.constant"() <{value = 64 : i16}> : () -> i16
    %31 = "llvm.extractvalue"(%9) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %32 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %33 = "llvm.mul"(%4, %32) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %34 = "llvm.add"(%33, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %35 = "llvm.getelementptr"(%31, %34) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %36 = "llvm.mlir.constant"() <{value = 128 : i64}> : () -> i64
    "llvm.call_intrinsic"(%29, %30, %35, %36, %19) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.tilestored64.internal", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (i16, i16, !llvm.ptr, i64, !llvm.x86_amx) -> ()
    "func.return"(%8) : (memref<16x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

