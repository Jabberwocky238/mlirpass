"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "create_of_real_and_imag"}> ({
  ^bb0(%arg25: complex<f32>):
    %106 = "complex.re"(%arg25) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %107 = "complex.im"(%arg25) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %108 = "complex.create"(%106, %107) : (f32, f32) -> complex<f32>
    "func.return"(%108) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "create_of_real_and_imag_different_operand"}> ({
  ^bb0(%arg23: complex<f32>, %arg24: complex<f32>):
    %103 = "complex.re"(%arg23) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %104 = "complex.im"(%arg24) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %105 = "complex.create"(%103, %104) : (f32, f32) -> complex<f32>
    "func.return"(%105) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "real_of_const"}> ({
    %101 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %102 = "complex.re"(%101) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%102) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "real_of_create_op"}> ({
    %97 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %98 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %99 = "complex.create"(%97, %98) : (f32, f32) -> complex<f32>
    %100 = "complex.re"(%99) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%100) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "imag_of_const"}> ({
    %95 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %96 = "complex.im"(%95) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%96) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "imag_of_create_op"}> ({
    %91 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %92 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %93 = "complex.create"(%91, %92) : (f32, f32) -> complex<f32>
    %94 = "complex.im"(%93) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%94) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_add_sub_lhs"}> ({
    %87 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %88 = "complex.constant"() <{value = [0.000000e+00 : f32, 2.000000e+00 : f32]}> : () -> complex<f32>
    %89 = "complex.sub"(%87, %88) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %90 = "complex.add"(%89, %88) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%90) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_add_sub_rhs"}> ({
    %83 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %84 = "complex.constant"() <{value = [0.000000e+00 : f32, 2.000000e+00 : f32]}> : () -> complex<f32>
    %85 = "complex.sub"(%83, %84) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %86 = "complex.add"(%84, %85) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%86) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_neg_neg"}> ({
    %80 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %81 = "complex.neg"(%80) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %82 = "complex.neg"(%81) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    "func.return"(%82) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_log_exp"}> ({
    %77 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %78 = "complex.exp"(%77) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %79 = "complex.log"(%78) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    "func.return"(%79) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_exp_log"}> ({
    %74 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %75 = "complex.log"(%74) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %76 = "complex.exp"(%75) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    "func.return"(%76) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_conj_conj"}> ({
    %71 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %72 = "complex.conj"(%71) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %73 = "complex.conj"(%72) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    "func.return"(%73) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_add_zero"}> ({
    %68 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %69 = "complex.constant"() <{value = [0.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %70 = "complex.add"(%68, %69) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%70) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_sub_add_lhs"}> ({
    %64 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %65 = "complex.constant"() <{value = [0.000000e+00 : f32, 2.000000e+00 : f32]}> : () -> complex<f32>
    %66 = "complex.add"(%64, %65) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %67 = "complex.sub"(%66, %65) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%67) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_sub_zero"}> ({
    %61 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %62 = "complex.constant"() <{value = [0.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %63 = "complex.sub"(%61, %62) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%63) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "re_neg"}> ({
  ^bb0(%arg21: f32, %arg22: f32):
    %58 = "complex.create"(%arg21, %arg22) : (f32, f32) -> complex<f32>
    %59 = "complex.neg"(%58) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %60 = "complex.re"(%59) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%60) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "im_neg"}> ({
  ^bb0(%arg19: f32, %arg20: f32):
    %55 = "complex.create"(%arg19, %arg20) : (f32, f32) -> complex<f32>
    %56 = "complex.neg"(%55) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %57 = "complex.im"(%56) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%57) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, f16) -> complex<f16>, sym_name = "mul_one_f16"}> ({
  ^bb0(%arg17: f16, %arg18: f16):
    %52 = "complex.create"(%arg17, %arg18) : (f16, f16) -> complex<f16>
    %53 = "complex.constant"() <{value = [1.000000e+00 : f16, 0.000000e+00 : f16]}> : () -> complex<f16>
    %54 = "complex.mul"(%52, %53) <{fastmath = #arith.fastmath<none>}> : (complex<f16>, complex<f16>) -> complex<f16>
    "func.return"(%54) : (complex<f16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "mul_one_f32"}> ({
  ^bb0(%arg15: f32, %arg16: f32):
    %49 = "complex.create"(%arg15, %arg16) : (f32, f32) -> complex<f32>
    %50 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %51 = "complex.mul"(%49, %50) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%51) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64, f64) -> complex<f64>, sym_name = "mul_one_f64"}> ({
  ^bb0(%arg13: f64, %arg14: f64):
    %46 = "complex.create"(%arg13, %arg14) : (f64, f64) -> complex<f64>
    %47 = "complex.constant"() <{value = [1.000000e+00, 0.000000e+00]}> : () -> complex<f64>
    %48 = "complex.mul"(%46, %47) <{fastmath = #arith.fastmath<none>}> : (complex<f64>, complex<f64>) -> complex<f64>
    "func.return"(%48) : (complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f80, f80) -> complex<f80>, sym_name = "mul_one_f80"}> ({
  ^bb0(%arg11: f80, %arg12: f80):
    %43 = "complex.create"(%arg11, %arg12) : (f80, f80) -> complex<f80>
    %44 = "complex.constant"() <{value = [1.000000e+00 : f80, 0.000000e+00 : f80]}> : () -> complex<f80>
    %45 = "complex.mul"(%43, %44) <{fastmath = #arith.fastmath<none>}> : (complex<f80>, complex<f80>) -> complex<f80>
    "func.return"(%45) : (complex<f80>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f128, f128) -> complex<f128>, sym_name = "mul_one_f128"}> ({
  ^bb0(%arg9: f128, %arg10: f128):
    %40 = "complex.create"(%arg9, %arg10) : (f128, f128) -> complex<f128>
    %41 = "complex.constant"() <{value = [1.000000e+00 : f128, 0.000000e+00 : f128]}> : () -> complex<f128>
    %42 = "complex.mul"(%40, %41) <{fastmath = #arith.fastmath<none>}> : (complex<f128>, complex<f128>) -> complex<f128>
    "func.return"(%42) : (complex<f128>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "fold_between_complex"}> ({
  ^bb0(%arg8: complex<f32>):
    %38 = "complex.bitcast"(%arg8) : (complex<f32>) -> i64
    %39 = "complex.bitcast"(%38) : (i64) -> complex<f32>
    "func.return"(%39) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "fold_between_i64"}> ({
  ^bb0(%arg7: i64):
    %36 = "complex.bitcast"(%arg7) : (i64) -> complex<f32>
    %37 = "complex.bitcast"(%36) : (complex<f32>) -> i64
    "func.return"(%37) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> i64, sym_name = "canon_arith_bitcast"}> ({
  ^bb0(%arg6: f64):
    %34 = "complex.bitcast"(%arg6) : (f64) -> complex<f32>
    %35 = "complex.bitcast"(%34) : (complex<f32>) -> i64
    "func.return"(%35) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> complex<f32>, sym_name = "double_bitcast"}> ({
  ^bb0(%arg5: f64):
    %32 = "arith.bitcast"(%arg5) : (f64) -> i64
    %33 = "complex.bitcast"(%32) : (i64) -> complex<f32>
    "func.return"(%33) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> f64, sym_name = "double_reverse_bitcast"}> ({
  ^bb0(%arg4: complex<f32>):
    %30 = "complex.bitcast"(%arg4) : (complex<f32>) -> i64
    %31 = "arith.bitcast"(%30) : (i64) -> f64
    "func.return"(%31) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f16>, sym_name = "div_one_f16"}> ({
    %27 = "complex.constant"() <{value = [1.000000e+00 : f16, 2.000000e+00 : f16]}> : () -> complex<f16>
    %28 = "complex.constant"() <{value = [1.000000e+00 : f16, 0.000000e+00 : f16]}> : () -> complex<f16>
    %29 = "complex.div"(%27, %28) <{fastmath = #arith.fastmath<none>}> : (complex<f16>, complex<f16>) -> complex<f16>
    "func.return"(%29) : (complex<f16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "div_one_f32"}> ({
    %24 = "complex.constant"() <{value = [1.000000e+00 : f32, 2.000000e+00 : f32]}> : () -> complex<f32>
    %25 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %26 = "complex.div"(%24, %25) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%26) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f64>, sym_name = "div_one_f64"}> ({
    %21 = "complex.constant"() <{value = [1.000000e+00, 2.000000e+00]}> : () -> complex<f64>
    %22 = "complex.constant"() <{value = [1.000000e+00, 0.000000e+00]}> : () -> complex<f64>
    %23 = "complex.div"(%21, %22) <{fastmath = #arith.fastmath<none>}> : (complex<f64>, complex<f64>) -> complex<f64>
    "func.return"(%23) : (complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f80>, sym_name = "div_one_f80"}> ({
    %18 = "complex.constant"() <{value = [1.000000e+00 : f80, 2.000000e+00 : f80]}> : () -> complex<f80>
    %19 = "complex.constant"() <{value = [1.000000e+00 : f80, 0.000000e+00 : f80]}> : () -> complex<f80>
    %20 = "complex.div"(%18, %19) <{fastmath = #arith.fastmath<none>}> : (complex<f80>, complex<f80>) -> complex<f80>
    "func.return"(%20) : (complex<f80>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f128>, sym_name = "div_one_f128"}> ({
    %15 = "complex.constant"() <{value = [1.000000e+00 : f128, 2.000000e+00 : f128]}> : () -> complex<f128>
    %16 = "complex.constant"() <{value = [1.000000e+00 : f128, 0.000000e+00 : f128]}> : () -> complex<f128>
    %17 = "complex.div"(%15, %16) <{fastmath = #arith.fastmath<none>}> : (complex<f128>, complex<f128>) -> complex<f128>
    "func.return"(%17) : (complex<f128>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "div_op_with_rhs_has_nan_real"}> ({
    %12 = "complex.constant"() <{value = [0x7FFFFFFF : f32, 1.000000e+00 : f32]}> : () -> complex<f32>
    %13 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %14 = "complex.div"(%12, %13) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%14) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "div_op_with_rhs_has_nan_imag"}> ({
    %9 = "complex.constant"() <{value = [1.000000e+00 : f32, 0x7FFFFFFF : f32]}> : () -> complex<f32>
    %10 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %11 = "complex.div"(%9, %10) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%11) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "div_op_with_rhs_has_nan_real_imag"}> ({
    %6 = "complex.constant"() <{value = [0x7FFFFFFF : f32, 0x7FFFFFFF : f32]}> : () -> complex<f32>
    %7 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %8 = "complex.div"(%6, %7) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%8) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "div_op_non_constant_lhs_with_fast_math"}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %3 = "complex.create"(%arg2, %arg3) : (f32, f32) -> complex<f32>
    %4 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %5 = "complex.div"(%3, %4) <{fastmath = #arith.fastmath<nnan>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%5) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "div_op_non_constant_lhs_without_fast_math"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "complex.create"(%arg0, %arg1) : (f32, f32) -> complex<f32>
    %1 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %2 = "complex.div"(%0, %1) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%2) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

