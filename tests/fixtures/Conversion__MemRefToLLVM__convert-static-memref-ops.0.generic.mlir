"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<f32>, sym_name = "zero_d_alloc"}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %1 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %2 = "llvm.getelementptr"(%1, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %3 = "llvm.ptrtoint"(%2) : (!llvm.ptr) -> i64
    %4 = "llvm.call"(%3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.insertvalue"(%5, %4) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %7 = "llvm.insertvalue"(%6, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %8 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %9 = "llvm.insertvalue"(%7, %8) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %10 = "builtin.unrealized_conversion_cast"(%9) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<f32>
    "func.return"(%10) : (memref<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "zero_d_dealloc"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<f32>) -> !llvm.struct<(ptr, ptr, i64)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<42xf32>, sym_name = "aligned_1d_alloc"}> ({
    %0 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %6 = "llvm.add"(%4, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.call"(%6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %8 = "llvm.ptrtoint"(%7) : (!llvm.ptr) -> i64
    %9 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %10 = "llvm.sub"(%5, %9) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %11 = "llvm.add"(%8, %10) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %12 = "llvm.urem"(%11, %5) : (i64, i64) -> i64
    %13 = "llvm.sub"(%11, %12) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %14 = "llvm.inttoptr"(%13) : (i64) -> !llvm.ptr
    %15 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %16 = "llvm.insertvalue"(%15, %7) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %17 = "llvm.insertvalue"(%16, %14) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %18 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %19 = "llvm.insertvalue"(%17, %18) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %20 = "llvm.insertvalue"(%19, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %21 = "llvm.insertvalue"(%20, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %22 = "builtin.unrealized_conversion_cast"(%21) : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> memref<42xf32>
    "func.return"(%22) : (memref<42xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<32x18xf32>, sym_name = "static_alloc"}> ({
    %0 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 18 : index}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %3 = "llvm.mlir.constant"() <{value = 576 : index}> : () -> i64
    %4 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %3) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %6 = "llvm.ptrtoint"(%5) : (!llvm.ptr) -> i64
    %7 = "llvm.call"(%6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %8 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = "llvm.insertvalue"(%8, %7) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = "llvm.insertvalue"(%9, %7) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %11 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %12 = "llvm.insertvalue"(%10, %11) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %13 = "llvm.insertvalue"(%12, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "llvm.insertvalue"(%13, %1) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.insertvalue"(%15, %2) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "builtin.unrealized_conversion_cast"(%16) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<32x18xf32>
    "func.return"(%17) : (memref<32x18xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<32x18xf32>, sym_name = "static_alloca"}> ({
    %0 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 18 : index}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %3 = "llvm.mlir.constant"() <{value = 576 : index}> : () -> i64
    %4 = "llvm.alloca"(%3) <{elem_type = f32}> : (i64) -> !llvm.ptr
    %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %6 = "llvm.insertvalue"(%5, %4) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %7 = "llvm.insertvalue"(%6, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %8 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %9 = "llvm.insertvalue"(%7, %8) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = "llvm.insertvalue"(%9, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %11 = "llvm.insertvalue"(%10, %1) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %12 = "llvm.insertvalue"(%11, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %13 = "llvm.insertvalue"(%12, %2) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "builtin.unrealized_conversion_cast"(%13) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<32x18xf32>
    %15 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %16 = "llvm.mlir.constant"() <{value = 18 : index}> : () -> i64
    %17 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %18 = "llvm.mlir.constant"() <{value = 576 : index}> : () -> i64
    %19 = "llvm.alloca"(%18) <{alignment = 32 : i64, elem_type = f32}> : (i64) -> !llvm.ptr
    %20 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = "llvm.insertvalue"(%20, %19) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %22 = "llvm.insertvalue"(%21, %19) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %23 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %24 = "llvm.insertvalue"(%22, %23) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %25 = "llvm.insertvalue"(%24, %15) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %26 = "llvm.insertvalue"(%25, %16) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %27 = "llvm.insertvalue"(%26, %16) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %28 = "llvm.insertvalue"(%27, %17) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    "func.return"(%14) : (memref<32x18xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<32x0x18xf32>, sym_name = "static_alloca_zero"}> ({
    %0 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = 18 : index}> : () -> i64
    %3 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %4 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %5 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %6 = "llvm.alloca"(%5) <{elem_type = f32}> : (i64) -> !llvm.ptr
    %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %8 = "llvm.insertvalue"(%7, %6) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %9 = "llvm.insertvalue"(%8, %6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %10 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %12 = "llvm.insertvalue"(%11, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %13 = "llvm.insertvalue"(%12, %1) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %14 = "llvm.insertvalue"(%13, %2) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %15 = "llvm.insertvalue"(%14, %4) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %16 = "llvm.insertvalue"(%15, %2) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %17 = "llvm.insertvalue"(%16, %3) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %18 = "builtin.unrealized_conversion_cast"(%17) : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> memref<32x0x18xf32>
    "func.return"(%18) : (memref<32x0x18xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<10x8xf32>) -> (), sym_name = "static_dealloc"}> ({
  ^bb0(%arg0: memref<10x8xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<10x8xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> f32, sym_name = "zero_d_load"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<f32>) -> !llvm.struct<(ptr, ptr, i64)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %2 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x42xf32>, index, index) -> (), sym_name = "static_load"}> ({
  ^bb0(%arg0: memref<10x42xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<10x42xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>, f32) -> (), sym_name = "zero_d_store"}> ({
  ^bb0(%arg0: memref<f32>, %arg1: f32):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<f32>) -> !llvm.struct<(ptr, ptr, i64)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    "llvm.store"(%arg1, %1) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x42xf32>, index, index, f32) -> (), sym_name = "static_store"}> ({
  ^bb0(%arg0: memref<10x42xf32>, %arg1: index, %arg2: index, %arg3: f32):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<10x42xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%arg3, %7) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x32x15x13x27xf32>) -> (), sym_name = "static_memref_dim"}> ({
  ^bb0(%arg0: memref<42x32x15x13x27xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i64
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "llvm.mlir.constant"() <{value = 15 : index}> : () -> i64
    %6 = "arith.constant"() <{value = 3 : index}> : () -> index
    %7 = "llvm.mlir.constant"() <{value = 13 : index}> : () -> i64
    %8 = "arith.constant"() <{value = 4 : index}> : () -> index
    %9 = "llvm.mlir.constant"() <{value = 27 : index}> : () -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x32x15x13x27xf32>) -> index, sym_name = "static_out_of_bound_memref_dim"}> ({
  ^bb0(%arg0: memref<42x32x15x13x27xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<42x32x15x13x27xf32>) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %1 = "arith.constant"() <{value = -7 : index}> : () -> index
    %2 = "builtin.unrealized_conversion_cast"(%1) : (index) -> i64
    %3 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>) -> !llvm.array<5 x i64>
    %5 = "llvm.alloca"(%3) <{elem_type = !llvm.array<5 x i64>}> : (i64) -> !llvm.ptr
    "llvm.store"(%4, %5) <{ordering = 0 : i64}> : (!llvm.array<5 x i64>, !llvm.ptr) -> ()
    %6 = "llvm.getelementptr"(%5, %2) <{elem_type = !llvm.array<5 x i64>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %7 = "llvm.load"(%6) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    %8 = "builtin.unrealized_conversion_cast"(%7) : (i64) -> index
    "func.return"(%8) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i32)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "address"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "builtin.unrealized_conversion_cast"(%0) : (index) -> i32
    %2 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %3 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %1) <{elem_type = vector<2xf32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i32) -> !llvm.ptr
    %5 = "llvm.ptrtoint"(%4) : (!llvm.ptr) -> i32
    %6 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %7 = "llvm.getelementptr"(%6) <{elem_type = vector<2xf32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %8 = "llvm.ptrtoint"(%7) : (!llvm.ptr) -> i32
    %9 = "llvm.add"(%5, %8) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %10 = "llvm.call"(%9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> !llvm.ptr
    %11 = "llvm.ptrtoint"(%10) : (!llvm.ptr) -> i32
    %12 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %13 = "llvm.sub"(%8, %12) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %14 = "llvm.add"(%11, %13) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %15 = "llvm.urem"(%14, %8) : (i32, i32) -> i32
    %16 = "llvm.sub"(%14, %15) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %17 = "llvm.inttoptr"(%16) : (i32) -> !llvm.ptr
    %18 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %19 = "llvm.insertvalue"(%18, %10) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %20 = "llvm.insertvalue"(%19, %17) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %21 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
    %22 = "llvm.insertvalue"(%20, %21) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %23 = "llvm.insertvalue"(%22, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %24 = "llvm.insertvalue"(%23, %2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    "func.return"() : () -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<index = 32 : i64>} : () -> ()

// -----
"builtin.module"() ({
  "llvm.mlir.global"() <{addr_space = 0 : i32, constant, global_type = !llvm.array<3 x i64>, linkage = #llvm.linkage<private>, sym_name = "__constant_3xi64", value = dense<[2, 6, 20]> : tensor<3xi64>, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<4x5x6xf32>) -> memref<2x6x20xf32>, sym_name = "memref.reshape"}> ({
  ^bb0(%arg0: memref<4x5x6xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4x5x6xf32>) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %3 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %4 = "llvm.getelementptr"(%3, %1) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %5 = "llvm.ptrtoint"(%4) : (!llvm.ptr) -> i64
    %6 = "llvm.mlir.addressof"() <{global_name = @__constant_3xi64}> : () -> !llvm.ptr
    %7 = "llvm.getelementptr"(%6) <{elem_type = !llvm.array<3 x i64>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 0>}> : (!llvm.ptr) -> !llvm.ptr
    %8 = "llvm.mlir.constant"() <{value = 3735928559 : index}> : () -> i64
    %9 = "llvm.inttoptr"(%8) : (i64) -> !llvm.ptr
    %10 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %11 = "llvm.insertvalue"(%10, %9) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.insertvalue"(%11, %7) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %14 = "llvm.insertvalue"(%12, %13) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = "llvm.insertvalue"(%14, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %16 = "llvm.insertvalue"(%15, %2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %17 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %18 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %19 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %20 = "llvm.insertvalue"(%17, %18) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %21 = "llvm.insertvalue"(%20, %19) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %22 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %23 = "llvm.insertvalue"(%21, %22) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %24 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %25 = "llvm.mlir.constant"() <{value = 20 : index}> : () -> i64
    %26 = "llvm.insertvalue"(%23, %25) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %27 = "llvm.insertvalue"(%26, %24) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %28 = "llvm.mul"(%24, %25) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %29 = "llvm.mlir.constant"() <{value = 20 : index}> : () -> i64
    %30 = "llvm.mlir.constant"() <{value = 6 : index}> : () -> i64
    %31 = "llvm.insertvalue"(%27, %30) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %32 = "llvm.insertvalue"(%31, %29) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %33 = "llvm.mul"(%29, %30) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %34 = "llvm.mlir.constant"() <{value = 120 : index}> : () -> i64
    %35 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %36 = "llvm.insertvalue"(%32, %35) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %37 = "llvm.insertvalue"(%36, %34) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %38 = "builtin.unrealized_conversion_cast"(%37) : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> memref<2x6x20xf32>
    %39 = "llvm.mul"(%34, %35) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "func.return"(%38) : (memref<2x6x20xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>, memref<4xi64>) -> memref<?x?x12x32xf32>, sym_name = "memref.reshape.dynamic.dim"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>, %arg1: memref<4xi64>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<4xi64>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?x?x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %2 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %3 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %4 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %5 = "llvm.insertvalue"(%2, %3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %6 = "llvm.insertvalue"(%5, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %7 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %8 = "llvm.insertvalue"(%6, %7) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %9 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %10 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %11 = "llvm.insertvalue"(%8, %10) <{position = array<i64: 3, 3>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %12 = "llvm.insertvalue"(%11, %9) <{position = array<i64: 4, 3>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %13 = "llvm.mul"(%9, %10) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %14 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %15 = "llvm.mlir.constant"() <{value = 12 : index}> : () -> i64
    %16 = "llvm.insertvalue"(%12, %15) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %17 = "llvm.insertvalue"(%16, %14) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %18 = "llvm.mul"(%14, %15) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %19 = "llvm.mlir.constant"() <{value = 384 : index}> : () -> i64
    %20 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %21 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %22 = "llvm.getelementptr"(%21, %20) <{elem_type = i64, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %23 = "llvm.load"(%22) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    %24 = "llvm.insertvalue"(%17, %23) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %25 = "llvm.insertvalue"(%24, %19) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %26 = "llvm.mul"(%19, %23) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %27 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %28 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %29 = "llvm.getelementptr"(%28, %27) <{elem_type = i64, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %30 = "llvm.load"(%29) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    %31 = "llvm.insertvalue"(%25, %30) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %32 = "llvm.insertvalue"(%31, %26) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %33 = "builtin.unrealized_conversion_cast"(%32) : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>) -> memref<?x?x12x32xf32>
    %34 = "llvm.mul"(%26, %30) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "func.return"(%33) : (memref<?x?x12x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xi32>, memref<1xindex>) -> memref<?xi32>, sym_name = "memref.reshape_index"}> ({
  ^bb0(%arg1: memref<?x?xi32>, %arg2: memref<1xindex>):
    %15 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<1xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %16 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?x?xi32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %18 = "llvm.extractvalue"(%16) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %19 = "llvm.extractvalue"(%16) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %20 = "llvm.insertvalue"(%17, %18) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %21 = "llvm.insertvalue"(%20, %19) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %22 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %23 = "llvm.insertvalue"(%21, %22) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %24 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %25 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %26 = "llvm.extractvalue"(%15) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %27 = "llvm.getelementptr"(%26, %25) <{elem_type = i64, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %28 = "llvm.load"(%27) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    %29 = "builtin.unrealized_conversion_cast"(%28) : (i64) -> index
    %30 = "builtin.unrealized_conversion_cast"(%29) : (index) -> i64
    %31 = "llvm.insertvalue"(%23, %30) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %32 = "llvm.insertvalue"(%31, %24) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %33 = "builtin.unrealized_conversion_cast"(%32) : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> memref<?xi32>
    %34 = "llvm.mul"(%24, %30) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "func.return"(%33) : (memref<?xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>) -> memref<?xf32, 1>, sym_name = "memref_memory_space_cast"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %5 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %6 = "llvm.addrspacecast"(%1) : (!llvm.ptr) -> !llvm.ptr<1>
    %7 = "llvm.addrspacecast"(%2) : (!llvm.ptr) -> !llvm.ptr<1>
    %8 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.insertvalue"(%8, %6) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %10 = "llvm.insertvalue"(%9, %7) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr<1>) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %11 = "llvm.insertvalue"(%10, %3) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.insertvalue"(%11, %4) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %13 = "llvm.insertvalue"(%12, %5) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>
    %14 = "builtin.unrealized_conversion_cast"(%13) : (!llvm.struct<(ptr<1>, ptr<1>, i64, array<1 x i64>, array<1 x i64>)>) -> memref<?xf32, 1>
    "func.return"(%14) : (memref<?xf32, 1>) -> ()
  }) : () -> ()
}) : () -> ()

