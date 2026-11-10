module {
  func.func @i64_wrap(%arg0: i64) -> i32 {
    %alloca = memref.alloca() : memref<i64>
    memref.store %arg0, %alloca[] : memref<i64>
    %0 = memref.load %alloca[] : memref<i64>
    %1 = arith.trunci %0 : i64 to i32
    return %1 : i32
  }
}

