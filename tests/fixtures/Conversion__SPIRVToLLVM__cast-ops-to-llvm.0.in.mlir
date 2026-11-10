"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "bitcast_float_to_integer_scalar"}> ({
  ^bb0(%arg30: f32):
    %30 = "spirv.Bitcast"(%arg30) : (f32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xf32>) -> (), sym_name = "bitcast_float_to_integer_vector"}> ({
  ^bb0(%arg29: vector<3xf32>):
    %29 = "spirv.Bitcast"(%arg29) : (vector<3xf32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>) -> (), sym_name = "bitcast_vector_to_scalar"}> ({
  ^bb0(%arg28: vector<2xf32>):
    %28 = "spirv.Bitcast"(%arg28) : (vector<2xf32>) -> i64
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64) -> (), sym_name = "bitcast_scalar_to_vector"}> ({
  ^bb0(%arg27: f64):
    %27 = "spirv.Bitcast"(%arg27) : (f64) -> vector<2xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>) -> (), sym_name = "bitcast_vector_to_vector"}> ({
  ^bb0(%arg26: vector<4xf32>):
    %26 = "spirv.Bitcast"(%arg26) : (vector<4xf32>) -> vector<2xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<f32, Function>) -> (), sym_name = "bitcast_pointer"}> ({
  ^bb0(%arg25: !spirv.ptr<f32, Function>):
    %25 = "spirv.Bitcast"(%arg25) : (!spirv.ptr<f32, Function>) -> !spirv.ptr<i32, Function>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "convert_float_to_signed_scalar"}> ({
  ^bb0(%arg24: f32):
    %24 = "spirv.ConvertFToS"(%arg24) : (f32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>) -> (), sym_name = "convert_float_to_signed_vector"}> ({
  ^bb0(%arg23: vector<2xf32>):
    %23 = "spirv.ConvertFToS"(%arg23) : (vector<2xf32>) -> vector<2xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "convert_float_to_unsigned_scalar"}> ({
  ^bb0(%arg22: f32):
    %22 = "spirv.ConvertFToU"(%arg22) : (f32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>) -> (), sym_name = "convert_float_to_unsigned_vector"}> ({
  ^bb0(%arg21: vector<2xf32>):
    %21 = "spirv.ConvertFToU"(%arg21) : (vector<2xf32>) -> vector<2xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "convert_signed_to_float_scalar"}> ({
  ^bb0(%arg20: i32):
    %20 = "spirv.ConvertSToF"(%arg20) : (i32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>) -> (), sym_name = "convert_signed_to_float_vector"}> ({
  ^bb0(%arg19: vector<3xi32>):
    %19 = "spirv.ConvertSToF"(%arg19) : (vector<3xi32>) -> vector<3xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "convert_unsigned_to_float_scalar"}> ({
  ^bb0(%arg18: i32):
    %18 = "spirv.ConvertUToF"(%arg18) : (i32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>) -> (), sym_name = "convert_unsigned_to_float_vector"}> ({
  ^bb0(%arg17: vector<3xi32>):
    %17 = "spirv.ConvertUToF"(%arg17) : (vector<3xi32>) -> vector<3xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f64) -> (), sym_name = "fconvert_scalar"}> ({
  ^bb0(%arg15: f32, %arg16: f64):
    %15 = "spirv.FConvert"(%arg15) : (f32) -> f64
    %16 = "spirv.FConvert"(%arg16) : (f64) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>, vector<2xf64>) -> (), sym_name = "fconvert_vector"}> ({
  ^bb0(%arg13: vector<2xf32>, %arg14: vector<2xf64>):
    %13 = "spirv.FConvert"(%arg13) : (vector<2xf32>) -> vector<2xf64>
    %14 = "spirv.FConvert"(%arg14) : (vector<2xf64>) -> vector<2xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i64) -> (), sym_name = "sconvert_scalar"}> ({
  ^bb0(%arg11: i32, %arg12: i64):
    %11 = "spirv.SConvert"(%arg11) : (i32) -> i64
    %12 = "spirv.SConvert"(%arg12) : (i64) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi64>) -> (), sym_name = "sconvert_vector"}> ({
  ^bb0(%arg9: vector<3xi32>, %arg10: vector<3xi64>):
    %9 = "spirv.SConvert"(%arg9) : (vector<3xi32>) -> vector<3xi64>
    %10 = "spirv.SConvert"(%arg10) : (vector<3xi64>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i64) -> (), sym_name = "uconvert_scalar"}> ({
  ^bb0(%arg7: i32, %arg8: i64):
    %7 = "spirv.UConvert"(%arg7) : (i32) -> i64
    %8 = "spirv.UConvert"(%arg8) : (i64) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi64>) -> (), sym_name = "uconvert_vector"}> ({
  ^bb0(%arg5: vector<3xi32>, %arg6: vector<3xi64>):
    %5 = "spirv.UConvert"(%arg5) : (vector<3xi32>) -> vector<3xi64>
    %6 = "spirv.UConvert"(%arg6) : (vector<3xi64>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<i32, Generic>) -> (), sym_name = "convert_ptr_to_u"}> ({
  ^bb0(%arg4: !spirv.ptr<i32, Generic>):
    %4 = "spirv.ConvertPtrToU"(%arg4) : (!spirv.ptr<i32, Generic>) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "convert_u_to_ptr"}> ({
  ^bb0(%arg3: i32):
    %3 = "spirv.ConvertUToPtr"(%arg3) : (i32) -> !spirv.ptr<i32, Generic>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<f32, CrossWorkgroup>) -> (), sym_name = "ptr_cast_to_generic"}> ({
  ^bb0(%arg2: !spirv.ptr<f32, CrossWorkgroup>):
    %2 = "spirv.PtrCastToGeneric"(%arg2) : (!spirv.ptr<f32, CrossWorkgroup>) -> !spirv.ptr<f32, Generic>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<vector<2xi32>, Generic>) -> (), sym_name = "generic_cast_to_ptr"}> ({
  ^bb0(%arg1: !spirv.ptr<vector<2xi32>, Generic>):
    %1 = "spirv.GenericCastToPtr"(%arg1) : (!spirv.ptr<vector<2xi32>, Generic>) -> !spirv.ptr<vector<2xi32>, CrossWorkgroup>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<vector<2xi32>, Generic>) -> (), sym_name = "generic_cast_to_ptr_explicit"}> ({
  ^bb0(%arg0: !spirv.ptr<vector<2xi32>, Generic>):
    %0 = "spirv.GenericCastToPtrExplicit"(%arg0) : (!spirv.ptr<vector<2xi32>, Generic>) -> !spirv.ptr<vector<2xi32>, CrossWorkgroup>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

