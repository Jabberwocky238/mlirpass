"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_54"}> ({
    "func.func"() <{function_type = (f32, f32, f64, f64) -> (f32, f32, f64, f64), sym_name = "gpu_fminmax"}> ({
    ^bb0(%arg0: f32, %arg1: f32, %arg2: f64, %arg3: f64):
      %0 = "arith.maxnumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %1 = "arith.minnumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %2 = "arith.maxnumf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      %3 = "arith.minnumf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "func.return"(%0, %1, %2, %3) : (f32, f32, f64, f64) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

