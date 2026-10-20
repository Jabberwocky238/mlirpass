"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %5 = "llvm.load"(%4) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 16 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_partial", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 6 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %5 = "llvm.load"(%4) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline_partial", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 6 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_full", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 40 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %5 = "llvm.load"(%4) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline_full", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 40 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
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
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i32, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    %4 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, i32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.intr.memset"(%4, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %5 = "llvm.load"(%4) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "indirect_memset_inline", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i32, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, i32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.intr.memset.inline"(%3, %2) <{isVolatile = false, len = 4 : i64}> : (!llvm.ptr, i8) -> ()
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
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
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i32, f32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    %5 = "llvm.load"(%4) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %6 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %7 = "llvm.load"(%6) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %8 = "llvm.bitcast"(%7) : (f32) -> i32
    %9 = "llvm.add"(%5, %8) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%9) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline_double_use", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i32, f32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 8 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %5 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %6 = "llvm.load"(%5) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %7 = "llvm.bitcast"(%6) : (f32) -> i32
    %8 = "llvm.add"(%4, %7) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%8) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_considers_alignment", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i8, i32, f32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i8, i32, f32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %5 = "llvm.load"(%4) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %6 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i8, i32, f32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %7 = "llvm.load"(%6) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %8 = "llvm.bitcast"(%7) : (f32) -> i32
    %9 = "llvm.add"(%5, %8) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%9) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline_considers_alignment", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i8, i32, f32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 8 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i8, i32, f32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %5 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i8, i32, f32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %6 = "llvm.load"(%5) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %7 = "llvm.bitcast"(%6) : (f32) -> i32
    %8 = "llvm.add"(%4, %7) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%8) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_considers_packing", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", packed (i8, i32, f32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
    "llvm.intr.memset"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    %4 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", packed (i8, i32, f32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %5 = "llvm.load"(%4) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %6 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", packed (i8, i32, f32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %7 = "llvm.load"(%6) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %8 = "llvm.bitcast"(%7) : (f32) -> i32
    %9 = "llvm.add"(%5, %8) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%9) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memset_inline_considers_packing", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", packed (i8, i32, f32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
    "llvm.intr.memset.inline"(%1, %2) <{isVolatile = false, len = 8 : i64}> : (!llvm.ptr, i8) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", packed (i8, i32, f32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    %5 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", packed (i8, i32, f32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %6 = "llvm.load"(%5) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %7 = "llvm.bitcast"(%6) : (f32) -> i32
    %8 = "llvm.add"(%4, %7) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"(%8) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memcpy_dest", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 40 : i32}> : () -> i32
    "llvm.intr.memcpy"(%1, %arg0, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memcpy_src", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.array<4 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    "llvm.intr.memcpy"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "memcpy_double", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.array<1 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.alloca"(%0) <{elem_type = !llvm.array<1 x i32>}> : (i32) -> !llvm.ptr
    %3 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
    "llvm.intr.memcpy"(%1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %4 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<1 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    %5 = "llvm.load"(%4) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%5) : (i32) -> ()
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
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 40 : i32}> : () -> i32
    "llvm.intr.memmove"(%1, %arg0, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memmove_src", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.array<4 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
    "llvm.intr.memmove"(%arg0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memcpy_inline_dest", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    "llvm.intr.memcpy.inline"(%1, %arg0) <{isVolatile = false, len = 40 : i32}> : (!llvm.ptr, !llvm.ptr) -> ()
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (ptr)>, linkage = #llvm.linkage<external>, sym_name = "memcpy_inline_src", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.array<4 x i32>}> : (i32) -> !llvm.ptr
    "llvm.intr.memcpy.inline"(%arg0, %1) <{isVolatile = false, len = 16 : i32}> : (!llvm.ptr, !llvm.ptr) -> ()
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<4 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

