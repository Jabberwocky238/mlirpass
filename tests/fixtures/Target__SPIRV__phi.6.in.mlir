"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "fmul_kernel"}> ({
    %0 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 43 : i32}> : () -> i32
    %2 = "spirv.Constant"() <{value = 44 : i32}> : () -> i32
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%1)[^bb1] : (i32) -> ()
    ^bb1(%6: i32):  // 2 preds: ^bb0, ^bb2
      %7 = "spirv.SLessThan"(%6, %0) : (i32, i32) -> i1
      "spirv.BranchConditional"(%7)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %8 = "spirv.IAdd"(%6, %0) : (i32, i32) -> i32
      "spirv.Branch"(%8)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%2)[^bb1] : (i32) -> ()
    ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb2
      %4 = "spirv.SLessThan"(%3, %0) : (i32, i32) -> i1
      "spirv.BranchConditional"(%4)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %5 = "spirv.IAdd"(%3, %0) : (i32, i32) -> i32
      "spirv.Branch"(%5)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @fmul_kernel, interface = []}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @fmul_kernel, values = [32 : i32, 1 : i32, 1 : i32]}> : () -> ()
}) : () -> ()

