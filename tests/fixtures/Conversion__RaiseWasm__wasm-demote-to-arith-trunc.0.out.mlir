module {
  func.func @func_0() -> f32 {
    %cst = arith.constant 2.240000e+00 : f64
    %0 = arith.truncf %cst : f64 to f32
    return %0 : f32
  }
}

