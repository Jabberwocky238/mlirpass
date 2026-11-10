"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "ceil"}> ({
  ^bb0(%arg76: f32, %arg77: vector<3xf16>):
    %67 = "spirv.GL.Ceil"(%arg76) : (f32) -> f32
    %68 = "spirv.GL.Ceil"(%arg77) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "cos"}> ({
  ^bb0(%arg74: f32, %arg75: vector<3xf16>):
    %65 = "spirv.GL.Cos"(%arg74) : (f32) -> f32
    %66 = "spirv.GL.Cos"(%arg75) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "exp"}> ({
  ^bb0(%arg72: f32, %arg73: vector<3xf16>):
    %63 = "spirv.GL.Exp"(%arg72) : (f32) -> f32
    %64 = "spirv.GL.Exp"(%arg73) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "fabs"}> ({
  ^bb0(%arg70: f32, %arg71: vector<3xf16>):
    %61 = "spirv.GL.FAbs"(%arg70) : (f32) -> f32
    %62 = "spirv.GL.FAbs"(%arg71) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "floor"}> ({
  ^bb0(%arg68: f32, %arg69: vector<3xf16>):
    %59 = "spirv.GL.Floor"(%arg68) : (f32) -> f32
    %60 = "spirv.GL.Floor"(%arg69) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "fmax"}> ({
  ^bb0(%arg66: f32, %arg67: vector<3xf16>):
    %57 = "spirv.GL.FMax"(%arg66, %arg66) : (f32, f32) -> f32
    %58 = "spirv.GL.FMax"(%arg67, %arg67) : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "fmin"}> ({
  ^bb0(%arg64: f32, %arg65: vector<3xf16>):
    %55 = "spirv.GL.FMin"(%arg64, %arg64) : (f32, f32) -> f32
    %56 = "spirv.GL.FMin"(%arg65, %arg65) : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32) -> (), sym_name = "fclamp"}> ({
  ^bb0(%arg61: f32, %arg62: f32, %arg63: f32):
    %54 = "spirv.GL.FClamp"(%arg61, %arg62, %arg63) : (f32, f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "nmax"}> ({
  ^bb0(%arg59: f32, %arg60: vector<3xf16>):
    %52 = "spirv.GL.NMax"(%arg59, %arg59) : (f32, f32) -> f32
    %53 = "spirv.GL.NMax"(%arg60, %arg60) : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "nmin"}> ({
  ^bb0(%arg57: f32, %arg58: vector<3xf16>):
    %50 = "spirv.GL.NMin"(%arg57, %arg57) : (f32, f32) -> f32
    %51 = "spirv.GL.NMin"(%arg58, %arg58) : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "log"}> ({
  ^bb0(%arg55: f32, %arg56: vector<3xf16>):
    %48 = "spirv.GL.Log"(%arg55) : (f32) -> f32
    %49 = "spirv.GL.Log"(%arg56) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "sin"}> ({
  ^bb0(%arg53: f32, %arg54: vector<3xf16>):
    %46 = "spirv.GL.Sin"(%arg53) : (f32) -> f32
    %47 = "spirv.GL.Sin"(%arg54) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "pow"}> ({
  ^bb0(%arg51: f32, %arg52: vector<3xf16>):
    %44 = "spirv.GL.Pow"(%arg51, %arg51) : (f32, f32) -> f32
    %45 = "spirv.GL.Pow"(%arg52, %arg52) : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "fma"}> ({
  ^bb0(%arg49: f32, %arg50: vector<3xf16>):
    %42 = "spirv.GL.Fma"(%arg49, %arg49, %arg49) : (f32, f32, f32) -> f32
    %43 = "spirv.GL.Fma"(%arg50, %arg50, %arg50) : (vector<3xf16>, vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, vector<3xi32>) -> (), sym_name = "sabs"}> ({
  ^bb0(%arg47: i16, %arg48: vector<3xi32>):
    %40 = "spirv.GL.SAbs"(%arg47) : (i16) -> i16
    %41 = "spirv.GL.SAbs"(%arg48) : (vector<3xi32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, vector<3xi32>) -> (), sym_name = "smax"}> ({
  ^bb0(%arg45: i16, %arg46: vector<3xi32>):
    %38 = "spirv.GL.SMax"(%arg45, %arg45) : (i16, i16) -> i16
    %39 = "spirv.GL.SMax"(%arg46, %arg46) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, vector<3xi32>) -> (), sym_name = "smin"}> ({
  ^bb0(%arg43: i16, %arg44: vector<3xi32>):
    %36 = "spirv.GL.SMin"(%arg43, %arg43) : (i16, i16) -> i16
    %37 = "spirv.GL.SMin"(%arg44, %arg44) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, vector<3xi32>) -> (), sym_name = "umax"}> ({
  ^bb0(%arg41: i16, %arg42: vector<3xi32>):
    %34 = "spirv.GL.UMax"(%arg41, %arg41) : (i16, i16) -> i16
    %35 = "spirv.GL.UMax"(%arg42, %arg42) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, vector<3xi32>) -> (), sym_name = "umin"}> ({
  ^bb0(%arg39: i16, %arg40: vector<3xi32>):
    %32 = "spirv.GL.UMin"(%arg39, %arg39) : (i16, i16) -> i16
    %33 = "spirv.GL.UMin"(%arg40, %arg40) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, i16, i16) -> (), sym_name = "sclamp"}> ({
  ^bb0(%arg36: i16, %arg37: i16, %arg38: i16):
    %31 = "spirv.GL.SClamp"(%arg36, %arg37, %arg38) : (i16, i16, i16) -> i16
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32, i32) -> (), sym_name = "uclamp"}> ({
  ^bb0(%arg33: i32, %arg34: i32, %arg35: i32):
    %30 = "spirv.GL.UClamp"(%arg33, %arg34, %arg35) : (i32, i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "sqrt"}> ({
  ^bb0(%arg31: f32, %arg32: vector<3xf16>):
    %28 = "spirv.GL.Sqrt"(%arg31) : (f32) -> f32
    %29 = "spirv.GL.Sqrt"(%arg32) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "tan"}> ({
  ^bb0(%arg30: f32):
    %27 = "spirv.GL.Tan"(%arg30) : (f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "tanh"}> ({
  ^bb0(%arg29: f32):
    %26 = "spirv.GL.Tanh"(%arg29) : (f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "exp2"}> ({
  ^bb0(%arg27: f32, %arg28: vector<3xf16>):
    %24 = "spirv.GL.Exp2"(%arg27) : (f32) -> f32
    %25 = "spirv.GL.Exp2"(%arg28) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "log2"}> ({
  ^bb0(%arg25: f32, %arg26: vector<3xf16>):
    %22 = "spirv.GL.Log2"(%arg25) : (f32) -> f32
    %23 = "spirv.GL.Log2"(%arg26) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "round"}> ({
  ^bb0(%arg23: f32, %arg24: vector<3xf16>):
    %20 = "spirv.GL.Round"(%arg23) : (f32) -> f32
    %21 = "spirv.GL.Round"(%arg24) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "round_even"}> ({
  ^bb0(%arg21: f32, %arg22: vector<3xf16>):
    %18 = "spirv.GL.RoundEven"(%arg21) : (f32) -> f32
    %19 = "spirv.GL.RoundEven"(%arg22) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "sinh"}> ({
  ^bb0(%arg19: f32, %arg20: vector<3xf16>):
    %16 = "spirv.GL.Sinh"(%arg19) : (f32) -> f32
    %17 = "spirv.GL.Sinh"(%arg20) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "cosh"}> ({
  ^bb0(%arg17: f32, %arg18: vector<3xf16>):
    %14 = "spirv.GL.Cosh"(%arg17) : (f32) -> f32
    %15 = "spirv.GL.Cosh"(%arg18) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "inverse_sqrt"}> ({
  ^bb0(%arg16: f32):
    %13 = "spirv.GL.InverseSqrt"(%arg16) : (f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf32>) -> (), sym_name = "radians"}> ({
  ^bb0(%arg14: f32, %arg15: vector<3xf32>):
    %11 = "spirv.GL.Radians"(%arg14) : (f32) -> f32
    %12 = "spirv.GL.Radians"(%arg15) : (vector<3xf32>) -> vector<3xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf32>) -> (), sym_name = "degrees"}> ({
  ^bb0(%arg12: f32, %arg13: vector<3xf32>):
    %9 = "spirv.GL.Degrees"(%arg12) : (f32) -> f32
    %10 = "spirv.GL.Degrees"(%arg13) : (vector<3xf32>) -> vector<3xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "trunc"}> ({
  ^bb0(%arg10: f32, %arg11: vector<3xf16>):
    %7 = "spirv.GL.Trunc"(%arg10) : (f32) -> f32
    %8 = "spirv.GL.Trunc"(%arg11) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "asin_acos_atan"}> ({
  ^bb0(%arg8: f32, %arg9: vector<3xf16>):
    %4 = "spirv.GL.Asin"(%arg8) : (f32) -> f32
    %5 = "spirv.GL.Acos"(%arg9) : (vector<3xf16>) -> vector<3xf16>
    %6 = "spirv.GL.Atan"(%arg8) : (f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf16>) -> (), sym_name = "fract"}> ({
  ^bb0(%arg6: f32, %arg7: vector<3xf16>):
    %2 = "spirv.GL.Fract"(%arg6) : (f32) -> f32
    %3 = "spirv.GL.Fract"(%arg7) : (vector<3xf16>) -> vector<3xf16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32) -> (), sym_name = "fmix_scalar"}> ({
  ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
    %1 = "spirv.GL.FMix"(%arg3, %arg4, %arg5) : (f32, f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> (), sym_name = "fmix_vector"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xf32>):
    %0 = "spirv.GL.FMix"(%arg0, %arg1, %arg2) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

