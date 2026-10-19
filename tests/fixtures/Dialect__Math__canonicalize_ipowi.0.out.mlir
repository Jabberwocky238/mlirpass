module {
  func.func @ipowi32_fold(%arg0: memref<?xi32>) {
    %c1073741824_i32 = arith.constant 1073741824 : i32
    %c-27_i32 = arith.constant -27 : i32
    %c11 = arith.constant 11 : index
    %c10 = arith.constant 10 : index
    %c9 = arith.constant 9 : index
    %c8 = arith.constant 8 : index
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c-1_i32 = arith.constant -1 : i32
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    memref.store %c1_i32, %arg0[%c0] : memref<?xi32>
    memref.store %c1_i32, %arg0[%c1] : memref<?xi32>
    memref.store %c1_i32, %arg0[%c2] : memref<?xi32>
    %0 = math.ipowi %c0_i32, %c-1_i32 : i32
    memref.store %0, %arg0[%c3] : memref<?xi32>
    memref.store %c1_i32, %arg0[%c4] : memref<?xi32>
    memref.store %c0_i32, %arg0[%c5] : memref<?xi32>
    memref.store %c0_i32, %arg0[%c6] : memref<?xi32>
    memref.store %c1_i32, %arg0[%c7] : memref<?xi32>
    memref.store %c-1_i32, %arg0[%c8] : memref<?xi32>
    memref.store %c-27_i32, %arg0[%c9] : memref<?xi32>
    memref.store %c1073741824_i32, %arg0[%c10] : memref<?xi32>
    memref.store %c1073741824_i32, %arg0[%c11] : memref<?xi32>
    return
  }
  func.func @ipowi64_fold(%arg0: memref<?xi64>) {
    %c281474976710656_i64 = arith.constant 281474976710656 : i64
    %c1073741824_i64 = arith.constant 1073741824 : i64
    %c-27_i64 = arith.constant -27 : i64
    %c11 = arith.constant 11 : index
    %c10 = arith.constant 10 : index
    %c9 = arith.constant 9 : index
    %c8 = arith.constant 8 : index
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c-1_i64 = arith.constant -1 : i64
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    memref.store %c1_i64, %arg0[%c0] : memref<?xi64>
    memref.store %c1_i64, %arg0[%c1] : memref<?xi64>
    memref.store %c1_i64, %arg0[%c2] : memref<?xi64>
    %0 = math.ipowi %c0_i64, %c-1_i64 : i64
    memref.store %0, %arg0[%c3] : memref<?xi64>
    memref.store %c1_i64, %arg0[%c4] : memref<?xi64>
    memref.store %c0_i64, %arg0[%c5] : memref<?xi64>
    memref.store %c0_i64, %arg0[%c6] : memref<?xi64>
    memref.store %c1_i64, %arg0[%c7] : memref<?xi64>
    memref.store %c-1_i64, %arg0[%c8] : memref<?xi64>
    memref.store %c-27_i64, %arg0[%c9] : memref<?xi64>
    memref.store %c1073741824_i64, %arg0[%c10] : memref<?xi64>
    memref.store %c281474976710656_i64, %arg0[%c11] : memref<?xi64>
    return
  }
  func.func @ipowi16_fold(%arg0: memref<?xi16>) {
    %c16384_i16 = arith.constant 16384 : i16
    %c-27_i16 = arith.constant -27 : i16
    %c10 = arith.constant 10 : index
    %c9 = arith.constant 9 : index
    %c8 = arith.constant 8 : index
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c-1_i16 = arith.constant -1 : i16
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c0_i16 = arith.constant 0 : i16
    %c1_i16 = arith.constant 1 : i16
    memref.store %c1_i16, %arg0[%c0] : memref<?xi16>
    memref.store %c1_i16, %arg0[%c1] : memref<?xi16>
    memref.store %c1_i16, %arg0[%c2] : memref<?xi16>
    %0 = math.ipowi %c0_i16, %c-1_i16 : i16
    memref.store %0, %arg0[%c3] : memref<?xi16>
    memref.store %c1_i16, %arg0[%c4] : memref<?xi16>
    memref.store %c0_i16, %arg0[%c5] : memref<?xi16>
    memref.store %c0_i16, %arg0[%c6] : memref<?xi16>
    memref.store %c1_i16, %arg0[%c7] : memref<?xi16>
    memref.store %c-1_i16, %arg0[%c8] : memref<?xi16>
    memref.store %c-27_i16, %arg0[%c9] : memref<?xi16>
    memref.store %c16384_i16, %arg0[%c10] : memref<?xi16>
    return
  }
  func.func @ipowi8_fold(%arg0: memref<?xi8>) {
    %c64_i8 = arith.constant 64 : i8
    %c-27_i8 = arith.constant -27 : i8
    %c10 = arith.constant 10 : index
    %c9 = arith.constant 9 : index
    %c8 = arith.constant 8 : index
    %c7 = arith.constant 7 : index
    %c6 = arith.constant 6 : index
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c-1_i8 = arith.constant -1 : i8
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c0_i8 = arith.constant 0 : i8
    %c1_i8 = arith.constant 1 : i8
    memref.store %c1_i8, %arg0[%c0] : memref<?xi8>
    memref.store %c1_i8, %arg0[%c1] : memref<?xi8>
    memref.store %c1_i8, %arg0[%c2] : memref<?xi8>
    %0 = math.ipowi %c0_i8, %c-1_i8 : i8
    memref.store %0, %arg0[%c3] : memref<?xi8>
    memref.store %c1_i8, %arg0[%c4] : memref<?xi8>
    memref.store %c0_i8, %arg0[%c5] : memref<?xi8>
    memref.store %c0_i8, %arg0[%c6] : memref<?xi8>
    memref.store %c1_i8, %arg0[%c7] : memref<?xi8>
    memref.store %c-1_i8, %arg0[%c8] : memref<?xi8>
    memref.store %c-27_i8, %arg0[%c9] : memref<?xi8>
    memref.store %c64_i8, %arg0[%c10] : memref<?xi8>
    return
  }
}

