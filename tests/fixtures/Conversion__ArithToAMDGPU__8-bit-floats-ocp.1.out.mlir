module {
  func.func @scalar_ext(%arg0: f8E5M2) -> f16 {
    %0 = amdgpu.ext_packed_fp8 %arg0[0] : f8E5M2 to f32
    %1 = arith.truncf %0 : f32 to f16
    return %1 : f16
  }
}

// -----
module {
  func.func @vector_ext_short(%arg0: vector<2xf8E5M2>) -> vector<2xf64> {
    %0 = amdgpu.ext_packed_fp8 %arg0[0] : vector<2xf8E5M2> to vector<2xf32>
    %1 = arith.extf %0 : vector<2xf32> to vector<2xf64>
    return %1 : vector<2xf64>
  }
}

// -----
module {
  func.func @vector_ext_long(%arg0: vector<9xf8E4M3FN>) -> vector<9xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<9xf32>
    %0 = vector.extract_strided_slice %arg0 {offsets = [0], sizes = [4], strides = [1]} : vector<9xf8E4M3FN> to vector<4xf8E4M3FN>
    %1 = amdgpu.ext_packed_fp8 %0[0] : vector<4xf8E4M3FN> to vector<2xf32>
    %2 = vector.insert_strided_slice %1, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<9xf32>
    %3 = amdgpu.ext_packed_fp8 %0[1] : vector<4xf8E4M3FN> to vector<2xf32>
    %4 = vector.insert_strided_slice %3, %2 {offsets = [2], strides = [1]} : vector<2xf32> into vector<9xf32>
    %5 = vector.extract_strided_slice %arg0 {offsets = [4], sizes = [4], strides = [1]} : vector<9xf8E4M3FN> to vector<4xf8E4M3FN>
    %6 = amdgpu.ext_packed_fp8 %5[0] : vector<4xf8E4M3FN> to vector<2xf32>
    %7 = vector.insert_strided_slice %6, %4 {offsets = [4], strides = [1]} : vector<2xf32> into vector<9xf32>
    %8 = amdgpu.ext_packed_fp8 %5[1] : vector<4xf8E4M3FN> to vector<2xf32>
    %9 = vector.insert_strided_slice %8, %7 {offsets = [6], strides = [1]} : vector<2xf32> into vector<9xf32>
    %10 = vector.extract_strided_slice %arg0 {offsets = [8], sizes = [1], strides = [1]} : vector<9xf8E4M3FN> to vector<1xf8E4M3FN>
    %11 = amdgpu.ext_packed_fp8 %10[0] : vector<1xf8E4M3FN> to f32
    %12 = vector.insert %11, %9 [8] : f32 into vector<9xf32>
    return %12 : vector<9xf32>
  }
}

// -----
module {
  func.func @scalar_trunc(%arg0: f16) -> f8E5M2 {
    %0 = arith.extf %arg0 : f16 to f32
    %1 = amdgpu.packed_trunc_2xfp8 %0, undef into undef[word 0] : f32 to vector<4xf8E5M2>
    %2 = vector.extract %1[0] : f8E5M2 from vector<4xf8E5M2>
    return %2 : f8E5M2
  }
}

// -----
module {
  func.func @vector_trunc_short(%arg0: vector<2xf64>) -> vector<2xf8E5M2> {
    %0 = vector.extract %arg0[0] : f64 from vector<2xf64>
    %1 = arith.truncf %0 : f64 to f32
    %2 = vector.extract %arg0[1] : f64 from vector<2xf64>
    %3 = arith.truncf %2 : f64 to f32
    %4 = amdgpu.packed_trunc_2xfp8 %1, %3 into undef[word 0] : f32 to vector<4xf8E5M2>
    %5 = vector.extract_strided_slice %4 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf8E5M2> to vector<2xf8E5M2>
    return %5 : vector<2xf8E5M2>
  }
}

// -----
module {
  func.func @vector_trunc_long(%arg0: vector<9xf32>) -> vector<9xf8E4M3FN> {
    %cst = arith.constant dense<0.000000e+00> : vector<9xf8E4M3FN>
    %0 = vector.extract %arg0[0] : f32 from vector<9xf32>
    %1 = vector.extract %arg0[1] : f32 from vector<9xf32>
    %2 = amdgpu.packed_trunc_2xfp8 %0, %1 into undef[word 0] : f32 to vector<4xf8E4M3FN>
    %3 = vector.extract %arg0[2] : f32 from vector<9xf32>
    %4 = vector.extract %arg0[3] : f32 from vector<9xf32>
    %5 = amdgpu.packed_trunc_2xfp8 %3, %4 into %2[word 1] : f32 to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %6 = vector.insert_strided_slice %5, %cst {offsets = [0], strides = [1]} : vector<4xf8E4M3FN> into vector<9xf8E4M3FN>
    %7 = vector.extract %arg0[4] : f32 from vector<9xf32>
    %8 = vector.extract %arg0[5] : f32 from vector<9xf32>
    %9 = amdgpu.packed_trunc_2xfp8 %7, %8 into undef[word 0] : f32 to vector<4xf8E4M3FN>
    %10 = vector.extract %arg0[6] : f32 from vector<9xf32>
    %11 = vector.extract %arg0[7] : f32 from vector<9xf32>
    %12 = amdgpu.packed_trunc_2xfp8 %10, %11 into %9[word 1] : f32 to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %13 = vector.insert_strided_slice %12, %6 {offsets = [4], strides = [1]} : vector<4xf8E4M3FN> into vector<9xf8E4M3FN>
    %14 = vector.extract %arg0[8] : f32 from vector<9xf32>
    %15 = amdgpu.packed_trunc_2xfp8 %14, undef into undef[word 0] : f32 to vector<4xf8E4M3FN>
    %16 = vector.extract_strided_slice %15 {offsets = [0], sizes = [1], strides = [1]} : vector<4xf8E4M3FN> to vector<1xf8E4M3FN>
    %17 = vector.insert_strided_slice %16, %13 {offsets = [8], strides = [1]} : vector<1xf8E4M3FN> into vector<9xf8E4M3FN>
    return %17 : vector<9xf8E4M3FN>
  }
}

// -----
module {
  func.func @vector_trunc_long_2d(%arg0: vector<1x9xf32>) -> vector<1x9xf8E4M3FN> {
    %cst = arith.constant dense<0.000000e+00> : vector<9xf8E4M3FN>
    %0 = vector.extract %arg0[0, 0] : f32 from vector<1x9xf32>
    %1 = vector.extract %arg0[0, 1] : f32 from vector<1x9xf32>
    %2 = amdgpu.packed_trunc_2xfp8 %0, %1 into undef[word 0] : f32 to vector<4xf8E4M3FN>
    %3 = vector.extract %arg0[0, 2] : f32 from vector<1x9xf32>
    %4 = vector.extract %arg0[0, 3] : f32 from vector<1x9xf32>
    %5 = amdgpu.packed_trunc_2xfp8 %3, %4 into %2[word 1] : f32 to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %6 = vector.insert_strided_slice %5, %cst {offsets = [0], strides = [1]} : vector<4xf8E4M3FN> into vector<9xf8E4M3FN>
    %7 = vector.extract %arg0[0, 4] : f32 from vector<1x9xf32>
    %8 = vector.extract %arg0[0, 5] : f32 from vector<1x9xf32>
    %9 = amdgpu.packed_trunc_2xfp8 %7, %8 into undef[word 0] : f32 to vector<4xf8E4M3FN>
    %10 = vector.extract %arg0[0, 6] : f32 from vector<1x9xf32>
    %11 = vector.extract %arg0[0, 7] : f32 from vector<1x9xf32>
    %12 = amdgpu.packed_trunc_2xfp8 %10, %11 into %9[word 1] : f32 to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %13 = vector.insert_strided_slice %12, %6 {offsets = [4], strides = [1]} : vector<4xf8E4M3FN> into vector<9xf8E4M3FN>
    %14 = vector.extract %arg0[0, 8] : f32 from vector<1x9xf32>
    %15 = amdgpu.packed_trunc_2xfp8 %14, undef into undef[word 0] : f32 to vector<4xf8E4M3FN>
    %16 = vector.extract_strided_slice %15 {offsets = [0], sizes = [1], strides = [1]} : vector<4xf8E4M3FN> to vector<1xf8E4M3FN>
    %17 = vector.insert_strided_slice %16, %13 {offsets = [8], strides = [1]} : vector<1xf8E4M3FN> into vector<9xf8E4M3FN>
    %18 = vector.shape_cast %17 : vector<9xf8E4M3FN> to vector<1x9xf8E4M3FN>
    return %18 : vector<1x9xf8E4M3FN>
  }
}

// -----
module {
  func.func @vector_ext_long_2d(%arg0: vector<1x11xf8E4M3FN>) -> vector<1x11xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<11xf32>
    %0 = vector.shape_cast %arg0 : vector<1x11xf8E4M3FN> to vector<11xf8E4M3FN>
    %1 = vector.extract_strided_slice %0 {offsets = [0], sizes = [4], strides = [1]} : vector<11xf8E4M3FN> to vector<4xf8E4M3FN>
    %2 = amdgpu.ext_packed_fp8 %1[0] : vector<4xf8E4M3FN> to vector<2xf32>
    %3 = vector.insert_strided_slice %2, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<11xf32>
    %4 = amdgpu.ext_packed_fp8 %1[1] : vector<4xf8E4M3FN> to vector<2xf32>
    %5 = vector.insert_strided_slice %4, %3 {offsets = [2], strides = [1]} : vector<2xf32> into vector<11xf32>
    %6 = vector.extract_strided_slice %0 {offsets = [4], sizes = [4], strides = [1]} : vector<11xf8E4M3FN> to vector<4xf8E4M3FN>
    %7 = amdgpu.ext_packed_fp8 %6[0] : vector<4xf8E4M3FN> to vector<2xf32>
    %8 = vector.insert_strided_slice %7, %5 {offsets = [4], strides = [1]} : vector<2xf32> into vector<11xf32>
    %9 = amdgpu.ext_packed_fp8 %6[1] : vector<4xf8E4M3FN> to vector<2xf32>
    %10 = vector.insert_strided_slice %9, %8 {offsets = [6], strides = [1]} : vector<2xf32> into vector<11xf32>
    %11 = vector.extract_strided_slice %0 {offsets = [8], sizes = [3], strides = [1]} : vector<11xf8E4M3FN> to vector<3xf8E4M3FN>
    %12 = amdgpu.ext_packed_fp8 %11[0] : vector<3xf8E4M3FN> to vector<2xf32>
    %13 = vector.insert_strided_slice %12, %10 {offsets = [8], strides = [1]} : vector<2xf32> into vector<11xf32>
    %14 = amdgpu.ext_packed_fp8 %11[2] : vector<3xf8E4M3FN> to f32
    %15 = vector.insert %14, %13 [10] : f32 into vector<11xf32>
    %16 = vector.shape_cast %15 : vector<11xf32> to vector<1x11xf32>
    return %16 : vector<1x11xf32>
  }
}

