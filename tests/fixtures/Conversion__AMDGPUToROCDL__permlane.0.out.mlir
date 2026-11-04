module {
  func.func @test_permlane16_i32(%arg0: i32) -> i32 {
    %0 = rocdl.permlane16.swap %arg0, %arg0, false, false : (i32, i32) -> <(i32, i32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.icmp "eq" %1, %arg0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    return %4 : i32
  }
  func.func @test_permlane16_i32_optional_attr(%arg0: i32) -> i32 {
    %0 = rocdl.permlane16.swap %arg0, %arg0, true, true : (i32, i32) -> <(i32, i32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.icmp "eq" %1, %arg0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    return %4 : i32
  }
  func.func @test_permlane32_i32(%arg0: i32) -> i32 {
    %0 = rocdl.permlane32.swap %arg0, %arg0, false, false : (i32, i32) -> <(i32, i32)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.icmp "eq" %1, %arg0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    return %4 : i32
  }
  func.func @test_permlane16_f32(%arg0: f32) -> f32 {
    %0 = llvm.bitcast %arg0 : f32 to i32
    %1 = rocdl.permlane16.swap %0, %0, false, false : (i32, i32) -> <(i32, i32)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i32)> 
    %4 = llvm.icmp "eq" %2, %0 : i32
    %5 = llvm.select %4, %3, %2 : i1, i32
    %6 = llvm.bitcast %5 : i32 to f32
    return %6 : f32
  }
  func.func @test_permlane32_f32(%arg0: f32) -> f32 {
    %0 = llvm.bitcast %arg0 : f32 to i32
    %1 = rocdl.permlane32.swap %0, %0, false, false : (i32, i32) -> <(i32, i32)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i32)> 
    %4 = llvm.icmp "eq" %2, %0 : i32
    %5 = llvm.select %4, %3, %2 : i1, i32
    %6 = llvm.bitcast %5 : i32 to f32
    return %6 : f32
  }
  func.func @test_permlane16_f16(%arg0: f16) -> f16 {
    %0 = llvm.bitcast %arg0 : f16 to i16
    %1 = llvm.zext %0 : i16 to i32
    %2 = rocdl.permlane16.swap %1, %1, false, false : (i32, i32) -> <(i32, i32)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i32)> 
    %5 = llvm.icmp "eq" %3, %1 : i32
    %6 = llvm.select %5, %4, %3 : i1, i32
    %7 = llvm.trunc %6 : i32 to i16
    %8 = llvm.bitcast %7 : i16 to f16
    return %8 : f16
  }
  func.func @test_permlane32_f16(%arg0: f16) -> f16 {
    %0 = llvm.bitcast %arg0 : f16 to i16
    %1 = llvm.zext %0 : i16 to i32
    %2 = rocdl.permlane32.swap %1, %1, false, false : (i32, i32) -> <(i32, i32)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i32)> 
    %5 = llvm.icmp "eq" %3, %1 : i32
    %6 = llvm.select %5, %4, %3 : i1, i32
    %7 = llvm.trunc %6 : i32 to i16
    %8 = llvm.bitcast %7 : i16 to f16
    return %8 : f16
  }
  func.func @test_permlane16_2xi32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%2 : i32] : vector<2xi32>
    %4 = llvm.extractelement %arg0[%1 : i32] : vector<2xi32>
    %5 = rocdl.permlane16.swap %3, %3, false, false : (i32, i32) -> <(i32, i32)>
    %6 = llvm.extractvalue %5[0] : !llvm.struct<(i32, i32)> 
    %7 = llvm.extractvalue %5[1] : !llvm.struct<(i32, i32)> 
    %8 = llvm.icmp "eq" %6, %3 : i32
    %9 = llvm.select %8, %7, %6 : i1, i32
    %10 = rocdl.permlane16.swap %4, %4, false, false : (i32, i32) -> <(i32, i32)>
    %11 = llvm.extractvalue %10[0] : !llvm.struct<(i32, i32)> 
    %12 = llvm.extractvalue %10[1] : !llvm.struct<(i32, i32)> 
    %13 = llvm.icmp "eq" %11, %4 : i32
    %14 = llvm.select %13, %12, %11 : i1, i32
    %15 = llvm.insertelement %9, %0[%2 : i32] : vector<2xi32>
    %16 = llvm.insertelement %14, %15[%1 : i32] : vector<2xi32>
    return %16 : vector<2xi32>
  }
  func.func @test_permlane32_2xi32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%2 : i32] : vector<2xi32>
    %4 = llvm.extractelement %arg0[%1 : i32] : vector<2xi32>
    %5 = rocdl.permlane32.swap %3, %3, false, false : (i32, i32) -> <(i32, i32)>
    %6 = llvm.extractvalue %5[0] : !llvm.struct<(i32, i32)> 
    %7 = llvm.extractvalue %5[1] : !llvm.struct<(i32, i32)> 
    %8 = llvm.icmp "eq" %6, %3 : i32
    %9 = llvm.select %8, %7, %6 : i1, i32
    %10 = rocdl.permlane32.swap %4, %4, false, false : (i32, i32) -> <(i32, i32)>
    %11 = llvm.extractvalue %10[0] : !llvm.struct<(i32, i32)> 
    %12 = llvm.extractvalue %10[1] : !llvm.struct<(i32, i32)> 
    %13 = llvm.icmp "eq" %11, %4 : i32
    %14 = llvm.select %13, %12, %11 : i1, i32
    %15 = llvm.insertelement %9, %0[%2 : i32] : vector<2xi32>
    %16 = llvm.insertelement %14, %15[%1 : i32] : vector<2xi32>
    return %16 : vector<2xi32>
  }
  func.func @test_permlane16_4xf16(%arg0: vector<4xf16>) -> vector<4xf16> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.bitcast %arg0 : vector<4xf16> to vector<2xi32>
    %4 = llvm.extractelement %3[%2 : i32] : vector<2xi32>
    %5 = llvm.extractelement %3[%1 : i32] : vector<2xi32>
    %6 = rocdl.permlane16.swap %4, %4, false, false : (i32, i32) -> <(i32, i32)>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(i32, i32)> 
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(i32, i32)> 
    %9 = llvm.icmp "eq" %7, %4 : i32
    %10 = llvm.select %9, %8, %7 : i1, i32
    %11 = rocdl.permlane16.swap %5, %5, false, false : (i32, i32) -> <(i32, i32)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(i32, i32)> 
    %13 = llvm.extractvalue %11[1] : !llvm.struct<(i32, i32)> 
    %14 = llvm.icmp "eq" %12, %5 : i32
    %15 = llvm.select %14, %13, %12 : i1, i32
    %16 = llvm.insertelement %10, %0[%2 : i32] : vector<2xi32>
    %17 = llvm.insertelement %15, %16[%1 : i32] : vector<2xi32>
    %18 = llvm.bitcast %17 : vector<2xi32> to vector<4xf16>
    return %18 : vector<4xf16>
  }
  func.func @test_permlane32_4xf16(%arg0: vector<4xf16>) -> vector<4xf16> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.bitcast %arg0 : vector<4xf16> to vector<2xi32>
    %4 = llvm.extractelement %3[%2 : i32] : vector<2xi32>
    %5 = llvm.extractelement %3[%1 : i32] : vector<2xi32>
    %6 = rocdl.permlane32.swap %4, %4, false, false : (i32, i32) -> <(i32, i32)>
    %7 = llvm.extractvalue %6[0] : !llvm.struct<(i32, i32)> 
    %8 = llvm.extractvalue %6[1] : !llvm.struct<(i32, i32)> 
    %9 = llvm.icmp "eq" %7, %4 : i32
    %10 = llvm.select %9, %8, %7 : i1, i32
    %11 = rocdl.permlane32.swap %5, %5, false, false : (i32, i32) -> <(i32, i32)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(i32, i32)> 
    %13 = llvm.extractvalue %11[1] : !llvm.struct<(i32, i32)> 
    %14 = llvm.icmp "eq" %12, %5 : i32
    %15 = llvm.select %14, %13, %12 : i1, i32
    %16 = llvm.insertelement %10, %0[%2 : i32] : vector<2xi32>
    %17 = llvm.insertelement %15, %16[%1 : i32] : vector<2xi32>
    %18 = llvm.bitcast %17 : vector<2xi32> to vector<4xf16>
    return %18 : vector<4xf16>
  }
}

