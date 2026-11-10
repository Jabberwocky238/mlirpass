module {
  func.func @i32.reinterpret_f32() -> i32 {
    %cst = arith.constant -1.000000e+00 : f32
    %0 = arith.bitcast %cst : f32 to i32
    return %0 : i32
  }
  func.func @i64.reinterpret_f64() -> i64 {
    %cst = arith.constant -1.000000e+00 : f64
    %0 = arith.bitcast %cst : f64 to i64
    return %0 : i64
  }
  func.func @f32.reinterpret_i32() -> f32 {
    %c-1_i32 = arith.constant -1 : i32
    %0 = arith.bitcast %c-1_i32 : i32 to f32
    return %0 : f32
  }
  func.func @f64.reinterpret_i64() -> f64 {
    %c-1_i64 = arith.constant -1 : i64
    %0 = arith.bitcast %c-1_i64 : i64 to f64
    return %0 : f64
  }
}

