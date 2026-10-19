"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "binary_ops"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "shape.add"(%arg0, %arg1) : (index, index) -> index
    %1 = "shape.mul"(%arg0, %arg1) : (index, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.size, !shape.size) -> (), sym_name = "binary_ops_on_size"}> ({
  ^bb0(%arg0: !shape.size, %arg1: !shape.size):
    %0 = "shape.add"(%arg0, %arg1) : (!shape.size, !shape.size) -> !shape.size
    %1 = "shape.mul"(%arg0, %arg1) : (!shape.size, !shape.size) -> !shape.size
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> index, sym_name = "rank"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "shape.rank"(%arg0) : (tensor<?xindex>) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, !shape.size) -> !shape.size, sym_name = "get_extent"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: !shape.size):
    %0 = "shape.get_extent"(%arg0, %arg1) : (tensor<?xindex>, !shape.size) -> !shape.size
    "func.return"(%0) : (!shape.size) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!shape.shape) -> (), sym_name = "rank"}> ({
  ^bb0(%arg0: !shape.shape):
    %0 = "shape.rank"(%arg0) : (!shape.shape) -> !shape.size
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>, index) -> index, sym_name = "dim"}> ({
  ^bb0(%arg0: tensor<2x3xf32>, %arg1: index):
    %0 = "shape.dim"(%arg0, %arg1) : (tensor<2x3xf32>, index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xf32>, index) -> index, sym_name = "get_extent_shape_of"}> ({
  ^bb0(%arg0: tensor<2x3xf32>, %arg1: index):
    %0 = "shape.shape_of"(%arg0) : (tensor<2x3xf32>) -> tensor<?xindex>
    %1 = "shape.get_extent"(%0, %arg1) : (tensor<?xindex>, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, index) -> index, sym_name = "get_extent_from_extent_tensor"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: index):
    %0 = "shape.get_extent"(%arg0, %arg1) : (tensor<?xindex>, index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<3xindex>, sym_name = "const_shape"}> ({
    %0 = "shape.const_shape"() <{shape = dense<[1, 2, 3]> : tensor<3xindex>}> : () -> tensor<3xindex>
    "func.return"(%0) : (tensor<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<0xindex>, sym_name = "const_shape_zero_elements"}> ({
    %0 = "shape.const_shape"() <{shape = dense<> : tensor<0xindex>}> : () -> tensor<0xindex>
    "func.return"(%0) : (tensor<0xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, tensor<?xindex>, tensor<?xindex>) -> tensor<?xindex>, sym_name = "any_of_three"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: tensor<?xindex>, %arg2: tensor<?xindex>):
    %0 = "shape.any"(%arg0, %arg1, %arg2) : (tensor<?xindex>, tensor<?xindex>, tensor<?xindex>) -> tensor<?xindex>
    "func.return"(%0) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> tensor<?xindex>, sym_name = "any_of_one"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "shape.any"(%arg0) : (tensor<?xindex>) -> tensor<?xindex>
    "func.return"(%0) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "const_size"}> ({
    %0 = "shape.const_size"() <{value = 42 : index}> : () -> !shape.size
    %1 = "shape.size_to_index"(%0) : (!shape.size) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> tensor<3xindex>, sym_name = "to_extent_tensor"}> ({
  ^bb0(%arg4: tensor<?xindex>):
    %3 = "shape.to_extent_tensor"(%arg4) : (tensor<?xindex>) -> tensor<3xindex>
    "func.return"(%3) : (tensor<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?xindex>) -> index, sym_name = "shape_reduce"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "shape.reduce"(%arg0, %0) ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index):
      %2 = "arith.muli"(%arg3, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "shape.yield"(%2) : (index) -> ()
    }) : (tensor<?xindex>, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>) -> (), sym_name = "shape_of"}> ({
  ^bb0(%arg0: tensor<*xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<*xf32>) -> !shape.shape
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>) -> (), sym_name = "shape_of_unranked"}> ({
  ^bb0(%arg0: tensor<*xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<*xf32>) -> tensor<?xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x3xf32>) -> (), sym_name = "shape_of_stat"}> ({
  ^bb0(%arg0: tensor<1x2x3xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<1x2x3xf32>) -> !shape.shape
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2x3xf32>) -> (), sym_name = "shape_of_stat"}> ({
  ^bb0(%arg0: tensor<1x2x3xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<1x2x3xf32>) -> tensor<?xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> (), sym_name = "shape_of_zero_d"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<f32>) -> tensor<?xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5x?xf32>) -> (), sym_name = "shape_of_dyn"}> ({
  ^bb0(%arg0: tensor<1x5x?xf32>):
    %0 = "shape.shape_of"(%arg0) : (tensor<1x5x?xf32>) -> tensor<?xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, tensor<?xindex>) -> i1, sym_name = "shape_eq"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: tensor<?xindex>):
    %0 = "shape.shape_eq"(%arg0, %arg1) : (tensor<?xindex>, tensor<?xindex>) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, tensor<?xindex>, tensor<?xindex>) -> i1, sym_name = "shape_eq"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: tensor<?xindex>, %arg2: tensor<?xindex>):
    %0 = "shape.shape_eq"(%arg0, %arg1, %arg2) : (tensor<?xindex>, tensor<?xindex>, tensor<?xindex>) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, !shape.shape) -> !shape.shape, sym_name = "broadcast"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: !shape.shape):
    %0 = "shape.broadcast"(%arg0, %arg1) : (tensor<?xindex>, !shape.shape) -> !shape.shape
    "func.return"(%0) : (!shape.shape) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xindex>, tensor<3xindex>, tensor<2xindex>) -> i1, sym_name = "try_is_broadcastable"}> ({
  ^bb0(%arg0: tensor<2xindex>, %arg1: tensor<3xindex>, %arg2: tensor<2xindex>):
    %0 = "shape.is_broadcastable"(%arg0, %arg1, %arg2) : (tensor<2xindex>, tensor<3xindex>, tensor<2xindex>) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xindex>, tensor<3xindex>, tensor<2xindex>) -> !shape.witness, sym_name = "broadcast"}> ({
  ^bb0(%arg0: tensor<2xindex>, %arg1: tensor<3xindex>, %arg2: tensor<2xindex>):
    %0 = "shape.cstr_broadcastable"(%arg0, %arg1, %arg2) : (tensor<2xindex>, tensor<3xindex>, tensor<2xindex>) -> !shape.witness
    "func.return"(%0) : (!shape.witness) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xindex>, tensor<3xindex>, tensor<2xindex>) -> (), sym_name = "broadcast_3_shapes_different_extents"}> ({
  ^bb0(%arg0: tensor<2xindex>, %arg1: tensor<3xindex>, %arg2: tensor<2xindex>):
    %0 = "shape.broadcast"(%arg0, %arg1, %arg2) : (tensor<2xindex>, tensor<3xindex>, tensor<2xindex>) -> tensor<?xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xindex>, tensor<3xindex>) -> tensor<3xindex>, sym_name = "broadcast_to_known_rank"}> ({
  ^bb0(%arg0: tensor<1xindex>, %arg1: tensor<3xindex>):
    %0 = "shape.broadcast"(%arg0, %arg1) : (tensor<1xindex>, tensor<3xindex>) -> tensor<3xindex>
    "func.return"(%0) : (tensor<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>, index) -> (tensor<?xindex>, tensor<?xindex>), sym_name = "split_at"}> ({
  ^bb0(%arg0: tensor<?xindex>, %arg1: index):
    %0:2 = "shape.split_at"(%arg0, %arg1) : (tensor<?xindex>, index) -> (tensor<?xindex>, tensor<?xindex>)
    "func.return"(%0#0, %0#1) : (tensor<?xindex>, tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

