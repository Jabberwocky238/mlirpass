"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "absf"}> ({
  ^bb0(%arg28: f32, %arg29: f64):
    %24 = "emitc.call_opaque"(%arg28) <{callee = "fabsf"}> : (f32) -> f32
    %25 = "emitc.call_opaque"(%arg29) <{callee = "fabs"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "floor"}> ({
  ^bb0(%arg26: f32, %arg27: f64):
    %22 = "emitc.call_opaque"(%arg26) <{callee = "floorf"}> : (f32) -> f32
    %23 = "emitc.call_opaque"(%arg27) <{callee = "floor"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "sin"}> ({
  ^bb0(%arg24: f32, %arg25: f64):
    %20 = "emitc.call_opaque"(%arg24) <{callee = "sinf"}> : (f32) -> f32
    %21 = "emitc.call_opaque"(%arg25) <{callee = "sin"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "cos"}> ({
  ^bb0(%arg22: f32, %arg23: f64):
    %18 = "emitc.call_opaque"(%arg22) <{callee = "cosf"}> : (f32) -> f32
    %19 = "emitc.call_opaque"(%arg23) <{callee = "cos"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "asin"}> ({
  ^bb0(%arg20: f32, %arg21: f64):
    %16 = "emitc.call_opaque"(%arg20) <{callee = "asinf"}> : (f32) -> f32
    %17 = "emitc.call_opaque"(%arg21) <{callee = "asin"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "acos"}> ({
  ^bb0(%arg18: f32, %arg19: f64):
    %14 = "emitc.call_opaque"(%arg18) <{callee = "acosf"}> : (f32) -> f32
    %15 = "emitc.call_opaque"(%arg19) <{callee = "acos"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f64, f64) -> (), sym_name = "atan2"}> ({
  ^bb0(%arg14: f32, %arg15: f32, %arg16: f64, %arg17: f64):
    %12 = "emitc.call_opaque"(%arg14, %arg15) <{callee = "atan2f"}> : (f32, f32) -> f32
    %13 = "emitc.call_opaque"(%arg16, %arg17) <{callee = "atan2"}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "ceil"}> ({
  ^bb0(%arg12: f32, %arg13: f64):
    %10 = "emitc.call_opaque"(%arg12) <{callee = "ceilf"}> : (f32) -> f32
    %11 = "emitc.call_opaque"(%arg13) <{callee = "ceil"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "sqrt"}> ({
  ^bb0(%arg10: f32, %arg11: f64):
    %8 = "emitc.call_opaque"(%arg10) <{callee = "sqrtf"}> : (f32) -> f32
    %9 = "emitc.call_opaque"(%arg11) <{callee = "sqrt"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "exp"}> ({
  ^bb0(%arg8: f32, %arg9: f64):
    %6 = "emitc.call_opaque"(%arg8) <{callee = "expf"}> : (f32) -> f32
    %7 = "emitc.call_opaque"(%arg9) <{callee = "exp"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f64, f64) -> (), sym_name = "powf"}> ({
  ^bb0(%arg4: f32, %arg5: f32, %arg6: f64, %arg7: f64):
    %4 = "emitc.call_opaque"(%arg4, %arg5) <{callee = "powf"}> : (f32, f32) -> f32
    %5 = "emitc.call_opaque"(%arg6, %arg7) <{callee = "pow"}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "round"}> ({
  ^bb0(%arg2: f32, %arg3: f64):
    %2 = "emitc.call_opaque"(%arg2) <{callee = "roundf"}> : (f32) -> f32
    %3 = "emitc.call_opaque"(%arg3) <{callee = "round"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "roundeven"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "emitc.call_opaque"(%arg0) <{callee = "roundevenf"}> : (f32) -> f32
    %1 = "emitc.call_opaque"(%arg1) <{callee = "roundeven"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

