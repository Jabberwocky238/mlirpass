"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, i32) -> (), sym_name = "math"}> ({
  ^bb0(%arg33: f32, %arg34: f32, %arg35: i32):
    %34 = "spirv.GL.Exp"(%arg33) : (f32) -> f32
    %35 = "spirv.GL.Sqrt"(%arg33) : (f32) -> f32
    %36 = "spirv.GL.Cos"(%arg33) : (f32) -> f32
    %37 = "spirv.GL.Sin"(%arg33) : (f32) -> f32
    %38 = "spirv.GL.Tan"(%arg33) : (f32) -> f32
    %39 = "spirv.GL.Acos"(%arg33) : (f32) -> f32
    %40 = "spirv.GL.Asin"(%arg33) : (f32) -> f32
    %41 = "spirv.GL.Atan"(%arg33) : (f32) -> f32
    %42 = "spirv.GL.Atan2"(%arg33, %arg34) : (f32, f32) -> f32
    %43 = "spirv.GL.Sinh"(%arg33) : (f32) -> f32
    %44 = "spirv.GL.Cosh"(%arg33) : (f32) -> f32
    %45 = "spirv.GL.Pow"(%arg33, %arg34) : (f32, f32) -> f32
    %46 = "spirv.GL.Round"(%arg33) : (f32) -> f32
    %47 = "spirv.GL.Trunc"(%arg33) : (f32) -> f32
    %48 = "spirv.GL.FrexpStruct"(%arg33) : (f32) -> !spirv.struct<(f32, i32)>
    %49 = "spirv.GL.Ldexp"(%arg33, %arg35) : (f32, i32) -> f32
    %50 = "spirv.GL.FMix"(%arg33, %arg34, %arg33) : (f32, f32, f32) -> f32
    %51 = "spirv.GL.Fract"(%arg33) : (f32) -> f32
    %52 = "spirv.GL.Asinh"(%arg33) : (f32) -> f32
    %53 = "spirv.GL.Acosh"(%arg33) : (f32) -> f32
    %54 = "spirv.GL.Atanh"(%arg33) : (f32) -> f32
    %55 = "spirv.GL.Log2"(%arg33) : (f32) -> f32
    %56 = "spirv.GL.Tanh"(%arg33) : (f32) -> f32
    %57 = "spirv.GL.Exp2"(%arg33) : (f32) -> f32
    %58 = "spirv.GL.Radians"(%arg33) : (f32) -> f32
    %59 = "spirv.GL.Degrees"(%arg33) : (f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, i32, i32) -> (), sym_name = "maxmin"}> ({
  ^bb0(%arg29: f32, %arg30: f32, %arg31: i32, %arg32: i32):
    %26 = "spirv.GL.FMax"(%arg29, %arg30) : (f32, f32) -> f32
    %27 = "spirv.GL.SMax"(%arg31, %arg32) : (i32, i32) -> i32
    %28 = "spirv.GL.UMax"(%arg31, %arg32) : (i32, i32) -> i32
    %29 = "spirv.GL.FMin"(%arg29, %arg30) : (f32, f32) -> f32
    %30 = "spirv.GL.SMin"(%arg31, %arg32) : (i32, i32) -> i32
    %31 = "spirv.GL.UMin"(%arg31, %arg32) : (i32, i32) -> i32
    %32 = "spirv.GL.NMax"(%arg29, %arg30) : (f32, f32) -> f32
    %33 = "spirv.GL.NMin"(%arg29, %arg30) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32) -> (), sym_name = "fclamp"}> ({
  ^bb0(%arg26: f32, %arg27: f32, %arg28: f32):
    %25 = "spirv.GL.FClamp"(%arg26, %arg27, %arg28) : (f32, f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32) -> (), sym_name = "nclamp"}> ({
  ^bb0(%arg23: f32, %arg24: f32, %arg25: f32):
    %24 = "spirv.GL.NClamp"(%arg23, %arg24, %arg25) : (f32, f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (ui32, ui32, ui32) -> (), sym_name = "uclamp"}> ({
  ^bb0(%arg20: ui32, %arg21: ui32, %arg22: ui32):
    %23 = "spirv.GL.UClamp"(%arg20, %arg21, %arg22) : (ui32, ui32, ui32) -> ui32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (si32, si32, si32) -> (), sym_name = "sclamp"}> ({
  ^bb0(%arg17: si32, %arg18: si32, %arg19: si32):
    %22 = "spirv.GL.SClamp"(%arg17, %arg18, %arg19) : (si32, si32, si32) -> si32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32) -> (), sym_name = "fma"}> ({
  ^bb0(%arg14: f32, %arg15: f32, %arg16: f32):
    %21 = "spirv.GL.Fma"(%arg14, %arg15, %arg16) : (f32, f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "findilsb"}> ({
  ^bb0(%arg13: i32):
    %20 = "spirv.GL.FindILsb"(%arg13) : (i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "findsmsb"}> ({
  ^bb0(%arg12: i32):
    %19 = "spirv.GL.FindSMsb"(%arg12) : (i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "findumsb"}> ({
  ^bb0(%arg11: i32):
    %18 = "spirv.GL.FindUMsb"(%arg11) : (i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf32>, vector<3xf32>, vector<3xi32>) -> (), sym_name = "vector"}> ({
  ^bb0(%arg7: f32, %arg8: vector<3xf32>, %arg9: vector<3xf32>, %arg10: vector<3xi32>):
    %6 = "spirv.GL.Cross"(%arg8, %arg9) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %7 = "spirv.GL.Normalize"(%arg7) : (f32) -> f32
    %8 = "spirv.GL.Normalize"(%arg8) : (vector<3xf32>) -> vector<3xf32>
    %9 = "spirv.GL.Reflect"(%arg7, %arg7) : (f32, f32) -> f32
    %10 = "spirv.GL.Reflect"(%arg8, %arg9) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %11 = "spirv.GL.Distance"(%arg7, %arg7) : (f32, f32) -> f32
    %12 = "spirv.GL.Distance"(%arg8, %arg9) : (vector<3xf32>, vector<3xf32>) -> f32
    %13 = "spirv.GL.FindILsb"(%arg10) : (vector<3xi32>) -> vector<3xi32>
    %14 = "spirv.GL.FindSMsb"(%arg10) : (vector<3xi32>) -> vector<3xi32>
    %15 = "spirv.GL.FindUMsb"(%arg10) : (vector<3xi32>) -> vector<3xi32>
    %16 = "spirv.GL.Length"(%arg7) : (f32) -> f32
    %17 = "spirv.GL.Length"(%arg8) : (vector<3xf32>) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "pack_half_2x16"}> ({
  ^bb0(%arg6: i32):
    %4 = "spirv.GL.UnpackHalf2x16"(%arg6) : (i32) -> vector<2xf32>
    %5 = "spirv.GL.PackHalf2x16"(%4) : (vector<2xf32>) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "pack_snorm_4x8"}> ({
  ^bb0(%arg5: i32):
    %2 = "spirv.GL.UnpackSnorm4x8"(%arg5) : (i32) -> vector<4xf32>
    %3 = "spirv.GL.PackSnorm4x8"(%2) : (vector<4xf32>) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "step"}> ({
  ^bb0(%arg3: f32, %arg4: f32):
    %1 = "spirv.GL.Step"(%arg3, %arg4) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32) -> (), sym_name = "smoothstep"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):
    %0 = "spirv.GL.SmoothStep"(%arg0, %arg1, %arg2) : (f32, f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

