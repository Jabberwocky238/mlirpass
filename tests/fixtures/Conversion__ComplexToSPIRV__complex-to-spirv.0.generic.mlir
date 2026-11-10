"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "create_complex"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "spirv.CompositeConstruct"(%arg0, %arg1) : (f32, f32) -> vector<2xf32>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (vector<2xf32>) -> complex<f32>
    "func.return"(%1) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "real_number"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> vector<2xf32>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "imaginary_number"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> vector<2xf32>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_const"}> ({
    %0 = "spirv.Constant"() <{value = dense<[0x7FC00000, 0.000000e+00]> : vector<2xf32>}> : () -> vector<2xf32>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (vector<2xf32>) -> complex<f32>
    "func.return"(%1) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_add"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (complex<f32>) -> vector<2xf32>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> vector<2xf32>
    %2 = "spirv.CompositeExtract"(%1) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %3 = "spirv.CompositeExtract"(%1) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %4 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %5 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %6 = "spirv.FAdd"(%2, %4) : (f32, f32) -> f32
    %7 = "spirv.FAdd"(%3, %5) : (f32, f32) -> f32
    %8 = "spirv.CompositeConstruct"(%6, %7) : (f32, f32) -> vector<2xf32>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (vector<2xf32>) -> complex<f32>
    "func.return"(%9) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_sub"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (complex<f32>) -> vector<2xf32>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> vector<2xf32>
    %2 = "spirv.CompositeExtract"(%1) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %3 = "spirv.CompositeExtract"(%1) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %4 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %5 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %6 = "spirv.FSub"(%2, %4) : (f32, f32) -> f32
    %7 = "spirv.FSub"(%3, %5) : (f32, f32) -> f32
    %8 = "spirv.CompositeConstruct"(%6, %7) : (f32, f32) -> vector<2xf32>
    %9 = "builtin.unrealized_conversion_cast"(%8) : (vector<2xf32>) -> complex<f32>
    "func.return"(%9) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_mul"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (complex<f32>) -> vector<2xf32>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> vector<2xf32>
    %2 = "spirv.CompositeExtract"(%1) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %3 = "spirv.CompositeExtract"(%1) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %4 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %5 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %6 = "spirv.FMul"(%2, %4) : (f32, f32) -> f32
    %7 = "spirv.FMul"(%3, %5) : (f32, f32) -> f32
    %8 = "spirv.FMul"(%2, %5) : (f32, f32) -> f32
    %9 = "spirv.FMul"(%3, %4) : (f32, f32) -> f32
    %10 = "spirv.FSub"(%6, %7) : (f32, f32) -> f32
    %11 = "spirv.FAdd"(%8, %9) : (f32, f32) -> f32
    %12 = "spirv.CompositeConstruct"(%10, %11) : (f32, f32) -> vector<2xf32>
    %13 = "builtin.unrealized_conversion_cast"(%12) : (vector<2xf32>) -> complex<f32>
    "func.return"(%13) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (complex<f32>) -> vector<2xf32>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> vector<2xf32>
    %2 = "spirv.CompositeExtract"(%1) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %3 = "spirv.CompositeExtract"(%1) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %4 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %5 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %6 = "spirv.FMul"(%2, %4) : (f32, f32) -> f32
    %7 = "spirv.FMul"(%3, %5) : (f32, f32) -> f32
    %8 = "spirv.FMul"(%3, %4) : (f32, f32) -> f32
    %9 = "spirv.FMul"(%2, %5) : (f32, f32) -> f32
    %10 = "spirv.FMul"(%4, %4) : (f32, f32) -> f32
    %11 = "spirv.FMul"(%5, %5) : (f32, f32) -> f32
    %12 = "spirv.FAdd"(%10, %11) : (f32, f32) -> f32
    %13 = "spirv.FAdd"(%6, %7) : (f32, f32) -> f32
    %14 = "spirv.FSub"(%8, %9) : (f32, f32) -> f32
    %15 = "spirv.FDiv"(%13, %12) : (f32, f32) -> f32
    %16 = "spirv.FDiv"(%14, %12) : (f32, f32) -> f32
    %17 = "spirv.CompositeConstruct"(%15, %16) : (f32, f32) -> vector<2xf32>
    %18 = "builtin.unrealized_conversion_cast"(%17) : (vector<2xf32>) -> complex<f32>
    "func.return"(%18) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> i1, sym_name = "complex_eq"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (complex<f32>) -> vector<2xf32>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> vector<2xf32>
    %2 = "spirv.CompositeExtract"(%1) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %3 = "spirv.CompositeExtract"(%1) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %4 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %5 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %6 = "spirv.FOrdEqual"(%2, %4) : (f32, f32) -> i1
    %7 = "spirv.FOrdEqual"(%3, %5) : (f32, f32) -> i1
    %8 = "spirv.LogicalAnd"(%6, %7) : (i1, i1) -> i1
    "func.return"(%8) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> i1, sym_name = "complex_neq"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (complex<f32>) -> vector<2xf32>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> vector<2xf32>
    %2 = "spirv.CompositeExtract"(%1) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %3 = "spirv.CompositeExtract"(%1) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %4 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %5 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %6 = "spirv.FUnordNotEqual"(%2, %4) : (f32, f32) -> i1
    %7 = "spirv.FUnordNotEqual"(%3, %5) : (f32, f32) -> i1
    %8 = "spirv.LogicalOr"(%6, %7) : (i1, i1) -> i1
    "func.return"(%8) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_neg"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> vector<2xf32>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %2 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %3 = "spirv.FNegate"(%1) : (f32) -> f32
    %4 = "spirv.FNegate"(%2) : (f32) -> f32
    %5 = "spirv.CompositeConstruct"(%3, %4) : (f32, f32) -> vector<2xf32>
    %6 = "builtin.unrealized_conversion_cast"(%5) : (vector<2xf32>) -> complex<f32>
    "func.return"(%6) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_conj"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> vector<2xf32>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %2 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %3 = "spirv.FNegate"(%2) : (f32) -> f32
    %4 = "spirv.CompositeConstruct"(%1, %3) : (f32, f32) -> vector<2xf32>
    %5 = "builtin.unrealized_conversion_cast"(%4) : (vector<2xf32>) -> complex<f32>
    "func.return"(%5) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_abs"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> vector<2xf32>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %2 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %3 = "spirv.FMul"(%1, %1) : (f32, f32) -> f32
    %4 = "spirv.FMul"(%2, %2) : (f32, f32) -> f32
    %5 = "spirv.FAdd"(%3, %4) : (f32, f32) -> f32
    %6 = "spirv.GL.Sqrt"(%5) : (f32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_abs_opencl"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (complex<f32>) -> vector<2xf32>
    %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %2 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %3 = "spirv.FMul"(%1, %1) : (f32, f32) -> f32
    %4 = "spirv.FMul"(%2, %2) : (f32, f32) -> f32
    %5 = "spirv.FAdd"(%3, %4) : (f32, f32) -> f32
    %6 = "spirv.CL.sqrt"(%5) : (f32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} : () -> ()

