module {
  func.func @scalar_trunc(%arg0: f16) -> f8E5M2 {
    %cst = arith.constant -5.734400e+04 : f16
    %cst_0 = arith.constant 5.734400e+04 : f16
    %cst_1 = arith.constant 0x7C00 : f16
    %cst_2 = arith.constant 0xFC00 : f16
    %0 = arith.cmpf oeq, %arg0, %cst_1 : f16
    %1 = arith.cmpf oeq, %arg0, %cst_2 : f16
    %2 = arith.cmpf uno, %arg0, %arg0 : f16
    %3 = arith.ori %0, %1 : i1
    %4 = arith.ori %3, %2 : i1
    %5 = arith.maximumf %arg0, %cst : f16
    %6 = arith.minimumf %5, %cst_0 : f16
    %7 = arith.select %4, %arg0, %6 : f16
    %8 = arith.extf %7 : f16 to f32
    %9 = amdgpu.packed_trunc_2xfp8 %8, undef into undef[word 0] : f32 to vector<4xf8E5M2>
    %10 = vector.extract %9[0] : f8E5M2 from vector<4xf8E5M2>
    return %10 : f8E5M2
  }
}

// -----
module {
  func.func @vector_trunc_short(%arg0: vector<2xf32>) -> vector<2xf8E4M3FN> {
    %cst = arith.constant dense<-4.480000e+02> : vector<2xf32>
    %cst_0 = arith.constant dense<4.480000e+02> : vector<2xf32>
    %cst_1 = arith.constant dense<0x7F800000> : vector<2xf32>
    %cst_2 = arith.constant dense<0xFF800000> : vector<2xf32>
    %0 = arith.cmpf oeq, %arg0, %cst_1 : vector<2xf32>
    %1 = arith.cmpf oeq, %arg0, %cst_2 : vector<2xf32>
    %2 = arith.cmpf uno, %arg0, %arg0 : vector<2xf32>
    %3 = arith.ori %0, %1 : vector<2xi1>
    %4 = arith.ori %3, %2 : vector<2xi1>
    %5 = arith.maximumf %arg0, %cst : vector<2xf32>
    %6 = arith.minimumf %5, %cst_0 : vector<2xf32>
    %7 = arith.select %4, %arg0, %6 : vector<2xi1>, vector<2xf32>
    %8 = vector.extract %7[0] : f32 from vector<2xf32>
    %9 = vector.extract %7[1] : f32 from vector<2xf32>
    %10 = amdgpu.packed_trunc_2xfp8 %8, %9 into undef[word 0] : f32 to vector<4xf8E4M3FN>
    %11 = vector.extract_strided_slice %10 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf8E4M3FN> to vector<2xf8E4M3FN>
    return %11 : vector<2xf8E4M3FN>
  }
}

