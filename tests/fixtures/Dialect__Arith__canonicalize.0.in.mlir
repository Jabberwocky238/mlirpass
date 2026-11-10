"builtin.module"() ({
  "func.func"() <{function_type = (i1, i64) -> i64, sym_name = "select_same_val"}> ({
  ^bb0(%arg44: i1, %arg45: i64):
    %108 = "arith.select"(%arg44, %arg45, %arg45) : (i1, i64, i64) -> i64
    "func.return"(%108) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "select_cmp_eq_select"}> ({
  ^bb0(%arg42: i64, %arg43: i64):
    %106 = "arith.cmpi"(%arg42, %arg43) <{predicate = 0 : i64}> : (i64, i64) -> i1
    %107 = "arith.select"(%106, %arg42, %arg43) : (i1, i64, i64) -> i64
    "func.return"(%107) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "select_cmp_ne_select"}> ({
  ^bb0(%arg40: i64, %arg41: i64):
    %104 = "arith.cmpi"(%arg40, %arg41) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %105 = "arith.select"(%104, %arg40, %arg41) : (i1, i64, i64) -> i64
    "func.return"(%105) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> (i64, i64, i64, i64, i64, i64, i64, i64), sym_name = "select_cmp_signed_min_max"}> ({
  ^bb0(%arg38: i64, %arg39: i64):
    %92 = "arith.cmpi"(%arg38, %arg39) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %93 = "arith.cmpi"(%arg38, %arg39) <{predicate = 3 : i64}> : (i64, i64) -> i1
    %94 = "arith.cmpi"(%arg38, %arg39) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %95 = "arith.cmpi"(%arg38, %arg39) <{predicate = 5 : i64}> : (i64, i64) -> i1
    %96 = "arith.select"(%92, %arg38, %arg39) : (i1, i64, i64) -> i64
    %97 = "arith.select"(%93, %arg38, %arg39) : (i1, i64, i64) -> i64
    %98 = "arith.select"(%94, %arg39, %arg38) : (i1, i64, i64) -> i64
    %99 = "arith.select"(%95, %arg39, %arg38) : (i1, i64, i64) -> i64
    %100 = "arith.select"(%92, %arg39, %arg38) : (i1, i64, i64) -> i64
    %101 = "arith.select"(%93, %arg39, %arg38) : (i1, i64, i64) -> i64
    %102 = "arith.select"(%94, %arg38, %arg39) : (i1, i64, i64) -> i64
    %103 = "arith.select"(%95, %arg38, %arg39) : (i1, i64, i64) -> i64
    "func.return"(%96, %97, %98, %99, %100, %101, %102, %103) : (i64, i64, i64, i64, i64, i64, i64, i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> (i64, i64, i64, i64, i64, i64, i64, i64), sym_name = "select_cmp_unsigned_min_max"}> ({
  ^bb0(%arg36: i64, %arg37: i64):
    %80 = "arith.cmpi"(%arg36, %arg37) <{predicate = 6 : i64}> : (i64, i64) -> i1
    %81 = "arith.cmpi"(%arg36, %arg37) <{predicate = 7 : i64}> : (i64, i64) -> i1
    %82 = "arith.cmpi"(%arg36, %arg37) <{predicate = 8 : i64}> : (i64, i64) -> i1
    %83 = "arith.cmpi"(%arg36, %arg37) <{predicate = 9 : i64}> : (i64, i64) -> i1
    %84 = "arith.select"(%80, %arg36, %arg37) : (i1, i64, i64) -> i64
    %85 = "arith.select"(%81, %arg36, %arg37) : (i1, i64, i64) -> i64
    %86 = "arith.select"(%82, %arg37, %arg36) : (i1, i64, i64) -> i64
    %87 = "arith.select"(%83, %arg37, %arg36) : (i1, i64, i64) -> i64
    %88 = "arith.select"(%80, %arg37, %arg36) : (i1, i64, i64) -> i64
    %89 = "arith.select"(%81, %arg37, %arg36) : (i1, i64, i64) -> i64
    %90 = "arith.select"(%82, %arg36, %arg37) : (i1, i64, i64) -> i64
    %91 = "arith.select"(%83, %arg36, %arg37) : (i1, i64, i64) -> i64
    "func.return"(%84, %85, %86, %87, %88, %89, %90, %91) : (i64, i64, i64, i64, i64, i64, i64, i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, vector<4xi32>, vector<4xi32>) -> (index, vector<4xi32>), sym_name = "select_cmp_min_max_index_vector"}> ({
  ^bb0(%arg32: index, %arg33: index, %arg34: vector<4xi32>, %arg35: vector<4xi32>):
    %76 = "arith.cmpi"(%arg32, %arg33) <{predicate = 3 : i64}> : (index, index) -> i1
    %77 = "arith.select"(%76, %arg32, %arg33) : (i1, index, index) -> index
    %78 = "arith.cmpi"(%arg34, %arg35) <{predicate = 6 : i64}> : (vector<4xi32>, vector<4xi32>) -> vector<4xi1>
    %79 = "arith.select"(%78, %arg35, %arg34) : (vector<4xi1>, vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "func.return"(%77, %79) : (index, vector<4xi32>) -> ()
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
  ^bb0(%arg3: i1):
    %6 = "arith.extui"(%arg3) : (i1) -> i8
    %7 = "arith.extsi"(%6) : (i8) -> i64
    "func.return"(%7) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i64, sym_name = "extSIOfExtUI_nneg"}> ({
  ^bb0(%arg2: i1):
    %4 = "arith.extui"(%arg2) <{nonNeg}> : (i1) -> i8
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
  ^bb0(%arg16: i8, %arg17: i8):
    %24 = "arith.extsi"(%arg16) : (i8) -> i64
    %25 = "arith.extsi"(%arg17) : (i8) -> i64
    %26 = "arith.andi"(%24, %25) : (i64, i64) -> i64
    "func.return"(%26) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "andOfExtUI"}> ({
  ^bb0(%arg14: i8, %arg15: i8):
    %21 = "arith.extui"(%arg14) : (i8) -> i64
    %22 = "arith.extui"(%arg15) : (i8) -> i64
    %23 = "arith.andi"(%21, %22) : (i64, i64) -> i64
    "func.return"(%23) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "andOfExtUI_nneg_lhs"}> ({
  ^bb0(%arg12: i8, %arg13: i8):
    %18 = "arith.extui"(%arg12) <{nonNeg}> : (i8) -> i64
    %19 = "arith.extui"(%arg13) : (i8) -> i64
    %20 = "arith.andi"(%18, %19) : (i64, i64) -> i64
    "func.return"(%20) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "andOfExtUI_nneg_rhs"}> ({
  ^bb0(%arg10: i8, %arg11: i8):
    %15 = "arith.extui"(%arg10) : (i8) -> i64
    %16 = "arith.extui"(%arg11) <{nonNeg}> : (i8) -> i64
    %17 = "arith.andi"(%15, %16) : (i64, i64) -> i64
    "func.return"(%17) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "andOfExtUI_nneg_both"}> ({
  ^bb0(%arg8: i8, %arg9: i8):
    %12 = "arith.extui"(%arg8) <{nonNeg}> : (i8) -> i64
    %13 = "arith.extui"(%arg9) <{nonNeg}> : (i8) -> i64
    %14 = "arith.andi"(%12, %13) : (i64, i64) -> i64
    "func.return"(%14) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "orOfExtSI"}> ({
  ^bb0(%arg6: i8, %arg7: i8):
    %9 = "arith.extsi"(%arg6) : (i8) -> i64
    %10 = "arith.extsi"(%arg7) : (i8) -> i64
    %11 = "arith.ori"(%9, %10) : (i64, i64) -> i64
    "func.return"(%11) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "orOfExtUI"}> ({
  ^bb0(%arg4: i8, %arg5: i8):
    %6 = "arith.extui"(%arg4) : (i8) -> i64
    %7 = "arith.extui"(%arg5) : (i8) -> i64
    %8 = "arith.ori"(%6, %7) : (i64, i64) -> i64
    "func.return"(%8) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "orOfExtUI_nneg_both"}> ({
  ^bb0(%arg2: i8, %arg3: i8):
    %3 = "arith.extui"(%arg2) <{nonNeg}> : (i8) -> i64
    %4 = "arith.extui"(%arg3) <{nonNeg}> : (i8) -> i64
    %5 = "arith.ori"(%3, %4) : (i64, i64) -> i64
    "func.return"(%5) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "orOfExtUI_nneg_mixed"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %0 = "arith.extui"(%arg0) <{nonNeg}> : (i8) -> i64
    %1 = "arith.extui"(%arg1) : (i8) -> i64
    %2 = "arith.ori"(%0, %1) : (i64, i64) -> i64
    "func.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "andOfAndConstant"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 12 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %2 = "arith.andi"(%arg0, %0) : (i32, i32) -> i32
    %3 = "arith.andi"(%2, %1) : (i32, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "andOfAndConstantIndex"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 12 : index}> : () -> index
    %1 = "arith.constant"() <{value = 10 : index}> : () -> index
    %2 = "arith.andi"(%arg0, %0) : (index, index) -> index
    %3 = "arith.andi"(%2, %1) : (index, index) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "andOfAndConstantMultiUse"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 12 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %2 = "arith.andi"(%arg0, %0) : (i32, i32) -> i32
    %3 = "arith.andi"(%2, %1) : (i32, i32) -> i32
    "func.return"(%2, %3) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32, i32), sym_name = "andOfAndConstantChain"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 14 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 13 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 11 : i32}> : () -> i32
    %3 = "arith.andi"(%arg0, %0) : (i32, i32) -> i32
    %4 = "arith.andi"(%3, %1) : (i32, i32) -> i32
    %5 = "arith.andi"(%4, %2) : (i32, i32) -> i32
    "func.return"(%3, %4, %5) : (i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "orOfOrConstant"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 12 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %2 = "arith.ori"(%arg0, %0) : (i32, i32) -> i32
    %3 = "arith.ori"(%2, %1) : (i32, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "orOfOrConstantIndex"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 12 : index}> : () -> index
    %1 = "arith.constant"() <{value = 10 : index}> : () -> index
    %2 = "arith.ori"(%arg0, %0) : (index, index) -> index
    %3 = "arith.ori"(%2, %1) : (index, index) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "orOfOrConstantMultiUse"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 12 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %2 = "arith.ori"(%arg0, %0) : (i32, i32) -> i32
    %3 = "arith.ori"(%2, %1) : (i32, i32) -> i32
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
    %32 = "arith.extsi"(%arg4) : (i8) -> i16
    %33 = "arith.index_cast"(%32) : (i16) -> index
    "func.return"(%33) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> index, sym_name = "indexCastUIOfUnsignedExtend"}> ({
  ^bb0(%arg3: i8):
    %30 = "arith.extui"(%arg3) : (i8) -> i16
    %31 = "arith.index_castui"(%30) : (i16) -> index
    "func.return"(%31) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> index, sym_name = "indexCastUIOfUnsignedExtend_nneg_on_extui"}> ({
  ^bb0(%arg2: i8):
    %28 = "arith.extui"(%arg2) <{nonNeg}> : (i8) -> i16
    %29 = "arith.index_castui"(%28) : (i16) -> index
    "func.return"(%29) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> index, sym_name = "indexCastUIOfUnsignedExtend_nneg_on_castui"}> ({
  ^bb0(%arg1: i8):
    %26 = "arith.extui"(%arg1) : (i8) -> i16
    %27 = "arith.index_castui"(%26) <{nonNeg}> : (i16) -> index
    "func.return"(%27) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "indexCastFold"}> ({
    %24 = "arith.constant"() <{value = -2 : i8}> : () -> i8
    %25 = "arith.index_cast"(%24) : (i8) -> index
    "func.return"(%25) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "indexCastFoldIndexToInt"}> ({
    %22 = "arith.constant"() <{value = 1 : index}> : () -> index
    %23 = "arith.index_cast"(%22) : (index) -> i32
    "func.return"(%23) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastFoldSplatVector"}> ({
    %20 = "arith.constant"() <{value = dense<42> : vector<3xi32>}> : () -> vector<3xi32>
    %21 = "arith.index_cast"(%20) : (vector<3xi32>) -> vector<3xindex>
    "func.return"(%21) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastFoldVector"}> ({
    %18 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %19 = "arith.index_cast"(%18) : (vector<3xi32>) -> vector<3xindex>
    "func.return"(%19) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastFoldSplatVectorIndexToInt"}> ({
    %16 = "arith.constant"() <{value = dense<42> : vector<3xindex>}> : () -> vector<3xindex>
    %17 = "arith.index_cast"(%16) : (vector<3xindex>) -> vector<3xi32>
    "func.return"(%17) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastFoldVectorIndexToInt"}> ({
    %14 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xindex>}> : () -> vector<3xindex>
    %15 = "arith.index_cast"(%14) : (vector<3xindex>) -> vector<3xi32>
    "func.return"(%15) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "indexCastUIFold"}> ({
    %12 = "arith.constant"() <{value = -2 : i8}> : () -> i8
    %13 = "arith.index_castui"(%12) : (i8) -> index
    "func.return"(%13) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastUIFoldSplatVector"}> ({
    %10 = "arith.constant"() <{value = dense<42> : vector<3xi32>}> : () -> vector<3xi32>
    %11 = "arith.index_castui"(%10) : (vector<3xi32>) -> vector<3xindex>
    "func.return"(%11) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastUIFoldVector"}> ({
    %8 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    %9 = "arith.index_castui"(%8) : (vector<3xi32>) -> vector<3xindex>
    "func.return"(%9) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "indexCastUIFoldIndexToInt"}> ({
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.index_castui"(%6) : (index) -> i32
    "func.return"(%7) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastUIFoldSplatVectorIndexToInt"}> ({
    %4 = "arith.constant"() <{value = dense<42> : vector<3xindex>}> : () -> vector<3xindex>
    %5 = "arith.index_castui"(%4) : (vector<3xindex>) -> vector<3xi32>
    "func.return"(%5) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastUIFoldVectorIndexToInt"}> ({
    %2 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xindex>}> : () -> vector<3xindex>
    %3 = "arith.index_castui"(%2) : (vector<3xindex>) -> vector<3xi32>
    "func.return"(%3) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "indexCastOfIndexCast_lossless"}> ({
  ^bb0(%arg0: i64):
    %0 = "arith.index_cast"(%arg0) : (i64) -> index
    %1 = "arith.index_cast"(%0) : (index) -> i64
    "func.return"(%1) : (i64) -> ()
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
    %0 = "arith.index_castui"(%arg0) : (i64) -> index
    %1 = "arith.index_castui"(%0) : (index) -> i64
    "func.return"(%1) : (i64) -> ()
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
    %1 = "arith.index_cast"(%0) : (index) -> i64
    %2 = "arith.index_cast"(%1) : (i64) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> i8, sym_name = "indexCastOfIndexCast_i8_roundtrip"}> ({
  ^bb0(%arg0: i8):
    %0 = "arith.index_cast"(%arg0) : (i8) -> index
    %1 = "arith.index_cast"(%0) : (index) -> i8
    "func.return"(%1) : (i8) -> ()
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
    %333 = "arith.constant"() <{value = -2 : i8}> : () -> i8
    %334 = "arith.extsi"(%333) : (i8) -> i16
    "func.return"(%334) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "signExtendConstantSplat"}> ({
    %330 = "arith.constant"() <{value = -2 : i8}> : () -> i8
    %331 = "vector.broadcast"(%330) : (i8) -> vector<4xi8>
    %332 = "arith.extsi"(%331) : (vector<4xi8>) -> vector<4xi16>
    "func.return"(%332) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "signExtendConstantVector"}> ({
    %328 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi8>}> : () -> vector<4xi8>
    %329 = "arith.extsi"(%328) : (vector<4xi8>) -> vector<4xi16>
    "func.return"(%329) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "unsignedExtendConstant"}> ({
    %326 = "arith.constant"() <{value = 2 : i8}> : () -> i8
    %327 = "arith.extui"(%326) : (i8) -> i16
    "func.return"(%327) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "unsignedExtendConstantSplat"}> ({
    %323 = "arith.constant"() <{value = 2 : i8}> : () -> i8
    %324 = "vector.broadcast"(%323) : (i8) -> vector<4xi8>
    %325 = "arith.extui"(%324) : (vector<4xi8>) -> vector<4xi16>
    "func.return"(%325) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "unsignedExtendConstantVector"}> ({
    %321 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi8>}> : () -> vector<4xi8>
    %322 = "arith.extui"(%321) : (vector<4xi8>) -> vector<4xi16>
    "func.return"(%322) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "extFPConstant"}> ({
    %319 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %320 = "arith.extf"(%319) : (f32) -> f64
    "func.return"(%320) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<2xf128>, sym_name = "extFPVectorConstant"}> ({
    %317 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00]> : vector<2xf80>}> : () -> vector<2xf80>
    %318 = "arith.extf"(%317) : (vector<2xf80>) -> vector<2xf128>
    "func.return"(%318) : (vector<2xf128>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "truncExtf"}> ({
  ^bb0(%arg126: f32):
    %315 = "arith.extf"(%arg126) : (f32) -> f64
    %316 = "arith.truncf"(%315) : (f64) -> f32
    "func.return"(%316) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> bf16, sym_name = "truncExtf1"}> ({
  ^bb0(%arg125: bf16):
    %313 = "arith.extf"(%arg125) : (bf16) -> f32
    %314 = "arith.truncf"(%313) : (f32) -> bf16
    "func.return"(%314) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> f16, sym_name = "truncExtf2"}> ({
  ^bb0(%arg124: bf16):
    %311 = "arith.extf"(%arg124) : (bf16) -> f32
    %312 = "arith.truncf"(%311) : (f32) -> f16
    "func.return"(%312) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f16, sym_name = "truncExtf3"}> ({
  ^bb0(%arg123: f32):
    %309 = "arith.extf"(%arg123) : (f32) -> f64
    %310 = "arith.truncf"(%309) : (f64) -> f16
    "func.return"(%310) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "truncSitofp"}> ({
  ^bb0(%arg122: i32):
    %307 = "arith.sitofp"(%arg122) : (i32) -> f64
    %308 = "arith.truncf"(%307) : (f64) -> f32
    "func.return"(%308) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "truncSitofpConstrained"}> ({
  ^bb0(%arg121: i32):
    %305 = "arith.sitofp"(%arg121) : (i32) -> f64
    %306 = "arith.truncf"(%305) <{roundingmode = 0 : i32}> : (f64) -> f32
    "func.return"(%306) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "truncUitofp"}> ({
  ^bb0(%arg120: i32):
    %303 = "arith.uitofp"(%arg120) : (i32) -> f64
    %304 = "arith.truncf"(%303) : (f64) -> f32
    "func.return"(%304) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "truncUitofp_nneg"}> ({
  ^bb0(%arg119: i32):
    %301 = "arith.uitofp"(%arg119) <{nonNeg}> : (i32) -> f64
    %302 = "arith.truncf"(%301) : (f64) -> f32
    "func.return"(%302) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> bf16, sym_name = "sitofpExtsi"}> ({
  ^bb0(%arg118: i8):
    %299 = "arith.extsi"(%arg118) : (i8) -> i32
    %300 = "arith.sitofp"(%299) : (i32) -> bf16
    "func.return"(%300) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i4) -> bf16, sym_name = "sitofpExtui"}> ({
  ^bb0(%arg117: i4):
    %297 = "arith.extui"(%arg117) : (i4) -> i8
    %298 = "arith.sitofp"(%297) : (i8) -> bf16
    "func.return"(%298) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> bf16, sym_name = "uitofpExtui"}> ({
  ^bb0(%arg116: i8):
    %295 = "arith.extui"(%arg116) : (i8) -> i32
    %296 = "arith.uitofp"(%295) : (i32) -> bf16
    "func.return"(%296) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i4) -> bf16, sym_name = "sitofpExtui_nneg"}> ({
  ^bb0(%arg115: i4):
    %293 = "arith.extui"(%arg115) <{nonNeg}> : (i4) -> i8
    %294 = "arith.sitofp"(%293) : (i8) -> bf16
    "func.return"(%294) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncConstant"}> ({
  ^bb0(%arg114: i8):
    %291 = "arith.constant"() <{value = -2 : i32}> : () -> i32
    %292 = "arith.trunci"(%291) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i16
    "func.return"(%292) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "truncExtui"}> ({
  ^bb0(%arg113: i32):
    %289 = "arith.extui"(%arg113) : (i32) -> i64
    %290 = "arith.trunci"(%289) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%290) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i16, sym_name = "truncExtui2"}> ({
  ^bb0(%arg112: i32):
    %287 = "arith.extui"(%arg112) : (i32) -> i64
    %288 = "arith.trunci"(%287) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i16
    "func.return"(%288) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncExtui3"}> ({
  ^bb0(%arg111: i8):
    %285 = "arith.extui"(%arg111) : (i8) -> i32
    %286 = "arith.trunci"(%285) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i16
    "func.return"(%286) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncExtui3_nneg"}> ({
  ^bb0(%arg110: i8):
    %283 = "arith.extui"(%arg110) <{nonNeg}> : (i8) -> i32
    %284 = "arith.trunci"(%283) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i16
    "func.return"(%284) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi16>, sym_name = "truncExtuiVector"}> ({
  ^bb0(%arg109: vector<2xi32>):
    %281 = "arith.extui"(%arg109) : (vector<2xi32>) -> vector<2xi64>
    %282 = "arith.trunci"(%281) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi64>) -> vector<2xi16>
    "func.return"(%282) : (vector<2xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "truncExtsi"}> ({
  ^bb0(%arg108: i32):
    %279 = "arith.extsi"(%arg108) : (i32) -> i64
    %280 = "arith.trunci"(%279) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%280) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i16, sym_name = "truncExtsi2"}> ({
  ^bb0(%arg107: i32):
    %277 = "arith.extsi"(%arg107) : (i32) -> i64
    %278 = "arith.trunci"(%277) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i16
    "func.return"(%278) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncExtsi3"}> ({
  ^bb0(%arg106: i8):
    %275 = "arith.extsi"(%arg106) : (i8) -> i32
    %276 = "arith.trunci"(%275) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i16
    "func.return"(%276) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi16>, sym_name = "truncExtsiVector"}> ({
  ^bb0(%arg105: vector<2xi32>):
    %273 = "arith.extsi"(%arg105) : (vector<2xi32>) -> vector<2xi64>
    %274 = "arith.trunci"(%273) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi64>) -> vector<2xi16>
    "func.return"(%274) : (vector<2xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi8>, sym_name = "truncConstantSplat"}> ({
    %270 = "arith.constant"() <{value = -2 : i16}> : () -> i16
    %271 = "vector.broadcast"(%270) : (i16) -> vector<4xi16>
    %272 = "arith.trunci"(%271) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi16>) -> vector<4xi8>
    "func.return"(%272) : (vector<4xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi8>, sym_name = "truncConstantVector"}> ({
    %268 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi16>}> : () -> vector<4xi16>
    %269 = "arith.trunci"(%268) <{overflowFlags = #arith.overflow<none>}> : (vector<4xi16>) -> vector<4xi8>
    "func.return"(%269) : (vector<4xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i8, sym_name = "truncTrunc"}> ({
  ^bb0(%arg104: i64):
    %266 = "arith.trunci"(%arg104) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    %267 = "arith.trunci"(%266) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
    "func.return"(%267) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPConstant"}> ({
    %264 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %265 = "arith.truncf"(%264) : (f32) -> bf16
    "func.return"(%265) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPToNearestEvenConstant"}> ({
    %262 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %263 = "arith.truncf"(%262) <{roundingmode = 0 : i32}> : (f32) -> bf16
    "func.return"(%263) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPDownwardConstant"}> ({
    %260 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %261 = "arith.truncf"(%260) <{roundingmode = 1 : i32}> : (f32) -> bf16
    "func.return"(%261) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPUpwardConstant"}> ({
    %258 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %259 = "arith.truncf"(%258) <{roundingmode = 2 : i32}> : (f32) -> bf16
    "func.return"(%259) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPTowardZeroConstant"}> ({
    %256 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %257 = "arith.truncf"(%256) <{roundingmode = 3 : i32}> : (f32) -> bf16
    "func.return"(%257) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPToNearestAwayConstant"}> ({
    %254 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %255 = "arith.truncf"(%254) <{roundingmode = 4 : i32}> : (f32) -> bf16
    "func.return"(%255) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<2xbf16>, sym_name = "truncFPVectorConstant"}> ({
    %252 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00]> : vector<2xf32>}> : () -> vector<2xf32>
    %253 = "arith.truncf"(%252) : (vector<2xf32>) -> vector<2xbf16>
    "func.return"(%253) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPConstantRounding"}> ({
    %250 = "arith.constant"() <{value = 1.444000e+25 : f32}> : () -> f32
    %251 = "arith.truncf"(%250) : (f32) -> bf16
    "func.return"(%251) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddAdd"}> ({
  ^bb0(%arg103: index):
    %246 = "arith.constant"() <{value = 17 : index}> : () -> index
    %247 = "arith.constant"() <{value = 42 : index}> : () -> index
    %248 = "arith.addi"(%246, %arg103) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %249 = "arith.addi"(%247, %248) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%249) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddAddOvf1"}> ({
  ^bb0(%arg102: index):
    %242 = "arith.constant"() <{value = 17 : index}> : () -> index
    %243 = "arith.constant"() <{value = 42 : index}> : () -> index
    %244 = "arith.addi"(%242, %arg102) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %245 = "arith.addi"(%243, %244) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%245) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddAddOvf2"}> ({
  ^bb0(%arg101: index):
    %238 = "arith.constant"() <{value = 17 : index}> : () -> index
    %239 = "arith.constant"() <{value = 42 : index}> : () -> index
    %240 = "arith.addi"(%238, %arg101) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    %241 = "arith.addi"(%239, %240) <{overflowFlags = #arith.overflow<nuw>}> : (index, index) -> index
    "func.return"(%241) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<10xi32>, tensor<?x?xi32>) -> (tensor<10xi32>, tensor<?x?xi32>), sym_name = "foldSubXX_tensor"}> ({
  ^bb0(%arg99: tensor<10xi32>, %arg100: tensor<?x?xi32>):
    %236 = "arith.subi"(%arg99, %arg99) <{overflowFlags = #arith.overflow<none>}> : (tensor<10xi32>, tensor<10xi32>) -> tensor<10xi32>
    %237 = "arith.subi"(%arg100, %arg100) <{overflowFlags = #arith.overflow<none>}> : (tensor<?x?xi32>, tensor<?x?xi32>) -> tensor<?x?xi32>
    "func.return"(%236, %237) : (tensor<10xi32>, tensor<?x?xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xi32>, vector<[4]xi32>) -> (vector<8xi32>, vector<[4]xi32>), sym_name = "foldSubXX_vector"}> ({
  ^bb0(%arg97: vector<8xi32>, %arg98: vector<[4]xi32>):
    %234 = "arith.subi"(%arg97, %arg97) <{overflowFlags = #arith.overflow<none>}> : (vector<8xi32>, vector<8xi32>) -> vector<8xi32>
    %235 = "arith.subi"(%arg98, %arg98) <{overflowFlags = #arith.overflow<none>}> : (vector<[4]xi32>, vector<[4]xi32>) -> vector<[4]xi32>
    "func.return"(%234, %235) : (vector<8xi32>, vector<[4]xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub0"}> ({
  ^bb0(%arg96: index):
    %230 = "arith.constant"() <{value = 17 : index}> : () -> index
    %231 = "arith.constant"() <{value = 42 : index}> : () -> index
    %232 = "arith.subi"(%230, %arg96) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %233 = "arith.addi"(%231, %232) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%233) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub0Ovf"}> ({
  ^bb0(%arg95: index):
    %226 = "arith.constant"() <{value = 17 : index}> : () -> index
    %227 = "arith.constant"() <{value = 42 : index}> : () -> index
    %228 = "arith.subi"(%226, %arg95) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %229 = "arith.addi"(%227, %228) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%229) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub1"}> ({
  ^bb0(%arg94: index):
    %222 = "arith.constant"() <{value = 17 : index}> : () -> index
    %223 = "arith.constant"() <{value = 42 : index}> : () -> index
    %224 = "arith.subi"(%arg94, %222) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %225 = "arith.addi"(%223, %224) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%225) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub1Ovf"}> ({
  ^bb0(%arg93: index):
    %218 = "arith.constant"() <{value = 17 : index}> : () -> index
    %219 = "arith.constant"() <{value = 42 : index}> : () -> index
    %220 = "arith.subi"(%arg93, %218) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %221 = "arith.addi"(%219, %220) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%221) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubAdd0"}> ({
  ^bb0(%arg92: index):
    %214 = "arith.constant"() <{value = 17 : index}> : () -> index
    %215 = "arith.constant"() <{value = 42 : index}> : () -> index
    %216 = "arith.addi"(%214, %arg92) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %217 = "arith.subi"(%215, %216) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%217) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubAdd0Ovf"}> ({
  ^bb0(%arg91: index):
    %210 = "arith.constant"() <{value = 17 : index}> : () -> index
    %211 = "arith.constant"() <{value = 42 : index}> : () -> index
    %212 = "arith.addi"(%210, %arg91) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %213 = "arith.subi"(%211, %212) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%213) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubAdd1"}> ({
  ^bb0(%arg90: index):
    %206 = "arith.constant"() <{value = 17 : index}> : () -> index
    %207 = "arith.constant"() <{value = 42 : index}> : () -> index
    %208 = "arith.addi"(%206, %arg90) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %209 = "arith.subi"(%208, %207) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%209) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subSub0"}> ({
  ^bb0(%arg88: index, %arg89: index):
    %204 = "arith.subi"(%arg88, %arg89) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %205 = "arith.subi"(%204, %arg88) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%205) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subSub1"}> ({
  ^bb0(%arg86: index, %arg87: index):
    %202 = "arith.subi"(%arg86, %arg87) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %203 = "arith.subi"(%arg86, %202) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%203) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subSub0Ovf"}> ({
  ^bb0(%arg84: index, %arg85: index):
    %200 = "arith.subi"(%arg84, %arg85) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %201 = "arith.subi"(%200, %arg84) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%201) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub0"}> ({
  ^bb0(%arg83: index):
    %196 = "arith.constant"() <{value = 17 : index}> : () -> index
    %197 = "arith.constant"() <{value = 42 : index}> : () -> index
    %198 = "arith.subi"(%196, %arg83) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %199 = "arith.subi"(%197, %198) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%199) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub0Ovf"}> ({
  ^bb0(%arg82: index):
    %192 = "arith.constant"() <{value = 17 : index}> : () -> index
    %193 = "arith.constant"() <{value = 42 : index}> : () -> index
    %194 = "arith.subi"(%192, %arg82) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %195 = "arith.subi"(%193, %194) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%195) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub1"}> ({
  ^bb0(%arg81: index):
    %188 = "arith.constant"() <{value = 17 : index}> : () -> index
    %189 = "arith.constant"() <{value = 42 : index}> : () -> index
    %190 = "arith.subi"(%188, %arg81) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %191 = "arith.subi"(%190, %189) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%191) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub1Ovf"}> ({
  ^bb0(%arg80: index):
    %184 = "arith.constant"() <{value = 17 : index}> : () -> index
    %185 = "arith.constant"() <{value = 42 : index}> : () -> index
    %186 = "arith.subi"(%184, %arg80) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %187 = "arith.subi"(%186, %185) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%187) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub2"}> ({
  ^bb0(%arg79: index):
    %180 = "arith.constant"() <{value = 17 : index}> : () -> index
    %181 = "arith.constant"() <{value = 42 : index}> : () -> index
    %182 = "arith.subi"(%arg79, %180) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %183 = "arith.subi"(%181, %182) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%183) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub2Ovf"}> ({
  ^bb0(%arg78: index):
    %176 = "arith.constant"() <{value = 17 : index}> : () -> index
    %177 = "arith.constant"() <{value = 42 : index}> : () -> index
    %178 = "arith.subi"(%arg78, %176) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %179 = "arith.subi"(%177, %178) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%179) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub3"}> ({
  ^bb0(%arg77: index):
    %172 = "arith.constant"() <{value = 17 : index}> : () -> index
    %173 = "arith.constant"() <{value = 42 : index}> : () -> index
    %174 = "arith.subi"(%arg77, %172) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %175 = "arith.subi"(%174, %173) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%175) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub3Ovf"}> ({
  ^bb0(%arg76: index):
    %168 = "arith.constant"() <{value = 17 : index}> : () -> index
    %169 = "arith.constant"() <{value = 42 : index}> : () -> index
    %170 = "arith.subi"(%arg76, %168) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    %171 = "arith.subi"(%170, %169) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%171) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subAdd1"}> ({
  ^bb0(%arg74: index, %arg75: index):
    %166 = "arith.addi"(%arg74, %arg75) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %167 = "arith.subi"(%166, %arg75) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%167) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subAdd2"}> ({
  ^bb0(%arg72: index, %arg73: index):
    %164 = "arith.addi"(%arg72, %arg73) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %165 = "arith.subi"(%164, %arg72) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%165) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "doubleAddSub1"}> ({
  ^bb0(%arg70: index, %arg71: index):
    %162 = "arith.subi"(%arg70, %arg71) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %163 = "arith.addi"(%162, %arg71) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%163) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "doubleAddSub2"}> ({
  ^bb0(%arg68: index, %arg69: index):
    %160 = "arith.subi"(%arg68, %arg69) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %161 = "arith.addi"(%arg69, %160) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%161) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "nested_muli"}> ({
    %155 = "test.constant"() <{value = 2147483647 : i64}> : () -> i32
    %156 = "test.constant"() <{value = -2147483648 : i64}> : () -> i32
    %157 = "test.constant"() <{value = 2147483648 : i64}> : () -> i32
    %158 = "arith.muli"(%155, %156) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %159 = "arith.muli"(%158, %157) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%159) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleMulIMulIIndex"}> ({
  ^bb0(%arg67: index):
    %151 = "arith.constant"() <{value = 3 : index}> : () -> index
    %152 = "arith.constant"() <{value = 5 : index}> : () -> index
    %153 = "arith.muli"(%arg67, %151) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %154 = "arith.muli"(%153, %152) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%154) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "tripleMulIMulII32"}> ({
  ^bb0(%arg66: i32):
    %147 = "arith.constant"() <{value = -3 : i32}> : () -> i32
    %148 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %149 = "arith.muli"(%arg66, %147) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %150 = "arith.muli"(%149, %148) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%150) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i256) -> i256, sym_name = "tripleMulLargeInt"}> ({
  ^bb0(%arg65: i256):
    %143 = "arith.constant"() <{value = 3618502788666131213697322783095070105623107215331596699973092056135872020481 : i256}> : () -> i256
    %144 = "arith.constant"() <{value = 1 : i256}> : () -> i256
    %145 = "arith.addi"(%arg65, %143) <{overflowFlags = #arith.overflow<none>}> : (i256, i256) -> i256
    %146 = "arith.addi"(%145, %144) <{overflowFlags = #arith.overflow<none>}> : (i256, i256) -> i256
    "func.return"(%146) : (i256) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "addiMuliToSubiRhsI32"}> ({
  ^bb0(%arg63: i32, %arg64: i32):
    %140 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %141 = "arith.muli"(%arg64, %140) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %142 = "arith.addi"(%arg63, %141) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%142) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "addiMuliToSubiRhsIndex"}> ({
  ^bb0(%arg61: index, %arg62: index):
    %137 = "arith.constant"() <{value = -1 : index}> : () -> index
    %138 = "arith.muli"(%arg62, %137) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %139 = "arith.addi"(%arg61, %138) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%139) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> vector<3xi64>, sym_name = "addiMuliToSubiRhsVector"}> ({
  ^bb0(%arg59: vector<3xi64>, %arg60: vector<3xi64>):
    %134 = "arith.constant"() <{value = dense<-1> : vector<3xi64>}> : () -> vector<3xi64>
    %135 = "arith.muli"(%arg60, %134) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    %136 = "arith.addi"(%arg59, %135) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "func.return"(%136) : (vector<3xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "addiMuliToSubiLhsI32"}> ({
  ^bb0(%arg57: i32, %arg58: i32):
    %131 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %132 = "arith.muli"(%arg58, %131) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %133 = "arith.addi"(%132, %arg57) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%133) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "addiMuliToSubiLhsIndex"}> ({
  ^bb0(%arg55: index, %arg56: index):
    %128 = "arith.constant"() <{value = -1 : index}> : () -> index
    %129 = "arith.muli"(%arg56, %128) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %130 = "arith.addi"(%129, %arg55) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%130) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> vector<3xi64>, sym_name = "addiMuliToSubiLhsVector"}> ({
  ^bb0(%arg53: vector<3xi64>, %arg54: vector<3xi64>):
    %125 = "arith.constant"() <{value = dense<-1> : vector<3xi64>}> : () -> vector<3xi64>
    %126 = "arith.muli"(%arg54, %125) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    %127 = "arith.addi"(%126, %arg53) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "func.return"(%127) : (vector<3xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "adduiExtendedZeroRhs"}> ({
  ^bb0(%arg52: i32):
    %123 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %124:2 = "arith.addui_extended"(%arg52, %123) : (i32, i32) -> (i32, i1)
    "func.return"(%124#0, %124#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi1>), sym_name = "adduiExtendedZeroRhsSplat"}> ({
  ^bb0(%arg51: vector<4xi32>):
    %121 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    %122:2 = "arith.addui_extended"(%arg51, %121) : (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi1>)
    "func.return"(%122#0, %122#1) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "adduiExtendedZeroLhs"}> ({
  ^bb0(%arg50: i32):
    %119 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %120:2 = "arith.addui_extended"(%119, %arg50) : (i32, i32) -> (i32, i1)
    "func.return"(%120#0, %120#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "adduiExtendedUnusedOverflowScalar"}> ({
  ^bb0(%arg48: i32, %arg49: i32):
    %118:2 = "arith.addui_extended"(%arg48, %arg49) : (i32, i32) -> (i32, i1)
    "func.return"(%118#0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, vector<3xi32>) -> vector<3xi32>, sym_name = "adduiExtendedUnusedOverflowVector"}> ({
  ^bb0(%arg46: vector<3xi32>, %arg47: vector<3xi32>):
    %117:2 = "arith.addui_extended"(%arg46, %arg47) : (vector<3xi32>, vector<3xi32>) -> (vector<3xi32>, vector<3xi1>)
    "func.return"(%117#0) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedConstants"}> ({
    %114 = "arith.constant"() <{value = 13 : i32}> : () -> i32
    %115 = "arith.constant"() <{value = 37 : i32}> : () -> i32
    %116:2 = "arith.addui_extended"(%114, %115) : (i32, i32) -> (i32, i1)
    "func.return"(%116#0, %116#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedConstantsOverflow1"}> ({
    %111 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %112 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %113:2 = "arith.addui_extended"(%111, %112) : (i32, i32) -> (i32, i1)
    "func.return"(%113#0, %113#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedConstantsOverflow2"}> ({
    %109 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %110:2 = "arith.addui_extended"(%109, %109) : (i32, i32) -> (i32, i1)
    "func.return"(%110#0, %110#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<4xi32>, vector<4xi1>), sym_name = "adduiExtendedConstantsOverflowVector"}> ({
    %106 = "arith.constant"() <{value = dense<[1, 3, 3, 7]> : vector<4xi32>}> : () -> vector<4xi32>
    %107 = "arith.constant"() <{value = dense<[0, 3, -1, 7]> : vector<4xi32>}> : () -> vector<4xi32>
    %108:2 = "arith.addui_extended"(%106, %107) : (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi1>)
    "func.return"(%108#0, %108#1) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<4xi32>, vector<4xi1>), sym_name = "adduiExtendedConstantsSplatVector"}> ({
    %103 = "arith.constant"() <{value = dense<1> : vector<4xi32>}> : () -> vector<4xi32>
    %104 = "arith.constant"() <{value = dense<2> : vector<4xi32>}> : () -> vector<4xi32>
    %105:2 = "arith.addui_extended"(%103, %104) : (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi1>)
    "func.return"(%105#0, %105#1) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedPoisonLhs"}> ({
    %100 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %101 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %102:2 = "arith.addui_extended"(%100, %101) : (i32, i32) -> (i32, i1)
    "func.return"(%102#0, %102#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedPoisonRhs"}> ({
    %97 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %98 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %99:2 = "arith.addui_extended"(%97, %98) : (i32, i32) -> (i32, i1)
    "func.return"(%99#0, %99#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "subuiExtendedZeroRhs"}> ({
  ^bb0(%arg45: i32):
    %95 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %96:2 = "arith.subui_extended"(%arg45, %95) : (i32, i32) -> (i32, i1)
    "func.return"(%96#0, %96#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi1>), sym_name = "subuiExtendedZeroRhsSplat"}> ({
  ^bb0(%arg44: vector<4xi32>):
    %93 = "arith.constant"() <{value = dense<0> : vector<4xi32>}> : () -> vector<4xi32>
    %94:2 = "arith.subui_extended"(%arg44, %93) : (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi1>)
    "func.return"(%94#0, %94#1) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "subuiExtendedSameOperand"}> ({
  ^bb0(%arg43: i32):
    %92:2 = "arith.subui_extended"(%arg43, %arg43) : (i32, i32) -> (i32, i1)
    "func.return"(%92#0, %92#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi1>), sym_name = "subuiExtendedSameOperandVector"}> ({
  ^bb0(%arg42: vector<4xi32>):
    %91:2 = "arith.subui_extended"(%arg42, %arg42) : (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi1>)
    "func.return"(%91#0, %91#1) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "subuiExtendedUnusedBorrowScalar"}> ({
  ^bb0(%arg40: i32, %arg41: i32):
    %90:2 = "arith.subui_extended"(%arg40, %arg41) : (i32, i32) -> (i32, i1)
    "func.return"(%90#0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, vector<3xi32>) -> vector<3xi32>, sym_name = "subuiExtendedUnusedBorrowVector"}> ({
  ^bb0(%arg38: vector<3xi32>, %arg39: vector<3xi32>):
    %89:2 = "arith.subui_extended"(%arg38, %arg39) : (vector<3xi32>, vector<3xi32>) -> (vector<3xi32>, vector<3xi1>)
    "func.return"(%89#0) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "subuiExtendedConstants"}> ({
    %86 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %87 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %88:2 = "arith.subui_extended"(%86, %87) : (i32, i32) -> (i32, i1)
    "func.return"(%88#0, %88#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "subuiExtendedConstantsBorrow"}> ({
    %83 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %84 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %85:2 = "arith.subui_extended"(%83, %84) : (i32, i32) -> (i32, i1)
    "func.return"(%85#0, %85#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<4xi32>, vector<4xi1>), sym_name = "subuiExtendedConstantsBorrowVector"}> ({
    %80 = "arith.constant"() <{value = dense<[1, 3, 3, 7]> : vector<4xi32>}> : () -> vector<4xi32>
    %81 = "arith.constant"() <{value = dense<[0, 3, 4, 7]> : vector<4xi32>}> : () -> vector<4xi32>
    %82:2 = "arith.subui_extended"(%80, %81) : (vector<4xi32>, vector<4xi32>) -> (vector<4xi32>, vector<4xi1>)
    "func.return"(%82#0, %82#1) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "subuiExtendedPoisonLhs"}> ({
    %77 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %78 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %79:2 = "arith.subui_extended"(%77, %78) : (i32, i32) -> (i32, i1)
    "func.return"(%79#0, %79#1) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "subuiExtendedPoisonRhs"}> ({
    %74 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %75 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %76:2 = "arith.subui_extended"(%74, %75) : (i32, i32) -> (i32, i1)
    "func.return"(%76#0, %76#1) : (i32, i1) -> ()
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
  ^bb0(%arg8: i1):
    %12 = "arith.constant"() <{value = true}> : () -> i1
    %13 = "arith.xori"(%arg8, %12) : (i1, i1) -> i1
    %14 = "arith.xori"(%13, %12) : (i1, i1) -> i1
    "func.return"(%14) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "xorOfExtSI"}> ({
  ^bb0(%arg6: i8, %arg7: i8):
    %9 = "arith.extsi"(%arg6) : (i8) -> i64
    %10 = "arith.extsi"(%arg7) : (i8) -> i64
    %11 = "arith.xori"(%9, %10) : (i64, i64) -> i64
    "func.return"(%11) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "xorOfExtUI"}> ({
  ^bb0(%arg4: i8, %arg5: i8):
    %6 = "arith.extui"(%arg4) : (i8) -> i64
    %7 = "arith.extui"(%arg5) : (i8) -> i64
    %8 = "arith.xori"(%6, %7) : (i64, i64) -> i64
    "func.return"(%8) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "xorOfExtUI_nneg_both"}> ({
  ^bb0(%arg2: i8, %arg3: i8):
    %3 = "arith.extui"(%arg2) <{nonNeg}> : (i8) -> i64
    %4 = "arith.extui"(%arg3) <{nonNeg}> : (i8) -> i64
    %5 = "arith.xori"(%3, %4) : (i64, i64) -> i64
    "func.return"(%5) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "xorOfExtUI_nneg_mixed"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %0 = "arith.extui"(%arg0) <{nonNeg}> : (i8) -> i64
    %1 = "arith.extui"(%arg1) : (i8) -> i64
    %2 = "arith.xori"(%0, %1) : (i64, i64) -> i64
    "func.return"(%2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "xorOfXorConstant"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 12 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %2 = "arith.xori"(%arg0, %0) : (i32, i32) -> i32
    %3 = "arith.xori"(%2, %1) : (i32, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "xorOfXorConstantIndex"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 12 : index}> : () -> index
    %1 = "arith.constant"() <{value = 10 : index}> : () -> index
    %2 = "arith.xori"(%arg0, %0) : (index, index) -> index
    %3 = "arith.xori"(%2, %1) : (index, index) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (i32, i32), sym_name = "xorOfXorConstantMultiUse"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 12 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %2 = "arith.xori"(%arg0, %0) : (i32, i32) -> i32
    %3 = "arith.xori"(%2, %1) : (i32, i32) -> i32
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
  ^bb0(%arg3: f16):
    %6 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %7 = "arith.constant"() <{value = -0.000000e+00 : f16}> : () -> f16
    %8 = "arith.constant"() <{value = 1.000000e+00 : f16}> : () -> f16
    %9 = "arith.subf"(%arg3, %6) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    %10 = "arith.subf"(%arg3, %7) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    %11 = "arith.subf"(%6, %8) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    "func.return"(%9, %10, %11) : (f16, f16, f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> f16, sym_name = "test_subf_negzero"}> ({
  ^bb0(%arg2: f16):
    %4 = "arith.constant"() <{value = -0.000000e+00 : f16}> : () -> f16
    %5 = "arith.subf"(%4, %arg2) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    "func.return"(%5) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> f16, sym_name = "test_subf_poszero_no_negf"}> ({
  ^bb0(%arg1: f16):
    %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %3 = "arith.subf"(%2, %arg1) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    "func.return"(%3) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>) -> vector<4xf32>, sym_name = "test_subf_negzero_splat"}> ({
  ^bb0(%arg0: vector<4xf32>):
    %0 = "arith.constant"() <{value = dense<-0.000000e+00> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "arith.subf"(%0, %arg0) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%1) : (vector<4xf32>) -> ()
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
  "func.func"() <{function_type = (f32) -> (f32, f32, f32), sym_name = "test_addf_rounding_mode"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 1.00000012 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    %3 = "arith.addf"(%arg0, %2) <{fastmath = #arith.fastmath<none>, roundingmode = 0 : i32}> : (f32, f32) -> f32
    %4 = "arith.addf"(%0, %1) <{fastmath = #arith.fastmath<none>, roundingmode = 2 : i32}> : (f32, f32) -> f32
    %5 = "arith.addf"(%0, %1) <{fastmath = #arith.fastmath<none>, roundingmode = 1 : i32}> : (f32, f32) -> f32
    "func.return"(%3, %4, %5) : (f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32, f32), sym_name = "test_subf_rounding_mode"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 1.00000012 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.subf"(%arg0, %2) <{fastmath = #arith.fastmath<none>, roundingmode = 1 : i32}> : (f32, f32) -> f32
    %4 = "arith.subf"(%0, %1) <{fastmath = #arith.fastmath<none>, roundingmode = 2 : i32}> : (f32, f32) -> f32
    %5 = "arith.subf"(%0, %1) <{fastmath = #arith.fastmath<none>, roundingmode = 1 : i32}> : (f32, f32) -> f32
    %6 = "arith.constant"() <{value = -0.000000e+00 : f32}> : () -> f32
    %7 = "arith.subf"(%6, %arg0) <{fastmath = #arith.fastmath<none>, roundingmode = 1 : i32}> : (f32, f32) -> f32
    "func.return"(%3, %4, %5, %7) : (f32, f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32), sym_name = "test_mulf_rounding_mode"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 1.00000012 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "arith.mulf"(%arg0, %2) <{fastmath = #arith.fastmath<none>, roundingmode = 2 : i32}> : (f32, f32) -> f32
    %4 = "arith.mulf"(%0, %1) <{fastmath = #arith.fastmath<none>, roundingmode = 2 : i32}> : (f32, f32) -> f32
    %5 = "arith.mulf"(%0, %1) <{fastmath = #arith.fastmath<none>, roundingmode = 1 : i32}> : (f32, f32) -> f32
    "func.return"(%3, %4, %5) : (f32, f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (f32, f32, f32), sym_name = "test_divf_rounding_mode"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %3 = "arith.divf"(%arg0, %2) <{fastmath = #arith.fastmath<none>, roundingmode = 3 : i32}> : (f32, f32) -> f32
    %4 = "arith.divf"(%0, %1) <{fastmath = #arith.fastmath<none>, roundingmode = 2 : i32}> : (f32, f32) -> f32
    %5 = "arith.divf"(%0, %1) <{fastmath = #arith.fastmath<none>, roundingmode = 1 : i32}> : (f32, f32) -> f32
    "func.return"(%3, %4, %5) : (f32, f32, f32) -> ()
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
  "func.func"() <{function_type = () -> f32, sym_name = "test_flush_denormals_const"}> ({
    %0 = "arith.constant"() <{value = 9.999940e-41 : f32}> : () -> f32
    %1 = "arith.flush_denormals"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "test_flush_denormals_idempotent"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.flush_denormals"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    %1 = "arith.flush_denormals"(%0) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
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
    %107 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %108 = "arith.shrsi"(%arg28, %107) : (i64, i64) -> i64
    %109 = "arith.trunci"(%108) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%109) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIExactToTrunciShrUIExact"}> ({
  ^bb0(%arg27: i64):
    %104 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %105 = "arith.shrsi"(%arg27, %104) <{isExact}> : (i64, i64) -> i64
    %106 = "arith.trunci"(%105) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%106) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIToTrunciShrUIBadShiftAmt1"}> ({
  ^bb0(%arg26: i64):
    %101 = "arith.constant"() <{value = 33 : i64}> : () -> i64
    %102 = "arith.shrsi"(%arg26, %101) : (i64, i64) -> i64
    %103 = "arith.trunci"(%102) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%103) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIToTrunciShrUIBadShiftAmt2"}> ({
  ^bb0(%arg25: i64):
    %98 = "arith.constant"() <{value = 31 : i64}> : () -> i64
    %99 = "arith.shrsi"(%arg25, %98) : (i64, i64) -> i64
    %100 = "arith.trunci"(%99) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%100) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "foldShli0"}> ({
  ^bb0(%arg24: i64):
    %96 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %97 = "arith.shli"(%arg24, %96) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%97) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "foldShrui0"}> ({
  ^bb0(%arg23: i64):
    %94 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %95 = "arith.shrui"(%arg23, %94) : (i64, i64) -> i64
    "func.return"(%95) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i64, sym_name = "foldShrsi0"}> ({
  ^bb0(%arg22: i64):
    %92 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %93 = "arith.shrsi"(%arg22, %92) : (i64, i64) -> i64
    "func.return"(%93) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor1"}> ({
  ^bb0(%arg21: i1):
    %89 = "arith.constant"() <{value = true}> : () -> i1
    %90 = "arith.xori"(%arg21, %89) : (i1, i1) -> i1
    %91 = "arith.ori"(%arg21, %90) : (i1, i1) -> i1
    "func.return"(%91) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor2"}> ({
  ^bb0(%arg20: i1):
    %86 = "arith.constant"() <{value = true}> : () -> i1
    %87 = "arith.xori"(%86, %arg20) : (i1, i1) -> i1
    %88 = "arith.ori"(%arg20, %87) : (i1, i1) -> i1
    "func.return"(%88) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor3"}> ({
  ^bb0(%arg19: i1):
    %83 = "arith.constant"() <{value = true}> : () -> i1
    %84 = "arith.xori"(%arg19, %83) : (i1, i1) -> i1
    %85 = "arith.ori"(%84, %arg19) : (i1, i1) -> i1
    "func.return"(%85) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor4"}> ({
  ^bb0(%arg18: i1):
    %80 = "arith.constant"() <{value = true}> : () -> i1
    %81 = "arith.xori"(%80, %arg18) : (i1, i1) -> i1
    %82 = "arith.ori"(%81, %arg18) : (i1, i1) -> i1
    "func.return"(%82) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "foldOrXor5"}> ({
  ^bb0(%arg17: i32):
    %77 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    %78 = "arith.xori"(%arg17, %77) : (i32, i32) -> i32
    %79 = "arith.ori"(%arg17, %78) : (i32, i32) -> i32
    "func.return"(%79) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "foldOrXor6"}> ({
  ^bb0(%arg16: index):
    %74 = "arith.constant"() <{value = -1 : index}> : () -> index
    %75 = "arith.xori"(%arg16, %74) : (index, index) -> index
    %76 = "arith.ori"(%arg16, %75) : (index, index) -> index
    "func.return"(%76) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32) -> (i32, i32, i32, i32), sym_name = "selectOfPoison"}> ({
  ^bb0(%arg14: i1, %arg15: i32):
    %67 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %68 = "arith.select"(%arg14, %67, %arg15) : (i1, i32, i32) -> i32
    %69 = "arith.select"(%arg14, %arg15, %67) : (i1, i32, i32) -> i32
    %70 = "arith.constant"() <{value = true}> : () -> i1
    %71 = "arith.constant"() <{value = false}> : () -> i1
    %72 = "arith.select"(%70, %67, %arg15) : (i1, i32, i32) -> i32
    %73 = "arith.select"(%71, %67, %arg15) : (i1, i32, i32) -> i32
    "func.return"(%68, %69, %72, %73) : (i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "addi_poison1"}> ({
  ^bb0(%arg13: i32):
    %65 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %66 = "arith.addi"(%65, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%66) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "addi_poison2"}> ({
  ^bb0(%arg12: i32):
    %63 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %64 = "arith.addi"(%arg12, %63) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%64) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "addf_poison1"}> ({
  ^bb0(%arg11: f32):
    %61 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %62 = "arith.addf"(%61, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%62) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "addf_poison2"}> ({
  ^bb0(%arg10: f32):
    %59 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %60 = "arith.addf"(%arg10, %59) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%60) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "negf_poison"}> ({
    %57 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %58 = "arith.negf"(%57) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
    "func.return"(%58) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "extsi_poison"}> ({
    %55 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %56 = "arith.extsi"(%55) : (i32) -> i64
    "func.return"(%56) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<i16>, sym_name = "unsignedExtendConstantResource"}> ({
    %53 = "arith.constant"() <{value = dense_resource<blob1> : tensor<i8>}> : () -> tensor<i8>
    %54 = "arith.extui"(%53) : (tensor<i8>) -> tensor<i16>
    "func.return"(%54) : (tensor<i16>) -> ()
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
    %0 = "arith.constant"() <{value = 2.000000e+00 : f8E4M3FN}> : () -> f8E4M3FN
    %1 = "arith.convertf"(%0) : (f8E4M3FN) -> f8E5M2
    "func.return"(%1) : (f8E5M2) -> ()
  }) : () -> ()
}) : () -> ()

