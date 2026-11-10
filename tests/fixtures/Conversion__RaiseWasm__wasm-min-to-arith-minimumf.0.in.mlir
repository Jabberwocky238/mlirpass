"builtin.module"() ({
  "wasmssa.func"() <{exported, functionType = (f32, f32) -> f32, sym_name = "min_f32"}> ({
  ^bb0(%arg2: !wasmssa<local ref to f32>, %arg3: !wasmssa<local ref to f32>):
    %3 = "wasmssa.local_get"(%arg2) : (!wasmssa<local ref to f32>) -> f32
    %4 = "wasmssa.local_get"(%arg3) : (!wasmssa<local ref to f32>) -> f32
    %5 = "wasmssa.min"(%3, %4) : (f32, f32) -> f32
    "wasmssa.return"(%5) : (f32) -> ()
  }) : () -> ()
  "wasmssa.func"() <{exported, functionType = (f64, f64) -> f64, sym_name = "min_f64"}> ({
  ^bb0(%arg0: !wasmssa<local ref to f64>, %arg1: !wasmssa<local ref to f64>):
    %0 = "wasmssa.local_get"(%arg0) : (!wasmssa<local ref to f64>) -> f64
    %1 = "wasmssa.local_get"(%arg1) : (!wasmssa<local ref to f64>) -> f64
    %2 = "wasmssa.min"(%0, %1) : (f64, f64) -> f64
    "wasmssa.return"(%2) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

