"spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Linkage, Addresses, Int64], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: i64):
    %0 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i1, Function>
    "spirv.Branch"(%arg0)[^bb1] : (i64) -> ()
  ^bb1(%1: i64):  // pred: ^bb0
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%1)[^bb1] : (i64) -> ()
    ^bb1(%2: i64):  // 2 preds: ^bb0, ^bb4
      "spirv.Branch"()[^bb2] : () -> ()
    ^bb2:  // pred: ^bb1
      %3 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
      %4 = "spirv.SGreaterThan"(%2, %3) : (i64, i64) -> i1
      "spirv.Branch"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
        "spirv.BranchConditional"(%4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb1:  // pred: ^bb0
        %9 = "spirv.Constant"() <{value = true}> : () -> i1
        "spirv.Store"(%0, %9) : (!spirv.ptr<i1, Function>, i1) -> ()
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb2:  // pred: ^bb0
        %10 = "spirv.Constant"() <{value = false}> : () -> i1
        "spirv.Store"(%0, %10) : (!spirv.ptr<i1, Function>, i1) -> ()
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb3:  // 2 preds: ^bb1, ^bb2
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      %5 = "spirv.Load"(%0) : (!spirv.ptr<i1, Function>) -> i1
      "spirv.BranchConditional"(%5, %2)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i64) -> ()
    ^bb4(%6: i64):  // pred: ^bb3
      %7 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
      %8 = "spirv.SLessThan"(%6, %7) : (i64, i64) -> i1
      "spirv.Store"(%0, %8) : (!spirv.ptr<i1, Function>, i1) -> ()
      "spirv.Branch"(%6)[^bb1] : (i64) -> ()
    ^bb5:  // pred: ^bb3
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()