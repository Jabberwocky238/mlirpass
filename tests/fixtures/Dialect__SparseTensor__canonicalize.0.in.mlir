#sparse = #sparse_tensor.encoding<{ map = (d0, d1, d2) -> (d0 : dense, d1 : loose_compressed(nonunique), d2 : singleton) }>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32, #sparse>, index, index) -> tensor<?x?x?xf32, #sparse>, sym_name = "sparse_slice_canonicalize"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32, #sparse>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "tensor.extract_slice"(%arg0, %0, %arg1, %1, %2, %1, %arg2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?xf32, #sparse>, index, index, index, index, index, index, index, index, index) -> tensor<?x?x?xf32, #sparse>
    "func.return"(%3) : (tensor<?x?x?xf32, #sparse>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#sparse = #sparse_tensor.encoding<{ map = (d0, d1) -> (d0 : dense, d1 : compressed) }>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf64, #sparse>) -> (), sym_name = "sparse_iterate_canonicalize"}> ({
  ^bb0(%arg0: tensor<?x?xf64, #sparse>):
    %0 = "sparse_tensor.extract_iteration_space"(%arg0) <{hiLvl = 2 : index, loLvl = 0 : index}> : (tensor<?x?xf64, #sparse>) -> !sparse_tensor.iter_space<#sparse, lvls = 0 to 2>
    "sparse_tensor.iterate"(%0) <{crdUsedLvls = 3 : i64}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: !sparse_tensor.iterator<#sparse, lvls = 0 to 2>):
      "test.op"(%arg2) : (index) -> ()
      "sparse_tensor.yield"() : () -> ()
    }) : (!sparse_tensor.iter_space<#sparse, lvls = 0 to 2>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

