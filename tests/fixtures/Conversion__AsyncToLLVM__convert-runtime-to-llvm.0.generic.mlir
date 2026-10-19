"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "create_token"}> ({
    %108 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "create_value"}> ({
    %104 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %105 = "llvm.getelementptr"(%104) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %106 = "llvm.ptrtoint"(%105) : (!llvm.ptr) -> i64
    %107 = "func.call"(%106) <{callee = @mlirAsyncRuntimeCreateValue}> : (i64) -> !llvm.ptr
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "create_group"}> ({
    %101 = "arith.constant"() <{value = 1 : index}> : () -> index
    %102 = "builtin.unrealized_conversion_cast"(%101) : (index) -> i64
    %103 = "func.call"(%102) <{callee = @mlirAsyncRuntimeCreateGroup}> : (i64) -> !llvm.ptr
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "set_token_available"}> ({
    %100 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    "func.call"(%100) <{callee = @mlirAsyncRuntimeEmplaceToken}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "set_value_available"}> ({
    %96 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %97 = "llvm.getelementptr"(%96) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %98 = "llvm.ptrtoint"(%97) : (!llvm.ptr) -> i64
    %99 = "func.call"(%98) <{callee = @mlirAsyncRuntimeCreateValue}> : (i64) -> !llvm.ptr
    "func.call"(%99) <{callee = @mlirAsyncRuntimeEmplaceValue}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "is_token_error"}> ({
    %94 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    %95 = "func.call"(%94) <{callee = @mlirAsyncRuntimeIsTokenError}> : (!llvm.ptr) -> i1
    "func.return"(%95) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "is_value_error"}> ({
    %89 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %90 = "llvm.getelementptr"(%89) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %91 = "llvm.ptrtoint"(%90) : (!llvm.ptr) -> i64
    %92 = "func.call"(%91) <{callee = @mlirAsyncRuntimeCreateValue}> : (i64) -> !llvm.ptr
    %93 = "func.call"(%92) <{callee = @mlirAsyncRuntimeIsValueError}> : (!llvm.ptr) -> i1
    "func.return"(%93) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "await_token"}> ({
    %88 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    "func.call"(%88) <{callee = @mlirAsyncRuntimeAwaitToken}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "await_value"}> ({
    %84 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %85 = "llvm.getelementptr"(%84) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %86 = "llvm.ptrtoint"(%85) : (!llvm.ptr) -> i64
    %87 = "func.call"(%86) <{callee = @mlirAsyncRuntimeCreateValue}> : (i64) -> !llvm.ptr
    "func.call"(%87) <{callee = @mlirAsyncRuntimeAwaitValue}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "await_group"}> ({
    %81 = "arith.constant"() <{value = 1 : index}> : () -> index
    %82 = "builtin.unrealized_conversion_cast"(%81) : (index) -> i64
    %83 = "func.call"(%82) <{callee = @mlirAsyncRuntimeCreateGroup}> : (i64) -> !llvm.ptr
    "func.call"(%83) <{callee = @mlirAsyncRuntimeAwaitAllInGroup}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "await_and_resume_token"}> ({
    %66 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %67 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %68 = "llvm.intr.coro.id"(%66, %67, %67, %67) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %69 = "llvm.intr.coro.size"() : () -> i64
    %70 = "llvm.intr.coro.align"() : () -> i64
    %71 = "llvm.add"(%69, %70) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %72 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %73 = "llvm.sub"(%71, %72) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %74 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %75 = "llvm.sub"(%74, %70) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %76 = "llvm.and"(%73, %75) : (i64, i64) -> i64
    %77 = "llvm.call"(%70, %76) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %78 = "llvm.intr.coro.begin"(%68, %77) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %79 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    %80 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%79, %78, %80) <{callee = @mlirAsyncRuntimeAwaitTokenAndExecute}> : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "await_and_resume_value"}> ({
    %48 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %49 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %50 = "llvm.intr.coro.id"(%48, %49, %49, %49) : (i32, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.token
    %51 = "llvm.intr.coro.size"() : () -> i64
    %52 = "llvm.intr.coro.align"() : () -> i64
    %53 = "llvm.add"(%51, %52) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %54 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %55 = "llvm.sub"(%53, %54) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %56 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %57 = "llvm.sub"(%56, %52) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %58 = "llvm.and"(%55, %57) : (i64, i64) -> i64
    %59 = "llvm.call"(%52, %58) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %60 = "llvm.intr.coro.begin"(%50, %59) : (!llvm.token, !llvm.ptr) -> !llvm.ptr
    %61 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %62 = "llvm.getelementptr"(%61) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %63 = "llvm.ptrtoint"(%62) : (!llvm.ptr) -> i64
    %64 = "func.call"(%63) <{callee = @mlirAsyncRuntimeCreateValue}> : (i64) -> !llvm.ptr
    %65 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%64, %60, %65) <{callee = @mlirAsyncRuntimeAwaitValueAndExecute}> : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "await_and_resume_group"}> ({
    %31 = "arith.constant"() <{value = 1 : index}> : () -> index
    %32 = "builtin.unrealized_conversion_cast"(%31) : (index) -> i64
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
    %46 = "func.call"(%32) <{callee = @mlirAsyncRuntimeCreateGroup}> : (i64) -> !llvm.ptr
    %47 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%46, %45, %47) <{callee = @mlirAsyncRuntimeAwaitAllInGroupAndExecute}> : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "resume"}> ({
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
    %30 = "llvm.mlir.addressof"() <{global_name = @__resume}> : () -> !llvm.ptr
    "func.call"(%29, %30) <{callee = @mlirAsyncRuntimeExecute}> : (!llvm.ptr, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "store"}> ({
    %11 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %12 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %13 = "llvm.getelementptr"(%12) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %14 = "llvm.ptrtoint"(%13) : (!llvm.ptr) -> i64
    %15 = "func.call"(%14) <{callee = @mlirAsyncRuntimeCreateValue}> : (i64) -> !llvm.ptr
    %16 = "func.call"(%15) <{callee = @mlirAsyncRuntimeGetValueStorage}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%11, %16) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "load"}> ({
    %5 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %6 = "llvm.getelementptr"(%5) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %7 = "llvm.ptrtoint"(%6) : (!llvm.ptr) -> i64
    %8 = "func.call"(%7) <{callee = @mlirAsyncRuntimeCreateValue}> : (i64) -> !llvm.ptr
    %9 = "func.call"(%8) <{callee = @mlirAsyncRuntimeGetValueStorage}> : (!llvm.ptr) -> !llvm.ptr
    %10 = "llvm.load"(%9) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "func.return"(%10) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "add_token_to_group"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "builtin.unrealized_conversion_cast"(%0) : (index) -> i64
    %2 = "func.call"() <{callee = @mlirAsyncRuntimeCreateToken}> : () -> !llvm.ptr
    %3 = "func.call"(%1) <{callee = @mlirAsyncRuntimeCreateGroup}> : (i64) -> !llvm.ptr
    %4 = "func.call"(%2, %3) <{callee = @mlirAsyncRuntimeAddTokenToGroup}> : (!llvm.ptr, !llvm.ptr) -> i64
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
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "__resume", sym_visibility = "private", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: !llvm.ptr):
    "llvm.intr.coro.resume"(%arg0) : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

