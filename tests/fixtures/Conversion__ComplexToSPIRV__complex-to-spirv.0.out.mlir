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

// -----
module {
  func.func @complex_add(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : complex<f32> to vector<2xf32>
    %1 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to vector<2xf32>
    %2 = spirv.CompositeExtract %1[0 : i32] : vector<2xf32>
    %3 = spirv.CompositeExtract %1[1 : i32] : vector<2xf32>
    %4 = spirv.CompositeExtract %0[0 : i32] : vector<2xf32>
    %5 = spirv.CompositeExtract %0[1 : i32] : vector<2xf32>
    %6 = spirv.FAdd %2, %4 : f32
    %7 = spirv.FAdd %3, %5 : f32
    %8 = spirv.CompositeConstruct %6, %7 : (f32, f32) -> vector<2xf32>
    %9 = builtin.unrealized_conversion_cast %8 : vector<2xf32> to complex<f32>
    return %9 : complex<f32>
  }
}

// -----
module {
  func.func @complex_sub(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : complex<f32> to vector<2xf32>
    %1 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to vector<2xf32>
    %2 = spirv.CompositeExtract %1[0 : i32] : vector<2xf32>
    %3 = spirv.CompositeExtract %1[1 : i32] : vector<2xf32>
    %4 = spirv.CompositeExtract %0[0 : i32] : vector<2xf32>
    %5 = spirv.CompositeExtract %0[1 : i32] : vector<2xf32>
    %6 = spirv.FSub %2, %4 : f32
    %7 = spirv.FSub %3, %5 : f32
    %8 = spirv.CompositeConstruct %6, %7 : (f32, f32) -> vector<2xf32>
    %9 = builtin.unrealized_conversion_cast %8 : vector<2xf32> to complex<f32>
    return %9 : complex<f32>
  }
}

// -----
module {
  func.func @complex_mul(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : complex<f32> to vector<2xf32>
    %1 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to vector<2xf32>
    %2 = spirv.CompositeExtract %1[0 : i32] : vector<2xf32>
    %3 = spirv.CompositeExtract %1[1 : i32] : vector<2xf32>
    %4 = spirv.CompositeExtract %0[0 : i32] : vector<2xf32>
    %5 = spirv.CompositeExtract %0[1 : i32] : vector<2xf32>
    %6 = spirv.FMul %2, %4 : f32
    %7 = spirv.FMul %3, %5 : f32
    %8 = spirv.FMul %2, %5 : f32
    %9 = spirv.FMul %3, %4 : f32
    %10 = spirv.FSub %6, %7 : f32
    %11 = spirv.FAdd %8, %9 : f32
    %12 = spirv.CompositeConstruct %10, %11 : (f32, f32) -> vector<2xf32>
    %13 = builtin.unrealized_conversion_cast %12 : vector<2xf32> to complex<f32>
    return %13 : complex<f32>
  }
}

// -----
module {
  func.func @complex_div(%arg0: complex<f32>, %arg1: complex<f32>) -> complex<f32> {
    %0 = builtin.unrealized_conversion_cast %arg1 : complex<f32> to vector<2xf32>
    %1 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to vector<2xf32>
    %2 = spirv.CompositeExtract %1[0 : i32] : vector<2xf32>
    %3 = spirv.CompositeExtract %1[1 : i32] : vector<2xf32>
    %4 = spirv.CompositeExtract %0[0 : i32] : vector<2xf32>
    %5 = spirv.CompositeExtract %0[1 : i32] : vector<2xf32>
    %6 = spirv.FMul %2, %4 : f32
    %7 = spirv.FMul %3, %5 : f32
    %8 = spirv.FMul %3, %4 : f32
    %9 = spirv.FMul %2, %5 : f32
    %10 = spirv.FMul %4, %4 : f32
    %11 = spirv.FMul %5, %5 : f32
    %12 = spirv.FAdd %10, %11 : f32
    %13 = spirv.FAdd %6, %7 : f32
    %14 = spirv.FSub %8, %9 : f32
    %15 = spirv.FDiv %13, %12 : f32
    %16 = spirv.FDiv %14, %12 : f32
    %17 = spirv.CompositeConstruct %15, %16 : (f32, f32) -> vector<2xf32>
    %18 = builtin.unrealized_conversion_cast %17 : vector<2xf32> to complex<f32>
    return %18 : complex<f32>
  }
}

// -----
module {
  func.func @complex_eq(%arg0: complex<f32>, %arg1: complex<f32>) -> i1 {
    %0 = builtin.unrealized_conversion_cast %arg1 : complex<f32> to vector<2xf32>
    %1 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to vector<2xf32>
    %2 = spirv.CompositeExtract %1[0 : i32] : vector<2xf32>
    %3 = spirv.CompositeExtract %1[1 : i32] : vector<2xf32>
    %4 = spirv.CompositeExtract %0[0 : i32] : vector<2xf32>
    %5 = spirv.CompositeExtract %0[1 : i32] : vector<2xf32>
    %6 = spirv.FOrdEqual %2, %4 : f32
    %7 = spirv.FOrdEqual %3, %5 : f32
    %8 = spirv.LogicalAnd %6, %7 : i1
    return %8 : i1
  }
}

// -----
module {
  func.func @complex_neq(%arg0: complex<f32>, %arg1: complex<f32>) -> i1 {
    %0 = builtin.unrealized_conversion_cast %arg1 : complex<f32> to vector<2xf32>
    %1 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to vector<2xf32>
    %2 = spirv.CompositeExtract %1[0 : i32] : vector<2xf32>
    %3 = spirv.CompositeExtract %1[1 : i32] : vector<2xf32>
    %4 = spirv.CompositeExtract %0[0 : i32] : vector<2xf32>
    %5 = spirv.CompositeExtract %0[1 : i32] : vector<2xf32>
    %6 = spirv.FUnordNotEqual %2, %4 : f32
    %7 = spirv.FUnordNotEqual %3, %5 : f32
    %8 = spirv.LogicalOr %6, %7 : i1
    return %8 : i1
  }
}

// -----
module {
  func.func @complex_neg(%arg0: complex<f32>) -> complex<f32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to vector<2xf32>
    %1 = spirv.CompositeExtract %0[0 : i32] : vector<2xf32>
    %2 = spirv.CompositeExtract %0[1 : i32] : vector<2xf32>
    %3 = spirv.FNegate %1 : f32
    %4 = spirv.FNegate %2 : f32
    %5 = spirv.CompositeConstruct %3, %4 : (f32, f32) -> vector<2xf32>
    %6 = builtin.unrealized_conversion_cast %5 : vector<2xf32> to complex<f32>
    return %6 : complex<f32>
  }
}

// -----
module {
  func.func @complex_conj(%arg0: complex<f32>) -> complex<f32> {
    %0 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to vector<2xf32>
    %1 = spirv.CompositeExtract %0[0 : i32] : vector<2xf32>
    %2 = spirv.CompositeExtract %0[1 : i32] : vector<2xf32>
    %3 = spirv.FNegate %2 : f32
    %4 = spirv.CompositeConstruct %1, %3 : (f32, f32) -> vector<2xf32>
    %5 = builtin.unrealized_conversion_cast %4 : vector<2xf32> to complex<f32>
    return %5 : complex<f32>
  }
}

// -----
module {
  func.func @complex_abs(%arg0: complex<f32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to vector<2xf32>
    %1 = spirv.CompositeExtract %0[0 : i32] : vector<2xf32>
    %2 = spirv.CompositeExtract %0[1 : i32] : vector<2xf32>
    %3 = spirv.FMul %1, %1 : f32
    %4 = spirv.FMul %2, %2 : f32
    %5 = spirv.FAdd %3, %4 : f32
    %6 = spirv.GL.Sqrt %5 : f32
    return %6 : f32
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} {
  func.func @complex_abs_opencl(%arg0: complex<f32>) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : complex<f32> to vector<2xf32>
    %1 = spirv.CompositeExtract %0[0 : i32] : vector<2xf32>
    %2 = spirv.CompositeExtract %0[1 : i32] : vector<2xf32>
    %3 = spirv.FMul %1, %1 : f32
    %4 = spirv.FMul %2, %2 : f32
    %5 = spirv.FAdd %3, %4 : f32
    %6 = spirv.CL.sqrt %5 : f32
    return %6 : f32
  }
}

