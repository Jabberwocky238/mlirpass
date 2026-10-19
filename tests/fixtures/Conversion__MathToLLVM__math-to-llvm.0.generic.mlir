"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, i32, i32, f64) -> (), sym_name = "ops"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: i32, %arg3: i32, %arg4: f64):
    %0 = "llvm.intr.exp"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %1 = "llvm.intr.exp2"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %2 = "llvm.intr.sqrt"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %3 = "llvm.intr.sqrt"(%arg4) <{fastmathFlags = #llvm.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "absi"}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<i32>) -> (), sym_name = "absi_0dvector"}> ({
  ^bb0(%arg0: vector<i32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<i32>) -> vector<1xi32>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (vector<1xi32>) -> vector<1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "log1p"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "llvm.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %2 = "llvm.intr.log"(%1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "log1p_fmf"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "llvm.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, f32) -> f32
    %2 = "llvm.intr.log"(%1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xf32>) -> (), sym_name = "log1p_2dvector"}> ({
  ^bb0(%arg0: vector<4x3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %1 = "llvm.mlir.poison"() : () -> !llvm.array<4 x vector<3xf32>>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %3 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %4 = "llvm.fadd"(%3, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %5 = "llvm.intr.log"(%4) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %6 = "llvm.insertvalue"(%1, %5) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %8 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %9 = "llvm.fadd"(%8, %7) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %10 = "llvm.intr.log"(%9) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %11 = "llvm.insertvalue"(%6, %10) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %12 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %13 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %14 = "llvm.fadd"(%13, %12) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %15 = "llvm.intr.log"(%14) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %16 = "llvm.insertvalue"(%11, %15) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %17 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %18 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %19 = "llvm.fadd"(%18, %17) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %20 = "llvm.intr.log"(%19) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %21 = "llvm.insertvalue"(%16, %20) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xf32>) -> (), sym_name = "log1p_2dvector_fmf"}> ({
  ^bb0(%arg0: vector<4x3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %1 = "llvm.mlir.poison"() : () -> !llvm.array<4 x vector<3xf32>>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %3 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %4 = "llvm.fadd"(%3, %2) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %5 = "llvm.intr.log"(%4) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<3xf32>) -> vector<3xf32>
    %6 = "llvm.insertvalue"(%1, %5) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %8 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %9 = "llvm.fadd"(%8, %7) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %10 = "llvm.intr.log"(%9) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<3xf32>) -> vector<3xf32>
    %11 = "llvm.insertvalue"(%6, %10) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %12 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %13 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %14 = "llvm.fadd"(%13, %12) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %15 = "llvm.intr.log"(%14) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<3xf32>) -> vector<3xf32>
    %16 = "llvm.insertvalue"(%11, %15) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %17 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %18 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %19 = "llvm.fadd"(%18, %17) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %20 = "llvm.intr.log"(%19) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<3xf32>) -> vector<3xf32>
    %21 = "llvm.insertvalue"(%16, %20) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "log1p_scalable_vector"}> ({
  ^bb0(%arg0: vector<[4]xf32>):
    %0 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    %1 = "llvm.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    %2 = "llvm.intr.log"(%1) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%2) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "log1p_0dvector"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<f32>) -> vector<1xf32>
    %1 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<1xf32>}> : () -> vector<1xf32>
    %2 = "llvm.fadd"(%1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<1xf32>, vector<1xf32>) -> vector<1xf32>
    %3 = "llvm.intr.log"(%2) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<1xf32>) -> vector<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "expm1"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "llvm.intr.exp"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %2 = "llvm.fsub"(%1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "expm1_fmf"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "llvm.intr.exp"(%arg0) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32) -> f32
    %2 = "llvm.fsub"(%1, %0) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "expm1_vector"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "llvm.intr.exp"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    %2 = "llvm.fsub"(%1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "expm1_scalable_vector"}> ({
  ^bb0(%arg0: vector<[4]xf32>):
    %0 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    %1 = "llvm.intr.exp"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>) -> vector<[4]xf32>
    %2 = "llvm.fsub"(%1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%2) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "expm1_vector_fmf"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "llvm.intr.exp"(%arg0) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<4xf32>) -> vector<4xf32>
    %2 = "llvm.fsub"(%1, %0) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "expm1_0dvector"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<f32>) -> vector<1xf32>
    %1 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<1xf32>}> : () -> vector<1xf32>
    %2 = "llvm.intr.exp"(%0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<1xf32>) -> vector<1xf32>
    %3 = "llvm.fsub"(%2, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<1xf32>, vector<1xf32>) -> vector<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "rsqrt"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "llvm.intr.sqrt"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %2 = "llvm.fdiv"(%0, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "rsqrt_0dvector"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<f32>) -> vector<1xf32>
    %1 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<1xf32>}> : () -> vector<1xf32>
    %2 = "llvm.intr.sqrt"(%0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<1xf32>) -> vector<1xf32>
    %3 = "llvm.fdiv"(%1, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<1xf32>, vector<1xf32>) -> vector<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "trigonometrics"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.intr.sin"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %1 = "llvm.intr.cos"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %2 = "llvm.intr.tan"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "sincos"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.intr.sincos"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> !llvm.struct<(f32, f32)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(f32, f32)>) -> f32
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(f32, f32)>) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "inverse_trigonometrics"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.intr.asin"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %1 = "llvm.intr.acos"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %2 = "llvm.intr.atan"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "atan2"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "llvm.intr.atan2"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "inverse_trigonometrics_vector"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "llvm.intr.asin"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    %1 = "llvm.intr.acos"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    %2 = "llvm.intr.atan"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "atan2_vector"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):
    %0 = "llvm.intr.atan2"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "inverse_trigonometrics_fmf"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.intr.asin"(%arg0) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32) -> f32
    %1 = "llvm.intr.acos"(%arg0) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32) -> f32
    %2 = "llvm.intr.atan"(%arg0) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "atan2_fmf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "llvm.intr.atan2"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "hyperbolics"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.intr.sinh"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %1 = "llvm.intr.cosh"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %2 = "llvm.intr.tanh"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "ctlz"}> ({
  ^bb0(%arg1: i32):
    %2 = "llvm.intr.ctlz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<i32>) -> (), sym_name = "ctlz_0dvector"}> ({
  ^bb0(%arg0: vector<i32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<i32>) -> vector<1xi32>
    %1 = "llvm.intr.ctlz"(%0) <{is_zero_poison = false}> : (vector<1xi32>) -> vector<1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "cttz"}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<i32>) -> (), sym_name = "cttz_0dvector"}> ({
  ^bb0(%arg0: vector<i32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<i32>) -> vector<1xi32>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (vector<1xi32>) -> vector<1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>) -> (), sym_name = "cttz_vec"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<4xi32>) -> vector<4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xi32>) -> vector<[4]xi32>, sym_name = "cttz_scalable_vec"}> ({
  ^bb0(%arg0: vector<[4]xi32>):
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<[4]xi32>) -> vector<[4]xi32>
    "func.return"(%0) : (vector<[4]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "ctpop"}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.intr.ctpop"(%arg0) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi32>) -> (), sym_name = "ctpop_vector"}> ({
  ^bb0(%arg0: vector<3xi32>):
    %0 = "llvm.intr.ctpop"(%arg0) : (vector<3xi32>) -> vector<3xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xi32>) -> vector<[4]xi32>, sym_name = "ctpop_scalable_vector"}> ({
  ^bb0(%arg0: vector<[4]xi32>):
    %0 = "llvm.intr.ctpop"(%arg0) : (vector<[4]xi32>) -> vector<[4]xi32>
    "func.return"(%0) : (vector<[4]xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "isnan_double"}> ({
  ^bb0(%arg0: f64):
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 3 : i32}> : (f64) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "isnan_0dvector"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<f32>) -> vector<1xf32>
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 3 : i32}> : (vector<1xf32>) -> vector<1xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "isfinite_double"}> ({
  ^bb0(%arg0: f64):
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 504 : i32}> : (f64) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f32>) -> (), sym_name = "isfinite_0dvector"}> ({
  ^bb0(%arg0: vector<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<f32>) -> vector<1xf32>
    %1 = "llvm.intr.is.fpclass"(%0) <{bit = 504 : i32}> : (vector<1xf32>) -> vector<1xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "rsqrt_double"}> ({
  ^bb0(%arg0: f64):
    %0 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    %1 = "llvm.intr.sqrt"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f64) -> f64
    %2 = "llvm.fdiv"(%0, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "rsqrt_double_fmf"}> ({
  ^bb0(%arg0: f64):
    %0 = "llvm.mlir.constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    %1 = "llvm.intr.sqrt"(%arg0) <{fastmathFlags = #llvm.fastmath<fast>}> : (f64) -> f64
    %2 = "llvm.fdiv"(%0, %1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "rsqrt_vector"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "llvm.intr.sqrt"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    %2 = "llvm.fdiv"(%0, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "rsqrt_scalable_vector"}> ({
  ^bb0(%arg0: vector<[4]xf32>):
    %0 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    %1 = "llvm.intr.sqrt"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>) -> vector<[4]xf32>
    %2 = "llvm.fdiv"(%0, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%2) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> (), sym_name = "rsqrt_vector_fmf"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "llvm.intr.sqrt"(%arg0) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<4xf32>) -> vector<4xf32>
    %2 = "llvm.fdiv"(%0, %1) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[4]xf32>) -> vector<[4]xf32>, sym_name = "rsqrt_scalable_vector_fmf"}> ({
  ^bb0(%arg0: vector<[4]xf32>):
    %0 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    %1 = "llvm.intr.sqrt"(%arg0) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<[4]xf32>) -> vector<[4]xf32>
    %2 = "llvm.fdiv"(%0, %1) <{fastmathFlags = #llvm.fastmath<fast>}> : (vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    "func.return"(%2) : (vector<[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xf32>) -> (), sym_name = "rsqrt_multidim_vector"}> ({
  ^bb0(%arg0: vector<4x3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %1 = "llvm.mlir.poison"() : () -> !llvm.array<4 x vector<3xf32>>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %3 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %4 = "llvm.intr.sqrt"(%2) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %5 = "llvm.fdiv"(%3, %4) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %6 = "llvm.insertvalue"(%1, %5) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %8 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %9 = "llvm.intr.sqrt"(%7) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %10 = "llvm.fdiv"(%8, %9) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %11 = "llvm.insertvalue"(%6, %10) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %12 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %13 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %14 = "llvm.intr.sqrt"(%12) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %15 = "llvm.fdiv"(%13, %14) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %16 = "llvm.insertvalue"(%11, %15) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %17 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %18 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %19 = "llvm.intr.sqrt"(%17) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>) -> vector<3xf32>
    %20 = "llvm.fdiv"(%18, %19) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %21 = "llvm.insertvalue"(%16, %20) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xf32>>, vector<3xf32>) -> !llvm.array<4 x vector<3xf32>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x[4]xf32>) -> vector<4x[4]xf32>, sym_name = "rsqrt_multidim_scalable_vector"}> ({
  ^bb0(%arg0: vector<4x[4]xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x[4]xf32>) -> !llvm.array<4 x vector<[4]xf32>>
    %1 = "llvm.mlir.poison"() : () -> !llvm.array<4 x vector<[4]xf32>>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<[4]xf32>>) -> vector<[4]xf32>
    %3 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    %4 = "llvm.intr.sqrt"(%2) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>) -> vector<[4]xf32>
    %5 = "llvm.fdiv"(%3, %4) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    %6 = "llvm.insertvalue"(%1, %5) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<4 x vector<[4]xf32>>
    %7 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<[4]xf32>>) -> vector<[4]xf32>
    %8 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    %9 = "llvm.intr.sqrt"(%7) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>) -> vector<[4]xf32>
    %10 = "llvm.fdiv"(%8, %9) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    %11 = "llvm.insertvalue"(%6, %10) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<4 x vector<[4]xf32>>
    %12 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<[4]xf32>>) -> vector<[4]xf32>
    %13 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    %14 = "llvm.intr.sqrt"(%12) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>) -> vector<[4]xf32>
    %15 = "llvm.fdiv"(%13, %14) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    %16 = "llvm.insertvalue"(%11, %15) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<4 x vector<[4]xf32>>
    %17 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<[4]xf32>>) -> vector<[4]xf32>
    %18 = "llvm.mlir.constant"() <{value = dense<1.000000e+00> : vector<[4]xf32>}> : () -> vector<[4]xf32>
    %19 = "llvm.intr.sqrt"(%17) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>) -> vector<[4]xf32>
    %20 = "llvm.fdiv"(%18, %19) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<[4]xf32>, vector<[4]xf32>) -> vector<[4]xf32>
    %21 = "llvm.insertvalue"(%16, %20) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<[4]xf32>>, vector<[4]xf32>) -> !llvm.array<4 x vector<[4]xf32>>
    %22 = "builtin.unrealized_conversion_cast"(%21) : (!llvm.array<4 x vector<[4]xf32>>) -> vector<4x[4]xf32>
    "func.return"(%22) : (vector<4x[4]xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64, i32) -> (), sym_name = "fpowi"}> ({
  ^bb0(%arg0: f64, %arg1: i32):
    %0 = "llvm.intr.powi"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, i32) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "powf"}> ({
  ^bb0(%arg0: f64):
    %0 = "llvm.intr.pow"(%arg0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "round"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.intr.round"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "roundeven"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.intr.roundeven"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "trunc"}> ({
  ^bb0(%arg0: f32):
    %0 = "llvm.intr.trunc"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>) -> (), sym_name = "fastmath"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4xf32>):
    %0 = "llvm.intr.trunc"(%arg0) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32) -> f32
    %1 = "llvm.intr.pow"(%arg0, %arg0) <{fastmathFlags = #llvm.fastmath<afn>}> : (f32, f32) -> f32
    %2 = "llvm.intr.sqrt"(%arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32) -> f32
    %3 = "llvm.intr.fma"(%arg0, %arg0, %arg0) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, f32, f32) -> f32
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

