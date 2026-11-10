"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "func_0"}> ({
    %0 = "arith.constant"() <{value = 2.240000e+00 : f64}> : () -> f64
    %1 = "arith.truncf"(%0) : (f64) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

