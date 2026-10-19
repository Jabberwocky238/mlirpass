module {
  func.func @create_of_real_and_imag(%arg0: complex<f32>) -> complex<f32> {
    return %arg0 : complex<f32>
  }
  func.func @create_of_real_and_imag_different_operand(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = complex.re %arg0 : complex<f32>
    %1 = complex.im %arg1 : complex<f32>
    %2 = complex.create %0, %1 : complex<f32>
    return %2 : complex<f32>
  }
  func.func @real_of_const() -> f32 {
    %cst = arith.constant 1.000000e+00 : f32
    return %cst : f32
  }
  func.func @real_of_create_op() -> f32 {
    %cst = arith.constant 1.000000e+00 : f32
    return %cst : f32
  }
  func.func @imag_of_const() -> f32 {
    %cst = arith.constant 0.000000e+00 : f32
    return %cst : f32
  }
  func.func @imag_of_create_op() -> f32 {
    %cst = arith.constant 0.000000e+00 : f32
    return %cst : f32
  }
  func.func @complex_add_sub_lhs() -> complex<f32> {
    %cst = complex.constant [1.000000e+00 : f32, 0.000000e+00 : f32] : complex<f32>
    return %cst : complex<f32>
  }
  func.func @complex_add_sub_rhs() -> complex<f32> {
    %cst = complex.constant [1.000000e+00 : f32, 0.000000e+00 : f32] : complex<f32>
    return %cst : complex<f32>
  }
  func.func @complex_neg_neg() -> complex<f32> {
    %cst = complex.constant [1.000000e+00 : f32, 0.000000e+00 : f32] : complex<f32>
    return %cst : complex<f32>
  }
  func.func @complex_log_exp() -> complex<f32> {
    %cst = complex.constant [1.000000e+00 : f32, 0.000000e+00 : f32] : complex<f32>
    return %cst : complex<f32>
  }
  func.func @complex_exp_log() -> complex<f32> {
    %cst = complex.constant [1.000000e+00 : f32, 0.000000e+00 : f32] : complex<f32>
    return %cst : complex<f32>
  }
  func.func @complex_conj_conj() -> complex<f32> {
    %cst = complex.constant [1.000000e+00 : f32, 0.000000e+00 : f32] : complex<f32>
    return %cst : complex<f32>
  }
  func.func @complex_add_zero() -> complex<f32> {
    %cst = complex.constant [1.000000e+00 : f32, 0.000000e+00 : f32] : complex<f32>
    return %cst : complex<f32>
  }
  func.func @complex_sub_add_lhs() -> complex<f32> {
    %cst = complex.constant [1.000000e+00 : f32, 0.000000e+00 : f32] : complex<f32>
    return %cst : complex<f32>
  }
  func.func @complex_sub_zero() -> complex<f32> {
    %cst = complex.constant [1.000000e+00 : f32, 0.000000e+00 : f32] : complex<f32>
    return %cst : complex<f32>
  }
  func.func @re_neg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = arith.negf %arg0 : f32
    return %0 : f32
  }
  func.func @im_neg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = arith.negf %arg1 : f32
    return %0 : f32
  }
  func.func @mul_one_f16(%arg0: f16, %arg1: f16) -> complex<f16> {
    %0 = complex.create %arg0, %arg1 : complex<f16>
    return %0 : complex<f16>
  }
  func.func @mul_one_f32(%arg0: f32, %arg1: f32) -> complex<f32> {
    %0 = complex.create %arg0, %arg1 : complex<f32>
    return %0 : complex<f32>
  }
  func.func @mul_one_f64(%arg0: f64, %arg1: f64) -> complex<f64> {
    %0 = complex.create %arg0, %arg1 : complex<f64>
    return %0 : complex<f64>
  }
  func.func @mul_one_f80(%arg0: f80, %arg1: f80) -> complex<f80> {
    %0 = complex.create %arg0, %arg1 : complex<f80>
    return %0 : complex<f80>
  }
  func.func @mul_one_f128(%arg0: f128, %arg1: f128) -> complex<f128> {
    %0 = complex.create %arg0, %arg1 : complex<f128>
    return %0 : complex<f128>
  }
  func.func @fold_between_complex(%arg0: complex<f32>) -> complex<f32> {
    return %arg0 : complex<f32>
  }
  func.func @fold_between_i64(%arg0: i64) -> i64 {
    return %arg0 : i64
  }
  func.func @canon_arith_bitcast(%arg0: f64) -> i64 {
    %0 = arith.bitcast %arg0 : f64 to i64
    return %0 : i64
  }
  func.func @double_bitcast(%arg0: f64) -> complex<f32> {
    %0 = complex.bitcast %arg0 : f64 to complex<f32>
    return %0 : complex<f32>
  }
  func.func @double_reverse_bitcast(%arg0: complex<f32>) -> f64 {
    %0 = complex.bitcast %arg0 : complex<f32> to f64
    return %0 : f64
  }
  func.func @div_one_f16(%arg0: f16, %arg1: f16) -> complex<f16> {
    %0 = complex.create %arg0, %arg1 : complex<f16>
    return %0 : complex<f16>
  }
  func.func @div_one_f32(%arg0: f32, %arg1: f32) -> complex<f32> {
    %0 = complex.create %arg0, %arg1 : complex<f32>
    return %0 : complex<f32>
  }
  func.func @div_one_f64(%arg0: f64, %arg1: f64) -> complex<f64> {
    %0 = complex.create %arg0, %arg1 : complex<f64>
    return %0 : complex<f64>
  }
  func.func @div_one_f80(%arg0: f80, %arg1: f80) -> complex<f80> {
    %0 = complex.create %arg0, %arg1 : complex<f80>
    return %0 : complex<f80>
  }
  func.func @div_one_f128(%arg0: f128, %arg1: f128) -> complex<f128> {
    %0 = complex.create %arg0, %arg1 : complex<f128>
    return %0 : complex<f128>
  }
}

