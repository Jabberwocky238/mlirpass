"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "fmul_kernel"}> ({
    %0 = "spirv.Constant"() <{value = 43 : i32}> : () -> i32
    "spirv.Branch"(%0)[^bb1] : (i32) -> ()
  ^bb1(%1: i32):  // pred: ^bb0
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%1)[^bb1] : (i32) -> ()
    ^bb1(%9: i32):  // 2 preds: ^bb0, ^bb2
      %10 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %11 = "spirv.SLessThan"(%9, %10) : (i32, i32) -> i1
      "spirv.BranchConditional"(%11)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %12 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %13 = "spirv.IAdd"(%9, %12) : (i32, i32) -> i32
      "spirv.Branch"(%13)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %2 = "spirv.Constant"() <{value = 44 : i32}> : () -> i32
    "spirv.Branch"(%2)[^bb2] : (i32) -> ()
  ^bb2(%3: i32):  // pred: ^bb1
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%3)[^bb1] : (i32) -> ()
    ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
      %5 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %6 = "spirv.SLessThan"(%4, %5) : (i32, i32) -> i1
      "spirv.BranchConditional"(%6)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %7 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %8 = "spirv.IAdd"(%4, %7) : (i32, i32) -> i32
      "spirv.Branch"(%8)[^bb1] : (i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @fmul_kernel, interface = []}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @fmul_kernel, values = [32 : i32, 1 : i32, 1 : i32]}> : () -> ()
}) : () -> ()