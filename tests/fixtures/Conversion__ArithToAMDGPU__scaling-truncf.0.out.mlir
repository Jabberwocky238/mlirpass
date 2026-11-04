module {
  func.func @conversion_f8_fallback(%arg0: vector<2x2xf32>, %arg1: vector<2x2xf8E8M0FNU>) -> vector<2x2xf8E5M2> {
    %cst = arith.constant dense<0.000000e+00> : vector<2x2xf8E5M2>
    %0 = arith.extf %arg1 : vector<2x2xf8E8M0FNU> to vector<2x2xf32>
    %1 = vector.extract_strided_slice %arg0 {offsets = [0, 0], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf32> to vector<1x1xf32>
    %2 = vector.shape_cast %1 : vector<1x1xf32> to vector<1xf32>
    %3 = vector.extract %0[0, 0] : f32 from vector<2x2xf32>
    %4 = amdgpu.packed_scaled_trunc %2 into undef[0], %3 : vector<1xf32> to vector<4xf8E5M2>
    %5 = vector.extract_strided_slice %4 {offsets = [0], sizes = [1], strides = [1]} : vector<4xf8E5M2> to vector<1xf8E5M2>
    %6 = vector.shape_cast %5 : vector<1xf8E5M2> to vector<1x1xf8E5M2>
    %7 = vector.insert_strided_slice %6, %cst {offsets = [0, 0], strides = [1, 1]} : vector<1x1xf8E5M2> into vector<2x2xf8E5M2>
    %8 = vector.extract_strided_slice %arg0 {offsets = [0, 1], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf32> to vector<1x1xf32>
    %9 = vector.shape_cast %8 : vector<1x1xf32> to vector<1xf32>
    %10 = vector.extract %0[0, 1] : f32 from vector<2x2xf32>
    %11 = amdgpu.packed_scaled_trunc %9 into undef[0], %10 : vector<1xf32> to vector<4xf8E5M2>
    %12 = vector.extract_strided_slice %11 {offsets = [0], sizes = [1], strides = [1]} : vector<4xf8E5M2> to vector<1xf8E5M2>
    %13 = vector.shape_cast %12 : vector<1xf8E5M2> to vector<1x1xf8E5M2>
    %14 = vector.insert_strided_slice %13, %7 {offsets = [0, 1], strides = [1, 1]} : vector<1x1xf8E5M2> into vector<2x2xf8E5M2>
    %15 = vector.extract_strided_slice %arg0 {offsets = [1, 0], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf32> to vector<1x1xf32>
    %16 = vector.shape_cast %15 : vector<1x1xf32> to vector<1xf32>
    %17 = vector.extract %0[1, 0] : f32 from vector<2x2xf32>
    %18 = amdgpu.packed_scaled_trunc %16 into undef[0], %17 : vector<1xf32> to vector<4xf8E5M2>
    %19 = vector.extract_strided_slice %18 {offsets = [0], sizes = [1], strides = [1]} : vector<4xf8E5M2> to vector<1xf8E5M2>
    %20 = vector.shape_cast %19 : vector<1xf8E5M2> to vector<1x1xf8E5M2>
    %21 = vector.insert_strided_slice %20, %14 {offsets = [1, 0], strides = [1, 1]} : vector<1x1xf8E5M2> into vector<2x2xf8E5M2>
    %22 = vector.extract_strided_slice %arg0 {offsets = [1, 1], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf32> to vector<1x1xf32>
    %23 = vector.shape_cast %22 : vector<1x1xf32> to vector<1xf32>
    %24 = vector.extract %0[1, 1] : f32 from vector<2x2xf32>
    %25 = amdgpu.packed_scaled_trunc %23 into undef[0], %24 : vector<1xf32> to vector<4xf8E5M2>
    %26 = vector.extract_strided_slice %25 {offsets = [0], sizes = [1], strides = [1]} : vector<4xf8E5M2> to vector<1xf8E5M2>
    %27 = vector.shape_cast %26 : vector<1xf8E5M2> to vector<1x1xf8E5M2>
    %28 = vector.insert_strided_slice %27, %21 {offsets = [1, 1], strides = [1, 1]} : vector<1x1xf8E5M2> into vector<2x2xf8E5M2>
    return %28 : vector<2x2xf8E5M2>
  }
}

// -----
module {
  func.func @conversion_f4_fallback(%arg0: vector<2x2xf32>, %arg1: vector<2x2xf8E8M0FNU>) -> vector<2x2xf4E2M1FN> {
    %cst = arith.constant dense<0.000000e+00> : vector<2x2xf4E2M1FN>
    %0 = arith.extf %arg1 : vector<2x2xf8E8M0FNU> to vector<2x2xf32>
    %1 = vector.extract_strided_slice %arg0 {offsets = [0, 0], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf32> to vector<1x1xf32>
    %2 = vector.shape_cast %1 : vector<1x1xf32> to vector<1xf32>
    %3 = vector.extract %0[0, 0] : f32 from vector<2x2xf32>
    %4 = amdgpu.packed_scaled_trunc %2 into undef[0], %3 : vector<1xf32> to vector<8xf4E2M1FN>
    %5 = vector.extract_strided_slice %4 {offsets = [0], sizes = [1], strides = [1]} : vector<8xf4E2M1FN> to vector<1xf4E2M1FN>
    %6 = vector.shape_cast %5 : vector<1xf4E2M1FN> to vector<1x1xf4E2M1FN>
    %7 = vector.insert_strided_slice %6, %cst {offsets = [0, 0], strides = [1, 1]} : vector<1x1xf4E2M1FN> into vector<2x2xf4E2M1FN>
    %8 = vector.extract_strided_slice %arg0 {offsets = [0, 1], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf32> to vector<1x1xf32>
    %9 = vector.shape_cast %8 : vector<1x1xf32> to vector<1xf32>
    %10 = vector.extract %0[0, 1] : f32 from vector<2x2xf32>
    %11 = amdgpu.packed_scaled_trunc %9 into undef[0], %10 : vector<1xf32> to vector<8xf4E2M1FN>
    %12 = vector.extract_strided_slice %11 {offsets = [0], sizes = [1], strides = [1]} : vector<8xf4E2M1FN> to vector<1xf4E2M1FN>
    %13 = vector.shape_cast %12 : vector<1xf4E2M1FN> to vector<1x1xf4E2M1FN>
    %14 = vector.insert_strided_slice %13, %7 {offsets = [0, 1], strides = [1, 1]} : vector<1x1xf4E2M1FN> into vector<2x2xf4E2M1FN>
    %15 = vector.extract_strided_slice %arg0 {offsets = [1, 0], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf32> to vector<1x1xf32>
    %16 = vector.shape_cast %15 : vector<1x1xf32> to vector<1xf32>
    %17 = vector.extract %0[1, 0] : f32 from vector<2x2xf32>
    %18 = amdgpu.packed_scaled_trunc %16 into undef[0], %17 : vector<1xf32> to vector<8xf4E2M1FN>
    %19 = vector.extract_strided_slice %18 {offsets = [0], sizes = [1], strides = [1]} : vector<8xf4E2M1FN> to vector<1xf4E2M1FN>
    %20 = vector.shape_cast %19 : vector<1xf4E2M1FN> to vector<1x1xf4E2M1FN>
    %21 = vector.insert_strided_slice %20, %14 {offsets = [1, 0], strides = [1, 1]} : vector<1x1xf4E2M1FN> into vector<2x2xf4E2M1FN>
    %22 = vector.extract_strided_slice %arg0 {offsets = [1, 1], sizes = [1, 1], strides = [1, 1]} : vector<2x2xf32> to vector<1x1xf32>
    %23 = vector.shape_cast %22 : vector<1x1xf32> to vector<1xf32>
    %24 = vector.extract %0[1, 1] : f32 from vector<2x2xf32>
    %25 = amdgpu.packed_scaled_trunc %23 into undef[0], %24 : vector<1xf32> to vector<8xf4E2M1FN>
    %26 = vector.extract_strided_slice %25 {offsets = [0], sizes = [1], strides = [1]} : vector<8xf4E2M1FN> to vector<1xf4E2M1FN>
    %27 = vector.shape_cast %26 : vector<1xf4E2M1FN> to vector<1x1xf4E2M1FN>
    %28 = vector.insert_strided_slice %27, %21 {offsets = [1, 1], strides = [1, 1]} : vector<1x1xf4E2M1FN> into vector<2x2xf4E2M1FN>
    return %28 : vector<2x2xf4E2M1FN>
  }
}

// -----
module {
  func.func @conversion_broadcast(%arg0: vector<8x8xf32>, %arg1: vector<8x2xf8E8M0FNU>) -> vector<8x8xf8E5M2> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E5M2>
    %cst_0 = arith.constant dense<0.000000e+00> : vector<8x2x4xf8E5M2>
    %0 = vector.broadcast %arg1 : vector<8x2xf8E8M0FNU> to vector<4x8x2xf8E8M0FNU>
    %1 = vector.shape_cast %arg0 : vector<8x8xf32> to vector<8x2x4xf32>
    %2 = vector.shape_cast %0 : vector<4x8x2xf8E8M0FNU> to vector<8x2x4xf8E8M0FNU>
    %3 = arith.extf %2 : vector<8x2x4xf8E8M0FNU> to vector<8x2x4xf32>
    %4 = vector.extract_strided_slice %1 {offsets = [0, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %5 = vector.shape_cast %4 : vector<1x1x4xf32> to vector<4xf32>
    %6 = vector.extract %3[0, 0, 0] : f32 from vector<8x2x4xf32>
    %7 = vector.extract_strided_slice %5 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %8 = amdgpu.packed_scaled_trunc %7 into %cst[0], %6 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %9 = vector.extract_strided_slice %5 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %10 = amdgpu.packed_scaled_trunc %9 into %8[1], %6 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %11 = vector.shape_cast %10 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %12 = vector.insert_strided_slice %11, %cst_0 {offsets = [0, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %13 = vector.extract_strided_slice %1 {offsets = [0, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %14 = vector.shape_cast %13 : vector<1x1x4xf32> to vector<4xf32>
    %15 = vector.extract %3[0, 1, 0] : f32 from vector<8x2x4xf32>
    %16 = vector.extract_strided_slice %14 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %17 = amdgpu.packed_scaled_trunc %16 into %cst[0], %15 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %18 = vector.extract_strided_slice %14 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %19 = amdgpu.packed_scaled_trunc %18 into %17[1], %15 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %20 = vector.shape_cast %19 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %21 = vector.insert_strided_slice %20, %12 {offsets = [0, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %22 = vector.extract_strided_slice %1 {offsets = [1, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %23 = vector.shape_cast %22 : vector<1x1x4xf32> to vector<4xf32>
    %24 = vector.extract %3[1, 0, 0] : f32 from vector<8x2x4xf32>
    %25 = vector.extract_strided_slice %23 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %26 = amdgpu.packed_scaled_trunc %25 into %cst[0], %24 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %27 = vector.extract_strided_slice %23 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %28 = amdgpu.packed_scaled_trunc %27 into %26[1], %24 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %29 = vector.shape_cast %28 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %30 = vector.insert_strided_slice %29, %21 {offsets = [1, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %31 = vector.extract_strided_slice %1 {offsets = [1, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %32 = vector.shape_cast %31 : vector<1x1x4xf32> to vector<4xf32>
    %33 = vector.extract %3[1, 1, 0] : f32 from vector<8x2x4xf32>
    %34 = vector.extract_strided_slice %32 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %35 = amdgpu.packed_scaled_trunc %34 into %cst[0], %33 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %36 = vector.extract_strided_slice %32 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %37 = amdgpu.packed_scaled_trunc %36 into %35[1], %33 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %38 = vector.shape_cast %37 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %39 = vector.insert_strided_slice %38, %30 {offsets = [1, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %40 = vector.extract_strided_slice %1 {offsets = [2, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %41 = vector.shape_cast %40 : vector<1x1x4xf32> to vector<4xf32>
    %42 = vector.extract %3[2, 0, 0] : f32 from vector<8x2x4xf32>
    %43 = vector.extract_strided_slice %41 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %44 = amdgpu.packed_scaled_trunc %43 into %cst[0], %42 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %45 = vector.extract_strided_slice %41 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %46 = amdgpu.packed_scaled_trunc %45 into %44[1], %42 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %47 = vector.shape_cast %46 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %48 = vector.insert_strided_slice %47, %39 {offsets = [2, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %49 = vector.extract_strided_slice %1 {offsets = [2, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %50 = vector.shape_cast %49 : vector<1x1x4xf32> to vector<4xf32>
    %51 = vector.extract %3[2, 1, 0] : f32 from vector<8x2x4xf32>
    %52 = vector.extract_strided_slice %50 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %53 = amdgpu.packed_scaled_trunc %52 into %cst[0], %51 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %54 = vector.extract_strided_slice %50 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %55 = amdgpu.packed_scaled_trunc %54 into %53[1], %51 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %56 = vector.shape_cast %55 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %57 = vector.insert_strided_slice %56, %48 {offsets = [2, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %58 = vector.extract_strided_slice %1 {offsets = [3, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %59 = vector.shape_cast %58 : vector<1x1x4xf32> to vector<4xf32>
    %60 = vector.extract %3[3, 0, 0] : f32 from vector<8x2x4xf32>
    %61 = vector.extract_strided_slice %59 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %62 = amdgpu.packed_scaled_trunc %61 into %cst[0], %60 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %63 = vector.extract_strided_slice %59 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %64 = amdgpu.packed_scaled_trunc %63 into %62[1], %60 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %65 = vector.shape_cast %64 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %66 = vector.insert_strided_slice %65, %57 {offsets = [3, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %67 = vector.extract_strided_slice %1 {offsets = [3, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %68 = vector.shape_cast %67 : vector<1x1x4xf32> to vector<4xf32>
    %69 = vector.extract %3[3, 1, 0] : f32 from vector<8x2x4xf32>
    %70 = vector.extract_strided_slice %68 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %71 = amdgpu.packed_scaled_trunc %70 into %cst[0], %69 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %72 = vector.extract_strided_slice %68 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %73 = amdgpu.packed_scaled_trunc %72 into %71[1], %69 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %74 = vector.shape_cast %73 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %75 = vector.insert_strided_slice %74, %66 {offsets = [3, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %76 = vector.extract_strided_slice %1 {offsets = [4, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %77 = vector.shape_cast %76 : vector<1x1x4xf32> to vector<4xf32>
    %78 = vector.extract %3[4, 0, 0] : f32 from vector<8x2x4xf32>
    %79 = vector.extract_strided_slice %77 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %80 = amdgpu.packed_scaled_trunc %79 into %cst[0], %78 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %81 = vector.extract_strided_slice %77 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %82 = amdgpu.packed_scaled_trunc %81 into %80[1], %78 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %83 = vector.shape_cast %82 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %84 = vector.insert_strided_slice %83, %75 {offsets = [4, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %85 = vector.extract_strided_slice %1 {offsets = [4, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %86 = vector.shape_cast %85 : vector<1x1x4xf32> to vector<4xf32>
    %87 = vector.extract %3[4, 1, 0] : f32 from vector<8x2x4xf32>
    %88 = vector.extract_strided_slice %86 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %89 = amdgpu.packed_scaled_trunc %88 into %cst[0], %87 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %90 = vector.extract_strided_slice %86 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %91 = amdgpu.packed_scaled_trunc %90 into %89[1], %87 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %92 = vector.shape_cast %91 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %93 = vector.insert_strided_slice %92, %84 {offsets = [4, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %94 = vector.extract_strided_slice %1 {offsets = [5, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %95 = vector.shape_cast %94 : vector<1x1x4xf32> to vector<4xf32>
    %96 = vector.extract %3[5, 0, 0] : f32 from vector<8x2x4xf32>
    %97 = vector.extract_strided_slice %95 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %98 = amdgpu.packed_scaled_trunc %97 into %cst[0], %96 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %99 = vector.extract_strided_slice %95 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %100 = amdgpu.packed_scaled_trunc %99 into %98[1], %96 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %101 = vector.shape_cast %100 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %102 = vector.insert_strided_slice %101, %93 {offsets = [5, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %103 = vector.extract_strided_slice %1 {offsets = [5, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %104 = vector.shape_cast %103 : vector<1x1x4xf32> to vector<4xf32>
    %105 = vector.extract %3[5, 1, 0] : f32 from vector<8x2x4xf32>
    %106 = vector.extract_strided_slice %104 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %107 = amdgpu.packed_scaled_trunc %106 into %cst[0], %105 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %108 = vector.extract_strided_slice %104 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %109 = amdgpu.packed_scaled_trunc %108 into %107[1], %105 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %110 = vector.shape_cast %109 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %111 = vector.insert_strided_slice %110, %102 {offsets = [5, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %112 = vector.extract_strided_slice %1 {offsets = [6, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %113 = vector.shape_cast %112 : vector<1x1x4xf32> to vector<4xf32>
    %114 = vector.extract %3[6, 0, 0] : f32 from vector<8x2x4xf32>
    %115 = vector.extract_strided_slice %113 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %116 = amdgpu.packed_scaled_trunc %115 into %cst[0], %114 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %117 = vector.extract_strided_slice %113 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %118 = amdgpu.packed_scaled_trunc %117 into %116[1], %114 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %119 = vector.shape_cast %118 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %120 = vector.insert_strided_slice %119, %111 {offsets = [6, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %121 = vector.extract_strided_slice %1 {offsets = [6, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %122 = vector.shape_cast %121 : vector<1x1x4xf32> to vector<4xf32>
    %123 = vector.extract %3[6, 1, 0] : f32 from vector<8x2x4xf32>
    %124 = vector.extract_strided_slice %122 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %125 = amdgpu.packed_scaled_trunc %124 into %cst[0], %123 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %126 = vector.extract_strided_slice %122 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %127 = amdgpu.packed_scaled_trunc %126 into %125[1], %123 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %128 = vector.shape_cast %127 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %129 = vector.insert_strided_slice %128, %120 {offsets = [6, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %130 = vector.extract_strided_slice %1 {offsets = [7, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %131 = vector.shape_cast %130 : vector<1x1x4xf32> to vector<4xf32>
    %132 = vector.extract %3[7, 0, 0] : f32 from vector<8x2x4xf32>
    %133 = vector.extract_strided_slice %131 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %134 = amdgpu.packed_scaled_trunc %133 into %cst[0], %132 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %135 = vector.extract_strided_slice %131 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %136 = amdgpu.packed_scaled_trunc %135 into %134[1], %132 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %137 = vector.shape_cast %136 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %138 = vector.insert_strided_slice %137, %129 {offsets = [7, 0, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %139 = vector.extract_strided_slice %1 {offsets = [7, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]} : vector<8x2x4xf32> to vector<1x1x4xf32>
    %140 = vector.shape_cast %139 : vector<1x1x4xf32> to vector<4xf32>
    %141 = vector.extract %3[7, 1, 0] : f32 from vector<8x2x4xf32>
    %142 = vector.extract_strided_slice %140 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %143 = amdgpu.packed_scaled_trunc %142 into %cst[0], %141 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %144 = vector.extract_strided_slice %140 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %145 = amdgpu.packed_scaled_trunc %144 into %143[1], %141 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %146 = vector.shape_cast %145 : vector<4xf8E5M2> to vector<1x1x4xf8E5M2>
    %147 = vector.insert_strided_slice %146, %138 {offsets = [7, 1, 0], strides = [1, 1, 1]} : vector<1x1x4xf8E5M2> into vector<8x2x4xf8E5M2>
    %148 = vector.shape_cast %147 : vector<8x2x4xf8E5M2> to vector<8x8xf8E5M2>
    return %148 : vector<8x8xf8E5M2>
  }
}

// -----
module {
  func.func @conversion_broadcast_odd(%arg0: vector<6xf32>, %arg1: vector<2xf8E8M0FNU>) -> vector<6xf8E5M2> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E5M2>
    %cst_0 = arith.constant dense<0.000000e+00> : vector<6xf8E5M2>
    %0 = vector.broadcast %arg1 : vector<2xf8E8M0FNU> to vector<3x2xf8E8M0FNU>
    %1 = vector.shape_cast %0 : vector<3x2xf8E8M0FNU> to vector<6xf8E8M0FNU>
    %2 = arith.extf %1 : vector<6xf8E8M0FNU> to vector<6xf32>
    %3 = vector.extract_strided_slice %arg0 {offsets = [0], sizes = [3], strides = [1]} : vector<6xf32> to vector<3xf32>
    %4 = vector.extract %2[0] : f32 from vector<6xf32>
    %5 = vector.extract_strided_slice %3 {offsets = [0], sizes = [2], strides = [1]} : vector<3xf32> to vector<2xf32>
    %6 = amdgpu.packed_scaled_trunc %5 into %cst[0], %4 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %7 = vector.extract_strided_slice %3 {offsets = [2], sizes = [1], strides = [1]} : vector<3xf32> to vector<1xf32>
    %8 = amdgpu.packed_scaled_trunc %7 into %6[1], %4 : vector<1xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %9 = vector.extract_strided_slice %8 {offsets = [0], sizes = [3], strides = [1]} : vector<4xf8E5M2> to vector<3xf8E5M2>
    %10 = vector.insert_strided_slice %9, %cst_0 {offsets = [0], strides = [1]} : vector<3xf8E5M2> into vector<6xf8E5M2>
    %11 = vector.extract_strided_slice %arg0 {offsets = [3], sizes = [3], strides = [1]} : vector<6xf32> to vector<3xf32>
    %12 = vector.extract %2[3] : f32 from vector<6xf32>
    %13 = vector.extract_strided_slice %11 {offsets = [0], sizes = [2], strides = [1]} : vector<3xf32> to vector<2xf32>
    %14 = amdgpu.packed_scaled_trunc %13 into %cst[0], %12 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %15 = vector.extract_strided_slice %11 {offsets = [2], sizes = [1], strides = [1]} : vector<3xf32> to vector<1xf32>
    %16 = amdgpu.packed_scaled_trunc %15 into %14[1], %12 : vector<1xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %17 = vector.extract_strided_slice %16 {offsets = [0], sizes = [3], strides = [1]} : vector<4xf8E5M2> to vector<3xf8E5M2>
    %18 = vector.insert_strided_slice %17, %10 {offsets = [3], strides = [1]} : vector<3xf8E5M2> into vector<6xf8E5M2>
    return %18 : vector<6xf8E5M2>
  }
}

// -----
module {
  func.func @conversion_broadcast(%arg0: vector<4xf32>, %arg1: f8E8M0FNU) -> vector<4xf8E5M2> {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf8E5M2>
    %0 = vector.broadcast %arg1 : f8E8M0FNU to vector<4xf8E8M0FNU>
    %1 = arith.extf %0 : vector<4xf8E8M0FNU> to vector<4xf32>
    %2 = vector.extract %1[0] : f32 from vector<4xf32>
    %3 = vector.extract_strided_slice %arg0 {offsets = [0], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %4 = amdgpu.packed_scaled_trunc %3 into %cst[0], %2 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    %5 = vector.extract_strided_slice %arg0 {offsets = [2], sizes = [2], strides = [1]} : vector<4xf32> to vector<2xf32>
    %6 = amdgpu.packed_scaled_trunc %5 into %4[1], %2 : vector<2xf32> to vector<4xf8E5M2> into vector<4xf8E5M2>
    return %6 : vector<4xf8E5M2>
  }
}

// -----
module {
  func.func @conversion_scalar(%arg0: f32, %arg1: f8E8M0FNU) -> f8E5M2 {
    %0 = arith.extf %arg1 : f8E8M0FNU to f32
    %1 = vector.broadcast %arg0 : f32 to vector<1xf32>
    %2 = amdgpu.packed_scaled_trunc %1 into undef[0], %0 : vector<1xf32> to vector<4xf8E5M2>
    %3 = vector.extract %2[0] : f8E5M2 from vector<4xf8E5M2>
    return %3 : f8E5M2
  }
}

// -----
module {
  func.func @long_fp4_broadcast(%arg0: vector<32xf32>, %arg1: f32) -> vector<32xf4E2M1FN> {
    %cst = arith.constant dense<0.000000e+00> : vector<32xf4E2M1FN>
    %cst_0 = arith.constant dense<0.000000e+00> : vector<8xf4E2M1FN>
    %0 = vector.extract_strided_slice %arg0 {offsets = [0], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %1 = amdgpu.packed_scaled_trunc %0 into %cst_0[0], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %2 = vector.extract_strided_slice %arg0 {offsets = [2], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %3 = amdgpu.packed_scaled_trunc %2 into %1[1], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %4 = vector.extract_strided_slice %arg0 {offsets = [4], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %5 = amdgpu.packed_scaled_trunc %4 into %3[2], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %6 = vector.extract_strided_slice %arg0 {offsets = [6], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %7 = amdgpu.packed_scaled_trunc %6 into %5[3], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %8 = vector.insert_strided_slice %7, %cst {offsets = [0], strides = [1]} : vector<8xf4E2M1FN> into vector<32xf4E2M1FN>
    %9 = vector.extract_strided_slice %arg0 {offsets = [8], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %10 = amdgpu.packed_scaled_trunc %9 into %cst_0[0], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %11 = vector.extract_strided_slice %arg0 {offsets = [10], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %12 = amdgpu.packed_scaled_trunc %11 into %10[1], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %13 = vector.extract_strided_slice %arg0 {offsets = [12], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %14 = amdgpu.packed_scaled_trunc %13 into %12[2], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %15 = vector.extract_strided_slice %arg0 {offsets = [14], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %16 = amdgpu.packed_scaled_trunc %15 into %14[3], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %17 = vector.insert_strided_slice %16, %8 {offsets = [8], strides = [1]} : vector<8xf4E2M1FN> into vector<32xf4E2M1FN>
    %18 = vector.extract_strided_slice %arg0 {offsets = [16], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %19 = amdgpu.packed_scaled_trunc %18 into %cst_0[0], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %20 = vector.extract_strided_slice %arg0 {offsets = [18], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %21 = amdgpu.packed_scaled_trunc %20 into %19[1], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %22 = vector.extract_strided_slice %arg0 {offsets = [20], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %23 = amdgpu.packed_scaled_trunc %22 into %21[2], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %24 = vector.extract_strided_slice %arg0 {offsets = [22], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %25 = amdgpu.packed_scaled_trunc %24 into %23[3], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %26 = vector.insert_strided_slice %25, %17 {offsets = [16], strides = [1]} : vector<8xf4E2M1FN> into vector<32xf4E2M1FN>
    %27 = vector.extract_strided_slice %arg0 {offsets = [24], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %28 = amdgpu.packed_scaled_trunc %27 into %cst_0[0], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %29 = vector.extract_strided_slice %arg0 {offsets = [26], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %30 = amdgpu.packed_scaled_trunc %29 into %28[1], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %31 = vector.extract_strided_slice %arg0 {offsets = [28], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %32 = amdgpu.packed_scaled_trunc %31 into %30[2], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %33 = vector.extract_strided_slice %arg0 {offsets = [30], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %34 = amdgpu.packed_scaled_trunc %33 into %32[3], %arg1 : vector<2xf32> to vector<8xf4E2M1FN> into vector<8xf4E2M1FN>
    %35 = vector.insert_strided_slice %34, %26 {offsets = [24], strides = [1]} : vector<8xf4E2M1FN> into vector<32xf4E2M1FN>
    return %35 : vector<32xf4E2M1FN>
  }
}

// -----
module {
  func.func @long_fp8_broadcast(%arg0: vector<32xf32>, %arg1: f32) -> vector<32xf8E4M3FN> {
    %cst = arith.constant dense<0.000000e+00> : vector<32xf8E4M3FN>
    %cst_0 = arith.constant dense<0.000000e+00> : vector<4xf8E4M3FN>
    %0 = vector.extract_strided_slice %arg0 {offsets = [0], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %1 = amdgpu.packed_scaled_trunc %0 into %cst_0[0], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %2 = vector.extract_strided_slice %arg0 {offsets = [2], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %3 = amdgpu.packed_scaled_trunc %2 into %1[1], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %4 = vector.insert_strided_slice %3, %cst {offsets = [0], strides = [1]} : vector<4xf8E4M3FN> into vector<32xf8E4M3FN>
    %5 = vector.extract_strided_slice %arg0 {offsets = [4], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %6 = amdgpu.packed_scaled_trunc %5 into %cst_0[0], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %7 = vector.extract_strided_slice %arg0 {offsets = [6], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %8 = amdgpu.packed_scaled_trunc %7 into %6[1], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %9 = vector.insert_strided_slice %8, %4 {offsets = [4], strides = [1]} : vector<4xf8E4M3FN> into vector<32xf8E4M3FN>
    %10 = vector.extract_strided_slice %arg0 {offsets = [8], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %11 = amdgpu.packed_scaled_trunc %10 into %cst_0[0], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %12 = vector.extract_strided_slice %arg0 {offsets = [10], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %13 = amdgpu.packed_scaled_trunc %12 into %11[1], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %14 = vector.insert_strided_slice %13, %9 {offsets = [8], strides = [1]} : vector<4xf8E4M3FN> into vector<32xf8E4M3FN>
    %15 = vector.extract_strided_slice %arg0 {offsets = [12], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %16 = amdgpu.packed_scaled_trunc %15 into %cst_0[0], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %17 = vector.extract_strided_slice %arg0 {offsets = [14], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %18 = amdgpu.packed_scaled_trunc %17 into %16[1], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %19 = vector.insert_strided_slice %18, %14 {offsets = [12], strides = [1]} : vector<4xf8E4M3FN> into vector<32xf8E4M3FN>
    %20 = vector.extract_strided_slice %arg0 {offsets = [16], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %21 = amdgpu.packed_scaled_trunc %20 into %cst_0[0], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %22 = vector.extract_strided_slice %arg0 {offsets = [18], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %23 = amdgpu.packed_scaled_trunc %22 into %21[1], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %24 = vector.insert_strided_slice %23, %19 {offsets = [16], strides = [1]} : vector<4xf8E4M3FN> into vector<32xf8E4M3FN>
    %25 = vector.extract_strided_slice %arg0 {offsets = [20], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %26 = amdgpu.packed_scaled_trunc %25 into %cst_0[0], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %27 = vector.extract_strided_slice %arg0 {offsets = [22], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %28 = amdgpu.packed_scaled_trunc %27 into %26[1], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %29 = vector.insert_strided_slice %28, %24 {offsets = [20], strides = [1]} : vector<4xf8E4M3FN> into vector<32xf8E4M3FN>
    %30 = vector.extract_strided_slice %arg0 {offsets = [24], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %31 = amdgpu.packed_scaled_trunc %30 into %cst_0[0], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %32 = vector.extract_strided_slice %arg0 {offsets = [26], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %33 = amdgpu.packed_scaled_trunc %32 into %31[1], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %34 = vector.insert_strided_slice %33, %29 {offsets = [24], strides = [1]} : vector<4xf8E4M3FN> into vector<32xf8E4M3FN>
    %35 = vector.extract_strided_slice %arg0 {offsets = [28], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %36 = amdgpu.packed_scaled_trunc %35 into %cst_0[0], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %37 = vector.extract_strided_slice %arg0 {offsets = [30], sizes = [2], strides = [1]} : vector<32xf32> to vector<2xf32>
    %38 = amdgpu.packed_scaled_trunc %37 into %36[1], %arg1 : vector<2xf32> to vector<4xf8E4M3FN> into vector<4xf8E4M3FN>
    %39 = vector.insert_strided_slice %38, %34 {offsets = [28], strides = [1]} : vector<4xf8E4M3FN> into vector<32xf8E4M3FN>
    return %39 : vector<32xf8E4M3FN>
  }
}

