"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (i32, i32), sym_name = "unknown_cf_in_loop", sym_visibility = "private"}> ({
  ^bb0(%arg0: f32):
    %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = -1 : i32}> : () -> i32
    %2 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
    %3 = "spirv.Variable"() <{storage_class = #spirv.storage_class<Function>}> : () -> !spirv.ptr<i32, Function>
    "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      "spirv.Branch"(%0, %1)[^bb1] : (i32, i32) -> ()
    ^bb1(%6: i32, %7: i32):  // 2 preds: ^bb0, ^bb2
      %8 = "spirv.SLessThan"(%6, %1) : (i32, i32) -> i1
      "spirv.BranchConditional"(%8)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %9 = "spirv.IAdd"(%6, %7) : (i32, i32) -> i32
      "spirv.Store"(%2, %9) : (!spirv.ptr<i32, Function>, i32) -> ()
      %10 = "spirv.IAdd"(%6, %0) : (i32, i32) -> i32
      "spirv.Branch"(%10, %9)[^bb1] : (i32, i32) -> ()
    ^bb3:  // pred: ^bb1
      "spirv.mlir.merge"() : () -> ()
    }) : () -> ()
    %4 = "spirv.Load"(%3) : (!spirv.ptr<i32, Function>) -> i32
    %5 = "spirv.Load"(%2) : (!spirv.ptr<i32, Function>) -> i32
    "func.return"(%5, %4) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

