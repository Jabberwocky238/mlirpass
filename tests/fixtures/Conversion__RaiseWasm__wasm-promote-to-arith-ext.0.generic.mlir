"builtin.module"() ({
  "func.func"() <{function_type = () -> f64, sym_name = "promote_f32_to_f64"}> ({
    %0 = "arith.constant"() <{value = 3.140000e+00 : f32}> : () -> f32
    %1 = "arith.extf"(%0) : (f32) -> f64
    "func.return"(%1) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

