module {
  func.func @get_some_const() -> (i32, i64, f32, f64) {
    %c17_i32 = arith.constant 17 : i32
    %c-163_i64 = arith.constant -163 : i64
    %cst = arith.constant 3.140000e+00 : f32
    %cst_0 = arith.constant -1.575000e+02 : f64
    return %c17_i32, %c-163_i64, %cst, %cst_0 : i32, i64, f32, f64
  }
}

