module {
  func.func private @private_func(memref<?xf32, strided<[?], offset: ?>>)
  func.func private @private_func_2d(memref<?x?xf32, strided<[?, ?], offset: ?>>)
  func.func @empty_func() {
    return
  }
}

// -----
module {
  func.func private @external_func_with_return_val(memref<4xi32, strided<[?], offset: ?>>) -> f32
}

// -----
module {
  func.func private @foo(memref<?xf32, strided<[?], offset: ?>>) -> (f32, memref<?xf32, strided<[?], offset: ?>>, f32)
  func.func @call_to_unknown_tensor_returning_func(%arg0: memref<?xf32, strided<[?], offset: ?>>) {
    %0:3 = call @foo(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> (f32, memref<?xf32, strided<[?], offset: ?>>, f32)
    return
  }
}

// -----
module {
  func.func @return_extract_slice(%arg0: index, %arg1: index) -> memref<2x?xf32, strided<[10, 1], offset: ?>> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<20x10xf32>
    %subview = memref.subview %alloc[%arg0, %arg0] [2, %arg1] [1, 1] : memref<20x10xf32> to memref<2x?xf32, strided<[10, 1], offset: ?>>
    return %subview : memref<2x?xf32, strided<[10, 1], offset: ?>>
  }
}

// -----
module {
  func.func @foo(%arg0: memref<3x8xf16, strided<[?, ?], offset: ?>>) -> memref<3x8xf16, strided<[?, ?], offset: ?>> {
    return %arg0 : memref<3x8xf16, strided<[?, ?], offset: ?>>
  }
  func.func @call_extract_slice(%arg0: memref<4x8xf16, strided<[?, ?], offset: ?>>) -> memref<3x8xf16, strided<[?, ?], offset: ?>> {
    %subview = memref.subview %arg0[1, 0] [3, 8] [1, 1] : memref<4x8xf16, strided<[?, ?], offset: ?>> to memref<3x8xf16, strided<[?, ?], offset: ?>>
    %0 = call @foo(%subview) : (memref<3x8xf16, strided<[?, ?], offset: ?>>) -> memref<3x8xf16, strided<[?, ?], offset: ?>>
    return %0 : memref<3x8xf16, strided<[?, ?], offset: ?>>
  }
}

// -----
module {
  func.func private @private_func(memref<?xf32, strided<[?], offset: ?>>) -> f32
  func.func @main(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> f32 {
    %0 = call @private_func(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    return %0 : f32
  }
}

// -----
module {
  func.func private @private_func(memref<?xf32, strided<[?], offset: ?>>) -> f32
  func.func @main(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> f32 {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %0 = call @private_func(%cast) : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    return %0 : f32
  }
}

// -----
module {
  func.func @func_without_tensor_args(%arg0: vector<10xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10xf32>
    vector.transfer_write %arg0, %alloc[%c0] {in_bounds = [true]} : vector<10xf32>, memref<10xf32>
    %0 = vector.transfer_read %alloc[%c0], %cst : memref<10xf32>, vector<11xf32>
    vector.print %0 : vector<11xf32>
    return
  }
}

// -----
module {
  func.func private @inner_func(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> f32 {
    %cst = arith.constant 1.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    memref.store %cst, %arg0[%c0] : memref<?xf32, strided<[?], offset: ?>>
    %0 = memref.load %arg0[%c1] : memref<?xf32, strided<[?], offset: ?>>
    return %0 : f32
  }
  func.func private @call_func_with_non_tensor_return(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> f32 {
    %0 = call @inner_func(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    return %0 : f32
  }
}

// -----
module {
  func.func private @inner_func(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> f32 {
    %cst = arith.constant 1.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    memref.store %cst, %arg0[%c0] : memref<?xf32, strided<[?], offset: ?>>
    %0 = memref.load %arg0[%c1] : memref<?xf32, strided<[?], offset: ?>>
    return %0 : f32
  }
  func.func @call_func_with_non_tensor_return(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> (f32, memref<?xf32, strided<[?], offset: ?>>) {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %0 = call @inner_func(%cast) : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    return %0, %cast : f32, memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func private @f0(memref<?xf32, strided<[?], offset: ?>>) -> f32
  func.func @f1(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> f32 {
    %0 = call @f0(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    return %0 : f32
  }
  func.func @f2(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> f32 {
    %0 = call @f1(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    return %0 : f32
  }
  func.func @main(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> f32 {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %0 = call @f2(%cast) : (memref<?xf32, strided<[?], offset: ?>>) -> f32
    return %0 : f32
  }
}

// -----
module {
  func.func private @does_not_read(%arg0: memref<?xf32, strided<[?], offset: ?>>) {
    %cst = arith.constant 0.000000e+00 : f32
    linalg.fill ins(%cst : f32) outs(%arg0 : memref<?xf32, strided<[?], offset: ?>>)
    return
  }
  func.func @main(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> f32 {
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    call @does_not_read(%cast) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    %0 = memref.load %cast[%c4] : memref<?xf32, strided<[?], offset: ?>>
    return %0 : f32
  }
}

// -----
module {
  memref.global "private" constant @__constant_4xi32 : memref<4xi32> = dense<[1, 2, 3, 4]> {alignment = 64 : i64}
  func.func private @some_external_func(memref<4xi32, strided<[?], offset: ?>>)
  func.func @main() {
    %0 = memref.get_global @__constant_4xi32 : memref<4xi32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4xi32>
    memref.copy %0, %alloc : memref<4xi32> to memref<4xi32>
    %cast = memref.cast %alloc : memref<4xi32> to memref<4xi32, strided<[?], offset: ?>>
    call @some_external_func(%cast) : (memref<4xi32, strided<[?], offset: ?>>) -> ()
    return
  }
}

// -----
module {
  memref.global "private" constant @__constant_4xi32 : memref<4xi32> = dense<[1, 2, 3, 4]> {alignment = 64 : i64}
  func.func private @some_external_func_within_scf_execute(memref<4xi32, strided<[?], offset: ?>>)
  func.func @main() {
    %0 = memref.get_global @__constant_4xi32 : memref<4xi32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<4xi32>
    memref.copy %0, %alloc : memref<4xi32> to memref<4xi32>
    %cast = memref.cast %alloc : memref<4xi32> to memref<4xi32, strided<[?], offset: ?>>
    call @some_external_func_within_scf_execute(%cast) : (memref<4xi32, strided<[?], offset: ?>>) -> ()
    return
  }
}

// -----
module {
  func.func private @execute_region_test(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> (f32, f32) {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %c7 = arith.constant 7 : index
    memref.store %cst_0, %arg0[%c7] : memref<?xf32, strided<[?], offset: ?>>
    return %cst, %cst_0 : f32, f32
  }
}

// -----
module {
  func.func private @foo()
  func.func @no_inline_execute_region_not_canonicalized() {
    scf.execute_region no_inline {
      func.call @foo() : () -> ()
      scf.yield
    }
    return
  }
}

// -----
module {
  func.func private @some_external_func(memref<?xf32, strided<[?], offset: ?>>)
  func.func private @scf_for_with_tensor_insert_slice(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: memref<4xf32, strided<[?], offset: ?>>, %arg3: index, %arg4: index, %arg5: index) {
    scf.for %arg6 = %arg3 to %arg4 step %arg5 {
      %subview = memref.subview %arg0[%arg6] [4] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
      memref.copy %arg2, %subview : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
      %subview_0 = memref.subview %arg1[%arg6] [4] [1] : memref<?xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
      memref.copy %arg2, %subview_0 : memref<4xf32, strided<[?], offset: ?>> to memref<4xf32, strided<[?], offset: ?>>
    }
    return
  }
  func.func @bar(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: memref<4xf32, strided<[?], offset: ?>>, %arg3: index, %arg4: index, %arg5: index) -> (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) {
    %c0 = arith.constant 0 : index
    call @scf_for_with_tensor_insert_slice(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, memref<4xf32, strided<[?], offset: ?>>, index, index, index) -> ()
    %dim = memref.dim %arg1, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg1, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    call @some_external_func(%cast) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    return %arg1, %arg0 : memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func private @init_and_dot(%arg0: memref<64xf32, strided<[?], offset: ?>>, %arg1: memref<64xf32, strided<[?], offset: ?>>, %arg2: memref<f32, strided<[], offset: ?>>) {
    %cst = arith.constant 0.000000e+00 : f32
    linalg.fill ins(%cst : f32) outs(%arg2 : memref<f32, strided<[], offset: ?>>)
    linalg.dot ins(%arg0, %arg1 : memref<64xf32, strided<[?], offset: ?>>, memref<64xf32, strided<[?], offset: ?>>) outs(%arg2 : memref<f32, strided<[], offset: ?>>)
    return
  }
  func.func @main() {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %cst_1 = arith.constant 2.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<64xf32>
    %alloc_2 = memref.alloc() {alignment = 64 : i64} : memref<64xf32>
    %alloc_3 = memref.alloc() {alignment = 64 : i64} : memref<f32>
    linalg.fill ins(%cst_0 : f32) outs(%alloc : memref<64xf32>)
    linalg.fill ins(%cst_1 : f32) outs(%alloc_2 : memref<64xf32>)
    linalg.fill ins(%cst : f32) outs(%alloc_3 : memref<f32>)
    %cast = memref.cast %alloc : memref<64xf32> to memref<64xf32, strided<[?], offset: ?>>
    %cast_4 = memref.cast %alloc_2 : memref<64xf32> to memref<64xf32, strided<[?], offset: ?>>
    %cast_5 = memref.cast %alloc_3 : memref<f32> to memref<f32, strided<[], offset: ?>>
    call @init_and_dot(%cast, %cast_4, %cast_5) : (memref<64xf32, strided<[?], offset: ?>>, memref<64xf32, strided<[?], offset: ?>>, memref<f32, strided<[], offset: ?>>) -> ()
    %cast_6 = memref.cast %cast_5 : memref<f32, strided<[], offset: ?>> to memref<*xf32>
    call @printMemrefF32(%cast_6) : (memref<*xf32>) -> ()
    return
  }
  func.func private @printMemrefF32(memref<*xf32>)
}

// -----
module {
  func.func private @external_func(memref<?xf32, strided<[?], offset: ?>>)
  func.func @callee(%arg0: memref<?xf32>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: memref<?xf32, strided<[?], offset: ?>>) {
    %cast = memref.cast %arg0 : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    call @external_func(%cast) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    call @external_func(%arg1) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    call @external_func(%arg2) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    return
  }
  func.func @entry(%arg0: memref<?xf32>, %arg1: memref<?xf32>, %arg2: memref<?xf32, strided<[?], offset: ?>>) {
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32> to memref<?xf32>
    %dim_0 = memref.dim %arg1, %c0 : memref<?xf32>
    %alloc_1 = memref.alloc(%dim_0) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg1, %alloc_1 : memref<?xf32> to memref<?xf32>
    %dim_2 = memref.dim %arg2, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc_3 = memref.alloc(%dim_2) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg2, %alloc_3 : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32>
    %cast_4 = memref.cast %alloc_1 : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    %cast_5 = memref.cast %alloc_3 : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
    call @callee(%cast, %cast_4, %cast_5) : (memref<?xf32>, memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> ()
    return
  }
}

// -----
module {
  func.func private @inner_func(%arg0: memref<?xf32, strided<[?], offset: ?>>) {
    %cst = arith.constant 1.000000e+00 : f32
    %c0 = arith.constant 0 : index
    memref.store %cst, %arg0[%c0] : memref<?xf32, strided<[?], offset: ?>>
    return
  }
  func.func @equivalent_func_arg(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index) -> memref<?xf32, strided<[?], offset: ?>> {
    %0 = scf.for %arg4 = %arg1 to %arg2 step %arg3 iter_args(%arg5 = %arg0) -> (memref<?xf32, strided<[?], offset: ?>>) {
      func.call @inner_func(%arg5) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
      scf.yield %arg5 : memref<?xf32, strided<[?], offset: ?>>
    }
    return %0 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @inner_func_2(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>> {
    %cst = arith.constant 1.000000e+00 : f32
    %c0 = arith.constant 0 : index
    memref.store %cst, %arg0[%c0] : memref<?xf32, strided<[?], offset: ?>>
    return %arg0 : memref<?xf32, strided<[?], offset: ?>>
  }
  func.func @equivalent_func_arg_2(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index) -> memref<?xf32, strided<[?], offset: ?>> {
    %c0 = arith.constant 0 : index
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
      %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
      %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
      memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
      %cast = memref.cast %alloc : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
      %0 = func.call @inner_func_2(%cast) : (memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>
    }
    return %arg0 : memref<?xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @transfer_read(%arg0: memref<?xf32, strided<[?], offset: ?>>) -> vector<4xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[%c0], %cst : memref<?xf32, strided<[?], offset: ?>>, vector<4xf32>
    return %0 : vector<4xf32>
  }
}

// -----
module {
  memref.global "private" constant @__constant_3xf32 : memref<3xf32> = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> {alignment = 64 : i64}
  func.func @main() {
    %0 = memref.get_global @__constant_3xf32 : memref<3xf32>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<3xf32>
    memref.copy %0, %alloc : memref<3xf32> to memref<3xf32>
    %cast = memref.cast %alloc : memref<3xf32> to memref<*xf32>
    call @maybe_writing_func(%cast) : (memref<*xf32>) -> ()
    return
  }
  func.func private @maybe_writing_func(memref<*xf32>)
}

// -----
module {
  llvm.func @llvm_func()
  func.func @call_llvm_func() {
    llvm.call @llvm_func() : () -> ()
    return
  }
}

// -----
module {
  func.func @to_buffer_op_unsupported(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<5xf32>) -> vector<5xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, strided<[?], offset: ?>>
    %alloc = memref.alloc(%dim) {alignment = 64 : i64} : memref<?xf32>
    memref.copy %arg0, %alloc : memref<?xf32, strided<[?], offset: ?>> to memref<?xf32>
    "test.foo"(%alloc) : (memref<?xf32>) -> ()
    %0 = vector.transfer_read %arg0[%arg3], %cst : memref<?xf32, strided<[?], offset: ?>>, vector<5xf32>
    return %0 : vector<5xf32>
  }
}

// -----
module {
  func.func @br_in_func(%arg0: memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>> {
    return %arg0 : memref<5xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @foo(%arg0: memref<5xf32>) -> memref<5xf32> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    %cast = memref.cast %alloc : memref<5xf32> to memref<5xf32, strided<[?], offset: ?>>
    %0 = call @bar(%cast, %arg0) : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32>) -> memref<5xf32>
    return %0 : memref<5xf32>
  }
  func.func @bar(%arg0: memref<5xf32, strided<[?], offset: ?>>, %arg1: memref<5xf32>) -> memref<5xf32> {
    %0 = call @foo(%arg1) : (memref<5xf32>) -> memref<5xf32>
    return %0 : memref<5xf32>
  }
}

// -----
module {
  func.func @foo(%arg0: memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>> {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<5xf32>
    memref.copy %arg0, %alloc : memref<5xf32, strided<[?], offset: ?>> to memref<5xf32>
    %cast = memref.cast %alloc : memref<5xf32> to memref<5xf32, strided<[?], offset: ?>>
    %0 = call @foo(%cast) : (memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>
    %1 = memref.load %arg0[%c0] : memref<5xf32, strided<[?], offset: ?>>
    vector.print %1 : f32
    return %0 : memref<5xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @foo(%arg0: memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>> {
    %0 = call @bar(%arg0) : (memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>
    return %0 : memref<5xf32, strided<[?], offset: ?>>
  }
  func.func @bar(%arg0: memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>> {
    %0 = call @foo(%arg0) : (memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>>
    return %0 : memref<5xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @result_type_mismatch(%arg0: i1) -> memref<5xf32, strided<[?], offset: ?>> {
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<10xf32>
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %subview = memref.subview %alloc[0] [5] [2] : memref<10xf32> to memref<5xf32, strided<[2]>>
    %cast = memref.cast %subview : memref<5xf32, strided<[2]>> to memref<5xf32, strided<[?], offset: ?>>
    return %cast : memref<5xf32, strided<[?], offset: ?>>
  ^bb2:  // pred: ^bb0
    %subview_0 = memref.subview %alloc[2] [5] [1] : memref<10xf32> to memref<5xf32, strided<[1], offset: 2>>
    %cast_1 = memref.cast %subview_0 : memref<5xf32, strided<[1], offset: 2>> to memref<5xf32, strided<[?], offset: ?>>
    return %cast_1 : memref<5xf32, strided<[?], offset: ?>>
  }
}

// -----
module {
  func.func @outer_func(%arg0: memref<5xf32, strided<[?], offset: ?>>) -> memref<5xf32, strided<[?], offset: ?>> {
    return %arg0 : memref<5xf32, strided<[?], offset: ?>>
  }
  module @inner_module {
    func.func @inner_func(%arg0: tensor<5xf32> {bufferization.writable = false}) -> tensor<5xf32> {
      return %arg0 : tensor<5xf32>
    }
  }
}

// -----
module {
  func.func @custom_types(%arg0: !test.test_memref<[4, 4], f64>) -> (!test.test_memref<[4, 8], f64>, !test.test_memref<[4, 8], f64>) {
    %0 = "test.dummy_memref_op"(%arg0) : (!test.test_memref<[4, 4], f64>) -> !test.test_memref<[4, 8], f64>
    %1 = "test.create_memref_op"() : () -> !test.test_memref<[4, 4], f64>
    %2 = "test.dummy_memref_op"(%1) : (!test.test_memref<[4, 4], f64>) -> !test.test_memref<[4, 8], f64>
    return %0, %2 : !test.test_memref<[4, 8], f64>, !test.test_memref<[4, 8], f64>
  }
}

// -----
module {
  func.func @custom_types_foo(%arg0: !test.test_memref<[4, 4], f64>) -> !test.test_memref<[4, 4], f64> {
    %0 = "test.dummy_memref_op"(%arg0) : (!test.test_memref<[4, 4], f64>) -> !test.test_memref<[4, 4], f64>
    return %0 : !test.test_memref<[4, 4], f64>
  }
  func.func @custom_types_bar(%arg0: !test.test_memref<[4, 4], f64>) -> !test.test_memref<[4, 8], f64> {
    %0 = call @custom_types_foo(%arg0) : (!test.test_memref<[4, 4], f64>) -> !test.test_memref<[4, 4], f64>
    %1 = "test.dummy_memref_op"(%0) : (!test.test_memref<[4, 4], f64>) -> !test.test_memref<[4, 8], f64>
    return %1 : !test.test_memref<[4, 8], f64>
  }
}

