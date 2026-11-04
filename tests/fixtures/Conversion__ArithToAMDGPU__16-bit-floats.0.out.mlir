module {
  func.func @scalar_trunc(%arg0: f32) -> f16 {
    %0 = llvm.mlir.poison : f32
    %1 = rocdl.cvt.pkrtz %arg0, %0 : vector<2xf16>
    %2 = vector.extract %1[0] : f16 from vector<2xf16>
    return %2 : f16
  }
  func.func @vector_trunc_short(%arg0: vector<2xf32>) -> vector<2xf16> {
    %0 = vector.extract %arg0[0] : f32 from vector<2xf32>
    %1 = vector.extract %arg0[1] : f32 from vector<2xf32>
    %2 = rocdl.cvt.pkrtz %0, %1 : vector<2xf16>
    return %2 : vector<2xf16>
  }
  func.func @vector_trunc_long(%arg0: vector<9xf32>) -> vector<9xf16> {
    %0 = llvm.mlir.poison : f32
    %cst = arith.constant dense<0.000000e+00> : vector<9xf16>
    %1 = vector.extract %arg0[0] : f32 from vector<9xf32>
    %2 = vector.extract %arg0[1] : f32 from vector<9xf32>
    %3 = rocdl.cvt.pkrtz %1, %2 : vector<2xf16>
    %4 = vector.insert_strided_slice %3, %cst {offsets = [0], strides = [1]} : vector<2xf16> into vector<9xf16>
    %5 = vector.extract %arg0[2] : f32 from vector<9xf32>
    %6 = vector.extract %arg0[3] : f32 from vector<9xf32>
    %7 = rocdl.cvt.pkrtz %5, %6 : vector<2xf16>
    %8 = vector.insert_strided_slice %7, %4 {offsets = [2], strides = [1]} : vector<2xf16> into vector<9xf16>
    %9 = vector.extract %arg0[4] : f32 from vector<9xf32>
    %10 = vector.extract %arg0[5] : f32 from vector<9xf32>
    %11 = rocdl.cvt.pkrtz %9, %10 : vector<2xf16>
    %12 = vector.insert_strided_slice %11, %8 {offsets = [4], strides = [1]} : vector<2xf16> into vector<9xf16>
    %13 = vector.extract %arg0[6] : f32 from vector<9xf32>
    %14 = vector.extract %arg0[7] : f32 from vector<9xf32>
    %15 = rocdl.cvt.pkrtz %13, %14 : vector<2xf16>
    %16 = vector.insert_strided_slice %15, %12 {offsets = [6], strides = [1]} : vector<2xf16> into vector<9xf16>
    %17 = vector.extract %arg0[8] : f32 from vector<9xf32>
    %18 = rocdl.cvt.pkrtz %17, %0 : vector<2xf16>
    %19 = vector.extract_strided_slice %18 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf16> to vector<1xf16>
    %20 = vector.insert_strided_slice %19, %16 {offsets = [8], strides = [1]} : vector<1xf16> into vector<9xf16>
    return %20 : vector<9xf16>
  }
}

