module {
  func.func @or_i32(%arg0: i32, %arg1: i32) -> i32 {
    %alloca = memref.alloca() : memref<i32>
    memref.store %arg1, %alloca[] : memref<i32>
    %alloca_0 = memref.alloca() : memref<i32>
    memref.store %arg0, %alloca_0[] : memref<i32>
    %0 = memref.load %alloca_0[] : memref<i32>
    %1 = memref.load %alloca[] : memref<i32>
    %2 = arith.ori %0, %1 : i32
    return %2 : i32
  }
  func.func @or_i64(%arg0: i64, %arg1: i64) -> i64 {
    %alloca = memref.alloca() : memref<i64>
    memref.store %arg1, %alloca[] : memref<i64>
    %alloca_0 = memref.alloca() : memref<i64>
    memref.store %arg0, %alloca_0[] : memref<i64>
    %0 = memref.load %alloca_0[] : memref<i64>
    %1 = memref.load %alloca[] : memref<i64>
    %2 = arith.ori %0, %1 : i64
    return %2 : i64
  }
}

