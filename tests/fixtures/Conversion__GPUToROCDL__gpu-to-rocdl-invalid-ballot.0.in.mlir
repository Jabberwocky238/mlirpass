"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (i1) -> i8, sym_name = "ballot_i8"}> ({
    ^bb0(%arg0: i1):
      %0 = "gpu.ballot"(%arg0) : (i1) -> i8
      "func.return"(%0) : (i8) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (i1) -> i16, sym_name = "ballot_i16"}> ({
    ^bb0(%arg0: i1):
      %0 = "gpu.ballot"(%arg0) : (i1) -> i16
      "func.return"(%0) : (i16) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (i1) -> i48, sym_name = "ballot_i48"}> ({
    ^bb0(%arg0: i1):
      %0 = "gpu.ballot"(%arg0) : (i1) -> i48
      "func.return"(%0) : (i48) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = (i1) -> i128, sym_name = "ballot_i128"}> ({
    ^bb0(%arg0: i1):
      %0 = "gpu.ballot"(%arg0) : (i1) -> i128
      "func.return"(%0) : (i128) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

