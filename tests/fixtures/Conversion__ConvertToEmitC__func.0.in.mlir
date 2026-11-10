"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "int"}> ({
  ^bb0(%arg2: i32):
    "func.return"(%arg2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "index"}> ({
  ^bb0(%arg1: index):
    "func.return"(%arg1) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "call_with_one_result"}> ({
  ^bb0(%arg0: index):
    %0 = "func.call"(%arg0) <{callee = @index}> : (index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

