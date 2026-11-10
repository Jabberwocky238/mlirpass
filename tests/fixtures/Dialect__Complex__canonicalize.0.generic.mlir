"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "create_of_real_and_imag"}> ({
  ^bb0(%arg25: complex<f32>):
    "func.return"(%arg25) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "create_of_real_and_imag_different_operand"}> ({
  ^bb0(%arg23: complex<f32>, %arg24: complex<f32>):
    %35 = "complex.re"(%arg23) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %36 = "complex.im"(%arg24) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %37 = "complex.create"(%35, %36) : (f32, f32) -> complex<f32>
    "func.return"(%37) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "real_of_const"}> ({
    %34 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "func.return"(%34) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "real_of_create_op"}> ({
    %33 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "func.return"(%33) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "imag_of_const"}> ({
    %32 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%32) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "imag_of_create_op"}> ({
    %31 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%31) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_add_sub_lhs"}> ({
    %30 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%30) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_add_sub_rhs"}> ({
    %29 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%29) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_neg_neg"}> ({
    %28 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%28) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_log_exp"}> ({
    %27 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%27) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_exp_log"}> ({
    %26 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%26) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_conj_conj"}> ({
    %25 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%25) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_add_zero"}> ({
    %24 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%24) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_sub_add_lhs"}> ({
    %23 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%23) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_sub_zero"}> ({
    %22 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%22) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "re_neg"}> ({
  ^bb0(%arg21: f32, %arg22: f32):
    %21 = "arith.negf"(%arg21) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%21) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "im_neg"}> ({
  ^bb0(%arg19: f32, %arg20: f32):
    %20 = "arith.negf"(%arg20) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%20) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, f16) -> complex<f16>, sym_name = "mul_one_f16"}> ({
  ^bb0(%arg17: f16, %arg18: f16):
    %19 = "complex.create"(%arg17, %arg18) : (f16, f16) -> complex<f16>
    "func.return"(%19) : (complex<f16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "mul_one_f32"}> ({
  ^bb0(%arg15: f32, %arg16: f32):
    %18 = "complex.create"(%arg15, %arg16) : (f32, f32) -> complex<f32>
    "func.return"(%18) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64, f64) -> complex<f64>, sym_name = "mul_one_f64"}> ({
  ^bb0(%arg13: f64, %arg14: f64):
    %17 = "complex.create"(%arg13, %arg14) : (f64, f64) -> complex<f64>
    "func.return"(%17) : (complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f80, f80) -> complex<f80>, sym_name = "mul_one_f80"}> ({
  ^bb0(%arg11: f80, %arg12: f80):
    %16 = "complex.create"(%arg11, %arg12) : (f80, f80) -> complex<f80>
    "func.return"(%16) : (complex<f80>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f128, f128) -> complex<f128>, sym_name = "mul_one_f128"}> ({
  ^bb0(%arg9: f128, %arg10: f128):
    %15 = "complex.create"(%arg9, %arg10) : (f128, f128) -> complex<f128>
    "func.return"(%15) : (complex<f128>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "fold_between_complex"}> ({
  ^bb0(%arg8: complex<f32>):
    "func.return"(%arg8) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "fold_between_i64"}> ({
  ^bb0(%arg7: i64):
    "func.return"(%arg7) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> i64, sym_name = "canon_arith_bitcast"}> ({
  ^bb0(%arg6: f64):
    %14 = "arith.bitcast"(%arg6) : (f64) -> i64
    "func.return"(%14) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> complex<f32>, sym_name = "double_bitcast"}> ({
  ^bb0(%arg5: f64):
    %13 = "complex.bitcast"(%arg5) : (f64) -> complex<f32>
    "func.return"(%13) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> f64, sym_name = "double_reverse_bitcast"}> ({
  ^bb0(%arg4: complex<f32>):
    %12 = "complex.bitcast"(%arg4) : (complex<f32>) -> f64
    "func.return"(%12) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f16>, sym_name = "div_one_f16"}> ({
    %11 = "complex.constant"() <{value = [1.000000e+00 : f16, 2.000000e+00 : f16]}> : () -> complex<f16>
    "func.return"(%11) : (complex<f16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "div_one_f32"}> ({
    %10 = "complex.constant"() <{value = [1.000000e+00 : f32, 2.000000e+00 : f32]}> : () -> complex<f32>
    "func.return"(%10) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f64>, sym_name = "div_one_f64"}> ({
    %9 = "complex.constant"() <{value = [1.000000e+00, 2.000000e+00]}> : () -> complex<f64>
    "func.return"(%9) : (complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f80>, sym_name = "div_one_f80"}> ({
    %8 = "complex.constant"() <{value = [1.000000e+00 : f80, 2.000000e+00 : f80]}> : () -> complex<f80>
    "func.return"(%8) : (complex<f80>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f128>, sym_name = "div_one_f128"}> ({
    %7 = "complex.constant"() <{value = [1.000000e+00 : f128, 2.000000e+00 : f128]}> : () -> complex<f128>
    "func.return"(%7) : (complex<f128>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "div_op_with_rhs_has_nan_real"}> ({
    %6 = "complex.constant"() <{value = [0x7FFFFFFF : f32, 0x7FFFFFFF : f32]}> : () -> complex<f32>
    "func.return"(%6) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "div_op_with_rhs_has_nan_imag"}> ({
    %5 = "complex.constant"() <{value = [0x7FFFFFFF : f32, 0x7FFFFFFF : f32]}> : () -> complex<f32>
    "func.return"(%5) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "div_op_with_rhs_has_nan_real_imag"}> ({
    %4 = "complex.constant"() <{value = [0x7FFFFFFF : f32, 0x7FFFFFFF : f32]}> : () -> complex<f32>
    "func.return"(%4) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "div_op_non_constant_lhs_with_fast_math"}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %3 = "complex.create"(%arg2, %arg3) : (f32, f32) -> complex<f32>
    "func.return"(%3) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "div_op_non_constant_lhs_without_fast_math"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %1 = "complex.create"(%arg0, %arg1) : (f32, f32) -> complex<f32>
    %2 = "complex.div"(%1, %0) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%2) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

