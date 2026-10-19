"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf32>, vector<4xi1>, vector<4xi64>, vector<4xi64>) -> vector<4xf32>, sym_name = "vector_ops"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xi1>, %arg2: vector<4xi64>, %arg3: vector<4xi64>):
    %0 = "llvm.mlir.constant"() <{value = dense<4.200000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "llvm.fadd"(%arg0, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %2 = "llvm.sdiv"(%arg2, %arg2) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %3 = "llvm.udiv"(%arg2, %arg2) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %4 = "llvm.srem"(%arg2, %arg2) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %5 = "llvm.urem"(%arg2, %arg2) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %6 = "llvm.fdiv"(%arg0, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %7 = "llvm.frem"(%arg0, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %8 = "llvm.and"(%arg2, %arg3) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %9 = "llvm.or"(%arg2, %arg3) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %10 = "llvm.xor"(%arg2, %arg3) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %11 = "llvm.shl"(%arg2, %arg2) <{overflowFlags = 0 : i32}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %12 = "llvm.ashr"(%arg2, %arg2) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %13 = "llvm.lshr"(%arg2, %arg2) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, i32, i32, f64) -> (f32, i32), sym_name = "ops"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: i32, %arg3: i32, %arg4: f64):
    %0 = "llvm.fsub"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %1 = "llvm.sub"(%arg2, %arg3) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %2 = "llvm.icmp"(%arg2, %1) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %3 = "llvm.icmp"(%arg2, %1) <{predicate = 3 : i64}> : (i32, i32) -> i1
    %4 = "llvm.icmp"(%arg2, %1) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %5 = "llvm.icmp"(%arg2, %1) <{predicate = 6 : i64}> : (i32, i32) -> i1
    %6 = "llvm.icmp"(%arg2, %1) <{predicate = 7 : i64}> : (i32, i32) -> i1
    %7 = "llvm.icmp"(%arg2, %1) <{predicate = 8 : i64}> : (i32, i32) -> i1
    %8 = "llvm.icmp"(%arg2, %1) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %9 = "llvm.sdiv"(%arg2, %arg3) : (i32, i32) -> i32
    %10 = "llvm.udiv"(%arg2, %arg3) : (i32, i32) -> i32
    %11 = "llvm.srem"(%arg2, %arg3) : (i32, i32) -> i32
    %12 = "llvm.urem"(%arg2, %arg3) : (i32, i32) -> i32
    %13 = "llvm.fdiv"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %14 = "llvm.frem"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %15 = "llvm.and"(%arg2, %arg3) : (i32, i32) -> i32
    %16 = "llvm.or"(%arg2, %arg3) : (i32, i32) -> i32
    %17 = "llvm.xor"(%arg2, %arg3) : (i32, i32) -> i32
    %18 = "llvm.mlir.constant"() <{value = 7.900000e-01 : f64}> : () -> f64
    %19 = "llvm.shl"(%arg2, %arg3) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %20 = "llvm.ashr"(%arg2, %arg3) : (i32, i32) -> i32
    %21 = "llvm.lshr"(%arg2, %arg3) : (i32, i32) -> i32
    %22 = "arith.constant"() <{value = 2.000000e+00 : tf32}> : () -> tf32
    "func.return"(%0, %10) : (f32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, i1) -> (), sym_name = "index_cast"}> ({
  ^bb0(%arg0: index, %arg1: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %1 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (i64) -> i1
    %2 = "llvm.sext"(%arg1) : (i1) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xindex>, vector<2xi1>) -> (), sym_name = "vector_index_cast"}> ({
  ^bb0(%arg0: vector<2xindex>, %arg1: vector<2xi1>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2xindex>) -> vector<2xi64>
    %1 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (vector<2xi64>) -> vector<2xi1>
    %2 = "llvm.sext"(%arg1) : (vector<2xi1>) -> vector<2xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, i1) -> (), sym_name = "index_castui"}> ({
  ^bb0(%arg0: index, %arg1: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> i64
    %1 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (i64) -> i1
    %2 = "llvm.zext"(%arg1) : (i1) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xindex>, vector<2xi1>) -> (), sym_name = "vector_index_castui"}> ({
  ^bb0(%arg0: vector<2xindex>, %arg1: vector<2xi1>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<2xindex>) -> vector<2xi64>
    %1 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (vector<2xi64>) -> vector<2xi1>
    %2 = "llvm.zext"(%arg1) : (vector<2xi1>) -> vector<2xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64) -> (), sym_name = "sitofp"}> ({
  ^bb0(%arg0: i32, %arg1: i64):
    %0 = "llvm.sitofp"(%arg0) : (i32) -> f32
    %1 = "llvm.sitofp"(%arg0) : (i32) -> f64
    %2 = "llvm.sitofp"(%arg1) : (i64) -> f32
    %3 = "llvm.sitofp"(%arg1) : (i64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi16>, vector<2xi32>, vector<2xi64>) -> (), sym_name = "sitofp_vector"}> ({
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>, %arg2: vector<2xi64>):
    %0 = "llvm.sitofp"(%arg0) : (vector<2xi16>) -> vector<2xf32>
    %1 = "llvm.sitofp"(%arg0) : (vector<2xi16>) -> vector<2xf64>
    %2 = "llvm.sitofp"(%arg1) : (vector<2xi32>) -> vector<2xf32>
    %3 = "llvm.sitofp"(%arg1) : (vector<2xi32>) -> vector<2xf64>
    %4 = "llvm.sitofp"(%arg2) : (vector<2xi64>) -> vector<2xf32>
    %5 = "llvm.sitofp"(%arg2) : (vector<2xi64>) -> vector<2xf64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64) -> (), sym_name = "uitofp"}> ({
  ^bb0(%arg0: i32, %arg1: i64):
    %0 = "llvm.uitofp"(%arg0) : (i32) -> f32
    %1 = "llvm.uitofp"(%arg0) : (i32) -> f64
    %2 = "llvm.uitofp"(%arg1) : (i64) -> f32
    %3 = "llvm.uitofp"(%arg1) : (i64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16, f32) -> (), sym_name = "fpext"}> ({
  ^bb0(%arg0: f16, %arg1: f32):
    %0 = "llvm.fpext"(%arg0) : (f16) -> f32
    %1 = "llvm.fpext"(%arg0) : (f16) -> f64
    %2 = "llvm.fpext"(%arg1) : (f32) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf32>) -> (), sym_name = "fpext_vector"}> ({
  ^bb0(%arg0: vector<2xf16>, %arg1: vector<2xf32>):
    %0 = "llvm.fpext"(%arg0) : (vector<2xf16>) -> vector<2xf32>
    %1 = "llvm.fpext"(%arg0) : (vector<2xf16>) -> vector<2xf64>
    %2 = "llvm.fpext"(%arg1) : (vector<2xf32>) -> vector<2xf64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "fptosi"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.fptosi"(%arg0) : (f32) -> i32
    %1 = "llvm.fptosi"(%arg0) : (f32) -> i64
    %2 = "llvm.fptosi"(%arg1) : (f64) -> i32
    %3 = "llvm.fptosi"(%arg1) : (f64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf32>, vector<2xf64>) -> (), sym_name = "fptosi_vector"}> ({
  ^bb0(%arg0: vector<2xf16>, %arg1: vector<2xf32>, %arg2: vector<2xf64>):
    %0 = "llvm.fptosi"(%arg0) : (vector<2xf16>) -> vector<2xi32>
    %1 = "llvm.fptosi"(%arg0) : (vector<2xf16>) -> vector<2xi64>
    %2 = "llvm.fptosi"(%arg1) : (vector<2xf32>) -> vector<2xi32>
    %3 = "llvm.fptosi"(%arg1) : (vector<2xf32>) -> vector<2xi64>
    %4 = "llvm.fptosi"(%arg2) : (vector<2xf64>) -> vector<2xi32>
    %5 = "llvm.fptosi"(%arg2) : (vector<2xf64>) -> vector<2xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "fptoui"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.fptoui"(%arg0) : (f32) -> i32
    %1 = "llvm.fptoui"(%arg0) : (f32) -> i64
    %2 = "llvm.fptoui"(%arg1) : (f64) -> i32
    %3 = "llvm.fptoui"(%arg1) : (f64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf32>, vector<2xf64>) -> (), sym_name = "fptoui_vector"}> ({
  ^bb0(%arg0: vector<2xf16>, %arg1: vector<2xf32>, %arg2: vector<2xf64>):
    %0 = "llvm.fptoui"(%arg0) : (vector<2xf16>) -> vector<2xi32>
    %1 = "llvm.fptoui"(%arg0) : (vector<2xf16>) -> vector<2xi64>
    %2 = "llvm.fptoui"(%arg1) : (vector<2xf32>) -> vector<2xi32>
    %3 = "llvm.fptoui"(%arg1) : (vector<2xf32>) -> vector<2xi64>
    %4 = "llvm.fptoui"(%arg2) : (vector<2xf64>) -> vector<2xi32>
    %5 = "llvm.fptoui"(%arg2) : (vector<2xf64>) -> vector<2xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi16>, vector<2xi32>, vector<2xi64>) -> (), sym_name = "uitofp_vector"}> ({
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi32>, %arg2: vector<2xi64>):
    %0 = "llvm.uitofp"(%arg0) : (vector<2xi16>) -> vector<2xf32>
    %1 = "llvm.uitofp"(%arg0) : (vector<2xi16>) -> vector<2xf64>
    %2 = "llvm.uitofp"(%arg1) : (vector<2xi32>) -> vector<2xf32>
    %3 = "llvm.uitofp"(%arg1) : (vector<2xi32>) -> vector<2xf64>
    %4 = "llvm.uitofp"(%arg2) : (vector<2xi64>) -> vector<2xf32>
    %5 = "llvm.uitofp"(%arg2) : (vector<2xi64>) -> vector<2xf64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "fptrunc"}> ({
  ^bb0(%arg0: f32, %arg1: f64):
    %0 = "llvm.fptrunc"(%arg0) : (f32) -> f16
    %1 = "llvm.fptrunc"(%arg1) : (f64) -> f16
    %2 = "llvm.fptrunc"(%arg1) : (f64) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>, vector<2xf64>) -> (), sym_name = "fptrunc_vector"}> ({
  ^bb0(%arg0: vector<2xf32>, %arg1: vector<2xf64>):
    %0 = "llvm.fptrunc"(%arg0) : (vector<2xf32>) -> vector<2xf16>
    %1 = "llvm.fptrunc"(%arg1) : (vector<2xf64>) -> vector<2xf16>
    %2 = "llvm.fptrunc"(%arg1) : (vector<2xf64>) -> vector<2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "experimental_constrained_fptrunc"}> ({
  ^bb0(%arg0: f64):
    %0 = "llvm.intr.experimental.constrained.fptrunc"(%arg0) <{fpExceptionBehavior = 0 : i64, roundingmode = 1 : i64}> : (f64) -> f32
    %1 = "llvm.intr.experimental.constrained.fptrunc"(%arg0) <{fpExceptionBehavior = 0 : i64, roundingmode = 3 : i64}> : (f64) -> f32
    %2 = "llvm.intr.experimental.constrained.fptrunc"(%arg0) <{fpExceptionBehavior = 0 : i64, roundingmode = 2 : i64}> : (f64) -> f32
    %3 = "llvm.intr.experimental.constrained.fptrunc"(%arg0) <{fpExceptionBehavior = 0 : i64, roundingmode = 0 : i64}> : (f64) -> f32
    %4 = "llvm.intr.experimental.constrained.fptrunc"(%arg0) <{fpExceptionBehavior = 0 : i64, roundingmode = 4 : i64}> : (f64) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i3) -> (), sym_name = "integer_extension_and_truncation"}> ({
  ^bb0(%arg0: i3):
    %0 = "llvm.sext"(%arg0) : (i3) -> i6
    %1 = "llvm.zext"(%arg0) : (i3) -> i6
    %2 = "llvm.trunc"(%arg0) <{overflowFlags = 0 : i32}> : (i3) -> i2
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<i3>) -> (), sym_name = "integer_cast_0d_vector"}> ({
  ^bb0(%arg0: vector<i3>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<i3>) -> vector<1xi3>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<i3>) -> vector<1xi3>
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<i3>) -> vector<1xi3>
    %3 = "llvm.sext"(%2) : (vector<1xi3>) -> vector<1xi6>
    %4 = "llvm.zext"(%1) : (vector<1xi3>) -> vector<1xi6>
    %5 = "llvm.trunc"(%0) <{overflowFlags = 0 : i32}> : (vector<1xi3>) -> vector<1xi2>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "fcmp"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    %1 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
    %2 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 3 : i64}> : (f32, f32) -> i1
    %3 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %4 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 5 : i64}> : (f32, f32) -> i1
    %5 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    %6 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    %7 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 8 : i64}> : (f32, f32) -> i1
    %8 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 9 : i64}> : (f32, f32) -> i1
    %9 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 10 : i64}> : (f32, f32) -> i1
    %10 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 11 : i64}> : (f32, f32) -> i1
    %11 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 12 : i64}> : (f32, f32) -> i1
    %12 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 13 : i64}> : (f32, f32) -> i1
    %13 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    %14 = "llvm.fcmp"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>, predicate = 1 : i64}> : (f32, f32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xindex>) -> (), sym_name = "index_vector"}> ({
  ^bb0(%arg0: vector<4xindex>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4xindex>) -> vector<4xi64>
    %1 = "llvm.mlir.constant"() <{value = dense<[0, 1, 2, 3]> : vector<4xindex>}> : () -> vector<4xi64>
    %2 = "llvm.add"(%0, %1) <{overflowFlags = 0 : i32}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf32>) -> (), sym_name = "bitcast_1d"}> ({
  ^bb0(%arg0: vector<2xf32>):
    %0 = "llvm.bitcast"(%arg0) : (vector<2xf32>) -> vector<2xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (i32, i1), sym_name = "addui_extended_scalar"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %3 = "llvm.intr.uadd.with.overflow"(%arg2, %arg3) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = "llvm.extractvalue"(%3) <{position = array<i64: 0>}> : (!llvm.struct<(i32, i1)>) -> i32
    %5 = "llvm.extractvalue"(%3) <{position = array<i64: 1>}> : (!llvm.struct<(i32, i1)>) -> i1
    "func.return"(%4, %5) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi16>, vector<3xi16>) -> (vector<3xi16>, vector<3xi1>), sym_name = "addui_extended_vector1d"}> ({
  ^bb0(%arg0: vector<3xi16>, %arg1: vector<3xi16>):
    %0 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (vector<3xi16>, vector<3xi16>) -> !llvm.struct<(vector<3xi16>, vector<3xi1>)>
    %1 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.struct<(vector<3xi16>, vector<3xi1>)>) -> vector<3xi16>
    %2 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.struct<(vector<3xi16>, vector<3xi1>)>) -> vector<3xi1>
    "func.return"(%1, %2) : (vector<3xi16>, vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "mulsi_extended_scalar"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %7 = "llvm.sext"(%arg2) : (i32) -> i64
    %8 = "llvm.sext"(%arg3) : (i32) -> i64
    %9 = "llvm.mul"(%7, %8) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %10 = "llvm.trunc"(%9) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %11 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
    %12 = "llvm.lshr"(%9, %11) : (i64, i64) -> i64
    %13 = "llvm.trunc"(%12) <{overflowFlags = 0 : i32}> : (i64) -> i32
    "func.return"(%10, %13) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> (vector<3xi64>, vector<3xi64>), sym_name = "mulsi_extended_vector1d"}> ({
  ^bb0(%arg0: vector<3xi64>, %arg1: vector<3xi64>):
    %0 = "llvm.sext"(%arg0) : (vector<3xi64>) -> vector<3xi128>
    %1 = "llvm.sext"(%arg1) : (vector<3xi64>) -> vector<3xi128>
    %2 = "llvm.mul"(%0, %1) <{overflowFlags = 0 : i32}> : (vector<3xi128>, vector<3xi128>) -> vector<3xi128>
    %3 = "llvm.trunc"(%2) <{overflowFlags = 0 : i32}> : (vector<3xi128>) -> vector<3xi64>
    %4 = "llvm.mlir.constant"() <{value = dense<64> : vector<3xi128>}> : () -> vector<3xi128>
    %5 = "llvm.lshr"(%2, %4) : (vector<3xi128>, vector<3xi128>) -> vector<3xi128>
    %6 = "llvm.trunc"(%5) <{overflowFlags = 0 : i32}> : (vector<3xi128>) -> vector<3xi64>
    "func.return"(%3, %6) : (vector<3xi64>, vector<3xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "mului_extended_scalar"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %7 = "llvm.zext"(%arg2) : (i32) -> i64
    %8 = "llvm.zext"(%arg3) : (i32) -> i64
    %9 = "llvm.mul"(%7, %8) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %10 = "llvm.trunc"(%9) <{overflowFlags = 0 : i32}> : (i64) -> i32
    %11 = "llvm.mlir.constant"() <{value = 32 : i64}> : () -> i64
    %12 = "llvm.lshr"(%9, %11) : (i64, i64) -> i64
    %13 = "llvm.trunc"(%12) <{overflowFlags = 0 : i32}> : (i64) -> i32
    "func.return"(%10, %13) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> (vector<3xi64>, vector<3xi64>), sym_name = "mului_extended_vector1d"}> ({
  ^bb0(%arg0: vector<3xi64>, %arg1: vector<3xi64>):
    %0 = "llvm.zext"(%arg0) : (vector<3xi64>) -> vector<3xi128>
    %1 = "llvm.zext"(%arg1) : (vector<3xi64>) -> vector<3xi128>
    %2 = "llvm.mul"(%0, %1) <{overflowFlags = 0 : i32}> : (vector<3xi128>, vector<3xi128>) -> vector<3xi128>
    %3 = "llvm.trunc"(%2) <{overflowFlags = 0 : i32}> : (vector<3xi128>) -> vector<3xi64>
    %4 = "llvm.mlir.constant"() <{value = dense<64> : vector<3xi128>}> : () -> vector<3xi128>
    %5 = "llvm.lshr"(%2, %4) : (vector<3xi128>, vector<3xi128>) -> vector<3xi128>
    %6 = "llvm.trunc"(%5) <{overflowFlags = 0 : i32}> : (vector<3xi128>) -> vector<3xi64>
    "func.return"(%3, %6) : (vector<3xi64>, vector<3xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xf32>, vector<4x3xf32>) -> (), sym_name = "cmpf_2dvector"}> ({
  ^bb0(%arg0: vector<4x3xf32>, %arg1: vector<4x3xf32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x3xf32>) -> !llvm.array<4 x vector<3xf32>>
    %2 = "llvm.mlir.poison"() : () -> !llvm.array<4 x vector<3xi1>>
    %3 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %5 = "llvm.fcmp"(%3, %4) <{fastmathFlags = #llvm.fastmath<none>, predicate = 4 : i64}> : (vector<3xf32>, vector<3xf32>) -> vector<3xi1>
    %6 = "llvm.insertvalue"(%2, %5) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xi1>>, vector<3xi1>) -> !llvm.array<4 x vector<3xi1>>
    %7 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %9 = "llvm.fcmp"(%7, %8) <{fastmathFlags = #llvm.fastmath<none>, predicate = 4 : i64}> : (vector<3xf32>, vector<3xf32>) -> vector<3xi1>
    %10 = "llvm.insertvalue"(%6, %9) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xi1>>, vector<3xi1>) -> !llvm.array<4 x vector<3xi1>>
    %11 = "llvm.extractvalue"(%1) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %12 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %13 = "llvm.fcmp"(%11, %12) <{fastmathFlags = #llvm.fastmath<none>, predicate = 4 : i64}> : (vector<3xf32>, vector<3xf32>) -> vector<3xi1>
    %14 = "llvm.insertvalue"(%10, %13) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xi1>>, vector<3xi1>) -> !llvm.array<4 x vector<3xi1>>
    %15 = "llvm.extractvalue"(%1) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %16 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xf32>>) -> vector<3xf32>
    %17 = "llvm.fcmp"(%15, %16) <{fastmathFlags = #llvm.fastmath<none>, predicate = 4 : i64}> : (vector<3xf32>, vector<3xf32>) -> vector<3xi1>
    %18 = "llvm.insertvalue"(%14, %17) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xi1>>, vector<3xi1>) -> !llvm.array<4 x vector<3xi1>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<i32>, vector<i32>) -> (), sym_name = "cmpi_0dvector"}> ({
  ^bb0(%arg0: vector<i32>, %arg1: vector<i32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<i32>) -> vector<1xi32>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<i32>) -> vector<1xi32>
    %2 = "llvm.icmp"(%1, %0) <{predicate = 6 : i64}> : (vector<1xi32>, vector<1xi32>) -> vector<1xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4x3xi32>, vector<4x3xi32>) -> (), sym_name = "cmpi_2dvector"}> ({
  ^bb0(%arg0: vector<4x3xi32>, %arg1: vector<4x3xi32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4x3xi32>) -> !llvm.array<4 x vector<3xi32>>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4x3xi32>) -> !llvm.array<4 x vector<3xi32>>
    %2 = "llvm.mlir.poison"() : () -> !llvm.array<4 x vector<3xi1>>
    %3 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %4 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %5 = "llvm.icmp"(%3, %4) <{predicate = 6 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    %6 = "llvm.insertvalue"(%2, %5) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<3xi1>>, vector<3xi1>) -> !llvm.array<4 x vector<3xi1>>
    %7 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %8 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %9 = "llvm.icmp"(%7, %8) <{predicate = 6 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    %10 = "llvm.insertvalue"(%6, %9) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<3xi1>>, vector<3xi1>) -> !llvm.array<4 x vector<3xi1>>
    %11 = "llvm.extractvalue"(%1) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %12 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %13 = "llvm.icmp"(%11, %12) <{predicate = 6 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    %14 = "llvm.insertvalue"(%10, %13) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<3xi1>>, vector<3xi1>) -> !llvm.array<4 x vector<3xi1>>
    %15 = "llvm.extractvalue"(%1) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %16 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xi32>>) -> vector<3xi32>
    %17 = "llvm.icmp"(%15, %16) <{predicate = 6 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    %18 = "llvm.insertvalue"(%14, %17) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<3xi1>>, vector<3xi1>) -> !llvm.array<4 x vector<3xi1>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i32, i32) -> i32, sym_name = "select"}> ({
  ^bb0(%arg3: i1, %arg4: i32, %arg5: i32):
    %4 = "llvm.select"(%arg3, %arg4, %arg5) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, complex<f32>, complex<f32>) -> complex<f32>, sym_name = "select_complex"}> ({
  ^bb0(%arg0: i1, %arg1: complex<f32>, %arg2: complex<f32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (complex<f32>) -> !llvm.struct<(f32, f32)>
    %2 = "llvm.select"(%arg0, %1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, !llvm.struct<(f32, f32)>, !llvm.struct<(f32, f32)>) -> !llvm.struct<(f32, f32)>
    %3 = "builtin.unrealized_conversion_cast"(%2) : (!llvm.struct<(f32, f32)>) -> complex<f32>
    "func.return"(%3) : (complex<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "ceildivsi"}> ({
  ^bb0(%arg1: i64, %arg2: i64):
    %7 = "llvm.mlir.constant"() <{value = 0 : i64}> : () -> i64
    %8 = "llvm.mlir.constant"() <{value = 1 : i64}> : () -> i64
    %9 = "llvm.sdiv"(%arg1, %arg2) : (i64, i64) -> i64
    %10 = "llvm.mul"(%9, %arg2) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %11 = "llvm.icmp"(%arg1, %10) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %12 = "llvm.icmp"(%arg1, %7) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %13 = "llvm.icmp"(%arg2, %7) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %14 = "llvm.icmp"(%12, %13) <{predicate = 0 : i64}> : (i1, i1) -> i1
    %15 = "llvm.and"(%11, %14) : (i1, i1) -> i1
    %16 = "llvm.add"(%9, %8) <{overflowFlags = 0 : i32}> : (i64, i64) -> i64
    %17 = "llvm.select"(%15, %16, %9) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    "func.return"(%17) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "ceildivui"}> ({
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "llvm.icmp"(%arg0, %0) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "llvm.sub"(%arg0, %2) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %4 = "llvm.udiv"(%3, %arg0) : (i32, i32) -> i32
    %5 = "llvm.add"(%4, %2) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %6 = "llvm.select"(%1, %0, %5) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "floordivsi"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "llvm.sdiv"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "llvm.mul"(%0, %arg1) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %2 = "llvm.icmp"(%arg0, %1) <{predicate = 1 : i64}> : (i32, i32) -> i1
    %3 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "llvm.icmp"(%arg0, %3) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %5 = "llvm.icmp"(%arg1, %3) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %6 = "llvm.icmp"(%4, %5) <{predicate = 1 : i64}> : (i1, i1) -> i1
    %7 = "llvm.and"(%2, %6) : (i1, i1) -> i1
    %8 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
    %9 = "llvm.add"(%0, %8) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %10 = "llvm.select"(%7, %9, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "func.return"(%10) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "minmaxi"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %4 = "llvm.intr.smin"(%arg2, %arg3) : (i32, i32) -> i32
    %5 = "llvm.intr.smax"(%arg2, %arg3) : (i32, i32) -> i32
    %6 = "llvm.intr.umin"(%arg2, %arg3) : (i32, i32) -> i32
    %7 = "llvm.intr.umax"(%arg2, %arg3) : (i32, i32) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "minmaxf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "llvm.intr.minimum"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %1 = "llvm.intr.maximum"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %2 = "llvm.intr.minnum"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %3 = "llvm.intr.maxnum"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, i32) -> (), sym_name = "fastmath"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: i32):
    %0 = "llvm.fadd"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, f32) -> f32
    %1 = "llvm.fmul"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, f32) -> f32
    %2 = "llvm.fneg"(%arg0) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32) -> f32
    %3 = "llvm.fadd"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %4 = "llvm.fadd"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<nnan, ninf>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, i32) -> (), sym_name = "ops_supporting_fastmath"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: i32):
    %0 = "llvm.fadd"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, f32) -> f32
    %1 = "llvm.fdiv"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, f32) -> f32
    %2 = "llvm.intr.maximum"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, f32) -> f32
    %3 = "llvm.intr.minimum"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, f32) -> f32
    %4 = "llvm.fmul"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, f32) -> f32
    %5 = "llvm.fneg"(%arg0) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32) -> f32
    %6 = "llvm.frem"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, f32) -> f32
    %7 = "llvm.fsub"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64, i64) -> (), sym_name = "ops_supporting_overflow"}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.add"(%arg0, %arg1) <{overflowFlags = 1 : i32}> : (i64, i64) -> i64
    %1 = "llvm.sub"(%arg0, %arg1) <{overflowFlags = 2 : i32}> : (i64, i64) -> i64
    %2 = "llvm.mul"(%arg0, %arg1) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %3 = "llvm.shl"(%arg0, %arg1) <{overflowFlags = 3 : i32}> : (i64, i64) -> i64
    %4 = "llvm.trunc"(%arg0) <{overflowFlags = 3 : i32}> : (i64) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "ops_supporting_exact"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "llvm.ashr"(%arg0, %arg1) <{isExact}> : (i32, i32) -> i32
    %1 = "llvm.lshr"(%arg0, %arg1) <{isExact}> : (i32, i32) -> i32
    %2 = "llvm.sdiv"(%arg0, %arg1) <{isExact}> : (i32, i32) -> i32
    %3 = "llvm.udiv"(%arg0, %arg1) <{isExact}> : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi16>) -> memref<?xbf16>, sym_name = "memref_bitcast"}> ({
  ^bb0(%arg0: memref<?xi16>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<?xi16>) -> !llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (!llvm.struct<(ptr, ptr, i64, array<1 x i64>, array<1 x i64>)>) -> memref<?xbf16>
    "func.return"(%1) : (memref<?xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f4E2M1FN, vector<4xf4E2M1FN>, vector<8x4xf4E2M1FN>, f4E2M1FN, i1) -> (), sym_name = "unsupported_fp_type"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: vector<4xf4E2M1FN>, %arg2: vector<8x4xf4E2M1FN>, %arg3: f4E2M1FN, %arg4: i1):
    %0 = "builtin.unrealized_conversion_cast"(%arg3) : (f4E2M1FN) -> i4
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (f4E2M1FN) -> i4
    %2 = "arith.addf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f4E2M1FN, f4E2M1FN) -> f4E2M1FN
    %3 = "arith.addf"(%arg1, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf4E2M1FN>, vector<4xf4E2M1FN>) -> vector<4xf4E2M1FN>
    %4 = "arith.addf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<8x4xf4E2M1FN>, vector<8x4xf4E2M1FN>) -> vector<8x4xf4E2M1FN>
    %5 = "arith.cmpf"(%arg0, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f4E2M1FN, f4E2M1FN) -> i1
    %6 = "llvm.select"(%arg4, %1, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i4, i4) -> i4
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>, vector<4x8xf32>, f32) -> (), sym_name = "supported_fp_type"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4x8xf32>, %arg3: f32):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<4x8xf32>) -> !llvm.array<4 x vector<8xf32>>
    %1 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<4x8xf32>) -> !llvm.array<4 x vector<8xf32>>
    %2 = "llvm.fadd"(%arg0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, f32) -> f32
    %3 = "llvm.fadd"(%arg1, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %4 = "llvm.mlir.poison"() : () -> !llvm.array<4 x vector<8xf32>>
    %5 = "llvm.extractvalue"(%1) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<8xf32>>) -> vector<8xf32>
    %6 = "llvm.extractvalue"(%0) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<8xf32>>) -> vector<8xf32>
    %7 = "llvm.fadd"(%5, %6) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %8 = "llvm.insertvalue"(%4, %7) <{position = array<i64: 0>}> : (!llvm.array<4 x vector<8xf32>>, vector<8xf32>) -> !llvm.array<4 x vector<8xf32>>
    %9 = "llvm.extractvalue"(%1) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<8xf32>>) -> vector<8xf32>
    %10 = "llvm.extractvalue"(%0) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<8xf32>>) -> vector<8xf32>
    %11 = "llvm.fadd"(%9, %10) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %12 = "llvm.insertvalue"(%8, %11) <{position = array<i64: 1>}> : (!llvm.array<4 x vector<8xf32>>, vector<8xf32>) -> !llvm.array<4 x vector<8xf32>>
    %13 = "llvm.extractvalue"(%1) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<8xf32>>) -> vector<8xf32>
    %14 = "llvm.extractvalue"(%0) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<8xf32>>) -> vector<8xf32>
    %15 = "llvm.fadd"(%13, %14) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %16 = "llvm.insertvalue"(%12, %15) <{position = array<i64: 2>}> : (!llvm.array<4 x vector<8xf32>>, vector<8xf32>) -> !llvm.array<4 x vector<8xf32>>
    %17 = "llvm.extractvalue"(%1) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<8xf32>>) -> vector<8xf32>
    %18 = "llvm.extractvalue"(%0) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<8xf32>>) -> vector<8xf32>
    %19 = "llvm.fadd"(%17, %18) <{fastmathFlags = #llvm.fastmath<none>}> : (vector<8xf32>, vector<8xf32>) -> vector<8xf32>
    %20 = "llvm.insertvalue"(%16, %19) <{position = array<i64: 3>}> : (!llvm.array<4 x vector<8xf32>>, vector<8xf32>) -> !llvm.array<4 x vector<8xf32>>
    %21 = "llvm.fcmp"(%arg0, %arg3) <{fastmathFlags = #llvm.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

