module @test_module {
  llvm.func spir_funccc @_Z20__spirv_ocl_copysignf(f32, f32) -> f32
  llvm.func spir_funccc @_Z17__spirv_ocl_atan2f(f32, f32) -> f32
  llvm.func spir_funccc @_Z15__spirv_ocl_powf(f32, f32) -> f32
  func.func @math_bin_f32(%arg0: f32, %arg1: f32) -> (f32, f32, f32) {
    %0 = llvm.call spir_funccc @_Z20__spirv_ocl_copysignf(%arg0, %arg1) : (f32, f32) -> f32
    %1 = llvm.call spir_funccc @_Z17__spirv_ocl_atan2f(%arg0, %arg1) : (f32, f32) -> f32
    %2 = llvm.call spir_funccc @_Z15__spirv_ocl_powf(%arg0, %arg1) : (f32, f32) -> f32
    return %0, %1, %2 : f32, f32, f32
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z20__spirv_ocl_copysignd(f64, f64) -> f64
  llvm.func spir_funccc @_Z17__spirv_ocl_atan2d(f64, f64) -> f64
  llvm.func spir_funccc @_Z15__spirv_ocl_powd(f64, f64) -> f64
  func.func @math_bin_f64(%arg0: f64, %arg1: f64) -> (f64, f64, f64) {
    %0 = llvm.call spir_funccc @_Z20__spirv_ocl_copysignd(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.call spir_funccc @_Z17__spirv_ocl_atan2d(%arg0, %arg1) : (f64, f64) -> f64
    %2 = llvm.call spir_funccc @_Z15__spirv_ocl_powd(%arg0, %arg1) : (f64, f64) -> f64
    return %0, %1, %2 : f64, f64, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z17__spirv_ocl_expm1f(f32) -> f32
  func.func @expm1_vector(%arg0: memref<32xvector<4xf32>>, %arg1: memref<32xvector<4xf32>>, %arg2: index) {
    %0 = memref.load %arg0[%arg2] : memref<32xvector<4xf32>>
    %1 = llvm.mlir.poison : vector<4xf32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.extractelement %0[%2 : i64] : vector<4xf32>
    %4 = llvm.call spir_funccc @_Z17__spirv_ocl_expm1f(%3) : (f32) -> f32
    %5 = llvm.insertelement %4, %1[%2 : i64] : vector<4xf32>
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.extractelement %0[%6 : i64] : vector<4xf32>
    %8 = llvm.call spir_funccc @_Z17__spirv_ocl_expm1f(%7) : (f32) -> f32
    %9 = llvm.insertelement %8, %5[%6 : i64] : vector<4xf32>
    %10 = llvm.mlir.constant(2 : i64) : i64
    %11 = llvm.extractelement %0[%10 : i64] : vector<4xf32>
    %12 = llvm.call spir_funccc @_Z17__spirv_ocl_expm1f(%11) : (f32) -> f32
    %13 = llvm.insertelement %12, %9[%10 : i64] : vector<4xf32>
    %14 = llvm.mlir.constant(3 : i64) : i64
    %15 = llvm.extractelement %0[%14 : i64] : vector<4xf32>
    %16 = llvm.call spir_funccc @_Z17__spirv_ocl_expm1f(%15) : (f32) -> f32
    %17 = llvm.insertelement %16, %13[%14 : i64] : vector<4xf32>
    memref.store %17, %arg1[%arg2] : memref<32xvector<4xf32>>
    return
  }
}

// -----
module @test_module {
  llvm.func @_Z22__spirv_ocl_native_sind(f64) -> f64
  llvm.func @_Z22__spirv_ocl_native_sinf(f32) -> f32
  func.func @math_fast_sin(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call @_Z22__spirv_ocl_native_sinf(%arg0) {fastmathFlags = #llvm.fastmath<afn>} : (f32) -> f32
    %1 = llvm.call @_Z22__spirv_ocl_native_sind(%arg1) {fastmathFlags = #llvm.fastmath<afn>} : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z16__spirv_ocl_acosf(f32) -> f32
  llvm.func spir_funccc @_Z16__spirv_ocl_acosd(f64) -> f64
  func.func @math_acos(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z16__spirv_ocl_acosf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z16__spirv_ocl_acosd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z17__spirv_ocl_acoshf(f32) -> f32
  llvm.func spir_funccc @_Z17__spirv_ocl_acoshd(f64) -> f64
  func.func @math_acosh(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z17__spirv_ocl_acoshf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z17__spirv_ocl_acoshd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z16__spirv_ocl_asinf(f32) -> f32
  llvm.func spir_funccc @_Z16__spirv_ocl_asind(f64) -> f64
  func.func @math_asin(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z16__spirv_ocl_asinf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z16__spirv_ocl_asind(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z17__spirv_ocl_asinhf(f32) -> f32
  llvm.func spir_funccc @_Z17__spirv_ocl_asinhd(f64) -> f64
  func.func @math_asinh(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z17__spirv_ocl_asinhf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z17__spirv_ocl_asinhd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z16__spirv_ocl_atanf(f32) -> f32
  llvm.func spir_funccc @_Z16__spirv_ocl_atand(f64) -> f64
  func.func @math_atan(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z16__spirv_ocl_atanf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z16__spirv_ocl_atand(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z17__spirv_ocl_atanhf(f32) -> f32
  llvm.func spir_funccc @_Z17__spirv_ocl_atanhd(f64) -> f64
  func.func @math_atanh(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z17__spirv_ocl_atanhf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z17__spirv_ocl_atanhd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z16__spirv_ocl_cbrtf(f32) -> f32
  llvm.func spir_funccc @_Z16__spirv_ocl_cbrtd(f64) -> f64
  func.func @math_cbrt(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z16__spirv_ocl_cbrtf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z16__spirv_ocl_cbrtd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z15__spirv_ocl_cosf(f32) -> f32
  llvm.func spir_funccc @_Z15__spirv_ocl_cosd(f64) -> f64
  func.func @math_cos(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z15__spirv_ocl_cosf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z15__spirv_ocl_cosd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z16__spirv_ocl_coshf(f32) -> f32
  llvm.func spir_funccc @_Z16__spirv_ocl_coshd(f64) -> f64
  func.func @math_cosh(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z16__spirv_ocl_coshf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z16__spirv_ocl_coshd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z15__spirv_ocl_erff(f32) -> f32
  llvm.func spir_funccc @_Z15__spirv_ocl_erfd(f64) -> f64
  func.func @math_erf(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z15__spirv_ocl_erff(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z15__spirv_ocl_erfd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z16__spirv_ocl_erfcf(f32) -> f32
  llvm.func spir_funccc @_Z16__spirv_ocl_erfcd(f64) -> f64
  func.func @math_erfc(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z16__spirv_ocl_erfcf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z16__spirv_ocl_erfcd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z15__spirv_ocl_expf(f32) -> f32
  llvm.func spir_funccc @_Z15__spirv_ocl_expd(f64) -> f64
  func.func @math_exp(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z15__spirv_ocl_expf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z15__spirv_ocl_expd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z16__spirv_ocl_exp2f(f32) -> f32
  llvm.func spir_funccc @_Z16__spirv_ocl_exp2d(f64) -> f64
  func.func @math_exp2(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z16__spirv_ocl_exp2f(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z16__spirv_ocl_exp2d(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z17__spirv_ocl_expm1f(f32) -> f32
  llvm.func spir_funccc @_Z17__spirv_ocl_expm1d(f64) -> f64
  func.func @math_expm1(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z17__spirv_ocl_expm1f(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z17__spirv_ocl_expm1d(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z15__spirv_ocl_logf(f32) -> f32
  llvm.func spir_funccc @_Z15__spirv_ocl_logd(f64) -> f64
  func.func @math_log(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z15__spirv_ocl_logf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z15__spirv_ocl_logd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z17__spirv_ocl_log10f(f32) -> f32
  llvm.func spir_funccc @_Z17__spirv_ocl_log10d(f64) -> f64
  func.func @math_log10(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z17__spirv_ocl_log10f(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z17__spirv_ocl_log10d(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z17__spirv_ocl_log1pf(f32) -> f32
  llvm.func spir_funccc @_Z17__spirv_ocl_log1pd(f64) -> f64
  func.func @math_log1p(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z17__spirv_ocl_log1pf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z17__spirv_ocl_log1pd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z16__spirv_ocl_log2f(f32) -> f32
  llvm.func spir_funccc @_Z16__spirv_ocl_log2d(f64) -> f64
  func.func @math_log2(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z16__spirv_ocl_log2f(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z16__spirv_ocl_log2d(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z17__spirv_ocl_rsqrtf(f32) -> f32
  llvm.func spir_funccc @_Z17__spirv_ocl_rsqrtd(f64) -> f64
  func.func @math_rsqrt(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z17__spirv_ocl_rsqrtf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z17__spirv_ocl_rsqrtd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z15__spirv_ocl_sinf(f32) -> f32
  llvm.func spir_funccc @_Z15__spirv_ocl_sind(f64) -> f64
  func.func @math_sin(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z15__spirv_ocl_sinf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z15__spirv_ocl_sind(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z16__spirv_ocl_sinhf(f32) -> f32
  llvm.func spir_funccc @_Z16__spirv_ocl_sinhd(f64) -> f64
  func.func @math_sinh(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z16__spirv_ocl_sinhf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z16__spirv_ocl_sinhd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z16__spirv_ocl_sqrtf(f32) -> f32
  llvm.func spir_funccc @_Z16__spirv_ocl_sqrtd(f64) -> f64
  func.func @math_sqrt(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z16__spirv_ocl_sqrtf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z16__spirv_ocl_sqrtd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z15__spirv_ocl_tanf(f32) -> f32
  llvm.func spir_funccc @_Z15__spirv_ocl_tand(f64) -> f64
  func.func @math_tan(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z15__spirv_ocl_tanf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z15__spirv_ocl_tand(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z16__spirv_ocl_tanhf(f32) -> f32
  llvm.func spir_funccc @_Z16__spirv_ocl_tanhd(f64) -> f64
  func.func @math_tanh(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = llvm.call spir_funccc @_Z16__spirv_ocl_tanhf(%arg0) : (f32) -> f32
    %1 = llvm.call spir_funccc @_Z16__spirv_ocl_tanhd(%arg1) : (f64) -> f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  llvm.func spir_funccc @_Z16__spirv_ocl_cbrtf(f32) -> f32
  llvm.func spir_funccc @_Z16__spirv_ocl_erfcf(f32) -> f32
  func.func @math_unary_16bit(%arg0: f16, %arg1: bf16) -> (f16, bf16) {
    %0 = llvm.fpext %arg0 : f16 to f32
    %1 = llvm.call spir_funccc @_Z16__spirv_ocl_cbrtf(%0) : (f32) -> f32
    %2 = llvm.fptrunc %1 : f32 to f16
    %3 = llvm.fpext %arg1 : bf16 to f32
    %4 = llvm.call spir_funccc @_Z16__spirv_ocl_erfcf(%3) : (f32) -> f32
    %5 = llvm.fptrunc %4 : f32 to bf16
    return %2, %5 : f16, bf16
  }
}

// -----
module @test_module {
  llvm.func @_Z25__spirv_ocl_native_divideff(f32, f32) -> f32
  llvm.func spir_funccc @_Z16__spirv_ocl_sqrtf(f32) -> f32
  func.func @math_sqrt_div(%arg0: f32) -> f32 {
    %0 = llvm.call spir_funccc @_Z16__spirv_ocl_sqrtf(%arg0) : (f32) -> f32
    %1 = llvm.call @_Z25__spirv_ocl_native_divideff(%arg0, %0) {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32
    return %1 : f32
  }
}

