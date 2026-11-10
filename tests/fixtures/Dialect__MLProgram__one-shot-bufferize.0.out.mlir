module {
  memref.global "private" @global : memref<i64> = dense<0>
  func.func @global_load_store() -> i64 {
    %c127_i64 = arith.constant 127 : i64
    %0 = memref.get_global @global : memref<i64>
    %1 = memref.load %0[] : memref<i64>
    %2 = arith.muli %1, %c127_i64 : i64
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<i64>
    memref.copy %0, %alloc : memref<i64> to memref<i64>
    memref.store %2, %alloc[] : memref<i64>
    %3 = memref.get_global @global : memref<i64>
    memref.copy %alloc, %3 : memref<i64> to memref<i64>
    return %2 : i64
  }
}

// -----
module {
  memref.global "private" @global : memref<i64> = dense<0>
  func.func @raw_hazard() -> i64 {
    %c127_i64 = arith.constant 127 : i64
    %0 = memref.get_global @global : memref<i64>
    %1 = memref.get_global @global : memref<i64>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<i64>
    memref.copy %0, %alloc : memref<i64> to memref<i64>
    memref.store %c127_i64, %alloc[] : memref<i64>
    %2 = memref.load %1[] : memref<i64>
    %3 = memref.get_global @global : memref<i64>
    memref.copy %alloc, %3 : memref<i64> to memref<i64>
    return %2 : i64
  }
}

// -----
module {
  memref.global "private" @state_tensor : memref<4x75xf32> = dense<0.000000e+00>
  func.func @global_load_store_tensor() -> tensor<4x75xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 1.000000e+00 : f32
    %0 = memref.get_global @state_tensor : memref<4x75xf32>
    %1 = memref.load %0[%c0, %c0] : memref<4x75xf32>
    %2 = arith.addf %1, %cst : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4x75xf32>
    memref.copy %0, %alloc : memref<4x75xf32> to memref<4x75xf32>
    memref.store %2, %alloc[%c0, %c0] : memref<4x75xf32>
    %3 = bufferization.to_tensor %alloc : memref<4x75xf32> to tensor<4x75xf32>
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<4x75xf32>
    memref.copy %alloc, %alloc_0 : memref<4x75xf32> to memref<4x75xf32>
    %4 = memref.get_global @state_tensor : memref<4x75xf32>
    memref.copy %alloc_0, %4 : memref<4x75xf32> to memref<4x75xf32>
    return %3 : tensor<4x75xf32>
  }
}

