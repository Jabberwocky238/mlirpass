module {
  func.func private @scf_for_yield_only(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: index, %arg3: index, %arg4: index) -> memref<?xf32> {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    return %alloc : memref<?xf32>
  }
}

// -----
module {
  func.func @scf_for_is_reading(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: index, %arg3: index) -> (f32, f32) {
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %0 = scf.for %arg4 = %arg2 to %arg3 step %c1 iter_args(%arg5 = %alloc) -> (memref<?xf32>) {
      linalg.fill ins(%cst : f32) outs(%arg5 : memref<?xf32>)
      %dim_0 = memref.dim %arg1, %c0 : memref<?xf32, strided<[?], offset: ?>>
      %alloc_1 = memref.alloc(%dim_0) {alignment = 64 : i64} : memref<?xf32>
      memref.copy %arg1, %alloc_1 : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
      scf.yield %alloc_1 : memref<?xf32>
    }
    %1 = memref.load %0[%c1] : memref<?xf32>
    %2 = memref.load %arg0[%c1] : memref<?xf32, strided<[?], offset: ?>>
    return %1, %2 : f32, f32
  }
}

// -----
module {
  func.func @nested_scf_for(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: vector<5xf32>) -> memref<?xf32, strided<[?], offset: ?>> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c10 = arith.constant 10 : index
    scf.for %arg2 = %c0 to %c10 step %c1 {
      scf.for %arg3 = %c0 to %c10 step %c1 {
        vector.transfer_write %arg1, %arg0[%c0] : vector<5xf32>, memref<?xf32, strided<[?], offset: ?>>
      }
    }
    return %arg0 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func private @scf_for_with_tensor.insert_slice(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: memref<4xf32, strided<[?], offset: ?>>, %arg3: index, %arg4: index, %arg5: index) -> memref<?xf32> {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    scf.for %arg6 = %arg3 to %arg4 step %arg5 {
      %subview = memref.subview %alloc[0] [4] [1] : memref<?xf32> to memref<4xf32, strided<[1]>>
      memref.copy %arg2, %subview : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[1]>>
      %subview_0 = memref.subview %arg1[0] [4] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
      memref.copy %arg2, %subview_0 : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
    }
    return %alloc : memref<?xf32>
  }
}

// -----
module {
  func.func @execute_region_with_conflict(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> (f32, memref<?xf32>, f32) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c7 = arith.constant 7 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    memref.store %cst, %alloc[%c7] : memref<?xf32>
    %0 = memref.load %arg0[%c7] : memref<?xf32, strided<[?], offset: ?>>
    return %cst, %alloc, %0 : f32, memref<?xf32>, f32
  }
}

// -----
module {
  func.func @scf_if_inplace(%arg0: i1, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: vector<5xf32>, %arg3: index) -> memref<?xf32, strided<[?], offset: ?>> {
    scf.if %arg0 {
    } else {
      vector.transfer_write %arg2, %arg1[%arg3] : vector<5xf32>, memref<?xf32, strided<[?], offset: ?>>
    }
    return %arg1 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @scf_if_inside_scf_for(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: vector<5xf32>, %arg2: index, %arg3: i1) -> memref<?xf32, strided<[?], offset: ?>> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c10 = arith.constant 10 : index
    scf.for %arg4 = %c0 to %c10 step %c1 {
      scf.if %arg3 {
      } else {
        vector.transfer_write %arg1, %arg0[%arg2] : vector<5xf32>, memref<?xf32, strided<[?], offset: ?>>
      }
    }
    return %arg0 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @scf_if_non_equiv_yields(%arg0: i1, %arg1: memref<4xf32, strided<[?], offset: ?>>, %arg2: memref<4xf32, strided<[?], offset: ?>>) -> memref<4xf32, strided<[?], offset: ?>> {
    %0 = arith.select %arg0, %arg1, %arg2 : memref<4xf32, strided<[?], offset: ?>>
    return %0 : memref<4xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @scf_execute_region_yield_non_equivalent(%arg0: index, %arg1: index) -> f32 {
    %alloc = memref.alloc(%arg0) {alignment = 64 : i64} : memref<?xf32>
    %0 = memref.load %alloc[%arg1] : memref<?xf32>
    return %0 : f32
  }
}

// -----
module {
  func.func @scf_for_yield_non_equivalent(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index) -> memref<?xf32> {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %0 = scf.for %arg4 = %arg1 to %arg2 step %arg3 iter_args(%arg5 = %alloc) -> (memref<?xf32>) {
      %alloc_0 = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
      memref.copy %arg0, %alloc_0 : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
      scf.yield %alloc_0 : memref<?xf32>
    }
    return %0 : memref<?xf32>
  }
}

// -----
module {
  func.func @scf_for_yield_allocation(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index) -> memref<?xf32, strided<[?], offset: ?>> {
    %0 = scf.for %arg4 = %arg1 to %arg2 step %arg3 iter_args(%arg5 = %arg0) -> (memref<?xf32, strided<[?], offset: ?>>) {
      %alloc = memref.alloc(%arg4) {alignment = 64 : i64} : memref<?xf32>
      %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
      scf.yield %cast : memref<?xf32, strided<[?], offset: ?>>
    }
    return %0 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @scf_for_swapping_yields(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: memref<4xf32, strided<[?], offset: ?>>, %arg3: index, %arg4: index, %arg5: index) -> (f32, f32) {
    %c0 = arith.constant 0 : index
    %0:2 = scf.for %arg6 = %arg3 to %arg4 step %arg5 iter_args(%arg7 = %arg0, %arg8 = %arg1) -> (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) {
      %subview = memref.subview %arg7[0] [4] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
      memref.copy %arg2, %subview : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
      %subview_0 = memref.subview %arg8[0] [4] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
      memref.copy %arg2, %subview_0 : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
      %dim = memref.dim %arg8, %c0 : memref<?xf32, strided<[?], offset: ?>>
      %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
      memref.copy %arg8, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
      %dim_1 = memref.dim %arg7, %c0 : memref<?xf32, strided<[?], offset: ?>>
      %alloc_2 = memref.alloc(%dim_1) {alignment = 64 : i64} : memref<?xf32>
      memref.copy %arg7, %alloc_2 : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
      %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
      %cast_3 = memref.cast %alloc_2 : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
      scf.yield %cast, %cast_3 : memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>
    }
    %1 = memref.load %0#0[%arg5] : memref<?xf32, strided<[?], offset: ?>>
    %2 = memref.load %0#1[%arg5] : memref<?xf32, strided<[?], offset: ?>>
    return %1, %2 : f32, f32
  }
}

// -----
module {
  func.func @scf_while(%arg0: memref<?xi1, strided<[?], offset: ?>>, %arg1: index) -> memref<?xi1, strided<[?], offset: ?>> {
    scf.while : () -> () {
      %0 = memref.load %arg0[%arg1] : memref<?xi1, strided<[?], offset: ?>>
      scf.condition(%0)
    } do {
      %0 = "dummy.some_op"() : () -> index
      %1 = "dummy.another_op"() : () -> i1
      memref.store %1, %arg0[%0] : memref<?xi1, strided<[?], offset: ?>>
      scf.yield
    }
    return %arg0 : memref<?xi1, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @scf_while_non_equiv_condition(%arg0: memref<5xi1, strided<[?], offset: ?>>, %arg1: memref<5xi1, strided<[?], offset: ?>>, %arg2: index) -> (memref<5xi1>, memref<5xi1>) {
    %0:2 = scf.while (%arg3 = %arg0, %arg4 = %arg1) : (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1, strided<[?], offset: ?>>) -> (memref<5xi1>, memref<5xi1>) {
      %1 = memref.load %arg3[%arg2] : memref<5xi1, strided<[?], offset: ?>>
      %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xi1>
      memref.copy %arg4, %alloc : memref<5xi1, strided<[?], offset: ?>> to memref<5xi1>
      %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<5xi1>
      memref.copy %arg3, %alloc_0 : memref<5xi1, strided<[?], offset: ?>> to memref<5xi1>
      scf.condition(%1) %alloc, %alloc_0 : memref<5xi1>, memref<5xi1>
    } do {
    ^bb0(%arg3: memref<5xi1>, %arg4: memref<5xi1>):
      %1 = "dummy.some_op"() : () -> index
      %2 = "dummy.another_op"() : () -> i1
      memref.store %2, %arg3[%1] : memref<5xi1>
      %cast = memref.cast %arg3 : memref<5xi1> to memref<5xi1, strided<[?], offset: ?>>
      %cast_0 = memref.cast %arg4 : memref<5xi1> to memref<5xi1, strided<[?], offset: ?>>
      scf.yield %cast, %cast_0 : memref<5xi1, strided<[?], offset: ?>>, memref<5xi1, strided<[?], offset: ?>>
    }
    return %0#0, %0#1 : memref<5xi1>, memref<5xi1>
  }
}

// -----
module {
  func.func @scf_while_non_equiv_condition_and_body(%arg0: memref<5xi1, strided<[?], offset: ?>>, %arg1: memref<5xi1, strided<[?], offset: ?>>, %arg2: index) -> (memref<5xi1>, memref<5xi1>) {
    %0:2 = scf.while (%arg3 = %arg0, %arg4 = %arg1) : (memref<5xi1, strided<[?], offset: ?>>, memref<5xi1, strided<[?], offset: ?>>) -> (memref<5xi1>, memref<5xi1>) {
      %1 = memref.load %arg3[%arg2] : memref<5xi1, strided<[?], offset: ?>>
      %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xi1>
      memref.copy %arg4, %alloc : memref<5xi1, strided<[?], offset: ?>> to memref<5xi1>
      %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<5xi1>
      memref.copy %arg3, %alloc_0 : memref<5xi1, strided<[?], offset: ?>> to memref<5xi1>
      scf.condition(%1) %alloc, %alloc_0 : memref<5xi1>, memref<5xi1>
    } do {
    ^bb0(%arg3: memref<5xi1>, %arg4: memref<5xi1>):
      %1 = "dummy.some_op"() : () -> index
      %2 = "dummy.another_op"() : () -> i1
      memref.store %2, %arg3[%1] : memref<5xi1>
      %cast = memref.cast %arg4 : memref<5xi1> to memref<5xi1, strided<[?], offset: ?>>
      %cast_0 = memref.cast %arg3 : memref<5xi1> to memref<5xi1, strided<[?], offset: ?>>
      scf.yield %cast, %cast_0 : memref<5xi1, strided<[?], offset: ?>>, memref<5xi1, strided<[?], offset: ?>>
    }
    return %0#0, %0#1 : memref<5xi1>, memref<5xi1>
  }
}

// -----
module {
  func.func @scf_while_iter_arg_result_mismatch(%arg0: memref<5xi1, strided<[?], offset: ?>>, %arg1: memref<5xi1, strided<[?], offset: ?>>, %arg2: index) {
    scf.while (%arg3 = %arg1) : (memref<5xi1, strided<[?], offset: ?>>) -> () {
      %0 = memref.load %arg0[%arg2] : memref<5xi1, strided<[?], offset: ?>>
      %1 = memref.load %arg3[%arg2] : memref<5xi1, strided<[?], offset: ?>>
      "dummy.use"(%1) : (i1) -> ()
      scf.condition(%0)
    } do {
      %0 = "dummy.some_op"() : () -> index
      %1 = "dummy.another_op"() : () -> i1
      %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xi1>
      memref.copy %arg0, %alloc : memref<5xi1, strided<[?], offset: ?>> to memref<5xi1>
      memref.store %1, %alloc[%0] : memref<5xi1>
      %cast = memref.cast %alloc : memref<5xi1> to memref<5xi1, strided<[?], offset: ?>>
      scf.yield %cast : memref<5xi1, strided<[?], offset: ?>>
    }
    return
  }
}

// -----
module {
  func.func private @parallel_insert_slice_no_conflict(%arg0: index, %arg1: index, %arg2: memref<?xf32, strided<[?], offset: ?>>, %arg3: memref<?xf32, strided<[?], offset: ?>>) -> f32 {
    %cst = arith.constant 4.200000e+01 : f32
    %c0 = arith.constant 0 : index
    scf.forall (%arg4) in (%arg1) {
      %subview = memref.subview %arg3[5] [%arg0] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32, strided<[?], offset: ?>>
      linalg.fill ins(%cst : f32) outs(%subview : memref<?xf32, strided<[?], offset: ?>>)
    } {keep_this_attribute}
    %0 = memref.load %arg3[%c0] : memref<?xf32, strided<[?], offset: ?>>
    return %0 : f32
  }
}

// -----
module {
  func.func @parallel_insert_slice_with_conflict(%arg0: index, %arg1: index, %arg2: memref<?xf32, strided<[?], offset: ?>>, %arg3: memref<?xf32, strided<[?], offset: ?>>) -> (f32, f32) {
    %cst = arith.constant 4.200000e+01 : f32
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg3, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg3, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    scf.forall (%arg4) in (%arg1) {
      %subview = memref.subview %alloc[5] [%arg0] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: 5>>
      linalg.fill ins(%cst : f32) outs(%subview : memref<?xf32, strided<[1], offset: 5>>)
    }
    %0 = memref.load %arg3[%c0] : memref<?xf32, strided<[?], offset: ?>>
    %1 = memref.load %alloc[%c0] : memref<?xf32>
    return %1, %0 : f32, f32
  }
}

// -----
#map = affine_map<(d0) -> (d0 * 4)>
#map1 = affine_map<(d0) -> (d0 * 2)>
module {
  func.func @matmul(%arg0: memref<8x8xf32, strided<[?, ?], offset: ?>>, %arg1: memref<8x8xf32, strided<[?, ?], offset: ?>>, %arg2: memref<8x8xf32, strided<[?, ?], offset: ?>>) -> memref<8x8xf32, strided<[?, ?], offset: ?>> {
    scf.forall (%arg3, %arg4) in (2, 4) {
      %0 = affine.apply #map(%arg3)
      %subview = memref.subview %arg0[%0, 0] [4, 8] [1, 1] : memref<8x8xf32, strided<[?, ?], offset: ?>> to memref<4x8xf32, strided<[?, ?], offset: ?>>
      %1 = affine.apply #map1(%arg4)
      %subview_0 = memref.subview %arg1[0, %1] [8, 4] [1, 1] : memref<8x8xf32, strided<[?, ?], offset: ?>> to memref<8x4xf32, strided<[?, ?], offset: ?>>
      %subview_1 = memref.subview %arg2[%0, %1] [4, 4] [1, 1] : memref<8x8xf32, strided<[?, ?], offset: ?>> to memref<4x4xf32, strided<[?, ?], offset: ?>>
      linalg.matmul ins(%subview, %subview_0 : memref<4x8xf32, strided<[?, ?], offset: ?>>, memref<8x4xf32, strided<[?, ?], offset: ?>>) outs(%subview_1 : memref<4x4xf32, strided<[?, ?], offset: ?>>)
    }
    return %arg2 : memref<8x8xf32, strided<[?, ?], offset: ?>>
  }
}

// -----
module {
  func.func @scf_foreach_private_var(%arg0: memref<10xf32, strided<[?], offset: ?>>) -> f32 {
    %c2 = arith.constant 2 : index
    %c5 = arith.constant 5 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10xf32>
    memref.copy %arg0, %alloc : memref<10xf32, strided<[?], offset: ?>> to memref<10xf32>
    scf.forall (%arg1) in (2) {
      %1 = arith.muli %arg1, %c5 : index
      %subview = memref.subview %alloc[%1] [5] [1] : memref<10xf32> to memref<5xf32, strided<[1], offset: ?>>
      %2 = memref.load %arg0[%arg1] : memref<10xf32, strided<[?], offset: ?>>
      memref.store %2, %subview[%c2] : memref<5xf32, strided<[1], offset: ?>>
    }
    %0 = memref.load %alloc[%c2] : memref<10xf32>
    return %0 : f32
  }
}

// -----
module {
  func.func @scf_foreach_privatized_but_not_copied(%arg0: memref<10xf32, strided<[?], offset: ?>>, %arg1: memref<10xf32, strided<[?], offset: ?>>) -> f32 {
    %c2 = arith.constant 2 : index
    %c5 = arith.constant 5 : index
    scf.forall (%arg2) in (2) {
      %1 = arith.muli %arg2, %c5 : index
      %subview = memref.subview %arg0[%1] [5] [1] : memref<10xf32, strided<[?], offset: ?>> to memref<5xf32, strided<[?], offset: ?>>
      %2 = memref.load %arg1[%arg2] : memref<10xf32, strided<[?], offset: ?>>
      memref.store %2, %subview[%c2] : memref<5xf32, strided<[?], offset: ?>>
    }
    %0 = memref.load %arg0[%c2] : memref<10xf32, strided<[?], offset: ?>>
    return %0 : f32
  }
}

// -----
module {
  func.func @scf_if_memory_space(%arg0: i1, %arg1: f32, %arg2: f32) -> (f32, f32) {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32, 1>
    linalg.fill ins(%arg2 : f32) outs(%alloc : memref<5xf32, 1>)
    %0 = scf.if %arg0 -> (memref<5xf32, 1>) {
      scf.yield %alloc : memref<5xf32, 1>
    } else {
      %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<5xf32, 1>
      memref.copy %alloc, %alloc_0 : memref<5xf32, 1> to memref<5xf32, 1>
      memref.store %arg1, %alloc_0[%c0] : memref<5xf32, 1>
      scf.yield %alloc_0 : memref<5xf32, 1>
    }
    %1 = memref.load %alloc[%c0] : memref<5xf32, 1>
    %2 = memref.load %0[%c0] : memref<5xf32, 1>
    return %1, %2 : f32, f32
  }
}

// -----
module {
  func.func @scf_execute_region_memory_space(%arg0: f32) -> f32 {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32, 1>
    memref.store %arg0, %alloc[%c0] : memref<5xf32, 1>
    %0 = memref.load %alloc[%c0] : memref<5xf32, 1>
    return %0 : f32
  }
}

// -----
module {
  func.func @scf_for_swapping_yields_memory_space(%arg0: index, %arg1: memref<4xf32, strided<[?], offset: ?>>, %arg2: index, %arg3: index, %arg4: index) -> (f32, f32) {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc(%arg0) {alignment = 64 : i64} : memref<?xf32, 1>
    %alloc_0 = memref.alloc(%arg0) {alignment = 64 : i64} : memref<?xf32, 1>
    %0:2 = scf.for %arg5 = %arg2 to %arg3 step %arg4 iter_args(%arg6 = %alloc, %arg7 = %alloc_0) -> (memref<?xf32, 1>, memref<?xf32, 1>) {
      %subview = memref.subview %arg6[0] [4] [1] : memref<?xf32, 1> to memref<4xf32, strided<[1]>, 1>
      memref.copy %arg1, %subview : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[1]>, 1>
      %subview_1 = memref.subview %arg7[0] [4] [1] : memref<?xf32, 1> to memref<4xf32, strided<[1]>, 1>
      memref.copy %arg1, %subview_1 : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[1]>, 1>
      %dim = memref.dim %arg7, %c0 : memref<?xf32, 1>
      %alloc_2 = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32, 1>
      memref.copy %arg7, %alloc_2 : memref<?xf32, 1> to memref<?xf32, 1>
      %dim_3 = memref.dim %arg6, %c0 : memref<?xf32, 1>
      %alloc_4 = memref.alloc(%dim_3) {alignment = 64 : i64} : memref<?xf32, 1>
      memref.copy %arg6, %alloc_4 : memref<?xf32, 1> to memref<?xf32, 1>
      scf.yield %alloc_2, %alloc_4 : memref<?xf32, 1>, memref<?xf32, 1>
    }
    %1 = memref.load %0#0[%arg4] : memref<?xf32, 1>
    %2 = memref.load %0#1[%arg4] : memref<?xf32, 1>
    return %1, %2 : f32, f32
  }
}

// -----
module {
  func.func @scf_for_yield_alias_of_non_equivalent(%arg0: index) -> memref<?xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 5.000000e+00 : f32
    %alloc = memref.alloc(%arg0) {alignment = 64 : i64} : memref<?xf32>
    linalg.map outs(%alloc : memref<?xf32>)
      (%init: f32) {
        linalg.yield %cst : f32
      }
    %alloc_0 = memref.alloc(%arg0) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %alloc, %alloc_0 : memref<?xf32> to memref<?xf32>
    scf.for %arg1 = %c0 to %arg0 step %c1 {
      %0 = arith.subi %arg1, %c1 : index
      %subview = memref.subview %alloc[%0] [%arg0] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: ?>>
      %1 = memref.load %subview[%c0] : memref<?xf32, strided<[1], offset: ?>>
      %2 = arith.mulf %1, %cst : f32
      memref.store %2, %alloc_0[%arg1] : memref<?xf32>
    }
    return %alloc_0 : memref<?xf32>
  }
}

// -----
module {
  func.func @scf_for_buffer_type_mismatch(%arg0: index, %arg1: index) -> f32 {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c10 = arith.constant 10 : index
    %alloc = memref.alloc(%arg0) {alignment = 64 : i64} : memref<?xf32>
    %subview = memref.subview %alloc[1] [%arg1] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: 1>>
    %cast = memref.cast %subview : memref<?xf32, strided<[1], offset: 1>> to memref<?xf32, strided<[?], offset: ?>>
    %0 = scf.for %arg2 = %c0 to %c10 step %c1 iter_args(%arg3 = %cast) -> (memref<?xf32, strided<[?], offset: ?>>) {
      %2 = "test.dummy"() : () -> index
      %subview_0 = memref.subview %arg3[1] [%2] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32, strided<[?], offset: ?>>
      scf.yield %subview_0 : memref<?xf32, strided<[?], offset: ?>>
    }
    %1 = memref.load %0[%c1] : memref<?xf32, strided<[?], offset: ?>>
    return %1 : f32
  }
}

// -----
module {
  func.func @scf_while_buffer_type_mismatch(%arg0: index, %arg1: index) -> f32 {
    %c1 = arith.constant 1 : index
    %cst = arith.constant 5.500000e+00 : f32
    %alloc = memref.alloc(%arg0) {alignment = 64 : i64} : memref<?xf32>
    %subview = memref.subview %alloc[1] [%arg1] [1] : memref<?xf32> to memref<?xf32, strided<[1], offset: 1>>
    %cast = memref.cast %subview : memref<?xf32, strided<[1], offset: 1>> to memref<?xf32, strided<[?], offset: ?>>
    %0 = scf.while (%arg2 = %cast) : (memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32> {
      %2 = "test.condition"() : () -> i1
      %3 = "test.dummy"() : () -> index
      %subview_0 = memref.subview %arg2[1] [%3] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32, strided<[?], offset: ?>>
      %alloc_1 = memref.alloc(%3) {alignment = 64 : i64} : memref<?xf32>
      memref.copy %subview_0, %alloc_1 : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
      scf.condition(%2) %alloc_1 : memref<?xf32>
    } do {
    ^bb0(%arg2: memref<?xf32>):
      %2 = "test.dummy"() : () -> index
      memref.store %cst, %arg2[%2] : memref<?xf32>
      %cast_0 = memref.cast %arg2 : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
      scf.yield %cast_0 : memref<?xf32, strided<[?], offset: ?>>
    }
    %1 = memref.load %0[%c1] : memref<?xf32>
    return %1 : f32
  }
}

// -----
module {
  func.func @non_tensor_for_arg(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 2.000000e+00 : f32
    %c10 = arith.constant 10 : index
    scf.for %arg1 = %c0 to %c10 step %c1 {
      memref.store %cst, %arg0[%c1] : memref<?xf32, strided<[?], offset: ?>>
    }
    return %arg0 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @buffer_type_of_collapse_shape(%arg0: memref<f64, strided<[], offset: ?>>) {
    %true = arith.constant true
    scf.while (%arg1 = %arg0) : (memref<f64, strided<[], offset: ?>>) -> () {
      %alloc = memref.alloc() {alignment = 64 : i64} : memref<f64>
      memref.copy %arg1, %alloc : memref<f64, strided<[], offset: ?>> to memref<f64>
      scf.condition(%true)
    } do {
      %alloc = memref.alloc() {alignment = 64 : i64} : memref<1xf64>
      %collapse_shape = memref.collapse_shape %alloc [] : memref<1xf64> into memref<f64>
      %cast = memref.cast %collapse_shape : memref<f64> to memref<f64, strided<[], offset: ?>>
      scf.yield %cast : memref<f64, strided<[], offset: ?>>
    }
    return
  }
}

// -----
module {
  func.func @non_block_argument_yield() {
    %true = arith.constant true
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<i32>
    scf.while (%arg0 = %alloc) : (memref<i32>) -> () {
      %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<i32>
      memref.copy %arg0, %alloc_0 : memref<i32> to memref<i32>
      scf.condition(%true)
    } do {
      %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<i32>
      %0 = scf.while (%arg0 = %alloc_0) : (memref<i32>) -> memref<i32> {
        %alloc_1 = memref.alloc() {alignment = 64 : i64} : memref<i32>
        memref.copy %arg0, %alloc_1 : memref<i32> to memref<i32>
        scf.condition(%true) %alloc_1 : memref<i32>
      } do {
      ^bb0(%arg0: memref<i32>):
        scf.yield %alloc : memref<i32>
      }
      scf.yield %0 : memref<i32>
    }
    return
  }
}

// -----
module {
  func.func @regression_cast_in_loop() -> memref<2xindex> {
    %false = arith.constant false
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<2xindex>
    %0 = scf.while (%arg0 = %alloc) : (memref<2xindex>) -> memref<2xindex> {
      %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<2xindex>
      memref.copy %arg0, %alloc_0 : memref<2xindex> to memref<2xindex>
      scf.condition(%false) %alloc_0 : memref<2xindex>
    } do {
    ^bb0(%arg0: memref<2xindex>):
      %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<2xindex>
      memref.store %c0, %alloc_0[%c0] : memref<2xindex>
      scf.yield %alloc_0 : memref<2xindex>
    }
    return %0 : memref<2xindex>
  }
}

// -----
module {
  func.func @elide_copy_of_non_writing_scf_if(%arg0: i1, %arg1: index, %arg2: index, %arg3: f32) -> (memref<10xf32>, f32) {
    %0 = scf.if %arg0 -> (memref<10xf32>) {
      %alloc = memref.alloc() {alignment = 64 : i64} : memref<10xf32>
      scf.yield %alloc : memref<10xf32>
    } else {
      %alloc = memref.alloc() {alignment = 64 : i64} : memref<10xf32>
      scf.yield %alloc : memref<10xf32>
    }
    memref.store %arg3, %0[%arg1] : memref<10xf32>
    %1 = memref.load %0[%arg2] : memref<10xf32>
    return %0, %1 : memref<10xf32>, f32
  }
}

// -----
module {
  func.func @index_switch(%arg0: index, %arg1: memref<5xf32, strided<[?], offset: ?>>, %arg2: memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    %0 = scf.index_switch %arg0 -> memref<5xf32, strided<[?], offset: ?>> 
    case 2 {
      %cast = memref.cast %alloc : memref<5xf32> to memref<5xf32, strided<[?], offset: ?>>
      scf.yield %cast : memref<5xf32, strided<[?], offset: ?>>
    }
    case 5 {
      scf.yield %arg1 : memref<5xf32, strided<[?], offset: ?>>
    }
    default {
      scf.yield %arg2 : memref<5xf32, strided<[?], offset: ?>>
    }
    return %0 : memref<5xf32, strided<[?], offset: ?>>
  }
}

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
module {
  func.func @check_scfforall_inplace_bufferizer(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg2: memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %dim = memref.dim %arg2, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %dim_0 = memref.dim %arg1, %c1 : memref<?x?xf32, strided<[?, ?], offset: ?>>
    %subview = memref.subview %arg0[0, 0] [%dim, %dim_0] [1, 1] : memref<?x?xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
    %subview_1 = memref.subview %arg1[0, 0] [%dim, %dim_0] [1, 1] : memref<?x?xf32, strided<[?, ?], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
    linalg.generic {indexing_maps = [#map, #map, #map1], iterator_types = ["parallel", "reduction"]} ins(%subview, %subview_1 : memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?x?xf32, strided<[?, ?], offset: ?>>) outs(%arg2 : memref<?xf32, strided<[?], offset: ?>>) {
    ^bb0(%in: f32, %in_3: f32, %out: f32):
      %0 = arith.mulf %in, %in_3 : f32
      %1 = arith.addf %0, %out : f32
      linalg.yield %1 : f32
    }
    %subview_2 = memref.subview %arg2[0] [%dim] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32, strided<[?], offset: ?>>
    memref.copy %arg2, %subview_2 : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32, strided<[?], offset: ?>>
    return %arg2 : memref<?xf32, strided<[?], offset: ?>>
  }
}

