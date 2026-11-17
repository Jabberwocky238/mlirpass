"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "loop"}> ({
  ^bb0(%arg0: i32):
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    "spirv.Branch"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"()[^bb1] : () -> ()
    ^bb1:  // 2 preds: ^bb0, ^bb3
      %2 = "spirv.Load"(%1) : (!spirv.ptr<i32, Function>) -> i32
      %3 = "spirv.SLessThan"(%2, %arg0) : (i32, i32) -> i1
      "spirv.BranchConditional"(%3)[^bb2, ^bb4] <{branch_weights = [1 : i32, 1 : i32], operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      %4 = "spirv.Load"(%1) : (!spirv.ptr<i32, Function>) -> i32
      %5 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %6 = "spirv.IAdd"(%4, %5) : (i32, i32) -> i32
      "spirv.Store"(%1, %6) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb1] : () -> ()
    ^bb4:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "main"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @main, interface = []}> : () -> ()
}) : () -> ()