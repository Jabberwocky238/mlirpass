"builtin.module"() ({
  "builtin.module"() ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, ptr<1>, i64, i64, i64, ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "foo", visibility_ = 0 : i64}> ({
    ^bb0(%arg14: !llvm.ptr<1>, %arg15: !llvm.ptr<1>, %arg16: i64, %arg17: i64, %arg18: i64, %arg19: !llvm.ptr, %arg20: !llvm.ptr, %arg21: i64, %arg22: i64, %arg23: i64):
      %26 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %27 = "llvm.insertvalue"(%26, %arg19) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %28 = "llvm.insertvalue"(%27, %arg20) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %29 = "llvm.insertvalue"(%28, %arg21) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %30 = "llvm.insertvalue"(%29, %arg22) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %31 = "llvm.insertvalue"(%30, %arg23) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
      %32 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %33 = "llvm.insertvalue"(%32, %arg14) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %34 = "llvm.insertvalue"(%33, %arg15) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %35 = "llvm.insertvalue"(%34, %arg16) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %36 = "llvm.insertvalue"(%35, %arg17) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %37 = "llvm.insertvalue"(%36, %arg18) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
      %38 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamCreate, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.ptr
      %39 = "llvm.mlir.constant"() <{value = 7 : index}> : () -> i64
      %40 = "llvm.mlir.zero"() : () -> !llvm.ptr
      %41 = "llvm.getelementptr"(%40, %39) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      %42 = "llvm.ptrtoint"(%41) : (!llvm.ptr) -> i64
      %43 = "llvm.extractvalue"(%31) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
      %44 = "llvm.extractvalue"(%37) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
      %45 = "llvm.addrspacecast"(%44) : (!llvm.ptr<1>) -> !llvm.ptr
      "llvm.call"(%45, %43, %42, %38) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemcpy, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (!llvm.ptr, !llvm.ptr, i64, !llvm.ptr) -> ()
      "llvm.call"(%38) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamSynchronize, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
      "llvm.call"(%38) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamDestroy, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr ()>, linkage = #llvm.linkage<external>, sym_name = "mgpuStreamCreate", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuMemcpy", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuStreamSynchronize", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuStreamDestroy", visibility_ = 0 : i64}> ({
    }) : () -> ()
  }) {gpu.container_module} : () -> ()
  "builtin.module"() ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr<1>, ptr<1>, i64, i64, i64, i64, i64, ptr, ptr, i64, i64, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "dynamic", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr<1>, %arg1: !llvm.ptr<1>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: !llvm.ptr, %arg8: !llvm.ptr, %arg9: i64, %arg10: i64, %arg11: i64, %arg12: i64, %arg13: i64):
      %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %1 = "llvm.insertvalue"(%0, %arg7) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %2 = "llvm.insertvalue"(%1, %arg8) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %3 = "llvm.insertvalue"(%2, %arg9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %4 = "llvm.insertvalue"(%3, %arg10) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %5 = "llvm.insertvalue"(%4, %arg12) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %6 = "llvm.insertvalue"(%5, %arg11) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %7 = "llvm.insertvalue"(%6, %arg13) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
      %8 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
      %9 = "llvm.insertvalue"(%8, %arg0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
      %10 = "llvm.insertvalue"(%9, %arg1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
      %11 = "llvm.insertvalue"(%10, %arg2) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
      %12 = "llvm.insertvalue"(%11, %arg3) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
      %13 = "llvm.insertvalue"(%12, %arg5) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
      %14 = "llvm.insertvalue"(%13, %arg4) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
      %15 = "llvm.insertvalue"(%14, %arg6) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
      %16 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamCreate, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.ptr
      %17 = "llvm.extractvalue"(%7) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
      %18 = "llvm.extractvalue"(%7) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
      %19 = "llvm.mul"(%17, %18) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
      %20 = "llvm.mlir.zero"() : () -> !llvm.ptr
      %21 = "llvm.getelementptr"(%20, %19) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
      %22 = "llvm.ptrtoint"(%21) : (!llvm.ptr) -> i64
      %23 = "llvm.extractvalue"(%7) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
      %24 = "llvm.extractvalue"(%15) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<1>
      %25 = "llvm.addrspacecast"(%24) : (!llvm.ptr<1>) -> !llvm.ptr
      "llvm.call"(%25, %23, %22, %16) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemcpy, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 4, 0>}> : (!llvm.ptr, !llvm.ptr, i64, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr ()>, linkage = #llvm.linkage<external>, sym_name = "mgpuStreamCreate", visibility_ = 0 : i64}> ({
    }) : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuMemcpy", visibility_ = 0 : i64}> ({
    }) : () -> ()
  }) {gpu.container_module} : () -> ()
}) : () -> ()

