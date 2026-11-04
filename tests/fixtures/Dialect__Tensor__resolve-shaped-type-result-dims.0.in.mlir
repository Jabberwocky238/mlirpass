"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, tensor<?x?x?xf32>, index, index, index) -> (index, index, index), sym_name = "insert_slice"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %0) : (tensor<?x?x?xf32>, index) -> index
    %4 = "tensor.dim"(%arg0, %1) : (tensor<?x?x?xf32>, index) -> index
    %5 = "tensor.dim"(%arg0, %2) : (tensor<?x?x?xf32>, index) -> index
    %6 = "tensor.insert_slice"(%arg0, %arg1, %arg2, %arg3, %arg4, %3, %4, %5) <{operandSegmentSizes = array<i32: 1, 1, 3, 3, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (tensor<?x?x?xf32>, tensor<?x?x?xf32>, index, index, index, index, index, index) -> tensor<?x?x?xf32>
    %7 = "tensor.dim"(%6, %0) : (tensor<?x?x?xf32>, index) -> index
    %8 = "tensor.dim"(%6, %1) : (tensor<?x?x?xf32>, index) -> index
    %9 = "tensor.dim"(%6, %2) : (tensor<?x?x?xf32>, index) -> index
    "func.return"(%7, %8, %9) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index, index) -> (index, index, index), sym_name = "extract_slice"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "tensor.extract_slice"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 0, 3, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (tensor<?x?x?xf32>, index, index, index) -> tensor<?x?x?xf32>
    %4 = "tensor.dim"(%3, %0) : (tensor<?x?x?xf32>, index) -> index
    %5 = "tensor.dim"(%3, %1) : (tensor<?x?x?xf32>, index) -> index
    %6 = "tensor.dim"(%3, %2) : (tensor<?x?x?xf32>, index) -> index
    "func.return"(%4, %5, %6) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index) -> index, sym_name = "extract_slice_rank_reduced_1"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.extract_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 1, -9223372036854775808, 1>, static_strides = array<i64: 1, 1, 1>}> : (tensor<?x?x?xf32>, index) -> tensor<?xf32>
    %2 = "tensor.dim"(%1, %0) : (tensor<?xf32>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index) -> index, sym_name = "extract_slice_rank_reduced_2"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.extract_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 1, -9223372036854775808, 1>, static_strides = array<i64: 1, 1, 1>}> : (tensor<?x?x?xf32>, index) -> tensor<?x1xf32>
    %2 = "tensor.dim"(%1, %0) : (tensor<?x1xf32>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index) -> index, sym_name = "extract_slice_rank_reduced_3"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.extract_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 1, -9223372036854775808, 1>, static_strides = array<i64: 1, 1, 1>}> : (tensor<?x?x?xf32>, index) -> tensor<1x?xf32>
    %2 = "tensor.dim"(%1, %0) : (tensor<1x?xf32>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index) -> index, sym_name = "extract_slice_rank_reduced_4"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.extract_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 1, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 1, -9223372036854775808, 1>, static_strides = array<i64: 1, 1, 1>}> : (tensor<?x?x?xf32>, index) -> tensor<1x?x1xf32>
    %2 = "tensor.dim"(%1, %0) : (tensor<1x?x1xf32>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index) -> (index, index), sym_name = "extract_slice_rank_reduced_5"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.extract_slice"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: -9223372036854775808, 1, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (tensor<?x?x?xf32>, index, index) -> tensor<?x?xf32>
    %3 = "tensor.dim"(%2, %0) : (tensor<?x?xf32>, index) -> index
    %4 = "tensor.dim"(%2, %1) : (tensor<?x?xf32>, index) -> index
    "func.return"(%3, %4) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, index, index) -> (index, index), sym_name = "extract_slice_rank_reduced_6"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "tensor.extract_slice"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: -9223372036854775808, 1, -9223372036854775808>, static_strides = array<i64: 1, 1, 1>}> : (tensor<?x?x?xf32>, index, index) -> tensor<?x1x?xf32>
    %3 = "tensor.dim"(%2, %0) : (tensor<?x1x?xf32>, index) -> index
    %4 = "tensor.dim"(%2, %1) : (tensor<?x1x?xf32>, index) -> index
    "func.return"(%3, %4) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "collapse_shape"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 7 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : i16}> : () -> i16
    %3 = "tensor.generate"(%1) ({
    ^bb0(%arg0: index, %arg1: index):
      "tensor.yield"(%2) : (i16) -> ()
    }) : (index) -> tensor<?x22xi16>
    %4 = "tensor.collapse_shape"(%3) <{reassociation = [[0, 1]]}> : (tensor<?x22xi16>) -> tensor<?xi16>
    %5 = "tensor.dim"(%4, %0) : (tensor<?xi16>, index) -> index
    "func.return"(%5) : (index) -> ()
  }) : () -> ()
}) : () -> ()

