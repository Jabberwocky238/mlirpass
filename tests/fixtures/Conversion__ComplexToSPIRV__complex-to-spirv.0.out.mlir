module {
  func.func @create_complex(%arg0: f32, %arg1: f32) -> complex<f32> {
    %0 = spirv.CompositeConstruct %arg0, %arg1 : (f32, f32) -> vector<2xf32>
    %1 = builtin.unrealized_conversion_cast %0 : vector<2xf32> to complex<f32>
    return %1 : complex<f32>
  }
}

// -----
module {
  func.func @real_number(%arg0: complex<f32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to vector<2xf32>
    %1 = spirv.CompositeExtract %0[0 : i32] : vector<2xf32>
    return %1 : f32
  }
}

// -----
module {
  func.func @imaginary_number(%arg0: complex<f32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to vector<2xf32>
    %1 = spirv.CompositeExtract %0[1 : i32] : vector<2xf32>
    return %1 : f32
  }
}

// -----
module {
  func.func @complex_const() -> complex<f32> {
    %cst_vec_2xf32 = spirv.Constant dense<[0x7FC00000, 0.000000e+00]> : vector<2xf32>
    %0 = builtin.unrealized_conversion_cast %cst_vec_2xf32 : vector<2xf32> to complex<f32>
    return %0 : complex<f32>
  }
}

