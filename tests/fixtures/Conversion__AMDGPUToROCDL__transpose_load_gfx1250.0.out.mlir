module {
  func.func @transpose_load_to_rocdl_8xf16(%arg0: index, %arg1: index, %arg2: memref<128x72xf16, 3>) -> vector<8xf16> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg2 : memref<128x72xf16, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(72 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, f16
    %8 = rocdl.ds.load.tr16.b128 %7 : !llvm.ptr<3> -> vector<8xf16>
    return %8 : vector<8xf16>
  }
}

// -----
module {
  func.func @transpose_load_to_rocdl_8xi8(%arg0: index, %arg1: index, %arg2: memref<128x128xi8, 3>) -> vector<8xi8> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg2 : memref<128x128xi8, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(128 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i8
    %8 = rocdl.ds.load.tr8.b64 %7 : !llvm.ptr<3> -> vector<2xi32>
    %9 = llvm.bitcast %8 : vector<2xi32> to vector<8xi8>
    return %9 : vector<8xi8>
  }
}

// -----
module {
  func.func @transpose_load_to_rocdl_16xi4(%arg0: index, %arg1: index, %arg2: memref<128x32xi8, 3>) -> vector<16xi4> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg2 : memref<128x32xi8, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(32 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i8
    %8 = rocdl.ds.load.tr4.b64 %7 : !llvm.ptr<3> -> vector<2xi32>
    %9 = llvm.bitcast %8 : vector<2xi32> to vector<16xi4>
    return %9 : vector<16xi4>
  }
}

// -----
module {
  func.func @transpose_load_to_rocdl_16xi6(%arg0: index, %arg1: index, %arg2: memref<128x32xi8, 3>) -> vector<16xi6> {
    %0 = builtin.unrealized_conversion_cast %arg1 : index to i64
    %1 = builtin.unrealized_conversion_cast %arg0 : index to i64
    %2 = builtin.unrealized_conversion_cast %arg2 : memref<128x32xi8, 3> to !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(ptr<3>, ptr<3>, i64, array<2 x i64>, array<2 x i64>)> 
    %4 = llvm.mlir.constant(32 : index) : i64
    %5 = llvm.mul %1, %4 : i64
    %6 = llvm.add %5, %0 : i64
    %7 = llvm.getelementptr %3[%6] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i8
    %8 = rocdl.ds.load.tr6.b96 %7 : !llvm.ptr<3> -> vector<3xi32>
    %9 = llvm.bitcast %8 : vector<3xi32> to vector<16xi6>
    return %9 : vector<16xi6>
  }
}

