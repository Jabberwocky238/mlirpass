"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf8E5M2>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf32>, sym_name = "conversion_f8_f32_fallback"}> ({
  ^bb0(%arg0: vector<2x2xf8E5M2>, %arg1: vector<2x2xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf32>}> : () -> vector<2x2xf32>
    %1 = "arith.extf"(%arg1) : (vector<2x2xf8E8M0FNU>) -> vector<2x2xf32>
    %2 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf8E5M2>) -> vector<1x1xf8E5M2>
    %3 = "vector.shape_cast"(%2) : (vector<1x1xf8E5M2>) -> vector<1xf8E5M2>
    %4 = "vector.extract"(%1) <{static_position = array<i64: 0, 0>}> : (vector<2x2xf32>) -> f32
    %5 = "amdgpu.scaled_ext_packed"(%3, %4) <{index = 0 : i32}> : (vector<1xf8E5M2>, f32) -> vector<2xf32>
    %6 = "vector.extract_strided_slice"(%5) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf32>) -> vector<1xf32>
    %7 = "vector.shape_cast"(%6) : (vector<1xf32>) -> vector<1x1xf32>
    %8 = "vector.insert_strided_slice"(%7, %0) <{offsets = [0, 0], strides = [1, 1]}> : (vector<1x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    %9 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf8E5M2>) -> vector<1x1xf8E5M2>
    %10 = "vector.shape_cast"(%9) : (vector<1x1xf8E5M2>) -> vector<1xf8E5M2>
    %11 = "vector.extract"(%1) <{static_position = array<i64: 0, 1>}> : (vector<2x2xf32>) -> f32
    %12 = "amdgpu.scaled_ext_packed"(%10, %11) <{index = 0 : i32}> : (vector<1xf8E5M2>, f32) -> vector<2xf32>
    %13 = "vector.extract_strided_slice"(%12) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf32>) -> vector<1xf32>
    %14 = "vector.shape_cast"(%13) : (vector<1xf32>) -> vector<1x1xf32>
    %15 = "vector.insert_strided_slice"(%14, %8) <{offsets = [0, 1], strides = [1, 1]}> : (vector<1x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    %16 = "vector.extract_strided_slice"(%arg0) <{offsets = [1, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf8E5M2>) -> vector<1x1xf8E5M2>
    %17 = "vector.shape_cast"(%16) : (vector<1x1xf8E5M2>) -> vector<1xf8E5M2>
    %18 = "vector.extract"(%1) <{static_position = array<i64: 1, 0>}> : (vector<2x2xf32>) -> f32
    %19 = "amdgpu.scaled_ext_packed"(%17, %18) <{index = 0 : i32}> : (vector<1xf8E5M2>, f32) -> vector<2xf32>
    %20 = "vector.extract_strided_slice"(%19) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf32>) -> vector<1xf32>
    %21 = "vector.shape_cast"(%20) : (vector<1xf32>) -> vector<1x1xf32>
    %22 = "vector.insert_strided_slice"(%21, %15) <{offsets = [1, 0], strides = [1, 1]}> : (vector<1x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    %23 = "vector.extract_strided_slice"(%arg0) <{offsets = [1, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf8E5M2>) -> vector<1x1xf8E5M2>
    %24 = "vector.shape_cast"(%23) : (vector<1x1xf8E5M2>) -> vector<1xf8E5M2>
    %25 = "vector.extract"(%1) <{static_position = array<i64: 1, 1>}> : (vector<2x2xf32>) -> f32
    %26 = "amdgpu.scaled_ext_packed"(%24, %25) <{index = 0 : i32}> : (vector<1xf8E5M2>, f32) -> vector<2xf32>
    %27 = "vector.extract_strided_slice"(%26) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf32>) -> vector<1xf32>
    %28 = "vector.shape_cast"(%27) : (vector<1xf32>) -> vector<1x1xf32>
    %29 = "vector.insert_strided_slice"(%28, %22) <{offsets = [1, 1], strides = [1, 1]}> : (vector<1x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    "func.return"(%29) : (vector<2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf4E2M1FN>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf32>, sym_name = "conversion_f4_f32_fallback"}> ({
  ^bb0(%arg0: vector<2x2xf4E2M1FN>, %arg1: vector<2x2xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf32>}> : () -> vector<2x2xf32>
    %1 = "arith.extf"(%arg1) : (vector<2x2xf8E8M0FNU>) -> vector<2x2xf32>
    %2 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf4E2M1FN>) -> vector<1x1xf4E2M1FN>
    %3 = "vector.shape_cast"(%2) : (vector<1x1xf4E2M1FN>) -> vector<1xf4E2M1FN>
    %4 = "vector.extract"(%1) <{static_position = array<i64: 0, 0>}> : (vector<2x2xf32>) -> f32
    %5 = "amdgpu.scaled_ext_packed"(%3, %4) <{index = 0 : i32}> : (vector<1xf4E2M1FN>, f32) -> vector<2xf32>
    %6 = "vector.extract_strided_slice"(%5) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf32>) -> vector<1xf32>
    %7 = "vector.shape_cast"(%6) : (vector<1xf32>) -> vector<1x1xf32>
    %8 = "vector.insert_strided_slice"(%7, %0) <{offsets = [0, 0], strides = [1, 1]}> : (vector<1x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    %9 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf4E2M1FN>) -> vector<1x1xf4E2M1FN>
    %10 = "vector.shape_cast"(%9) : (vector<1x1xf4E2M1FN>) -> vector<1xf4E2M1FN>
    %11 = "vector.extract"(%1) <{static_position = array<i64: 0, 1>}> : (vector<2x2xf32>) -> f32
    %12 = "amdgpu.scaled_ext_packed"(%10, %11) <{index = 0 : i32}> : (vector<1xf4E2M1FN>, f32) -> vector<2xf32>
    %13 = "vector.extract_strided_slice"(%12) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf32>) -> vector<1xf32>
    %14 = "vector.shape_cast"(%13) : (vector<1xf32>) -> vector<1x1xf32>
    %15 = "vector.insert_strided_slice"(%14, %8) <{offsets = [0, 1], strides = [1, 1]}> : (vector<1x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    %16 = "vector.extract_strided_slice"(%arg0) <{offsets = [1, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf4E2M1FN>) -> vector<1x1xf4E2M1FN>
    %17 = "vector.shape_cast"(%16) : (vector<1x1xf4E2M1FN>) -> vector<1xf4E2M1FN>
    %18 = "vector.extract"(%1) <{static_position = array<i64: 1, 0>}> : (vector<2x2xf32>) -> f32
    %19 = "amdgpu.scaled_ext_packed"(%17, %18) <{index = 0 : i32}> : (vector<1xf4E2M1FN>, f32) -> vector<2xf32>
    %20 = "vector.extract_strided_slice"(%19) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf32>) -> vector<1xf32>
    %21 = "vector.shape_cast"(%20) : (vector<1xf32>) -> vector<1x1xf32>
    %22 = "vector.insert_strided_slice"(%21, %15) <{offsets = [1, 0], strides = [1, 1]}> : (vector<1x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    %23 = "vector.extract_strided_slice"(%arg0) <{offsets = [1, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf4E2M1FN>) -> vector<1x1xf4E2M1FN>
    %24 = "vector.shape_cast"(%23) : (vector<1x1xf4E2M1FN>) -> vector<1xf4E2M1FN>
    %25 = "vector.extract"(%1) <{static_position = array<i64: 1, 1>}> : (vector<2x2xf32>) -> f32
    %26 = "amdgpu.scaled_ext_packed"(%24, %25) <{index = 0 : i32}> : (vector<1xf4E2M1FN>, f32) -> vector<2xf32>
    %27 = "vector.extract_strided_slice"(%26) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf32>) -> vector<1xf32>
    %28 = "vector.shape_cast"(%27) : (vector<1xf32>) -> vector<1x1xf32>
    %29 = "vector.insert_strided_slice"(%28, %22) <{offsets = [1, 1], strides = [1, 1]}> : (vector<1x1xf32>, vector<2x2xf32>) -> vector<2x2xf32>
    "func.return"(%29) : (vector<2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf8E5M2>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf16>, sym_name = "conversion_f8_f16_fallback"}> ({
  ^bb0(%arg0: vector<2x2xf8E5M2>, %arg1: vector<2x2xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf16>}> : () -> vector<2x2xf16>
    %1 = "arith.extf"(%arg1) : (vector<2x2xf8E8M0FNU>) -> vector<2x2xf32>
    %2 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf8E5M2>) -> vector<1x1xf8E5M2>
    %3 = "vector.shape_cast"(%2) : (vector<1x1xf8E5M2>) -> vector<1xf8E5M2>
    %4 = "vector.extract"(%1) <{static_position = array<i64: 0, 0>}> : (vector<2x2xf32>) -> f32
    %5 = "amdgpu.scaled_ext_packed"(%3, %4) <{index = 0 : i32}> : (vector<1xf8E5M2>, f32) -> vector<2xf16>
    %6 = "vector.extract_strided_slice"(%5) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf16>) -> vector<1xf16>
    %7 = "vector.shape_cast"(%6) : (vector<1xf16>) -> vector<1x1xf16>
    %8 = "vector.insert_strided_slice"(%7, %0) <{offsets = [0, 0], strides = [1, 1]}> : (vector<1x1xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %9 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf8E5M2>) -> vector<1x1xf8E5M2>
    %10 = "vector.shape_cast"(%9) : (vector<1x1xf8E5M2>) -> vector<1xf8E5M2>
    %11 = "vector.extract"(%1) <{static_position = array<i64: 0, 1>}> : (vector<2x2xf32>) -> f32
    %12 = "amdgpu.scaled_ext_packed"(%10, %11) <{index = 0 : i32}> : (vector<1xf8E5M2>, f32) -> vector<2xf16>
    %13 = "vector.extract_strided_slice"(%12) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf16>) -> vector<1xf16>
    %14 = "vector.shape_cast"(%13) : (vector<1xf16>) -> vector<1x1xf16>
    %15 = "vector.insert_strided_slice"(%14, %8) <{offsets = [0, 1], strides = [1, 1]}> : (vector<1x1xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %16 = "vector.extract_strided_slice"(%arg0) <{offsets = [1, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf8E5M2>) -> vector<1x1xf8E5M2>
    %17 = "vector.shape_cast"(%16) : (vector<1x1xf8E5M2>) -> vector<1xf8E5M2>
    %18 = "vector.extract"(%1) <{static_position = array<i64: 1, 0>}> : (vector<2x2xf32>) -> f32
    %19 = "amdgpu.scaled_ext_packed"(%17, %18) <{index = 0 : i32}> : (vector<1xf8E5M2>, f32) -> vector<2xf16>
    %20 = "vector.extract_strided_slice"(%19) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf16>) -> vector<1xf16>
    %21 = "vector.shape_cast"(%20) : (vector<1xf16>) -> vector<1x1xf16>
    %22 = "vector.insert_strided_slice"(%21, %15) <{offsets = [1, 0], strides = [1, 1]}> : (vector<1x1xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %23 = "vector.extract_strided_slice"(%arg0) <{offsets = [1, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf8E5M2>) -> vector<1x1xf8E5M2>
    %24 = "vector.shape_cast"(%23) : (vector<1x1xf8E5M2>) -> vector<1xf8E5M2>
    %25 = "vector.extract"(%1) <{static_position = array<i64: 1, 1>}> : (vector<2x2xf32>) -> f32
    %26 = "amdgpu.scaled_ext_packed"(%24, %25) <{index = 0 : i32}> : (vector<1xf8E5M2>, f32) -> vector<2xf16>
    %27 = "vector.extract_strided_slice"(%26) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf16>) -> vector<1xf16>
    %28 = "vector.shape_cast"(%27) : (vector<1xf16>) -> vector<1x1xf16>
    %29 = "vector.insert_strided_slice"(%28, %22) <{offsets = [1, 1], strides = [1, 1]}> : (vector<1x1xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    "func.return"(%29) : (vector<2x2xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf4E2M1FN>, vector<2x2xf8E8M0FNU>) -> vector<2x2xf16>, sym_name = "conversion_f4_f16_fallback"}> ({
  ^bb0(%arg0: vector<2x2xf4E2M1FN>, %arg1: vector<2x2xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2x2xf16>}> : () -> vector<2x2xf16>
    %1 = "arith.extf"(%arg1) : (vector<2x2xf8E8M0FNU>) -> vector<2x2xf32>
    %2 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf4E2M1FN>) -> vector<1x1xf4E2M1FN>
    %3 = "vector.shape_cast"(%2) : (vector<1x1xf4E2M1FN>) -> vector<1xf4E2M1FN>
    %4 = "vector.extract"(%1) <{static_position = array<i64: 0, 0>}> : (vector<2x2xf32>) -> f32
    %5 = "amdgpu.scaled_ext_packed"(%3, %4) <{index = 0 : i32}> : (vector<1xf4E2M1FN>, f32) -> vector<2xf16>
    %6 = "vector.extract_strided_slice"(%5) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf16>) -> vector<1xf16>
    %7 = "vector.shape_cast"(%6) : (vector<1xf16>) -> vector<1x1xf16>
    %8 = "vector.insert_strided_slice"(%7, %0) <{offsets = [0, 0], strides = [1, 1]}> : (vector<1x1xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %9 = "vector.extract_strided_slice"(%arg0) <{offsets = [0, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf4E2M1FN>) -> vector<1x1xf4E2M1FN>
    %10 = "vector.shape_cast"(%9) : (vector<1x1xf4E2M1FN>) -> vector<1xf4E2M1FN>
    %11 = "vector.extract"(%1) <{static_position = array<i64: 0, 1>}> : (vector<2x2xf32>) -> f32
    %12 = "amdgpu.scaled_ext_packed"(%10, %11) <{index = 0 : i32}> : (vector<1xf4E2M1FN>, f32) -> vector<2xf16>
    %13 = "vector.extract_strided_slice"(%12) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf16>) -> vector<1xf16>
    %14 = "vector.shape_cast"(%13) : (vector<1xf16>) -> vector<1x1xf16>
    %15 = "vector.insert_strided_slice"(%14, %8) <{offsets = [0, 1], strides = [1, 1]}> : (vector<1x1xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %16 = "vector.extract_strided_slice"(%arg0) <{offsets = [1, 0], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf4E2M1FN>) -> vector<1x1xf4E2M1FN>
    %17 = "vector.shape_cast"(%16) : (vector<1x1xf4E2M1FN>) -> vector<1xf4E2M1FN>
    %18 = "vector.extract"(%1) <{static_position = array<i64: 1, 0>}> : (vector<2x2xf32>) -> f32
    %19 = "amdgpu.scaled_ext_packed"(%17, %18) <{index = 0 : i32}> : (vector<1xf4E2M1FN>, f32) -> vector<2xf16>
    %20 = "vector.extract_strided_slice"(%19) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf16>) -> vector<1xf16>
    %21 = "vector.shape_cast"(%20) : (vector<1xf16>) -> vector<1x1xf16>
    %22 = "vector.insert_strided_slice"(%21, %15) <{offsets = [1, 0], strides = [1, 1]}> : (vector<1x1xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    %23 = "vector.extract_strided_slice"(%arg0) <{offsets = [1, 1], sizes = [1, 1], strides = [1, 1]}> : (vector<2x2xf4E2M1FN>) -> vector<1x1xf4E2M1FN>
    %24 = "vector.shape_cast"(%23) : (vector<1x1xf4E2M1FN>) -> vector<1xf4E2M1FN>
    %25 = "vector.extract"(%1) <{static_position = array<i64: 1, 1>}> : (vector<2x2xf32>) -> f32
    %26 = "amdgpu.scaled_ext_packed"(%24, %25) <{index = 0 : i32}> : (vector<1xf4E2M1FN>, f32) -> vector<2xf16>
    %27 = "vector.extract_strided_slice"(%26) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf16>) -> vector<1xf16>
    %28 = "vector.shape_cast"(%27) : (vector<1xf16>) -> vector<1x1xf16>
    %29 = "vector.insert_strided_slice"(%28, %22) <{offsets = [1, 1], strides = [1, 1]}> : (vector<1x1xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    "func.return"(%29) : (vector<2x2xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<8x8xf8E5M2>, vector<8x2xf8E8M0FNU>) -> vector<8x8xf32>, sym_name = "conversion_broadcast"}> ({
  ^bb0(%arg0: vector<8x8xf8E5M2>, %arg1: vector<8x2xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<8x2x4xf32>}> : () -> vector<8x2x4xf32>
    %2 = "vector.broadcast"(%arg1) : (vector<8x2xf8E8M0FNU>) -> vector<4x8x2xf8E8M0FNU>
    %3 = "vector.shape_cast"(%arg0) : (vector<8x8xf8E5M2>) -> vector<8x2x4xf8E5M2>
    %4 = "vector.shape_cast"(%2) : (vector<4x8x2xf8E8M0FNU>) -> vector<8x2x4xf8E8M0FNU>
    %5 = "arith.extf"(%4) : (vector<8x2x4xf8E8M0FNU>) -> vector<8x2x4xf32>
    %6 = "vector.extract_strided_slice"(%3) <{offsets = [0, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %7 = "vector.shape_cast"(%6) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %8 = "vector.extract"(%5) <{static_position = array<i64: 0, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %9 = "amdgpu.scaled_ext_packed"(%7, %8) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %10 = "vector.insert_strided_slice"(%9, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %11 = "amdgpu.scaled_ext_packed"(%7, %8) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %12 = "vector.insert_strided_slice"(%11, %10) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %13 = "vector.shape_cast"(%12) : (vector<4xf32>) -> vector<1x1x4xf32>
    %14 = "vector.insert_strided_slice"(%13, %1) <{offsets = [0, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %15 = "vector.extract_strided_slice"(%3) <{offsets = [0, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %16 = "vector.shape_cast"(%15) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %17 = "vector.extract"(%5) <{static_position = array<i64: 0, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %18 = "amdgpu.scaled_ext_packed"(%16, %17) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %19 = "vector.insert_strided_slice"(%18, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %20 = "amdgpu.scaled_ext_packed"(%16, %17) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %21 = "vector.insert_strided_slice"(%20, %19) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %22 = "vector.shape_cast"(%21) : (vector<4xf32>) -> vector<1x1x4xf32>
    %23 = "vector.insert_strided_slice"(%22, %14) <{offsets = [0, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %24 = "vector.extract_strided_slice"(%3) <{offsets = [1, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %25 = "vector.shape_cast"(%24) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %26 = "vector.extract"(%5) <{static_position = array<i64: 1, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %27 = "amdgpu.scaled_ext_packed"(%25, %26) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %28 = "vector.insert_strided_slice"(%27, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %29 = "amdgpu.scaled_ext_packed"(%25, %26) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %30 = "vector.insert_strided_slice"(%29, %28) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %31 = "vector.shape_cast"(%30) : (vector<4xf32>) -> vector<1x1x4xf32>
    %32 = "vector.insert_strided_slice"(%31, %23) <{offsets = [1, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %33 = "vector.extract_strided_slice"(%3) <{offsets = [1, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %34 = "vector.shape_cast"(%33) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %35 = "vector.extract"(%5) <{static_position = array<i64: 1, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %36 = "amdgpu.scaled_ext_packed"(%34, %35) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %37 = "vector.insert_strided_slice"(%36, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %38 = "amdgpu.scaled_ext_packed"(%34, %35) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %39 = "vector.insert_strided_slice"(%38, %37) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %40 = "vector.shape_cast"(%39) : (vector<4xf32>) -> vector<1x1x4xf32>
    %41 = "vector.insert_strided_slice"(%40, %32) <{offsets = [1, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %42 = "vector.extract_strided_slice"(%3) <{offsets = [2, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %43 = "vector.shape_cast"(%42) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %44 = "vector.extract"(%5) <{static_position = array<i64: 2, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %45 = "amdgpu.scaled_ext_packed"(%43, %44) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %46 = "vector.insert_strided_slice"(%45, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %47 = "amdgpu.scaled_ext_packed"(%43, %44) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %48 = "vector.insert_strided_slice"(%47, %46) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %49 = "vector.shape_cast"(%48) : (vector<4xf32>) -> vector<1x1x4xf32>
    %50 = "vector.insert_strided_slice"(%49, %41) <{offsets = [2, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %51 = "vector.extract_strided_slice"(%3) <{offsets = [2, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %52 = "vector.shape_cast"(%51) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %53 = "vector.extract"(%5) <{static_position = array<i64: 2, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %54 = "amdgpu.scaled_ext_packed"(%52, %53) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %55 = "vector.insert_strided_slice"(%54, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %56 = "amdgpu.scaled_ext_packed"(%52, %53) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %57 = "vector.insert_strided_slice"(%56, %55) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %58 = "vector.shape_cast"(%57) : (vector<4xf32>) -> vector<1x1x4xf32>
    %59 = "vector.insert_strided_slice"(%58, %50) <{offsets = [2, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %60 = "vector.extract_strided_slice"(%3) <{offsets = [3, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %61 = "vector.shape_cast"(%60) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %62 = "vector.extract"(%5) <{static_position = array<i64: 3, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %63 = "amdgpu.scaled_ext_packed"(%61, %62) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %64 = "vector.insert_strided_slice"(%63, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %65 = "amdgpu.scaled_ext_packed"(%61, %62) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %66 = "vector.insert_strided_slice"(%65, %64) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %67 = "vector.shape_cast"(%66) : (vector<4xf32>) -> vector<1x1x4xf32>
    %68 = "vector.insert_strided_slice"(%67, %59) <{offsets = [3, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %69 = "vector.extract_strided_slice"(%3) <{offsets = [3, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %70 = "vector.shape_cast"(%69) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %71 = "vector.extract"(%5) <{static_position = array<i64: 3, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %72 = "amdgpu.scaled_ext_packed"(%70, %71) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %73 = "vector.insert_strided_slice"(%72, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %74 = "amdgpu.scaled_ext_packed"(%70, %71) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %75 = "vector.insert_strided_slice"(%74, %73) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %76 = "vector.shape_cast"(%75) : (vector<4xf32>) -> vector<1x1x4xf32>
    %77 = "vector.insert_strided_slice"(%76, %68) <{offsets = [3, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %78 = "vector.extract_strided_slice"(%3) <{offsets = [4, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %79 = "vector.shape_cast"(%78) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %80 = "vector.extract"(%5) <{static_position = array<i64: 4, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %81 = "amdgpu.scaled_ext_packed"(%79, %80) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %82 = "vector.insert_strided_slice"(%81, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %83 = "amdgpu.scaled_ext_packed"(%79, %80) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %84 = "vector.insert_strided_slice"(%83, %82) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %85 = "vector.shape_cast"(%84) : (vector<4xf32>) -> vector<1x1x4xf32>
    %86 = "vector.insert_strided_slice"(%85, %77) <{offsets = [4, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %87 = "vector.extract_strided_slice"(%3) <{offsets = [4, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %88 = "vector.shape_cast"(%87) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %89 = "vector.extract"(%5) <{static_position = array<i64: 4, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %90 = "amdgpu.scaled_ext_packed"(%88, %89) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %91 = "vector.insert_strided_slice"(%90, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %92 = "amdgpu.scaled_ext_packed"(%88, %89) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %93 = "vector.insert_strided_slice"(%92, %91) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %94 = "vector.shape_cast"(%93) : (vector<4xf32>) -> vector<1x1x4xf32>
    %95 = "vector.insert_strided_slice"(%94, %86) <{offsets = [4, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %96 = "vector.extract_strided_slice"(%3) <{offsets = [5, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %97 = "vector.shape_cast"(%96) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %98 = "vector.extract"(%5) <{static_position = array<i64: 5, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %99 = "amdgpu.scaled_ext_packed"(%97, %98) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %100 = "vector.insert_strided_slice"(%99, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %101 = "amdgpu.scaled_ext_packed"(%97, %98) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %102 = "vector.insert_strided_slice"(%101, %100) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %103 = "vector.shape_cast"(%102) : (vector<4xf32>) -> vector<1x1x4xf32>
    %104 = "vector.insert_strided_slice"(%103, %95) <{offsets = [5, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %105 = "vector.extract_strided_slice"(%3) <{offsets = [5, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %106 = "vector.shape_cast"(%105) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %107 = "vector.extract"(%5) <{static_position = array<i64: 5, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %108 = "amdgpu.scaled_ext_packed"(%106, %107) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %109 = "vector.insert_strided_slice"(%108, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %110 = "amdgpu.scaled_ext_packed"(%106, %107) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %111 = "vector.insert_strided_slice"(%110, %109) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %112 = "vector.shape_cast"(%111) : (vector<4xf32>) -> vector<1x1x4xf32>
    %113 = "vector.insert_strided_slice"(%112, %104) <{offsets = [5, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %114 = "vector.extract_strided_slice"(%3) <{offsets = [6, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %115 = "vector.shape_cast"(%114) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %116 = "vector.extract"(%5) <{static_position = array<i64: 6, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %117 = "amdgpu.scaled_ext_packed"(%115, %116) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %118 = "vector.insert_strided_slice"(%117, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %119 = "amdgpu.scaled_ext_packed"(%115, %116) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %120 = "vector.insert_strided_slice"(%119, %118) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %121 = "vector.shape_cast"(%120) : (vector<4xf32>) -> vector<1x1x4xf32>
    %122 = "vector.insert_strided_slice"(%121, %113) <{offsets = [6, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %123 = "vector.extract_strided_slice"(%3) <{offsets = [6, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %124 = "vector.shape_cast"(%123) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %125 = "vector.extract"(%5) <{static_position = array<i64: 6, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %126 = "amdgpu.scaled_ext_packed"(%124, %125) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %127 = "vector.insert_strided_slice"(%126, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %128 = "amdgpu.scaled_ext_packed"(%124, %125) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %129 = "vector.insert_strided_slice"(%128, %127) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %130 = "vector.shape_cast"(%129) : (vector<4xf32>) -> vector<1x1x4xf32>
    %131 = "vector.insert_strided_slice"(%130, %122) <{offsets = [6, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %132 = "vector.extract_strided_slice"(%3) <{offsets = [7, 0, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %133 = "vector.shape_cast"(%132) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %134 = "vector.extract"(%5) <{static_position = array<i64: 7, 0, 0>}> : (vector<8x2x4xf32>) -> f32
    %135 = "amdgpu.scaled_ext_packed"(%133, %134) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %136 = "vector.insert_strided_slice"(%135, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %137 = "amdgpu.scaled_ext_packed"(%133, %134) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %138 = "vector.insert_strided_slice"(%137, %136) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %139 = "vector.shape_cast"(%138) : (vector<4xf32>) -> vector<1x1x4xf32>
    %140 = "vector.insert_strided_slice"(%139, %131) <{offsets = [7, 0, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %141 = "vector.extract_strided_slice"(%3) <{offsets = [7, 1, 0], sizes = [1, 1, 4], strides = [1, 1, 1]}> : (vector<8x2x4xf8E5M2>) -> vector<1x1x4xf8E5M2>
    %142 = "vector.shape_cast"(%141) : (vector<1x1x4xf8E5M2>) -> vector<4xf8E5M2>
    %143 = "vector.extract"(%5) <{static_position = array<i64: 7, 1, 0>}> : (vector<8x2x4xf32>) -> f32
    %144 = "amdgpu.scaled_ext_packed"(%142, %143) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %145 = "vector.insert_strided_slice"(%144, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %146 = "amdgpu.scaled_ext_packed"(%142, %143) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %147 = "vector.insert_strided_slice"(%146, %145) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %148 = "vector.shape_cast"(%147) : (vector<4xf32>) -> vector<1x1x4xf32>
    %149 = "vector.insert_strided_slice"(%148, %140) <{offsets = [7, 1, 0], strides = [1, 1, 1]}> : (vector<1x1x4xf32>, vector<8x2x4xf32>) -> vector<8x2x4xf32>
    %150 = "vector.shape_cast"(%149) : (vector<8x2x4xf32>) -> vector<8x8xf32>
    "func.return"(%150) : (vector<8x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<6xf8E5M2>, vector<2xf8E8M0FNU>) -> vector<6xf32>, sym_name = "conversion_broadcast_odd"}> ({
  ^bb0(%arg0: vector<6xf8E5M2>, %arg1: vector<2xf8E8M0FNU>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<6xf32>}> : () -> vector<6xf32>
    %2 = "vector.broadcast"(%arg1) : (vector<2xf8E8M0FNU>) -> vector<3x2xf8E8M0FNU>
    %3 = "vector.shape_cast"(%2) : (vector<3x2xf8E8M0FNU>) -> vector<6xf8E8M0FNU>
    %4 = "arith.extf"(%3) : (vector<6xf8E8M0FNU>) -> vector<6xf32>
    %5 = "vector.extract_strided_slice"(%arg0) <{offsets = [0], sizes = [3], strides = [1]}> : (vector<6xf8E5M2>) -> vector<3xf8E5M2>
    %6 = "vector.extract"(%4) <{static_position = array<i64: 0>}> : (vector<6xf32>) -> f32
    %7 = "amdgpu.scaled_ext_packed"(%5, %6) <{index = 0 : i32}> : (vector<3xf8E5M2>, f32) -> vector<2xf32>
    %8 = "vector.insert_strided_slice"(%7, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<3xf32>) -> vector<3xf32>
    %9 = "amdgpu.scaled_ext_packed"(%5, %6) <{index = 1 : i32}> : (vector<3xf8E5M2>, f32) -> vector<2xf32>
    %10 = "vector.extract_strided_slice"(%9) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf32>) -> vector<1xf32>
    %11 = "vector.insert_strided_slice"(%10, %8) <{offsets = [2], strides = [1]}> : (vector<1xf32>, vector<3xf32>) -> vector<3xf32>
    %12 = "vector.insert_strided_slice"(%11, %1) <{offsets = [0], strides = [1]}> : (vector<3xf32>, vector<6xf32>) -> vector<6xf32>
    %13 = "vector.extract_strided_slice"(%arg0) <{offsets = [3], sizes = [3], strides = [1]}> : (vector<6xf8E5M2>) -> vector<3xf8E5M2>
    %14 = "vector.extract"(%4) <{static_position = array<i64: 3>}> : (vector<6xf32>) -> f32
    %15 = "amdgpu.scaled_ext_packed"(%13, %14) <{index = 0 : i32}> : (vector<3xf8E5M2>, f32) -> vector<2xf32>
    %16 = "vector.insert_strided_slice"(%15, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<3xf32>) -> vector<3xf32>
    %17 = "amdgpu.scaled_ext_packed"(%13, %14) <{index = 1 : i32}> : (vector<3xf8E5M2>, f32) -> vector<2xf32>
    %18 = "vector.extract_strided_slice"(%17) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf32>) -> vector<1xf32>
    %19 = "vector.insert_strided_slice"(%18, %16) <{offsets = [2], strides = [1]}> : (vector<1xf32>, vector<3xf32>) -> vector<3xf32>
    %20 = "vector.insert_strided_slice"(%19, %12) <{offsets = [3], strides = [1]}> : (vector<3xf32>, vector<6xf32>) -> vector<6xf32>
    "func.return"(%20) : (vector<6xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf8E5M2>, f8E8M0FNU) -> vector<4xf32>, sym_name = "conversion_broadcast"}> ({
  ^bb0(%arg0: vector<4xf8E5M2>, %arg1: f8E8M0FNU):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "vector.broadcast"(%arg1) : (f8E8M0FNU) -> vector<4xf8E8M0FNU>
    %2 = "arith.extf"(%1) : (vector<4xf8E8M0FNU>) -> vector<4xf32>
    %3 = "vector.extract"(%2) <{static_position = array<i64: 0>}> : (vector<4xf32>) -> f32
    %4 = "amdgpu.scaled_ext_packed"(%arg0, %3) <{index = 0 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %5 = "vector.insert_strided_slice"(%4, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    %6 = "amdgpu.scaled_ext_packed"(%arg0, %3) <{index = 1 : i32}> : (vector<4xf8E5M2>, f32) -> vector<2xf32>
    %7 = "vector.insert_strided_slice"(%6, %5) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%7) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f8E5M2, f8E8M0FNU) -> f32, sym_name = "conversion_scalar"}> ({
  ^bb0(%arg0: f8E5M2, %arg1: f8E8M0FNU):
    %0 = "arith.extf"(%arg1) : (f8E8M0FNU) -> f32
    %1 = "vector.broadcast"(%arg0) : (f8E5M2) -> vector<1xf8E5M2>
    %2 = "amdgpu.scaled_ext_packed"(%1, %0) <{index = 0 : i32}> : (vector<1xf8E5M2>, f32) -> vector<2xf32>
    %3 = "vector.extract"(%2) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xf4E2M1FN>, f32) -> vector<32xf32>, sym_name = "long_fp4_broadcast"}> ({
  ^bb0(%arg0: vector<32xf4E2M1FN>, %arg1: f32):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<32xf32>}> : () -> vector<32xf32>
    %1 = "vector.extract_strided_slice"(%arg0) <{offsets = [0], sizes = [8], strides = [1]}> : (vector<32xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %2 = "amdgpu.scaled_ext_packed"(%1, %arg1) <{index = 0 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %3 = "vector.insert_strided_slice"(%2, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %4 = "amdgpu.scaled_ext_packed"(%1, %arg1) <{index = 1 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %5 = "vector.insert_strided_slice"(%4, %3) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %6 = "amdgpu.scaled_ext_packed"(%1, %arg1) <{index = 2 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %7 = "vector.insert_strided_slice"(%6, %5) <{offsets = [4], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %8 = "amdgpu.scaled_ext_packed"(%1, %arg1) <{index = 3 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %9 = "vector.insert_strided_slice"(%8, %7) <{offsets = [6], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %10 = "vector.extract_strided_slice"(%arg0) <{offsets = [8], sizes = [8], strides = [1]}> : (vector<32xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %11 = "amdgpu.scaled_ext_packed"(%10, %arg1) <{index = 0 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %12 = "vector.insert_strided_slice"(%11, %9) <{offsets = [8], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %13 = "amdgpu.scaled_ext_packed"(%10, %arg1) <{index = 1 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %14 = "vector.insert_strided_slice"(%13, %12) <{offsets = [10], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %15 = "amdgpu.scaled_ext_packed"(%10, %arg1) <{index = 2 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %16 = "vector.insert_strided_slice"(%15, %14) <{offsets = [12], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %17 = "amdgpu.scaled_ext_packed"(%10, %arg1) <{index = 3 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %18 = "vector.insert_strided_slice"(%17, %16) <{offsets = [14], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %19 = "vector.extract_strided_slice"(%arg0) <{offsets = [16], sizes = [8], strides = [1]}> : (vector<32xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %20 = "amdgpu.scaled_ext_packed"(%19, %arg1) <{index = 0 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %21 = "vector.insert_strided_slice"(%20, %18) <{offsets = [16], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %22 = "amdgpu.scaled_ext_packed"(%19, %arg1) <{index = 1 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %23 = "vector.insert_strided_slice"(%22, %21) <{offsets = [18], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %24 = "amdgpu.scaled_ext_packed"(%19, %arg1) <{index = 2 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %25 = "vector.insert_strided_slice"(%24, %23) <{offsets = [20], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %26 = "amdgpu.scaled_ext_packed"(%19, %arg1) <{index = 3 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %27 = "vector.insert_strided_slice"(%26, %25) <{offsets = [22], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %28 = "vector.extract_strided_slice"(%arg0) <{offsets = [24], sizes = [8], strides = [1]}> : (vector<32xf4E2M1FN>) -> vector<8xf4E2M1FN>
    %29 = "amdgpu.scaled_ext_packed"(%28, %arg1) <{index = 0 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %30 = "vector.insert_strided_slice"(%29, %27) <{offsets = [24], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %31 = "amdgpu.scaled_ext_packed"(%28, %arg1) <{index = 1 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %32 = "vector.insert_strided_slice"(%31, %30) <{offsets = [26], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %33 = "amdgpu.scaled_ext_packed"(%28, %arg1) <{index = 2 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %34 = "vector.insert_strided_slice"(%33, %32) <{offsets = [28], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %35 = "amdgpu.scaled_ext_packed"(%28, %arg1) <{index = 3 : i32}> : (vector<8xf4E2M1FN>, f32) -> vector<2xf32>
    %36 = "vector.insert_strided_slice"(%35, %34) <{offsets = [30], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    "func.return"(%36) : (vector<32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xf8E4M3FN>, f32) -> vector<32xf32>, sym_name = "long_fp8_broadcast"}> ({
  ^bb0(%arg0: vector<32xf8E4M3FN>, %arg1: f32):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<32xf32>}> : () -> vector<32xf32>
    %1 = "vector.extract_strided_slice"(%arg0) <{offsets = [0], sizes = [4], strides = [1]}> : (vector<32xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %2 = "amdgpu.scaled_ext_packed"(%1, %arg1) <{index = 0 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %3 = "vector.insert_strided_slice"(%2, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %4 = "amdgpu.scaled_ext_packed"(%1, %arg1) <{index = 1 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %5 = "vector.insert_strided_slice"(%4, %3) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %6 = "vector.extract_strided_slice"(%arg0) <{offsets = [4], sizes = [4], strides = [1]}> : (vector<32xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %7 = "amdgpu.scaled_ext_packed"(%6, %arg1) <{index = 0 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %8 = "vector.insert_strided_slice"(%7, %5) <{offsets = [4], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %9 = "amdgpu.scaled_ext_packed"(%6, %arg1) <{index = 1 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %10 = "vector.insert_strided_slice"(%9, %8) <{offsets = [6], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %11 = "vector.extract_strided_slice"(%arg0) <{offsets = [8], sizes = [4], strides = [1]}> : (vector<32xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %12 = "amdgpu.scaled_ext_packed"(%11, %arg1) <{index = 0 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %13 = "vector.insert_strided_slice"(%12, %10) <{offsets = [8], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %14 = "amdgpu.scaled_ext_packed"(%11, %arg1) <{index = 1 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %15 = "vector.insert_strided_slice"(%14, %13) <{offsets = [10], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %16 = "vector.extract_strided_slice"(%arg0) <{offsets = [12], sizes = [4], strides = [1]}> : (vector<32xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %17 = "amdgpu.scaled_ext_packed"(%16, %arg1) <{index = 0 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %18 = "vector.insert_strided_slice"(%17, %15) <{offsets = [12], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %19 = "amdgpu.scaled_ext_packed"(%16, %arg1) <{index = 1 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %20 = "vector.insert_strided_slice"(%19, %18) <{offsets = [14], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %21 = "vector.extract_strided_slice"(%arg0) <{offsets = [16], sizes = [4], strides = [1]}> : (vector<32xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %22 = "amdgpu.scaled_ext_packed"(%21, %arg1) <{index = 0 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %23 = "vector.insert_strided_slice"(%22, %20) <{offsets = [16], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %24 = "amdgpu.scaled_ext_packed"(%21, %arg1) <{index = 1 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %25 = "vector.insert_strided_slice"(%24, %23) <{offsets = [18], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %26 = "vector.extract_strided_slice"(%arg0) <{offsets = [20], sizes = [4], strides = [1]}> : (vector<32xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %27 = "amdgpu.scaled_ext_packed"(%26, %arg1) <{index = 0 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %28 = "vector.insert_strided_slice"(%27, %25) <{offsets = [20], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %29 = "amdgpu.scaled_ext_packed"(%26, %arg1) <{index = 1 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %30 = "vector.insert_strided_slice"(%29, %28) <{offsets = [22], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %31 = "vector.extract_strided_slice"(%arg0) <{offsets = [24], sizes = [4], strides = [1]}> : (vector<32xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %32 = "amdgpu.scaled_ext_packed"(%31, %arg1) <{index = 0 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %33 = "vector.insert_strided_slice"(%32, %30) <{offsets = [24], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %34 = "amdgpu.scaled_ext_packed"(%31, %arg1) <{index = 1 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %35 = "vector.insert_strided_slice"(%34, %33) <{offsets = [26], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %36 = "vector.extract_strided_slice"(%arg0) <{offsets = [28], sizes = [4], strides = [1]}> : (vector<32xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %37 = "amdgpu.scaled_ext_packed"(%36, %arg1) <{index = 0 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %38 = "vector.insert_strided_slice"(%37, %35) <{offsets = [28], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    %39 = "amdgpu.scaled_ext_packed"(%36, %arg1) <{index = 1 : i32}> : (vector<4xf8E4M3FN>, f32) -> vector<2xf32>
    %40 = "vector.insert_strided_slice"(%39, %38) <{offsets = [30], strides = [1]}> : (vector<2xf32>, vector<32xf32>) -> vector<32xf32>
    "func.return"(%40) : (vector<32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

