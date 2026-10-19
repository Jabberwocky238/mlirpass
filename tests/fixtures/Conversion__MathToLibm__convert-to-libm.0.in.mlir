"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "absf_caller"}> ({
  ^bb0(%arg130: f32, %arg131: f64):
    %118 = "math.absf"(%arg130) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %119 = "math.absf"(%arg131) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%118, %119) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "absf_vec_caller"}> ({
  ^bb0(%arg128: vector<2xf32>, %arg129: vector<2xf64>):
    %116 = "math.absf"(%arg128) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %117 = "math.absf"(%arg129) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%116, %117) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "acos_caller"}> ({
  ^bb0(%arg126: f32, %arg127: f64):
    %114 = "math.acos"(%arg126) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %115 = "math.acos"(%arg127) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%114, %115) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "acos_vec_caller"}> ({
  ^bb0(%arg124: vector<2xf32>, %arg125: vector<2xf64>):
    %112 = "math.acos"(%arg124) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %113 = "math.acos"(%arg125) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%112, %113) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "acosh_caller"}> ({
  ^bb0(%arg122: f32, %arg123: f64):
    %110 = "math.acosh"(%arg122) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %111 = "math.acosh"(%arg123) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%110, %111) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "acosh_vec_caller"}> ({
  ^bb0(%arg120: vector<2xf32>, %arg121: vector<2xf64>):
    %108 = "math.acosh"(%arg120) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %109 = "math.acosh"(%arg121) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%108, %109) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "asin_caller"}> ({
  ^bb0(%arg118: f32, %arg119: f64):
    %106 = "math.asin"(%arg118) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %107 = "math.asin"(%arg119) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%106, %107) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "asin_vec_caller"}> ({
  ^bb0(%arg116: vector<2xf32>, %arg117: vector<2xf64>):
    %104 = "math.asin"(%arg116) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %105 = "math.asin"(%arg117) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%104, %105) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "asinh_caller"}> ({
  ^bb0(%arg114: f32, %arg115: f64):
    %102 = "math.asinh"(%arg114) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %103 = "math.asinh"(%arg115) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%102, %103) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "asinh_vec_caller"}> ({
  ^bb0(%arg112: vector<2xf32>, %arg113: vector<2xf64>):
    %100 = "math.asinh"(%arg112) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %101 = "math.asinh"(%arg113) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%100, %101) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64, f16, bf16) -> (f32, f64, f16, bf16), sym_name = "atan_caller"}> ({
  ^bb0(%arg108: f32, %arg109: f64, %arg110: f16, %arg111: bf16):
    %96 = "math.atan"(%arg108) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %97 = "math.atan"(%arg109) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    %98 = "math.atan"(%arg110) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %99 = "math.atan"(%arg111) <{fastmath = #arith.fastmath<none>}> : (bf16) -> bf16
    "func.return"(%96, %97, %98, %99) : (f32, f64, f16, bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "atan_vec_caller"}> ({
  ^bb0(%arg106: vector<2xf32>, %arg107: vector<2xf64>):
    %94 = "math.atan"(%arg106) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %95 = "math.atan"(%arg107) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%94, %95) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64, f16, bf16) -> (f32, f64, f16, bf16), sym_name = "atanh_caller"}> ({
  ^bb0(%arg102: f32, %arg103: f64, %arg104: f16, %arg105: bf16):
    %90 = "math.atanh"(%arg102) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %91 = "math.atanh"(%arg103) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    %92 = "math.atanh"(%arg104) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %93 = "math.atanh"(%arg105) <{fastmath = #arith.fastmath<none>}> : (bf16) -> bf16
    "func.return"(%90, %91, %92, %93) : (f32, f64, f16, bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "atanh_vec_caller"}> ({
  ^bb0(%arg100: vector<2xf32>, %arg101: vector<2xf64>):
    %88 = "math.atanh"(%arg100) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %89 = "math.atanh"(%arg101) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%88, %89) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "tanh_caller"}> ({
  ^bb0(%arg98: f32, %arg99: f64):
    %86 = "math.tanh"(%arg98) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %87 = "math.tanh"(%arg99) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%86, %87) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "cosh_caller"}> ({
  ^bb0(%arg96: f32, %arg97: f64):
    %84 = "math.cosh"(%arg96) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %85 = "math.cosh"(%arg97) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%84, %85) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "sinh_caller"}> ({
  ^bb0(%arg94: f32, %arg95: f64):
    %82 = "math.sinh"(%arg94) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %83 = "math.sinh"(%arg95) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%82, %83) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64, f16, bf16) -> (f32, f64, f16, bf16), sym_name = "atan2_caller"}> ({
  ^bb0(%arg90: f32, %arg91: f64, %arg92: f16, %arg93: bf16):
    %78 = "math.atan2"(%arg90, %arg90) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %79 = "math.atan2"(%arg91, %arg91) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    %80 = "math.atan2"(%arg92, %arg92) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    %81 = "math.atan2"(%arg93, %arg93) <{fastmath = #arith.fastmath<none>}> : (bf16, bf16) -> bf16
    "func.return"(%78, %79, %80, %81) : (f32, f64, f16, bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "erf_caller"}> ({
  ^bb0(%arg88: f32, %arg89: f64):
    %76 = "math.erf"(%arg88) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %77 = "math.erf"(%arg89) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%76, %77) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "erf_vec_caller"}> ({
  ^bb0(%arg86: vector<2xf32>, %arg87: vector<2xf64>):
    %74 = "math.erf"(%arg86) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %75 = "math.erf"(%arg87) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%74, %75) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "exp_caller"}> ({
  ^bb0(%arg84: f32, %arg85: f64):
    %72 = "math.exp"(%arg84) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %73 = "math.exp"(%arg85) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%72, %73) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "exp_vec_caller"}> ({
  ^bb0(%arg82: vector<2xf32>, %arg83: vector<2xf64>):
    %70 = "math.exp"(%arg82) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %71 = "math.exp"(%arg83) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%70, %71) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "exp2_caller"}> ({
  ^bb0(%arg80: f32, %arg81: f64):
    %68 = "math.exp2"(%arg80) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %69 = "math.exp2"(%arg81) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%68, %69) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "exp2_vec_caller"}> ({
  ^bb0(%arg78: vector<2xf32>, %arg79: vector<2xf64>):
    %66 = "math.exp2"(%arg78) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %67 = "math.exp2"(%arg79) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%66, %67) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "log_caller"}> ({
  ^bb0(%arg76: f32, %arg77: f64):
    %64 = "math.log"(%arg76) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %65 = "math.log"(%arg77) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%64, %65) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "log_vec_caller"}> ({
  ^bb0(%arg74: vector<2xf32>, %arg75: vector<2xf64>):
    %62 = "math.log"(%arg74) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %63 = "math.log"(%arg75) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%62, %63) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "log2_caller"}> ({
  ^bb0(%arg72: f32, %arg73: f64):
    %60 = "math.log2"(%arg72) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %61 = "math.log2"(%arg73) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%60, %61) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "log2_vec_caller"}> ({
  ^bb0(%arg70: vector<2xf32>, %arg71: vector<2xf64>):
    %58 = "math.log2"(%arg70) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %59 = "math.log2"(%arg71) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%58, %59) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "log10_caller"}> ({
  ^bb0(%arg68: f32, %arg69: f64):
    %56 = "math.log10"(%arg68) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %57 = "math.log10"(%arg69) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%56, %57) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "log10_vec_caller"}> ({
  ^bb0(%arg66: vector<2xf32>, %arg67: vector<2xf64>):
    %54 = "math.log10"(%arg66) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %55 = "math.log10"(%arg67) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%54, %55) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "expm1_caller"}> ({
  ^bb0(%arg64: f32, %arg65: f64):
    %52 = "math.expm1"(%arg64) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %53 = "math.expm1"(%arg65) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%52, %53) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "expm1_vec_caller"}> ({
  ^bb0(%arg62: vector<2xf32>, %arg63: vector<2xf64>):
    %50 = "math.expm1"(%arg62) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %51 = "math.expm1"(%arg63) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%50, %51) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2x2xf32>) -> vector<2x2xf32>, sym_name = "expm1_multidim_vec_caller"}> ({
  ^bb0(%arg61: vector<2x2xf32>):
    %49 = "math.expm1"(%arg61) <{fastmath = #arith.fastmath<none>}> : (vector<2x2xf32>) -> vector<2x2xf32>
    "func.return"(%49) : (vector<2x2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32, f64, f64, f64) -> (f32, f64), sym_name = "fma_caller"}> ({
  ^bb0(%arg55: f32, %arg56: f32, %arg57: f32, %arg58: f64, %arg59: f64, %arg60: f64):
    %47 = "math.fma"(%arg55, %arg56, %arg57) <{fastmath = #arith.fastmath<none>}> : (f32, f32, f32) -> f32
    %48 = "math.fma"(%arg58, %arg59, %arg60) <{fastmath = #arith.fastmath<none>}> : (f64, f64, f64) -> f64
    "func.return"(%47, %48) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>, vector<2xf32>, vector<2xf64>, vector<2xf64>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "fma_vec_caller"}> ({
  ^bb0(%arg49: vector<2xf32>, %arg50: vector<2xf32>, %arg51: vector<2xf32>, %arg52: vector<2xf64>, %arg53: vector<2xf64>, %arg54: vector<2xf64>):
    %45 = "math.fma"(%arg49, %arg50, %arg51) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %46 = "math.fma"(%arg52, %arg53, %arg54) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    "func.return"(%45, %46) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "round_caller"}> ({
  ^bb0(%arg47: f32, %arg48: f64):
    %43 = "math.round"(%arg47) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %44 = "math.round"(%arg48) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%43, %44) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "roundeven_caller"}> ({
  ^bb0(%arg45: f32, %arg46: f64):
    %41 = "math.roundeven"(%arg45) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %42 = "math.roundeven"(%arg46) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%41, %42) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "trunc_caller"}> ({
  ^bb0(%arg43: f32, %arg44: f64):
    %39 = "math.trunc"(%arg43) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %40 = "math.trunc"(%arg44) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%39, %40) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64, f16, bf16, vector<2xf32>) -> (f32, f64, f16, bf16, vector<2xf32>), sym_name = "cbrt_caller"}> ({
  ^bb0(%arg38: f32, %arg39: f64, %arg40: f16, %arg41: bf16, %arg42: vector<2xf32>):
    %34 = "math.cbrt"(%arg38) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %35 = "math.cbrt"(%arg39) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    %36 = "math.cbrt"(%arg40) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %37 = "math.cbrt"(%arg41) <{fastmath = #arith.fastmath<none>}> : (bf16) -> bf16
    %38 = "math.cbrt"(%arg42) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    "func.return"(%34, %35, %36, %37, %38) : (f32, f64, f16, bf16, vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "cos_caller"}> ({
  ^bb0(%arg36: f32, %arg37: f64):
    %32 = "math.cos"(%arg36) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %33 = "math.cos"(%arg37) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%32, %33) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "sin_caller"}> ({
  ^bb0(%arg34: f32, %arg35: f64):
    %30 = "math.sin"(%arg34) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %31 = "math.sin"(%arg35) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%30, %31) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "round_vec_caller"}> ({
  ^bb0(%arg32: vector<2xf32>, %arg33: vector<2xf64>):
    %28 = "math.round"(%arg32) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %29 = "math.round"(%arg33) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%28, %29) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "roundeven_vec_caller"}> ({
  ^bb0(%arg30: vector<2xf32>, %arg31: vector<2xf64>):
    %26 = "math.roundeven"(%arg30) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %27 = "math.roundeven"(%arg31) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%26, %27) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "trunc_vec_caller"}> ({
  ^bb0(%arg28: vector<2xf32>, %arg29: vector<2xf64>):
    %24 = "math.trunc"(%arg28) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %25 = "math.trunc"(%arg29) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%24, %25) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64, f16, bf16) -> (f32, f64, f16, bf16), sym_name = "tan_caller"}> ({
  ^bb0(%arg24: f32, %arg25: f64, %arg26: f16, %arg27: bf16):
    %20 = "math.tan"(%arg24) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %21 = "math.tan"(%arg25) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    %22 = "math.tan"(%arg26) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    %23 = "math.tan"(%arg27) <{fastmath = #arith.fastmath<none>}> : (bf16) -> bf16
    "func.return"(%20, %21, %22, %23) : (f32, f64, f16, bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "tan_vec_caller"}> ({
  ^bb0(%arg22: vector<2xf32>, %arg23: vector<2xf64>):
    %18 = "math.tan"(%arg22) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %19 = "math.tan"(%arg23) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%18, %19) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "log1p_caller"}> ({
  ^bb0(%arg20: f32, %arg21: f64):
    %16 = "math.log1p"(%arg20) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %17 = "math.log1p"(%arg21) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%16, %17) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "floor_caller"}> ({
  ^bb0(%arg18: f32, %arg19: f64):
    %14 = "math.floor"(%arg18) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %15 = "math.floor"(%arg19) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%14, %15) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "ceil_caller"}> ({
  ^bb0(%arg16: f32, %arg17: f64):
    %12 = "math.ceil"(%arg16) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %13 = "math.ceil"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%12, %13) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "sqrt_caller"}> ({
  ^bb0(%arg14: f32, %arg15: f64):
    %10 = "math.sqrt"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %11 = "math.sqrt"(%arg15) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%10, %11) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "sqrt_vec_caller"}> ({
  ^bb0(%arg12: vector<2xf32>, %arg13: vector<2xf64>):
    %8 = "math.sqrt"(%arg12) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %9 = "math.sqrt"(%arg13) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%8, %9) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (f32, f64), sym_name = "rsqrt_caller"}> ({
  ^bb0(%arg10: f32, %arg11: f64):
    %6 = "math.rsqrt"(%arg10) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %7 = "math.rsqrt"(%arg11) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%6, %7) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "rsqrt_vec_caller"}> ({
  ^bb0(%arg8: vector<2xf32>, %arg9: vector<2xf64>):
    %4 = "math.rsqrt"(%arg8) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>) -> vector<2xf32>
    %5 = "math.rsqrt"(%arg9) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>) -> vector<2xf64>
    "func.return"(%4, %5) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f64, f64) -> (f32, f64), sym_name = "powf_caller"}> ({
  ^bb0(%arg4: f32, %arg5: f32, %arg6: f64, %arg7: f64):
    %2 = "math.powf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %3 = "math.powf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"(%2, %3) : (f32, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf32>, vector<2xf64>, vector<2xf64>) -> (vector<2xf32>, vector<2xf64>), sym_name = "powf_vec_caller"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf64>, %arg3: vector<2xf64>):
    %0 = "math.powf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %1 = "math.powf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    "func.return"(%0, %1) : (vector<2xf32>, vector<2xf64>) -> ()
  }) : () -> ()
}) : () -> ()

