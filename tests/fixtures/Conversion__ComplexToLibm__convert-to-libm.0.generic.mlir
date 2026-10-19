"builtin.module"() ({
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "ctan", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "ctanf", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "clog", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "clogf", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> f64, sym_name = "carg", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "cargf", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> f64, sym_name = "cabs", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "cabsf", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "conj", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "conjf", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "csin", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "csinf", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "ccos", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "ccosf", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "ctanh", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "ctanhf", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>) -> complex<f64>, sym_name = "csqrt", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "csqrtf", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f64>, complex<f64>) -> complex<f64>, sym_name = "cpow", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "cpowf", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "cpow_caller"}> ({
  ^bb0(%arg18: complex<f32>, %arg19: complex<f64>):
    %18 = "func.call"(%arg18, %arg18) <{callee = @cpowf}> : (complex<f32>, complex<f32>) -> complex<f32>
    %19 = "func.call"(%arg19, %arg19) <{callee = @cpow}> : (complex<f64>, complex<f64>) -> complex<f64>
    "func.return"(%18, %19) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "csqrt_caller"}> ({
  ^bb0(%arg16: complex<f32>, %arg17: complex<f64>):
    %16 = "func.call"(%arg16) <{callee = @csqrtf}> : (complex<f32>) -> complex<f32>
    %17 = "func.call"(%arg17) <{callee = @csqrt}> : (complex<f64>) -> complex<f64>
    "func.return"(%16, %17) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "ctanh_caller"}> ({
  ^bb0(%arg14: complex<f32>, %arg15: complex<f64>):
    %14 = "func.call"(%arg14) <{callee = @ctanhf}> : (complex<f32>) -> complex<f32>
    %15 = "func.call"(%arg15) <{callee = @ctanh}> : (complex<f64>) -> complex<f64>
    "func.return"(%14, %15) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "ccos_caller"}> ({
  ^bb0(%arg12: complex<f32>, %arg13: complex<f64>):
    %12 = "func.call"(%arg12) <{callee = @ccosf}> : (complex<f32>) -> complex<f32>
    %13 = "func.call"(%arg13) <{callee = @ccos}> : (complex<f64>) -> complex<f64>
    "func.return"(%12, %13) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "csin_caller"}> ({
  ^bb0(%arg10: complex<f32>, %arg11: complex<f64>):
    %10 = "func.call"(%arg10) <{callee = @csinf}> : (complex<f32>) -> complex<f32>
    %11 = "func.call"(%arg11) <{callee = @csin}> : (complex<f64>) -> complex<f64>
    "func.return"(%10, %11) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "conj_caller"}> ({
  ^bb0(%arg8: complex<f32>, %arg9: complex<f64>):
    %8 = "func.call"(%arg8) <{callee = @conjf}> : (complex<f32>) -> complex<f32>
    %9 = "func.call"(%arg9) <{callee = @conj}> : (complex<f64>) -> complex<f64>
    "func.return"(%8, %9) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (f32, f64), sym_name = "cabs_caller"}> ({
  ^bb0(%arg6: complex<f32>, %arg7: complex<f64>):
    %6 = "func.call"(%arg6) <{callee = @cabsf}> : (complex<f32>) -> f32
    %7 = "func.call"(%arg7) <{callee = @cabs}> : (complex<f64>) -> f64
    "func.return"(%6, %7) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (f32, f64), sym_name = "carg_caller"}> ({
  ^bb0(%arg4: complex<f32>, %arg5: complex<f64>):
    %4 = "func.call"(%arg4) <{callee = @cargf}> : (complex<f32>) -> f32
    %5 = "func.call"(%arg5) <{callee = @carg}> : (complex<f64>) -> f64
    "func.return"(%4, %5) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "clog_caller"}> ({
  ^bb0(%arg2: complex<f32>, %arg3: complex<f64>):
    %2 = "func.call"(%arg2) <{callee = @clogf}> : (complex<f32>) -> complex<f32>
    %3 = "func.call"(%arg3) <{callee = @clog}> : (complex<f64>) -> complex<f64>
    "func.return"(%2, %3) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f64>) -> (complex<f32>, complex<f64>), sym_name = "ctan_caller"}> ({
  ^bb0(%arg0: complex<f32>, %arg1: complex<f64>):
    %0 = "func.call"(%arg0) <{callee = @ctanf}> : (complex<f32>) -> complex<f32>
    %1 = "func.call"(%arg1) <{callee = @ctan}> : (complex<f64>) -> complex<f64>
    "func.return"(%0, %1) : (complex<f32>, complex<f64>) -> ()
  }) : () -> ()
}) : () -> ()

