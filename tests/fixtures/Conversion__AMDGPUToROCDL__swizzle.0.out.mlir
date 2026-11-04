module {
  func.func @test_swizzle_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4161 : i32) : i32
    %1 = rocdl.ds_swizzle %arg0, %0 : (i32, i32) -> i32
    return %1 : i32
  }
  func.func @test_swizzle_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4161 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = rocdl.ds_swizzle %1, %0 : (i32, i32) -> i32
    %3 = llvm.bitcast %2 : i32 to f32
    return %3 : f32
  }
  func.func @test_swizzle_f16(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(4161 : i32) : i32
    %1 = llvm.bitcast %arg0 : f16 to i16
    %2 = llvm.zext %1 : i16 to i32
    %3 = rocdl.ds_swizzle %2, %0 : (i32, i32) -> i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.bitcast %4 : i16 to f16
    return %5 : f16
  }
  func.func @test_swizzle_2xi32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(4161 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.extractelement %arg0[%3 : i32] : vector<2xi32>
    %5 = llvm.extractelement %arg0[%2 : i32] : vector<2xi32>
    %6 = rocdl.ds_swizzle %4, %1 : (i32, i32) -> i32
    %7 = rocdl.ds_swizzle %5, %1 : (i32, i32) -> i32
    %8 = llvm.insertelement %6, %0[%3 : i32] : vector<2xi32>
    %9 = llvm.insertelement %7, %8[%2 : i32] : vector<2xi32>
    return %9 : vector<2xi32>
  }
  func.func @test_swizzle_4xf16(%arg0: vector<4xf16>) -> vector<4xf16> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(4161 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.bitcast %arg0 : vector<4xf16> to vector<2xi32>
    %5 = llvm.extractelement %4[%3 : i32] : vector<2xi32>
    %6 = llvm.extractelement %4[%2 : i32] : vector<2xi32>
    %7 = rocdl.ds_swizzle %5, %1 : (i32, i32) -> i32
    %8 = rocdl.ds_swizzle %6, %1 : (i32, i32) -> i32
    %9 = llvm.insertelement %7, %0[%3 : i32] : vector<2xi32>
    %10 = llvm.insertelement %8, %9[%2 : i32] : vector<2xi32>
    %11 = llvm.bitcast %10 : vector<2xi32> to vector<4xf16>
    return %11 : vector<4xf16>
  }
}

