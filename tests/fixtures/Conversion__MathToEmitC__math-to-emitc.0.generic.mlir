"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "absf"}> ({
  ^bb0(%arg24: f32, %arg25: f64):
    %20 = "emitc.call_opaque"(%arg24) <{callee = "fabsf"}> : (f32) -> f32
    %21 = "emitc.call_opaque"(%arg25) <{callee = "fabs"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "floor"}> ({
  ^bb0(%arg22: f32, %arg23: f64):
    %18 = "emitc.call_opaque"(%arg22) <{callee = "floorf"}> : (f32) -> f32
    %19 = "emitc.call_opaque"(%arg23) <{callee = "floor"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "sin"}> ({
  ^bb0(%arg20: f32, %arg21: f64):
    %16 = "emitc.call_opaque"(%arg20) <{callee = "sinf"}> : (f32) -> f32
    %17 = "emitc.call_opaque"(%arg21) <{callee = "sin"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "cos"}> ({
  ^bb0(%arg18: f32, %arg19: f64):
    %14 = "emitc.call_opaque"(%arg18) <{callee = "cosf"}> : (f32) -> f32
    %15 = "emitc.call_opaque"(%arg19) <{callee = "cos"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "asin"}> ({
  ^bb0(%arg16: f32, %arg17: f64):
    %12 = "emitc.call_opaque"(%arg16) <{callee = "asinf"}> : (f32) -> f32
    %13 = "emitc.call_opaque"(%arg17) <{callee = "asin"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "acos"}> ({
  ^bb0(%arg14: f32, %arg15: f64):
    %10 = "emitc.call_opaque"(%arg14) <{callee = "acosf"}> : (f32) -> f32
    %11 = "emitc.call_opaque"(%arg15) <{callee = "acos"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f64, f64) -> (), sym_name = "atan2"}> ({
  ^bb0(%arg10: f32, %arg11: f32, %arg12: f64, %arg13: f64):
    %8 = "emitc.call_opaque"(%arg10, %arg11) <{callee = "atan2f"}> : (f32, f32) -> f32
    %9 = "emitc.call_opaque"(%arg12, %arg13) <{callee = "atan2"}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "ceil"}> ({
  ^bb0(%arg8: f32, %arg9: f64):
    %6 = "emitc.call_opaque"(%arg8) <{callee = "ceilf"}> : (f32) -> f32
    %7 = "emitc.call_opaque"(%arg9) <{callee = "ceil"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "exp"}> ({
  ^bb0(%arg6: f32, %arg7: f64):
    %4 = "emitc.call_opaque"(%arg6) <{callee = "expf"}> : (f32) -> f32
    %5 = "emitc.call_opaque"(%arg7) <{callee = "exp"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f64, f64) -> (), sym_name = "powf"}> ({
  ^bb0(%arg2: f32, %arg3: f32, %arg4: f64, %arg5: f64):
    %2 = "emitc.call_opaque"(%arg2, %arg3) <{callee = "powf"}> : (f32, f32) -> f32
    %3 = "emitc.call_opaque"(%arg4, %arg5) <{callee = "pow"}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "round"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "emitc.call_opaque"(%arg0) <{callee = "roundf"}> : (f32) -> f32
    %1 = "emitc.call_opaque"(%arg1) <{callee = "round"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

