"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> (), sym_name = "ipowi"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "math.ipowi"(%arg0, %arg1) : (i64, i64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8, i8) -> (), sym_name = "ipowi"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %0 = "math.ipowi"(%arg0, %arg1) : (i8, i8) -> i8
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x3xi64>, vector<2x3xi64>) -> (), sym_name = "ipowi_vec"}> ({
  ^bb0(%arg0: vector<2x3xi64>, %arg1: vector<2x3xi64>):
    %0 = "math.ipowi"(%arg0, %arg1) : (vector<2x3xi64>, vector<2x3xi64>) -> vector<2x3xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "ipowi_index"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "math.ipowi"(%arg0, %arg1) : (index, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

