"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "tensor_extract_constant"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<[[[1, 2, 3], [4, 5, 6]], [[7, 8, 9], [10, 11, 12]]]> : tensor<2x2x3xi32>}> : () -> tensor<2x2x3xi32>
    %1 = "tensor.extract"(%0, %arg0, %arg1, %arg2) : (tensor<2x2x3xi32>, index, index, index) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "test_spirv_unsupported_type_index"}> ({
  ^bb0(%arg1: index):
    %2 = "arith.constant"() <{value = dense<[1, 2]> : tensor<2xindex>}> : () -> tensor<2xindex>
    %3 = "tensor.extract"(%2, %arg1) : (tensor<2xindex>, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "test_spirv_unsupported_type_i128"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = dense<[1, 2]> : tensor<2xi128>}> : () -> tensor<2xi128>
    %1 = "tensor.extract"(%0, %arg0) : (tensor<2xi128>, index) -> i128
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "tensor_0d"}> ({
    %4 = "arith.constant"() <{value = dense<1> : tensor<i32>}> : () -> tensor<i32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "tensor_1d"}> ({
    %3 = "arith.constant"() <{value = dense<[1, 2, 3]> : tensor<3xi32>}> : () -> tensor<3xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "tensor_2d"}> ({
    %2 = "arith.constant"() <{value = dense<[[1, 2, 3], [4, 5, 6]]> : tensor<2x3xi32>}> : () -> tensor<2x3xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "tensor_2d_empty"}> ({
    %1 = "arith.constant"() <{value = dense<> : tensor<2x0xi32>}> : () -> tensor<2x0xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "very_large_tensor"}> ({
    %0 = "arith.constant"() <{value = dense<1> : tensor<4294967296xi32>}> : () -> tensor<4294967296xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

