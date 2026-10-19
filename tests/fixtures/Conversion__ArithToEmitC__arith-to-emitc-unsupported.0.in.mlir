"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xi32>, sym_name = "arith_cast_tensor"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "arith.fptosi"(%arg0) : (tensor<5xf32>) -> tensor<5xi32>
    "func.return"(%0) : (tensor<5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<5xf32>) -> vector<5xi32>, sym_name = "arith_cast_vector"}> ({
  ^bb0(%arg0: vector<5xf32>):
    %0 = "arith.fptosi"(%arg0) : (vector<5xf32>) -> vector<5xi32>
    "func.return"(%0) : (vector<5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f80) -> i32, sym_name = "arith_cast_f80"}> ({
  ^bb0(%arg0: f80):
    %0 = "arith.fptosi"(%arg0) : (f80) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f128) -> i32, sym_name = "arith_cast_f128"}> ({
  ^bb0(%arg0: f128):
    %0 = "arith.fptosi"(%arg0) : (f128) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> f80, sym_name = "arith_cast_to_f80"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.sitofp"(%arg0) : (i32) -> f80
    "func.return"(%0) : (f80) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> f128, sym_name = "arith_cast_to_f128"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.sitofp"(%arg0) : (i32) -> f128
    "func.return"(%0) : (f128) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> i1, sym_name = "arith_cast_fptosi_i1"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.fptosi"(%arg0) : (f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> i1, sym_name = "arith_cast_fptoui_i1"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.fptoui"(%arg0) : (f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<5xf32>, vector<5xf32>) -> vector<5xi1>, sym_name = "arith_cmpf_vector"}> ({
  ^bb0(%arg0: vector<5xf32>, %arg1: vector<5xf32>):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (vector<5xf32>, vector<5xf32>) -> vector<5xi1>
    "func.return"(%0) : (vector<5xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, tensor<5xf32>) -> tensor<5xi1>, sym_name = "arith_cmpf_tensor"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: tensor<5xf32>):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xi1>
    "func.return"(%0) : (tensor<5xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f80) -> f80, sym_name = "arith_negf_f80"}> ({
  ^bb0(%arg0: f80):
    %0 = "arith.negf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f80) -> f80
    "func.return"(%0) : (f80) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<5xf32>, sym_name = "arith_negf_tensor"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "arith.negf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<5xf32>) -> vector<5xf32>, sym_name = "arith_negf_vector"}> ({
  ^bb0(%arg0: vector<5xf32>):
    %0 = "arith.negf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<5xf32>) -> vector<5xf32>
    "func.return"(%0) : (vector<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "arith_extsi_i1_to_i32"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.extsi"(%arg0) : (i1) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "arith_shli_i1"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "arith.shli"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "arith_shrsi_i1"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "arith.shrsi"(%arg0, %arg1) : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "arith_shrui_i1"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "arith.shrui"(%arg0, %arg1) : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<5xi32>, vector<5xi32>) -> vector<5xi32>, sym_name = "arith_divui_vector"}> ({
  ^bb0(%arg0: vector<5xi32>, %arg1: vector<5xi32>):
    %0 = "arith.divui"(%arg0, %arg1) : (vector<5xi32>, vector<5xi32>) -> vector<5xi32>
    "func.return"(%0) : (vector<5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<5xi32>, vector<5xi32>) -> vector<5xi32>, sym_name = "arith_remui_vector"}> ({
  ^bb0(%arg0: vector<5xi32>, %arg1: vector<5xi32>):
    %0 = "arith.remui"(%arg0, %arg1) : (vector<5xi32>, vector<5xi32>) -> vector<5xi32>
    "func.return"(%0) : (vector<5xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> f32, sym_name = "arith_truncf"}> ({
  ^bb0(%arg0: f64):
    %0 = "arith.truncf"(%arg0) <{roundingmode = 4 : i32}> : (f64) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f128, sym_name = "arith_extf_f128"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.extf"(%arg0) : (f32) -> f128
    "func.return"(%0) : (f128) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f128) -> f32, sym_name = "arith_truncf_f128"}> ({
  ^bb0(%arg0: f128):
    %0 = "arith.truncf"(%arg0) : (f128) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf64>, sym_name = "arith_extf_vector"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "arith.extf"(%arg0) : (vector<4xf32>) -> vector<4xf64>
    "func.return"(%0) : (vector<4xf64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf64>) -> vector<4xf32>, sym_name = "arith_truncf_vector"}> ({
  ^bb0(%arg0: vector<4xf64>):
    %0 = "arith.truncf"(%arg0) : (vector<4xf64>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

