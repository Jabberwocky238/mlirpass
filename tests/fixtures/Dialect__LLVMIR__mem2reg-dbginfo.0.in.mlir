#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "ptr sized type", sizeInBits = 64>
#di_file = #llvm.di_file<"test.ll" in "">
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C_plus_plus_14, file = #di_file, producer = "clang", emissionKind = Full>
#di_subprogram = #llvm.di_subprogram<compileUnit = #di_compile_unit, scope = #di_file, name = "blah", linkageName = "blah", file = #di_file, line = 7, subprogramFlags = Definition>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "ptr sized var", file = #di_file, line = 7, arg = 1, type = #di_basic_type>
#di_local_variable1 = #llvm.di_local_variable<scope = #di_subprogram, name = "ptr sized var 2", file = #di_file, line = 7, arg = 1, type = #di_basic_type>
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "use", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "use_ptr", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "basic_store_load", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg8: i64):
    %25 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %26 = "llvm.alloca"(%25) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.store"(%arg8, %26) <{alignment = 4 : i64, ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    "llvm.intr.dbg.declare"(%26) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    %27 = "llvm.load"(%26) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i64
    "llvm.return"(%27) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64)>, linkage = #llvm.linkage<external>, sym_name = "multiple_store_load", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg7: i64):
    %22 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %23 = "llvm.alloca"(%22) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%23) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.store"(%arg7, %23) <{alignment = 4 : i64, ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    "llvm.intr.dbg.declare"(%23) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    %24 = "llvm.load"(%23) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i64
    "llvm.return"(%24) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "block_argument_value", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg5: i64, %arg6: i1):
    %19 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %20 = "llvm.alloca"(%19) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%20) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.cond_br"(%arg6)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.store"(%arg5, %20) <{alignment = 4 : i64, ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %21 = "llvm.load"(%20) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i64
    "llvm.return"(%21) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "double_block_argument_value", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg3: i64, %arg4: i1):
    %16 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %17 = "llvm.alloca"(%16) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%17) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.cond_br"(%arg4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %18 = "llvm.load"(%17) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i64
    "llvm.call"(%18) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> ()
    "llvm.store"(%arg3, %17) <{alignment = 4 : i64, ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "llvm.br"()[^bb1] : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "always_drop_promoted_declare", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %14 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %15 = "llvm.alloca"(%14) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%15) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.intr.dbg.value"(%15) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "keep_dbg_if_not_promoted", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %11 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %12 = "llvm.alloca"(%11) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%12) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    %13 = "llvm.alloca"(%11) <{alignment = 8 : i64, elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%13) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable1}> : (!llvm.ptr) -> ()
    "llvm.call"(%12) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @use_ptr, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "store_load_store_back", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %7 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %8 = "llvm.mlir.constant"() <{value = 42 : i64}> : () -> i64
    %9 = "llvm.alloca"(%7) <{elem_type = i64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%9) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.store"(%8, %9) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    %10 = "llvm.load"(%9) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    "llvm.store"(%10, %9) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (f32)>, linkage = #llvm.linkage<external>, sym_name = "dbg_declare_with_store_type_conversion", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg2: f32):
    %4 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "llvm.alloca"(%4) <{alignment = 4 : i64, elem_type = i32}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%5) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "llvm.store"(%arg2, %5) <{alignment = 4 : i64, ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    %6 = "llvm.load"(%5) <{alignment = 4 : i64, ordering = 0 : i64}> : (!llvm.ptr) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i1, i1)>, linkage = #llvm.linkage<external>, sym_name = "nested_store_load_store_back", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 4.000000e+00 : f64}> : () -> f64
    %2 = "llvm.alloca"(%0) <{elem_type = f64}> : (i32) -> !llvm.ptr
    "llvm.intr.dbg.declare"(%2) <{locationExpr = #llvm.di_expression<>, varInfo = #di_local_variable}> : (!llvm.ptr) -> ()
    "scf.if"(%arg0) ({
      "llvm.store"(%1, %2) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
      %3 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> f64
      "llvm.store"(%3, %2) <{ordering = 0 : i64}> : (f64, !llvm.ptr) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

