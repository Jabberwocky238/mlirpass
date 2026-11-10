module {
  func.func @global_transpose_load_8xf16(%arg0: index, %arg1: index, %arg2: memref<128x256xf16, #gpu.address_space<global>>) -> vector<8xf16> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg2 : memref<128x256xf16, #gpu.address_space<global>> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(256 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f16
    %8 = rocdl.global.load.tr.b128 %7 : !llvm.ptr<1> -> vector<8xf16>
    return %8 : vector<8xf16>
  }
}

// -----
module {
  func.func @global_transpose_load_8xi8(%arg0: index, %arg1: index, %arg2: memref<128x256xi8, #gpu.address_space<global>>) -> vector<8xi8> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg2 : memref<128x256xi8, #gpu.address_space<global>> to !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr<1>, ptr<1>, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(256 : index) : i64
    %5 = llvm.mul %1, %4 overflow<nsw, nuw> : i64
    %6 = llvm.add %5, %0 overflow<nsw, nuw> : i64
    %7 = llvm.getelementptr inbounds|nuw %3[%6] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i8
    %8 = rocdl.global.load.tr.b64 %7 : !llvm.ptr<1> -> vector<2xi32>
    %9 = llvm.bitcast %8 : vector<2xi32> to vector<8xi8>
    return %9 : vector<8xi8>
  }
}

// -----
// -----
