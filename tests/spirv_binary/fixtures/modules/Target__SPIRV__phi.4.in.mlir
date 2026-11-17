"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "foo"}> ({
    %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
    "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      %1 = "spirv.Constant"() <{value = true}> : () -> i1
      "spirv.BranchConditional"(%1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      "spirv.Branch"(%2)[^bb3] : (i32) -> ()
    ^bb2:  // pred: ^bb0
      %3 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      "spirv.Branch"(%3)[^bb3] : (i32) -> ()
    ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
      "spirv.Store"(%0, %4) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Return"() : () -> ()
    ^bb4:  // no predecessors
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "main"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @main, interface = []}> : () -> ()
}) : () -> ()

