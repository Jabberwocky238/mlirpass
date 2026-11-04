"builtin.module"() ({
  "func.func"() <{function_type = (f8E5M2) -> f16, sym_name = "scalar_ext"}> ({
  ^bb0(%arg0: f8E5M2):
    %0 = "amdgpu.ext_packed_fp8"(%arg0) <{index = 0 : i32}> : (f8E5M2) -> f32
    %1 = "arith.truncf"(%0) : (f32) -> f16
    "func.return"(%1) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf8E5M2>) -> vector<2xf64>, sym_name = "vector_ext_short"}> ({
  ^bb0(%arg0: vector<2xf8E5M2>):
    %0 = "amdgpu.ext_packed_fp8"(%arg0) <{index = 0 : i32}> : (vector<2xf8E5M2>) -> vector<2xf32>
    %1 = "arith.extf"(%0) : (vector<2xf32>) -> vector<2xf64>
    "func.return"(%1) : (vector<2xf64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<9xf8E4M3FN>) -> vector<9xf32>, sym_name = "vector_ext_long"}> ({
  ^bb0(%arg0: vector<9xf8E4M3FN>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<9xf32>}> : () -> vector<9xf32>
    %1 = "vector.extract_strided_slice"(%arg0) <{offsets = [0], sizes = [4], strides = [1]}> : (vector<9xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %2 = "amdgpu.ext_packed_fp8"(%1) <{index = 0 : i32}> : (vector<4xf8E4M3FN>) -> vector<2xf32>
    %3 = "vector.insert_strided_slice"(%2, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<9xf32>) -> vector<9xf32>
    %4 = "amdgpu.ext_packed_fp8"(%1) <{index = 1 : i32}> : (vector<4xf8E4M3FN>) -> vector<2xf32>
    %5 = "vector.insert_strided_slice"(%4, %3) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<9xf32>) -> vector<9xf32>
    %6 = "vector.extract_strided_slice"(%arg0) <{offsets = [4], sizes = [4], strides = [1]}> : (vector<9xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %7 = "amdgpu.ext_packed_fp8"(%6) <{index = 0 : i32}> : (vector<4xf8E4M3FN>) -> vector<2xf32>
    %8 = "vector.insert_strided_slice"(%7, %5) <{offsets = [4], strides = [1]}> : (vector<2xf32>, vector<9xf32>) -> vector<9xf32>
    %9 = "amdgpu.ext_packed_fp8"(%6) <{index = 1 : i32}> : (vector<4xf8E4M3FN>) -> vector<2xf32>
    %10 = "vector.insert_strided_slice"(%9, %8) <{offsets = [6], strides = [1]}> : (vector<2xf32>, vector<9xf32>) -> vector<9xf32>
    %11 = "vector.extract_strided_slice"(%arg0) <{offsets = [8], sizes = [1], strides = [1]}> : (vector<9xf8E4M3FN>) -> vector<1xf8E4M3FN>
    %12 = "amdgpu.ext_packed_fp8"(%11) <{index = 0 : i32}> : (vector<1xf8E4M3FN>) -> f32
    %13 = "vector.insert"(%12, %10) <{static_position = array<i64: 8>}> : (f32, vector<9xf32>) -> vector<9xf32>
    "func.return"(%13) : (vector<9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> f8E5M2, sym_name = "scalar_trunc"}> ({
  ^bb0(%arg0: f16):
    %0 = "arith.extf"(%arg0) : (f16) -> f32
    %1 = "amdgpu.packed_trunc_2xfp8"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>, wordIndex = 0 : i32}> : (f32) -> vector<4xf8E5M2>
    %2 = "vector.extract"(%1) <{static_position = array<i64: 0>}> : (vector<4xf8E5M2>) -> f8E5M2
    "func.return"(%2) : (f8E5M2) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf64>) -> vector<2xf8E5M2>, sym_name = "vector_trunc_short"}> ({
  ^bb0(%arg0: vector<2xf64>):
    %0 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<2xf64>) -> f64
    %1 = "arith.truncf"(%0) : (f64) -> f32
    %2 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<2xf64>) -> f64
    %3 = "arith.truncf"(%2) : (f64) -> f32
    %4 = "amdgpu.packed_trunc_2xfp8"(%1, %3) <{operandSegmentSizes = array<i32: 1, 1, 0>, wordIndex = 0 : i32}> : (f32, f32) -> vector<4xf8E5M2>
    %5 = "vector.extract_strided_slice"(%4) <{offsets = [0], sizes = [2], strides = [1]}> : (vector<4xf8E5M2>) -> vector<2xf8E5M2>
    "func.return"(%5) : (vector<2xf8E5M2>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<9xf32>) -> vector<9xf8E4M3FN>, sym_name = "vector_trunc_long"}> ({
  ^bb0(%arg0: vector<9xf32>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<9xf8E4M3FN>}> : () -> vector<9xf8E4M3FN>
    %1 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<9xf32>) -> f32
    %2 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<9xf32>) -> f32
    %3 = "amdgpu.packed_trunc_2xfp8"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1, 0>, wordIndex = 0 : i32}> : (f32, f32) -> vector<4xf8E4M3FN>
    %4 = "vector.extract"(%arg0) <{static_position = array<i64: 2>}> : (vector<9xf32>) -> f32
    %5 = "vector.extract"(%arg0) <{static_position = array<i64: 3>}> : (vector<9xf32>) -> f32
    %6 = "amdgpu.packed_trunc_2xfp8"(%4, %5, %3) <{operandSegmentSizes = array<i32: 1, 1, 1>, wordIndex = 1 : i32}> : (f32, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %7 = "vector.insert_strided_slice"(%6, %0) <{offsets = [0], strides = [1]}> : (vector<4xf8E4M3FN>, vector<9xf8E4M3FN>) -> vector<9xf8E4M3FN>
    %8 = "vector.extract"(%arg0) <{static_position = array<i64: 4>}> : (vector<9xf32>) -> f32
    %9 = "vector.extract"(%arg0) <{static_position = array<i64: 5>}> : (vector<9xf32>) -> f32
    %10 = "amdgpu.packed_trunc_2xfp8"(%8, %9) <{operandSegmentSizes = array<i32: 1, 1, 0>, wordIndex = 0 : i32}> : (f32, f32) -> vector<4xf8E4M3FN>
    %11 = "vector.extract"(%arg0) <{static_position = array<i64: 6>}> : (vector<9xf32>) -> f32
    %12 = "vector.extract"(%arg0) <{static_position = array<i64: 7>}> : (vector<9xf32>) -> f32
    %13 = "amdgpu.packed_trunc_2xfp8"(%11, %12, %10) <{operandSegmentSizes = array<i32: 1, 1, 1>, wordIndex = 1 : i32}> : (f32, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %14 = "vector.insert_strided_slice"(%13, %7) <{offsets = [4], strides = [1]}> : (vector<4xf8E4M3FN>, vector<9xf8E4M3FN>) -> vector<9xf8E4M3FN>
    %15 = "vector.extract"(%arg0) <{static_position = array<i64: 8>}> : (vector<9xf32>) -> f32
    %16 = "amdgpu.packed_trunc_2xfp8"(%15) <{operandSegmentSizes = array<i32: 1, 0, 0>, wordIndex = 0 : i32}> : (f32) -> vector<4xf8E4M3FN>
    %17 = "vector.extract_strided_slice"(%16) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<4xf8E4M3FN>) -> vector<1xf8E4M3FN>
    %18 = "vector.insert_strided_slice"(%17, %14) <{offsets = [8], strides = [1]}> : (vector<1xf8E4M3FN>, vector<9xf8E4M3FN>) -> vector<9xf8E4M3FN>
    "func.return"(%18) : (vector<9xf8E4M3FN>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x9xf32>) -> vector<1x9xf8E4M3FN>, sym_name = "vector_trunc_long_2d"}> ({
  ^bb0(%arg0: vector<1x9xf32>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<9xf8E4M3FN>}> : () -> vector<9xf8E4M3FN>
    %1 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 0>}> : (vector<1x9xf32>) -> f32
    %2 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 1>}> : (vector<1x9xf32>) -> f32
    %3 = "amdgpu.packed_trunc_2xfp8"(%1, %2) <{operandSegmentSizes = array<i32: 1, 1, 0>, wordIndex = 0 : i32}> : (f32, f32) -> vector<4xf8E4M3FN>
    %4 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 2>}> : (vector<1x9xf32>) -> f32
    %5 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 3>}> : (vector<1x9xf32>) -> f32
    %6 = "amdgpu.packed_trunc_2xfp8"(%4, %5, %3) <{operandSegmentSizes = array<i32: 1, 1, 1>, wordIndex = 1 : i32}> : (f32, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %7 = "vector.insert_strided_slice"(%6, %0) <{offsets = [0], strides = [1]}> : (vector<4xf8E4M3FN>, vector<9xf8E4M3FN>) -> vector<9xf8E4M3FN>
    %8 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 4>}> : (vector<1x9xf32>) -> f32
    %9 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 5>}> : (vector<1x9xf32>) -> f32
    %10 = "amdgpu.packed_trunc_2xfp8"(%8, %9) <{operandSegmentSizes = array<i32: 1, 1, 0>, wordIndex = 0 : i32}> : (f32, f32) -> vector<4xf8E4M3FN>
    %11 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 6>}> : (vector<1x9xf32>) -> f32
    %12 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 7>}> : (vector<1x9xf32>) -> f32
    %13 = "amdgpu.packed_trunc_2xfp8"(%11, %12, %10) <{operandSegmentSizes = array<i32: 1, 1, 1>, wordIndex = 1 : i32}> : (f32, f32, vector<4xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %14 = "vector.insert_strided_slice"(%13, %7) <{offsets = [4], strides = [1]}> : (vector<4xf8E4M3FN>, vector<9xf8E4M3FN>) -> vector<9xf8E4M3FN>
    %15 = "vector.extract"(%arg0) <{static_position = array<i64: 0, 8>}> : (vector<1x9xf32>) -> f32
    %16 = "amdgpu.packed_trunc_2xfp8"(%15) <{operandSegmentSizes = array<i32: 1, 0, 0>, wordIndex = 0 : i32}> : (f32) -> vector<4xf8E4M3FN>
    %17 = "vector.extract_strided_slice"(%16) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<4xf8E4M3FN>) -> vector<1xf8E4M3FN>
    %18 = "vector.insert_strided_slice"(%17, %14) <{offsets = [8], strides = [1]}> : (vector<1xf8E4M3FN>, vector<9xf8E4M3FN>) -> vector<9xf8E4M3FN>
    %19 = "vector.shape_cast"(%18) : (vector<9xf8E4M3FN>) -> vector<1x9xf8E4M3FN>
    "func.return"(%19) : (vector<1x9xf8E4M3FN>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x11xf8E4M3FN>) -> vector<1x11xf32>, sym_name = "vector_ext_long_2d"}> ({
  ^bb0(%arg0: vector<1x11xf8E4M3FN>):
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<11xf32>}> : () -> vector<11xf32>
    %1 = "vector.shape_cast"(%arg0) : (vector<1x11xf8E4M3FN>) -> vector<11xf8E4M3FN>
    %2 = "vector.extract_strided_slice"(%1) <{offsets = [0], sizes = [4], strides = [1]}> : (vector<11xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %3 = "amdgpu.ext_packed_fp8"(%2) <{index = 0 : i32}> : (vector<4xf8E4M3FN>) -> vector<2xf32>
    %4 = "vector.insert_strided_slice"(%3, %0) <{offsets = [0], strides = [1]}> : (vector<2xf32>, vector<11xf32>) -> vector<11xf32>
    %5 = "amdgpu.ext_packed_fp8"(%2) <{index = 1 : i32}> : (vector<4xf8E4M3FN>) -> vector<2xf32>
    %6 = "vector.insert_strided_slice"(%5, %4) <{offsets = [2], strides = [1]}> : (vector<2xf32>, vector<11xf32>) -> vector<11xf32>
    %7 = "vector.extract_strided_slice"(%1) <{offsets = [4], sizes = [4], strides = [1]}> : (vector<11xf8E4M3FN>) -> vector<4xf8E4M3FN>
    %8 = "amdgpu.ext_packed_fp8"(%7) <{index = 0 : i32}> : (vector<4xf8E4M3FN>) -> vector<2xf32>
    %9 = "vector.insert_strided_slice"(%8, %6) <{offsets = [4], strides = [1]}> : (vector<2xf32>, vector<11xf32>) -> vector<11xf32>
    %10 = "amdgpu.ext_packed_fp8"(%7) <{index = 1 : i32}> : (vector<4xf8E4M3FN>) -> vector<2xf32>
    %11 = "vector.insert_strided_slice"(%10, %9) <{offsets = [6], strides = [1]}> : (vector<2xf32>, vector<11xf32>) -> vector<11xf32>
    %12 = "vector.extract_strided_slice"(%1) <{offsets = [8], sizes = [3], strides = [1]}> : (vector<11xf8E4M3FN>) -> vector<3xf8E4M3FN>
    %13 = "amdgpu.ext_packed_fp8"(%12) <{index = 0 : i32}> : (vector<3xf8E4M3FN>) -> vector<2xf32>
    %14 = "vector.insert_strided_slice"(%13, %11) <{offsets = [8], strides = [1]}> : (vector<2xf32>, vector<11xf32>) -> vector<11xf32>
    %15 = "amdgpu.ext_packed_fp8"(%12) <{index = 2 : i32}> : (vector<3xf8E4M3FN>) -> f32
    %16 = "vector.insert"(%15, %14) <{static_position = array<i64: 10>}> : (f32, vector<11xf32>) -> vector<11xf32>
    %17 = "vector.shape_cast"(%16) : (vector<11xf32>) -> vector<1x11xf32>
    "func.return"(%17) : (vector<1x11xf32>) -> ()
  }) : () -> ()
}) : () -> ()

