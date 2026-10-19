"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "create_of_real_and_imag"}> ({
  ^bb0(%arg31: complex<f32>):
    "func.return"(%arg31) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "create_of_real_and_imag_different_operand"}> ({
  ^bb0(%arg29: complex<f32>, %arg30: complex<f32>):
    %28 = "complex.re"(%arg29) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %29 = "complex.im"(%arg30) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %30 = "complex.create"(%28, %29) : (f32, f32) -> complex<f32>
    "func.return"(%30) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "real_of_const"}> ({
    %27 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "func.return"(%27) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "real_of_create_op"}> ({
    %26 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "func.return"(%26) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "imag_of_const"}> ({
    %25 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%25) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "imag_of_create_op"}> ({
    %24 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%24) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_add_sub_lhs"}> ({
    %23 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%23) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_add_sub_rhs"}> ({
    %22 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%22) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_neg_neg"}> ({
    %21 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%21) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_log_exp"}> ({
    %20 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%20) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_exp_log"}> ({
    %19 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%19) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_conj_conj"}> ({
    %18 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%18) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_add_zero"}> ({
    %17 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%17) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_sub_add_lhs"}> ({
    %16 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%16) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_sub_zero"}> ({
    %15 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%15) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "re_neg"}> ({
  ^bb0(%arg27: f32, %arg28: f32):
    %14 = "arith.negf"(%arg27) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%14) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "im_neg"}> ({
  ^bb0(%arg25: f32, %arg26: f32):
    %13 = "arith.negf"(%arg26) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%13) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, f16) -> complex<f16>, sym_name = "mul_one_f16"}> ({
  ^bb0(%arg23: f16, %arg24: f16):
    %12 = "complex.create"(%arg23, %arg24) : (f16, f16) -> complex<f16>
    "func.return"(%12) : (complex<f16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "mul_one_f32"}> ({
  ^bb0(%arg21: f32, %arg22: f32):
    %11 = "complex.create"(%arg21, %arg22) : (f32, f32) -> complex<f32>
    "func.return"(%11) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64, f64) -> complex<f64>, sym_name = "mul_one_f64"}> ({
  ^bb0(%arg19: f64, %arg20: f64):
    %10 = "complex.create"(%arg19, %arg20) : (f64, f64) -> complex<f64>
    "func.return"(%10) : (complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f80, f80) -> complex<f80>, sym_name = "mul_one_f80"}> ({
  ^bb0(%arg17: f80, %arg18: f80):
    %9 = "complex.create"(%arg17, %arg18) : (f80, f80) -> complex<f80>
    "func.return"(%9) : (complex<f80>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f128, f128) -> complex<f128>, sym_name = "mul_one_f128"}> ({
  ^bb0(%arg15: f128, %arg16: f128):
    %8 = "complex.create"(%arg15, %arg16) : (f128, f128) -> complex<f128>
    "func.return"(%8) : (complex<f128>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "fold_between_complex"}> ({
  ^bb0(%arg14: complex<f32>):
    "func.return"(%arg14) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "fold_between_i64"}> ({
  ^bb0(%arg13: i64):
    "func.return"(%arg13) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> i64, sym_name = "canon_arith_bitcast"}> ({
  ^bb0(%arg12: f64):
    %7 = "arith.bitcast"(%arg12) : (f64) -> i64
    "func.return"(%7) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> complex<f32>, sym_name = "double_bitcast"}> ({
  ^bb0(%arg11: f64):
    %6 = "complex.bitcast"(%arg11) : (f64) -> complex<f32>
    "func.return"(%6) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> f64, sym_name = "double_reverse_bitcast"}> ({
  ^bb0(%arg10: complex<f32>):
    %5 = "complex.bitcast"(%arg10) : (complex<f32>) -> f64
    "func.return"(%5) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, f16) -> complex<f16>, sym_name = "div_one_f16"}> ({
  ^bb0(%arg8: f16, %arg9: f16):
    %4 = "complex.create"(%arg8, %arg9) : (f16, f16) -> complex<f16>
    "func.return"(%4) : (complex<f16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "div_one_f32"}> ({
  ^bb0(%arg6: f32, %arg7: f32):
    %3 = "complex.create"(%arg6, %arg7) : (f32, f32) -> complex<f32>
    "func.return"(%3) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64, f64) -> complex<f64>, sym_name = "div_one_f64"}> ({
  ^bb0(%arg4: f64, %arg5: f64):
    %2 = "complex.create"(%arg4, %arg5) : (f64, f64) -> complex<f64>
    "func.return"(%2) : (complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f80, f80) -> complex<f80>, sym_name = "div_one_f80"}> ({
  ^bb0(%arg2: f80, %arg3: f80):
    %1 = "complex.create"(%arg2, %arg3) : (f80, f80) -> complex<f80>
    "func.return"(%1) : (complex<f80>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f128, f128) -> complex<f128>, sym_name = "div_one_f128"}> ({
  ^bb0(%arg0: f128, %arg1: f128):
    %0 = "complex.create"(%arg0, %arg1) : (f128, f128) -> complex<f128>
    "func.return"(%0) : (complex<f128>) -> ()
  }) : () -> ()
}) : () -> ()

