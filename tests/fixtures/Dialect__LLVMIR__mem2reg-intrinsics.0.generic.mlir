"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i8)>, linkage = #llvm.linkage<external>, sym_name = "basic_memset", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i8):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %2 = "llvm.zext"(%arg0) : (i8) -> i32
    %3 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %4 = "llvm.shl"(%2, %3) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %5 = "llvm.or"(%2, %4) : (i32, i32) -> i32
    %6 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %7 = "llvm.shl"(%5, %6) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %8 = "llvm.or"(%5, %7) : (i32, i32) -> i32
    "llvm.return"(%8) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 (i8)>, linkage = #llvm.linkage<external>, sym_name = "memset_float", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i8):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %2 = "llvm.zext"(%arg0) : (i8) -> i32
    %3 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %4 = "llvm.shl"(%2, %3) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %5 = "llvm.or"(%2, %4) : (i32, i32) -> i32
    %6 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %7 = "llvm.shl"(%5, %6) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %8 = "llvm.or"(%5, %7) : (i32, i32) -> i32
    %9 = "llvm.bitcast"(%8) : (i32) -> f32
    "llvm.return"(%9) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i8)>, linkage = #llvm.linkage<external>, sym_name = "basic_memset_inline", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i8):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.zext"(%arg0) : (i8) -> i32
    %2 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %3 = "llvm.shl"(%1, %2) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %4 = "llvm.or"(%1, %3) : (i32, i32) -> i32
    %5 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %6 = "llvm.shl"(%4, %5) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %7 = "llvm.or"(%4, %6) : (i32, i32) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "basic_memset_constant", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %2 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 707406378 : i32}> : () -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i8 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_one_byte_constant", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "basic_memset_inline_constant", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %2 = "llvm.mlir.constant"() <{value = 707406378 : i32}> : () -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i40 (i8)>, linkage = #llvm.linkage<external>, sym_name = "exotic_target_memset", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i8):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
    %2 = "llvm.zext"(%arg0) : (i8) -> i40
    %3 = "llvm.mlir.constant"() <{value = 8 : i40}> : () -> i40
    %4 = "llvm.shl"(%2, %3) <{overflowFlags = 0 : i32}> : (i40, i40) -> i40
    %5 = "llvm.or"(%2, %4) : (i40, i40) -> i40
    %6 = "llvm.mlir.constant"() <{value = 16 : i40}> : () -> i40
    %7 = "llvm.shl"(%5, %6) <{overflowFlags = 0 : i32}> : (i40, i40) -> i40
    %8 = "llvm.or"(%5, %7) : (i40, i40) -> i40
    %9 = "llvm.mlir.constant"() <{value = 32 : i40}> : () -> i40
    %10 = "llvm.shl"(%8, %9) <{overflowFlags = 0 : i32}> : (i40, i40) -> i40
    %11 = "llvm.or"(%8, %10) : (i40, i40) -> i40
    "llvm.return"(%11) : (i40) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i40 (i8)>, linkage = #llvm.linkage<external>, sym_name = "exotic_target_memset_inline", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i8):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.zext"(%arg0) : (i8) -> i40
    %2 = "llvm.mlir.constant"() <{value = 8 : i40}> : () -> i40
    %3 = "llvm.shl"(%1, %2) <{overflowFlags = 0 : i32}> : (i40, i40) -> i40
    %4 = "llvm.or"(%1, %3) : (i40, i40) -> i40
    %5 = "llvm.mlir.constant"() <{value = 16 : i40}> : () -> i40
    %6 = "llvm.shl"(%4, %5) <{overflowFlags = 0 : i32}> : (i40, i40) -> i40
    %7 = "llvm.or"(%4, %6) : (i40, i40) -> i40
    %8 = "llvm.mlir.constant"() <{value = 32 : i40}> : () -> i40
    %9 = "llvm.shl"(%7, %8) <{overflowFlags = 0 : i32}> : (i40, i40) -> i40
    %10 = "llvm.or"(%7, %9) : (i40, i40) -> i40
    "llvm.return"(%10) : (i40) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "no_volatile_memset", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 4 : i64, elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = true}> : (!llvm.ptr, i8, i32) -> ()
    %4 = "llvm.load"(%1) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "no_volatile_memset_inline", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 4 : i64, elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = true, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.load"(%1) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "no_partial_memset", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 4 : i64, elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = "llvm.load"(%1) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "no_partial_memset_inline", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 4 : i64, elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 2 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.load"(%1) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "no_overflowing_memset", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 4 : i64, elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = "llvm.load"(%1) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "no_overflowing_memset_inline", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 4 : i64, elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 6 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.load"(%1) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i10 ()>, linkage = #llvm.linkage<external>, sym_name = "only_byte_aligned_integers_memset", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 4 : i64, elem_type = i10}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = "llvm.load"(%1) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i10
    "llvm.return"(%4) : (i10) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i10 ()>, linkage = #llvm.linkage<external>, sym_name = "only_byte_aligned_integers_memset_inline", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 4 : i64, elem_type = i10}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 2 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.load"(%1) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i10
    "llvm.return"(%3) : (i10) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "basic_memcpy", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %2 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %3 = "llvm.load"(%arg0) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "basic_memcpy_dest", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %3 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.store"(%1, %arg0) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "double_memcpy", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 42 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %3 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "ignore_self_memcpy", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %2 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %3 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%3, %3, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "ignore_partial_memcpy", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %2 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%3, %arg0, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "ignore_volatile_memcpy", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %2 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %3 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%3, %arg0, %2) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "basic_memmove", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %2 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %3 = "llvm.load"(%arg0) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "basic_memcpy_inline", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %2 = "llvm.load"(%arg0) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

