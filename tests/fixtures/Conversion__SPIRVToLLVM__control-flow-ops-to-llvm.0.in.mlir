"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "branch_without_arguments"}> ({
      "spirv.Branch"()[^bb1] : () -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "branch_with_arguments"}> ({
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %1 = "spirv.Constant"() <{value = true}> : () -> i1
      "spirv.Branch"(%0, %1)[^bb1] : (i32, i1) -> ()
    ^bb1(%2: i32, %3: i1):  // pred: ^bb0
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "cond_branch_without_arguments"}> ({
      %7 = "spirv.Constant"() <{value = true}> : () -> i1
      "spirv.BranchConditional"(%7)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Return"() : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "cond_branch_with_arguments_nested"}> ({
      %0 = "spirv.Constant"() <{value = true}> : () -> i1
      %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %2 = "spirv.Constant"() <{value = false}> : () -> i1
      "spirv.BranchConditional"(%0, %1, %2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (i1, i32, i1) -> ()
    ^bb1(%3: i32, %4: i1):  // pred: ^bb0
      "spirv.BranchConditional"(%4, %3, %3)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 2>}> : (i1, i32, i32) -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Return"() : () -> ()
    ^bb3:  // pred: ^bb1
      "spirv.Return"() : () -> ()
    ^bb4(%5: i32, %6: i32):  // pred: ^bb1
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> (), sym_name = "cond_branch_with_weights"}> ({
    ^bb0(%arg0: i1):
      "spirv.BranchConditional"(%arg0)[^bb1, ^bb2] <{branch_weights = [1 : i32, 2 : i32], operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "spirv.Return"() : () -> ()
    ^bb2:  // pred: ^bb0
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "empty_loop"}> ({
      "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
      }) : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "infinite_loop"}> ({
    ^bb0(%arg0: i32):
      "spirv.mlir.loop"() <{loop_control = #spirv.loop_control<None>}> ({
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb1:  // 2 preds: ^bb0, ^bb3
        %0 = "spirv.Constant"() <{value = true}> : () -> i1
        "spirv.BranchConditional"(%0)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb2:  // pred: ^bb1
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb3:  // pred: ^bb2
        "spirv.Branch"()[^bb1] : () -> ()
      ^bb4:  // pred: ^bb1
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "selection_empty"}> ({
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
      }) : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "selection_with_merge_block_only"}> ({
      %5 = "spirv.Constant"() <{value = true}> : () -> i1
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
        "spirv.BranchConditional"(%5)[^bb1, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb1:  // 2 preds: ^bb0, ^bb0
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "selection_with_true_block_only"}> ({
      %4 = "spirv.Constant"() <{value = true}> : () -> i1
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
        "spirv.BranchConditional"(%4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb1:  // pred: ^bb0
        "spirv.Branch"()[^bb2] : () -> ()
      ^bb2:  // 2 preds: ^bb0, ^bb1
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "selection_with_both_true_and_false_block"}> ({
      %3 = "spirv.Constant"() <{value = true}> : () -> i1
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
        "spirv.BranchConditional"(%3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb1:  // pred: ^bb0
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb2:  // pred: ^bb0
        "spirv.Branch"()[^bb3] : () -> ()
      ^bb3:  // 2 preds: ^bb1, ^bb2
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> i32, sym_name = "selection_with_early_return"}> ({
    ^bb0(%arg0: i1):
      %0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      "spirv.mlir.selection"() <{selection_control = #spirv.selection_control<None>}> ({
        "spirv.BranchConditional"(%arg0, %0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
      ^bb1(%2: i32):  // pred: ^bb0
        "spirv.ReturnValue"(%2) : (i32) -> ()
      ^bb2:  // pred: ^bb0
        "spirv.mlir.merge"() : () -> ()
      }) : () -> ()
      %1 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      "spirv.ReturnValue"(%1) : (i32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

