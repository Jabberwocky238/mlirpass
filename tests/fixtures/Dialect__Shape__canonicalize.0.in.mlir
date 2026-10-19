"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x4xf32>) -> tensor<3xindex>, sym_name = "f"}> ({
  ^bb0(%arg0: tensor<2x3x4xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<2x3x4xf32>) -> tensor<3xindex>
    "func.return"(%0) : (tensor<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (!shape.shape, !shape.shape), sym_name = "f"}> ({
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "shape.const_shape"() <{shape = dense<[2, 3, 4, 5]> : tensor<4xindex>}> : () -> !shape.shape
    %2:2 = "shape.split_at"(%1, %0) : (!shape.shape, index) -> (!shape.shape, !shape.shape)
    "func.return"(%2#0, %2#1) : (!shape.shape, !shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (!shape.shape, !shape.shape), sym_name = "f"}> ({
    %0 = "arith.constant"() <{value = -1 : index}> : () -> index
    %1 = "shape.const_shape"() <{shape = dense<[2, 3, 4, 5]> : tensor<4xindex>}> : () -> !shape.shape
    %2:2 = "shape.split_at"(%1, %0) : (!shape.shape, index) -> (!shape.shape, !shape.shape)
    "func.return"(%2#0, %2#1) : (!shape.shape, !shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (!shape.shape, !shape.shape), sym_name = "f"}> ({
    %0 = "arith.constant"() <{value = 5 : index}> : () -> index
    %1 = "shape.const_shape"() <{shape = dense<[2, 3, 4, 5]> : tensor<4xindex>}> : () -> !shape.shape
    %2:2 = "shape.split_at"(%1, %0) : (!shape.shape, index) -> (!shape.shape, !shape.shape)
    "func.return"(%2#0, %2#1) : (!shape.shape, !shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.shape, sym_name = "f"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[1, 2]> : tensor<2xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[7, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %2 = "shape.broadcast"(%0, %1) : (!shape.shape, !shape.shape) -> !shape.shape
    "func.return"(%2) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<2xindex>, sym_name = "broadcast"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[1, 2]> : tensor<2xindex>}> : () -> tensor<2xindex>
    %1 = "shape.const_shape"() <{shape = dense<[7, 1]> : tensor<2xindex>}> : () -> tensor<2xindex>
    %2 = "shape.broadcast"(%0, %1) : (tensor<2xindex>, tensor<2xindex>) -> tensor<2xindex>
    "func.return"(%2) : (tensor<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.shape, sym_name = "broadcast"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[1, 2]> : tensor<2xindex>}> : () -> tensor<2xindex>
    %1 = "shape.const_shape"() <{shape = dense<[7, 1]> : tensor<2xindex>}> : () -> tensor<2xindex>
    %2 = "shape.broadcast"(%0, %1) : (tensor<2xindex>, tensor<2xindex>) -> !shape.shape
    "func.return"(%2) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.shape, sym_name = "broadcast_variadic"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[2, 1]> : tensor<2xindex>}> : () -> tensor<2xindex>
    %1 = "shape.const_shape"() <{shape = dense<[7, 2, 1]> : tensor<3xindex>}> : () -> tensor<3xindex>
    %2 = "shape.const_shape"() <{shape = dense<[1, 10]> : tensor<2xindex>}> : () -> tensor<2xindex>
    %3 = "shape.broadcast"(%0, %1, %2) : (tensor<2xindex>, tensor<3xindex>, tensor<2xindex>) -> !shape.shape
    "func.return"(%3) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> !shape.shape, sym_name = "f"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.const_shape"() <{shape = dense<> : tensor<0xindex>}> : () -> !shape.shape
    %1 = "shape.broadcast"(%arg0, %0) : (!shape.shape, !shape.shape) -> !shape.shape
    "func.return"(%1) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> !shape.shape, sym_name = "f"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.const_shape"() <{shape = dense<> : tensor<0xindex>}> : () -> !shape.shape
    %1 = "shape.broadcast"(%0, %arg0) : (!shape.shape, !shape.shape) -> !shape.shape
    "func.return"(%1) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.shape, sym_name = "f"}> ({
    %0 = "shape.const_shape"() <{shape = dense<> : tensor<0xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[1, 2, 3]> : tensor<3xindex>}> : () -> !shape.shape
    %2 = "shape.broadcast"(%0, %1) : (!shape.shape, !shape.shape) -> !shape.shape
    "func.return"(%2) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> !shape.shape, sym_name = "all_but_one_empty"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.const_shape"() <{shape = dense<> : tensor<0xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<> : tensor<0xindex>}> : () -> tensor<0xindex>
    %2 = "shape.broadcast"(%0, %arg0, %1, %0) : (!shape.shape, !shape.shape, tensor<0xindex>, !shape.shape) -> !shape.shape
    "func.return"(%2) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, tensor<i1>) -> tensor<0xindex>, sym_name = "all_empty"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: tensor<i1>):
    %0 = "shape.shape_of"(%arg0) : (tensor<f32>) -> tensor<0xindex>
    %1 = "shape.shape_of"(%arg1) : (tensor<i1>) -> tensor<0xindex>
    %2 = "shape.const_shape"() <{shape = dense<> : tensor<0xindex>}> : () -> tensor<0xindex>
    %3 = "shape.broadcast"(%0, %1, %2) : (tensor<0xindex>, tensor<0xindex>, tensor<0xindex>) -> tensor<0xindex>
    "func.return"(%3) : (tensor<0xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> !shape.shape, sym_name = "partial_folding"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.const_shape"() <{shape = dense<[2, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[1, 2, 3]> : tensor<3xindex>}> : () -> tensor<3xindex>
    %2 = "shape.broadcast"(%0, %arg0, %1, %0) : (!shape.shape, !shape.shape, tensor<3xindex>, !shape.shape) -> !shape.shape
    "func.return"(%2) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.shape, sym_name = "f"}> ({
    %0 = "shape.const_shape"() <{shape = dense<2> : tensor<1xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<7> : tensor<1xindex>}> : () -> !shape.shape
    %2 = "shape.broadcast"(%0, %1) : (!shape.shape, !shape.shape) -> !shape.shape
    "func.return"(%2) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape, !shape.shape) -> (), sym_name = "broadcast"}> ({
  ^bb0(%arg0: !shape.shape, %arg1: !shape.shape):
    %0 = "shape.broadcast"(%arg0, %arg1) : (!shape.shape, !shape.shape) -> !shape.shape
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.shape, sym_name = "f"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[0, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[2, 3]> : tensor<2xindex>}> : () -> !shape.shape
    %2 = "shape.concat"(%0, %1) : (!shape.shape, !shape.shape) -> !shape.shape
    "func.return"(%2) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<4xindex>, sym_name = "f"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[0, 1]> : tensor<2xindex>}> : () -> tensor<2xindex>
    %1 = "shape.const_shape"() <{shape = dense<[2, 3]> : tensor<2xindex>}> : () -> tensor<2xindex>
    %2 = "shape.concat"(%0, %1) : (tensor<2xindex>, tensor<2xindex>) -> tensor<4xindex>
    "func.return"(%2) : (tensor<4xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<2xindex>, sym_name = "f"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[0, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %1 = "shape.to_extent_tensor"(%0) : (!shape.shape) -> tensor<2xindex>
    "func.return"(%1) : (tensor<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.shape, sym_name = "f"}> ({
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "arith.constant"() <{value = 5 : index}> : () -> index
    %2 = "arith.constant"() <{value = 11 : index}> : () -> index
    %3 = "shape.from_extents"(%0, %1, %2) : (index, index, index) -> !shape.shape
    "func.return"(%3) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.shape, sym_name = "fold_const_size"}> ({
    %0 = "shape.const_size"() <{value = 3 : index}> : () -> !shape.size
    %1 = "shape.const_size"() <{value = 5 : index}> : () -> !shape.size
    %2 = "shape.from_extents"(%0, %1) : (!shape.size, !shape.size) -> !shape.shape
    "func.return"(%2) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> !shape.shape, sym_name = "no_fold"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "shape.from_extents"(%0, %arg0) : (index, index) -> !shape.shape
    "func.return"(%1) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "const_size_to_index"}> ({
    %0 = "shape.const_size"() <{value = 123 : index}> : () -> !shape.size
    %1 = "shape.size_to_index"(%0) : (!shape.size) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.size, sym_name = "const_index_to_size"}> ({
    %0 = "arith.constant"() <{value = 123 : index}> : () -> index
    %1 = "shape.index_to_size"(%0) : (index) -> !shape.size
    "func.return"(%1) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "const_index_to_size_to_index"}> ({
    %0 = "arith.constant"() <{value = 123 : index}> : () -> index
    %1 = "shape.index_to_size"(%0) : (index) -> !shape.size
    %2 = "shape.size_to_index"(%1) : (!shape.size) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.size) -> index, sym_name = "nonfoldable_size_to_index"}> ({
  ^bb0(%arg0: !shape.size):
    %0 = "shape.size_to_index"(%arg0) : (!shape.size) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> !shape.size, sym_name = "nonfoldable_index_to_size"}> ({
  ^bb0(%arg0: index):
    %0 = "shape.index_to_size"(%arg0) : (index) -> !shape.size
    "func.return"(%0) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.size, sym_name = "num_elements"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[4, 5, 6]> : tensor<3xindex>}> : () -> !shape.shape
    %1 = "shape.num_elements"(%0) : (!shape.shape) -> !shape.size
    "func.return"(%1) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> !shape.size, sym_name = "nonfoldable_num_elements"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.num_elements"(%arg0) : (!shape.shape) -> !shape.size
    "func.return"(%0) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "basic"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[0, 1, 2]> : tensor<3xindex>}> : () -> tensor<3xindex>
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "shape.get_extent"(%0, %1) : (tensor<3xindex>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "out_of_bounds"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[0, 1, 2]> : tensor<3xindex>}> : () -> tensor<3xindex>
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "shape.get_extent"(%0, %1) : (tensor<3xindex>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> index, sym_name = "not_const"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "shape.get_extent"(%arg0, %0) : (tensor<?xindex>, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.size, sym_name = "basic"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[0, 1, 2]> : tensor<3xindex>}> : () -> !shape.shape
    %1 = "shape.const_size"() <{value = 2 : index}> : () -> !shape.size
    %2 = "shape.get_extent"(%0, %1) : (!shape.shape, !shape.size) -> !shape.size
    "func.return"(%2) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.size, sym_name = "out_of_bounds"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[0, 1, 2]> : tensor<3xindex>}> : () -> !shape.shape
    %1 = "shape.const_size"() <{value = 3 : index}> : () -> !shape.size
    %2 = "shape.get_extent"(%0, %1) : (!shape.shape, !shape.size) -> !shape.size
    "func.return"(%2) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> !shape.size, sym_name = "not_const"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.const_size"() <{value = 3 : index}> : () -> !shape.size
    %1 = "shape.get_extent"(%arg0, %0) : (!shape.shape, !shape.size) -> !shape.size
    "func.return"(%1) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.cstr_eq"(%arg0, %arg0, %arg0) : (!shape.shape, !shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%0) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[0, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[0, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %2 = "shape.const_shape"() <{shape = dense<[0, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %3 = "shape.cstr_eq"(%0, %1, %2) : (!shape.shape, !shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%3) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[0, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[3, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %2 = "shape.cstr_eq"(%0, %1) : (!shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%2) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape, !shape.shape) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: !shape.shape, %arg1: !shape.shape):
    %0 = "shape.cstr_eq"(%arg0, %arg1) : (!shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%0) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "cstr_require_fold"}> ({
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "shape.cstr_require"(%0) <{msg = "msg"}> : (i1) -> !shape.witness
    "consume.witness"(%1) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "cstr_require_no_fold"}> ({
  ^bb0(%arg0: i1):
    %0 = "shape.cstr_require"(%arg0) <{msg = "msg"}> : (i1) -> !shape.witness
    "consume.witness"(%0) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    %0 = "test.source"() : () -> !shape.witness
    %1 = "test.source"() : () -> !shape.witness
    %2 = "test.source"() : () -> !shape.witness
    %3 = "shape.assuming_all"(%0, %1) : (!shape.witness, !shape.witness) -> !shape.witness
    %4 = "shape.assuming_all"(%3, %2) : (!shape.witness, !shape.witness) -> !shape.witness
    "consume.witness"(%4) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape, tensor<?xindex>, tensor<3xindex>) -> !shape.witness, sym_name = "assuming_all_to_cstr_eq"}> ({
  ^bb0(%arg0: !shape.shape, %arg1: tensor<?xindex>, %arg2: tensor<3xindex>):
    %0 = "shape.cstr_eq"(%arg0, %arg1) : (!shape.shape, tensor<?xindex>) -> !shape.witness
    %1 = "shape.cstr_eq"(%arg1, %arg2) : (tensor<?xindex>, tensor<3xindex>) -> !shape.witness
    %2 = "shape.assuming_all"(%0, %1) : (!shape.witness, !shape.witness) -> !shape.witness
    "func.return"(%2) : (!shape.witness) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, tensor<?xindex>) -> !shape.witness, sym_name = "assuming_all_duplicate_operands"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: tensor<?xindex>):
    %0 = "shape.cstr_broadcastable"(%arg0, %arg1) : (tensor<?xindex>, tensor<?xindex>) -> !shape.witness
    %1 = "shape.assuming_all"(%0, %0, %0) : (!shape.witness, !shape.witness, !shape.witness) -> !shape.witness
    "func.return"(%1) : (!shape.witness) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape, tensor<?xindex>, tensor<3xindex>, tensor<3xindex>) -> !shape.witness, sym_name = "assuming_all_to_cstr_eq"}> ({
  ^bb0(%arg0: !shape.shape, %arg1: tensor<?xindex>, %arg2: tensor<3xindex>, %arg3: tensor<3xindex>):
    %0 = "shape.cstr_eq"(%arg0, %arg1) : (!shape.shape, tensor<?xindex>) -> !shape.witness
    %1 = "shape.cstr_eq"(%arg2, %arg3) : (tensor<3xindex>, tensor<3xindex>) -> !shape.witness
    %2 = "shape.assuming_all"(%0, %1) : (!shape.witness, !shape.witness) -> !shape.witness
    "func.return"(%2) : (!shape.witness) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    %0 = "shape.const_witness"() <{passing = true}> : () -> !shape.witness
    %1 = "shape.const_witness"() <{passing = true}> : () -> !shape.witness
    %2 = "shape.const_witness"() <{passing = true}> : () -> !shape.witness
    %3 = "shape.assuming_all"(%0, %1, %2) : (!shape.witness, !shape.witness, !shape.witness) -> !shape.witness
    "consume.witness"(%3) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    %0 = "shape.const_witness"() <{passing = true}> : () -> !shape.witness
    %1 = "test.source"() : () -> !shape.witness
    %2 = "test.source"() : () -> !shape.witness
    %3 = "shape.assuming_all"(%0, %1, %2) : (!shape.witness, !shape.witness, !shape.witness) -> !shape.witness
    "consume.witness"(%3) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape, !shape.shape, !shape.shape) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: !shape.shape, %arg1: !shape.shape, %arg2: !shape.shape):
    %0 = "shape.cstr_broadcastable"(%arg0, %arg1) : (!shape.shape, !shape.shape) -> !shape.witness
    %1 = "shape.cstr_broadcastable"(%arg0, %arg1, %arg2) : (!shape.shape, !shape.shape, !shape.shape) -> !shape.witness
    %2 = "shape.assuming_all"(%0, %1) : (!shape.witness, !shape.witness) -> !shape.witness
    "consume.witness"(%2) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape, !shape.shape, !shape.shape) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: !shape.shape, %arg1: !shape.shape, %arg2: !shape.shape):
    %0 = "shape.cstr_broadcastable"(%arg0, %arg1) : (!shape.shape, !shape.shape) -> !shape.witness
    %1 = "shape.cstr_broadcastable"(%arg1, %arg2) : (!shape.shape, !shape.shape) -> !shape.witness
    %2 = "shape.assuming_all"(%0, %1) : (!shape.witness, !shape.witness) -> !shape.witness
    "consume.witness"(%2) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> !shape.shape, sym_name = "f"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.const_shape"() <{shape = dense<[2, 3, 4]> : tensor<3xindex>}> : () -> !shape.shape
    %1 = "shape.any"(%0, %arg0) : (!shape.shape, !shape.shape) -> !shape.shape
    "func.return"(%1) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> tensor<3xindex>, sym_name = "f"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "shape.const_shape"() <{shape = dense<[2, 3, 4]> : tensor<3xindex>}> : () -> tensor<3xindex>
    %1 = "shape.any"(%0, %arg0) : (tensor<3xindex>, tensor<?xindex>) -> tensor<3xindex>
    "func.return"(%1) : (tensor<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape, !shape.shape) -> !shape.shape, sym_name = "f"}> ({
  ^bb0(%arg0: !shape.shape, %arg1: !shape.shape):
    %0 = "shape.any"(%arg0, %arg1) : (!shape.shape, !shape.shape) -> !shape.shape
    "func.return"(%0) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    %0 = "shape.const_witness"() <{passing = true}> : () -> !shape.witness
    %1 = "shape.assuming"(%0) ({
      %2 = "test.source"() : () -> index
      "shape.assuming_yield"(%2) : (index) -> ()
    }) : (!shape.witness) -> index
    "test.sink"(%1) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    %0 = "test.source"() : () -> !shape.witness
    %1 = "shape.assuming"(%0) ({
      %2 = "test.source"() : () -> index
      "shape.assuming_yield"(%2) : (index) -> ()
    }) : (!shape.witness) -> index
    "test.sink"(%1) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "unused_assuming_results"}> ({
    %0 = "test.source"() : () -> !shape.witness
    %1:2 = "shape.assuming"(%0) ({
      %2 = "produce.redundant"() : () -> f32
      %3 = "produce.meaningful"() : () -> f32
      "shape.assuming_yield"(%2, %3) : (f32, f32) -> ()
    }) : (!shape.witness) -> (f32, f32)
    "use"(%1#1) : (f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[3, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[1, 5]> : tensor<2xindex>}> : () -> !shape.shape
    %2 = "shape.cstr_broadcastable"(%0, %1) : (!shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%2) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, tensor<?xindex>, tensor<0xindex>) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: tensor<?xindex>, %arg2: tensor<0xindex>):
    %0 = "shape.const_shape"() <{shape = dense<> : tensor<0xindex>}> : () -> !shape.shape
    %1 = "shape.cstr_broadcastable"(%arg0, %arg1, %0, %arg2) : (tensor<?xindex>, tensor<?xindex>, !shape.shape, tensor<0xindex>) -> !shape.witness
    "consume.witness"(%1) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "static_non_broadcastable"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[1, 3]> : tensor<2xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[1, 5]> : tensor<2xindex>}> : () -> !shape.shape
    %2 = "shape.cstr_broadcastable"(%0, %1) : (!shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%2) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.const_shape"() <{shape = dense<[1, 3]> : tensor<2xindex>}> : () -> !shape.shape
    %1 = "shape.cstr_broadcastable"(%arg0, %0) : (!shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%1) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.cstr_broadcastable"(%arg0, %arg0) : (!shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%0) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> (), sym_name = "broadcastable_on_extent_tensors"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "shape.cstr_broadcastable"(%arg0, %arg0) : (tensor<?xindex>, tensor<?xindex>) -> !shape.witness
    "consume.witness"(%0) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[8, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[1, 8]> : tensor<2xindex>}> : () -> !shape.shape
    %2 = "shape.const_shape"() <{shape = dense<1> : tensor<2xindex>}> : () -> !shape.shape
    %3 = "shape.cstr_broadcastable"(%0, %1, %2) : (!shape.shape, !shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%3) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[8, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[1, -9223372036854775808]> : tensor<2xindex>}> : () -> !shape.shape
    %2 = "shape.cstr_broadcastable"(%0, %0, %1) : (!shape.shape, !shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%2) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[8, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[1, 8]> : tensor<2xindex>}> : () -> !shape.shape
    %2 = "shape.const_shape"() <{shape = dense<[1, -9223372036854775808]> : tensor<2xindex>}> : () -> !shape.shape
    %3 = "shape.cstr_broadcastable"(%0, %1, %2) : (!shape.shape, !shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%3) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "f"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[8, 1]> : tensor<2xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[1, -9223372036854775808]> : tensor<2xindex>}> : () -> !shape.shape
    %2 = "shape.const_shape"() <{shape = dense<[8, -9223372036854775808]> : tensor<2xindex>}> : () -> !shape.shape
    %3 = "shape.cstr_broadcastable"(%0, %1, %2) : (!shape.shape, !shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%3) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.const_shape"() <{shape = dense<> : tensor<0xindex>}> : () -> !shape.shape
    %1 = "shape.cstr_broadcastable"(%0, %0, %arg0) : (!shape.shape, !shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%1) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> (), sym_name = "f"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.const_shape"() <{shape = dense<> : tensor<0xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<2> : tensor<1xindex>}> : () -> !shape.shape
    %2 = "shape.cstr_broadcastable"(%0, %1, %arg0) : (!shape.shape, !shape.shape, !shape.shape) -> !shape.witness
    "consume.witness"(%2) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.size, sym_name = "fold_rank"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[3, 4, 5, 6, 7]> : tensor<5xindex>}> : () -> !shape.shape
    %1 = "shape.rank"(%0) : (!shape.shape) -> !shape.size
    "func.return"(%1) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> !shape.size, sym_name = "dont_fold_rank"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.rank"(%arg0) : (!shape.shape) -> !shape.size
    "func.return"(%0) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "fold_rank"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[3, 4, 5, 6, 7]> : tensor<5xindex>}> : () -> tensor<5xindex>
    %1 = "shape.rank"(%0) : (tensor<5xindex>) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> index, sym_name = "dont_fold_rank"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "shape.rank"(%arg0) : (tensor<?xindex>) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x?xf32>) -> index, sym_name = "canonicalize_rank"}> ({
  ^bb0(%arg0: tensor<1x2x?xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<1x2x?xf32>) -> tensor<?xindex>
    %1 = "shape.rank"(%0) : (tensor<?xindex>) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x?xf32>) -> !shape.size, sym_name = "canonicalize_rank_size"}> ({
  ^bb0(%arg0: tensor<1x2x?xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<1x2x?xf32>) -> !shape.shape
    %1 = "shape.rank"(%0) : (!shape.shape) -> !shape.size
    "func.return"(%1) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>) -> index, sym_name = "dont_canonicalize_rank"}> ({
  ^bb0(%arg0: tensor<*xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<*xf32>) -> tensor<?xindex>
    %1 = "shape.rank"(%0) : (tensor<?xindex>) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "index_to_size_to_index"}> ({
  ^bb0(%arg0: index):
    %0 = "shape.index_to_size"(%arg0) : (index) -> !shape.size
    %1 = "shape.size_to_index"(%0) : (!shape.size) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.size) -> !shape.size, sym_name = "size_to_index_to_size"}> ({
  ^bb0(%arg0: !shape.size):
    %0 = "shape.size_to_index"(%arg0) : (!shape.size) -> index
    %1 = "shape.index_to_size"(%0) : (index) -> !shape.size
    "func.return"(%1) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (), sym_name = "cstr_broadcastable_scalar"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "shape.const_shape"() <{shape = dense<> : tensor<0xindex>}> : () -> !shape.shape
    %1 = "shape.shape_of"(%arg0) : (tensor<?xf32>) -> tensor<?xindex>
    %2 = "shape.cstr_broadcastable"(%0, %1) : (!shape.shape, tensor<?xindex>) -> !shape.witness
    "consume.witness"(%2) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>) -> (), sym_name = "cstr_broadcastable_unknown"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<?xf32>) -> tensor<?xindex>
    %1 = "shape.shape_of"(%arg1) : (tensor<?xf32>) -> tensor<?xindex>
    %2 = "shape.cstr_broadcastable"(%0, %1) : (tensor<?xindex>, tensor<?xindex>) -> !shape.witness
    "consume.witness"(%2) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, tensor<index>) -> (), sym_name = "cstr_broadcastable_scalar_unranked"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: tensor<index>):
    %0 = "shape.shape_of"(%arg1) : (tensor<index>) -> tensor<?xindex>
    %1 = "shape.shape_of"(%arg0) : (tensor<*xf32>) -> tensor<?xindex>
    %2 = "shape.cstr_broadcastable"(%0, %1) : (tensor<?xindex>, tensor<?xindex>) -> !shape.witness
    "consume.witness"(%2) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i1, sym_name = "shape_eq_fold_1"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[1, 2, 3]> : tensor<3xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[1, 2, 3]> : tensor<3xindex>}> : () -> tensor<3xindex>
    %2 = "shape.const_shape"() <{shape = dense<[1, 2, 3]> : tensor<3xindex>}> : () -> tensor<3xindex>
    %3 = "shape.shape_eq"(%0, %1, %2) : (!shape.shape, tensor<3xindex>, tensor<3xindex>) -> i1
    "func.return"(%3) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i1, sym_name = "shape_eq_fold_0"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[1, 2, 3]> : tensor<3xindex>}> : () -> tensor<3xindex>
    %1 = "shape.const_shape"() <{shape = dense<[4, 5, 6]> : tensor<3xindex>}> : () -> tensor<3xindex>
    %2 = "shape.const_shape"() <{shape = dense<[4, 5, 6]> : tensor<3xindex>}> : () -> tensor<3xindex>
    %3 = "shape.shape_eq"(%0, %1, %2) : (tensor<3xindex>, tensor<3xindex>, tensor<3xindex>) -> i1
    "func.return"(%3) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i1, sym_name = "shape_eq_fold_0"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[1, 2, 3, 4, 5, 6]> : tensor<6xindex>}> : () -> !shape.shape
    %1 = "shape.const_shape"() <{shape = dense<[1, 2, 3]> : tensor<3xindex>}> : () -> !shape.shape
    %2 = "shape.shape_eq"(%0, %1) : (!shape.shape, !shape.shape) -> i1
    "func.return"(%2) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> i1, sym_name = "shape_eq_do_not_fold"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.const_shape"() <{shape = dense<[4, 5, 6]> : tensor<3xindex>}> : () -> !shape.shape
    %1 = "shape.shape_eq"(%arg0, %0) : (!shape.shape, !shape.shape) -> i1
    "func.return"(%1) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.size, sym_name = "fold_add_size"}> ({
    %0 = "shape.const_size"() <{value = 2 : index}> : () -> !shape.size
    %1 = "shape.const_size"() <{value = 3 : index}> : () -> !shape.size
    %2 = "shape.add"(%0, %1) : (!shape.size, !shape.size) -> !shape.size
    "func.return"(%2) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.size, sym_name = "fold_mul_size"}> ({
    %0 = "shape.const_size"() <{value = 2 : index}> : () -> !shape.size
    %1 = "shape.const_size"() <{value = 3 : index}> : () -> !shape.size
    %2 = "shape.mul"(%0, %1) : (!shape.size, !shape.size) -> !shape.size
    "func.return"(%2) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "fold_mul_index"}> ({
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "shape.mul"(%0, %1) : (index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.size, sym_name = "fold_mul_mixed"}> ({
    %0 = "shape.const_size"() <{value = 2 : index}> : () -> !shape.size
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "shape.mul"(%0, %1) : (!shape.size, index) -> !shape.size
    "func.return"(%2) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.size, sym_name = "fold_div_size"}> ({
    %0 = "shape.const_size"() <{value = 10 : index}> : () -> !shape.size
    %1 = "shape.const_size"() <{value = 3 : index}> : () -> !shape.size
    %2 = "shape.div"(%0, %1) : (!shape.size, !shape.size) -> !shape.size
    "func.return"(%2) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "fold_div_index"}> ({
    %0 = "arith.constant"() <{value = 10 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "shape.div"(%0, %1) : (index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "fold_div_index_neg_lhs"}> ({
    %0 = "arith.constant"() <{value = -10 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "shape.div"(%0, %1) : (index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "fold_div_index_neg_rhs"}> ({
    %0 = "arith.constant"() <{value = 10 : index}> : () -> index
    %1 = "arith.constant"() <{value = -4 : index}> : () -> index
    %2 = "shape.div"(%0, %1) : (index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.size, sym_name = "fold_div_mixed"}> ({
    %0 = "shape.const_size"() <{value = 12 : index}> : () -> !shape.size
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "shape.div"(%0, %1) : (!shape.size, index) -> !shape.size
    "func.return"(%2) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "fold_index_cast_on_index"}> ({
  ^bb0(%arg0: index):
    %0 = "shape.size_to_index"(%arg0) : (index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> tensor<?xindex>, sym_name = "fold_to_extent_tensor_on_tensor"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "shape.to_extent_tensor"(%arg0) : (tensor<?xindex>) -> tensor<?xindex>
    "func.return"(%0) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> (), sym_name = "fold_assuming_all_single_element"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "test.source"() : () -> !shape.witness
    %1 = "shape.assuming_all"(%0) : (!shape.witness) -> !shape.witness
    "consume.witness"(%1) : (!shape.witness) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> tensor<1xindex>, sym_name = "fold_tensor.cast_of_const_shape_returned"}> ({
  ^bb0(%arg0: i1):
    %0 = "shape.const_shape"() <{shape = dense<2> : tensor<1xindex>}> : () -> tensor<1xindex>
    %1 = "tensor.cast"(%0) : (tensor<1xindex>) -> tensor<1xindex>
    "func.return"(%1) : (tensor<1xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> tensor<?xindex>, sym_name = "dont_fold_tensor.cast_of_const_shape_returned_dynamic"}> ({
  ^bb0(%arg0: i1):
    %0 = "shape.const_shape"() <{shape = dense<2> : tensor<1xindex>}> : () -> tensor<1xindex>
    %1 = "tensor.cast"(%0) : (tensor<1xindex>) -> tensor<?xindex>
    "func.return"(%1) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> i1, sym_name = "is_broadcastable_on_same_shape"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.is_broadcastable"(%arg0, %arg0, %arg0) : (!shape.shape, !shape.shape, !shape.shape) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape, !shape.shape) -> i1, sym_name = "is_broadcastable_on_duplicate_shapes"}> ({
  ^bb0(%arg0: !shape.shape, %arg1: !shape.shape):
    %0 = "shape.is_broadcastable"(%arg0, %arg1, %arg0, %arg0, %arg0, %arg1) : (!shape.shape, !shape.shape, !shape.shape, !shape.shape, !shape.shape, !shape.shape) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape, !shape.shape) -> !shape.witness, sym_name = "cstr_broadcastable_on_duplicate_shapes"}> ({
  ^bb0(%arg0: !shape.shape, %arg1: !shape.shape):
    %0 = "shape.cstr_broadcastable"(%arg0, %arg1, %arg0, %arg0, %arg0, %arg1) : (!shape.shape, !shape.shape, !shape.shape, !shape.shape, !shape.shape, !shape.shape) -> !shape.witness
    "func.return"(%0) : (!shape.witness) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> !shape.shape, sym_name = "broadcast_on_same_shape"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.broadcast"(%arg0, %arg0, %arg0) : (!shape.shape, !shape.shape, !shape.shape) -> !shape.shape
    "func.return"(%0) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape, !shape.shape) -> !shape.shape, sym_name = "broadcast_on_duplicate_shapes"}> ({
  ^bb0(%arg0: !shape.shape, %arg1: !shape.shape):
    %0 = "shape.broadcast"(%arg0, %arg1, %arg0, %arg0, %arg0, %arg1) : (!shape.shape, !shape.shape, !shape.shape, !shape.shape, !shape.shape, !shape.shape) -> !shape.shape
    "func.return"(%0) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> (), sym_name = "broadcast_on_single_operand"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "shape.broadcast"(%arg0) : (tensor<?xindex>) -> tensor<?xindex>
    "use"(%0) : (tensor<?xindex>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3xindex>) -> tensor<?xindex>, sym_name = "broadcast_as_tensor_cast"}> ({
  ^bb0(%arg0: tensor<3xindex>):
    %0 = "shape.broadcast"(%arg0) : (tensor<3xindex>) -> tensor<?xindex>
    "func.return"(%0) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> !shape.shape, sym_name = "broadcast_as_from_extent_tensor"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "shape.broadcast"(%arg0) : (tensor<?xindex>) -> !shape.shape
    "func.return"(%0) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, tensor<?xindex>) -> tensor<?xindex>, sym_name = "shape_of_from_reshape"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: tensor<?xindex>):
    %0 = "tensor.reshape"(%arg0, %arg1) : (tensor<*xf32>, tensor<?xindex>) -> tensor<*xf32>
    %1 = "shape.shape_of"(%0) : (tensor<*xf32>) -> tensor<?xindex>
    "func.return"(%1) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x1xf32>, tensor<3xi32>) -> tensor<3xindex>, sym_name = "shape_of_from_reshape_int_to_index"}> ({
  ^bb0(%arg0: tensor<?x1xf32>, %arg1: tensor<3xi32>):
    %0 = "tensor.reshape"(%arg0, %arg1) : (tensor<?x1xf32>, tensor<3xi32>) -> tensor<?x1x1xf32>
    %1 = "shape.shape_of"(%0) : (tensor<?x1x1xf32>) -> tensor<3xindex>
    "func.return"(%1) : (tensor<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, tensor<5xindex>) -> tensor<?xindex>, sym_name = "shape_of_from_reshape_static_to_dynamic"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: tensor<5xindex>):
    %0 = "tensor.reshape"(%arg0, %arg1) : (tensor<*xf32>, tensor<5xindex>) -> tensor<*xf32>
    %1 = "shape.shape_of"(%0) : (tensor<*xf32>) -> tensor<?xindex>
    "func.return"(%1) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, tensor<?xindex>) -> tensor<5xindex>, sym_name = "shape_of_from_reshape_dynamic_to_static"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: tensor<?xindex>):
    %0 = "tensor.reshape"(%arg0, %arg1) : (tensor<*xf32>, tensor<?xindex>) -> tensor<*xf32>
    %1 = "shape.shape_of"(%0) : (tensor<*xf32>) -> tensor<5xindex>
    "func.return"(%1) : (tensor<5xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, tensor<5xindex>) -> tensor<5xindex>, sym_name = "shape_of_from_reshape_identical_types"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: tensor<5xindex>):
    %0 = "tensor.reshape"(%arg0, %arg1) : (tensor<*xf32>, tensor<5xindex>) -> tensor<*xf32>
    %1 = "shape.shape_of"(%0) : (tensor<*xf32>) -> tensor<5xindex>
    "func.return"(%1) : (tensor<5xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, tensor<?xindex>) -> !shape.shape, sym_name = "shape_of_from_reshape_nofold"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: tensor<?xindex>):
    %0 = "tensor.reshape"(%arg0, %arg1) : (tensor<*xf32>, tensor<?xindex>) -> tensor<*xf32>
    %1 = "shape.shape_of"(%0) : (tensor<*xf32>) -> !shape.shape
    "func.return"(%1) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> tensor<?xindex>, sym_name = "cast_extent_tensor"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<?x?x?xf32>) -> tensor<3xindex>
    %1 = "tensor.cast"(%0) : (tensor<3xindex>) -> tensor<?xindex>
    "func.return"(%1) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> tensor<3xindex>, sym_name = "cast_extent_tensor"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<?x?x?xf32>) -> tensor<?xindex>
    %1 = "tensor.cast"(%0) : (tensor<?xindex>) -> tensor<3xindex>
    "func.return"(%1) : (tensor<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?xf32>) -> tensor<3xindex>, sym_name = "cast_extent_tensor"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<?x?x?x?xf32>) -> tensor<?xindex>
    %1 = "tensor.cast"(%0) : (tensor<?xindex>) -> tensor<3xindex>
    "func.return"(%1) : (tensor<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>) -> tensor<3xindex>, sym_name = "cast_extent_tensor"}> ({
  ^bb0(%arg0: tensor<*xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<*xf32>) -> tensor<?xindex>
    %1 = "tensor.cast"(%0) : (tensor<?xindex>) -> tensor<3xindex>
    "func.return"(%1) : (tensor<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> !shape.shape, sym_name = "max_same_arg"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.max"(%arg0, %arg0) : (!shape.shape, !shape.shape) -> !shape.shape
    "func.return"(%0) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> !shape.shape, sym_name = "min_same_arg"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.min"(%arg0, %arg0) : (!shape.shape, !shape.shape) -> !shape.shape
    "func.return"(%0) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x4xf32>) -> (), sym_name = "cstr_broadcastable_folding"}> ({
  ^bb0(%arg0: tensor<?x4xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<?x4xf32>) -> tensor<2xindex>
    %1 = "shape.const_shape"() <{shape = dense<4> : tensor<1xindex>}> : () -> tensor<1xindex>
    %2 = "shape.cstr_broadcastable"(%0, %1) : (tensor<2xindex>, tensor<1xindex>) -> !shape.witness
    "use"(%2) : (!shape.witness) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, tensor<3xindex>) -> (!shape.witness, tensor<?xindex>), sym_name = "cast_extent_tensor_operands"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: tensor<3xindex>):
    %0 = "tensor.cast"(%arg0) : (tensor<?xindex>) -> tensor<3xindex>
    %1 = "tensor.cast"(%arg1) : (tensor<3xindex>) -> tensor<?xindex>
    %2 = "shape.cstr_broadcastable"(%0, %1) : (tensor<3xindex>, tensor<?xindex>) -> !shape.witness
    %3 = "shape.broadcast"(%0, %1) : (tensor<3xindex>, tensor<?xindex>) -> tensor<?xindex>
    "func.return"(%2, %3) : (!shape.witness, tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xindex>, tensor<3xindex>) -> tensor<?xindex>, sym_name = "concretize_broadcast_result_type"}> ({
  ^bb0(%arg0: tensor<2xindex>, %arg1: tensor<3xindex>):
    %0 = "shape.broadcast"(%arg0, %arg1) : (tensor<2xindex>, tensor<3xindex>) -> tensor<?xindex>
    "func.return"(%0) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf64>) -> index, sym_name = "extract_shapeof"}> ({
  ^bb0(%arg0: tensor<?x?xf64>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "shape.shape_of"(%arg0) : (tensor<?x?xf64>) -> tensor<2xindex>
    %2 = "tensor.extract"(%1, %0) : (tensor<2xindex>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> !shape.size, sym_name = "add_poison"}> ({
    %0 = "shape.const_size"() <{value = 2 : index}> : () -> !shape.size
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> !shape.size
    %2 = "shape.add"(%0, %1) : (!shape.size, !shape.size) -> !shape.size
    "func.return"(%2) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<?xindex>, sym_name = "shape_of_0d"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<f32>) -> tensor<?xindex>
    "func.return"(%0) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

