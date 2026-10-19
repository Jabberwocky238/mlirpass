module {
  func.func private @ctan(complex<f64>) -> complex<f64>
  func.func private @ctanf(complex<f32>) -> complex<f32>
  func.func private @clog(complex<f64>) -> complex<f64>
  func.func private @clogf(complex<f32>) -> complex<f32>
  func.func private @carg(complex<f64>) -> f64
  func.func private @cargf(complex<f32>) -> f32
  func.func private @cabs(complex<f64>) -> f64
  func.func private @cabsf(complex<f32>) -> f32
  func.func private @conj(complex<f64>) -> complex<f64>
  func.func private @conjf(complex<f32>) -> complex<f32>
  func.func private @csin(complex<f64>) -> complex<f64>
  func.func private @csinf(complex<f32>) -> complex<f32>
  func.func private @ccos(complex<f64>) -> complex<f64>
  func.func private @ccosf(complex<f32>) -> complex<f32>
  func.func private @ctanh(complex<f64>) -> complex<f64>
  func.func private @ctanhf(complex<f32>) -> complex<f32>
  func.func private @csqrt(complex<f64>) -> complex<f64>
  func.func private @csqrtf(complex<f32>) -> complex<f32>
  func.func private @cpow(complex<f64>, complex<f64>) -> complex<f64>
  func.func private @cpowf(complex<f32>, complex<f32>) -> complex<f32>
  func.func @cpow_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @cpowf(%arg0, %arg0) : (complex<f32>, complex<f32>) -> complex<f32>
    %1 = call @cpow(%arg1, %arg1) : (complex<f64>, complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
  func.func @csqrt_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @csqrtf(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @csqrt(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
  func.func @ctanh_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @ctanhf(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @ctanh(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
  func.func @ccos_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @ccosf(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @ccos(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
  func.func @csin_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @csinf(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @csin(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
  func.func @conj_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @conjf(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @conj(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
  func.func @cabs_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (f32, f64) {
    %0 = call @cabsf(%arg0) : (complex<f32>) -> f32
    %1 = call @cabs(%arg1) : (complex<f64>) -> f64
    return %0, %1 : f32, f64
  }
  func.func @carg_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (f32, f64) {
    %0 = call @cargf(%arg0) : (complex<f32>) -> f32
    %1 = call @carg(%arg1) : (complex<f64>) -> f64
    return %0, %1 : f32, f64
  }
  func.func @clog_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @clogf(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @clog(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
  func.func @ctan_caller(%arg0: complex<f32>, %arg1: complex<f64>) -> (complex<f32>, complex<f64>) {
    %0 = call @ctanf(%arg0) : (complex<f32>) -> complex<f32>
    %1 = call @ctan(%arg1) : (complex<f64>) -> complex<f64>
    return %0, %1 : complex<f32>, complex<f64>
  }
}

