module {
  llvm.func @free(!llvm.ptr)
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @coro_id() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.intr.coro.id %0, %1, %1, %1 : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    return
  }
  func.func @coro_begin() {
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
    return
  }
  func.func @coro_free() {
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
    %13 = llvm.intr.coro.free %2, %12 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%13) : (!llvm.ptr) -> ()
    return
  }
  func.func @coro_end() {
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
    %13 = llvm.mlir.constant(false) : i1
    %14 = llvm.mlir.none : !llvm.token
    %15 = llvm.intr.coro.end %12, %13, %14 : (!llvm.ptr, i1, !llvm.token) -> i1
    return
  }
  func.func @coro_save() {
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
    %13 = llvm.intr.coro.save %12 : (!llvm.ptr) -> !llvm.token
    return
  }
  func.func @coro_suspend() {
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
    %13 = llvm.intr.coro.save %12 : (!llvm.ptr) -> !llvm.token
    %14 = llvm.mlir.constant(false) : i1
    %15 = llvm.intr.coro.suspend %13, %14 : i8
    %16 = llvm.sext %15 : i8 to i32
    llvm.switch %16 : i32, ^bb3 [
      0: ^bb1,
      1: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    return {coro.resume}
  ^bb2:  // pred: ^bb0
    return {coro.cleanup}
  ^bb3:  // pred: ^bb0
    return {coro.suspend}
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
}

