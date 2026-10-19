"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i64)>, linkage = #llvm.linkage<external>, sym_name = "matmul", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64):
    %0 = "llvm.call"() <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamCreate, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 0, 0>}> : () -> !llvm.ptr
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %arg0) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %6 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %7 = "llvm.call"(%4, %0, %6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemAlloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %8 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.insertvalue"(%8, %7) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %10 = "llvm.insertvalue"(%9, %7) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %11 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %12 = "llvm.insertvalue"(%10, %11) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = "llvm.insertvalue"(%12, %arg0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %14 = "llvm.insertvalue"(%13, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %16 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %17 = "llvm.getelementptr"(%16, %arg0) <{elem_type = f16, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %18 = "llvm.ptrtoint"(%17) : (!llvm.ptr) -> i64
    %19 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %20 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
    %21 = "llvm.call"(%18, %0, %20) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuMemAlloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, !llvm.ptr, i8) -> !llvm.ptr
    %22 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %23 = "llvm.insertvalue"(%22, %21) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %24 = "llvm.insertvalue"(%23, %21) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %25 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %26 = "llvm.insertvalue"(%24, %25) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %27 = "llvm.insertvalue"(%26, %arg0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %28 = "llvm.insertvalue"(%27, %15) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %29 = "llvm.extractvalue"(%14) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %30 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %31 = "llvm.mlir.constant"() <{value = 44104 : index}> : () -> i64
    %32 = "llvm.alloca"(%31) <{alignment = 16 : i64, elem_type = i8}> : (i64) -> !llvm.ptr
    %33 = "llvm.bitcast"(%32) : (!llvm.ptr) -> !llvm.ptr
    "llvm.call"(%33, %arg0, %arg0, %29, %30, %0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCusparseLtCreate2To4SpMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> : (!llvm.ptr, i64, i64, !llvm.ptr, i32, !llvm.ptr) -> ()
    %34 = "llvm.extractvalue"(%28) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %35 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %36 = "llvm.mlir.constant"() <{value = 11032 : index}> : () -> i64
    %37 = "llvm.alloca"(%36) <{alignment = 16 : i64, elem_type = i8}> : (i64) -> !llvm.ptr
    %38 = "llvm.bitcast"(%37) : (!llvm.ptr) -> !llvm.ptr
    "llvm.call"(%38, %arg0, %arg0, %34, %35, %0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCreateCuSparseLtDnMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 6, 0>}> : (!llvm.ptr, i64, i64, !llvm.ptr, i32, !llvm.ptr) -> ()
    %39 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %40 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %41 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %42 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %43 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %44 = "llvm.alloca"(%43) <{alignment = 16 : i64, elem_type = !llvm.ptr}> : (i64) -> !llvm.ptr
    "llvm.call"(%44, %39, %40, %33, %38, %38, %42, %41, %0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCuSparseLtSpMMBufferSize, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 9, 0>}> : (!llvm.ptr, i32, i32, !llvm.ptr, !llvm.ptr, !llvm.ptr, i32, i32, !llvm.ptr) -> ()
    %45 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %46 = "llvm.getelementptr"(%44, %45) <{elem_type = !llvm.ptr, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %47 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %48 = "llvm.getelementptr"(%44, %47) <{elem_type = !llvm.ptr, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %49 = "llvm.load"(%44) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    %50 = "llvm.load"(%46) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    %51 = "llvm.load"(%48) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    %52 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %53 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %54 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
    %55 = "llvm.extractvalue"(%28) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %56 = "llvm.extractvalue"(%28) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %57 = "llvm.extractvalue"(%28) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    "llvm.call"(%33, %38, %38, %55, %56, %57, %0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuCuSparseLtSpMM, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 7, 0>}> : (!llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%33, %0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuDestroyCuSparseLtSpMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%38, %0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuDestroyCuSparseLtDnMat, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.call"(%0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamSynchronize, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.call"(%0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mgpuStreamDestroy, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr ()>, linkage = #llvm.linkage<external>, sym_name = "mgpuStreamCreate", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, ptr, i8)>, linkage = #llvm.linkage<external>, sym_name = "mgpuMemAlloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i64, i64, ptr, i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuCusparseLtCreate2To4SpMat", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i64, i64, ptr, i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuCreateCuSparseLtDnMat", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, i32, i32, ptr, ptr, ptr, i32, i32, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuCuSparseLtSpMMBufferSize", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, ptr, ptr, ptr, ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuCuSparseLtSpMM", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuDestroyCuSparseLtSpMat", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuDestroyCuSparseLtDnMat", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuStreamSynchronize", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "mgpuStreamDestroy", visibility_ = 0 : i64}> ({
  }) : () -> ()
}) {gpu.container_module} : () -> ()

