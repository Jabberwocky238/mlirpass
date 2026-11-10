module {
  func.func @load(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> vector<8xf32>
    return %8 : vector<8xf32>
  }
}

// -----
module {
  func.func @load_scalable(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<[8]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> vector<[8]xf32>
    return %8 : vector<[8]xf32>
  }
}

// -----
module {
  func.func @load_nontemporal(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 {alignment = 4 : i64, nontemporal} : !llvm.ptr -> vector<8xf32>
    return %8 : vector<8xf32>
  }
}

// -----
module {
  func.func @load_nontemporal_scalable(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<[8]xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 {alignment = 4 : i64, nontemporal} : !llvm.ptr -> vector<[8]xf32>
    return %8 : vector<[8]xf32>
  }
}

// -----
module {
  func.func @load_index(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index) -> vector<8xindex> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xindex> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> vector<8xi64>
    %9 = builtin.unrealized_conversion_cast %8 : vector<8xi64> to vector<8xindex>
    return %9 : vector<8xindex>
  }
}

// -----
module {
  func.func @load_index_scalable(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index) -> vector<[8]xindex> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xindex> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> vector<[8]xi64>
    %9 = builtin.unrealized_conversion_cast %8 : vector<[8]xi64> to vector<[8]xindex>
    return %9 : vector<[8]xindex>
  }
}

// -----
module {
  func.func @load_0d(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<f32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> vector<1xf32>
    %9 = builtin.unrealized_conversion_cast %8 : vector<1xf32> to vector<f32>
    return %9 : vector<f32>
  }
}

// -----
module {
  func.func @load_with_alignment(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) -> vector<8xf32> {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
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
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %cst, %7 {alignment = 4 : i64} : vector<4xf32>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_scalable(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<1.100000e+01> : vector<[4]xf32>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %cst, %7 {alignment = 4 : i64} : vector<[4]xf32>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_nontemporal(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<1.100000e+01> : vector<4xf32>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %cst, %7 {alignment = 4 : i64, nontemporal} : vector<4xf32>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_nontemporal_scalable(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<1.100000e+01> : vector<[4]xf32>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %cst, %7 {alignment = 4 : i64, nontemporal} : vector<[4]xf32>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_index(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xindex> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<11> : vector<4xindex>
    %3 = builtin.unrealized_conversion_cast %cst : vector<4xindex> to vector<4xi64>
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mlir.constant(100 : index) : i64
    %6 = llvm.mul %1, %5 overflow<nsw, nuw> : i64
    %7 = llvm.add %6, %0 overflow<nsw, nuw> : i64
    %8 = llvm.getelementptr inbounds|nuw %4[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %3, %8 {alignment = 8 : i64} : vector<4xi64>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_index_scalable(%arg0: memref<200x100xindex>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xindex> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<11> : vector<[4]xindex>
    %3 = builtin.unrealized_conversion_cast %cst : vector<[4]xindex> to vector<[4]xi64>
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mlir.constant(100 : index) : i64
    %6 = llvm.mul %1, %5 overflow<nsw, nuw> : i64
    %7 = llvm.add %6, %0 overflow<nsw, nuw> : i64
    %8 = llvm.getelementptr inbounds|nuw %4[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %3, %8 {alignment = 8 : i64} : vector<[4]xi64>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_0d(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %cst = arith.constant dense<1.100000e+01> : vector<f32>
    %3 = builtin.unrealized_conversion_cast %cst : vector<f32> to vector<1xf32>
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %5 = llvm.mlir.constant(100 : index) : i64
    %6 = llvm.mul %1, %5 overflow<nsw, nuw> : i64
    %7 = llvm.add %6, %0 overflow<nsw, nuw> : i64
    %8 = llvm.getelementptr inbounds|nuw %4[%7] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %3, %8 {alignment = 4 : i64} : vector<1xf32>, !llvm.ptr
    return
  }
}

// -----
module {
  func.func @store_with_alignment(%arg0: memref<200x100xf32>, %arg1: index, %arg2: index, %arg3: vector<4xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg0 : memref<200x100xf32> to !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr, ptr, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(100 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    llvm.store %arg3, %7 {alignment = 8 : i64} : vector<4xf32>, !llvm.ptr
    return
  }
}

