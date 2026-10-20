"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "default_value", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "store_of_ptr", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.alloca"(%0) <{alignment = 4 : i64, elem_type = i32}> : (i32) -> !llvm.ptr
    "llvm.store"(%1, %3) <{alignment = 4 : i64, ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
    "llvm.store"(%3, %2) <{alignment = 8 : i64, ordering = 0 : i64}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "unreachable", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "llvm.return"() : () -> ()
  ^bb1:  // no predecessors
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "unreachable_in_loop", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb3
    "llvm.br"()[^bb3] : () -> ()
  ^bb2:  // no predecessors
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "llvm.br"()[^bb1] : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "branching", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    "llvm.cond_br"(%arg0, %0)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.cond_br"(%arg1, %2, %2)[^bb2, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i32, i32) -> ()
  ^bb2(%3: i32):  // 3 preds: ^bb0, ^bb1, ^bb1
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "recursive_alloca", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "reset_in_branch", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32, %arg1: i1):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %2 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    "llvm.cond_br"(%arg1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.call"(%arg0, %2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @reset_in_branch, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i32, i1) -> ()
    "llvm.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    "llvm.call"(%arg0, %1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @reset_in_branch, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i32, i1) -> ()
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i32)>, linkage = #llvm.linkage<external>, sym_name = "intertwined_alloca", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr, %arg1: i32):
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "llvm.br"(%2, %0)[^bb1] : (i32, i32) -> ()
  ^bb1(%3: i32, %4: i32):  // 2 preds: ^bb0, ^bb4
    %5 = "llvm.add"(%arg1, %1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %6 = "llvm.icmp"(%5, %3) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %7 = "llvm.zext"(%6) : (i1) -> i32
    "llvm.cond_br"(%6)[^bb2, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %8 = "llvm.icmp"(%3, %2) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %9 = "llvm.zext"(%8) : (i1) -> i32
    "llvm.cond_br"(%8)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %10 = "llvm.sub"(%3, %1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %11 = "llvm.getelementptr"(%arg0, %10) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i32) -> !llvm.ptr
    %12 = "llvm.trunc"(%4) <{overflowFlags = 0 : i32}> : (i32) -> i8
    "llvm.store"(%12, %11) <{alignment = 1 : i64, ordering = 0 : i64}> : (i8, !llvm.ptr) -> ()
    "llvm.br"()[^bb4] : () -> ()
  ^bb4:  // 2 preds: ^bb2, ^bb3
    %13 = "llvm.add"(%3, %1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.br"(%13, %2)[^bb1] : (i32, i32) -> ()
  ^bb5:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ...)>, linkage = #llvm.linkage<external>, sym_name = "complex_cf", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "llvm.cond_br"(%1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb2, ^bb16
    "llvm.cond_br"(%1)[^bb4, ^bb17] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    "llvm.cond_br"(%1)[^bb5, ^bb14] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb5:  // pred: ^bb4
    "llvm.cond_br"(%1)[^bb7, ^bb6] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb6:  // pred: ^bb5
    "llvm.br"()[^bb7] : () -> ()
  ^bb7:  // 2 preds: ^bb5, ^bb6
    "llvm.cond_br"(%1)[^bb9, ^bb8] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb8:  // pred: ^bb7
    "llvm.br"()[^bb9] : () -> ()
  ^bb9:  // 2 preds: ^bb7, ^bb8
    "llvm.cond_br"(%1)[^bb11, ^bb10] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb10:  // pred: ^bb9
    "llvm.br"()[^bb11] : () -> ()
  ^bb11:  // 2 preds: ^bb9, ^bb10
    "llvm.cond_br"(%1)[^bb12, ^bb13] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb12:  // pred: ^bb11
    "llvm.br"()[^bb13] : () -> ()
  ^bb13:  // 2 preds: ^bb11, ^bb12
    "llvm.br"()[^bb14] : () -> ()
  ^bb14:  // 2 preds: ^bb4, ^bb13
    "llvm.cond_br"(%1)[^bb15, ^bb16] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb15:  // pred: ^bb14
    "llvm.br"()[^bb16] : () -> ()
  ^bb16:  // 2 preds: ^bb14, ^bb15
    "llvm.br"()[^bb3] : () -> ()
  ^bb17:  // pred: ^bb3
    "llvm.br"()[^bb20] : () -> ()
  ^bb18:  // no predecessors
    "llvm.br"()[^bb24] : () -> ()
  ^bb19:  // no predecessors
    "llvm.br"()[^bb20] : () -> ()
  ^bb20:  // 2 preds: ^bb17, ^bb19
    "llvm.cond_br"(%1)[^bb21, ^bb22] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb21:  // pred: ^bb20
    "llvm.br"()[^bb23] : () -> ()
  ^bb22:  // pred: ^bb20
    "llvm.br"()[^bb23] : () -> ()
  ^bb23:  // 2 preds: ^bb21, ^bb22
    "llvm.br"()[^bb24] : () -> ()
  ^bb24:  // 2 preds: ^bb18, ^bb23
    "llvm.br"()[^bb26] : () -> ()
  ^bb25:  // no predecessors
    "llvm.br"()[^bb26] : () -> ()
  ^bb26:  // 2 preds: ^bb24, ^bb25
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "llvm_crash", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.mlir.addressof"() <{global_name = @j}> : () -> !llvm.ptr
    %3 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %4 = "llvm.alloca"(%0) <{alignment = 4 : i64, elem_type = i32}> : (i32) -> !llvm.ptr
    %5 = "llvm.bitcast"(%1) : (i32) -> i32
    "llvm.store"(%1, %4) <{alignment = 4 : i64, ordering = 0 : i64, volatile_}> : (i32, !llvm.ptr) -> ()
    %6 = "llvm.call"(%2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @_setjmp, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> i32
    %7 = "llvm.icmp"(%6, %1) <{predicate = 1 : i64}> : (i32, i32) -> i1
    %8 = "llvm.zext"(%7) : (i1) -> i8
    %9 = "llvm.icmp"(%8, %3) <{predicate = 1 : i64}> : (i8, i8) -> i1
    "llvm.cond_br"(%9)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %10 = "llvm.load"(%4) <{alignment = 4 : i64, ordering = 0 : i64, volatile_}> : (!llvm.ptr) -> i32
    "llvm.br"(%10)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.store"(%0, %4) <{alignment = 4 : i64, ordering = 0 : i64, volatile_}> : (i32, !llvm.ptr) -> ()
    "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @g, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
    "llvm.br"(%1)[^bb3] : (i32) -> ()
  ^bb3(%11: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    "llvm.return"(%11) : (i32) -> ()
  }) : () -> ()
  "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = !llvm.array<1 x struct<"struct.__jmp_buf_tag", (array<6 x i32>, i32, struct<"struct.__sigset_t", (array<32 x i32>)>)>>, linkage = #llvm.linkage<external>, sym_name = "j", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, passthrough = ["returns_twice"], sym_name = "_setjmp", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "g", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<amdgpu_kernelcc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "addrspace_discard", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "ignore_atomic", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.return"(%arg0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, personality = @__gxx_personality_v0, sym_name = "landing_pad", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.invoke"()[^bb1, ^bb3] <{CConv = #llvm.cconv<ccc>, callee = @landing_padf, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0, 0, 0>}> : () -> i32
  ^bb1:  // pred: ^bb0
    "llvm.br"(%2)[^bb2] : (i32) -> ()
  ^bb2(%3: i32):  // 2 preds: ^bb1, ^bb3
    "llvm.return"(%3) : (i32) -> ()
  ^bb3:  // pred: ^bb0
    %4 = "llvm.landingpad"() <{cleanup}> : () -> !llvm.struct<(ptr, i32)>
    "llvm.br"(%0)[^bb2] : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "landing_padf", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (...)>, linkage = #llvm.linkage<external>, sym_name = "__gxx_personality_v0", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "unreachable_defines", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    "llvm.return"(%0) : (i32) -> ()
  ^bb2:  // no predecessors
    "llvm.br"()[^bb1] : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i1)>, linkage = #llvm.linkage<external>, sym_name = "unreachable_jumps_to_merge_point", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1):
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
    "llvm.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%2)[^bb4] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.br"(%3)[^bb4] : (i32) -> ()
  ^bb3:  // no predecessors
    "llvm.br"(%0)[^bb4] : (i32) -> ()
  ^bb4(%4: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "ignore_lifetime", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "ignore_invariant_group", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "ignore_discardable_tree", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
    %2 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %3 = "llvm.mlir.undef"() : () -> !llvm.struct<(i8, i16)>
    %4 = "llvm.insertvalue"(%3, %2) <{position = array<i64: 0>}> : (!llvm.struct<(i8, i16)>, i8) -> !llvm.struct<(i8, i16)>
    %5 = "llvm.insertvalue"(%4, %1) <{position = array<i64: 1>}> : (!llvm.struct<(i8, i16)>, i16) -> !llvm.struct<(i8, i16)>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "store_load_forward", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "merge_point_cycle", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
    "llvm.br"(%0)[^bb1] : (i32) -> ()
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = "llvm.call"(%3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i1
    %5 = "llvm.call"(%2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @def, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i32
    "llvm.cond_br"(%4, %5)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "def", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i32)>, linkage = #llvm.linkage<external>, sym_name = "use", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "no_unnecessary_arguments", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %2 = "llvm.call"(%0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> i1
    "llvm.cond_br"(%2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i32)>, linkage = #llvm.linkage<external>, sym_name = "use", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "discardable_use_tree", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "non_discardable_use_tree", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %2 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i8}> : (i32) -> !llvm.ptr
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr) -> !llvm.ptr
    "llvm.intr.lifetime.start"(%3) : (!llvm.ptr) -> ()
    "llvm.intr.lifetime.start"(%4) : (!llvm.ptr) -> ()
    %5 = "llvm.call"(%4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> i1
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "use", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "trivial_get_element_ptr", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "nontrivial_get_element_ptr", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %2 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i8}> : (i32) -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.intr.lifetime.start"(%2) : (!llvm.ptr) -> ()
    "llvm.intr.lifetime.start"(%3) : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "dynamic_get_element_ptr", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 2 : i64}> : () -> i64
    %2 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i8}> : (i32) -> !llvm.ptr
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %0) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i32) -> !llvm.ptr
    "llvm.intr.lifetime.start"(%3) : (!llvm.ptr) -> ()
    "llvm.intr.lifetime.start"(%4) : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i1, i64)>, linkage = #llvm.linkage<external>, sym_name = "live_cycle", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i1, %arg2: i64):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.cond_br"(%arg1, %arg2, %arg2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i64, i64) -> ()
  ^bb1(%1: i64):  // 2 preds: ^bb0, ^bb2
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.br"(%arg0)[^bb2] : (i64) -> ()
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    "llvm.br"(%2)[^bb1] : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "use", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "subregion_block_promotion", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg1, %1) <{alignment = 4 : i64, ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    "scf.execute_region"() ({
      "llvm.store"(%arg0, %1) <{alignment = 4 : i64, ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    %2 = "llvm.load"(%1) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "subregion_simple_transitive_promotion", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "scf.execute_region"() ({
      "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    "llvm.return"(%arg1) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "use", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "no_inner_alloca_promotion", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg0, %1) <{alignment = 4 : i64, ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    %2 = "llvm.load"(%1) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr ()>, linkage = #llvm.linkage<external>, sym_name = "transitive_reaching_def", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> !llvm.ptr
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.return"(%0) : (!llvm.ptr) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "load_int_from_float", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> f32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.bitcast"(%0) : (f32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 ()>, linkage = #llvm.linkage<external>, sym_name = "load_float_from_int", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.bitcast"(%0) : (i32) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "load_int_from_vector", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.bitcast"(%0) : (vector<2xi16>) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "load_int_from_array", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.array<2 x i16>}> : (i32) -> !llvm.ptr
    %2 = "llvm.load"(%1) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "store_int_to_float", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.bitcast"(%arg0) : (i32) -> f32
    "llvm.return"(%arg0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "store_float_to_int", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.bitcast"(%arg0) : (f32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<vector<4xi8> (i32)>, linkage = #llvm.linkage<external>, sym_name = "store_int_to_vector", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.bitcast"(%arg0) : (i32) -> vector<2xi16>
    %2 = "llvm.bitcast"(%arg0) : (i32) -> vector<4xi8>
    "llvm.return"(%2) : (vector<4xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr ()>, linkage = #llvm.linkage<external>, sym_name = "load_ptr_from_int", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.inttoptr"(%0) : (i64) -> !llvm.ptr
    "llvm.return"(%2) : (!llvm.ptr) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "load_int_from_ptr", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> !llvm.ptr
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.ptrtoint"(%0) : (!llvm.ptr) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr<2> ()>, linkage = #llvm.linkage<external>, sym_name = "load_ptr_addrspace_cast", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> !llvm.ptr<1>
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.addrspacecast"(%0) : (!llvm.ptr<1>) -> !llvm.ptr<2>
    "llvm.return"(%2) : (!llvm.ptr<2>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (i64, f64, i1)>, linkage = #llvm.linkage<external>, sym_name = "stores_with_different_types", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: f64, %arg2: i1):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.cond_br"(%arg2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg0)[^bb3] : (i64) -> ()
  ^bb2:  // pred: ^bb0
    %1 = "llvm.bitcast"(%arg1) : (f64) -> i64
    "llvm.br"(%1)[^bb3] : (i64) -> ()
  ^bb3(%2: i64):  // 2 preds: ^bb1, ^bb2
    %3 = "llvm.bitcast"(%2) : (i64) -> f64
    "llvm.return"(%3) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i16 ()>, linkage = #llvm.linkage<external>, sym_name = "load_smaller_int", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 ()>, linkage = #llvm.linkage<external>, sym_name = "load_different_type_same_size", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %3 = "llvm.bitcast"(%2) : (i32) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 ()>, linkage = #llvm.linkage<external>, sym_name = "impossible_load", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 4 : i64, elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.load"(%1) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> f64
    "llvm.return"(%2) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr<2> ()>, linkage = #llvm.linkage<external>, sym_name = "load_ptr_addrspace_cast_different_size", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "llvm.alloca"(%3) <{alignment = 4 : i64, elem_type = !llvm.ptr<1>}> : (i32) -> !llvm.ptr
    %5 = "llvm.load"(%4) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.ptr<2>
    "llvm.return"(%5) : (!llvm.ptr<2>) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr<1> ()>, linkage = #llvm.linkage<external>, sym_name = "load_ptr_addrspace_cast_different_size2", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 4 : i64, elem_type = !llvm.ptr<2>}> : (i32) -> !llvm.ptr
    %2 = "llvm.load"(%1) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.ptr<1>
    "llvm.return"(%2) : (!llvm.ptr<1>) -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<!llvm.ptr<1> = dense<[32, 64, 64]> : vector<3xi64>, !llvm.ptr<2> = dense<64> : vector<3xi64>>} : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "load_smaller_int_type", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (i64) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i8 ()>, linkage = #llvm.linkage<external>, sym_name = "load_smaller_int_type_big_endian", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 56 : i64}> : () -> i64
    %3 = "llvm.lshr"(%0, %2) : (i64, i64) -> i64
    %4 = "llvm.trunc"(%3) <{overflowFlags = 0 : i32}> : (i64) -> i8
    "llvm.return"(%4) : (i8) -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<"dlti.endianness" = "big">} : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 ()>, linkage = #llvm.linkage<external>, sym_name = "load_different_type_smaller", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %3 = "llvm.bitcast"(%2) : (i32) -> f32
    "llvm.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 ()>, linkage = #llvm.linkage<external>, sym_name = "load_smaller_float_type", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> f64
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.bitcast"(%0) : (f64) -> i64
    %3 = "llvm.trunc"(%2) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %4 = "llvm.bitcast"(%3) : (i32) -> f32
    "llvm.return"(%4) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i16 ()>, linkage = #llvm.linkage<external>, sym_name = "load_first_vector_elem", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.undef"() : () -> vector<4xi16>
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.bitcast"(%0) : (vector<4xi16>) -> i64
    %3 = "llvm.trunc"(%2) <{overflowFlags = 0 : i32}> : (i64) -> i16
    "llvm.return"(%3) : (i16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i16 ()>, linkage = #llvm.linkage<external>, sym_name = "load_first_llvm_vector_elem", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = vector<4x!llvm.ptr>}> : (i32) -> !llvm.ptr
    %2 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i16 ()>, linkage = #llvm.linkage<external>, sym_name = "scalable_vector", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = vector<[4]xi16>}> : (i32) -> !llvm.ptr
    %2 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i16 ()>, linkage = #llvm.linkage<external>, sym_name = "scalable_llvm_vector", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = vector<[4]x!llvm.ppc_fp128>}> : (i32) -> !llvm.ptr
    %2 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16)>, linkage = #llvm.linkage<external>, sym_name = "smaller_store_forwarding", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i16):
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.zext"(%arg0) : (i16) -> i32
    %3 = "llvm.mlir.constant"() <{value = -65536 : i32}> : () -> i32
    %4 = "llvm.and"(%0, %3) : (i32, i32) -> i32
    %5 = "llvm.or"(%4, %2) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16)>, linkage = #llvm.linkage<external>, sym_name = "smaller_store_forwarding_big_endian", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i16):
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.zext"(%arg0) : (i16) -> i32
    %3 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %4 = "llvm.shl"(%2, %3) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %5 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
    %6 = "llvm.and"(%0, %5) : (i32, i32) -> i32
    %7 = "llvm.or"(%6, %4) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<"dlti.endianness" = "big">} : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<1xi8>)>, linkage = #llvm.linkage<external>, sym_name = "smaller_store_forwarding_type_mix", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<1xi8>):
    %0 = "llvm.mlir.undef"() : () -> f32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.bitcast"(%0) : (f32) -> i32
    %3 = "llvm.bitcast"(%arg0) : (vector<1xi8>) -> i8
    %4 = "llvm.zext"(%3) : (i8) -> i32
    %5 = "llvm.mlir.constant"() <{value = -256 : i32}> : () -> i32
    %6 = "llvm.and"(%2, %5) : (i32, i32) -> i32
    %7 = "llvm.or"(%6, %4) : (i32, i32) -> i32
    %8 = "llvm.bitcast"(%7) : (i32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<1xi8>)>, linkage = #llvm.linkage<external>, sym_name = "smaller_store_forwarding_type_mix", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<1xi8>):
    %0 = "llvm.mlir.undef"() : () -> f32
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "llvm.bitcast"(%0) : (f32) -> i32
    %3 = "llvm.bitcast"(%arg0) : (vector<1xi8>) -> i8
    %4 = "llvm.zext"(%3) : (i8) -> i32
    %5 = "llvm.mlir.constant"() <{value = 24 : i32}> : () -> i32
    %6 = "llvm.shl"(%4, %5) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %7 = "llvm.mlir.constant"() <{value = 16777215 : i32}> : () -> i32
    %8 = "llvm.and"(%2, %7) : (i32, i32) -> i32
    %9 = "llvm.or"(%8, %6) : (i32, i32) -> i32
    %10 = "llvm.bitcast"(%9) : (i32) -> f32
    "llvm.return"() : () -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<"dlti.endianness" = "big">} : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 (i64, f32, i1)>, linkage = #llvm.linkage<external>, sym_name = "stores_with_different_types_branches", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: f32, %arg2: i1):
    %0 = "llvm.mlir.undef"() : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.cond_br"(%arg2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%arg0)[^bb3] : (i64) -> ()
  ^bb2:  // pred: ^bb0
    %2 = "llvm.bitcast"(%arg1) : (f32) -> i32
    %3 = "llvm.zext"(%2) : (i32) -> i64
    %4 = "llvm.mlir.constant"() <{value = -4294967296 : i64}> : () -> i64
    %5 = "llvm.and"(%0, %4) : (i64, i64) -> i64
    %6 = "llvm.or"(%5, %3) : (i64, i64) -> i64
    "llvm.br"(%6)[^bb3] : (i64) -> ()
  ^bb3(%7: i64):  // 2 preds: ^bb1, ^bb2
    %8 = "llvm.bitcast"(%7) : (i64) -> f64
    "llvm.return"(%8) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "store_out_of_bounds", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg0, %1) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

