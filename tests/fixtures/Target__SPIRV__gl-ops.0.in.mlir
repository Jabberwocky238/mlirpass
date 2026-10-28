"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, i32) -> (), sym_name = "math"}> ({
  ^bb0(%arg25: f32, %arg26: f32, %arg27: i32):
    %29 = "spirv.GL.Exp"(%arg25) : (f32) -> f32
    %30 = "spirv.GL.Sqrt"(%arg25) : (f32) -> f32
    %31 = "spirv.GL.Cos"(%arg25) : (f32) -> f32
    %32 = "spirv.GL.Sin"(%arg25) : (f32) -> f32
    %33 = "spirv.GL.Tan"(%arg25) : (f32) -> f32
    %34 = "spirv.GL.Acos"(%arg25) : (f32) -> f32
    %35 = "spirv.GL.Asin"(%arg25) : (f32) -> f32
    %36 = "spirv.GL.Atan"(%arg25) : (f32) -> f32
    %37 = "spirv.GL.Sinh"(%arg25) : (f32) -> f32
    %38 = "spirv.GL.Cosh"(%arg25) : (f32) -> f32
    %39 = "spirv.GL.Pow"(%arg25, %arg26) : (f32, f32) -> f32
    %40 = "spirv.GL.Round"(%arg25) : (f32) -> f32
    %41 = "spirv.GL.FrexpStruct"(%arg25) : (f32) -> !spirv.struct<(f32, i32)>
    %42 = "spirv.GL.Ldexp"(%arg25, %arg27) : (f32, i32) -> f32
    %43 = "spirv.GL.FMix"(%arg25, %arg26, %arg25) : (f32, f32, f32) -> f32
    %44 = "spirv.GL.Fract"(%arg25) : (f32) -> f32
    %45 = "spirv.GL.Asinh"(%arg25) : (f32) -> f32
    %46 = "spirv.GL.Acosh"(%arg25) : (f32) -> f32
    %47 = "spirv.GL.Atanh"(%arg25) : (f32) -> f32
    %48 = "spirv.GL.Log2"(%arg25) : (f32) -> f32
    %49 = "spirv.GL.Tanh"(%arg25) : (f32) -> f32
    %50 = "spirv.GL.Exp2"(%arg25) : (f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, i32, i32) -> (), sym_name = "maxmin"}> ({
  ^bb0(%arg21: f32, %arg22: f32, %arg23: i32, %arg24: i32):
    %23 = "spirv.GL.FMax"(%arg21, %arg22) : (f32, f32) -> f32
    %24 = "spirv.GL.SMax"(%arg23, %arg24) : (i32, i32) -> i32
    %25 = "spirv.GL.UMax"(%arg23, %arg24) : (i32, i32) -> i32
    %26 = "spirv.GL.FMin"(%arg21, %arg22) : (f32, f32) -> f32
    %27 = "spirv.GL.SMin"(%arg23, %arg24) : (i32, i32) -> i32
    %28 = "spirv.GL.UMin"(%arg23, %arg24) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32) -> (), sym_name = "fclamp"}> ({
  ^bb0(%arg18: f32, %arg19: f32, %arg20: f32):
    %22 = "spirv.GL.FClamp"(%arg18, %arg19, %arg20) : (f32, f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (ui32, ui32, ui32) -> (), sym_name = "uclamp"}> ({
  ^bb0(%arg15: ui32, %arg16: ui32, %arg17: ui32):
    %21 = "spirv.GL.UClamp"(%arg15, %arg16, %arg17) : (ui32, ui32, ui32) -> ui32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (si32, si32, si32) -> (), sym_name = "sclamp"}> ({
  ^bb0(%arg12: si32, %arg13: si32, %arg14: si32):
    %20 = "spirv.GL.SClamp"(%arg12, %arg13, %arg14) : (si32, si32, si32) -> si32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32) -> (), sym_name = "fma"}> ({
  ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
    %19 = "spirv.GL.Fma"(%arg9, %arg10, %arg11) : (f32, f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "findilsb"}> ({
  ^bb0(%arg8: i32):
    %18 = "spirv.GL.FindILsb"(%arg8) : (i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "findsmsb"}> ({
  ^bb0(%arg7: i32):
    %17 = "spirv.GL.FindSMsb"(%arg7) : (i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "findumsb"}> ({
  ^bb0(%arg6: i32):
    %16 = "spirv.GL.FindUMsb"(%arg6) : (i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<3xf32>, vector<3xf32>, vector<3xi32>) -> (), sym_name = "vector"}> ({
  ^bb0(%arg2: f32, %arg3: vector<3xf32>, %arg4: vector<3xf32>, %arg5: vector<3xi32>):
    %4 = "spirv.GL.Cross"(%arg3, %arg4) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %5 = "spirv.GL.Normalize"(%arg2) : (f32) -> f32
    %6 = "spirv.GL.Normalize"(%arg3) : (vector<3xf32>) -> vector<3xf32>
    %7 = "spirv.GL.Reflect"(%arg2, %arg2) : (f32, f32) -> f32
    %8 = "spirv.GL.Reflect"(%arg3, %arg4) : (vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %9 = "spirv.GL.Distance"(%arg2, %arg2) : (f32, f32) -> f32
    %10 = "spirv.GL.Distance"(%arg3, %arg4) : (vector<3xf32>, vector<3xf32>) -> f32
    %11 = "spirv.GL.FindILsb"(%arg5) : (vector<3xi32>) -> vector<3xi32>
    %12 = "spirv.GL.FindSMsb"(%arg5) : (vector<3xi32>) -> vector<3xi32>
    %13 = "spirv.GL.FindUMsb"(%arg5) : (vector<3xi32>) -> vector<3xi32>
    %14 = "spirv.GL.Length"(%arg2) : (f32) -> f32
    %15 = "spirv.GL.Length"(%arg3) : (vector<3xf32>) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "pack_half_2x16"}> ({
  ^bb0(%arg1: i32):
    %2 = "spirv.GL.UnpackHalf2x16"(%arg1) : (i32) -> vector<2xf32>
    %3 = "spirv.GL.PackHalf2x16"(%2) : (vector<2xf32>) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "pack_snorm_4x8"}> ({
  ^bb0(%arg0: i32):
    %0 = "spirv.GL.UnpackSnorm4x8"(%arg0) : (i32) -> vector<4xf32>
    %1 = "spirv.GL.PackSnorm4x8"(%0) : (vector<4xf32>) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

