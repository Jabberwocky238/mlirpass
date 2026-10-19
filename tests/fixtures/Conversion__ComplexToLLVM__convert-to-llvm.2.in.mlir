"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "complex_create"}> ({
  ^bb0(%arg11: f32, %arg12: f32):
    %37 = "complex.create"(%arg11, %arg12) : (f32, f32) -> complex<f32>
    "func.return"(%37) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f64>, sym_name = "complex_constant"}> ({
    %36 = "complex.constant"() <{value = [1.000000e+00, 2.000000e+00]}> : () -> complex<f64>
    "func.return"(%36) : (complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> (), sym_name = "complex_extract"}> ({
  ^bb0(%arg10: complex<f32>):
    %34 = "complex.re"(%arg10) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %35 = "complex.im"(%arg10) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "complex_addition"}> ({
    %27 = "arith.constant"() <{value = 1.200000e+00 : f64}> : () -> f64
    %28 = "arith.constant"() <{value = 3.400000e+00 : f64}> : () -> f64
    %29 = "complex.create"(%27, %28) : (f64, f64) -> complex<f64>
    %30 = "arith.constant"() <{value = 5.600000e+00 : f64}> : () -> f64
    %31 = "arith.constant"() <{value = 7.7999999999999998 : f64}> : () -> f64
    %32 = "complex.create"(%30, %31) : (f64, f64) -> complex<f64>
    %33 = "complex.add"(%29, %32) <{fastmath = #arith.fastmath<none>}> : (complex<f64>, complex<f64>) -> complex<f64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "complex_substraction"}> ({
    %20 = "arith.constant"() <{value = 1.200000e+00 : f64}> : () -> f64
    %21 = "arith.constant"() <{value = 3.400000e+00 : f64}> : () -> f64
    %22 = "complex.create"(%20, %21) : (f64, f64) -> complex<f64>
    %23 = "arith.constant"() <{value = 5.600000e+00 : f64}> : () -> f64
    %24 = "arith.constant"() <{value = 7.7999999999999998 : f64}> : () -> f64
    %25 = "complex.create"(%23, %24) : (f64, f64) -> complex<f64>
    %26 = "complex.sub"(%22, %25) <{fastmath = #arith.fastmath<none>}> : (complex<f64>, complex<f64>) -> complex<f64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div"}> ({
  ^bb0(%arg8: complex<f32>, %arg9: complex<f32>):
    %19 = "complex.div"(%arg8, %arg9) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%19) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_mul"}> ({
  ^bb0(%arg6: complex<f32>, %arg7: complex<f32>):
    %18 = "complex.mul"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%18) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_abs"}> ({
  ^bb0(%arg5: complex<f32>):
    %17 = "complex.abs"(%arg5) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%17) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "complex_addition_with_fmf"}> ({
    %10 = "arith.constant"() <{value = 1.200000e+00 : f64}> : () -> f64
    %11 = "arith.constant"() <{value = 3.400000e+00 : f64}> : () -> f64
    %12 = "complex.create"(%10, %11) : (f64, f64) -> complex<f64>
    %13 = "arith.constant"() <{value = 5.600000e+00 : f64}> : () -> f64
    %14 = "arith.constant"() <{value = 7.7999999999999998 : f64}> : () -> f64
    %15 = "complex.create"(%13, %14) : (f64, f64) -> complex<f64>
    %16 = "complex.add"(%12, %15) <{fastmath = #arith.fastmath<reassoc>}> : (complex<f64>, complex<f64>) -> complex<f64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "complex_substraction_with_fmf"}> ({
    %3 = "arith.constant"() <{value = 1.200000e+00 : f64}> : () -> f64
    %4 = "arith.constant"() <{value = 3.400000e+00 : f64}> : () -> f64
    %5 = "complex.create"(%3, %4) : (f64, f64) -> complex<f64>
    %6 = "arith.constant"() <{value = 5.600000e+00 : f64}> : () -> f64
    %7 = "arith.constant"() <{value = 7.7999999999999998 : f64}> : () -> f64
    %8 = "complex.create"(%6, %7) : (f64, f64) -> complex<f64>
    %9 = "complex.sub"(%5, %8) <{fastmath = #arith.fastmath<nnan,ninf>}> : (complex<f64>, complex<f64>) -> complex<f64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_div_with_fmf"}> ({
  ^bb0(%arg3: complex<f32>, %arg4: complex<f32>):
    %2 = "complex.div"(%arg3, %arg4) <{fastmath = #arith.fastmath<nsz,arcp>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%2) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "complex_mul_with_fmf"}> ({
  ^bb0(%arg1: complex<f32>, %arg2: complex<f32>):
    %1 = "complex.mul"(%arg1, %arg2) <{fastmath = #arith.fastmath<contract,afn>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%1) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> f32, sym_name = "complex_abs_with_fmf"}> ({
  ^bb0(%arg0: complex<f32>):
    %0 = "complex.abs"(%arg0) <{fastmath = #arith.fastmath<contract>}> : (complex<f32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

