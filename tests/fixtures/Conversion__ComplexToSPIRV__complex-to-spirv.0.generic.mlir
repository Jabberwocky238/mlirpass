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

