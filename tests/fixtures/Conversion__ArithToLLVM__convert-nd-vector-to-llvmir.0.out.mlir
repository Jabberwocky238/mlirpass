module {
  func.func @vec_bin(%arg0: vector<2x2x2xf32>) -> vector<2x2x2xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x2x2xf32> to !llvm.array<2 x array<2 x vector<2xf32>>>
    %1 = llvm.mlir.poison : !llvm.array<2 x array<2 x vector<2xf32>>>
    %2 = llvm.extractvalue %0[0, 0] : !llvm.array<2 x array<2 x vector<2xf32>>> 
    %3 = llvm.extractvalue %0[0, 0] : !llvm.array<2 x array<2 x vector<2xf32>>> 
    %4 = llvm.fadd %2, %3 : vector<2xf32>
    %5 = llvm.insertvalue %4, %1[0, 0] : !llvm.array<2 x array<2 x vector<2xf32>>> 
    %6 = llvm.extractvalue %0[0, 1] : !llvm.array<2 x array<2 x vector<2xf32>>> 
    %7 = llvm.extractvalue %0[0, 1] : !llvm.array<2 x array<2 x vector<2xf32>>> 
    %8 = llvm.fadd %6, %7 : vector<2xf32>
    %9 = llvm.insertvalue %8, %5[0, 1] : !llvm.array<2 x array<2 x vector<2xf32>>> 
    %10 = llvm.extractvalue %0[1, 0] : !llvm.array<2 x array<2 x vector<2xf32>>> 
    %11 = llvm.extractvalue %0[1, 0] : !llvm.array<2 x array<2 x vector<2xf32>>> 
    %12 = llvm.fadd %10, %11 : vector<2xf32>
    %13 = llvm.insertvalue %12, %9[1, 0] : !llvm.array<2 x array<2 x vector<2xf32>>> 
    %14 = llvm.extractvalue %0[1, 1] : !llvm.array<2 x array<2 x vector<2xf32>>> 
    %15 = llvm.extractvalue %0[1, 1] : !llvm.array<2 x array<2 x vector<2xf32>>> 
    %16 = llvm.fadd %14, %15 : vector<2xf32>
    %17 = llvm.insertvalue %16, %13[1, 1] : !llvm.array<2 x array<2 x vector<2xf32>>> 
    %18 = builtin.unrealized_conversion_cast %17 : !llvm.array<2 x array<2 x vector<2xf32>>> to vector<2x2x2xf32>
    return %18 : vector<2x2x2xf32>
  }
  func.func @sexti_vector(%arg0: vector<1x2x3xi32>, %arg1: vector<1x2x3xi64>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x2x3xi32> to !llvm.array<1 x array<2 x vector<3xi32>>>
    %1 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xi64>>>
    %2 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<2 x vector<3xi32>>> 
    %3 = llvm.sext %2 : vector<3xi32> to vector<3xi64>
    %4 = llvm.insertvalue %3, %1[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %5 = llvm.extractvalue %0[0, 1] : !llvm.array<1 x array<2 x vector<3xi32>>> 
    %6 = llvm.sext %5 : vector<3xi32> to vector<3xi64>
    %7 = llvm.insertvalue %6, %4[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    return
  }
  func.func @zexti_vector(%arg0: vector<1x2x3xi32>, %arg1: vector<1x2x3xi64>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x2x3xi32> to !llvm.array<1 x array<2 x vector<3xi32>>>
    %1 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xi64>>>
    %2 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<2 x vector<3xi32>>> 
    %3 = llvm.zext %2 : vector<3xi32> to vector<3xi64>
    %4 = llvm.insertvalue %3, %1[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %5 = llvm.extractvalue %0[0, 1] : !llvm.array<1 x array<2 x vector<3xi32>>> 
    %6 = llvm.zext %5 : vector<3xi32> to vector<3xi64>
    %7 = llvm.insertvalue %6, %4[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    return
  }
  func.func @sitofp_vector(%arg0: vector<1x2x3xi32>) -> vector<1x2x3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x2x3xi32> to !llvm.array<1 x array<2 x vector<3xi32>>>
    %1 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xf32>>>
    %2 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<2 x vector<3xi32>>> 
    %3 = llvm.sitofp %2 : vector<3xi32> to vector<3xf32>
    %4 = llvm.insertvalue %3, %1[0, 0] : !llvm.array<1 x array<2 x vector<3xf32>>> 
    %5 = llvm.extractvalue %0[0, 1] : !llvm.array<1 x array<2 x vector<3xi32>>> 
    %6 = llvm.sitofp %5 : vector<3xi32> to vector<3xf32>
    %7 = llvm.insertvalue %6, %4[0, 1] : !llvm.array<1 x array<2 x vector<3xf32>>> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.array<1 x array<2 x vector<3xf32>>> to vector<1x2x3xf32>
    return %8 : vector<1x2x3xf32>
  }
  func.func @uitofp_vector(%arg0: vector<1x2x3xi32>) -> vector<1x2x3xf32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x2x3xi32> to !llvm.array<1 x array<2 x vector<3xi32>>>
    %1 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xf32>>>
    %2 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<2 x vector<3xi32>>> 
    %3 = llvm.uitofp %2 : vector<3xi32> to vector<3xf32>
    %4 = llvm.insertvalue %3, %1[0, 0] : !llvm.array<1 x array<2 x vector<3xf32>>> 
    %5 = llvm.extractvalue %0[0, 1] : !llvm.array<1 x array<2 x vector<3xi32>>> 
    %6 = llvm.uitofp %5 : vector<3xi32> to vector<3xf32>
    %7 = llvm.insertvalue %6, %4[0, 1] : !llvm.array<1 x array<2 x vector<3xf32>>> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.array<1 x array<2 x vector<3xf32>>> to vector<1x2x3xf32>
    return %8 : vector<1x2x3xf32>
  }
  func.func @fptosi_vector(%arg0: vector<1x2x3xf32>) -> vector<1x2x3xi32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x2x3xf32> to !llvm.array<1 x array<2 x vector<3xf32>>>
    %1 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xi32>>>
    %2 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<2 x vector<3xf32>>> 
    %3 = llvm.fptosi %2 : vector<3xf32> to vector<3xi32>
    %4 = llvm.insertvalue %3, %1[0, 0] : !llvm.array<1 x array<2 x vector<3xi32>>> 
    %5 = llvm.extractvalue %0[0, 1] : !llvm.array<1 x array<2 x vector<3xf32>>> 
    %6 = llvm.fptosi %5 : vector<3xf32> to vector<3xi32>
    %7 = llvm.insertvalue %6, %4[0, 1] : !llvm.array<1 x array<2 x vector<3xi32>>> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.array<1 x array<2 x vector<3xi32>>> to vector<1x2x3xi32>
    return %8 : vector<1x2x3xi32>
  }
  func.func @fptoui_vector(%arg0: vector<1x2x3xf32>) -> vector<1x2x3xi32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x2x3xf32> to !llvm.array<1 x array<2 x vector<3xf32>>>
    %1 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xi32>>>
    %2 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<2 x vector<3xf32>>> 
    %3 = llvm.fptoui %2 : vector<3xf32> to vector<3xi32>
    %4 = llvm.insertvalue %3, %1[0, 0] : !llvm.array<1 x array<2 x vector<3xi32>>> 
    %5 = llvm.extractvalue %0[0, 1] : !llvm.array<1 x array<2 x vector<3xf32>>> 
    %6 = llvm.fptoui %5 : vector<3xf32> to vector<3xi32>
    %7 = llvm.insertvalue %6, %4[0, 1] : !llvm.array<1 x array<2 x vector<3xi32>>> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.array<1 x array<2 x vector<3xi32>>> to vector<1x2x3xi32>
    return %8 : vector<1x2x3xi32>
  }
  func.func @fpext_vector(%arg0: vector<1x2x3xf16>) -> vector<1x2x3xf64> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x2x3xf16> to !llvm.array<1 x array<2 x vector<3xf16>>>
    %1 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xf64>>>
    %2 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<2 x vector<3xf16>>> 
    %3 = llvm.fpext %2 : vector<3xf16> to vector<3xf64>
    %4 = llvm.insertvalue %3, %1[0, 0] : !llvm.array<1 x array<2 x vector<3xf64>>> 
    %5 = llvm.extractvalue %0[0, 1] : !llvm.array<1 x array<2 x vector<3xf16>>> 
    %6 = llvm.fpext %5 : vector<3xf16> to vector<3xf64>
    %7 = llvm.insertvalue %6, %4[0, 1] : !llvm.array<1 x array<2 x vector<3xf64>>> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.array<1 x array<2 x vector<3xf64>>> to vector<1x2x3xf64>
    return %8 : vector<1x2x3xf64>
  }
  func.func @fptrunc_vector(%arg0: vector<1x2x3xf64>) -> vector<1x2x3xf16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x2x3xf64> to !llvm.array<1 x array<2 x vector<3xf64>>>
    %1 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xf16>>>
    %2 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<2 x vector<3xf64>>> 
    %3 = llvm.fptrunc %2 : vector<3xf64> to vector<3xf16>
    %4 = llvm.insertvalue %3, %1[0, 0] : !llvm.array<1 x array<2 x vector<3xf16>>> 
    %5 = llvm.extractvalue %0[0, 1] : !llvm.array<1 x array<2 x vector<3xf64>>> 
    %6 = llvm.fptrunc %5 : vector<3xf64> to vector<3xf16>
    %7 = llvm.insertvalue %6, %4[0, 1] : !llvm.array<1 x array<2 x vector<3xf16>>> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.array<1 x array<2 x vector<3xf16>>> to vector<1x2x3xf16>
    return %8 : vector<1x2x3xf16>
  }
  func.func @trunci_vector(%arg0: vector<1x2x3xi64>) -> vector<1x2x3xi16> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x2x3xi64> to !llvm.array<1 x array<2 x vector<3xi64>>>
    %1 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xi16>>>
    %2 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %3 = llvm.trunc %2 : vector<3xi64> to vector<3xi16>
    %4 = llvm.insertvalue %3, %1[0, 0] : !llvm.array<1 x array<2 x vector<3xi16>>> 
    %5 = llvm.extractvalue %0[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %6 = llvm.trunc %5 : vector<3xi64> to vector<3xi16>
    %7 = llvm.insertvalue %6, %4[0, 1] : !llvm.array<1 x array<2 x vector<3xi16>>> 
    %8 = builtin.unrealized_conversion_cast %7 : !llvm.array<1 x array<2 x vector<3xi16>>> to vector<1x2x3xi16>
    return %8 : vector<1x2x3xi16>
  }
  func.func @shl_vector(%arg0: vector<1x2x3xi64>) -> vector<1x2x3xi64> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x2x3xi64> to !llvm.array<1 x array<2 x vector<3xi64>>>
    %1 = llvm.mlir.constant(dense<1> : vector<1x2x3xi64>) : !llvm.array<1 x array<2 x vector<3xi64>>>
    %2 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xi64>>>
    %3 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %4 = llvm.extractvalue %1[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %5 = llvm.shl %3, %4 : vector<3xi64>
    %6 = llvm.insertvalue %5, %2[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %7 = llvm.extractvalue %0[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %8 = llvm.extractvalue %1[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %9 = llvm.shl %7, %8 : vector<3xi64>
    %10 = llvm.insertvalue %9, %6[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %11 = builtin.unrealized_conversion_cast %10 : !llvm.array<1 x array<2 x vector<3xi64>>> to vector<1x2x3xi64>
    return %11 : vector<1x2x3xi64>
  }
  func.func @shrs_vector(%arg0: vector<1x2x3xi64>) -> vector<1x2x3xi64> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x2x3xi64> to !llvm.array<1 x array<2 x vector<3xi64>>>
    %1 = llvm.mlir.constant(dense<1> : vector<1x2x3xi64>) : !llvm.array<1 x array<2 x vector<3xi64>>>
    %2 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xi64>>>
    %3 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %4 = llvm.extractvalue %1[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %5 = llvm.ashr %3, %4 : vector<3xi64>
    %6 = llvm.insertvalue %5, %2[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %7 = llvm.extractvalue %0[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %8 = llvm.extractvalue %1[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %9 = llvm.ashr %7, %8 : vector<3xi64>
    %10 = llvm.insertvalue %9, %6[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %11 = builtin.unrealized_conversion_cast %10 : !llvm.array<1 x array<2 x vector<3xi64>>> to vector<1x2x3xi64>
    return %11 : vector<1x2x3xi64>
  }
  func.func @shru_vector(%arg0: vector<1x2x3xi64>) -> vector<1x2x3xi64> {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x2x3xi64> to !llvm.array<1 x array<2 x vector<3xi64>>>
    %1 = llvm.mlir.constant(dense<1> : vector<1x2x3xi64>) : !llvm.array<1 x array<2 x vector<3xi64>>>
    %2 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xi64>>>
    %3 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %4 = llvm.extractvalue %1[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %5 = llvm.lshr %3, %4 : vector<3xi64>
    %6 = llvm.insertvalue %5, %2[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %7 = llvm.extractvalue %0[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %8 = llvm.extractvalue %1[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %9 = llvm.lshr %7, %8 : vector<3xi64>
    %10 = llvm.insertvalue %9, %6[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %11 = builtin.unrealized_conversion_cast %10 : !llvm.array<1 x array<2 x vector<3xi64>>> to vector<1x2x3xi64>
    return %11 : vector<1x2x3xi64>
  }
}

// -----
module {
  func.func @bitcast_2d(%arg0: vector<2x4xf32>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<2x4xf32> to !llvm.array<2 x vector<4xf32>>
    %1 = llvm.mlir.poison : !llvm.array<2 x vector<4xi32>>
    %2 = llvm.extractvalue %0[0] : !llvm.array<2 x vector<4xf32>> 
    %3 = llvm.bitcast %2 : vector<4xf32> to vector<4xi32>
    %4 = llvm.insertvalue %3, %1[0] : !llvm.array<2 x vector<4xi32>> 
    %5 = llvm.extractvalue %0[1] : !llvm.array<2 x vector<4xf32>> 
    %6 = llvm.bitcast %5 : vector<4xf32> to vector<4xi32>
    %7 = llvm.insertvalue %6, %4[1] : !llvm.array<2 x vector<4xi32>> 
    return
  }
}

// -----
module {
  func.func @select_2d(%arg0: vector<4x3xi1>, %arg1: vector<4x3xi32>, %arg2: vector<4x3xi32>) {
    %0 = builtin.unrealized_conversion_cast %arg2 : vector<4x3xi32> to !llvm.array<4 x vector<3xi32>>
    %1 = builtin.unrealized_conversion_cast %arg1 : vector<4x3xi32> to !llvm.array<4 x vector<3xi32>>
    %2 = builtin.unrealized_conversion_cast %arg0 : vector<4x3xi1> to !llvm.array<4 x vector<3xi1>>
    %3 = llvm.mlir.poison : !llvm.array<4 x vector<3xi32>>
    %4 = llvm.extractvalue %2[0] : !llvm.array<4 x vector<3xi1>> 
    %5 = llvm.extractvalue %1[0] : !llvm.array<4 x vector<3xi32>> 
    %6 = llvm.extractvalue %0[0] : !llvm.array<4 x vector<3xi32>> 
    %7 = llvm.select %4, %5, %6 : vector<3xi1>, vector<3xi32>
    %8 = llvm.insertvalue %7, %3[0] : !llvm.array<4 x vector<3xi32>> 
    %9 = llvm.extractvalue %2[1] : !llvm.array<4 x vector<3xi1>> 
    %10 = llvm.extractvalue %1[1] : !llvm.array<4 x vector<3xi32>> 
    %11 = llvm.extractvalue %0[1] : !llvm.array<4 x vector<3xi32>> 
    %12 = llvm.select %9, %10, %11 : vector<3xi1>, vector<3xi32>
    %13 = llvm.insertvalue %12, %8[1] : !llvm.array<4 x vector<3xi32>> 
    %14 = llvm.extractvalue %2[2] : !llvm.array<4 x vector<3xi1>> 
    %15 = llvm.extractvalue %1[2] : !llvm.array<4 x vector<3xi32>> 
    %16 = llvm.extractvalue %0[2] : !llvm.array<4 x vector<3xi32>> 
    %17 = llvm.select %14, %15, %16 : vector<3xi1>, vector<3xi32>
    %18 = llvm.insertvalue %17, %13[2] : !llvm.array<4 x vector<3xi32>> 
    %19 = llvm.extractvalue %2[3] : !llvm.array<4 x vector<3xi1>> 
    %20 = llvm.extractvalue %1[3] : !llvm.array<4 x vector<3xi32>> 
    %21 = llvm.extractvalue %0[3] : !llvm.array<4 x vector<3xi32>> 
    %22 = llvm.select %19, %20, %21 : vector<3xi1>, vector<3xi32>
    %23 = llvm.insertvalue %22, %18[3] : !llvm.array<4 x vector<3xi32>> 
    return
  }
  func.func @index_cast_2d(%arg0: vector<1x2x3xi1>) {
    %0 = builtin.unrealized_conversion_cast %arg0 : vector<1x2x3xi1> to !llvm.array<1 x array<2 x vector<3xi1>>>
    %1 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xi64>>>
    %2 = llvm.extractvalue %0[0, 0] : !llvm.array<1 x array<2 x vector<3xi1>>> 
    %3 = llvm.sext %2 : vector<3xi1> to vector<3xi64>
    %4 = llvm.insertvalue %3, %1[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %5 = llvm.extractvalue %0[0, 1] : !llvm.array<1 x array<2 x vector<3xi1>>> 
    %6 = llvm.sext %5 : vector<3xi1> to vector<3xi64>
    %7 = llvm.insertvalue %6, %4[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %8 = llvm.mlir.poison : !llvm.array<1 x array<2 x vector<3xi1>>>
    %9 = llvm.extractvalue %7[0, 0] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %10 = llvm.trunc %9 : vector<3xi64> to vector<3xi1>
    %11 = llvm.insertvalue %10, %8[0, 0] : !llvm.array<1 x array<2 x vector<3xi1>>> 
    %12 = llvm.extractvalue %7[0, 1] : !llvm.array<1 x array<2 x vector<3xi64>>> 
    %13 = llvm.trunc %12 : vector<3xi64> to vector<3xi1>
    %14 = llvm.insertvalue %13, %11[0, 1] : !llvm.array<1 x array<2 x vector<3xi1>>> 
    return
  }
}

