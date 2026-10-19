module {
  func.func private @single_alloc(%arg0: index, %arg1: memref<?xf32>) {
    return
  }
  func.func @single_alloc_test(%arg0: index) {
    %alloc = memref.alloc(%arg0) : memref<?xf32>
    call @single_alloc(%arg0, %alloc) : (index, memref<?xf32>) -> ()
    "test.sink"(%alloc) : (memref<?xf32>) -> ()
  }
}

// -----
module {
  func.func private @mult_alloc(%arg0: index, %arg1: index, %arg2: memref<?x?xf32>, %arg3: memref<?xf32>) {
    return
  }
  func.func @mult_alloc_test(%arg0: index, %arg1: index) {
    %alloc = memref.alloc(%arg0, %arg1) : memref<?x?xf32>
    %alloc_0 = memref.alloc(%arg1) : memref<?xf32>
    call @mult_alloc(%arg0, %arg1, %alloc, %alloc_0) : (index, index, memref<?x?xf32>, memref<?xf32>) -> ()
    "test.sink"(%alloc, %alloc_0) : (memref<?x?xf32>, memref<?xf32>) -> ()
  }
}

// -----
module {
  func.func private @complex_alloc(%arg0: index, %arg1: index, %arg2: memref<?x?xf32>, %arg3: memref<4xf32>, %arg4: memref<?xf32>) {
    %alloc = memref.alloc() : memref<4xf32>
    memref.copy %alloc, %arg3 : memref<4xf32> to memref<4xf32>
    return
  }
  func.func @complex_alloc_test(%arg0: index, %arg1: index) {
    %alloc = memref.alloc(%arg0, %arg1) : memref<?x?xf32>
    %alloc_0 = memref.alloc() : memref<4xf32>
    %alloc_1 = memref.alloc(%arg1) : memref<?xf32>
    call @complex_alloc(%arg0, %arg1, %alloc, %alloc_0, %alloc_1) : (index, index, memref<?x?xf32>, memref<4xf32>, memref<?xf32>) -> ()
    "test.sink"(%alloc, %alloc_0, %alloc_1) : (memref<?x?xf32>, memref<4xf32>, memref<?xf32>) -> ()
  }
}

