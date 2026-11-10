"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "absf"}> ({
  ^bb0(%arg28: f32, %arg29: f64):
    %24 = "math.absf"(%arg28) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %25 = "math.absf"(%arg29) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "floor"}> ({
  ^bb0(%arg26: f32, %arg27: f64):
    %22 = "math.floor"(%arg26) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %23 = "math.floor"(%arg27) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "sin"}> ({
  ^bb0(%arg24: f32, %arg25: f64):
    %20 = "math.sin"(%arg24) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %21 = "math.sin"(%arg25) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "cos"}> ({
  ^bb0(%arg22: f32, %arg23: f64):
    %18 = "math.cos"(%arg22) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %19 = "math.cos"(%arg23) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "asin"}> ({
  ^bb0(%arg20: f32, %arg21: f64):
    %16 = "math.asin"(%arg20) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %17 = "math.asin"(%arg21) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "acos"}> ({
  ^bb0(%arg18: f32, %arg19: f64):
    %14 = "math.acos"(%arg18) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %15 = "math.acos"(%arg19) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f64, f64) -> (), sym_name = "atan2"}> ({
  ^bb0(%arg14: f32, %arg15: f32, %arg16: f64, %arg17: f64):
    %12 = "math.atan2"(%arg14, %arg15) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %13 = "math.atan2"(%arg16, %arg17) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "ceil"}> ({
  ^bb0(%arg12: f32, %arg13: f64):
    %10 = "math.ceil"(%arg12) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %11 = "math.ceil"(%arg13) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "sqrt"}> ({
  ^bb0(%arg10: f32, %arg11: f64):
    %8 = "math.sqrt"(%arg10) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %9 = "math.sqrt"(%arg11) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "exp"}> ({
  ^bb0(%arg8: f32, %arg9: f64):
    %6 = "math.exp"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %7 = "math.exp"(%arg9) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f64, f64) -> (), sym_name = "powf"}> ({
  ^bb0(%arg4: f32, %arg5: f32, %arg6: f64, %arg7: f64):
    %4 = "math.powf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %5 = "math.powf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "round"}> ({
  ^bb0(%arg2: f32, %arg3: f64):
    %2 = "math.round"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %3 = "math.round"(%arg3) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "roundeven"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "math.roundeven"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "math.roundeven"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

