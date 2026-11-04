module {
  func.func private @__ocml_ctanh_f64(complex<f64>) -> complex<f64>
  func.func private @__ocml_ctanh_f32(complex<f32>) -> complex<f32>
  func.func private @__ocml_ctan_f64(complex<f64>) -> complex<f64>
  func.func private @__ocml_ctan_f32(complex<f32>) -> complex<f32>
  func.func private @__ocml_csqrt_f64(complex<f64>) -> complex<f64>
  func.func private @__ocml_csqrt_f32(complex<f32>) -> complex<f32>
  func.func private @__ocml_csin_f64(complex<f64>) -> complex<f64>
  func.func private @__ocml_csin_f32(complex<f32>) -> complex<f32>
  func.func private @__ocml_clog_f64(complex<f64>) -> complex<f64>
  func.func private @__ocml_clog_f32(complex<f32>) -> complex<f32>
  func.func private @__ocml_cexp_f64(complex<f64>) -> complex<f64>
  func.func private @__ocml_cexp_f32(complex<f32>) -> complex<f32>
  func.func private @__ocml_ccos_f64(complex<f64>) -> complex<f64>
  func.func private @__ocml_ccos_f32(complex<f32>) -> complex<f32>
  func.func private @__ocml_cabs_f64(complex<f64>) -> f64
  func.func private @__ocml_cabs_f32(complex<f32>) -> f32
  func.func @abs_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (f32, f64) {
    %0 = call @__ocml_cabs_f32(%arg0) : (complex<f32>) -> f32
    %1 = call @__ocml_cabs_f64(%arg1) : (complex<f64>) -> f64
    return %0, %1 : f32, f64
  }
  func.func @cos_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @__ocml_ccos_f32(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @__ocml_ccos_f64(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
  func.func @exp_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @__ocml_cexp_f32(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @__ocml_cexp_f64(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
  func.func @log_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @__ocml_clog_f32(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @__ocml_clog_f64(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
  func.func @pow_caller(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = call @__ocml_clog_f32(%arg0) : (complex<f32>) -> complex<f32>
    %1 = complex.mul %arg1, %0 : complex<f32>
    %2 = call @__ocml_cexp_f32(%1) : (complex<f32>) -> complex<f32>
    return %2 : complex<f32>
  }
  func.func @powi_caller(%arg0: complex<f32>, %arg1: i32) -> complex<f32> {
    %0 = arith.sitofp %arg1 : i32 to f32
    %cst = arith.constant 0.000000e+00 : f32
    %1 = complex.create %0, %cst : complex<f32>
    %2 = call @__ocml_clog_f32(%arg0) : (complex<f32>) -> complex<f32>
    %3 = complex.mul %1, %2 : complex<f32>
    %4 = call @__ocml_cexp_f32(%3) : (complex<f32>) -> complex<f32>
    return %4 : complex<f32>
  }
  func.func @sin_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @__ocml_csin_f32(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @__ocml_csin_f64(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
  func.func @sqrt_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @__ocml_csqrt_f32(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @__ocml_csqrt_f64(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
  func.func @tan_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @__ocml_ctan_f32(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @__ocml_ctan_f64(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
  func.func @tanh_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @__ocml_ctanh_f32(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @__ocml_ctanh_f64(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
}

