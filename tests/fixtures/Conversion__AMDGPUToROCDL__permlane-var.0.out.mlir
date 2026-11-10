module {
  func.func @test_permlane_var_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = rocdl.permlane16.var %arg0, %arg0, %arg1, false, false : (i32, i32, i32) -> i32
    return %0 : i32
  }
  func.func @test_permlane_var_cross_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = rocdl.permlanex16.var %arg0, %arg0, %arg1, false, false : (i32, i32, i32) -> i32
    return %0 : i32
  }
  func.func @test_permlane_var_f32(%arg0: f32, %arg1: i32) -> f32 {
    %0 = llvm.bitcast %arg0 : f32 to i32
    %1 = rocdl.permlane16.var %0, %0, %arg1, false, false : (i32, i32, i32) -> i32
    %2 = llvm.bitcast %1 : i32 to f32
    return %2 : f32
  }
  func.func @test_permlane_var_f16(%arg0: f16, %arg1: i32) -> f16 {
    %0 = llvm.bitcast %arg0 : f16 to i16
    %1 = llvm.zext %0 : i16 to i32
    %2 = rocdl.permlane16.var %1, %1, %arg1, false, false : (i32, i32, i32) -> i32
    %3 = llvm.trunc %2 : i32 to i16
    %4 = llvm.bitcast %3 : i16 to f16
    return %4 : f16
  }
  func.func @test_permlane_var_cross_f16(%arg0: f16, %arg1: i32) -> f16 {
    %0 = llvm.bitcast %arg0 : f16 to i16
    %1 = llvm.zext %0 : i16 to i32
    %2 = rocdl.permlanex16.var %1, %1, %arg1, false, false : (i32, i32, i32) -> i32
    %3 = llvm.trunc %2 : i32 to i16
    %4 = llvm.bitcast %3 : i16 to f16
    return %4 : f16
  }
  func.func @test_permlane_var_4xf16(%arg0: vector<4xf16>, %arg1: i32) -> vector<4xf16> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.bitcast %arg0 : vector<4xf16> to vector<2xi32>
    %4 = llvm.extractelement %3[%2 : i32] : vector<2xi32>
    %5 = llvm.extractelement %3[%1 : i32] : vector<2xi32>
    %6 = rocdl.permlane16.var %4, %4, %arg1, false, false : (i32, i32, i32) -> i32
    %7 = rocdl.permlane16.var %5, %5, %arg1, false, false : (i32, i32, i32) -> i32
    %8 = llvm.insertelement %6, %0[%2 : i32] : vector<2xi32>
    %9 = llvm.insertelement %7, %8[%1 : i32] : vector<2xi32>
    %10 = llvm.bitcast %9 : vector<2xi32> to vector<4xf16>
    return %10 : vector<4xf16>
  }
  func.func @test_permlane_var_attrs(%arg0: i32, %arg1: i32) -> i32 {
    %0 = rocdl.permlanex16.var %arg0, %arg0, %arg1, true, true : (i32, i32, i32) -> i32
    return %0 : i32
  }
}

