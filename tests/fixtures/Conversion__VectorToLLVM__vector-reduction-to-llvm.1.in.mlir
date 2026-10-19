"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> f32, sym_name = "reduce_add_f32"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<16xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> f32, sym_name = "reduce_add_f32_always_reassoc"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<reassoc>, kind = #vector.kind<add>}> : (vector<16xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>) -> f32, sym_name = "reduce_mul_f32"}> ({
  ^bb0(%arg0: vector<16xf32>):
    %0 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<nnan,ninf>, kind = #vector.kind<mul>}> : (vector<16xf32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xi1>) -> f32, sym_name = "masked_reduce_add_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<16xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<16xf32>) -> f32
      "vector.yield"(%1) : (f32) -> ()
    }) : (vector<16xi1>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, vector<[16]xi1>) -> f32, sym_name = "masked_reduce_add_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: vector<[16]xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<[16]xf32>) -> f32
      "vector.yield"(%1) : (f32) -> ()
    }) : (vector<[16]xi1>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xi1>) -> f32, sym_name = "masked_reduce_mul_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<16xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<mul>}> : (vector<16xf32>) -> f32
      "vector.yield"(%1) : (f32) -> ()
    }) : (vector<16xi1>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xi1>) -> f32, sym_name = "masked_reduce_minf_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<16xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minnumf>}> : (vector<16xf32>) -> f32
      "vector.yield"(%1) : (f32) -> ()
    }) : (vector<16xi1>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[16]xf32>, vector<[16]xi1>) -> f32, sym_name = "masked_reduce_minf_f32_scalable"}> ({
  ^bb0(%arg0: vector<[16]xf32>, %arg1: vector<[16]xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minnumf>}> : (vector<[16]xf32>) -> f32
      "vector.yield"(%1) : (f32) -> ()
    }) : (vector<[16]xi1>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xi1>) -> f32, sym_name = "masked_reduce_maxf_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<16xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxnumf>}> : (vector<16xf32>) -> f32
      "vector.yield"(%1) : (f32) -> ()
    }) : (vector<16xi1>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xi1>) -> f32, sym_name = "masked_reduce_maximumf_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<16xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maximumf>}> : (vector<16xf32>) -> f32
      "vector.yield"(%1) : (f32) -> ()
    }) : (vector<16xi1>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<16xf32>, vector<16xi1>) -> f32, sym_name = "masked_reduce_minimumf_f32"}> ({
  ^bb0(%arg0: vector<16xf32>, %arg1: vector<16xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minimumf>}> : (vector<16xf32>) -> f32
      "vector.yield"(%1) : (f32) -> ()
    }) : (vector<16xi1>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_add_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<32xi8>) -> i8
      "vector.yield"(%1) : (i8) -> ()
    }) : (vector<32xi1>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[32]xi8>, vector<[32]xi1>) -> i8, sym_name = "masked_reduce_add_i8_scalable"}> ({
  ^bb0(%arg0: vector<[32]xi8>, %arg1: vector<[32]xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<add>}> : (vector<[32]xi8>) -> i8
      "vector.yield"(%1) : (i8) -> ()
    }) : (vector<[32]xi1>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_mul_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<mul>}> : (vector<32xi8>) -> i8
      "vector.yield"(%1) : (i8) -> ()
    }) : (vector<32xi1>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_minui_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minui>}> : (vector<32xi8>) -> i8
      "vector.yield"(%1) : (i8) -> ()
    }) : (vector<32xi1>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[32]xi8>, vector<[32]xi1>) -> i8, sym_name = "masked_reduce_minui_i8_scalable"}> ({
  ^bb0(%arg0: vector<[32]xi8>, %arg1: vector<[32]xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minui>}> : (vector<[32]xi8>) -> i8
      "vector.yield"(%1) : (i8) -> ()
    }) : (vector<[32]xi1>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_maxui_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxui>}> : (vector<32xi8>) -> i8
      "vector.yield"(%1) : (i8) -> ()
    }) : (vector<32xi1>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_minsi_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<minsi>}> : (vector<32xi8>) -> i8
      "vector.yield"(%1) : (i8) -> ()
    }) : (vector<32xi1>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_maxsi_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxsi>}> : (vector<32xi8>) -> i8
      "vector.yield"(%1) : (i8) -> ()
    }) : (vector<32xi1>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[32]xi8>, vector<[32]xi1>) -> i8, sym_name = "masked_reduce_maxsi_i8_scalable"}> ({
  ^bb0(%arg0: vector<[32]xi8>, %arg1: vector<[32]xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<maxsi>}> : (vector<[32]xi8>) -> i8
      "vector.yield"(%1) : (i8) -> ()
    }) : (vector<[32]xi1>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_or_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<or>}> : (vector<32xi8>) -> i8
      "vector.yield"(%1) : (i8) -> ()
    }) : (vector<32xi1>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_and_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<and>}> : (vector<32xi8>) -> i8
      "vector.yield"(%1) : (i8) -> ()
    }) : (vector<32xi1>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<32xi8>, vector<32xi1>) -> i8, sym_name = "masked_reduce_xor_i8"}> ({
  ^bb0(%arg0: vector<32xi8>, %arg1: vector<32xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<xor>}> : (vector<32xi8>) -> i8
      "vector.yield"(%1) : (i8) -> ()
    }) : (vector<32xi1>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<[32]xi8>, vector<[32]xi1>) -> i8, sym_name = "masked_reduce_xor_i8_scalable"}> ({
  ^bb0(%arg0: vector<[32]xi8>, %arg1: vector<[32]xi1>):
    %0 = "vector.mask"(%arg1) ({
      %1 = "vector.reduction"(%arg0) <{fastmath = #arith.fastmath<none>, kind = #vector.kind<xor>}> : (vector<[32]xi8>) -> i8
      "vector.yield"(%1) : (i8) -> ()
    }) : (vector<[32]xi1>) -> i8
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

