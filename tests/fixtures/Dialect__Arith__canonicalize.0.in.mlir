"builtin.module"() ({
  "func.func"() <{function_type = (i1, i64) -> i64, sym_name = "select_same_val"}> ({
  ^bb0(%arg36: i1, %arg37: i64):
    %80 = "arith.select"(%arg36, %arg37, %arg37) : (i1, i64, i64) -> i64
    "func.return"(%80) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "select_cmp_eq_select"}> ({
  ^bb0(%arg34: i64, %arg35: i64):
    %78 = "arith.cmpi"(%arg34, %arg35) <{predicate = 0 : i64}> : (i64, i64) -> i1
    %79 = "arith.select"(%78, %arg34, %arg35) : (i1, i64, i64) -> i64
    "func.return"(%79) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "select_cmp_ne_select"}> ({
  ^bb0(%arg32: i64, %arg33: i64):
    %76 = "arith.cmpi"(%arg32, %arg33) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %77 = "arith.select"(%76, %arg32, %arg33) : (i1, i64, i64) -> i64
    "func.return"(%77) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i64, sym_name = "select_extui"}> ({
  ^bb0(%arg31: i1):
    %73 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %74 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %75 = "arith.select"(%arg31, %74, %73) : (i1, i64, i64) -> i64
    "func.return"(%75) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i64, sym_name = "select_extui2"}> ({
  ^bb0(%arg30: i1):
    %70 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %71 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %72 = "arith.select"(%arg30, %70, %71) : (i1, i64, i64) -> i64
    "func.return"(%72) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "select_extui_i1"}> ({
  ^bb0(%arg29: i1):
    %67 = "arith.constant"() <{value = false}> : () -> i1
    %68 = "arith.constant"() <{value = true}> : () -> i1
    %69 = "arith.select"(%arg29, %68, %67) : (i1, i1, i1) -> i1
    "func.return"(%69) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> ui1, sym_name = "select_no_fold_ui1"}> ({
  ^bb0(%arg28: i1):
    %64 = "test.constant"() <{value = 0 : i32}> : () -> ui1
    %65 = "test.constant"() <{value = 1 : i32}> : () -> ui1
    %66 = "arith.select"(%arg28, %65, %64) : (i1, ui1, ui1) -> ui1
    "func.return"(%66) : (ui1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "select_cst_false_scalar"}> ({
  ^bb0(%arg26: i32, %arg27: i32):
    %62 = "arith.constant"() <{value = false}> : () -> i1
    %63 = "arith.select"(%62, %arg26, %arg27) : (i1, i32, i32) -> i32
    "func.return"(%63) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "select_cst_true_scalar"}> ({
  ^bb0(%arg24: i32, %arg25: i32):
    %60 = "arith.constant"() <{value = true}> : () -> i1
    %61 = "arith.select"(%60, %arg24, %arg25) : (i1, i32, i32) -> i32
    "func.return"(%61) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "select_cst_true_splat"}> ({
    %56 = "arith.constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    %57 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %58 = "arith.constant"() <{value = dense<[4, 5, 6]> : vector<3xi32>}> : () -> vector<3xi32>
    %59 = "arith.select"(%56, %57, %58) : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%59) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "select_cst_vector_i32"}> ({
    %52 = "arith.constant"() <{value = dense<[true, false, true]> : vector<3xi1>}> : () -> vector<3xi1>
    %53 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %54 = "arith.constant"() <{value = dense<[4, 5, 6]> : vector<3xi32>}> : () -> vector<3xi32>
    %55 = "arith.select"(%52, %53, %54) : (vector<3xi1>, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%55) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xf32>, sym_name = "select_cst_vector_f32"}> ({
    %48 = "arith.constant"() <{value = dense<[false, true, false]> : vector<3xi1>}> : () -> vector<3xi1>
    %49 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>}> : () -> vector<3xf32>
    %50 = "arith.constant"() <{value = dense<[4.000000e+00, 5.000000e+00, 6.000000e+00]> : vector<3xf32>}> : () -> vector<3xf32>
    %51 = "arith.select"(%48, %49, %50) : (vector<3xi1>, vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    "func.return"(%51) : (vector<3xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "selToNot"}> ({
  ^bb0(%arg23: i1):
    %45 = "arith.constant"() <{value = true}> : () -> i1
    %46 = "arith.constant"() <{value = false}> : () -> i1
    %47 = "arith.select"(%arg23, %46, %45) : (i1, i1, i1) -> i1
    "func.return"(%47) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32, i32, i32) -> i32, sym_name = "redundantSelectTrue"}> ({
  ^bb0(%arg19: i1, %arg20: i32, %arg21: i32, %arg22: i32):
    %43 = "arith.select"(%arg19, %arg20, %arg21) : (i1, i32, i32) -> i32
    %44 = "arith.select"(%arg19, %43, %arg22) : (i1, i32, i32) -> i32
    "func.return"(%44) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32, i32, i32) -> i32, sym_name = "redundantSelectFalse"}> ({
  ^bb0(%arg15: i1, %arg16: i32, %arg17: i32, %arg18: i32):
    %41 = "arith.select"(%arg15, %arg16, %arg17) : (i1, i32, i32) -> i32
    %42 = "arith.select"(%arg15, %arg18, %41) : (i1, i32, i32) -> i32
    "func.return"(%42) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32, i32, i32, i32) -> (i32, i32), sym_name = "selNotCond"}> ({
  ^bb0(%arg10: i1, %arg11: i32, %arg12: i32, %arg13: i32, %arg14: i32):
    %36 = "arith.constant"() <{value = true}> : () -> i1
    %37 = "arith.xori"(%arg10, %36) : (i1, i1) -> i1
    %38 = "arith.xori"(%36, %arg10) : (i1, i1) -> i1
    %39 = "arith.select"(%37, %arg11, %arg12) : (i1, i32, i32) -> i32
    %40 = "arith.select"(%38, %arg13, %arg14) : (i1, i32, i32) -> i32
    "func.return"(%39, %40) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "cmpiI1eq"}> ({
  ^bb0(%arg9: i1):
    %34 = "arith.constant"() <{value = true}> : () -> i1
    %35 = "arith.cmpi"(%arg9, %34) <{predicate = 0 : i64}> : (i1, i1) -> i1
    "func.return"(%35) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "cmpiI1eqVec"}> ({
  ^bb0(%arg8: vector<4xi1>):
    %32 = "arith.constant"() <{value = dense<true> : vector<4xi1>}> : () -> vector<4xi1>
    %33 = "arith.cmpi"(%arg8, %32) <{predicate = 0 : i64}> : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "func.return"(%33) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "cmpiI1ne"}> ({
  ^bb0(%arg7: i1):
    %30 = "arith.constant"() <{value = false}> : () -> i1
    %31 = "arith.cmpi"(%arg7, %30) <{predicate = 1 : i64}> : (i1, i1) -> i1
    "func.return"(%31) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "cmpiI1neVec"}> ({
  ^bb0(%arg6: vector<4xi1>):
    %28 = "arith.constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    %29 = "arith.cmpi"(%arg6, %28) <{predicate = 1 : i64}> : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "func.return"(%29) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "cmpiI1eqLhs"}> ({
  ^bb0(%arg5: i1):
    %26 = "arith.constant"() <{value = true}> : () -> i1
    %27 = "arith.cmpi"(%26, %arg5) <{predicate = 0 : i64}> : (i1, i1) -> i1
    "func.return"(%27) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "cmpiI1eqVecLhs"}> ({
  ^bb0(%arg4: vector<4xi1>):
    %24 = "arith.constant"() <{value = dense<true> : vector<4xi1>}> : () -> vector<4xi1>
    %25 = "arith.cmpi"(%24, %arg4) <{predicate = 0 : i64}> : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "func.return"(%25) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "cmpiI1neLhs"}> ({
  ^bb0(%arg3: i1):
    %22 = "arith.constant"() <{value = false}> : () -> i1
    %23 = "arith.cmpi"(%22, %arg3) <{predicate = 1 : i64}> : (i1, i1) -> i1
    "func.return"(%23) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "cmpiI1neVecLhs"}> ({
  ^bb0(%arg2: vector<4xi1>):
    %20 = "arith.constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    %21 = "arith.cmpi"(%20, %arg2) <{predicate = 1 : i64}> : (vector<4xi1>, vector<4xi1>) -> vector<4xi1>
    "func.return"(%21) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> (i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), sym_name = "cmpi_equal_operands"}> ({
  ^bb0(%arg1: i64):
    %10 = "arith.cmpi"(%arg1, %arg1) <{predicate = 0 : i64}> : (i64, i64) -> i1
    %11 = "arith.cmpi"(%arg1, %arg1) <{predicate = 3 : i64}> : (i64, i64) -> i1
    %12 = "arith.cmpi"(%arg1, %arg1) <{predicate = 5 : i64}> : (i64, i64) -> i1
    %13 = "arith.cmpi"(%arg1, %arg1) <{predicate = 7 : i64}> : (i64, i64) -> i1
    %14 = "arith.cmpi"(%arg1, %arg1) <{predicate = 9 : i64}> : (i64, i64) -> i1
    %15 = "arith.cmpi"(%arg1, %arg1) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %16 = "arith.cmpi"(%arg1, %arg1) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %17 = "arith.cmpi"(%arg1, %arg1) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %18 = "arith.cmpi"(%arg1, %arg1) <{predicate = 6 : i64}> : (i64, i64) -> i1
    %19 = "arith.cmpi"(%arg1, %arg1) <{predicate = 8 : i64}> : (i64, i64) -> i1
    "func.return"(%10, %11, %12, %13, %14, %15, %16, %17, %18, %19) : (i1, i1, i1, i1, i1, i1, i1, i1, i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<1x8xi64>) -> (vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>), sym_name = "cmpi_equal_vector_operands"}> ({
  ^bb0(%arg0: vector<1x8xi64>):
    %0 = "arith.cmpi"(%arg0, %arg0) <{predicate = 0 : i64}> : (vector<1x8xi64>, vector<1x8xi64>) -> vector<1x8xi1>
    %1 = "arith.cmpi"(%arg0, %arg0) <{predicate = 3 : i64}> : (vector<1x8xi64>, vector<1x8xi64>) -> vector<1x8xi1>
    %2 = "arith.cmpi"(%arg0, %arg0) <{predicate = 5 : i64}> : (vector<1x8xi64>, vector<1x8xi64>) -> vector<1x8xi1>
    %3 = "arith.cmpi"(%arg0, %arg0) <{predicate = 7 : i64}> : (vector<1x8xi64>, vector<1x8xi64>) -> vector<1x8xi1>
    %4 = "arith.cmpi"(%arg0, %arg0) <{predicate = 9 : i64}> : (vector<1x8xi64>, vector<1x8xi64>) -> vector<1x8xi1>
    %5 = "arith.cmpi"(%arg0, %arg0) <{predicate = 1 : i64}> : (vector<1x8xi64>, vector<1x8xi64>) -> vector<1x8xi1>
    %6 = "arith.cmpi"(%arg0, %arg0) <{predicate = 2 : i64}> : (vector<1x8xi64>, vector<1x8xi64>) -> vector<1x8xi1>
    %7 = "arith.cmpi"(%arg0, %arg0) <{predicate = 4 : i64}> : (vector<1x8xi64>, vector<1x8xi64>) -> vector<1x8xi1>
    %8 = "arith.cmpi"(%arg0, %arg0) <{predicate = 6 : i64}> : (vector<1x8xi64>, vector<1x8xi64>) -> vector<1x8xi1>
    %9 = "arith.cmpi"(%arg0, %arg0) <{predicate = 8 : i64}> : (vector<1x8xi64>, vector<1x8xi64>) -> vector<1x8xi1>
    "func.return"(%0, %1, %2, %3, %4, %5, %6, %7, %8, %9) : (vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>, vector<1x8xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> (i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), sym_name = "cmpi_const_right"}> ({
  ^bb0(%arg0: i64):
    %0 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %1 = "arith.cmpi"(%0, %arg0) <{predicate = 0 : i64}> : (i64, i64) -> i1
    %2 = "arith.cmpi"(%0, %arg0) <{predicate = 3 : i64}> : (i64, i64) -> i1
    %3 = "arith.cmpi"(%0, %arg0) <{predicate = 5 : i64}> : (i64, i64) -> i1
    %4 = "arith.cmpi"(%0, %arg0) <{predicate = 7 : i64}> : (i64, i64) -> i1
    %5 = "arith.cmpi"(%0, %arg0) <{predicate = 9 : i64}> : (i64, i64) -> i1
    %6 = "arith.cmpi"(%0, %arg0) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %7 = "arith.cmpi"(%0, %arg0) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %8 = "arith.cmpi"(%0, %arg0) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %9 = "arith.cmpi"(%0, %arg0) <{predicate = 6 : i64}> : (i64, i64) -> i1
    %10 = "arith.cmpi"(%0, %arg0) <{predicate = 8 : i64}> : (i64, i64) -> i1
    "func.return"(%1, %2, %3, %4, %5, %6, %7, %8, %9, %10) : (i1, i1, i1, i1, i1, i1, i1, i1, i1, i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i1, sym_name = "cmpOfExtSI"}> ({
  ^bb0(%arg1: i1):
    %3 = "arith.extsi"(%arg1) : (i1) -> i64
    %4 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %5 = "arith.cmpi"(%3, %4) <{predicate = 1 : i64}> : (i64, i64) -> i1
    "func.return"(%5) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "cmpOfExtUI"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.extui"(%arg0) : (i1) -> i64
    %1 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %2 = "arith.cmpi"(%0, %1) <{predicate = 1 : i64}> : (i64, i64) -> i1
    "func.return"(%2) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "cmpOfExtSIVector"}> ({
  ^bb0(%arg1: vector<4xi1>):
    %3 = "arith.extsi"(%arg1) : (vector<4xi1>) -> vector<4xi64>
    %4 = "arith.constant"() <{value = dense<0> : vector<4xi64>}> : () -> vector<4xi64>
    %5 = "arith.cmpi"(%3, %4) <{predicate = 1 : i64}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi1>
    "func.return"(%5) : (vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi1>) -> vector<4xi1>, sym_name = "cmpOfExtUIVector"}> ({
  ^bb0(%arg0: vector<4xi1>):
    %0 = "arith.extui"(%arg0) : (vector<4xi1>) -> vector<4xi64>
    %1 = "arith.constant"() <{value = dense<0> : vector<4xi64>}> : () -> vector<4xi64>
    %2 = "arith.cmpi"(%0, %1) <{predicate = 1 : i64}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi1>
    "func.return"(%2) : (vector<4xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i64, sym_name = "extSIOfExtUI"}> ({
  ^bb0(%arg2: i1):
    %4 = "arith.extui"(%arg2) : (i1) -> i8
    %5 = "arith.extsi"(%4) : (i8) -> i64
    "func.return"(%5) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i64, sym_name = "extUIOfExtUI"}> ({
  ^bb0(%arg1: i1):
    %2 = "arith.extui"(%arg1) : (i1) -> i8
    %3 = "arith.extui"(%2) : (i8) -> i64
    "func.return"(%3) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i64, sym_name = "extSIOfExtSI"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.extsi"(%arg0) : (i1) -> i8
    %1 = "arith.extsi"(%0) : (i8) -> i64
    "func.return"(%1) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "cmpIExtSINE"}> ({
  ^bb0(%arg6: i8, %arg7: i8):
    %21 = "arith.extsi"(%arg6) : (i8) -> i64
    %22 = "arith.extsi"(%arg7) : (i8) -> i64
    %23 = "arith.cmpi"(%21, %22) <{predicate = 1 : i64}> : (i64, i64) -> i1
    "func.return"(%23) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "cmpIExtSIEQ"}> ({
  ^bb0(%arg4: i8, %arg5: i8):
    %18 = "arith.extsi"(%arg4) : (i8) -> i64
    %19 = "arith.extsi"(%arg5) : (i8) -> i64
    %20 = "arith.cmpi"(%18, %19) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "func.return"(%20) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "cmpIExtUINE"}> ({
  ^bb0(%arg2: i8, %arg3: i8):
    %15 = "arith.extui"(%arg2) : (i8) -> i64
    %16 = "arith.extui"(%arg3) : (i8) -> i64
    %17 = "arith.cmpi"(%15, %16) <{predicate = 1 : i64}> : (i64, i64) -> i1
    "func.return"(%17) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "cmpIExtUIEQ"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %12 = "arith.extui"(%arg0) : (i8) -> i64
    %13 = "arith.extui"(%arg1) : (i8) -> i64
    %14 = "arith.cmpi"(%12, %13) <{predicate = 0 : i64}> : (i64, i64) -> i1
    "func.return"(%14) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "cmpIFoldEQ"}> ({
    %9 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %10 = "arith.constant"() <{value = dense<[1, 2, 4]> : vector<3xi32>}> : () -> vector<3xi32>
    %11 = "arith.cmpi"(%9, %10) <{predicate = 0 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%11) : (vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "cmpIFoldNE"}> ({
    %6 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %7 = "arith.constant"() <{value = dense<[1, 2, 4]> : vector<3xi32>}> : () -> vector<3xi32>
    %8 = "arith.cmpi"(%6, %7) <{predicate = 1 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%8) : (vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "cmpIFoldSGE"}> ({
    %3 = "arith.constant"() <{value = dense<2> : vector<3xi32>}> : () -> vector<3xi32>
    %4 = "arith.constant"() <{value = dense<[1, 2, 4]> : vector<3xi32>}> : () -> vector<3xi32>
    %5 = "arith.cmpi"(%3, %4) <{predicate = 5 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%5) : (vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi1>, sym_name = "cmpIFoldULT"}> ({
    %0 = "arith.constant"() <{value = dense<2> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "arith.constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
    %2 = "arith.cmpi"(%0, %1) <{predicate = 6 : i64}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi1>
    "func.return"(%2) : (vector<3xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "andOfExtSI"}> ({
  ^bb0(%arg6: i8, %arg7: i8):
    %9 = "arith.extsi"(%arg6) : (i8) -> i64
    %10 = "arith.extsi"(%arg7) : (i8) -> i64
    %11 = "arith.andi"(%9, %10) : (i64, i64) -> i64
    "func.return"(%11) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "andOfExtUI"}> ({
  ^bb0(%arg4: i8, %arg5: i8):
    %6 = "arith.extui"(%arg4) : (i8) -> i64
    %7 = "arith.extui"(%arg5) : (i8) -> i64
    %8 = "arith.andi"(%6, %7) : (i64, i64) -> i64
    "func.return"(%8) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "orOfExtSI"}> ({
  ^bb0(%arg2: i8, %arg3: i8):
    %3 = "arith.extsi"(%arg2) : (i8) -> i64
    %4 = "arith.extsi"(%arg3) : (i8) -> i64
    %5 = "arith.ori"(%3, %4) : (i64, i64) -> i64
    "func.return"(%5) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "orOfExtUI"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %0 = "arith.extui"(%arg0) : (i8) -> i64
    %1 = "arith.extui"(%arg1) : (i8) -> i64
    %2 = "arith.ori"(%0, %1) : (i64, i64) -> i64
    "func.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> index, sym_name = "indexCastOfSignExtend"}> ({
  ^bb0(%arg111: i8):
    %316 = "arith.extsi"(%arg111) : (i8) -> i16
    %317 = "arith.index_cast"(%316) : (i16) -> index
    "func.return"(%317) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> index, sym_name = "indexCastUIOfUnsignedExtend"}> ({
  ^bb0(%arg110: i8):
    %314 = "arith.extui"(%arg110) : (i8) -> i16
    %315 = "arith.index_castui"(%314) : (i16) -> index
    "func.return"(%315) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "indexCastFold"}> ({
    %312 = "arith.constant"() <{value = -2 : i8}> : () -> i8
    %313 = "arith.index_cast"(%312) : (i8) -> index
    "func.return"(%313) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "indexCastFoldIndexToInt"}> ({
    %310 = "arith.constant"() <{value = 1 : index}> : () -> index
    %311 = "arith.index_cast"(%310) : (index) -> i32
    "func.return"(%311) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastFoldSplatVector"}> ({
    %308 = "arith.constant"() <{value = dense<42> : vector<3xi32>}> : () -> vector<3xi32>
    %309 = "arith.index_cast"(%308) : (vector<3xi32>) -> vector<3xindex>
    "func.return"(%309) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastFoldVector"}> ({
    %306 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %307 = "arith.index_cast"(%306) : (vector<3xi32>) -> vector<3xindex>
    "func.return"(%307) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastFoldSplatVectorIndexToInt"}> ({
    %304 = "arith.constant"() <{value = dense<42> : vector<3xindex>}> : () -> vector<3xindex>
    %305 = "arith.index_cast"(%304) : (vector<3xindex>) -> vector<3xi32>
    "func.return"(%305) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastFoldVectorIndexToInt"}> ({
    %302 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xindex>}> : () -> vector<3xindex>
    %303 = "arith.index_cast"(%302) : (vector<3xindex>) -> vector<3xi32>
    "func.return"(%303) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "indexCastUIFold"}> ({
    %300 = "arith.constant"() <{value = -2 : i8}> : () -> i8
    %301 = "arith.index_castui"(%300) : (i8) -> index
    "func.return"(%301) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastUIFoldSplatVector"}> ({
    %298 = "arith.constant"() <{value = dense<42> : vector<3xi32>}> : () -> vector<3xi32>
    %299 = "arith.index_castui"(%298) : (vector<3xi32>) -> vector<3xindex>
    "func.return"(%299) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastUIFoldVector"}> ({
    %296 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %297 = "arith.index_castui"(%296) : (vector<3xi32>) -> vector<3xindex>
    "func.return"(%297) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "indexCastUIFoldIndexToInt"}> ({
    %294 = "arith.constant"() <{value = 1 : index}> : () -> index
    %295 = "arith.index_castui"(%294) : (index) -> i32
    "func.return"(%295) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastUIFoldSplatVectorIndexToInt"}> ({
    %292 = "arith.constant"() <{value = dense<42> : vector<3xindex>}> : () -> vector<3xindex>
    %293 = "arith.index_castui"(%292) : (vector<3xindex>) -> vector<3xi32>
    "func.return"(%293) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastUIFoldVectorIndexToInt"}> ({
    %290 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xindex>}> : () -> vector<3xindex>
    %291 = "arith.index_castui"(%290) : (vector<3xindex>) -> vector<3xi32>
    "func.return"(%291) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "signExtendConstant"}> ({
    %288 = "arith.constant"() <{value = -2 : i8}> : () -> i8
    %289 = "arith.extsi"(%288) : (i8) -> i16
    "func.return"(%289) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "signExtendConstantSplat"}> ({
    %285 = "arith.constant"() <{value = -2 : i8}> : () -> i8
    %286 = "vector.broadcast"(%285) : (i8) -> vector<4xi8>
    %287 = "arith.extsi"(%286) : (vector<4xi8>) -> vector<4xi16>
    "func.return"(%287) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "signExtendConstantVector"}> ({
    %283 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi8>}> : () -> vector<4xi8>
    %284 = "arith.extsi"(%283) : (vector<4xi8>) -> vector<4xi16>
    "func.return"(%284) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "unsignedExtendConstant"}> ({
    %281 = "arith.constant"() <{value = 2 : i8}> : () -> i8
    %282 = "arith.extui"(%281) : (i8) -> i16
    "func.return"(%282) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "unsignedExtendConstantSplat"}> ({
    %278 = "arith.constant"() <{value = 2 : i8}> : () -> i8
    %279 = "vector.broadcast"(%278) : (i8) -> vector<4xi8>
    %280 = "arith.extui"(%279) : (vector<4xi8>) -> vector<4xi16>
    "func.return"(%280) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "unsignedExtendConstantVector"}> ({
    %276 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi8>}> : () -> vector<4xi8>
    %277 = "arith.extui"(%276) : (vector<4xi8>) -> vector<4xi16>
    "func.return"(%277) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "extFPConstant"}> ({
    %274 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %275 = "arith.extf"(%274) : (f32) -> f64
    "func.return"(%275) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<2xf128>, sym_name = "extFPVectorConstant"}> ({
    %272 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00]> : vector<2xf80>}> : () -> vector<2xf80>
    %273 = "arith.extf"(%272) : (vector<2xf80>) -> vector<2xf128>
    "func.return"(%273) : (vector<2xf128>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "truncExtf"}> ({
  ^bb0(%arg109: f32):
    %270 = "arith.extf"(%arg109) : (f32) -> f64
    %271 = "arith.truncf"(%270) : (f64) -> f32
    "func.return"(%271) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> bf16, sym_name = "truncExtf1"}> ({
  ^bb0(%arg108: bf16):
    %268 = "arith.extf"(%arg108) : (bf16) -> f32
    %269 = "arith.truncf"(%268) : (f32) -> bf16
    "func.return"(%269) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> f16, sym_name = "truncExtf2"}> ({
  ^bb0(%arg107: bf16):
    %266 = "arith.extf"(%arg107) : (bf16) -> f32
    %267 = "arith.truncf"(%266) : (f32) -> f16
    "func.return"(%267) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f16, sym_name = "truncExtf3"}> ({
  ^bb0(%arg106: f32):
    %264 = "arith.extf"(%arg106) : (f32) -> f64
    %265 = "arith.truncf"(%264) : (f64) -> f16
    "func.return"(%265) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "truncSitofp"}> ({
  ^bb0(%arg105: i32):
    %262 = "arith.sitofp"(%arg105) : (i32) -> f64
    %263 = "arith.truncf"(%262) : (f64) -> f32
    "func.return"(%263) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "truncSitofpConstrained"}> ({
  ^bb0(%arg104: i32):
    %260 = "arith.sitofp"(%arg104) : (i32) -> f64
    %261 = "arith.truncf"(%260) <{roundingmode = 0 : i32}> : (f64) -> f32
    "func.return"(%261) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncConstant"}> ({
  ^bb0(%arg103: i8):
    %258 = "arith.constant"() <{value = -2 : i32}> : () -> i32
    %259 = "arith.trunci"(%258) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i16
    "func.return"(%259) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "truncExtui"}> ({
  ^bb0(%arg102: i32):
    %256 = "arith.extui"(%arg102) : (i32) -> i64
    %257 = "arith.trunci"(%256) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%257) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i16, sym_name = "truncExtui2"}> ({
  ^bb0(%arg101: i32):
    %254 = "arith.extui"(%arg101) : (i32) -> i64
    %255 = "arith.trunci"(%254) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i16
    "func.return"(%255) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncExtui3"}> ({
  ^bb0(%arg100: i8):
    %252 = "arith.extui"(%arg100) : (i8) -> i32
    %253 = "arith.trunci"(%252) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i16
    "func.return"(%253) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi16>, sym_name = "truncExtuiVector"}> ({
  ^bb0(%arg99: vector<2xi32>):
    %250 = "arith.extui"(%arg99) : (vector<2xi32>) -> vector<2xi64>
    %251 = "arith.trunci"(%250) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi64>) -> vector<2xi16>
    "func.return"(%251) : (vector<2xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "truncExtsi"}> ({
  ^bb0(%arg98: i32):
    %248 = "arith.extsi"(%arg98) : (i32) -> i64
    %249 = "arith.trunci"(%248) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%249) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i16, sym_name = "truncExtsi2"}> ({
  ^bb0(%arg97: i32):
    %246 = "arith.extsi"(%arg97) : (i32) -> i64
    %247 = "arith.trunci"(%246) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i16
    "func.return"(%247) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncExtsi3"}> ({
  ^bb0(%arg96: i8):
    %244 = "arith.extsi"(%arg96) : (i8) -> i32
    %245 = "arith.trunci"(%244) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i16
    "func.return"(%245) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi16>, sym_name = "truncExtsiVector"}> ({
  ^bb0(%arg95: vector<2xi32>):
    %242 = "arith.extsi"(%arg95) : (vector<2xi32>) -> vector<2xi64>
    %243 = "arith.trunci"(%242) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi64>) -> vector<2xi16>
    "func.return"(%243) : (vector<2xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi8>, sym_name = "truncConstantSplat"}> ({
    %239 = "arith.constant"() <{value = -2 : i16}> : () -> i16
    %240 = "vector.broadcast"(%239) : (i16) -> vector<4xi16>
    %241 = "arith.trunci"(%240) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi16>) -> vector<4xi8>
    "func.return"(%241) : (vector<4xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi8>, sym_name = "truncConstantVector"}> ({
    %237 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi16>}> : () -> vector<4xi16>
    %238 = "arith.trunci"(%237) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi16>) -> vector<4xi8>
    "func.return"(%238) : (vector<4xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i8, sym_name = "truncTrunc"}> ({
  ^bb0(%arg94: i64):
    %235 = "arith.trunci"(%arg94) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %236 = "arith.trunci"(%235) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
    "func.return"(%236) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPConstant"}> ({
    %233 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %234 = "arith.truncf"(%233) : (f32) -> bf16
    "func.return"(%234) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPToNearestEvenConstant"}> ({
    %231 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %232 = "arith.truncf"(%231) <{roundingmode = 0 : i32}> : (f32) -> bf16
    "func.return"(%232) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPDownwardConstant"}> ({
    %229 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %230 = "arith.truncf"(%229) <{roundingmode = 1 : i32}> : (f32) -> bf16
    "func.return"(%230) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPUpwardConstant"}> ({
    %227 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %228 = "arith.truncf"(%227) <{roundingmode = 2 : i32}> : (f32) -> bf16
    "func.return"(%228) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPTowardZeroConstant"}> ({
    %225 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %226 = "arith.truncf"(%225) <{roundingmode = 3 : i32}> : (f32) -> bf16
    "func.return"(%226) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPToNearestAwayConstant"}> ({
    %223 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %224 = "arith.truncf"(%223) <{roundingmode = 4 : i32}> : (f32) -> bf16
    "func.return"(%224) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<2xbf16>, sym_name = "truncFPVectorConstant"}> ({
    %221 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00]> : vector<2xf32>}> : () -> vector<2xf32>
    %222 = "arith.truncf"(%221) : (vector<2xf32>) -> vector<2xbf16>
    "func.return"(%222) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPConstantRounding"}> ({
    %219 = "arith.constant"() <{value = 1.444000e+25 : f32}> : () -> f32
    %220 = "arith.truncf"(%219) : (f32) -> bf16
    "func.return"(%220) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddAdd"}> ({
  ^bb0(%arg93: index):
    %215 = "arith.constant"() <{value = 17 : index}> : () -> index
    %216 = "arith.constant"() <{value = 42 : index}> : () -> index
    %217 = "arith.addi"(%215, %arg93) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %218 = "arith.addi"(%216, %217) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%218) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddAddOvf1"}> ({
  ^bb0(%arg92: index):
    %211 = "arith.constant"() <{value = 17 : index}> : () -> index
    %212 = "arith.constant"() <{value = 42 : index}> : () -> index
    %213 = "arith.addi"(%211, %arg92) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %214 = "arith.addi"(%212, %213) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%214) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddAddOvf2"}> ({
  ^bb0(%arg91: index):
    %207 = "arith.constant"() <{value = 17 : index}> : () -> index
    %208 = "arith.constant"() <{value = 42 : index}> : () -> index
    %209 = "arith.addi"(%207, %arg91) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %210 = "arith.addi"(%208, %209) <{overflowFlags = #arith.overflow<nuw>}> : (index, index) -> index
    "func.return"(%210) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<10xi32>, tensor<?x?xi32>) -> (tensor<10xi32>, tensor<?x?xi32>), sym_name = "foldSubXX_tensor"}> ({
  ^bb0(%arg89: tensor<10xi32>, %arg90: tensor<?x?xi32>):
    %205 = "arith.subi"(%arg89, %arg89) <{overflowFlags = #arith.overflow<none>}> : (tensor<10xi32>, tensor<10xi32>) -> tensor<10xi32>
    %206 = "arith.subi"(%arg90, %arg90) <{overflowFlags = #arith.overflow<none>}> : (tensor<?x?xi32>, tensor<?x?xi32>) -> tensor<?x?xi32>
    "func.return"(%205, %206) : (tensor<10xi32>, tensor<?x?xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xi32>, vector<[4]xi32>) -> (vector<8xi32>, vector<[4]xi32>), sym_name = "foldSubXX_vector"}> ({
  ^bb0(%arg87: vector<8xi32>, %arg88: vector<[4]xi32>):
    %203 = "arith.subi"(%arg87, %arg87) <{overflowFlags = #arith.overflow<none>}> : (vector<8xi32>, vector<8xi32>) -> vector<8xi32>
    %204 = "arith.subi"(%arg88, %arg88) <{overflowFlags = #arith.overflow<none>}> : (vector<[4]xi32>, vector<[4]xi32>) -> vector<[4]xi32>
    "func.return"(%203, %204) : (vector<8xi32>, vector<[4]xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub0"}> ({
  ^bb0(%arg86: index):
    %199 = "arith.constant"() <{value = 17 : index}> : () -> index
    %200 = "arith.constant"() <{value = 42 : index}> : () -> index
    %201 = "arith.subi"(%199, %arg86) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %202 = "arith.addi"(%200, %201) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%202) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub0Ovf"}> ({
  ^bb0(%arg85: index):
    %195 = "arith.constant"() <{value = 17 : index}> : () -> index
    %196 = "arith.constant"() <{value = 42 : index}> : () -> index
    %197 = "arith.subi"(%195, %arg85) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %198 = "arith.addi"(%196, %197) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%198) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub1"}> ({
  ^bb0(%arg84: index):
    %191 = "arith.constant"() <{value = 17 : index}> : () -> index
    %192 = "arith.constant"() <{value = 42 : index}> : () -> index
    %193 = "arith.subi"(%arg84, %191) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %194 = "arith.addi"(%192, %193) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%194) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub1Ovf"}> ({
  ^bb0(%arg83: index):
    %187 = "arith.constant"() <{value = 17 : index}> : () -> index
    %188 = "arith.constant"() <{value = 42 : index}> : () -> index
    %189 = "arith.subi"(%arg83, %187) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %190 = "arith.addi"(%188, %189) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%190) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubAdd0"}> ({
  ^bb0(%arg82: index):
    %183 = "arith.constant"() <{value = 17 : index}> : () -> index
    %184 = "arith.constant"() <{value = 42 : index}> : () -> index
    %185 = "arith.addi"(%183, %arg82) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %186 = "arith.subi"(%184, %185) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%186) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubAdd0Ovf"}> ({
  ^bb0(%arg81: index):
    %179 = "arith.constant"() <{value = 17 : index}> : () -> index
    %180 = "arith.constant"() <{value = 42 : index}> : () -> index
    %181 = "arith.addi"(%179, %arg81) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %182 = "arith.subi"(%180, %181) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%182) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubAdd1"}> ({
  ^bb0(%arg80: index):
    %175 = "arith.constant"() <{value = 17 : index}> : () -> index
    %176 = "arith.constant"() <{value = 42 : index}> : () -> index
    %177 = "arith.addi"(%175, %arg80) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %178 = "arith.subi"(%177, %176) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%178) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subSub0"}> ({
  ^bb0(%arg78: index, %arg79: index):
    %173 = "arith.subi"(%arg78, %arg79) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %174 = "arith.subi"(%173, %arg78) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%174) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subSub0Ovf"}> ({
  ^bb0(%arg76: index, %arg77: index):
    %171 = "arith.subi"(%arg76, %arg77) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %172 = "arith.subi"(%171, %arg76) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%172) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub0"}> ({
  ^bb0(%arg75: index):
    %167 = "arith.constant"() <{value = 17 : index}> : () -> index
    %168 = "arith.constant"() <{value = 42 : index}> : () -> index
    %169 = "arith.subi"(%167, %arg75) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %170 = "arith.subi"(%168, %169) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%170) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub0Ovf"}> ({
  ^bb0(%arg74: index):
    %163 = "arith.constant"() <{value = 17 : index}> : () -> index
    %164 = "arith.constant"() <{value = 42 : index}> : () -> index
    %165 = "arith.subi"(%163, %arg74) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %166 = "arith.subi"(%164, %165) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%166) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub1"}> ({
  ^bb0(%arg73: index):
    %159 = "arith.constant"() <{value = 17 : index}> : () -> index
    %160 = "arith.constant"() <{value = 42 : index}> : () -> index
    %161 = "arith.subi"(%159, %arg73) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %162 = "arith.subi"(%161, %160) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%162) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub1Ovf"}> ({
  ^bb0(%arg72: index):
    %155 = "arith.constant"() <{value = 17 : index}> : () -> index
    %156 = "arith.constant"() <{value = 42 : index}> : () -> index
    %157 = "arith.subi"(%155, %arg72) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %158 = "arith.subi"(%157, %156) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%158) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub2"}> ({
  ^bb0(%arg71: index):
    %151 = "arith.constant"() <{value = 17 : index}> : () -> index
    %152 = "arith.constant"() <{value = 42 : index}> : () -> index
    %153 = "arith.subi"(%arg71, %151) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %154 = "arith.subi"(%152, %153) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%154) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub2Ovf"}> ({
  ^bb0(%arg70: index):
    %147 = "arith.constant"() <{value = 17 : index}> : () -> index
    %148 = "arith.constant"() <{value = 42 : index}> : () -> index
    %149 = "arith.subi"(%arg70, %147) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %150 = "arith.subi"(%148, %149) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%150) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub3"}> ({
  ^bb0(%arg69: index):
    %143 = "arith.constant"() <{value = 17 : index}> : () -> index
    %144 = "arith.constant"() <{value = 42 : index}> : () -> index
    %145 = "arith.subi"(%arg69, %143) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %146 = "arith.subi"(%145, %144) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%146) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub3Ovf"}> ({
  ^bb0(%arg68: index):
    %139 = "arith.constant"() <{value = 17 : index}> : () -> index
    %140 = "arith.constant"() <{value = 42 : index}> : () -> index
    %141 = "arith.subi"(%arg68, %139) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %142 = "arith.subi"(%141, %140) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%142) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subAdd1"}> ({
  ^bb0(%arg66: index, %arg67: index):
    %137 = "arith.addi"(%arg66, %arg67) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %138 = "arith.subi"(%137, %arg67) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%138) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subAdd2"}> ({
  ^bb0(%arg64: index, %arg65: index):
    %135 = "arith.addi"(%arg64, %arg65) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %136 = "arith.subi"(%135, %arg64) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%136) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "doubleAddSub1"}> ({
  ^bb0(%arg62: index, %arg63: index):
    %133 = "arith.subi"(%arg62, %arg63) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %134 = "arith.addi"(%133, %arg63) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%134) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "doubleAddSub2"}> ({
  ^bb0(%arg60: index, %arg61: index):
    %131 = "arith.subi"(%arg60, %arg61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %132 = "arith.addi"(%arg61, %131) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%132) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "nested_muli"}> ({
    %126 = "test.constant"() <{value = 2147483647 : i64}> : () -> i32
    %127 = "test.constant"() <{value = -2147483648 : i64}> : () -> i32
    %128 = "test.constant"() <{value = 2147483648 : i64}> : () -> i32
    %129 = "arith.muli"(%126, %127) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %130 = "arith.muli"(%129, %128) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%130) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleMulIMulIIndex"}> ({
  ^bb0(%arg59: index):
    %122 = "arith.constant"() <{value = 3 : index}> : () -> index
    %123 = "arith.constant"() <{value = 5 : index}> : () -> index
    %124 = "arith.muli"(%arg59, %122) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %125 = "arith.muli"(%124, %123) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%125) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "tripleMulIMulII32"}> ({
  ^bb0(%arg58: i32):
    %118 = "arith.constant"() <{value = -3 : i32}> : () -> i32
    %119 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %120 = "arith.muli"(%arg58, %118) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %121 = "arith.muli"(%120, %119) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%121) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i256) -> i256, sym_name = "tripleMulLargeInt"}> ({
  ^bb0(%arg57: i256):
    %114 = "arith.constant"() <{value = 3618502788666131213697322783095070105623107215331596699973092056135872020481 : i256}> : () -> i256
    %115 = "arith.constant"() <{value = 1 : i256}> : () -> i256
    %116 = "arith.addi"(%arg57, %114) <{overflowFlags = #arith.overflow<none>}> : (i256, i256) -> i256
    %117 = "arith.addi"(%116, %115) <{overflowFlags = #arith.overflow<none>}> : (i256, i256) -> i256
    "func.return"(%117) : (i256) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "addiMuliToSubiRhsI32"}> ({
  ^bb0(%arg55: i32, %arg56: i32):
    %111 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %112 = "arith.muli"(%arg56, %111) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %113 = "arith.addi"(%arg55, %112) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%113) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "addiMuliToSubiRhsIndex"}> ({
  ^bb0(%arg53: index, %arg54: index):
    %108 = "arith.constant"() <{value = -1 : index}> : () -> index
    %109 = "arith.muli"(%arg54, %108) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %110 = "arith.addi"(%arg53, %109) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%110) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> vector<3xi64>, sym_name = "addiMuliToSubiRhsVector"}> ({
  ^bb0(%arg51: vector<3xi64>, %arg52: vector<3xi64>):
    %105 = "arith.constant"() <{value = dense<-1> : vector<3xi64>}> : () -> vector<3xi64>
    %106 = "arith.muli"(%arg52, %105) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    %107 = "arith.addi"(%arg51, %106) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "func.return"(%107) : (vector<3xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "addiMuliToSubiLhsI32"}> ({
  ^bb0(%arg49: i32, %arg50: i32):
    %102 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %103 = "arith.muli"(%arg50, %102) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %104 = "arith.addi"(%103, %arg49) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%104) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "addiMuliToSubiLhsIndex"}> ({
  ^bb0(%arg47: index, %arg48: index):
    %99 = "arith.constant"() <{value = -1 : index}> : () -> index
    %100 = "arith.muli"(%arg48, %99) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %101 = "arith.addi"(%100, %arg47) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%101) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> vector<3xi64>, sym_name = "addiMuliToSubiLhsVector"}> ({
  ^bb0(%arg45: vector<3xi64>, %arg46: vector<3xi64>):
    %96 = "arith.constant"() <{value = dense<-1> : vector<3xi64>}> : () -> vector<3xi64>
    %97 = "arith.muli"(%arg46, %96) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    %98 = "arith.addi"(%97, %arg45) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "func.return"(%98) : (vector<3xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "adduiExtendedZeroRhs"}> ({
  ^bb0(%arg44: i32):
    %94 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %95:2 = "arith.addui_extended"(%arg44, %94) : (i32, i32) -> (i32, i1)
    "func.return"(%95#0, %95#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi1>), sym_name = "adduiExtendedZeroRhsSplat"}> ({
  ^bb0(%arg43: vector<4xi32>):
    %92 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    %93:2 = "arith.addui_extended"(%arg43, %92) : (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi1>)
    "func.return"(%93#0, %93#1) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "adduiExtendedZeroLhs"}> ({
  ^bb0(%arg42: i32):
    %90 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %91:2 = "arith.addui_extended"(%90, %arg42) : (i32, i32) -> (i32, i1)
    "func.return"(%91#0, %91#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "adduiExtendedUnusedOverflowScalar"}> ({
  ^bb0(%arg40: i32, %arg41: i32):
    %89:2 = "arith.addui_extended"(%arg40, %arg41) : (i32, i32) -> (i32, i1)
    "func.return"(%89#0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, vector<3xi32>) -> vector<3xi32>, sym_name = "adduiExtendedUnusedOverflowVector"}> ({
  ^bb0(%arg38: vector<3xi32>, %arg39: vector<3xi32>):
    %88:2 = "arith.addui_extended"(%arg38, %arg39) : (vector<3xi32>, vector<3xi32>) -> (vector<3xi32>, vector<3xi1>)
    "func.return"(%88#0) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedConstants"}> ({
    %85 = "arith.constant"() <{value = 13 : i32}> : () -> i32
    %86 = "arith.constant"() <{value = 37 : i32}> : () -> i32
    %87:2 = "arith.addui_extended"(%85, %86) : (i32, i32) -> (i32, i1)
    "func.return"(%87#0, %87#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedConstantsOverflow1"}> ({
    %82 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %83 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %84:2 = "arith.addui_extended"(%82, %83) : (i32, i32) -> (i32, i1)
    "func.return"(%84#0, %84#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedConstantsOverflow2"}> ({
    %80 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %81:2 = "arith.addui_extended"(%80, %80) : (i32, i32) -> (i32, i1)
    "func.return"(%81#0, %81#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<4xi32>, vector<4xi1>), sym_name = "adduiExtendedConstantsOverflowVector"}> ({
    %77 = "arith.constant"() <{value = dense<[1, 3, 3, 7]> : vector<4xi32>}> : () -> vector<4xi32>
    %78 = "arith.constant"() <{value = dense<[0, 3, -1, 7]> : vector<4xi32>}> : () -> vector<4xi32>
    %79:2 = "arith.addui_extended"(%77, %78) : (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi1>)
    "func.return"(%79#0, %79#1) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<4xi32>, vector<4xi1>), sym_name = "adduiExtendedConstantsSplatVector"}> ({
    %74 = "arith.constant"() <{value = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
    %75 = "arith.constant"() <{value = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
    %76:2 = "arith.addui_extended"(%74, %75) : (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi1>)
    "func.return"(%76#0, %76#1) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "mulsiExtendedZeroRhs"}> ({
  ^bb0(%arg37: i32):
    %72 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %73:2 = "arith.mulsi_extended"(%arg37, %72) : (i32, i32) -> (i32, i32)
    "func.return"(%73#0, %73#1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>) -> (vector<3xi32>, vector<3xi32>), sym_name = "mulsiExtendedZeroRhsSplat"}> ({
  ^bb0(%arg36: vector<3xi32>):
    %70 = "arith.constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %71:2 = "arith.mulsi_extended"(%arg36, %70) : (vector<3xi32>, vector<3xi32>) -> (vector<3xi32>, vector<3xi32>)
    "func.return"(%71#0, %71#1) : (vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "mulsiExtendedZeroLhs"}> ({
  ^bb0(%arg35: i32):
    %68 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %69:2 = "arith.mulsi_extended"(%68, %arg35) : (i32, i32) -> (i32, i32)
    "func.return"(%69#0, %69#1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "mulsiExtendedOneRhs"}> ({
  ^bb0(%arg34: i32):
    %66 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %67:2 = "arith.mulsi_extended"(%arg34, %66) : (i32, i32) -> (i32, i32)
    "func.return"(%67#0, %67#1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>) -> (vector<3xi32>, vector<3xi32>), sym_name = "mulsiExtendedOneRhsSplat"}> ({
  ^bb0(%arg33: vector<3xi32>):
    %64 = "arith.constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
    %65:2 = "arith.mulsi_extended"(%arg33, %64) : (vector<3xi32>, vector<3xi32>) -> (vector<3xi32>, vector<3xi32>)
    "func.return"(%65#0, %65#1) : (vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (i1, i1), sym_name = "mulsiExtendedOneRhsI1"}> ({
  ^bb0(%arg32: i1):
    %62 = "arith.constant"() <{value = true}> : () -> i1
    %63:2 = "arith.mulsi_extended"(%arg32, %62) : (i1, i1) -> (i1, i1)
    "func.return"(%63#0, %63#1) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi1>) -> (vector<3xi1>, vector<3xi1>), sym_name = "mulsiExtendedOneRhsSplatI1"}> ({
  ^bb0(%arg31: vector<3xi1>):
    %60 = "arith.constant"() <{value = dense<true> : vector<3xi1>}> : () -> vector<3xi1>
    %61:2 = "arith.mulsi_extended"(%arg31, %60) : (vector<3xi1>, vector<3xi1>) -> (vector<3xi1>, vector<3xi1>)
    "func.return"(%61#0, %61#1) : (vector<3xi1>, vector<3xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "mulsiExtendedUnusedHigh"}> ({
  ^bb0(%arg30: i32):
    %59:2 = "arith.mulsi_extended"(%arg30, %arg30) : (i32, i32) -> (i32, i32)
    "func.return"(%59#0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i8, i8), sym_name = "mulsiExtendedScalarConstants"}> ({
    %56 = "arith.constant"() <{value = 57 : i8}> : () -> i8
    %57 = "arith.constant"() <{value = -13 : i8}> : () -> i8
    %58:2 = "arith.mulsi_extended"(%56, %57) : (i8, i8) -> (i8, i8)
    "func.return"(%58#0, %58#1) : (i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<3xi8>, vector<3xi8>), sym_name = "mulsiExtendedVectorConstants"}> ({
    %53 = "arith.constant"() <{value = dense<[5, 37, -17]> : vector<3xi8>}> : () -> vector<3xi8>
    %54 = "arith.constant"() <{value = dense<[13, 99, -2]> : vector<3xi8>}> : () -> vector<3xi8>
    %55:2 = "arith.mulsi_extended"(%53, %54) : (vector<3xi8>, vector<3xi8>) -> (vector<3xi8>, vector<3xi8>)
    "func.return"(%55#0, %55#1) : (vector<3xi8>, vector<3xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "muluiExtendedZeroRhs"}> ({
  ^bb0(%arg29: i32):
    %51 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %52:2 = "arith.mului_extended"(%arg29, %51) : (i32, i32) -> (i32, i32)
    "func.return"(%52#0, %52#1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>) -> (vector<3xi32>, vector<3xi32>), sym_name = "muluiExtendedZeroRhsSplat"}> ({
  ^bb0(%arg28: vector<3xi32>):
    %49 = "arith.constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %50:2 = "arith.mului_extended"(%arg28, %49) : (vector<3xi32>, vector<3xi32>) -> (vector<3xi32>, vector<3xi32>)
    "func.return"(%50#0, %50#1) : (vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "muluiExtendedZeroLhs"}> ({
  ^bb0(%arg27: i32):
    %47 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %48:2 = "arith.mului_extended"(%47, %arg27) : (i32, i32) -> (i32, i32)
    "func.return"(%48#0, %48#1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "muluiExtendedOneRhs"}> ({
  ^bb0(%arg26: i32):
    %45 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %46:2 = "arith.mului_extended"(%arg26, %45) : (i32, i32) -> (i32, i32)
    "func.return"(%46#0, %46#1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>) -> (vector<3xi32>, vector<3xi32>), sym_name = "muluiExtendedOneRhsSplat"}> ({
  ^bb0(%arg25: vector<3xi32>):
    %43 = "arith.constant"() <{value = dense<1> : vector<3xi32>}> : () -> vector<3xi32>
    %44:2 = "arith.mului_extended"(%arg25, %43) : (vector<3xi32>, vector<3xi32>) -> (vector<3xi32>, vector<3xi32>)
    "func.return"(%44#0, %44#1) : (vector<3xi32>, vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "muluiExtendedOneLhs"}> ({
  ^bb0(%arg24: i32):
    %41 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %42:2 = "arith.mului_extended"(%41, %arg24) : (i32, i32) -> (i32, i32)
    "func.return"(%42#0, %42#1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "muluiExtendedUnusedHigh"}> ({
  ^bb0(%arg23: i32):
    %40:2 = "arith.mului_extended"(%arg23, %arg23) : (i32, i32) -> (i32, i32)
    "func.return"(%40#0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "muluiExtendedUnusedLow"}> ({
  ^bb0(%arg22: i32):
    %39:2 = "arith.mului_extended"(%arg22, %arg22) : (i32, i32) -> (i32, i32)
    "func.return"(%39#1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i8, i8), sym_name = "muluiExtendedScalarConstants"}> ({
    %36 = "arith.constant"() <{value = 57 : i8}> : () -> i8
    %37 = "arith.constant"() <{value = -123 : i8}> : () -> i8
    %38:2 = "arith.mului_extended"(%36, %37) : (i8, i8) -> (i8, i8)
    "func.return"(%38#0, %38#1) : (i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<3xi8>, vector<3xi8>), sym_name = "muluiExtendedVectorConstants"}> ({
    %33 = "arith.constant"() <{value = dense<[5, 37, -1]> : vector<3xi8>}> : () -> vector<3xi8>
    %34 = "arith.constant"() <{value = dense<[13, 99, -1]> : vector<3xi8>}> : () -> vector<3xi8>
    %35:2 = "arith.mului_extended"(%33, %34) : (vector<3xi8>, vector<3xi8>) -> (vector<3xi8>, vector<3xi8>)
    "func.return"(%35#0, %35#1) : (vector<3xi8>, vector<3xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpEQ"}> ({
  ^bb0(%arg20: i8, %arg21: i8):
    %30 = "arith.constant"() <{value = true}> : () -> i1
    %31 = "arith.cmpi"(%arg20, %arg21) <{predicate = 0 : i64}> : (i8, i8) -> i1
    %32 = "arith.xori"(%31, %30) : (i1, i1) -> i1
    "func.return"(%32) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpEQ2"}> ({
  ^bb0(%arg18: i8, %arg19: i8):
    %27 = "arith.constant"() <{value = true}> : () -> i1
    %28 = "arith.cmpi"(%arg18, %arg19) <{predicate = 0 : i64}> : (i8, i8) -> i1
    %29 = "arith.xori"(%27, %28) : (i1, i1) -> i1
    "func.return"(%29) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpNE"}> ({
  ^bb0(%arg16: i8, %arg17: i8):
    %24 = "arith.constant"() <{value = true}> : () -> i1
    %25 = "arith.cmpi"(%arg16, %arg17) <{predicate = 1 : i64}> : (i8, i8) -> i1
    %26 = "arith.xori"(%25, %24) : (i1, i1) -> i1
    "func.return"(%26) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpSLT"}> ({
  ^bb0(%arg14: i8, %arg15: i8):
    %21 = "arith.constant"() <{value = true}> : () -> i1
    %22 = "arith.cmpi"(%arg14, %arg15) <{predicate = 2 : i64}> : (i8, i8) -> i1
    %23 = "arith.xori"(%22, %21) : (i1, i1) -> i1
    "func.return"(%23) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpSLE"}> ({
  ^bb0(%arg12: i8, %arg13: i8):
    %18 = "arith.constant"() <{value = true}> : () -> i1
    %19 = "arith.cmpi"(%arg12, %arg13) <{predicate = 3 : i64}> : (i8, i8) -> i1
    %20 = "arith.xori"(%19, %18) : (i1, i1) -> i1
    "func.return"(%20) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpSGT"}> ({
  ^bb0(%arg10: i8, %arg11: i8):
    %15 = "arith.constant"() <{value = true}> : () -> i1
    %16 = "arith.cmpi"(%arg10, %arg11) <{predicate = 4 : i64}> : (i8, i8) -> i1
    %17 = "arith.xori"(%16, %15) : (i1, i1) -> i1
    "func.return"(%17) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpSGE"}> ({
  ^bb0(%arg8: i8, %arg9: i8):
    %12 = "arith.constant"() <{value = true}> : () -> i1
    %13 = "arith.cmpi"(%arg8, %arg9) <{predicate = 5 : i64}> : (i8, i8) -> i1
    %14 = "arith.xori"(%13, %12) : (i1, i1) -> i1
    "func.return"(%14) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpULT"}> ({
  ^bb0(%arg6: i8, %arg7: i8):
    %9 = "arith.constant"() <{value = true}> : () -> i1
    %10 = "arith.cmpi"(%arg6, %arg7) <{predicate = 6 : i64}> : (i8, i8) -> i1
    %11 = "arith.xori"(%10, %9) : (i1, i1) -> i1
    "func.return"(%11) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpULE"}> ({
  ^bb0(%arg4: i8, %arg5: i8):
    %6 = "arith.constant"() <{value = true}> : () -> i1
    %7 = "arith.cmpi"(%arg4, %arg5) <{predicate = 7 : i64}> : (i8, i8) -> i1
    %8 = "arith.xori"(%7, %6) : (i1, i1) -> i1
    "func.return"(%8) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpUGT"}> ({
  ^bb0(%arg2: i8, %arg3: i8):
    %3 = "arith.constant"() <{value = true}> : () -> i1
    %4 = "arith.cmpi"(%arg2, %arg3) <{predicate = 8 : i64}> : (i8, i8) -> i1
    %5 = "arith.xori"(%4, %3) : (i1, i1) -> i1
    "func.return"(%5) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i1, sym_name = "notCmpUGE"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "arith.cmpi"(%arg0, %arg1) <{predicate = 9 : i64}> : (i8, i8) -> i1
    %2 = "arith.xori"(%1, %0) : (i1, i1) -> i1
    "func.return"(%2) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i1, sym_name = "xorxor"}> ({
  ^bb0(%arg4: i1):
    %6 = "arith.constant"() <{value = true}> : () -> i1
    %7 = "arith.xori"(%arg4, %6) : (i1, i1) -> i1
    %8 = "arith.xori"(%7, %6) : (i1, i1) -> i1
    "func.return"(%8) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "xorOfExtSI"}> ({
  ^bb0(%arg2: i8, %arg3: i8):
    %3 = "arith.extsi"(%arg2) : (i8) -> i64
    %4 = "arith.extsi"(%arg3) : (i8) -> i64
    %5 = "arith.xori"(%3, %4) : (i64, i64) -> i64
    "func.return"(%5) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "xorOfExtUI"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %0 = "arith.extui"(%arg0) : (i8) -> i64
    %1 = "arith.extui"(%arg1) : (i8) -> i64
    %2 = "arith.xori"(%0, %1) : (i64, i64) -> i64
    "func.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "bitcastSameType"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.bitcast"(%arg0) : (f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "bitcastConstantFPtoI"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.bitcast"(%0) : (f32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "bitcastConstantItoFP"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.bitcast"(%0) : (i32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f16, sym_name = "bitcastConstantFPtoFP"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : bf16}> : () -> bf16
    %1 = "arith.bitcast"(%0) : (bf16) -> f16
    "func.return"(%1) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<3xf32>, sym_name = "bitcastConstantVecFPtoI"}> ({
    %0 = "arith.constant"() <{value = dense<0> : vector<3xi32>}> : () -> vector<3xi32>
    %1 = "arith.bitcast"(%0) : (vector<3xi32>) -> vector<3xf32>
    "func.return"(%1) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "bitcastConstantVecItoFP"}> ({
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<3xf32>}> : () -> vector<3xf32>
    %1 = "arith.bitcast"(%0) : (vector<3xf32>) -> vector<3xi32>
    "func.return"(%1) : (vector<3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<3xbf16>, sym_name = "bitcastConstantVecFPtoFP"}> ({
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<3xf16>}> : () -> vector<3xf16>
    %1 = "arith.bitcast"(%0) : (vector<3xf16>) -> vector<3xbf16>
    "func.return"(%1) : (vector<3xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "bitcastBackAndForth"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.bitcast"(%arg0) : (i32) -> f32
    %1 = "arith.bitcast"(%0) : (f32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i16) -> i16, sym_name = "bitcastOfBitcast"}> ({
  ^bb0(%arg0: i16):
    %0 = "arith.bitcast"(%arg0) : (i16) -> f16
    %1 = "arith.bitcast"(%0) : (f16) -> bf16
    %2 = "arith.bitcast"(%1) : (bf16) -> i16
    "func.return"(%2) : (i16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "bitcastPoisonItoFP"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %1 = "arith.bitcast"(%0) : (i32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "bitcastPoisonFPtoI"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %1 = "arith.bitcast"(%0) : (f32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i16) -> f16, sym_name = "bitcastChain"}> ({
  ^bb0(%arg0: i16):
    %0 = "arith.bitcast"(%arg0) : (i16) -> bf16
    %1 = "arith.bitcast"(%0) : (bf16) -> f16
    "func.return"(%1) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_maxsi"}> ({
  ^bb0(%arg1: i8):
    %7 = "arith.constant"() <{value = 127 : i8}> : () -> i8
    %8 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %9 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %10 = "arith.maxsi"(%arg1, %arg1) : (i8, i8) -> i8
    %11 = "arith.maxsi"(%arg1, %7) : (i8, i8) -> i8
    %12 = "arith.maxsi"(%arg1, %8) : (i8, i8) -> i8
    %13 = "arith.maxsi"(%arg1, %9) : (i8, i8) -> i8
    "func.return"(%10, %11, %12, %13) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_maxsi2"}> ({
  ^bb0(%arg0: i8):
    %0 = "arith.constant"() <{value = 127 : i8}> : () -> i8
    %1 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %2 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "arith.maxsi"(%arg0, %arg0) : (i8, i8) -> i8
    %4 = "arith.maxsi"(%0, %arg0) : (i8, i8) -> i8
    %5 = "arith.maxsi"(%1, %arg0) : (i8, i8) -> i8
    %6 = "arith.maxsi"(%2, %arg0) : (i8, i8) -> i8
    "func.return"(%3, %4, %5, %6) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_maxui"}> ({
  ^bb0(%arg1: i8):
    %7 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %8 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %9 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %10 = "arith.maxui"(%arg1, %arg1) : (i8, i8) -> i8
    %11 = "arith.maxui"(%arg1, %7) : (i8, i8) -> i8
    %12 = "arith.maxui"(%arg1, %8) : (i8, i8) -> i8
    %13 = "arith.maxui"(%arg1, %9) : (i8, i8) -> i8
    "func.return"(%10, %11, %12, %13) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_maxui2"}> ({
  ^bb0(%arg0: i8):
    %0 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %1 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %2 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "arith.maxui"(%arg0, %arg0) : (i8, i8) -> i8
    %4 = "arith.maxui"(%0, %arg0) : (i8, i8) -> i8
    %5 = "arith.maxui"(%1, %arg0) : (i8, i8) -> i8
    %6 = "arith.maxui"(%2, %arg0) : (i8, i8) -> i8
    "func.return"(%3, %4, %5, %6) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_minsi"}> ({
  ^bb0(%arg1: i8):
    %7 = "arith.constant"() <{value = 127 : i8}> : () -> i8
    %8 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %9 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %10 = "arith.minsi"(%arg1, %arg1) : (i8, i8) -> i8
    %11 = "arith.minsi"(%arg1, %7) : (i8, i8) -> i8
    %12 = "arith.minsi"(%arg1, %8) : (i8, i8) -> i8
    %13 = "arith.minsi"(%arg1, %9) : (i8, i8) -> i8
    "func.return"(%10, %11, %12, %13) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_minsi2"}> ({
  ^bb0(%arg0: i8):
    %0 = "arith.constant"() <{value = 127 : i8}> : () -> i8
    %1 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %2 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "arith.minsi"(%arg0, %arg0) : (i8, i8) -> i8
    %4 = "arith.minsi"(%0, %arg0) : (i8, i8) -> i8
    %5 = "arith.minsi"(%1, %arg0) : (i8, i8) -> i8
    %6 = "arith.minsi"(%2, %arg0) : (i8, i8) -> i8
    "func.return"(%3, %4, %5, %6) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_minui"}> ({
  ^bb0(%arg1: i8):
    %7 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %8 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %9 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %10 = "arith.minui"(%arg1, %arg1) : (i8, i8) -> i8
    %11 = "arith.minui"(%arg1, %7) : (i8, i8) -> i8
    %12 = "arith.minui"(%arg1, %8) : (i8, i8) -> i8
    %13 = "arith.minui"(%arg1, %9) : (i8, i8) -> i8
    "func.return"(%10, %11, %12, %13) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> (i8, i8, i8, i8), sym_name = "test_minui2"}> ({
  ^bb0(%arg0: i8):
    %0 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %1 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %2 = "arith.constant"() <{value = 42 : i8}> : () -> i8
    %3 = "arith.minui"(%arg0, %arg0) : (i8, i8) -> i8
    %4 = "arith.minui"(%0, %arg0) : (i8, i8) -> i8
    %5 = "arith.minui"(%1, %arg0) : (i8, i8) -> i8
    %6 = "arith.minui"(%2, %arg0) : (i8, i8) -> i8
    "func.return"(%3, %4, %5, %6) : (i8, i8, i8, i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32), sym_name = "test_minimumf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %2 = "arith.minimumf"(%0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %3 = "arith.minimumf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %4 = "arith.minimumf"(%1, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2, %3, %4) : (f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32), sym_name = "test_maximumf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %2 = "arith.maximumf"(%0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %3 = "arith.maximumf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %4 = "arith.maximumf"(%1, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2, %3, %4) : (f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32), sym_name = "test_minnumf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0x7F800000 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %3 = "arith.minnumf"(%0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %4 = "arith.minnumf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %5 = "arith.minnumf"(%1, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "arith.minnumf"(%2, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3, %4, %5, %6) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32), sym_name = "test_maxnumf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0xFF800000 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %3 = "arith.maxnumf"(%0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %4 = "arith.maxnumf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %5 = "arith.maxnumf"(%1, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "arith.maxnumf"(%2, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3, %4, %5, %6) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32), sym_name = "test_addf"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "arith.addf"(%0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %4 = "arith.addf"(%arg0, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %5 = "arith.addf"(%1, %arg0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %6 = "arith.addf"(%2, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3, %4, %5, %6) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f16) -> (f16, f16, f16), sym_name = "test_subf"}> ({
  ^bb0(%arg0: f16):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %1 = "arith.constant"() <{value = -0.000000e+00 : f16}> : () -> f16
    %2 = "arith.constant"() <{value = 1.000000e+00 : f16}> : () -> f16
    %3 = "arith.subf"(%arg0, %0) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    %4 = "arith.subf"(%arg0, %1) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    %5 = "arith.subf"(%0, %2) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    "func.return"(%3, %4, %5) : (f16, f16, f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32), sym_name = "test_mulf"}> ({
  ^bb0(%arg3: f32):
    %7 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %9 = "arith.mulf"(%8, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %10 = "arith.mulf"(%arg3, %7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %11 = "arith.mulf"(%7, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %12 = "arith.mulf"(%8, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%9, %10, %11, %12) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "test_mulf1"}> ({
  ^bb0(%arg1: f32, %arg2: f32):
    %4 = "arith.negf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %5 = "arith.negf"(%arg2) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %6 = "arith.mulf"(%4, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (f32, f32), sym_name = "test_mulf2"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    %2 = "arith.mulf"(%0, %arg0) <{fastmath = #arith.fastmath<nnan,nsz>}> : (f32, f32) -> f32
    %3 = "arith.mulf"(%1, %arg0) <{fastmath = #arith.fastmath<nnan,nsz>}> : (f32, f32) -> f32
    "func.return"(%2, %3) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (f64, f64), sym_name = "test_divf"}> ({
  ^bb0(%arg2: f64):
    %3 = "arith.constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    %4 = "arith.constant"() <{value = 2.000000e+00 : f64}> : () -> f64
    %5 = "arith.divf"(%arg2, %3) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    %6 = "arith.divf"(%3, %4) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"(%5, %6) : (f64, f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "test_divf1"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.negf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "arith.negf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %2 = "arith.divf"(%0, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "fold_divui_of_muli_0"}> ({
  ^bb0(%arg10: index, %arg11: index):
    %10 = "arith.muli"(%arg10, %arg11) <{overflowFlags = #arith.overflow<nuw>}> : (index, index) -> index
    %11 = "arith.divui"(%10, %arg10) : (index, index) -> index
    "func.return"(%11) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "fold_divui_of_muli_1"}> ({
  ^bb0(%arg8: index, %arg9: index):
    %8 = "arith.muli"(%arg8, %arg9) <{overflowFlags = #arith.overflow<nuw>}> : (index, index) -> index
    %9 = "arith.divui"(%8, %arg9) : (index, index) -> index
    "func.return"(%9) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "fold_divsi_of_muli_0"}> ({
  ^bb0(%arg6: index, %arg7: index):
    %6 = "arith.muli"(%arg6, %arg7) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %7 = "arith.divsi"(%6, %arg6) : (index, index) -> index
    "func.return"(%7) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "fold_divsi_of_muli_1"}> ({
  ^bb0(%arg4: index, %arg5: index):
    %4 = "arith.muli"(%arg4, %arg5) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %5 = "arith.divsi"(%4, %arg5) : (index, index) -> index
    "func.return"(%5) : (index) -> ()
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
    %0 = "arith.constant"() <{value = 0x7FFFFFFF : f32}> : () -> f32
    %1 = "arith.cmpf"(%0, %arg0) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %2 = "arith.cmpf"(%arg0, %0) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f32, f32) -> i1
    %3 = "arith.cmpf"(%0, %arg0) <{fastmath = #arith.fastmath<none>, predicate = 9 : i64}> : (f32, f32) -> i1
    %4 = "arith.cmpf"(%arg0, %0) <{fastmath = #arith.fastmath<none>, predicate = 9 : i64}> : (f32, f32) -> i1
    "func.return"(%1, %2, %3, %4) : (i1, i1, i1, i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "constant_FPtoUI"}> ({
    %5 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %6 = "arith.fptoui"(%5) : (f32) -> i32
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "constant_FPtoUI_splat"}> ({
    %2 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %3 = "vector.broadcast"(%2) : (f32) -> vector<4xf32>
    %4 = "arith.fptoui"(%3) : (vector<4xf32>) -> vector<4xi32>
    "func.return"(%4) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "constant_FPtoUI_vector"}> ({
    %0 = "arith.constant"() <{value = dense<[1.000000e+00, 3.000000e+00, 5.000000e+00, 7.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "arith.fptoui"(%0) : (vector<4xf32>) -> vector<4xi32>
    "func.return"(%1) : (vector<4xi32>) -> ()
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
    %5 = "arith.constant"() <{value = -2.000000e+00 : f32}> : () -> f32
    %6 = "arith.fptosi"(%5) : (f32) -> i32
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "constant_FPtoSI_splat"}> ({
    %2 = "arith.constant"() <{value = -2.000000e+00 : f32}> : () -> f32
    %3 = "vector.broadcast"(%2) : (f32) -> vector<4xf32>
    %4 = "arith.fptosi"(%3) : (vector<4xf32>) -> vector<4xi32>
    "func.return"(%4) : (vector<4xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "constant_FPtoSI_vector"}> ({
    %0 = "arith.constant"() <{value = dense<[-1.000000e+00, -3.000000e+00, -5.000000e+00, -7.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "arith.fptosi"(%0) : (vector<4xf32>) -> vector<4xi32>
    "func.return"(%1) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i8, sym_name = "invalid_constant_FPtoSI"}> ({
    %7 = "arith.constant"() <{value = 2.000000e+10 : f32}> : () -> f32
    %8 = "arith.fptosi"(%7) : (f32) -> i8
    "func.return"(%8) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "constant_SItoFP"}> ({
    %5 = "arith.constant"() <{value = -2 : i32}> : () -> i32
    %6 = "arith.sitofp"(%5) : (i32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "constant_SItoFP_splat"}> ({
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "vector.broadcast"(%2) : (i32) -> vector<4xi32>
    %4 = "arith.sitofp"(%3) : (vector<4xi32>) -> vector<4xf32>
    "func.return"(%4) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "constant_SItoFP_vector"}> ({
    %0 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi32>}> : () -> vector<4xi32>
    %1 = "arith.sitofp"(%0) : (vector<4xi32>) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "constant_UItoFP"}> ({
    %5 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %6 = "arith.uitofp"(%5) : (i32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "constant_UItoFP_splat"}> ({
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "vector.broadcast"(%2) : (i32) -> vector<4xi32>
    %4 = "arith.uitofp"(%3) : (vector<4xi32>) -> vector<4xf32>
    "func.return"(%4) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "constant_UItoFP_vector"}> ({
    %0 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi32>}> : () -> vector<4xi32>
    %1 = "arith.uitofp"(%0) : (vector<4xi32>) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test1"}> ({
  ^bb0(%arg6: i32):
    %18 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %19 = "arith.uitofp"(%arg6) : (i32) -> f64
    %20 = "arith.cmpf"(%19, %18) <{fastmath = #arith.fastmath<none>, predicate = 5 : i64}> : (f64, f64) -> i1
    "func.return"(%20) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test2"}> ({
  ^bb0(%arg5: i32):
    %15 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %16 = "arith.uitofp"(%arg5) : (i32) -> f64
    %17 = "arith.cmpf"(%16, %15) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f64, f64) -> i1
    "func.return"(%17) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test3"}> ({
  ^bb0(%arg4: i32):
    %12 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %13 = "arith.uitofp"(%arg4) : (i32) -> f64
    %14 = "arith.cmpf"(%13, %12) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (f64, f64) -> i1
    "func.return"(%14) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test4"}> ({
  ^bb0(%arg3: i32):
    %9 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    %10 = "arith.uitofp"(%arg3) : (i32) -> f64
    %11 = "arith.cmpf"(%10, %9) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f64, f64) -> i1
    "func.return"(%11) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test5"}> ({
  ^bb0(%arg2: i32):
    %6 = "arith.constant"() <{value = -4.400000e+00 : f64}> : () -> f64
    %7 = "arith.uitofp"(%arg2) : (i32) -> f64
    %8 = "arith.cmpf"(%7, %6) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f64, f64) -> i1
    "func.return"(%8) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test6"}> ({
  ^bb0(%arg1: i32):
    %3 = "arith.constant"() <{value = -4.400000e+00 : f64}> : () -> f64
    %4 = "arith.uitofp"(%arg1) : (i32) -> f64
    %5 = "arith.cmpf"(%4, %3) <{fastmath = #arith.fastmath<none>, predicate = 4 : i64}> : (f64, f64) -> i1
    "func.return"(%5) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "test7"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 3.200000e+00 : f64}> : () -> f64
    %1 = "arith.uitofp"(%arg0) : (i32) -> f64
    %2 = "arith.cmpf"(%1, %0) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (f64, f64) -> i1
    "func.return"(%2) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i64, sym_name = "foldShl"}> ({
    %39 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %40 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %41 = "arith.shli"(%39, %40) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%41) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShl"}> ({
    %36 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %37 = "arith.constant"() <{value = 132 : i64}> : () -> i64
    %38 = "arith.shli"(%36, %37) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%38) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShl2"}> ({
    %33 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %34 = "arith.constant"() <{value = -32 : i64}> : () -> i64
    %35 = "arith.shli"(%33, %34) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%35) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShl3"}> ({
    %30 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %31 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %32 = "arith.shli"(%30, %31) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%32) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "foldShru"}> ({
    %27 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %28 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %29 = "arith.shrui"(%27, %28) : (i64, i64) -> i64
    "func.return"(%29) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "foldShru2"}> ({
    %24 = "arith.constant"() <{value = -2 : i64}> : () -> i64
    %25 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %26 = "arith.shrui"(%24, %25) : (i64, i64) -> i64
    "func.return"(%26) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShru"}> ({
    %21 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %22 = "arith.constant"() <{value = 132 : i64}> : () -> i64
    %23 = "arith.shrui"(%21, %22) : (i64, i64) -> i64
    "func.return"(%23) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShru2"}> ({
    %18 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %19 = "arith.constant"() <{value = -32 : i64}> : () -> i64
    %20 = "arith.shrui"(%18, %19) : (i64, i64) -> i64
    "func.return"(%20) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "nofoldShru3"}> ({
    %15 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %16 = "arith.constant"() <{value = 64 : i64}> : () -> i64
    %17 = "arith.shrui"(%15, %16) : (i64, i64) -> i64
    "func.return"(%17) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "foldShrs"}> ({
    %12 = "arith.constant"() <{value = 8 : i64}> : () -> i64
    %13 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %14 = "arith.shrsi"(%12, %13) : (i64, i64) -> i64
    "func.return"(%14) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "foldShrs2"}> ({
    %9 = "arith.constant"() <{value = -2 : i64}> : () -> i64
    %10 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %11 = "arith.shrsi"(%9, %10) : (i64, i64) -> i64
    "func.return"(%11) : (i64) -> ()
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
    %2 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %3 = "arith.negf"(%2) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "test_negf1"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.negf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "arith.negf"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "test_remui"}> ({
    %0 = "arith.constant"() <{value = dense<9> : vector<4xi32>}> : () -> vector<4xi32>
    %1 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi32>}> : () -> vector<4xi32>
    %2 = "arith.remui"(%0, %1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%2) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "test_remui_1"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "arith.constant"() <{value = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
    %1 = "arith.remui"(%arg0, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%1) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> vector<4xi32>, sym_name = "test_remsi"}> ({
    %0 = "arith.constant"() <{value = dense<9> : vector<4xi32>}> : () -> vector<4xi32>
    %1 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi32>}> : () -> vector<4xi32>
    %2 = "arith.remsi"(%0, %1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%2) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xi32>) -> vector<4xi32>, sym_name = "test_remsi_1"}> ({
  ^bb0(%arg0: vector<4xi32>):
    %0 = "arith.constant"() <{value = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
    %1 = "arith.remsi"(%arg0, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%1) : (vector<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> f32, sym_name = "test_remf"}> ({
    %8 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %9 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %10 = "arith.remf"(%8, %9) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%10) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (f32, f32), sym_name = "test_remf2"}> ({
    %3 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = -2.000000e+00 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = -3.000000e+00 : f32}> : () -> f32
    %6 = "arith.remf"(%3, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %7 = "arith.remf"(%5, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%6, %7) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xf32>, sym_name = "test_remf_vec"}> ({
    %0 = "arith.constant"() <{value = dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "arith.constant"() <{value = dense<2.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %2 = "arith.remf"(%0, %1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "test_andi_not_fold_rhs"}> ({
  ^bb0(%arg1: index):
    %3 = "arith.constant"() <{value = -1 : index}> : () -> index
    %4 = "arith.xori"(%arg1, %3) : (index, index) -> index
    %5 = "arith.andi"(%arg1, %4) : (index, index) -> index
    "func.return"(%5) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "test_andi_not_fold_lhs"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = -1 : index}> : () -> index
    %1 = "arith.xori"(%arg0, %0) : (index, index) -> index
    %2 = "arith.andi"(%1, %arg0) : (index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "test_andi_not_fold_rhs_vec"}> ({
  ^bb0(%arg1: vector<2xi32>):
    %3 = "arith.constant"() <{value = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
    %4 = "arith.xori"(%arg1, %3) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = "arith.andi"(%arg1, %4) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "func.return"(%5) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "test_andi_not_fold_lhs_vec"}> ({
  ^bb0(%arg0: vector<2xi32>):
    %0 = "arith.constant"() <{value = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
    %1 = "arith.xori"(%arg0, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = "arith.andi"(%1, %arg0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "func.return"(%2) : (vector<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "xorxor0"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.xori"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "arith.xori"(%0, %arg1) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "xorxor1"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.xori"(%arg1, %arg0) : (i32, i32) -> i32
    %1 = "arith.xori"(%0, %arg1) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "xorxor2"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.xori"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "arith.xori"(%arg1, %0) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "xorxor3"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.xori"(%arg1, %arg0) : (i32, i32) -> i32
    %1 = "arith.xori"(%arg1, %0) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "andand0"}> ({
  ^bb0(%arg6: i32, %arg7: i32):
    %6 = "arith.andi"(%arg6, %arg7) : (i32, i32) -> i32
    %7 = "arith.andi"(%arg6, %6) : (i32, i32) -> i32
    "func.return"(%7) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "andand1"}> ({
  ^bb0(%arg4: i32, %arg5: i32):
    %4 = "arith.andi"(%arg4, %arg5) : (i32, i32) -> i32
    %5 = "arith.andi"(%4, %arg4) : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "andand2"}> ({
  ^bb0(%arg2: i32, %arg3: i32):
    %2 = "arith.andi"(%arg2, %arg3) : (i32, i32) -> i32
    %3 = "arith.andi"(%arg3, %2) : (i32, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "andand3"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "arith.andi"(%arg0, %arg1) : (i32, i32) -> i32
    %1 = "arith.andi"(%0, %arg1) : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIToTrunciShrUI"}> ({
  ^bb0(%arg28: i64):
    %125 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %126 = "arith.shrsi"(%arg28, %125) : (i64, i64) -> i64
    %127 = "arith.trunci"(%126) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%127) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIExactToTrunciShrUIExact"}> ({
  ^bb0(%arg27: i64):
    %122 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %123 = "arith.shrsi"(%arg27, %122) <{isExact}> : (i64, i64) -> i64
    %124 = "arith.trunci"(%123) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%124) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIToTrunciShrUIBadShiftAmt1"}> ({
  ^bb0(%arg26: i64):
    %119 = "arith.constant"() <{value = 33 : i64}> : () -> i64
    %120 = "arith.shrsi"(%arg26, %119) : (i64, i64) -> i64
    %121 = "arith.trunci"(%120) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%121) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIToTrunciShrUIBadShiftAmt2"}> ({
  ^bb0(%arg25: i64):
    %116 = "arith.constant"() <{value = 31 : i64}> : () -> i64
    %117 = "arith.shrsi"(%arg25, %116) : (i64, i64) -> i64
    %118 = "arith.trunci"(%117) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%118) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "foldShli0"}> ({
  ^bb0(%arg24: i64):
    %114 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %115 = "arith.shli"(%arg24, %114) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%115) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "foldShrui0"}> ({
  ^bb0(%arg23: i64):
    %112 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %113 = "arith.shrui"(%arg23, %112) : (i64, i64) -> i64
    "func.return"(%113) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "foldShrsi0"}> ({
  ^bb0(%arg22: i64):
    %110 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %111 = "arith.shrsi"(%arg22, %110) : (i64, i64) -> i64
    "func.return"(%111) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor1"}> ({
  ^bb0(%arg21: i1):
    %107 = "arith.constant"() <{value = true}> : () -> i1
    %108 = "arith.xori"(%arg21, %107) : (i1, i1) -> i1
    %109 = "arith.ori"(%arg21, %108) : (i1, i1) -> i1
    "func.return"(%109) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor2"}> ({
  ^bb0(%arg20: i1):
    %104 = "arith.constant"() <{value = true}> : () -> i1
    %105 = "arith.xori"(%104, %arg20) : (i1, i1) -> i1
    %106 = "arith.ori"(%arg20, %105) : (i1, i1) -> i1
    "func.return"(%106) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor3"}> ({
  ^bb0(%arg19: i1):
    %101 = "arith.constant"() <{value = true}> : () -> i1
    %102 = "arith.xori"(%arg19, %101) : (i1, i1) -> i1
    %103 = "arith.ori"(%102, %arg19) : (i1, i1) -> i1
    "func.return"(%103) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor4"}> ({
  ^bb0(%arg18: i1):
    %98 = "arith.constant"() <{value = true}> : () -> i1
    %99 = "arith.xori"(%98, %arg18) : (i1, i1) -> i1
    %100 = "arith.ori"(%99, %arg18) : (i1, i1) -> i1
    "func.return"(%100) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "foldOrXor5"}> ({
  ^bb0(%arg17: i32):
    %95 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %96 = "arith.xori"(%arg17, %95) : (i32, i32) -> i32
    %97 = "arith.ori"(%arg17, %96) : (i32, i32) -> i32
    "func.return"(%97) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "foldOrXor6"}> ({
  ^bb0(%arg16: index):
    %92 = "arith.constant"() <{value = -1 : index}> : () -> index
    %93 = "arith.xori"(%arg16, %92) : (index, index) -> index
    %94 = "arith.ori"(%arg16, %93) : (index, index) -> index
    "func.return"(%94) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32) -> (i32, i32, i32, i32), sym_name = "selectOfPoison"}> ({
  ^bb0(%arg14: i1, %arg15: i32):
    %85 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %86 = "arith.select"(%arg14, %85, %arg15) : (i1, i32, i32) -> i32
    %87 = "arith.select"(%arg14, %arg15, %85) : (i1, i32, i32) -> i32
    %88 = "arith.constant"() <{value = true}> : () -> i1
    %89 = "arith.constant"() <{value = false}> : () -> i1
    %90 = "arith.select"(%88, %85, %arg15) : (i1, i32, i32) -> i32
    %91 = "arith.select"(%89, %85, %arg15) : (i1, i32, i32) -> i32
    "func.return"(%86, %87, %90, %91) : (i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "addi_poison1"}> ({
  ^bb0(%arg13: i32):
    %83 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %84 = "arith.addi"(%83, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%84) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "addi_poison2"}> ({
  ^bb0(%arg12: i32):
    %81 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %82 = "arith.addi"(%arg12, %81) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%82) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "addf_poison1"}> ({
  ^bb0(%arg11: f32):
    %79 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %80 = "arith.addf"(%79, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%80) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "addf_poison2"}> ({
  ^bb0(%arg10: f32):
    %77 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %78 = "arith.addf"(%arg10, %77) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%78) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "negf_poison"}> ({
    %75 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %76 = "arith.negf"(%75) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%76) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "extsi_poison"}> ({
    %73 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %74 = "arith.extsi"(%73) : (i32) -> i64
    "func.return"(%74) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<i16>, sym_name = "unsignedExtendConstantResource"}> ({
    %71 = "arith.constant"() <{value = dense_resource<blob1> : tensor<i8>}> : () -> tensor<i8>
    %72 = "arith.extui"(%71) : (tensor<i8>) -> tensor<i16>
    "func.return"(%72) : (tensor<i16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "extsi_i0"}> ({
    %69 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    %70 = "arith.extsi"(%69) : (i0) -> i16
    "func.return"(%70) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "extui_i0"}> ({
    %67 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    %68 = "arith.extui"(%67) : (i0) -> i16
    "func.return"(%68) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i0, sym_name = "trunc_i0"}> ({
    %65 = "arith.constant"() <{value = -1 : i8}> : () -> i8
    %66 = "arith.trunci"(%65) <{overflowFlags = #arith.overflow<none>}> : (i8) -> i0
    "func.return"(%66) : (i0) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i0, sym_name = "shli_i0"}> ({
    %63 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    %64 = "arith.shli"(%63, %63) <{overflowFlags = #arith.overflow<none>}> : (i0, i0) -> i0
    "func.return"(%64) : (i0) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i0, sym_name = "shrsi_i0"}> ({
    %61 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    %62 = "arith.shrsi"(%61, %61) : (i0, i0) -> i0
    "func.return"(%62) : (i0) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i0, sym_name = "shrui_i0"}> ({
    %59 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    %60 = "arith.shrui"(%59, %59) : (i0, i0) -> i0
    "func.return"(%60) : (i0) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i0, sym_name = "maxsi_i0"}> ({
    %57 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    %58 = "arith.maxsi"(%57, %57) : (i0, i0) -> i0
    "func.return"(%58) : (i0) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i0, sym_name = "minsi_i0"}> ({
    %55 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    %56 = "arith.minsi"(%55, %55) : (i0, i0) -> i0
    "func.return"(%56) : (i0) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i0, i0), sym_name = "mulsi_extended_i0"}> ({
    %53 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    %54:2 = "arith.mulsi_extended"(%53, %53) : (i0, i0) -> (i0, i0)
    "func.return"(%54#0, %54#1) : (i0, i0) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> bf16, sym_name = "sequences_fastmath_contract"}> ({
  ^bb0(%arg9: bf16):
    %47 = "arith.extf"(%arg9) <{fastmath = #arith.fastmath<contract>}> : (bf16) -> f32
    %48 = "math.absf"(%47) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %49 = "arith.truncf"(%48) <{fastmath = #arith.fastmath<contract>}> : (f32) -> bf16
    %50 = "arith.extf"(%49) <{fastmath = #arith.fastmath<contract>}> : (bf16) -> f32
    %51 = "math.sin"(%50) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %52 = "arith.truncf"(%51) <{fastmath = #arith.fastmath<contract>}> : (f32) -> bf16
    "func.return"(%52) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> bf16, sym_name = "sequences_no_fastmath"}> ({
  ^bb0(%arg8: bf16):
    %41 = "arith.extf"(%arg8) : (bf16) -> f32
    %42 = "math.absf"(%41) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %43 = "arith.truncf"(%42) : (f32) -> bf16
    %44 = "arith.extf"(%43) : (bf16) -> f32
    %45 = "math.sin"(%44) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %46 = "arith.truncf"(%45) : (f32) -> bf16
    "func.return"(%46) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "eliminate_cast_to_f16"}> ({
  ^bb0(%arg7: f32):
    %39 = "arith.truncf"(%arg7) <{fastmath = #arith.fastmath<contract>}> : (f32) -> f16
    %40 = "arith.extf"(%39) <{fastmath = #arith.fastmath<contract>}> : (f16) -> f32
    "func.return"(%40) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "eliminate_cast_to_bf16"}> ({
  ^bb0(%arg6: f32):
    %37 = "arith.truncf"(%arg6) <{fastmath = #arith.fastmath<contract>}> : (f32) -> bf16
    %38 = "arith.extf"(%37) <{fastmath = #arith.fastmath<contract>}> : (bf16) -> f32
    "func.return"(%38) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<32x32x32xbf16>) -> vector<32x32x32xbf16>, sym_name = "bf16_sin_vector"}> ({
  ^bb0(%arg5: vector<32x32x32xbf16>):
    %31 = "arith.extf"(%arg5) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %32 = "math.absf"(%31) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %33 = "arith.truncf"(%32) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xbf16>
    %34 = "arith.extf"(%33) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %35 = "math.sin"(%34) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %36 = "arith.truncf"(%35) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xbf16>
    "func.return"(%36) : (vector<32x32x32xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<32x32x32xf16>) -> vector<32x32x32xf16>, sym_name = "f16_sin_vector"}> ({
  ^bb0(%arg4: vector<32x32x32xf16>):
    %25 = "arith.extf"(%arg4) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf16>) -> vector<32x32x32xf32>
    %26 = "math.absf"(%25) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %27 = "arith.truncf"(%26) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf16>
    %28 = "arith.extf"(%27) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf16>) -> vector<32x32x32xf32>
    %29 = "math.sin"(%28) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %30 = "arith.truncf"(%29) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf16>
    "func.return"(%30) : (vector<32x32x32xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<32x32x32xbf16>) -> vector<32x32x32xbf16>, sym_name = "bf16_branch_vector"}> ({
  ^bb0(%arg3: vector<32x32x32xbf16>):
    %13 = "arith.extf"(%arg3) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %14 = "math.absf"(%13) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %15 = "arith.truncf"(%14) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xbf16>
    %16 = "arith.extf"(%15) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %17 = "math.sin"(%16) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %18 = "arith.truncf"(%17) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xbf16>
    %19 = "arith.extf"(%18) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %20 = "math.cos"(%16) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %21 = "arith.truncf"(%20) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xbf16>
    %22 = "arith.extf"(%21) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %23 = "arith.addf"(%19, %22) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>, vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %24 = "arith.truncf"(%23) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xbf16>
    "func.return"(%24) : (vector<32x32x32xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<32x32x32xbf16>, vector<32x32x32xbf16>, vector<32x32x32xbf16>) -> vector<32x32x32xbf16>, sym_name = "bf16_fma"}> ({
  ^bb0(%arg0: vector<32x32x32xbf16>, %arg1: vector<32x32x32xbf16>, %arg2: vector<32x32x32xbf16>):
    %2 = "arith.extf"(%arg0) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %3 = "math.absf"(%2) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %4 = "arith.truncf"(%3) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xbf16>
    %5 = "arith.extf"(%4) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %6 = "math.sin"(%5) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %7 = "arith.truncf"(%6) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xbf16>
    %8 = "arith.extf"(%7) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %9 = "math.fma"(%7, %arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xbf16>, vector<32x32x32xbf16>, vector<32x32x32xbf16>) -> vector<32x32x32xbf16>
    %10 = "arith.extf"(%9) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xbf16>) -> vector<32x32x32xf32>
    %11 = "arith.addf"(%10, %8) <{fastmath = #arith.fastmath<none>}> : (vector<32x32x32xf32>, vector<32x32x32xf32>) -> vector<32x32x32xf32>
    %12 = "arith.truncf"(%11) <{fastmath = #arith.fastmath<contract>}> : (vector<32x32x32xf32>) -> vector<32x32x32xbf16>
    "func.return"(%12) : (vector<32x32x32xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "unreachable"}> ({
    "func.return"() : () -> ()
  ^bb1:  // pred: ^bb1
    %0 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %1 = "arith.addi"(%1, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
}) : () -> ()

{-#
  dialect_resources: {
    builtin: {
      blob1: "0x08000000010000000000000002000000000000000300000000000000"
    }
  }
#-}

