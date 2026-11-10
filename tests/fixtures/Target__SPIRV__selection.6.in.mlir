"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "switch_default_only"}> ({
  ^bb0(%arg0: i32):
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      "spirv.Switch"(%arg0)[^bb1] <{case_operand_segments = array<i32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Branch"()[^bb2] : () -> ()
    ^bb2:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

