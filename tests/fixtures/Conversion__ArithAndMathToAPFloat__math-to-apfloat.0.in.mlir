"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "full_example"}> ({
    %0 = "arith.constant"() <{value = -1.375000e+00 : f8E4M3FN}> : () -> f8E4M3FN
    %1 = "math.absf"(%0) <{fastmath = #arith.fastmath<none>}> : (f8E4M3FN) -> f8E4M3FN
    %2 = "arith.constant"() <{value = 2.000000e+00 : f8E8M0FNU}> : () -> f8E8M0FNU
    %3 = "arith.constant"() <{value = 4.000000e+00 : f8E8M0FNU}> : () -> f8E8M0FNU
    %4 = "arith.constant"() <{value = 8.000000e+00 : f8E8M0FNU}> : () -> f8E8M0FNU
    %5 = "math.fma"(%3, %2, %4) <{fastmath = #arith.fastmath<none>}> : (f8E8M0FNU, f8E8M0FNU, f8E8M0FNU) -> f8E8M0FNU
    %6 = "math.isinf"(%0) <{fastmath = #arith.fastmath<none>}> : (f8E4M3FN) -> i1
    %7 = "math.isnan"(%0) <{fastmath = #arith.fastmath<none>}> : (f8E4M3FN) -> i1
    %8 = "math.isnormal"(%0) <{fastmath = #arith.fastmath<none>}> : (f8E4M3FN) -> i1
    %9 = "math.isfinite"(%0) <{fastmath = #arith.fastmath<none>}> : (f8E4M3FN) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

