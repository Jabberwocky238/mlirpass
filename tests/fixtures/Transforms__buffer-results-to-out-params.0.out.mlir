module {
  func.func private @basic(%arg0: memref<f32>) {
    %0 = "test.source"() : () -> memref<f32>
    memref.copy %0, %arg0 : memref<f32> to memref<f32>
    return
  }
  func.func private @presence_of_existing_arguments(%arg0: memref<1xf32>, %arg1: memref<2xf32>) {
    %0 = "test.source"() : () -> memref<2xf32>
    memref.copy %0, %arg1 : memref<2xf32> to memref<2xf32>
    return
  }
  func.func private @multiple_results(%arg0: memref<1xf32>, %arg1: memref<2xf32>) {
    %0:2 = "test.source"() : () -> (memref<1xf32>, memref<2xf32>)
    memref.copy %0#0, %arg0 : memref<1xf32> to memref<1xf32>
    memref.copy %0#1, %arg1 : memref<2xf32> to memref<2xf32>
    return
  }
  func.func private @non_memref_types(%arg0: memref<f32>) -> (i1, i32) {
    %0:3 = "test.source"() : () -> (i1, memref<f32>, i32)
    memref.copy %0#1, %arg0 : memref<f32> to memref<f32>
    return %0#0, %0#2 : i1, i32
  }
  func.func private @external_function() -> memref<f32>
  func.func private @result_attrs() -> (memref<f32> {test.some_attr})
  func.func private @mixed_result_attrs() -> (memref<1xf32>, memref<2xf32> {test.some_attr}, memref<3xf32>)
}

// -----
module {
  func.func private @callee() -> memref<1xf32>
  func.func @call_basic() {
    %0 = call @callee() : () -> memref<1xf32>
    "test.sink"(%0) : (memref<1xf32>) -> ()
    return
  }
}

// -----
module {
  func.func private @callee() -> (memref<1xf32>, memref<2xf32>)
  func.func @call_multiple_result() {
    %0:2 = call @callee() : () -> (memref<1xf32>, memref<2xf32>)
    "test.sink"(%0#0, %0#1) : (memref<1xf32>, memref<2xf32>) -> ()
  }
}

// -----
module {
  func.func private @callee() -> (i1, memref<1xf32>, i32)
  func.func @call_non_memref_result() {
    %0:3 = call @callee() : () -> (i1, memref<1xf32>, i32)
    "test.sink"(%0#0, %0#1, %0#2) : (i1, memref<1xf32>, i32) -> ()
  }
}

// -----
