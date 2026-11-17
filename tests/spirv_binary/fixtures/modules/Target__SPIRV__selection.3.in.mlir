"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> (), sym_name = "selection_yield"}> ({
  ^bb0(%arg0: i1):
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    %2 = "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg0)[^bb1, ^bb2] <{branch_weights = [5 : i32, 10 : i32], operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %3 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      "spirv.Branch"(%3)[^bb3] : (i32) -> ()
    ^bb2:  // pred: ^bb0
      %4 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
      "spirv.Branch"(%4)[^bb3] : (i32) -> ()
    ^bb3(%5: i32):  // 2 preds: ^bb1, ^bb2
      "spirv.mlir.merge"(%5) : (i32) -> ()
    }) : () -> i32
    "spirv.Store"(%1, %2) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "main"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @main, interface = []}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @main, values = [1 : i32, 1 : i32, 1 : i32]}> : () -> ()
}) : () -> ()

