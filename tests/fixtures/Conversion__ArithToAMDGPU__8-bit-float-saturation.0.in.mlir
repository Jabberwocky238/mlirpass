"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> f8E5M2FNUZ, sym_name = "scalar_trunc"}> ({
  ^bb0(%arg0: f16):
    %0 = "arith.truncf"(%arg0) : (f16) -> f8E5M2FNUZ
    "func.return"(%0) : (f8E5M2FNUZ) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<2xf8E4M3FNUZ>, sym_name = "vector_trunc_short"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "arith.truncf"(%arg0) : (vector<2xf32>) -> vector<2xf8E4M3FNUZ>
    "func.return"(%0) : (vector<2xf8E4M3FNUZ>) -> ()
  }) : () -> ()
}) : () -> ()

