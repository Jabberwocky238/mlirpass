"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64, i64) -> i64, sym_name = "_mlir_apfloat_add", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> f8E4M3FN, sym_name = "foo"}> ({
    %21 = "arith.constant"() <{value = 2.250000e+00 : f8E4M3FN}> : () -> f8E4M3FN
    "func.return"(%21) : (f8E4M3FN) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f6E3M2FN, sym_name = "bar"}> ({
    %20 = "arith.constant"() <{value = 3.000000e+00 : f6E3M2FN}> : () -> f6E3M2FN
    "func.return"(%20) : (f6E3M2FN) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "full_example"}> ({
    %0 = "arith.constant"() <{value = 1.375000e+00 : f8E4M3FN}> : () -> f8E4M3FN
    %1 = "func.call"() <{callee = @foo}> : () -> f8E4M3FN
    %2 = "arith.bitcast"(%0) : (f8E4M3FN) -> i8
    %3 = "arith.extui"(%2) : (i8) -> i64
    %4 = "arith.bitcast"(%1) : (f8E4M3FN) -> i8
    %5 = "arith.extui"(%4) : (i8) -> i64
    %6 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %7 = "func.call"(%6, %3, %5) <{callee = @_mlir_apfloat_add}> : (i32, i64, i64) -> i64
    %8 = "arith.trunci"(%7) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i8
    %9 = "arith.bitcast"(%8) : (i8) -> f8E4M3FN
    "vector.print"(%9) <{punctuation = #vector.punctuation<newline>}> : (f8E4M3FN) -> ()
    %10 = "arith.constant"() <{value = 2.500000e+00 : f6E3M2FN}> : () -> f6E3M2FN
    %11 = "func.call"() <{callee = @bar}> : () -> f6E3M2FN
    %12 = "arith.bitcast"(%10) : (f6E3M2FN) -> i6
    %13 = "arith.extui"(%12) : (i6) -> i64
    %14 = "arith.bitcast"(%11) : (f6E3M2FN) -> i6
    %15 = "arith.extui"(%14) : (i6) -> i64
    %16 = "arith.constant"() <{value = 16 : i32}> : () -> i32
    %17 = "func.call"(%16, %13, %15) <{callee = @_mlir_apfloat_add}> : (i32, i64, i64) -> i64
    %18 = "arith.trunci"(%17) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i6
    %19 = "arith.bitcast"(%18) : (i6) -> f6E3M2FN
    "vector.print"(%19) <{punctuation = #vector.punctuation<newline>}> : (f6E3M2FN) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64, i64) -> i64, sym_name = "_mlir_apfloat_add", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN) -> (), sym_name = "addf"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN):
    %0 = "arith.bitcast"(%arg0) : (f4E2M1FN) -> i4
    %1 = "arith.extui"(%0) : (i4) -> i64
    %2 = "arith.bitcast"(%arg1) : (f4E2M1FN) -> i4
    %3 = "arith.extui"(%2) : (i4) -> i64
    %4 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %5 = "func.call"(%4, %1, %3) <{callee = @_mlir_apfloat_add}> : (i32, i64, i64) -> i64
    %6 = "arith.trunci"(%5) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    %7 = "arith.bitcast"(%6) : (i4) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64, i64) -> i64, sym_name = "_mlir_apfloat_subtract", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN) -> (), sym_name = "subf"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN):
    %0 = "arith.bitcast"(%arg0) : (f4E2M1FN) -> i4
    %1 = "arith.extui"(%0) : (i4) -> i64
    %2 = "arith.bitcast"(%arg1) : (f4E2M1FN) -> i4
    %3 = "arith.extui"(%2) : (i4) -> i64
    %4 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %5 = "func.call"(%4, %1, %3) <{callee = @_mlir_apfloat_subtract}> : (i32, i64, i64) -> i64
    %6 = "arith.trunci"(%5) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    %7 = "arith.bitcast"(%6) : (i4) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64, i64) -> i64, sym_name = "_mlir_apfloat_multiply", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN) -> (), sym_name = "subf"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN):
    %0 = "arith.bitcast"(%arg0) : (f4E2M1FN) -> i4
    %1 = "arith.extui"(%0) : (i4) -> i64
    %2 = "arith.bitcast"(%arg1) : (f4E2M1FN) -> i4
    %3 = "arith.extui"(%2) : (i4) -> i64
    %4 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %5 = "func.call"(%4, %1, %3) <{callee = @_mlir_apfloat_multiply}> : (i32, i64, i64) -> i64
    %6 = "arith.trunci"(%5) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    %7 = "arith.bitcast"(%6) : (i4) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64, i64) -> i64, sym_name = "_mlir_apfloat_divide", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN) -> (), sym_name = "subf"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN):
    %0 = "arith.bitcast"(%arg0) : (f4E2M1FN) -> i4
    %1 = "arith.extui"(%0) : (i4) -> i64
    %2 = "arith.bitcast"(%arg1) : (f4E2M1FN) -> i4
    %3 = "arith.extui"(%2) : (i4) -> i64
    %4 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %5 = "func.call"(%4, %1, %3) <{callee = @_mlir_apfloat_divide}> : (i32, i64, i64) -> i64
    %6 = "arith.trunci"(%5) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    %7 = "arith.bitcast"(%6) : (i4) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64, i64) -> i64, sym_name = "_mlir_apfloat_remainder", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN) -> (), sym_name = "remf"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN):
    %0 = "arith.bitcast"(%arg0) : (f4E2M1FN) -> i4
    %1 = "arith.extui"(%0) : (i4) -> i64
    %2 = "arith.bitcast"(%arg1) : (f4E2M1FN) -> i4
    %3 = "arith.extui"(%2) : (i4) -> i64
    %4 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %5 = "func.call"(%4, %1, %3) <{callee = @_mlir_apfloat_remainder}> : (i32, i64, i64) -> i64
    %6 = "arith.trunci"(%5) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    %7 = "arith.bitcast"(%6) : (i4) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i64) -> i64, sym_name = "_mlir_apfloat_convert", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f4E2M1FN) -> (), sym_name = "extf"}> ({
  ^bb0(%arg0: f4E2M1FN):
    %0 = "arith.bitcast"(%arg0) : (f4E2M1FN) -> i4
    %1 = "arith.extui"(%0) : (i4) -> i64
    %2 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %4 = "func.call"(%2, %3, %1) <{callee = @_mlir_apfloat_convert}> : (i32, i32, i64) -> i64
    %5 = "arith.trunci"(%4) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %6 = "arith.bitcast"(%5) : (i32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i64) -> i64, sym_name = "_mlir_apfloat_convert", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> (), sym_name = "truncf"}> ({
  ^bb0(%arg0: bf16):
    %0 = "arith.bitcast"(%arg0) : (bf16) -> i16
    %1 = "arith.extui"(%0) : (i16) -> i64
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %4 = "func.call"(%2, %3, %1) <{callee = @_mlir_apfloat_convert}> : (i32, i32, i64) -> i64
    %5 = "arith.trunci"(%4) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    %6 = "arith.bitcast"(%5) : (i4) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i1, i64) -> i64, sym_name = "_mlir_apfloat_convert_to_int", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> (), sym_name = "fptosi"}> ({
  ^bb0(%arg0: f16):
    %0 = "arith.bitcast"(%arg0) : (f16) -> i16
    %1 = "arith.extui"(%0) : (i16) -> i64
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = false}> : () -> i1
    %5 = "func.call"(%2, %3, %4, %1) <{callee = @_mlir_apfloat_convert_to_int}> : (i32, i32, i1, i64) -> i64
    %6 = "arith.trunci"(%5) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i1, i64) -> i64, sym_name = "_mlir_apfloat_convert_to_int", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> (), sym_name = "fptoui"}> ({
  ^bb0(%arg0: f16):
    %0 = "arith.bitcast"(%arg0) : (f16) -> i16
    %1 = "arith.extui"(%0) : (i16) -> i64
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = true}> : () -> i1
    %5 = "func.call"(%2, %3, %4, %1) <{callee = @_mlir_apfloat_convert_to_int}> : (i32, i32, i1, i64) -> i64
    %6 = "arith.trunci"(%5) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i1, i64) -> i64, sym_name = "_mlir_apfloat_convert_from_int", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "sitofp"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.extsi"(%arg0) : (i32) -> i64
    %1 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = false}> : () -> i1
    %4 = "func.call"(%1, %2, %3, %0) <{callee = @_mlir_apfloat_convert_from_int}> : (i32, i32, i1, i64) -> i64
    %5 = "arith.trunci"(%4) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    %6 = "arith.bitcast"(%5) : (i4) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i1, i64) -> i64, sym_name = "_mlir_apfloat_convert_from_int", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "uitofp"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.extui"(%arg0) : (i32) -> i64
    %1 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = true}> : () -> i1
    %4 = "func.call"(%1, %2, %3, %0) <{callee = @_mlir_apfloat_convert_from_int}> : (i32, i32, i1, i64) -> i64
    %5 = "arith.trunci"(%4) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    %6 = "arith.bitcast"(%5) : (i4) -> f4E2M1FN
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64, i64) -> i8, sym_name = "_mlir_apfloat_compare", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f4E2M1FN, f4E2M1FN) -> (), sym_name = "cmpf"}> ({
  ^bb0(%arg0: f4E2M1FN, %arg1: f4E2M1FN):
    %0 = "arith.bitcast"(%arg0) : (f4E2M1FN) -> i4
    %1 = "arith.extui"(%0) : (i4) -> i64
    %2 = "arith.bitcast"(%arg1) : (f4E2M1FN) -> i4
    %3 = "arith.extui"(%2) : (i4) -> i64
    %4 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %5 = "func.call"(%4, %1, %3) <{callee = @_mlir_apfloat_compare}> : (i32, i64, i64) -> i8
    %6 = "arith.constant"() <{value = 3 : i8}> : () -> i8
    %7 = "arith.cmpi"(%5, %6) <{predicate = 0 : i64}> : (i8, i8) -> i1
    %8 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %9 = "arith.cmpi"(%5, %8) <{predicate = 0 : i64}> : (i8, i8) -> i1
    %10 = "arith.ori"(%7, %9) : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64) -> i64, sym_name = "_mlir_apfloat_neg", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "negf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.bitcast"(%arg0) : (f32) -> i32
    %1 = "arith.extui"(%0) : (i32) -> i64
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "func.call"(%2, %1) <{callee = @_mlir_apfloat_neg}> : (i32, i64) -> i64
    %4 = "arith.trunci"(%3) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %5 = "arith.bitcast"(%4) : (i32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64, i64) -> i64, sym_name = "_mlir_apfloat_minimum", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "minimumf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.bitcast"(%arg0) : (f32) -> i32
    %1 = "arith.extui"(%0) : (i32) -> i64
    %2 = "arith.bitcast"(%arg1) : (f32) -> i32
    %3 = "arith.extui"(%2) : (i32) -> i64
    %4 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %5 = "func.call"(%4, %1, %3) <{callee = @_mlir_apfloat_minimum}> : (i32, i64, i64) -> i64
    %6 = "arith.trunci"(%5) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %7 = "arith.bitcast"(%6) : (i32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64, i64) -> i64, sym_name = "_mlir_apfloat_maximum", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "maximumf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.bitcast"(%arg0) : (f32) -> i32
    %1 = "arith.extui"(%0) : (i32) -> i64
    %2 = "arith.bitcast"(%arg1) : (f32) -> i32
    %3 = "arith.extui"(%2) : (i32) -> i64
    %4 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %5 = "func.call"(%4, %1, %3) <{callee = @_mlir_apfloat_maximum}> : (i32, i64, i64) -> i64
    %6 = "arith.trunci"(%5) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %7 = "arith.bitcast"(%6) : (i32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64, i64) -> i64, sym_name = "_mlir_apfloat_minnum", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "minnumf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.bitcast"(%arg0) : (f32) -> i32
    %1 = "arith.extui"(%0) : (i32) -> i64
    %2 = "arith.bitcast"(%arg1) : (f32) -> i32
    %3 = "arith.extui"(%2) : (i32) -> i64
    %4 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %5 = "func.call"(%4, %1, %3) <{callee = @_mlir_apfloat_minnum}> : (i32, i64, i64) -> i64
    %6 = "arith.trunci"(%5) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %7 = "arith.bitcast"(%6) : (i32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i64, i64) -> i64, sym_name = "_mlir_apfloat_maxnum", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "maxnumf"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.bitcast"(%arg0) : (f32) -> i32
    %1 = "arith.extui"(%0) : (i32) -> i64
    %2 = "arith.bitcast"(%arg1) : (f32) -> i32
    %3 = "arith.extui"(%2) : (i32) -> i64
    %4 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %5 = "func.call"(%4, %1, %3) <{callee = @_mlir_apfloat_maxnum}> : (i32, i64, i64) -> i64
    %6 = "arith.trunci"(%5) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %7 = "arith.bitcast"(%6) : (i32) -> f32
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
  "func.func"() <{function_type = (i32, i64, i64) -> i64, sym_name = "_mlir_apfloat_add", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf4E2M1FN>, vector<4xf4E2M1FN>) -> (), sym_name = "addf_vector"}> ({
  ^bb0(%arg0: vector<4xf4E2M1FN>, %arg1: vector<4xf4E2M1FN>):
    %0:4 = "vector.to_elements"(%arg0) : (vector<4xf4E2M1FN>) -> (f4E2M1FN, f4E2M1FN, f4E2M1FN, f4E2M1FN)
    %1:4 = "vector.to_elements"(%arg1) : (vector<4xf4E2M1FN>) -> (f4E2M1FN, f4E2M1FN, f4E2M1FN, f4E2M1FN)
    %2 = "arith.bitcast"(%0#0) : (f4E2M1FN) -> i4
    %3 = "arith.extui"(%2) : (i4) -> i64
    %4 = "arith.bitcast"(%1#0) : (f4E2M1FN) -> i4
    %5 = "arith.extui"(%4) : (i4) -> i64
    %6 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %7 = "func.call"(%6, %3, %5) <{callee = @_mlir_apfloat_add}> : (i32, i64, i64) -> i64
    %8 = "arith.trunci"(%7) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    %9 = "arith.bitcast"(%8) : (i4) -> f4E2M1FN
    %10 = "arith.bitcast"(%0#1) : (f4E2M1FN) -> i4
    %11 = "arith.extui"(%10) : (i4) -> i64
    %12 = "arith.bitcast"(%1#1) : (f4E2M1FN) -> i4
    %13 = "arith.extui"(%12) : (i4) -> i64
    %14 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %15 = "func.call"(%14, %11, %13) <{callee = @_mlir_apfloat_add}> : (i32, i64, i64) -> i64
    %16 = "arith.trunci"(%15) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    %17 = "arith.bitcast"(%16) : (i4) -> f4E2M1FN
    %18 = "arith.bitcast"(%0#2) : (f4E2M1FN) -> i4
    %19 = "arith.extui"(%18) : (i4) -> i64
    %20 = "arith.bitcast"(%1#2) : (f4E2M1FN) -> i4
    %21 = "arith.extui"(%20) : (i4) -> i64
    %22 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %23 = "func.call"(%22, %19, %21) <{callee = @_mlir_apfloat_add}> : (i32, i64, i64) -> i64
    %24 = "arith.trunci"(%23) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    %25 = "arith.bitcast"(%24) : (i4) -> f4E2M1FN
    %26 = "arith.bitcast"(%0#3) : (f4E2M1FN) -> i4
    %27 = "arith.extui"(%26) : (i4) -> i64
    %28 = "arith.bitcast"(%1#3) : (f4E2M1FN) -> i4
    %29 = "arith.extui"(%28) : (i4) -> i64
    %30 = "arith.constant"() <{value = 18 : i32}> : () -> i32
    %31 = "func.call"(%30, %27, %29) <{callee = @_mlir_apfloat_add}> : (i32, i64, i64) -> i64
    %32 = "arith.trunci"(%31) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i4
    %33 = "arith.bitcast"(%32) : (i4) -> f4E2M1FN
    %34 = "vector.from_elements"(%9, %17, %25, %33) : (f4E2M1FN, f4E2M1FN, f4E2M1FN, f4E2M1FN) -> vector<4xf4E2M1FN>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

