module {
  func.func private @insert_slice_fun(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: memref<4xf32, strided<[?], offset: ?>>, %arg3: memref<4xf32, strided<[?], offset: ?>>) -> (memref<?xf32>, memref<?xf32>, memref<?xf32>) {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %subview = memref.subview %alloc[0] [4] [1] : memref<?xf32> to memref<4xf32, strided<[1]>>
    memref.copy %arg2, %subview : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[1]>>
    %c0_0 = arith.constant 0 : index
    %dim_1 = memref.dim %arg0, %c0_0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc_2 = memref.alloc(%dim_1) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc_2 : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %subview_3 = memref.subview %alloc_2[0] [4] [1] : memref<?xf32> to memref<4xf32, strided<[1]>>
    memref.copy %arg3, %subview_3 : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[1]>>
    %c0_4 = arith.constant 0 : index
    %dim_5 = memref.dim %arg1, %c0_4 : memref<?xf32, strided<[?], offset: ?>>
    %alloc_6 = memref.alloc(%dim_5) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg1, %alloc_6 : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %subview_7 = memref.subview %alloc_6[0] [4] [1] : memref<?xf32> to memref<4xf32, strided<[1]>>
    memref.copy %arg2, %subview_7 : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[1]>>
    %subview_8 = memref.subview %arg1[0] [4] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
    memref.copy %arg3, %subview_8 : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
    %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %cast_9 = memref.cast %alloc_2 : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %cast_10 = memref.cast %alloc_6 : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    return %alloc, %alloc_2, %alloc_6 : memref<?xf32>, memref<?xf32>, memref<?xf32>
  }
}

// -----
module {
  func.func @insert_slice_fun(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<4xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>> {
    %cst = arith.constant 0.000000e+00 : f32
    %subview = memref.subview %arg0[0] [4] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
    memref.copy %arg1, %subview : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
    linalg.fill ins(%cst : f32) outs(%arg0 : memref<?xf32, strided<[?], offset: ?>>)
    return %arg0 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @insert_slice_fun(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<4xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>> {
    %cst = arith.constant 0.000000e+00 : f32
    linalg.fill ins(%cst : f32) outs(%arg0 : memref<?xf32, strided<[?], offset: ?>>)
    %subview = memref.subview %arg0[0] [4] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
    memref.copy %arg1, %subview : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
    return %arg0 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @insert_slice_fun_not_inplace(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<4xf32, strided<[?], offset: ?>>) -> memref<?xf32> {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %subview = memref.subview %alloc[0] [4] [1] : memref<?xf32> to memref<4xf32, strided<[1]>>
    memref.copy %arg1, %subview : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[1]>>
    %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    return %alloc : memref<?xf32>
  }
}

// -----
module {
  func.func @tensor_cast_not_in_place(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: index) -> memref<?xf32, strided<[?], offset: ?>> {
    %cast = memref.cast %arg0 : memref<?xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4xf32>
    memref.copy %cast, %alloc : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32>
    %subview = memref.subview %arg0[%arg2] [4] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
    memref.copy %alloc, %subview : memref<4xf32> to memref<4xf32, strided<[?], offset: ?>>
    return %arg0 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @insert_op(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: f32, %arg2: index) -> memref<?xf32, strided<[?], offset: ?>> {
    memref.store %arg1, %arg0[%arg2] : memref<?xf32, strided<[?], offset: ?>>
    return %arg0 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
#map = affine_map<(d0) -> (d0 ceildiv 8)>
module {
  func.func @rank_reducing(%arg0: index, %arg1: index, %arg2: memref<8x18x32xf32, strided<[?, ?, ?], offset: ?>>) -> memref<?x1x6x8xf32> {
    %c1 = arith.constant 1 : index
    %c6 = arith.constant 6 : index
    %c8 = arith.constant 8 : index
    %c32 = arith.constant 32 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4x1x6x8xf32>
    %cast = memref.cast %alloc : memref<4x1x6x8xf32> to memref<?x1x6x8xf32>
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<1x6x8xf32>
    %0 = scf.for %arg3 = %c0 to %c32 step %c8 iter_args(%arg4 = %cast) -> (memref<?x1x6x8xf32>) {
      %1 = affine.apply #map(%arg3)
      %subview = memref.subview %arg2[%arg0, %arg1, %arg3] [1, 6, 8] [1, 1, 1] : memref<8x18x32xf32, strided<[?, ?, ?], offset: ?>> to memref<1x6x8xf32, strided<[?, ?, ?], offset: ?>>
      %2 = scf.for %arg5 = %c0 to %c6 step %c1 iter_args(%arg6 = %alloc_0) -> (memref<1x6x8xf32>) {
        %subview_3 = memref.subview %subview[0, %arg5, 0] [1, 1, 8] [1, 1, 1] : memref<1x6x8xf32, strided<[?, ?, ?], offset: ?>> to memref<1x1x8xf32, strided<[?, ?, ?], offset: ?>>
        %subview_4 = memref.subview %arg6[0, %arg5, 0] [1, 1, 8] [1, 1, 1] : memref<1x6x8xf32> to memref<1x1x8xf32, strided<[48, 8, 1], offset: ?>>
        memref.copy %subview_3, %subview_4 : memref<1x1x8xf32, strided<[?, ?, ?], offset: ?>> to memref<1x1x8xf32, strided<[48, 8, 1], offset: ?>>
        scf.yield %arg6 : memref<1x6x8xf32>
      }
      %subview_2 = memref.subview %arg4[%1, 0, 0, 0] [1, 1, 6, 8] [1, 1, 1, 1] : memref<?x1x6x8xf32> to memref<1x6x8xf32, strided<[48, 8, 1], offset: ?>>
      memref.copy %2, %subview_2 : memref<1x6x8xf32> to memref<1x6x8xf32, strided<[48, 8, 1], offset: ?>>
      scf.yield %arg4 : memref<?x1x6x8xf32>
    }
    %cast_1 = memref.cast %0 : memref<?x1x6x8xf32> to memref<?x1x6x8xf32, strided<[?, ?, ?, ?], offset: ?>>
    return %0 : memref<?x1x6x8xf32>
  }
}

// -----
module {
  func.func @rank_reducing_parallel_insert_slice(%arg0: memref<100xf32, strided<[?], offset: ?>>, %arg1: memref<200x100xf32, strided<[?, ?], offset: ?>>) {
    %c1 = arith.constant 1 : index
    %c100 = arith.constant 100 : index
    scf.forall (%arg2) in (%c100) {
      %subview = memref.subview %arg0[%arg2] [1] [1] : memref<100xf32, strided<[?], offset: ?>> to memref<1xf32, strided<[?], offset: ?>>
      %subview_0 = memref.subview %arg1[1, %arg2] [1, 1] [1, 1] : memref<200x100xf32, strided<[?, ?], offset: ?>> to memref<1xf32, strided<[?], offset: ?>>
      memref.copy %subview, %subview_0 : memref<1xf32, strided<[?], offset: ?>> to memref<1xf32, strided<[?], offset: ?>>
    }
    return
  }
}

// -----
module {
  func.func @parallel_insert_full_slice_in_place(%arg0: memref<2xf32, strided<[?], offset: ?>>) -> memref<2xf32, strided<[?], offset: ?>> {
    %cst = arith.constant 0.000000e+00 : f32
    scf.forall (%arg1) in (1) {
      linalg.fill ins(%cst : f32) outs(%arg0 : memref<2xf32, strided<[?], offset: ?>>)
      %subview = memref.subview %arg0[0] [2] [1] : memref<2xf32, strided<[?], offset: ?>> to memref<2xf32, strided<[?], offset: ?>>
      memref.copy %arg0, %subview : memref<2xf32, strided<[?], offset: ?>> to memref<2xf32, strided<[?], offset: ?>>
    } {mapping = [#gpu.thread<linear_dim_0>]}
    return %arg0 : memref<2xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @insert_equivalent_tensor(%arg0: memref<10xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>> {
    %cst = arith.constant 4.200000e+01 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10xf32>
    linalg.fill ins(%cst : f32) outs(%alloc : memref<10xf32>)
    %subview = memref.subview %arg0[0] [10] [1] : memref<10xf32, strided<[?], offset: ?>> to memref<10xf32, strided<[?], offset: ?>>
    memref.copy %alloc, %subview : memref<10xf32> to memref<10xf32, strided<[?], offset: ?>>
    return %arg0 : memref<10xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @pad_memory_space(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: f32, %arg3: index) -> f32 {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32, 3>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32, 3>
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<15xf32, 3>
    linalg.map outs(%alloc_0 : memref<15xf32, 3>)
      (%init: f32) {
        %1 = linalg.index 0 : index
        linalg.yield %arg2 : f32
      }
    %c0_1 = arith.constant 0 : index
    %dim_2 = memref.dim %alloc, %c0_1 : memref<?xf32, 3>
    %subview = memref.subview %alloc_0[2] [%dim_2] [1] : memref<15xf32, 3> to memref<?xf32, strided<[1], offset: 2>, 3>
    memref.copy %alloc, %subview : memref<?xf32, 3> to memref<?xf32, strided<[1], offset: 2>, 3>
    %0 = memref.load %alloc_0[%arg3] : memref<15xf32, 3>
    return %0 : f32
  }
}

// -----
module {
  func.func @insert_slice_regression(%arg0: memref<10xf32, strided<[?], offset: ?>>, %arg1: memref<5xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>> {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10xf32>
    linalg.fill ins(%cst : f32) outs(%alloc : memref<10xf32>)
    %0 = vector.transfer_read %alloc[%c0], %cst : memref<10xf32>, vector<10xf32>
    vector.print %0 : vector<10xf32>
    %subview = memref.subview %arg0[0] [5] [1] : memref<10xf32, strided<[?], offset: ?>> to memref<5xf32, strided<[?], offset: ?>>
    memref.copy %arg1, %subview : memref<5xf32, strided<[?], offset: ?>> to memref<5xf32, strided<[?], offset: ?>>
    return %arg0 : memref<10xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @insert_slice_full_overwrite(%arg0: memref<10xf32, strided<[?], offset: ?>>, %arg1: memref<10xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>> {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    linalg.fill ins(%cst : f32) outs(%arg0 : memref<10xf32, strided<[?], offset: ?>>)
    %0 = vector.transfer_read %arg0[%c0], %cst : memref<10xf32, strided<[?], offset: ?>>, vector<10xf32>
    vector.print %0 : vector<10xf32>
    %subview = memref.subview %arg0[0] [10] [1] : memref<10xf32, strided<[?], offset: ?>> to memref<10xf32, strided<[?], offset: ?>>
    memref.copy %arg1, %subview : memref<10xf32, strided<[?], offset: ?>> to memref<10xf32, strided<[?], offset: ?>>
    return %arg0 : memref<10xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @dim_not_reading(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: f32, %arg2: index) -> (memref<?xf32, strided<[?], offset: ?>>, index) {
    %c0 = arith.constant 0 : index
    memref.store %arg1, %arg0[%arg2] : memref<?xf32, strided<[?], offset: ?>>
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    return %arg0, %dim : memref<?xf32, strided<[?], offset: ?>>, index
  }
}

// -----
#map = affine_map<(d0) -> (d0 + 5)>
module {
  func.func private @cast_retains_buffer_layout(%arg0: memref<?xf32, #map>, %arg1: index) -> memref<?xf32, strided<[1], offset: 7>> {
    %cast = memref.cast %arg0 : memref<?xf32, #map> to memref<10xf32, #map>
    %subview = memref.subview %cast[2] [%arg1] [1] : memref<10xf32, #map> to memref<?xf32, strided<[1], offset: 7>>
    %cast_0 = memref.cast %cast : memref<10xf32, #map> to memref<10xf32, strided<[?], offset: ?>>
    %cast_1 = memref.cast %subview : memref<?xf32, strided<[1], offset: 7>> to memref<?xf32, strided<[?], offset: ?>>
    return %subview : memref<?xf32, strided<[1], offset: 7>>
  }
}

// -----
module {
  func.func private @cast_retains_buffer_layout_strided(%arg0: memref<?xf32, strided<[1], offset: 5>>, %arg1: index) -> memref<?xf32, strided<[1], offset: 7>> {
    %cast = memref.cast %arg0 : memref<?xf32, strided<[1], offset: 5>> to memref<10xf32, strided<[1], offset: 5>>
    %subview = memref.subview %cast[2] [%arg1] [1] : memref<10xf32, strided<[1], offset: 5>> to memref<?xf32, strided<[1], offset: 7>>
    %cast_0 = memref.cast %cast : memref<10xf32, strided<[1], offset: 5>> to memref<10xf32, strided<[?], offset: ?>>
    %cast_1 = memref.cast %subview : memref<?xf32, strided<[1], offset: 7>> to memref<?xf32, strided<[?], offset: ?>>
    return %subview : memref<?xf32, strided<[1], offset: 7>>
  }
}

// -----
module {
  func.func @parallel_insert_slice_source_out_of_place(%arg0: memref<1xf32, strided<[?], offset: ?>>, %arg1: memref<100xf32, strided<[?], offset: ?>>, %arg2: f32) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c50 = arith.constant 50 : index
    scf.forall (%arg3) in (%c50) {
      %alloc = memref.alloc() {alignment = 64 : i64} : memref<1xf32>
      memref.copy %arg0, %alloc : memref<1xf32, strided<[?], offset: ?>> to memref<1xf32>
      memref.store %arg2, %alloc[%c0] : memref<1xf32>
      %0 = memref.load %arg0[%c0] : memref<1xf32, strided<[?], offset: ?>>
      vector.print %0 : f32
      %subview = memref.subview %arg1[%arg3] [1] [1] : memref<100xf32, strided<[?], offset: ?>> to memref<1xf32, strided<[?], offset: ?>>
      memref.copy %alloc, %subview : memref<1xf32> to memref<1xf32, strided<[?], offset: ?>>
    }
    return
  }
}

// -----
module {
  memref.global "private" constant @__constant_3xi64 : memref<3xi64> = dense<[2, 2, 5]> {alignment = 64 : i64}
  memref.global "private" constant @__constant_2x10xf32 : memref<2x10xf32> = dense<0.000000e+00> {alignment = 64 : i64}
  func.func @tensor.reshape() -> memref<2x2x5xf32> {
    %0 = memref.get_global @__constant_2x10xf32 : memref<2x10xf32>
    %cast = memref.cast %0 : memref<2x10xf32> to memref<?x10xf32>
    %1 = memref.get_global @__constant_3xi64 : memref<3xi64>
    %reshape = memref.reshape %cast(%1) : (memref<?x10xf32>, memref<3xi64>) -> memref<2x2x5xf32>
    %cast_0 = memref.cast %reshape : memref<2x2x5xf32> to memref<2x2x5xf32, strided<[?, ?, ?], offset: ?>>
    return %reshape : memref<2x2x5xf32>
  }
}

// -----
module {
  memref.global "private" constant @__constant_10xf32 : memref<10xf32> = dense<0.000000e+00> {alignment = 64 : i64}
  func.func @tensor_reshape_aliasing(%arg0: index, %arg1: index) -> memref<?x?xf32> {
    %0 = memref.get_global @__constant_10xf32 : memref<10xf32>
    %cast = memref.cast %0 : memref<10xf32> to memref<?xf32>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<2xindex>
    memref.store %arg0, %alloc[%c0] : memref<2xindex>
    memref.store %arg1, %alloc[%c1] : memref<2xindex>
    %reshape = memref.reshape %cast(%alloc) : (memref<?xf32>, memref<2xindex>) -> memref<?x?xf32>
    %cast_0 = memref.cast %reshape : memref<?x?xf32> to memref<?x?xf32, strided<[?, ?], offset: ?>>
    return %reshape : memref<?x?xf32>
  }
}

// -----
module {
  func.func @reshape_with_non_identity_layout(%arg0: memref<2x2xf32, strided<[?, ?], offset: ?>, 3>, %arg1: memref<2xi32, strided<[?], offset: ?>>, %arg2: index) -> f32 {
    %subview = memref.subview %arg0[1, 0] [1, 2] [1, 1] : memref<2x2xf32, strided<[?, ?], offset: ?>, 3> to memref<2xf32, strided<[?], offset: ?>, 3>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<2xf32, 3>
    memref.copy %subview, %alloc : memref<2xf32, strided<[?], offset: ?>, 3> to memref<2xf32, 3>
    %reshape = memref.reshape %alloc(%arg1) : (memref<2xf32, 3>, memref<2xi32, strided<[?], offset: ?>>) -> memref<1x2xf32, 3>
    %0 = memref.load %reshape[%arg2, %arg2] : memref<1x2xf32, 3>
    return %0 : f32
  }
}

// -----
module {
  func.func @collapse_shape_regression(%arg0: memref<10x20xf32, strided<[?, ?], offset: ?>>, %arg1: f32, %arg2: index) {
    %subview = memref.subview %arg0[2, 3] [5, 6] [1, 1] : memref<10x20xf32, strided<[?, ?], offset: ?>> to memref<5x6xf32, strided<[?, ?], offset: ?>>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5x6xf32>
    memref.copy %subview, %alloc : memref<5x6xf32, strided<[?, ?], offset: ?>> to memref<5x6xf32>
    memref.store %arg1, %alloc[%arg2, %arg2] : memref<5x6xf32>
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<5x6xf32>
    memref.copy %subview, %alloc_0 : memref<5x6xf32, strided<[?, ?], offset: ?>> to memref<5x6xf32>
    %collapse_shape = memref.collapse_shape %alloc_0 [[0, 1]] : memref<5x6xf32> into memref<30xf32>
    return
  }
}

// -----
module {
  func.func private @mult_return_callee(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: i1, %arg2: index, %arg3: index) -> index {
    %cast = memref.cast %arg0 : memref<?xf32, strided<[?], offset: ?>> to memref<10xf32, strided<[?], offset: ?>>
    cf.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return %arg2 : index
  ^bb2:  // pred: ^bb0
    return %arg3 : index
  }
  func.func @mult_return(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: i1, %arg2: index, %arg3: index) -> (memref<?xf32, strided<[?], offset: ?>>, index) {
    %0 = call @mult_return_callee(%arg0, %arg1, %arg2, %arg3) : (memref<?xf32, strided<[?], offset: ?>>, i1, index, index) -> index
    %cast = memref.cast %arg0 : memref<?xf32, strided<[?], offset: ?>> to memref<10xf32, strided<[?], offset: ?>>
    return %arg0, %0 : memref<?xf32, strided<[?], offset: ?>>, index
  }
}

