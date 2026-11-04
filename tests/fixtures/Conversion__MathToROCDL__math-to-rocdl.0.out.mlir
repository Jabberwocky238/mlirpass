module @test_module {
  llvm.func @__ocml_fmod_f16(f16, f16) -> f16
  llvm.func @__ocml_fmod_f32(f32, f32) -> f32
  llvm.func @__ocml_fmod_f64(f64, f64) -> f64
  func.func @arith_remf(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_fmod_f16(%arg0, %arg0) : (f16, f16) -> f16
    %1 = llvm.call @__ocml_fmod_f32(%arg1, %arg1) : (f32, f32) -> f32
    %2 = llvm.call @__ocml_fmod_f64(%arg2, %arg2) : (f64, f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_acos_f16(f16) -> f16
  llvm.func @__ocml_acos_f32(f32) -> f32
  llvm.func @__ocml_acos_f64(f64) -> f64
  func.func @math_acos(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_acos_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_acos_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_acos_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_acosh_f16(f16) -> f16
  llvm.func @__ocml_acosh_f32(f32) -> f32
  llvm.func @__ocml_acosh_f64(f64) -> f64
  func.func @math_acosh(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_acosh_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_acosh_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_acosh_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_asin_f16(f16) -> f16
  llvm.func @__ocml_asin_f32(f32) -> f32
  llvm.func @__ocml_asin_f64(f64) -> f64
  func.func @math_asin(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_asin_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_asin_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_asin_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_asinh_f16(f16) -> f16
  llvm.func @__ocml_asinh_f32(f32) -> f32
  llvm.func @__ocml_asinh_f64(f64) -> f64
  func.func @math_asinh(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_asinh_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_asinh_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_asinh_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_atan_f16(f16) -> f16
  llvm.func @__ocml_atan_f32(f32) -> f32
  llvm.func @__ocml_atan_f64(f64) -> f64
  func.func @math_atan(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_atan_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_atan_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_atan_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_atanh_f16(f16) -> f16
  llvm.func @__ocml_atanh_f32(f32) -> f32
  llvm.func @__ocml_atanh_f64(f64) -> f64
  func.func @math_atanh(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_atanh_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_atanh_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_atanh_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_atan2_f16(f16, f16) -> f16
  llvm.func @__ocml_atan2_f32(f32, f32) -> f32
  llvm.func @__ocml_atan2_f64(f64, f64) -> f64
  func.func @math_atan2(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_atan2_f16(%arg0, %arg0) : (f16, f16) -> f16
    %1 = llvm.call @__ocml_atan2_f32(%arg1, %arg1) : (f32, f32) -> f32
    %2 = llvm.call @__ocml_atan2_f64(%arg2, %arg2) : (f64, f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_cbrt_f16(f16) -> f16
  llvm.func @__ocml_cbrt_f32(f32) -> f32
  llvm.func @__ocml_cbrt_f64(f64) -> f64
  func.func @math_cbrt(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_cbrt_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_cbrt_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_cbrt_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_ceil_f16(f16) -> f16
  llvm.func @__ocml_ceil_f32(f32) -> f32
  llvm.func @__ocml_ceil_f64(f64) -> f64
  func.func @math_ceil(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_ceil_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_ceil_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_ceil_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_cos_f16(f16) -> f16
  llvm.func @__ocml_cos_f32(f32) -> f32
  llvm.func @__ocml_cos_f64(f64) -> f64
  func.func @math_cos(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_cos_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_cos_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_cos_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_cosh_f16(f16) -> f16
  llvm.func @__ocml_cosh_f32(f32) -> f32
  llvm.func @__ocml_cosh_f64(f64) -> f64
  func.func @math_cosh(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_cosh_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_cosh_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_cosh_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_sinh_f16(f16) -> f16
  llvm.func @__ocml_sinh_f32(f32) -> f32
  llvm.func @__ocml_sinh_f64(f64) -> f64
  func.func @math_sinh(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_sinh_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_sinh_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_sinh_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_exp_f16(f16) -> f16
  llvm.func @__ocml_exp_f64(f64) -> f64
  func.func @math_exp(%arg0: f16, %arg1: f64) -> (f16, f64) {
    %0 = llvm.call @__ocml_exp_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_exp_f64(%arg1) : (f64) -> f64
    return %0, %1 : f16, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_exp2_f16(f16) -> f16
  llvm.func @__ocml_exp2_f32(f32) -> f32
  llvm.func @__ocml_exp2_f64(f64) -> f64
  func.func @math_exp2(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_exp2_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_exp2_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_exp2_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_expm1_f16(f16) -> f16
  llvm.func @__ocml_expm1_f32(f32) -> f32
  llvm.func @__ocml_expm1_f64(f64) -> f64
  func.func @math_expm1(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_expm1_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_expm1_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_expm1_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_floor_f16(f16) -> f16
  llvm.func @__ocml_floor_f32(f32) -> f32
  llvm.func @__ocml_floor_f64(f64) -> f64
  func.func @math_floor(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_floor_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_floor_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_floor_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_log_f16(f16) -> f16
  llvm.func @__ocml_log_f64(f64) -> f64
  func.func @math_log(%arg0: f16, %arg1: f64) -> (f16, f64) {
    %0 = llvm.call @__ocml_log_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_log_f64(%arg1) : (f64) -> f64
    return %0, %1 : f16, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_log10_f16(f16) -> f16
  llvm.func @__ocml_log10_f32(f32) -> f32
  llvm.func @__ocml_log10_f64(f64) -> f64
  func.func @math_log10(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_log10_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_log10_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_log10_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_log1p_f16(f16) -> f16
  llvm.func @__ocml_log1p_f32(f32) -> f32
  llvm.func @__ocml_log1p_f64(f64) -> f64
  func.func @math_log1p(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_log1p_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_log1p_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_log1p_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_pow_f16(f16, f16) -> f16
  llvm.func @__ocml_pow_f32(f32, f32) -> f32
  llvm.func @__ocml_pow_f64(f64, f64) -> f64
  func.func @math_powf(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_pow_f16(%arg0, %arg0) : (f16, f16) -> f16
    %1 = llvm.call @__ocml_pow_f32(%arg1, %arg1) : (f32, f32) -> f32
    %2 = llvm.call @__ocml_pow_f64(%arg2, %arg2) : (f64, f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_rsqrt_f16(f16) -> f16
  llvm.func @__ocml_rsqrt_f32(f32) -> f32
  llvm.func @__ocml_rsqrt_f64(f64) -> f64
  func.func @math_rsqrt(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_rsqrt_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_rsqrt_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_rsqrt_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_sin_f16(f16) -> f16
  llvm.func @__ocml_sin_f32(f32) -> f32
  llvm.func @__ocml_sin_f64(f64) -> f64
  func.func @math_sin(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_sin_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_sin_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_sin_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_tanh_f16(f16) -> f16
  llvm.func @__ocml_tanh_f32(f32) -> f32
  llvm.func @__ocml_tanh_f64(f64) -> f64
  func.func @math_tanh(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_tanh_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_tanh_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_tanh_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_tan_f16(f16) -> f16
  llvm.func @__ocml_tan_f32(f32) -> f32
  llvm.func @__ocml_tan_f64(f64) -> f64
  func.func @math_tan(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_tan_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_tan_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_tan_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_erf_f16(f16) -> f16
  llvm.func @__ocml_erf_f32(f32) -> f32
  llvm.func @__ocml_erf_f64(f64) -> f64
  func.func @math_erf(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_erf_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_erf_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_erf_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_erfc_f16(f16) -> f16
  llvm.func @__ocml_erfc_f32(f32) -> f32
  llvm.func @__ocml_erfc_f64(f64) -> f64
  func.func @math_erfc(%arg0: f16, %arg1: f32, %arg2: f64) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_erfc_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_erfc_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_erfc_f64(%arg2) : (f64) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module @test_module {
  llvm.func @__ocml_sin_f16(f16) -> f16
  llvm.func @__ocml_sin_f32(f32) -> f32
  llvm.func @__ocml_sin_f64(f64) -> f64
  func.func @math_casting(%arg0: f16, %arg1: f32, %arg2: f64, %arg3: bf16) -> (f16, f32, f64, bf16) {
    %0 = llvm.call @__ocml_sin_f16(%arg0) : (f16) -> f16
    %1 = llvm.call @__ocml_sin_f32(%arg1) : (f32) -> f32
    %2 = llvm.call @__ocml_sin_f64(%arg2) : (f64) -> f64
    %3 = llvm.fpext %arg3 : bf16 to f32
    %4 = llvm.call @__ocml_sin_f32(%3) : (f32) -> f32
    %5 = llvm.fptrunc %4 : f32 to bf16
    return %0, %1, %2, %5 : f16, f32, f64, bf16
  }
}

// -----
module @test_module {
  llvm.func @__ocml_pown_f16(f16, i32) -> f16
  llvm.func @__ocml_pown_f32(f32, i32) -> f32
  llvm.func @__ocml_pown_f64(f64, i32) -> f64
  func.func @math_fpowi(%arg0: f16, %arg1: f32, %arg2: f64, %arg3: i32) -> (f16, f32, f64) {
    %0 = llvm.call @__ocml_pown_f16(%arg0, %arg3) : (f16, i32) -> f16
    %1 = llvm.call @__ocml_pown_f32(%arg1, %arg3) : (f32, i32) -> f32
    %2 = llvm.call @__ocml_pown_f64(%arg2, %arg3) : (f64, i32) -> f64
    return %0, %1, %2 : f16, f32, f64
  }
}

// -----
module {
  "test.some_op_with_region"() ({
  ^bb0(%arg0: f64):
    %0 = math.atan %arg0 : f64
    "test.possible_terminator"() : () -> ()
  }) : () -> ()
}

// -----
module @test_module {
  llvm.func @__ocml_sin_f16(f16) -> f16
  func.func @math_sin_vector_0d(%arg0: vector<f16>) -> vector<f16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<f16> to vector<1xf16>
    %1 = llvm.mlir.poison : vector<1xf16>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.extractelement %0[%2 : i64] : vector<1xf16>
    %4 = llvm.call @__ocml_sin_f16(%3) : (f16) -> f16
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<1xf16>
    %6 = builtin.unrealized_conversion_cast %5 : vector<1xf16> to vector<f16>
    return %6 : vector<f16>
  }
}

// -----
module @test_module {
  llvm.func @__ocml_sin_f16(f16) -> f16
  func.func @math_sin_vector_1d(%arg0: vector<4xf16>) -> vector<4xf16> {
    %0 = llvm.mlir.poison : vector<4xf16>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.extractelement %arg0[%1 : i64] : vector<4xf16>
    %3 = llvm.call @__ocml_sin_f16(%2) : (f16) -> f16
    %4 = llvm.insertelement %3, %0[%1 : i64] : vector<4xf16>
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.extractelement %arg0[%5 : i64] : vector<4xf16>
    %7 = llvm.call @__ocml_sin_f16(%6) : (f16) -> f16
    %8 = llvm.insertelement %7, %4[%5 : i64] : vector<4xf16>
    %9 = llvm.mlir.constant(2 : i64) : i64
    %10 = llvm.extractelement %arg0[%9 : i64] : vector<4xf16>
    %11 = llvm.call @__ocml_sin_f16(%10) : (f16) -> f16
    %12 = llvm.insertelement %11, %8[%9 : i64] : vector<4xf16>
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.extractelement %arg0[%13 : i64] : vector<4xf16>
    %15 = llvm.call @__ocml_sin_f16(%14) : (f16) -> f16
    %16 = llvm.insertelement %15, %12[%13 : i64] : vector<4xf16>
    return %16 : vector<4xf16>
  }
}

// -----
module @test_module {
  llvm.func @__ocml_sin_f16(f16) -> f16
  func.func @math_sin_vector_2d(%arg0: vector<2x2xf16>) -> vector<2x2xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x2xf16> to !llvm.array<2 x vector<2xf16>>
    %1 = llvm.mlir.poison : !llvm.array<2 x vector<2xf16>>
    %2 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<2xf16>> 
    %3 = llvm.mlir.poison : vector<2xf16>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %2[%4 : i64] : vector<2xf16>
    %6 = llvm.call @__ocml_sin_f16(%5) : (f16) -> f16
    %7 = llvm.insertelement %6, %3[%4 : i64] : vector<2xf16>
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.extractelement %2[%8 : i64] : vector<2xf16>
    %10 = llvm.call @__ocml_sin_f16(%9) : (f16) -> f16
    %11 = llvm.insertelement %10, %7[%8 : i64] : vector<2xf16>
    %12 = llvm.insertvalue %11, %1[0] : !llvm.array<2 x vector<2xf16>> 
    %13 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<2xf16>> 
    %14 = llvm.mlir.poison : vector<2xf16>
    %15 = llvm.mlir.constant(0 : i64) : i64
    %16 = llvm.extractelement %13[%15 : i64] : vector<2xf16>
    %17 = llvm.call @__ocml_sin_f16(%16) : (f16) -> f16
    %18 = llvm.insertelement %17, %14[%15 : i64] : vector<2xf16>
    %19 = llvm.mlir.constant(1 : i64) : i64
    %20 = llvm.extractelement %13[%19 : i64] : vector<2xf16>
    %21 = llvm.call @__ocml_sin_f16(%20) : (f16) -> f16
    %22 = llvm.insertelement %21, %18[%19 : i64] : vector<2xf16>
    %23 = llvm.insertvalue %22, %12[1] : !llvm.array<2 x vector<2xf16>> 
    %24 = builtin.unrealized_conversion_cast %23 : !llvm.array<2 x vector<2xf16>> to vector<2x2xf16>
    return %24 : vector<2x2xf16>
  }
}

// -----
module {
  func.func @clampf_f16(%arg0: f16, %arg1: f16, %arg2: f16) -> f16 {
    %0 = math.clampf %arg0 to [%arg1, %arg2] : f16
    return %0 : f16
  }
  func.func @clampf_f32(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = math.clampf %arg0 to [%arg1, %arg2] : f32
    return %0 : f32
  }
}

// -----
module {
  func.func @clampf_vector_f16(%arg0: vector<2xf16>, %arg1: vector<2xf16>, %arg2: vector<2xf16>) -> vector<2xf16> {
    %0 = math.clampf %arg0 to [%arg1, %arg2] : vector<2xf16>
    return %0 : vector<2xf16>
  }
}

// -----
module {
  func.func @clampf_vector_f32(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = math.clampf %arg0 to [%arg1, %arg2] : vector<2xf32>
    return %0 : vector<2xf32>
  }
}

// -----
module {
  func.func @clampf_vector_2d_f16(%arg0: vector<2x2xf16>, %arg1: vector<2x2xf16>, %arg2: vector<2x2xf16>) -> vector<2x2xf16> {
    %0 = math.clampf %arg0 to [%arg1, %arg2] : vector<2x2xf16>
    return %0 : vector<2x2xf16>
  }
}

// -----
module {
  func.func @clampf_bf16(%arg0: bf16, %arg1: bf16, %arg2: bf16) -> bf16 {
    %0 = math.clampf %arg0 to [%arg1, %arg2] : bf16
    return %0 : bf16
  }
}

