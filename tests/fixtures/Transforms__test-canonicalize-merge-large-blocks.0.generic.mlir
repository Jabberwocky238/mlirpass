"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "foo", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 ()>, linkage = #llvm.linkage<external>, sym_name = "rand", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "large_merge_block", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg3: i64):
    %22 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %23 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %24 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %25 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    %26 = "llvm.mlir.constant"() <{value = 4 : i64}> : () -> i64
    %27 = "llvm.icmp"(%arg3, %22) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "llvm.cond_br"(%27, %23, %25, %26, %24, %26, %24, %23, %25)[^bb1, ^bb1] <{operandSegmentSizes = array<i32: 1, 4, 4>}> : (i1, i64, i64, i64, i64, i64, i64, i64, i64) -> ()
  ^bb1(%28: i64, %29: i64, %30: i64, %31: i64):  // 2 preds: ^bb0, ^bb0
    %32 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @rand, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> i1
    "llvm.cond_br"(%32, %28, %31)[^bb2, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i64, i64) -> ()
  ^bb2(%33: i64):  // 2 preds: ^bb1, ^bb1
    "llvm.call"(%33) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @foo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // pred: ^bb2
    %34 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @rand, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> i1
    "llvm.cond_br"(%34, %29, %30)[^bb4, ^bb4] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i64, i64) -> ()
  ^bb4(%35: i64):  // 2 preds: ^bb3, ^bb3
    "llvm.call"(%35) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @foo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.br"()[^bb5] : () -> ()
  ^bb5:  // pred: ^bb4
    "llvm.br"()[^bb6] : () -> ()
  ^bb6:  // pred: ^bb5
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1)>, linkage = #llvm.linkage<external>, sym_name = "redundant_args0", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg2: i1):
    %17 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %18 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %19 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    "llvm.cond_br"(%arg2, %17, %17, %18, %19)[^bb1, ^bb1] <{operandSegmentSizes = array<i32: 1, 2, 2>}> : (i1, i64, i64, i64, i64) -> ()
  ^bb1(%20: i64, %21: i64):  // 2 preds: ^bb0, ^bb0
    "llvm.call"(%20) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @foo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"(%21) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @foo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1)>, linkage = #llvm.linkage<external>, sym_name = "redundant_args1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg1: i1):
    %12 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %13 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %14 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    "llvm.cond_br"(%arg1, %13, %14, %12, %12)[^bb1, ^bb1] <{operandSegmentSizes = array<i32: 1, 2, 2>}> : (i1, i64, i64, i64, i64) -> ()
  ^bb1(%15: i64, %16: i64):  // 2 preds: ^bb0, ^bb0
    "llvm.call"(%15) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @foo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"(%16) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @foo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1)>, linkage = #llvm.linkage<external>, sym_name = "redundant_args_complex", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1):
    %5 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %6 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %7 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %8 = "llvm.mlir.constant"() <{value = 3 : i64}> : () -> i64
    "llvm.cond_br"(%arg0, %7, %6, %8, %5, %8, %7)[^bb1, ^bb1] <{operandSegmentSizes = array<i32: 1, 3, 3>}> : (i1, i64, i64, i64, i64, i64, i64) -> ()
  ^bb1(%9: i64, %10: i64, %11: i64):  // 2 preds: ^bb0, ^bb0
    "llvm.call"(%9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @foo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"(%9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @foo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"(%10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @foo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"(%7) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @foo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.call"(%11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @foo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "blocks_with_args", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @rand, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> i1
    "llvm.cond_br"(%3, %0, %1)[^bb1, ^bb1] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i64, i64) -> ()
  ^bb1(%4: i64):  // 2 preds: ^bb0, ^bb0
    "llvm.store"(%2, %2) <{ordering = 0 : i64}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.cond_br"(%3)[^bb2, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // 2 preds: ^bb1, ^bb1
    "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @foo, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // pred: ^bb2
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

