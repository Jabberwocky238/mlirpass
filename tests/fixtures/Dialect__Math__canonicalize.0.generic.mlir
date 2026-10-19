"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "ceil_fold"}> ({
    %63 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "func.return"(%63) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "ceil_fold2"}> ({
    %62 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%62) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log2_fold"}> ({
    %61 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%61) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log2_fold2"}> ({
    %60 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    "func.return"(%60) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log2_nofold2"}> ({
    %58 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %59 = "math.log2"(%58) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%59) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "log2_fold_64"}> ({
    %57 = "arith.constant"() <{value = 2.000000e+00 : f64}> : () -> f64
    "func.return"(%57) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "log2_fold2_64"}> ({
    %56 = "arith.constant"() <{value = 0xFFF0000000000000 : f64}> : () -> f64
    "func.return"(%56) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "log2_nofold2_64"}> ({
    %54 = "arith.constant"() <{value = -1.000000e+00 : f64}> : () -> f64
    %55 = "math.log2"(%54) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%55) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log2_fold_vec"}> ({
    %53 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 1.58496249, 2.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%53) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "powf_fold"}> ({
    %52 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    "func.return"(%52) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "powf_fold_vec"}> ({
    %51 = "arith.constant"() <{value = dense<[1.000000e+00, 4.000000e+00, 9.000000e+00, 1.600000e+01]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%51) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "sqrt_fold"}> ({
    %50 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%50) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "sqrt_fold_vec"}> ({
    %49 = "arith.constant"() <{value = dense<[1.000000e+00, 1.41421354, 1.73205078, 2.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%49) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "abs_fold"}> ({
    %48 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    "func.return"(%48) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "copysign_fold"}> ({
    %47 = "arith.constant"() <{value = -4.000000e+00 : f32}> : () -> f32
    "func.return"(%47) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "ctlz_fold1"}> ({
    %46 = "arith.constant"() <{value = 31 : i32}> : () -> i32
    "func.return"(%46) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i8, sym_name = "ctlz_fold2"}> ({
    %45 = "arith.constant"() <{value = 7 : i8}> : () -> i8
    "func.return"(%45) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "cttz_fold"}> ({
    %44 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    "func.return"(%44) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "ctpop_fold"}> ({
    %43 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    "func.return"(%43) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log10_fold"}> ({
    %42 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%42) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log10_fold_vec"}> ({
    %41 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 2.000000e+00, 2.301030e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%41) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log1p_fold"}> ({
    %40 = "arith.constant"() <{value = 2.8903718 : f32}> : () -> f32
    "func.return"(%40) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log1p_fold_vec"}> ({
    %39 = "arith.constant"() <{value = dense<[1.38629436, 1.79175949, 2.07944155, 2.48490667]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%39) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log_fold"}> ({
    %38 = "arith.constant"() <{value = 0.693147182 : f32}> : () -> f32
    "func.return"(%38) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log_fold_vec"}> ({
    %37 = "arith.constant"() <{value = dense<[0.000000e+00, 0.693147182, 1.09861231, 1.38629436]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%37) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "exp_fold"}> ({
    %36 = "arith.constant"() <{value = 7.3890562 : f32}> : () -> f32
    "func.return"(%36) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "exp_fold_vec"}> ({
    %35 = "arith.constant"() <{value = dense<[2.71828175, 7.3890562, 20.085537, 54.5981483]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%35) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "exp2_fold"}> ({
    %34 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    "func.return"(%34) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "exp2_fold_vec"}> ({
    %33 = "arith.constant"() <{value = dense<[2.000000e+00, 4.000000e+00, 8.000000e+00, 1.600000e+01]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%33) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "expm1_fold"}> ({
    %32 = "arith.constant"() <{value = 6.3890562 : f32}> : () -> f32
    "func.return"(%32) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "expm1_fold_vec"}> ({
    %31 = "arith.constant"() <{value = dense<[0.000000e+00, 1.71828175, 0.000000e+00, 1.71828175]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%31) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "tan_fold"}> ({
    %30 = "arith.constant"() <{value = 1.55740774 : f32}> : () -> f32
    "func.return"(%30) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "tan_fold_vec"}> ({
    %29 = "arith.constant"() <{value = dense<[0.000000e+00, 1.55740774, 0.000000e+00, 1.55740774]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%29) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "tanh_fold"}> ({
    %28 = "arith.constant"() <{value = 0.761594176 : f32}> : () -> f32
    "func.return"(%28) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "tanh_fold_vec"}> ({
    %27 = "arith.constant"() <{value = dense<[0.000000e+00, 0.761594176, 0.000000e+00, 0.761594176]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%27) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "atan_fold"}> ({
    %26 = "arith.constant"() <{value = 0.785398185 : f32}> : () -> f32
    "func.return"(%26) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "atan_fold_vec"}> ({
    %25 = "arith.constant"() <{value = dense<[0.000000e+00, 0.785398185, 0.000000e+00, 0.785398185]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%25) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "atan2_fold"}> ({
    %24 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%24) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "atan2_fold_vec"}> ({
    %23 = "arith.constant"() <{value = dense<[0.000000e+00, 0.000000e+00, 0.463647604, 0.463647604]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%23) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "cos_fold"}> ({
    %22 = "arith.constant"() <{value = 0.540302277 : f32}> : () -> f32
    "func.return"(%22) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "cos_fold_vec"}> ({
    %21 = "arith.constant"() <{value = dense<[1.000000e+00, 0.540302277, 1.000000e+00, 0.540302277]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%21) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "roundeven_fold"}> ({
    %20 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%20) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "roundeven_fold_vec"}> ({
    %19 = "arith.constant"() <{value = dense<[0.000000e+00, -0.000000e+00, 2.000000e+00, -2.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%19) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "round_fold"}> ({
    %18 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%18) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "round_fold_vec"}> ({
    %17 = "arith.constant"() <{value = dense<[1.000000e+00, -1.000000e+00, 2.000000e+00, -2.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%17) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "floor_fold"}> ({
    %16 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%16) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "floor_fold2"}> ({
    %15 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%15) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "trunc_fold"}> ({
    %14 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "func.return"(%14) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "trunc_fold_vec"}> ({
    %13 = "arith.constant"() <{value = dense<[0.000000e+00, -0.000000e+00, 1.000000e+00, -1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%13) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "sin_fold"}> ({
    %12 = "arith.constant"() <{value = 0.841470957 : f32}> : () -> f32
    "func.return"(%12) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "sin_fold_vec"}> ({
    %11 = "arith.constant"() <{value = dense<[0.000000e+00, 0.841470957, 0.000000e+00, 0.841470957]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%11) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "erf_fold"}> ({
    %10 = "arith.constant"() <{value = 0.842700779 : f32}> : () -> f32
    "func.return"(%10) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "erf_fold_vec"}> ({
    %9 = "arith.constant"() <{value = dense<[0.000000e+00, 0.842700779, 0.000000e+00, 0.842700779]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%9) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "abs_poison"}> ({
    %8 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    "func.return"(%8) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isfinite_fold"}> ({
    %7 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%7) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isfinite_fold_vec"}> ({
    %6 = "arith.constant"() <{value = dense<true> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%6) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isinf_fold"}> ({
    %5 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%5) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isinf_fold_vec"}> ({
    %4 = "arith.constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%4) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isnan_fold"}> ({
    %3 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%3) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isnan_fold_vec"}> ({
    %2 = "arith.constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%2) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isnormal_fold"}> ({
    %1 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%1) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isnormal_fold_vec"}> ({
    %0 = "arith.constant"() <{value = dense<true> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%0) : (vector<4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

