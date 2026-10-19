"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2x2xf32>) -> vector<2x2x2xf32>, sym_name = "vec_bin"}> ({
  ^bb0(%arg14: vector<2x2x2xf32>):
    %15 = "arith.addf"(%arg14, %arg14) <{fastmath = #arith.fastmath<none>}> : (vector<2x2x2xf32>, vector<2x2x2xf32>) -> vector<2x2x2xf32>
    "func.return"(%15) : (vector<2x2x2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi32>, vector<1x2x3xi64>) -> (), sym_name = "sexti_vector"}> ({
  ^bb0(%arg12: vector<1x2x3xi32>, %arg13: vector<1x2x3xi64>):
    %14 = "arith.extsi"(%arg12) : (vector<1x2x3xi32>) -> vector<1x2x3xi64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi32>, vector<1x2x3xi64>) -> (), sym_name = "zexti_vector"}> ({
  ^bb0(%arg10: vector<1x2x3xi32>, %arg11: vector<1x2x3xi64>):
    %13 = "arith.extui"(%arg10) : (vector<1x2x3xi32>) -> vector<1x2x3xi64>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi32>) -> vector<1x2x3xf32>, sym_name = "sitofp_vector"}> ({
  ^bb0(%arg9: vector<1x2x3xi32>):
    %12 = "arith.sitofp"(%arg9) : (vector<1x2x3xi32>) -> vector<1x2x3xf32>
    "func.return"(%12) : (vector<1x2x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi32>) -> vector<1x2x3xf32>, sym_name = "uitofp_vector"}> ({
  ^bb0(%arg8: vector<1x2x3xi32>):
    %11 = "arith.uitofp"(%arg8) : (vector<1x2x3xi32>) -> vector<1x2x3xf32>
    "func.return"(%11) : (vector<1x2x3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xf32>) -> vector<1x2x3xi32>, sym_name = "fptosi_vector"}> ({
  ^bb0(%arg7: vector<1x2x3xf32>):
    %10 = "arith.fptosi"(%arg7) : (vector<1x2x3xf32>) -> vector<1x2x3xi32>
    "func.return"(%10) : (vector<1x2x3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xf32>) -> vector<1x2x3xi32>, sym_name = "fptoui_vector"}> ({
  ^bb0(%arg6: vector<1x2x3xf32>):
    %9 = "arith.fptoui"(%arg6) : (vector<1x2x3xf32>) -> vector<1x2x3xi32>
    "func.return"(%9) : (vector<1x2x3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xf16>) -> vector<1x2x3xf64>, sym_name = "fpext_vector"}> ({
  ^bb0(%arg5: vector<1x2x3xf16>):
    %8 = "arith.extf"(%arg5) : (vector<1x2x3xf16>) -> vector<1x2x3xf64>
    "func.return"(%8) : (vector<1x2x3xf64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xf64>) -> vector<1x2x3xf16>, sym_name = "fptrunc_vector"}> ({
  ^bb0(%arg4: vector<1x2x3xf64>):
    %7 = "arith.truncf"(%arg4) : (vector<1x2x3xf64>) -> vector<1x2x3xf16>
    "func.return"(%7) : (vector<1x2x3xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi64>) -> vector<1x2x3xi16>, sym_name = "trunci_vector"}> ({
  ^bb0(%arg3: vector<1x2x3xi64>):
    %6 = "arith.trunci"(%arg3) <{overflowFlags = #arith.overflow<none>}> : (vector<1x2x3xi64>) -> vector<1x2x3xi16>
    "func.return"(%6) : (vector<1x2x3xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi64>) -> vector<1x2x3xi64>, sym_name = "shl_vector"}> ({
  ^bb0(%arg2: vector<1x2x3xi64>):
    %4 = "arith.constant"() <{value = dense<1> : vector<1x2x3xi64>}> : () -> vector<1x2x3xi64>
    %5 = "arith.shli"(%arg2, %4) <{overflowFlags = #arith.overflow<none>}> : (vector<1x2x3xi64>, vector<1x2x3xi64>) -> vector<1x2x3xi64>
    "func.return"(%5) : (vector<1x2x3xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi64>) -> vector<1x2x3xi64>, sym_name = "shrs_vector"}> ({
  ^bb0(%arg1: vector<1x2x3xi64>):
    %2 = "arith.constant"() <{value = dense<1> : vector<1x2x3xi64>}> : () -> vector<1x2x3xi64>
    %3 = "arith.shrsi"(%arg1, %2) : (vector<1x2x3xi64>, vector<1x2x3xi64>) -> vector<1x2x3xi64>
    "func.return"(%3) : (vector<1x2x3xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi64>) -> vector<1x2x3xi64>, sym_name = "shru_vector"}> ({
  ^bb0(%arg0: vector<1x2x3xi64>):
    %0 = "arith.constant"() <{value = dense<1> : vector<1x2x3xi64>}> : () -> vector<1x2x3xi64>
    %1 = "arith.shrui"(%arg0, %0) : (vector<1x2x3xi64>, vector<1x2x3xi64>) -> vector<1x2x3xi64>
    "func.return"(%1) : (vector<1x2x3xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x4xf32>) -> (), sym_name = "bitcast_2d"}> ({
  ^bb0(%arg0: vector<2x4xf32>):
    %0 = "arith.bitcast"(%arg0) : (vector<2x4xf32>) -> vector<2x4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xi1>, vector<4x3xi32>, vector<4x3xi32>) -> (), sym_name = "select_2d"}> ({
  ^bb0(%arg1: vector<4x3xi1>, %arg2: vector<4x3xi32>, %arg3: vector<4x3xi32>):
    %2 = "arith.select"(%arg1, %arg2, %arg3) : (vector<4x3xi1>, vector<4x3xi32>, vector<4x3xi32>) -> vector<4x3xi32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x2x3xi1>) -> (), sym_name = "index_cast_2d"}> ({
  ^bb0(%arg0: vector<1x2x3xi1>):
    %0 = "arith.index_cast"(%arg0) : (vector<1x2x3xi1>) -> vector<1x2x3xindex>
    %1 = "arith.index_cast"(%0) : (vector<1x2x3xindex>) -> vector<1x2x3xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

