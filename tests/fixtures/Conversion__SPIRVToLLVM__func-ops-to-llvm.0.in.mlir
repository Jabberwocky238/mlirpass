"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "return"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> i32, sym_name = "return_value"}> ({
  ^bb0(%arg17: i32):
    "spirv.ReturnValue"(%arg17) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "none"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<Inline>, function_type = () -> (), sym_name = "inline"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<DontInline>, function_type = () -> (), sym_name = "dont_inline"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<Pure>, function_type = () -> (), sym_name = "pure"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<Const>, function_type = () -> (), sym_name = "const"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i1, f64, f32) -> (), sym_name = "scalar_types"}> ({
  ^bb0(%arg13: i32, %arg14: i1, %arg15: f64, %arg16: f32):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>, vector<2xi64>) -> vector<2xi64>, sym_name = "vector_types"}> ({
  ^bb0(%arg11: vector<2xi64>, %arg12: vector<2xi64>):
    %2 = "spirv.IAdd"(%arg11, %arg12) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "spirv.ReturnValue"(%2) : (vector<2xi64>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i1, f64, vector<2xi64>, vector<2xf32>) -> (), sym_name = "function_calls"}> ({
  ^bb0(%arg6: i32, %arg7: i1, %arg8: f64, %arg9: vector<2xi64>, %arg10: vector<2xf32>):
    "spirv.FunctionCall"() <{callee = @void_1}> : () -> ()
    "spirv.FunctionCall"(%arg9) <{callee = @void_2}> : (vector<2xi64>) -> ()
    %0 = "spirv.FunctionCall"(%arg6, %arg7, %arg8) <{callee = @value_scalar}> : (i32, i1, f64) -> i32
    %1 = "spirv.FunctionCall"(%arg9, %arg10) <{callee = @value_vector}> : (vector<2xi64>, vector<2xf32>) -> vector<2xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "void_1"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>) -> (), sym_name = "void_2"}> ({
  ^bb0(%arg5: vector<2xi64>):
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, i1, f64) -> i32, sym_name = "value_scalar"}> ({
  ^bb0(%arg2: i32, %arg3: i1, %arg4: f64):
    "spirv.ReturnValue"(%arg2) : (i32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi64>, vector<2xf32>) -> vector<2xf32>, sym_name = "value_vector"}> ({
  ^bb0(%arg0: vector<2xi64>, %arg1: vector<2xf32>):
    "spirv.ReturnValue"(%arg1) : (vector<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

