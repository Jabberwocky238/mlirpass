"builtin.module"() ({
  "func.func"() <{function_type = (i1, i64) -> i64, sym_name = "select_same_val"}> ({
  ^bb0(%arg44: i1, %arg45: i64):
    "func.return"(%arg45) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "select_cmp_eq_select"}> ({
  ^bb0(%arg42: i64, %arg43: i64):
    "func.return"(%arg43) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "select_cmp_ne_select"}> ({
  ^bb0(%arg40: i64, %arg41: i64):
    "func.return"(%arg40) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> (i64, i64, i64, i64, i64, i64, i64, i64), sym_name = "select_cmp_signed_min_max"}> ({
  ^bb0(%arg38: i64, %arg39: i64):
    %30 = "arith.minsi"(%arg38, %arg39) : (i64, i64) -> i64
    %31 = "arith.minsi"(%arg38, %arg39) : (i64, i64) -> i64
    %32 = "arith.minsi"(%arg38, %arg39) : (i64, i64) -> i64
    %33 = "arith.minsi"(%arg38, %arg39) : (i64, i64) -> i64
    %34 = "arith.maxsi"(%arg38, %arg39) : (i64, i64) -> i64
    %35 = "arith.maxsi"(%arg38, %arg39) : (i64, i64) -> i64
    %36 = "arith.maxsi"(%arg38, %arg39) : (i64, i64) -> i64
    %37 = "arith.maxsi"(%arg38, %arg39) : (i64, i64) -> i64
    "func.return"(%30, %31, %32, %33, %34, %35, %36, %37) : (i64, i64, i64, i64, i64, i64, i64, i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> (i64, i64, i64, i64, i64, i64, i64, i64), sym_name = "select_cmp_unsigned_min_max"}> ({
  ^bb0(%arg36: i64, %arg37: i64):
    %22 = "arith.minui"(%arg36, %arg37) : (i64, i64) -> i64
    %23 = "arith.minui"(%arg36, %arg37) : (i64, i64) -> i64
    %24 = "arith.minui"(%arg36, %arg37) : (i64, i64) -> i64
    %25 = "arith.minui"(%arg36, %arg37) : (i64, i64) -> i64
    %26 = "arith.maxui"(%arg36, %arg37) : (i64, i64) -> i64
    %27 = "arith.maxui"(%arg36, %arg37) : (i64, i64) -> i64
    %28 = "arith.maxui"(%arg36, %arg37) : (i64, i64) -> i64
    %29 = "arith.maxui"(%arg36, %arg37) : (i64, i64) -> i64
    "func.return"(%22, %23, %24, %25, %26, %27, %28, %29) : (i64, i64, i64, i64, i64, i64, i64, i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, vector<4xi32>, vector<4xi32>) -> (index, vector<4xi32>), sym_name = "select_cmp_min_max_index_vector"}> ({
  ^bb0(%arg32: index, %arg33: index, %arg34: vector<4xi32>, %arg35: vector<4xi32>):
    %20 = "arith.minsi"(%arg32, %arg33) : (index, index) -> index
    %21 = "arith.maxui"(%arg34, %arg35) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%20, %21) : (index, vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i64, sym_name = "select_extui"}> ({
  ^bb0(%arg31: i1):
    %19 = "arith.extui"(%arg31) : (i1) -> i64
    "func.return"(%19) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i64, sym_name = "select_extui2"}> ({
  ^bb0(%arg30: i1):
    %16 = "arith.constant"() <{value = true}> : () -> i1
    %17 = "arith.xori"(%arg30, %16) : (i1, i1) -> i1
    %18 = "arith.extui"(%17) : (i1) -> i64
    "func.return"(%18) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "select_extui_i1"}> ({
  ^bb0(%arg29: i1):
    "func.return"(%arg29) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> ui1, sym_name = "select_no_fold_ui1"}> ({
  ^bb0(%arg28: i1):
    %13 = "test.constant"() <{value = 0 : i32}> : () -> ui1
    %14 = "test.constant"() <{value = 1 : i32}> : () -> ui1
    %15 = "arith.select"(%arg28, %14, %13) : (i1, ui1, ui1) -> ui1
    "func.return"(%15) : (ui1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "select_cst_false_scalar"}> ({
  ^bb0(%arg26: i32, %arg27: i32):
    "func.return"(%arg27) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "select_cst_true_scalar"}> ({
  ^bb0(%arg24: i32, %arg25: i32):
    "func.return"(%arg24) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "select_cst_true_splat"}> ({
    %12 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%12) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "select_cst_vector_i32"}> ({
    %11 = "arith.constant"() <{value = dense<[1, 5, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%11) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xf32>, sym_name = "select_cst_vector_f32"}> ({
    %10 = "arith.constant"() <{value = dense<[4.000000e+00, 2.000000e+00, 6.000000e+00]> : vector<3xf32>}> : () -> vector<3xf32>
    "func.return"(%10) : (vector<3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "selToNot"}> ({
  ^bb0(%arg23: i1):
    %8 = "arith.constant"() <{value = true}> : () -> i1
    %9 = "arith.xori"(%arg23, %8) : (i1, i1) -> i1
    "func.return"(%9) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32, i32, i32) -> i32, sym_name = "redundantSelectTrue"}> ({
  ^bb0(%arg19: i1, %arg20: i32, %arg21: i32, %arg22: i32):
    %7 = "arith.select"(%arg19, %arg20, %arg22) : (i1, i32, i32) -> i32
    "func.return"(%7) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32, i32, i32) -> i32, sym_name = "redundantSelectFalse"}> ({
  ^bb0(%arg15: i1, %arg16: i32, %arg17: i32, %arg18: i32):
    %6 = "arith.select"(%arg15, %arg18, %arg17) : (i1, i32, i32) -> i32
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32, i32, i32, i32) -> (i32, i32), sym_name = "selNotCond"}> ({
  ^bb0(%arg10: i1, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32):
    %4 = "arith.select"(%arg10, %arg12, %arg11) : (i1, i32, i32) -> i32
    %5 = "arith.select"(%arg10, %arg14, %arg13) : (i1, i32, i32) -> i32
    "func.return"(%4, %5) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "cmpiI1eq"}> ({
  ^bb0(%arg9: i1):
    "func.return"(%arg9) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "cmpiI1eqVec"}> ({
  ^bb0(%arg8: vector<4xi1>):
    "func.return"(%arg8) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "cmpiI1ne"}> ({
  ^bb0(%arg7: i1):
    "func.return"(%arg7) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "cmpiI1neVec"}> ({
  ^bb0(%arg6: vector<4xi1>):
    "func.return"(%arg6) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "cmpiI1eqLhs"}> ({
  ^bb0(%arg5: i1):
    "func.return"(%arg5) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "cmpiI1eqVecLhs"}> ({
  ^bb0(%arg4: vector<4xi1>):
    "func.return"(%arg4) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "cmpiI1neLhs"}> ({
  ^bb0(%arg3: i1):
    "func.return"(%arg3) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "cmpiI1neVecLhs"}> ({
  ^bb0(%arg2: vector<4xi1>):
    "func.return"(%arg2) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> (i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), sym_name = "cmpi_equal_operands"}> ({
  ^bb0(%arg1: i64):
    %2 = "arith.constant"() <{value = true}> : () -> i1
    %3 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%2, %2, %2, %2, %2, %3, %3, %3, %3, %3) : (i1, i1, i1, i1, i1, i1, i1, i1, i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x8xi64>) -> (vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>), sym_name = "cmpi_equal_vector_operands"}> ({
  ^bb0(%arg0: vector<1x8xi64>):
    %0 = "arith.constant"() <{value = dense<true> : vector<1x8xi1>}> : () -> vector<1x8xi1>
    %1 = "arith.constant"() <{value = dense<false> : vector<1x8xi1>}> : () -> vector<1x8xi1>
    "func.return"(%0, %0, %0, %0, %0, %1, %1, %1, %1, %1) : (vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> (i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), sym_name = "cmpi_const_right"}> ({
  ^bb0(%arg0: i64):
    %0 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %1 = "arith.cmpi"(%arg0, %0) <{predicate = 0 : i64}> : (i64, i64) -> i1
    %2 = "arith.cmpi"(%arg0, %0) <{predicate = 5 : i64}> : (i64, i64) -> i1
    %3 = "arith.cmpi"(%arg0, %0) <{predicate = 3 : i64}> : (i64, i64) -> i1
    %4 = "arith.cmpi"(%arg0, %0) <{predicate = 9 : i64}> : (i64, i64) -> i1
    %5 = "arith.cmpi"(%arg0, %0) <{predicate = 7 : i64}> : (i64, i64) -> i1
    %6 = "arith.cmpi"(%arg0, %0) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %7 = "arith.cmpi"(%arg0, %0) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %8 = "arith.cmpi"(%arg0, %0) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %9 = "arith.cmpi"(%arg0, %0) <{predicate = 8 : i64}> : (i64, i64) -> i1
    %10 = "arith.cmpi"(%arg0, %0) <{predicate = 6 : i64}> : (i64, i64) -> i1
    "func.return"(%1, %2, %3, %4, %5, %6, %7, %8, %9, %10) : (i1, i1, i1, i1, i1, i1, i1, i1, i1, i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i1, sym_name = "cmpOfExtSI"}> ({
  ^bb0(%arg1: i1):
    "func.return"(%arg1) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "cmpOfExtUI"}> ({
  ^bb0(%arg0: i1):
    "func.return"(%arg0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "cmpOfExtSIVector"}> ({
  ^bb0(%arg1: vector<4xi1>):
    "func.return"(%arg1) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "cmpOfExtUIVector"}> ({
  ^bb0(%arg0: vector<4xi1>):
    "func.return"(%arg0) : (vector<4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i64, sym_name = "extSIOfExtUI"}> ({
  ^bb0(%arg3: i1):
    %3 = "arith.extui"(%arg3) : (i1) -> i64
    "func.return"(%3) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i64, sym_name = "extSIOfExtUI_nneg"}> ({
  ^bb0(%arg2: i1):
    %2 = "arith.extui"(%arg2) <{nonNeg}> : (i1) -> i64
    "func.return"(%2) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i64, sym_name = "extUIOfExtUI"}> ({
  ^bb0(%arg1: i1):
    %1 = "arith.extui"(%arg1) : (i1) -> i64
    "func.return"(%1) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i64, sym_name = "extSIOfExtSI"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.extsi"(%arg0) : (i1) -> i64
    "func.return"(%0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "cmpIExtSINE"}> ({
  ^bb0(%arg6: i8, %arg7: i8):
    %7 = "arith.cmpi"(%arg6, %arg7) <{predicate = 1 : i64}> : (i8, i8) -> i1
    "func.return"(%7) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "cmpIExtSIEQ"}> ({
  ^bb0(%arg4: i8, %arg5: i8):
    %6 = "arith.cmpi"(%arg4, %arg5) <{predicate = 0 : i64}> : (i8, i8) -> i1
    "func.return"(%6) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "cmpIExtUINE"}> ({
  ^bb0(%arg2: i8, %arg3: i8):
    %5 = "arith.cmpi"(%arg2, %arg3) <{predicate = 1 : i64}> : (i8, i8) -> i1
    "func.return"(%5) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "cmpIExtUIEQ"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %4 = "arith.cmpi"(%arg0, %arg1) <{predicate = 0 : i64}> : (i8, i8) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "cmpIFoldEQ"}> ({
    %3 = "arith.constant"() <{value = dense<[true, true, false]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%3) : (vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "cmpIFoldNE"}> ({
    %2 = "arith.constant"() <{value = dense<[false, false, true]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "cmpIFoldSGE"}> ({
    %1 = "arith.constant"() <{value = dense<[true, true, false]> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%1) : (vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "cmpIFoldULT"}> ({
    %0 = "arith.constant"() <{value = dense<false> : vector<3xi1>}> : () -> vector<3xi1>
    "func.return"(%0) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "andOfExtSI"}> ({
  ^bb0(%arg16: i8, %arg17: i8):
    %16 = "arith.andi"(%arg16, %arg17) : (i8, i8) -> i8
    %17 = "arith.extsi"(%16) : (i8) -> i64
    "func.return"(%17) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "andOfExtUI"}> ({
  ^bb0(%arg14: i8, %arg15: i8):
    %14 = "arith.andi"(%arg14, %arg15) : (i8, i8) -> i8
    %15 = "arith.extui"(%14) : (i8) -> i64
    "func.return"(%15) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "andOfExtUI_nneg_lhs"}> ({
  ^bb0(%arg12: i8, %arg13: i8):
    %12 = "arith.andi"(%arg12, %arg13) : (i8, i8) -> i8
    %13 = "arith.extui"(%12) <{nonNeg}> : (i8) -> i64
    "func.return"(%13) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "andOfExtUI_nneg_rhs"}> ({
  ^bb0(%arg10: i8, %arg11: i8):
    %10 = "arith.andi"(%arg10, %arg11) : (i8, i8) -> i8
    %11 = "arith.extui"(%10) <{nonNeg}> : (i8) -> i64
    "func.return"(%11) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "andOfExtUI_nneg_both"}> ({
  ^bb0(%arg8: i8, %arg9: i8):
    %8 = "arith.andi"(%arg8, %arg9) : (i8, i8) -> i8
    %9 = "arith.extui"(%8) <{nonNeg}> : (i8) -> i64
    "func.return"(%9) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "orOfExtSI"}> ({
  ^bb0(%arg6: i8, %arg7: i8):
    %6 = "arith.ori"(%arg6, %arg7) : (i8, i8) -> i8
    %7 = "arith.extsi"(%6) : (i8) -> i64
    "func.return"(%7) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "orOfExtUI"}> ({
  ^bb0(%arg4: i8, %arg5: i8):
    %4 = "arith.ori"(%arg4, %arg5) : (i8, i8) -> i8
    %5 = "arith.extui"(%4) : (i8) -> i64
    "func.return"(%5) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "orOfExtUI_nneg_both"}> ({
  ^bb0(%arg2: i8, %arg3: i8):
    %2 = "arith.ori"(%arg2, %arg3) : (i8, i8) -> i8
    %3 = "arith.extui"(%2) <{nonNeg}> : (i8) -> i64
    "func.return"(%3) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "orOfExtUI_nneg_mixed"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %0 = "arith.ori"(%arg0, %arg1) : (i8, i8) -> i8
    %1 = "arith.extui"(%0) : (i8) -> i64
    "func.return"(%1) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "andOfAndConstant"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %1 = "arith.andi"(%arg0, %0) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "andOfAndConstantIndex"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.andi"(%arg0, %0) : (index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "andOfAndConstantMultiUse"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 12 : i32}> : () -> i32
    %2 = "arith.andi"(%arg0, %1) : (i32, i32) -> i32
    %3 = "arith.andi"(%arg0, %0) : (i32, i32) -> i32
    "func.return"(%2, %3) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32, i32), sym_name = "andOfAndConstantChain"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 12 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 14 : i32}> : () -> i32
    %3 = "arith.andi"(%arg0, %2) : (i32, i32) -> i32
    %4 = "arith.andi"(%arg0, %1) : (i32, i32) -> i32
    %5 = "arith.andi"(%arg0, %0) : (i32, i32) -> i32
    "func.return"(%3, %4, %5) : (i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "orOfOrConstant"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 14 : i32}> : () -> i32
    %1 = "arith.ori"(%arg0, %0) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "orOfOrConstantIndex"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 14 : index}> : () -> index
    %1 = "arith.ori"(%arg0, %0) : (index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "orOfOrConstantMultiUse"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 14 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 12 : i32}> : () -> i32
    %2 = "arith.ori"(%arg0, %1) : (i32, i32) -> i32
    %3 = "arith.ori"(%arg0, %0) : (i32, i32) -> i32
    "func.return"(%2, %3) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "nested_andi"}> ({
    %0 = "test.constant"() <{value = 2147483647 : i64}> : () -> i32
    %1 = "test.constant"() <{value = -2147483648 : i64}> : () -> i32
    %2 = "test.constant"() <{value = 2147483648 : i64}> : () -> i32
    %3 = "arith.andi"(%0, %1) : (i32, i32) -> i32
    %4 = "arith.andi"(%3, %2) : (i32, i32) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "nested_ori"}> ({
    %0 = "test.constant"() <{value = 2147483647 : i64}> : () -> i32
    %1 = "test.constant"() <{value = -2147483648 : i64}> : () -> i32
    %2 = "test.constant"() <{value = 2147483648 : i64}> : () -> i32
    %3 = "arith.ori"(%0, %1) : (i32, i32) -> i32
    %4 = "arith.ori"(%3, %2) : (i32, i32) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> index, sym_name = "indexCastOfSignExtend"}> ({
  ^bb0(%arg4: i8):
    %15 = "arith.index_cast"(%arg4) : (i8) -> index
    "func.return"(%15) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> index, sym_name = "indexCastUIOfUnsignedExtend"}> ({
  ^bb0(%arg3: i8):
    %14 = "arith.index_castui"(%arg3) : (i8) -> index
    "func.return"(%14) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> index, sym_name = "indexCastUIOfUnsignedExtend_nneg_on_extui"}> ({
  ^bb0(%arg2: i8):
    %13 = "arith.index_castui"(%arg2) <{nonNeg}> : (i8) -> index
    "func.return"(%13) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> index, sym_name = "indexCastUIOfUnsignedExtend_nneg_on_castui"}> ({
  ^bb0(%arg1: i8):
    %12 = "arith.index_castui"(%arg1) : (i8) -> index
    "func.return"(%12) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "indexCastFold"}> ({
    %11 = "arith.constant"() <{value = -2 : index}> : () -> index
    "func.return"(%11) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "indexCastFoldIndexToInt"}> ({
    %10 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%10) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastFoldSplatVector"}> ({
    %9 = "arith.constant"() <{value = dense<42> : vector<3xindex>}> : () -> vector<3xindex>
    "func.return"(%9) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastFoldVector"}> ({
    %8 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xindex>}> : () -> vector<3xindex>
    "func.return"(%8) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastFoldSplatVectorIndexToInt"}> ({
    %7 = "arith.constant"() <{value = dense<42> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%7) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastFoldVectorIndexToInt"}> ({
    %6 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%6) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "indexCastUIFold"}> ({
    %5 = "arith.constant"() <{value = 254 : index}> : () -> index
    "func.return"(%5) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastUIFoldSplatVector"}> ({
    %4 = "arith.constant"() <{value = dense<42> : vector<3xindex>}> : () -> vector<3xindex>
    "func.return"(%4) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastUIFoldVector"}> ({
    %3 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xindex>}> : () -> vector<3xindex>
    "func.return"(%3) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "indexCastUIFoldIndexToInt"}> ({
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastUIFoldSplatVectorIndexToInt"}> ({
    %1 = "arith.constant"() <{value = dense<42> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%1) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastUIFoldVectorIndexToInt"}> ({
    %0 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "indexCastOfIndexCast_lossless"}> ({
  ^bb0(%arg0: i64):
    "func.return"(%arg0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "indexCastOfIndexCast_lossy"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.index_cast"(%arg0) : (index) -> i8
    %1 = "arith.index_cast"(%0) : (i8) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i64, sym_name = "indexCastUIOfIndexCastUI_lossless"}> ({
  ^bb0(%arg0: i64):
    "func.return"(%arg0) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "indexCastUIOfIndexCastUI_lossy"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.index_castui"(%arg0) : (index) -> i8
    %1 = "arith.index_castui"(%0) : (i8) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> index, sym_name = "indexCastUIOfIndexCastUI_3way_lossy"}> ({
  ^bb0(%arg0: i64):
    %0 = "arith.index_castui"(%arg0) : (i64) -> index
    %1 = "arith.index_castui"(%0) : (index) -> i8
    %2 = "arith.index_castui"(%1) : (i8) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> index, sym_name = "indexCastOfIndexCast_3way_lossy"}> ({
  ^bb0(%arg0: i8):
    %0 = "arith.index_cast"(%arg0) : (i8) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> i8, sym_name = "indexCastOfIndexCast_i8_roundtrip"}> ({
  ^bb0(%arg0: i8):
    "func.return"(%arg0) : (i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xi128>) -> vector<3xi128>, sym_name = "indexCastOfIndexCast_vector_lossy"}> ({
  ^bb0(%arg0: vector<3xi128>):
    %0 = "arith.index_cast"(%arg0) : (vector<3xi128>) -> vector<3xindex>
    %1 = "arith.index_cast"(%0) : (vector<3xindex>) -> vector<3xi128>
    "func.return"(%1) : (vector<3xi128>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i16, sym_name = "signExtendConstant"}> ({
    %178 = "arith.constant"() <{value = -2 : i16}> : () -> i16
    "func.return"(%178) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "signExtendConstantSplat"}> ({
    %177 = "arith.constant"() <{value = dense<-2> : vector<4xi16>}> : () -> vector<4xi16>
    "func.return"(%177) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "signExtendConstantVector"}> ({
    %176 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi16>}> : () -> vector<4xi16>
    "func.return"(%176) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "unsignedExtendConstant"}> ({
    %175 = "arith.constant"() <{value = 2 : i16}> : () -> i16
    "func.return"(%175) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "unsignedExtendConstantSplat"}> ({
    %174 = "arith.constant"() <{value = dense<2> : vector<4xi16>}> : () -> vector<4xi16>
    "func.return"(%174) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "unsignedExtendConstantVector"}> ({
    %173 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi16>}> : () -> vector<4xi16>
    "func.return"(%173) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "extFPConstant"}> ({
    %172 = "arith.constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    "func.return"(%172) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<2xf128>, sym_name = "extFPVectorConstant"}> ({
    %171 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00]> : vector<2xf128>}> : () -> vector<2xf128>
    "func.return"(%171) : (vector<2xf128>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "truncExtf"}> ({
  ^bb0(%arg126: f32):
    "func.return"(%arg126) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> bf16, sym_name = "truncExtf1"}> ({
  ^bb0(%arg125: bf16):
    "func.return"(%arg125) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> f16, sym_name = "truncExtf2"}> ({
  ^bb0(%arg124: bf16):
    %169 = "arith.extf"(%arg124) : (bf16) -> f32
    %170 = "arith.truncf"(%169) : (f32) -> f16
    "func.return"(%170) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f16, sym_name = "truncExtf3"}> ({
  ^bb0(%arg123: f32):
    %168 = "arith.truncf"(%arg123) : (f32) -> f16
    "func.return"(%168) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "truncSitofp"}> ({
  ^bb0(%arg122: i32):
    %167 = "arith.sitofp"(%arg122) : (i32) -> f32
    "func.return"(%167) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "truncSitofpConstrained"}> ({
  ^bb0(%arg121: i32):
    %165 = "arith.sitofp"(%arg121) : (i32) -> f64
    %166 = "arith.truncf"(%165) <{roundingmode = 0 : i32}> : (f64) -> f32
    "func.return"(%166) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "truncUitofp"}> ({
  ^bb0(%arg120: i32):
    %164 = "arith.uitofp"(%arg120) : (i32) -> f32
    "func.return"(%164) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "truncUitofp_nneg"}> ({
  ^bb0(%arg119: i32):
    %163 = "arith.uitofp"(%arg119) <{nonNeg}> : (i32) -> f32
    "func.return"(%163) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> bf16, sym_name = "sitofpExtsi"}> ({
  ^bb0(%arg118: i8):
    %162 = "arith.sitofp"(%arg118) : (i8) -> bf16
    "func.return"(%162) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i4) -> bf16, sym_name = "sitofpExtui"}> ({
  ^bb0(%arg117: i4):
    %161 = "arith.uitofp"(%arg117) : (i4) -> bf16
    "func.return"(%161) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> bf16, sym_name = "uitofpExtui"}> ({
  ^bb0(%arg116: i8):
    %160 = "arith.uitofp"(%arg116) : (i8) -> bf16
    "func.return"(%160) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i4) -> bf16, sym_name = "sitofpExtui_nneg"}> ({
  ^bb0(%arg115: i4):
    %159 = "arith.uitofp"(%arg115) <{nonNeg}> : (i4) -> bf16
    "func.return"(%159) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncConstant"}> ({
  ^bb0(%arg114: i8):
    %158 = "arith.constant"() <{value = -2 : i16}> : () -> i16
    "func.return"(%158) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "truncExtui"}> ({
  ^bb0(%arg113: i32):
    "func.return"(%arg113) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i16, sym_name = "truncExtui2"}> ({
  ^bb0(%arg112: i32):
    %157 = "arith.trunci"(%arg112) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i16
    "func.return"(%157) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncExtui3"}> ({
  ^bb0(%arg111: i8):
    %156 = "arith.extui"(%arg111) : (i8) -> i16
    "func.return"(%156) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncExtui3_nneg"}> ({
  ^bb0(%arg110: i8):
    %155 = "arith.extui"(%arg110) <{nonNeg}> : (i8) -> i16
    "func.return"(%155) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi16>, sym_name = "truncExtuiVector"}> ({
  ^bb0(%arg109: vector<2xi32>):
    %154 = "arith.trunci"(%arg109) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi32>) -> vector<2xi16>
    "func.return"(%154) : (vector<2xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "truncExtsi"}> ({
  ^bb0(%arg108: i32):
    "func.return"(%arg108) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i16, sym_name = "truncExtsi2"}> ({
  ^bb0(%arg107: i32):
    %153 = "arith.trunci"(%arg107) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i16
    "func.return"(%153) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncExtsi3"}> ({
  ^bb0(%arg106: i8):
    %152 = "arith.extsi"(%arg106) : (i8) -> i16
    "func.return"(%152) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi16>, sym_name = "truncExtsiVector"}> ({
  ^bb0(%arg105: vector<2xi32>):
    %151 = "arith.trunci"(%arg105) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi32>) -> vector<2xi16>
    "func.return"(%151) : (vector<2xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi8>, sym_name = "truncConstantSplat"}> ({
    %150 = "arith.constant"() <{value = dense<-2> : vector<4xi8>}> : () -> vector<4xi8>
    "func.return"(%150) : (vector<4xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi8>, sym_name = "truncConstantVector"}> ({
    %149 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi8>}> : () -> vector<4xi8>
    "func.return"(%149) : (vector<4xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i8, sym_name = "truncTrunc"}> ({
  ^bb0(%arg104: i64):
    %148 = "arith.trunci"(%arg104) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i8
    "func.return"(%148) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPConstant"}> ({
    %147 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    "func.return"(%147) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPToNearestEvenConstant"}> ({
    %146 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    "func.return"(%146) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPDownwardConstant"}> ({
    %145 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    "func.return"(%145) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPUpwardConstant"}> ({
    %144 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    "func.return"(%144) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPTowardZeroConstant"}> ({
    %143 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    "func.return"(%143) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPToNearestAwayConstant"}> ({
    %142 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    "func.return"(%142) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<2xbf16>, sym_name = "truncFPVectorConstant"}> ({
    %141 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00]> : vector<2xbf16>}> : () -> vector<2xbf16>
    "func.return"(%141) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPConstantRounding"}> ({
    %139 = "arith.constant"() <{value = 1.444000e+25 : f32}> : () -> f32
    %140 = "arith.truncf"(%139) : (f32) -> bf16
    "func.return"(%140) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddAdd"}> ({
  ^bb0(%arg103: index):
    %137 = "arith.constant"() <{value = 59 : index}> : () -> index
    %138 = "arith.addi"(%arg103, %137) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%138) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddAddOvf1"}> ({
  ^bb0(%arg102: index):
    %135 = "arith.constant"() <{value = 59 : index}> : () -> index
    %136 = "arith.addi"(%arg102, %135) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%136) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddAddOvf2"}> ({
  ^bb0(%arg101: index):
    %133 = "arith.constant"() <{value = 59 : index}> : () -> index
    %134 = "arith.addi"(%arg101, %133) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%134) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<10xi32>, tensor<?x?xi32>) -> (tensor<10xi32>, tensor<?x?xi32>), sym_name = "foldSubXX_tensor"}> ({
  ^bb0(%arg99: tensor<10xi32>, %arg100: tensor<?x?xi32>):
    %131 = "arith.constant"() <{value = dense<0> : tensor<10xi32>}> : () -> tensor<10xi32>
    %132 = "arith.subi"(%arg100, %arg100) <{overflowFlags = #arith.overflow<none>}> : (tensor<?x?xi32>, tensor<?x?xi32>) -> tensor<?x?xi32>
    "func.return"(%131, %132) : (tensor<10xi32>, tensor<?x?xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xi32>, vector<[4]xi32>) -> (vector<8xi32>, vector<[4]xi32>), sym_name = "foldSubXX_vector"}> ({
  ^bb0(%arg97: vector<8xi32>, %arg98: vector<[4]xi32>):
    %129 = "arith.constant"() <{value = dense<0> : vector<8xi32>}> : () -> vector<8xi32>
    %130 = "arith.constant"() <{value = dense<0> : vector<[4]xi32>}> : () -> vector<[4]xi32>
    "func.return"(%129, %130) : (vector<8xi32>, vector<[4]xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub0"}> ({
  ^bb0(%arg96: index):
    %127 = "arith.constant"() <{value = 59 : index}> : () -> index
    %128 = "arith.subi"(%127, %arg96) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%128) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub0Ovf"}> ({
  ^bb0(%arg95: index):
    %125 = "arith.constant"() <{value = 59 : index}> : () -> index
    %126 = "arith.subi"(%125, %arg95) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%126) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub1"}> ({
  ^bb0(%arg94: index):
    %123 = "arith.constant"() <{value = 25 : index}> : () -> index
    %124 = "arith.addi"(%arg94, %123) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%124) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub1Ovf"}> ({
  ^bb0(%arg93: index):
    %121 = "arith.constant"() <{value = 25 : index}> : () -> index
    %122 = "arith.addi"(%arg93, %121) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%122) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubAdd0"}> ({
  ^bb0(%arg92: index):
    %119 = "arith.constant"() <{value = 25 : index}> : () -> index
    %120 = "arith.subi"(%119, %arg92) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%120) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubAdd0Ovf"}> ({
  ^bb0(%arg91: index):
    %117 = "arith.constant"() <{value = 25 : index}> : () -> index
    %118 = "arith.subi"(%117, %arg91) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%118) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubAdd1"}> ({
  ^bb0(%arg90: index):
    %115 = "arith.constant"() <{value = -25 : index}> : () -> index
    %116 = "arith.addi"(%arg90, %115) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%116) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subSub0"}> ({
  ^bb0(%arg88: index, %arg89: index):
    %113 = "arith.constant"() <{value = 0 : index}> : () -> index
    %114 = "arith.subi"(%113, %arg89) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%114) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subSub1"}> ({
  ^bb0(%arg86: index, %arg87: index):
    "func.return"(%arg87) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subSub0Ovf"}> ({
  ^bb0(%arg84: index, %arg85: index):
    %111 = "arith.constant"() <{value = 0 : index}> : () -> index
    %112 = "arith.subi"(%111, %arg85) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%112) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub0"}> ({
  ^bb0(%arg83: index):
    %109 = "arith.constant"() <{value = 25 : index}> : () -> index
    %110 = "arith.addi"(%arg83, %109) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%110) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub0Ovf"}> ({
  ^bb0(%arg82: index):
    %107 = "arith.constant"() <{value = 25 : index}> : () -> index
    %108 = "arith.addi"(%arg82, %107) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%108) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub1"}> ({
  ^bb0(%arg81: index):
    %105 = "arith.constant"() <{value = -25 : index}> : () -> index
    %106 = "arith.subi"(%105, %arg81) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%106) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub1Ovf"}> ({
  ^bb0(%arg80: index):
    %103 = "arith.constant"() <{value = -25 : index}> : () -> index
    %104 = "arith.subi"(%103, %arg80) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%104) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub2"}> ({
  ^bb0(%arg79: index):
    %101 = "arith.constant"() <{value = 59 : index}> : () -> index
    %102 = "arith.subi"(%101, %arg79) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%102) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub2Ovf"}> ({
  ^bb0(%arg78: index):
    %99 = "arith.constant"() <{value = 59 : index}> : () -> index
    %100 = "arith.subi"(%99, %arg78) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%100) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub3"}> ({
  ^bb0(%arg77: index):
    %97 = "arith.constant"() <{value = 59 : index}> : () -> index
    %98 = "arith.subi"(%arg77, %97) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%98) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub3Ovf"}> ({
  ^bb0(%arg76: index):
    %95 = "arith.constant"() <{value = 59 : index}> : () -> index
    %96 = "arith.subi"(%arg76, %95) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%96) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subAdd1"}> ({
  ^bb0(%arg74: index, %arg75: index):
    "func.return"(%arg74) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subAdd2"}> ({
  ^bb0(%arg72: index, %arg73: index):
    "func.return"(%arg73) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "doubleAddSub1"}> ({
  ^bb0(%arg70: index, %arg71: index):
    "func.return"(%arg70) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "doubleAddSub2"}> ({
  ^bb0(%arg68: index, %arg69: index):
    "func.return"(%arg68) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "nested_muli"}> ({
    %90 = "test.constant"() <{value = 2147483647 : i64}> : () -> i32
    %91 = "test.constant"() <{value = -2147483648 : i64}> : () -> i32
    %92 = "test.constant"() <{value = 2147483648 : i64}> : () -> i32
    %93 = "arith.muli"(%90, %91) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %94 = "arith.muli"(%93, %92) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%94) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleMulIMulIIndex"}> ({
  ^bb0(%arg67: index):
    %88 = "arith.constant"() <{value = 15 : index}> : () -> index
    %89 = "arith.muli"(%arg67, %88) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%89) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "tripleMulIMulII32"}> ({
  ^bb0(%arg66: i32):
    %86 = "arith.constant"() <{value = -21 : i32}> : () -> i32
    %87 = "arith.muli"(%arg66, %86) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%87) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i256) -> i256, sym_name = "tripleMulLargeInt"}> ({
  ^bb0(%arg65: i256):
    %84 = "arith.constant"() <{value = 3618502788666131213697322783095070105623107215331596699973092056135872020482 : i256}> : () -> i256
    %85 = "arith.addi"(%arg65, %84) <{overflowFlags = #arith.overflow<none>}> : (i256, i256) -> i256
    "func.return"(%85) : (i256) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "addiMuliToSubiRhsI32"}> ({
  ^bb0(%arg63: i32, %arg64: i32):
    %83 = "arith.subi"(%arg63, %arg64) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%83) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "addiMuliToSubiRhsIndex"}> ({
  ^bb0(%arg61: index, %arg62: index):
    %82 = "arith.subi"(%arg61, %arg62) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%82) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> vector<3xi64>, sym_name = "addiMuliToSubiRhsVector"}> ({
  ^bb0(%arg59: vector<3xi64>, %arg60: vector<3xi64>):
    %81 = "arith.subi"(%arg59, %arg60) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "func.return"(%81) : (vector<3xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "addiMuliToSubiLhsI32"}> ({
  ^bb0(%arg57: i32, %arg58: i32):
    %80 = "arith.subi"(%arg57, %arg58) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%80) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "addiMuliToSubiLhsIndex"}> ({
  ^bb0(%arg55: index, %arg56: index):
    %79 = "arith.subi"(%arg55, %arg56) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%79) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> vector<3xi64>, sym_name = "addiMuliToSubiLhsVector"}> ({
  ^bb0(%arg53: vector<3xi64>, %arg54: vector<3xi64>):
    %78 = "arith.subi"(%arg53, %arg54) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "func.return"(%78) : (vector<3xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "adduiExtendedZeroRhs"}> ({
  ^bb0(%arg52: i32):
    %77 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%arg52, %77) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi1>), sym_name = "adduiExtendedZeroRhsSplat"}> ({
  ^bb0(%arg51: vector<4xi32>):
    %76 = "arith.constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%arg51, %76) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "adduiExtendedZeroLhs"}> ({
  ^bb0(%arg50: i32):
    %75 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%arg50, %75) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "adduiExtendedUnusedOverflowScalar"}> ({
  ^bb0(%arg48: i32, %arg49: i32):
    %74 = "arith.addi"(%arg48, %arg49) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%74) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, vector<3xi32>) -> vector<3xi32>, sym_name = "adduiExtendedUnusedOverflowVector"}> ({
  ^bb0(%arg46: vector<3xi32>, %arg47: vector<3xi32>):
    %73 = "arith.addi"(%arg46, %arg47) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%73) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedConstants"}> ({
    %71 = "arith.constant"() <{value = 50 : i32}> : () -> i32
    %72 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%71, %72) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedConstantsOverflow1"}> ({
    %69 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %70 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%69, %70) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedConstantsOverflow2"}> ({
    %67 = "arith.constant"() <{value = -2 : i32}> : () -> i32
    %68 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%67, %68) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<4xi32>, vector<4xi1>), sym_name = "adduiExtendedConstantsOverflowVector"}> ({
    %65 = "arith.constant"() <{value = dense<[1, 6, 2, 14]> : vector<4xi32>}> : () -> vector<4xi32>
    %66 = "arith.constant"() <{value = dense<[false, false, true, false]> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%65, %66) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<4xi32>, vector<4xi1>), sym_name = "adduiExtendedConstantsSplatVector"}> ({
    %63 = "arith.constant"() <{value = dense<3> : vector<4xi32>}> : () -> vector<4xi32>
    %64 = "arith.constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%63, %64) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedPoisonLhs"}> ({
    %61 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %62 = "ub.poison"() <{value = #ub.poison}> : () -> i1
    "func.return"(%61, %62) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedPoisonRhs"}> ({
    %59 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %60 = "ub.poison"() <{value = #ub.poison}> : () -> i1
    "func.return"(%59, %60) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "subuiExtendedZeroRhs"}> ({
  ^bb0(%arg45: i32):
    %58 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%arg45, %58) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi1>), sym_name = "subuiExtendedZeroRhsSplat"}> ({
  ^bb0(%arg44: vector<4xi32>):
    %57 = "arith.constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%arg44, %57) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "subuiExtendedSameOperand"}> ({
  ^bb0(%arg43: i32):
    %55 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %56 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%55, %56) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi1>), sym_name = "subuiExtendedSameOperandVector"}> ({
  ^bb0(%arg42: vector<4xi32>):
    %53 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    %54 = "arith.constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%53, %54) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "subuiExtendedUnusedBorrowScalar"}> ({
  ^bb0(%arg40: i32, %arg41: i32):
    %52 = "arith.subi"(%arg40, %arg41) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%52) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, vector<3xi32>) -> vector<3xi32>, sym_name = "subuiExtendedUnusedBorrowVector"}> ({
  ^bb0(%arg38: vector<3xi32>, %arg39: vector<3xi32>):
    %51 = "arith.subi"(%arg38, %arg39) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%51) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "subuiExtendedConstants"}> ({
    %49 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %50 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%49, %50) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "subuiExtendedConstantsBorrow"}> ({
    %47 = "arith.constant"() <{value = -2 : i32}> : () -> i32
    %48 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%47, %48) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<4xi32>, vector<4xi1>), sym_name = "subuiExtendedConstantsBorrowVector"}> ({
    %45 = "arith.constant"() <{value = dense<[1, 0, -1, 0]> : vector<4xi32>}> : () -> vector<4xi32>
    %46 = "arith.constant"() <{value = dense<[false, false, true, false]> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%45, %46) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "subuiExtendedPoisonLhs"}> ({
    %43 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %44 = "ub.poison"() <{value = #ub.poison}> : () -> i1
    "func.return"(%43, %44) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "subuiExtendedPoisonRhs"}> ({
    %41 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %42 = "ub.poison"() <{value = #ub.poison}> : () -> i1
    "func.return"(%41, %42) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "mulsiExtendedZeroRhs"}> ({
  ^bb0(%arg37: i32):
    %40 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%40, %40) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>) -> (vector<3xi32>, vector<3xi32>), sym_name = "mulsiExtendedZeroRhsSplat"}> ({
  ^bb0(%arg36: vector<3xi32>):
    %39 = "arith.constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%39, %39) : (vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "mulsiExtendedZeroLhs"}> ({
  ^bb0(%arg35: i32):
    %38 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%38, %38) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "mulsiExtendedOneRhs"}> ({
  ^bb0(%arg34: i32):
    %35 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %36 = "arith.cmpi"(%arg34, %35) <{predicate = 2 : i64}> : (i32, i32) -> i1
    %37 = "arith.extsi"(%36) : (i1) -> i32
    "func.return"(%arg34, %37) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>) -> (vector<3xi32>, vector<3xi32>), sym_name = "mulsiExtendedOneRhsSplat"}> ({
  ^bb0(%arg33: vector<3xi32>):
    %32 = "arith.constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %33 = "arith.cmpi"(%arg33, %32) <{predicate = 2 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    %34 = "arith.extsi"(%33) : (vector<3xi1>) -> vector<3xi32>
    "func.return"(%arg33, %34) : (vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (i1, i1), sym_name = "mulsiExtendedOneRhsI1"}> ({
  ^bb0(%arg32: i1):
    %30 = "arith.constant"() <{value = true}> : () -> i1
    %31:2 = "arith.mulsi_extended"(%arg32, %30) : (i1, i1) -> (i1, i1)
    "func.return"(%31#0, %31#1) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi1>) -> (vector<3xi1>, vector<3xi1>), sym_name = "mulsiExtendedOneRhsSplatI1"}> ({
  ^bb0(%arg31: vector<3xi1>):
    %28 = "arith.constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    %29:2 = "arith.mulsi_extended"(%arg31, %28) : (vector<3xi1>, vector<3xi1>) -> (vector<3xi1>, vector<3xi1>)
    "func.return"(%29#0, %29#1) : (vector<3xi1>, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "mulsiExtendedUnusedHigh"}> ({
  ^bb0(%arg30: i32):
    %27 = "arith.muli"(%arg30, %arg30) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%27) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i8, i8), sym_name = "mulsiExtendedScalarConstants"}> ({
    %25 = "arith.constant"() <{value = 27 : i8}> : () -> i8
    %26 = "arith.constant"() <{value = -3 : i8}> : () -> i8
    "func.return"(%25, %26) : (i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<3xi8>, vector<3xi8>), sym_name = "mulsiExtendedVectorConstants"}> ({
    %23 = "arith.constant"() <{value = dense<[65, 79, 34]> : vector<3xi8>}> : () -> vector<3xi8>
    %24 = "arith.constant"() <{value = dense<[0, 14, 0]> : vector<3xi8>}> : () -> vector<3xi8>
    "func.return"(%23, %24) : (vector<3xi8>, vector<3xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "muluiExtendedZeroRhs"}> ({
  ^bb0(%arg29: i32):
    %22 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%22, %22) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>) -> (vector<3xi32>, vector<3xi32>), sym_name = "muluiExtendedZeroRhsSplat"}> ({
  ^bb0(%arg28: vector<3xi32>):
    %21 = "arith.constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%21, %21) : (vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "muluiExtendedZeroLhs"}> ({
  ^bb0(%arg27: i32):
    %20 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%20, %20) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "muluiExtendedOneRhs"}> ({
  ^bb0(%arg26: i32):
    %19 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%arg26, %19) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>) -> (vector<3xi32>, vector<3xi32>), sym_name = "muluiExtendedOneRhsSplat"}> ({
  ^bb0(%arg25: vector<3xi32>):
    %18 = "arith.constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%arg25, %18) : (vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "muluiExtendedOneLhs"}> ({
  ^bb0(%arg24: i32):
    %17 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%arg24, %17) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "muluiExtendedUnusedHigh"}> ({
  ^bb0(%arg23: i32):
    %16 = "arith.muli"(%arg23, %arg23) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%16) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "muluiExtendedUnusedLow"}> ({
  ^bb0(%arg22: i32):
    %15:2 = "arith.mului_extended"(%arg22, %arg22) : (i32, i32) -> (i32, i32)
    "func.return"(%15#1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i8, i8), sym_name = "muluiExtendedScalarConstants"}> ({
    %13 = "arith.constant"() <{value = -99 : i8}> : () -> i8
    %14 = "arith.constant"() <{value = 29 : i8}> : () -> i8
    "func.return"(%13, %14) : (i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<3xi8>, vector<3xi8>), sym_name = "muluiExtendedVectorConstants"}> ({
    %11 = "arith.constant"() <{value = dense<[65, 79, 1]> : vector<3xi8>}> : () -> vector<3xi8>
    %12 = "arith.constant"() <{value = dense<[0, 14, -2]> : vector<3xi8>}> : () -> vector<3xi8>
    "func.return"(%11, %12) : (vector<3xi8>, vector<3xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpEQ"}> ({
  ^bb0(%arg20: i8, %arg21: i8):
    %10 = "arith.cmpi"(%arg20, %arg21) <{predicate = 1 : i64}> : (i8, i8) -> i1
    "func.return"(%10) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpEQ2"}> ({
  ^bb0(%arg18: i8, %arg19: i8):
    %9 = "arith.cmpi"(%arg18, %arg19) <{predicate = 1 : i64}> : (i8, i8) -> i1
    "func.return"(%9) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpNE"}> ({
  ^bb0(%arg16: i8, %arg17: i8):
    %8 = "arith.cmpi"(%arg16, %arg17) <{predicate = 0 : i64}> : (i8, i8) -> i1
    "func.return"(%8) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpSLT"}> ({
  ^bb0(%arg14: i8, %arg15: i8):
    %7 = "arith.cmpi"(%arg14, %arg15) <{predicate = 5 : i64}> : (i8, i8) -> i1
    "func.return"(%7) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpSLE"}> ({
  ^bb0(%arg12: i8, %arg13: i8):
    %6 = "arith.cmpi"(%arg12, %arg13) <{predicate = 4 : i64}> : (i8, i8) -> i1
    "func.return"(%6) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpSGT"}> ({
  ^bb0(%arg10: i8, %arg11: i8):
    %5 = "arith.cmpi"(%arg10, %arg11) <{predicate = 3 : i64}> : (i8, i8) -> i1
    "func.return"(%5) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpSGE"}> ({
  ^bb0(%arg8: i8, %arg9: i8):
    %4 = "arith.cmpi"(%arg8, %arg9) <{predicate = 2 : i64}> : (i8, i8) -> i1
    "func.return"(%4) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpULT"}> ({
  ^bb0(%arg6: i8, %arg7: i8):
    %3 = "arith.cmpi"(%arg6, %arg7) <{predicate = 9 : i64}> : (i8, i8) -> i1
    "func.return"(%3) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpULE"}> ({
  ^bb0(%arg4: i8, %arg5: i8):
    %2 = "arith.cmpi"(%arg4, %arg5) <{predicate = 8 : i64}> : (i8, i8) -> i1
    "func.return"(%2) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpUGT"}> ({
  ^bb0(%arg2: i8, %arg3: i8):
    %1 = "arith.cmpi"(%arg2, %arg3) <{predicate = 7 : i64}> : (i8, i8) -> i1
    "func.return"(%1) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpUGE"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %0 = "arith.cmpi"(%arg0, %arg1) <{predicate = 6 : i64}> : (i8, i8) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i1, sym_name = "xorxor"}> ({
  ^bb0(%arg8: i1):
    "func.return"(%arg8) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "xorOfExtSI"}> ({
  ^bb0(%arg6: i8, %arg7: i8):
    %6 = "arith.xori"(%arg6, %arg7) : (i8, i8) -> i8
    %7 = "arith.extsi"(%6) : (i8) -> i64
    "func.return"(%7) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "xorOfExtUI"}> ({
  ^bb0(%arg4: i8, %arg5: i8):
    %4 = "arith.xori"(%arg4, %arg5) : (i8, i8) -> i8
    %5 = "arith.extui"(%4) : (i8) -> i64
    "func.return"(%5) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "xorOfExtUI_nneg_both"}> ({
  ^bb0(%arg2: i8, %arg3: i8):
    %2 = "arith.xori"(%arg2, %arg3) : (i8, i8) -> i8
    %3 = "arith.extui"(%2) <{nonNeg}> : (i8) -> i64
    "func.return"(%3) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "xorOfExtUI_nneg_mixed"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %0 = "arith.xori"(%arg0, %arg1) : (i8, i8) -> i8
    %1 = "arith.extui"(%0) : (i8) -> i64
    "func.return"(%1) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "xorOfXorConstant"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 6 : i32}> : () -> i32
    %1 = "arith.xori"(%arg0, %0) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "xorOfXorConstantIndex"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 6 : index}> : () -> index
    %1 = "arith.xori"(%arg0, %0) : (index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "xorOfXorConstantMultiUse"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 6 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 12 : i32}> : () -> i32
    %2 = "arith.xori"(%arg0, %1) : (i32, i32) -> i32
    %3 = "arith.xori"(%arg0, %0) : (i32, i32) -> i32
    "func.return"(%2, %3) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "nested_xori"}> ({
    %0 = "test.constant"() <{value = 2147483647 : i64}> : () -> i32
    %1 = "test.constant"() <{value = -2147483648 : i64}> : () -> i32
    %2 = "test.constant"() <{value = 2147483648 : i64}> : () -> i32
    %3 = "arith.xori"(%0, %1) : (i32, i32) -> i32
    %4 = "arith.xori"(%3, %2) : (i32, i32) -> i32
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "bitcastSameType"}> ({
  ^bb0(%arg0: f32):
    "func.return"(%arg0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "bitcastConstantFPtoI"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "bitcastConstantItoFP"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f16, sym_name = "bitcastConstantFPtoFP"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    "func.return"(%0) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<3xf32>, sym_name = "bitcastConstantVecFPtoI"}> ({
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    "func.return"(%0) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "bitcastConstantVecItoFP"}> ({
    %0 = "arith.constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%0) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<3xbf16>, sym_name = "bitcastConstantVecFPtoFP"}> ({
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<3xbf16>}> : () -> vector<3xbf16>
    "func.return"(%0) : (vector<3xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "bitcastBackAndForth"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i16) -> i16, sym_name = "bitcastOfBitcast"}> ({
  ^bb0(%arg0: i16):
    "func.return"(%arg0) : (i16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "bitcastPoisonItoFP"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "bitcastPoisonFPtoI"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i16) -> f16, sym_name = "bitcastChain"}> ({
  ^bb0(%arg0: i16):
    %0 = "arith.bitcast"(%arg0) : (i16) -> f16
    "func.return"(%0) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_maxsi"}> ({
  ^bb0(%arg1: i8):
    %3 = "arith.constant"() <{value = 127 : i8}> : () -> i8
    %4 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %5 = "arith.maxsi"(%arg1, %4) : (i8, i8) -> i8
    "func.return"(%arg1, %3, %arg1, %5) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_maxsi2"}> ({
  ^bb0(%arg0: i8):
    %0 = "arith.constant"() <{value = 127 : i8}> : () -> i8
    %1 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %2 = "arith.maxsi"(%arg0, %1) : (i8, i8) -> i8
    "func.return"(%arg0, %0, %arg0, %2) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_maxui"}> ({
  ^bb0(%arg1: i8):
    %3 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %4 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %5 = "arith.maxui"(%arg1, %4) : (i8, i8) -> i8
    "func.return"(%arg1, %3, %arg1, %5) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_maxui2"}> ({
  ^bb0(%arg0: i8):
    %0 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %1 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %2 = "arith.maxui"(%arg0, %1) : (i8, i8) -> i8
    "func.return"(%arg0, %0, %arg0, %2) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_minsi"}> ({
  ^bb0(%arg1: i8):
    %3 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %4 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %5 = "arith.minsi"(%arg1, %4) : (i8, i8) -> i8
    "func.return"(%arg1, %arg1, %3, %5) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_minsi2"}> ({
  ^bb0(%arg0: i8):
    %0 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %1 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %2 = "arith.minsi"(%arg0, %1) : (i8, i8) -> i8
    "func.return"(%arg0, %arg0, %0, %2) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_minui"}> ({
  ^bb0(%arg1: i8):
    %3 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %4 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %5 = "arith.minui"(%arg1, %4) : (i8, i8) -> i8
    "func.return"(%arg1, %arg1, %3, %5) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_minui2"}> ({
  ^bb0(%arg0: i8):
    %0 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %1 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %2 = "arith.minui"(%arg0, %1) : (i8, i8) -> i8
    "func.return"(%arg0, %arg0, %0, %2) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32), sym_name = "test_minimumf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.minimumf"(%arg0, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%1, %arg0, %arg0) : (f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32), sym_name = "test_maximumf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.maximumf"(%arg0, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%1, %arg0, %arg0) : (f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32), sym_name = "test_minnumf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %2 = "arith.minnumf"(%arg0, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %3 = "arith.minnumf"(%arg0, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2, %arg0, %3, %arg0) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32), sym_name = "test_maxnumf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %2 = "arith.maxnumf"(%arg0, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %3 = "arith.maxnumf"(%arg0, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2, %arg0, %3, %arg0) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32), sym_name = "test_addf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.addf"(%arg0, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2, %arg0, %arg0, %0) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> (f16, f16, f16), sym_name = "test_subf"}> ({
  ^bb0(%arg3: f16):
    %4 = "arith.constant"() <{value = -1.000000e+00 : f16}> : () -> f16
    %5 = "arith.constant"() <{value = -0.000000e+00 : f16}> : () -> f16
    %6 = "arith.subf"(%arg3, %5) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    "func.return"(%arg3, %6, %4) : (f16, f16, f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> f16, sym_name = "test_subf_negzero"}> ({
  ^bb0(%arg2: f16):
    %3 = "arith.negf"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
    "func.return"(%3) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> f16, sym_name = "test_subf_poszero_no_negf"}> ({
  ^bb0(%arg1: f16):
    %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %2 = "arith.subf"(%1, %arg1) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    "func.return"(%2) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "test_subf_negzero_splat"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "arith.negf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32), sym_name = "test_mulf"}> ({
  ^bb0(%arg3: f32):
    %3 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %5 = "arith.mulf"(%arg3, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%5, %arg3, %arg3, %3) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "test_mulf1"}> ({
  ^bb0(%arg1: f32, %arg2: f32):
    %2 = "arith.mulf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (f32, f32), sym_name = "test_mulf2"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    "func.return"(%0, %1) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (f64, f64), sym_name = "test_divf"}> ({
  ^bb0(%arg2: f64):
    %1 = "arith.constant"() <{value = 5.000000e-01 : f64}> : () -> f64
    "func.return"(%arg2, %1) : (f64, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "test_divf1"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.divf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32), sym_name = "test_addf_rounding_mode"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 2.00000024 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%arg0, %0, %1) : (f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32), sym_name = "test_subf_rounding_mode"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2.00000024 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %3 = "arith.subf"(%0, %arg0) <{fastmath = #arith.fastmath<none>, roundingmode = 1 : i32}> : (f32, f32) -> f32
    "func.return"(%arg0, %1, %2, %3) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32), sym_name = "test_mulf_rounding_mode"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 3.00000048 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 3.00000024 : f32}> : () -> f32
    "func.return"(%arg0, %0, %1) : (f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32), sym_name = "test_divf_rounding_mode"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0.333333343 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0.333333313 : f32}> : () -> f32
    "func.return"(%arg0, %0, %1) : (f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "fold_divui_of_muli_0"}> ({
  ^bb0(%arg10: index, %arg11: index):
    "func.return"(%arg11) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "fold_divui_of_muli_1"}> ({
  ^bb0(%arg8: index, %arg9: index):
    "func.return"(%arg8) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "fold_divsi_of_muli_0"}> ({
  ^bb0(%arg6: index, %arg7: index):
    "func.return"(%arg7) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "fold_divsi_of_muli_1"}> ({
  ^bb0(%arg4: index, %arg5: index):
    "func.return"(%arg4) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "no_fold_divui_of_muli"}> ({
  ^bb0(%arg2: index, %arg3: index):
    %2 = "arith.muli"(%arg2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %3 = "arith.divui"(%2, %arg2) : (index, index) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "no_fold_divsi_of_muli"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.muli"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %1 = "arith.divsi"(%0, %arg0) : (index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (i1, i1, i1, i1), sym_name = "test_cmpf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = false}> : () -> i1
    %1 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%0, %0, %1, %1) : (i1, i1, i1, i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "constant_FPtoUI"}> ({
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "constant_FPtoUI_splat"}> ({
    %1 = "arith.constant"() <{value = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
    "func.return"(%1) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "constant_FPtoUI_vector"}> ({
    %0 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi32>}> : () -> vector<4xi32>
    "func.return"(%0) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "invalid_constant_FPtoUI"}> ({
    %0 = "arith.constant"() <{value = -2.000000e+00 : f32}> : () -> f32
    %1 = "arith.fptoui"(%0) : (f32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "constant_FPtoSI"}> ({
    %2 = "arith.constant"() <{value = -2 : i32}> : () -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "constant_FPtoSI_splat"}> ({
    %1 = "arith.constant"() <{value = dense<-2> : vector<4xi32>}> : () -> vector<4xi32>
    "func.return"(%1) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "constant_FPtoSI_vector"}> ({
    %0 = "arith.constant"() <{value = dense<[-1, -3, -5, -7]> : vector<4xi32>}> : () -> vector<4xi32>
    "func.return"(%0) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i8, sym_name = "invalid_constant_FPtoSI"}> ({
    %3 = "arith.constant"() <{value = 2.000000e+10 : f32}> : () -> f32
    %4 = "arith.fptosi"(%3) : (f32) -> i8
    "func.return"(%4) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "constant_SItoFP"}> ({
    %2 = "arith.constant"() <{value = -2.000000e+00 : f32}> : () -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "constant_SItoFP_splat"}> ({
    %1 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "constant_SItoFP_vector"}> ({
    %0 = "arith.constant"() <{value = dense<[1.000000e+00, 3.000000e+00, 5.000000e+00, 7.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "constant_UItoFP"}> ({
    %2 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "constant_UItoFP_splat"}> ({
    %1 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "constant_UItoFP_vector"}> ({
    %0 = "arith.constant"() <{value = dense<[1.000000e+00, 3.000000e+00, 5.000000e+00, 7.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test1"}> ({
  ^bb0(%arg6: i32):
    %10 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %11 = "arith.cmpi"(%arg6, %10) <{predicate = 7 : i64}> : (i32, i32) -> i1
    "func.return"(%11) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test2"}> ({
  ^bb0(%arg5: i32):
    %8 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %9 = "arith.cmpi"(%arg5, %8) <{predicate = 6 : i64}> : (i32, i32) -> i1
    "func.return"(%9) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test3"}> ({
  ^bb0(%arg4: i32):
    %6 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %7 = "arith.cmpi"(%arg4, %6) <{predicate = 9 : i64}> : (i32, i32) -> i1
    "func.return"(%7) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test4"}> ({
  ^bb0(%arg3: i32):
    %4 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %5 = "arith.cmpi"(%arg3, %4) <{predicate = 8 : i64}> : (i32, i32) -> i1
    "func.return"(%5) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test5"}> ({
  ^bb0(%arg2: i32):
    %3 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%3) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test6"}> ({
  ^bb0(%arg1: i32):
    %2 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%2) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test7"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %1 = "arith.cmpi"(%arg0, %0) <{predicate = 8 : i64}> : (i32, i32) -> i1
    "func.return"(%1) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i64, sym_name = "foldShl"}> ({
    %31 = "arith.constant"() <{value = 4294967296 : i64}> : () -> i64
    "func.return"(%31) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShl"}> ({
    %28 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %29 = "arith.constant"() <{value = 132 : i64}> : () -> i64
    %30 = "arith.shli"(%28, %29) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%30) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShl2"}> ({
    %25 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %26 = "arith.constant"() <{value = -32 : i64}> : () -> i64
    %27 = "arith.shli"(%25, %26) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%27) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShl3"}> ({
    %22 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %23 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %24 = "arith.shli"(%22, %23) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%24) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "foldShru"}> ({
    %21 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    "func.return"(%21) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "foldShru2"}> ({
    %20 = "arith.constant"() <{value = 9223372036854775807 : i64}> : () -> i64
    "func.return"(%20) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShru"}> ({
    %17 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %18 = "arith.constant"() <{value = 132 : i64}> : () -> i64
    %19 = "arith.shrui"(%17, %18) : (i64, i64) -> i64
    "func.return"(%19) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShru2"}> ({
    %14 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %15 = "arith.constant"() <{value = -32 : i64}> : () -> i64
    %16 = "arith.shrui"(%14, %15) : (i64, i64) -> i64
    "func.return"(%16) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShru3"}> ({
    %11 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %12 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %13 = "arith.shrui"(%11, %12) : (i64, i64) -> i64
    "func.return"(%13) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "foldShrs"}> ({
    %10 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    "func.return"(%10) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "foldShrs2"}> ({
    %9 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    "func.return"(%9) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShrs"}> ({
    %6 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %7 = "arith.constant"() <{value = 132 : i64}> : () -> i64
    %8 = "arith.shrsi"(%6, %7) : (i64, i64) -> i64
    "func.return"(%8) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShrs2"}> ({
    %3 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %4 = "arith.constant"() <{value = -32 : i64}> : () -> i64
    %5 = "arith.shrsi"(%3, %4) : (i64, i64) -> i64
    "func.return"(%5) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShrs3"}> ({
    %0 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %2 = "arith.shrsi"(%0, %1) : (i64, i64) -> i64
    "func.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "test_negf"}> ({
    %0 = "arith.constant"() <{value = -2.000000e+00 : f32}> : () -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "test_negf1"}> ({
  ^bb0(%arg0: f32):
    "func.return"(%arg0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "test_flush_denormals_const"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "test_flush_denormals_idempotent"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.flush_denormals"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "test_remui"}> ({
    %0 = "arith.constant"() <{value = dense<[0, 0, 4, 2]> : vector<4xi32>}> : () -> vector<4xi32>
    "func.return"(%0) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "test_remui_1"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    "func.return"(%0) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "test_remsi"}> ({
    %0 = "arith.constant"() <{value = dense<[0, 0, 4, 2]> : vector<4xi32>}> : () -> vector<4xi32>
    "func.return"(%0) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "test_remsi_1"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    "func.return"(%0) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "test_remf"}> ({
    %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (f32, f32), sym_name = "test_remf2"}> ({
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    "func.return"(%1, %2) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "test_remf_vec"}> ({
    %0 = "arith.constant"() <{value = dense<[1.000000e+00, 0.000000e+00, -1.000000e+00, 0.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "test_andi_not_fold_rhs"}> ({
  ^bb0(%arg1: index):
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "test_andi_not_fold_lhs"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "test_andi_not_fold_rhs_vec"}> ({
  ^bb0(%arg1: vector<2xi32>):
    %1 = "arith.constant"() <{value = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
    "func.return"(%1) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "test_andi_not_fold_lhs_vec"}> ({
  ^bb0(%arg0: vector<2xi32>):
    %0 = "arith.constant"() <{value = dense<0> : vector<2xi32>}> : () -> vector<2xi32>
    "func.return"(%0) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "xorxor0"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "xorxor1"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "xorxor2"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "xorxor3"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "andand0"}> ({
  ^bb0(%arg6: i32, %arg7: i32):
    %3 = "arith.andi"(%arg6, %arg7) : (i32, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "andand1"}> ({
  ^bb0(%arg4: i32, %arg5: i32):
    %2 = "arith.andi"(%arg4, %arg5) : (i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "andand2"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %1 = "arith.andi"(%arg2, %arg3) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "andand3"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.andi"(%arg0, %arg1) : (i32, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIToTrunciShrUI"}> ({
  ^bb0(%arg28: i64):
    %56 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %57 = "arith.shrui"(%arg28, %56) : (i64, i64) -> i64
    %58 = "arith.trunci"(%57) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%58) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIExactToTrunciShrUIExact"}> ({
  ^bb0(%arg27: i64):
    %53 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %54 = "arith.shrui"(%arg27, %53) <{isExact}> : (i64, i64) -> i64
    %55 = "arith.trunci"(%54) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%55) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIToTrunciShrUIBadShiftAmt1"}> ({
  ^bb0(%arg26: i64):
    %50 = "arith.constant"() <{value = 33 : i64}> : () -> i64
    %51 = "arith.shrsi"(%arg26, %50) : (i64, i64) -> i64
    %52 = "arith.trunci"(%51) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%52) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIToTrunciShrUIBadShiftAmt2"}> ({
  ^bb0(%arg25: i64):
    %47 = "arith.constant"() <{value = 31 : i64}> : () -> i64
    %48 = "arith.shrsi"(%arg25, %47) : (i64, i64) -> i64
    %49 = "arith.trunci"(%48) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%49) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "foldShli0"}> ({
  ^bb0(%arg24: i64):
    "func.return"(%arg24) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "foldShrui0"}> ({
  ^bb0(%arg23: i64):
    "func.return"(%arg23) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "foldShrsi0"}> ({
  ^bb0(%arg22: i64):
    "func.return"(%arg22) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor1"}> ({
  ^bb0(%arg21: i1):
    %46 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%46) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor2"}> ({
  ^bb0(%arg20: i1):
    %45 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%45) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor3"}> ({
  ^bb0(%arg19: i1):
    %44 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%44) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor4"}> ({
  ^bb0(%arg18: i1):
    %43 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%43) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "foldOrXor5"}> ({
  ^bb0(%arg17: i32):
    %42 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    "func.return"(%42) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "foldOrXor6"}> ({
  ^bb0(%arg16: index):
    %41 = "arith.constant"() <{value = -1 : index}> : () -> index
    "func.return"(%41) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32) -> (i32, i32, i32, i32), sym_name = "selectOfPoison"}> ({
  ^bb0(%arg14: i1, %arg15: i32):
    %40 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    "func.return"(%arg15, %arg15, %40, %arg15) : (i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "addi_poison1"}> ({
  ^bb0(%arg13: i32):
    %39 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    "func.return"(%39) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "addi_poison2"}> ({
  ^bb0(%arg12: i32):
    %38 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    "func.return"(%38) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "addf_poison1"}> ({
  ^bb0(%arg11: f32):
    %37 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    "func.return"(%37) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "addf_poison2"}> ({
  ^bb0(%arg10: f32):
    %36 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    "func.return"(%36) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "negf_poison"}> ({
    %35 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    "func.return"(%35) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "extsi_poison"}> ({
    %34 = "ub.poison"() <{value = #ub.poison}> : () -> i64
    "func.return"(%34) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<i16>, sym_name = "unsignedExtendConstantResource"}> ({
    %32 = "arith.constant"() <{value = dense_resource<blob1> : tensor<i8>}> : () -> tensor<i8>
    %33 = "arith.extui"(%32) : (tensor<i8>) -> tensor<i16>
    "func.return"(%33) : (tensor<i16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> bf16, sym_name = "sequences_fastmath_contract"}> ({
  ^bb0(%arg9: bf16):
    %28 = "arith.extf"(%arg9) <{fastmath = #arith.fastmath<contract>}> : (bf16) -> f32
    %29 = "math.absf"(%28) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %30 = "math.sin"(%29) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %31 = "arith.truncf"(%30) <{fastmath = #arith.fastmath<contract>}> : (f32) -> bf16
    "func.return"(%31) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> bf16, sym_name = "sequences_no_fastmath"}> ({
  ^bb0(%arg8: bf16):
    %22 = "arith.extf"(%arg8) : (bf16) -> f32
    %23 = "math.absf"(%22) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %24 = "arith.truncf"(%23) : (f32) -> bf16
    %25 = "arith.extf"(%24) : (bf16) -> f32
    %26 = "math.sin"(%25) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %27 = "arith.truncf"(%26) : (f32) -> bf16
    "func.return"(%27) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "eliminate_cast_to_f16"}> ({
  ^bb0(%arg7: f32):
    "func.return"(%arg7) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "eliminate_cast_to_bf16"}> ({
  ^bb0(%arg6: f32):
    "func.return"(%arg6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<32x32x32xbf16>) -> vector<32x32x32xbf16>, sym_name = "bf16_sin_vector"}> ({
  ^bb0(%arg5: vector<32x32x32xbf16>):
    %18 = "arith.extf"(%arg5) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %19 = "math.absf"(%18) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %20 = "math.sin"(%19) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %21 = "arith.truncf"(%20) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xbf16>
    "func.return"(%21) : (vector<32x32x32xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<32x32x32xf16>) -> vector<32x32x32xf16>, sym_name = "f16_sin_vector"}> ({
  ^bb0(%arg4: vector<32x32x32xf16>):
    %14 = "arith.extf"(%arg4) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf16>) -> vector<32x32x32xf32>
    %15 = "math.absf"(%14) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %16 = "math.sin"(%15) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %17 = "arith.truncf"(%16) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf16>
    "func.return"(%17) : (vector<32x32x32xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<32x32x32xbf16>) -> vector<32x32x32xbf16>, sym_name = "bf16_branch_vector"}> ({
  ^bb0(%arg3: vector<32x32x32xbf16>):
    %8 = "arith.extf"(%arg3) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %9 = "math.absf"(%8) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %10 = "math.sin"(%9) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %11 = "math.cos"(%9) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %12 = "arith.addf"(%10, %11) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>, vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %13 = "arith.truncf"(%12) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xbf16>
    "func.return"(%13) : (vector<32x32x32xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<32x32x32xbf16>, vector<32x32x32xbf16>, vector<32x32x32xbf16>) -> vector<32x32x32xbf16>, sym_name = "bf16_fma"}> ({
  ^bb0(%arg0: vector<32x32x32xbf16>, %arg1: vector<32x32x32xbf16>, %arg2: vector<32x32x32xbf16>):
    %0 = "arith.extf"(%arg0) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %1 = "math.absf"(%0) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %2 = "math.sin"(%1) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %3 = "arith.truncf"(%2) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xbf16>
    %4 = "math.fma"(%3, %arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xbf16>, vector<32x32x32xbf16>, vector<32x32x32xbf16>) -> vector<32x32x32xbf16>
    %5 = "arith.extf"(%4) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %6 = "arith.addf"(%5, %2) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>, vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %7 = "arith.truncf"(%6) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xbf16>
    "func.return"(%7) : (vector<32x32x32xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "unreachable"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

{-#
  dialect_resources: {
    builtin: {
      blob1: "0x08000000010000000000000002000000000000000300000000000000"
    }
  }
#-}

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xi32>) -> tensor<?xi1>, sym_name = "cmpi_dynamic_shape_no_fold"}> ({
  ^bb0(%arg0: tensor<?xi32>):
    %0 = "arith.cmpi"(%arg0, %arg0) <{predicate = 0 : i64}> : (tensor<?xi32>, tensor<?xi32>) -> tensor<?xi1>
    "func.return"(%0) : (tensor<?xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f4E2M1FN, sym_name = "truncf_inf_to_finite_only_no_fold"}> ({
    %0 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %1 = "arith.truncf"(%0) : (f32) -> f4E2M1FN
    "func.return"(%1) : (f4E2M1FN) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f4E2M1FN, sym_name = "truncf_neg_inf_to_finite_only_no_fold"}> ({
    %0 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %1 = "arith.truncf"(%0) : (f32) -> f4E2M1FN
    "func.return"(%1) : (f4E2M1FN) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f8E5M2, sym_name = "convertf_fold_f8"}> ({
    %0 = "arith.constant"() <{value = 2.000000e+00 : f8E5M2}> : () -> f8E5M2
    "func.return"(%0) : (f8E5M2) -> ()
  }) : () -> ()
}) : () -> ()

