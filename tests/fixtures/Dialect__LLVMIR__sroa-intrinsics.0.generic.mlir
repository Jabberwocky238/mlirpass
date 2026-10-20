"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %4 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %4) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %5 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_partial", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
    %4 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %4) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %5 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline_partial", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 2 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_full", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 40 : i32}> : () -> i32
    %4 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %4) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %5 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline_full", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_too_much", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 41 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %5 = "llvm.load"(%4) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline_too_much", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 41 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_no_volatile", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = true}> : (!llvm.ptr, i8, i32) -> ()
    %4 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %5 = "llvm.load"(%4) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline_no_volatile", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = true, len = 16 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "indirect_memset", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "indirect_memset_inline", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "invalid_indirect_memset", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i32, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
    %4 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, i32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.intr.memset"(%4, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %5 = "llvm.load"(%4) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "invalid_indirect_memset_inline", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i32, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, i32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.intr.memset.inline"(%3, %2) <{isVolatile = false, len = 6 : i64}> : (!llvm.ptr, i8) -> ()
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_double_use", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = f32}> : (i32) -> !llvm.ptr
    %2 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %3 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %4 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %5 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memset"(%2, %3, %5) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %6 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %3, %6) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %7 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %8 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %9 = "llvm.bitcast"(%8) : (f32) -> i32
    %10 = "llvm.add"(%7, %9) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%10) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline_double_use", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = f32}> : (i32) -> !llvm.ptr
    %2 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %3 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%2, %3) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    "llvm.intr.memset.inline"(%1, %3) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    %4 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %5 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %6 = "llvm.bitcast"(%5) : (f32) -> i32
    %7 = "llvm.add"(%4, %6) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_considers_alignment", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = f32}> : (i32) -> !llvm.ptr
    %2 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %3 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %4 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %5 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memset"(%2, %3, %5) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %6 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %7 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %8 = "llvm.bitcast"(%7) : (f32) -> i32
    %9 = "llvm.add"(%6, %8) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%9) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline_considers_alignment", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = f32}> : (i32) -> !llvm.ptr
    %2 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %3 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%2, %3) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    %4 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %5 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %6 = "llvm.bitcast"(%5) : (f32) -> i32
    %7 = "llvm.add"(%4, %6) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_considers_packing", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = f32}> : (i32) -> !llvm.ptr
    %2 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %3 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %4 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    %5 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memset"(%2, %3, %5) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %6 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %3, %6) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %7 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %8 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %9 = "llvm.bitcast"(%8) : (f32) -> i32
    %10 = "llvm.add"(%7, %9) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%10) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline_considers_packing", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = f32}> : (i32) -> !llvm.ptr
    %2 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %3 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%2, %3) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    "llvm.intr.memset.inline"(%1, %3) <{isVolatile = false, len = 3 : i64}> : (!llvm.ptr, i8) -> ()
    %4 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %5 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %6 = "llvm.bitcast"(%5) : (f32) -> i32
    %7 = "llvm.add"(%4, %6) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memcpy_dest", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 40 : i32}> : () -> i32
    %3 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memcpy"(%1, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %5 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memcpy_src", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %3 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %4 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %6 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    %7 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memcpy"(%6, %2, %7) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %8 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %9 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memcpy"(%8, %1, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %10 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %11 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memcpy"(%10, %3, %11) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %12 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 3>}> : (!llvm.ptr) -> !llvm.ptr
    %13 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memcpy"(%12, %4, %13) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %14 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%14) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memcpy_double", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.alloca"(%0) <{elem_type = !llvm.array<1 x i32>}> : (i32) -> !llvm.ptr
    %3 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %4 = "llvm.getelementptr"(%2) <{elem_type = !llvm.array<1 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memcpy"(%1, %4, %5) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %6 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memcpy_no_partial", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 21 : i32}> : () -> i32
    "llvm.intr.memcpy"(%1, %arg0, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memcpy_no_volatile", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 40 : i32}> : () -> i32
    "llvm.intr.memcpy"(%1, %arg0, %2) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memmove_dest", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 40 : i32}> : () -> i32
    %3 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memmove"(%1, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %5 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memmove_src", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %3 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %4 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    %6 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    %7 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memmove"(%6, %4, %7) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %8 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %9 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memmove"(%8, %1, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %10 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %11 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memmove"(%10, %3, %11) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %12 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 3>}> : (!llvm.ptr) -> !llvm.ptr
    %13 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memmove"(%12, %2, %13) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %14 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%14) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memcpy_inline_dest", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.intr.memcpy.inline"(%1, %2) <{isVolatile = false, len = 4 : i32}> : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memcpy_inline_src", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %2 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %3 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %4 = "llvm.alloca"(%0) <{elem_type = i32}> : (i32) -> !llvm.ptr
    %5 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.intr.memcpy.inline"(%5, %2) <{isVolatile = false, len = 4 : i32}> : (!llvm.ptr, !llvm.ptr) -> ()
    %6 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.intr.memcpy.inline"(%6, %1) <{isVolatile = false, len = 4 : i32}> : (!llvm.ptr, !llvm.ptr) -> ()
    %7 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.intr.memcpy.inline"(%7, %3) <{isVolatile = false, len = 4 : i32}> : (!llvm.ptr, !llvm.ptr) -> ()
    %8 = "llvm.getelementptr"(%arg0) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 3>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.intr.memcpy.inline"(%8, %4) <{isVolatile = false, len = 4 : i32}> : (!llvm.ptr, !llvm.ptr) -> ()
    %9 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%9) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

