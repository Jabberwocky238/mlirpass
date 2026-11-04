module {
  func.func @buffer_forwarding_conflict(%arg0: memref<?xf32>, %arg1: index) -> (memref<?xf32>, memref<?xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %alloc = memref.alloc(%arg1) {alignment = 64 : i64} : memref<?xf32>
    linalg.fill ins(%cst : f32) outs(%alloc : memref<?xf32>)
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    %alloc_0 = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc_0 : memref<?xf32> to memref<?xf32>
    %subview = memref.subview %alloc_0[0] [%arg1] [1] : memref<?xf32> to memref<?xf32, strided<[1]>>
    memref.copy %alloc, %subview : memref<?xf32> to memref<?xf32, strided<[1]>>
    %subview_1 = memref.subview %arg0[42] [%arg1] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: 42>>
    memref.copy %alloc, %subview_1 : memref<?xf32> to memref<?xf32, strided<[1], offset: 42>>
    return %alloc_0, %arg0 : memref<?xf32>, memref<?xf32>
  }
}

// -----
module {
  func.func @buffer_forwarding_no_conflict(%arg0: memref<?xf32>, %arg1: index) -> memref<?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %subview = memref.subview %arg0[42] [%arg1] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: 42>>
    linalg.fill ins(%cst : f32) outs(%subview : memref<?xf32, strided<[1], offset: 42>>)
    return %arg0 : memref<?xf32>
  }
}

// -----
module {
  func.func @insertion_point_inside_loop(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index) -> memref<?xf32, strided<[?], offset: ?>> {
    %c0 = arith.constant 0 : index
    %c5 = arith.constant 5 : index
    scf.for %arg2 = %c0 to %arg1 step %c5 {
      %subview = memref.subview %arg0[%arg2] [5] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<5xf32, strided<[?], offset: ?>>
      %0 = arith.index_cast %arg2 : index to i32
      %1 = arith.sitofp %0 : i32 to f32
      linalg.fill ins(%1 : f32) outs(%subview : memref<5xf32, strided<[?], offset: ?>>)
    }
    return %arg0 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @insertion_point_outside_loop(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index) -> memref<?xf32, strided<[?], offset: ?>> {
    %c0 = arith.constant 0 : index
    %c5 = arith.constant 5 : index
    scf.for %arg3 = %c0 to %arg1 step %c5 {
      %subview = memref.subview %arg0[%arg2] [5] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<5xf32, strided<[?], offset: ?>>
      %0 = arith.index_cast %arg3 : index to i32
      %1 = arith.sitofp %0 : i32 to f32
      linalg.fill ins(%1 : f32) outs(%subview : memref<5xf32, strided<[?], offset: ?>>)
    }
    return %arg0 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @shape_mismatch(%arg0: memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>) -> memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>> {
    %cst = arith.constant 8.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<128xf32>
    linalg.fill ins(%cst : f32) outs(%alloc : memref<128xf32>)
    %expand_shape = memref.expand_shape %alloc [[0, 1, 2]] output_shape [1, 1, 128] : memref<128xf32> into memref<1x1x128xf32>
    %subview = memref.subview %arg0[2, 3, 0] [1, 1, 128] [1, 1, 1] : memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>> to memref<1x1x128xf32, strided<[?, ?, ?], offset: ?>>
    memref.copy %expand_shape, %subview : memref<1x1x128xf32> to memref<1x1x128xf32, strided<[?, ?, ?], offset: ?>>
    return %arg0 : memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>
  }
}

// -----
module {
  func.func @cast(%arg0: memref<256xf32, strided<[?], offset: ?>>) -> memref<256xf32, strided<[?], offset: ?>> {
    %cst = arith.constant 8.000000e+00 : f32
    %subview = memref.subview %arg0[2] [128] [1] : memref<256xf32, strided<[?], offset: ?>> to memref<128xf32, strided<[?], offset: ?>>
    linalg.fill ins(%cst : f32) outs(%subview : memref<128xf32, strided<[?], offset: ?>>)
    return %arg0 : memref<256xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @parallel_insert_slice(%arg0: memref<?xf32>, %arg1: index) -> memref<?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    scf.forall (%arg2) in (512) {
      %subview = memref.subview %arg0[42] [%arg1] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: 42>>
      linalg.fill ins(%cst : f32) outs(%subview : memref<?xf32, strided<[1], offset: 42>>)
    }
    return %arg0 : memref<?xf32>
  }
}

// -----
module {
  func.func @eleminate_multiple_ops(%arg0: memref<?xf32>, %arg1: index, %arg2: i1) -> memref<?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %0 = scf.if %arg2 -> (memref<?xf32, strided<[1], offset: 42>>) {
      %subview_1 = memref.subview %arg0[42] [%arg1] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: 42>>
      linalg.fill ins(%cst : f32) outs(%subview_1 : memref<?xf32, strided<[1], offset: 42>>)
      scf.yield %subview_1 : memref<?xf32, strided<[1], offset: 42>>
    } else {
      %subview_1 = memref.subview %arg0[42] [%arg1] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: 42>>
      linalg.fill ins(%cst_0 : f32) outs(%subview_1 : memref<?xf32, strided<[1], offset: 42>>)
      scf.yield %subview_1 : memref<?xf32, strided<[1], offset: 42>>
    }
    %subview = memref.subview %arg0[42] [%arg1] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: 42>>
    memref.copy %0, %subview : memref<?xf32, strided<[1], offset: 42>> to memref<?xf32, strided<[1], offset: 42>>
    return %arg0 : memref<?xf32>
  }
}

// -----
module {
  func.func @regression_do_not_eliminate_non_empty(%arg0: memref<10xf32, strided<[?], offset: ?>>, %arg1: memref<10xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>> {
    %subview = memref.subview %arg0[0] [5] [1] : memref<10xf32, strided<[?], offset: ?>> to memref<5xf32, strided<[?], offset: ?>>
    %subview_0 = memref.subview %arg1[1] [5] [1] : memref<10xf32, strided<[?], offset: ?>> to memref<5xf32, strided<[?], offset: ?>>
    memref.copy %subview, %subview_0 : memref<5xf32, strided<[?], offset: ?>> to memref<5xf32, strided<[?], offset: ?>>
    return %arg1 : memref<10xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @regression_insert_of_bbarg(%arg0: memref<5xf32, strided<[?], offset: ?>>, %arg1: memref<10xf32, strided<[?], offset: ?>>) -> memref<10xf32, strided<[?], offset: ?>> {
    %subview = memref.subview %arg1[2] [5] [1] : memref<10xf32, strided<[?], offset: ?>> to memref<5xf32, strided<[?], offset: ?>>
    memref.copy %arg0, %subview : memref<5xf32, strided<[?], offset: ?>> to memref<5xf32, strided<[?], offset: ?>>
    return %arg1 : memref<10xf32, strided<[?], offset: ?>>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @regression_eliminate_equivalent_only(%arg0: index, %arg1: index, %arg2: memref<?x16xi8, strided<[?, ?], offset: ?>>) -> memref<?x16xi8, strided<[?, ?], offset: ?>> {
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %c16 = arith.constant 16 : index
    %alloc = memref.alloc(%arg0) {alignment = 64 : i64} : memref<?x8xi32>
    %subview = memref.subview %alloc[0, 0] [%arg1, 8] [1, 1] : memref<?x8xi32> to memref<?x8xi32, strided<[8, 1]>>
    scf.for %arg3 = %c0 to %c16 step %c8 {
      %subview_0 = memref.subview %alloc[0, 0] [%arg0, 8] [1, 1] : memref<?x8xi32> to memref<?x8xi32, strided<[8, 1]>>
      memref.copy %subview, %subview_0 : memref<?x8xi32, strided<[8, 1]>> to memref<?x8xi32, strided<[8, 1]>>
      %alloc_1 = memref.alloc(%arg0) {alignment = 64 : i64} : memref<?x8xi8>
      linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%alloc : memref<?x8xi32>) outs(%alloc_1 : memref<?x8xi8>) {
      ^bb0(%in: i32, %out: i8):
        %0 = arith.trunci %in : i32 to i8
        linalg.yield %0 : i8
      }
      %subview_2 = memref.subview %arg2[%arg1, %arg3] [%arg0, 8] [1, 1] : memref<?x16xi8, strided<[?, ?], offset: ?>> to memref<?x8xi8, strided<[?, ?], offset: ?>>
      memref.copy %alloc_1, %subview_2 : memref<?x8xi8> to memref<?x8xi8, strided<[?, ?], offset: ?>>
    }
    return %arg2 : memref<?x16xi8, strided<[?, ?], offset: ?>>
  }
}

// -----
module {
  func.func @regression_multiple_insertion_points(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>) -> memref<?x?xf32, strided<[?, ?], offset: ?>> {
    %cst = arith.constant 5.500000e+00 : f32
    %0 = "test.foo"() : () -> index
    %1 = "test.bar"() : () -> index
    %subview = memref.subview %arg0[%0, %1] [2, 5] [1, 1] : memref<?x?xf32, strided<[?, ?], offset: ?>> to memref<2x5xf32, strided<[?, ?], offset: ?>>
    linalg.fill ins(%cst : f32) outs(%subview : memref<2x5xf32, strided<[?, ?], offset: ?>>)
    return %arg0 : memref<?x?xf32, strided<[?, ?], offset: ?>>
  }
}

// -----
module {
  func.func @materialize_in_destination(%arg0: memref<5xf32, strided<[?], offset: ?>>, %arg1: f32) -> memref<5xf32, strided<[?], offset: ?>> {
    linalg.fill ins(%arg1 : f32) outs(%arg0 : memref<5xf32, strided<[?], offset: ?>>)
    return %arg0 : memref<5xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @materialize_in_destination_buffer(%arg0: memref<5xf32>, %arg1: f32) {
    linalg.fill ins(%arg1 : f32) outs(%arg0 : memref<5xf32>)
    return
  }
}

// -----
module {
  func.func @linalg_copy(%arg0: memref<5xf32, strided<[?], offset: ?>>, %arg1: f32) -> memref<5xf32, strided<[?], offset: ?>> {
    linalg.fill ins(%arg1 : f32) outs(%arg0 : memref<5xf32, strided<[?], offset: ?>>)
    return %arg0 : memref<5xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @linalg_copy_empty() -> memref<26xi32> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<26xi32>
    return %alloc : memref<26xi32>
  }
}

// -----
module {
  func.func @multiple_materialize_in_destination_buffer(%arg0: memref<5xf32>, %arg1: f32, %arg2: f32, %arg3: i1) {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    linalg.fill ins(%arg1 : f32) outs(%alloc : memref<5xf32>)
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    linalg.fill ins(%arg2 : f32) outs(%alloc_0 : memref<5xf32>)
    %0 = arith.select %arg3, %alloc, %alloc_0 : memref<5xf32>
    memref.copy %0, %arg0 : memref<5xf32> to memref<5xf32>
    return
  }
}

// -----
module {
  func.func @eliminate_all_empty_tensors() -> memref<5x6x128xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5x6x128xf32>
    %subview = memref.subview %alloc[0, 0, 0] [5, 6, 64] [1, 1, 1] : memref<5x6x128xf32> to memref<5x6x64xf32, strided<[768, 128, 1]>>
    linalg.fill ins(%cst : f32) outs(%subview : memref<5x6x64xf32, strided<[768, 128, 1]>>)
    %subview_1 = memref.subview %alloc[0, 0, 64] [5, 6, 64] [1, 1, 1] : memref<5x6x128xf32> to memref<5x6x64xf32, strided<[768, 128, 1], offset: 64>>
    linalg.fill ins(%cst_0 : f32) outs(%subview_1 : memref<5x6x64xf32, strided<[768, 128, 1], offset: 64>>)
    return %alloc : memref<5x6x128xf32>
  }
}

// -----
module {
  func.func @eliminate_concatenated_empty_tensors() -> memref<5x6x128xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5x6x128xf32>
    %subview = memref.subview %alloc[0, 0, 0] [5, 6, 64] [1, 1, 1] : memref<5x6x128xf32> to memref<5x6x64xf32, strided<[768, 128, 1]>>
    linalg.fill ins(%cst : f32) outs(%subview : memref<5x6x64xf32, strided<[768, 128, 1]>>)
    %subview_1 = memref.subview %alloc[0, 0, 64] [5, 6, 64] [1, 1, 1] : memref<5x6x128xf32> to memref<5x6x64xf32, strided<[768, 128, 1], offset: 64>>
    linalg.fill ins(%cst_0 : f32) outs(%subview_1 : memref<5x6x64xf32, strided<[768, 128, 1], offset: 64>>)
    return %alloc : memref<5x6x128xf32>
  }
}

// -----
module {
  func.func @multi_use_of_the_same_tensor_empty() -> memref<5x6x128xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5x6x128xf32>
    %subview = memref.subview %alloc[0, 0, 0] [5, 6, 64] [1, 1, 1] : memref<5x6x128xf32> to memref<5x6x64xf32, strided<[768, 128, 1]>>
    linalg.fill ins(%cst : f32) outs(%subview : memref<5x6x64xf32, strided<[768, 128, 1]>>)
    %subview_1 = memref.subview %alloc[0, 0, 64] [5, 6, 64] [1, 1, 1] : memref<5x6x128xf32> to memref<5x6x64xf32, strided<[768, 128, 1], offset: 64>>
    linalg.fill ins(%cst_0 : f32) outs(%subview_1 : memref<5x6x64xf32, strided<[768, 128, 1], offset: 64>>)
    return %alloc : memref<5x6x128xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  func.func @multi_use_of_the_same_tensor_empty_creates_non_existent_read(%arg0: memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>, %arg1: memref<5x6x64xf32, strided<[?, ?, ?], offset: ?>>) -> (memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>, memref<5x6x64xf32, strided<[?, ?, ?], offset: ?>>) {
    %cst = arith.constant 1.000000e+00 : f32
    %subview = memref.subview %arg0[0, 0, 0] [5, 6, 64] [1, 1, 1] : memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>> to memref<5x6x64xf32, strided<[?, ?, ?], offset: ?>>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5x6x64xf32>
    linalg.fill ins(%cst : f32) outs(%subview : memref<5x6x64xf32, strided<[?, ?, ?], offset: ?>>)
    linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%alloc : memref<5x6x64xf32>) outs(%arg1 : memref<5x6x64xf32, strided<[?, ?, ?], offset: ?>>) {
    ^bb0(%in: f32, %out: f32):
      %0 = arith.addf %in, %in : f32
      linalg.yield %0 : f32
    }
    return %arg0, %arg1 : memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>, memref<5x6x64xf32, strided<[?, ?, ?], offset: ?>>
  }
}

// -----
module {
  func.func @direct_use_of_tensor_empty(%arg0: memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>) -> memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>> {
    return %arg0 : memref<5x6x128xf32, strided<[?, ?, ?], offset: ?>>
  }
}

// -----
module {
  func.func @move_dependent_arith_op(%arg0: memref<10xf32>, %arg1: index, %arg2: f32) -> memref<10xf32> {
    %c5 = arith.constant 5 : index
    %0 = arith.addi %arg1, %c5 : index
    %subview = memref.subview %arg0[%0] [5] [1] : memref<10xf32> to memref<5xf32, strided<[1], offset: ?>>
    linalg.fill ins(%arg2 : f32) outs(%subview : memref<5xf32, strided<[1], offset: ?>>)
    return %arg0 : memref<10xf32>
  }
}

// -----
module {
  func.func @side_effecting_op_blocks_movement(%arg0: memref<10xf32>, %arg1: memref<index>, %arg2: f32) -> memref<10xf32> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    linalg.fill ins(%arg2 : f32) outs(%alloc : memref<5xf32>)
    %0 = memref.load %arg1[] : memref<index>
    %subview = memref.subview %arg0[%0] [5] [1] : memref<10xf32> to memref<5xf32, strided<[1], offset: ?>>
    memref.copy %alloc, %subview : memref<5xf32> to memref<5xf32, strided<[1], offset: ?>>
    return %arg0 : memref<10xf32>
  }
}

