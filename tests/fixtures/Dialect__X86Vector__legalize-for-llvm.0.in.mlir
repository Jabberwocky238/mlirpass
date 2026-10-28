"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xf32>, vector<8xf64>, i16, i8, i16, i8) -> (vector<16xf32>, vector<8xf64>, vector<16xf32>, vector<8xf64>), sym_name = "avx512_mask_rndscale"}> ({
  ^bb0(%arg38: vector<16xf32>, %arg39: vector<16xf32>, %arg40: vector<8xf64>, %arg41: i16, %arg42: i8, %arg43: i16, %arg44: i8):
    %26 = "arith.constant"() <{value = 15 : i32}> : () -> i32
    %27 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %28 = "x86vector.avx512.mask.rndscale"(%arg38, %26, %arg39, %arg41, %27) : (vector<16xf32>, i32, vector<16xf32>, i16, i32) -> vector<16xf32>
    %29 = "x86vector.avx512.mask.rndscale"(%arg40, %26, %arg40, %arg42, %27) : (vector<8xf64>, i32, vector<8xf64>, i8, i32) -> vector<8xf64>
    %30 = "x86vector.avx512.mask.scalef"(%arg39, %arg39, %arg39, %arg43, %27) : (vector<16xf32>, vector<16xf32>, vector<16xf32>, i16, i32) -> vector<16xf32>
    %31 = "x86vector.avx512.mask.scalef"(%arg40, %arg40, %arg40, %arg44, %27) : (vector<8xf64>, vector<8xf64>, vector<8xf64>, i8, i32) -> vector<8xf64>
    "func.return"(%28, %29, %30, %31) : (vector<16xf32>, vector<8xf64>, vector<16xf32>, vector<8xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xi1>, vector<16xf32>, vector<8xi1>, vector<8xi64>) -> (vector<16xf32>, vector<16xf32>, vector<8xi64>), sym_name = "avx512_mask_compress"}> ({
  ^bb0(%arg34: vector<16xi1>, %arg35: vector<16xf32>, %arg36: vector<8xi1>, %arg37: vector<8xi64>):
    %23 = "x86vector.avx512.mask.compress"(%arg34, %arg35) : (vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    %24 = "x86vector.avx512.mask.compress"(%arg34, %arg35) <{constant_src = dense<5.000000e+00> : vector<16xf32>}> : (vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    %25 = "x86vector.avx512.mask.compress"(%arg36, %arg37, %arg37) : (vector<8xi1>, vector<8xi64>, vector<8xi64>) -> vector<8xi64>
    "func.return"(%23, %24, %25) : (vector<16xf32>, vector<16xf32>, vector<8xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xi32>, vector<8xi64>) -> (vector<16xi1>, vector<16xi1>, vector<8xi1>, vector<8xi1>), sym_name = "avx512_vp2intersect"}> ({
  ^bb0(%arg32: vector<16xi32>, %arg33: vector<8xi64>):
    %21:2 = "x86vector.avx512.vp2intersect"(%arg32, %arg32) : (vector<16xi32>, vector<16xi32>) -> (vector<16xi1>, vector<16xi1>)
    %22:2 = "x86vector.avx512.vp2intersect"(%arg33, %arg33) : (vector<8xi64>, vector<8xi64>) -> (vector<8xi1>, vector<8xi1>)
    "func.return"(%21#0, %21#1, %22#0, %22#1) : (vector<16xi1>, vector<16xi1>, vector<8xi1>, vector<8xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<8xbf16>, vector<8xbf16>) -> vector<4xf32>, sym_name = "avx512bf16_dot_128"}> ({
  ^bb0(%arg29: vector<4xf32>, %arg30: vector<8xbf16>, %arg31: vector<8xbf16>):
    %20 = "x86vector.avx512.dot"(%arg29, %arg30, %arg31) : (vector<4xf32>, vector<8xbf16>, vector<8xbf16>) -> vector<4xf32>
    "func.return"(%20) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>, vector<16xbf16>, vector<16xbf16>) -> vector<8xf32>, sym_name = "avx512bf16_dot_256"}> ({
  ^bb0(%arg26: vector<8xf32>, %arg27: vector<16xbf16>, %arg28: vector<16xbf16>):
    %19 = "x86vector.avx512.dot"(%arg26, %arg27, %arg28) : (vector<8xf32>, vector<16xbf16>, vector<16xbf16>) -> vector<8xf32>
    "func.return"(%19) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>, sym_name = "avx512bf16_dot_512"}> ({
  ^bb0(%arg23: vector<16xf32>, %arg24: vector<32xbf16>, %arg25: vector<32xbf16>):
    %18 = "x86vector.avx512.dot"(%arg23, %arg24, %arg25) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    "func.return"(%18) : (vector<16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> vector<8xbf16>, sym_name = "avx512bf16_cvt_packed_f32_to_bf16_256"}> ({
  ^bb0(%arg22: vector<8xf32>):
    %17 = "x86vector.avx512.cvt.packed.f32_to_bf16"(%arg22) : (vector<8xf32>) -> vector<8xbf16>
    "func.return"(%17) : (vector<8xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xf32>) -> vector<16xbf16>, sym_name = "avx512bf16_cvt_packed_f32_to_bf16_512"}> ({
  ^bb0(%arg21: vector<16xf32>):
    %16 = "x86vector.avx512.cvt.packed.f32_to_bf16"(%arg21) : (vector<16xf32>) -> vector<16xbf16>
    "func.return"(%16) : (vector<16xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xbf16>) -> vector<4xf32>, sym_name = "avxbf16_cvt_packed_even_indexed_bf16_to_f32_128"}> ({
  ^bb0(%arg20: memref<8xbf16>):
    %15 = "x86vector.avx.cvt.packed.even.indexed_to_f32"(%arg20) : (memref<8xbf16>) -> vector<4xf32>
    "func.return"(%15) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xbf16>) -> vector<8xf32>, sym_name = "avxbf16_cvt_packed_even_indexed_bf16_to_f32_256"}> ({
  ^bb0(%arg19: memref<16xbf16>):
    %14 = "x86vector.avx.cvt.packed.even.indexed_to_f32"(%arg19) : (memref<16xbf16>) -> vector<8xf32>
    "func.return"(%14) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xbf16>) -> vector<4xf32>, sym_name = "avxbf16_cvt_packed_odd_indexed_bf16_to_f32_128"}> ({
  ^bb0(%arg18: memref<8xbf16>):
    %13 = "x86vector.avx.cvt.packed.odd.indexed_to_f32"(%arg18) : (memref<8xbf16>) -> vector<4xf32>
    "func.return"(%13) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xbf16>) -> vector<8xf32>, sym_name = "avxbf16_cvt_packed_odd_indexed_bf16_to_f32_256"}> ({
  ^bb0(%arg17: memref<16xbf16>):
    %12 = "x86vector.avx.cvt.packed.odd.indexed_to_f32"(%arg17) : (memref<16xbf16>) -> vector<8xf32>
    "func.return"(%12) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xbf16>) -> vector<4xf32>, sym_name = "avxbf16_bsct_bf16_to_f32_packed_128"}> ({
  ^bb0(%arg16: memref<1xbf16>):
    %11 = "x86vector.avx.bcst_to_f32.packed"(%arg16) : (memref<1xbf16>) -> vector<4xf32>
    "func.return"(%11) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xbf16>) -> vector<8xf32>, sym_name = "avxbf16_bsct_bf16_to_f32_packed_256"}> ({
  ^bb0(%arg15: memref<1xbf16>):
    %10 = "x86vector.avx.bcst_to_f32.packed"(%arg15) : (memref<1xbf16>) -> vector<8xf32>
    "func.return"(%10) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xf16>) -> vector<4xf32>, sym_name = "avxf16_cvt_packed_even_indexed_f16_to_f32_128"}> ({
  ^bb0(%arg14: memref<8xf16>):
    %9 = "x86vector.avx.cvt.packed.even.indexed_to_f32"(%arg14) : (memref<8xf16>) -> vector<4xf32>
    "func.return"(%9) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xf16>) -> vector<8xf32>, sym_name = "avxf16_cvt_packed_even_indexed_f16_to_f32_256"}> ({
  ^bb0(%arg13: memref<16xf16>):
    %8 = "x86vector.avx.cvt.packed.even.indexed_to_f32"(%arg13) : (memref<16xf16>) -> vector<8xf32>
    "func.return"(%8) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xf16>) -> vector<4xf32>, sym_name = "avxf16_cvt_packed_odd_indexed_f16_to_f32_128"}> ({
  ^bb0(%arg12: memref<8xf16>):
    %7 = "x86vector.avx.cvt.packed.odd.indexed_to_f32"(%arg12) : (memref<8xf16>) -> vector<4xf32>
    "func.return"(%7) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xf16>) -> vector<8xf32>, sym_name = "avxf16_cvt_packed_odd_indexed_f16_to_f32_256"}> ({
  ^bb0(%arg11: memref<16xf16>):
    %6 = "x86vector.avx.cvt.packed.odd.indexed_to_f32"(%arg11) : (memref<16xf16>) -> vector<8xf32>
    "func.return"(%6) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xf16>) -> vector<4xf32>, sym_name = "avxf16_bsct_f16_to_f32_packed_128"}> ({
  ^bb0(%arg10: memref<1xf16>):
    %5 = "x86vector.avx.bcst_to_f32.packed"(%arg10) : (memref<1xf16>) -> vector<4xf32>
    "func.return"(%5) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xf16>) -> vector<8xf32>, sym_name = "avxf16_bsct_f16_to_f32_packed_256"}> ({
  ^bb0(%arg9: memref<1xf16>):
    %4 = "x86vector.avx.bcst_to_f32.packed"(%arg9) : (memref<1xf16>) -> vector<8xf32>
    "func.return"(%4) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> vector<8xf32>, sym_name = "avx_rsqrt"}> ({
  ^bb0(%arg8: vector<8xf32>):
    %3 = "x86vector.avx.rsqrt"(%arg8) : (vector<8xf32>) -> vector<8xf32>
    "func.return"(%3) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>, vector<8xf32>) -> vector<8xf32>, sym_name = "avx_dot"}> ({
  ^bb0(%arg6: vector<8xf32>, %arg7: vector<8xf32>):
    %2 = "x86vector.avx.intr.dot"(%arg6, %arg7) : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%2) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>, vector<16xi8>, vector<16xi8>) -> vector<4xi32>, sym_name = "avx_dot_i8_128"}> ({
  ^bb0(%arg3: vector<4xi32>, %arg4: vector<16xi8>, %arg5: vector<16xi8>):
    %1 = "x86vector.avx.dot.i8"(%arg3, %arg4, %arg5) : (vector<4xi32>, vector<16xi8>, vector<16xi8>) -> vector<4xi32>
    "func.return"(%1) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xi32>, vector<32xi8>, vector<32xi8>) -> vector<8xi32>, sym_name = "avx_dot_i8_256"}> ({
  ^bb0(%arg0: vector<8xi32>, %arg1: vector<32xi8>, %arg2: vector<32xi8>):
    %0 = "x86vector.avx.dot.i8"(%arg0, %arg1, %arg2) : (vector<8xi32>, vector<32xi8>, vector<32xi8>) -> vector<8xi32>
    "func.return"(%0) : (vector<8xi32>) -> ()
  }) : () -> ()
}) : () -> ()

