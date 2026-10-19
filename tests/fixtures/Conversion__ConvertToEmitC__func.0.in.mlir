"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "int"}> ({
  ^bb0(%arg1: i32):
    "func.return"(%arg1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "index"}> ({
  ^bb0(%arg0: index):
    "func.return"(%arg0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

