"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "create_complex"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "complex.create"(%arg0, %arg1) : (f32, f32) -> complex<f32>
    "func.return"(%0) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "real_number"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.re"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "imaginary_number"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.im"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_const"}> ({
    %0 = "complex.constant"() <{value = [0x7FC00000 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%0) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

