module {
  llvm.func @check_attributes(%arg0: i64 {dialect.a = true, dialect.b = 4 : i64}) {
    llvm.return
  }
  llvm.func @check_memref(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64) {
    llvm.return
  }
  llvm.func @check_multiple(%arg0: f32 {first.arg = true}, %arg1: i64 {second.arg = 42 : i32}) {
    llvm.return
  }
}

