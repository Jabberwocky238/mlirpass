"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "absf"}> ({
  ^bb0(%arg24: f32, %arg25: f64):
    %20 = "emitc.call_opaque"(%arg24) <{callee = "std::fabs"}> : (f32) -> f32
    %21 = "emitc.call_opaque"(%arg25) <{callee = "std::fabs"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "floor"}> ({
  ^bb0(%arg22: f32, %arg23: f64):
    %18 = "emitc.call_opaque"(%arg22) <{callee = "std::floor"}> : (f32) -> f32
    %19 = "emitc.call_opaque"(%arg23) <{callee = "std::floor"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "sin"}> ({
  ^bb0(%arg20: f32, %arg21: f64):
    %16 = "emitc.call_opaque"(%arg20) <{callee = "std::sin"}> : (f32) -> f32
    %17 = "emitc.call_opaque"(%arg21) <{callee = "std::sin"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "cos"}> ({
  ^bb0(%arg18: f32, %arg19: f64):
    %14 = "emitc.call_opaque"(%arg18) <{callee = "std::cos"}> : (f32) -> f32
    %15 = "emitc.call_opaque"(%arg19) <{callee = "std::cos"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "asin"}> ({
  ^bb0(%arg16: f32, %arg17: f64):
    %12 = "emitc.call_opaque"(%arg16) <{callee = "std::asin"}> : (f32) -> f32
    %13 = "emitc.call_opaque"(%arg17) <{callee = "std::asin"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "acos"}> ({
  ^bb0(%arg14: f32, %arg15: f64):
    %10 = "emitc.call_opaque"(%arg14) <{callee = "std::acos"}> : (f32) -> f32
    %11 = "emitc.call_opaque"(%arg15) <{callee = "std::acos"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f64, f64) -> (), sym_name = "atan2"}> ({
  ^bb0(%arg10: f32, %arg11: f32, %arg12: f64, %arg13: f64):
    %8 = "emitc.call_opaque"(%arg10, %arg11) <{callee = "std::atan2"}> : (f32, f32) -> f32
    %9 = "emitc.call_opaque"(%arg12, %arg13) <{callee = "std::atan2"}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "ceil"}> ({
  ^bb0(%arg8: f32, %arg9: f64):
    %6 = "emitc.call_opaque"(%arg8) <{callee = "std::ceil"}> : (f32) -> f32
    %7 = "emitc.call_opaque"(%arg9) <{callee = "std::ceil"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "exp"}> ({
  ^bb0(%arg6: f32, %arg7: f64):
    %4 = "emitc.call_opaque"(%arg6) <{callee = "std::exp"}> : (f32) -> f32
    %5 = "emitc.call_opaque"(%arg7) <{callee = "std::exp"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f64, f64) -> (), sym_name = "powf"}> ({
  ^bb0(%arg2: f32, %arg3: f32, %arg4: f64, %arg5: f64):
    %2 = "emitc.call_opaque"(%arg2, %arg3) <{callee = "std::pow"}> : (f32, f32) -> f32
    %3 = "emitc.call_opaque"(%arg4, %arg5) <{callee = "std::pow"}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "round"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "emitc.call_opaque"(%arg0) <{callee = "std::round"}> : (f32) -> f32
    %1 = "emitc.call_opaque"(%arg1) <{callee = "std::round"}> : (f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

