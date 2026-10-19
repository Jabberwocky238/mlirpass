"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, si32, i16, ui16) -> (), sym_name = "shift_right_arithmetic_scalar"}> ({
  ^bb0(%arg20: i32, %arg21: si32, %arg22: i16, %arg23: ui16):
    %20 = "spirv.ShiftRightArithmetic"(%arg20, %arg20) : (i32, i32) -> i32
    %21 = "spirv.ShiftRightArithmetic"(%arg20, %arg21) : (i32, si32) -> i32
    %22 = "spirv.ShiftRightArithmetic"(%arg20, %arg22) : (i32, i16) -> i32
    %23 = "spirv.ShiftRightArithmetic"(%arg20, %arg23) : (i32, ui16) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi64>, vector<4xui64>, vector<4xi32>, vector<4xui32>) -> (), sym_name = "shift_right_arithmetic_vector"}> ({
  ^bb0(%arg16: vector<4xi64>, %arg17: vector<4xui64>, %arg18: vector<4xi32>, %arg19: vector<4xui32>):
    %16 = "spirv.ShiftRightArithmetic"(%arg16, %arg16) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %17 = "spirv.ShiftRightArithmetic"(%arg16, %arg17) : (vector<4xi64>, vector<4xui64>) -> vector<4xi64>
    %18 = "spirv.ShiftRightArithmetic"(%arg16, %arg18) : (vector<4xi64>, vector<4xi32>) -> vector<4xi64>
    %19 = "spirv.ShiftRightArithmetic"(%arg16, %arg19) : (vector<4xi64>, vector<4xui32>) -> vector<4xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, si32, si16, ui16) -> (), sym_name = "shift_right_logical_scalar"}> ({
  ^bb0(%arg12: i32, %arg13: si32, %arg14: si16, %arg15: ui16):
    %12 = "spirv.ShiftRightLogical"(%arg12, %arg12) : (i32, i32) -> i32
    %13 = "spirv.ShiftRightLogical"(%arg12, %arg13) : (i32, si32) -> i32
    %14 = "spirv.ShiftRightLogical"(%arg12, %arg14) : (i32, si16) -> i32
    %15 = "spirv.ShiftRightLogical"(%arg12, %arg15) : (i32, ui16) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi64>, vector<4xsi64>, vector<4xi32>, vector<4xui32>) -> (), sym_name = "shift_right_logical_vector"}> ({
  ^bb0(%arg8: vector<4xi64>, %arg9: vector<4xsi64>, %arg10: vector<4xi32>, %arg11: vector<4xui32>):
    %8 = "spirv.ShiftRightLogical"(%arg8, %arg8) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %9 = "spirv.ShiftRightLogical"(%arg8, %arg9) : (vector<4xi64>, vector<4xsi64>) -> vector<4xi64>
    %10 = "spirv.ShiftRightLogical"(%arg8, %arg10) : (vector<4xi64>, vector<4xi32>) -> vector<4xi64>
    %11 = "spirv.ShiftRightLogical"(%arg8, %arg11) : (vector<4xi64>, vector<4xui32>) -> vector<4xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, si32, i16, ui16) -> (), sym_name = "shift_left_logical_scalar"}> ({
  ^bb0(%arg4: i32, %arg5: si32, %arg6: i16, %arg7: ui16):
    %4 = "spirv.ShiftLeftLogical"(%arg4, %arg4) : (i32, i32) -> i32
    %5 = "spirv.ShiftLeftLogical"(%arg4, %arg5) : (i32, si32) -> i32
    %6 = "spirv.ShiftLeftLogical"(%arg4, %arg6) : (i32, i16) -> i32
    %7 = "spirv.ShiftLeftLogical"(%arg4, %arg7) : (i32, ui16) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi64>, vector<4xsi64>, vector<4xi32>, vector<4xui32>) -> (), sym_name = "shift_left_logical_vector"}> ({
  ^bb0(%arg0: vector<4xi64>, %arg1: vector<4xsi64>, %arg2: vector<4xi32>, %arg3: vector<4xui32>):
    %0 = "spirv.ShiftLeftLogical"(%arg0, %arg0) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %1 = "spirv.ShiftLeftLogical"(%arg0, %arg1) : (vector<4xi64>, vector<4xsi64>) -> vector<4xi64>
    %2 = "spirv.ShiftLeftLogical"(%arg0, %arg2) : (vector<4xi64>, vector<4xi32>) -> vector<4xi64>
    %3 = "spirv.ShiftLeftLogical"(%arg0, %arg3) : (vector<4xi64>, vector<4xui32>) -> vector<4xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

