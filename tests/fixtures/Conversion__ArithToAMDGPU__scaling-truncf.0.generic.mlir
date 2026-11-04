"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf8E5M2>, sym_name = "conversion_f8_fallback"}> ({
  ^bb0(%arg0: vector<2x2xf32>, %arg1: vector<2x2xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf8E5M2>}> : () -> vector<2x2xf8E5M2>
    %1 = "arith.extf"(%arg1) : (vector<2x2xf8E8M0FNU>) -> vector<2x2xf32>
    %2 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf32>) -> vector<1x1xf32>
    %3 = "vector.shape_cast"(%2) : (vector<1x1xf32>) -> vector<1xf32>
    %4 = "vector.extract"(%1) <{static_position = array<i64: 0, 0>}> : (vector<2x2xf32>) -> f32
    %5 = "amdgpu.packed_scaled_trunc"(%3, %4) <{index = 0 : i32}> : (vector<1xf32>, f32) -> vector<4xf8E5M2>
    %6 = "vector.extract_strided_slice"(%5) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<4xf8E5M2>) -> vector<1xf8E5M2>
    %7 = "vector.shape_cast"(%6) : (vector<1xf8E5M2>) -> vector<1x1xf8E5M2>
    %8 = "vector.insert_strided_slice"(%7, %0) <{offsets = [0, 0], strides = [1, 1]}> : (vector<1x1xf8E5M2>, vector<2x2xf8E5M2>) -> vector<2x2xf8E5M2>
    %9 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf32>) -> vector<1x1xf32>
    %10 = "vector.shape_cast"(%9) : (vector<1x1xf32>) -> vector<1xf32>
    %11 = "vector.extract"(%1) <{static_position = array<i64: 0, 1>}> : (vector<2x2xf32>) -> f32
    %12 = "amdgpu.packed_scaled_trunc"(%10, %11) <{index = 0 : i32}> : (vector<1xf32>, f32) -> vector<4xf8E5M2>
    %13 = "vector.extract_strided_slice"(%12) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<4xf8E5M2>) -> vector<1xf8E5M2>
    %14 = "vector.shape_cast"(%13) : (vector<1xf8E5M2>) -> vector<1x1xf8E5M2>
    %15 = "vector.insert_strided_slice"(%14, %8) <{offsets = [0, 1], strides = [1, 1]}> : (vector<1x1xf8E5M2>, vector<2x2xf8E5M2>) -> vector<2x2xf8E5M2>
    %16 = "vector.extract_strided_slice"(%arg0) <{offsets = [1, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf32>) -> vector<1x1xf32>
    %17 = "vector.shape_cast"(%16) : (vector<1x1xf32>) -> vector<1xf32>
    %18 = "vector.extract"(%1) <{static_position = array<i64: 1, 0>}> : (vector<2x2xf32>) -> f32
    %19 = "amdgpu.packed_scaled_trunc"(%17, %18) <{index = 0 : i32}> : (vector<1xf32>, f32) -> vector<4xf8E5M2>
    %20 = "vector.extract_strided_slice"(%19) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<4xf8E5M2>) -> vector<1xf8E5M2>
    %21 = "vector.shape_cast"(%20) : (vector<1xf8E5M2>) -> vector<1x1xf8E5M2>
    %22 = "vector.insert_strided_slice"(%21, %15) <{offsets = [1, 0], strides = [1, 1]}> : (vector<1x1xf8E5M2>, vector<2x2xf8E5M2>) -> vector<2x2xf8E5M2>
    %23 = "vector.extract_strided_slice"(%arg0) <{offsets = [1, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf32>) -> vector<1x1xf32>
    %24 = "vector.shape_cast"(%23) : (vector<1x1xf32>) -> vector<1xf32>
    %25 = "vector.extract"(%1) <{static_position = array<i64: 1, 1>}> : (vector<2x2xf32>) -> f32
    %26 = "amdgpu.packed_scaled_trunc"(%24, %25) <{index = 0 : i32}> : (vector<1xf32>, f32) -> vector<4xf8E5M2>
    %27 = "vector.extract_strided_slice"(%26) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<4xf8E5M2>) -> vector<1xf8E5M2>
    %28 = "vector.shape_cast"(%27) : (vector<1xf8E5M2>) -> vector<1x1xf8E5M2>
    %29 = "vector.insert_strided_slice"(%28, %22) <{offsets = [1, 1], strides = [1, 1]}> : (vector<1x1xf8E5M2>, vector<2x2xf8E5M2>) -> vector<2x2xf8E5M2>
    "func.return"(%29) : (vector<2x2xf8E5M2>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf32>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf4E2M1FN>, sym_name = "conversion_f4_fallback"}> ({
  ^bb0(%arg0: vector<2x2xf32>, %arg1: vector<2x2xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf4E2M1FN>}> : () -> vector<2x2xf4E2M1FN>
    %1 = "arith.extf"(%arg1) : (vector<2x2xf8E8M0FNU>) -> vector<2x2xf32>
    %2 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf32>) -> vector<1x1xf32>
    %3 = "vector.shape_cast"(%2) : (vector<1x1xf32>) -> vector<1xf32>
    %4 = "vector.extract"(%1) <{static_position = array<i64: 0, 0>}> : (vector<2x2xf32>) -> f32
    %5 = "amdgpu.packed_scaled_trunc"(%3, %4) <{index = 0 : i32}> : (vector<1xf32>, f32) -> vector<8xf4E2M1FN>
    %6 = "vector.extract_strided_slice"(%5) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<8xf4E2M1FN>) -> vector<1xf4E2M1FN>
    %7 = "vector.shape_cast"(%6) : (vector<1xf4E2M1FN>) -> vector<1x1xf4E2M1FN>
    %8 = "vector.insert_strided_slice"(%7, %0) <{offsets = [0, 0], strides = [1, 1]}> : (vector<1x1xf4E2M1FN>, vector<2x2xf4E2M1FN>) -> vector<2x2xf4E2M1FN>
    %9 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf32>) -> vector<1x1xf32>
    %10 = "vector.shape_cast"(%9) : (vector<1x1xf32>) -> vector<1xf32>
    %11 = "vector.extract"(%1) <{static_position = array<i64: 0, 1>}> : (vector<2x2xf32>) -> f32
    %12 = "amdgpu.packed_scaled_trunc"(%10, %11) <{index = 0 : i32}> : (vector<1xf32>, f32) -> vector<8xf4E2M1FN>
    %13 = "vector.extract_strided_slice"(%12) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<8xf4E2M1FN>) -> vector<1xf4E2M1FN>
    %14 = "vector.shape_cast"(%13) : (vector<1xf4E2M1FN>) -> vector<1x1xf4E2M1FN>
    %15 = "vector.insert_strided_slice"(%14, %8) <{offsets = [0, 1], strides = [1, 1]}> : (vector<1x1xf4E2M1FN>, vector<2x2xf4E2M1FN>) -> vector<2x2xf4E2M1FN>
    %16 = "vector.extract_strided_slice"(%arg0) <{offsets = [1, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf32>) -> vector<1x1xf32>
    %17 = "vector.shape_cast"(%16) : (vector<1x1xf32>) -> vector<1xf32>
    %18 = "vector.extract"(%1) <{static_position = array<i64: 1, 0>}> : (vector<2x2xf32>) -> f32
    %19 = "amdgpu.packed_scaled_trunc"(%17, %18) <{index = 0 : i32}> : (vector<1xf32>, f32) -> vector<8xf4E2M1FN>
    %20 = "vector.extract_strided_slice"(%19) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<8xf4E2M1FN>) -> vector<1xf4E2M1FN>
    %21 = "vector.shape_cast"(%20) : (vector<1xf4E2M1FN>) -> vector<1x1xf4E2M1FN>
    %22 = "vector.insert_strided_slice"(%21, %15) <{offsets = [1, 0], strides = [1, 1]}> : (vector<1x1xf4E2M1FN>, vector<2x2xf4E2M1FN>) -> vector<2x2xf4E2M1FN>
    %23 = "vector.extract_strided_slice"(%arg0) <{offsets = [1, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf32>) -> vector<1x1xf32>
    %24 = "vector.shape_cast"(%23) : (vector<1x1xf32>) -> vector<1xf32>
    %25 = "vector.extract"(%1) <{static_position = array<i64: 1, 1>}> : (vector<2x2xf32>) -> f32
    %26 = "amdgpu.packed_scaled_trunc"(%24, %25) <{index = 0 : i32}> : (vector<1xf32>, f32) -> vector<8xf4E2M1FN>
    %27 = "vector.extract_strided_slice"(%26) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<8xf4E2M1FN>) -> vector<1xf4E2M1FN>
    %28 = "vector.shape_cast"(%27) : (vector<1xf4E2M1FN>) -> vector<1x1xf4E2M1FN>
    %29 = "vector.insert_strided_slice"(%28, %22) <{offsets = [1, 1], strides = [1, 1]}> : (vector<1x1xf4E2M1FN>, vector<2x2xf4E2M1FN>) -> vector<2x2xf4E2M1FN>
    "func.return"(%29) : (vector<2x2xf4E2M1FN>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x8xf32>, vector<8x2xf8E8M0FNU>) -> vector<8x8xf8E5M2>, sym_name = "conversion_broadcast"}> ({
  ^bb0(%arg0: vector<8x8xf32>, %arg1: vector<8x2xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E5M2>}> : () -> vector<4xf8E5M2>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<8x2x4xf8E5M2>}> : () -> vector<8x2x4xf8E5M2>
    %2 = "vector.broadcast"(%arg1) : (vector<8x2xf8E8M0FNU>) -> vector<4x8x2xf8E8M0FNU>
    %3 = "vector.shape_cast"(%arg0) : (vector<8x8xf32>) -> vector<8x2x4xf32>
    %4 = "vector.shape_cast"(%2) : (vector<4x8x2xf8E8M0FNU>) -> vector<8x2x4xf8E8M0FNU>
    %5 = "arith.extf"(%4) : (vector<8x2x4xf8E8M0FNU>) -> vector<8x2x4xf32>
    %6 = "vector.extract_strided_slice"(%3) <{offsets = [0, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %7 = "vector.shape_cast"(%6) : (vector<1x1x4xf32>) -> vector<4xf32>
    %8 = "vector.extract"(%5) <{static_position = array<i64: 0, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %9 = "vector.extract_strided_slice"(%7) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %10 = "amdgpu.packed_scaled_trunc"(%9, %8, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %11 = "vector.extract_strided_slice"(%7) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %12 = "amdgpu.packed_scaled_trunc"(%11, %8, %10) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %13 = "vector.shape_cast"(%12) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %14 = "vector.insert_strided_slice"(%13, %1) <{offsets = [0, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %15 = "vector.extract_strided_slice"(%3) <{offsets = [0, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %16 = "vector.shape_cast"(%15) : (vector<1x1x4xf32>) -> vector<4xf32>
    %17 = "vector.extract"(%5) <{static_position = array<i64: 0, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %18 = "vector.extract_strided_slice"(%16) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %19 = "amdgpu.packed_scaled_trunc"(%18, %17, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %20 = "vector.extract_strided_slice"(%16) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %21 = "amdgpu.packed_scaled_trunc"(%20, %17, %19) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %22 = "vector.shape_cast"(%21) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %23 = "vector.insert_strided_slice"(%22, %14) <{offsets = [0, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %24 = "vector.extract_strided_slice"(%3) <{offsets = [1, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %25 = "vector.shape_cast"(%24) : (vector<1x1x4xf32>) -> vector<4xf32>
    %26 = "vector.extract"(%5) <{static_position = array<i64: 1, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %27 = "vector.extract_strided_slice"(%25) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %28 = "amdgpu.packed_scaled_trunc"(%27, %26, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %29 = "vector.extract_strided_slice"(%25) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %30 = "amdgpu.packed_scaled_trunc"(%29, %26, %28) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %31 = "vector.shape_cast"(%30) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %32 = "vector.insert_strided_slice"(%31, %23) <{offsets = [1, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %33 = "vector.extract_strided_slice"(%3) <{offsets = [1, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %34 = "vector.shape_cast"(%33) : (vector<1x1x4xf32>) -> vector<4xf32>
    %35 = "vector.extract"(%5) <{static_position = array<i64: 1, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %36 = "vector.extract_strided_slice"(%34) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %37 = "amdgpu.packed_scaled_trunc"(%36, %35, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %38 = "vector.extract_strided_slice"(%34) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %39 = "amdgpu.packed_scaled_trunc"(%38, %35, %37) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %40 = "vector.shape_cast"(%39) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %41 = "vector.insert_strided_slice"(%40, %32) <{offsets = [1, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %42 = "vector.extract_strided_slice"(%3) <{offsets = [2, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %43 = "vector.shape_cast"(%42) : (vector<1x1x4xf32>) -> vector<4xf32>
    %44 = "vector.extract"(%5) <{static_position = array<i64: 2, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %45 = "vector.extract_strided_slice"(%43) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %46 = "amdgpu.packed_scaled_trunc"(%45, %44, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %47 = "vector.extract_strided_slice"(%43) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %48 = "amdgpu.packed_scaled_trunc"(%47, %44, %46) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %49 = "vector.shape_cast"(%48) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %50 = "vector.insert_strided_slice"(%49, %41) <{offsets = [2, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %51 = "vector.extract_strided_slice"(%3) <{offsets = [2, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %52 = "vector.shape_cast"(%51) : (vector<1x1x4xf32>) -> vector<4xf32>
    %53 = "vector.extract"(%5) <{static_position = array<i64: 2, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %54 = "vector.extract_strided_slice"(%52) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %55 = "amdgpu.packed_scaled_trunc"(%54, %53, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %56 = "vector.extract_strided_slice"(%52) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %57 = "amdgpu.packed_scaled_trunc"(%56, %53, %55) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %58 = "vector.shape_cast"(%57) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %59 = "vector.insert_strided_slice"(%58, %50) <{offsets = [2, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %60 = "vector.extract_strided_slice"(%3) <{offsets = [3, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %61 = "vector.shape_cast"(%60) : (vector<1x1x4xf32>) -> vector<4xf32>
    %62 = "vector.extract"(%5) <{static_position = array<i64: 3, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %63 = "vector.extract_strided_slice"(%61) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %64 = "amdgpu.packed_scaled_trunc"(%63, %62, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %65 = "vector.extract_strided_slice"(%61) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %66 = "amdgpu.packed_scaled_trunc"(%65, %62, %64) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %67 = "vector.shape_cast"(%66) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %68 = "vector.insert_strided_slice"(%67, %59) <{offsets = [3, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %69 = "vector.extract_strided_slice"(%3) <{offsets = [3, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %70 = "vector.shape_cast"(%69) : (vector<1x1x4xf32>) -> vector<4xf32>
    %71 = "vector.extract"(%5) <{static_position = array<i64: 3, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %72 = "vector.extract_strided_slice"(%70) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %73 = "amdgpu.packed_scaled_trunc"(%72, %71, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %74 = "vector.extract_strided_slice"(%70) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %75 = "amdgpu.packed_scaled_trunc"(%74, %71, %73) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %76 = "vector.shape_cast"(%75) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %77 = "vector.insert_strided_slice"(%76, %68) <{offsets = [3, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %78 = "vector.extract_strided_slice"(%3) <{offsets = [4, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %79 = "vector.shape_cast"(%78) : (vector<1x1x4xf32>) -> vector<4xf32>
    %80 = "vector.extract"(%5) <{static_position = array<i64: 4, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %81 = "vector.extract_strided_slice"(%79) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %82 = "amdgpu.packed_scaled_trunc"(%81, %80, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %83 = "vector.extract_strided_slice"(%79) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %84 = "amdgpu.packed_scaled_trunc"(%83, %80, %82) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %85 = "vector.shape_cast"(%84) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %86 = "vector.insert_strided_slice"(%85, %77) <{offsets = [4, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %87 = "vector.extract_strided_slice"(%3) <{offsets = [4, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %88 = "vector.shape_cast"(%87) : (vector<1x1x4xf32>) -> vector<4xf32>
    %89 = "vector.extract"(%5) <{static_position = array<i64: 4, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %90 = "vector.extract_strided_slice"(%88) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %91 = "amdgpu.packed_scaled_trunc"(%90, %89, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %92 = "vector.extract_strided_slice"(%88) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %93 = "amdgpu.packed_scaled_trunc"(%92, %89, %91) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %94 = "vector.shape_cast"(%93) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %95 = "vector.insert_strided_slice"(%94, %86) <{offsets = [4, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %96 = "vector.extract_strided_slice"(%3) <{offsets = [5, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %97 = "vector.shape_cast"(%96) : (vector<1x1x4xf32>) -> vector<4xf32>
    %98 = "vector.extract"(%5) <{static_position = array<i64: 5, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %99 = "vector.extract_strided_slice"(%97) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %100 = "amdgpu.packed_scaled_trunc"(%99, %98, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %101 = "vector.extract_strided_slice"(%97) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %102 = "amdgpu.packed_scaled_trunc"(%101, %98, %100) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %103 = "vector.shape_cast"(%102) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %104 = "vector.insert_strided_slice"(%103, %95) <{offsets = [5, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %105 = "vector.extract_strided_slice"(%3) <{offsets = [5, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %106 = "vector.shape_cast"(%105) : (vector<1x1x4xf32>) -> vector<4xf32>
    %107 = "vector.extract"(%5) <{static_position = array<i64: 5, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %108 = "vector.extract_strided_slice"(%106) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %109 = "amdgpu.packed_scaled_trunc"(%108, %107, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %110 = "vector.extract_strided_slice"(%106) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %111 = "amdgpu.packed_scaled_trunc"(%110, %107, %109) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %112 = "vector.shape_cast"(%111) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %113 = "vector.insert_strided_slice"(%112, %104) <{offsets = [5, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %114 = "vector.extract_strided_slice"(%3) <{offsets = [6, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %115 = "vector.shape_cast"(%114) : (vector<1x1x4xf32>) -> vector<4xf32>
    %116 = "vector.extract"(%5) <{static_position = array<i64: 6, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %117 = "vector.extract_strided_slice"(%115) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %118 = "amdgpu.packed_scaled_trunc"(%117, %116, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %119 = "vector.extract_strided_slice"(%115) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %120 = "amdgpu.packed_scaled_trunc"(%119, %116, %118) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %121 = "vector.shape_cast"(%120) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %122 = "vector.insert_strided_slice"(%121, %113) <{offsets = [6, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %123 = "vector.extract_strided_slice"(%3) <{offsets = [6, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %124 = "vector.shape_cast"(%123) : (vector<1x1x4xf32>) -> vector<4xf32>
    %125 = "vector.extract"(%5) <{static_position = array<i64: 6, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %126 = "vector.extract_strided_slice"(%124) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %127 = "amdgpu.packed_scaled_trunc"(%126, %125, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %128 = "vector.extract_strided_slice"(%124) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %129 = "amdgpu.packed_scaled_trunc"(%128, %125, %127) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %130 = "vector.shape_cast"(%129) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %131 = "vector.insert_strided_slice"(%130, %122) <{offsets = [6, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %132 = "vector.extract_strided_slice"(%3) <{offsets = [7, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %133 = "vector.shape_cast"(%132) : (vector<1x1x4xf32>) -> vector<4xf32>
    %134 = "vector.extract"(%5) <{static_position = array<i64: 7, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %135 = "vector.extract_strided_slice"(%133) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %136 = "amdgpu.packed_scaled_trunc"(%135, %134, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %137 = "vector.extract_strided_slice"(%133) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %138 = "amdgpu.packed_scaled_trunc"(%137, %134, %136) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %139 = "vector.shape_cast"(%138) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %140 = "vector.insert_strided_slice"(%139, %131) <{offsets = [7, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %141 = "vector.extract_strided_slice"(%3) <{offsets = [7, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf32>) -> vector<1x1x4xf32>
    %142 = "vector.shape_cast"(%141) : (vector<1x1x4xf32>) -> vector<4xf32>
    %143 = "vector.extract"(%5) <{static_position = array<i64: 7, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %144 = "vector.extract_strided_slice"(%142) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %145 = "amdgpu.packed_scaled_trunc"(%144, %143, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %146 = "vector.extract_strided_slice"(%142) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %147 = "amdgpu.packed_scaled_trunc"(%146, %143, %145) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %148 = "vector.shape_cast"(%147) : (vector<4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %149 = "vector.insert_strided_slice"(%148, %140) <{offsets = [7, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf8E5M2>, vector<8x2x4xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %150 = "vector.shape_cast"(%149) : (vector<8x2x4xf8E5M2>) -> vector<8x8xf8E5M2>
    "func.return"(%150) : (vector<8x8xf8E5M2>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<6xf32>, vector<2xf8E8M0FNU>) -> vector<6xf8E5M2>, sym_name = "conversion_broadcast_odd"}> ({
  ^bb0(%arg0: vector<6xf32>, %arg1: vector<2xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E5M2>}> : () -> vector<4xf8E5M2>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<6xf8E5M2>}> : () -> vector<6xf8E5M2>
    %2 = "vector.broadcast"(%arg1) : (vector<2xf8E8M0FNU>) -> vector<3x2xf8E8M0FNU>
    %3 = "vector.shape_cast"(%2) : (vector<3x2xf8E8M0FNU>) -> vector<6xf8E8M0FNU>
    %4 = "arith.extf"(%3) : (vector<6xf8E8M0FNU>) -> vector<6xf32>
    %5 = "vector.extract_strided_slice"(%arg0) <{offsets = [0], sizes = [3], strides = [1]}> : (vector<6xf32>) -> vector<3xf32>
    %6 = "vector.extract"(%4) <{static_position = array<i64: 0>}> : (vector<6xf32>) -> f32
    %7 = "vector.extract_strided_slice"(%5) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<3xf32>) -> vector<2xf32>
    %8 = "amdgpu.packed_scaled_trunc"(%7, %6, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %9 = "vector.extract_strided_slice"(%5) <{offsets = [2], sizes = [1], strides = [1]}> : (vector<3xf32>) -> vector<1xf32>
    %10 = "amdgpu.packed_scaled_trunc"(%9, %6, %8) <{index = 1 : i32}> : (vector<1xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %11 = "vector.extract_strided_slice"(%10) <{offsets = [0], sizes = [3], strides = [1]}> : (vector<4xf8E5M2>) -> vector<3xf8E5M2>
    %12 = "vector.insert_strided_slice"(%11, %1) <{offsets = [0], strides = [1]}> : (vector<3xf8E5M2>, vector<6xf8E5M2>) -> vector<6xf8E5M2>
    %13 = "vector.extract_strided_slice"(%arg0) <{offsets = [3], sizes = [3], strides = [1]}> : (vector<6xf32>) -> vector<3xf32>
    %14 = "vector.extract"(%4) <{static_position = array<i64: 3>}> : (vector<6xf32>) -> f32
    %15 = "vector.extract_strided_slice"(%13) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<3xf32>) -> vector<2xf32>
    %16 = "amdgpu.packed_scaled_trunc"(%15, %14, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %17 = "vector.extract_strided_slice"(%13) <{offsets = [2], sizes = [1], strides = [1]}> : (vector<3xf32>) -> vector<1xf32>
    %18 = "amdgpu.packed_scaled_trunc"(%17, %14, %16) <{index = 1 : i32}> : (vector<1xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %19 = "vector.extract_strided_slice"(%18) <{offsets = [0], sizes = [3], strides = [1]}> : (vector<4xf8E5M2>) -> vector<3xf8E5M2>
    %20 = "vector.insert_strided_slice"(%19, %12) <{offsets = [3], strides = [1]}> : (vector<3xf8E5M2>, vector<6xf8E5M2>) -> vector<6xf8E5M2>
    "func.return"(%20) : (vector<6xf8E5M2>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, f8E8M0FNU) -> vector<4xf8E5M2>, sym_name = "conversion_broadcast"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: f8E8M0FNU):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E5M2>}> : () -> vector<4xf8E5M2>
    %1 = "vector.broadcast"(%arg1) : (f8E8M0FNU) -> vector<4xf8E8M0FNU>
    %2 = "arith.extf"(%1) : (vector<4xf8E8M0FNU>) -> vector<4xf32>
    %3 = "vector.extract"(%2) <{static_position = array<i64: 0>}> : (vector<4xf32>) -> f32
    %4 = "vector.extract_strided_slice"(%arg0) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %5 = "amdgpu.packed_scaled_trunc"(%4, %3, %0) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    %6 = "vector.extract_strided_slice"(%arg0) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<4xf32>) -> vector<2xf32>
    %7 = "amdgpu.packed_scaled_trunc"(%6, %3, %5) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>
    "func.return"(%7) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f8E8M0FNU) -> f8E5M2, sym_name = "conversion_scalar"}> ({
  ^bb0(%arg0: f32, %arg1: f8E8M0FNU):
    %0 = "arith.extf"(%arg1) : (f8E8M0FNU) -> f32
    %1 = "vector.broadcast"(%arg0) : (f32) -> vector<1xf32>
    %2 = "amdgpu.packed_scaled_trunc"(%1, %0) <{index = 0 : i32}> : (vector<1xf32>, f32) -> vector<4xf8E5M2>
    %3 = "vector.extract"(%2) <{static_position = array<i64: 0>}> : (vector<4xf8E5M2>) -> f8E5M2
    "func.return"(%3) : (f8E5M2) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xf32>, f32) -> vector<32xf4E2M1FN>, sym_name = "long_fp4_broadcast"}> ({
  ^bb0(%arg0: vector<32xf32>, %arg1: f32):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<32xf4E2M1FN>}> : () -> vector<32xf4E2M1FN>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<8xf4E2M1FN>}> : () -> vector<8xf4E2M1FN>
    %2 = "vector.extract_strided_slice"(%arg0) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %3 = "amdgpu.packed_scaled_trunc"(%2, %arg1, %1) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %4 = "vector.extract_strided_slice"(%arg0) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %5 = "amdgpu.packed_scaled_trunc"(%4, %arg1, %3) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %6 = "vector.extract_strided_slice"(%arg0) <{offsets = [4], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %7 = "amdgpu.packed_scaled_trunc"(%6, %arg1, %5) <{index = 2 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %8 = "vector.extract_strided_slice"(%arg0) <{offsets = [6], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %9 = "amdgpu.packed_scaled_trunc"(%8, %arg1, %7) <{index = 3 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %10 = "vector.insert_strided_slice"(%9, %0) <{offsets = [0], strides = [1]}> : (vector<8xf4E2M1FN>, vector<32xf4E2M1FN>) -> vector<32xf4E2M1FN>
    %11 = "vector.extract_strided_slice"(%arg0) <{offsets = [8], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %12 = "amdgpu.packed_scaled_trunc"(%11, %arg1, %1) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %13 = "vector.extract_strided_slice"(%arg0) <{offsets = [10], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %14 = "amdgpu.packed_scaled_trunc"(%13, %arg1, %12) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %15 = "vector.extract_strided_slice"(%arg0) <{offsets = [12], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %16 = "amdgpu.packed_scaled_trunc"(%15, %arg1, %14) <{index = 2 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %17 = "vector.extract_strided_slice"(%arg0) <{offsets = [14], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %18 = "amdgpu.packed_scaled_trunc"(%17, %arg1, %16) <{index = 3 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %19 = "vector.insert_strided_slice"(%18, %10) <{offsets = [8], strides = [1]}> : (vector<8xf4E2M1FN>, vector<32xf4E2M1FN>) -> vector<32xf4E2M1FN>
    %20 = "vector.extract_strided_slice"(%arg0) <{offsets = [16], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %21 = "amdgpu.packed_scaled_trunc"(%20, %arg1, %1) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %22 = "vector.extract_strided_slice"(%arg0) <{offsets = [18], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %23 = "amdgpu.packed_scaled_trunc"(%22, %arg1, %21) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %24 = "vector.extract_strided_slice"(%arg0) <{offsets = [20], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %25 = "amdgpu.packed_scaled_trunc"(%24, %arg1, %23) <{index = 2 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %26 = "vector.extract_strided_slice"(%arg0) <{offsets = [22], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %27 = "amdgpu.packed_scaled_trunc"(%26, %arg1, %25) <{index = 3 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %28 = "vector.insert_strided_slice"(%27, %19) <{offsets = [16], strides = [1]}> : (vector<8xf4E2M1FN>, vector<32xf4E2M1FN>) -> vector<32xf4E2M1FN>
    %29 = "vector.extract_strided_slice"(%arg0) <{offsets = [24], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %30 = "amdgpu.packed_scaled_trunc"(%29, %arg1, %1) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %31 = "vector.extract_strided_slice"(%arg0) <{offsets = [26], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %32 = "amdgpu.packed_scaled_trunc"(%31, %arg1, %30) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %33 = "vector.extract_strided_slice"(%arg0) <{offsets = [28], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %34 = "amdgpu.packed_scaled_trunc"(%33, %arg1, %32) <{index = 2 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %35 = "vector.extract_strided_slice"(%arg0) <{offsets = [30], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %36 = "amdgpu.packed_scaled_trunc"(%35, %arg1, %34) <{index = 3 : i32}> : (vector<2xf32>, f32, vector<8xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %37 = "vector.insert_strided_slice"(%36, %28) <{offsets = [24], strides = [1]}> : (vector<8xf4E2M1FN>, vector<32xf4E2M1FN>) -> vector<32xf4E2M1FN>
    "func.return"(%37) : (vector<32xf4E2M1FN>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xf32>, f32) -> vector<32xf8E4M3FN>, sym_name = "long_fp8_broadcast"}> ({
  ^bb0(%arg0: vector<32xf32>, %arg1: f32):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<32xf8E4M3FN>}> : () -> vector<32xf8E4M3FN>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf8E4M3FN>}> : () -> vector<4xf8E4M3FN>
    %2 = "vector.extract_strided_slice"(%arg0) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %3 = "amdgpu.packed_scaled_trunc"(%2, %arg1, %1) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %4 = "vector.extract_strided_slice"(%arg0) <{offsets = [2], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %5 = "amdgpu.packed_scaled_trunc"(%4, %arg1, %3) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %6 = "vector.insert_strided_slice"(%5, %0) <{offsets = [0], strides = [1]}> : (vector<4xf8E4M3FN>, vector<32xf8E4M3FN>) -> vector<32xf8E4M3FN>
    %7 = "vector.extract_strided_slice"(%arg0) <{offsets = [4], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %8 = "amdgpu.packed_scaled_trunc"(%7, %arg1, %1) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %9 = "vector.extract_strided_slice"(%arg0) <{offsets = [6], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %10 = "amdgpu.packed_scaled_trunc"(%9, %arg1, %8) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %11 = "vector.insert_strided_slice"(%10, %6) <{offsets = [4], strides = [1]}> : (vector<4xf8E4M3FN>, vector<32xf8E4M3FN>) -> vector<32xf8E4M3FN>
    %12 = "vector.extract_strided_slice"(%arg0) <{offsets = [8], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %13 = "amdgpu.packed_scaled_trunc"(%12, %arg1, %1) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %14 = "vector.extract_strided_slice"(%arg0) <{offsets = [10], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %15 = "amdgpu.packed_scaled_trunc"(%14, %arg1, %13) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %16 = "vector.insert_strided_slice"(%15, %11) <{offsets = [8], strides = [1]}> : (vector<4xf8E4M3FN>, vector<32xf8E4M3FN>) -> vector<32xf8E4M3FN>
    %17 = "vector.extract_strided_slice"(%arg0) <{offsets = [12], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %18 = "amdgpu.packed_scaled_trunc"(%17, %arg1, %1) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %19 = "vector.extract_strided_slice"(%arg0) <{offsets = [14], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %20 = "amdgpu.packed_scaled_trunc"(%19, %arg1, %18) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %21 = "vector.insert_strided_slice"(%20, %16) <{offsets = [12], strides = [1]}> : (vector<4xf8E4M3FN>, vector<32xf8E4M3FN>) -> vector<32xf8E4M3FN>
    %22 = "vector.extract_strided_slice"(%arg0) <{offsets = [16], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %23 = "amdgpu.packed_scaled_trunc"(%22, %arg1, %1) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %24 = "vector.extract_strided_slice"(%arg0) <{offsets = [18], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %25 = "amdgpu.packed_scaled_trunc"(%24, %arg1, %23) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %26 = "vector.insert_strided_slice"(%25, %21) <{offsets = [16], strides = [1]}> : (vector<4xf8E4M3FN>, vector<32xf8E4M3FN>) -> vector<32xf8E4M3FN>
    %27 = "vector.extract_strided_slice"(%arg0) <{offsets = [20], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %28 = "amdgpu.packed_scaled_trunc"(%27, %arg1, %1) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %29 = "vector.extract_strided_slice"(%arg0) <{offsets = [22], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %30 = "amdgpu.packed_scaled_trunc"(%29, %arg1, %28) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %31 = "vector.insert_strided_slice"(%30, %26) <{offsets = [20], strides = [1]}> : (vector<4xf8E4M3FN>, vector<32xf8E4M3FN>) -> vector<32xf8E4M3FN>
    %32 = "vector.extract_strided_slice"(%arg0) <{offsets = [24], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %33 = "amdgpu.packed_scaled_trunc"(%32, %arg1, %1) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %34 = "vector.extract_strided_slice"(%arg0) <{offsets = [26], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %35 = "amdgpu.packed_scaled_trunc"(%34, %arg1, %33) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %36 = "vector.insert_strided_slice"(%35, %31) <{offsets = [24], strides = [1]}> : (vector<4xf8E4M3FN>, vector<32xf8E4M3FN>) -> vector<32xf8E4M3FN>
    %37 = "vector.extract_strided_slice"(%arg0) <{offsets = [28], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %38 = "amdgpu.packed_scaled_trunc"(%37, %arg1, %1) <{index = 0 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %39 = "vector.extract_strided_slice"(%arg0) <{offsets = [30], sizes = [2], strides = [1]}> : (vector<32xf32>) -> vector<2xf32>
    %40 = "amdgpu.packed_scaled_trunc"(%39, %arg1, %38) <{index = 1 : i32}> : (vector<2xf32>, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %41 = "vector.insert_strided_slice"(%40, %36) <{offsets = [28], strides = [1]}> : (vector<4xf8E4M3FN>, vector<32xf8E4M3FN>) -> vector<32xf8E4M3FN>
    "func.return"(%41) : (vector<32xf8E4M3FN>) -> ()
  }) : () -> ()
}) : () -> ()

