"builtin.module"() ({
  "wasmssa.func"() <{exported, functionType = () -> f64, sym_name = "func_0"}> ({
    %2 = "wasmssa.const"() <{value = -1.210000e+01 : f64}> : () -> f64
    %3 = "wasmssa.ceil"(%2) : (f64) -> f64
    "wasmssa.return"(%3) : (f64) -> ()
  }) : () -> ()
  "wasmssa.func"() <{exported, functionType = () -> f32, sym_name = "func_1"}> ({
    %0 = "wasmssa.const"() <{value = 1.618000e+00 : f32}> : () -> f32
    %1 = "wasmssa.ceil"(%0) : (f32) -> f32
    "wasmssa.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

