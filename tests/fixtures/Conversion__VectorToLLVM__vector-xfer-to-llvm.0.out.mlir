module {
  func.func @transfer_read_write_1d(%arg0: memref<?xf32>, %arg1: index) -> vector<17xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<17xf32>
    %cst_0 = arith.constant dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    %2 = arith.subi %dim, %arg1 : index
    %3 = arith.index_cast %2 : index to i32
    %4 = llvm.mlir.poison : vector<17xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<17xi32>
    %7 = llvm.shufflevector %6, %4 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %8 = arith.cmpi sgt, %7, %cst_0 : vector<17xi32>
    %9 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.getelementptr %9[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %11 = llvm.intr.masked.load %10, %8, %cst {alignment = 4 : i32} : (!llvm.ptr, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    %dim_1 = memref.dim %arg0, %c0 : memref<?xf32>
    %12 = arith.subi %dim_1, %arg1 : index
    %13 = arith.index_cast %12 : index to i32
    %14 = llvm.mlir.poison : vector<17xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<17xi32>
    %17 = llvm.shufflevector %16, %14 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %18 = arith.cmpi sgt, %17, %cst_0 : vector<17xi32>
    %19 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.getelementptr %19[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.intr.masked.store %11, %20, %18 {alignment = 4 : i32} : vector<17xf32>, vector<17xi1> into !llvm.ptr
    return %11 : vector<17xf32>
  }
  func.func @transfer_read_write_1d_scalable(%arg0: memref<?xf32>, %arg1: index) -> vector<[17]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<[17]xf32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    %2 = arith.subi %dim, %arg1 : index
    %3 = llvm.intr.stepvector : vector<[17]xi32>
    %4 = arith.index_cast %2 : index to i32
    %5 = llvm.mlir.poison : vector<[17]xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<[17]xi32>
    %8 = llvm.shufflevector %7, %5 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %9 = arith.cmpi slt, %3, %8 : vector<[17]xi32>
    %10 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.getelementptr %10[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %12 = llvm.intr.masked.load %11, %9, %cst {alignment = 4 : i32} : (!llvm.ptr, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    %dim_0 = memref.dim %arg0, %c0 : memref<?xf32>
    %13 = arith.subi %dim_0, %arg1 : index
    %14 = llvm.intr.stepvector : vector<[17]xi32>
    %15 = arith.index_cast %13 : index to i32
    %16 = llvm.mlir.poison : vector<[17]xi32>
    %17 = llvm.mlir.constant(0 : i32) : i32
    %18 = llvm.insertelement %15, %16[%17 : i32] : vector<[17]xi32>
    %19 = llvm.shufflevector %18, %16 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %20 = arith.cmpi slt, %14, %19 : vector<[17]xi32>
    %21 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.getelementptr %21[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.intr.masked.store %12, %22, %20 {alignment = 4 : i32} : vector<[17]xf32>, vector<[17]xi1> into !llvm.ptr
    return %12 : vector<[17]xf32>
  }
}

// -----
module {
  func.func @transfer_read_write_index_1d(%arg0: memref<?xindex>, %arg1: index) -> vector<17xindex> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xindex> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7> : vector<17xindex>
    %2 = builtin.unrealized_conversion_cast %cst : vector<17xindex> to vector<17xi64>
    %cst_0 = arith.constant dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xindex>
    %3 = arith.subi %dim, %arg1 : index
    %4 = arith.index_cast %3 : index to i32
    %5 = llvm.mlir.poison : vector<17xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<17xi32>
    %8 = llvm.shufflevector %7, %5 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %9 = arith.cmpi sgt, %8, %cst_0 : vector<17xi32>
    %10 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.getelementptr %10[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %12 = llvm.intr.masked.load %11, %9, %2 {alignment = 8 : i32} : (!llvm.ptr, vector<17xi1>, vector<17xi64>) -> vector<17xi64>
    %13 = builtin.unrealized_conversion_cast %12 : vector<17xi64> to vector<17xindex>
    %dim_1 = memref.dim %arg0, %c0 : memref<?xindex>
    %14 = arith.subi %dim_1, %arg1 : index
    %15 = arith.index_cast %14 : index to i32
    %16 = llvm.mlir.poison : vector<17xi32>
    %17 = llvm.mlir.constant(0 : i32) : i32
    %18 = llvm.insertelement %15, %16[%17 : i32] : vector<17xi32>
    %19 = llvm.shufflevector %18, %16 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %20 = arith.cmpi sgt, %19, %cst_0 : vector<17xi32>
    %21 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.getelementptr %21[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.intr.masked.store %12, %22, %20 {alignment = 8 : i32} : vector<17xi64>, vector<17xi1> into !llvm.ptr
    return %13 : vector<17xindex>
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
    %5 = arith.index_cast %3 : index to i32
    %6 = llvm.mlir.poison : vector<[17]xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<[17]xi32>
    %9 = llvm.shufflevector %8, %6 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %10 = arith.cmpi slt, %4, %9 : vector<[17]xi32>
    %11 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.getelementptr %11[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %13 = llvm.intr.masked.load %12, %10, %2 {alignment = 8 : i32} : (!llvm.ptr, vector<[17]xi1>, vector<[17]xi64>) -> vector<[17]xi64>
    %14 = builtin.unrealized_conversion_cast %13 : vector<[17]xi64> to vector<[17]xindex>
    %dim_0 = memref.dim %arg0, %c0 : memref<?xindex>
    %15 = arith.subi %dim_0, %arg1 : index
    %16 = llvm.intr.stepvector : vector<[17]xi32>
    %17 = arith.index_cast %15 : index to i32
    %18 = llvm.mlir.poison : vector<[17]xi32>
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.insertelement %17, %18[%19 : i32] : vector<[17]xi32>
    %21 = llvm.shufflevector %20, %18 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %22 = arith.cmpi slt, %16, %21 : vector<[17]xi32>
    %23 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.getelementptr %23[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.intr.masked.store %13, %24, %22 {alignment = 8 : i32} : vector<[17]xi64>, vector<[17]xi1> into !llvm.ptr
    return %14 : vector<[17]xindex>
  }
}

// -----
module {
  func.func @transfer_read_2d_to_1d(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index) -> vector<17xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<?x?xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<17xf32>
    %cst_0 = arith.constant dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>
    %c1 = arith.constant 1 : index
    %dim = memref.dim %arg0, %c1 : memref<?x?xf32>
    %3 = arith.subi %dim, %arg2 : index
    %4 = arith.index_cast %3 : index to i32
    %5 = llvm.mlir.poison : vector<17xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<17xi32>
    %8 = llvm.shufflevector %7, %5 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %9 = arith.cmpi sgt, %8, %cst_0 : vector<17xi32>
    %10 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.extractvalue %2[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.mul %1, %11 : i64
    %13 = llvm.add %12, %0 : i64
    %14 = llvm.getelementptr %10[%13] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %15 = llvm.intr.masked.load %14, %9, %cst {alignment = 4 : i32} : (!llvm.ptr, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    return %15 : vector<17xf32>
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
    %5 = arith.index_cast %3 : index to i32
    %6 = llvm.mlir.poison : vector<[17]xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<[17]xi32>
    %9 = llvm.shufflevector %8, %6 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %10 = arith.cmpi slt, %4, %9 : vector<[17]xi32>
    %11 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.extractvalue %2[4, 0] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.mul %1, %12 : i64
    %14 = llvm.add %13, %0 : i64
    %15 = llvm.getelementptr %11[%14] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %16 = llvm.intr.masked.load %15, %10, %cst {alignment = 4 : i32} : (!llvm.ptr, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    return %16 : vector<[17]xf32>
  }
}

// -----
module {
  func.func @transfer_read_write_1d_non_zero_addrspace(%arg0: memref<?xf32, 3>, %arg1: index) -> vector<17xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<17xf32>
    %cst_0 = arith.constant dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]> : vector<17xi32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, 3>
    %2 = arith.subi %dim, %arg1 : index
    %3 = arith.index_cast %2 : index to i32
    %4 = llvm.mlir.poison : vector<17xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<17xi32>
    %7 = llvm.shufflevector %6, %4 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %8 = arith.cmpi sgt, %7, %cst_0 : vector<17xi32>
    %9 = llvm.extractvalue %1[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.getelementptr %9[%0] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
    %11 = llvm.intr.masked.load %10, %8, %cst {alignment = 4 : i32} : (!llvm.ptr<3>, vector<17xi1>, vector<17xf32>) -> vector<17xf32>
    %dim_1 = memref.dim %arg0, %c0 : memref<?xf32, 3>
    %12 = arith.subi %dim_1, %arg1 : index
    %13 = arith.index_cast %12 : index to i32
    %14 = llvm.mlir.poison : vector<17xi32>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<17xi32>
    %17 = llvm.shufflevector %16, %14 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<17xi32> 
    %18 = arith.cmpi sgt, %17, %cst_0 : vector<17xi32>
    %19 = llvm.extractvalue %1[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
    %20 = llvm.getelementptr %19[%0] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
    llvm.intr.masked.store %11, %20, %18 {alignment = 4 : i32} : vector<17xf32>, vector<17xi1> into !llvm.ptr<3>
    return %11 : vector<17xf32>
  }
  func.func @transfer_read_write_1d_non_zero_addrspace_scalable(%arg0: memref<?xf32, 3>, %arg1: index) -> vector<[17]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<[17]xf32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32, 3>
    %2 = arith.subi %dim, %arg1 : index
    %3 = llvm.intr.stepvector : vector<[17]xi32>
    %4 = arith.index_cast %2 : index to i32
    %5 = llvm.mlir.poison : vector<[17]xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<[17]xi32>
    %8 = llvm.shufflevector %7, %5 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %9 = arith.cmpi slt, %3, %8 : vector<[17]xi32>
    %10 = llvm.extractvalue %1[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.getelementptr %10[%0] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
    %12 = llvm.intr.masked.load %11, %9, %cst {alignment = 4 : i32} : (!llvm.ptr<3>, vector<[17]xi1>, vector<[17]xf32>) -> vector<[17]xf32>
    %dim_0 = memref.dim %arg0, %c0 : memref<?xf32, 3>
    %13 = arith.subi %dim_0, %arg1 : index
    %14 = llvm.intr.stepvector : vector<[17]xi32>
    %15 = arith.index_cast %13 : index to i32
    %16 = llvm.mlir.poison : vector<[17]xi32>
    %17 = llvm.mlir.constant(0 : i32) : i32
    %18 = llvm.insertelement %15, %16[%17 : i32] : vector<[17]xi32>
    %19 = llvm.shufflevector %18, %16 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<[17]xi32> 
    %20 = arith.cmpi slt, %14, %19 : vector<[17]xi32>
    %21 = llvm.extractvalue %1[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.getelementptr %21[%0] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f32
    llvm.intr.masked.store %12, %22, %20 {alignment = 4 : i32} : vector<[17]xf32>, vector<[17]xi1> into !llvm.ptr<3>
    return %12 : vector<[17]xf32>
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
    %cst_0 = arith.constant dense<[0, 1, 2, 3, 4]> : vector<5xi32>
    %cst_1 = arith.constant dense<[false, false, true, false, true]> : vector<5xi1>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    %2 = arith.subi %dim, %arg1 : index
    %3 = arith.index_cast %2 : index to i32
    %4 = llvm.mlir.poison : vector<5xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<5xi32>
    %7 = llvm.shufflevector %6, %4 [0, 0, 0, 0, 0] : vector<5xi32> 
    %8 = arith.cmpi sgt, %7, %cst_0 : vector<5xi32>
    %9 = arith.andi %8, %cst_1 : vector<5xi1>
    %10 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.getelementptr %10[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %12 = llvm.intr.masked.load %11, %9, %cst {alignment = 4 : i32} : (!llvm.ptr, vector<5xi1>, vector<5xf32>) -> vector<5xf32>
    %dim_2 = memref.dim %arg0, %c0 : memref<?xf32>
    %13 = arith.subi %dim_2, %arg1 : index
    %14 = arith.index_cast %13 : index to i32
    %15 = llvm.mlir.poison : vector<5xi32>
    %16 = llvm.mlir.constant(0 : i32) : i32
    %17 = llvm.insertelement %14, %15[%16 : i32] : vector<5xi32>
    %18 = llvm.shufflevector %17, %15 [0, 0, 0, 0, 0] : vector<5xi32> 
    %19 = arith.cmpi sgt, %18, %cst_0 : vector<5xi32>
    %20 = arith.andi %19, %cst_1 : vector<5xi1>
    %21 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %22 = llvm.getelementptr %21[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.intr.masked.store %12, %22, %20 {alignment = 4 : i32} : vector<5xf32>, vector<5xi1> into !llvm.ptr
    return %12 : vector<5xf32>
  }
  func.func @transfer_read_write_1d_mask_scalable(%arg0: memref<?xf32>, %arg1: index, %arg2: vector<[5]xi1>) -> vector<[5]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %cst = arith.constant dense<7.000000e+00> : vector<[5]xf32>
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    %2 = arith.subi %dim, %arg1 : index
    %3 = llvm.intr.stepvector : vector<[5]xi32>
    %4 = arith.index_cast %2 : index to i32
    %5 = llvm.mlir.poison : vector<[5]xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<[5]xi32>
    %8 = llvm.shufflevector %7, %5 [0, 0, 0, 0, 0] : vector<[5]xi32> 
    %9 = arith.cmpi slt, %3, %8 : vector<[5]xi32>
    %10 = arith.andi %9, %arg2 : vector<[5]xi1>
    %11 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.getelementptr %11[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %13 = llvm.intr.masked.load %12, %10, %cst {alignment = 4 : i32} : (!llvm.ptr, vector<[5]xi1>, vector<[5]xf32>) -> vector<[5]xf32>
    %dim_0 = memref.dim %arg0, %c0 : memref<?xf32>
    %14 = arith.subi %dim_0, %arg1 : index
    %15 = llvm.intr.stepvector : vector<[5]xi32>
    %16 = arith.index_cast %14 : index to i32
    %17 = llvm.mlir.poison : vector<[5]xi32>
    %18 = llvm.mlir.constant(0 : i32) : i32
    %19 = llvm.insertelement %16, %17[%18 : i32] : vector<[5]xi32>
    %20 = llvm.shufflevector %19, %17 [0, 0, 0, 0, 0] : vector<[5]xi32> 
    %21 = arith.cmpi slt, %15, %20 : vector<[5]xi32>
    %22 = arith.andi %21, %arg2 : vector<[5]xi1>
    %23 = llvm.extractvalue %1[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %24 = llvm.getelementptr %23[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.intr.masked.store %13, %24, %22 {alignment = 4 : i32} : vector<[5]xf32>, vector<[5]xi1> into !llvm.ptr
    return %13 : vector<[5]xf32>
  }
}

// -----
module {
  func.func @transfer_read_write_tensor(%arg0: tensor<?xf32>, %arg1: index) -> vector<4xf32> {
    %cst = arith.constant dense<[0, 1, 2, 3]> : vector<4xi32>
    %cst_0 = arith.constant 7.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?xf32>
    %0 = arith.subi %dim, %arg1 : index
    %1 = arith.index_cast %0 : index to i32
    %2 = llvm.mlir.poison : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.shufflevector %4, %2 [0, 0, 0, 0] : vector<4xi32> 
    %6 = arith.cmpi sgt, %5, %cst : vector<4xi32>
    %7 = vector.transfer_read %arg0[%arg1], %cst_0, %6 {in_bounds = [true]} : tensor<?xf32>, vector<4xf32>
    %dim_1 = tensor.dim %arg0, %c0 : tensor<?xf32>
    %8 = arith.index_cast %dim_1 : index to i32
    %9 = llvm.mlir.poison : vector<4xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.shufflevector %11, %9 [0, 0, 0, 0] : vector<4xi32> 
    %13 = arith.cmpi sgt, %12, %cst : vector<4xi32>
    %14 = vector.transfer_write %7, %arg0[%c0], %13 {in_bounds = [true]} : vector<4xf32>, tensor<?xf32>
    "test.some_use"(%14) : (tensor<?xf32>) -> ()
    return %7 : vector<4xf32>
  }
}

