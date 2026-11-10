"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "ceil_fold"}> ({
    %86 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "func.return"(%86) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "ceil_fold2"}> ({
    %85 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%85) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log2_fold"}> ({
    %84 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%84) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log2_fold2"}> ({
    %83 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    "func.return"(%83) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log2_nofold2"}> ({
    %81 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %82 = "math.log2"(%81) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%82) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "log2_fold_64"}> ({
    %80 = "arith.constant"() <{value = 2.000000e+00 : f64}> : () -> f64
    "func.return"(%80) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "log2_fold2_64"}> ({
    %79 = "arith.constant"() <{value = 0xFFF0000000000000 : f64}> : () -> f64
    "func.return"(%79) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "log2_nofold2_64"}> ({
    %77 = "arith.constant"() <{value = -1.000000e+00 : f64}> : () -> f64
    %78 = "math.log2"(%77) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%78) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log2_fold_vec"}> ({
    %76 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 1.58496249, 2.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%76) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "powf_fold"}> ({
    %75 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    "func.return"(%75) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "powf_fold_vec"}> ({
    %74 = "arith.constant"() <{value = dense<[1.000000e+00, 4.000000e+00, 9.000000e+00, 1.600000e+01]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%74) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "rsqrt_fold"}> ({
    %73 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
    "func.return"(%73) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<2xf32>, sym_name = "rsqrt_fold_vec"}> ({
    %72 = "arith.constant"() <{value = dense<[1.000000e+00, 5.000000e-01]> : vector<2xf32>}> : () -> vector<2xf32>
    "func.return"(%72) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "rsqrt_poison"}> ({
    %71 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    "func.return"(%71) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "sqrt_fold"}> ({
    %70 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%70) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "sqrt_fold_vec"}> ({
    %69 = "arith.constant"() <{value = dense<[1.000000e+00, 1.41421354, 1.73205078, 2.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%69) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "abs_fold"}> ({
    %68 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    "func.return"(%68) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "copysign_fold"}> ({
    %67 = "arith.constant"() <{value = -4.000000e+00 : f32}> : () -> f32
    "func.return"(%67) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "ctlz_fold1"}> ({
    %66 = "arith.constant"() <{value = 31 : i32}> : () -> i32
    "func.return"(%66) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i8, sym_name = "ctlz_fold2"}> ({
    %65 = "arith.constant"() <{value = 7 : i8}> : () -> i8
    "func.return"(%65) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "cttz_fold"}> ({
    %64 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    "func.return"(%64) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "ctpop_fold"}> ({
    %63 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    "func.return"(%63) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log10_fold"}> ({
    %62 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%62) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log10_fold_vec"}> ({
    %61 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 2.000000e+00, 2.301030e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%61) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log1p_fold"}> ({
    %60 = "arith.constant"() <{value = 2.8903718 : f32}> : () -> f32
    "func.return"(%60) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log1p_fold_vec"}> ({
    %59 = "arith.constant"() <{value = dense<[1.38629436, 1.79175949, 2.07944155, 2.48490667]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%59) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log_fold"}> ({
    %58 = "arith.constant"() <{value = 0.693147182 : f32}> : () -> f32
    "func.return"(%58) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log_fold_vec"}> ({
    %57 = "arith.constant"() <{value = dense<[0.000000e+00, 0.693147182, 1.09861231, 1.38629436]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%57) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "exp_fold"}> ({
    %56 = "arith.constant"() <{value = 7.3890562 : f32}> : () -> f32
    "func.return"(%56) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "exp_fold_vec"}> ({
    %55 = "arith.constant"() <{value = dense<[2.71828175, 7.3890562, 20.085537, 54.5981483]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%55) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "exp2_fold"}> ({
    %54 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    "func.return"(%54) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "exp2_fold_vec"}> ({
    %53 = "arith.constant"() <{value = dense<[2.000000e+00, 4.000000e+00, 8.000000e+00, 1.600000e+01]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%53) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "expm1_fold"}> ({
    %52 = "arith.constant"() <{value = 6.3890562 : f32}> : () -> f32
    "func.return"(%52) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "expm1_fold_vec"}> ({
    %51 = "arith.constant"() <{value = dense<[0.000000e+00, 1.71828175, 0.000000e+00, 1.71828175]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%51) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "tan_fold"}> ({
    %50 = "arith.constant"() <{value = 1.55740774 : f32}> : () -> f32
    "func.return"(%50) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "tan_fold_vec"}> ({
    %49 = "arith.constant"() <{value = dense<[0.000000e+00, 1.55740774, 0.000000e+00, 1.55740774]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%49) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "tanh_fold"}> ({
    %48 = "arith.constant"() <{value = 0.761594176 : f32}> : () -> f32
    "func.return"(%48) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "tanh_fold_vec"}> ({
    %47 = "arith.constant"() <{value = dense<[0.000000e+00, 0.761594176, 0.000000e+00, 0.761594176]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%47) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "atan_fold"}> ({
    %46 = "arith.constant"() <{value = 0.785398185 : f32}> : () -> f32
    "func.return"(%46) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "atan_fold_vec"}> ({
    %45 = "arith.constant"() <{value = dense<[0.000000e+00, 0.785398185, 0.000000e+00, 0.785398185]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%45) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "atan2_fold"}> ({
    %44 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%44) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "atan2_fold_vec"}> ({
    %43 = "arith.constant"() <{value = dense<[0.000000e+00, 0.000000e+00, 0.463647604, 0.463647604]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%43) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "cos_fold"}> ({
    %42 = "arith.constant"() <{value = 0.540302277 : f32}> : () -> f32
    "func.return"(%42) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "cos_fold_vec"}> ({
    %41 = "arith.constant"() <{value = dense<[1.000000e+00, 0.540302277, 1.000000e+00, 0.540302277]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%41) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "roundeven_fold"}> ({
    %40 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%40) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "roundeven_fold_vec"}> ({
    %39 = "arith.constant"() <{value = dense<[0.000000e+00, -0.000000e+00, 2.000000e+00, -2.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%39) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "round_fold"}> ({
    %38 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%38) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "round_fold_vec"}> ({
    %37 = "arith.constant"() <{value = dense<[1.000000e+00, -1.000000e+00, 2.000000e+00, -2.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%37) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "floor_fold"}> ({
    %36 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%36) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "floor_fold2"}> ({
    %35 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%35) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "trunc_fold"}> ({
    %34 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "func.return"(%34) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "trunc_fold_vec"}> ({
    %33 = "arith.constant"() <{value = dense<[0.000000e+00, -0.000000e+00, 1.000000e+00, -1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%33) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "sin_fold"}> ({
    %32 = "arith.constant"() <{value = 0.841470957 : f32}> : () -> f32
    "func.return"(%32) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "sin_fold_vec"}> ({
    %31 = "arith.constant"() <{value = dense<[0.000000e+00, 0.841470957, 0.000000e+00, 0.841470957]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%31) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "erf_fold"}> ({
    %30 = "arith.constant"() <{value = 0.842700779 : f32}> : () -> f32
    "func.return"(%30) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "erf_fold_vec"}> ({
    %29 = "arith.constant"() <{value = dense<[0.000000e+00, 0.842700779, 0.000000e+00, 0.842700779]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%29) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "abs_poison"}> ({
    %28 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    "func.return"(%28) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isfinite_fold"}> ({
    %27 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%27) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isfinite_fold_vec"}> ({
    %26 = "arith.constant"() <{value = dense<true> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%26) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isinf_fold"}> ({
    %25 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%25) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isinf_fold_vec"}> ({
    %24 = "arith.constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%24) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isnan_fold"}> ({
    %23 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%23) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isnan_fold_vec"}> ({
    %22 = "arith.constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%22) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isnormal_fold"}> ({
    %21 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%21) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isnormal_fold_vec"}> ({
    %20 = "arith.constant"() <{value = dense<true> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%20) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "ipowi_i1_const_pos_exp"}> ({
    %17 = "arith.constant"() <{value = true}> : () -> i1
    %18 = "arith.constant"() <{value = false}> : () -> i1
    %19 = "math.ipowi"(%17, %18) : (i1, i1) -> i1
    "func.return"(%19) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "ipowi_i1_const_neg_exp"}> ({
    %15 = "arith.constant"() <{value = true}> : () -> i1
    %16 = "math.ipowi"(%15, %15) : (i1, i1) -> i1
    "func.return"(%16) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (f64, f32), sym_name = "fpowi_fold"}> ({
    %13 = "arith.constant"() <{value = 4.000000e+00 : f64}> : () -> f64
    %14 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    "func.return"(%13, %14) : (f64, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "fpowi_fold_vec"}> ({
    %12 = "arith.constant"() <{value = dense<[1.000000e+00, 1.600000e+01, 9.000000e+00, 1.600000e+01]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%12) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "fpowi_fold_failed"}> ({
    %9 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %10 = "arith.constant"() <{value = 16777217 : i32}> : () -> i32
    %11 = "math.fpowi"(%9, %10) <{fastmath = #arith.fastmath<none>}> : (f32, i32) -> f32
    "func.return"(%11) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (f32, f32), sym_name = "sincos_fold_f32"}> ({
    %7 = "arith.constant"() <{value = 0.841470957 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 0.540302277 : f32}> : () -> f32
    "func.return"(%7, %8) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (f64, f64), sym_name = "sincos_fold_f64"}> ({
    %5 = "arith.constant"() <{value = 0.8414709848078965 : f64}> : () -> f64
    %6 = "arith.constant"() <{value = 0.54030230586813977 : f64}> : () -> f64
    "func.return"(%5, %6) : (f64, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<4xf32>, vector<4xf32>), sym_name = "sincos_fold_vec"}> ({
    %3 = "arith.constant"() <{value = dense<[0.000000e+00, 0.841470957, 0.000000e+00, 0.841470957]> : vector<4xf32>}> : () -> vector<4xf32>
    %4 = "arith.constant"() <{value = dense<[1.000000e+00, 0.540302277, 1.000000e+00, 0.540302277]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%3, %4) : (vector<4xf32>, vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (f64, f32), sym_name = "cbrt_fold"}> ({
    %1 = "arith.constant"() <{value = 2.000000e+00 : f64}> : () -> f64
    %2 = "arith.constant"() <{value = -2.000000e+00 : f32}> : () -> f32
    "func.return"(%1, %2) : (f64, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "cbrt_fold_vec"}> ({
    %0 = "arith.constant"() <{value = dense<[-1.000000e+00, 0.000000e+00, 1.000000e+00, 2.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

