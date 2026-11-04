"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (f32, f64), sym_name = "abs_caller"}> ({
  ^bb0(%arg18: complex<f32>, %arg19: complex<f64>):
    %16 = "complex.abs"(%arg18) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %17 = "complex.abs"(%arg19) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> f64
    "func.return"(%16, %17) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "cos_caller"}> ({
  ^bb0(%arg16: complex<f32>, %arg17: complex<f64>):
    %14 = "complex.cos"(%arg16) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %15 = "complex.cos"(%arg17) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%14, %15) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "exp_caller"}> ({
  ^bb0(%arg14: complex<f32>, %arg15: complex<f64>):
    %12 = "complex.exp"(%arg14) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %13 = "complex.exp"(%arg15) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%12, %13) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "log_caller"}> ({
  ^bb0(%arg12: complex<f32>, %arg13: complex<f64>):
    %10 = "complex.log"(%arg12) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %11 = "complex.log"(%arg13) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%10, %11) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "pow_caller"}> ({
  ^bb0(%arg10: complex<f32>, %arg11: complex<f32>):
    %9 = "complex.pow"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%9) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, i32) -> complex<f32>, sym_name = "powi_caller"}> ({
  ^bb0(%arg8: complex<f32>, %arg9: i32):
    %8 = "complex.powi"(%arg8, %arg9) : (complex<f32>, i32) -> complex<f32>
    "func.return"(%8) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "sin_caller"}> ({
  ^bb0(%arg6: complex<f32>, %arg7: complex<f64>):
    %6 = "complex.sin"(%arg6) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %7 = "complex.sin"(%arg7) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%6, %7) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "sqrt_caller"}> ({
  ^bb0(%arg4: complex<f32>, %arg5: complex<f64>):
    %4 = "complex.sqrt"(%arg4) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %5 = "complex.sqrt"(%arg5) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%4, %5) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "tan_caller"}> ({
  ^bb0(%arg2: complex<f32>, %arg3: complex<f64>):
    %2 = "complex.tan"(%arg2) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %3 = "complex.tan"(%arg3) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%2, %3) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "tanh_caller"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f64>):
    %0 = "complex.tanh"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %1 = "complex.tanh"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%0, %1) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
}) : () -> ()

