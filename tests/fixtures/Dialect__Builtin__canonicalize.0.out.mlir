module {
  func.func @multiple_conversion_casts(%arg0: i32, %arg1: i32) -> (i32, i32) {
    return %arg0, %arg1 : i32, i32
  }
  func.func @multiple_conversion_casts_failure(%arg0: i32, %arg1: i32, %arg2: i64) -> (i32, i32) {
    %0:2 = builtin.unrealized_conversion_cast %arg0, %arg1 : i32, i32 to i64, i64
    %1:2 = builtin.unrealized_conversion_cast %arg2, %0#1 : i64, i64 to i32, i32
    return %1#0, %1#1 : i32, i32
  }
}

