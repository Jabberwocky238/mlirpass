"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "ceil_fold"}> ({
    %161 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
    %162 = "math.ceil"(%161) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%162) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "ceil_fold2"}> ({
    %159 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %160 = "math.ceil"(%159) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%160) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log2_fold"}> ({
    %157 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %158 = "math.log2"(%157) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%158) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log2_fold2"}> ({
    %155 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %156 = "math.log2"(%155) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%156) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log2_nofold2"}> ({
    %153 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %154 = "math.log2"(%153) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%154) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "log2_fold_64"}> ({
    %151 = "arith.constant"() <{value = 4.000000e+00 : f64}> : () -> f64
    %152 = "math.log2"(%151) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%152) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "log2_fold2_64"}> ({
    %149 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %150 = "math.log2"(%149) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%150) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "log2_nofold2_64"}> ({
    %147 = "arith.constant"() <{value = -1.000000e+00 : f64}> : () -> f64
    %148 = "math.log2"(%147) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%148) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log2_fold_vec"}> ({
    %145 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %146 = "math.log2"(%145) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%146) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "powf_fold"}> ({
    %143 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %144 = "math.powf"(%143, %143) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%144) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "powf_fold_vec"}> ({
    %140 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %141 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %142 = "math.powf"(%140, %141) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%142) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "rsqrt_fold"}> ({
    %138 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %139 = "math.rsqrt"(%138) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%139) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<2xf32>, sym_name = "rsqrt_fold_vec"}> ({
    %136 = "arith.constant"() <{value = dense<[1.000000e+00, 4.000000e+00]> : vector<2xf32>}> : () -> vector<2xf32>
    %137 = "math.rsqrt"(%136) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    "func.return"(%137) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "rsqrt_poison"}> ({
    %134 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %135 = "math.rsqrt"(%134) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%135) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "sqrt_fold"}> ({
    %132 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %133 = "math.sqrt"(%132) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%133) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "sqrt_fold_vec"}> ({
    %130 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %131 = "math.sqrt"(%130) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%131) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "abs_fold"}> ({
    %128 = "arith.constant"() <{value = -4.000000e+00 : f32}> : () -> f32
    %129 = "math.absf"(%128) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%129) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "copysign_fold"}> ({
    %125 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %126 = "arith.constant"() <{value = -9.000000e+00 : f32}> : () -> f32
    %127 = "math.copysign"(%125, %126) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%127) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "ctlz_fold1"}> ({
    %123 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %124 = "math.ctlz"(%123) : (i32) -> i32
    "func.return"(%124) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i8, sym_name = "ctlz_fold2"}> ({
    %121 = "arith.constant"() <{value = 1 : i8}> : () -> i8
    %122 = "math.ctlz"(%121) : (i8) -> i8
    "func.return"(%122) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "cttz_fold"}> ({
    %119 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %120 = "math.cttz"(%119) : (i32) -> i32
    "func.return"(%120) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "ctpop_fold"}> ({
    %117 = "arith.constant"() <{value = -16776961 : i32}> : () -> i32
    %118 = "math.ctpop"(%117) : (i32) -> i32
    "func.return"(%118) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log10_fold"}> ({
    %115 = "arith.constant"() <{value = 1.000000e+02 : f32}> : () -> f32
    %116 = "math.log10"(%115) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%116) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log10_fold_vec"}> ({
    %113 = "arith.constant"() <{value = dense<[1.000000e+00, 1.000000e+01, 1.000000e+02, 2.000000e+02]> : vector<4xf32>}> : () -> vector<4xf32>
    %114 = "math.log10"(%113) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%114) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log1p_fold"}> ({
    %111 = "arith.constant"() <{value = 1.700000e+01 : f32}> : () -> f32
    %112 = "math.log1p"(%111) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%112) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log1p_fold_vec"}> ({
    %109 = "arith.constant"() <{value = dense<[3.000000e+00, 5.000000e+00, 7.000000e+00, 1.100000e+01]> : vector<4xf32>}> : () -> vector<4xf32>
    %110 = "math.log1p"(%109) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%110) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "log_fold"}> ({
    %107 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %108 = "math.log"(%107) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%108) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "log_fold_vec"}> ({
    %105 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %106 = "math.log"(%105) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%106) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "exp_fold"}> ({
    %103 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %104 = "math.exp"(%103) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%104) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "exp_fold_vec"}> ({
    %101 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %102 = "math.exp"(%101) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%102) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "exp2_fold"}> ({
    %99 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %100 = "math.exp2"(%99) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%100) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "exp2_fold_vec"}> ({
    %97 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %98 = "math.exp2"(%97) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%98) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "expm1_fold"}> ({
    %95 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %96 = "math.expm1"(%95) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%96) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "expm1_fold_vec"}> ({
    %93 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %94 = "math.expm1"(%93) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%94) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "tan_fold"}> ({
    %91 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %92 = "math.tan"(%91) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%92) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "tan_fold_vec"}> ({
    %89 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %90 = "math.tan"(%89) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%90) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "tanh_fold"}> ({
    %87 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %88 = "math.tanh"(%87) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%88) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "tanh_fold_vec"}> ({
    %85 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %86 = "math.tanh"(%85) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%86) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "atan_fold"}> ({
    %83 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %84 = "math.atan"(%83) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%84) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "atan_fold_vec"}> ({
    %81 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %82 = "math.atan"(%81) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%82) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "atan2_fold"}> ({
    %78 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %79 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %80 = "math.atan2"(%78, %79) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%80) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "atan2_fold_vec"}> ({
    %75 = "arith.constant"() <{value = dense<[0.000000e+00, 0.000000e+00, 1.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %76 = "arith.constant"() <{value = dense<[1.000000e+00, 1.000000e+00, 2.000000e+00, 2.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %77 = "math.atan2"(%75, %76) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%77) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "cos_fold"}> ({
    %73 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %74 = "math.cos"(%73) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%74) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "cos_fold_vec"}> ({
    %71 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %72 = "math.cos"(%71) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%72) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "roundeven_fold"}> ({
    %69 = "arith.constant"() <{value = 1.500000e+00 : f32}> : () -> f32
    %70 = "math.roundeven"(%69) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%70) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "roundeven_fold_vec"}> ({
    %67 = "arith.constant"() <{value = dense<[5.000000e-01, -5.000000e-01, 1.500000e+00, -1.500000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %68 = "math.roundeven"(%67) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%68) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "round_fold"}> ({
    %65 = "arith.constant"() <{value = 1.500000e+00 : f32}> : () -> f32
    %66 = "math.round"(%65) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%66) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "round_fold_vec"}> ({
    %63 = "arith.constant"() <{value = dense<[5.000000e-01, -5.000000e-01, 1.500000e+00, -1.500000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %64 = "math.round"(%63) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%64) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "floor_fold"}> ({
    %61 = "arith.constant"() <{value = 3.000000e-01 : f32}> : () -> f32
    %62 = "math.floor"(%61) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%62) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "floor_fold2"}> ({
    %59 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %60 = "math.floor"(%59) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%60) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "trunc_fold"}> ({
    %57 = "arith.constant"() <{value = 1.100000e+00 : f32}> : () -> f32
    %58 = "math.trunc"(%57) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%58) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "trunc_fold_vec"}> ({
    %55 = "arith.constant"() <{value = dense<[5.000000e-01, -5.000000e-01, 1.500000e+00, -1.500000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %56 = "math.trunc"(%55) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%56) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "sin_fold"}> ({
    %53 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %54 = "math.sin"(%53) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%54) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "sin_fold_vec"}> ({
    %51 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %52 = "math.sin"(%51) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%52) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "erf_fold"}> ({
    %49 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %50 = "math.erf"(%49) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%50) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "erf_fold_vec"}> ({
    %47 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %48 = "math.erf"(%47) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%48) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "abs_poison"}> ({
    %45 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %46 = "math.absf"(%45) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%46) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isfinite_fold"}> ({
    %43 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %44 = "math.isfinite"(%43) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    "func.return"(%44) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isfinite_fold_vec"}> ({
    %41 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %42 = "math.isfinite"(%41) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    "func.return"(%42) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isinf_fold"}> ({
    %39 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %40 = "math.isinf"(%39) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    "func.return"(%40) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isinf_fold_vec"}> ({
    %37 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %38 = "math.isinf"(%37) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    "func.return"(%38) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isnan_fold"}> ({
    %35 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %36 = "math.isnan"(%35) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    "func.return"(%36) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isnan_fold_vec"}> ({
    %33 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %34 = "math.isnan"(%33) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    "func.return"(%34) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "isnormal_fold"}> ({
    %31 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %32 = "math.isnormal"(%31) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    "func.return"(%32) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi1>, sym_name = "isnormal_fold_vec"}> ({
    %29 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %30 = "math.isnormal"(%29) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    "func.return"(%30) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "ipowi_i1_const_pos_exp"}> ({
    %26 = "arith.constant"() <{value = true}> : () -> i1
    %27 = "arith.constant"() <{value = false}> : () -> i1
    %28 = "math.ipowi"(%26, %27) : (i1, i1) -> i1
    "func.return"(%28) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "ipowi_i1_const_neg_exp"}> ({
    %23 = "arith.constant"() <{value = true}> : () -> i1
    %24 = "arith.constant"() <{value = true}> : () -> i1
    %25 = "math.ipowi"(%23, %24) : (i1, i1) -> i1
    "func.return"(%25) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (f64, f32), sym_name = "fpowi_fold"}> ({
    %18 = "arith.constant"() <{value = 2.000000e+00 : f64}> : () -> f64
    %19 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %20 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %21 = "math.fpowi"(%18, %20) <{fastmath = #arith.fastmath<none>}> : (f64, i32) -> f64
    %22 = "math.fpowi"(%19, %20) <{fastmath = #arith.fastmath<none>}> : (f32, i32) -> f32
    "func.return"(%21, %22) : (f64, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "fpowi_fold_vec"}> ({
    %15 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %16 = "arith.constant"() <{value = dense<[2, 4, 2, 2]> : vector<4xi32>}> : () -> vector<4xi32>
    %17 = "math.fpowi"(%15, %16) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xi32>) -> vector<4xf32>
    "func.return"(%17) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "fpowi_fold_failed"}> ({
    %12 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %13 = "arith.constant"() <{value = 16777217 : i32}> : () -> i32
    %14 = "math.fpowi"(%12, %13) <{fastmath = #arith.fastmath<none>}> : (f32, i32) -> f32
    "func.return"(%14) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (f32, f32), sym_name = "sincos_fold_f32"}> ({
    %10 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %11:2 = "math.sincos"(%10) <{fastmath = #arith.fastmath<none>}> : (f32) -> (f32, f32)
    "func.return"(%11#0, %11#1) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (f64, f64), sym_name = "sincos_fold_f64"}> ({
    %8 = "arith.constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    %9:2 = "math.sincos"(%8) <{fastmath = #arith.fastmath<none>}> : (f64) -> (f64, f64)
    "func.return"(%9#0, %9#1) : (f64, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<4xf32>, vector<4xf32>), sym_name = "sincos_fold_vec"}> ({
    %6 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00, 0.000000e+00, 1.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %7:2 = "math.sincos"(%6) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> (vector<4xf32>, vector<4xf32>)
    "func.return"(%7#0, %7#1) : (vector<4xf32>, vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (f64, f32), sym_name = "cbrt_fold"}> ({
    %2 = "arith.constant"() <{value = 8.000000e+00 : f64}> : () -> f64
    %3 = "arith.constant"() <{value = -8.000000e+00 : f32}> : () -> f32
    %4 = "math.cbrt"(%2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    %5 = "math.cbrt"(%3) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%4, %5) : (f64, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "cbrt_fold_vec"}> ({
    %0 = "arith.constant"() <{value = dense<[-1.000000e+00, 0.000000e+00, 1.000000e+00, 8.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "math.cbrt"(%0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

