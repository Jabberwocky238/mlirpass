"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.array<4 x f32, stride=8>) -> (), sym_name = "array_with_unnatural_stride"}> ({
  ^bb0(%arg0: !spirv.array<4 x f32, stride=8>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.struct<(!spirv.array<4 x f32, stride=8>)>) -> (), sym_name = "struct_array_with_unnatural_stride"}> ({
  ^bb0(%arg0: !spirv.struct<(!spirv.array<4 x f32, stride=8>)>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.struct<(i32 [0], i32 [8])>) -> (), sym_name = "struct_with_unnatural_offset"}> ({
  ^bb0(%arg0: !spirv.struct<(i32 [0], i32 [8])>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.struct<(f32 [RelaxedPrecision])>) -> (), sym_name = "struct_with_decorations"}> ({
  ^bb0(%arg0: !spirv.struct<(f32 [RelaxedPrecision])>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

