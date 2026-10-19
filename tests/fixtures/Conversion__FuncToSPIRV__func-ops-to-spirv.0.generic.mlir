"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "return_none_val"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> f32, sym_name = "return_one_val"}> ({
  ^bb0(%arg3: f32):
    "spirv.ReturnValue"(%arg3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (f32, f32), sym_name = "return_multi_val"}> ({
  ^bb0(%arg2: f32):
    "func.return"(%arg2, %arg2) : (f32, f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "return_one_index"}> ({
  ^bb0(%arg1: i32):
    "spirv.ReturnValue"(%arg1) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "call_functions"}> ({
  ^bb0(%arg0: i32):
    "spirv.FunctionCall"() <{callee = @return_none_val}> : () -> ()
    %0 = "spirv.FunctionCall"(%arg0) <{callee = @return_one_index}> : (i32) -> i32
    "spirv.ReturnValue"(%0) : (i32) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
// -----
"builtin.module"() ({
^bb0:
}) : () -> ()

