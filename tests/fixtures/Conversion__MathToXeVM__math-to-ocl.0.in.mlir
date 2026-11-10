"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f32) -> (f32, f32, f32), sym_name = "math_bin_f32"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "math.copysign"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %1 = "math.atan2"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %2 = "math.powf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0, %1, %2) : (f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f64, f64) -> (f64, f64, f64), sym_name = "math_bin_f64"}> ({
  ^bb0(%arg0: f64, %arg1: f64):
    %0 = "math.copysign"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    %1 = "math.atan2"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    %2 = "math.powf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"(%0, %1, %2) : (f64, f64, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (memref<32xvector<4xf32>>, memref<32xvector<4xf32>>, index) -> (), sym_name = "expm1_vector"}> ({
  ^bb0(%arg0: memref<32xvector<4xf32>>, %arg1: memref<32xvector<4xf32>>, %arg2: index):
    %0 = "memref.load"(%arg0, %arg2) : (memref<32xvector<4xf32>>, index) -> vector<4xf32>
    %1 = "math.expm1"(%0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "memref.store"(%1, %arg1, %arg2) : (vector<4xf32>, memref<32xvector<4xf32>>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_fast_sin"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.sin"(%arg0) <{fastmath = #arith.fastmath<afn>}> : (f32) -> f32
    %1 = "math.sin"(%arg1) <{fastmath = #arith.fastmath<afn>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_acos"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.acos"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.acos"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_acosh"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.acosh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.acosh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_asin"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.asin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.asin"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_asinh"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.asinh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.asinh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_atan"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.atan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.atan"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_atanh"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.atanh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.atanh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_cbrt"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.cbrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.cbrt"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_cos"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.cos"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.cos"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_cosh"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.cosh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.cosh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_erf"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.erf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.erf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_erfc"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.erfc"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.erfc"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_exp"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.exp"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.exp"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_exp2"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.exp2"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.exp2"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_expm1"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.expm1"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.expm1"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_log"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.log"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.log"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_log10"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.log10"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.log10"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_log1p"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.log1p"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.log1p"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_log2"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.log2"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.log2"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_rsqrt"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.rsqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.rsqrt"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_sin"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.sin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.sin"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_sinh"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.sinh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.sinh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_sqrt"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.sqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.sqrt"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_tan"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.tan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.tan"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "math_tanh"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.tanh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.tanh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%0, %1) : (f32, f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f16, bf16) -> (f16, bf16), sym_name = "math_unary_16bit"}> ({
  ^bb0(%arg0: f16, %arg1: bf16):
    %0 = "math.cbrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %1 = "math.erfc"(%arg1) <{fastmath = #arith.fastmath<none>}> : (bf16) -> bf16
    "func.return"(%0, %1) : (f16, bf16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "test_module"}> ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "math_sqrt_div"}> ({
  ^bb0(%arg0: f32):
    %0 = "math.sqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "arith.divf"(%arg0, %0) <{fastmath = #arith.fastmath<afn>}> : (f32, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

