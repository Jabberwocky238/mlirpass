"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_wmma_load_op", visibility_ = 0 : i64}> ({
      %1 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i32
      %2 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %3 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %4 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %5 = "llvm.mlir.constant"() <{value = 1024 : index}> : () -> i32
      %6 = "llvm.alloca"(%5) <{alignment = 32 : i64, elem_type = f16}> : (i32) -> !llvm.ptr<3>
      %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %8 = "llvm.insertvalue"(%7, %6) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %9 = "llvm.insertvalue"(%8, %6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %10 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %12 = "llvm.insertvalue"(%11, %2) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %13 = "llvm.insertvalue"(%12, %3) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %14 = "llvm.insertvalue"(%13, %3) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %15 = "llvm.insertvalue"(%14, %4) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %16 = "llvm.extractvalue"(%15) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr<3>
      %17 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %18 = "llvm.mul"(%1, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %19 = "llvm.add"(%18, %1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %20 = "llvm.getelementptr"(%16, %19) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      %21 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %22 = "nvvm.wmma.load"(%20, %21) <{eltype = #nvvm.mma_type<f16>, frag = #nvvm.mma_frag<a>, k = 16 : i32, layout = #nvvm.mma_layout<col>, m = 16 : i32, n = 16 : i32}> : (!llvm.ptr<3>, i32) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      "llvm.return"(%22) : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_wmma_load_op", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr):
      %0 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_wmma_load_op, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i32, i32)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_wmma_int8_load_op", visibility_ = 0 : i64}> ({
      %1 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i32
      %2 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %3 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %4 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %5 = "llvm.mlir.constant"() <{value = 1024 : index}> : () -> i32
      %6 = "llvm.alloca"(%5) <{alignment = 32 : i64, elem_type = i8}> : (i32) -> !llvm.ptr<3>
      %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %8 = "llvm.insertvalue"(%7, %6) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %9 = "llvm.insertvalue"(%8, %6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %10 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %12 = "llvm.insertvalue"(%11, %2) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %13 = "llvm.insertvalue"(%12, %3) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %14 = "llvm.insertvalue"(%13, %3) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %15 = "llvm.insertvalue"(%14, %4) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %16 = "llvm.extractvalue"(%15) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr<3>
      %17 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %18 = "llvm.mul"(%1, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %19 = "llvm.add"(%18, %1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %20 = "llvm.getelementptr"(%16, %19) <{elem_type = i8, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      %21 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %22 = "nvvm.wmma.load"(%20, %21) <{eltype = #nvvm.mma_type<s8>, frag = #nvvm.mma_frag<a>, k = 16 : i32, layout = #nvvm.mma_layout<col>, m = 16 : i32, n = 16 : i32}> : (!llvm.ptr<3>, i32) -> !llvm.struct<(i32, i32)>
      "llvm.return"(%22) : (!llvm.struct<(i32, i32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_wmma_int8_load_op", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr):
      %0 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_wmma_int8_load_op, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(i32, i32)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(i32, i32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_wmma_f64_load_op", visibility_ = 0 : i64}> ({
      %1 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i32
      %2 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %3 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %4 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %5 = "llvm.mlir.constant"() <{value = 1024 : index}> : () -> i32
      %6 = "llvm.alloca"(%5) <{alignment = 32 : i64, elem_type = f64}> : (i32) -> !llvm.ptr<3>
      %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %8 = "llvm.insertvalue"(%7, %6) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %9 = "llvm.insertvalue"(%8, %6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %10 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %12 = "llvm.insertvalue"(%11, %2) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %13 = "llvm.insertvalue"(%12, %3) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %14 = "llvm.insertvalue"(%13, %3) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %15 = "llvm.insertvalue"(%14, %4) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %16 = "llvm.extractvalue"(%15) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr<3>
      %17 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %18 = "llvm.mul"(%1, %17) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %19 = "llvm.add"(%18, %1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %20 = "llvm.getelementptr"(%16, %19) <{elem_type = f64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      %21 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %22 = "nvvm.wmma.load"(%20, %21) <{eltype = #nvvm.mma_type<f64>, frag = #nvvm.mma_frag<a>, k = 4 : i32, layout = #nvvm.mma_layout<row>, m = 8 : i32, n = 8 : i32}> : (!llvm.ptr<3>, i32) -> f64
      "llvm.return"(%22) : (f64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<f64 ()>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_wmma_f64_load_op", visibility_ = 0 : i64}> ({
      %0 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_wmma_f64_load_op, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> f64
      "llvm.return"(%0) : (f64) -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>)>, linkage = #llvm.linkage<external>, sym_name = "gpu_wmma_store_op", visibility_ = 0 : i64}> ({
    ^bb0(%arg1: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>):
      %0 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i32
      %1 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %2 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %3 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
      %4 = "llvm.mlir.constant"() <{value = 1024 : index}> : () -> i32
      %5 = "llvm.alloca"(%4) <{alignment = 32 : i64, elem_type = f16}> : (i32) -> !llvm.ptr<3>
      %6 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %7 = "llvm.insertvalue"(%6, %5) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %10 = "llvm.insertvalue"(%8, %9) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %11 = "llvm.insertvalue"(%10, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %12 = "llvm.insertvalue"(%11, %2) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %13 = "llvm.insertvalue"(%12, %2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %14 = "llvm.insertvalue"(%13, %3) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
      %15 = "llvm.extractvalue"(%arg1) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %16 = "llvm.extractvalue"(%arg1) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %17 = "llvm.extractvalue"(%arg1) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %18 = "llvm.extractvalue"(%arg1) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %19 = "llvm.extractvalue"(%14) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr<3>
      %20 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %21 = "llvm.mul"(%0, %20) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %22 = "llvm.add"(%21, %0) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %23 = "llvm.getelementptr"(%19, %22) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>
      %24 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      "nvvm.wmma.store"(%23, %15, %16, %17, %18, %24) <{eltype = #nvvm.mma_type<f16>, k = 16 : i32, layout = #nvvm.mma_layout<col>, m = 16 : i32, n = 16 : i32}> : (!llvm.ptr<3>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, i32) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_wmma_store_op", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>):
      "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_wmma_store_op, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> (struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>)>, linkage = #llvm.linkage<external>, sym_name = "gpu_wmma_mma_op", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, %arg5: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, %arg6: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>):
      %1 = "llvm.extractvalue"(%arg4) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %2 = "llvm.extractvalue"(%arg4) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %3 = "llvm.extractvalue"(%arg4) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %4 = "llvm.extractvalue"(%arg4) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %5 = "llvm.extractvalue"(%arg4) <{position = array<i64: 4>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %6 = "llvm.extractvalue"(%arg4) <{position = array<i64: 5>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %7 = "llvm.extractvalue"(%arg4) <{position = array<i64: 6>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %8 = "llvm.extractvalue"(%arg4) <{position = array<i64: 7>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %9 = "llvm.extractvalue"(%arg5) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %10 = "llvm.extractvalue"(%arg5) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %11 = "llvm.extractvalue"(%arg5) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %12 = "llvm.extractvalue"(%arg5) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %13 = "llvm.extractvalue"(%arg5) <{position = array<i64: 4>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %14 = "llvm.extractvalue"(%arg5) <{position = array<i64: 5>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %15 = "llvm.extractvalue"(%arg5) <{position = array<i64: 6>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %16 = "llvm.extractvalue"(%arg5) <{position = array<i64: 7>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %17 = "llvm.extractvalue"(%arg6) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %18 = "llvm.extractvalue"(%arg6) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %19 = "llvm.extractvalue"(%arg6) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %20 = "llvm.extractvalue"(%arg6) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %21 = "nvvm.wmma.mma"(%1, %2, %3, %4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19, %20) <{eltypeA = #nvvm.mma_type<f16>, eltypeB = #nvvm.mma_type<f16>, k = 16 : i32, layoutA = #nvvm.mma_layout<col>, layoutB = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32}> : (vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      "llvm.return"(%21) : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_wmma_mma_op", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, %arg2: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, %arg3: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_wmma_mma_op, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(i32, i32, i32, i32, i32, i32, i32, i32)> (struct<(i32, i32, i32, i32)>, struct<(i32)>, struct<(i32, i32, i32, i32, i32, i32, i32, i32)>)>, linkage = #llvm.linkage<external>, sym_name = "gpu_wmma_mma_int8_op", visibility_ = 0 : i64}> ({
    ^bb0(%arg4: !llvm.struct<(i32, i32, i32, i32)>, %arg5: !llvm.struct<(i32)>, %arg6: !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>):
      %1 = "llvm.extractvalue"(%arg4) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
      %2 = "llvm.extractvalue"(%arg4) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
      %3 = "llvm.extractvalue"(%arg4) <{position = array<i64: 2>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
      %4 = "llvm.extractvalue"(%arg4) <{position = array<i64: 3>}> : (!llvm.struct<(i32, i32, i32, i32)>) -> i32
      %5 = "llvm.extractvalue"(%arg5) <{position = array<i64: 0>}> : (!llvm.struct<(i32)>) -> i32
      %6 = "llvm.extractvalue"(%arg6) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>) -> i32
      %7 = "llvm.extractvalue"(%arg6) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>) -> i32
      %8 = "llvm.extractvalue"(%arg6) <{position = array<i64: 2>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>) -> i32
      %9 = "llvm.extractvalue"(%arg6) <{position = array<i64: 3>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>) -> i32
      %10 = "llvm.extractvalue"(%arg6) <{position = array<i64: 4>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>) -> i32
      %11 = "llvm.extractvalue"(%arg6) <{position = array<i64: 5>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>) -> i32
      %12 = "llvm.extractvalue"(%arg6) <{position = array<i64: 6>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>) -> i32
      %13 = "llvm.extractvalue"(%arg6) <{position = array<i64: 7>}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>) -> i32
      %14 = "nvvm.wmma.mma"(%1, %2, %3, %4, %5, %6, %7, %8, %9, %10, %11, %12, %13) <{eltypeA = #nvvm.mma_type<s8>, eltypeB = #nvvm.mma_type<s32>, k = 16 : i32, layoutA = #nvvm.mma_layout<col>, layoutB = #nvvm.mma_layout<row>, m = 32 : i32, n = 8 : i32}> : (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>
      "llvm.return"(%14) : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, struct<(i32, i32, i32, i32)>, struct<(i32)>, struct<(i32, i32, i32, i32, i32, i32, i32, i32)>)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_wmma_mma_int8_op", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.struct<(i32, i32, i32, i32)>, %arg2: !llvm.struct<(i32)>, %arg3: !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>):
      %0 = "llvm.call"(%arg1, %arg2, %arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_wmma_mma_int8_op, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (!llvm.struct<(i32, i32, i32, i32)>, !llvm.struct<(i32)>, !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>) -> !llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(i32, i32, i32, i32, i32, i32, i32, i32)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i32, i32, i32, i32, i32, ptr, ptr, i32, i32, i32, i32, i32, ptr, ptr, i32, i32, i32, i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "gpu_wmma_mma_loop_op", visibility_ = 0 : i64}> ({
    ^bb0(%arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: !llvm.ptr, %arg11: !llvm.ptr, %arg12: i32, %arg13: i32, %arg14: i32, %arg15: i32, %arg16: i32, %arg17: !llvm.ptr, %arg18: !llvm.ptr, %arg19: i32, %arg20: i32, %arg21: i32, %arg22: i32, %arg23: i32):
      %24 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %25 = "llvm.insertvalue"(%24, %arg10) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %26 = "llvm.insertvalue"(%25, %arg11) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %27 = "llvm.insertvalue"(%26, %arg12) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %28 = "llvm.insertvalue"(%27, %arg13) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %29 = "llvm.insertvalue"(%28, %arg15) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %30 = "llvm.insertvalue"(%29, %arg14) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %31 = "llvm.insertvalue"(%30, %arg16) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %32 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %33 = "llvm.insertvalue"(%32, %arg3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %34 = "llvm.insertvalue"(%33, %arg4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %35 = "llvm.insertvalue"(%34, %arg5) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %36 = "llvm.insertvalue"(%35, %arg6) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %37 = "llvm.insertvalue"(%36, %arg8) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %38 = "llvm.insertvalue"(%37, %arg7) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %39 = "llvm.insertvalue"(%38, %arg9) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %40 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %41 = "llvm.insertvalue"(%40, %arg17) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %42 = "llvm.insertvalue"(%41, %arg18) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %43 = "llvm.insertvalue"(%42, %arg19) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %44 = "llvm.insertvalue"(%43, %arg20) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %45 = "llvm.insertvalue"(%44, %arg22) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %46 = "llvm.insertvalue"(%45, %arg21) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %47 = "llvm.insertvalue"(%46, %arg23) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %48 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
      %49 = "llvm.mlir.constant"() <{value = 128 : index}> : () -> i32
      %50 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
      %51 = "llvm.extractvalue"(%47) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr
      %52 = "llvm.mlir.constant"() <{value = 128 : index}> : () -> i32
      %53 = "llvm.mul"(%48, %52) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %54 = "llvm.add"(%53, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %55 = "llvm.getelementptr"(%51, %54) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i32) -> !llvm.ptr
      %56 = "llvm.mlir.constant"() <{value = 128 : index}> : () -> i32
      %57 = "nvvm.wmma.load"(%55, %56) <{eltype = #nvvm.mma_type<f16>, frag = #nvvm.mma_frag<c>, k = 16 : i32, layout = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32}> : (!llvm.ptr, i32) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      "llvm.br"(%48, %57)[^bb1] : (i32, !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> ()
    ^bb1(%58: i32, %59: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>):  // 2 preds: ^bb0, ^bb2
      %60 = "llvm.icmp"(%58, %49) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "llvm.cond_br"(%60)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb2:  // pred: ^bb1
      %61 = "llvm.extractvalue"(%39) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr
      %62 = "llvm.mlir.constant"() <{value = 128 : index}> : () -> i32
      %63 = "llvm.mul"(%48, %62) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %64 = "llvm.add"(%63, %58) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %65 = "llvm.getelementptr"(%61, %64) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i32) -> !llvm.ptr
      %66 = "llvm.mlir.constant"() <{value = 128 : index}> : () -> i32
      %67 = "nvvm.wmma.load"(%65, %66) <{eltype = #nvvm.mma_type<f16>, frag = #nvvm.mma_frag<a>, k = 16 : i32, layout = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32}> : (!llvm.ptr, i32) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %68 = "llvm.extractvalue"(%31) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr
      %69 = "llvm.mlir.constant"() <{value = 128 : index}> : () -> i32
      %70 = "llvm.mul"(%58, %69) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %71 = "llvm.add"(%70, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %72 = "llvm.getelementptr"(%68, %71) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i32) -> !llvm.ptr
      %73 = "llvm.mlir.constant"() <{value = 128 : index}> : () -> i32
      %74 = "nvvm.wmma.load"(%72, %73) <{eltype = #nvvm.mma_type<f16>, frag = #nvvm.mma_frag<b>, k = 16 : i32, layout = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32}> : (!llvm.ptr, i32) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %75 = "llvm.extractvalue"(%67) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %76 = "llvm.extractvalue"(%67) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %77 = "llvm.extractvalue"(%67) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %78 = "llvm.extractvalue"(%67) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %79 = "llvm.extractvalue"(%67) <{position = array<i64: 4>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %80 = "llvm.extractvalue"(%67) <{position = array<i64: 5>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %81 = "llvm.extractvalue"(%67) <{position = array<i64: 6>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %82 = "llvm.extractvalue"(%67) <{position = array<i64: 7>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %83 = "llvm.extractvalue"(%74) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %84 = "llvm.extractvalue"(%74) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %85 = "llvm.extractvalue"(%74) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %86 = "llvm.extractvalue"(%74) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %87 = "llvm.extractvalue"(%74) <{position = array<i64: 4>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %88 = "llvm.extractvalue"(%74) <{position = array<i64: 5>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %89 = "llvm.extractvalue"(%74) <{position = array<i64: 6>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %90 = "llvm.extractvalue"(%74) <{position = array<i64: 7>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %91 = "llvm.extractvalue"(%59) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %92 = "llvm.extractvalue"(%59) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %93 = "llvm.extractvalue"(%59) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %94 = "llvm.extractvalue"(%59) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %95 = "nvvm.wmma.mma"(%75, %76, %77, %78, %79, %80, %81, %82, %83, %84, %85, %86, %87, %88, %89, %90, %91, %92, %93, %94) <{eltypeA = #nvvm.mma_type<f16>, eltypeB = #nvvm.mma_type<f16>, k = 16 : i32, layoutA = #nvvm.mma_layout<row>, layoutB = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32}> : (vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %96 = "llvm.add"(%58, %50) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      "llvm.br"(%96, %95)[^bb1] : (i32, !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> ()
    ^bb3:  // pred: ^bb1
      %97 = "llvm.extractvalue"(%59) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %98 = "llvm.extractvalue"(%59) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %99 = "llvm.extractvalue"(%59) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %100 = "llvm.extractvalue"(%59) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %101 = "llvm.extractvalue"(%47) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr
      %102 = "llvm.mlir.constant"() <{value = 128 : index}> : () -> i32
      %103 = "llvm.mul"(%48, %102) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %104 = "llvm.add"(%103, %48) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
      %105 = "llvm.getelementptr"(%101, %104) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i32) -> !llvm.ptr
      %106 = "llvm.mlir.constant"() <{value = 128 : index}> : () -> i32
      "nvvm.wmma.store"(%105, %97, %98, %99, %100, %106) <{eltype = #nvvm.mma_type<f16>, k = 16 : i32, layout = #nvvm.mma_layout<row>, m = 16 : i32, n = 16 : i32}> : (!llvm.ptr, vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>, i32) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_wmma_mma_loop_op", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr):
      %0 = "llvm.load"(%arg0) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr
      %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr
      %3 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %4 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %5 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %6 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %7 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %8 = "llvm.load"(%arg1) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %9 = "llvm.extractvalue"(%8) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr
      %10 = "llvm.extractvalue"(%8) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr
      %11 = "llvm.extractvalue"(%8) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %12 = "llvm.extractvalue"(%8) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %13 = "llvm.extractvalue"(%8) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %14 = "llvm.extractvalue"(%8) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %15 = "llvm.extractvalue"(%8) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %16 = "llvm.load"(%arg2) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
      %17 = "llvm.extractvalue"(%16) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr
      %18 = "llvm.extractvalue"(%16) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> !llvm.ptr
      %19 = "llvm.extractvalue"(%16) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %20 = "llvm.extractvalue"(%16) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %21 = "llvm.extractvalue"(%16) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %22 = "llvm.extractvalue"(%16) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      %23 = "llvm.extractvalue"(%16) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>) -> i32
      "llvm.call"(%1, %2, %3, %4, %5, %6, %7, %9, %10, %11, %12, %13, %14, %15, %17, %18, %19, %20, %21, %22, %23) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_wmma_mma_loop_op, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 21, 0>}> : (!llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32, !llvm.ptr, !llvm.ptr, i32, i32, i32, i32, i32) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> ()>, linkage = #llvm.linkage<external>, sym_name = "gpu_wmma_constant_op", visibility_ = 0 : i64}> ({
      %1 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f16}> : () -> f16
      %2 = "llvm.mlir.poison"() : () -> vector<2xf16>
      %3 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
      %4 = "llvm.insertelement"(%2, %1, %3) : (vector<2xf16>, f16, i32) -> vector<2xf16>
      %5 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
      %6 = "llvm.insertelement"(%4, %1, %5) : (vector<2xf16>, f16, i32) -> vector<2xf16>
      %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %8 = "llvm.insertvalue"(%7, %6) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %9 = "llvm.insertvalue"(%8, %6) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %10 = "llvm.insertvalue"(%9, %6) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %11 = "llvm.insertvalue"(%10, %6) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      "llvm.return"(%11) : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_wmma_constant_op", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr):
      %0 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_wmma_constant_op, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)> (struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>)>, linkage = #llvm.linkage<external>, sym_name = "gpu_wmma_elementwise", visibility_ = 0 : i64}> ({
    ^bb0(%arg3: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, %arg4: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>):
      %1 = "llvm.mlir.poison"() : () -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %2 = "llvm.extractvalue"(%arg3) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %3 = "llvm.extractvalue"(%arg4) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %4 = "llvm.fadd"(%2, %3) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
      %5 = "llvm.insertvalue"(%1, %4) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %6 = "llvm.extractvalue"(%arg3) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %7 = "llvm.extractvalue"(%arg4) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %8 = "llvm.fadd"(%6, %7) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
      %9 = "llvm.insertvalue"(%5, %8) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %10 = "llvm.extractvalue"(%arg3) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %11 = "llvm.extractvalue"(%arg4) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %12 = "llvm.fadd"(%10, %11) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
      %13 = "llvm.insertvalue"(%9, %12) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %14 = "llvm.extractvalue"(%arg3) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %15 = "llvm.extractvalue"(%arg4) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %16 = "llvm.fadd"(%14, %15) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
      %17 = "llvm.insertvalue"(%13, %16) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %18 = "llvm.mlir.poison"() : () -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %19 = "llvm.extractvalue"(%17) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %20 = "llvm.extractvalue"(%arg4) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %21 = "llvm.fcmp"(%19, %20) <{fastmathFlags = #llvm.fastmath<none>, predicate = 2 : i64}> : (vector<2xf16>, vector<2xf16>) -> vector<2xi1>
      %22 = "llvm.select"(%21, %19, %20) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xi1>, vector<2xf16>, vector<2xf16>) -> vector<2xf16>
      %23 = "llvm.fcmp"(%19, %20) <{fastmathFlags = #llvm.fastmath<none>, predicate = 14 : i64}> : (vector<2xf16>, vector<2xf16>) -> vector<2xi1>
      %24 = "llvm.mlir.constant"() <{value = 0x7E00 : f16}> : () -> vector<2xf16>
      %25 = "llvm.select"(%23, %24, %22) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xi1>, vector<2xf16>, vector<2xf16>) -> vector<2xf16>
      %26 = "llvm.insertvalue"(%18, %25) <{position = array<i64: 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %27 = "llvm.extractvalue"(%17) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %28 = "llvm.extractvalue"(%arg4) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %29 = "llvm.fcmp"(%27, %28) <{fastmathFlags = #llvm.fastmath<none>, predicate = 2 : i64}> : (vector<2xf16>, vector<2xf16>) -> vector<2xi1>
      %30 = "llvm.select"(%29, %27, %28) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xi1>, vector<2xf16>, vector<2xf16>) -> vector<2xf16>
      %31 = "llvm.fcmp"(%27, %28) <{fastmathFlags = #llvm.fastmath<none>, predicate = 14 : i64}> : (vector<2xf16>, vector<2xf16>) -> vector<2xi1>
      %32 = "llvm.mlir.constant"() <{value = 0x7E00 : f16}> : () -> vector<2xf16>
      %33 = "llvm.select"(%31, %32, %30) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xi1>, vector<2xf16>, vector<2xf16>) -> vector<2xf16>
      %34 = "llvm.insertvalue"(%26, %33) <{position = array<i64: 1>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %35 = "llvm.extractvalue"(%17) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %36 = "llvm.extractvalue"(%arg4) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %37 = "llvm.fcmp"(%35, %36) <{fastmathFlags = #llvm.fastmath<none>, predicate = 2 : i64}> : (vector<2xf16>, vector<2xf16>) -> vector<2xi1>
      %38 = "llvm.select"(%37, %35, %36) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xi1>, vector<2xf16>, vector<2xf16>) -> vector<2xf16>
      %39 = "llvm.fcmp"(%35, %36) <{fastmathFlags = #llvm.fastmath<none>, predicate = 14 : i64}> : (vector<2xf16>, vector<2xf16>) -> vector<2xi1>
      %40 = "llvm.mlir.constant"() <{value = 0x7E00 : f16}> : () -> vector<2xf16>
      %41 = "llvm.select"(%39, %40, %38) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xi1>, vector<2xf16>, vector<2xf16>) -> vector<2xf16>
      %42 = "llvm.insertvalue"(%34, %41) <{position = array<i64: 2>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      %43 = "llvm.extractvalue"(%17) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %44 = "llvm.extractvalue"(%arg4) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> vector<2xf16>
      %45 = "llvm.fcmp"(%43, %44) <{fastmathFlags = #llvm.fastmath<none>, predicate = 2 : i64}> : (vector<2xf16>, vector<2xf16>) -> vector<2xi1>
      %46 = "llvm.select"(%45, %43, %44) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xi1>, vector<2xf16>, vector<2xf16>) -> vector<2xf16>
      %47 = "llvm.fcmp"(%43, %44) <{fastmathFlags = #llvm.fastmath<none>, predicate = 14 : i64}> : (vector<2xf16>, vector<2xf16>) -> vector<2xi1>
      %48 = "llvm.mlir.constant"() <{value = 0x7E00 : f16}> : () -> vector<2xf16>
      %49 = "llvm.select"(%47, %48, %46) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<2xi1>, vector<2xf16>, vector<2xf16>) -> vector<2xf16>
      %50 = "llvm.insertvalue"(%42, %49) <{position = array<i64: 3>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, vector<2xf16>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      "llvm.return"(%50) : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> ()
    }) {llvm.emit_c_interface} : () -> ()
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>)>, linkage = #llvm.linkage<external>, sym_name = "_mlir_ciface_gpu_wmma_elementwise", visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, %arg2: !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>):
      %0 = "llvm.call"(%arg1, %arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @gpu_wmma_elementwise, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>) -> !llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>
      "llvm.store"(%0, %arg0) <{ordering = 0 : i64}> : (!llvm.struct<(vector<2xf16>, vector<2xf16>, vector<2xf16>, vector<2xf16>)>, !llvm.ptr) -> ()
      "llvm.return"() : () -> ()
    }) {llvm.emit_c_interface} : () -> ()
  }) : () -> ()
}) : () -> ()

