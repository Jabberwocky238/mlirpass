"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32, i32) -> i32, sym_name = "tensor_extract_constant"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
    %0 = "spirv.Constant"() <{value = dense<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]> : tensor<12xi32>}> : () -> !spirv.array<12 x i32>
    %1 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<!spirv.array<12 x i32>, Function>
    "spirv.Store"(%1, %0) : (!spirv.ptr<!spirv.array<12 x i32>, Function>, !spirv.array<12 x i32>) -> ()
    %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 6 : i32}> : () -> i32
    %4 = "spirv.IMul"(%arg0, %3) : (i32, i32) -> i32
    %5 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %6 = "spirv.IMul"(%arg1, %5) : (i32, i32) -> i32
    %7 = "spirv.IAdd"(%6, %4) : (i32, i32) -> i32
    %8 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %9 = "spirv.IAdd"(%arg2, %7) : (i32, i32) -> i32
    %10 = "spirv.AccessChain"(%1, %9) : (!spirv.ptr<!spirv.array<12 x i32>, Function>, i32) -> !spirv.ptr<i32, Function>
    %11 = "spirv.Load"(%10) : (!spirv.ptr<i32, Function>) -> i32
    "spirv.ReturnValue"(%11) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test_spirv_unsupported_type_index"}> ({
  ^bb0(%arg1: i32):
    %3 = "builtin.unrealized_conversion_cast"(%arg1) : (i32) -> index
    %4 = "spirv.Constant"() <{value = dense<[1, 2]> : tensor<2xi32>}> : () -> !spirv.array<2 x i32>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (!spirv.array<2 x i32>) -> tensor<2xindex>
    %6 = "tensor.extract"(%5, %3) : (tensor<2xindex>, index) -> index
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test_spirv_unsupported_type_i128"}> ({
  ^bb0(%arg0: i32):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (i32) -> index
    %1 = "arith.constant"() <{value = dense<[1, 2]> : tensor<2xi128>}> : () -> tensor<2xi128>
    %2 = "tensor.extract"(%1, %0) : (tensor<2xi128>, index) -> i128
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "tensor_0d"}> ({
    %4 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "tensor_1d"}> ({
    %3 = "spirv.Constant"() <{value = dense<[1, 2, 3]> : tensor<3xi32>}> : () -> !spirv.array<3 x i32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "tensor_2d"}> ({
    %2 = "spirv.Constant"() <{value = dense<[1, 2, 3, 4, 5, 6]> : tensor<6xi32>}> : () -> !spirv.array<6 x i32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "tensor_2d_empty"}> ({
    %1 = "arith.constant"() <{value = dense<> : tensor<2x0xi32>}> : () -> tensor<2x0xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "very_large_tensor"}> ({
    %0 = "arith.constant"() <{value = dense<1> : tensor<4294967296xi32>}> : () -> tensor<4294967296xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

