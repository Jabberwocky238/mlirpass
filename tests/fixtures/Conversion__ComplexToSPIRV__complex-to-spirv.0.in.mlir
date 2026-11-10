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

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_add"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.add"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%0) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_sub"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.sub"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%0) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_mul"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.mul"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%0) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.div"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%0) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> i1, sym_name = "complex_eq"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.eq"(%arg0, %arg1) : (complex<f32>, complex<f32>) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> i1, sym_name = "complex_neq"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f32>):
    %0 = "complex.neq"(%arg0, %arg1) : (complex<f32>, complex<f32>) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_neg"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.neg"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    "func.return"(%0) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "complex_conj"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.conj"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    "func.return"(%0) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_abs"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.abs"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_abs_opencl"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.abs"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>} : () -> ()

