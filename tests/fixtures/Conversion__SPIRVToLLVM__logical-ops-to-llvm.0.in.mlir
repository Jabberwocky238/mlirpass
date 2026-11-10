"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, i1) -> (), sym_name = "logical_equal_scalar"}> ({
  ^bb0(%arg24: i1, %arg25: i1):
    %13 = "spirv.LogicalEqual"(%arg24, %arg25) : (i1, i1) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi1>, vector<4xi1>) -> (), sym_name = "logical_equal_vector"}> ({
  ^bb0(%arg22: vector<4xi1>, %arg23: vector<4xi1>):
    %12 = "spirv.LogicalEqual"(%arg22, %arg23) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, i1) -> (), sym_name = "logical_not_equal_scalar"}> ({
  ^bb0(%arg20: i1, %arg21: i1):
    %11 = "spirv.LogicalNotEqual"(%arg20, %arg21) : (i1, i1) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi1>, vector<4xi1>) -> (), sym_name = "logical_not_equal_vector"}> ({
  ^bb0(%arg18: vector<4xi1>, %arg19: vector<4xi1>):
    %10 = "spirv.LogicalNotEqual"(%arg18, %arg19) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> (), sym_name = "logical_not_scalar"}> ({
  ^bb0(%arg17: i1):
    %9 = "spirv.LogicalNot"(%arg17) : (i1) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi1>) -> (), sym_name = "logical_not_vector"}> ({
  ^bb0(%arg16: vector<4xi1>):
    %8 = "spirv.LogicalNot"(%arg16) : (vector<4xi1>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, i1) -> (), sym_name = "logical_and_scalar"}> ({
  ^bb0(%arg14: i1, %arg15: i1):
    %7 = "spirv.LogicalAnd"(%arg14, %arg15) : (i1, i1) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi1>, vector<4xi1>) -> (), sym_name = "logical_and_vector"}> ({
  ^bb0(%arg12: vector<4xi1>, %arg13: vector<4xi1>):
    %6 = "spirv.LogicalAnd"(%arg12, %arg13) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, i1) -> (), sym_name = "logical_or_scalar"}> ({
  ^bb0(%arg10: i1, %arg11: i1):
    %5 = "spirv.LogicalOr"(%arg10, %arg11) : (i1, i1) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi1>, vector<4xi1>) -> (), sym_name = "logical_or_vector"}> ({
  ^bb0(%arg8: vector<4xi1>, %arg9: vector<4xi1>):
    %4 = "spirv.LogicalOr"(%arg8, %arg9) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "ordered_scalar"}> ({
  ^bb0(%arg6: f32, %arg7: f32):
    %3 = "spirv.Ordered"(%arg6, %arg7) : (f32, f32) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "ordered_vector"}> ({
  ^bb0(%arg4: vector<4xf32>, %arg5: vector<4xf32>):
    %2 = "spirv.Ordered"(%arg4, %arg5) : (vector<4xf32>, vector<4xf32>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32) -> (), sym_name = "unordered_scalar"}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %1 = "spirv.Unordered"(%arg2, %arg3) : (f32, f32) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, vector<4xf32>) -> (), sym_name = "unordered_vector"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):
    %0 = "spirv.Unordered"(%arg0, %arg1) : (vector<4xf32>, vector<4xf32>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

