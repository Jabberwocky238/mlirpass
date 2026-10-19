module {
  func.func private @basic(%arg0: memref<8x64xf32>) {
    "test.source"(%arg0) : (memref<8x64xf32>) -> ()
    return
  }
  func.func private @basic_no_change(%arg0: memref<f32>) {
    %0 = "test.source"() : () -> memref<f32>
    memref.copy %0, %arg0 : memref<f32> to memref<f32>
    return
  }
  func.func private @basic_dynamic(%arg0: index, %arg1: memref<?xf32>) {
    %alloc = memref.alloc(%arg0) : memref<?xf32>
    "test.source"(%alloc) : (memref<?xf32>) -> ()
    memref.copy %alloc, %arg1 : memref<?xf32> to memref<?xf32>
    return
  }
  func.func private @return_arg(%arg0: memref<128x256xf32>, %arg1: memref<128x256xf32>, %arg2: memref<128x256xf32>) {
    "test.source"(%arg0, %arg1) : (memref<128x256xf32>, memref<128x256xf32>) -> ()
    memref.copy %arg0, %arg2 : memref<128x256xf32> to memref<128x256xf32>
    return
  }
}

