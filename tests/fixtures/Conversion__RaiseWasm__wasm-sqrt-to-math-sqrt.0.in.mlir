"builtin.module"() ({
  "wasmssa.func"() <{functionType = (f32) -> f32, sym_name = "sqrt_f32"}> ({
  ^bb0(%arg1: !wasmssa<local ref to f32>):
    %2 = "wasmssa.local_get"(%arg1) : (!wasmssa<local ref to f32>) -> f32
    %3 = "wasmssa.sqrt"(%2) : (f32) -> f32
    "wasmssa.return"(%3) : (f32) -> ()
  }) : () -> ()
  "wasmssa.func"() <{functionType = (f64) -> f64, sym_name = "sqrt_f64"}> ({
  ^bb0(%arg0: !wasmssa<local ref to f64>):
    %0 = "wasmssa.local_get"(%arg0) : (!wasmssa<local ref to f64>) -> f64
    %1 = "wasmssa.sqrt"(%0) : (f64) -> f64
    "wasmssa.return"(%1) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

