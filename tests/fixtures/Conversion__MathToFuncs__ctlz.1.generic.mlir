"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "main"}> ({
  ^bb0(%arg0: i32):
    %0 = "math.ctlz"(%arg0) : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> (), sym_name = "main"}> ({
  ^bb0(%arg0: i8):
    %0 = "math.ctlz"(%arg0) : (i8) -> i8
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "ctlz_index"}> ({
  ^bb0(%arg0: index):
    %0 = "math.ctlz"(%arg0) : (index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

