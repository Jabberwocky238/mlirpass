"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128xf32, 1 : i64>, index, index, index) -> tensor<128xf32, 1 : i64>, sym_name = "scf_for_iter_arg"}> ({
  ^bb0(%arg0: tensor<128xf32, 1 : i64>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "scf.for"(%arg1, %arg2, %arg3, %arg0) ({
    ^bb0(%arg4: index, %arg5: tensor<128xf32, 1 : i64>):
      %1 = "some.use"(%arg5) : (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>
      "scf.yield"(%1) : (tensor<128xf32, 1 : i64>) -> ()
    }) : (index, index, index, tensor<128xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>
    "func.return"(%0) : (tensor<128xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, tensor<?xf32, 1 : i64>, tensor<?xf32, 1 : i64>) -> tensor<?xf32, 1 : i64>, sym_name = "scf_forall"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: tensor<?xf32, 1 : i64>, %arg3: tensor<?xf32, 1 : i64>):
    %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "scf.forall"(%arg1, %arg3) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32, 1 : i64>):
      %4 = "some.use"(%arg5) : (tensor<?xf32, 1 : i64>) -> tensor<?xf32, 1 : i64>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%4, %arg5, %arg0, %2) <{operandSegmentSizes = array<i32: 1, 1, 0, 1, 1>, static_offsets = array<i64: 5>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: -9223372036854775808>}> : (tensor<?xf32, 1 : i64>, tensor<?xf32, 1 : i64>, index, index) -> ()
      }) : () -> ()
    }) : (index, tensor<?xf32, 1 : i64>) -> tensor<?xf32, 1 : i64>
    "func.return"(%3) : (tensor<?xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>, sym_name = "scf_execute_region"}> ({
  ^bb0(%arg0: tensor<128xf32, 1 : i64>):
    %0 = "scf.execute_region"() ({
      "scf.yield"(%arg0) : (tensor<128xf32, 1 : i64>) -> ()
    }) : () -> tensor<128xf32, 1 : i64>
    %1 = "some.use"(%0) : (tensor<128xf32, 1 : i64>) -> tensor<128xf32, 1 : i64>
    "func.return"(%1) : (tensor<128xf32, 1 : i64>) -> ()
  }) : () -> ()
}) : () -> ()

