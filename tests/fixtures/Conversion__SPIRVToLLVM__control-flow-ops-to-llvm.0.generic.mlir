"builtin.module"() ({
  "builtin.module"() ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "branch_without_arguments", visibility_ = 0 : i64}> ({
      "llvm.br"()[^bb1] : () -> ()
    ^bb1:  // pred: ^bb0
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "branch_with_arguments", visibility_ = 0 : i64}> ({
      %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %1 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      "llvm.br"(%0, %1)[^bb1] : (i32, i1) -> ()
    ^bb1(%2: i32, %3: i1):  // pred: ^bb0
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "builtin.module"() ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "cond_branch_without_arguments", visibility_ = 0 : i64}> ({
      %7 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      "llvm.cond_br"(%7)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "llvm.return"() : () -> ()
    ^bb2:  // pred: ^bb0
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "cond_branch_with_arguments_nested", visibility_ = 0 : i64}> ({
      %0 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %2 = "llvm.mlir.constant"() <{value = false}> : () -> i1
      "llvm.cond_br"(%0, %1, %2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (i1, i32, i1) -> ()
    ^bb1(%3: i32, %4: i1):  // pred: ^bb0
      "llvm.cond_br"(%4, %3, %3)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 2>}> : (i1, i32, i32) -> ()
    ^bb2:  // pred: ^bb0
      "llvm.return"() : () -> ()
    ^bb3:  // pred: ^bb1
      "llvm.return"() : () -> ()
    ^bb4(%5: i32, %6: i32):  // pred: ^bb1
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1)>, linkage = #llvm.linkage<external>, sym_name = "cond_branch_with_weights", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i1):
      "llvm.cond_br"(%arg0)[^bb1, ^bb2] <{branch_weights = array<i32: 1, 2>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "llvm.return"() : () -> ()
    ^bb2:  // pred: ^bb0
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "builtin.module"() ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "empty_loop", visibility_ = 0 : i64}> ({
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "infinite_loop", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i32):
      "llvm.br"()[^bb1] : () -> ()
    ^bb1:  // 2 preds: ^bb0, ^bb3
      %0 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      "llvm.cond_br"(%0)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      "llvm.br"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      "llvm.br"()[^bb1] : () -> ()
    ^bb4:  // pred: ^bb1
      "llvm.br"()[^bb5] : () -> ()
    ^bb5:  // pred: ^bb4
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "builtin.module"() ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "selection_empty", visibility_ = 0 : i64}> ({
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "selection_with_merge_block_only", visibility_ = 0 : i64}> ({
      %5 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "selection_with_true_block_only", visibility_ = 0 : i64}> ({
      %4 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      "llvm.cond_br"(%4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "llvm.br"()[^bb2] : () -> ()
    ^bb2:  // 2 preds: ^bb0, ^bb1
      "llvm.br"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "selection_with_both_true_and_false_block", visibility_ = 0 : i64}> ({
      %3 = "llvm.mlir.constant"() <{value = true}> : () -> i1
      "llvm.cond_br"(%3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "llvm.br"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "llvm.br"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "llvm.br"()[^bb4] : () -> ()
    ^bb4:  // pred: ^bb3
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i1)>, linkage = #llvm.linkage<external>, sym_name = "selection_with_early_return", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i1):
      %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      "llvm.cond_br"(%arg0, %0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
    ^bb1(%1: i32):  // pred: ^bb0
      "llvm.return"(%1) : (i32) -> ()
    ^bb2:  // pred: ^bb0
      "llvm.br"()[^bb3] : () -> ()
    ^bb3:  // pred: ^bb2
      %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      "llvm.return"(%2) : (i32) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

