"builtin.module"() ({
  "wasmssa.func"() <{functionType = () -> f64, sym_name = "func_0"}> ({
    %2 = "wasmssa.const"() <{value = -1.210000e+01 : f64}> : () -> f64
    %3 = "wasmssa.floor"(%2) : (f64) -> f64
    "wasmssa.return"(%3) : (f64) -> ()
  }) : () -> ()
  "wasmssa.func"() <{functionType = () -> f32, sym_name = "func_1"}> ({
    %0 = "wasmssa.const"() <{value = 1.618000e+00 : f32}> : () -> f32
    %1 = "wasmssa.floor"(%0) : (f32) -> f32
    "wasmssa.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

