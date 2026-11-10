"builtin.module"() ({
  "func.func"() <{function_type = () -> f64, sym_name = "func_4"}> ({
    %2 = "arith.constant"() <{value = -1.210000e+01 : f64}> : () -> f64
    %3 = "math.trunc"(%2) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"(%3) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "func_5"}> ({
    %0 = "arith.constant"() <{value = 1.618000e+00 : f32}> : () -> f32
    %1 = "math.trunc"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

