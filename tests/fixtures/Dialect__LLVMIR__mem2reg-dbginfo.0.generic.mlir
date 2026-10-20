#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "ptr sized type", sizeInBits = 64>
#di_file = #llvm.di_file<"test.ll" in "">
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C_plus_plus_14, file = #di_file, producer = "clang", isOptimized = false, emissionKind = Full>
#di_subprogram = #llvm.di_subprogram<compileUnit = #di_compile_unit, scope = #di_file, name = "blah", linkageName = "blah", file = #di_file, line = 7, subprogramFlags = Definition>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "ptr sized var", file = #di_file, line = 7, arg = 1, type = #di_basic_type>
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "use", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "use_ptr", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "basic_store_load", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg5: i64):
    %12 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.intr.dbg.value"(%arg5) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (i64) -> ()
    "llvm.return"(%arg5) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "multiple_store_load", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg4: i64):
    %11 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.intr.dbg.value"(%arg4) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (i64) -> ()
    "llvm.intr.dbg.value"(%arg4) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (i64) -> ()
    "llvm.return"(%arg4) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "block_argument_value", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg2: i64, %arg3: i1):
    %8 = "llvm.mlir.undef"() : () -> i64
    %9 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.cond_br"(%arg3, %8)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i64) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.intr.dbg.value"(%arg2) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (i64) -> ()
    "llvm.br"(%arg2)[^bb2] : (i64) -> ()
  ^bb2(%10: i64):  // 2 preds: ^bb0, ^bb1
    "llvm.intr.dbg.value"(%10) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (i64) -> ()
    "llvm.return"(%10) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "double_block_argument_value", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i1):
    %4 = "llvm.mlir.undef"() : () -> i64
    %5 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    "llvm.cond_br"(%arg1, %4, %4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i64, i64) -> ()
  ^bb1(%6: i64):  // 2 preds: ^bb0, ^bb2
    "llvm.intr.dbg.value"(%6) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (i64) -> ()
    "llvm.call"(%6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.intr.dbg.value"(%arg0) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (i64) -> ()
    "llvm.br"(%arg0)[^bb2] : (i64) -> ()
  ^bb2(%7: i64):  // 2 preds: ^bb0, ^bb1
    "llvm.intr.dbg.value"(%7) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (i64) -> ()
    "llvm.br"(%7)[^bb1] : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "always_drop_promoted_declare", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "llvm.mlir.undef"() : () -> !llvm.ptr
    "llvm.intr.dbg.value"(%3) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "keep_dbg_if_not_promoted", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.alloca"(%0) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%1) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use_ptr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

