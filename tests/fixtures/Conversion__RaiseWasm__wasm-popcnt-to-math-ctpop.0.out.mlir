module {
  func.func @popcnt_i32(%arg0: i32) -> i32 {
    %alloca = memref.alloca() : memref<i32>
    memref.store %arg0, %alloca[] : memref<i32>
    %0 = memref.load %alloca[] : memref<i32>
    %1 = math.ctpop %0 : i32
    return %1 : i32
  }
  func.func @popcnt_i64(%arg0: i64) -> i64 {
    %alloca = memref.alloca() : memref<i64>
    memref.store %arg0, %alloca[] : memref<i64>
    %0 = memref.load %alloca[] : memref<i64>
    %1 = math.ctpop %0 : i64
    return %1 : i64
  }
}

