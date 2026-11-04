module {
  func.func private @fill_inplace(%arg0: memref<?xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    linalg.fill ins(%cst : f32) outs(%arg0 : memref<?xf32>)
    return
  }
}

// -----
module {
  func.func @not_inplace(%arg0: memref<?xf32>) -> memref<?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    linalg.fill ins(%cst : f32) outs(%alloc : memref<?xf32>)
    return %alloc : memref<?xf32>
  }
}

// -----
module {
  func.func private @not_inplace(%arg0: memref<?x?xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?xf32>
    %alloc = memref.alloc(%dim, %dim_0) {alignment = 64 : i64} : memref<?x?xf32>
    linalg.fill ins(%cst : f32) outs(%alloc : memref<?x?xf32>)
    linalg.matmul ins(%alloc, %alloc : memref<?x?xf32>, memref<?x?xf32>) outs(%arg0 : memref<?x?xf32>)
    return
  }
}

// -----
module {
  func.func @not_inplace(%arg0: memref<?x?xf32>) -> memref<?x?xf32> {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?xf32>
    %alloc = memref.alloc(%dim, %dim_0) {alignment = 64 : i64} : memref<?x?xf32>
    memref.copy %arg0, %alloc : memref<?x?xf32> to memref<?x?xf32>
    linalg.matmul ins(%arg0, %arg0 : memref<?x?xf32>, memref<?x?xf32>) outs(%alloc : memref<?x?xf32>)
    return %alloc : memref<?x?xf32>
  }
}

// -----
module {
  func.func @vec_inplace(%arg0: memref<?xf32>, %arg1: vector<4xf32>) -> memref<?xf32> {
    %c0 = arith.constant 0 : index
    vector.transfer_write %arg1, %arg0[%c0] : vector<4xf32>, memref<?xf32>
    return %arg0 : memref<?xf32>
  }
}

// -----
module {
  func.func @vec_not_inplace(%arg0: memref<?xf32>, %arg1: vector<4xf32>) -> (memref<?xf32>, memref<?xf32>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c0_0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0_0 : memref<?xf32>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32> to memref<?xf32>
    vector.transfer_write %arg1, %alloc[%c0] : vector<4xf32>, memref<?xf32>
    vector.transfer_write %arg1, %arg0[%c1] : vector<4xf32>, memref<?xf32>
    return %alloc, %arg0 : memref<?xf32>, memref<?xf32>
  }
}

// -----
module {
  func.func @matmul(%arg0: memref<128x256xf32>, %arg1: memref<256x192xf32>, %arg2: memref<128x192xf32>) -> memref<128x192xf32> {
    %c0 = arith.constant 0 : index
    %c256 = arith.constant 256 : index
    %c32 = arith.constant 32 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c128 = arith.constant 128 : index
    %c192 = arith.constant 192 : index
    %c8 = arith.constant 8 : index
    %c16 = arith.constant 16 : index
    %0 = scf.for %arg3 = %c0 to %c128 step %c8 iter_args(%arg4 = %arg2) -> (memref<128x192xf32>) {
      %subview = memref.subview %arg0[%arg3, 0] [8, 256] [1, 1] : memref<128x256xf32> to memref<8x256xf32, strided<[256, 1], offset: ?>>
      %1 = scf.for %arg5 = %c0 to %c192 step %c16 iter_args(%arg6 = %arg4) -> (memref<128x192xf32>) {
        %subview_0 = memref.subview %arg1[0, %arg5] [256, 16] [1, 1] : memref<256x192xf32> to memref<256x16xf32, strided<[192, 1], offset: ?>>
        %subview_1 = memref.subview %arg2[%arg3, %arg5] [8, 16] [1, 1] : memref<128x192xf32> to memref<8x16xf32, strided<[192, 1], offset: ?>>
        %alloc = memref.alloc() {alignment = 64 : i64} : memref<8x16xf32>
        linalg.fill ins(%cst : f32) outs(%alloc : memref<8x16xf32>)
        %2 = scf.for %arg7 = %c0 to %c256 step %c32 iter_args(%arg8 = %alloc) -> (memref<8x16xf32>) {
          %subview_3 = memref.subview %subview[0, %arg7] [8, 32] [1, 1] : memref<8x256xf32, strided<[256, 1], offset: ?>> to memref<8x32xf32, strided<[256, 1], offset: ?>>
          %subview_4 = memref.subview %subview_0[%arg7, 0] [32, 16] [1, 1] : memref<256x16xf32, strided<[192, 1], offset: ?>> to memref<32x16xf32, strided<[192, 1], offset: ?>>
          linalg.matmul ins(%subview_3, %subview_4 : memref<8x32xf32, strided<[256, 1], offset: ?>>, memref<32x16xf32, strided<[192, 1], offset: ?>>) outs(%arg8 : memref<8x16xf32>)
          scf.yield %arg8 : memref<8x16xf32>
        }
        %subview_2 = memref.subview %arg6[%arg3, %arg5] [8, 16] [1, 1] : memref<128x192xf32> to memref<8x16xf32, strided<[192, 1], offset: ?>>
        memref.copy %2, %subview_2 : memref<8x16xf32> to memref<8x16xf32, strided<[192, 1], offset: ?>>
        scf.yield %arg6 : memref<128x192xf32>
      }
      scf.yield %1 : memref<128x192xf32>
    }
    return %0 : memref<128x192xf32>
  }
}

// -----
module {
  func.func @dominance_violation_bug_1(%arg0: memref<?x?xf32>, %arg1: index) -> memref<?x?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %subview = memref.subview %arg0[0, 0] [%arg1, %arg1] [1, 1] : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1]>>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %subview, %c0 : memref<?x?xf32, strided<[?, 1]>>
    %c1 = arith.constant 1 : index
    %dim_0 = memref.dim %subview, %c1 : memref<?x?xf32, strided<[?, 1]>>
    %alloc = memref.alloc(%dim, %dim_0) {alignment = 64 : i64} : memref<?x?xf32>
    memref.copy %subview, %alloc : memref<?x?xf32, strided<[?, 1]>> to memref<?x?xf32>
    %subview_1 = memref.subview %alloc[0, 0] [4, 4] [1, 1] : memref<?x?xf32> to memref<4x4xf32, strided<[?, 1]>>
    linalg.fill ins(%cst : f32) outs(%subview_1 : memref<4x4xf32, strided<[?, 1]>>)
    %subview_2 = memref.subview %alloc[0, 0] [4, 4] [1, 1] : memref<?x?xf32> to memref<4x4xf32, strided<[?, 1]>>
    memref.copy %subview_1, %subview_2 : memref<4x4xf32, strided<[?, 1]>> to memref<4x4xf32, strided<[?, 1]>>
    %c0_3 = arith.constant 0 : index
    %dim_4 = memref.dim %arg0, %c0_3 : memref<?x?xf32>
    %c1_5 = arith.constant 1 : index
    %dim_6 = memref.dim %arg0, %c1_5 : memref<?x?xf32>
    %alloc_7 = memref.alloc(%dim_4, %dim_6) {alignment = 64 : i64} : memref<?x?xf32>
    memref.copy %arg0, %alloc_7 : memref<?x?xf32> to memref<?x?xf32>
    %subview_8 = memref.subview %alloc_7[0, 0] [%arg1, %arg1] [1, 1] : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1]>>
    memref.copy %alloc, %subview_8 : memref<?x?xf32> to memref<?x?xf32, strided<[?, 1]>>
    return %alloc_7 : memref<?x?xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func private @gather_like(%arg0: memref<?x?xf32>, %arg1: memref<?xi32>, %arg2: memref<?x?xf32>) {
    linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg1 : memref<?xi32>) outs(%arg2 : memref<?x?xf32>) {
    ^bb0(%in: i32, %out: f32):
      %0 = linalg.index 1 : index
      %1 = arith.index_cast %in : i32 to index
      %2 = memref.load %arg0[%1, %0] : memref<?x?xf32>
      linalg.yield %2 : f32
    }
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
module {
  func.func @linalg_op_bufferizes_inplace_with_input(%arg0: memref<?x?xf32>, %arg1: memref<?xf32>, %arg2: memref<?x?xf32>, %arg3: index, %arg4: index, %arg5: f32) -> memref<?x?xf32> {
    linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : memref<?x?xf32>, memref<?xf32>) outs(%arg2 : memref<?x?xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %0 = arith.addf %in, %in_0 : f32
      linalg.yield %0 : f32
    }
    return %arg2 : memref<?x?xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
module {
  func.func @op_is_reading_but_following_ops_are_not(%arg0: memref<?xf32>, %arg1: f32) -> memref<?xf32> {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32> to memref<?xf32>
    linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%alloc : memref<?xf32>) {
    ^bb0(%out: f32):
      %0 = arith.addf %arg1, %out : f32
      linalg.yield %0 : f32
    }
    linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%alloc : memref<?xf32>) {
    ^bb0(%out: f32):
      linalg.yield %arg1 : f32
    }
    return %alloc : memref<?xf32>
  }
}

// -----
module {
  func.func @map_binary(%arg0: memref<64xf32>, %arg1: memref<64xf32>, %arg2: memref<64xf32>) -> memref<64xf32> {
    linalg.map { arith.addf } ins(%arg0, %arg1 : memref<64xf32>, memref<64xf32>) outs(%arg2 : memref<64xf32>)
    return %arg2 : memref<64xf32>
  }
}

// -----
module {
  func.func @reduce(%arg0: memref<16x32x64xf32>, %arg1: memref<16x64xf32>) -> memref<16x64xf32> {
    linalg.reduce { arith.addf } ins(%arg0 : memref<16x32x64xf32>) outs(%arg1 : memref<16x64xf32>) dimensions = [1] 
    return %arg1 : memref<16x64xf32>
  }
}

// -----
module {
  func.func @transpose(%arg0: memref<16x32x64xf32>, %arg1: memref<32x64x16xf32>) -> memref<32x64x16xf32> {
    linalg.transpose ins(%arg0 : memref<16x32x64xf32>) outs(%arg1 : memref<32x64x16xf32>) permutation = [1, 2, 0] 
    return %arg1 : memref<32x64x16xf32>
  }
}

// -----
module {
  func.func @broadcast(%arg0: memref<8x32xf32>, %arg1: memref<8x16x32xf32>) -> memref<8x16x32xf32> {
    linalg.broadcast ins(%arg0 : memref<8x32xf32>) outs(%arg1 : memref<8x16x32xf32>) dimensions = [1] 
    return %arg1 : memref<8x16x32xf32>
  }
}

// -----
#map = affine_map<(d0) -> (d0 ceildiv 8)>
module {
  func.func @depthwise_conv_1d_nwc_wc(%arg0: index, %arg1: index, %arg2: memref<8x18x32xf32>) -> memref<?x1x6x8xf32> {
    %c0 = arith.constant 0 : index
    %c32 = arith.constant 32 : index
    %c8 = arith.constant 8 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4x1x6x8xf32>
    %cast = memref.cast %alloc : memref<4x1x6x8xf32> to memref<?x1x6x8xf32>
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<1x6x8xf32>
    %0 = scf.for %arg3 = %c0 to %c32 step %c8 iter_args(%arg4 = %cast) -> (memref<?x1x6x8xf32>) {
      %1 = affine.apply #map(%arg3)
      %subview = memref.subview %arg4[%1, 0, 0, 0] [1, 1, 6, 8] [1, 1, 1, 1] : memref<?x1x6x8xf32> to memref<1x6x8xf32, strided<[48, 8, 1], offset: ?>>
      memref.copy %alloc_0, %subview : memref<1x6x8xf32> to memref<1x6x8xf32, strided<[48, 8, 1], offset: ?>>
      scf.yield %arg4 : memref<?x1x6x8xf32>
    }
    return %0 : memref<?x1x6x8xf32>
  }
}

// -----
module {
  func.func @do_not_copy_alloc_tensors(%arg0: f32, %arg1: f32, %arg2: index) -> (memref<5xf32>, memref<5xf32>) {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    memref.store %arg0, %alloc_0[%arg2] : memref<5xf32>
    memref.store %arg1, %alloc[%arg2] : memref<5xf32>
    return %alloc_0, %alloc : memref<5xf32>, memref<5xf32>
  }
}

