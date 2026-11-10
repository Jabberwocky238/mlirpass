module {
  func.func @transfer_read_write_1d(%arg0: memref<?xf32>, %arg1: index) -> vector<17xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<17xf32>
    %c2147483647 = arith.constant 2147483647 : index
    %cst_0 = arith.constant dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    %2 = arith.subi %dim, %arg1 : index
    %3 = arith.minsi %2, %c2147483647 : index
    %4 = arith.index_cast %3 : index to i32
    %5 = llvm.mlir.poison : vector<17xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<17xi32>
    %8 = llvm.shufflevector %7, %5 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %9 = arith.cmpi sgt, %8, %cst_0 : vector<17xi32>
    %10 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.getelementptr %10[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %12 = llvm.intr.masked.load %11, %9, %cst {alignment = 4 : i32} : (!llvm.ptr, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    %dim_1 = memref.dim %arg0, %c0 : memref<?xf32>
    %13 = arith.subi %dim_1, %arg1 : index
    %14 = arith.minsi %13, %c2147483647 : index
    %15 = arith.index_cast %14 : index to i32
    %16 = llvm.mlir.poison : vector<17xi32>
    %17 = llvm.mlir.constant(0 : i32) : i32
    %18 = llvm.insertelement %15, %16[%17 : i32] : vector<17xi32>
    %19 = llvm.shufflevector %18, %16 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %20 = arith.cmpi sgt, %19, %cst_0 : vector<17xi32>
    %21 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.getelementptr %21[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.intr.masked.store %12, %22, %20 {alignment = 4 : i32} : vector<17xf32>, vector<17xi1> into !llvm.ptr
    return %12 : vector<17xf32>
  }
  func.func @transfer_read_write_1d_scalable(%arg0: memref<?xf32>, %arg1: index) -> vector<[17]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<[17]xf32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    %2 = arith.subi %dim, %arg1 : index
    %3 = llvm.intr.stepvector : vector<[17]xi32>
    %c2147483647 = arith.constant 2147483647 : index
    %4 = arith.minsi %2, %c2147483647 : index
    %5 = arith.index_cast %4 : index to i32
    %6 = llvm.mlir.poison : vector<[17]xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<[17]xi32>
    %9 = llvm.shufflevector %8, %6 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %10 = arith.cmpi slt, %3, %9 : vector<[17]xi32>
    %11 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.getelementptr %11[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %13 = llvm.intr.masked.load %12, %10, %cst {alignment = 4 : i32} : (!llvm.ptr, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    %dim_0 = memref.dim %arg0, %c0 : memref<?xf32>
    %14 = arith.subi %dim_0, %arg1 : index
    %15 = llvm.intr.stepvector : vector<[17]xi32>
    %c2147483647_1 = arith.constant 2147483647 : index
    %16 = arith.minsi %14, %c2147483647_1 : index
    %17 = arith.index_cast %16 : index to i32
    %18 = llvm.mlir.poison : vector<[17]xi32>
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.insertelement %17, %18[%19 : i32] : vector<[17]xi32>
    %21 = llvm.shufflevector %20, %18 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %22 = arith.cmpi slt, %15, %21 : vector<[17]xi32>
    %23 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.getelementptr %23[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.intr.masked.store %13, %24, %22 {alignment = 4 : i32} : vector<[17]xf32>, vector<[17]xi1> into !llvm.ptr
    return %13 : vector<[17]xf32>
  }
}

// -----
module {
  func.func @transfer_read_write_index_1d(%arg0: memref<?xindex>, %arg1: index) -> vector<17xindex> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7> : vector<17xindex>
    %2 = builtin.unrealized_conversion_cast %cst : vector<17xindex> to vector<17xi64>
    %c2147483647 = arith.constant 2147483647 : index
    %cst_0 = arith.constant dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xindex>
    %3 = arith.subi %dim, %arg1 : index
    %4 = arith.minsi %3, %c2147483647 : index
    %5 = arith.index_cast %4 : index to i32
    %6 = llvm.mlir.poison : vector<17xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<17xi32>
    %9 = llvm.shufflevector %8, %6 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %10 = arith.cmpi sgt, %9, %cst_0 : vector<17xi32>
    %11 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.getelementptr %11[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %13 = llvm.intr.masked.load %12, %10, %2 {alignment = 8 : i32} : (!llvm.ptr, vector<17xi1>, vector<17xi64>) -> vector<17xi64>
    %14 = builtin.unrealized_conversion_cast %13 : vector<17xi64> to vector<17xindex>
    %dim_1 = memref.dim %arg0, %c0 : memref<?xindex>
    %15 = arith.subi %dim_1, %arg1 : index
    %16 = arith.minsi %15, %c2147483647 : index
    %17 = arith.index_cast %16 : index to i32
    %18 = llvm.mlir.poison : vector<17xi32>
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.insertelement %17, %18[%19 : i32] : vector<17xi32>
    %21 = llvm.shufflevector %20, %18 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %22 = arith.cmpi sgt, %21, %cst_0 : vector<17xi32>
    %23 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.getelementptr %23[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.intr.masked.store %13, %24, %22 {alignment = 8 : i32} : vector<17xi64>, vector<17xi1> into !llvm.ptr
    return %14 : vector<17xindex>
  }
  func.func @transfer_read_write_index_1d_scalable(%arg0: memref<?xindex>, %arg1: index) -> vector<[17]xindex> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7> : vector<[17]xindex>
    %2 = builtin.unrealized_conversion_cast %cst : vector<[17]xindex> to vector<[17]xi64>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xindex>
    %3 = arith.subi %dim, %arg1 : index
    %4 = llvm.intr.stepvector : vector<[17]xi32>
    %c2147483647 = arith.constant 2147483647 : index
    %5 = arith.minsi %3, %c2147483647 : index
    %6 = arith.index_cast %5 : index to i32
    %7 = llvm.mlir.poison : vector<[17]xi32>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %6, %7[%8 : i32] : vector<[17]xi32>
    %10 = llvm.shufflevector %9, %7 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %11 = arith.cmpi slt, %4, %10 : vector<[17]xi32>
    %12 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.getelementptr %12[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %14 = llvm.intr.masked.load %13, %11, %2 {alignment = 8 : i32} : (!llvm.ptr, vector<[17]xi1>, vector<[17]xi64>) -> vector<[17]xi64>
    %15 = builtin.unrealized_conversion_cast %14 : vector<[17]xi64> to vector<[17]xindex>
    %dim_0 = memref.dim %arg0, %c0 : memref<?xindex>
    %16 = arith.subi %dim_0, %arg1 : index
    %17 = llvm.intr.stepvector : vector<[17]xi32>
    %c2147483647_1 = arith.constant 2147483647 : index
    %18 = arith.minsi %16, %c2147483647_1 : index
    %19 = arith.index_cast %18 : index to i32
    %20 = llvm.mlir.poison : vector<[17]xi32>
    %21 = llvm.mlir.constant(0 : i32) : i32
    %22 = llvm.insertelement %19, %20[%21 : i32] : vector<[17]xi32>
    %23 = llvm.shufflevector %22, %20 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %24 = arith.cmpi slt, %17, %23 : vector<[17]xi32>
    %25 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %26 = llvm.getelementptr %25[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.intr.masked.store %14, %26, %24 {alignment = 8 : i32} : vector<[17]xi64>, vector<[17]xi1> into !llvm.ptr
    return %15 : vector<[17]xindex>
  }
}

// -----
module {
  func.func @transfer_read_2d_to_1d(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index) -> vector<17xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?x?xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<17xf32>
    %c2147483647 = arith.constant 2147483647 : index
    %cst_0 = arith.constant dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>
    %c1 = arith.constant 1 : index
    %dim = memref.dim %arg0, %c1 : memref<?x?xf32>
    %3 = arith.subi %dim, %arg2 : index
    %4 = arith.minsi %3, %c2147483647 : index
    %5 = arith.index_cast %4 : index to i32
    %6 = llvm.mlir.poison : vector<17xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<17xi32>
    %9 = llvm.shufflevector %8, %6 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %10 = arith.cmpi sgt, %9, %cst_0 : vector<17xi32>
    %11 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.extractvalue %2[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.mul %1, %12 : i64
    %14 = llvm.add %13, %0 : i64
    %15 = llvm.getelementptr %11[%14] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %16 = llvm.intr.masked.load %15, %10, %cst {alignment = 4 : i32} : (!llvm.ptr, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    return %16 : vector<17xf32>
  }
  func.func @transfer_read_2d_to_1d_scalable(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index) -> vector<[17]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?x?xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<[17]xf32>
    %c1 = arith.constant 1 : index
    %dim = memref.dim %arg0, %c1 : memref<?x?xf32>
    %3 = arith.subi %dim, %arg2 : index
    %4 = llvm.intr.stepvector : vector<[17]xi32>
    %c2147483647 = arith.constant 2147483647 : index
    %5 = arith.minsi %3, %c2147483647 : index
    %6 = arith.index_cast %5 : index to i32
    %7 = llvm.mlir.poison : vector<[17]xi32>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %6, %7[%8 : i32] : vector<[17]xi32>
    %10 = llvm.shufflevector %9, %7 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %11 = arith.cmpi slt, %4, %10 : vector<[17]xi32>
    %12 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.extractvalue %2[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.mul %1, %13 : i64
    %15 = llvm.add %14, %0 : i64
    %16 = llvm.getelementptr %12[%15] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %17 = llvm.intr.masked.load %16, %11, %cst {alignment = 4 : i32} : (!llvm.ptr, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    return %17 : vector<[17]xf32>
  }
}

// -----
module {
  func.func @transfer_read_write_1d_non_zero_addrspace(%arg0: memref<?xf32, 3>, %arg1: index) -> vector<17xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<17xf32>
    %c2147483647 = arith.constant 2147483647 : index
    %cst_0 = arith.constant dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, 3>
    %2 = arith.subi %dim, %arg1 : index
    %3 = arith.minsi %2, %c2147483647 : index
    %4 = arith.index_cast %3 : index to i32
    %5 = llvm.mlir.poison : vector<17xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<17xi32>
    %8 = llvm.shufflevector %7, %5 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %9 = arith.cmpi sgt, %8, %cst_0 : vector<17xi32>
    %10 = llvm.extractvalue %1[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.getelementptr %10[%0] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
    %12 = llvm.intr.masked.load %11, %9, %cst {alignment = 4 : i32} : (!llvm.ptr<3>, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    %dim_1 = memref.dim %arg0, %c0 : memref<?xf32, 3>
    %13 = arith.subi %dim_1, %arg1 : index
    %14 = arith.minsi %13, %c2147483647 : index
    %15 = arith.index_cast %14 : index to i32
    %16 = llvm.mlir.poison : vector<17xi32>
    %17 = llvm.mlir.constant(0 : i32) : i32
    %18 = llvm.insertelement %15, %16[%17 : i32] : vector<17xi32>
    %19 = llvm.shufflevector %18, %16 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %20 = arith.cmpi sgt, %19, %cst_0 : vector<17xi32>
    %21 = llvm.extractvalue %1[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.getelementptr %21[%0] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
    llvm.intr.masked.store %12, %22, %20 {alignment = 4 : i32} : vector<17xf32>, vector<17xi1> into !llvm.ptr<3>
    return %12 : vector<17xf32>
  }
  func.func @transfer_read_write_1d_non_zero_addrspace_scalable(%arg0: memref<?xf32, 3>, %arg1: index) -> vector<[17]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<[17]xf32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, 3>
    %2 = arith.subi %dim, %arg1 : index
    %3 = llvm.intr.stepvector : vector<[17]xi32>
    %c2147483647 = arith.constant 2147483647 : index
    %4 = arith.minsi %2, %c2147483647 : index
    %5 = arith.index_cast %4 : index to i32
    %6 = llvm.mlir.poison : vector<[17]xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<[17]xi32>
    %9 = llvm.shufflevector %8, %6 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %10 = arith.cmpi slt, %3, %9 : vector<[17]xi32>
    %11 = llvm.extractvalue %1[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.getelementptr %11[%0] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
    %13 = llvm.intr.masked.load %12, %10, %cst {alignment = 4 : i32} : (!llvm.ptr<3>, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    %dim_0 = memref.dim %arg0, %c0 : memref<?xf32, 3>
    %14 = arith.subi %dim_0, %arg1 : index
    %15 = llvm.intr.stepvector : vector<[17]xi32>
    %c2147483647_1 = arith.constant 2147483647 : index
    %16 = arith.minsi %14, %c2147483647_1 : index
    %17 = arith.index_cast %16 : index to i32
    %18 = llvm.mlir.poison : vector<[17]xi32>
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.insertelement %17, %18[%19 : i32] : vector<[17]xi32>
    %21 = llvm.shufflevector %20, %18 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %22 = arith.cmpi slt, %15, %21 : vector<[17]xi32>
    %23 = llvm.extractvalue %1[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.getelementptr %23[%0] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
    llvm.intr.masked.store %13, %24, %22 {alignment = 4 : i32} : vector<[17]xf32>, vector<[17]xi1> into !llvm.ptr<3>
    return %13 : vector<[17]xf32>
  }
}

// -----
module {
  func.func @transfer_read_1d_inbounds(%arg0: memref<?xf32>, %arg1: index) -> vector<17xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> vector<17xf32>
    return %4 : vector<17xf32>
  }
  func.func @transfer_read_1d_inbounds_scalable(%arg0: memref<?xf32>, %arg1: index) -> vector<[17]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> vector<[17]xf32>
    return %4 : vector<[17]xf32>
  }
}

// -----
module {
  func.func @transfer_read_write_1d_mask(%arg0: memref<?xf32>, %arg1: index) -> vector<5xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<5xf32>
    %c2147483647 = arith.constant 2147483647 : index
    %cst_0 = arith.constant dense<[0, 1, 2, 3, 4]> : vector<5xi32>
    %cst_1 = arith.constant dense<[false, false, true, false, true]> : vector<5xi1>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    %2 = arith.subi %dim, %arg1 : index
    %3 = arith.minsi %2, %c2147483647 : index
    %4 = arith.index_cast %3 : index to i32
    %5 = llvm.mlir.poison : vector<5xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<5xi32>
    %8 = llvm.shufflevector %7, %5 [0, 0, 0, 0, 0] : vector<5xi32> 
    %9 = arith.cmpi sgt, %8, %cst_0 : vector<5xi32>
    %10 = arith.andi %9, %cst_1 : vector<5xi1>
    %11 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.getelementptr %11[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %13 = llvm.intr.masked.load %12, %10, %cst {alignment = 4 : i32} : (!llvm.ptr, vector<5xi1>, vector<5xf32>) -> vector<5xf32>
    %dim_2 = memref.dim %arg0, %c0 : memref<?xf32>
    %14 = arith.subi %dim_2, %arg1 : index
    %15 = arith.minsi %14, %c2147483647 : index
    %16 = arith.index_cast %15 : index to i32
    %17 = llvm.mlir.poison : vector<5xi32>
    %18 = llvm.mlir.constant(0 : i32) : i32
    %19 = llvm.insertelement %16, %17[%18 : i32] : vector<5xi32>
    %20 = llvm.shufflevector %19, %17 [0, 0, 0, 0, 0] : vector<5xi32> 
    %21 = arith.cmpi sgt, %20, %cst_0 : vector<5xi32>
    %22 = arith.andi %21, %cst_1 : vector<5xi1>
    %23 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.getelementptr %23[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.intr.masked.store %13, %24, %22 {alignment = 4 : i32} : vector<5xf32>, vector<5xi1> into !llvm.ptr
    return %13 : vector<5xf32>
  }
  func.func @transfer_read_write_1d_mask_scalable(%arg0: memref<?xf32>, %arg1: index, %arg2: vector<[5]xi1>) -> vector<[5]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<[5]xf32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    %2 = arith.subi %dim, %arg1 : index
    %3 = llvm.intr.stepvector : vector<[5]xi32>
    %c2147483647 = arith.constant 2147483647 : index
    %4 = arith.minsi %2, %c2147483647 : index
    %5 = arith.index_cast %4 : index to i32
    %6 = llvm.mlir.poison : vector<[5]xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<[5]xi32>
    %9 = llvm.shufflevector %8, %6 [0, 0, 0, 0, 0] : vector<[5]xi32> 
    %10 = arith.cmpi slt, %3, %9 : vector<[5]xi32>
    %11 = arith.andi %10, %arg2 : vector<[5]xi1>
    %12 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.getelementptr %12[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %14 = llvm.intr.masked.load %13, %11, %cst {alignment = 4 : i32} : (!llvm.ptr, vector<[5]xi1>, vector<[5]xf32>) -> vector<[5]xf32>
    %dim_0 = memref.dim %arg0, %c0 : memref<?xf32>
    %15 = arith.subi %dim_0, %arg1 : index
    %16 = llvm.intr.stepvector : vector<[5]xi32>
    %c2147483647_1 = arith.constant 2147483647 : index
    %17 = arith.minsi %15, %c2147483647_1 : index
    %18 = arith.index_cast %17 : index to i32
    %19 = llvm.mlir.poison : vector<[5]xi32>
    %20 = llvm.mlir.constant(0 : i32) : i32
    %21 = llvm.insertelement %18, %19[%20 : i32] : vector<[5]xi32>
    %22 = llvm.shufflevector %21, %19 [0, 0, 0, 0, 0] : vector<[5]xi32> 
    %23 = arith.cmpi slt, %16, %22 : vector<[5]xi32>
    %24 = arith.andi %23, %arg2 : vector<[5]xi1>
    %25 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %26 = llvm.getelementptr %25[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.intr.masked.store %14, %26, %24 {alignment = 4 : i32} : vector<[5]xf32>, vector<[5]xi1> into !llvm.ptr
    return %14 : vector<[5]xf32>
  }
}

// -----
module {
  func.func @transfer_read_write_tensor(%arg0: tensor<?xf32>, %arg1: index) -> vector<4xf32> {
    %c2147483647 = arith.constant 2147483647 : index
    %cst = arith.constant dense<[0, 1, 2, 3]> : vector<4xi32>
    %cst_0 = arith.constant 7.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xf32>
    %0 = arith.subi %dim, %arg1 : index
    %1 = arith.minsi %0, %c2147483647 : index
    %2 = arith.index_cast %1 : index to i32
    %3 = llvm.mlir.poison : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.shufflevector %5, %3 [0, 0, 0, 0] : vector<4xi32> 
    %7 = arith.cmpi sgt, %6, %cst : vector<4xi32>
    %8 = vector.transfer_read %arg0[%arg1], %cst_0, %7 {in_bounds = [true]} : tensor<?xf32>, vector<4xf32>
    %dim_1 = tensor.dim %arg0, %c0 : tensor<?xf32>
    %9 = arith.minsi %dim_1, %c2147483647 : index
    %10 = arith.index_cast %9 : index to i32
    %11 = llvm.mlir.poison : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<4xi32>
    %14 = llvm.shufflevector %13, %11 [0, 0, 0, 0] : vector<4xi32> 
    %15 = arith.cmpi sgt, %14, %cst : vector<4xi32>
    %16 = vector.transfer_write %8, %arg0[%c0], %15 {in_bounds = [true]} : vector<4xf32>, tensor<?xf32>
    "test.some_use"(%16) : (tensor<?xf32>) -> ()
    return %8 : vector<4xf32>
  }
}

