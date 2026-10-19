"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<4xi1>, vector<4xi64>, vector<4xi64>) -> vector<4xf32>, sym_name = "vector_ops"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xi1>, %arg2: vector<4xi64>, %arg3: vector<4xi64>):
    %0 = "arith.constant"() <{value = dense<4.200000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "arith.addf"(%arg0, %0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %2 = "arith.divsi"(%arg2, %arg2) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %3 = "arith.divui"(%arg2, %arg2) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %4 = "arith.remsi"(%arg2, %arg2) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %5 = "arith.remui"(%arg2, %arg2) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %6 = "arith.divf"(%arg0, %0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %7 = "arith.remf"(%arg0, %0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %8 = "arith.andi"(%arg2, %arg3) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %9 = "arith.ori"(%arg2, %arg3) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %10 = "arith.xori"(%arg2, %arg3) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %11 = "arith.shli"(%arg2, %arg2) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %12 = "arith.shrsi"(%arg2, %arg2) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %13 = "arith.shrui"(%arg2, %arg2) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, i32, i32, f64) -> (f32, i32), sym_name = "ops"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: i32, %arg3: i32, %arg4: f64):
    %0 = "arith.subf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %1 = "arith.subi"(%arg2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "arith.cmpi"(%arg2, %1) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %3 = "arith.cmpi"(%arg2, %1) <{predicate = 3 : i64}> : (i32, i32) -> i1
    %4 = "arith.cmpi"(%arg2, %1) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %5 = "arith.cmpi"(%arg2, %1) <{predicate = 6 : i64}> : (i32, i32) -> i1
    %6 = "arith.cmpi"(%arg2, %1) <{predicate = 7 : i64}> : (i32, i32) -> i1
    %7 = "arith.cmpi"(%arg2, %1) <{predicate = 8 : i64}> : (i32, i32) -> i1
    %8 = "arith.cmpi"(%arg2, %1) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %9 = "arith.divsi"(%arg2, %arg3) : (i32, i32) -> i32
    %10 = "arith.divui"(%arg2, %arg3) : (i32, i32) -> i32
    %11 = "arith.remsi"(%arg2, %arg3) : (i32, i32) -> i32
    %12 = "arith.remui"(%arg2, %arg3) : (i32, i32) -> i32
    %13 = "arith.divf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %14 = "arith.remf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %15 = "arith.andi"(%arg2, %arg3) : (i32, i32) -> i32
    %16 = "arith.ori"(%arg2, %arg3) : (i32, i32) -> i32
    %17 = "arith.xori"(%arg2, %arg3) : (i32, i32) -> i32
    %18 = "arith.constant"() <{value = 7.900000e-01 : f64}> : () -> f64
    %19 = "arith.shli"(%arg2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %20 = "arith.shrsi"(%arg2, %arg3) : (i32, i32) -> i32
    %21 = "arith.shrui"(%arg2, %arg3) : (i32, i32) -> i32
    %22 = "arith.constant"() <{value = 2.000000e+00 : tf32}> : () -> tf32
    "func.return"(%0, %10) : (f32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, i1) -> (), sym_name = "index_cast"}> ({
  ^bb0(%arg0: index, %arg1: i1):
    %0 = "arith.index_cast"(%arg0) : (index) -> i1
    %1 = "arith.index_cast"(%arg1) : (i1) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xindex>, vector<2xi1>) -> (), sym_name = "vector_index_cast"}> ({
  ^bb0(%arg0: vector<2xindex>, %arg1: vector<2xi1>):
    %0 = "arith.index_cast"(%arg0) : (vector<2xindex>) -> vector<2xi1>
    %1 = "arith.index_cast"(%arg1) : (vector<2xi1>) -> vector<2xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, i1) -> (), sym_name = "index_castui"}> ({
  ^bb0(%arg0: index, %arg1: i1):
    %0 = "arith.index_castui"(%arg0) : (index) -> i1
    %1 = "arith.index_castui"(%arg1) : (i1) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xindex>, vector<2xi1>) -> (), sym_name = "vector_index_castui"}> ({
  ^bb0(%arg0: vector<2xindex>, %arg1: vector<2xi1>):
    %0 = "arith.index_castui"(%arg0) : (vector<2xindex>) -> vector<2xi1>
    %1 = "arith.index_castui"(%arg1) : (vector<2xi1>) -> vector<2xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64) -> (), sym_name = "sitofp"}> ({
  ^bb0(%arg0: i32, %arg1: i64):
    %0 = "arith.sitofp"(%arg0) : (i32) -> f32
    %1 = "arith.sitofp"(%arg0) : (i32) -> f64
    %2 = "arith.sitofp"(%arg1) : (i64) -> f32
    %3 = "arith.sitofp"(%arg1) : (i64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi16>, vector<2xi32>, vector<2xi64>) -> (), sym_name = "sitofp_vector"}> ({
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>, %arg2: vector<2xi64>):
    %0 = "arith.sitofp"(%arg0) : (vector<2xi16>) -> vector<2xf32>
    %1 = "arith.sitofp"(%arg0) : (vector<2xi16>) -> vector<2xf64>
    %2 = "arith.sitofp"(%arg1) : (vector<2xi32>) -> vector<2xf32>
    %3 = "arith.sitofp"(%arg1) : (vector<2xi32>) -> vector<2xf64>
    %4 = "arith.sitofp"(%arg2) : (vector<2xi64>) -> vector<2xf32>
    %5 = "arith.sitofp"(%arg2) : (vector<2xi64>) -> vector<2xf64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64) -> (), sym_name = "uitofp"}> ({
  ^bb0(%arg0: i32, %arg1: i64):
    %0 = "arith.uitofp"(%arg0) : (i32) -> f32
    %1 = "arith.uitofp"(%arg0) : (i32) -> f64
    %2 = "arith.uitofp"(%arg1) : (i64) -> f32
    %3 = "arith.uitofp"(%arg1) : (i64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16, f32) -> (), sym_name = "fpext"}> ({
  ^bb0(%arg0: f16, %arg1: f32):
    %0 = "arith.extf"(%arg0) : (f16) -> f32
    %1 = "arith.extf"(%arg0) : (f16) -> f64
    %2 = "arith.extf"(%arg1) : (f32) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf32>) -> (), sym_name = "fpext_vector"}> ({
  ^bb0(%arg0: vector<2xf16>, %arg1: vector<2xf32>):
    %0 = "arith.extf"(%arg0) : (vector<2xf16>) -> vector<2xf32>
    %1 = "arith.extf"(%arg0) : (vector<2xf16>) -> vector<2xf64>
    %2 = "arith.extf"(%arg1) : (vector<2xf32>) -> vector<2xf64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "fptosi"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "arith.fptosi"(%arg0) : (f32) -> i32
    %1 = "arith.fptosi"(%arg0) : (f32) -> i64
    %2 = "arith.fptosi"(%arg1) : (f64) -> i32
    %3 = "arith.fptosi"(%arg1) : (f64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf32>, vector<2xf64>) -> (), sym_name = "fptosi_vector"}> ({
  ^bb0(%arg0: vector<2xf16>, %arg1: vector<2xf32>, %arg2: vector<2xf64>):
    %0 = "arith.fptosi"(%arg0) : (vector<2xf16>) -> vector<2xi32>
    %1 = "arith.fptosi"(%arg0) : (vector<2xf16>) -> vector<2xi64>
    %2 = "arith.fptosi"(%arg1) : (vector<2xf32>) -> vector<2xi32>
    %3 = "arith.fptosi"(%arg1) : (vector<2xf32>) -> vector<2xi64>
    %4 = "arith.fptosi"(%arg2) : (vector<2xf64>) -> vector<2xi32>
    %5 = "arith.fptosi"(%arg2) : (vector<2xf64>) -> vector<2xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "fptoui"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "arith.fptoui"(%arg0) : (f32) -> i32
    %1 = "arith.fptoui"(%arg0) : (f32) -> i64
    %2 = "arith.fptoui"(%arg1) : (f64) -> i32
    %3 = "arith.fptoui"(%arg1) : (f64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf32>, vector<2xf64>) -> (), sym_name = "fptoui_vector"}> ({
  ^bb0(%arg0: vector<2xf16>, %arg1: vector<2xf32>, %arg2: vector<2xf64>):
    %0 = "arith.fptoui"(%arg0) : (vector<2xf16>) -> vector<2xi32>
    %1 = "arith.fptoui"(%arg0) : (vector<2xf16>) -> vector<2xi64>
    %2 = "arith.fptoui"(%arg1) : (vector<2xf32>) -> vector<2xi32>
    %3 = "arith.fptoui"(%arg1) : (vector<2xf32>) -> vector<2xi64>
    %4 = "arith.fptoui"(%arg2) : (vector<2xf64>) -> vector<2xi32>
    %5 = "arith.fptoui"(%arg2) : (vector<2xf64>) -> vector<2xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi16>, vector<2xi32>, vector<2xi64>) -> (), sym_name = "uitofp_vector"}> ({
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>, %arg2: vector<2xi64>):
    %0 = "arith.uitofp"(%arg0) : (vector<2xi16>) -> vector<2xf32>
    %1 = "arith.uitofp"(%arg0) : (vector<2xi16>) -> vector<2xf64>
    %2 = "arith.uitofp"(%arg1) : (vector<2xi32>) -> vector<2xf32>
    %3 = "arith.uitofp"(%arg1) : (vector<2xi32>) -> vector<2xf64>
    %4 = "arith.uitofp"(%arg2) : (vector<2xi64>) -> vector<2xf32>
    %5 = "arith.uitofp"(%arg2) : (vector<2xi64>) -> vector<2xf64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "fptrunc"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "arith.truncf"(%arg0) : (f32) -> f16
    %1 = "arith.truncf"(%arg1) : (f64) -> f16
    %2 = "arith.truncf"(%arg1) : (f64) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (), sym_name = "fptrunc_vector"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf64>):
    %0 = "arith.truncf"(%arg0) : (vector<2xf32>) -> vector<2xf16>
    %1 = "arith.truncf"(%arg1) : (vector<2xf64>) -> vector<2xf16>
    %2 = "arith.truncf"(%arg1) : (vector<2xf64>) -> vector<2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "experimental_constrained_fptrunc"}> ({
  ^bb0(%arg0: f64):
    %0 = "arith.truncf"(%arg0) <{roundingmode = 0 : i32}> : (f64) -> f32
    %1 = "arith.truncf"(%arg0) <{roundingmode = 1 : i32}> : (f64) -> f32
    %2 = "arith.truncf"(%arg0) <{roundingmode = 2 : i32}> : (f64) -> f32
    %3 = "arith.truncf"(%arg0) <{roundingmode = 3 : i32}> : (f64) -> f32
    %4 = "arith.truncf"(%arg0) <{roundingmode = 4 : i32}> : (f64) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i3) -> (), sym_name = "integer_extension_and_truncation"}> ({
  ^bb0(%arg0: i3):
    %0 = "arith.extsi"(%arg0) : (i3) -> i6
    %1 = "arith.extui"(%arg0) : (i3) -> i6
    %2 = "arith.trunci"(%arg0) <{overflowFlags = #arith.overflow<none>}> : (i3) -> i2
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<i3>) -> (), sym_name = "integer_cast_0d_vector"}> ({
  ^bb0(%arg0: vector<i3>):
    %0 = "arith.extsi"(%arg0) : (vector<i3>) -> vector<i6>
    %1 = "arith.extui"(%arg0) : (vector<i3>) -> vector<i6>
    %2 = "arith.trunci"(%arg0) <{overflowFlags = #arith.overflow<none>}> : (vector<i3>) -> vector<i2>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "fcmp"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %1 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
    %2 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (f32, f32) -> i1
    %3 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %4 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 5 : i64}> : (f32, f32) -> i1
    %5 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %6 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %7 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 8 : i64}> : (f32, f32) -> i1
    %8 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 9 : i64}> : (f32, f32) -> i1
    %9 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 10 : i64}> : (f32, f32) -> i1
    %10 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 11 : i64}> : (f32, f32) -> i1
    %11 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 12 : i64}> : (f32, f32) -> i1
    %12 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 13 : i64}> : (f32, f32) -> i1
    %13 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %14 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<fast>, predicate = 1 : i64}> : (f32, f32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xindex>) -> (), sym_name = "index_vector"}> ({
  ^bb0(%arg0: vector<4xindex>):
    %0 = "arith.constant"() <{value = dense<[0, 1, 2, 3]> : vector<4xindex>}> : () -> vector<4xindex>
    %1 = "arith.addi"(%arg0, %0) <{overflowFlags = #arith.overflow<none>}> : (vector<4xindex>, vector<4xindex>) -> vector<4xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> (), sym_name = "bitcast_1d"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "arith.bitcast"(%arg0) : (vector<2xf32>) -> vector<2xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (i32, i1), sym_name = "addui_extended_scalar"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %1:2 = "arith.addui_extended"(%arg2, %arg3) : (i32, i32) -> (i32, i1)
    "func.return"(%1#0, %1#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi16>, vector<3xi16>) -> (vector<3xi16>, vector<3xi1>), sym_name = "addui_extended_vector1d"}> ({
  ^bb0(%arg0: vector<3xi16>, %arg1: vector<3xi16>):
    %0:2 = "arith.addui_extended"(%arg0, %arg1) : (vector<3xi16>, vector<3xi16>) -> (vector<3xi16>, vector<3xi1>)
    "func.return"(%0#0, %0#1) : (vector<3xi16>, vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "mulsi_extended_scalar"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %1:2 = "arith.mulsi_extended"(%arg2, %arg3) : (i32, i32) -> (i32, i32)
    "func.return"(%1#0, %1#1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> (vector<3xi64>, vector<3xi64>), sym_name = "mulsi_extended_vector1d"}> ({
  ^bb0(%arg0: vector<3xi64>, %arg1: vector<3xi64>):
    %0:2 = "arith.mulsi_extended"(%arg0, %arg1) : (vector<3xi64>, vector<3xi64>) -> (vector<3xi64>, vector<3xi64>)
    "func.return"(%0#0, %0#1) : (vector<3xi64>, vector<3xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "mului_extended_scalar"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %1:2 = "arith.mului_extended"(%arg2, %arg3) : (i32, i32) -> (i32, i32)
    "func.return"(%1#0, %1#1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> (vector<3xi64>, vector<3xi64>), sym_name = "mului_extended_vector1d"}> ({
  ^bb0(%arg0: vector<3xi64>, %arg1: vector<3xi64>):
    %0:2 = "arith.mului_extended"(%arg0, %arg1) : (vector<3xi64>, vector<3xi64>) -> (vector<3xi64>, vector<3xi64>)
    "func.return"(%0#0, %0#1) : (vector<3xi64>, vector<3xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xf32>, vector<4x3xf32>) -> (), sym_name = "cmpf_2dvector"}> ({
  ^bb0(%arg0: vector<4x3xf32>, %arg1: vector<4x3xf32>):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (vector<4x3xf32>, vector<4x3xf32>) -> vector<4x3xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<i32>, vector<i32>) -> (), sym_name = "cmpi_0dvector"}> ({
  ^bb0(%arg0: vector<i32>, %arg1: vector<i32>):
    %0 = "arith.cmpi"(%arg0, %arg1) <{predicate = 6 : i64}> : (vector<i32>, vector<i32>) -> vector<i1>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xi32>, vector<4x3xi32>) -> (), sym_name = "cmpi_2dvector"}> ({
  ^bb0(%arg0: vector<4x3xi32>, %arg1: vector<4x3xi32>):
    %0 = "arith.cmpi"(%arg0, %arg1) <{predicate = 6 : i64}> : (vector<4x3xi32>, vector<4x3xi32>) -> vector<4x3xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i32, i32) -> i32, sym_name = "select"}> ({
  ^bb0(%arg3: i1, %arg4: i32, %arg5: i32):
    %1 = "arith.select"(%arg3, %arg4, %arg5) : (i1, i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, complex<f32>, complex<f32>) -> complex<f32>, sym_name = "select_complex"}> ({
  ^bb0(%arg0: i1, %arg1: complex<f32>, %arg2: complex<f32>):
    %0 = "arith.select"(%arg0, %arg1, %arg2) : (i1, complex<f32>, complex<f32>) -> complex<f32>
    "func.return"(%0) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "ceildivsi"}> ({
  ^bb0(%arg1: i64, %arg2: i64):
    %1 = "arith.ceildivsi"(%arg1, %arg2) : (i64, i64) -> i64
    "func.return"(%1) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "ceildivui"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.ceildivui"(%arg0, %arg0) : (i32, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "floordivsi"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.floordivsi"(%arg0, %arg1) : (i32, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "minmaxi"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %4 = "arith.minsi"(%arg2, %arg3) : (i32, i32) -> i32
    %5 = "arith.maxsi"(%arg2, %arg3) : (i32, i32) -> i32
    %6 = "arith.minui"(%arg2, %arg3) : (i32, i32) -> i32
    %7 = "arith.maxui"(%arg2, %arg3) : (i32, i32) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "minmaxf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.minimumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %1 = "arith.maximumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %2 = "arith.minnumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %3 = "arith.maxnumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, i32) -> (), sym_name = "fastmath"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: i32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
    %1 = "arith.mulf"(%arg0, %arg1) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
    %2 = "arith.negf"(%arg0) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
    %3 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %4 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<nnan,ninf>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, i32) -> (), sym_name = "ops_supporting_fastmath"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: i32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
    %1 = "arith.divf"(%arg0, %arg1) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
    %2 = "arith.maximumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
    %3 = "arith.minimumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
    %4 = "arith.mulf"(%arg0, %arg1) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
    %5 = "arith.negf"(%arg0) <{fastmath = #arith.fastmath<fast>}> : (f32) -> f32
    %6 = "arith.remf"(%arg0, %arg1) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
    %7 = "arith.subf"(%arg0, %arg1) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> (), sym_name = "ops_supporting_overflow"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nsw>}> : (i64, i64) -> i64
    %1 = "arith.subi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nuw>}> : (i64, i64) -> i64
    %2 = "arith.muli"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %3 = "arith.shli"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %4 = "arith.trunci"(%arg0) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (i64) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "ops_supporting_exact"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.shrsi"(%arg0, %arg1) <{isExact}> : (i32, i32) -> i32
    %1 = "arith.shrui"(%arg0, %arg1) <{isExact}> : (i32, i32) -> i32
    %2 = "arith.divsi"(%arg0, %arg1) <{isExact}> : (i32, i32) -> i32
    %3 = "arith.divui"(%arg0, %arg1) <{isExact}> : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi16>) -> memref<?xbf16>, sym_name = "memref_bitcast"}> ({
  ^bb0(%arg0: memref<?xi16>):
    %0 = "arith.bitcast"(%arg0) : (memref<?xi16>) -> memref<?xbf16>
    "func.return"(%0) : (memref<?xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f4E2M1FN, vector<4xf4E2M1FN>, vector<8x4xf4E2M1FN>, f4E2M1FN, i1) -> (), sym_name = "unsupported_fp_type"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: vector<4xf4E2M1FN>, %arg2: vector<8x4xf4E2M1FN>, %arg3: f4E2M1FN, %arg4: i1):
    %0 = "arith.addf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f4E2M1FN, f4E2M1FN) -> f4E2M1FN
    %1 = "arith.addf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf4E2M1FN>, vector<4xf4E2M1FN>) -> vector<4xf4E2M1FN>
    %2 = "arith.addf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<8x4xf4E2M1FN>, vector<8x4xf4E2M1FN>) -> vector<8x4xf4E2M1FN>
    %3 = "arith.cmpf"(%arg0, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f4E2M1FN, f4E2M1FN) -> i1
    %4 = "arith.select"(%arg4, %arg0, %arg3) : (i1, f4E2M1FN, f4E2M1FN) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>, vector<4x8xf32>, f32) -> (), sym_name = "supported_fp_type"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4x8xf32>, %arg3: f32):
    %0 = "arith.addf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %1 = "arith.addf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %2 = "arith.addf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<4x8xf32>, vector<4x8xf32>) -> vector<4x8xf32>
    %3 = "arith.cmpf"(%arg0, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

