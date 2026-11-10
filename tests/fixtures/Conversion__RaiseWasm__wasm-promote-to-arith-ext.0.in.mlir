"builtin.module"() ({
  "wasmssa.func"() <{functionType = () -> f64, sym_name = "promote_f32_to_f64"}> ({
    %0 = "wasmssa.const"() <{value = 3.140000e+00 : f32}> : () -> f32
    %1 = "wasmssa.promote"(%0) : (f32) -> f64
    "wasmssa.return"(%1) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

