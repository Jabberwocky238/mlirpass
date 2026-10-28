"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "umul_extended_i32"}> ({
    ^bb0(%arg18: i32, %arg19: i32):
      %12 = "spirv.UMulExtended"(%arg18, %arg19) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%12) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "umul_extended_vector_i32"}> ({
    ^bb0(%arg16: vector<3xi32>, %arg17: vector<3xi32>):
      %11 = "spirv.UMulExtended"(%arg16, %arg17) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%11) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16) -> !spirv.struct<(i16, i16)>, sym_name = "umul_extended_i16"}> ({
    ^bb0(%arg15: i16):
      %10 = "spirv.UMulExtended"(%arg15, %arg15) : (i16, i16) -> !spirv.struct<(i16, i16)>
      "spirv.ReturnValue"(%10) : (!spirv.struct<(i16, i16)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "smul_extended_i32"}> ({
    ^bb0(%arg13: i32, %arg14: i32):
      %9 = "spirv.SMulExtended"(%arg13, %arg14) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%9) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "smul_extended_vector_i32"}> ({
    ^bb0(%arg11: vector<3xi32>, %arg12: vector<3xi32>):
      %8 = "spirv.SMulExtended"(%arg11, %arg12) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%8) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16) -> !spirv.struct<(i16, i16)>, sym_name = "smul_extended_i16"}> ({
    ^bb0(%arg10: i16):
      %7 = "spirv.SMulExtended"(%arg10, %arg10) : (i16, i16) -> !spirv.struct<(i16, i16)>
      "spirv.ReturnValue"(%7) : (!spirv.struct<(i16, i16)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i32) -> !spirv.struct<(i32, i32)>, sym_name = "iaddcarry_i32"}> ({
    ^bb0(%arg8: i32, %arg9: i32):
      %6 = "spirv.IAddCarry"(%arg8, %arg9) : (i32, i32) -> !spirv.struct<(i32, i32)>
      "spirv.ReturnValue"(%6) : (!spirv.struct<(i32, i32)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>, sym_name = "iaddcarry_vector_i32"}> ({
    ^bb0(%arg6: vector<3xi32>, %arg7: vector<3xi32>):
      %5 = "spirv.IAddCarry"(%arg6, %arg7) : (vector<3xi32>, vector<3xi32>) -> !spirv.struct<(vector<3xi32>, vector<3xi32>)>
      "spirv.ReturnValue"(%5) : (!spirv.struct<(vector<3xi32>, vector<3xi32>)>) -> ()
    }) : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i16, i16) -> !spirv.struct<(i16, i16)>, sym_name = "iaddcarry_i16"}> ({
    ^bb0(%arg4: i16, %arg5: i16):
      %4 = "spirv.IAddCarry"(%arg4, %arg5) : (i16, i16) -> !spirv.struct<(i16, i16)>
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

