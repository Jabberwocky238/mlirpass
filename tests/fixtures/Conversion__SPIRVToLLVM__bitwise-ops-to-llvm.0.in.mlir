"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16) -> (), sym_name = "bitcount_scalar"}> ({
  ^bb0(%arg57: i16):
    %23 = "spirv.BitCount"(%arg57) : (i16) -> i16
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>) -> (), sym_name = "bitcount_vector"}> ({
  ^bb0(%arg56: vector<3xi32>):
    %22 = "spirv.BitCount"(%arg56) : (vector<3xi32>) -> vector<3xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64) -> (), sym_name = "bitreverse_scalar"}> ({
  ^bb0(%arg55: i64):
    %21 = "spirv.BitReverse"(%arg55) : (i64) -> i64
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi32>) -> (), sym_name = "bitreverse_vector"}> ({
  ^bb0(%arg54: vector<4xi32>):
    %20 = "spirv.BitReverse"(%arg54) : (vector<4xi32>) -> vector<4xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32, i32, i32) -> (), sym_name = "bitfield_insert_scalar_same_bit_width"}> ({
  ^bb0(%arg50: i32, %arg51: i32, %arg52: i32, %arg53: i32):
    %19 = "spirv.BitFieldInsert"(%arg50, %arg51, %arg52, %arg53) : (i32, i32, i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64, i64, i8, i8) -> (), sym_name = "bitfield_insert_scalar_smaller_bit_width"}> ({
  ^bb0(%arg46: i64, %arg47: i64, %arg48: i8, %arg49: i8):
    %18 = "spirv.BitFieldInsert"(%arg46, %arg47, %arg48, %arg49) : (i64, i64, i8, i8) -> i64
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, i16, i32, i64) -> (), sym_name = "bitfield_insert_scalar_greater_bit_width"}> ({
  ^bb0(%arg42: i16, %arg43: i16, %arg44: i32, %arg45: i64):
    %17 = "spirv.BitFieldInsert"(%arg42, %arg43, %arg44, %arg45) : (i16, i16, i32, i64) -> i16
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi32>, vector<2xi32>, i32, i32) -> (), sym_name = "bitfield_insert_vector"}> ({
  ^bb0(%arg38: vector<2xi32>, %arg39: vector<2xi32>, %arg40: i32, %arg41: i32):
    %16 = "spirv.BitFieldInsert"(%arg38, %arg39, %arg40, %arg41) : (vector<2xi32>, vector<2xi32>, i32, i32) -> vector<2xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64, i64, i64) -> (), sym_name = "bitfield_sextract_scalar_same_bit_width"}> ({
  ^bb0(%arg35: i64, %arg36: i64, %arg37: i64):
    %15 = "spirv.BitFieldSExtract"(%arg35, %arg36, %arg37) : (i64, i64, i64) -> i64
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i8, i8) -> (), sym_name = "bitfield_sextract_scalar_smaller_bit_width"}> ({
  ^bb0(%arg32: i32, %arg33: i8, %arg34: i8):
    %14 = "spirv.BitFieldSExtract"(%arg32, %arg33, %arg34) : (i32, i8, i8) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i64, i64) -> (), sym_name = "bitfield_sextract_scalar_greater_bit_width"}> ({
  ^bb0(%arg29: i32, %arg30: i64, %arg31: i64):
    %13 = "spirv.BitFieldSExtract"(%arg29, %arg30, %arg31) : (i32, i64, i64) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi32>, i32, i32) -> (), sym_name = "bitfield_sextract_vector"}> ({
  ^bb0(%arg26: vector<2xi32>, %arg27: i32, %arg28: i32):
    %12 = "spirv.BitFieldSExtract"(%arg26, %arg27, %arg28) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32, i32) -> (), sym_name = "bitfield_uextract_scalar_same_bit_width"}> ({
  ^bb0(%arg23: i32, %arg24: i32, %arg25: i32):
    %11 = "spirv.BitFieldUExtract"(%arg23, %arg24, %arg25) : (i32, i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i16, i8) -> (), sym_name = "bitfield_uextract_scalar_smaller_bit_width"}> ({
  ^bb0(%arg20: i32, %arg21: i16, %arg22: i8):
    %10 = "spirv.BitFieldUExtract"(%arg20, %arg21, %arg22) : (i32, i16, i8) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i8, i16, i8) -> (), sym_name = "bitfield_uextract_scalar_greater_bit_width"}> ({
  ^bb0(%arg17: i8, %arg18: i16, %arg19: i8):
    %9 = "spirv.BitFieldUExtract"(%arg17, %arg18, %arg19) : (i8, i16, i8) -> i8
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi32>, i32, i32) -> (), sym_name = "bitfield_uextract_vector"}> ({
  ^bb0(%arg14: vector<2xi32>, %arg15: i32, %arg16: i32):
    %8 = "spirv.BitFieldUExtract"(%arg14, %arg15, %arg16) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "bitwise_and_scalar"}> ({
  ^bb0(%arg12: i32, %arg13: i32):
    %7 = "spirv.BitwiseAnd"(%arg12, %arg13) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi64>, vector<4xi64>) -> (), sym_name = "bitwise_and_vector"}> ({
  ^bb0(%arg10: vector<4xi64>, %arg11: vector<4xi64>):
    %6 = "spirv.BitwiseAnd"(%arg10, %arg11) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i64, i64) -> (), sym_name = "bitwise_or_scalar"}> ({
  ^bb0(%arg8: i64, %arg9: i64):
    %5 = "spirv.BitwiseOr"(%arg8, %arg9) : (i64, i64) -> i64
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi8>, vector<3xi8>) -> (), sym_name = "bitwise_or_vector"}> ({
  ^bb0(%arg6: vector<3xi8>, %arg7: vector<3xi8>):
    %4 = "spirv.BitwiseOr"(%arg6, %arg7) : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> (), sym_name = "bitwise_xor_scalar"}> ({
  ^bb0(%arg4: i32, %arg5: i32):
    %3 = "spirv.BitwiseXor"(%arg4, %arg5) : (i32, i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi16>, vector<2xi16>) -> (), sym_name = "bitwise_xor_vector"}> ({
  ^bb0(%arg2: vector<2xi16>, %arg3: vector<2xi16>):
    %2 = "spirv.BitwiseXor"(%arg2, %arg3) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "not_scalar"}> ({
  ^bb0(%arg1: i32):
    %1 = "spirv.Not"(%arg1) : (i32) -> i32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi16>) -> (), sym_name = "not_vector"}> ({
  ^bb0(%arg0: vector<2xi16>):
    %0 = "spirv.Not"(%arg0) : (vector<2xi16>) -> vector<2xi16>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

