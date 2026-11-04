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

