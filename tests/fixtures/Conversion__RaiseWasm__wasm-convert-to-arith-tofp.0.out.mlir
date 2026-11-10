module {
  func.func @convert_i32_u_to_f32() -> f32 {
    %c10_i32 = arith.constant 10 : i32
    %0 = arith.uitofp %c10_i32 : i32 to f32
    return %0 : f32
  }
  func.func @convert_i32_s_to_f32() -> f32 {
    %c42_i32 = arith.constant 42 : i32
    %0 = arith.sitofp %c42_i32 : i32 to f32
    return %0 : f32
  }
  func.func @convert_i64_u_to_f32() -> f32 {
    %c17_i64 = arith.constant 17 : i64
    %0 = arith.uitofp %c17_i64 : i64 to f32
    return %0 : f32
  }
  func.func @convert_i64s_to_f32() -> f32 {
    %c10_i64 = arith.constant 10 : i64
    %0 = arith.sitofp %c10_i64 : i64 to f32
    return %0 : f32
  }
  func.func @convert_i32_u_to_f64() -> f64 {
    %c10_i32 = arith.constant 10 : i32
    %0 = arith.uitofp %c10_i32 : i32 to f64
    return %0 : f64
  }
  func.func @convert_i32_s_to_f64() -> f64 {
    %c42_i32 = arith.constant 42 : i32
    %0 = arith.sitofp %c42_i32 : i32 to f64
    return %0 : f64
  }
  func.func @convert_i64_u_to_f64() -> f64 {
    %c17_i64 = arith.constant 17 : i64
    %0 = arith.uitofp %c17_i64 : i64 to f64
    return %0 : f64
  }
  func.func @convert_i64s_to_f64() -> f64 {
    %c10_i64 = arith.constant 10 : i64
    %0 = arith.sitofp %c10_i64 : i64 to f64
    return %0 : f64
  }
}

