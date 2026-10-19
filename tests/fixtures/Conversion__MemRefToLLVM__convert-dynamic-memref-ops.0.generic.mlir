"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
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
    %9 = "llvm.call"(%8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %10 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %11 = "llvm.insertvalue"(%10, %9) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %12 = "llvm.insertvalue"(%11, %9) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %13 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %14 = "llvm.insertvalue"(%12, %13) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %15 = "llvm.insertvalue"(%14, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %16 = "llvm.insertvalue"(%15, %2) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %17 = "llvm.insertvalue"(%16, %0) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %18 = "llvm.insertvalue"(%17, %4) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %19 = "llvm.insertvalue"(%18, %0) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %20 = "llvm.insertvalue"(%19, %3) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %21 = "builtin.unrealized_conversion_cast"(%20) : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> memref<?x42x?xf32>
    "func.return"(%21) : (memref<?x42x?xf32>) -> ()
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
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
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
    %7 = "llvm.call"(%6) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %8 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = "llvm.insertvalue"(%8, %7) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = "llvm.insertvalue"(%9, %7) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %11 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %12 = "llvm.insertvalue"(%10, %11) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %13 = "llvm.insertvalue"(%12, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "llvm.insertvalue"(%13, %0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.insertvalue"(%15, %2) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "builtin.unrealized_conversion_cast"(%16) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<?x?xf32>
    "func.return"(%17) : (memref<?x?xf32>) -> ()
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
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
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
    %9 = "llvm.add"(%7, %8) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %10 = "llvm.call"(%9) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %11 = "llvm.ptrtoint"(%10) : (!llvm.ptr) -> i64
    %12 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %13 = "llvm.sub"(%8, %12) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %14 = "llvm.add"(%11, %13) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %15 = "llvm.urem"(%14, %8) : (i64, i64) -> i64
    %16 = "llvm.sub"(%14, %15) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %17 = "llvm.inttoptr"(%16) : (i64) -> !llvm.ptr
    %18 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "llvm.insertvalue"(%18, %10) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %20 = "llvm.insertvalue"(%19, %17) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %22 = "llvm.insertvalue"(%20, %21) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %23 = "llvm.insertvalue"(%22, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %24 = "llvm.insertvalue"(%23, %2) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %25 = "llvm.insertvalue"(%24, %2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %26 = "llvm.insertvalue"(%25, %3) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %27 = "builtin.unrealized_conversion_cast"(%26) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<32x18xf32>
    %28 = "llvm.mlir.constant"() <{value = 4096 : index}> : () -> i64
    %29 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %30 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %31 = "llvm.getelementptr"(%30, %28) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %32 = "llvm.ptrtoint"(%31) : (!llvm.ptr) -> i64
    %33 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %34 = "llvm.add"(%32, %33) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %35 = "llvm.call"(%34) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %36 = "llvm.ptrtoint"(%35) : (!llvm.ptr) -> i64
    %37 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %38 = "llvm.sub"(%33, %37) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %39 = "llvm.add"(%36, %38) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %40 = "llvm.urem"(%39, %33) : (i64, i64) -> i64
    %41 = "llvm.sub"(%39, %40) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %42 = "llvm.inttoptr"(%41) : (i64) -> !llvm.ptr
    %43 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %44 = "llvm.insertvalue"(%43, %35) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %45 = "llvm.insertvalue"(%44, %42) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %46 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %47 = "llvm.insertvalue"(%45, %46) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %48 = "llvm.insertvalue"(%47, %28) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %49 = "llvm.insertvalue"(%48, %29) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %50 = "llvm.mlir.constant"() <{value = 4096 : index}> : () -> i64
    %51 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %52 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %53 = "llvm.getelementptr"(%52, %50) <{elem_type = vector<8xf32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %54 = "llvm.ptrtoint"(%53) : (!llvm.ptr) -> i64
    %55 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %56 = "llvm.getelementptr"(%55) <{elem_type = vector<8xf32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %57 = "llvm.ptrtoint"(%56) : (!llvm.ptr) -> i64
    %58 = "llvm.add"(%54, %57) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %59 = "llvm.call"(%58) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %60 = "llvm.ptrtoint"(%59) : (!llvm.ptr) -> i64
    %61 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %62 = "llvm.sub"(%57, %61) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %63 = "llvm.add"(%60, %62) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %64 = "llvm.urem"(%63, %57) : (i64, i64) -> i64
    %65 = "llvm.sub"(%63, %64) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %66 = "llvm.inttoptr"(%65) : (i64) -> !llvm.ptr
    %67 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %68 = "llvm.insertvalue"(%67, %59) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %69 = "llvm.insertvalue"(%68, %66) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %70 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %71 = "llvm.insertvalue"(%69, %70) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %72 = "llvm.insertvalue"(%71, %50) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %73 = "llvm.insertvalue"(%72, %51) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %74 = "llvm.mlir.constant"() <{value = 4096 : index}> : () -> i64
    %75 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %76 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %77 = "llvm.getelementptr"(%76, %74) <{elem_type = vector<2xf32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %78 = "llvm.ptrtoint"(%77) : (!llvm.ptr) -> i64
    %79 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %80 = "llvm.getelementptr"(%79) <{elem_type = vector<2xf32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %81 = "llvm.ptrtoint"(%80) : (!llvm.ptr) -> i64
    %82 = "llvm.add"(%78, %81) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %83 = "llvm.call"(%82) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %84 = "llvm.ptrtoint"(%83) : (!llvm.ptr) -> i64
    %85 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %86 = "llvm.sub"(%81, %85) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %87 = "llvm.add"(%84, %86) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %88 = "llvm.urem"(%87, %81) : (i64, i64) -> i64
    %89 = "llvm.sub"(%87, %88) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %90 = "llvm.inttoptr"(%89) : (i64) -> !llvm.ptr
    %91 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %92 = "llvm.insertvalue"(%91, %83) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %93 = "llvm.insertvalue"(%92, %90) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %94 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %95 = "llvm.insertvalue"(%93, %94) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %96 = "llvm.insertvalue"(%95, %74) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %97 = "llvm.insertvalue"(%96, %75) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %98 = "llvm.mlir.constant"() <{value = 1024 : index}> : () -> i64
    %99 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %100 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %101 = "llvm.getelementptr"(%100, %98) <{elem_type = vector<4xf32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %102 = "llvm.ptrtoint"(%101) : (!llvm.ptr) -> i64
    %103 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %104 = "llvm.add"(%102, %103) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %105 = "llvm.call"(%104) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %106 = "llvm.ptrtoint"(%105) : (!llvm.ptr) -> i64
    %107 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %108 = "llvm.sub"(%103, %107) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %109 = "llvm.add"(%106, %108) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %110 = "llvm.urem"(%109, %103) : (i64, i64) -> i64
    %111 = "llvm.sub"(%109, %110) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %112 = "llvm.inttoptr"(%111) : (i64) -> !llvm.ptr
    %113 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %114 = "llvm.insertvalue"(%113, %105) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %115 = "llvm.insertvalue"(%114, %112) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %116 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %117 = "llvm.insertvalue"(%115, %116) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %118 = "llvm.insertvalue"(%117, %98) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %119 = "llvm.insertvalue"(%118, %99) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %120 = "llvm.mlir.constant"() <{value = 100 : index}> : () -> i64
    %121 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %122 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %123 = "llvm.getelementptr"(%122, %120) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %124 = "llvm.ptrtoint"(%123) : (!llvm.ptr) -> i64
    %125 = "llvm.mlir.constant"() <{value = 32 : index}> : () -> i64
    %126 = "llvm.add"(%124, %125) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %127 = "llvm.call"(%126) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %128 = "llvm.ptrtoint"(%127) : (!llvm.ptr) -> i64
    %129 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %130 = "llvm.sub"(%125, %129) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %131 = "llvm.add"(%128, %130) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %132 = "llvm.urem"(%131, %125) : (i64, i64) -> i64
    %133 = "llvm.sub"(%131, %132) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %134 = "llvm.inttoptr"(%133) : (i64) -> !llvm.ptr
    %135 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %136 = "llvm.insertvalue"(%135, %127) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %137 = "llvm.insertvalue"(%136, %134) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %138 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %139 = "llvm.insertvalue"(%137, %138) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %140 = "llvm.insertvalue"(%139, %120) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %141 = "llvm.insertvalue"(%140, %121) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %142 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %143 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %144 = "llvm.getelementptr"(%143, %0) <{elem_type = vector<18xf32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %145 = "llvm.ptrtoint"(%144) : (!llvm.ptr) -> i64
    %146 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %147 = "llvm.getelementptr"(%146) <{elem_type = vector<18xf32>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %148 = "llvm.ptrtoint"(%147) : (!llvm.ptr) -> i64
    %149 = "llvm.add"(%145, %148) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %150 = "llvm.call"(%149) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %151 = "llvm.ptrtoint"(%150) : (!llvm.ptr) -> i64
    %152 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %153 = "llvm.sub"(%148, %152) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %154 = "llvm.add"(%151, %153) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %155 = "llvm.urem"(%154, %148) : (i64, i64) -> i64
    %156 = "llvm.sub"(%154, %155) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %157 = "llvm.inttoptr"(%156) : (i64) -> !llvm.ptr
    %158 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %159 = "llvm.insertvalue"(%158, %150) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %160 = "llvm.insertvalue"(%159, %157) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %161 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %162 = "llvm.insertvalue"(%160, %161) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %163 = "llvm.insertvalue"(%162, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %164 = "llvm.insertvalue"(%163, %142) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    "func.return"(%27) : (memref<32x18xf32>) -> ()
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
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "memref_of_memref"}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %6 = "llvm.getelementptr"(%5) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %7 = "llvm.ptrtoint"(%6) : (!llvm.ptr) -> i64
    %8 = "llvm.add"(%4, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %9 = "llvm.call"(%8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %10 = "llvm.ptrtoint"(%9) : (!llvm.ptr) -> i64
    %11 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %12 = "llvm.sub"(%7, %11) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %13 = "llvm.add"(%10, %12) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %14 = "llvm.urem"(%13, %7) : (i64, i64) -> i64
    %15 = "llvm.sub"(%13, %14) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %16 = "llvm.inttoptr"(%15) : (i64) -> !llvm.ptr
    %17 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %18 = "llvm.insertvalue"(%17, %9) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %19 = "llvm.insertvalue"(%18, %16) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %20 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %21 = "llvm.insertvalue"(%19, %20) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %22 = "llvm.insertvalue"(%21, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %23 = "llvm.insertvalue"(%22, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i32)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "memref_of_memref_32"}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i32) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i32
    %5 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %6 = "llvm.getelementptr"(%5) <{elem_type = !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %7 = "llvm.ptrtoint"(%6) : (!llvm.ptr) -> i32
    %8 = "llvm.add"(%4, %7) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %9 = "llvm.call"(%8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i32) -> !llvm.ptr
    %10 = "llvm.ptrtoint"(%9) : (!llvm.ptr) -> i32
    %11 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i32
    %12 = "llvm.sub"(%7, %11) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %13 = "llvm.add"(%10, %12) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %14 = "llvm.urem"(%13, %7) : (i32, i32) -> i32
    %15 = "llvm.sub"(%13, %14) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %16 = "llvm.inttoptr"(%15) : (i32) -> !llvm.ptr
    %17 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %18 = "llvm.insertvalue"(%17, %9) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %19 = "llvm.insertvalue"(%18, %16) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %20 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i32
    %21 = "llvm.insertvalue"(%19, %20) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %22 = "llvm.insertvalue"(%21, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %23 = "llvm.insertvalue"(%22, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>, i32) -> !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    "func.return"() : () -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<index = 32 : i64>} : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "memref_of_memref_of_memref"}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %6 = "llvm.getelementptr"(%5) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %7 = "llvm.ptrtoint"(%6) : (!llvm.ptr) -> i64
    %8 = "llvm.add"(%4, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %9 = "llvm.call"(%8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %10 = "llvm.ptrtoint"(%9) : (!llvm.ptr) -> i64
    %11 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %12 = "llvm.sub"(%7, %11) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %13 = "llvm.add"(%10, %12) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %14 = "llvm.urem"(%13, %7) : (i64, i64) -> i64
    %15 = "llvm.sub"(%13, %14) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %16 = "llvm.inttoptr"(%15) : (i64) -> !llvm.ptr
    %17 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %18 = "llvm.insertvalue"(%17, %9) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %19 = "llvm.insertvalue"(%18, %16) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %20 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %21 = "llvm.insertvalue"(%19, %20) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %22 = "llvm.insertvalue"(%21, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %23 = "llvm.insertvalue"(%22, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<ptr (i64)>, linkage = #llvm.linkage<external>, sym_name = "malloc", visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "ranked_unranked"}> ({
    %0 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %1 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %2 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %3 = "llvm.getelementptr"(%2, %0) <{elem_type = !llvm.struct<(i64, ptr)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %4 = "llvm.ptrtoint"(%3) : (!llvm.ptr) -> i64
    %5 = "llvm.mlir.zero"() : () -> !llvm.ptr
    %6 = "llvm.getelementptr"(%5) <{elem_type = !llvm.struct<(i64, ptr)>, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: 1>}> : (!llvm.ptr) -> !llvm.ptr
    %7 = "llvm.ptrtoint"(%6) : (!llvm.ptr) -> i64
    %8 = "llvm.add"(%4, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %9 = "llvm.call"(%8) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @malloc, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 1, 0>}> : (i64) -> !llvm.ptr
    %10 = "llvm.ptrtoint"(%9) : (!llvm.ptr) -> i64
    %11 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %12 = "llvm.sub"(%7, %11) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %13 = "llvm.add"(%10, %12) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %14 = "llvm.urem"(%13, %7) : (i64, i64) -> i64
    %15 = "llvm.sub"(%13, %14) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %16 = "llvm.inttoptr"(%15) : (i64) -> !llvm.ptr
    %17 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %18 = "llvm.insertvalue"(%17, %9) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %19 = "llvm.insertvalue"(%18, %16) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %20 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %21 = "llvm.insertvalue"(%19, %20) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %22 = "llvm.insertvalue"(%21, %0) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %23 = "llvm.insertvalue"(%22, %1) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %24 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %25 = "llvm.alloca"(%24) <{elem_type = !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>}> : (i64) -> !llvm.ptr
    "llvm.store"(%23, %25) <{ordering = 0 : i64}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> ()
    %26 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %27 = "llvm.mlir.poison"() : () -> !llvm.struct<(i64, ptr)>
    %28 = "llvm.insertvalue"(%27, %26) <{position = array<i64: 0>}> : (!llvm.struct<(i64, ptr)>, i64) -> !llvm.struct<(i64, ptr)>
    %29 = "llvm.insertvalue"(%28, %25) <{position = array<i64: 1>}> : (!llvm.struct<(i64, ptr)>, !llvm.ptr) -> !llvm.struct<(i64, ptr)>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

