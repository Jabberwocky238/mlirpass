"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "ceil_fold"}> ({
    %126 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
    %127 = "math.ceil"(%126) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%127) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "ceil_fold2"}> ({
    %124 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %125 = "math.ceil"(%124) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%125) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log2_fold"}> ({
    %122 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %123 = "math.log2"(%122) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%123) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log2_fold2"}> ({
    %120 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %121 = "math.log2"(%120) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%121) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log2_nofold2"}> ({
    %118 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %119 = "math.log2"(%118) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%119) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "log2_fold_64"}> ({
    %116 = "arith.constant"() <{value = 4.000000e+00 : f64}> : () -> f64
    %117 = "math.log2"(%116) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%117) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "log2_fold2_64"}> ({
    %114 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %115 = "math.log2"(%114) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%115) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "log2_nofold2_64"}> ({
    %112 = "arith.constant"() <{value = -1.000000e+00 : f64}> : () -> f64
    %113 = "math.log2"(%112) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%113) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log2_fold_vec"}> ({
    %110 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %111 = "math.log2"(%110) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%111) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "powf_fold"}> ({
    %108 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %109 = "math.powf"(%108, %108) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%109) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "powf_fold_vec"}> ({
    %105 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %106 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %107 = "math.powf"(%105, %106) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%107) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "sqrt_fold"}> ({
    %103 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %104 = "math.sqrt"(%103) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%104) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "sqrt_fold_vec"}> ({
    %101 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %102 = "math.sqrt"(%101) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%102) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "abs_fold"}> ({
    %99 = "arith.constant"() <{value = -4.000000e+00 : f32}> : () -> f32
    %100 = "math.absf"(%99) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%100) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "copysign_fold"}> ({
    %96 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %97 = "arith.constant"() <{value = -9.000000e+00 : f32}> : () -> f32
    %98 = "math.copysign"(%96, %97) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%98) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "ctlz_fold1"}> ({
    %94 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %95 = "math.ctlz"(%94) : (i32) -> i32
    "func.return"(%95) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i8, sym_name = "ctlz_fold2"}> ({
    %92 = "arith.constant"() <{value = 1 : i8}> : () -> i8
    %93 = "math.ctlz"(%92) : (i8) -> i8
    "func.return"(%93) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "cttz_fold"}> ({
    %90 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %91 = "math.cttz"(%90) : (i32) -> i32
    "func.return"(%91) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "ctpop_fold"}> ({
    %88 = "arith.constant"() <{value = -16776961 : i32}> : () -> i32
    %89 = "math.ctpop"(%88) : (i32) -> i32
    "func.return"(%89) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log10_fold"}> ({
    %86 = "arith.constant"() <{value = 1.000000e+02 : f32}> : () -> f32
    %87 = "math.log10"(%86) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%87) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log10_fold_vec"}> ({
    %84 = "arith.constant"() <{value = dense<[1.000000e+00, 1.000000e+01, 1.000000e+02, 2.000000e+02]> : vector<4xf32>}> : () -> vector<4xf32>
    %85 = "math.log10"(%84) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%85) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log1p_fold"}> ({
    %82 = "arith.constant"() <{value = 1.700000e+01 : f32}> : () -> f32
    %83 = "math.log1p"(%82) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%83) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log1p_fold_vec"}> ({
    %80 = "arith.constant"() <{value = dense<[3.000000e+00, 5.000000e+00, 7.000000e+00, 1.100000e+01]> : vector<4xf32>}> : () -> vector<4xf32>
    %81 = "math.log1p"(%80) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%81) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log_fold"}> ({
    %78 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %79 = "math.log"(%78) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%79) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log_fold_vec"}> ({
    %76 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %77 = "math.log"(%76) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%77) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "exp_fold"}> ({
    %74 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %75 = "math.exp"(%74) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%75) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "exp_fold_vec"}> ({
    %72 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %73 = "math.exp"(%72) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%73) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "exp2_fold"}> ({
    %70 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %71 = "math.exp2"(%70) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%71) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "exp2_fold_vec"}> ({
    %68 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %69 = "math.exp2"(%68) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%69) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "expm1_fold"}> ({
    %66 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %67 = "math.expm1"(%66) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%67) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "expm1_fold_vec"}> ({
    %64 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %65 = "math.expm1"(%64) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%65) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "tan_fold"}> ({
    %62 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %63 = "math.tan"(%62) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%63) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "tan_fold_vec"}> ({
    %60 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %61 = "math.tan"(%60) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%61) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "tanh_fold"}> ({
    %58 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %59 = "math.tanh"(%58) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%59) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "tanh_fold_vec"}> ({
    %56 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %57 = "math.tanh"(%56) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%57) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "atan_fold"}> ({
    %54 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %55 = "math.atan"(%54) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%55) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "atan_fold_vec"}> ({
    %52 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %53 = "math.atan"(%52) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%53) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "atan2_fold"}> ({
    %49 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %50 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %51 = "math.atan2"(%49, %50) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%51) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "atan2_fold_vec"}> ({
    %46 = "arith.constant"() <{value = dense<[0.000000e+00, 0.000000e+00, 1.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %47 = "arith.constant"() <{value = dense<[1.000000e+00, 1.000000e+00, 2.000000e+00, 2.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %48 = "math.atan2"(%46, %47) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%48) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "cos_fold"}> ({
    %44 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %45 = "math.cos"(%44) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%45) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "cos_fold_vec"}> ({
    %42 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %43 = "math.cos"(%42) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%43) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "roundeven_fold"}> ({
    %40 = "arith.constant"() <{value = 1.500000e+00 : f32}> : () -> f32
    %41 = "math.roundeven"(%40) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%41) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "roundeven_fold_vec"}> ({
    %38 = "arith.constant"() <{value = dense<[5.000000e-01, -5.000000e-01, 1.500000e+00, -1.500000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %39 = "math.roundeven"(%38) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%39) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "round_fold"}> ({
    %36 = "arith.constant"() <{value = 1.500000e+00 : f32}> : () -> f32
    %37 = "math.round"(%36) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%37) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "round_fold_vec"}> ({
    %34 = "arith.constant"() <{value = dense<[5.000000e-01, -5.000000e-01, 1.500000e+00, -1.500000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %35 = "math.round"(%34) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%35) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "floor_fold"}> ({
    %32 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
    %33 = "math.floor"(%32) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%33) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "floor_fold2"}> ({
    %30 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %31 = "math.floor"(%30) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%31) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "trunc_fold"}> ({
    %28 = "arith.constant"() <{value = 1.100000e+00 : f32}> : () -> f32
    %29 = "math.trunc"(%28) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%29) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "trunc_fold_vec"}> ({
    %26 = "arith.constant"() <{value = dense<[5.000000e-01, -5.000000e-01, 1.500000e+00, -1.500000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %27 = "math.trunc"(%26) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%27) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "sin_fold"}> ({
    %24 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %25 = "math.sin"(%24) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%25) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "sin_fold_vec"}> ({
    %22 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %23 = "math.sin"(%22) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%23) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "erf_fold"}> ({
    %20 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %21 = "math.erf"(%20) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%21) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "erf_fold_vec"}> ({
    %18 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %19 = "math.erf"(%18) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%19) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "abs_poison"}> ({
    %16 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %17 = "math.absf"(%16) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%17) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isfinite_fold"}> ({
    %14 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %15 = "math.isfinite"(%14) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    "func.return"(%15) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isfinite_fold_vec"}> ({
    %12 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %13 = "math.isfinite"(%12) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    "func.return"(%13) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isinf_fold"}> ({
    %10 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %11 = "math.isinf"(%10) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    "func.return"(%11) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isinf_fold_vec"}> ({
    %8 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %9 = "math.isinf"(%8) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    "func.return"(%9) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isnan_fold"}> ({
    %6 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %7 = "math.isnan"(%6) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    "func.return"(%7) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isnan_fold_vec"}> ({
    %4 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %5 = "math.isnan"(%4) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    "func.return"(%5) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isnormal_fold"}> ({
    %2 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %3 = "math.isnormal"(%2) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    "func.return"(%3) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isnormal_fold_vec"}> ({
    %0 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "math.isnormal"(%0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    "func.return"(%1) : (vector<4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

