#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "ptr sized type", sizeInBits = 64>
#di_file = #llvm.di_file<"test.ll" in "">
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C_plus_plus_14, file = #di_file, producer = "clang", isOptimized = false, emissionKind = Full>
#di_subprogram = #llvm.di_subprogram<compileUnit = #di_compile_unit, scope = #di_file, name = "blah", linkageName = "blah", file = #di_file, line = 7, subprogramFlags = Definition>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "ptr sized var", file = #di_file, line = 7, arg = 1, type = #di_basic_type>
#di_local_variable1 = #llvm.di_local_variable<scope = #di_subprogram, name = "ptr sized var 2", file = #di_file, line = 7, arg = 1, type = #di_basic_type>
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "use", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "use_ptr", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "basic_store_load", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg5: i64):
    %14 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %15 = "llvm.alloca"(%14) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg5, %15) <{alignment = 4 : i64, ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    "llvm.intr.dbg.declare"(%15) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    %16 = "llvm.load"(%15) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i64
    "llvm.return"(%16) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "multiple_store_load", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg4: i64):
    %11 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %12 = "llvm.alloca"(%11) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%12) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.store"(%arg4, %12) <{alignment = 4 : i64, ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    "llvm.intr.dbg.declare"(%12) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    %13 = "llvm.load"(%12) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i64
    "llvm.return"(%13) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "block_argument_value", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg2: i64, %arg3: i1):
    %8 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %9 = "llvm.alloca"(%8) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%9) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.cond_br"(%arg3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.store"(%arg2, %9) <{alignment = 4 : i64, ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %10 = "llvm.load"(%9) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i64
    "llvm.return"(%10) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "double_block_argument_value", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i1):
    %5 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %6 = "llvm.alloca"(%5) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%6) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.cond_br"(%arg1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %7 = "llvm.load"(%6) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i64
    "llvm.call"(%7) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.store"(%arg0, %6) <{alignment = 4 : i64, ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "llvm.br"()[^bb1] : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "always_drop_promoted_declare", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %3 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "llvm.alloca"(%3) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%4) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.intr.dbg.value"(%4) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "keep_dbg_if_not_promoted", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%1) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    %2 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%2) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable1}> : (!llvm.ptr) -> ()
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use_ptr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

