"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage, BFloat16TypeKHR, BFloat16DotProductKHR], [SPV_KHR_bfloat16]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "fmul"}> ({
  ^bb0(%arg32: f32, %arg33: f32):
    %17 = "spirv.FMul"(%arg32, %arg33) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "fadd"}> ({
  ^bb0(%arg30: vector<4xf32>, %arg31: vector<4xf32>):
    %16 = "spirv.FAdd"(%arg30, %arg31) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "fdiv"}> ({
  ^bb0(%arg28: vector<4xf32>, %arg29: vector<4xf32>):
    %15 = "spirv.FDiv"(%arg28, %arg29) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "fmod"}> ({
  ^bb0(%arg26: vector<4xf32>, %arg27: vector<4xf32>):
    %14 = "spirv.FMod"(%arg26, %arg27) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>) -> (), sym_name = "fnegate"}> ({
  ^bb0(%arg25: vector<4xf32>):
    %13 = "spirv.FNegate"(%arg25) : (vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "fsub"}> ({
  ^bb0(%arg23: vector<4xf32>, %arg24: vector<4xf32>):
    %12 = "spirv.FSub"(%arg23, %arg24) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "frem"}> ({
  ^bb0(%arg21: vector<4xf32>, %arg22: vector<4xf32>):
    %11 = "spirv.FRem"(%arg21, %arg22) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "iadd"}> ({
  ^bb0(%arg19: vector<4xi32>, %arg20: vector<4xi32>):
    %10 = "spirv.IAdd"(%arg19, %arg20) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "isub"}> ({
  ^bb0(%arg17: vector<4xi32>, %arg18: vector<4xi32>):
    %9 = "spirv.ISub"(%arg17, %arg18) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "imul"}> ({
  ^bb0(%arg15: vector<4xi32>, %arg16: vector<4xi32>):
    %8 = "spirv.IMul"(%arg15, %arg16) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "udiv"}> ({
  ^bb0(%arg13: vector<4xi32>, %arg14: vector<4xi32>):
    %7 = "spirv.UDiv"(%arg13, %arg14) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "umod"}> ({
  ^bb0(%arg11: vector<4xi32>, %arg12: vector<4xi32>):
    %6 = "spirv.UMod"(%arg11, %arg12) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "sdiv"}> ({
  ^bb0(%arg9: vector<4xi32>, %arg10: vector<4xi32>):
    %5 = "spirv.SDiv"(%arg9, %arg10) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "smod"}> ({
  ^bb0(%arg7: vector<4xi32>, %arg8: vector<4xi32>):
    %4 = "spirv.SMod"(%arg7, %arg8) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>) -> (), sym_name = "snegate"}> ({
  ^bb0(%arg6: vector<4xi32>):
    %3 = "spirv.SNegate"(%arg6) : (vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "srem"}> ({
  ^bb0(%arg4: vector<4xi32>, %arg5: vector<4xi32>):
    %2 = "spirv.SRem"(%arg4, %arg5) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, f32) -> (), sym_name = "vector_times_scalar"}> ({
  ^bb0(%arg2: vector<4xf32>, %arg3: f32):
    %1 = "spirv.VectorTimesScalar"(%arg2, %arg3) : (vector<4xf32>, f32) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xbf16>, vector<4xbf16>) -> (), sym_name = "dot_bf16"}> ({
  ^bb0(%arg0: vector<4xbf16>, %arg1: vector<4xbf16>):
    %0 = "spirv.Dot"(%arg0, %arg1) : (vector<4xbf16>, vector<4xbf16>) -> bf16
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

