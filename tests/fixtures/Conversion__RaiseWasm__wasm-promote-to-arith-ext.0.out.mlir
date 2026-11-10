module {
  func.func @promote_f32_to_f64() -> f64 {
    %cst = arith.constant 3.140000e+00 : f32
    %0 = arith.extf %cst : f32 to f64
    return %0 : f64
  }
}

