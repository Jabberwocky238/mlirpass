"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> i32, sym_name = "selection"}> ({
  ^bb0(%arg0: i1):
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.BranchConditional"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      "spirv.ReturnValue"(%1) : (i32) -> ()
    ^bb2:  // pred: ^bb0
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %0 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    "spirv.ReturnValue"(%0) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "main"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @main, interface = []}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @main, values = [1 : i32, 1 : i32, 1 : i32]}> : () -> ()
}) : () -> ()

