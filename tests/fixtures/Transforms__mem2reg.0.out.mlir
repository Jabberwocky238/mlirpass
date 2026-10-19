module {
  func.func @multi_slot_alloca() -> (i32, i32) {
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %1 = "test.constant"() <{value = 42 : i32}> : () -> i32
    return %1, %0 : i32, i32
  }
}

// -----
module {
  func.func private @consumer(memref<i32>)
  func.func @multi_slot_alloca_only_second() -> (i32, i32) {
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %1 = test.multi_slot_alloca : () -> memref<i32>
    call @consumer(%1) : (memref<i32>) -> ()
    %2 = memref.load %1[] : memref<i32>
    return %2, %0 : i32, i32
  }
}

// -----
module {
  test.isolated_graph_region {
    %0 = test.multi_slot_alloca : () -> memref<i32>
    memref.store %1, %0[] : memref<i32>
    %1 = memref.load %0[] : memref<i32>
    "test.foo"() : () -> ()
  }
}

