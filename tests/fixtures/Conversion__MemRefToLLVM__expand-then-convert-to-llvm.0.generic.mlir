"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x4xf32, strided<[4, 1]>>, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>, sym_name = "subview"}> ({
  ^bb0(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<64x4xf32, strided<[4, 1]>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.insertvalue"(%5, %3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %7 = "llvm.insertvalue"(%6, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %8 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %9 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %10 = "llvm.mul"(%1, %9) <{overflowFlags = 1 : i32}> : (i64, i64) -> i64
    %11 = "builtin.unrealized_conversion_cast"(%10) : (i64) -> index
    %12 = "builtin.unrealized_conversion_cast"(%11) : (index) -> i64
    %13 = "llvm.add"(%10, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %14 = "builtin.unrealized_conversion_cast"(%13) : (i64) -> index
    %15 = "builtin.unrealized_conversion_cast"(%14) : (index) -> i64
    %16 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "llvm.insertvalue"(%16, %3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %18 = "llvm.insertvalue"(%17, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "llvm.insertvalue"(%18, %15) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %20 = "llvm.insertvalue"(%19, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = "llvm.insertvalue"(%20, %12) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %22 = "llvm.insertvalue"(%21, %0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %23 = "llvm.insertvalue"(%22, %0) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %24 = "builtin.unrealized_conversion_cast"(%23) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"(%24) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x4xf32, strided<[4, 1]>, 3>, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>, 3>, sym_name = "subview_non_zero_addrspace"}> ({
  ^bb0(%arg0: memref<64x4xf32, strided<[4, 1]>, 3>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<64x4xf32, strided<[4, 1]>, 3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr<3>
    %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64)>
    %6 = "llvm.insertvalue"(%5, %3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64)>
    %7 = "llvm.insertvalue"(%6, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64)>
    %8 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %9 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %10 = "llvm.mul"(%1, %9) <{overflowFlags = 1 : i32}> : (i64, i64) -> i64
    %11 = "builtin.unrealized_conversion_cast"(%10) : (i64) -> index
    %12 = "builtin.unrealized_conversion_cast"(%11) : (index) -> i64
    %13 = "llvm.add"(%10, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %14 = "builtin.unrealized_conversion_cast"(%13) : (i64) -> index
    %15 = "builtin.unrealized_conversion_cast"(%14) : (index) -> i64
    %16 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "llvm.insertvalue"(%16, %3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %18 = "llvm.insertvalue"(%17, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr<3>) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "llvm.insertvalue"(%18, %15) <{position = array<i64: 2>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %20 = "llvm.insertvalue"(%19, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %21 = "llvm.insertvalue"(%20, %12) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %22 = "llvm.insertvalue"(%21, %0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %23 = "llvm.insertvalue"(%22, %0) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %24 = "builtin.unrealized_conversion_cast"(%23) : (!llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>) -> memref<?x?xf32, strided<[?, ?], offset: ?>, 3>
    "func.return"(%24) : (memref<?x?xf32, strided<[?, ?], offset: ?>, 3>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x4xf32, strided<[4, 1]>>, index, index, index) -> memref<4x2xf32, strided<[?, ?], offset: ?>>, sym_name = "subview_const_size"}> ({
  ^bb0(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<64x4xf32, strided<[4, 1]>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.insertvalue"(%5, %3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %7 = "llvm.insertvalue"(%6, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %8 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %9 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %10 = "llvm.mul"(%1, %9) <{overflowFlags = 1 : i32}> : (i64, i64) -> i64
    %11 = "builtin.unrealized_conversion_cast"(%10) : (i64) -> index
    %12 = "builtin.unrealized_conversion_cast"(%11) : (index) -> i64
    %13 = "llvm.add"(%10, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %14 = "builtin.unrealized_conversion_cast"(%13) : (i64) -> index
    %15 = "builtin.unrealized_conversion_cast"(%14) : (index) -> i64
    %16 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "llvm.insertvalue"(%16, %3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %18 = "llvm.insertvalue"(%17, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "llvm.insertvalue"(%18, %15) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %20 = "llvm.insertvalue"(%19, %9) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = "llvm.insertvalue"(%20, %12) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %22 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %23 = "llvm.insertvalue"(%21, %22) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %24 = "llvm.insertvalue"(%23, %0) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %25 = "builtin.unrealized_conversion_cast"(%24) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<4x2xf32, strided<[?, ?], offset: ?>>
    "func.return"(%25) : (memref<4x2xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x4xf32, strided<[4, 1]>>, index, index, index) -> memref<?x?xf32, strided<[4, 2], offset: ?>>, sym_name = "subview_const_stride"}> ({
  ^bb0(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<64x4xf32, strided<[4, 1]>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %5 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.insertvalue"(%5, %3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %7 = "llvm.insertvalue"(%6, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %8 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %9 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %10 = "llvm.mul"(%1, %9) <{overflowFlags = 1 : i32}> : (i64, i64) -> i64
    %11 = "llvm.add"(%10, %0) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %12 = "builtin.unrealized_conversion_cast"(%11) : (i64) -> index
    %13 = "builtin.unrealized_conversion_cast"(%12) : (index) -> i64
    %14 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.insertvalue"(%15, %4) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "llvm.insertvalue"(%16, %13) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %18 = "llvm.insertvalue"(%17, %1) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "llvm.insertvalue"(%18, %9) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %20 = "llvm.insertvalue"(%19, %0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %22 = "llvm.insertvalue"(%20, %21) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %23 = "builtin.unrealized_conversion_cast"(%22) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<?x?xf32, strided<[4, 2], offset: ?>>
    "func.return"(%23) : (memref<?x?xf32, strided<[4, 2], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x8xf32, strided<[8, 1]>>) -> memref<62x3xf32, strided<[8, 1], offset: 2>>, sym_name = "subview_const_stride_and_offset"}> ({
  ^bb0(%arg0: memref<64x8xf32, strided<[8, 1]>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<64x8xf32, strided<[8, 1]>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %8 = "llvm.insertvalue"(%7, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = "llvm.insertvalue"(%8, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %12 = "llvm.mlir.constant"() <{value = 62 : index}> : () -> i64
    %13 = "llvm.insertvalue"(%11, %12) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "llvm.mlir.constant"() <{value = 8 : index}> : () -> i64
    %15 = "llvm.insertvalue"(%13, %14) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %17 = "llvm.insertvalue"(%15, %16) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %18 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %19 = "llvm.insertvalue"(%17, %18) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %20 = "builtin.unrealized_conversion_cast"(%19) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<62x3xf32, strided<[8, 1], offset: 2>>
    "func.return"(%20) : (memref<62x3xf32, strided<[8, 1], offset: 2>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64x4xf32, strided<[4, 1]>>, index, index, index) -> memref<62x?xf32, strided<[?, 1], offset: ?>>, sym_name = "subview_mixed_static_dynamic"}> ({
  ^bb0(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg3) : (index) -> i64
    %3 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<64x4xf32, strided<[4, 1]>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %4 = "llvm.extractvalue"(%3) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %5 = "llvm.extractvalue"(%3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %6 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %7 = "llvm.insertvalue"(%6, %4) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %8 = "llvm.insertvalue"(%7, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %9 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %10 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %11 = "llvm.mul"(%1, %10) <{overflowFlags = 1 : i32}> : (i64, i64) -> i64
    %12 = "builtin.unrealized_conversion_cast"(%11) : (i64) -> index
    %13 = "builtin.unrealized_conversion_cast"(%12) : (index) -> i64
    %14 = "llvm.mul"(%0, %10) <{overflowFlags = 1 : i32}> : (i64, i64) -> i64
    %15 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %16 = "llvm.add"(%14, %15) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %17 = "builtin.unrealized_conversion_cast"(%16) : (i64) -> index
    %18 = "builtin.unrealized_conversion_cast"(%17) : (index) -> i64
    %19 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %20 = "llvm.insertvalue"(%19, %4) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = "llvm.insertvalue"(%20, %5) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %22 = "llvm.insertvalue"(%21, %18) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %23 = "llvm.mlir.constant"() <{value = 62 : index}> : () -> i64
    %24 = "llvm.insertvalue"(%22, %23) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %25 = "llvm.insertvalue"(%24, %13) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %26 = "llvm.insertvalue"(%25, %2) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %27 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %28 = "llvm.insertvalue"(%26, %27) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %29 = "builtin.unrealized_conversion_cast"(%28) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<62x?xf32, strided<[?, 1], offset: ?>>
    "func.return"(%29) : (memref<62x?xf32, strided<[?, 1], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5x3xf32>, memref<5x?xf32>) -> memref<3x3xf32, strided<[3, 1], offset: 6>>, sym_name = "subview_leading_operands"}> ({
  ^bb0(%arg0: memref<5x3xf32>, %arg1: memref<5x?xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<5x3xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %8 = "llvm.insertvalue"(%7, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = "llvm.insertvalue"(%8, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = "llvm.mlir.constant"() <{value = 6 : index}> : () -> i64
    %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %12 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %13 = "llvm.insertvalue"(%11, %12) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "llvm.insertvalue"(%13, %12) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %12) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %17 = "llvm.insertvalue"(%15, %16) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %18 = "builtin.unrealized_conversion_cast"(%17) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<3x3xf32, strided<[3, 1], offset: 6>>
    "func.return"(%18) : (memref<3x3xf32, strided<[3, 1], offset: 6>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5x?xf32>) -> memref<3x?xf32, strided<[?, 1], offset: ?>>, sym_name = "subview_leading_operands_dynamic"}> ({
  ^bb0(%arg0: memref<5x?xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<5x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %3 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.insertvalue"(%5, %3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %7 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %9 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %10 = "llvm.mul"(%8, %9) <{overflowFlags = 1 : i32}> : (i64, i64) -> i64
    %11 = "builtin.unrealized_conversion_cast"(%10) : (i64) -> index
    %12 = "builtin.unrealized_conversion_cast"(%11) : (index) -> i64
    %13 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "llvm.insertvalue"(%13, %2) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %3) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.insertvalue"(%15, %12) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %18 = "llvm.insertvalue"(%16, %17) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "llvm.insertvalue"(%18, %8) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %20 = "llvm.insertvalue"(%19, %1) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %22 = "llvm.insertvalue"(%20, %21) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %23 = "builtin.unrealized_conversion_cast"(%22) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<3x?xf32, strided<[?, 1], offset: ?>>
    "func.return"(%23) : (memref<3x?xf32, strided<[?, 1], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5x3xf32>) -> memref<3xf32, strided<[1], offset: 3>>, sym_name = "subview_rank_reducing_leading_operands"}> ({
  ^bb0(%arg0: memref<5x3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<5x3xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %8 = "llvm.insertvalue"(%7, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.insertvalue"(%8, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %10 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.insertvalue"(%11, %10) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %13 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %14 = "llvm.insertvalue"(%12, %13) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %15 = "builtin.unrealized_conversion_cast"(%14) : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> memref<3xf32, strided<[1], offset: 3>>
    "func.return"(%15) : (memref<3xf32, strided<[1], offset: 3>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<7xf32>) -> memref<7xf32, strided<[-1], offset: 6>>, sym_name = "subview_negative_stride"}> ({
  ^bb0(%arg0: memref<7xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<7xf32>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %8 = "llvm.insertvalue"(%7, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.insertvalue"(%8, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %10 = "llvm.mlir.constant"() <{value = 6 : index}> : () -> i64
    %11 = "llvm.insertvalue"(%9, %10) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.mlir.constant"() <{value = 7 : index}> : () -> i64
    %13 = "llvm.insertvalue"(%11, %12) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %14 = "llvm.mlir.constant"() <{value = -1 : index}> : () -> i64
    %15 = "llvm.insertvalue"(%13, %14) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %16 = "builtin.unrealized_conversion_cast"(%15) : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> memref<7xf32, strided<[-1], offset: 6>>
    "func.return"(%16) : (memref<7xf32, strided<[-1], offset: 6>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x3x4x1x5xf32>) -> memref<3x4x5xf32>, sym_name = "collapse_shape_static"}> ({
  ^bb0(%arg0: memref<1x3x4x1x5xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<1x3x4x1x5xf32>) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %8 = "llvm.insertvalue"(%7, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %9 = "llvm.insertvalue"(%8, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %10 = "llvm.insertvalue"(%9, %6) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %11 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %12 = "llvm.insertvalue"(%10, %11) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %13 = "llvm.mlir.constant"() <{value = 20 : index}> : () -> i64
    %14 = "llvm.insertvalue"(%12, %13) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %15 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %16 = "llvm.insertvalue"(%14, %15) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %17 = "llvm.mlir.constant"() <{value = 5 : index}> : () -> i64
    %18 = "llvm.insertvalue"(%16, %17) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %19 = "llvm.insertvalue"(%18, %17) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %20 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %21 = "llvm.insertvalue"(%19, %20) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %22 = "builtin.unrealized_conversion_cast"(%21) : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> memref<3x4x5xf32>
    "func.return"(%22) : (memref<3x4x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x?x?xf32, strided<[?, 4, 1], offset: ?>>) -> memref<4x?xf32, strided<[?, ?], offset: ?>>, sym_name = "collapse_shape_dynamic_with_non_identity_layout"}> ({
  ^bb0(%arg0: memref<4x?x?xf32, strided<[?, 4, 1], offset: ?>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4x?x?xf32, strided<[?, 4, 1], offset: ?>>) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %11 = "llvm.mul"(%8, %9) <{overflowFlags = 1 : i32}> : (i64, i64) -> i64
    %12 = "builtin.unrealized_conversion_cast"(%11) : (i64) -> index
    %13 = "builtin.unrealized_conversion_cast"(%12) : (index) -> i64
    %14 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.insertvalue"(%15, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "llvm.insertvalue"(%16, %7) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %18 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %19 = "llvm.insertvalue"(%17, %18) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %20 = "llvm.insertvalue"(%19, %10) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = "llvm.insertvalue"(%20, %13) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %22 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %23 = "llvm.insertvalue"(%21, %22) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %24 = "builtin.unrealized_conversion_cast"(%23) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<4x?xf32, strided<[?, ?], offset: ?>>
    "func.return"(%24) : (memref<4x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<3x4x5xf32>) -> memref<1x3x4x1x5xf32>, sym_name = "expand_shape_static"}> ({
  ^bb0(%arg0: memref<3x4x5xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<3x4x5xf32>) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %8 = "llvm.insertvalue"(%7, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %9 = "llvm.insertvalue"(%8, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %10 = "llvm.insertvalue"(%9, %6) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %11 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %12 = "llvm.insertvalue"(%10, %11) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %13 = "llvm.mlir.constant"() <{value = 60 : index}> : () -> i64
    %14 = "llvm.insertvalue"(%12, %13) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %15 = "llvm.mlir.constant"() <{value = 3 : index}> : () -> i64
    %16 = "llvm.insertvalue"(%14, %15) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %17 = "llvm.mlir.constant"() <{value = 20 : index}> : () -> i64
    %18 = "llvm.insertvalue"(%16, %17) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %19 = "llvm.mlir.constant"() <{value = 4 : index}> : () -> i64
    %20 = "llvm.insertvalue"(%18, %19) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %21 = "llvm.mlir.constant"() <{value = 5 : index}> : () -> i64
    %22 = "llvm.insertvalue"(%20, %21) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %23 = "llvm.insertvalue"(%22, %11) <{position = array<i64: 3, 3>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %24 = "llvm.insertvalue"(%23, %21) <{position = array<i64: 4, 3>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %25 = "llvm.insertvalue"(%24, %21) <{position = array<i64: 3, 4>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %26 = "llvm.insertvalue"(%25, %11) <{position = array<i64: 4, 4>}> : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>
    %27 = "builtin.unrealized_conversion_cast"(%26) : (!llvm.struct<(ptr, ptr, i64, array<5 x i64>, array<5 x i64>)>) -> memref<1x3x4x1x5xf32>
    "func.return"(%27) : (memref<1x3x4x1x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1xf32>) -> memref<f32>, sym_name = "collapse_shape_fold_zero_dim"}> ({
  ^bb0(%arg0: memref<1x1xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<1x1xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.insertvalue"(%5, %6) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64)>, i64) -> !llvm.struct<(ptr, ptr, i64)>
    %8 = "builtin.unrealized_conversion_cast"(%7) : (!llvm.struct<(ptr, ptr, i64)>) -> memref<f32>
    "func.return"(%8) : (memref<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> memref<1x1xf32>, sym_name = "expand_shape_zero_dim"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<f32>) -> !llvm.struct<(ptr, ptr, i64)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %8 = "llvm.insertvalue"(%7, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %9 = "llvm.insertvalue"(%8, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %10 = "llvm.insertvalue"(%9, %6) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %11 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %12 = "llvm.insertvalue"(%10, %11) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %13 = "llvm.insertvalue"(%12, %11) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "llvm.insertvalue"(%13, %11) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %11) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "builtin.unrealized_conversion_cast"(%15) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<1x1xf32>
    "func.return"(%16) : (memref<1x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x2x?xf32>) -> memref<1x?xf32>, sym_name = "collapse_shape_dynamic"}> ({
  ^bb0(%arg0: memref<1x2x?xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<1x2x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> i64
    %9 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %10 = "llvm.mul"(%7, %9) <{overflowFlags = 1 : i32}> : (i64, i64) -> i64
    %11 = "builtin.unrealized_conversion_cast"(%10) : (i64) -> index
    %12 = "builtin.unrealized_conversion_cast"(%11) : (index) -> i64
    %13 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %14 = "llvm.insertvalue"(%13, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %15 = "llvm.insertvalue"(%14, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %16 = "llvm.insertvalue"(%15, %6) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %17 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %18 = "llvm.insertvalue"(%16, %17) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %19 = "llvm.insertvalue"(%18, %8) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %20 = "llvm.insertvalue"(%19, %12) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %21 = "llvm.insertvalue"(%20, %17) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %22 = "builtin.unrealized_conversion_cast"(%21) : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> memref<1x?xf32>
    "func.return"(%22) : (memref<1x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x?xf32>, index) -> memref<1x2x?xf32>, sym_name = "expand_shape_dynamic"}> ({
  ^bb0(%arg0: memref<1x?xf32>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<1x?xf32>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %9 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %10 = "llvm.mlir.constant"() <{value = -1 : index}> : () -> i64
    %11 = "llvm.icmp"(%7, %6) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %12 = "llvm.sub"(%10, %7) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %13 = "llvm.select"(%11, %12, %7) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %14 = "llvm.sdiv"(%13, %9) : (i64, i64) -> i64
    %15 = "llvm.sub"(%10, %14) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %16 = "llvm.select"(%11, %15, %14) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %17 = "builtin.unrealized_conversion_cast"(%16) : (i64) -> index
    %18 = "builtin.unrealized_conversion_cast"(%17) : (index) -> i64
    %19 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %20 = "llvm.insertvalue"(%19, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %21 = "llvm.insertvalue"(%20, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %22 = "llvm.insertvalue"(%21, %6) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %23 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %24 = "llvm.insertvalue"(%22, %23) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %25 = "llvm.insertvalue"(%24, %8) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %26 = "llvm.insertvalue"(%25, %9) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %27 = "llvm.insertvalue"(%26, %18) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %28 = "llvm.insertvalue"(%27, %18) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %29 = "llvm.insertvalue"(%28, %23) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %30 = "builtin.unrealized_conversion_cast"(%29) : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> memref<1x2x?xf32>
    "func.return"(%30) : (memref<1x2x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x?xf32, strided<[?, ?], offset: ?>>, index) -> memref<1x2x?xf32, strided<[?, ?, ?], offset: ?>>, sym_name = "expand_shape_dynamic_with_non_identity_layout"}> ({
  ^bb0(%arg0: memref<1x?xf32, strided<[?, ?], offset: ?>>, %arg1: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<1x?xf32, strided<[?, ?], offset: ?>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %9 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %11 = "llvm.mlir.constant"() <{value = 2 : index}> : () -> i64
    %12 = "llvm.mlir.constant"() <{value = -1 : index}> : () -> i64
    %13 = "llvm.icmp"(%8, %6) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %14 = "llvm.sub"(%12, %8) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %15 = "llvm.select"(%13, %14, %8) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %16 = "llvm.sdiv"(%15, %11) : (i64, i64) -> i64
    %17 = "llvm.sub"(%12, %16) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %18 = "llvm.select"(%13, %17, %16) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %19 = "builtin.unrealized_conversion_cast"(%18) : (i64) -> index
    %20 = "builtin.unrealized_conversion_cast"(%19) : (index) -> i64
    %21 = "llvm.mul"(%18, %10) <{overflowFlags = 1 : i32}> : (i64, i64) -> i64
    %22 = "builtin.unrealized_conversion_cast"(%21) : (i64) -> index
    %23 = "builtin.unrealized_conversion_cast"(%22) : (index) -> i64
    %24 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %25 = "llvm.insertvalue"(%24, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %26 = "llvm.insertvalue"(%25, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %27 = "llvm.insertvalue"(%26, %7) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %28 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %29 = "llvm.insertvalue"(%27, %28) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %30 = "llvm.insertvalue"(%29, %9) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %31 = "llvm.insertvalue"(%30, %11) <{position = array<i64: 3, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %32 = "llvm.insertvalue"(%31, %23) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %33 = "llvm.insertvalue"(%32, %20) <{position = array<i64: 3, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %34 = "llvm.insertvalue"(%33, %10) <{position = array<i64: 4, 2>}> : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>
    %35 = "builtin.unrealized_conversion_cast"(%34) : (!llvm.struct<(ptr, ptr, i64, array<3 x i64>, array<3 x i64>)>) -> memref<1x2x?xf32, strided<[?, ?, ?], offset: ?>>
    "func.return"(%35) : (memref<1x2x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1x1x8x8xf32, strided<[64, 64, 8, 1], offset: ?>>) -> memref<64xf32, strided<[1], offset: ?>>, sym_name = "collapse_static_shape_with_non_identity_layout"}> ({
  ^bb0(%arg0: memref<1x1x8x8xf32, strided<[64, 64, 8, 1], offset: ?>>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<1x1x8x8xf32, strided<[64, 64, 8, 1], offset: ?>>) -> !llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>) -> !llvm.ptr
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>) -> !llvm.ptr
    %3 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64)>
    %4 = "llvm.insertvalue"(%3, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %5 = "llvm.insertvalue"(%4, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64)>
    %6 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<4 x i64>, array<4 x i64>)>) -> i64
    %8 = "llvm.mlir.poison"() : () -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %9 = "llvm.insertvalue"(%8, %1) <{position = array<i64: 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %10 = "llvm.insertvalue"(%9, %2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, !llvm.ptr) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %11 = "llvm.insertvalue"(%10, %7) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %12 = "llvm.mlir.constant"() <{value = 64 : index}> : () -> i64
    %13 = "llvm.insertvalue"(%11, %12) <{position = array<i64: 3, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %14 = "llvm.mlir.constant"() <{value = 1 : index}> : () -> i64
    %15 = "llvm.insertvalue"(%13, %14) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>, i64) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %16 = "builtin.unrealized_conversion_cast"(%15) : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> memref<64xf32, strided<[1], offset: ?>>
    "func.return"(%16) : (memref<64xf32, strided<[1], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> f32, sym_name = "load_and_assume"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> i64
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> i64
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = "llvm.extractvalue"(%2) <{position = array<i64: 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> !llvm.ptr
    %4 = "llvm.extractvalue"(%2) <{position = array<i64: 2>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %5 = "llvm.getelementptr"(%3, %4) <{elem_type = f32, noWrapFlags = 0 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %6 = "llvm.mlir.constant"() <{value = true}> : () -> i1
    %7 = "llvm.mlir.constant"() <{value = 16 : index}> : () -> i64
    "llvm.intr.assume"(%6, %5, %7) <{op_bundle_sizes = array<i32: 2>, op_bundle_tags = ["align"]}> : (i1, !llvm.ptr, i64) -> ()
    %8 = "llvm.extractvalue"(%2) <{position = array<i64: 4, 0>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %9 = "llvm.mul"(%1, %8) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %10 = "llvm.extractvalue"(%2) <{position = array<i64: 4, 1>}> : (!llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>) -> i64
    %11 = "llvm.mul"(%0, %10) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %12 = "llvm.add"(%9, %11) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %13 = "llvm.getelementptr"(%5, %12) <{elem_type = f32, noWrapFlags = 7 : i32, rawConstantIndices = array<i32: -2147483648>}> : (!llvm.ptr, i64) -> !llvm.ptr
    %14 = "llvm.load"(%13) <{ordering = 0 : i64}> : (!llvm.ptr) -> f32
    "func.return"(%14) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

