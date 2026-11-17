"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "selection_switch"}> ({
  ^bb0(%arg0: i32):
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %3 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %4 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %5 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.Switch"(%arg0)[^bb1, ^bb2, ^bb3, ^bb4] <{case_operand_segments = array<i32: 0, 0, 0>, literals = dense<[0, 1, 2]> : vector<3xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Store"(%5, %1) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb5] : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Store"(%5, %2) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb5] : () -> ()
    ^bb3:  // pred: ^bb0
      "spirv.Store"(%5, %3) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb5] : () -> ()
    ^bb4:  // pred: ^bb0
      "spirv.Store"(%5, %4) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb5] : () -> ()
    ^bb5:  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "main"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @main, interface = []}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @main, values = [1 : i32, 1 : i32, 1 : i32]}> : () -> ()
}) : () -> ()

