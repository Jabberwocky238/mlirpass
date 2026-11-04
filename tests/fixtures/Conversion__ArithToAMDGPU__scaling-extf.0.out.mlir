module {
  func.func @conversion_f8_f32_fallback(%arg0: vector<2x2xf8E5M2>, %arg1: vector<2x2xf8E8M0FNU>) -> vector<2x2xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<2x2xf32>
    %0 = arith.extf %arg1 : vector<2x2xf8E8M0FNU> to vector<2x2xf32>
    %1 = vector.extract_strided_slice %arg0 {offsets = [0, 0], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf8E5M2> to vector<1x1xf8E5M2>
    %2 = vector.shape_cast %1 : vector<1x1xf8E5M2> to vector<1xf8E5M2>
    %3 = vector.extract %0[0, 0] : f32 from vector<2x2xf32>
    %4 = amdgpu.scaled_ext_packed %2[0], %3 : vector<1xf8E5M2> to vector<2xf32>
    %5 = vector.extract_strided_slice %4 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf32> to vector<1xf32>
    %6 = vector.shape_cast %5 : vector<1xf32> to vector<1x1xf32>
    %7 = vector.insert_strided_slice %6, %cst {offsets = [0, 0], strides = [1, 1]} : vector<1x1xf32> into vector<2x2xf32>
    %8 = vector.extract_strided_slice %arg0 {offsets = [0, 1], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf8E5M2> to vector<1x1xf8E5M2>
    %9 = vector.shape_cast %8 : vector<1x1xf8E5M2> to vector<1xf8E5M2>
    %10 = vector.extract %0[0, 1] : f32 from vector<2x2xf32>
    %11 = amdgpu.scaled_ext_packed %9[0], %10 : vector<1xf8E5M2> to vector<2xf32>
    %12 = vector.extract_strided_slice %11 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf32> to vector<1xf32>
    %13 = vector.shape_cast %12 : vector<1xf32> to vector<1x1xf32>
    %14 = vector.insert_strided_slice %13, %7 {offsets = [0, 1], strides = [1, 1]} : vector<1x1xf32> into vector<2x2xf32>
    %15 = vector.extract_strided_slice %arg0 {offsets = [1, 0], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf8E5M2> to vector<1x1xf8E5M2>
    %16 = vector.shape_cast %15 : vector<1x1xf8E5M2> to vector<1xf8E5M2>
    %17 = vector.extract %0[1, 0] : f32 from vector<2x2xf32>
    %18 = amdgpu.scaled_ext_packed %16[0], %17 : vector<1xf8E5M2> to vector<2xf32>
    %19 = vector.extract_strided_slice %18 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf32> to vector<1xf32>
    %20 = vector.shape_cast %19 : vector<1xf32> to vector<1x1xf32>
    %21 = vector.insert_strided_slice %20, %14 {offsets = [1, 0], strides = [1, 1]} : vector<1x1xf32> into vector<2x2xf32>
    %22 = vector.extract_strided_slice %arg0 {offsets = [1, 1], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf8E5M2> to vector<1x1xf8E5M2>
    %23 = vector.shape_cast %22 : vector<1x1xf8E5M2> to vector<1xf8E5M2>
    %24 = vector.extract %0[1, 1] : f32 from vector<2x2xf32>
    %25 = amdgpu.scaled_ext_packed %23[0], %24 : vector<1xf8E5M2> to vector<2xf32>
    %26 = vector.extract_strided_slice %25 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf32> to vector<1xf32>
    %27 = vector.shape_cast %26 : vector<1xf32> to vector<1x1xf32>
    %28 = vector.insert_strided_slice %27, %21 {offsets = [1, 1], strides = [1, 1]} : vector<1x1xf32> into vector<2x2xf32>
    return %28 : vector<2x2xf32>
  }
}

// -----
module {
  func.func @conversion_f4_f32_fallback(%arg0: vector<2x2xf4E2M1FN>, %arg1: vector<2x2xf8E8M0FNU>) -> vector<2x2xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<2x2xf32>
    %0 = arith.extf %arg1 : vector<2x2xf8E8M0FNU> to vector<2x2xf32>
    %1 = vector.extract_strided_slice %arg0 {offsets = [0, 0], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf4E2M1FN> to vector<1x1xf4E2M1FN>
    %2 = vector.shape_cast %1 : vector<1x1xf4E2M1FN> to vector<1xf4E2M1FN>
    %3 = vector.extract %0[0, 0] : f32 from vector<2x2xf32>
    %4 = amdgpu.scaled_ext_packed %2[0], %3 : vector<1xf4E2M1FN> to vector<2xf32>
    %5 = vector.extract_strided_slice %4 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf32> to vector<1xf32>
    %6 = vector.shape_cast %5 : vector<1xf32> to vector<1x1xf32>
    %7 = vector.insert_strided_slice %6, %cst {offsets = [0, 0], strides = [1, 1]} : vector<1x1xf32> into vector<2x2xf32>
    %8 = vector.extract_strided_slice %arg0 {offsets = [0, 1], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf4E2M1FN> to vector<1x1xf4E2M1FN>
    %9 = vector.shape_cast %8 : vector<1x1xf4E2M1FN> to vector<1xf4E2M1FN>
    %10 = vector.extract %0[0, 1] : f32 from vector<2x2xf32>
    %11 = amdgpu.scaled_ext_packed %9[0], %10 : vector<1xf4E2M1FN> to vector<2xf32>
    %12 = vector.extract_strided_slice %11 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf32> to vector<1xf32>
    %13 = vector.shape_cast %12 : vector<1xf32> to vector<1x1xf32>
    %14 = vector.insert_strided_slice %13, %7 {offsets = [0, 1], strides = [1, 1]} : vector<1x1xf32> into vector<2x2xf32>
    %15 = vector.extract_strided_slice %arg0 {offsets = [1, 0], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf4E2M1FN> to vector<1x1xf4E2M1FN>
    %16 = vector.shape_cast %15 : vector<1x1xf4E2M1FN> to vector<1xf4E2M1FN>
    %17 = vector.extract %0[1, 0] : f32 from vector<2x2xf32>
    %18 = amdgpu.scaled_ext_packed %16[0], %17 : vector<1xf4E2M1FN> to vector<2xf32>
    %19 = vector.extract_strided_slice %18 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf32> to vector<1xf32>
    %20 = vector.shape_cast %19 : vector<1xf32> to vector<1x1xf32>
    %21 = vector.insert_strided_slice %20, %14 {offsets = [1, 0], strides = [1, 1]} : vector<1x1xf32> into vector<2x2xf32>
    %22 = vector.extract_strided_slice %arg0 {offsets = [1, 1], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf4E2M1FN> to vector<1x1xf4E2M1FN>
    %23 = vector.shape_cast %22 : vector<1x1xf4E2M1FN> to vector<1xf4E2M1FN>
    %24 = vector.extract %0[1, 1] : f32 from vector<2x2xf32>
    %25 = amdgpu.scaled_ext_packed %23[0], %24 : vector<1xf4E2M1FN> to vector<2xf32>
    %26 = vector.extract_strided_slice %25 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf32> to vector<1xf32>
    %27 = vector.shape_cast %26 : vector<1xf32> to vector<1x1xf32>
    %28 = vector.insert_strided_slice %27, %21 {offsets = [1, 1], strides = [1, 1]} : vector<1x1xf32> into vector<2x2xf32>
    return %28 : vector<2x2xf32>
  }
}

// -----
module {
  func.func @conversion_f8_f16_fallback(%arg0: vector<2x2xf8E5M2>, %arg1: vector<2x2xf8E8M0FNU>) -> vector<2x2xf16> {
    %cst = arith.constant dense<0.000000e+00> : vector<2x2xf16>
    %0 = arith.extf %arg1 : vector<2x2xf8E8M0FNU> to vector<2x2xf32>
    %1 = vector.extract_strided_slice %arg0 {offsets = [0, 0], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf8E5M2> to vector<1x1xf8E5M2>
    %2 = vector.shape_cast %1 : vector<1x1xf8E5M2> to vector<1xf8E5M2>
    %3 = vector.extract %0[0, 0] : f32 from vector<2x2xf32>
    %4 = amdgpu.scaled_ext_packed %2[0], %3 : vector<1xf8E5M2> to vector<2xf16>
    %5 = vector.extract_strided_slice %4 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf16> to vector<1xf16>
    %6 = vector.shape_cast %5 : vector<1xf16> to vector<1x1xf16>
    %7 = vector.insert_strided_slice %6, %cst {offsets = [0, 0], strides = [1, 1]} : vector<1x1xf16> into vector<2x2xf16>
    %8 = vector.extract_strided_slice %arg0 {offsets = [0, 1], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf8E5M2> to vector<1x1xf8E5M2>
    %9 = vector.shape_cast %8 : vector<1x1xf8E5M2> to vector<1xf8E5M2>
    %10 = vector.extract %0[0, 1] : f32 from vector<2x2xf32>
    %11 = amdgpu.scaled_ext_packed %9[0], %10 : vector<1xf8E5M2> to vector<2xf16>
    %12 = vector.extract_strided_slice %11 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf16> to vector<1xf16>
    %13 = vector.shape_cast %12 : vector<1xf16> to vector<1x1xf16>
    %14 = vector.insert_strided_slice %13, %7 {offsets = [0, 1], strides = [1, 1]} : vector<1x1xf16> into vector<2x2xf16>
    %15 = vector.extract_strided_slice %arg0 {offsets = [1, 0], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf8E5M2> to vector<1x1xf8E5M2>
    %16 = vector.shape_cast %15 : vector<1x1xf8E5M2> to vector<1xf8E5M2>
    %17 = vector.extract %0[1, 0] : f32 from vector<2x2xf32>
    %18 = amdgpu.scaled_ext_packed %16[0], %17 : vector<1xf8E5M2> to vector<2xf16>
    %19 = vector.extract_strided_slice %18 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf16> to vector<1xf16>
    %20 = vector.shape_cast %19 : vector<1xf16> to vector<1x1xf16>
    %21 = vector.insert_strided_slice %20, %14 {offsets = [1, 0], strides = [1, 1]} : vector<1x1xf16> into vector<2x2xf16>
    %22 = vector.extract_strided_slice %arg0 {offsets = [1, 1], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf8E5M2> to vector<1x1xf8E5M2>
    %23 = vector.shape_cast %22 : vector<1x1xf8E5M2> to vector<1xf8E5M2>
    %24 = vector.extract %0[1, 1] : f32 from vector<2x2xf32>
    %25 = amdgpu.scaled_ext_packed %23[0], %24 : vector<1xf8E5M2> to vector<2xf16>
    %26 = vector.extract_strided_slice %25 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf16> to vector<1xf16>
    %27 = vector.shape_cast %26 : vector<1xf16> to vector<1x1xf16>
    %28 = vector.insert_strided_slice %27, %21 {offsets = [1, 1], strides = [1, 1]} : vector<1x1xf16> into vector<2x2xf16>
    return %28 : vector<2x2xf16>
  }
}

// -----
module {
  func.func @conversion_f4_f16_fallback(%arg0: vector<2x2xf4E2M1FN>, %arg1: vector<2x2xf8E8M0FNU>) -> vector<2x2xf16> {
    %cst = arith.constant dense<0.000000e+00> : vector<2x2xf16>
    %0 = arith.extf %arg1 : vector<2x2xf8E8M0FNU> to vector<2x2xf32>
    %1 = vector.extract_strided_slice %arg0 {offsets = [0, 0], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf4E2M1FN> to vector<1x1xf4E2M1FN>
    %2 = vector.shape_cast %1 : vector<1x1xf4E2M1FN> to vector<1xf4E2M1FN>
    %3 = vector.extract %0[0, 0] : f32 from vector<2x2xf32>
    %4 = amdgpu.scaled_ext_packed %2[0], %3 : vector<1xf4E2M1FN> to vector<2xf16>
    %5 = vector.extract_strided_slice %4 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf16> to vector<1xf16>
    %6 = vector.shape_cast %5 : vector<1xf16> to vector<1x1xf16>
    %7 = vector.insert_strided_slice %6, %cst {offsets = [0, 0], strides = [1, 1]} : vector<1x1xf16> into vector<2x2xf16>
    %8 = vector.extract_strided_slice %arg0 {offsets = [0, 1], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf4E2M1FN> to vector<1x1xf4E2M1FN>
    %9 = vector.shape_cast %8 : vector<1x1xf4E2M1FN> to vector<1xf4E2M1FN>
    %10 = vector.extract %0[0, 1] : f32 from vector<2x2xf32>
    %11 = amdgpu.scaled_ext_packed %9[0], %10 : vector<1xf4E2M1FN> to vector<2xf16>
    %12 = vector.extract_strided_slice %11 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf16> to vector<1xf16>
    %13 = vector.shape_cast %12 : vector<1xf16> to vector<1x1xf16>
    %14 = vector.insert_strided_slice %13, %7 {offsets = [0, 1], strides = [1, 1]} : vector<1x1xf16> into vector<2x2xf16>
    %15 = vector.extract_strided_slice %arg0 {offsets = [1, 0], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf4E2M1FN> to vector<1x1xf4E2M1FN>
    %16 = vector.shape_cast %15 : vector<1x1xf4E2M1FN> to vector<1xf4E2M1FN>
    %17 = vector.extract %0[1, 0] : f32 from vector<2x2xf32>
    %18 = amdgpu.scaled_ext_packed %16[0], %17 : vector<1xf4E2M1FN> to vector<2xf16>
    %19 = vector.extract_strided_slice %18 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf16> to vector<1xf16>
    %20 = vector.shape_cast %19 : vector<1xf16> to vector<1x1xf16>
    %21 = vector.insert_strided_slice %20, %14 {offsets = [1, 0], strides = [1, 1]} : vector<1x1xf16> into vector<2x2xf16>
    %22 = vector.extract_strided_slice %arg0 {offsets = [1, 1], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf4E2M1FN> to vector<1x1xf4E2M1FN>
    %23 = vector.shape_cast %22 : vector<1x1xf4E2M1FN> to vector<1xf4E2M1FN>
    %24 = vector.extract %0[1, 1] : f32 from vector<2x2xf32>
    %25 = amdgpu.scaled_ext_packed %23[0], %24 : vector<1xf4E2M1FN> to vector<2xf16>
    %26 = vector.extract_strided_slice %25 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf16> to vector<1xf16>
    %27 = vector.shape_cast %26 : vector<1xf16> to vector<1x1xf16>
    %28 = vector.insert_strided_slice %27, %21 {offsets = [1, 1], strides = [1, 1]} : vector<1x1xf16> into vector<2x2xf16>
    return %28 : vector<2x2xf16>
  }
}

// -----
module {
  func.func @conversion_broadcast(%arg0: vector<8x8xf8E5M2>, %arg1: vector<8x2xf8E8M0FNU>) -> vector<8x8xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %cst_0 = arith.constant dense<0.000000e+00> : vector<8x2x4xf32>
    %0 = vector.broadcast %arg1 : vector<8x2xf8E8M0FNU> to vector<4x8x2xf8E8M0FNU>
    %1 = vector.shape_cast %arg0 : vector<8x8xf8E5M2> to vector<8x2x4xf8E5M2>
    %2 = vector.shape_cast %0 : vector<4x8x2xf8E8M0FNU> to vector<8x2x4xf8E8M0FNU>
    %3 = arith.extf %2 : vector<8x2x4xf8E8M0FNU> to vector<8x2x4xf32>
    %4 = vector.extract_strided_slice %1 {offsets = [0, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %5 = vector.shape_cast %4 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %6 = vector.extract %3[0, 0, 0] : f32 from vector<8x2x4xf32>
    %7 = amdgpu.scaled_ext_packed %5[0], %6 : vector<4xf8E5M2> to vector<2xf32>
    %8 = vector.insert_strided_slice %7, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %9 = amdgpu.scaled_ext_packed %5[1], %6 : vector<4xf8E5M2> to vector<2xf32>
    %10 = vector.insert_strided_slice %9, %8 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %11 = vector.shape_cast %10 : vector<4xf32> to vector<1x1x4xf32>
    %12 = vector.insert_strided_slice %11, %cst_0 {offsets = [0, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %13 = vector.extract_strided_slice %1 {offsets = [0, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %14 = vector.shape_cast %13 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %15 = vector.extract %3[0, 1, 0] : f32 from vector<8x2x4xf32>
    %16 = amdgpu.scaled_ext_packed %14[0], %15 : vector<4xf8E5M2> to vector<2xf32>
    %17 = vector.insert_strided_slice %16, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %18 = amdgpu.scaled_ext_packed %14[1], %15 : vector<4xf8E5M2> to vector<2xf32>
    %19 = vector.insert_strided_slice %18, %17 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %20 = vector.shape_cast %19 : vector<4xf32> to vector<1x1x4xf32>
    %21 = vector.insert_strided_slice %20, %12 {offsets = [0, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %22 = vector.extract_strided_slice %1 {offsets = [1, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %23 = vector.shape_cast %22 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %24 = vector.extract %3[1, 0, 0] : f32 from vector<8x2x4xf32>
    %25 = amdgpu.scaled_ext_packed %23[0], %24 : vector<4xf8E5M2> to vector<2xf32>
    %26 = vector.insert_strided_slice %25, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %27 = amdgpu.scaled_ext_packed %23[1], %24 : vector<4xf8E5M2> to vector<2xf32>
    %28 = vector.insert_strided_slice %27, %26 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %29 = vector.shape_cast %28 : vector<4xf32> to vector<1x1x4xf32>
    %30 = vector.insert_strided_slice %29, %21 {offsets = [1, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %31 = vector.extract_strided_slice %1 {offsets = [1, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %32 = vector.shape_cast %31 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %33 = vector.extract %3[1, 1, 0] : f32 from vector<8x2x4xf32>
    %34 = amdgpu.scaled_ext_packed %32[0], %33 : vector<4xf8E5M2> to vector<2xf32>
    %35 = vector.insert_strided_slice %34, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %36 = amdgpu.scaled_ext_packed %32[1], %33 : vector<4xf8E5M2> to vector<2xf32>
    %37 = vector.insert_strided_slice %36, %35 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %38 = vector.shape_cast %37 : vector<4xf32> to vector<1x1x4xf32>
    %39 = vector.insert_strided_slice %38, %30 {offsets = [1, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %40 = vector.extract_strided_slice %1 {offsets = [2, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %41 = vector.shape_cast %40 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %42 = vector.extract %3[2, 0, 0] : f32 from vector<8x2x4xf32>
    %43 = amdgpu.scaled_ext_packed %41[0], %42 : vector<4xf8E5M2> to vector<2xf32>
    %44 = vector.insert_strided_slice %43, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %45 = amdgpu.scaled_ext_packed %41[1], %42 : vector<4xf8E5M2> to vector<2xf32>
    %46 = vector.insert_strided_slice %45, %44 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %47 = vector.shape_cast %46 : vector<4xf32> to vector<1x1x4xf32>
    %48 = vector.insert_strided_slice %47, %39 {offsets = [2, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %49 = vector.extract_strided_slice %1 {offsets = [2, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %50 = vector.shape_cast %49 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %51 = vector.extract %3[2, 1, 0] : f32 from vector<8x2x4xf32>
    %52 = amdgpu.scaled_ext_packed %50[0], %51 : vector<4xf8E5M2> to vector<2xf32>
    %53 = vector.insert_strided_slice %52, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %54 = amdgpu.scaled_ext_packed %50[1], %51 : vector<4xf8E5M2> to vector<2xf32>
    %55 = vector.insert_strided_slice %54, %53 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %56 = vector.shape_cast %55 : vector<4xf32> to vector<1x1x4xf32>
    %57 = vector.insert_strided_slice %56, %48 {offsets = [2, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %58 = vector.extract_strided_slice %1 {offsets = [3, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %59 = vector.shape_cast %58 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %60 = vector.extract %3[3, 0, 0] : f32 from vector<8x2x4xf32>
    %61 = amdgpu.scaled_ext_packed %59[0], %60 : vector<4xf8E5M2> to vector<2xf32>
    %62 = vector.insert_strided_slice %61, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %63 = amdgpu.scaled_ext_packed %59[1], %60 : vector<4xf8E5M2> to vector<2xf32>
    %64 = vector.insert_strided_slice %63, %62 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %65 = vector.shape_cast %64 : vector<4xf32> to vector<1x1x4xf32>
    %66 = vector.insert_strided_slice %65, %57 {offsets = [3, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %67 = vector.extract_strided_slice %1 {offsets = [3, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %68 = vector.shape_cast %67 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %69 = vector.extract %3[3, 1, 0] : f32 from vector<8x2x4xf32>
    %70 = amdgpu.scaled_ext_packed %68[0], %69 : vector<4xf8E5M2> to vector<2xf32>
    %71 = vector.insert_strided_slice %70, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %72 = amdgpu.scaled_ext_packed %68[1], %69 : vector<4xf8E5M2> to vector<2xf32>
    %73 = vector.insert_strided_slice %72, %71 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %74 = vector.shape_cast %73 : vector<4xf32> to vector<1x1x4xf32>
    %75 = vector.insert_strided_slice %74, %66 {offsets = [3, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %76 = vector.extract_strided_slice %1 {offsets = [4, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %77 = vector.shape_cast %76 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %78 = vector.extract %3[4, 0, 0] : f32 from vector<8x2x4xf32>
    %79 = amdgpu.scaled_ext_packed %77[0], %78 : vector<4xf8E5M2> to vector<2xf32>
    %80 = vector.insert_strided_slice %79, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %81 = amdgpu.scaled_ext_packed %77[1], %78 : vector<4xf8E5M2> to vector<2xf32>
    %82 = vector.insert_strided_slice %81, %80 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %83 = vector.shape_cast %82 : vector<4xf32> to vector<1x1x4xf32>
    %84 = vector.insert_strided_slice %83, %75 {offsets = [4, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %85 = vector.extract_strided_slice %1 {offsets = [4, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %86 = vector.shape_cast %85 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %87 = vector.extract %3[4, 1, 0] : f32 from vector<8x2x4xf32>
    %88 = amdgpu.scaled_ext_packed %86[0], %87 : vector<4xf8E5M2> to vector<2xf32>
    %89 = vector.insert_strided_slice %88, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %90 = amdgpu.scaled_ext_packed %86[1], %87 : vector<4xf8E5M2> to vector<2xf32>
    %91 = vector.insert_strided_slice %90, %89 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %92 = vector.shape_cast %91 : vector<4xf32> to vector<1x1x4xf32>
    %93 = vector.insert_strided_slice %92, %84 {offsets = [4, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %94 = vector.extract_strided_slice %1 {offsets = [5, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %95 = vector.shape_cast %94 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %96 = vector.extract %3[5, 0, 0] : f32 from vector<8x2x4xf32>
    %97 = amdgpu.scaled_ext_packed %95[0], %96 : vector<4xf8E5M2> to vector<2xf32>
    %98 = vector.insert_strided_slice %97, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %99 = amdgpu.scaled_ext_packed %95[1], %96 : vector<4xf8E5M2> to vector<2xf32>
    %100 = vector.insert_strided_slice %99, %98 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %101 = vector.shape_cast %100 : vector<4xf32> to vector<1x1x4xf32>
    %102 = vector.insert_strided_slice %101, %93 {offsets = [5, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %103 = vector.extract_strided_slice %1 {offsets = [5, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %104 = vector.shape_cast %103 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %105 = vector.extract %3[5, 1, 0] : f32 from vector<8x2x4xf32>
    %106 = amdgpu.scaled_ext_packed %104[0], %105 : vector<4xf8E5M2> to vector<2xf32>
    %107 = vector.insert_strided_slice %106, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %108 = amdgpu.scaled_ext_packed %104[1], %105 : vector<4xf8E5M2> to vector<2xf32>
    %109 = vector.insert_strided_slice %108, %107 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %110 = vector.shape_cast %109 : vector<4xf32> to vector<1x1x4xf32>
    %111 = vector.insert_strided_slice %110, %102 {offsets = [5, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %112 = vector.extract_strided_slice %1 {offsets = [6, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %113 = vector.shape_cast %112 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %114 = vector.extract %3[6, 0, 0] : f32 from vector<8x2x4xf32>
    %115 = amdgpu.scaled_ext_packed %113[0], %114 : vector<4xf8E5M2> to vector<2xf32>
    %116 = vector.insert_strided_slice %115, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %117 = amdgpu.scaled_ext_packed %113[1], %114 : vector<4xf8E5M2> to vector<2xf32>
    %118 = vector.insert_strided_slice %117, %116 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %119 = vector.shape_cast %118 : vector<4xf32> to vector<1x1x4xf32>
    %120 = vector.insert_strided_slice %119, %111 {offsets = [6, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %121 = vector.extract_strided_slice %1 {offsets = [6, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %122 = vector.shape_cast %121 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %123 = vector.extract %3[6, 1, 0] : f32 from vector<8x2x4xf32>
    %124 = amdgpu.scaled_ext_packed %122[0], %123 : vector<4xf8E5M2> to vector<2xf32>
    %125 = vector.insert_strided_slice %124, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %126 = amdgpu.scaled_ext_packed %122[1], %123 : vector<4xf8E5M2> to vector<2xf32>
    %127 = vector.insert_strided_slice %126, %125 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %128 = vector.shape_cast %127 : vector<4xf32> to vector<1x1x4xf32>
    %129 = vector.insert_strided_slice %128, %120 {offsets = [6, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %130 = vector.extract_strided_slice %1 {offsets = [7, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %131 = vector.shape_cast %130 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %132 = vector.extract %3[7, 0, 0] : f32 from vector<8x2x4xf32>
    %133 = amdgpu.scaled_ext_packed %131[0], %132 : vector<4xf8E5M2> to vector<2xf32>
    %134 = vector.insert_strided_slice %133, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %135 = amdgpu.scaled_ext_packed %131[1], %132 : vector<4xf8E5M2> to vector<2xf32>
    %136 = vector.insert_strided_slice %135, %134 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %137 = vector.shape_cast %136 : vector<4xf32> to vector<1x1x4xf32>
    %138 = vector.insert_strided_slice %137, %129 {offsets = [7, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %139 = vector.extract_strided_slice %1 {offsets = [7, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf8E5M2> to vector<1x1x4xf8E5M2>
    %140 = vector.shape_cast %139 : vector<1x1x4xf8E5M2> to vector<4xf8E5M2>
    %141 = vector.extract %3[7, 1, 0] : f32 from vector<8x2x4xf32>
    %142 = amdgpu.scaled_ext_packed %140[0], %141 : vector<4xf8E5M2> to vector<2xf32>
    %143 = vector.insert_strided_slice %142, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %144 = amdgpu.scaled_ext_packed %140[1], %141 : vector<4xf8E5M2> to vector<2xf32>
    %145 = vector.insert_strided_slice %144, %143 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    %146 = vector.shape_cast %145 : vector<4xf32> to vector<1x1x4xf32>
    %147 = vector.insert_strided_slice %146, %138 {offsets = [7, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf32> into vector<8x2x4xf32>
    %148 = vector.shape_cast %147 : vector<8x2x4xf32> to vector<8x8xf32>
    return %148 : vector<8x8xf32>
  }
}

// -----
module {
  func.func @conversion_broadcast_odd(%arg0: vector<6xf8E5M2>, %arg1: vector<2xf8E8M0FNU>) -> vector<6xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<3xf32>
    %cst_0 = arith.constant dense<0.000000e+00> : vector<6xf32>
    %0 = vector.broadcast %arg1 : vector<2xf8E8M0FNU> to vector<3x2xf8E8M0FNU>
    %1 = vector.shape_cast %0 : vector<3x2xf8E8M0FNU> to vector<6xf8E8M0FNU>
    %2 = arith.extf %1 : vector<6xf8E8M0FNU> to vector<6xf32>
    %3 = vector.extract_strided_slice %arg0 {offsets = [0], sizes = [3], strides = [1]} : vector<6xf8E5M2> to vector<3xf8E5M2>
    %4 = vector.extract %2[0] : f32 from vector<6xf32>
    %5 = amdgpu.scaled_ext_packed %3[0], %4 : vector<3xf8E5M2> to vector<2xf32>
    %6 = vector.insert_strided_slice %5, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<3xf32>
    %7 = amdgpu.scaled_ext_packed %3[1], %4 : vector<3xf8E5M2> to vector<2xf32>
    %8 = vector.extract_strided_slice %7 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf32> to vector<1xf32>
    %9 = vector.insert_strided_slice %8, %6 {offsets = [2], strides = [1]} : vector<1xf32> into vector<3xf32>
    %10 = vector.insert_strided_slice %9, %cst_0 {offsets = [0], strides = [1]} : vector<3xf32> into vector<6xf32>
    %11 = vector.extract_strided_slice %arg0 {offsets = [3], sizes = [3], strides = [1]} : vector<6xf8E5M2> to vector<3xf8E5M2>
    %12 = vector.extract %2[3] : f32 from vector<6xf32>
    %13 = amdgpu.scaled_ext_packed %11[0], %12 : vector<3xf8E5M2> to vector<2xf32>
    %14 = vector.insert_strided_slice %13, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<3xf32>
    %15 = amdgpu.scaled_ext_packed %11[1], %12 : vector<3xf8E5M2> to vector<2xf32>
    %16 = vector.extract_strided_slice %15 {offsets = [0], sizes = [1], strides = [1]} : vector<2xf32> to vector<1xf32>
    %17 = vector.insert_strided_slice %16, %14 {offsets = [2], strides = [1]} : vector<1xf32> into vector<3xf32>
    %18 = vector.insert_strided_slice %17, %10 {offsets = [3], strides = [1]} : vector<3xf32> into vector<6xf32>
    return %18 : vector<6xf32>
  }
}

// -----
module {
  func.func @conversion_broadcast(%arg0: vector<4xf8E5M2>, %arg1: f8E8M0FNU) -> vector<4xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %0 = vector.broadcast %arg1 : f8E8M0FNU to vector<4xf8E8M0FNU>
    %1 = arith.extf %0 : vector<4xf8E8M0FNU> to vector<4xf32>
    %2 = vector.extract %1[0] : f32 from vector<4xf32>
    %3 = amdgpu.scaled_ext_packed %arg0[0], %2 : vector<4xf8E5M2> to vector<2xf32>
    %4 = vector.insert_strided_slice %3, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<4xf32>
    %5 = amdgpu.scaled_ext_packed %arg0[1], %2 : vector<4xf8E5M2> to vector<2xf32>
    %6 = vector.insert_strided_slice %5, %4 {offsets = [2], strides = [1]} : vector<2xf32> into vector<4xf32>
    return %6 : vector<4xf32>
  }
}

// -----
module {
  func.func @conversion_scalar(%arg0: f8E5M2, %arg1: f8E8M0FNU) -> f32 {
    %0 = arith.extf %arg1 : f8E8M0FNU to f32
    %1 = vector.broadcast %arg0 : f8E5M2 to vector<1xf8E5M2>
    %2 = amdgpu.scaled_ext_packed %1[0], %0 : vector<1xf8E5M2> to vector<2xf32>
    %3 = vector.extract %2[0] : f32 from vector<2xf32>
    return %3 : f32
  }
}

// -----
module {
  func.func @long_fp4_broadcast(%arg0: vector<32xf4E2M1FN>, %arg1: f32) -> vector<32xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<32xf32>
    %0 = vector.extract_strided_slice %arg0 {offsets = [0], sizes = [8], strides = [1]} : vector<32xf4E2M1FN> to vector<8xf4E2M1FN>
    %1 = amdgpu.scaled_ext_packed %0[0], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %2 = vector.insert_strided_slice %1, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<32xf32>
    %3 = amdgpu.scaled_ext_packed %0[1], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %4 = vector.insert_strided_slice %3, %2 {offsets = [2], strides = [1]} : vector<2xf32> into vector<32xf32>
    %5 = amdgpu.scaled_ext_packed %0[2], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %6 = vector.insert_strided_slice %5, %4 {offsets = [4], strides = [1]} : vector<2xf32> into vector<32xf32>
    %7 = amdgpu.scaled_ext_packed %0[3], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %8 = vector.insert_strided_slice %7, %6 {offsets = [6], strides = [1]} : vector<2xf32> into vector<32xf32>
    %9 = vector.extract_strided_slice %arg0 {offsets = [8], sizes = [8], strides = [1]} : vector<32xf4E2M1FN> to vector<8xf4E2M1FN>
    %10 = amdgpu.scaled_ext_packed %9[0], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %11 = vector.insert_strided_slice %10, %8 {offsets = [8], strides = [1]} : vector<2xf32> into vector<32xf32>
    %12 = amdgpu.scaled_ext_packed %9[1], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %13 = vector.insert_strided_slice %12, %11 {offsets = [10], strides = [1]} : vector<2xf32> into vector<32xf32>
    %14 = amdgpu.scaled_ext_packed %9[2], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %15 = vector.insert_strided_slice %14, %13 {offsets = [12], strides = [1]} : vector<2xf32> into vector<32xf32>
    %16 = amdgpu.scaled_ext_packed %9[3], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %17 = vector.insert_strided_slice %16, %15 {offsets = [14], strides = [1]} : vector<2xf32> into vector<32xf32>
    %18 = vector.extract_strided_slice %arg0 {offsets = [16], sizes = [8], strides = [1]} : vector<32xf4E2M1FN> to vector<8xf4E2M1FN>
    %19 = amdgpu.scaled_ext_packed %18[0], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %20 = vector.insert_strided_slice %19, %17 {offsets = [16], strides = [1]} : vector<2xf32> into vector<32xf32>
    %21 = amdgpu.scaled_ext_packed %18[1], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %22 = vector.insert_strided_slice %21, %20 {offsets = [18], strides = [1]} : vector<2xf32> into vector<32xf32>
    %23 = amdgpu.scaled_ext_packed %18[2], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %24 = vector.insert_strided_slice %23, %22 {offsets = [20], strides = [1]} : vector<2xf32> into vector<32xf32>
    %25 = amdgpu.scaled_ext_packed %18[3], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %26 = vector.insert_strided_slice %25, %24 {offsets = [22], strides = [1]} : vector<2xf32> into vector<32xf32>
    %27 = vector.extract_strided_slice %arg0 {offsets = [24], sizes = [8], strides = [1]} : vector<32xf4E2M1FN> to vector<8xf4E2M1FN>
    %28 = amdgpu.scaled_ext_packed %27[0], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %29 = vector.insert_strided_slice %28, %26 {offsets = [24], strides = [1]} : vector<2xf32> into vector<32xf32>
    %30 = amdgpu.scaled_ext_packed %27[1], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %31 = vector.insert_strided_slice %30, %29 {offsets = [26], strides = [1]} : vector<2xf32> into vector<32xf32>
    %32 = amdgpu.scaled_ext_packed %27[2], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %33 = vector.insert_strided_slice %32, %31 {offsets = [28], strides = [1]} : vector<2xf32> into vector<32xf32>
    %34 = amdgpu.scaled_ext_packed %27[3], %arg1 : vector<8xf4E2M1FN> to vector<2xf32>
    %35 = vector.insert_strided_slice %34, %33 {offsets = [30], strides = [1]} : vector<2xf32> into vector<32xf32>
    return %35 : vector<32xf32>
  }
}

// -----
module {
  func.func @long_fp8_broadcast(%arg0: vector<32xf8E4M3FN>, %arg1: f32) -> vector<32xf32> {
    %cst = arith.constant dense<0.000000e+00> : vector<32xf32>
    %0 = vector.extract_strided_slice %arg0 {offsets = [0], sizes = [4], strides = [1]} : vector<32xf8E4M3FN> to vector<4xf8E4M3FN>
    %1 = amdgpu.scaled_ext_packed %0[0], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %2 = vector.insert_strided_slice %1, %cst {offsets = [0], strides = [1]} : vector<2xf32> into vector<32xf32>
    %3 = amdgpu.scaled_ext_packed %0[1], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %4 = vector.insert_strided_slice %3, %2 {offsets = [2], strides = [1]} : vector<2xf32> into vector<32xf32>
    %5 = vector.extract_strided_slice %arg0 {offsets = [4], sizes = [4], strides = [1]} : vector<32xf8E4M3FN> to vector<4xf8E4M3FN>
    %6 = amdgpu.scaled_ext_packed %5[0], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %7 = vector.insert_strided_slice %6, %4 {offsets = [4], strides = [1]} : vector<2xf32> into vector<32xf32>
    %8 = amdgpu.scaled_ext_packed %5[1], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %9 = vector.insert_strided_slice %8, %7 {offsets = [6], strides = [1]} : vector<2xf32> into vector<32xf32>
    %10 = vector.extract_strided_slice %arg0 {offsets = [8], sizes = [4], strides = [1]} : vector<32xf8E4M3FN> to vector<4xf8E4M3FN>
    %11 = amdgpu.scaled_ext_packed %10[0], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %12 = vector.insert_strided_slice %11, %9 {offsets = [8], strides = [1]} : vector<2xf32> into vector<32xf32>
    %13 = amdgpu.scaled_ext_packed %10[1], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %14 = vector.insert_strided_slice %13, %12 {offsets = [10], strides = [1]} : vector<2xf32> into vector<32xf32>
    %15 = vector.extract_strided_slice %arg0 {offsets = [12], sizes = [4], strides = [1]} : vector<32xf8E4M3FN> to vector<4xf8E4M3FN>
    %16 = amdgpu.scaled_ext_packed %15[0], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %17 = vector.insert_strided_slice %16, %14 {offsets = [12], strides = [1]} : vector<2xf32> into vector<32xf32>
    %18 = amdgpu.scaled_ext_packed %15[1], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %19 = vector.insert_strided_slice %18, %17 {offsets = [14], strides = [1]} : vector<2xf32> into vector<32xf32>
    %20 = vector.extract_strided_slice %arg0 {offsets = [16], sizes = [4], strides = [1]} : vector<32xf8E4M3FN> to vector<4xf8E4M3FN>
    %21 = amdgpu.scaled_ext_packed %20[0], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %22 = vector.insert_strided_slice %21, %19 {offsets = [16], strides = [1]} : vector<2xf32> into vector<32xf32>
    %23 = amdgpu.scaled_ext_packed %20[1], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %24 = vector.insert_strided_slice %23, %22 {offsets = [18], strides = [1]} : vector<2xf32> into vector<32xf32>
    %25 = vector.extract_strided_slice %arg0 {offsets = [20], sizes = [4], strides = [1]} : vector<32xf8E4M3FN> to vector<4xf8E4M3FN>
    %26 = amdgpu.scaled_ext_packed %25[0], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %27 = vector.insert_strided_slice %26, %24 {offsets = [20], strides = [1]} : vector<2xf32> into vector<32xf32>
    %28 = amdgpu.scaled_ext_packed %25[1], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %29 = vector.insert_strided_slice %28, %27 {offsets = [22], strides = [1]} : vector<2xf32> into vector<32xf32>
    %30 = vector.extract_strided_slice %arg0 {offsets = [24], sizes = [4], strides = [1]} : vector<32xf8E4M3FN> to vector<4xf8E4M3FN>
    %31 = amdgpu.scaled_ext_packed %30[0], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %32 = vector.insert_strided_slice %31, %29 {offsets = [24], strides = [1]} : vector<2xf32> into vector<32xf32>
    %33 = amdgpu.scaled_ext_packed %30[1], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %34 = vector.insert_strided_slice %33, %32 {offsets = [26], strides = [1]} : vector<2xf32> into vector<32xf32>
    %35 = vector.extract_strided_slice %arg0 {offsets = [28], sizes = [4], strides = [1]} : vector<32xf8E4M3FN> to vector<4xf8E4M3FN>
    %36 = amdgpu.scaled_ext_packed %35[0], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %37 = vector.insert_strided_slice %36, %34 {offsets = [28], strides = [1]} : vector<2xf32> into vector<32xf32>
    %38 = amdgpu.scaled_ext_packed %35[1], %arg1 : vector<4xf8E4M3FN> to vector<2xf32>
    %39 = vector.insert_strided_slice %38, %37 {offsets = [30], strides = [1]} : vector<2xf32> into vector<32xf32>
    return %39 : vector<32xf32>
  }
}

