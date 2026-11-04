"builtin.module"() ({
  "func.func"() <{function_type = (f8E5M2FNUZ) -> f16, sym_name = "scalar_ext"}> ({
  ^bb0(%arg0: f8E5M2FNUZ):
    %0 = "arith.extf"(%arg0) : (f8E5M2FNUZ) -> f16
    "func.return"(%0) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<f8E5M2FNUZ>) -> vector<f32>, sym_name = "vector_zero_d"}> ({
  ^bb0(%arg0: vector<f8E5M2FNUZ>):
    %0 = "arith.extf"(%arg0) : (vector<f8E5M2FNUZ>) -> vector<f32>
    "func.return"(%0) : (vector<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf8E5M2FNUZ>) -> vector<2xf64>, sym_name = "vector_ext_short"}> ({
  ^bb0(%arg0: vector<2xf8E5M2FNUZ>):
    %0 = "arith.extf"(%arg0) : (vector<2xf8E5M2FNUZ>) -> vector<2xf64>
    "func.return"(%0) : (vector<2xf64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<9xf8E4M3FNUZ>) -> vector<9xf32>, sym_name = "vector_ext_long"}> ({
  ^bb0(%arg0: vector<9xf8E4M3FNUZ>):
    %0 = "arith.extf"(%arg0) : (vector<9xf8E4M3FNUZ>) -> vector<9xf32>
    "func.return"(%0) : (vector<9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> f8E5M2FNUZ, sym_name = "scalar_trunc"}> ({
  ^bb0(%arg0: f16):
    %0 = "arith.truncf"(%arg0) : (f16) -> f8E5M2FNUZ
    "func.return"(%0) : (f8E5M2FNUZ) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf64>) -> vector<2xf8E5M2FNUZ>, sym_name = "vector_trunc_short"}> ({
  ^bb0(%arg0: vector<2xf64>):
    %0 = "arith.truncf"(%arg0) : (vector<2xf64>) -> vector<2xf8E5M2FNUZ>
    "func.return"(%0) : (vector<2xf8E5M2FNUZ>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<9xf32>) -> vector<9xf8E4M3FNUZ>, sym_name = "vector_trunc_long"}> ({
  ^bb0(%arg0: vector<9xf32>):
    %0 = "arith.truncf"(%arg0) : (vector<9xf32>) -> vector<9xf8E4M3FNUZ>
    "func.return"(%0) : (vector<9xf8E4M3FNUZ>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x9xf32>) -> vector<1x9xf8E4M3FNUZ>, sym_name = "vector_trunc_long_2d"}> ({
  ^bb0(%arg0: vector<1x9xf32>):
    %0 = "arith.truncf"(%arg0) : (vector<1x9xf32>) -> vector<1x9xf8E4M3FNUZ>
    "func.return"(%0) : (vector<1x9xf8E4M3FNUZ>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1x11xf8E4M3FNUZ>) -> vector<1x11xf32>, sym_name = "vector_ext_long_2d"}> ({
  ^bb0(%arg0: vector<1x11xf8E4M3FNUZ>):
    %0 = "arith.extf"(%arg0) : (vector<1x11xf8E4M3FNUZ>) -> vector<1x11xf32>
    "func.return"(%0) : (vector<1x11xf32>) -> ()
  }) : () -> ()
}) : () -> ()

