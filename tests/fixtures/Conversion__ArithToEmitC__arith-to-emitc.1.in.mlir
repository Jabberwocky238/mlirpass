"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "arith_constants"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = dense<0> : tensor<i32>}> : () -> tensor<i32>
    %4 = "arith.constant"() <{value = dense<[[1, 2], [-3, 9], [0, 0], [2, -1]]> : tensor<4x2xi64>}> : () -> tensor<4x2xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "arith_ops"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %1 = "arith.divf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %2 = "arith.mulf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %3 = "arith.subf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_integer_ops"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %1 = "arith.subi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "arith.muli"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_integer_ops_signed_nsw"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nsw>}> : (i32, i32) -> i32
    %1 = "arith.subi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nsw>}> : (i32, i32) -> i32
    %2 = "arith.muli"(%arg0, %arg1) <{overflowFlags = #arith.overflow<nsw>}> : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_index"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.index_cast"(%arg0) : (i32) -> index
    %1 = "arith.index_cast"(%arg1) : (i32) -> index
    %2 = "arith.addi"(%0, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %3 = "arith.subi"(%0, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %4 = "arith.muli"(%0, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_bitwise"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.andi"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "arith.ori"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "arith.xori"(%arg0, %arg1) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "arith_bitwise_bool"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "arith.andi"(%arg0, %arg1) : (i1, i1) -> i1
    %1 = "arith.ori"(%arg0, %arg1) : (i1, i1) -> i1
    %2 = "arith.xori"(%arg0, %arg1) : (i1, i1) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_signed_integer_div_rem"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.divsi"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "arith.remsi"(%arg0, %arg1) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_shift_left"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.shli"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_shift_right"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.shrui"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "arith.shrsi"(%arg0, %arg1) : (i32, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "arith_shift_left_index"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 42 : index}> : () -> index
    %1 = "arith.index_cast"(%arg0) : (i32) -> index
    %2 = "arith.shli"(%0, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "arith_shift_right_index"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 42 : index}> : () -> index
    %1 = "arith.index_cast"(%arg0) : (i32) -> index
    %2 = "arith.shrui"(%0, %1) : (index, index) -> index
    %3 = "arith.shrsi"(%0, %1) : (index, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, tensor<8xi32>, tensor<8xi32>) -> (), sym_name = "arith_select"}> ({
  ^bb0(%arg0: i1, %arg1: tensor<8xi32>, %arg2: tensor<8xi32>):
    %0 = "arith.select"(%arg0, %arg1, %arg2) : (i1, tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_false"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 0 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_oeq"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ogt"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_oge"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_olt"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ole"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 5 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_one"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 6 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ord"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ueq"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 8 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ugt"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 9 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_uge"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 10 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ult"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 11 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_ule"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 12 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_une"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 13 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_uno"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "arith_cmpf_true"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>, predicate = 15 : i64}> : (f32, f32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i1, sym_name = "arith_cmpi_eq"}> ({
  ^bb0(%arg6: i32, %arg7: i32):
    %15 = "arith.cmpi"(%arg6, %arg7) <{predicate = 0 : i64}> : (i32, i32) -> i1
    "func.return"(%15) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i1, sym_name = "arith_cmpi_ult"}> ({
  ^bb0(%arg4: i32, %arg5: i32):
    %14 = "arith.cmpi"(%arg4, %arg5) <{predicate = 6 : i64}> : (i32, i32) -> i1
    "func.return"(%14) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "arith_cmpi_predicates"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %4 = "arith.cmpi"(%arg2, %arg3) <{predicate = 6 : i64}> : (i32, i32) -> i1
    %5 = "arith.cmpi"(%arg2, %arg3) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %6 = "arith.cmpi"(%arg2, %arg3) <{predicate = 7 : i64}> : (i32, i32) -> i1
    %7 = "arith.cmpi"(%arg2, %arg3) <{predicate = 3 : i64}> : (i32, i32) -> i1
    %8 = "arith.cmpi"(%arg2, %arg3) <{predicate = 8 : i64}> : (i32, i32) -> i1
    %9 = "arith.cmpi"(%arg2, %arg3) <{predicate = 4 : i64}> : (i32, i32) -> i1
    %10 = "arith.cmpi"(%arg2, %arg3) <{predicate = 9 : i64}> : (i32, i32) -> i1
    %11 = "arith.cmpi"(%arg2, %arg3) <{predicate = 5 : i64}> : (i32, i32) -> i1
    %12 = "arith.cmpi"(%arg2, %arg3) <{predicate = 0 : i64}> : (i32, i32) -> i1
    %13 = "arith.cmpi"(%arg2, %arg3) <{predicate = 1 : i64}> : (i32, i32) -> i1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i1, sym_name = "arith_cmpi_index"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.index_cast"(%arg0) : (i32) -> index
    %1 = "arith.index_cast"(%arg0) : (i32) -> index
    %2 = "arith.cmpi"(%0, %1) <{predicate = 6 : i64}> : (index, index) -> i1
    %3 = "arith.cmpi"(%0, %1) <{predicate = 2 : i64}> : (index, index) -> i1
    "func.return"(%3) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "arith_negf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.negf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f64) -> (), sym_name = "arith_float_to_int_cast_ops"}> ({
  ^bb0(%arg2: f32, %arg3: f64):
    %3 = "arith.fptosi"(%arg2) : (f32) -> i32
    %4 = "arith.fptosi"(%arg3) : (f64) -> i32
    %5 = "arith.fptosi"(%arg2) : (f32) -> i16
    %6 = "arith.fptosi"(%arg3) : (f64) -> i16
    %7 = "arith.fptoui"(%arg2) : (f32) -> i32
    %8 = "arith.fptoui"(%arg2) : (f32) -> i16
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i64) -> (), sym_name = "arith_int_to_float_cast_ops"}> ({
  ^bb0(%arg0: i8, %arg1: i64):
    %0 = "arith.sitofp"(%arg0) : (i8) -> f32
    %1 = "arith.sitofp"(%arg1) : (i64) -> f32
    %2 = "arith.uitofp"(%arg0) : (i8) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i8, sym_name = "arith_trunci"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.trunci"(%arg0) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
    %1 = "arith.trunci"(%arg0) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
    "func.return"(%0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i1, sym_name = "arith_trunci_to_i1"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.trunci"(%arg0) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "arith_extsi"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.extsi"(%arg0) : (i32) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "arith_extui"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.extui"(%arg0) : (i32) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "arith_extui_i1_to_i32"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.extui"(%arg0) : (i1) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "arith_index_cast"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.index_cast"(%arg0) : (i32) -> index
    %1 = "arith.index_cast"(%0) : (index) -> i32
    %2 = "arith.index_cast"(%0) : (index) -> i1
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "arith_index_castui"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.index_castui"(%arg0) : (i32) -> index
    %1 = "arith.index_castui"(%0) : (index) -> i32
    %2 = "arith.index_castui"(%0) : (index) -> i1
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "arith_divui_remui"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.divui"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "arith.remui"(%arg0, %arg1) : (i32, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> f64, sym_name = "arith_extf"}> ({
  ^bb0(%arg0: f16):
    %0 = "arith.extf"(%arg0) : (f16) -> f32
    %1 = "arith.extf"(%0) : (f32) -> f64
    "func.return"(%1) : (f64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> f16, sym_name = "arith_truncf"}> ({
  ^bb0(%arg0: f64):
    %0 = "arith.truncf"(%arg0) : (f64) -> f32
    %1 = "arith.truncf"(%0) : (f32) -> f16
    "func.return"(%1) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

