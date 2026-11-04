"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index), sym_name = "empty_tensor_static_dim"}> ({
    %0 = "arith.constant"() <{value = 6 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    "func.return"(%0, %1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "empty_tensor_dynamic_dim"}> ({
  ^bb0(%arg0: index):
    "func.return"(%arg0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (index, index), sym_name = "empty_tensor_dynamic_dim2"}> ({
  ^bb0(%arg0: index, %arg1: index):
    "func.return"(%arg0, %arg1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
#map1 = affine_map<()[s0, s1] -> (-s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (index, index), sym_name = "remove_dim_result_uses"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<?x?xf32>, index) -> index
    %3 = "tensor.dim"(%arg1, %0) : (tensor<?x?xf32>, index) -> index
    %4 = "affine.apply"(%2, %3) <{map = #map}> : (index, index) -> index
    %5 = "tensor.dim"(%arg0, %1) : (tensor<?x?xf32>, index) -> index
    %6 = "tensor.dim"(%arg1, %0) : (tensor<?x?xf32>, index) -> index
    %7 = "affine.apply"(%5, %6) <{map = #map1}> : (index, index) -> index
    "func.return"(%4, %7) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> index, sym_name = "remove_dim_result_uses_outs"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    "func.return"(%arg1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> (index, index, index, index), sym_name = "remove_dim_result_uses_sequence"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<?x?xf32>, index) -> index
    %3 = "tensor.dim"(%arg1, %0) : (tensor<?x?xf32>, index) -> index
    %4 = "tensor.dim"(%arg0, %0) : (tensor<?x?xf32>, index) -> index
    %5 = "tensor.dim"(%arg1, %0) : (tensor<?x?xf32>, index) -> index
    "func.return"(%2, %3, %4, %5) : (index, index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> (index, index), sym_name = "keep_result_dim_uses_sequence2"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?xf32>, index) -> index
    "func.return"(%1, %arg1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>) -> (index, index), sym_name = "empty_tensor_dim_of_linalg_result"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?xf32>, index) -> index
    %2 = "tensor.dim"(%arg0, %0) : (tensor<?xf32>, index) -> index
    "func.return"(%1, %2) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6x5x?xf32>, index) -> (index, index, index), sym_name = "dim_reshape_expansion"}> ({
  ^bb0(%arg0: tensor<6x5x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    "func.return"(%0, %1, %arg1) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 * 28)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x5x4x?x7xf32>) -> (index, index), sym_name = "dim_reshape_collapse"}> ({
  ^bb0(%arg0: tensor<2x3x5x4x?x7xf32>):
    %0 = "arith.constant"() <{value = 5 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<2x3x5x4x?x7xf32>, index) -> index
    %3 = "affine.apply"(%2) <{map = #map}> : (index) -> index
    "func.return"(%0, %3) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 + 5)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1 + 4)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x?x?xf32>, index, index, f32) -> (index, index, index), sym_name = "dim_of_pad_op"}> ({
  ^bb0(%arg0: tensor<2x?x?xf32>, %arg1: index, %arg2: index, %arg3: f32):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 12 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<2x?x?xf32>, index) -> index
    %4 = "affine.apply"(%3, %arg1) <{map = #map}> : (index, index) -> index
    %5 = "tensor.dim"(%arg0, %0) : (tensor<2x?x?xf32>, index) -> index
    %6 = "affine.apply"(%5, %arg2) <{map = #map1}> : (index, index) -> index
    "func.return"(%1, %4, %6) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x16x?xf32>, tensor<2x?x?xf32>) -> (index, index, index), sym_name = "dim_of_softmax_op"}> ({
  ^bb0(%arg0: tensor<?x16x?xf32>, %arg1: tensor<2x?x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 16 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %0) : (tensor<?x16x?xf32>, index) -> index
    "func.return"(%0, %1, %2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

