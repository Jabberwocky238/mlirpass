"builtin.module"() ({
  "func.func"() <{function_type = () -> f8E4M3FN, sym_name = "foo"}> ({
    %7 = "arith.constant"() <{value = 2.250000e+00 : f8E4M3FN}> : () -> f8E4M3FN
    "func.return"(%7) : (f8E4M3FN) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f6E3M2FN, sym_name = "bar"}> ({
    %6 = "arith.constant"() <{value = 3.000000e+00 : f6E3M2FN}> : () -> f6E3M2FN
    "func.return"(%6) : (f6E3M2FN) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "full_example"}> ({
    %0 = "arith.constant"() <{value = 1.375000e+00 : f8E4M3FN}> : () -> f8E4M3FN
    %1 = "func.call"() <{callee = @foo}> : () -> f8E4M3FN
    %2 = "arith.addf"(%0, %1) <{fastmath = #arith.fastmath<none>}> : (f8E4M3FN, f8E4M3FN) -> f8E4M3FN
    "vector.print"(%2) <{punctuation = #vector.punctuation<newline>}> : (f8E4M3FN) -> ()
    %3 = "arith.constant"() <{value = 2.500000e+00 : f6E3M2FN}> : () -> f6E3M2FN
    %4 = "func.call"() <{callee = @bar}> : () -> f6E3M2FN
    %5 = "arith.addf"(%3, %4) <{fastmath = #arith.fastmath<none>}> : (f6E3M2FN, f6E3M2FN) -> f6E3M2FN
    "vector.print"(%5) <{punctuation = #vector.punctuation<newline>}> : (f6E3M2FN) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN) -> (), sym_name = "addf"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f4E2M1FN, f4E2M1FN) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, f32) -> index, sym_name = "_mlir_apfloat_add", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN) -> (), sym_name = "addf"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f4E2M1FN, f4E2M1FN) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN) -> (), sym_name = "subf"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN):
    %0 = "arith.subf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f4E2M1FN, f4E2M1FN) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN) -> (), sym_name = "subf"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN):
    %0 = "arith.mulf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f4E2M1FN, f4E2M1FN) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN) -> (), sym_name = "subf"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN):
    %0 = "arith.divf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f4E2M1FN, f4E2M1FN) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN) -> (), sym_name = "remf"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN):
    %0 = "arith.remf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f4E2M1FN, f4E2M1FN) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f4E2M1FN) -> (), sym_name = "extf"}> ({
  ^bb0(%arg0: f4E2M1FN):
    %0 = "arith.extf"(%arg0) : (f4E2M1FN) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (bf16) -> (), sym_name = "truncf"}> ({
  ^bb0(%arg0: bf16):
    %0 = "arith.truncf"(%arg0) : (bf16) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> (), sym_name = "fptosi"}> ({
  ^bb0(%arg0: f16):
    %0 = "arith.fptosi"(%arg0) : (f16) -> i4
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> (), sym_name = "fptoui"}> ({
  ^bb0(%arg0: f16):
    %0 = "arith.fptoui"(%arg0) : (f16) -> i4
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "sitofp"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.sitofp"(%arg0) : (i32) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "uitofp"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.uitofp"(%arg0) : (i32) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN) -> (), sym_name = "cmpf"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 11 : i64}> : (f4E2M1FN, f4E2M1FN) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "negf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.negf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "minimumf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.minimumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "maximumf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.maximumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "minnumf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.minnumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "maxnumf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.maxnumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f128, f128, f32) -> (), sym_name = "unsupported_bitwidth"}> ({
  ^bb0(%arg0: f128, %arg1: f128, %arg2: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f128, f128) -> f128
    %1 = "arith.negf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f128) -> f128
    %2 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 11 : i64}> : (f128, f128) -> i1
    %3 = "arith.extf"(%arg2) : (f32) -> f128
    %4 = "arith.truncf"(%arg0) : (f128) -> f32
    %5 = "arith.fptosi"(%arg0) : (f128) -> i32
    %6 = "arith.fptosi"(%arg2) : (f32) -> i92
    %7 = "arith.sitofp"(%2) : (i1) -> f128
    %8 = "arith.sitofp"(%6) : (i92) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf4E2M1FN>, vector<4xf4E2M1FN>) -> (), sym_name = "addf_vector"}> ({
  ^bb0(%arg0: vector<4xf4E2M1FN>, %arg1: vector<4xf4E2M1FN>):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf4E2M1FN>, vector<4xf4E2M1FN>) -> vector<4xf4E2M1FN>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

