module @test_module {
  func.func @math_bin_f32(%arg0: f32, %arg1: f32) -> (f32, f32, f32) {
    %0 = math.copysign %arg0, %arg1 : f32
    %1 = math.atan2 %arg0, %arg1 : f32
    %2 = math.powf %arg0, %arg1 : f32
    return %0, %1, %2 : f32, f32, f32
  }
}

// -----
module @test_module {
  func.func @math_bin_f64(%arg0: f64, %arg1: f64) -> (f64, f64, f64) {
    %0 = math.copysign %arg0, %arg1 : f64
    %1 = math.atan2 %arg0, %arg1 : f64
    %2 = math.powf %arg0, %arg1 : f64
    return %0, %1, %2 : f64, f64, f64
  }
}

// -----
module @test_module {
  func.func @expm1_vector(%arg0: memref<32xvector<4xf32>>, %arg1: memref<32xvector<4xf32>>, %arg2: index) {
    %0 = memref.load %arg0[%arg2] : memref<32xvector<4xf32>>
    %1 = math.expm1 %0 : vector<4xf32>
    memref.store %1, %arg1[%arg2] : memref<32xvector<4xf32>>
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
  func.func @math_acos(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.acos %arg0 : f32
    %1 = math.acos %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_acosh(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.acosh %arg0 : f32
    %1 = math.acosh %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_asin(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.asin %arg0 : f32
    %1 = math.asin %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_asinh(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.asinh %arg0 : f32
    %1 = math.asinh %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_atan(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.atan %arg0 : f32
    %1 = math.atan %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_atanh(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.atanh %arg0 : f32
    %1 = math.atanh %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_cbrt(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.cbrt %arg0 : f32
    %1 = math.cbrt %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_cos(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.cos %arg0 : f32
    %1 = math.cos %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_cosh(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.cosh %arg0 : f32
    %1 = math.cosh %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_erf(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.erf %arg0 : f32
    %1 = math.erf %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_erfc(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.erfc %arg0 : f32
    %1 = math.erfc %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_exp(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.exp %arg0 : f32
    %1 = math.exp %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_exp2(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.exp2 %arg0 : f32
    %1 = math.exp2 %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_expm1(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.expm1 %arg0 : f32
    %1 = math.expm1 %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_log(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.log %arg0 : f32
    %1 = math.log %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_log10(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.log10 %arg0 : f32
    %1 = math.log10 %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_log1p(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.log1p %arg0 : f32
    %1 = math.log1p %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_log2(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.log2 %arg0 : f32
    %1 = math.log2 %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_rsqrt(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.rsqrt %arg0 : f32
    %1 = math.rsqrt %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_sin(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.sin %arg0 : f32
    %1 = math.sin %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_sinh(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.sinh %arg0 : f32
    %1 = math.sinh %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_sqrt(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.sqrt %arg0 : f32
    %1 = math.sqrt %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_tan(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.tan %arg0 : f32
    %1 = math.tan %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_tanh(%arg0: f32, %arg1: f64) -> (f32, f64) {
    %0 = math.tanh %arg0 : f32
    %1 = math.tanh %arg1 : f64
    return %0, %1 : f32, f64
  }
}

// -----
module @test_module {
  func.func @math_unary_16bit(%arg0: f16, %arg1: bf16) -> (f16, bf16) {
    %0 = math.cbrt %arg0 : f16
    %1 = math.erfc %arg1 : bf16
    return %0, %1 : f16, bf16
  }
}

// -----
module @test_module {
  llvm.func @_Z25__spirv_ocl_native_divideff(f32, f32) -> f32
  func.func @math_sqrt_div(%arg0: f32) -> f32 {
    %0 = math.sqrt %arg0 : f32
    %1 = llvm.call @_Z25__spirv_ocl_native_divideff(%arg0, %0) {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32
    return %1 : f32
  }
}

