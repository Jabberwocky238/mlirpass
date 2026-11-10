"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32) -> (), sym_name = "switch_no_result"}> ({
  ^bb0(%arg3: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg4: i32):
    %11 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %12 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.Switch"(%arg4)[^bb2, ^bb1] <{case_operand_segments = array<i32: 0>, literals = dense<2> : vector<1xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
    ^bb1:  // pred: ^bb0
      %13 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %14 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %15 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %16 = "spirv.AccessChain"(%arg3, %13, %12) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%16, %11) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "switch_yield"}> ({
  ^bb0(%arg2: i32):
    %6 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.Switch"(%arg2)[^bb3, ^bb1, ^bb2] <{case_operand_segments = array<i32: 0, 0>, literals = dense<[2, 5]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
    ^bb1:  // pred: ^bb0
      %8 = "spirv.Constant"() <{value = 10 : i32}> : () -> i32
      "spirv.Store"(%6, %8) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb4] : () -> ()
    ^bb2:  // pred: ^bb0
      %9 = "spirv.Constant"() <{value = 20 : i32}> : () -> i32
      "spirv.Store"(%6, %9) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb4] : () -> ()
    ^bb3:  // pred: ^bb0
      %10 = "spirv.Constant"() <{value = 30 : i32}> : () -> i32
      "spirv.Store"(%6, %10) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb4] : () -> ()
    ^bb4:  // 3 preds: ^bb1, ^bb2, ^bb3
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %7 = "spirv.Load"(%6) : (!spirv.ptr<i32, Function>) -> i32
    "spirv.ReturnValue"(%7) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32) -> (), sym_name = "switch_selection_control"}> ({
  ^bb0(%arg0: !spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, %arg1: i32):
    %0 = "spirv.Constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<Flatten>}> ({
      "spirv.Switch"(%arg1)[^bb2, ^bb1] <{case_operand_segments = array<i32: 0>, literals = dense<2> : vector<1xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
    ^bb1:  // pred: ^bb0
      %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %3 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %4 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %5 = "spirv.AccessChain"(%arg0, %2, %1) : (!spirv.ptr<!spirv.struct<(!spirv.array<10 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      "spirv.Store"(%5, %0) : (!spirv.ptr<f32, StorageBuffer>, f32) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()

