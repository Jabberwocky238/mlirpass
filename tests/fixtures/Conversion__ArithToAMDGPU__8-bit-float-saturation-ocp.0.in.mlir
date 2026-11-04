"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> f8E5M2, sym_name = "scalar_trunc"}> ({
  ^bb0(%arg0: f16):
    %0 = "arith.truncf"(%arg0) : (f16) -> f8E5M2
    "func.return"(%0) : (f8E5M2) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> vector<2xf8E4M3FN>, sym_name = "vector_trunc_short"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "arith.truncf"(%arg0) : (vector<2xf32>) -> vector<2xf8E4M3FN>
    "func.return"(%0) : (vector<2xf8E4M3FN>) -> ()
  }) : () -> ()
}) : () -> ()

