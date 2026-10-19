"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, i1) -> (), sym_name = "logical_equal_scalar"}> ({
  ^bb0(%arg16: i1, %arg17: i1):
    %9 = "spirv.LogicalEqual"(%arg16, %arg17) : (i1, i1) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi1>, vector<4xi1>) -> (), sym_name = "logical_equal_vector"}> ({
  ^bb0(%arg14: vector<4xi1>, %arg15: vector<4xi1>):
    %8 = "spirv.LogicalEqual"(%arg14, %arg15) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, i1) -> (), sym_name = "logical_not_equal_scalar"}> ({
  ^bb0(%arg12: i1, %arg13: i1):
    %7 = "spirv.LogicalNotEqual"(%arg12, %arg13) : (i1, i1) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi1>, vector<4xi1>) -> (), sym_name = "logical_not_equal_vector"}> ({
  ^bb0(%arg10: vector<4xi1>, %arg11: vector<4xi1>):
    %6 = "spirv.LogicalNotEqual"(%arg10, %arg11) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1) -> (), sym_name = "logical_not_scalar"}> ({
  ^bb0(%arg9: i1):
    %5 = "spirv.LogicalNot"(%arg9) : (i1) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi1>) -> (), sym_name = "logical_not_vector"}> ({
  ^bb0(%arg8: vector<4xi1>):
    %4 = "spirv.LogicalNot"(%arg8) : (vector<4xi1>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, i1) -> (), sym_name = "logical_and_scalar"}> ({
  ^bb0(%arg6: i1, %arg7: i1):
    %3 = "spirv.LogicalAnd"(%arg6, %arg7) : (i1, i1) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi1>, vector<4xi1>) -> (), sym_name = "logical_and_vector"}> ({
  ^bb0(%arg4: vector<4xi1>, %arg5: vector<4xi1>):
    %2 = "spirv.LogicalAnd"(%arg4, %arg5) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, i1) -> (), sym_name = "logical_or_scalar"}> ({
  ^bb0(%arg2: i1, %arg3: i1):
    %1 = "spirv.LogicalOr"(%arg2, %arg3) : (i1, i1) -> i1
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xi1>, vector<4xi1>) -> (), sym_name = "logical_or_vector"}> ({
  ^bb0(%arg0: vector<4xi1>, %arg1: vector<4xi1>):
    %0 = "spirv.LogicalOr"(%arg0, %arg1) : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

