"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "iadd_scalar"}> ({
  ^bb0(%arg48: i32, %arg49: i32):
    %25 = "spirv.IAdd"(%arg48, %arg49) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi64>, vector<4xi64>) -> (), sym_name = "iadd_vector"}> ({
  ^bb0(%arg46: vector<4xi64>, %arg47: vector<4xi64>):
    %24 = "spirv.IAdd"(%arg46, %arg47) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i8, i8) -> (), sym_name = "isub_scalar"}> ({
  ^bb0(%arg44: i8, %arg45: i8):
    %23 = "spirv.ISub"(%arg44, %arg45) : (i8, i8) -> i8
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi16>, vector<2xi16>) -> (), sym_name = "isub_vector"}> ({
  ^bb0(%arg42: vector<2xi16>, %arg43: vector<2xi16>):
    %22 = "spirv.ISub"(%arg42, %arg43) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "imul_scalar"}> ({
  ^bb0(%arg40: i32, %arg41: i32):
    %21 = "spirv.IMul"(%arg40, %arg41) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> (), sym_name = "imul_vector"}> ({
  ^bb0(%arg38: vector<3xi32>, %arg39: vector<3xi32>):
    %20 = "spirv.IMul"(%arg38, %arg39) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f16, f16) -> (), sym_name = "fadd_scalar"}> ({
  ^bb0(%arg36: f16, %arg37: f16):
    %19 = "spirv.FAdd"(%arg36, %arg37) : (f16, f16) -> f16
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "fadd_vector"}> ({
  ^bb0(%arg34: vector<4xf32>, %arg35: vector<4xf32>):
    %18 = "spirv.FAdd"(%arg34, %arg35) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "fsub_scalar"}> ({
  ^bb0(%arg32: f32, %arg33: f32):
    %17 = "spirv.FSub"(%arg32, %arg33) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>, vector<2xf32>) -> (), sym_name = "fsub_vector"}> ({
  ^bb0(%arg30: vector<2xf32>, %arg31: vector<2xf32>):
    %16 = "spirv.FSub"(%arg30, %arg31) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "fdiv_scalar"}> ({
  ^bb0(%arg28: f32, %arg29: f32):
    %15 = "spirv.FDiv"(%arg28, %arg29) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xf64>, vector<3xf64>) -> (), sym_name = "fdiv_vector"}> ({
  ^bb0(%arg26: vector<3xf64>, %arg27: vector<3xf64>):
    %14 = "spirv.FDiv"(%arg26, %arg27) : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "fmul_scalar"}> ({
  ^bb0(%arg24: f32, %arg25: f32):
    %13 = "spirv.FMul"(%arg24, %arg25) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>, vector<2xf32>) -> (), sym_name = "fmul_vector"}> ({
  ^bb0(%arg22: vector<2xf32>, %arg23: vector<2xf32>):
    %12 = "spirv.FMul"(%arg22, %arg23) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "frem_scalar"}> ({
  ^bb0(%arg20: f32, %arg21: f32):
    %11 = "spirv.FRem"(%arg20, %arg21) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xf64>, vector<3xf64>) -> (), sym_name = "frem_vector"}> ({
  ^bb0(%arg18: vector<3xf64>, %arg19: vector<3xf64>):
    %10 = "spirv.FRem"(%arg18, %arg19) : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64) -> (), sym_name = "fneg_scalar"}> ({
  ^bb0(%arg17: f64):
    %9 = "spirv.FNegate"(%arg17) : (f64) -> f64
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>) -> (), sym_name = "fneg_vector"}> ({
  ^bb0(%arg16: vector<2xf32>):
    %8 = "spirv.FNegate"(%arg16) : (vector<2xf32>) -> vector<2xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "udiv_scalar"}> ({
  ^bb0(%arg14: i32, %arg15: i32):
    %7 = "spirv.UDiv"(%arg14, %arg15) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi64>, vector<3xi64>) -> (), sym_name = "udiv_vector"}> ({
  ^bb0(%arg12: vector<3xi64>, %arg13: vector<3xi64>):
    %6 = "spirv.UDiv"(%arg12, %arg13) : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "umod_scalar"}> ({
  ^bb0(%arg10: i32, %arg11: i32):
    %5 = "spirv.UMod"(%arg10, %arg11) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi64>, vector<3xi64>) -> (), sym_name = "umod_vector"}> ({
  ^bb0(%arg8: vector<3xi64>, %arg9: vector<3xi64>):
    %4 = "spirv.UMod"(%arg8, %arg9) : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, i16) -> (), sym_name = "sdiv_scalar"}> ({
  ^bb0(%arg6: i16, %arg7: i16):
    %3 = "spirv.SDiv"(%arg6, %arg7) : (i16, i16) -> i16
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>, vector<2xi64>) -> (), sym_name = "sdiv_vector"}> ({
  ^bb0(%arg4: vector<2xi64>, %arg5: vector<2xi64>):
    %2 = "spirv.SDiv"(%arg4, %arg5) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "srem_scalar"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %1 = "spirv.SRem"(%arg2, %arg3) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "srem_vector"}> ({
  ^bb0(%arg0: vector<4xi32>, %arg1: vector<4xi32>):
    %0 = "spirv.SRem"(%arg0, %arg1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

