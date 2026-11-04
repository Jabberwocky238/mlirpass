"builtin.module"() ({
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "__ocml_ctanh_f64", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "__ocml_ctanh_f32", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "__ocml_ctan_f64", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "__ocml_ctan_f32", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "__ocml_csqrt_f64", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "__ocml_csqrt_f32", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "__ocml_csin_f64", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "__ocml_csin_f32", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "__ocml_clog_f64", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "__ocml_clog_f32", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "__ocml_cexp_f64", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "__ocml_cexp_f32", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "__ocml_ccos_f64", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "__ocml_ccos_f32", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> f64, sym_name = "__ocml_cabs_f64", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "__ocml_cabs_f32", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (f32, f64), sym_name = "abs_caller"}> ({
  ^bb0(%arg18: complex<f32>, %arg19: complex<f64>):
    %23 = "func.call"(%arg18) <{callee = @__ocml_cabs_f32}> : (complex<f32>) -> f32
    %24 = "func.call"(%arg19) <{callee = @__ocml_cabs_f64}> : (complex<f64>) -> f64
    "func.return"(%23, %24) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "cos_caller"}> ({
  ^bb0(%arg16: complex<f32>, %arg17: complex<f64>):
    %21 = "func.call"(%arg16) <{callee = @__ocml_ccos_f32}> : (complex<f32>) -> complex<f32>
    %22 = "func.call"(%arg17) <{callee = @__ocml_ccos_f64}> : (complex<f64>) -> complex<f64>
    "func.return"(%21, %22) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "exp_caller"}> ({
  ^bb0(%arg14: complex<f32>, %arg15: complex<f64>):
    %19 = "func.call"(%arg14) <{callee = @__ocml_cexp_f32}> : (complex<f32>) -> complex<f32>
    %20 = "func.call"(%arg15) <{callee = @__ocml_cexp_f64}> : (complex<f64>) -> complex<f64>
    "func.return"(%19, %20) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "log_caller"}> ({
  ^bb0(%arg12: complex<f32>, %arg13: complex<f64>):
    %17 = "func.call"(%arg12) <{callee = @__ocml_clog_f32}> : (complex<f32>) -> complex<f32>
    %18 = "func.call"(%arg13) <{callee = @__ocml_clog_f64}> : (complex<f64>) -> complex<f64>
    "func.return"(%17, %18) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "pow_caller"}> ({
  ^bb0(%arg10: complex<f32>, %arg11: complex<f32>):
    %14 = "func.call"(%arg10) <{callee = @__ocml_clog_f32}> : (complex<f32>) -> complex<f32>
    %15 = "complex.mul"(%arg11, %14) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %16 = "func.call"(%15) <{callee = @__ocml_cexp_f32}> : (complex<f32>) -> complex<f32>
    "func.return"(%16) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, i32) -> complex<f32>, sym_name = "powi_caller"}> ({
  ^bb0(%arg8: complex<f32>, %arg9: i32):
    %8 = "arith.sitofp"(%arg9) : (i32) -> f32
    %9 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %10 = "complex.create"(%8, %9) : (f32, f32) -> complex<f32>
    %11 = "func.call"(%arg8) <{callee = @__ocml_clog_f32}> : (complex<f32>) -> complex<f32>
    %12 = "complex.mul"(%10, %11) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %13 = "func.call"(%12) <{callee = @__ocml_cexp_f32}> : (complex<f32>) -> complex<f32>
    "func.return"(%13) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "sin_caller"}> ({
  ^bb0(%arg6: complex<f32>, %arg7: complex<f64>):
    %6 = "func.call"(%arg6) <{callee = @__ocml_csin_f32}> : (complex<f32>) -> complex<f32>
    %7 = "func.call"(%arg7) <{callee = @__ocml_csin_f64}> : (complex<f64>) -> complex<f64>
    "func.return"(%6, %7) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "sqrt_caller"}> ({
  ^bb0(%arg4: complex<f32>, %arg5: complex<f64>):
    %4 = "func.call"(%arg4) <{callee = @__ocml_csqrt_f32}> : (complex<f32>) -> complex<f32>
    %5 = "func.call"(%arg5) <{callee = @__ocml_csqrt_f64}> : (complex<f64>) -> complex<f64>
    "func.return"(%4, %5) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "tan_caller"}> ({
  ^bb0(%arg2: complex<f32>, %arg3: complex<f64>):
    %2 = "func.call"(%arg2) <{callee = @__ocml_ctan_f32}> : (complex<f32>) -> complex<f32>
    %3 = "func.call"(%arg3) <{callee = @__ocml_ctan_f64}> : (complex<f64>) -> complex<f64>
    "func.return"(%2, %3) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "tanh_caller"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f64>):
    %0 = "func.call"(%arg0) <{callee = @__ocml_ctanh_f32}> : (complex<f32>) -> complex<f32>
    %1 = "func.call"(%arg1) <{callee = @__ocml_ctanh_f64}> : (complex<f64>) -> complex<f64>
    "func.return"(%0, %1) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
}) : () -> ()

