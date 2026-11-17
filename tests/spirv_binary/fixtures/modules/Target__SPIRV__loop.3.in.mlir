"spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.0, [Kernel, Linkage, Addresses, Int64], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: i64):
    %0 = "spirv.Constant"() <{value = 0 : i64}> : () -> i64
    %1 = "spirv.Constant"() <{value = true}> : () -> i1
    %2 = "spirv.Constant"() <{value = false}> : () -> i1
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%arg0)[^bb1] : (i64) -> ()
    ^bb1(%3: i64):  // 2 preds: ^bb0, ^bb2
      %4 = "spirv.SGreaterThan"(%3, %0) : (i64, i64) -> i1
      %5 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i1, Function>
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
        "spirv.BranchConditional"(%4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb1:  // pred: ^bb0
        "spirv.Store"(%5, %1) : (!spirv.ptr<i1, Function>, i1) -> ()
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb2:  // pred: ^bb0
        "spirv.Store"(%5, %2) : (!spirv.ptr<i1, Function>, i1) -> ()
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb3:  // 2 preds: ^bb1, ^bb2
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      %6 = "spirv.Load"(%5) : (!spirv.ptr<i1, Function>) -> i1
      "spirv.BranchConditional"(%6, %3)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i64) -> ()
    ^bb2(%7: i64):  // pred: ^bb1
      %8 = "spirv.SLessThan"(%7, %0) : (i64, i64) -> i1
      "spirv.Store"(%5, %8) : (!spirv.ptr<i1, Function>, i1) -> ()
      "spirv.Branch"(%7)[^bb1] : (i64) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

