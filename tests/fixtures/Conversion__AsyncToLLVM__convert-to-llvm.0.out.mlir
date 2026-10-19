module {
  func.func @reference_counting(%arg0: !llvm.ptr) {
    %c2_i64 = arith.constant 2 : i64
    call @mlirAsyncRuntimeAddRef(%arg0, %c2_i64) : (!llvm.ptr, i64) -> ()
    %c1_i64 = arith.constant 1 : i64
    call @mlirAsyncRuntimeDropRef(%arg0, %c1_i64) : (!llvm.ptr, i64) -> ()
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
}

// -----
module {
  llvm.func @free(!llvm.ptr)
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @execute_no_async_args(%arg0: f32, %arg1: memref<1xf32>) {
    %0 = call @async_execute_fn(%arg0, %arg1) : (f32, memref<1xf32>) -> !llvm.ptr
    call @mlirAsyncRuntimeAwaitToken(%0) : (!llvm.ptr) -> ()
    %1 = call @mlirAsyncRuntimeIsTokenError(%0) : (!llvm.ptr) -> i1
    %true = arith.constant true
    %2 = arith.xori %1, %true : i1
    cf.assert %2, "Awaited async operand is in error state"
    return
  }
  func.func private @async_execute_fn(%arg0: f32, %arg1: memref<1xf32>) -> !llvm.ptr attributes {passthrough = ["presplitcoroutine"]} {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
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
    %14 = llvm.intr.coro.save %13 : (!llvm.ptr) -> !llvm.token
    %15 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeExecute(%13, %15) : (!llvm.ptr, !llvm.ptr) -> ()
    %16 = llvm.mlir.constant(false) : i1
    %17 = llvm.intr.coro.suspend %14, %16 : i8
    %18 = llvm.sext %17 : i8 to i32
    llvm.switch %18 : i32, ^bb4 [
      0: ^bb1,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    %c0 = arith.constant 0 : index
    memref.store %arg0, %arg1[%c0] : memref<1xf32>
    call @mlirAsyncRuntimeEmplaceToken(%0) : (!llvm.ptr) -> ()
    cf.br ^bb2
  ^bb2:  // pred: ^bb1
    %19 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%19) : (!llvm.ptr) -> ()
    cf.br ^bb4
  ^bb3:  // pred: ^bb0
    %20 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%20) : (!llvm.ptr) -> ()
    cf.br ^bb4
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    %21 = llvm.mlir.constant(false) : i1
    %22 = llvm.mlir.none : !llvm.token
    %23 = llvm.intr.coro.end %13, %21, %22 : (!llvm.ptr, i1, !llvm.token) -> i1
    return %0 : !llvm.ptr
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

// -----
module {
  llvm.func @free(!llvm.ptr)
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @nested_async_execute(%arg0: f32, %arg1: f32, %arg2: memref<1xf32>) {
    %0 = call @async_execute_fn_0(%arg0, %arg2, %arg1) : (f32, memref<1xf32>, f32) -> !llvm.ptr
    call @mlirAsyncRuntimeAwaitToken(%0) : (!llvm.ptr) -> ()
    %1 = call @mlirAsyncRuntimeIsTokenError(%0) : (!llvm.ptr) -> i1
    %true = arith.constant true
    %2 = arith.xori %1, %true : i1
    cf.assert %2, "Awaited async operand is in error state"
    return
  }
  func.func private @async_execute_fn(%arg0: f32, %arg1: memref<1xf32>) -> !llvm.ptr attributes {passthrough = ["presplitcoroutine"]} {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
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
    %14 = llvm.intr.coro.save %13 : (!llvm.ptr) -> !llvm.token
    %15 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeExecute(%13, %15) : (!llvm.ptr, !llvm.ptr) -> ()
    %16 = llvm.mlir.constant(false) : i1
    %17 = llvm.intr.coro.suspend %14, %16 : i8
    %18 = llvm.sext %17 : i8 to i32
    llvm.switch %18 : i32, ^bb4 [
      0: ^bb1,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    memref.store %arg0, %arg1[%c0] : memref<1xf32>
    call @mlirAsyncRuntimeEmplaceToken(%0) : (!llvm.ptr) -> ()
    cf.br ^bb2
  ^bb2:  // pred: ^bb1
    %19 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%19) : (!llvm.ptr) -> ()
    cf.br ^bb4
  ^bb3:  // pred: ^bb0
    %20 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%20) : (!llvm.ptr) -> ()
    cf.br ^bb4
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    %21 = llvm.mlir.constant(false) : i1
    %22 = llvm.mlir.none : !llvm.token
    %23 = llvm.intr.coro.end %13, %21, %22 : (!llvm.ptr, i1, !llvm.token) -> i1
    return %0 : !llvm.ptr
  }
  func.func private @async_execute_fn_0(%arg0: f32, %arg1: memref<1xf32>, %arg2: f32) -> !llvm.ptr attributes {passthrough = ["presplitcoroutine"]} {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
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
    %14 = llvm.intr.coro.save %13 : (!llvm.ptr) -> !llvm.token
    %15 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeExecute(%13, %15) : (!llvm.ptr, !llvm.ptr) -> ()
    %16 = llvm.mlir.constant(false) : i1
    %17 = llvm.intr.coro.suspend %14, %16 : i8
    %18 = llvm.sext %17 : i8 to i32
    llvm.switch %18 : i32, ^bb7 [
      0: ^bb1,
      1: ^bb6
    ]
  ^bb1:  // pred: ^bb0
    %c0 = arith.constant 0 : index
    %19 = call @async_execute_fn(%arg0, %arg1) : (f32, memref<1xf32>) -> !llvm.ptr
    %20 = llvm.intr.coro.save %13 : (!llvm.ptr) -> !llvm.token
    %21 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeAwaitTokenAndExecute(%19, %13, %21) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    %22 = llvm.mlir.constant(false) : i1
    %23 = llvm.intr.coro.suspend %20, %22 : i8
    %24 = llvm.sext %23 : i8 to i32
    llvm.switch %24 : i32, ^bb7 [
      0: ^bb2,
      1: ^bb6
    ]
  ^bb2:  // pred: ^bb1
    %25 = call @mlirAsyncRuntimeIsTokenError(%19) : (!llvm.ptr) -> i1
    cf.cond_br %25, ^bb4, ^bb3
  ^bb3:  // pred: ^bb2
    memref.store %arg2, %arg1[%c0] : memref<1xf32>
    call @mlirAsyncRuntimeEmplaceToken(%0) : (!llvm.ptr) -> ()
    cf.br ^bb5
  ^bb4:  // pred: ^bb2
    call @mlirAsyncRuntimeSetTokenError(%0) : (!llvm.ptr) -> ()
    cf.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %26 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%26) : (!llvm.ptr) -> ()
    cf.br ^bb7
  ^bb6:  // 2 preds: ^bb0, ^bb1
    %27 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%27) : (!llvm.ptr) -> ()
    cf.br ^bb7
  ^bb7:  // 4 preds: ^bb0, ^bb1, ^bb5, ^bb6
    %28 = llvm.mlir.constant(false) : i1
    %29 = llvm.mlir.none : !llvm.token
    %30 = llvm.intr.coro.end %13, %28, %29 : (!llvm.ptr, i1, !llvm.token) -> i1
    return %0 : !llvm.ptr
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

// -----
module {
  llvm.func @free(!llvm.ptr)
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @async_execute_token_dependency(%arg0: f32, %arg1: memref<1xf32>) {
    %0 = call @async_execute_fn(%arg0, %arg1) : (f32, memref<1xf32>) -> !llvm.ptr
    %1 = call @async_execute_fn_0(%0, %arg0, %arg1) : (!llvm.ptr, f32, memref<1xf32>) -> !llvm.ptr
    return
  }
  func.func private @async_execute_fn(%arg0: f32, %arg1: memref<1xf32>) -> !llvm.ptr attributes {passthrough = ["presplitcoroutine"]} {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
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
    %14 = llvm.intr.coro.save %13 : (!llvm.ptr) -> !llvm.token
    %15 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeExecute(%13, %15) : (!llvm.ptr, !llvm.ptr) -> ()
    %16 = llvm.mlir.constant(false) : i1
    %17 = llvm.intr.coro.suspend %14, %16 : i8
    %18 = llvm.sext %17 : i8 to i32
    llvm.switch %18 : i32, ^bb4 [
      0: ^bb1,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    %c0 = arith.constant 0 : index
    memref.store %arg0, %arg1[%c0] : memref<1xf32>
    call @mlirAsyncRuntimeEmplaceToken(%0) : (!llvm.ptr) -> ()
    cf.br ^bb2
  ^bb2:  // pred: ^bb1
    %19 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%19) : (!llvm.ptr) -> ()
    cf.br ^bb4
  ^bb3:  // pred: ^bb0
    %20 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%20) : (!llvm.ptr) -> ()
    cf.br ^bb4
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    %21 = llvm.mlir.constant(false) : i1
    %22 = llvm.mlir.none : !llvm.token
    %23 = llvm.intr.coro.end %13, %21, %22 : (!llvm.ptr, i1, !llvm.token) -> i1
    return %0 : !llvm.ptr
  }
  func.func private @async_execute_fn_0(%arg0: !llvm.ptr, %arg1: f32, %arg2: memref<1xf32>) -> !llvm.ptr attributes {passthrough = ["presplitcoroutine"]} {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
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
    %14 = llvm.intr.coro.save %13 : (!llvm.ptr) -> !llvm.token
    %15 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeExecute(%13, %15) : (!llvm.ptr, !llvm.ptr) -> ()
    %16 = llvm.mlir.constant(false) : i1
    %17 = llvm.intr.coro.suspend %14, %16 : i8
    %18 = llvm.sext %17 : i8 to i32
    llvm.switch %18 : i32, ^bb7 [
      0: ^bb1,
      1: ^bb6
    ]
  ^bb1:  // pred: ^bb0
    %19 = llvm.intr.coro.save %13 : (!llvm.ptr) -> !llvm.token
    %20 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeAwaitTokenAndExecute(%arg0, %13, %20) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    %21 = llvm.mlir.constant(false) : i1
    %22 = llvm.intr.coro.suspend %19, %21 : i8
    %23 = llvm.sext %22 : i8 to i32
    llvm.switch %23 : i32, ^bb7 [
      0: ^bb2,
      1: ^bb6
    ]
  ^bb2:  // pred: ^bb1
    %24 = call @mlirAsyncRuntimeIsTokenError(%arg0) : (!llvm.ptr) -> i1
    cf.cond_br %24, ^bb4, ^bb3
  ^bb3:  // pred: ^bb2
    %c0 = arith.constant 0 : index
    memref.store %arg1, %arg2[%c0] : memref<1xf32>
    call @mlirAsyncRuntimeEmplaceToken(%0) : (!llvm.ptr) -> ()
    cf.br ^bb5
  ^bb4:  // pred: ^bb2
    call @mlirAsyncRuntimeSetTokenError(%0) : (!llvm.ptr) -> ()
    cf.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %25 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%25) : (!llvm.ptr) -> ()
    cf.br ^bb7
  ^bb6:  // 2 preds: ^bb0, ^bb1
    %26 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%26) : (!llvm.ptr) -> ()
    cf.br ^bb7
  ^bb7:  // 4 preds: ^bb0, ^bb1, ^bb5, ^bb6
    %27 = llvm.mlir.constant(false) : i1
    %28 = llvm.mlir.none : !llvm.token
    %29 = llvm.intr.coro.end %13, %27, %28 : (!llvm.ptr, i1, !llvm.token) -> i1
    return %0 : !llvm.ptr
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

// -----
module {
  llvm.func @free(!llvm.ptr)
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @async_group_await_all(%arg0: f32, %arg1: memref<1xf32>) {
    %c1 = arith.constant 1 : index
    %0 = builtin.unrealized_conversion_cast %c1 : index to i64
    %1 = call @mlirAsyncRuntimeCreateGroup(%0) : (i64) -> !llvm.ptr
    %2 = call @async_execute_fn() : () -> !llvm.ptr
    %3 = call @mlirAsyncRuntimeAddTokenToGroup(%2, %1) : (!llvm.ptr, !llvm.ptr) -> i64
    %4 = call @async_execute_fn_0(%1) : (!llvm.ptr) -> !llvm.ptr
    call @mlirAsyncRuntimeAwaitAllInGroup(%1) : (!llvm.ptr) -> ()
    %5 = call @mlirAsyncRuntimeIsGroupError(%1) : (!llvm.ptr) -> i1
    %true = arith.constant true
    %6 = arith.xori %5, %true : i1
    cf.assert %6, "Awaited async operand is in error state"
    return
  }
  func.func private @async_execute_fn() -> !llvm.ptr attributes {passthrough = ["presplitcoroutine"]} {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
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
    %14 = llvm.intr.coro.save %13 : (!llvm.ptr) -> !llvm.token
    %15 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeExecute(%13, %15) : (!llvm.ptr, !llvm.ptr) -> ()
    %16 = llvm.mlir.constant(false) : i1
    %17 = llvm.intr.coro.suspend %14, %16 : i8
    %18 = llvm.sext %17 : i8 to i32
    llvm.switch %18 : i32, ^bb4 [
      0: ^bb1,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    call @mlirAsyncRuntimeEmplaceToken(%0) : (!llvm.ptr) -> ()
    cf.br ^bb2
  ^bb2:  // pred: ^bb1
    %19 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%19) : (!llvm.ptr) -> ()
    cf.br ^bb4
  ^bb3:  // pred: ^bb0
    %20 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%20) : (!llvm.ptr) -> ()
    cf.br ^bb4
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    %21 = llvm.mlir.constant(false) : i1
    %22 = llvm.mlir.none : !llvm.token
    %23 = llvm.intr.coro.end %13, %21, %22 : (!llvm.ptr, i1, !llvm.token) -> i1
    return %0 : !llvm.ptr
  }
  func.func private @async_execute_fn_0(%arg0: !llvm.ptr) -> !llvm.ptr attributes {passthrough = ["presplitcoroutine"]} {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
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
    %14 = llvm.intr.coro.save %13 : (!llvm.ptr) -> !llvm.token
    %15 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeExecute(%13, %15) : (!llvm.ptr, !llvm.ptr) -> ()
    %16 = llvm.mlir.constant(false) : i1
    %17 = llvm.intr.coro.suspend %14, %16 : i8
    %18 = llvm.sext %17 : i8 to i32
    llvm.switch %18 : i32, ^bb7 [
      0: ^bb1,
      1: ^bb6
    ]
  ^bb1:  // pred: ^bb0
    %19 = llvm.intr.coro.save %13 : (!llvm.ptr) -> !llvm.token
    %20 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeAwaitAllInGroupAndExecute(%arg0, %13, %20) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    %21 = llvm.mlir.constant(false) : i1
    %22 = llvm.intr.coro.suspend %19, %21 : i8
    %23 = llvm.sext %22 : i8 to i32
    llvm.switch %23 : i32, ^bb7 [
      0: ^bb2,
      1: ^bb6
    ]
  ^bb2:  // pred: ^bb1
    %24 = call @mlirAsyncRuntimeIsGroupError(%arg0) : (!llvm.ptr) -> i1
    cf.cond_br %24, ^bb4, ^bb3
  ^bb3:  // pred: ^bb2
    call @mlirAsyncRuntimeEmplaceToken(%0) : (!llvm.ptr) -> ()
    cf.br ^bb5
  ^bb4:  // pred: ^bb2
    call @mlirAsyncRuntimeSetTokenError(%0) : (!llvm.ptr) -> ()
    cf.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %25 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%25) : (!llvm.ptr) -> ()
    cf.br ^bb7
  ^bb6:  // 2 preds: ^bb0, ^bb1
    %26 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%26) : (!llvm.ptr) -> ()
    cf.br ^bb7
  ^bb7:  // 4 preds: ^bb0, ^bb1, ^bb5, ^bb6
    %27 = llvm.mlir.constant(false) : i1
    %28 = llvm.mlir.none : !llvm.token
    %29 = llvm.intr.coro.end %13, %27, %28 : (!llvm.ptr, i1, !llvm.token) -> i1
    return %0 : !llvm.ptr
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

// -----
module {
  llvm.func @free(!llvm.ptr)
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @execute_and_return_f32() -> f32 {
    %0:2 = call @async_execute_fn() : () -> (!llvm.ptr, !llvm.ptr)
    call @mlirAsyncRuntimeAwaitValue(%0#1) : (!llvm.ptr) -> ()
    %1 = call @mlirAsyncRuntimeIsValueError(%0#1) : (!llvm.ptr) -> i1
    %true = arith.constant true
    %2 = arith.xori %1, %true : i1
    cf.assert %2, "Awaited async operand is in error state"
    %3 = call @mlirAsyncRuntimeGetValueStorage(%0#1) : (!llvm.ptr) -> !llvm.ptr
    %4 = llvm.load %3 : !llvm.ptr -> f32
    return %4 : f32
  }
  func.func private @async_execute_fn() -> (!llvm.ptr, !llvm.ptr) attributes {passthrough = ["presplitcoroutine"]} {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr %1[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = call @mlirAsyncRuntimeCreateValue(%3) : (i64) -> !llvm.ptr
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.intr.coro.id %5, %6, %6, %6 : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %8 = llvm.intr.coro.size : i64
    %9 = llvm.intr.coro.align : i64
    %10 = llvm.add %8, %9 : i64
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.sub %10, %11 : i64
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.sub %13, %9 : i64
    %15 = llvm.and %12, %14 : i64
    %16 = llvm.call @aligned_alloc(%9, %15) : (i64, i64) -> !llvm.ptr
    %17 = llvm.intr.coro.begin %7, %16 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %18 = llvm.intr.coro.save %17 : (!llvm.ptr) -> !llvm.token
    %19 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeExecute(%17, %19) : (!llvm.ptr, !llvm.ptr) -> ()
    %20 = llvm.mlir.constant(false) : i1
    %21 = llvm.intr.coro.suspend %18, %20 : i8
    %22 = llvm.sext %21 : i8 to i32
    llvm.switch %22 : i32, ^bb4 [
      0: ^bb1,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    %cst = arith.constant 1.230000e+02 : f32
    %23 = call @mlirAsyncRuntimeGetValueStorage(%4) : (!llvm.ptr) -> !llvm.ptr
    llvm.store %cst, %23 : f32, !llvm.ptr
    call @mlirAsyncRuntimeEmplaceValue(%4) : (!llvm.ptr) -> ()
    call @mlirAsyncRuntimeEmplaceToken(%0) : (!llvm.ptr) -> ()
    cf.br ^bb2
  ^bb2:  // pred: ^bb1
    %24 = llvm.intr.coro.free %7, %17 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%24) : (!llvm.ptr) -> ()
    cf.br ^bb4
  ^bb3:  // pred: ^bb0
    %25 = llvm.intr.coro.free %7, %17 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%25) : (!llvm.ptr) -> ()
    cf.br ^bb4
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    %26 = llvm.mlir.constant(false) : i1
    %27 = llvm.mlir.none : !llvm.token
    %28 = llvm.intr.coro.end %17, %26, %27 : (!llvm.ptr, i1, !llvm.token) -> i1
    return %0, %4 : !llvm.ptr, !llvm.ptr
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

// -----
module {
  llvm.func @free(!llvm.ptr)
  llvm.func @aligned_alloc(i64, i64) -> !llvm.ptr
  func.func @async_value_operands() {
    %0:2 = call @async_execute_fn() : () -> (!llvm.ptr, !llvm.ptr)
    %1 = call @async_execute_fn_0(%0#1) : (!llvm.ptr) -> !llvm.ptr
    call @mlirAsyncRuntimeAwaitToken(%1) : (!llvm.ptr) -> ()
    %2 = call @mlirAsyncRuntimeIsTokenError(%1) : (!llvm.ptr) -> i1
    %true = arith.constant true
    %3 = arith.xori %2, %true : i1
    cf.assert %3, "Awaited async operand is in error state"
    return
  }
  func.func private @async_execute_fn() -> (!llvm.ptr, !llvm.ptr) attributes {passthrough = ["presplitcoroutine"]} {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr %1[1] : (!llvm.ptr) -> !llvm.ptr, f32
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = call @mlirAsyncRuntimeCreateValue(%3) : (i64) -> !llvm.ptr
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.intr.coro.id %5, %6, %6, %6 : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %8 = llvm.intr.coro.size : i64
    %9 = llvm.intr.coro.align : i64
    %10 = llvm.add %8, %9 : i64
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.sub %10, %11 : i64
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.sub %13, %9 : i64
    %15 = llvm.and %12, %14 : i64
    %16 = llvm.call @aligned_alloc(%9, %15) : (i64, i64) -> !llvm.ptr
    %17 = llvm.intr.coro.begin %7, %16 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %18 = llvm.intr.coro.save %17 : (!llvm.ptr) -> !llvm.token
    %19 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeExecute(%17, %19) : (!llvm.ptr, !llvm.ptr) -> ()
    %20 = llvm.mlir.constant(false) : i1
    %21 = llvm.intr.coro.suspend %18, %20 : i8
    %22 = llvm.sext %21 : i8 to i32
    llvm.switch %22 : i32, ^bb4 [
      0: ^bb1,
      1: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    %cst = arith.constant 1.230000e+02 : f32
    %23 = call @mlirAsyncRuntimeGetValueStorage(%4) : (!llvm.ptr) -> !llvm.ptr
    llvm.store %cst, %23 : f32, !llvm.ptr
    call @mlirAsyncRuntimeEmplaceValue(%4) : (!llvm.ptr) -> ()
    call @mlirAsyncRuntimeEmplaceToken(%0) : (!llvm.ptr) -> ()
    cf.br ^bb2
  ^bb2:  // pred: ^bb1
    %24 = llvm.intr.coro.free %7, %17 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%24) : (!llvm.ptr) -> ()
    cf.br ^bb4
  ^bb3:  // pred: ^bb0
    %25 = llvm.intr.coro.free %7, %17 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%25) : (!llvm.ptr) -> ()
    cf.br ^bb4
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    %26 = llvm.mlir.constant(false) : i1
    %27 = llvm.mlir.none : !llvm.token
    %28 = llvm.intr.coro.end %17, %26, %27 : (!llvm.ptr, i1, !llvm.token) -> i1
    return %0, %4 : !llvm.ptr, !llvm.ptr
  }
  func.func private @async_execute_fn_0(%arg0: !llvm.ptr) -> !llvm.ptr attributes {passthrough = ["presplitcoroutine"]} {
    %0 = call @mlirAsyncRuntimeCreateToken() : () -> !llvm.ptr
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
    %14 = llvm.intr.coro.save %13 : (!llvm.ptr) -> !llvm.token
    %15 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeExecute(%13, %15) : (!llvm.ptr, !llvm.ptr) -> ()
    %16 = llvm.mlir.constant(false) : i1
    %17 = llvm.intr.coro.suspend %14, %16 : i8
    %18 = llvm.sext %17 : i8 to i32
    llvm.switch %18 : i32, ^bb7 [
      0: ^bb1,
      1: ^bb6
    ]
  ^bb1:  // pred: ^bb0
    %19 = llvm.intr.coro.save %13 : (!llvm.ptr) -> !llvm.token
    %20 = llvm.mlir.addressof @__resume : !llvm.ptr
    call @mlirAsyncRuntimeAwaitValueAndExecute(%arg0, %13, %20) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    %21 = llvm.mlir.constant(false) : i1
    %22 = llvm.intr.coro.suspend %19, %21 : i8
    %23 = llvm.sext %22 : i8 to i32
    llvm.switch %23 : i32, ^bb7 [
      0: ^bb2,
      1: ^bb6
    ]
  ^bb2:  // pred: ^bb1
    %24 = call @mlirAsyncRuntimeIsValueError(%arg0) : (!llvm.ptr) -> i1
    cf.cond_br %24, ^bb4, ^bb3
  ^bb3:  // pred: ^bb2
    %25 = call @mlirAsyncRuntimeGetValueStorage(%arg0) : (!llvm.ptr) -> !llvm.ptr
    %26 = llvm.load %25 : !llvm.ptr -> f32
    %27 = arith.addf %26, %26 : f32
    call @mlirAsyncRuntimeEmplaceToken(%0) : (!llvm.ptr) -> ()
    cf.br ^bb5
  ^bb4:  // pred: ^bb2
    call @mlirAsyncRuntimeSetTokenError(%0) : (!llvm.ptr) -> ()
    cf.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %28 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%28) : (!llvm.ptr) -> ()
    cf.br ^bb7
  ^bb6:  // 2 preds: ^bb0, ^bb1
    %29 = llvm.intr.coro.free %3, %13 : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    llvm.call @free(%29) : (!llvm.ptr) -> ()
    cf.br ^bb7
  ^bb7:  // 4 preds: ^bb0, ^bb1, ^bb5, ^bb6
    %30 = llvm.mlir.constant(false) : i1
    %31 = llvm.mlir.none : !llvm.token
    %32 = llvm.intr.coro.end %13, %30, %31 : (!llvm.ptr, i1, !llvm.token) -> i1
    return %0 : !llvm.ptr
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

