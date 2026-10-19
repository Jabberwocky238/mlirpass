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
    %2 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<10xf32, 1>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (memref<10xf32, 1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %4 = "llvm.extractvalue"(%3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr<1>
    "gpu.launch_func"(%0, %0, %0, %0, %0, %0, %1, %4) <{kernel = @kernels::@kernel_1, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (i64, i64, i64, i64, i64, i64, f32, !llvm.ptr<1>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

