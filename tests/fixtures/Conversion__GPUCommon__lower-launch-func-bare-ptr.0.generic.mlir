"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels", targets = [#nvvm.target]}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f32, ptr<1>)>, linkage = #llvm.linkage<external>, sym_name = "kernel_1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg0: f32, %arg1: !llvm.ptr<1>):
      "llvm.return"() : () -> ()
    }) {gpu.kernel, nvvm.kernel} : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "foo", visibility_ = 0 : i64}> ({
    %0 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "llvm.mlir.constant"() <{value = 10 : index}> : () -> i64
    %3 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %4 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %2) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %6 = "llvm.ptrtoint"(%5) : (!llvm.ptr) -> i64
    %7 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %8 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %9 = "llvm.call"(%6, %7, %8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemAlloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %10 = "llvm.addrspacecast"(%9) : (!llvm.ptr) -> !llvm.ptr<1>
    %11 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.insertvalue"(%11, %10) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %13 = "llvm.insertvalue"(%12, %10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %14 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %15 = "llvm.insertvalue"(%13, %14) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %16 = "llvm.insertvalue"(%15, %2) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %17 = "llvm.insertvalue"(%16, %3) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %18 = "llvm.extractvalue"(%17) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    "gpu.launch_func"(%0, %0, %0, %0, %0, %0, %1, %18) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (i64, i64, i64, i64, i64, i64, f32, !llvm.ptr<1>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, ptr, i8)>, linkage = #llvm.linkage<external>, sym_name = "mgpuMemAlloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
}) {gpu.container_module} : () -> ()

