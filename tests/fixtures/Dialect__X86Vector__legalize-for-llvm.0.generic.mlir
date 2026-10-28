"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xf32>, vector<8xf64>, i16, i8, i16, i8) -> (vector<16xf32>, vector<8xf64>, vector<16xf32>, vector<8xf64>), sym_name = "avx512_mask_rndscale"}> ({
  ^bb0(%arg38: vector<16xf32>, %arg39: vector<16xf32>, %arg40: vector<8xf64>, %arg41: i16, %arg42: i8, %arg43: i16, %arg44: i8):
    %57 = "arith.constant"() <{value = 15 : i32}> : () -> i32
    %58 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %59 = "llvm.call_intrinsic"(%arg38, %57, %arg39, %arg41, %58) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512.mask.rndscale.ps.512", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (vector<16xf32>, i32, vector<16xf32>, i16, i32) -> vector<16xf32>
    %60 = "llvm.call_intrinsic"(%arg40, %57, %arg40, %arg42, %58) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512.mask.rndscale.pd.512", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (vector<8xf64>, i32, vector<8xf64>, i8, i32) -> vector<8xf64>
    %61 = "llvm.call_intrinsic"(%arg39, %arg39, %arg39, %arg43, %58) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512.mask.scalef.ps.512", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (vector<16xf32>, vector<16xf32>, vector<16xf32>, i16, i32) -> vector<16xf32>
    %62 = "llvm.call_intrinsic"(%arg40, %arg40, %arg40, %arg44, %58) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512.mask.scalef.pd.512", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 5, 0>}> : (vector<8xf64>, vector<8xf64>, vector<8xf64>, i8, i32) -> vector<8xf64>
    "func.return"(%59, %60, %61, %62) : (vector<16xf32>, vector<8xf64>, vector<16xf32>, vector<8xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xi1>, vector<16xf32>, vector<8xi1>, vector<8xi64>) -> (vector<16xf32>, vector<16xf32>, vector<8xi64>), sym_name = "avx512_mask_compress"}> ({
  ^bb0(%arg34: vector<16xi1>, %arg35: vector<16xf32>, %arg36: vector<8xi1>, %arg37: vector<8xi64>):
    %52 = "llvm.mlir.constant"() <{value = dense<0.000000e+00> : vector<16xf32>}> : () -> vector<16xf32>
    %53 = "llvm.call_intrinsic"(%arg35, %52, %arg34) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512.mask.compress", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (vector<16xf32>, vector<16xf32>, vector<16xi1>) -> vector<16xf32>
    %54 = "llvm.mlir.constant"() <{value = dense<5.000000e+00> : vector<16xf32>}> : () -> vector<16xf32>
    %55 = "llvm.call_intrinsic"(%arg35, %54, %arg34) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512.mask.compress", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> {constant_src = dense<5.000000e+00> : vector<16xf32>} : (vector<16xf32>, vector<16xf32>, vector<16xi1>) -> vector<16xf32>
    %56 = "llvm.call_intrinsic"(%arg37, %arg37, %arg36) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512.mask.compress", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (vector<8xi64>, vector<8xi64>, vector<8xi1>) -> vector<8xi64>
    "func.return"(%53, %55, %56) : (vector<16xf32>, vector<16xf32>, vector<8xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xi32>, vector<8xi64>) -> (vector<16xi1>, vector<16xi1>, vector<8xi1>, vector<8xi1>), sym_name = "avx512_vp2intersect"}> ({
  ^bb0(%arg32: vector<16xi32>, %arg33: vector<8xi64>):
    %46 = "llvm.call_intrinsic"(%arg32, %arg32) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512.vp2intersect.d.512", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (vector<16xi32>, vector<16xi32>) -> !llvm.struct<(vector<16xi1>, vector<16xi1>)>
    %47 = "llvm.extractvalue"(%46) <{position = array<i64: 0>}> : (!llvm.struct<(vector<16xi1>, vector<16xi1>)>) -> vector<16xi1>
    %48 = "llvm.extractvalue"(%46) <{position = array<i64: 1>}> : (!llvm.struct<(vector<16xi1>, vector<16xi1>)>) -> vector<16xi1>
    %49 = "llvm.call_intrinsic"(%arg33, %arg33) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512.vp2intersect.q.512", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (vector<8xi64>, vector<8xi64>) -> !llvm.struct<(vector<8xi1>, vector<8xi1>)>
    %50 = "llvm.extractvalue"(%49) <{position = array<i64: 0>}> : (!llvm.struct<(vector<8xi1>, vector<8xi1>)>) -> vector<8xi1>
    %51 = "llvm.extractvalue"(%49) <{position = array<i64: 1>}> : (!llvm.struct<(vector<8xi1>, vector<8xi1>)>) -> vector<8xi1>
    "func.return"(%47, %48, %50, %51) : (vector<16xi1>, vector<16xi1>, vector<8xi1>, vector<8xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<8xbf16>, vector<8xbf16>) -> vector<4xf32>, sym_name = "avx512bf16_dot_128"}> ({
  ^bb0(%arg29: vector<4xf32>, %arg30: vector<8xbf16>, %arg31: vector<8xbf16>):
    %45 = "llvm.call_intrinsic"(%arg29, %arg30, %arg31) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512bf16.dpbf16ps.128", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (vector<4xf32>, vector<8xbf16>, vector<8xbf16>) -> vector<4xf32>
    "func.return"(%45) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>, vector<16xbf16>, vector<16xbf16>) -> vector<8xf32>, sym_name = "avx512bf16_dot_256"}> ({
  ^bb0(%arg26: vector<8xf32>, %arg27: vector<16xbf16>, %arg28: vector<16xbf16>):
    %44 = "llvm.call_intrinsic"(%arg26, %arg27, %arg28) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512bf16.dpbf16ps.256", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (vector<8xf32>, vector<16xbf16>, vector<16xbf16>) -> vector<8xf32>
    "func.return"(%44) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>, sym_name = "avx512bf16_dot_512"}> ({
  ^bb0(%arg23: vector<16xf32>, %arg24: vector<32xbf16>, %arg25: vector<32xbf16>):
    %43 = "llvm.call_intrinsic"(%arg23, %arg24, %arg25) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512bf16.dpbf16ps.512", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    "func.return"(%43) : (vector<16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> vector<8xbf16>, sym_name = "avx512bf16_cvt_packed_f32_to_bf16_256"}> ({
  ^bb0(%arg22: vector<8xf32>):
    %42 = "llvm.call_intrinsic"(%arg22) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512bf16.cvtneps2bf16.256", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (vector<8xf32>) -> vector<8xbf16>
    "func.return"(%42) : (vector<8xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xf32>) -> vector<16xbf16>, sym_name = "avx512bf16_cvt_packed_f32_to_bf16_512"}> ({
  ^bb0(%arg21: vector<16xf32>):
    %41 = "llvm.call_intrinsic"(%arg21) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx512bf16.cvtneps2bf16.512", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (vector<16xf32>) -> vector<16xbf16>
    "func.return"(%41) : (vector<16xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xbf16>) -> vector<4xf32>, sym_name = "avxbf16_cvt_packed_even_indexed_bf16_to_f32_128"}> ({
  ^bb0(%arg20: memref<8xbf16>):
    %38 = "builtin.unrealized_conversion_cast"(%arg20) : (memref<8xbf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %39 = "llvm.extractvalue"(%38) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %40 = "llvm.call_intrinsic"(%39) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.vcvtneebf162ps128", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> vector<4xf32>
    "func.return"(%40) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xbf16>) -> vector<8xf32>, sym_name = "avxbf16_cvt_packed_even_indexed_bf16_to_f32_256"}> ({
  ^bb0(%arg19: memref<16xbf16>):
    %35 = "builtin.unrealized_conversion_cast"(%arg19) : (memref<16xbf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %36 = "llvm.extractvalue"(%35) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %37 = "llvm.call_intrinsic"(%36) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.vcvtneebf162ps256", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> vector<8xf32>
    "func.return"(%37) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xbf16>) -> vector<4xf32>, sym_name = "avxbf16_cvt_packed_odd_indexed_bf16_to_f32_128"}> ({
  ^bb0(%arg18: memref<8xbf16>):
    %32 = "builtin.unrealized_conversion_cast"(%arg18) : (memref<8xbf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %33 = "llvm.extractvalue"(%32) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %34 = "llvm.call_intrinsic"(%33) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.vcvtneobf162ps128", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> vector<4xf32>
    "func.return"(%34) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xbf16>) -> vector<8xf32>, sym_name = "avxbf16_cvt_packed_odd_indexed_bf16_to_f32_256"}> ({
  ^bb0(%arg17: memref<16xbf16>):
    %29 = "builtin.unrealized_conversion_cast"(%arg17) : (memref<16xbf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %30 = "llvm.extractvalue"(%29) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %31 = "llvm.call_intrinsic"(%30) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.vcvtneobf162ps256", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> vector<8xf32>
    "func.return"(%31) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xbf16>) -> vector<4xf32>, sym_name = "avxbf16_bsct_bf16_to_f32_packed_128"}> ({
  ^bb0(%arg16: memref<1xbf16>):
    %26 = "builtin.unrealized_conversion_cast"(%arg16) : (memref<1xbf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %27 = "llvm.extractvalue"(%26) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %28 = "llvm.call_intrinsic"(%27) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.vbcstnebf162ps128", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> vector<4xf32>
    "func.return"(%28) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xbf16>) -> vector<8xf32>, sym_name = "avxbf16_bsct_bf16_to_f32_packed_256"}> ({
  ^bb0(%arg15: memref<1xbf16>):
    %23 = "builtin.unrealized_conversion_cast"(%arg15) : (memref<1xbf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %24 = "llvm.extractvalue"(%23) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %25 = "llvm.call_intrinsic"(%24) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.vbcstnebf162ps256", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> vector<8xf32>
    "func.return"(%25) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xf16>) -> vector<4xf32>, sym_name = "avxf16_cvt_packed_even_indexed_f16_to_f32_128"}> ({
  ^bb0(%arg14: memref<8xf16>):
    %20 = "builtin.unrealized_conversion_cast"(%arg14) : (memref<8xf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %21 = "llvm.extractvalue"(%20) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %22 = "llvm.call_intrinsic"(%21) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.vcvtneeph2ps128", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> vector<4xf32>
    "func.return"(%22) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xf16>) -> vector<8xf32>, sym_name = "avxf16_cvt_packed_even_indexed_f16_to_f32_256"}> ({
  ^bb0(%arg13: memref<16xf16>):
    %17 = "builtin.unrealized_conversion_cast"(%arg13) : (memref<16xf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %18 = "llvm.extractvalue"(%17) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %19 = "llvm.call_intrinsic"(%18) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.vcvtneeph2ps256", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> vector<8xf32>
    "func.return"(%19) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xf16>) -> vector<4xf32>, sym_name = "avxf16_cvt_packed_odd_indexed_f16_to_f32_128"}> ({
  ^bb0(%arg12: memref<8xf16>):
    %14 = "builtin.unrealized_conversion_cast"(%arg12) : (memref<8xf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = "llvm.extractvalue"(%14) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %16 = "llvm.call_intrinsic"(%15) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.vcvtneoph2ps128", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> vector<4xf32>
    "func.return"(%16) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xf16>) -> vector<8xf32>, sym_name = "avxf16_cvt_packed_odd_indexed_f16_to_f32_256"}> ({
  ^bb0(%arg11: memref<16xf16>):
    %11 = "builtin.unrealized_conversion_cast"(%arg11) : (memref<16xf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.extractvalue"(%11) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %13 = "llvm.call_intrinsic"(%12) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.vcvtneoph2ps256", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> vector<8xf32>
    "func.return"(%13) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xf16>) -> vector<4xf32>, sym_name = "avxf16_bsct_f16_to_f32_packed_128"}> ({
  ^bb0(%arg10: memref<1xf16>):
    %8 = "builtin.unrealized_conversion_cast"(%arg10) : (memref<1xf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.extractvalue"(%8) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %10 = "llvm.call_intrinsic"(%9) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.vbcstnesh2ps128", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> vector<4xf32>
    "func.return"(%10) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xf16>) -> vector<8xf32>, sym_name = "avxf16_bsct_f16_to_f32_packed_256"}> ({
  ^bb0(%arg9: memref<1xf16>):
    %5 = "builtin.unrealized_conversion_cast"(%arg9) : (memref<1xf16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %6 = "llvm.extractvalue"(%5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %7 = "llvm.call_intrinsic"(%6) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.vbcstnesh2ps256", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> vector<8xf32>
    "func.return"(%7) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> vector<8xf32>, sym_name = "avx_rsqrt"}> ({
  ^bb0(%arg8: vector<8xf32>):
    %4 = "llvm.call_intrinsic"(%arg8) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx.rsqrt.ps.256", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (vector<8xf32>) -> vector<8xf32>
    "func.return"(%4) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>, vector<8xf32>) -> vector<8xf32>, sym_name = "avx_dot"}> ({
  ^bb0(%arg6: vector<8xf32>, %arg7: vector<8xf32>):
    %2 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
    %3 = "llvm.call_intrinsic"(%arg6, %arg7, %2) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx.dp.ps.256", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (vector<8xf32>, vector<8xf32>, i8) -> vector<8xf32>
    "func.return"(%3) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>, vector<16xi8>, vector<16xi8>) -> vector<4xi32>, sym_name = "avx_dot_i8_128"}> ({
  ^bb0(%arg3: vector<4xi32>, %arg4: vector<16xi8>, %arg5: vector<16xi8>):
    %1 = "llvm.call_intrinsic"(%arg3, %arg4, %arg5) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx2.vpdpbssd.128", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (vector<4xi32>, vector<16xi8>, vector<16xi8>) -> vector<4xi32>
    "func.return"(%1) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xi32>, vector<32xi8>, vector<32xi8>) -> vector<8xi32>, sym_name = "avx_dot_i8_256"}> ({
  ^bb0(%arg0: vector<8xi32>, %arg1: vector<32xi8>, %arg2: vector<32xi8>):
    %0 = "llvm.call_intrinsic"(%arg0, %arg1, %arg2) <{fastmathFlags = #llvm.fastmath<none>, intrin = "llvm.x86.avx2.vpdpbssd.256", op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (vector<8xi32>, vector<32xi8>, vector<32xi8>) -> vector<8xi32>
    "func.return"(%0) : (vector<8xi32>) -> ()
  }) : () -> ()
}) : () -> ()

