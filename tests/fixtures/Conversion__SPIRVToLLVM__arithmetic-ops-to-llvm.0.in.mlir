"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "iadd_scalar"}> ({
  ^bb0(%arg50: i32, %arg51: i32):
    %27 = "spirv.IAdd"(%arg50, %arg51) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi64>, vector<4xi64>) -> (), sym_name = "iadd_vector"}> ({
  ^bb0(%arg48: vector<4xi64>, %arg49: vector<4xi64>):
    %26 = "spirv.IAdd"(%arg48, %arg49) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i8, i8) -> (), sym_name = "isub_scalar"}> ({
  ^bb0(%arg46: i8, %arg47: i8):
    %25 = "spirv.ISub"(%arg46, %arg47) : (i8, i8) -> i8
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi16>, vector<2xi16>) -> (), sym_name = "isub_vector"}> ({
  ^bb0(%arg44: vector<2xi16>, %arg45: vector<2xi16>):
    %24 = "spirv.ISub"(%arg44, %arg45) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "imul_scalar"}> ({
  ^bb0(%arg42: i32, %arg43: i32):
    %23 = "spirv.IMul"(%arg42, %arg43) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> (), sym_name = "imul_vector"}> ({
  ^bb0(%arg40: vector<3xi32>, %arg41: vector<3xi32>):
    %22 = "spirv.IMul"(%arg40, %arg41) : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f16, f16) -> (), sym_name = "fadd_scalar"}> ({
  ^bb0(%arg38: f16, %arg39: f16):
    %21 = "spirv.FAdd"(%arg38, %arg39) : (f16, f16) -> f16
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "fadd_vector"}> ({
  ^bb0(%arg36: vector<4xf32>, %arg37: vector<4xf32>):
    %20 = "spirv.FAdd"(%arg36, %arg37) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "fsub_scalar"}> ({
  ^bb0(%arg34: f32, %arg35: f32):
    %19 = "spirv.FSub"(%arg34, %arg35) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>, vector<2xf32>) -> (), sym_name = "fsub_vector"}> ({
  ^bb0(%arg32: vector<2xf32>, %arg33: vector<2xf32>):
    %18 = "spirv.FSub"(%arg32, %arg33) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "fdiv_scalar"}> ({
  ^bb0(%arg30: f32, %arg31: f32):
    %17 = "spirv.FDiv"(%arg30, %arg31) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xf64>, vector<3xf64>) -> (), sym_name = "fdiv_vector"}> ({
  ^bb0(%arg28: vector<3xf64>, %arg29: vector<3xf64>):
    %16 = "spirv.FDiv"(%arg28, %arg29) : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "fmul_scalar"}> ({
  ^bb0(%arg26: f32, %arg27: f32):
    %15 = "spirv.FMul"(%arg26, %arg27) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>, vector<2xf32>) -> (), sym_name = "fmul_vector"}> ({
  ^bb0(%arg24: vector<2xf32>, %arg25: vector<2xf32>):
    %14 = "spirv.FMul"(%arg24, %arg25) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "frem_scalar"}> ({
  ^bb0(%arg22: f32, %arg23: f32):
    %13 = "spirv.FRem"(%arg22, %arg23) : (f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xf64>, vector<3xf64>) -> (), sym_name = "frem_vector"}> ({
  ^bb0(%arg20: vector<3xf64>, %arg21: vector<3xf64>):
    %12 = "spirv.FRem"(%arg20, %arg21) : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64) -> (), sym_name = "fneg_scalar"}> ({
  ^bb0(%arg19: f64):
    %11 = "spirv.FNegate"(%arg19) : (f64) -> f64
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>) -> (), sym_name = "fneg_vector"}> ({
  ^bb0(%arg18: vector<2xf32>):
    %10 = "spirv.FNegate"(%arg18) : (vector<2xf32>) -> vector<2xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "udiv_scalar"}> ({
  ^bb0(%arg16: i32, %arg17: i32):
    %9 = "spirv.UDiv"(%arg16, %arg17) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi64>, vector<3xi64>) -> (), sym_name = "udiv_vector"}> ({
  ^bb0(%arg14: vector<3xi64>, %arg15: vector<3xi64>):
    %8 = "spirv.UDiv"(%arg14, %arg15) : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "umod_scalar"}> ({
  ^bb0(%arg12: i32, %arg13: i32):
    %7 = "spirv.UMod"(%arg12, %arg13) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi64>, vector<3xi64>) -> (), sym_name = "umod_vector"}> ({
  ^bb0(%arg10: vector<3xi64>, %arg11: vector<3xi64>):
    %6 = "spirv.UMod"(%arg10, %arg11) : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, i16) -> (), sym_name = "sdiv_scalar"}> ({
  ^bb0(%arg8: i16, %arg9: i16):
    %5 = "spirv.SDiv"(%arg8, %arg9) : (i16, i16) -> i16
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>, vector<2xi64>) -> (), sym_name = "sdiv_vector"}> ({
  ^bb0(%arg6: vector<2xi64>, %arg7: vector<2xi64>):
    %4 = "spirv.SDiv"(%arg6, %arg7) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "srem_scalar"}> ({
  ^bb0(%arg4: i32, %arg5: i32):
    %3 = "spirv.SRem"(%arg4, %arg5) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>, vector<4xi32>) -> (), sym_name = "srem_vector"}> ({
  ^bb0(%arg2: vector<4xi32>, %arg3: vector<4xi32>):
    %2 = "spirv.SRem"(%arg2, %arg3) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "snegate_scalar"}> ({
  ^bb0(%arg1: i32):
    %1 = "spirv.SNegate"(%arg1) : (i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>) -> (), sym_name = "snegate_vector"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "spirv.SNegate"(%arg0) : (vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

