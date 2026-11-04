"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, i1) -> tensor<?xf32>, sym_name = "buffer_not_deallocated"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: i1):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %1 = "scf.if"(%arg1) ({
      %3 = "test.some_op"() : () -> index
      %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
      %5 = "memref.cast"(%4) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
      "scf.yield"(%5) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    }, {
      "scf.yield"(%0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    }) : (i1) -> memref<?xf32, strided<[?], offset: ?>>
    %2 = "bufferization.to_tensor"(%1) : (memref<?xf32, strided<[?], offset: ?>>) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<i32>, i1, i32) -> tensor<i32>, sym_name = "write_to_alloc_tensor_or_readonly_tensor"}> ({
  ^bb0(%arg0: tensor<i32>, %arg1: i1, %arg2: i32):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<i32>) -> memref<i32, strided<[], offset: ?>>
    %1 = "scf.if"(%arg1) ({
      "scf.yield"(%0) : (memref<i32, strided<[], offset: ?>>) -> ()
    }, {
      %3 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
      "memref.store"(%arg2, %3) <{nontemporal = false}> : (i32, memref<i32>) -> ()
      %4 = "memref.cast"(%3) : (memref<i32>) -> memref<i32, strided<[], offset: ?>>
      "scf.yield"(%4) : (memref<i32, strided<[], offset: ?>>) -> ()
    }) : (i1) -> memref<i32, strided<[], offset: ?>>
    %2 = "bufferization.to_tensor"(%1) : (memref<i32, strided<[], offset: ?>>) -> tensor<i32>
    "func.return"(%2) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

