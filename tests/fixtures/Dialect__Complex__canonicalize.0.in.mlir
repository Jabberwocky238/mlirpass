"builtin.module"() ({
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "create_of_real_and_imag"}> ({
  ^bb0(%arg31: complex<f32>):
    %91 = "complex.re"(%arg31) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %92 = "complex.im"(%arg31) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %93 = "complex.create"(%91, %92) : (f32, f32) -> complex<f32>
    "func.return"(%93) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>, complex<f32>) -> complex<f32>, sym_name = "create_of_real_and_imag_different_operand"}> ({
  ^bb0(%arg29: complex<f32>, %arg30: complex<f32>):
    %88 = "complex.re"(%arg29) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %89 = "complex.im"(%arg30) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    %90 = "complex.create"(%88, %89) : (f32, f32) -> complex<f32>
    "func.return"(%90) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "real_of_const"}> ({
    %86 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %87 = "complex.re"(%86) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%87) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "real_of_create_op"}> ({
    %82 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %83 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %84 = "complex.create"(%82, %83) : (f32, f32) -> complex<f32>
    %85 = "complex.re"(%84) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%85) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "imag_of_const"}> ({
    %80 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %81 = "complex.im"(%80) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%81) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "imag_of_create_op"}> ({
    %76 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %77 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %78 = "complex.create"(%76, %77) : (f32, f32) -> complex<f32>
    %79 = "complex.im"(%78) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%79) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_add_sub_lhs"}> ({
    %72 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %73 = "complex.constant"() <{value = [0.000000e+00 : f32, 2.000000e+00 : f32]}> : () -> complex<f32>
    %74 = "complex.sub"(%72, %73) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %75 = "complex.add"(%74, %73) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%75) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_add_sub_rhs"}> ({
    %68 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %69 = "complex.constant"() <{value = [0.000000e+00 : f32, 2.000000e+00 : f32]}> : () -> complex<f32>
    %70 = "complex.sub"(%68, %69) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %71 = "complex.add"(%69, %70) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%71) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_neg_neg"}> ({
    %65 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %66 = "complex.neg"(%65) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %67 = "complex.neg"(%66) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    "func.return"(%67) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_log_exp"}> ({
    %62 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %63 = "complex.exp"(%62) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %64 = "complex.log"(%63) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    "func.return"(%64) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_exp_log"}> ({
    %59 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %60 = "complex.log"(%59) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %61 = "complex.exp"(%60) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    "func.return"(%61) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_conj_conj"}> ({
    %56 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %57 = "complex.conj"(%56) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %58 = "complex.conj"(%57) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    "func.return"(%58) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_add_zero"}> ({
    %53 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %54 = "complex.constant"() <{value = [0.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %55 = "complex.add"(%53, %54) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%55) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_sub_add_lhs"}> ({
    %49 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %50 = "complex.constant"() <{value = [0.000000e+00 : f32, 2.000000e+00 : f32]}> : () -> complex<f32>
    %51 = "complex.add"(%49, %50) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    %52 = "complex.sub"(%51, %50) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%52) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> complex<f32>, sym_name = "complex_sub_zero"}> ({
    %46 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %47 = "complex.constant"() <{value = [0.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %48 = "complex.sub"(%46, %47) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%48) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "re_neg"}> ({
  ^bb0(%arg27: f32, %arg28: f32):
    %43 = "complex.create"(%arg27, %arg28) : (f32, f32) -> complex<f32>
    %44 = "complex.neg"(%43) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %45 = "complex.re"(%44) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%45) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "im_neg"}> ({
  ^bb0(%arg25: f32, %arg26: f32):
    %40 = "complex.create"(%arg25, %arg26) : (f32, f32) -> complex<f32>
    %41 = "complex.neg"(%40) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> complex<f32>
    %42 = "complex.im"(%41) <{fastmath = #arith.fastmath<none>}> : (complex<f32>) -> f32
    "func.return"(%42) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, f16) -> complex<f16>, sym_name = "mul_one_f16"}> ({
  ^bb0(%arg23: f16, %arg24: f16):
    %37 = "complex.create"(%arg23, %arg24) : (f16, f16) -> complex<f16>
    %38 = "complex.constant"() <{value = [1.000000e+00 : f16, 0.000000e+00 : f16]}> : () -> complex<f16>
    %39 = "complex.mul"(%37, %38) <{fastmath = #arith.fastmath<none>}> : (complex<f16>, complex<f16>) -> complex<f16>
    "func.return"(%39) : (complex<f16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "mul_one_f32"}> ({
  ^bb0(%arg21: f32, %arg22: f32):
    %34 = "complex.create"(%arg21, %arg22) : (f32, f32) -> complex<f32>
    %35 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %36 = "complex.mul"(%34, %35) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%36) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64, f64) -> complex<f64>, sym_name = "mul_one_f64"}> ({
  ^bb0(%arg19: f64, %arg20: f64):
    %31 = "complex.create"(%arg19, %arg20) : (f64, f64) -> complex<f64>
    %32 = "complex.constant"() <{value = [1.000000e+00, 0.000000e+00]}> : () -> complex<f64>
    %33 = "complex.mul"(%31, %32) <{fastmath = #arith.fastmath<none>}> : (complex<f64>, complex<f64>) -> complex<f64>
    "func.return"(%33) : (complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f80, f80) -> complex<f80>, sym_name = "mul_one_f80"}> ({
  ^bb0(%arg17: f80, %arg18: f80):
    %28 = "complex.create"(%arg17, %arg18) : (f80, f80) -> complex<f80>
    %29 = "complex.constant"() <{value = [1.000000e+00 : f80, 0.000000e+00 : f80]}> : () -> complex<f80>
    %30 = "complex.mul"(%28, %29) <{fastmath = #arith.fastmath<none>}> : (complex<f80>, complex<f80>) -> complex<f80>
    "func.return"(%30) : (complex<f80>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f128, f128) -> complex<f128>, sym_name = "mul_one_f128"}> ({
  ^bb0(%arg15: f128, %arg16: f128):
    %25 = "complex.create"(%arg15, %arg16) : (f128, f128) -> complex<f128>
    %26 = "complex.constant"() <{value = [1.000000e+00 : f128, 0.000000e+00 : f128]}> : () -> complex<f128>
    %27 = "complex.mul"(%25, %26) <{fastmath = #arith.fastmath<none>}> : (complex<f128>, complex<f128>) -> complex<f128>
    "func.return"(%27) : (complex<f128>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> complex<f32>, sym_name = "fold_between_complex"}> ({
  ^bb0(%arg14: complex<f32>):
    %23 = "complex.bitcast"(%arg14) : (complex<f32>) -> i64
    %24 = "complex.bitcast"(%23) : (i64) -> complex<f32>
    "func.return"(%24) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "fold_between_i64"}> ({
  ^bb0(%arg13: i64):
    %21 = "complex.bitcast"(%arg13) : (i64) -> complex<f32>
    %22 = "complex.bitcast"(%21) : (complex<f32>) -> i64
    "func.return"(%22) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> i64, sym_name = "canon_arith_bitcast"}> ({
  ^bb0(%arg12: f64):
    %19 = "complex.bitcast"(%arg12) : (f64) -> complex<f32>
    %20 = "complex.bitcast"(%19) : (complex<f32>) -> i64
    "func.return"(%20) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64) -> complex<f32>, sym_name = "double_bitcast"}> ({
  ^bb0(%arg11: f64):
    %17 = "arith.bitcast"(%arg11) : (f64) -> i64
    %18 = "complex.bitcast"(%17) : (i64) -> complex<f32>
    "func.return"(%18) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (complex<f32>) -> f64, sym_name = "double_reverse_bitcast"}> ({
  ^bb0(%arg10: complex<f32>):
    %15 = "complex.bitcast"(%arg10) : (complex<f32>) -> i64
    %16 = "arith.bitcast"(%15) : (i64) -> f64
    "func.return"(%16) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, f16) -> complex<f16>, sym_name = "div_one_f16"}> ({
  ^bb0(%arg8: f16, %arg9: f16):
    %12 = "complex.create"(%arg8, %arg9) : (f16, f16) -> complex<f16>
    %13 = "complex.constant"() <{value = [1.000000e+00 : f16, 0.000000e+00 : f16]}> : () -> complex<f16>
    %14 = "complex.div"(%12, %13) <{fastmath = #arith.fastmath<none>}> : (complex<f16>, complex<f16>) -> complex<f16>
    "func.return"(%14) : (complex<f16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> complex<f32>, sym_name = "div_one_f32"}> ({
  ^bb0(%arg6: f32, %arg7: f32):
    %9 = "complex.create"(%arg6, %arg7) : (f32, f32) -> complex<f32>
    %10 = "complex.constant"() <{value = [1.000000e+00 : f32, 0.000000e+00 : f32]}> : () -> complex<f32>
    %11 = "complex.div"(%9, %10) <{fastmath = #arith.fastmath<none>}> : (complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%11) : (complex<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64, f64) -> complex<f64>, sym_name = "div_one_f64"}> ({
  ^bb0(%arg4: f64, %arg5: f64):
    %6 = "complex.create"(%arg4, %arg5) : (f64, f64) -> complex<f64>
    %7 = "complex.constant"() <{value = [1.000000e+00, 0.000000e+00]}> : () -> complex<f64>
    %8 = "complex.div"(%6, %7) <{fastmath = #arith.fastmath<none>}> : (complex<f64>, complex<f64>) -> complex<f64>
    "func.return"(%8) : (complex<f64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f80, f80) -> complex<f80>, sym_name = "div_one_f80"}> ({
  ^bb0(%arg2: f80, %arg3: f80):
    %3 = "complex.create"(%arg2, %arg3) : (f80, f80) -> complex<f80>
    %4 = "complex.constant"() <{value = [1.000000e+00 : f80, 0.000000e+00 : f80]}> : () -> complex<f80>
    %5 = "complex.div"(%3, %4) <{fastmath = #arith.fastmath<none>}> : (complex<f80>, complex<f80>) -> complex<f80>
    "func.return"(%5) : (complex<f80>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f128, f128) -> complex<f128>, sym_name = "div_one_f128"}> ({
  ^bb0(%arg0: f128, %arg1: f128):
    %0 = "complex.create"(%arg0, %arg1) : (f128, f128) -> complex<f128>
    %1 = "complex.constant"() <{value = [1.000000e+00 : f128, 0.000000e+00 : f128]}> : () -> complex<f128>
    %2 = "complex.div"(%0, %1) <{fastmath = #arith.fastmath<none>}> : (complex<f128>, complex<f128>) -> complex<f128>
    "func.return"(%2) : (complex<f128>) -> ()
  }) : () -> ()
}) : () -> ()

