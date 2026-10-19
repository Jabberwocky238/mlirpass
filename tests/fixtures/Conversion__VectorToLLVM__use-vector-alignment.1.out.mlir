module {
  func.func @load(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 {alignment = 32 : i64} : !llvm.ptr -> vector<8xf32>
    return %8 : vector<8xf32>
  }
}

// -----
module {
  func.func @load_with_alignment_attribute(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> vector<8xf32>
    return %8 : vector<8xf32>
  }
}

// -----
module {
  func.func @store(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<1.100000e+01> : vector<4xf32>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %cst, %7 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_with_alignment_attribute(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<1.100000e+01> : vector<4xf32>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %cst, %7 {alignment = 8 : i64} : vector<4xf32>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @masked_load(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>) -> vector<16xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.intr.masked.load %3, %arg1, %arg2 {alignment = 64 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    return %4 : vector<16xf32>
  }
}

// -----
module {
  func.func @masked_load_with_alignment_attribute(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>) -> vector<16xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.intr.masked.load %3, %arg1, %arg2 {alignment = 8 : i32} : (!llvm.ptr, vector<16xi1>, vector<16xf32>) -> vector<16xf32>
    return %4 : vector<16xf32>
  }
}

// -----
module {
  func.func @masked_store(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.intr.masked.store %arg2, %3, %arg1 {alignment = 64 : i32} : vector<16xf32>, vector<16xi1> into !llvm.ptr
    return
  }
}

// -----
module {
  func.func @masked_store_with_alignment_attribute(%arg0: memref<?xf32>, %arg1: vector<16xi1>, %arg2: vector<16xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.intr.masked.store %arg2, %3, %arg1 {alignment = 8 : i32} : vector<16xf32>, vector<16xi1> into !llvm.ptr
    return
  }
}

// -----
module {
  func.func @scatter(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>, f32
    llvm.intr.masked.scatter %arg3, %4, %arg2 {alignment = 16 : i32} : vector<3xf32>, vector<3xi1> into vector<3x!llvm.ptr>
    return
  }
}

// -----
module {
  func.func @scatter_with_alignment_attribute(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>, f32
    llvm.intr.masked.scatter %arg3, %4, %arg2 {alignment = 8 : i32} : vector<3xf32>, vector<3xi1> into vector<3x!llvm.ptr>
    return
  }
}

// -----
module {
  func.func @gather(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>) -> vector<3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>, f32
    %5 = llvm.intr.masked.gather %4, %arg2, %arg3 {alignment = 16 : i32} : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    return %5 : vector<3xf32>
  }
}

// -----
module {
  func.func @gather_with_alignment_attribute(%arg0: memref<?xf32>, %arg1: vector<3xi32>, %arg2: vector<3xi1>, %arg3: vector<3xf32>) -> vector<3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<?xf32> to !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %c0 = arith.constant 0 : index
    %1 = builtin.unrealized_conversion_cast %c0 : index to i64
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)> 
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.ptr, vector<3xi32>) -> vector<3x!llvm.ptr>, f32
    %5 = llvm.intr.masked.gather %4, %arg2, %arg3 {alignment = 8 : i32} : (vector<3x!llvm.ptr>, vector<3xi1>, vector<3xf32>) -> vector<3xf32>
    return %5 : vector<3xf32>
  }
}

