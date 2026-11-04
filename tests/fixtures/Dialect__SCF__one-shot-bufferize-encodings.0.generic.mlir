"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128xf32, 1 : i64>, index, index, index) -> tensor<128xf32, 1 : i64>, sym_name = "scf_for_iter_arg"}> ({
  ^bb0(%arg0: tensor<128xf32, 1 : i64>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<128xf32, 1 : i64>) -> memref<128xf32, strided<[?], offset: ?>, 1>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<128xf32, 1>
    "memref.copy"(%0, %1) : (memref<128xf32, strided<[?], offset: ?>, 1>, memref<128xf32, 1>) -> ()
    %2 = "memref.cast"(%1) : (memref<128xf32, 1>) -> memref<128xf32, strided<[?], offset: ?>, 1>
    %3 = "scf.for"(%arg1, %arg2, %arg3, %2) ({
    ^bb0(%arg4: index, %arg5: memref<128xf32, strided<[?], offset: ?>, 1>):
      %5 = "bufferization.to_tensor"(%arg5) : (memref<128xf32, strided<[?], offset: ?>, 1>) -> tensor<128xf32, 1 : i64>
      %6 = "some.use"(%5) : (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>
      %7 = "bufferization.to_buffer"(%6) : (tensor<128xf32, 1 : i64>) -> memref<128xf32, strided<[?], offset: ?>, 1>
      "scf.yield"(%7) : (memref<128xf32, strided<[?], offset: ?>, 1>) -> ()
    }) : (index, index, index, memref<128xf32, strided<[?], offset: ?>, 1>) -> memref<128xf32, strided<[?], offset: ?>, 1>
    %4 = "bufferization.to_tensor"(%3) : (memref<128xf32, strided<[?], offset: ?>, 1>) -> tensor<128xf32, 1 : i64>
    "func.return"(%4) : (tensor<128xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, tensor<?xf32, 1 : i64>, tensor<?xf32, 1 : i64>) -> tensor<?xf32, 1 : i64>, sym_name = "scf_forall"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: tensor<?xf32, 1 : i64>, %arg3: tensor<?xf32, 1 : i64>):
    %0 = "bufferization.to_buffer"(%arg3) : (tensor<?xf32, 1 : i64>) -> memref<?xf32, strided<[?], offset: ?>, 1>
    %1 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "memref.dim"(%0, %4) : (memref<?xf32, strided<[?], offset: ?>, 1>, index) -> index
    %6 = "memref.alloc"(%5) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32, 1>
    "memref.copy"(%0, %6) : (memref<?xf32, strided<[?], offset: ?>, 1>, memref<?xf32, 1>) -> ()
    "scf.forall"(%arg1) <{operandSegmentSizes = array<i32: 0, 1, 0, 0>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg4: index):
      %8 = "bufferization.to_tensor"(%6) : (memref<?xf32, 1>) -> tensor<?xf32, 1 : i64>
      %9 = "some.use"(%8) : (tensor<?xf32, 1 : i64>) -> tensor<?xf32, 1 : i64>
      %10 = "bufferization.to_buffer"(%9) : (tensor<?xf32, 1 : i64>) -> memref<?xf32, strided<[?], offset: ?>, 1>
      %11 = "memref.subview"(%6, %arg0, %3) <{operandSegmentSizes = array<i32: 1, 0, 1, 1>, static_offsets = array<i64: 5>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: -9223372036854775808>}> : (memref<?xf32, 1>, index, index) -> memref<?xf32, strided<[?], offset: 5>, 1>
      "memref.copy"(%10, %11) : (memref<?xf32, strided<[?], offset: ?>, 1>, memref<?xf32, strided<[?], offset: 5>, 1>) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : (index) -> ()
    %7 = "bufferization.to_tensor"(%6) : (memref<?xf32, 1>) -> tensor<?xf32, 1 : i64>
    "func.return"(%7) : (tensor<?xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>, sym_name = "scf_execute_region"}> ({
  ^bb0(%arg0: tensor<128xf32, 1 : i64>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<128xf32, 1 : i64>) -> memref<128xf32, strided<[?], offset: ?>, 1>
    %1 = "scf.execute_region"() ({
      "scf.yield"(%0) : (memref<128xf32, strided<[?], offset: ?>, 1>) -> ()
    }) : () -> memref<128xf32, strided<[?], offset: ?>, 1>
    %2 = "bufferization.to_tensor"(%1) : (memref<128xf32, strided<[?], offset: ?>, 1>) -> tensor<128xf32, 1 : i64>
    %3 = "some.use"(%2) : (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>
    "func.return"(%3) : (tensor<128xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

