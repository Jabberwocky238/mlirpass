"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> memref<?x42x?xf32>, sym_name = "mixed_alloc"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %2 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i64
    %3 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %4 = "llvm.mul"(%0, %2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %5 = "llvm.mul"(%4, %1) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %7 = "llvm.getelementptr"(%6, %5) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.ptrtoint"(%7) : (!llvm.ptr) -> i64
    %9 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i64
    %10 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %11 = "llvm.sub"(%9, %10) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %12 = "llvm.add"(%8, %11) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %13 = "llvm.urem"(%12, %9) : (i64, i64) -> i64
    %14 = "llvm.sub"(%12, %13) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %15 = "llvm.call"(%9, %14) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %16 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %17 = "llvm.insertvalue"(%16, %15) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %18 = "llvm.insertvalue"(%17, %15) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %19 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %20 = "llvm.insertvalue"(%18, %19) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %21 = "llvm.insertvalue"(%20, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %22 = "llvm.insertvalue"(%21, %2) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %23 = "llvm.insertvalue"(%22, %0) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %24 = "llvm.insertvalue"(%23, %4) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %25 = "llvm.insertvalue"(%24, %0) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %26 = "llvm.insertvalue"(%25, %3) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %27 = "builtin.unrealized_conversion_cast"(%26) : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> memref<?x42x?xf32>
    "func.return"(%27) : (memref<?x42x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x42x?xf32>) -> (), sym_name = "mixed_dealloc"}> ({
  ^bb0(%arg0: memref<?x42x?xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?x42x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xf32>) -> (), sym_name = "unranked_dealloc"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<*xf32>) -> !llvm.struct<(i64, ptr)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    %2 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.call"(%2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> memref<?x?xf32>, sym_name = "dynamic_alloc"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %2 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %3 = "llvm.mul"(%0, %1) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %4 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %5 = "llvm.getelementptr"(%4, %3) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %6 = "llvm.ptrtoint"(%5) : (!llvm.ptr) -> i64
    %7 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i64
    %8 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %9 = "llvm.sub"(%7, %8) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %10 = "llvm.add"(%6, %9) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %11 = "llvm.urem"(%10, %7) : (i64, i64) -> i64
    %12 = "llvm.sub"(%10, %11) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %13 = "llvm.call"(%7, %12) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %14 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %13) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.insertvalue"(%15, %13) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %18 = "llvm.insertvalue"(%16, %17) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "llvm.insertvalue"(%18, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %20 = "llvm.insertvalue"(%19, %0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = "llvm.insertvalue"(%20, %0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %22 = "llvm.insertvalue"(%21, %2) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %23 = "builtin.unrealized_conversion_cast"(%22) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<?x?xf32>
    "func.return"(%23) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> memref<?x?xf32>, sym_name = "dynamic_alloca"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %2 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %3 = "llvm.mul"(%0, %1) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %4 = "llvm.alloca"(%3) <{elem_type = f32}> : (i64) -> !llvm.ptr
    %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %6 = "llvm.insertvalue"(%5, %4) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %7 = "llvm.insertvalue"(%6, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %8 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %9 = "llvm.insertvalue"(%7, %8) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = "llvm.insertvalue"(%9, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %11 = "llvm.insertvalue"(%10, %0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %12 = "llvm.insertvalue"(%11, %0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %13 = "llvm.insertvalue"(%12, %2) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "builtin.unrealized_conversion_cast"(%13) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<?x?xf32>
    %15 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %16 = "llvm.mul"(%0, %1) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %17 = "llvm.alloca"(%16) <{alignment = 32 : i64, elem_type = f32}> : (i64) -> !llvm.ptr
    %18 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "llvm.insertvalue"(%18, %17) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %20 = "llvm.insertvalue"(%19, %17) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %22 = "llvm.insertvalue"(%20, %21) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %23 = "llvm.insertvalue"(%22, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %24 = "llvm.insertvalue"(%23, %0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %25 = "llvm.insertvalue"(%24, %0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %26 = "llvm.insertvalue"(%25, %15) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    "func.return"(%14) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr)>, linkage = #llvm.linkage<external>, sym_name = "free", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf32>) -> (), sym_name = "dynamic_dealloc"}> ({
  ^bb0(%arg0: memref<?x?xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    "llvm.call"(%1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @free, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index) -> memref<32x18xf32>, sym_name = "stdlib_aligned_alloc"}> ({
  ^bb0(%arg0: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %1 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %2 = "llvm.mlir.constant"() <{value = 18 : index}> : () -> i64
    %3 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %4 = "llvm.mlir.constant"() <{value = 576 : index}> : () -> i64
    %5 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %6 = "llvm.getelementptr"(%5, %4) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %7 = "llvm.ptrtoint"(%6) : (!llvm.ptr) -> i64
    %8 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %9 = "llvm.call"(%8, %7) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %10 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %11 = "llvm.insertvalue"(%10, %9) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %12 = "llvm.insertvalue"(%11, %9) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %13 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %14 = "llvm.insertvalue"(%12, %13) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.insertvalue"(%15, %2) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "llvm.insertvalue"(%16, %2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %18 = "llvm.insertvalue"(%17, %3) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "builtin.unrealized_conversion_cast"(%18) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<32x18xf32>
    %20 = "llvm.mlir.constant"() <{value = 4096 : index}> : () -> i64
    %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %22 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %23 = "llvm.getelementptr"(%22, %20) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %24 = "llvm.ptrtoint"(%23) : (!llvm.ptr) -> i64
    %25 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %26 = "llvm.call"(%25, %24) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %27 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %28 = "llvm.insertvalue"(%27, %26) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %29 = "llvm.insertvalue"(%28, %26) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %30 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %31 = "llvm.insertvalue"(%29, %30) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %32 = "llvm.insertvalue"(%31, %20) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %33 = "llvm.insertvalue"(%32, %21) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %34 = "llvm.mlir.constant"() <{value = 4096 : index}> : () -> i64
    %35 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %36 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %37 = "llvm.getelementptr"(%36, %34) <{elem_type = vector<8xf32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %38 = "llvm.ptrtoint"(%37) : (!llvm.ptr) -> i64
    %39 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %40 = "llvm.call"(%39, %38) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %41 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %42 = "llvm.insertvalue"(%41, %40) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %43 = "llvm.insertvalue"(%42, %40) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %44 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %45 = "llvm.insertvalue"(%43, %44) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %46 = "llvm.insertvalue"(%45, %34) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %47 = "llvm.insertvalue"(%46, %35) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %48 = "llvm.mlir.constant"() <{value = 4096 : index}> : () -> i64
    %49 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %50 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %51 = "llvm.getelementptr"(%50, %48) <{elem_type = vector<2xf32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %52 = "llvm.ptrtoint"(%51) : (!llvm.ptr) -> i64
    %53 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i64
    %54 = "llvm.call"(%53, %52) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %55 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %56 = "llvm.insertvalue"(%55, %54) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %57 = "llvm.insertvalue"(%56, %54) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %58 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %59 = "llvm.insertvalue"(%57, %58) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %60 = "llvm.insertvalue"(%59, %48) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %61 = "llvm.insertvalue"(%60, %49) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %62 = "llvm.mlir.constant"() <{value = 1024 : index}> : () -> i64
    %63 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %64 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %65 = "llvm.getelementptr"(%64, %62) <{elem_type = vector<4xf32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %66 = "llvm.ptrtoint"(%65) : (!llvm.ptr) -> i64
    %67 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %68 = "llvm.call"(%67, %66) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %69 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %70 = "llvm.insertvalue"(%69, %68) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %71 = "llvm.insertvalue"(%70, %68) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %72 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %73 = "llvm.insertvalue"(%71, %72) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %74 = "llvm.insertvalue"(%73, %62) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %75 = "llvm.insertvalue"(%74, %63) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %76 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %77 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %78 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %79 = "llvm.getelementptr"(%78, %76) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %80 = "llvm.ptrtoint"(%79) : (!llvm.ptr) -> i64
    %81 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %82 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %83 = "llvm.sub"(%81, %82) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %84 = "llvm.add"(%80, %83) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %85 = "llvm.urem"(%84, %81) : (i64, i64) -> i64
    %86 = "llvm.sub"(%84, %85) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %87 = "llvm.call"(%81, %86) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %88 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %89 = "llvm.insertvalue"(%88, %87) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %90 = "llvm.insertvalue"(%89, %87) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %91 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %92 = "llvm.insertvalue"(%90, %91) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %93 = "llvm.insertvalue"(%92, %76) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %94 = "llvm.insertvalue"(%93, %77) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %95 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %96 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %97 = "llvm.getelementptr"(%96, %0) <{elem_type = vector<18xf32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %98 = "llvm.ptrtoint"(%97) : (!llvm.ptr) -> i64
    %99 = "llvm.mlir.constant"() <{value = 128 : index}> : () -> i64
    %100 = "llvm.call"(%99, %98) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %101 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %102 = "llvm.insertvalue"(%101, %100) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %103 = "llvm.insertvalue"(%102, %100) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %104 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %105 = "llvm.insertvalue"(%103, %104) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %106 = "llvm.insertvalue"(%105, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %107 = "llvm.insertvalue"(%106, %95) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    "func.return"(%19) : (memref<32x18xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x?xf32>, index, index) -> (), sym_name = "mixed_load"}> ({
  ^bb0(%arg0: memref<42x?xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<42x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> (), sym_name = "dynamic_load"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> (), sym_name = "prefetch"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.prefetch"(%7) <{cache = 1 : i32, hint = 3 : i32, rw = 1 : i32}> : (!llvm.ptr) -> ()
    %8 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %9 = "llvm.extractvalue"(%2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %10 = "llvm.mul"(%1, %9) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %11 = "llvm.add"(%10, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %12 = "llvm.getelementptr"(%8, %11) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.prefetch"(%12) <{cache = 1 : i32, hint = 0 : i32, rw = 0 : i32}> : (!llvm.ptr) -> ()
    %13 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %14 = "llvm.extractvalue"(%2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %15 = "llvm.mul"(%1, %14) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %16 = "llvm.add"(%15, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %17 = "llvm.getelementptr"(%13, %16) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.intr.prefetch"(%17) <{cache = 0 : i32, hint = 2 : i32, rw = 0 : i32}> : (!llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, index, f32) -> (), sym_name = "dynamic_store"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index, %arg3: f32):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%arg3, %7) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x?xf32>, index, index, f32) -> (), sym_name = "mixed_store"}> ({
  ^bb0(%arg0: memref<42x?xf32>, %arg1: index, %arg2: index, %arg3: f32):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<42x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %5 = "llvm.mul"(%1, %4) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %6 = "llvm.add"(%5, %0) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%3, %6) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%arg3, %7) <{ordering = 0 : i64}> : (f32, !llvm.ptr) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> memref<*xf32, 1>, sym_name = "memref_memory_space_cast"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<*xf32>) -> !llvm.struct<(i64, ptr)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %5 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %6 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %7 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %8 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %9 = "llvm.mul"(%6, %8) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %10 = "llvm.extractvalue"(%4) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %11 = "llvm.mul"(%6, %10) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %12 = "llvm.add"(%11, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %13 = "llvm.mul"(%12, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %14 = "llvm.add"(%9, %13) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %15 = "llvm.alloca"(%14) <{elem_type = i8}> : (i64) -> !llvm.ptr
    %16 = "llvm.insertvalue"(%4, %15) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %17 = "builtin.unrealized_conversion_cast"(%16) : (!llvm.struct<(i64, ptr)>) -> memref<*xf32, 1>
    %18 = "llvm.load"(%2) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.ptr
    %19 = "llvm.getelementptr"(%2) <{elem_type = !llvm.ptr, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %20 = "llvm.load"(%19) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.ptr
    %21 = "llvm.addrspacecast"(%18) : (!llvm.ptr) -> !llvm.ptr<1>
    %22 = "llvm.addrspacecast"(%20) : (!llvm.ptr) -> !llvm.ptr<1>
    "llvm.store"(%21, %15) <{ordering = 0 : i64}> : (!llvm.ptr<1>, !llvm.ptr) -> ()
    %23 = "llvm.getelementptr"(%15) <{elem_type = !llvm.ptr<1>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%22, %23) <{ordering = 0 : i64}> : (!llvm.ptr<1>, !llvm.ptr) -> ()
    %24 = "llvm.getelementptr"(%2) <{elem_type = !llvm.ptr, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 2>}> : (!llvm.ptr) -> !llvm.ptr
    %25 = "llvm.getelementptr"(%15) <{elem_type = !llvm.ptr<1>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 2>}> : (!llvm.ptr) -> !llvm.ptr
    %26 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i64
    %27 = "llvm.sub"(%14, %26) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.intr.memcpy"(%25, %24, %27) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "func.return"(%17) : (memref<*xf32, 1>) -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<!llvm.ptr = dense<64> : vector<3xi64>, !llvm.ptr<1> = dense<32> : vector<3xi64>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x42xf32>) -> (), sym_name = "memref_cast_static_to_dynamic"}> ({
  ^bb0(%arg0: memref<10x42xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x42xf32>) -> (), sym_name = "memref_cast_static_to_mixed"}> ({
  ^bb0(%arg0: memref<10x42xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>) -> (), sym_name = "memref_cast_dynamic_to_static"}> ({
  ^bb0(%arg0: memref<?x?xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>) -> (), sym_name = "memref_cast_dynamic_to_mixed"}> ({
  ^bb0(%arg0: memref<?x?xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x?xf32>) -> (), sym_name = "memref_cast_mixed_to_dynamic"}> ({
  ^bb0(%arg0: memref<42x?xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x?xf32>) -> (), sym_name = "memref_cast_mixed_to_static"}> ({
  ^bb0(%arg0: memref<42x?xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x?xf32>) -> (), sym_name = "memref_cast_mixed_to_mixed"}> ({
  ^bb0(%arg0: memref<42x?xf32>):
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x2x?xf32>) -> (), sym_name = "memref_cast_ranked_to_unranked"}> ({
  ^bb0(%arg0: memref<42x2x?xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<42x2x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.alloca"(%1) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%0, %2) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> ()
    %3 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %5 = "llvm.insertvalue"(%4, %3) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %6 = "llvm.insertvalue"(%5, %2) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> (), sym_name = "memref_cast_unranked_to_ranked"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<*xf32>) -> !llvm.struct<(i64, ptr)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    %2 = "llvm.load"(%1) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x?x?x13x?xf32>) -> (), sym_name = "mixed_memref_dim"}> ({
  ^bb0(%arg0: memref<42x?x?x13x?xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<42x?x?x13x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "llvm.mlir.constant"() <{value = 42 : index}> : () -> i64
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>) -> i64
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>) -> i64
    %7 = "arith.constant"() <{value = 3 : index}> : () -> index
    %8 = "llvm.mlir.constant"() <{value = 13 : index}> : () -> i64
    %9 = "arith.constant"() <{value = 4 : index}> : () -> index
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 4>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<3x?xf32>, index) -> index, sym_name = "memref_dim_with_dyn_index"}> ({
  ^bb0(%arg0: memref<3x?xf32>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<3x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %3 = "llvm.extractvalue"(%1) <{position = array<i64: 3>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.array<2 x i64>
    %4 = "llvm.alloca"(%2) <{elem_type = !llvm.array<2 x i64>}> : (i64) -> !llvm.ptr
    "llvm.store"(%3, %4) <{ordering = 0 : i64}> : (!llvm.array<2 x i64>, !llvm.ptr) -> ()
    %5 = "llvm.getelementptr"(%4, %0) <{elem_type = !llvm.array<2 x i64>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %6 = "llvm.load"(%5) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    %7 = "builtin.unrealized_conversion_cast"(%6) : (i64) -> index
    "func.return"(%7) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x3xf32>) -> (), sym_name = "memref_reinterpret_cast_ranked_to_static_shape"}> ({
  ^bb0(%arg0: memref<2x3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<2x3xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.insertvalue"(%1, %2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %5 = "llvm.insertvalue"(%4, %3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.insertvalue"(%5, %6) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %8 = "llvm.mlir.constant"() <{value = 6 : index}> : () -> i64
    %9 = "llvm.insertvalue"(%7, %8) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %12 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %13 = "llvm.insertvalue"(%11, %12) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %15 = "llvm.insertvalue"(%13, %14) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index, memref<*xf32>) -> (), sym_name = "memref_reinterpret_cast_unranked_to_dynamic_shape"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: memref<*xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %3 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %4 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %5 = "builtin.unrealized_conversion_cast"(%arg5) : (memref<*xf32>) -> !llvm.struct<(i64, ptr)>
    %6 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %7 = "llvm.extractvalue"(%5) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>) -> !llvm.ptr
    %8 = "llvm.load"(%7) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.ptr
    %9 = "llvm.getelementptr"(%7) <{elem_type = !llvm.ptr, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %10 = "llvm.load"(%9) <{ordering = 0 : i64}> : (!llvm.ptr) -> !llvm.ptr
    %11 = "llvm.insertvalue"(%6, %8) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %12 = "llvm.insertvalue"(%11, %10) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %13 = "llvm.insertvalue"(%12, %4) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "llvm.insertvalue"(%13, %3) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.insertvalue"(%15, %2) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "llvm.insertvalue"(%16, %0) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x3xf32>, memref<?xindex>) -> (), sym_name = "memref_reshape"}> ({
  ^bb0(%arg0: memref<2x3xf32>, %arg1: memref<?xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (memref<?xindex>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<2x3xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> i64
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %4 = "llvm.insertvalue"(%3, %2) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %5 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %6 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %7 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %8 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %9 = "llvm.mul"(%6, %8) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %10 = "llvm.extractvalue"(%4) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>) -> i64
    %11 = "llvm.mul"(%6, %10) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %12 = "llvm.add"(%11, %5) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %13 = "llvm.mul"(%12, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %14 = "llvm.add"(%9, %13) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %15 = "llvm.alloca"(%14) <{elem_type = i8}> : (i64) -> !llvm.ptr
    %16 = "llvm.insertvalue"(%4, %15) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    %17 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %18 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %19 = "llvm.extractvalue"(%1) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    "llvm.store"(%17, %15) <{ordering = 0 : i64}> : (!llvm.ptr, !llvm.ptr) -> ()
    %20 = "llvm.getelementptr"(%15) <{elem_type = !llvm.ptr, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%18, %20) <{ordering = 0 : i64}> : (!llvm.ptr, !llvm.ptr) -> ()
    %21 = "llvm.getelementptr"(%15) <{elem_type = !llvm.ptr, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 2>}> : (!llvm.ptr) -> !llvm.ptr
    "llvm.store"(%19, %21) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    %22 = "llvm.getelementptr"(%15) <{elem_type = !llvm.struct<(ptr, ptr, i64, i64)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 0, 3>}> : (!llvm.ptr) -> !llvm.ptr
    %23 = "llvm.getelementptr"(%22, %2) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %24 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %25 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %26 = "llvm.sub"(%2, %25) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.br"(%26, %25)[^bb1] : (i64, i64) -> ()
  ^bb1(%27: i64, %28: i64):  // 2 preds: ^bb0, ^bb2
    %29 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %30 = "llvm.icmp"(%27, %29) <{predicate = 5 : i64}> : (i64, i64) -> i1
    "llvm.cond_br"(%30)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %31 = "llvm.getelementptr"(%24, %27) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %32 = "llvm.load"(%31) <{ordering = 0 : i64}> : (!llvm.ptr) -> i64
    %33 = "llvm.getelementptr"(%22, %27) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%32, %33) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    %34 = "llvm.getelementptr"(%23, %27) <{elem_type = i64, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    "llvm.store"(%28, %34) <{ordering = 0 : i64}> : (i64, !llvm.ptr) -> ()
    %35 = "llvm.mul"(%28, %32) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %36 = "llvm.sub"(%27, %25) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    "llvm.br"(%36, %35)[^bb1] : (i64, i64) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "memref_of_memref"}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %6 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %7 = "llvm.sub"(%5, %6) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %8 = "llvm.add"(%4, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %9 = "llvm.urem"(%8, %5) : (i64, i64) -> i64
    %10 = "llvm.sub"(%8, %9) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %11 = "llvm.call"(%5, %10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %12 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = "llvm.insertvalue"(%12, %11) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %14 = "llvm.insertvalue"(%13, %11) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %16 = "llvm.insertvalue"(%14, %15) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %17 = "llvm.insertvalue"(%16, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %18 = "llvm.insertvalue"(%17, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i32, i32)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "memref_of_memref_32"}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i32) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i32
    %5 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i32
    %6 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %7 = "llvm.sub"(%5, %6) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %8 = "llvm.add"(%4, %7) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %9 = "llvm.urem"(%8, %5) : (i32, i32) -> i32
    %10 = "llvm.sub"(%8, %9) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %11 = "llvm.call"(%5, %10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i32, i32) -> !llvm.ptr
    %12 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %13 = "llvm.insertvalue"(%12, %11) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %14 = "llvm.insertvalue"(%13, %11) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
    %16 = "llvm.insertvalue"(%14, %15) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %17 = "llvm.insertvalue"(%16, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %18 = "llvm.insertvalue"(%17, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    "func.return"() : () -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<index = 32 : i64>} : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "memref_of_memref_of_memref"}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %6 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %7 = "llvm.sub"(%5, %6) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %8 = "llvm.add"(%4, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %9 = "llvm.urem"(%8, %5) : (i64, i64) -> i64
    %10 = "llvm.sub"(%8, %9) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %11 = "llvm.call"(%5, %10) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %12 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = "llvm.insertvalue"(%12, %11) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %14 = "llvm.insertvalue"(%13, %11) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %16 = "llvm.insertvalue"(%14, %15) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %17 = "llvm.insertvalue"(%16, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %18 = "llvm.insertvalue"(%17, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "aligned_alloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "ranked_unranked"}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = !llvm.struct<(i64, ptr)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i64
    %6 = "llvm.call"(%5, %4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @aligned_alloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> !llvm.ptr
    %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %8 = "llvm.insertvalue"(%7, %6) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.insertvalue"(%8, %6) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %10 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.insertvalue"(%11, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = "llvm.insertvalue"(%12, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %14 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %15 = "llvm.alloca"(%14) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%13, %15) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> ()
    %16 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %17 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %18 = "llvm.insertvalue"(%17, %16) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %19 = "llvm.insertvalue"(%18, %15) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

