module {
  func.func @func_4() -> f64 {
    %cst = arith.constant -1.210000e+01 : f64
    %0 = math.trunc %cst : f64
    return %0 : f64
  }
  func.func @func_5() -> f32 {
    %cst = arith.constant 1.618000e+00 : f32
    %0 = math.trunc %cst : f32
    return %0 : f32
  }
}

