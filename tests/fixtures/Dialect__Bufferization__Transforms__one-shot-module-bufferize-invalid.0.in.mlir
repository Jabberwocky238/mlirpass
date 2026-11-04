"builtin.module"() ({
  "func.func"() <{arg_attrs = [{}, {bufferization.writable = true}, {}, {}, {}, {}], function_type = (tensor<?xf32>, tensor<?xf32>, tensor<4xf32>, index, index, index) -> (f32, f32), sym_name = "scf_for"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>, %arg2: tensor<4xf32>, %arg3: index, %arg4: index, %arg5: index):
    %0:2 = "scf.for"(%arg3, %arg4, %arg5, %arg0, %arg1) ({
    ^bb0(%arg6: index, %arg7: tensor<?xf32>, %arg8: tensor<?xf32>):
      %3 = "tensor.insert_slice"(%arg2, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
      %4 = "tensor.insert_slice"(%arg2, %arg8) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4>, static_strides = array<i64: 1>}> : (tensor<4xf32>, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%4, %3) : (tensor<?xf32>, tensor<?xf32>) -> ()
    }) : (index, index, index, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>)
    %1 = "tensor.extract"(%0#0, %arg5) : (tensor<?xf32>, index) -> f32
    %2 = "tensor.extract"(%0#1, %arg5) : (tensor<?xf32>, index) -> f32
    "func.return"(%1, %2) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xi1>, tensor<5xi1>, index) -> (i1, i1), sym_name = "scf_while_non_equiv_condition"}> ({
  ^bb0(%arg0: tensor<5xi1>, %arg1: tensor<5xi1>, %arg2: index):
    %0:2 = "scf.while"(%arg0, %arg1) ({
    ^bb0(%arg5: tensor<5xi1>, %arg6: tensor<5xi1>):
      %6 = "tensor.extract"(%arg5, %arg2) : (tensor<5xi1>, index) -> i1
      "scf.condition"(%6, %arg6, %arg5) : (i1, tensor<5xi1>, tensor<5xi1>) -> ()
    }, {
    ^bb0(%arg3: tensor<5xi1>, %arg4: tensor<5xi1>):
      %3 = "dummy.some_op"() : () -> index
      %4 = "dummy.another_op"() : () -> i1
      %5 = "tensor.insert"(%4, %arg3, %3) : (i1, tensor<5xi1>, index) -> tensor<5xi1>
      "scf.yield"(%5, %arg4) : (tensor<5xi1>, tensor<5xi1>) -> ()
    }) : (tensor<5xi1>, tensor<5xi1>) -> (tensor<5xi1>, tensor<5xi1>)
    %1 = "tensor.extract"(%0#0, %arg2) : (tensor<5xi1>, index) -> i1
    %2 = "tensor.extract"(%0#1, %arg2) : (tensor<5xi1>, index) -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xi1>, tensor<5xi1>, index) -> (i1, i1), sym_name = "scf_while_non_equiv_yield"}> ({
  ^bb0(%arg0: tensor<5xi1>, %arg1: tensor<5xi1>, %arg2: index):
    %0:2 = "scf.while"(%arg0, %arg1) ({
    ^bb0(%arg5: tensor<5xi1>, %arg6: tensor<5xi1>):
      %6 = "tensor.extract"(%arg5, %arg2) : (tensor<5xi1>, index) -> i1
      "scf.condition"(%6, %arg5, %arg6) : (i1, tensor<5xi1>, tensor<5xi1>) -> ()
    }, {
    ^bb0(%arg3: tensor<5xi1>, %arg4: tensor<5xi1>):
      %3 = "dummy.some_op"() : () -> index
      %4 = "dummy.another_op"() : () -> i1
      %5 = "tensor.insert"(%4, %arg3, %3) : (i1, tensor<5xi1>, index) -> tensor<5xi1>
      "scf.yield"(%arg4, %5) : (tensor<5xi1>, tensor<5xi1>) -> ()
    }) : (tensor<5xi1>, tensor<5xi1>) -> (tensor<5xi1>, tensor<5xi1>)
    %1 = "tensor.extract"(%0#0, %arg2) : (tensor<5xi1>, index) -> i1
    %2 = "tensor.extract"(%0#1, %arg2) : (tensor<5xi1>, index) -> i1
    "func.return"(%1, %2) : (i1, i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, index) -> f32, sym_name = "to_tensor_op_unsupported"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: index):
    %0 = "bufferization.to_tensor"(%arg0) : (memref<?xf32>) -> tensor<?xf32>
    %1 = "tensor.extract"(%0, %arg1) : (tensor<?xf32>, index) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, index, index) -> f32, sym_name = "yield_alloc_dominance_test_2"}> ({
  ^bb0(%arg0: f32, %arg1: index, %arg2: index):
    %0 = "bufferization.alloc_tensor"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (index) -> tensor<?xf32>
    %1 = "scf.execute_region"() ({
      "scf.yield"(%0) : (tensor<?xf32>) -> ()
    }) : () -> tensor<?xf32>
    %2 = "tensor.insert"(%arg0, %1, %arg1) : (f32, tensor<?xf32>, index) -> tensor<?xf32>
    %3 = "tensor.extract"(%2, %arg2) : (tensor<?xf32>, index) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>) -> tensor<*xf32>, sym_name = "copy_of_unranked_tensor"}> ({
  ^bb0(%arg0: tensor<*xf32>):
    "func.call"(%arg0) <{callee = @maybe_writing_func}> : (tensor<*xf32>) -> ()
    "func.return"(%arg0) : (tensor<*xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<*xf32>) -> (), sym_name = "maybe_writing_func", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "regression_scf_while"}> ({
    %0 = "arith.constant"() <{value = false}> : () -> i1
    %1 = "bufferization.alloc_tensor"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> tensor<10x10xf32>
    "scf.while"(%1) ({
    ^bb0(%arg0: tensor<10x10xf32>):
      "scf.condition"(%0) : (i1) -> ()
    }, {
      "scf.yield"(%1) : (tensor<10x10xf32>) -> ()
    }) : (tensor<10x10xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "func_multiple_yields"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    "func.return"(%arg0) : (tensor<5xf32>) -> ()
  ^bb1(%0: tensor<5xf32>):  // no predecessors
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<1x!quant.uniform<i8:f32, 1.000000e+00>>, sym_name = "non_memref_elem_type"}> ({
    %0 = "tensor.empty"() : () -> tensor<1x!quant.uniform<i8:f32, 1.000000e+00>>
    "func.return"(%0) : (tensor<1x!quant.uniform<i8:f32, 1.000000e+00>>) -> ()
  }) : () -> ()
}) : () -> ()

