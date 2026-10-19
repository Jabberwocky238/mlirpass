"builtin.module"() ({
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "reference_counting"}> ({
  ^bb0(%arg0: !llvm.ptr):
    %0 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    "func.call"(%arg0, %0) <{callee = @mlirAsyncRuntimeAddRef}> : (!llvm.ptr, i64) -> ()
    %1 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    "func.call"(%arg0, %1) <{callee = @mlirAsyncRuntimeDropRef}> : (!llvm.ptr, i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeAddRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeDropRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsGroupError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeGetValueStorage", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> i64, sym_name = "mlirAsyncRuntimeAddTokenToGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitTokenAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValueAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroupAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "mlirAsyncRuntimGetNumWorkerThreads", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<1xf32>) -> (), sym_name = "execute_no_async_args"}> ({
  ^bb0(%arg3: f32, %arg4: memref<1xf32>):
    %25 = "func.call"(%arg3, %arg4) <{callee = @async_execute_fn}> : (f32, memref<1xf32>) -> !llvm.ptr
    "func.call"(%25) <{callee = @mlirAsyncRuntimeAwaitToken}> : (!llvm.ptr) -> ()
    %26 = "func.call"(%25) <{callee = @mlirAsyncRuntimeIsTokenError}> : (!llvm.ptr) -> i1
    %27 = "arith.constant"() <{value = true}> : () -> i1
    %28 = "arith.xori"(%26, %27) : (i1, i1) -> i1
    "cf.assert"(%28) <{msg = "Awaited async operand is in error state"}> : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<1xf32>) -> !llvm.ptr, sym_name = "async_execute_fn", sym_visibility = "private"}> ({
  ^bb0(%arg1: f32, %arg2: memref<1xf32>):
    %0 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.intr.coro.id"(%1, %2, %2, %2) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %4 = "llvm.intr.coro.size"() : () -> i64
    %5 = "llvm.intr.coro.align"() : () -> i64
    %6 = "llvm.add"(%4, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %8 = "llvm.sub"(%6, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %9 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %10 = "llvm.sub"(%9, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %11 = "llvm.and"(%8, %10) : (i64, i64) -> i64
    %12 = "llvm.call"(%5, %11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %13 = "llvm.intr.coro.begin"(%3, %12) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %14 = "llvm.intr.coro.save"(%13) : (!llvm.ptr) -> !llvm.token
    %15 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%13, %15) <{callee = @mlirAsyncRuntimeExecute}> : (!llvm.ptr, !llvm.ptr) -> ()
    %16 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %17 = "llvm.intr.coro.suspend"(%14, %16) : (!llvm.token, i1) -> i8
    %18 = "llvm.sext"(%17) : (i8) -> i32
    "llvm.switch"(%18)[^bb4, ^bb1, ^bb3] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    %19 = "arith.constant"() <{value = 0 : index}> : () -> index
    "memref.store"(%arg1, %arg2, %19) : (f32, memref<1xf32>, index) -> ()
    "func.call"(%0) <{callee = @mlirAsyncRuntimeEmplaceToken}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    %20 = "llvm.intr.coro.free"(%3, %13) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%20) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb3:  // pred: ^bb0
    %21 = "llvm.intr.coro.free"(%3, %13) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%21) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    %22 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %23 = "llvm.mlir.none"() : () -> !llvm.token
    %24 = "llvm.intr.coro.end"(%13, %22, %23) : (!llvm.ptr, i1, !llvm.token) -> i1
    "func.return"(%0) : (!llvm.ptr) -> ()
  }) {passthrough = ["presplitcoroutine"]} : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeAddRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeDropRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsGroupError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeGetValueStorage", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> i64, sym_name = "mlirAsyncRuntimeAddTokenToGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitTokenAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValueAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroupAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "mlirAsyncRuntimGetNumWorkerThreads", sym_visibility = "private"}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "__resume", sym_visibility = "private", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    "llvm.intr.coro.resume"(%arg0) : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, memref<1xf32>) -> (), sym_name = "nested_async_execute"}> ({
  ^bb0(%arg6: f32, %arg7: f32, %arg8: memref<1xf32>):
    %58 = "func.call"(%arg6, %arg8, %arg7) <{callee = @async_execute_fn_0}> : (f32, memref<1xf32>, f32) -> !llvm.ptr
    "func.call"(%58) <{callee = @mlirAsyncRuntimeAwaitToken}> : (!llvm.ptr) -> ()
    %59 = "func.call"(%58) <{callee = @mlirAsyncRuntimeIsTokenError}> : (!llvm.ptr) -> i1
    %60 = "arith.constant"() <{value = true}> : () -> i1
    %61 = "arith.xori"(%59, %60) : (i1, i1) -> i1
    "cf.assert"(%61) <{msg = "Awaited async operand is in error state"}> : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<1xf32>) -> !llvm.ptr, sym_name = "async_execute_fn", sym_visibility = "private"}> ({
  ^bb0(%arg4: f32, %arg5: memref<1xf32>):
    %32 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    %33 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %34 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %35 = "llvm.intr.coro.id"(%33, %34, %34, %34) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %36 = "llvm.intr.coro.size"() : () -> i64
    %37 = "llvm.intr.coro.align"() : () -> i64
    %38 = "llvm.add"(%36, %37) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %39 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %40 = "llvm.sub"(%38, %39) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %41 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %42 = "llvm.sub"(%41, %37) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %43 = "llvm.and"(%40, %42) : (i64, i64) -> i64
    %44 = "llvm.call"(%37, %43) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %45 = "llvm.intr.coro.begin"(%35, %44) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %46 = "llvm.intr.coro.save"(%45) : (!llvm.ptr) -> !llvm.token
    %47 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%45, %47) <{callee = @mlirAsyncRuntimeExecute}> : (!llvm.ptr, !llvm.ptr) -> ()
    %48 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %49 = "llvm.intr.coro.suspend"(%46, %48) : (!llvm.token, i1) -> i8
    %50 = "llvm.sext"(%49) : (i8) -> i32
    "llvm.switch"(%50)[^bb4, ^bb1, ^bb3] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    %51 = "arith.constant"() <{value = 0 : index}> : () -> index
    %52 = "arith.constant"() <{value = 1 : index}> : () -> index
    "memref.store"(%arg4, %arg5, %51) : (f32, memref<1xf32>, index) -> ()
    "func.call"(%32) <{callee = @mlirAsyncRuntimeEmplaceToken}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    %53 = "llvm.intr.coro.free"(%35, %45) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%53) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb3:  // pred: ^bb0
    %54 = "llvm.intr.coro.free"(%35, %45) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%54) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    %55 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %56 = "llvm.mlir.none"() : () -> !llvm.token
    %57 = "llvm.intr.coro.end"(%45, %55, %56) : (!llvm.ptr, i1, !llvm.token) -> i1
    "func.return"(%32) : (!llvm.ptr) -> ()
  }) {passthrough = ["presplitcoroutine"]} : () -> ()
  "func.func"() <{function_type = (f32, memref<1xf32>, f32) -> !llvm.ptr, sym_name = "async_execute_fn_0", sym_visibility = "private"}> ({
  ^bb0(%arg1: f32, %arg2: memref<1xf32>, %arg3: f32):
    %0 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.intr.coro.id"(%1, %2, %2, %2) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %4 = "llvm.intr.coro.size"() : () -> i64
    %5 = "llvm.intr.coro.align"() : () -> i64
    %6 = "llvm.add"(%4, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %8 = "llvm.sub"(%6, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %9 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %10 = "llvm.sub"(%9, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %11 = "llvm.and"(%8, %10) : (i64, i64) -> i64
    %12 = "llvm.call"(%5, %11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %13 = "llvm.intr.coro.begin"(%3, %12) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %14 = "llvm.intr.coro.save"(%13) : (!llvm.ptr) -> !llvm.token
    %15 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%13, %15) <{callee = @mlirAsyncRuntimeExecute}> : (!llvm.ptr, !llvm.ptr) -> ()
    %16 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %17 = "llvm.intr.coro.suspend"(%14, %16) : (!llvm.token, i1) -> i8
    %18 = "llvm.sext"(%17) : (i8) -> i32
    "llvm.switch"(%18)[^bb7, ^bb1, ^bb6] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    %19 = "arith.constant"() <{value = 0 : index}> : () -> index
    %20 = "func.call"(%arg1, %arg2) <{callee = @async_execute_fn}> : (f32, memref<1xf32>) -> !llvm.ptr
    %21 = "llvm.intr.coro.save"(%13) : (!llvm.ptr) -> !llvm.token
    %22 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%20, %13, %22) <{callee = @mlirAsyncRuntimeAwaitTokenAndExecute}> : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    %23 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %24 = "llvm.intr.coro.suspend"(%21, %23) : (!llvm.token, i1) -> i8
    %25 = "llvm.sext"(%24) : (i8) -> i32
    "llvm.switch"(%25)[^bb7, ^bb2, ^bb6] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb2:  // pred: ^bb1
    %26 = "func.call"(%20) <{callee = @mlirAsyncRuntimeIsTokenError}> : (!llvm.ptr) -> i1
    "cf.cond_br"(%26)[^bb4, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "memref.store"(%arg3, %arg2, %19) : (f32, memref<1xf32>, index) -> ()
    "func.call"(%0) <{callee = @mlirAsyncRuntimeEmplaceToken}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb5] : () -> ()
  ^bb4:  // pred: ^bb2
    "func.call"(%0) <{callee = @mlirAsyncRuntimeSetTokenError}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb5] : () -> ()
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %27 = "llvm.intr.coro.free"(%3, %13) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%27) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb7] : () -> ()
  ^bb6:  // 2 preds: ^bb0, ^bb1
    %28 = "llvm.intr.coro.free"(%3, %13) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%28) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb7] : () -> ()
  ^bb7:  // 4 preds: ^bb0, ^bb1, ^bb5, ^bb6
    %29 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %30 = "llvm.mlir.none"() : () -> !llvm.token
    %31 = "llvm.intr.coro.end"(%13, %29, %30) : (!llvm.ptr, i1, !llvm.token) -> i1
    "func.return"(%0) : (!llvm.ptr) -> ()
  }) {passthrough = ["presplitcoroutine"]} : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeAddRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeDropRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsGroupError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeGetValueStorage", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> i64, sym_name = "mlirAsyncRuntimeAddTokenToGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitTokenAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValueAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroupAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "mlirAsyncRuntimGetNumWorkerThreads", sym_visibility = "private"}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "__resume", sym_visibility = "private", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    "llvm.intr.coro.resume"(%arg0) : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<1xf32>) -> (), sym_name = "async_execute_token_dependency"}> ({
  ^bb0(%arg6: f32, %arg7: memref<1xf32>):
    %56 = "func.call"(%arg6, %arg7) <{callee = @async_execute_fn}> : (f32, memref<1xf32>) -> !llvm.ptr
    %57 = "func.call"(%56, %arg6, %arg7) <{callee = @async_execute_fn_0}> : (!llvm.ptr, f32, memref<1xf32>) -> !llvm.ptr
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<1xf32>) -> !llvm.ptr, sym_name = "async_execute_fn", sym_visibility = "private"}> ({
  ^bb0(%arg4: f32, %arg5: memref<1xf32>):
    %31 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    %32 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %33 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %34 = "llvm.intr.coro.id"(%32, %33, %33, %33) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %35 = "llvm.intr.coro.size"() : () -> i64
    %36 = "llvm.intr.coro.align"() : () -> i64
    %37 = "llvm.add"(%35, %36) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %38 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %39 = "llvm.sub"(%37, %38) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %40 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %41 = "llvm.sub"(%40, %36) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %42 = "llvm.and"(%39, %41) : (i64, i64) -> i64
    %43 = "llvm.call"(%36, %42) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %44 = "llvm.intr.coro.begin"(%34, %43) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %45 = "llvm.intr.coro.save"(%44) : (!llvm.ptr) -> !llvm.token
    %46 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%44, %46) <{callee = @mlirAsyncRuntimeExecute}> : (!llvm.ptr, !llvm.ptr) -> ()
    %47 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %48 = "llvm.intr.coro.suspend"(%45, %47) : (!llvm.token, i1) -> i8
    %49 = "llvm.sext"(%48) : (i8) -> i32
    "llvm.switch"(%49)[^bb4, ^bb1, ^bb3] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    %50 = "arith.constant"() <{value = 0 : index}> : () -> index
    "memref.store"(%arg4, %arg5, %50) : (f32, memref<1xf32>, index) -> ()
    "func.call"(%31) <{callee = @mlirAsyncRuntimeEmplaceToken}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    %51 = "llvm.intr.coro.free"(%34, %44) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%51) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb3:  // pred: ^bb0
    %52 = "llvm.intr.coro.free"(%34, %44) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%52) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    %53 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %54 = "llvm.mlir.none"() : () -> !llvm.token
    %55 = "llvm.intr.coro.end"(%44, %53, %54) : (!llvm.ptr, i1, !llvm.token) -> i1
    "func.return"(%31) : (!llvm.ptr) -> ()
  }) {passthrough = ["presplitcoroutine"]} : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, f32, memref<1xf32>) -> !llvm.ptr, sym_name = "async_execute_fn_0", sym_visibility = "private"}> ({
  ^bb0(%arg1: !llvm.ptr, %arg2: f32, %arg3: memref<1xf32>):
    %0 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.intr.coro.id"(%1, %2, %2, %2) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %4 = "llvm.intr.coro.size"() : () -> i64
    %5 = "llvm.intr.coro.align"() : () -> i64
    %6 = "llvm.add"(%4, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %8 = "llvm.sub"(%6, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %9 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %10 = "llvm.sub"(%9, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %11 = "llvm.and"(%8, %10) : (i64, i64) -> i64
    %12 = "llvm.call"(%5, %11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %13 = "llvm.intr.coro.begin"(%3, %12) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %14 = "llvm.intr.coro.save"(%13) : (!llvm.ptr) -> !llvm.token
    %15 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%13, %15) <{callee = @mlirAsyncRuntimeExecute}> : (!llvm.ptr, !llvm.ptr) -> ()
    %16 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %17 = "llvm.intr.coro.suspend"(%14, %16) : (!llvm.token, i1) -> i8
    %18 = "llvm.sext"(%17) : (i8) -> i32
    "llvm.switch"(%18)[^bb7, ^bb1, ^bb6] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    %19 = "llvm.intr.coro.save"(%13) : (!llvm.ptr) -> !llvm.token
    %20 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%arg1, %13, %20) <{callee = @mlirAsyncRuntimeAwaitTokenAndExecute}> : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    %21 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %22 = "llvm.intr.coro.suspend"(%19, %21) : (!llvm.token, i1) -> i8
    %23 = "llvm.sext"(%22) : (i8) -> i32
    "llvm.switch"(%23)[^bb7, ^bb2, ^bb6] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb2:  // pred: ^bb1
    %24 = "func.call"(%arg1) <{callee = @mlirAsyncRuntimeIsTokenError}> : (!llvm.ptr) -> i1
    "cf.cond_br"(%24)[^bb4, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %25 = "arith.constant"() <{value = 0 : index}> : () -> index
    "memref.store"(%arg2, %arg3, %25) : (f32, memref<1xf32>, index) -> ()
    "func.call"(%0) <{callee = @mlirAsyncRuntimeEmplaceToken}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb5] : () -> ()
  ^bb4:  // pred: ^bb2
    "func.call"(%0) <{callee = @mlirAsyncRuntimeSetTokenError}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb5] : () -> ()
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %26 = "llvm.intr.coro.free"(%3, %13) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%26) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb7] : () -> ()
  ^bb6:  // 2 preds: ^bb0, ^bb1
    %27 = "llvm.intr.coro.free"(%3, %13) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%27) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb7] : () -> ()
  ^bb7:  // 4 preds: ^bb0, ^bb1, ^bb5, ^bb6
    %28 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %29 = "llvm.mlir.none"() : () -> !llvm.token
    %30 = "llvm.intr.coro.end"(%13, %28, %29) : (!llvm.ptr, i1, !llvm.token) -> i1
    "func.return"(%0) : (!llvm.ptr) -> ()
  }) {passthrough = ["presplitcoroutine"]} : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeAddRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeDropRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsGroupError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeGetValueStorage", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> i64, sym_name = "mlirAsyncRuntimeAddTokenToGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitTokenAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValueAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroupAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "mlirAsyncRuntimGetNumWorkerThreads", sym_visibility = "private"}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "__resume", sym_visibility = "private", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    "llvm.intr.coro.resume"(%arg0) : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, memref<1xf32>) -> (), sym_name = "async_group_await_all"}> ({
  ^bb0(%arg2: f32, %arg3: memref<1xf32>):
    %54 = "arith.constant"() <{value = 1 : index}> : () -> index
    %55 = "builtin.unrealized_conversion_cast"(%54) : (index) -> i64
    %56 = "func.call"(%55) <{callee = @mlirAsyncRuntimeCreateGroup}> : (i64) -> !llvm.ptr
    %57 = "func.call"() <{callee = @async_execute_fn}> : () -> !llvm.ptr
    %58 = "func.call"(%57, %56) <{callee = @mlirAsyncRuntimeAddTokenToGroup}> : (!llvm.ptr, !llvm.ptr) -> i64
    %59 = "func.call"(%56) <{callee = @async_execute_fn_0}> : (!llvm.ptr) -> !llvm.ptr
    "func.call"(%56) <{callee = @mlirAsyncRuntimeAwaitAllInGroup}> : (!llvm.ptr) -> ()
    %60 = "func.call"(%56) <{callee = @mlirAsyncRuntimeIsGroupError}> : (!llvm.ptr) -> i1
    %61 = "arith.constant"() <{value = true}> : () -> i1
    %62 = "arith.xori"(%60, %61) : (i1, i1) -> i1
    "cf.assert"(%62) <{msg = "Awaited async operand is in error state"}> : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> !llvm.ptr, sym_name = "async_execute_fn", sym_visibility = "private"}> ({
    %30 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    %31 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %32 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %33 = "llvm.intr.coro.id"(%31, %32, %32, %32) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %34 = "llvm.intr.coro.size"() : () -> i64
    %35 = "llvm.intr.coro.align"() : () -> i64
    %36 = "llvm.add"(%34, %35) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %37 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %38 = "llvm.sub"(%36, %37) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %39 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %40 = "llvm.sub"(%39, %35) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %41 = "llvm.and"(%38, %40) : (i64, i64) -> i64
    %42 = "llvm.call"(%35, %41) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %43 = "llvm.intr.coro.begin"(%33, %42) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %44 = "llvm.intr.coro.save"(%43) : (!llvm.ptr) -> !llvm.token
    %45 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%43, %45) <{callee = @mlirAsyncRuntimeExecute}> : (!llvm.ptr, !llvm.ptr) -> ()
    %46 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %47 = "llvm.intr.coro.suspend"(%44, %46) : (!llvm.token, i1) -> i8
    %48 = "llvm.sext"(%47) : (i8) -> i32
    "llvm.switch"(%48)[^bb4, ^bb1, ^bb3] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    "func.call"(%30) <{callee = @mlirAsyncRuntimeEmplaceToken}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    %49 = "llvm.intr.coro.free"(%33, %43) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%49) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb3:  // pred: ^bb0
    %50 = "llvm.intr.coro.free"(%33, %43) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%50) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    %51 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %52 = "llvm.mlir.none"() : () -> !llvm.token
    %53 = "llvm.intr.coro.end"(%43, %51, %52) : (!llvm.ptr, i1, !llvm.token) -> i1
    "func.return"(%30) : (!llvm.ptr) -> ()
  }) {passthrough = ["presplitcoroutine"]} : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> !llvm.ptr, sym_name = "async_execute_fn_0", sym_visibility = "private"}> ({
  ^bb0(%arg1: !llvm.ptr):
    %0 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.intr.coro.id"(%1, %2, %2, %2) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %4 = "llvm.intr.coro.size"() : () -> i64
    %5 = "llvm.intr.coro.align"() : () -> i64
    %6 = "llvm.add"(%4, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %8 = "llvm.sub"(%6, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %9 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %10 = "llvm.sub"(%9, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %11 = "llvm.and"(%8, %10) : (i64, i64) -> i64
    %12 = "llvm.call"(%5, %11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %13 = "llvm.intr.coro.begin"(%3, %12) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %14 = "llvm.intr.coro.save"(%13) : (!llvm.ptr) -> !llvm.token
    %15 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%13, %15) <{callee = @mlirAsyncRuntimeExecute}> : (!llvm.ptr, !llvm.ptr) -> ()
    %16 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %17 = "llvm.intr.coro.suspend"(%14, %16) : (!llvm.token, i1) -> i8
    %18 = "llvm.sext"(%17) : (i8) -> i32
    "llvm.switch"(%18)[^bb7, ^bb1, ^bb6] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    %19 = "llvm.intr.coro.save"(%13) : (!llvm.ptr) -> !llvm.token
    %20 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%arg1, %13, %20) <{callee = @mlirAsyncRuntimeAwaitAllInGroupAndExecute}> : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    %21 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %22 = "llvm.intr.coro.suspend"(%19, %21) : (!llvm.token, i1) -> i8
    %23 = "llvm.sext"(%22) : (i8) -> i32
    "llvm.switch"(%23)[^bb7, ^bb2, ^bb6] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb2:  // pred: ^bb1
    %24 = "func.call"(%arg1) <{callee = @mlirAsyncRuntimeIsGroupError}> : (!llvm.ptr) -> i1
    "cf.cond_br"(%24)[^bb4, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "func.call"(%0) <{callee = @mlirAsyncRuntimeEmplaceToken}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb5] : () -> ()
  ^bb4:  // pred: ^bb2
    "func.call"(%0) <{callee = @mlirAsyncRuntimeSetTokenError}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb5] : () -> ()
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %25 = "llvm.intr.coro.free"(%3, %13) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%25) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb7] : () -> ()
  ^bb6:  // 2 preds: ^bb0, ^bb1
    %26 = "llvm.intr.coro.free"(%3, %13) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%26) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb7] : () -> ()
  ^bb7:  // 4 preds: ^bb0, ^bb1, ^bb5, ^bb6
    %27 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %28 = "llvm.mlir.none"() : () -> !llvm.token
    %29 = "llvm.intr.coro.end"(%13, %27, %28) : (!llvm.ptr, i1, !llvm.token) -> i1
    "func.return"(%0) : (!llvm.ptr) -> ()
  }) {passthrough = ["presplitcoroutine"]} : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeAddRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeDropRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsGroupError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeGetValueStorage", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> i64, sym_name = "mlirAsyncRuntimeAddTokenToGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitTokenAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValueAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroupAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "mlirAsyncRuntimGetNumWorkerThreads", sym_visibility = "private"}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "__resume", sym_visibility = "private", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    "llvm.intr.coro.resume"(%arg0) : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "execute_and_return_f32"}> ({
    %30:2 = "func.call"() <{callee = @async_execute_fn}> : () -> (!llvm.ptr, !llvm.ptr)
    "func.call"(%30#1) <{callee = @mlirAsyncRuntimeAwaitValue}> : (!llvm.ptr) -> ()
    %31 = "func.call"(%30#1) <{callee = @mlirAsyncRuntimeIsValueError}> : (!llvm.ptr) -> i1
    %32 = "arith.constant"() <{value = true}> : () -> i1
    %33 = "arith.xori"(%31, %32) : (i1, i1) -> i1
    "cf.assert"(%33) <{msg = "Awaited async operand is in error state"}> : (i1) -> ()
    %34 = "func.call"(%30#1) <{callee = @mlirAsyncRuntimeGetValueStorage}> : (!llvm.ptr) -> !llvm.ptr
    %35 = "llvm.load"(%34) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "func.return"(%35) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (!llvm.ptr, !llvm.ptr), sym_name = "async_execute_fn", sym_visibility = "private"}> ({
    %0 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    %1 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %3 = "llvm.ptrtoint"(%2) : (!llvm.ptr) -> i64
    %4 = "func.call"(%3) <{callee = @mlirAsyncRuntimeCreateValue}> : (i64) -> !llvm.ptr
    %5 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %6 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %7 = "llvm.intr.coro.id"(%5, %6, %6, %6) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %8 = "llvm.intr.coro.size"() : () -> i64
    %9 = "llvm.intr.coro.align"() : () -> i64
    %10 = "llvm.add"(%8, %9) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %11 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %12 = "llvm.sub"(%10, %11) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %13 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %14 = "llvm.sub"(%13, %9) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %15 = "llvm.and"(%12, %14) : (i64, i64) -> i64
    %16 = "llvm.call"(%9, %15) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %17 = "llvm.intr.coro.begin"(%7, %16) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %18 = "llvm.intr.coro.save"(%17) : (!llvm.ptr) -> !llvm.token
    %19 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%17, %19) <{callee = @mlirAsyncRuntimeExecute}> : (!llvm.ptr, !llvm.ptr) -> ()
    %20 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %21 = "llvm.intr.coro.suspend"(%18, %20) : (!llvm.token, i1) -> i8
    %22 = "llvm.sext"(%21) : (i8) -> i32
    "llvm.switch"(%22)[^bb4, ^bb1, ^bb3] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    %23 = "arith.constant"() <{value = 1.230000e+02 : f32}> : () -> f32
    %24 = "func.call"(%4) <{callee = @mlirAsyncRuntimeGetValueStorage}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%23, %24) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "func.call"(%4) <{callee = @mlirAsyncRuntimeEmplaceValue}> : (!llvm.ptr) -> ()
    "func.call"(%0) <{callee = @mlirAsyncRuntimeEmplaceToken}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    %25 = "llvm.intr.coro.free"(%7, %17) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%25) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb3:  // pred: ^bb0
    %26 = "llvm.intr.coro.free"(%7, %17) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%26) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    %27 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %28 = "llvm.mlir.none"() : () -> !llvm.token
    %29 = "llvm.intr.coro.end"(%17, %27, %28) : (!llvm.ptr, i1, !llvm.token) -> i1
    "func.return"(%0, %4) : (!llvm.ptr, !llvm.ptr) -> ()
  }) {passthrough = ["presplitcoroutine"]} : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeAddRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeDropRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsGroupError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeGetValueStorage", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> i64, sym_name = "mlirAsyncRuntimeAddTokenToGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitTokenAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValueAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroupAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "mlirAsyncRuntimGetNumWorkerThreads", sym_visibility = "private"}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "__resume", sym_visibility = "private", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    "llvm.intr.coro.resume"(%arg0) : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "async_value_operands"}> ({
    %63:2 = "func.call"() <{callee = @async_execute_fn}> : () -> (!llvm.ptr, !llvm.ptr)
    %64 = "func.call"(%63#1) <{callee = @async_execute_fn_0}> : (!llvm.ptr) -> !llvm.ptr
    "func.call"(%64) <{callee = @mlirAsyncRuntimeAwaitToken}> : (!llvm.ptr) -> ()
    %65 = "func.call"(%64) <{callee = @mlirAsyncRuntimeIsTokenError}> : (!llvm.ptr) -> i1
    %66 = "arith.constant"() <{value = true}> : () -> i1
    %67 = "arith.xori"(%65, %66) : (i1, i1) -> i1
    "cf.assert"(%67) <{msg = "Awaited async operand is in error state"}> : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (!llvm.ptr, !llvm.ptr), sym_name = "async_execute_fn", sym_visibility = "private"}> ({
    %33 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    %34 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %35 = "llvm.getelementptr"(%34) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %36 = "llvm.ptrtoint"(%35) : (!llvm.ptr) -> i64
    %37 = "func.call"(%36) <{callee = @mlirAsyncRuntimeCreateValue}> : (i64) -> !llvm.ptr
    %38 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %39 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %40 = "llvm.intr.coro.id"(%38, %39, %39, %39) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %41 = "llvm.intr.coro.size"() : () -> i64
    %42 = "llvm.intr.coro.align"() : () -> i64
    %43 = "llvm.add"(%41, %42) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %44 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %45 = "llvm.sub"(%43, %44) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %46 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %47 = "llvm.sub"(%46, %42) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %48 = "llvm.and"(%45, %47) : (i64, i64) -> i64
    %49 = "llvm.call"(%42, %48) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %50 = "llvm.intr.coro.begin"(%40, %49) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %51 = "llvm.intr.coro.save"(%50) : (!llvm.ptr) -> !llvm.token
    %52 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%50, %52) <{callee = @mlirAsyncRuntimeExecute}> : (!llvm.ptr, !llvm.ptr) -> ()
    %53 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %54 = "llvm.intr.coro.suspend"(%51, %53) : (!llvm.token, i1) -> i8
    %55 = "llvm.sext"(%54) : (i8) -> i32
    "llvm.switch"(%55)[^bb4, ^bb1, ^bb3] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    %56 = "arith.constant"() <{value = 1.230000e+02 : f32}> : () -> f32
    %57 = "func.call"(%37) <{callee = @mlirAsyncRuntimeGetValueStorage}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%56, %57) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "func.call"(%37) <{callee = @mlirAsyncRuntimeEmplaceValue}> : (!llvm.ptr) -> ()
    "func.call"(%33) <{callee = @mlirAsyncRuntimeEmplaceToken}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    %58 = "llvm.intr.coro.free"(%40, %50) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%58) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb3:  // pred: ^bb0
    %59 = "llvm.intr.coro.free"(%40, %50) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%59) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    %60 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %61 = "llvm.mlir.none"() : () -> !llvm.token
    %62 = "llvm.intr.coro.end"(%50, %60, %61) : (!llvm.ptr, i1, !llvm.token) -> i1
    "func.return"(%33, %37) : (!llvm.ptr, !llvm.ptr) -> ()
  }) {passthrough = ["presplitcoroutine"]} : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> !llvm.ptr, sym_name = "async_execute_fn_0", sym_visibility = "private"}> ({
  ^bb0(%arg1: !llvm.ptr):
    %0 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    %1 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.intr.coro.id"(%1, %2, %2, %2) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %4 = "llvm.intr.coro.size"() : () -> i64
    %5 = "llvm.intr.coro.align"() : () -> i64
    %6 = "llvm.add"(%4, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %8 = "llvm.sub"(%6, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %9 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %10 = "llvm.sub"(%9, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %11 = "llvm.and"(%8, %10) : (i64, i64) -> i64
    %12 = "llvm.call"(%5, %11) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %13 = "llvm.intr.coro.begin"(%3, %12) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %14 = "llvm.intr.coro.save"(%13) : (!llvm.ptr) -> !llvm.token
    %15 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%13, %15) <{callee = @mlirAsyncRuntimeExecute}> : (!llvm.ptr, !llvm.ptr) -> ()
    %16 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %17 = "llvm.intr.coro.suspend"(%14, %16) : (!llvm.token, i1) -> i8
    %18 = "llvm.sext"(%17) : (i8) -> i32
    "llvm.switch"(%18)[^bb7, ^bb1, ^bb6] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    %19 = "llvm.intr.coro.save"(%13) : (!llvm.ptr) -> !llvm.token
    %20 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%arg1, %13, %20) <{callee = @mlirAsyncRuntimeAwaitValueAndExecute}> : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    %21 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %22 = "llvm.intr.coro.suspend"(%19, %21) : (!llvm.token, i1) -> i8
    %23 = "llvm.sext"(%22) : (i8) -> i32
    "llvm.switch"(%23)[^bb7, ^bb2, ^bb6] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb2:  // pred: ^bb1
    %24 = "func.call"(%arg1) <{callee = @mlirAsyncRuntimeIsValueError}> : (!llvm.ptr) -> i1
    "cf.cond_br"(%24)[^bb4, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %25 = "func.call"(%arg1) <{callee = @mlirAsyncRuntimeGetValueStorage}> : (!llvm.ptr) -> !llvm.ptr
    %26 = "llvm.load"(%25) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    %27 = "arith.addf"(%26, %26) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.call"(%0) <{callee = @mlirAsyncRuntimeEmplaceToken}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb5] : () -> ()
  ^bb4:  // pred: ^bb2
    "func.call"(%0) <{callee = @mlirAsyncRuntimeSetTokenError}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb5] : () -> ()
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %28 = "llvm.intr.coro.free"(%3, %13) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%28) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb7] : () -> ()
  ^bb6:  // 2 preds: ^bb0, ^bb1
    %29 = "llvm.intr.coro.free"(%3, %13) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%29) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "cf.br"()[^bb7] : () -> ()
  ^bb7:  // 4 preds: ^bb0, ^bb1, ^bb5, ^bb6
    %30 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %31 = "llvm.mlir.none"() : () -> !llvm.token
    %32 = "llvm.intr.coro.end"(%13, %30, %31) : (!llvm.ptr, i1, !llvm.token) -> i1
    "func.return"(%0) : (!llvm.ptr) -> ()
  }) {passthrough = ["presplitcoroutine"]} : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeAddRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, i64) -> (), sym_name = "mlirAsyncRuntimeDropRef", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeCreateGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeEmplaceValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeSetValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsTokenError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsValueError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> i1, sym_name = "mlirAsyncRuntimeIsGroupError", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitToken", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValue", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr) -> !llvm.ptr, sym_name = "mlirAsyncRuntimeGetValueStorage", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr) -> i64, sym_name = "mlirAsyncRuntimeAddTokenToGroup", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitTokenAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitValueAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> (), sym_name = "mlirAsyncRuntimeAwaitAllInGroupAndExecute", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "mlirAsyncRuntimGetNumWorkerThreads", sym_visibility = "private"}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "__resume", sym_visibility = "private", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    "llvm.intr.coro.resume"(%arg0) : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

