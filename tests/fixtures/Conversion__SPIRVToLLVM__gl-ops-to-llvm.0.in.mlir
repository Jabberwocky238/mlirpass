"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "ceil"}> ({
  ^bb0(%arg25: f32, %arg26: vector<3xf16>):
    %25 = "spirv.GL.Ceil"(%arg25) : (f32) -> f32
    %26 = "spirv.GL.Ceil"(%arg26) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "cos"}> ({
  ^bb0(%arg23: f32, %arg24: vector<3xf16>):
    %23 = "spirv.GL.Cos"(%arg23) : (f32) -> f32
    %24 = "spirv.GL.Cos"(%arg24) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "exp"}> ({
  ^bb0(%arg21: f32, %arg22: vector<3xf16>):
    %21 = "spirv.GL.Exp"(%arg21) : (f32) -> f32
    %22 = "spirv.GL.Exp"(%arg22) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "fabs"}> ({
  ^bb0(%arg19: f32, %arg20: vector<3xf16>):
    %19 = "spirv.GL.FAbs"(%arg19) : (f32) -> f32
    %20 = "spirv.GL.FAbs"(%arg20) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "floor"}> ({
  ^bb0(%arg17: f32, %arg18: vector<3xf16>):
    %17 = "spirv.GL.Floor"(%arg17) : (f32) -> f32
    %18 = "spirv.GL.Floor"(%arg18) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "fmax"}> ({
  ^bb0(%arg15: f32, %arg16: vector<3xf16>):
    %15 = "spirv.GL.FMax"(%arg15, %arg15) : (f32, f32) -> f32
    %16 = "spirv.GL.FMax"(%arg16, %arg16) : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "fmin"}> ({
  ^bb0(%arg13: f32, %arg14: vector<3xf16>):
    %13 = "spirv.GL.FMin"(%arg13, %arg13) : (f32, f32) -> f32
    %14 = "spirv.GL.FMin"(%arg14, %arg14) : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "log"}> ({
  ^bb0(%arg11: f32, %arg12: vector<3xf16>):
    %11 = "spirv.GL.Log"(%arg11) : (f32) -> f32
    %12 = "spirv.GL.Log"(%arg12) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "sin"}> ({
  ^bb0(%arg9: f32, %arg10: vector<3xf16>):
    %9 = "spirv.GL.Sin"(%arg9) : (f32) -> f32
    %10 = "spirv.GL.Sin"(%arg10) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, vector<3xi32>) -> (), sym_name = "smax"}> ({
  ^bb0(%arg7: i16, %arg8: vector<3xi32>):
    %7 = "spirv.GL.SMax"(%arg7, %arg7) : (i16, i16) -> i16
    %8 = "spirv.GL.SMax"(%arg8, %arg8) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, vector<3xi32>) -> (), sym_name = "smin"}> ({
  ^bb0(%arg5: i16, %arg6: vector<3xi32>):
    %5 = "spirv.GL.SMin"(%arg5, %arg5) : (i16, i16) -> i16
    %6 = "spirv.GL.SMin"(%arg6, %arg6) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "sqrt"}> ({
  ^bb0(%arg3: f32, %arg4: vector<3xf16>):
    %3 = "spirv.GL.Sqrt"(%arg3) : (f32) -> f32
    %4 = "spirv.GL.Sqrt"(%arg4) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "tan"}> ({
  ^bb0(%arg2: f32):
    %2 = "spirv.GL.Tan"(%arg2) : (f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "tanh"}> ({
  ^bb0(%arg1: f32):
    %1 = "spirv.GL.Tanh"(%arg1) : (f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "inverse_sqrt"}> ({
  ^bb0(%arg0: f32):
    %0 = "spirv.GL.InverseSqrt"(%arg0) : (f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

