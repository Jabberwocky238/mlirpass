module {
  func.func @mask(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: vector<16xf32>, %arg2: index, %arg3: vector<16xi1>) -> memref<?xf32, strided<[?], offset: ?>> {
    vector.mask %arg3 { vector.transfer_write %arg1, %arg0[%arg2] : vector<16xf32>, memref<?xf32, strided<[?], offset: ?>> } : vector<16xi1>
    return %arg0 : memref<?xf32, strided<[?], offset: ?>>
  }
  func.func @mask_scalable(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: vector<[16]xf32>, %arg2: index, %arg3: vector<[16]xi1>) -> memref<?xf32, strided<[?], offset: ?>> {
    vector.mask %arg3 { vector.transfer_write %arg1, %arg0[%arg2] : vector<[16]xf32>, memref<?xf32, strided<[?], offset: ?>> } : vector<[16]xi1>
    return %arg0 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @non_reading_xfer_write(%arg0: memref<5x10xf32, strided<[?, ?], offset: ?>>, %arg1: vector<6x11xf32>) -> memref<5x10xf32, strided<[?, ?], offset: ?>> {
    %c0 = arith.constant 0 : index
    vector.transfer_write %arg1, %arg0[%c0, %c0] : vector<6x11xf32>, memref<5x10xf32, strided<[?, ?], offset: ?>>
    return %arg0 : memref<5x10xf32, strided<[?, ?], offset: ?>>
  }
}

// -----
module {
  func.func @reading_xfer_write(%arg0: memref<5x10xf32, strided<[?, ?], offset: ?>>, %arg1: vector<4x11xf32>) -> memref<5x10xf32, strided<[?, ?], offset: ?>> {
    %c0 = arith.constant 0 : index
    vector.transfer_write %arg1, %arg0[%c0, %c0] : vector<4x11xf32>, memref<5x10xf32, strided<[?, ?], offset: ?>>
    return %arg0 : memref<5x10xf32, strided<[?, ?], offset: ?>>
  }
}

