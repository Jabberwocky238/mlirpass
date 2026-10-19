"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64, i32) -> (), sym_name = "fpowi32"}> ({
  ^bb0(%arg0: f64, %arg1: i32):
    %0 = "math.fpowi"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f64, i32) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64, i64) -> (), sym_name = "fpowi64"}> ({
  ^bb0(%arg0: f64, %arg1: i64):
    %0 = "math.fpowi"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f64, i64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x3xf32>, vector<2x3xi64>) -> (), sym_name = "fpowi64_vec"}> ({
  ^bb0(%arg0: vector<2x3xf32>, %arg1: vector<2x3xi64>):
    %0 = "math.fpowi"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<2x3xf32>, vector<2x3xi64>) -> vector<2x3xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

