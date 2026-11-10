"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "umul_extended_i32"}> ({
    ^bb0(%arg24: i32, %arg25: i32):
      %15 = "spirv.UMulExtended"(%arg24, %arg25) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%15) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "umul_extended_vector_i32"}> ({
    ^bb0(%arg22: vector<3xi32>, %arg23: vector<3xi32>):
      %14 = "spirv.UMulExtended"(%arg22, %arg23) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%14) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16) -> !spirv.struct<(i16, i16)>, sym_name = "umul_extended_i16"}> ({
    ^bb0(%arg21: i16):
      %13 = "spirv.UMulExtended"(%arg21, %arg21) : (i16, i16) -> !spirv.struct<(i16, i16)>
      "spirv.ReturnValue"(%13) : (!spirv.struct<(i16, i16)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "smul_extended_i32"}> ({
    ^bb0(%arg19: i32, %arg20: i32):
      %12 = "spirv.SMulExtended"(%arg19, %arg20) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%12) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "smul_extended_vector_i32"}> ({
    ^bb0(%arg17: vector<3xi32>, %arg18: vector<3xi32>):
      %11 = "spirv.SMulExtended"(%arg17, %arg18) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%11) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16) -> !spirv.struct<(i16, i16)>, sym_name = "smul_extended_i16"}> ({
    ^bb0(%arg16: i16):
      %10 = "spirv.SMulExtended"(%arg16, %arg16) : (i16, i16) -> !spirv.struct<(i16, i16)>
      "spirv.ReturnValue"(%10) : (!spirv.struct<(i16, i16)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "iaddcarry_i32"}> ({
    ^bb0(%arg14: i32, %arg15: i32):
      %9 = "spirv.IAddCarry"(%arg14, %arg15) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%9) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "iaddcarry_vector_i32"}> ({
    ^bb0(%arg12: vector<3xi32>, %arg13: vector<3xi32>):
      %8 = "spirv.IAddCarry"(%arg12, %arg13) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%8) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, i16) -> !spirv.struct<(i16, i16)>, sym_name = "iaddcarry_i16"}> ({
    ^bb0(%arg10: i16, %arg11: i16):
      %7 = "spirv.IAddCarry"(%arg10, %arg11) : (i16, i16) -> !spirv.struct<(i16, i16)>
      "spirv.ReturnValue"(%7) : (!spirv.struct<(i16, i16)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "isubborrow_i32"}> ({
    ^bb0(%arg8: i32, %arg9: i32):
      %6 = "spirv.ISubBorrow"(%arg8, %arg9) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%6) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "isubborrow_vector_i32"}> ({
    ^bb0(%arg6: vector<3xi32>, %arg7: vector<3xi32>):
      %5 = "spirv.ISubBorrow"(%arg6, %arg7) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%5) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, i16) -> !spirv.struct<(i16, i16)>, sym_name = "isubborrow_i16"}> ({
    ^bb0(%arg4: i16, %arg5: i16):
      %4 = "spirv.ISubBorrow"(%arg4, %arg5) : (i16, i16) -> !spirv.struct<(i16, i16)>
      "spirv.ReturnValue"(%4) : (!spirv.struct<(i16, i16)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> i1, sym_name = "is_inf_f32"}> ({
    ^bb0(%arg3: f32):
      %3 = "spirv.IsInf"(%arg3) : (f32) -> i1
      "spirv.ReturnValue"(%3) : (i1) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>) -> vector<4xi1>, sym_name = "is_inf_4xf32"}> ({
    ^bb0(%arg2: vector<4xf32>):
      %2 = "spirv.IsInf"(%arg2) : (vector<4xf32>) -> vector<4xi1>
      "spirv.ReturnValue"(%2) : (vector<4xi1>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> i1, sym_name = "is_nan_f32"}> ({
    ^bb0(%arg1: f32):
      %1 = "spirv.IsNan"(%arg1) : (f32) -> i1
      "spirv.ReturnValue"(%1) : (i1) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>) -> vector<4xi1>, sym_name = "is_nan_4xf32"}> ({
    ^bb0(%arg0: vector<4xf32>):
      %0 = "spirv.IsNan"(%arg0) : (vector<4xf32>) -> vector<4xi1>
      "spirv.ReturnValue"(%0) : (vector<4xi1>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

