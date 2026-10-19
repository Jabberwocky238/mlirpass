module {
}

// -----
module {
  func.func @subview(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index) -> memref<?x?xf32, strided<[?, ?], offset: ?>> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<64x4xf32, strided<[4, 1]>> to !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %5 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %6 = llvm.insertvalue %3, %5[0] : !llvm.struct<(ptr, ptr, i32)> 
    %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<(ptr, ptr, i32)> 
    %8 = llvm.mlir.constant(0 : index) : i32
    %9 = llvm.mlir.constant(4 : index) : i32
    %10 = llvm.mul %1, %9 overflow<nsw> : i32
    %11 = builtin.unrealized_conversion_cast %10 : i32 to index
    %12 = builtin.unrealized_conversion_cast %11 : index to i32
    %13 = llvm.add %10, %0 : i32
    %14 = builtin.unrealized_conversion_cast %13 : i32 to index
    %15 = builtin.unrealized_conversion_cast %14 : index to i32
    %16 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %17 = llvm.insertvalue %3, %16[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %18 = llvm.insertvalue %4, %17[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %19 = llvm.insertvalue %15, %18[2] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %20 = llvm.insertvalue %1, %19[3, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %21 = llvm.insertvalue %12, %20[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %22 = llvm.insertvalue %0, %21[3, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %23 = llvm.insertvalue %0, %22[4, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %24 = builtin.unrealized_conversion_cast %23 : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> to memref<?x?xf32, strided<[?, ?], offset: ?>>
    return %24 : memref<?x?xf32, strided<[?, ?], offset: ?>>
  }
}

// -----
module {
  func.func @subview_non_zero_addrspace(%arg0: memref<64x4xf32, strided<[4, 1]>, 3>, %arg1: index, %arg2: index, %arg3: index) -> memref<?x?xf32, strided<[?, ?], offset: ?>, 3> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<64x4xf32, strided<[4, 1]>, 3> to !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)> 
    %5 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i32)>
    %6 = llvm.insertvalue %3, %5[0] : !llvm.struct<(ptr<3>, ptr<3>, i32)> 
    %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<(ptr<3>, ptr<3>, i32)> 
    %8 = llvm.mlir.constant(0 : index) : i32
    %9 = llvm.mlir.constant(4 : index) : i32
    %10 = llvm.mul %1, %9 overflow<nsw> : i32
    %11 = builtin.unrealized_conversion_cast %10 : i32 to index
    %12 = builtin.unrealized_conversion_cast %11 : index to i32
    %13 = llvm.add %10, %0 : i32
    %14 = builtin.unrealized_conversion_cast %13 : i32 to index
    %15 = builtin.unrealized_conversion_cast %14 : index to i32
    %16 = llvm.mlir.poison : !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)>
    %17 = llvm.insertvalue %3, %16[0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)> 
    %18 = llvm.insertvalue %4, %17[1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)> 
    %19 = llvm.insertvalue %15, %18[2] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)> 
    %20 = llvm.insertvalue %1, %19[3, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)> 
    %21 = llvm.insertvalue %12, %20[4, 0] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)> 
    %22 = llvm.insertvalue %0, %21[3, 1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)> 
    %23 = llvm.insertvalue %0, %22[4, 1] : !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)> 
    %24 = builtin.unrealized_conversion_cast %23 : !llvm.struct<(ptr<3>, ptr<3>, i32, array<2 x i32>, array<2 x i32>)> to memref<?x?xf32, strided<[?, ?], offset: ?>, 3>
    return %24 : memref<?x?xf32, strided<[?, ?], offset: ?>, 3>
  }
}

// -----
module {
  func.func @subview_const_size(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index) -> memref<4x2xf32, strided<[?, ?], offset: ?>> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<64x4xf32, strided<[4, 1]>> to !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %5 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %6 = llvm.insertvalue %3, %5[0] : !llvm.struct<(ptr, ptr, i32)> 
    %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<(ptr, ptr, i32)> 
    %8 = llvm.mlir.constant(0 : index) : i32
    %9 = llvm.mlir.constant(4 : index) : i32
    %10 = llvm.mul %1, %9 overflow<nsw> : i32
    %11 = builtin.unrealized_conversion_cast %10 : i32 to index
    %12 = builtin.unrealized_conversion_cast %11 : index to i32
    %13 = llvm.add %10, %0 : i32
    %14 = builtin.unrealized_conversion_cast %13 : i32 to index
    %15 = builtin.unrealized_conversion_cast %14 : index to i32
    %16 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %17 = llvm.insertvalue %3, %16[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %18 = llvm.insertvalue %4, %17[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %19 = llvm.insertvalue %15, %18[2] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %20 = llvm.insertvalue %9, %19[3, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %21 = llvm.insertvalue %12, %20[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %22 = llvm.mlir.constant(2 : index) : i32
    %23 = llvm.insertvalue %22, %21[3, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %24 = llvm.insertvalue %0, %23[4, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %25 = builtin.unrealized_conversion_cast %24 : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> to memref<4x2xf32, strided<[?, ?], offset: ?>>
    return %25 : memref<4x2xf32, strided<[?, ?], offset: ?>>
  }
}

// -----
module {
  func.func @subview_const_stride(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index) -> memref<?x?xf32, strided<[4, 2], offset: ?>> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<64x4xf32, strided<[4, 1]>> to !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %5 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %6 = llvm.insertvalue %3, %5[0] : !llvm.struct<(ptr, ptr, i32)> 
    %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<(ptr, ptr, i32)> 
    %8 = llvm.mlir.constant(0 : index) : i32
    %9 = llvm.mlir.constant(4 : index) : i32
    %10 = llvm.mul %1, %9 overflow<nsw> : i32
    %11 = llvm.add %10, %0 : i32
    %12 = builtin.unrealized_conversion_cast %11 : i32 to index
    %13 = builtin.unrealized_conversion_cast %12 : index to i32
    %14 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %15 = llvm.insertvalue %3, %14[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %16 = llvm.insertvalue %4, %15[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %17 = llvm.insertvalue %13, %16[2] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %18 = llvm.insertvalue %1, %17[3, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %19 = llvm.insertvalue %9, %18[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %20 = llvm.insertvalue %0, %19[3, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %21 = llvm.mlir.constant(2 : index) : i32
    %22 = llvm.insertvalue %21, %20[4, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %23 = builtin.unrealized_conversion_cast %22 : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> to memref<?x?xf32, strided<[4, 2], offset: ?>>
    return %23 : memref<?x?xf32, strided<[4, 2], offset: ?>>
  }
}

// -----
module {
  func.func @subview_const_stride_and_offset(%arg0: memref<64x8xf32, strided<[8, 1]>>) -> memref<62x3xf32, strided<[8, 1], offset: 2>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<64x8xf32, strided<[8, 1]>> to !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.mlir.constant(0 : index) : i32
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %8 = llvm.insertvalue %1, %7[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %9 = llvm.insertvalue %2, %8[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %10 = llvm.mlir.constant(2 : index) : i32
    %11 = llvm.insertvalue %10, %9[2] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %12 = llvm.mlir.constant(62 : index) : i32
    %13 = llvm.insertvalue %12, %11[3, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %14 = llvm.mlir.constant(8 : index) : i32
    %15 = llvm.insertvalue %14, %13[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %16 = llvm.mlir.constant(3 : index) : i32
    %17 = llvm.insertvalue %16, %15[3, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %18 = llvm.mlir.constant(1 : index) : i32
    %19 = llvm.insertvalue %18, %17[4, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %20 = builtin.unrealized_conversion_cast %19 : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> to memref<62x3xf32, strided<[8, 1], offset: 2>>
    return %20 : memref<62x3xf32, strided<[8, 1], offset: 2>>
  }
}

// -----
module {
  func.func @subview_mixed_static_dynamic(%arg0: memref<64x4xf32, strided<[4, 1]>>, %arg1: index, %arg2: index, %arg3: index) -> memref<62x?xf32, strided<[?, 1], offset: ?>> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg3 : index to i32
    %3 = builtin.unrealized_conversion_cast %arg0 : memref<64x4xf32, strided<[4, 1]>> to !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %6 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %7 = llvm.insertvalue %4, %6[0] : !llvm.struct<(ptr, ptr, i32)> 
    %8 = llvm.insertvalue %5, %7[1] : !llvm.struct<(ptr, ptr, i32)> 
    %9 = llvm.mlir.constant(0 : index) : i32
    %10 = llvm.mlir.constant(4 : index) : i32
    %11 = llvm.mul %1, %10 overflow<nsw> : i32
    %12 = builtin.unrealized_conversion_cast %11 : i32 to index
    %13 = builtin.unrealized_conversion_cast %12 : index to i32
    %14 = llvm.mul %0, %10 overflow<nsw> : i32
    %15 = llvm.mlir.constant(2 : index) : i32
    %16 = llvm.add %14, %15 : i32
    %17 = builtin.unrealized_conversion_cast %16 : i32 to index
    %18 = builtin.unrealized_conversion_cast %17 : index to i32
    %19 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %20 = llvm.insertvalue %4, %19[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %21 = llvm.insertvalue %5, %20[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %22 = llvm.insertvalue %18, %21[2] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %23 = llvm.mlir.constant(62 : index) : i32
    %24 = llvm.insertvalue %23, %22[3, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %25 = llvm.insertvalue %13, %24[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %26 = llvm.insertvalue %2, %25[3, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %27 = llvm.mlir.constant(1 : index) : i32
    %28 = llvm.insertvalue %27, %26[4, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %29 = builtin.unrealized_conversion_cast %28 : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> to memref<62x?xf32, strided<[?, 1], offset: ?>>
    return %29 : memref<62x?xf32, strided<[?, 1], offset: ?>>
  }
}

// -----
module {
  func.func @subview_leading_operands(%arg0: memref<5x3xf32>, %arg1: memref<5x?xf32>) -> memref<3x3xf32, strided<[3, 1], offset: 6>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<5x3xf32> to !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.mlir.constant(0 : index) : i32
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %8 = llvm.insertvalue %1, %7[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %9 = llvm.insertvalue %2, %8[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %10 = llvm.mlir.constant(6 : index) : i32
    %11 = llvm.insertvalue %10, %9[2] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %12 = llvm.mlir.constant(3 : index) : i32
    %13 = llvm.insertvalue %12, %11[3, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %14 = llvm.insertvalue %12, %13[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %15 = llvm.insertvalue %12, %14[3, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %16 = llvm.mlir.constant(1 : index) : i32
    %17 = llvm.insertvalue %16, %15[4, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %18 = builtin.unrealized_conversion_cast %17 : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> to memref<3x3xf32, strided<[3, 1], offset: 6>>
    return %18 : memref<3x3xf32, strided<[3, 1], offset: 6>>
  }
}

// -----
module {
  func.func @subview_leading_operands_dynamic(%arg0: memref<5x?xf32>) -> memref<3x?xf32, strided<[?, 1], offset: ?>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<5x?xf32> to !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %1 = llvm.extractvalue %0[3, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %3 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %4 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %5 = llvm.insertvalue %2, %4[0] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<(ptr, ptr, i32)> 
    %7 = llvm.mlir.constant(0 : index) : i32
    %8 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %9 = llvm.mlir.constant(2 : index) : i32
    %10 = llvm.mul %8, %9 overflow<nsw> : i32
    %11 = builtin.unrealized_conversion_cast %10 : i32 to index
    %12 = builtin.unrealized_conversion_cast %11 : index to i32
    %13 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %14 = llvm.insertvalue %2, %13[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %15 = llvm.insertvalue %3, %14[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %16 = llvm.insertvalue %12, %15[2] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %17 = llvm.mlir.constant(3 : index) : i32
    %18 = llvm.insertvalue %17, %16[3, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %19 = llvm.insertvalue %8, %18[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %20 = llvm.insertvalue %1, %19[3, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %21 = llvm.mlir.constant(1 : index) : i32
    %22 = llvm.insertvalue %21, %20[4, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %23 = builtin.unrealized_conversion_cast %22 : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> to memref<3x?xf32, strided<[?, 1], offset: ?>>
    return %23 : memref<3x?xf32, strided<[?, 1], offset: ?>>
  }
}

// -----
module {
  func.func @subview_rank_reducing_leading_operands(%arg0: memref<5x3xf32>) -> memref<3xf32, strided<[1], offset: 3>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<5x3xf32> to !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.mlir.constant(0 : index) : i32
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %8 = llvm.insertvalue %1, %7[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %9 = llvm.insertvalue %2, %8[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %10 = llvm.mlir.constant(3 : index) : i32
    %11 = llvm.insertvalue %10, %9[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %12 = llvm.insertvalue %10, %11[3, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %13 = llvm.mlir.constant(1 : index) : i32
    %14 = llvm.insertvalue %13, %12[4, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %15 = builtin.unrealized_conversion_cast %14 : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> to memref<3xf32, strided<[1], offset: 3>>
    return %15 : memref<3xf32, strided<[1], offset: 3>>
  }
}

// -----
module {
  func.func @subview_negative_stride(%arg0: memref<7xf32>) -> memref<7xf32, strided<[-1], offset: 6>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<7xf32> to !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.mlir.constant(0 : index) : i32
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %8 = llvm.insertvalue %1, %7[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %9 = llvm.insertvalue %2, %8[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %10 = llvm.mlir.constant(6 : index) : i32
    %11 = llvm.insertvalue %10, %9[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %12 = llvm.mlir.constant(7 : index) : i32
    %13 = llvm.insertvalue %12, %11[3, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %14 = llvm.mlir.constant(-1 : index) : i32
    %15 = llvm.insertvalue %14, %13[4, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %16 = builtin.unrealized_conversion_cast %15 : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> to memref<7xf32, strided<[-1], offset: 6>>
    return %16 : memref<7xf32, strided<[-1], offset: 6>>
  }
}

// -----
module {
  func.func @collapse_shape_static(%arg0: memref<1x3x4x1x5xf32>) -> memref<3x4x5xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<1x3x4x1x5xf32> to !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.mlir.constant(0 : index) : i32
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)>
    %8 = llvm.insertvalue %1, %7[0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %9 = llvm.insertvalue %2, %8[1] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %10 = llvm.insertvalue %6, %9[2] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %11 = llvm.mlir.constant(3 : index) : i32
    %12 = llvm.insertvalue %11, %10[3, 0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %13 = llvm.mlir.constant(20 : index) : i32
    %14 = llvm.insertvalue %13, %12[4, 0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %15 = llvm.mlir.constant(4 : index) : i32
    %16 = llvm.insertvalue %15, %14[3, 1] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %17 = llvm.mlir.constant(5 : index) : i32
    %18 = llvm.insertvalue %17, %16[4, 1] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %19 = llvm.insertvalue %17, %18[3, 2] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %20 = llvm.mlir.constant(1 : index) : i32
    %21 = llvm.insertvalue %20, %19[4, 2] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %22 = builtin.unrealized_conversion_cast %21 : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> to memref<3x4x5xf32>
    return %22 : memref<3x4x5xf32>
  }
}

// -----
module {
  func.func @collapse_shape_dynamic_with_non_identity_layout(%arg0: memref<4x?x?xf32, strided<[?, 4, 1], offset: ?>>) -> memref<4x?xf32, strided<[?, ?], offset: ?>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x?x?xf32, strided<[?, 4, 1], offset: ?>> to !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.mlir.constant(0 : index) : i32
    %7 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %8 = llvm.extractvalue %0[3, 1] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %9 = llvm.extractvalue %0[3, 2] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %10 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %11 = llvm.mul %8, %9 overflow<nsw> : i32
    %12 = builtin.unrealized_conversion_cast %11 : i32 to index
    %13 = builtin.unrealized_conversion_cast %12 : index to i32
    %14 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %15 = llvm.insertvalue %1, %14[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %16 = llvm.insertvalue %2, %15[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %17 = llvm.insertvalue %7, %16[2] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %18 = llvm.mlir.constant(4 : index) : i32
    %19 = llvm.insertvalue %18, %17[3, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %20 = llvm.insertvalue %10, %19[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %21 = llvm.insertvalue %13, %20[3, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %22 = llvm.mlir.constant(1 : index) : i32
    %23 = llvm.insertvalue %22, %21[4, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %24 = builtin.unrealized_conversion_cast %23 : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> to memref<4x?xf32, strided<[?, ?], offset: ?>>
    return %24 : memref<4x?xf32, strided<[?, ?], offset: ?>>
  }
}

// -----
module {
  func.func @expand_shape_static(%arg0: memref<3x4x5xf32>) -> memref<1x3x4x1x5xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<3x4x5xf32> to !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.mlir.constant(0 : index) : i32
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)>
    %8 = llvm.insertvalue %1, %7[0] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %9 = llvm.insertvalue %2, %8[1] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %10 = llvm.insertvalue %6, %9[2] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %11 = llvm.mlir.constant(1 : index) : i32
    %12 = llvm.insertvalue %11, %10[3, 0] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %13 = llvm.mlir.constant(60 : index) : i32
    %14 = llvm.insertvalue %13, %12[4, 0] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %15 = llvm.mlir.constant(3 : index) : i32
    %16 = llvm.insertvalue %15, %14[3, 1] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %17 = llvm.mlir.constant(20 : index) : i32
    %18 = llvm.insertvalue %17, %16[4, 1] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %19 = llvm.mlir.constant(4 : index) : i32
    %20 = llvm.insertvalue %19, %18[3, 2] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %21 = llvm.mlir.constant(5 : index) : i32
    %22 = llvm.insertvalue %21, %20[4, 2] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %23 = llvm.insertvalue %11, %22[3, 3] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %24 = llvm.insertvalue %21, %23[4, 3] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %25 = llvm.insertvalue %21, %24[3, 4] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %26 = llvm.insertvalue %11, %25[4, 4] : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> 
    %27 = builtin.unrealized_conversion_cast %26 : !llvm.struct<(ptr, ptr, i32, array<5 x i32>, array<5 x i32>)> to memref<1x3x4x1x5xf32>
    return %27 : memref<1x3x4x1x5xf32>
  }
}

// -----
module {
  func.func @collapse_shape_fold_zero_dim(%arg0: memref<1x1xf32>) -> memref<f32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<1x1xf32> to !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.mlir.constant(0 : index) : i32
    %7 = llvm.insertvalue %6, %5[2] : !llvm.struct<(ptr, ptr, i32)> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.struct<(ptr, ptr, i32)> to memref<f32>
    return %8 : memref<f32>
  }
}

// -----
module {
  func.func @expand_shape_zero_dim(%arg0: memref<f32>) -> memref<1x1xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<f32> to !llvm.struct<(ptr, ptr, i32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.mlir.constant(0 : index) : i32
    %7 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %8 = llvm.insertvalue %1, %7[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %9 = llvm.insertvalue %2, %8[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %10 = llvm.insertvalue %6, %9[2] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %11 = llvm.mlir.constant(1 : index) : i32
    %12 = llvm.insertvalue %11, %10[3, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %13 = llvm.insertvalue %11, %12[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %14 = llvm.insertvalue %11, %13[3, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %15 = llvm.insertvalue %11, %14[4, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %16 = builtin.unrealized_conversion_cast %15 : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> to memref<1x1xf32>
    return %16 : memref<1x1xf32>
  }
}

// -----
module {
  func.func @collapse_shape_dynamic(%arg0: memref<1x2x?xf32>) -> memref<1x?xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<1x2x?xf32> to !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.mlir.constant(0 : index) : i32
    %7 = llvm.extractvalue %0[3, 2] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %8 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %9 = llvm.mlir.constant(2 : index) : i32
    %10 = llvm.mul %7, %9 overflow<nsw> : i32
    %11 = builtin.unrealized_conversion_cast %10 : i32 to index
    %12 = builtin.unrealized_conversion_cast %11 : index to i32
    %13 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %14 = llvm.insertvalue %1, %13[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %15 = llvm.insertvalue %2, %14[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %16 = llvm.insertvalue %6, %15[2] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %17 = llvm.mlir.constant(1 : index) : i32
    %18 = llvm.insertvalue %17, %16[3, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %19 = llvm.insertvalue %8, %18[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %20 = llvm.insertvalue %12, %19[3, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %21 = llvm.insertvalue %17, %20[4, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %22 = builtin.unrealized_conversion_cast %21 : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> to memref<1x?xf32>
    return %22 : memref<1x?xf32>
  }
}

// -----
module {
  func.func @expand_shape_dynamic(%arg0: memref<1x?xf32>, %arg1: index) -> memref<1x2x?xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<1x?xf32> to !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.mlir.constant(0 : index) : i32
    %7 = llvm.extractvalue %0[3, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %8 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %9 = llvm.mlir.constant(2 : index) : i32
    %10 = llvm.mlir.constant(-1 : index) : i32
    %11 = llvm.icmp "slt" %7, %6 : i32
    %12 = llvm.sub %10, %7 : i32
    %13 = llvm.select %11, %12, %7 : i1, i32
    %14 = llvm.sdiv %13, %9 : i32
    %15 = llvm.sub %10, %14 : i32
    %16 = llvm.select %11, %15, %14 : i1, i32
    %17 = builtin.unrealized_conversion_cast %16 : i32 to index
    %18 = builtin.unrealized_conversion_cast %17 : index to i32
    %19 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)>
    %20 = llvm.insertvalue %1, %19[0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %21 = llvm.insertvalue %2, %20[1] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %22 = llvm.insertvalue %6, %21[2] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %23 = llvm.mlir.constant(1 : index) : i32
    %24 = llvm.insertvalue %23, %22[3, 0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %25 = llvm.insertvalue %8, %24[4, 0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %26 = llvm.insertvalue %9, %25[3, 1] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %27 = llvm.insertvalue %18, %26[4, 1] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %28 = llvm.insertvalue %18, %27[3, 2] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %29 = llvm.insertvalue %23, %28[4, 2] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %30 = builtin.unrealized_conversion_cast %29 : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> to memref<1x2x?xf32>
    return %30 : memref<1x2x?xf32>
  }
}

// -----
module {
  func.func @expand_shape_dynamic_with_non_identity_layout(%arg0: memref<1x?xf32, strided<[?, ?], offset: ?>>, %arg1: index) -> memref<1x2x?xf32, strided<[?, ?, ?], offset: ?>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<1x?xf32, strided<[?, ?], offset: ?>> to !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.mlir.constant(0 : index) : i32
    %7 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %8 = llvm.extractvalue %0[3, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %9 = llvm.extractvalue %0[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %10 = llvm.extractvalue %0[4, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %11 = llvm.mlir.constant(2 : index) : i32
    %12 = llvm.mlir.constant(-1 : index) : i32
    %13 = llvm.icmp "slt" %8, %6 : i32
    %14 = llvm.sub %12, %8 : i32
    %15 = llvm.select %13, %14, %8 : i1, i32
    %16 = llvm.sdiv %15, %11 : i32
    %17 = llvm.sub %12, %16 : i32
    %18 = llvm.select %13, %17, %16 : i1, i32
    %19 = builtin.unrealized_conversion_cast %18 : i32 to index
    %20 = builtin.unrealized_conversion_cast %19 : index to i32
    %21 = llvm.mul %18, %10 overflow<nsw> : i32
    %22 = builtin.unrealized_conversion_cast %21 : i32 to index
    %23 = builtin.unrealized_conversion_cast %22 : index to i32
    %24 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)>
    %25 = llvm.insertvalue %1, %24[0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %26 = llvm.insertvalue %2, %25[1] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %27 = llvm.insertvalue %7, %26[2] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %28 = llvm.mlir.constant(1 : index) : i32
    %29 = llvm.insertvalue %28, %27[3, 0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %30 = llvm.insertvalue %9, %29[4, 0] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %31 = llvm.insertvalue %11, %30[3, 1] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %32 = llvm.insertvalue %23, %31[4, 1] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %33 = llvm.insertvalue %20, %32[3, 2] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %34 = llvm.insertvalue %10, %33[4, 2] : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> 
    %35 = builtin.unrealized_conversion_cast %34 : !llvm.struct<(ptr, ptr, i32, array<3 x i32>, array<3 x i32>)> to memref<1x2x?xf32, strided<[?, ?, ?], offset: ?>>
    return %35 : memref<1x2x?xf32, strided<[?, ?, ?], offset: ?>>
  }
}

// -----
module {
  func.func @collapse_static_shape_with_non_identity_layout(%arg0: memref<1x1x8x8xf32, strided<[64, 64, 8, 1], offset: ?>>) -> memref<64xf32, strided<[1], offset: ?>> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<1x1x8x8xf32, strided<[64, 64, 8, 1], offset: ?>> to !llvm.struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)> 
    %3 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32)>
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(ptr, ptr, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(ptr, ptr, i32)> 
    %6 = llvm.mlir.constant(0 : index) : i32
    %7 = llvm.extractvalue %0[2] : !llvm.struct<(ptr, ptr, i32, array<4 x i32>, array<4 x i32>)> 
    %8 = llvm.mlir.poison : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)>
    %9 = llvm.insertvalue %1, %8[0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %10 = llvm.insertvalue %2, %9[1] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %11 = llvm.insertvalue %7, %10[2] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %12 = llvm.mlir.constant(64 : index) : i32
    %13 = llvm.insertvalue %12, %11[3, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %14 = llvm.mlir.constant(1 : index) : i32
    %15 = llvm.insertvalue %14, %13[4, 0] : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> 
    %16 = builtin.unrealized_conversion_cast %15 : !llvm.struct<(ptr, ptr, i32, array<1 x i32>, array<1 x i32>)> to memref<64xf32, strided<[1], offset: ?>>
    return %16 : memref<64xf32, strided<[1], offset: ?>>
  }
}

// -----
module {
  func.func @load_and_assume(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: index, %arg2: index) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i32
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i32
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?x?xf32, strided<[?, ?], offset: ?>> to !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %4 = llvm.extractvalue %2[2] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %5 = llvm.getelementptr %3[%4] : (!llvm.ptr, i32) -> !llvm.ptr, f32
    %6 = llvm.mlir.constant(true) : i1
    %7 = llvm.mlir.constant(16 : index) : i32
    llvm.intr.assume %6 ["align"(%5, %7 : !llvm.ptr, i32)] : i1
    %8 = llvm.extractvalue %2[4, 0] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %9 = llvm.mul %1, %8 overflow<nsw, nuw> : i32
    %10 = llvm.extractvalue %2[4, 1] : !llvm.struct<(ptr, ptr, i32, array<2 x i32>, array<2 x i32>)> 
    %11 = llvm.mul %0, %10 overflow<nsw, nuw> : i32
    %12 = llvm.add %9, %11 overflow<nsw, nuw> : i32
    %13 = llvm.getelementptr inbounds|nuw %5[%12] : (!llvm.ptr, i32) -> !llvm.ptr, f32
    %14 = llvm.load %13 : !llvm.ptr -> f32
    return %14 : f32
  }
}

