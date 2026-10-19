"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "arith_constants"}> ({
    %0 = "emitc.constant"() <{value = 0 : index}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "emitc.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "emitc.constant"() <{value = dense<0> : tensor<i32>}> : () -> tensor<i32>
    %4 = "emitc.constant"() <{value = dense<[[1, 2], [-3, 9], [0, 0], [2, -1]]> : tensor<4x2xi64>}> : () -> tensor<4x2xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "arith_ops"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.add"(%arg0, %arg1) : (f32, f32) -> f32
    %1 = "emitc.div"(%arg0, %arg1) : (f32, f32) -> f32
    %2 = "emitc.mul"(%arg0, %arg1) : (f32, f32) -> f32
    %3 = "emitc.sub"(%arg0, %arg1) : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_integer_ops"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "emitc.cast"(%arg0) : (i32) -> ui32
    %1 = "emitc.cast"(%arg1) : (i32) -> ui32
    %2 = "emitc.add"(%0, %1) : (ui32, ui32) -> ui32
    %3 = "emitc.cast"(%2) : (ui32) -> i32
    %4 = "emitc.cast"(%arg0) : (i32) -> ui32
    %5 = "emitc.cast"(%arg1) : (i32) -> ui32
    %6 = "emitc.sub"(%4, %5) : (ui32, ui32) -> ui32
    %7 = "emitc.cast"(%6) : (ui32) -> i32
    %8 = "emitc.cast"(%arg0) : (i32) -> ui32
    %9 = "emitc.cast"(%arg1) : (i32) -> ui32
    %10 = "emitc.mul"(%8, %9) : (ui32, ui32) -> ui32
    %11 = "emitc.cast"(%10) : (ui32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_integer_ops_signed_nsw"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "emitc.add"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "emitc.sub"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "emitc.mul"(%arg0, %arg1) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_index"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "emitc.cast"(%arg0) : (i32) -> !emitc.ptrdiff_t
    %1 = "emitc.cast"(%0) : (!emitc.ptrdiff_t) -> !emitc.size_t
    %2 = "emitc.cast"(%arg1) : (i32) -> !emitc.ptrdiff_t
    %3 = "emitc.cast"(%2) : (!emitc.ptrdiff_t) -> !emitc.size_t
    %4 = "emitc.add"(%1, %3) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %5 = "emitc.sub"(%1, %3) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %6 = "emitc.mul"(%1, %3) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_bitwise"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "emitc.cast"(%arg0) : (i32) -> ui32
    %1 = "emitc.cast"(%arg1) : (i32) -> ui32
    %2 = "emitc.bitwise_and"(%0, %1) : (ui32, ui32) -> ui32
    %3 = "emitc.cast"(%2) : (ui32) -> i32
    %4 = "emitc.cast"(%arg0) : (i32) -> ui32
    %5 = "emitc.cast"(%arg1) : (i32) -> ui32
    %6 = "emitc.bitwise_or"(%4, %5) : (ui32, ui32) -> ui32
    %7 = "emitc.cast"(%6) : (ui32) -> i32
    %8 = "emitc.cast"(%arg0) : (i32) -> ui32
    %9 = "emitc.cast"(%arg1) : (i32) -> ui32
    %10 = "emitc.bitwise_xor"(%8, %9) : (ui32, ui32) -> ui32
    %11 = "emitc.cast"(%10) : (ui32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "arith_bitwise_bool"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "emitc.bitwise_and"(%arg0, %arg1) : (i1, i1) -> i1
    %1 = "emitc.bitwise_or"(%arg0, %arg1) : (i1, i1) -> i1
    %2 = "emitc.bitwise_xor"(%arg0, %arg1) : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_signed_integer_div_rem"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "emitc.div"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "emitc.rem"(%arg0, %arg1) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_shift_left"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "emitc.cast"(%arg0) : (i32) -> ui32
    %1 = "emitc.cast"(%arg1) : (i32) -> ui32
    %2 = "emitc.constant"() <{value = 32 : ui32}> : () -> ui32
    %3 = "emitc.cmp"(%1, %2) <{predicate = 2 : i64}> : (ui32, ui32) -> i1
    %4 = "emitc.constant"() <{value = 0 : ui32}> : () -> ui32
    %5 = "emitc.expression"(%0, %1, %3, %4) ({
    ^bb0(%arg2: ui32, %arg3: ui32, %arg4: i1, %arg5: ui32):
      %7 = "emitc.bitwise_left_shift"(%arg2, %arg3) : (ui32, ui32) -> ui32
      %8 = "emitc.conditional"(%arg4, %7, %arg5) : (i1, ui32, ui32) -> ui32
      "emitc.yield"(%8) : (ui32) -> ()
    }) : (ui32, ui32, i1, ui32) -> ui32
    %6 = "emitc.cast"(%5) : (ui32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_shift_right"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "emitc.cast"(%arg0) : (i32) -> ui32
    %1 = "emitc.cast"(%arg1) : (i32) -> ui32
    %2 = "emitc.constant"() <{value = 32 : ui32}> : () -> ui32
    %3 = "emitc.cmp"(%1, %2) <{predicate = 2 : i64}> : (ui32, ui32) -> i1
    %4 = "emitc.constant"() <{value = 0 : ui32}> : () -> ui32
    %5 = "emitc.expression"(%0, %1, %3, %4) ({
    ^bb0(%arg6: ui32, %arg7: ui32, %arg8: i1, %arg9: ui32):
      %14 = "emitc.bitwise_right_shift"(%arg6, %arg7) : (ui32, ui32) -> ui32
      %15 = "emitc.conditional"(%arg8, %14, %arg9) : (i1, ui32, ui32) -> ui32
      "emitc.yield"(%15) : (ui32) -> ()
    }) : (ui32, ui32, i1, ui32) -> ui32
    %6 = "emitc.cast"(%5) : (ui32) -> i32
    %7 = "emitc.cast"(%arg1) : (i32) -> ui32
    %8 = "emitc.constant"() <{value = 32 : ui32}> : () -> ui32
    %9 = "emitc.cmp"(%7, %8) <{predicate = 2 : i64}> : (ui32, ui32) -> i1
    %10 = "emitc.constant"() <{value = 0 : i32}> : () -> i32
    %11 = "emitc.expression"(%arg0, %7, %9, %10) ({
    ^bb0(%arg2: i32, %arg3: ui32, %arg4: i1, %arg5: i32):
      %12 = "emitc.bitwise_right_shift"(%arg2, %arg3) : (i32, ui32) -> i32
      %13 = "emitc.conditional"(%arg4, %12, %arg5) : (i1, i32, i32) -> i32
      "emitc.yield"(%13) : (i32) -> ()
    }) : (i32, ui32, i1, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "arith_shift_left_index"}> ({
  ^bb0(%arg0: i32):
    %0 = "emitc.constant"() <{value = 42 : index}> : () -> !emitc.size_t
    %1 = "emitc.cast"(%arg0) : (i32) -> !emitc.ptrdiff_t
    %2 = "emitc.cast"(%1) : (!emitc.ptrdiff_t) -> !emitc.size_t
    %3 = "emitc.constant"() <{value = 8 : index}> : () -> !emitc.size_t
    %4 = "emitc.call_opaque"(%3) <{callee = "sizeof"}> : (!emitc.size_t) -> !emitc.size_t
    %5 = "emitc.mul"(%3, %4) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %6 = "emitc.cmp"(%2, %5) <{predicate = 2 : i64}> : (!emitc.size_t, !emitc.size_t) -> i1
    %7 = "emitc.constant"() <{value = 0 : index}> : () -> !emitc.size_t
    %8 = "emitc.expression"(%0, %2, %6, %7) ({
    ^bb0(%arg1: !emitc.size_t, %arg2: !emitc.size_t, %arg3: i1, %arg4: !emitc.size_t):
      %9 = "emitc.bitwise_left_shift"(%arg1, %arg2) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
      %10 = "emitc.conditional"(%arg3, %9, %arg4) : (i1, !emitc.size_t, !emitc.size_t) -> !emitc.size_t
      "emitc.yield"(%10) : (!emitc.size_t) -> ()
    }) : (!emitc.size_t, !emitc.size_t, i1, !emitc.size_t) -> !emitc.size_t
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "arith_shift_right_index"}> ({
  ^bb0(%arg0: i32):
    %0 = "emitc.constant"() <{value = 42 : index}> : () -> !emitc.size_t
    %1 = "emitc.cast"(%arg0) : (i32) -> !emitc.ptrdiff_t
    %2 = "emitc.cast"(%1) : (!emitc.ptrdiff_t) -> !emitc.size_t
    %3 = "emitc.constant"() <{value = 8 : index}> : () -> !emitc.size_t
    %4 = "emitc.call_opaque"(%3) <{callee = "sizeof"}> : (!emitc.size_t) -> !emitc.size_t
    %5 = "emitc.mul"(%3, %4) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %6 = "emitc.cmp"(%2, %5) <{predicate = 2 : i64}> : (!emitc.size_t, !emitc.size_t) -> i1
    %7 = "emitc.constant"() <{value = 0 : index}> : () -> !emitc.size_t
    %8 = "emitc.expression"(%0, %2, %6, %7) ({
    ^bb0(%arg5: !emitc.size_t, %arg6: !emitc.size_t, %arg7: i1, %arg8: !emitc.size_t):
      %19 = "emitc.bitwise_right_shift"(%arg5, %arg6) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
      %20 = "emitc.conditional"(%arg7, %19, %arg8) : (i1, !emitc.size_t, !emitc.size_t) -> !emitc.size_t
      "emitc.yield"(%20) : (!emitc.size_t) -> ()
    }) : (!emitc.size_t, !emitc.size_t, i1, !emitc.size_t) -> !emitc.size_t
    %9 = "emitc.cast"(%0) : (!emitc.size_t) -> !emitc.ptrdiff_t
    %10 = "emitc.constant"() <{value = 8 : index}> : () -> !emitc.size_t
    %11 = "emitc.call_opaque"(%10) <{callee = "sizeof"}> : (!emitc.size_t) -> !emitc.size_t
    %12 = "emitc.mul"(%10, %11) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %13 = "emitc.cmp"(%2, %12) <{predicate = 2 : i64}> : (!emitc.size_t, !emitc.size_t) -> i1
    %14 = "emitc.constant"() <{value = 0 : index}> : () -> !emitc.ptrdiff_t
    %15 = "emitc.expression"(%9, %2, %13, %14) ({
    ^bb0(%arg1: !emitc.ptrdiff_t, %arg2: !emitc.size_t, %arg3: i1, %arg4: !emitc.ptrdiff_t):
      %17 = "emitc.bitwise_right_shift"(%arg1, %arg2) : (!emitc.ptrdiff_t, !emitc.size_t) -> !emitc.ptrdiff_t
      %18 = "emitc.conditional"(%arg3, %17, %arg4) : (i1, !emitc.ptrdiff_t, !emitc.ptrdiff_t) -> !emitc.ptrdiff_t
      "emitc.yield"(%18) : (!emitc.ptrdiff_t) -> ()
    }) : (!emitc.ptrdiff_t, !emitc.size_t, i1, !emitc.ptrdiff_t) -> !emitc.ptrdiff_t
    %16 = "emitc.cast"(%15) : (!emitc.ptrdiff_t) -> !emitc.size_t
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, tensor<8xi32>, tensor<8xi32>) -> (), sym_name = "arith_select"}> ({
  ^bb0(%arg0: i1, %arg1: tensor<8xi32>, %arg2: tensor<8xi32>):
    %0 = "emitc.conditional"(%arg0, %arg1, %arg2) : (i1, tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_false"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.constant"() <{value = false}> : () -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_oeq"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg1) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg0, %arg0) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %2 = "emitc.cmp"(%arg1, %arg1) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %3 = "emitc.logical_and"(%1, %2) : (i1, i1) -> i1
    %4 = "emitc.logical_and"(%3, %0) : (i1, i1) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ogt"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg1) <{predicate = 4 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg0, %arg0) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %2 = "emitc.cmp"(%arg1, %arg1) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %3 = "emitc.logical_and"(%1, %2) : (i1, i1) -> i1
    %4 = "emitc.logical_and"(%3, %0) : (i1, i1) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_oge"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg1) <{predicate = 5 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg0, %arg0) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %2 = "emitc.cmp"(%arg1, %arg1) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %3 = "emitc.logical_and"(%1, %2) : (i1, i1) -> i1
    %4 = "emitc.logical_and"(%3, %0) : (i1, i1) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_olt"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg1) <{predicate = 2 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg0, %arg0) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %2 = "emitc.cmp"(%arg1, %arg1) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %3 = "emitc.logical_and"(%1, %2) : (i1, i1) -> i1
    %4 = "emitc.logical_and"(%3, %0) : (i1, i1) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ole"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg1) <{predicate = 3 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg0, %arg0) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %2 = "emitc.cmp"(%arg1, %arg1) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %3 = "emitc.logical_and"(%1, %2) : (i1, i1) -> i1
    %4 = "emitc.logical_and"(%3, %0) : (i1, i1) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_one"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg1) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg0, %arg0) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %2 = "emitc.cmp"(%arg1, %arg1) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %3 = "emitc.logical_and"(%1, %2) : (i1, i1) -> i1
    %4 = "emitc.logical_and"(%3, %0) : (i1, i1) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ord"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg0) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg1, %arg1) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %2 = "emitc.logical_and"(%0, %1) : (i1, i1) -> i1
    "func.return"(%2) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ueq"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg1) <{predicate = 0 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg0, %arg0) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %2 = "emitc.cmp"(%arg1, %arg1) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %3 = "emitc.logical_or"(%1, %2) : (i1, i1) -> i1
    %4 = "emitc.logical_or"(%3, %0) : (i1, i1) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ugt"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg1) <{predicate = 4 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg0, %arg0) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %2 = "emitc.cmp"(%arg1, %arg1) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %3 = "emitc.logical_or"(%1, %2) : (i1, i1) -> i1
    %4 = "emitc.logical_or"(%3, %0) : (i1, i1) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_uge"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg1) <{predicate = 5 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg0, %arg0) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %2 = "emitc.cmp"(%arg1, %arg1) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %3 = "emitc.logical_or"(%1, %2) : (i1, i1) -> i1
    %4 = "emitc.logical_or"(%3, %0) : (i1, i1) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ult"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg1) <{predicate = 2 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg0, %arg0) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %2 = "emitc.cmp"(%arg1, %arg1) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %3 = "emitc.logical_or"(%1, %2) : (i1, i1) -> i1
    %4 = "emitc.logical_or"(%3, %0) : (i1, i1) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ule"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg1) <{predicate = 3 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg0, %arg0) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %2 = "emitc.cmp"(%arg1, %arg1) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %3 = "emitc.logical_or"(%1, %2) : (i1, i1) -> i1
    %4 = "emitc.logical_or"(%3, %0) : (i1, i1) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_une"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg1) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg0, %arg0) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %2 = "emitc.cmp"(%arg1, %arg1) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %3 = "emitc.logical_or"(%1, %2) : (i1, i1) -> i1
    %4 = "emitc.logical_or"(%3, %0) : (i1, i1) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_uno"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.cmp"(%arg0, %arg0) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %1 = "emitc.cmp"(%arg1, %arg1) <{predicate = 1 : i64}> : (f32, f32) -> i1
    %2 = "emitc.logical_or"(%0, %1) : (i1, i1) -> i1
    "func.return"(%2) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_true"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "emitc.constant"() <{value = true}> : () -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i1, sym_name = "arith_cmpi_eq"}> ({
  ^bb0(%arg6: i32, %arg7: i32):
    %29 = "emitc.cmp"(%arg6, %arg7) <{predicate = 0 : i64}> : (i32, i32) -> i1
    "func.return"(%29) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i1, sym_name = "arith_cmpi_ult"}> ({
  ^bb0(%arg4: i32, %arg5: i32):
    %26 = "emitc.cast"(%arg4) : (i32) -> ui32
    %27 = "emitc.cast"(%arg5) : (i32) -> ui32
    %28 = "emitc.cmp"(%26, %27) <{predicate = 2 : i64}> : (ui32, ui32) -> i1
    "func.return"(%28) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_cmpi_predicates"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %8 = "emitc.cast"(%arg2) : (i32) -> ui32
    %9 = "emitc.cast"(%arg3) : (i32) -> ui32
    %10 = "emitc.cmp"(%8, %9) <{predicate = 2 : i64}> : (ui32, ui32) -> i1
    %11 = "emitc.cmp"(%arg2, %arg3) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %12 = "emitc.cast"(%arg2) : (i32) -> ui32
    %13 = "emitc.cast"(%arg3) : (i32) -> ui32
    %14 = "emitc.cmp"(%12, %13) <{predicate = 3 : i64}> : (ui32, ui32) -> i1
    %15 = "emitc.cmp"(%arg2, %arg3) <{predicate = 3 : i64}> : (i32, i32) -> i1
    %16 = "emitc.cast"(%arg2) : (i32) -> ui32
    %17 = "emitc.cast"(%arg3) : (i32) -> ui32
    %18 = "emitc.cmp"(%16, %17) <{predicate = 4 : i64}> : (ui32, ui32) -> i1
    %19 = "emitc.cmp"(%arg2, %arg3) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %20 = "emitc.cast"(%arg2) : (i32) -> ui32
    %21 = "emitc.cast"(%arg3) : (i32) -> ui32
    %22 = "emitc.cmp"(%20, %21) <{predicate = 5 : i64}> : (ui32, ui32) -> i1
    %23 = "emitc.cmp"(%arg2, %arg3) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %24 = "emitc.cmp"(%arg2, %arg3) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %25 = "emitc.cmp"(%arg2, %arg3) <{predicate = 1 : i64}> : (i32, i32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i1, sym_name = "arith_cmpi_index"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "emitc.cast"(%arg0) : (i32) -> !emitc.ptrdiff_t
    %1 = "emitc.cast"(%0) : (!emitc.ptrdiff_t) -> !emitc.size_t
    %2 = "emitc.cast"(%arg0) : (i32) -> !emitc.ptrdiff_t
    %3 = "emitc.cast"(%2) : (!emitc.ptrdiff_t) -> !emitc.size_t
    %4 = "emitc.cmp"(%1, %3) <{predicate = 2 : i64}> : (!emitc.size_t, !emitc.size_t) -> i1
    %5 = "emitc.cast"(%1) : (!emitc.size_t) -> !emitc.ptrdiff_t
    %6 = "emitc.cast"(%3) : (!emitc.size_t) -> !emitc.ptrdiff_t
    %7 = "emitc.cmp"(%5, %6) <{predicate = 2 : i64}> : (!emitc.ptrdiff_t, !emitc.ptrdiff_t) -> i1
    "func.return"(%7) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "arith_negf"}> ({
  ^bb0(%arg0: f32):
    %0 = "emitc.unary_minus"(%arg0) : (f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "arith_float_to_int_cast_ops"}> ({
  ^bb0(%arg2: f32, %arg3: f64):
    %4 = "emitc.cast"(%arg2) : (f32) -> i32
    %5 = "emitc.cast"(%arg3) : (f64) -> i32
    %6 = "emitc.cast"(%arg2) : (f32) -> i16
    %7 = "emitc.cast"(%arg3) : (f64) -> i16
    %8 = "emitc.cast"(%arg2) : (f32) -> ui32
    %9 = "emitc.cast"(%8) : (ui32) -> i32
    %10 = "emitc.cast"(%arg2) : (f32) -> ui16
    %11 = "emitc.cast"(%10) : (ui16) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i64) -> (), sym_name = "arith_int_to_float_cast_ops"}> ({
  ^bb0(%arg0: i8, %arg1: i64):
    %0 = "emitc.cast"(%arg0) : (i8) -> f32
    %1 = "emitc.cast"(%arg1) : (i64) -> f32
    %2 = "emitc.cast"(%arg0) : (i8) -> ui8
    %3 = "emitc.cast"(%2) : (ui8) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i8, sym_name = "arith_trunci"}> ({
  ^bb0(%arg0: i32):
    %0 = "emitc.cast"(%arg0) : (i32) -> ui32
    %1 = "emitc.cast"(%0) : (ui32) -> ui8
    %2 = "emitc.cast"(%1) : (ui8) -> i8
    %3 = "emitc.constant"() <{value = 1 : i32}> : () -> i32
    %4 = "emitc.bitwise_and"(%arg0, %3) : (i32, i32) -> i32
    %5 = "emitc.cast"(%4) : (i32) -> i1
    "func.return"(%2) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i1, sym_name = "arith_trunci_to_i1"}> ({
  ^bb0(%arg0: i32):
    %0 = "emitc.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "emitc.bitwise_and"(%arg0, %0) : (i32, i32) -> i32
    %2 = "emitc.cast"(%1) : (i32) -> i1
    "func.return"(%2) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "arith_extsi"}> ({
  ^bb0(%arg0: i32):
    %0 = "emitc.cast"(%arg0) : (i32) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "arith_extui"}> ({
  ^bb0(%arg0: i32):
    %0 = "emitc.cast"(%arg0) : (i32) -> ui32
    %1 = "emitc.cast"(%0) : (ui32) -> ui64
    %2 = "emitc.cast"(%1) : (ui64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "arith_extui_i1_to_i32"}> ({
  ^bb0(%arg0: i1):
    %0 = "emitc.cast"(%arg0) : (i1) -> ui1
    %1 = "emitc.cast"(%0) : (ui1) -> ui32
    %2 = "emitc.cast"(%1) : (ui32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "arith_index_cast"}> ({
  ^bb0(%arg0: i32):
    %0 = "emitc.cast"(%arg0) : (i32) -> !emitc.ptrdiff_t
    %1 = "emitc.cast"(%0) : (!emitc.ptrdiff_t) -> !emitc.size_t
    %2 = "emitc.cast"(%1) : (!emitc.size_t) -> !emitc.ptrdiff_t
    %3 = "emitc.cast"(%2) : (!emitc.ptrdiff_t) -> i32
    %4 = "emitc.constant"() <{value = 1 : index}> : () -> !emitc.size_t
    %5 = "emitc.bitwise_and"(%1, %4) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %6 = "emitc.cast"(%5) : (!emitc.size_t) -> i1
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "arith_index_castui"}> ({
  ^bb0(%arg0: i32):
    %0 = "emitc.cast"(%arg0) : (i32) -> ui32
    %1 = "emitc.cast"(%0) : (ui32) -> !emitc.size_t
    %2 = "emitc.cast"(%1) : (!emitc.size_t) -> ui32
    %3 = "emitc.cast"(%2) : (ui32) -> i32
    %4 = "emitc.constant"() <{value = 1 : index}> : () -> !emitc.size_t
    %5 = "emitc.bitwise_and"(%1, %4) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %6 = "emitc.cast"(%5) : (!emitc.size_t) -> i1
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "arith_divui_remui"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "emitc.cast"(%arg0) : (i32) -> ui32
    %1 = "emitc.cast"(%arg1) : (i32) -> ui32
    %2 = "emitc.div"(%0, %1) : (ui32, ui32) -> ui32
    %3 = "emitc.cast"(%2) : (ui32) -> i32
    %4 = "emitc.cast"(%arg0) : (i32) -> ui32
    %5 = "emitc.cast"(%arg1) : (i32) -> ui32
    %6 = "emitc.rem"(%4, %5) : (ui32, ui32) -> ui32
    %7 = "emitc.cast"(%6) : (ui32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> f64, sym_name = "arith_extf"}> ({
  ^bb0(%arg0: f16):
    %0 = "emitc.cast"(%arg0) : (f16) -> f32
    %1 = "emitc.cast"(%0) : (f32) -> f64
    "func.return"(%1) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> f16, sym_name = "arith_truncf"}> ({
  ^bb0(%arg0: f64):
    %0 = "emitc.cast"(%arg0) : (f64) -> f32
    %1 = "emitc.cast"(%0) : (f32) -> f16
    "func.return"(%1) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

