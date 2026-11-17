"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "loop"}> ({
  ^bb0(%arg0: i32):
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Variable"(%0) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %3 = "spirv.Variable"(%2) <{storage_class = #spirv.storage_class<Function>}> : (i32) -> !spirv.ptr<i32, Function>
    "spirv.Branch"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<Unroll>}> ({
      "spirv.Branch"()[^bb1] : () -> ()
    ^bb1:  // 2 preds: ^bb0, ^bb4
      %4 = "spirv.Load"(%1) : (!spirv.ptr<i32, Function>) -> i32
      %5 = "spirv.SLessThan"(%4, %arg0) : (i32, i32) -> i1
      "spirv.BranchConditional"(%5)[^bb2, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %6 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      "spirv.Store"(%3, %6) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<DontUnroll>}> ({
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb1:  // 2 preds: ^bb0, ^bb3
        %10 = "spirv.Load"(%3) : (!spirv.ptr<i32, Function>) -> i32
        %11 = "spirv.SLessThan"(%10, %arg0) : (i32, i32) -> i1
        "spirv.BranchConditional"(%11)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb2:  // pred: ^bb1
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb3:  // pred: ^bb2
        %12 = "spirv.Load"(%3) : (!spirv.ptr<i32, Function>) -> i32
        %13 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
        %14 = "spirv.IAdd"(%12, %13) : (i32, i32) -> i32
        "spirv.Store"(%3, %14) : (!spirv.ptr<i32, Function>, i32) -> ()
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb4:  // pred: ^bb1
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Branch"()[^bb4] : () -> ()
    ^bb4:  // pred: ^bb3
      %7 = "spirv.Load"(%1) : (!spirv.ptr<i32, Function>) -> i32
      %8 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %9 = "spirv.IAdd"(%7, %8) : (i32, i32) -> i32
      "spirv.Store"(%1, %9) : (!spirv.ptr<i32, Function>, i32) -> ()
      "spirv.Branch"()[^bb1] : () -> ()
    ^bb5:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "main"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @main, interface = []}> : () -> ()
}) : () -> ()