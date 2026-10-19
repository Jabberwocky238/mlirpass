"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "cpow_caller"}> ({
  ^bb0(%arg18: complex<f32>, %arg19: complex<f64>):
    %18 = "complex.pow"(%arg18, %arg18) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %19 = "complex.pow"(%arg19, %arg19) <{fastmath = #arith.fastmath<none>}> : (complex<f64>, complex<f64>) -> complex<f64>
    "func.return"(%18, %19) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "csqrt_caller"}> ({
  ^bb0(%arg16: complex<f32>, %arg17: complex<f64>):
    %16 = "complex.sqrt"(%arg16) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %17 = "complex.sqrt"(%arg17) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%16, %17) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "ctanh_caller"}> ({
  ^bb0(%arg14: complex<f32>, %arg15: complex<f64>):
    %14 = "complex.tanh"(%arg14) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %15 = "complex.tanh"(%arg15) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%14, %15) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "ccos_caller"}> ({
  ^bb0(%arg12: complex<f32>, %arg13: complex<f64>):
    %12 = "complex.cos"(%arg12) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %13 = "complex.cos"(%arg13) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%12, %13) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "csin_caller"}> ({
  ^bb0(%arg10: complex<f32>, %arg11: complex<f64>):
    %10 = "complex.sin"(%arg10) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %11 = "complex.sin"(%arg11) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%10, %11) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "conj_caller"}> ({
  ^bb0(%arg8: complex<f32>, %arg9: complex<f64>):
    %8 = "complex.conj"(%arg8) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %9 = "complex.conj"(%arg9) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%8, %9) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (f32, f64), sym_name = "cabs_caller"}> ({
  ^bb0(%arg6: complex<f32>, %arg7: complex<f64>):
    %6 = "complex.abs"(%arg6) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %7 = "complex.abs"(%arg7) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> f64
    "func.return"(%6, %7) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (f32, f64), sym_name = "carg_caller"}> ({
  ^bb0(%arg4: complex<f32>, %arg5: complex<f64>):
    %4 = "complex.angle"(%arg4) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %5 = "complex.angle"(%arg5) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> f64
    "func.return"(%4, %5) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "clog_caller"}> ({
  ^bb0(%arg2: complex<f32>, %arg3: complex<f64>):
    %2 = "complex.log"(%arg2) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %3 = "complex.log"(%arg3) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%2, %3) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "ctan_caller"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f64>):
    %0 = "complex.tan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %1 = "complex.tan"(%arg1) <{fastmath = #arith.fastmath<none>}> : (complex<f64>) -> complex<f64>
    "func.return"(%0, %1) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
}) : () -> ()

