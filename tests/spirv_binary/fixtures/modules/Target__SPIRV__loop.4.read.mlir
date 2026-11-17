"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "loop_yield"}> ({
  ^bb0(%arg0: i32):
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    "spirv.Branch"(%2)[^bb1] : (i32) -> ()
  ^bb1(%3: i32):  // pred: ^bb0
    %4 = "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%3)[^bb1] : (i32) -> ()
    ^bb1(%5: i32):  // 2 preds: ^bb0, ^bb3
      %6 = "spirv.SLessThan"(%5, %arg0) : (i32, i32) -> i1
      "spirv.BranchConditional"(%6)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      %7 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %8 = "spirv.IAdd"(%5, %7) : (i32, i32) -> i32
      "spirv.Branch"(%8)[^bb1] : (i32) -> ()
    ^bb4:  // pred: ^bb1
      "spirv.mlir.merge"(%5) : (i32) -> ()
    }) : () -> i32
    "spirv.Store"(%1, %4) : (!spirv.ptr<i32, Function>, i32) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()