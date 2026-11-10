"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xf32>, vector<8xf64>, i16, i8, i16, i8) -> (vector<16xf32>, vector<8xf64>, vector<16xf32>, vector<8xf64>), sym_name = "avx512_mask_rndscale"}> ({
  ^bb0(%arg41: vector<16xf32>, %arg42: vector<16xf32>, %arg43: vector<8xf64>, %arg44: i16, %arg45: i8, %arg46: i16, %arg47: i8):
    %27 = "arith.constant"() <{value = 15 : i32}> : () -> i32
    %28 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %29 = "x86.avx512.mask.rndscale"(%arg41, %27, %arg42, %arg44, %28) : (vector<16xf32>, i32, vector<16xf32>, i16, i32) -> vector<16xf32>
    %30 = "x86.avx512.mask.rndscale"(%arg43, %27, %arg43, %arg45, %28) : (vector<8xf64>, i32, vector<8xf64>, i8, i32) -> vector<8xf64>
    %31 = "x86.avx512.mask.scalef"(%arg42, %arg42, %arg42, %arg46, %28) : (vector<16xf32>, vector<16xf32>, vector<16xf32>, i16, i32) -> vector<16xf32>
    %32 = "x86.avx512.mask.scalef"(%arg43, %arg43, %arg43, %arg47, %28) : (vector<8xf64>, vector<8xf64>, vector<8xf64>, i8, i32) -> vector<8xf64>
    "func.return"(%29, %30, %31, %32) : (vector<16xf32>, vector<8xf64>, vector<16xf32>, vector<8xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xi1>, vector<16xf32>, vector<8xi1>, vector<8xi64>) -> (vector<16xf32>, vector<16xf32>, vector<8xi64>), sym_name = "avx512_mask_compress"}> ({
  ^bb0(%arg37: vector<16xi1>, %arg38: vector<16xf32>, %arg39: vector<8xi1>, %arg40: vector<8xi64>):
    %24 = "x86.avx512.mask.compress"(%arg37, %arg38) : (vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    %25 = "x86.avx512.mask.compress"(%arg37, %arg38) <{constant_src = dense<5.000000e+00> : vector<16xf32>}> : (vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    %26 = "x86.avx512.mask.compress"(%arg39, %arg40, %arg40) : (vector<8xi1>, vector<8xi64>, vector<8xi64>) -> vector<8xi64>
    "func.return"(%24, %25, %26) : (vector<16xf32>, vector<16xf32>, vector<8xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xi32>, vector<8xi64>) -> (vector<16xi1>, vector<16xi1>, vector<8xi1>, vector<8xi1>), sym_name = "avx512_vp2intersect"}> ({
  ^bb0(%arg35: vector<16xi32>, %arg36: vector<8xi64>):
    %22:2 = "x86.avx512.vp2intersect"(%arg35, %arg35) : (vector<16xi32>, vector<16xi32>) -> (vector<16xi1>, vector<16xi1>)
    %23:2 = "x86.avx512.vp2intersect"(%arg36, %arg36) : (vector<8xi64>, vector<8xi64>) -> (vector<8xi1>, vector<8xi1>)
    "func.return"(%22#0, %22#1, %23#0, %23#1) : (vector<16xi1>, vector<16xi1>, vector<8xi1>, vector<8xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<8xbf16>, vector<8xbf16>) -> vector<4xf32>, sym_name = "avx512bf16_dot_128"}> ({
  ^bb0(%arg32: vector<4xf32>, %arg33: vector<8xbf16>, %arg34: vector<8xbf16>):
    %21 = "x86.avx512.dot"(%arg32, %arg33, %arg34) : (vector<4xf32>, vector<8xbf16>, vector<8xbf16>) -> vector<4xf32>
    "func.return"(%21) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>, vector<16xbf16>, vector<16xbf16>) -> vector<8xf32>, sym_name = "avx512bf16_dot_256"}> ({
  ^bb0(%arg29: vector<8xf32>, %arg30: vector<16xbf16>, %arg31: vector<16xbf16>):
    %20 = "x86.avx512.dot"(%arg29, %arg30, %arg31) : (vector<8xf32>, vector<16xbf16>, vector<16xbf16>) -> vector<8xf32>
    "func.return"(%20) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>, sym_name = "avx512bf16_dot_512"}> ({
  ^bb0(%arg26: vector<16xf32>, %arg27: vector<32xbf16>, %arg28: vector<32xbf16>):
    %19 = "x86.avx512.dot"(%arg26, %arg27, %arg28) : (vector<16xf32>, vector<32xbf16>, vector<32xbf16>) -> vector<16xf32>
    "func.return"(%19) : (vector<16xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> vector<8xbf16>, sym_name = "avx512bf16_cvt_packed_f32_to_bf16_256"}> ({
  ^bb0(%arg25: vector<8xf32>):
    %18 = "x86.avx512.cvt.packed.f32_to_bf16"(%arg25) : (vector<8xf32>) -> vector<8xbf16>
    "func.return"(%18) : (vector<8xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xf32>) -> vector<16xbf16>, sym_name = "avx512bf16_cvt_packed_f32_to_bf16_512"}> ({
  ^bb0(%arg24: vector<16xf32>):
    %17 = "x86.avx512.cvt.packed.f32_to_bf16"(%arg24) : (vector<16xf32>) -> vector<16xbf16>
    "func.return"(%17) : (vector<16xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<16xi32>, vector<64xi8>, vector<64xi8>) -> vector<16xi32>, sym_name = "avx10_dot_i8_512"}> ({
  ^bb0(%arg21: vector<16xi32>, %arg22: vector<64xi8>, %arg23: vector<64xi8>):
    %16 = "x86.avx10.dot.i8"(%arg21, %arg22, %arg23) : (vector<16xi32>, vector<64xi8>, vector<64xi8>) -> vector<16xi32>
    "func.return"(%16) : (vector<16xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xbf16>) -> vector<4xf32>, sym_name = "avxbf16_cvt_packed_even_indexed_bf16_to_f32_128"}> ({
  ^bb0(%arg20: memref<8xbf16>):
    %15 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg20) : (memref<8xbf16>) -> vector<4xf32>
    "func.return"(%15) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xbf16>) -> vector<8xf32>, sym_name = "avxbf16_cvt_packed_even_indexed_bf16_to_f32_256"}> ({
  ^bb0(%arg19: memref<16xbf16>):
    %14 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg19) : (memref<16xbf16>) -> vector<8xf32>
    "func.return"(%14) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xbf16>) -> vector<4xf32>, sym_name = "avxbf16_cvt_packed_odd_indexed_bf16_to_f32_128"}> ({
  ^bb0(%arg18: memref<8xbf16>):
    %13 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg18) : (memref<8xbf16>) -> vector<4xf32>
    "func.return"(%13) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xbf16>) -> vector<8xf32>, sym_name = "avxbf16_cvt_packed_odd_indexed_bf16_to_f32_256"}> ({
  ^bb0(%arg17: memref<16xbf16>):
    %12 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg17) : (memref<16xbf16>) -> vector<8xf32>
    "func.return"(%12) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xbf16>) -> vector<4xf32>, sym_name = "avxbf16_bsct_bf16_to_f32_packed_128"}> ({
  ^bb0(%arg16: memref<1xbf16>):
    %11 = "x86.avx.bcst_to_f32.packed"(%arg16) : (memref<1xbf16>) -> vector<4xf32>
    "func.return"(%11) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xbf16>) -> vector<8xf32>, sym_name = "avxbf16_bsct_bf16_to_f32_packed_256"}> ({
  ^bb0(%arg15: memref<1xbf16>):
    %10 = "x86.avx.bcst_to_f32.packed"(%arg15) : (memref<1xbf16>) -> vector<8xf32>
    "func.return"(%10) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xf16>) -> vector<4xf32>, sym_name = "avxf16_cvt_packed_even_indexed_f16_to_f32_128"}> ({
  ^bb0(%arg14: memref<8xf16>):
    %9 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg14) : (memref<8xf16>) -> vector<4xf32>
    "func.return"(%9) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xf16>) -> vector<8xf32>, sym_name = "avxf16_cvt_packed_even_indexed_f16_to_f32_256"}> ({
  ^bb0(%arg13: memref<16xf16>):
    %8 = "x86.avx.cvt.packed.even.indexed_to_f32"(%arg13) : (memref<16xf16>) -> vector<8xf32>
    "func.return"(%8) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<8xf16>) -> vector<4xf32>, sym_name = "avxf16_cvt_packed_odd_indexed_f16_to_f32_128"}> ({
  ^bb0(%arg12: memref<8xf16>):
    %7 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg12) : (memref<8xf16>) -> vector<4xf32>
    "func.return"(%7) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16xf16>) -> vector<8xf32>, sym_name = "avxf16_cvt_packed_odd_indexed_f16_to_f32_256"}> ({
  ^bb0(%arg11: memref<16xf16>):
    %6 = "x86.avx.cvt.packed.odd.indexed_to_f32"(%arg11) : (memref<16xf16>) -> vector<8xf32>
    "func.return"(%6) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xf16>) -> vector<4xf32>, sym_name = "avxf16_bsct_f16_to_f32_packed_128"}> ({
  ^bb0(%arg10: memref<1xf16>):
    %5 = "x86.avx.bcst_to_f32.packed"(%arg10) : (memref<1xf16>) -> vector<4xf32>
    "func.return"(%5) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xf16>) -> vector<8xf32>, sym_name = "avxf16_bsct_f16_to_f32_packed_256"}> ({
  ^bb0(%arg9: memref<1xf16>):
    %4 = "x86.avx.bcst_to_f32.packed"(%arg9) : (memref<1xf16>) -> vector<8xf32>
    "func.return"(%4) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>) -> vector<8xf32>, sym_name = "avx_rsqrt"}> ({
  ^bb0(%arg8: vector<8xf32>):
    %3 = "x86.avx.rsqrt"(%arg8) : (vector<8xf32>) -> vector<8xf32>
    "func.return"(%3) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xf32>, vector<8xf32>) -> vector<8xf32>, sym_name = "avx_dot"}> ({
  ^bb0(%arg6: vector<8xf32>, %arg7: vector<8xf32>):
    %2 = "x86.avx.intr.dot"(%arg6, %arg7) : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    "func.return"(%2) : (vector<8xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>, vector<16xi8>, vector<16xi8>) -> vector<4xi32>, sym_name = "avx_dot_i8_128"}> ({
  ^bb0(%arg3: vector<4xi32>, %arg4: vector<16xi8>, %arg5: vector<16xi8>):
    %1 = "x86.avx.dot.i8"(%arg3, %arg4, %arg5) : (vector<4xi32>, vector<16xi8>, vector<16xi8>) -> vector<4xi32>
    "func.return"(%1) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xi32>, vector<32xi8>, vector<32xi8>) -> vector<8xi32>, sym_name = "avx_dot_i8_256"}> ({
  ^bb0(%arg0: vector<8xi32>, %arg1: vector<32xi8>, %arg2: vector<32xi8>):
    %0 = "x86.avx.dot.i8"(%arg0, %arg1, %arg2) : (vector<8xi32>, vector<32xi8>, vector<32xi8>) -> vector<8xi32>
    "func.return"(%0) : (vector<8xi32>) -> ()
  }) : () -> ()
}) : () -> ()

