"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "coro_id"}> ({
    %74 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %75 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %76 = "llvm.intr.coro.id"(%74, %75, %75, %75) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "coro_begin"}> ({
    %61 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %62 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %63 = "llvm.intr.coro.id"(%61, %62, %62, %62) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %64 = "llvm.intr.coro.size"() : () -> i64
    %65 = "llvm.intr.coro.align"() : () -> i64
    %66 = "llvm.add"(%64, %65) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %67 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %68 = "llvm.sub"(%66, %67) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %69 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %70 = "llvm.sub"(%69, %65) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %71 = "llvm.and"(%68, %70) : (i64, i64) -> i64
    %72 = "llvm.call"(%65, %71) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %73 = "llvm.intr.coro.begin"(%63, %72) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "coro_free"}> ({
    %47 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %48 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %49 = "llvm.intr.coro.id"(%47, %48, %48, %48) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %50 = "llvm.intr.coro.size"() : () -> i64
    %51 = "llvm.intr.coro.align"() : () -> i64
    %52 = "llvm.add"(%50, %51) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %53 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %54 = "llvm.sub"(%52, %53) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %55 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %56 = "llvm.sub"(%55, %51) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %57 = "llvm.and"(%54, %56) : (i64, i64) -> i64
    %58 = "llvm.call"(%51, %57) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %59 = "llvm.intr.coro.begin"(%49, %58) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %60 = "llvm.intr.coro.free"(%49, %59) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    "llvm.call"(%60) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "coro_end"}> ({
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
    %44 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %45 = "llvm.mlir.none"() : () -> !llvm.token
    %46 = "llvm.intr.coro.end"(%43, %44, %45) : (!llvm.ptr, i1, !llvm.token) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "coro_save"}> ({
    %17 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %18 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %19 = "llvm.intr.coro.id"(%17, %18, %18, %18) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %20 = "llvm.intr.coro.size"() : () -> i64
    %21 = "llvm.intr.coro.align"() : () -> i64
    %22 = "llvm.add"(%20, %21) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %23 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %24 = "llvm.sub"(%22, %23) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %25 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %26 = "llvm.sub"(%25, %21) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %27 = "llvm.and"(%24, %26) : (i64, i64) -> i64
    %28 = "llvm.call"(%21, %27) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %29 = "llvm.intr.coro.begin"(%19, %28) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %30 = "llvm.intr.coro.save"(%29) : (!llvm.ptr) -> !llvm.token
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "coro_suspend"}> ({
    %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %2 = "llvm.intr.coro.id"(%0, %1, %1, %1) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %3 = "llvm.intr.coro.size"() : () -> i64
    %4 = "llvm.intr.coro.align"() : () -> i64
    %5 = "llvm.add"(%3, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %7 = "llvm.sub"(%5, %6) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %8 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %9 = "llvm.sub"(%8, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %10 = "llvm.and"(%7, %9) : (i64, i64) -> i64
    %11 = "llvm.call"(%4, %10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %12 = "llvm.intr.coro.begin"(%2, %11) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %13 = "llvm.intr.coro.save"(%12) : (!llvm.ptr) -> !llvm.token
    %14 = "llvm.mlir.constant"() <{value = false}> : () -> i1
    %15 = "llvm.intr.coro.suspend"(%13, %14) : (!llvm.token, i1) -> i8
    %16 = "llvm.sext"(%15) : (i8) -> i32
    "llvm.switch"(%16)[^bb3, ^bb1, ^bb2] <{case_operand_segments = array<i32: 0, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() {coro.resume} : () -> ()
  ^bb2:  // pred: ^bb0
    "func.return"() {coro.cleanup} : () -> ()
  ^bb3:  // pred: ^bb0
    "func.return"() {coro.suspend} : () -> ()
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

