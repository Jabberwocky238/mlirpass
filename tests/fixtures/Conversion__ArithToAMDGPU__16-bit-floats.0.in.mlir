"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f16, sym_name = "scalar_trunc"}> ({
  ^bb0(%arg2: f32):
    %2 = "arith.truncf"(%arg2) : (f32) -> f16
    "func.return"(%2) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>) -> vector<2xf16>, sym_name = "vector_trunc_short"}> ({
  ^bb0(%arg1: vector<2xf32>):
    %1 = "arith.truncf"(%arg1) : (vector<2xf32>) -> vector<2xf16>
    "func.return"(%1) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<9xf32>) -> vector<9xf16>, sym_name = "vector_trunc_long"}> ({
  ^bb0(%arg0: vector<9xf32>):
    %0 = "arith.truncf"(%arg0) : (vector<9xf32>) -> vector<9xf16>
    "func.return"(%0) : (vector<9xf16>) -> ()
  }) : () -> ()
}) : () -> ()

