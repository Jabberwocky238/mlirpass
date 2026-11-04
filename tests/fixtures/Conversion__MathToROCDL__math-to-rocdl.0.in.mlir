"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "arith_remf"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "arith.remf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    %1 = "arith.remf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %2 = "arith.remf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_acos"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.acos"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.acos"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.acos"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_acosh"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.acosh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.acosh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.acosh"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_asin"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.asin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.asin"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.asin"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_asinh"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.asinh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.asinh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.asinh"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_atan"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.atan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.atan"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.atan"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_atanh"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.atanh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.atanh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.atanh"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_atan2"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.atan2"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    %1 = "math.atan2"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %2 = "math.atan2"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_cbrt"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.cbrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.cbrt"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.cbrt"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_ceil"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.ceil"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.ceil"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.ceil"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_cos"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.cos"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.cos"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.cos"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_cosh"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.cosh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.cosh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.cosh"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_sinh"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.sinh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.sinh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.sinh"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f64) -> (f16, f64), sym_name = "math_exp"}> ({
  ^bb0(%arg0: f16, %arg1: f64):
    %0 = "math.exp"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.exp"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f16, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_exp2"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.exp2"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.exp2"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.exp2"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_expm1"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.expm1"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.expm1"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.expm1"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_floor"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.floor"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.floor"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.floor"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f64) -> (f16, f64), sym_name = "math_log"}> ({
  ^bb0(%arg0: f16, %arg1: f64):
    %0 = "math.log"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.log"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f16, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_log10"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.log10"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.log10"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.log10"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_log1p"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.log1p"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.log1p"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.log1p"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_powf"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.powf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    %1 = "math.powf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %2 = "math.powf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_rsqrt"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.rsqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.rsqrt"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.rsqrt"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_sin"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.sin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.sin"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.sin"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_tanh"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.tanh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.tanh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.tanh"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_tan"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.tan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.tan"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.tan"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_erf"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.erf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.erf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.erf"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64) -> (f16, f32, f64), sym_name = "math_erfc"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64):
    %0 = "math.erfc"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.erfc"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.erfc"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64, bf16) -> (f16, f32, f64, bf16), sym_name = "math_casting"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64, %arg3: bf16):
    %0 = "math.sin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.sin"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.sin"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    %3 = "math.sin"(%arg3) <{fastmath = #arith.fastmath<none>}> : (bf16) -> bf16
    "func.return"(%0, %1, %2, %3) : (f16, f32, f64, bf16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, f32, f64, i32) -> (f16, f32, f64), sym_name = "math_fpowi"}> ({
  ^bb0(%arg0: f16, %arg1: f32, %arg2: f64, %arg3: i32):
    %0 = "math.fpowi"(%arg0, %arg3) <{fastmath = #arith.fastmath<none>}> : (f16, i32) -> f16
    %1 = "math.fpowi"(%arg1, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, i32) -> f32
    %2 = "math.fpowi"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f64, i32) -> f64
    "func.return"(%0, %1, %2) : (f16, f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "test.some_op_with_region"() ({
  ^bb0(%arg0: f64):
    %0 = "math.atan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "test.possible_terminator"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (vector<f16>) -> vector<f16>, sym_name = "math_sin_vector_0d"}> ({
  ^bb0(%arg0: vector<f16>):
    %0 = "math.sin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<f16>) -> vector<f16>
    "func.return"(%0) : (vector<f16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf16>, sym_name = "math_sin_vector_1d"}> ({
  ^bb0(%arg0: vector<4xf16>):
    %0 = "math.sin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf16>) -> vector<4xf16>
    "func.return"(%0) : (vector<4xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (vector<2x2xf16>) -> vector<2x2xf16>, sym_name = "math_sin_vector_2d"}> ({
  ^bb0(%arg0: vector<2x2xf16>):
    %0 = "math.sin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf16>) -> vector<2x2xf16>
    "func.return"(%0) : (vector<2x2xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16, f16, f16) -> f16, sym_name = "clampf_f16"}> ({
  ^bb0(%arg3: f16, %arg4: f16, %arg5: f16):
    %1 = "math.clampf"(%arg3, %arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f16, f16, f16) -> f16
    "func.return"(%1) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> f32, sym_name = "clampf_f32"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
    %0 = "math.clampf"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf16>, vector<2xf16>) -> vector<2xf16>, sym_name = "clampf_vector_f16"}> ({
  ^bb0(%arg0: vector<2xf16>, %arg1: vector<2xf16>, %arg2: vector<2xf16>):
    %0 = "math.clampf"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<2xf16>, vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    "func.return"(%0) : (vector<2xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>, sym_name = "clampf_vector_f32"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>):
    %0 = "math.clampf"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "func.return"(%0) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>, sym_name = "clampf_vector_2d_f16"}> ({
  ^bb0(%arg0: vector<2x2xf16>, %arg1: vector<2x2xf16>, %arg2: vector<2x2xf16>):
    %0 = "math.clampf"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf16>, vector<2x2xf16>, vector<2x2xf16>) -> vector<2x2xf16>
    "func.return"(%0) : (vector<2x2xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (bf16, bf16, bf16) -> bf16, sym_name = "clampf_bf16"}> ({
  ^bb0(%arg0: bf16, %arg1: bf16, %arg2: bf16):
    %0 = "math.clampf"(%arg0, %arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16, bf16) -> bf16
    "func.return"(%0) : (bf16) -> ()
  }) : () -> ()
}) : () -> ()

