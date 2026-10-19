"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "bitcast_float_to_integer_scalar"}> ({
  ^bb0(%arg25: f32):
    %25 = "spirv.Bitcast"(%arg25) : (f32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xf32>) -> (), sym_name = "bitcast_float_to_integer_vector"}> ({
  ^bb0(%arg24: vector<3xf32>):
    %24 = "spirv.Bitcast"(%arg24) : (vector<3xf32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>) -> (), sym_name = "bitcast_vector_to_scalar"}> ({
  ^bb0(%arg23: vector<2xf32>):
    %23 = "spirv.Bitcast"(%arg23) : (vector<2xf32>) -> i64
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64) -> (), sym_name = "bitcast_scalar_to_vector"}> ({
  ^bb0(%arg22: f64):
    %22 = "spirv.Bitcast"(%arg22) : (f64) -> vector<2xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>) -> (), sym_name = "bitcast_vector_to_vector"}> ({
  ^bb0(%arg21: vector<4xf32>):
    %21 = "spirv.Bitcast"(%arg21) : (vector<4xf32>) -> vector<2xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<f32, Function>) -> (), sym_name = "bitcast_pointer"}> ({
  ^bb0(%arg20: !spirv.ptr<f32, Function>):
    %20 = "spirv.Bitcast"(%arg20) : (!spirv.ptr<f32, Function>) -> !spirv.ptr<i32, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "convert_float_to_signed_scalar"}> ({
  ^bb0(%arg19: f32):
    %19 = "spirv.ConvertFToS"(%arg19) : (f32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>) -> (), sym_name = "convert_float_to_signed_vector"}> ({
  ^bb0(%arg18: vector<2xf32>):
    %18 = "spirv.ConvertFToS"(%arg18) : (vector<2xf32>) -> vector<2xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "convert_float_to_unsigned_scalar"}> ({
  ^bb0(%arg17: f32):
    %17 = "spirv.ConvertFToU"(%arg17) : (f32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>) -> (), sym_name = "convert_float_to_unsigned_vector"}> ({
  ^bb0(%arg16: vector<2xf32>):
    %16 = "spirv.ConvertFToU"(%arg16) : (vector<2xf32>) -> vector<2xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "convert_signed_to_float_scalar"}> ({
  ^bb0(%arg15: i32):
    %15 = "spirv.ConvertSToF"(%arg15) : (i32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>) -> (), sym_name = "convert_signed_to_float_vector"}> ({
  ^bb0(%arg14: vector<3xi32>):
    %14 = "spirv.ConvertSToF"(%arg14) : (vector<3xi32>) -> vector<3xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "convert_unsigned_to_float_scalar"}> ({
  ^bb0(%arg13: i32):
    %13 = "spirv.ConvertUToF"(%arg13) : (i32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>) -> (), sym_name = "convert_unsigned_to_float_vector"}> ({
  ^bb0(%arg12: vector<3xi32>):
    %12 = "spirv.ConvertUToF"(%arg12) : (vector<3xi32>) -> vector<3xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f64) -> (), sym_name = "fconvert_scalar"}> ({
  ^bb0(%arg10: f32, %arg11: f64):
    %10 = "spirv.FConvert"(%arg10) : (f32) -> f64
    %11 = "spirv.FConvert"(%arg11) : (f64) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>, vector<2xf64>) -> (), sym_name = "fconvert_vector"}> ({
  ^bb0(%arg8: vector<2xf32>, %arg9: vector<2xf64>):
    %8 = "spirv.FConvert"(%arg8) : (vector<2xf32>) -> vector<2xf64>
    %9 = "spirv.FConvert"(%arg9) : (vector<2xf64>) -> vector<2xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i64) -> (), sym_name = "sconvert_scalar"}> ({
  ^bb0(%arg6: i32, %arg7: i64):
    %6 = "spirv.SConvert"(%arg6) : (i32) -> i64
    %7 = "spirv.SConvert"(%arg7) : (i64) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi64>) -> (), sym_name = "sconvert_vector"}> ({
  ^bb0(%arg4: vector<3xi32>, %arg5: vector<3xi64>):
    %4 = "spirv.SConvert"(%arg4) : (vector<3xi32>) -> vector<3xi64>
    %5 = "spirv.SConvert"(%arg5) : (vector<3xi64>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i64) -> (), sym_name = "uconvert_scalar"}> ({
  ^bb0(%arg2: i32, %arg3: i64):
    %2 = "spirv.UConvert"(%arg2) : (i32) -> i64
    %3 = "spirv.UConvert"(%arg3) : (i64) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi64>) -> (), sym_name = "uconvert_vector"}> ({
  ^bb0(%arg0: vector<3xi32>, %arg1: vector<3xi64>):
    %0 = "spirv.UConvert"(%arg0) : (vector<3xi32>) -> vector<3xi64>
    %1 = "spirv.UConvert"(%arg1) : (vector<3xi64>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

