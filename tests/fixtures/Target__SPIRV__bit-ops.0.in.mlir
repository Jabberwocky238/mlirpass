"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage, Int16, Int8], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "bitcount"}> ({
  ^bb0(%arg20: i32):
    %11 = "spirv.BitCount"(%arg20) : (i32) -> i32
    "spirv.ReturnValue"(%11) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>, i32, i16) -> vector<3xi32>, sym_name = "bit_field_insert"}> ({
  ^bb0(%arg16: vector<3xi32>, %arg17: vector<3xi32>, %arg18: i32, %arg19: i16):
    %10 = "spirv.BitFieldInsert"(%arg16, %arg17, %arg18, %arg19) : (vector<3xi32>, vector<3xi32>, i32, i16) -> vector<3xi32>
    "spirv.ReturnValue"(%10) : (vector<3xi32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, i8, i8) -> vector<3xi32>, sym_name = "bit_field_s_extract"}> ({
  ^bb0(%arg13: vector<3xi32>, %arg14: i8, %arg15: i8):
    %9 = "spirv.BitFieldSExtract"(%arg13, %arg14, %arg15) : (vector<3xi32>, i8, i8) -> vector<3xi32>
    "spirv.ReturnValue"(%9) : (vector<3xi32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, i8, i8) -> vector<3xi32>, sym_name = "bit_field_u_extract"}> ({
  ^bb0(%arg10: vector<3xi32>, %arg11: i8, %arg12: i8):
    %8 = "spirv.BitFieldUExtract"(%arg10, %arg11, %arg12) : (vector<3xi32>, i8, i8) -> vector<3xi32>
    "spirv.ReturnValue"(%8) : (vector<3xi32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "bitreverse"}> ({
  ^bb0(%arg9: i32):
    %7 = "spirv.BitReverse"(%arg9) : (i32) -> i32
    "spirv.ReturnValue"(%7) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "not"}> ({
  ^bb0(%arg8: i32):
    %6 = "spirv.Not"(%arg8) : (i32) -> i32
    "spirv.ReturnValue"(%6) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "bitwise_scalar"}> ({
  ^bb0(%arg6: i32, %arg7: i32):
    %3 = "spirv.BitwiseAnd"(%arg6, %arg7) : (i32, i32) -> i32
    %4 = "spirv.BitwiseOr"(%arg6, %arg7) : (i32, i32) -> i32
    %5 = "spirv.BitwiseXor"(%arg6, %arg7) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i16) -> i32, sym_name = "shift_left_logical"}> ({
  ^bb0(%arg4: i32, %arg5: i16):
    %2 = "spirv.ShiftLeftLogical"(%arg4, %arg5) : (i32, i16) -> i32
    "spirv.ReturnValue"(%2) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>, vector<4xi8>) -> vector<4xi32>, sym_name = "shift_right_arithmetic"}> ({
  ^bb0(%arg2: vector<4xi32>, %arg3: vector<4xi8>):
    %1 = "spirv.ShiftRightArithmetic"(%arg2, %arg3) : (vector<4xi32>, vector<4xi8>) -> vector<4xi32>
    "spirv.ReturnValue"(%1) : (vector<4xi32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi32>, vector<2xi8>) -> vector<2xi32>, sym_name = "shift_right_logical"}> ({
  ^bb0(%arg0: vector<2xi32>, %arg1: vector<2xi8>):
    %0 = "spirv.ShiftRightLogical"(%arg0, %arg1) : (vector<2xi32>, vector<2xi8>) -> vector<2xi32>
    "spirv.ReturnValue"(%0) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

