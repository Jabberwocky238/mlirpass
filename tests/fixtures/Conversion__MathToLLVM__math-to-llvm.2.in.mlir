"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, i32, i32, f64) -> (), sym_name = "ops"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: i32, %arg3: i32, %arg4: f64):
    %0 = "math.exp"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.exp2"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.sqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %3 = "math.sqrt"(%arg4) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "absi"}> ({
  ^bb0(%arg0: i32):
    %0 = "math.absi"(%arg0) : (i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<i32>) -> (), sym_name = "absi_0dvector"}> ({
  ^bb0(%arg0: vector<i32>):
    %0 = "math.absi"(%arg0) : (vector<i32>) -> vector<i32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "log1p"}> ({
  ^bb0(%arg0: f32):
    %0 = "math.log1p"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "log1p_fmf"}> ({
  ^bb0(%arg0: f32):
    %0 = "math.log1p"(%arg0) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xf32>) -> (), sym_name = "log1p_2dvector"}> ({
  ^bb0(%arg0: vector<4x3xf32>):
    %0 = "math.log1p"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4x3xf32>) -> vector<4x3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xf32>) -> (), sym_name = "log1p_2dvector_fmf"}> ({
  ^bb0(%arg0: vector<4x3xf32>):
    %0 = "math.log1p"(%arg0) <{fastmath = #arith.fastmath<fast>}> : (vector<4x3xf32>) -> vector<4x3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "log1p_scalable_vector"}> ({
  ^bb0(%arg0: vector<[4]xf32>):
    %0 = "math.log1p"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%0) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "log1p_0dvector"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "math.log1p"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<f32>) -> vector<f32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "expm1"}> ({
  ^bb0(%arg0: f32):
    %0 = "math.expm1"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "expm1_fmf"}> ({
  ^bb0(%arg0: f32):
    %0 = "math.expm1"(%arg0) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "expm1_vector"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "math.expm1"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "expm1_scalable_vector"}> ({
  ^bb0(%arg0: vector<[4]xf32>):
    %0 = "math.expm1"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%0) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "expm1_vector_fmf"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "math.expm1"(%arg0) <{fastmath = #arith.fastmath<fast>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "expm1_0dvector"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "math.expm1"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<f32>) -> vector<f32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "rsqrt"}> ({
  ^bb0(%arg0: f32):
    %0 = "math.rsqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "rsqrt_0dvector"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "math.rsqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<f32>) -> vector<f32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "trigonometrics"}> ({
  ^bb0(%arg0: f32):
    %0 = "math.sin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.cos"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.tan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "sincos"}> ({
  ^bb0(%arg0: f32):
    %0:2 = "math.sincos"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> (f32, f32)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "inverse_trigonometrics"}> ({
  ^bb0(%arg0: f32):
    %0 = "math.asin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.acos"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.atan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "atan2"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "math.atan2"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "inverse_trigonometrics_vector"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "math.asin"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    %1 = "math.acos"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    %2 = "math.atan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "atan2_vector"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):
    %0 = "math.atan2"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "inverse_trigonometrics_fmf"}> ({
  ^bb0(%arg0: f32):
    %0 = "math.asin"(%arg0) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
    %1 = "math.acos"(%arg0) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
    %2 = "math.atan"(%arg0) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "atan2_fmf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "math.atan2"(%arg0, %arg1) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "hyperbolics"}> ({
  ^bb0(%arg0: f32):
    %0 = "math.sinh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.cosh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "math.tanh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "ctlz"}> ({
  ^bb0(%arg1: i32):
    %1 = "math.ctlz"(%arg1) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<i32>) -> (), sym_name = "ctlz_0dvector"}> ({
  ^bb0(%arg0: vector<i32>):
    %0 = "math.ctlz"(%arg0) : (vector<i32>) -> vector<i32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "cttz"}> ({
  ^bb0(%arg0: i32):
    %0 = "math.cttz"(%arg0) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<i32>) -> (), sym_name = "cttz_0dvector"}> ({
  ^bb0(%arg0: vector<i32>):
    %0 = "math.cttz"(%arg0) : (vector<i32>) -> vector<i32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>) -> (), sym_name = "cttz_vec"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "math.cttz"(%arg0) : (vector<4xi32>) -> vector<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xi32>) -> vector<[4]xi32>, sym_name = "cttz_scalable_vec"}> ({
  ^bb0(%arg0: vector<[4]xi32>):
    %0 = "math.cttz"(%arg0) : (vector<[4]xi32>) -> vector<[4]xi32>
    "func.return"(%0) : (vector<[4]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "ctpop"}> ({
  ^bb0(%arg0: i32):
    %0 = "math.ctpop"(%arg0) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi32>) -> (), sym_name = "ctpop_vector"}> ({
  ^bb0(%arg0: vector<3xi32>):
    %0 = "math.ctpop"(%arg0) : (vector<3xi32>) -> vector<3xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xi32>) -> vector<[4]xi32>, sym_name = "ctpop_scalable_vector"}> ({
  ^bb0(%arg0: vector<[4]xi32>):
    %0 = "math.ctpop"(%arg0) : (vector<[4]xi32>) -> vector<[4]xi32>
    "func.return"(%0) : (vector<[4]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "isnan_double"}> ({
  ^bb0(%arg0: f64):
    %0 = "math.isnan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f64) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "isnan_0dvector"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "math.isnan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<f32>) -> vector<i1>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "isfinite_double"}> ({
  ^bb0(%arg0: f64):
    %0 = "math.isfinite"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f64) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "isfinite_0dvector"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "math.isfinite"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<f32>) -> vector<i1>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "rsqrt_double"}> ({
  ^bb0(%arg0: f64):
    %0 = "math.rsqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "rsqrt_double_fmf"}> ({
  ^bb0(%arg0: f64):
    %0 = "math.rsqrt"(%arg0) <{fastmath = #arith.fastmath<fast>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "rsqrt_vector"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "math.rsqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "rsqrt_scalable_vector"}> ({
  ^bb0(%arg0: vector<[4]xf32>):
    %0 = "math.rsqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%0) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "rsqrt_vector_fmf"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "math.rsqrt"(%arg0) <{fastmath = #arith.fastmath<fast>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "rsqrt_scalable_vector_fmf"}> ({
  ^bb0(%arg0: vector<[4]xf32>):
    %0 = "math.rsqrt"(%arg0) <{fastmath = #arith.fastmath<fast>}> : (vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%0) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xf32>) -> (), sym_name = "rsqrt_multidim_vector"}> ({
  ^bb0(%arg0: vector<4x3xf32>):
    %0 = "math.rsqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4x3xf32>) -> vector<4x3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>) -> vector<4x[4]xf32>, sym_name = "rsqrt_multidim_scalable_vector"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>):
    %0 = "math.rsqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4x[4]xf32>) -> vector<4x[4]xf32>
    "func.return"(%0) : (vector<4x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64, i32) -> (), sym_name = "fpowi"}> ({
  ^bb0(%arg0: f64, %arg1: i32):
    %0 = "math.fpowi"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f64, i32) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "powf"}> ({
  ^bb0(%arg0: f64):
    %0 = "math.powf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "round"}> ({
  ^bb0(%arg0: f32):
    %0 = "math.round"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "roundeven"}> ({
  ^bb0(%arg0: f32):
    %0 = "math.roundeven"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "trunc"}> ({
  ^bb0(%arg0: f32):
    %0 = "math.trunc"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>) -> (), sym_name = "fastmath"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4xf32>):
    %0 = "math.trunc"(%arg0) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
    %1 = "math.powf"(%arg0, %arg0) <{fastmath = #arith.fastmath<afn>}> : (f32, f32) -> f32
    %2 = "math.sqrt"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %3 = "math.fma"(%arg0, %arg0, %arg0) <{fastmath = #arith.fastmath<fast>}> : (f32, f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN, f4E2M1FN) -> (), sym_name = "unsupported_fp_type"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN, %arg2: f4E2M1FN):
    %0 = "math.absf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f4E2M1FN) -> f4E2M1FN
    %1 = "math.cos"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f4E2M1FN) -> f4E2M1FN
    %2 = "math.fma"(%arg1, %arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f4E2M1FN, f4E2M1FN, f4E2M1FN) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

