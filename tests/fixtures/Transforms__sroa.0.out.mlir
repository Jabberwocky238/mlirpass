module {
  func.func @multi_slot_alloca() -> (i32, i32) {
    %c0 = arith.constant 0 : index
    %0 = test.multi_slot_alloca : () -> memref<i32>
    %1 = test.multi_slot_alloca : () -> memref<i32>
    %2 = memref.load %1[] {first} : memref<i32>
    %3 = memref.load %0[] {second} : memref<i32>
    return %2, %3 : i32, i32
  }
}

// -----
module {
  func.func private @consumer(memref<2xi32>)
  func.func @multi_slot_alloca_only_second() -> (i32, i32) {
    %c0 = arith.constant 0 : index
    %0 = test.multi_slot_alloca : () -> memref<2xi32>
    %1 = test.multi_slot_alloca : () -> memref<i32>
    call @consumer(%0) : (memref<2xi32>) -> ()
    %2 = memref.load %0[%c0] : memref<2xi32>
    %3 = memref.load %1[] : memref<i32>
    return %2, %3 : i32, i32
  }
}

