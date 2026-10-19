"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "add_scalar"}> ({
  ^bb0(%arg1: i32):
    %1 = "spirv.IAdd"(%arg1, %arg1) : (i32, i32) -> i32
    "spirv.ReturnValue"(%1) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "add_index"}> ({
  ^bb0(%arg0: i32):
    %0 = "spirv.IAdd"(%arg0, %arg0) : (i32, i32) -> i32
    "spirv.ReturnValue"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

