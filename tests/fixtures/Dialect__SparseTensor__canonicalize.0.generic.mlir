#sparse = #sparse_tensor.encoding<{ map = (d0, d1, d2) -> (d0 : dense, d1 : loose_compressed(nonunique), d2 : singleton) }>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32, #sparse>, index, index) -> tensor<?x?x?xf32, #sparse>, sym_name = "sparse_slice_canonicalize"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32, #sparse>, %arg1: index, %arg2: index):
    %0 = "tensor.extract_slice"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 0, -9223372036854775808, 1>, static_sizes = array<i64: 4, 1, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (tensor<?x?x?xf32, #sparse>, index, index) -> tensor<4x1x?xf32, #sparse>
    %1 = "tensor.cast"(%0) : (tensor<4x1x?xf32, #sparse>) -> tensor<?x?x?xf32, #sparse>
    "func.return"(%1) : (tensor<?x?x?xf32, #sparse>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#sparse = #sparse_tensor.encoding<{ map = (d0, d1) -> (d0 : dense, d1 : compressed) }>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf64, #sparse>) -> (), sym_name = "sparse_iterate_canonicalize"}> ({
  ^bb0(%arg0: tensor<?x?xf64, #sparse>):
    %0 = "sparse_tensor.extract_iteration_space"(%arg0) <{hiLvl = 2 : index, loLvl = 0 : index}> : (tensor<?x?xf64, #sparse>) -> !sparse_tensor.iter_space<#sparse, lvls = 0 to 2>
    "sparse_tensor.iterate"(%0) <{crdUsedLvls = 2 : i64}> ({
    ^bb0(%arg1: index, %arg2: !sparse_tensor.iterator<#sparse, lvls = 0 to 2>):
      "test.op"(%arg1) : (index) -> ()
      "sparse_tensor.yield"() : () -> ()
    }) : (!sparse_tensor.iter_space<#sparse, lvls = 0 to 2>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

