"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "basic_struct", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i32, f64, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f64, i32)>, noWrapFlags = 3 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "basic_array", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 3 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "multi_level_direct", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i32, f64, struct<"bar", (i8, array<10 x array<10 x i32>>, i8)>)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f64, struct<"bar", (i8, array<10 x array<10 x i32>>, i8)>)>, noWrapFlags = 3 : i32, rawConstantIndices = array<i32: 0, 2, 1, 5, 8>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "multi_level_direct_two_applications", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i32, f64, array<10 x i32>, i8)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f64, array<10 x i32>, i8)>, noWrapFlags = 3 : i32, rawConstantIndices = array<i32: 0, 2, 0>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "multi_level_indirect", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i32, f64, struct<"bar", (i8, array<10 x array<10 x i32>>, i8)>)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f64, struct<"bar", (i8, array<10 x array<10 x i32>>, i8)>)>, noWrapFlags = 3 : i32, rawConstantIndices = array<i32: 0, 2, 1, 5>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 3 : i32, rawConstantIndices = array<i32: 0, 8>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 ()>, linkage = #llvm.linkage<external>, sym_name = "nested_access_over_slot_bound", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<(i32, struct<(array<10 x i32>)>, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<(i32, struct<(array<10 x i32>)>, i32)>, noWrapFlags = 3 : i32, rawConstantIndices = array<i32: 0, 1, 0>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 3 : i32, rawConstantIndices = array<i32: 0, 9>}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "resolve_alias", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i32, f64, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f64, i32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f64, i32)>, noWrapFlags = 3 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%arg0, %2) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
    %4 = "llvm.load"(%3) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "no_non_single_support", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i32, f64, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f64, i32)>, noWrapFlags = 3 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "no_pointer_indexing", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i32, f64, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f64, i32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "no_direct_use", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i32, f64, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f64, i32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "use", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "direct_promotable_use_is_fine", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i32, f64, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f64, i32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.intr.lifetime.start"(%1) : (!llvm.ptr) -> ()
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "direct_promotable_use_is_fine_on_accessor", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<"foo", (i32, f64, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<"foo", (i32, f64, i32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 2>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.intr.invariant.start"(%2) <{size = 2 : i64}> : (!llvm.ptr) -> !llvm.ptr
    %4 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.intr.invariant.end"(%3, %2) <{size = 2 : i64}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "no_dynamic_indexing", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.array<10 x i32>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1, %arg0) <{elem_type = !llvm.array<10 x i32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, -2147483648>}> : (!llvm.ptr, i32) -> !llvm.ptr
    %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32)>, linkage = #llvm.linkage<external>, sym_name = "no_nested_dynamic_indexing", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = !llvm.struct<(array<10 x i32>, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1, %arg0) <{elem_type = !llvm.struct<(array<10 x i32>, i32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0, -2147483648>}> : (!llvm.ptr, i32) -> !llvm.ptr
    %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "store_first_field", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i32, i32, i32)>}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg0, %1) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "store_first_field_different_type", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i32, i32, i32)>}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg0, %1) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32)>, linkage = #llvm.linkage<external>, sym_name = "store_sub_field", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i64, i32)>}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg0, %1) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "load_first_field", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i32, i32, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f32 ()>, linkage = #llvm.linkage<external>, sym_name = "load_first_field_different_type", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i32, i32, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "llvm.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 ()>, linkage = #llvm.linkage<external>, sym_name = "load_sub_field", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<(i64, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi32>)>, linkage = #llvm.linkage<external>, sym_name = "vector_store_type_mismatch", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (vector<4xf32>)>}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg0, %1) <{ordering = 0 : i64}> : (vector<4xi32>, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "store_to_memory", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (vector<4xf32>)>}> : (i32) -> !llvm.ptr
    "llvm.store"(%1, %arg0) <{ordering = 0 : i64}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "type_mismatch_array_access", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<(i32, i32, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 8>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%arg0, %2) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "type_mismatch_struct_access", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<(i32, i32, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.struct<(i32, i32)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 1>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%arg0, %2) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "index_in_final_padding", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i32, i8)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 7>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%arg0, %2) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "index_out_of_bounds", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i32, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 9>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%arg0, %2) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16)>, linkage = #llvm.linkage<external>, sym_name = "index_in_padding", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i16):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i16, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 2>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%arg0, %2) <{ordering = 0 : i64}> : (i16, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i16)>, linkage = #llvm.linkage<external>, sym_name = "index_not_in_padding_because_packed", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i16):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", packed (i16, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 2>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%arg0, %2) <{ordering = 0 : i64}> : (i16, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f16)>, linkage = #llvm.linkage<external>, sym_name = "no_crash_on_negative_gep_index", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: f16):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i32, i32, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -1>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%arg0, %2) <{ordering = 0 : i64}> : (f16, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32)>, linkage = #llvm.linkage<external>, sym_name = "out_of_bound_gep_array_access", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{elem_type = !llvm.struct<"foo", (i32, i32)>}> : (i32) -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = !llvm.array<4 x i8>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 4>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%arg0, %2) <{ordering = 0 : i64}> : (i32, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

