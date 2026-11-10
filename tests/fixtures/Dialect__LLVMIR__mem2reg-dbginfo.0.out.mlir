#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "ptr sized type", sizeInBits = 64>
#di_file = #llvm.di_file<"test.ll" in "">
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C_plus_plus_14, file = #di_file, producer = "clang", emissionKind = Full>
#di_subprogram = #llvm.di_subprogram<compileUnit = #di_compile_unit, scope = #di_file, name = "blah", linkageName = "blah", file = #di_file, line = 7, subprogramFlags = Definition>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "ptr sized var", file = #di_file, line = 7, arg = 1, type = #di_basic_type>
module {
  llvm.func @use(i64)
  llvm.func @use_ptr(!llvm.ptr)
  llvm.func @basic_store_load(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.intr.dbg.value #di_local_variable = %arg0 : i64
    llvm.return %arg0 : i64
  }
  llvm.func @multiple_store_load(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.intr.dbg.value #di_local_variable = %arg0 : i64
    llvm.intr.dbg.value #di_local_variable = %arg0 : i64
    llvm.return %arg0 : i64
  }
  llvm.func @block_argument_value(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2(%0 : i64)
  ^bb1:  // pred: ^bb0
    llvm.intr.dbg.value #di_local_variable = %arg0 : i64
    llvm.br ^bb2(%arg0 : i64)
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    llvm.intr.dbg.value #di_local_variable = %2 : i64
    llvm.return %2 : i64
  }
  llvm.func @double_block_argument_value(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %arg1, ^bb1(%0 : i64), ^bb2(%0 : i64)
  ^bb1(%2: i64):  // 2 preds: ^bb0, ^bb2
    llvm.intr.dbg.value #di_local_variable = %2 : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.intr.dbg.value #di_local_variable = %arg0 : i64
    llvm.br ^bb2(%arg0 : i64)
  ^bb2(%3: i64):  // 2 preds: ^bb0, ^bb1
    llvm.intr.dbg.value #di_local_variable = %3 : i64
    llvm.br ^bb1(%3 : i64)
  }
  llvm.func @always_drop_promoted_declare() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.ptr
    llvm.intr.dbg.value #di_local_variable = %1 : !llvm.ptr
    llvm.return
  }
  llvm.func @keep_dbg_if_not_promoted() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.intr.dbg.declare #di_local_variable = %1 : !llvm.ptr
    llvm.call @use_ptr(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @store_load_store_back() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i64) : i64
    llvm.intr.dbg.value #di_local_variable = %1 : i64
    llvm.intr.dbg.value #di_local_variable = %1 : i64
    llvm.return
  }
  llvm.func @dbg_declare_with_store_type_conversion(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    llvm.intr.dbg.value #di_local_variable = %1 : i32
    llvm.return %1 : i32
  }
  llvm.func @nested_store_load_store_back(%arg0: i1, %arg1: i1) {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %3 = scf.if %arg0 -> (f64) {
      llvm.intr.dbg.value #di_local_variable = %2 : f64
      llvm.intr.dbg.value #di_local_variable = %2 : f64
      scf.yield %2 : f64
    } else {
      scf.yield %0 : f64
    }
    llvm.return
  }
}

