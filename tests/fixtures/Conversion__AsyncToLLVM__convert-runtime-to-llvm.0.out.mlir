module {
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @create_token() {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
    return
  }
  func.func @create_value() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr %0[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = call @mlirAsyncRuntimeCreateValue(%2) : (i64) -> !llvm.ptr
    return
  }
  func.func @create_group() {
    %c1 = arith.constant 1 : index
    %0 = builtin.unrealized_conversion_cast %c1 : index to i64
    %1 = call @mlirAsyncRuntimeCreateGroup(%0) : (i64) -> !llvm.ptr
    return
  }
  func.func @set_token_available() {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
    call @mlirAsyncRuntimeEmplaceToken(%0) : (!llvm.ptr) -> ()
    return
  }
  func.func @set_value_available() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr %0[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = call @mlirAsyncRuntimeCreateValue(%2) : (i64) -> !llvm.ptr
    call @mlirAsyncRuntimeEmplaceValue(%3) : (!llvm.ptr) -> ()
    return
  }
  func.func @is_token_error() -> i1 {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
    %1 = call @mlirAsyncRuntimeIsTokenError(%0) : (!llvm.ptr) -> i1
    return %1 : i1
  }
  func.func @is_value_error() -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr %0[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = call @mlirAsyncRuntimeCreateValue(%2) : (i64) -> !llvm.ptr
    %4 = call @mlirAsyncRuntimeIsValueError(%3) : (!llvm.ptr) -> i1
    return %4 : i1
  }
  func.func @await_token() {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
    call @mlirAsyncRuntimeAwaitToken(%0) : (!llvm.ptr) -> ()
    return
  }
  func.func @await_value() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr %0[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = call @mlirAsyncRuntimeCreateValue(%2) : (i64) -> !llvm.ptr
    call @mlirAsyncRuntimeAwaitValue(%3) : (!llvm.ptr) -> ()
    return
  }
  func.func @await_group() {
    %c1 = arith.constant 1 : index
    %0 = builtin.unrealized_conversion_cast %c1 : index to i64
    %1 = call @mlirAsyncRuntimeCreateGroup(%0) : (i64) -> !llvm.ptr
    call @mlirAsyncRuntimeAwaitAllInGroup(%1) : (!llvm.ptr) -> ()
    return
  }
  func.func @await_and_resume_token() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.intr.coro.id %0, %1, %1, %1 : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %3 = llvm.intr.coro.size : i64
    %4 = llvm.intr.coro.align : i64
    %5 = llvm.add %3, %4 : i64
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.sub %5, %6 : i64
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.sub %8, %4 : i64
    %10 = llvm.and %7, %9 : i64
    %11 = llvm.call @aligned_alloc(%4, %10) : (i64, i64) -> !llvm.ptr
    %12 = llvm.intr.coro.begin %2, %11 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %13 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
    %14 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeAwaitTokenAndExecute(%13, %12, %14) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    return
  }
  func.func @await_and_resume_value() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.intr.coro.id %0, %1, %1, %1 : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %3 = llvm.intr.coro.size : i64
    %4 = llvm.intr.coro.align : i64
    %5 = llvm.add %3, %4 : i64
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.sub %5, %6 : i64
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.sub %8, %4 : i64
    %10 = llvm.and %7, %9 : i64
    %11 = llvm.call @aligned_alloc(%4, %10) : (i64, i64) -> !llvm.ptr
    %12 = llvm.intr.coro.begin %2, %11 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %13 = llvm.mlir.zero : !llvm.ptr
    %14 = llvm.getelementptr %13[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %15 = llvm.ptrtoint %14 : !llvm.ptr to i64
    %16 = call @mlirAsyncRuntimeCreateValue(%15) : (i64) -> !llvm.ptr
    %17 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeAwaitValueAndExecute(%16, %12, %17) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    return
  }
  func.func @await_and_resume_group() {
    %c1 = arith.constant 1 : index
    %0 = builtin.unrealized_conversion_cast %c1 : index to i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.intr.coro.id %1, %2, %2, %2 : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %4 = llvm.intr.coro.size : i64
    %5 = llvm.intr.coro.align : i64
    %6 = llvm.add %4, %5 : i64
    %7 = llvm.mlir.constant(1 : i64) : i64
    %8 = llvm.sub %6, %7 : i64
    %9 = llvm.mlir.constant(0 : i64) : i64
    %10 = llvm.sub %9, %5 : i64
    %11 = llvm.and %8, %10 : i64
    %12 = llvm.call @aligned_alloc(%5, %11) : (i64, i64) -> !llvm.ptr
    %13 = llvm.intr.coro.begin %3, %12 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %14 = call @mlirAsyncRuntimeCreateGroup(%0) : (i64) -> !llvm.ptr
    %15 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeAwaitAllInGroupAndExecute(%14, %13, %15) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    return
  }
  func.func @resume() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.intr.coro.id %0, %1, %1, %1 : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %3 = llvm.intr.coro.size : i64
    %4 = llvm.intr.coro.align : i64
    %5 = llvm.add %3, %4 : i64
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.sub %5, %6 : i64
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.sub %8, %4 : i64
    %10 = llvm.and %7, %9 : i64
    %11 = llvm.call @aligned_alloc(%4, %10) : (i64, i64) -> !llvm.ptr
    %12 = llvm.intr.coro.begin %2, %11 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %13 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeExecute(%12, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    return
  }
  func.func @store() {
    %cst = arith.constant 1.000000e+00 : f32
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr %0[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = call @mlirAsyncRuntimeCreateValue(%2) : (i64) -> !llvm.ptr
    %4 = call @mlirAsyncRuntimeGetValueStorage(%3) : (!llvm.ptr) -> !llvm.ptr
    llvm.store %cst, %4 : f32, !llvm.ptr
    return
  }
  func.func @load() -> f32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr %0[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = call @mlirAsyncRuntimeCreateValue(%2) : (i64) -> !llvm.ptr
    %4 = call @mlirAsyncRuntimeGetValueStorage(%3) : (!llvm.ptr) -> !llvm.ptr
    %5 = llvm.load %4 : !llvm.ptr -> f32
    return %5 : f32
  }
  func.func @add_token_to_group() {
    %c1 = arith.constant 1 : index
    %0 = builtin.unrealized_conversion_cast %c1 : index to i64
    %1 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
    %2 = call @mlirAsyncRuntimeCreateGroup(%0) : (i64) -> !llvm.ptr
    %3 = call @mlirAsyncRuntimeAddTokenToGroup(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i64
    return
  }
  func.func private @mlirAsyncRuntimeAddRef(!llvm.ptr, i64)
  func.func private @mlirAsyncRuntimeDropRef(!llvm.ptr, i64)
  func.func private @mlirAsyncRuntimeCreateToken() -> !llvm.ptr
  func.func private @mlirAsyncRuntimeCreateValue(i64) -> !llvm.ptr
  func.func private @mlirAsyncRuntimeCreateGroup(i64) -> !llvm.ptr
  func.func private @mlirAsyncRuntimeEmplaceToken(!llvm.ptr)
  func.func private @mlirAsyncRuntimeEmplaceValue(!llvm.ptr)
  func.func private @mlirAsyncRuntimeSetTokenError(!llvm.ptr)
  func.func private @mlirAsyncRuntimeSetValueError(!llvm.ptr)
  func.func private @mlirAsyncRuntimeIsTokenError(!llvm.ptr) -> i1
  func.func private @mlirAsyncRuntimeIsValueError(!llvm.ptr) -> i1
  func.func private @mlirAsyncRuntimeIsGroupError(!llvm.ptr) -> i1
  func.func private @mlirAsyncRuntimeAwaitToken(!llvm.ptr)
  func.func private @mlirAsyncRuntimeAwaitValue(!llvm.ptr)
  func.func private @mlirAsyncRuntimeAwaitAllInGroup(!llvm.ptr)
  func.func private @mlirAsyncRuntimeExecute(!llvm.ptr, !llvm.ptr)
  func.func private @mlirAsyncRuntimeGetValueStorage(!llvm.ptr) -> !llvm.ptr
  func.func private @mlirAsyncRuntimeAddTokenToGroup(!llvm.ptr, !llvm.ptr) -> i64
  func.func private @mlirAsyncRuntimeAwaitTokenAndExecute(!llvm.ptr, !llvm.ptr, !llvm.ptr)
  func.func private @mlirAsyncRuntimeAwaitValueAndExecute(!llvm.ptr, !llvm.ptr, !llvm.ptr)
  func.func private @mlirAsyncRuntimeAwaitAllInGroupAndExecute(!llvm.ptr, !llvm.ptr, !llvm.ptr)
  func.func private @mlirAsyncRuntimGetNumWorkerThreads() -> index
  llvm.func @__resume(%arg0: !llvm.ptr) attributes {sym_visibility = "private"} {
    llvm.intr.coro.resume %arg0 : !llvm.ptr
    llvm.return
  }
}

