"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "absf"}> ({
  ^bb0(%arg24: f32, %arg25: f64):
    %20 = "math.absf"(%arg24) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %21 = "math.absf"(%arg25) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "floor"}> ({
  ^bb0(%arg22: f32, %arg23: f64):
    %18 = "math.floor"(%arg22) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %19 = "math.floor"(%arg23) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "sin"}> ({
  ^bb0(%arg20: f32, %arg21: f64):
    %16 = "math.sin"(%arg20) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %17 = "math.sin"(%arg21) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "cos"}> ({
  ^bb0(%arg18: f32, %arg19: f64):
    %14 = "math.cos"(%arg18) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %15 = "math.cos"(%arg19) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "asin"}> ({
  ^bb0(%arg16: f32, %arg17: f64):
    %12 = "math.asin"(%arg16) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %13 = "math.asin"(%arg17) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "acos"}> ({
  ^bb0(%arg14: f32, %arg15: f64):
    %10 = "math.acos"(%arg14) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %11 = "math.acos"(%arg15) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f64, f64) -> (), sym_name = "atan2"}> ({
  ^bb0(%arg10: f32, %arg11: f32, %arg12: f64, %arg13: f64):
    %8 = "math.atan2"(%arg10, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %9 = "math.atan2"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "ceil"}> ({
  ^bb0(%arg8: f32, %arg9: f64):
    %6 = "math.ceil"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %7 = "math.ceil"(%arg9) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "exp"}> ({
  ^bb0(%arg6: f32, %arg7: f64):
    %4 = "math.exp"(%arg6) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %5 = "math.exp"(%arg7) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f64, f64) -> (), sym_name = "powf"}> ({
  ^bb0(%arg2: f32, %arg3: f32, %arg4: f64, %arg5: f64):
    %2 = "math.powf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %3 = "math.powf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "round"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.round"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.round"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

