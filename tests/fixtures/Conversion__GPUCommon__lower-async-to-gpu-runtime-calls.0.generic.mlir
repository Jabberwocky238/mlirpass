"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "yield_launch_token", visibility_ = 0 : i64}> ({
  ^bb0(%arg5: !llvm.ptr, %arg6: !llvm.ptr, %arg7: i64, %arg8: i64, %arg9: i64):
    %0 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "llvm.insertvalue"(%0, %arg5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = "llvm.insertvalue"(%1, %arg6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %3 = "llvm.insertvalue"(%2, %arg7) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %4 = "llvm.insertvalue"(%3, %arg8) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %5 = "llvm.insertvalue"(%4, %arg9) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %6 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %7:2 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %8 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamCreate, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.ptr
      %9 = "llvm.extractvalue"(%5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
      %10 = "llvm.extractvalue"(%5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
      %11 = "llvm.extractvalue"(%5) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
      %12 = "llvm.extractvalue"(%5) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
      %13 = "llvm.extractvalue"(%5) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
      "gpu.launch_func"(%6, %6, %6, %6, %6, %6, %9, %10, %11, %12, %13, %8) <{kernel = @kmod::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 5, 1>}> : (i64, i64, i64, i64, i64, i64, !llvm.ptr, !llvm.ptr, i64, i64, i64, !llvm.ptr) -> ()
      %14 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuEventCreate, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.ptr
      "llvm.call"(%14, %8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuEventRecord, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
      "llvm.call"(%8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamDestroy, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
      "async.yield"(%14) : (!llvm.ptr) -> ()
    }) : () -> (!async.token, !async.value<!llvm.ptr>)
    "llvm.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kmod", targets = [#nvvm.target]}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "kernel", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64):
      "llvm.return"() : () -> ()
    }) {gpu.kernel, nvvm.kernel} : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr ()>, linkage = #llvm.linkage<external>, sym_name = "mgpuStreamCreate", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr ()>, linkage = #llvm.linkage<external>, sym_name = "mgpuEventCreate", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuEventRecord", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuStreamDestroy", visibility_ = 0 : i64}> ({
  }) : () -> ()
}) {gpu.container_module} : () -> ()

