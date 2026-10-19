"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "i_equal_scalar"}> ({
  ^bb0(%arg86: i32, %arg87: i32):
    %43 = "spirv.IEqual"(%arg86, %arg87) : (i32, i32) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi64>, vector<4xi64>) -> (), sym_name = "i_equal_vector"}> ({
  ^bb0(%arg84: vector<4xi64>, %arg85: vector<4xi64>):
    %42 = "spirv.IEqual"(%arg84, %arg85) : (vector<4xi64>, vector<4xi64>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64, i64) -> (), sym_name = "i_not_equal_scalar"}> ({
  ^bb0(%arg82: i64, %arg83: i64):
    %41 = "spirv.INotEqual"(%arg82, %arg83) : (i64, i64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>, vector<2xi64>) -> (), sym_name = "i_not_equal_vector"}> ({
  ^bb0(%arg80: vector<2xi64>, %arg81: vector<2xi64>):
    %40 = "spirv.INotEqual"(%arg80, %arg81) : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64, i64) -> (), sym_name = "s_greater_than_equal_scalar"}> ({
  ^bb0(%arg78: i64, %arg79: i64):
    %39 = "spirv.SGreaterThanEqual"(%arg78, %arg79) : (i64, i64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>, vector<2xi64>) -> (), sym_name = "s_greater_than_equal_vector"}> ({
  ^bb0(%arg76: vector<2xi64>, %arg77: vector<2xi64>):
    %38 = "spirv.SGreaterThanEqual"(%arg76, %arg77) : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64, i64) -> (), sym_name = "s_greater_than_scalar"}> ({
  ^bb0(%arg74: i64, %arg75: i64):
    %37 = "spirv.SGreaterThan"(%arg74, %arg75) : (i64, i64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>, vector<2xi64>) -> (), sym_name = "s_greater_than_vector"}> ({
  ^bb0(%arg72: vector<2xi64>, %arg73: vector<2xi64>):
    %36 = "spirv.SGreaterThan"(%arg72, %arg73) : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64, i64) -> (), sym_name = "s_less_than_equal_scalar"}> ({
  ^bb0(%arg70: i64, %arg71: i64):
    %35 = "spirv.SLessThanEqual"(%arg70, %arg71) : (i64, i64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>, vector<2xi64>) -> (), sym_name = "s_less_than_equal_vector"}> ({
  ^bb0(%arg68: vector<2xi64>, %arg69: vector<2xi64>):
    %34 = "spirv.SLessThanEqual"(%arg68, %arg69) : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64, i64) -> (), sym_name = "s_less_than_scalar"}> ({
  ^bb0(%arg66: i64, %arg67: i64):
    %33 = "spirv.SLessThan"(%arg66, %arg67) : (i64, i64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>, vector<2xi64>) -> (), sym_name = "s_less_than_vector"}> ({
  ^bb0(%arg64: vector<2xi64>, %arg65: vector<2xi64>):
    %32 = "spirv.SLessThan"(%arg64, %arg65) : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64, i64) -> (), sym_name = "u_greater_than_equal_scalar"}> ({
  ^bb0(%arg62: i64, %arg63: i64):
    %31 = "spirv.UGreaterThanEqual"(%arg62, %arg63) : (i64, i64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>, vector<2xi64>) -> (), sym_name = "u_greater_than_equal_vector"}> ({
  ^bb0(%arg60: vector<2xi64>, %arg61: vector<2xi64>):
    %30 = "spirv.UGreaterThanEqual"(%arg60, %arg61) : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64, i64) -> (), sym_name = "u_greater_than_scalar"}> ({
  ^bb0(%arg58: i64, %arg59: i64):
    %29 = "spirv.UGreaterThan"(%arg58, %arg59) : (i64, i64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>, vector<2xi64>) -> (), sym_name = "u_greater_than_vector"}> ({
  ^bb0(%arg56: vector<2xi64>, %arg57: vector<2xi64>):
    %28 = "spirv.UGreaterThan"(%arg56, %arg57) : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64, i64) -> (), sym_name = "u_less_than_equal_scalar"}> ({
  ^bb0(%arg54: i64, %arg55: i64):
    %27 = "spirv.ULessThanEqual"(%arg54, %arg55) : (i64, i64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>, vector<2xi64>) -> (), sym_name = "u_less_than_equal_vector"}> ({
  ^bb0(%arg52: vector<2xi64>, %arg53: vector<2xi64>):
    %26 = "spirv.ULessThanEqual"(%arg52, %arg53) : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64, i64) -> (), sym_name = "u_less_than_scalar"}> ({
  ^bb0(%arg50: i64, %arg51: i64):
    %25 = "spirv.ULessThan"(%arg50, %arg51) : (i64, i64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>, vector<2xi64>) -> (), sym_name = "u_less_than_vector"}> ({
  ^bb0(%arg48: vector<2xi64>, %arg49: vector<2xi64>):
    %24 = "spirv.ULessThan"(%arg48, %arg49) : (vector<2xi64>, vector<2xi64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "f_ord_equal_scalar"}> ({
  ^bb0(%arg46: f32, %arg47: f32):
    %23 = "spirv.FOrdEqual"(%arg46, %arg47) : (f32, f32) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf64>, vector<4xf64>) -> (), sym_name = "f_ord_equal_vector"}> ({
  ^bb0(%arg44: vector<4xf64>, %arg45: vector<4xf64>):
    %22 = "spirv.FOrdEqual"(%arg44, %arg45) : (vector<4xf64>, vector<4xf64>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64, f64) -> (), sym_name = "f_ord_greater_than_equal_scalar"}> ({
  ^bb0(%arg42: f64, %arg43: f64):
    %21 = "spirv.FOrdGreaterThanEqual"(%arg42, %arg43) : (f64, f64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf64>, vector<2xf64>) -> (), sym_name = "f_ord_greater_than_equal_vector"}> ({
  ^bb0(%arg40: vector<2xf64>, %arg41: vector<2xf64>):
    %20 = "spirv.FOrdGreaterThanEqual"(%arg40, %arg41) : (vector<2xf64>, vector<2xf64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64, f64) -> (), sym_name = "f_ord_greater_than_scalar"}> ({
  ^bb0(%arg38: f64, %arg39: f64):
    %19 = "spirv.FOrdGreaterThan"(%arg38, %arg39) : (f64, f64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf64>, vector<2xf64>) -> (), sym_name = "f_ord_greater_than_vector"}> ({
  ^bb0(%arg36: vector<2xf64>, %arg37: vector<2xf64>):
    %18 = "spirv.FOrdGreaterThan"(%arg36, %arg37) : (vector<2xf64>, vector<2xf64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64, f64) -> (), sym_name = "f_ord_less_than_scalar"}> ({
  ^bb0(%arg34: f64, %arg35: f64):
    %17 = "spirv.FOrdLessThan"(%arg34, %arg35) : (f64, f64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf64>, vector<2xf64>) -> (), sym_name = "f_ord_less_than_vector"}> ({
  ^bb0(%arg32: vector<2xf64>, %arg33: vector<2xf64>):
    %16 = "spirv.FOrdLessThan"(%arg32, %arg33) : (vector<2xf64>, vector<2xf64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64, f64) -> (), sym_name = "f_ord_less_than_equal_scalar"}> ({
  ^bb0(%arg30: f64, %arg31: f64):
    %15 = "spirv.FOrdLessThanEqual"(%arg30, %arg31) : (f64, f64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf64>, vector<2xf64>) -> (), sym_name = "f_ord_less_than_equal_vector"}> ({
  ^bb0(%arg28: vector<2xf64>, %arg29: vector<2xf64>):
    %14 = "spirv.FOrdLessThanEqual"(%arg28, %arg29) : (vector<2xf64>, vector<2xf64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "f_ord_not_equal_scalar"}> ({
  ^bb0(%arg26: f32, %arg27: f32):
    %13 = "spirv.FOrdNotEqual"(%arg26, %arg27) : (f32, f32) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf64>, vector<4xf64>) -> (), sym_name = "f_ord_not_equal_vector"}> ({
  ^bb0(%arg24: vector<4xf64>, %arg25: vector<4xf64>):
    %12 = "spirv.FOrdNotEqual"(%arg24, %arg25) : (vector<4xf64>, vector<4xf64>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "f_unord_equal_scalar"}> ({
  ^bb0(%arg22: f32, %arg23: f32):
    %11 = "spirv.FUnordEqual"(%arg22, %arg23) : (f32, f32) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf64>, vector<4xf64>) -> (), sym_name = "f_unord_equal_vector"}> ({
  ^bb0(%arg20: vector<4xf64>, %arg21: vector<4xf64>):
    %10 = "spirv.FUnordEqual"(%arg20, %arg21) : (vector<4xf64>, vector<4xf64>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64, f64) -> (), sym_name = "f_unord_greater_than_equal_scalar"}> ({
  ^bb0(%arg18: f64, %arg19: f64):
    %9 = "spirv.FUnordGreaterThanEqual"(%arg18, %arg19) : (f64, f64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf64>, vector<2xf64>) -> (), sym_name = "f_unord_greater_than_equal_vector"}> ({
  ^bb0(%arg16: vector<2xf64>, %arg17: vector<2xf64>):
    %8 = "spirv.FUnordGreaterThanEqual"(%arg16, %arg17) : (vector<2xf64>, vector<2xf64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64, f64) -> (), sym_name = "f_unord_greater_than_scalar"}> ({
  ^bb0(%arg14: f64, %arg15: f64):
    %7 = "spirv.FUnordGreaterThan"(%arg14, %arg15) : (f64, f64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf64>, vector<2xf64>) -> (), sym_name = "f_unord_greater_than_vector"}> ({
  ^bb0(%arg12: vector<2xf64>, %arg13: vector<2xf64>):
    %6 = "spirv.FUnordGreaterThan"(%arg12, %arg13) : (vector<2xf64>, vector<2xf64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64, f64) -> (), sym_name = "f_unord_less_than_scalar"}> ({
  ^bb0(%arg10: f64, %arg11: f64):
    %5 = "spirv.FUnordLessThan"(%arg10, %arg11) : (f64, f64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf64>, vector<2xf64>) -> (), sym_name = "f_unord_less_than_vector"}> ({
  ^bb0(%arg8: vector<2xf64>, %arg9: vector<2xf64>):
    %4 = "spirv.FUnordLessThan"(%arg8, %arg9) : (vector<2xf64>, vector<2xf64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f64, f64) -> (), sym_name = "f_unord_less_than_equal_scalar"}> ({
  ^bb0(%arg6: f64, %arg7: f64):
    %3 = "spirv.FUnordLessThanEqual"(%arg6, %arg7) : (f64, f64) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf64>, vector<2xf64>) -> (), sym_name = "f_unord_less_than_equal_vector"}> ({
  ^bb0(%arg4: vector<2xf64>, %arg5: vector<2xf64>):
    %2 = "spirv.FUnordLessThanEqual"(%arg4, %arg5) : (vector<2xf64>, vector<2xf64>) -> vector<2xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "f_unord_not_equal_scalar"}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %1 = "spirv.FUnordNotEqual"(%arg2, %arg3) : (f32, f32) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf64>, vector<4xf64>) -> (), sym_name = "f_unord_not_equal_vector"}> ({
  ^bb0(%arg0: vector<4xf64>, %arg1: vector<4xf64>):
    %0 = "spirv.FUnordNotEqual"(%arg0, %arg1) : (vector<4xf64>, vector<4xf64>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

