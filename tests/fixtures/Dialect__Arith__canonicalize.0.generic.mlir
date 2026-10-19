"builtin.module"() ({
  "func.func"() <{function_type = (i1, i64) -> i64, sym_name = "select_same_val"}> ({
  ^bb0(%arg36: i1, %arg37: i64):
    "func.return"(%arg37) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "select_cmp_eq_select"}> ({
  ^bb0(%arg34: i64, %arg35: i64):
    "func.return"(%arg35) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "select_cmp_ne_select"}> ({
  ^bb0(%arg32: i64, %arg33: i64):
    "func.return"(%arg32) : (i64) -> ()
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
  ^bb0(%arg2: i1):
    %2 = "arith.extui"(%arg2) : (i1) -> i64
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
  ^bb0(%arg6: i8, %arg7: i8):
    %6 = "arith.andi"(%arg6, %arg7) : (i8, i8) -> i8
    %7 = "arith.extsi"(%6) : (i8) -> i64
    "func.return"(%7) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "andOfExtUI"}> ({
  ^bb0(%arg4: i8, %arg5: i8):
    %4 = "arith.andi"(%arg4, %arg5) : (i8, i8) -> i8
    %5 = "arith.extui"(%4) : (i8) -> i64
    "func.return"(%5) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "orOfExtSI"}> ({
  ^bb0(%arg2: i8, %arg3: i8):
    %2 = "arith.ori"(%arg2, %arg3) : (i8, i8) -> i8
    %3 = "arith.extsi"(%2) : (i8) -> i64
    "func.return"(%3) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "orOfExtUI"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %0 = "arith.ori"(%arg0, %arg1) : (i8, i8) -> i8
    %1 = "arith.extui"(%0) : (i8) -> i64
    "func.return"(%1) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i8) -> index, sym_name = "indexCastOfSignExtend"}> ({
  ^bb0(%arg111: i8):
    %163 = "arith.index_cast"(%arg111) : (i8) -> index
    "func.return"(%163) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> index, sym_name = "indexCastUIOfUnsignedExtend"}> ({
  ^bb0(%arg110: i8):
    %162 = "arith.index_castui"(%arg110) : (i8) -> index
    "func.return"(%162) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "indexCastFold"}> ({
    %161 = "arith.constant"() <{value = -2 : index}> : () -> index
    "func.return"(%161) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "indexCastFoldIndexToInt"}> ({
    %160 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%160) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastFoldSplatVector"}> ({
    %159 = "arith.constant"() <{value = dense<42> : vector<3xindex>}> : () -> vector<3xindex>
    "func.return"(%159) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastFoldVector"}> ({
    %158 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xindex>}> : () -> vector<3xindex>
    "func.return"(%158) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastFoldSplatVectorIndexToInt"}> ({
    %157 = "arith.constant"() <{value = dense<42> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%157) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastFoldVectorIndexToInt"}> ({
    %156 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%156) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "indexCastUIFold"}> ({
    %155 = "arith.constant"() <{value = 254 : index}> : () -> index
    "func.return"(%155) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastUIFoldSplatVector"}> ({
    %154 = "arith.constant"() <{value = dense<42> : vector<3xindex>}> : () -> vector<3xindex>
    "func.return"(%154) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xindex>, sym_name = "indexCastUIFoldVector"}> ({
    %153 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xindex>}> : () -> vector<3xindex>
    "func.return"(%153) : (vector<3xindex>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "indexCastUIFoldIndexToInt"}> ({
    %152 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%152) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastUIFoldSplatVectorIndexToInt"}> ({
    %151 = "arith.constant"() <{value = dense<42> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%151) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<3xi32>, sym_name = "indexCastUIFoldVectorIndexToInt"}> ({
    %150 = "arith.constant"() <{value = dense<[1, 2, 3]> : vector<3xi32>}> : () -> vector<3xi32>
    "func.return"(%150) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "signExtendConstant"}> ({
    %149 = "arith.constant"() <{value = -2 : i16}> : () -> i16
    "func.return"(%149) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "signExtendConstantSplat"}> ({
    %148 = "arith.constant"() <{value = dense<-2> : vector<4xi16>}> : () -> vector<4xi16>
    "func.return"(%148) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "signExtendConstantVector"}> ({
    %147 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi16>}> : () -> vector<4xi16>
    "func.return"(%147) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "unsignedExtendConstant"}> ({
    %146 = "arith.constant"() <{value = 2 : i16}> : () -> i16
    "func.return"(%146) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "unsignedExtendConstantSplat"}> ({
    %145 = "arith.constant"() <{value = dense<2> : vector<4xi16>}> : () -> vector<4xi16>
    "func.return"(%145) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi16>, sym_name = "unsignedExtendConstantVector"}> ({
    %144 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi16>}> : () -> vector<4xi16>
    "func.return"(%144) : (vector<4xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f64, sym_name = "extFPConstant"}> ({
    %143 = "arith.constant"() <{value = 1.000000e+00 : f64}> : () -> f64
    "func.return"(%143) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<2xf128>, sym_name = "extFPVectorConstant"}> ({
    %142 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00]> : vector<2xf128>}> : () -> vector<2xf128>
    "func.return"(%142) : (vector<2xf128>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "truncExtf"}> ({
  ^bb0(%arg109: f32):
    "func.return"(%arg109) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> bf16, sym_name = "truncExtf1"}> ({
  ^bb0(%arg108: bf16):
    "func.return"(%arg108) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (bf16) -> f16, sym_name = "truncExtf2"}> ({
  ^bb0(%arg107: bf16):
    %140 = "arith.extf"(%arg107) : (bf16) -> f32
    %141 = "arith.truncf"(%140) : (f32) -> f16
    "func.return"(%141) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f16, sym_name = "truncExtf3"}> ({
  ^bb0(%arg106: f32):
    %139 = "arith.truncf"(%arg106) : (f32) -> f16
    "func.return"(%139) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "truncSitofp"}> ({
  ^bb0(%arg105: i32):
    %138 = "arith.sitofp"(%arg105) : (i32) -> f32
    "func.return"(%138) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> f32, sym_name = "truncSitofpConstrained"}> ({
  ^bb0(%arg104: i32):
    %136 = "arith.sitofp"(%arg104) : (i32) -> f64
    %137 = "arith.truncf"(%136) <{roundingmode = 0 : i32}> : (f64) -> f32
    "func.return"(%137) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncConstant"}> ({
  ^bb0(%arg103: i8):
    %135 = "arith.constant"() <{value = -2 : i16}> : () -> i16
    "func.return"(%135) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "truncExtui"}> ({
  ^bb0(%arg102: i32):
    "func.return"(%arg102) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i16, sym_name = "truncExtui2"}> ({
  ^bb0(%arg101: i32):
    %134 = "arith.trunci"(%arg101) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i16
    "func.return"(%134) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncExtui3"}> ({
  ^bb0(%arg100: i8):
    %133 = "arith.extui"(%arg100) : (i8) -> i16
    "func.return"(%133) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi16>, sym_name = "truncExtuiVector"}> ({
  ^bb0(%arg99: vector<2xi32>):
    %132 = "arith.trunci"(%arg99) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi32>) -> vector<2xi16>
    "func.return"(%132) : (vector<2xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "truncExtsi"}> ({
  ^bb0(%arg98: i32):
    "func.return"(%arg98) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i16, sym_name = "truncExtsi2"}> ({
  ^bb0(%arg97: i32):
    %131 = "arith.trunci"(%arg97) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i16
    "func.return"(%131) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8) -> i16, sym_name = "truncExtsi3"}> ({
  ^bb0(%arg96: i8):
    %130 = "arith.extsi"(%arg96) : (i8) -> i16
    "func.return"(%130) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi16>, sym_name = "truncExtsiVector"}> ({
  ^bb0(%arg95: vector<2xi32>):
    %129 = "arith.trunci"(%arg95) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi32>) -> vector<2xi16>
    "func.return"(%129) : (vector<2xi16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi8>, sym_name = "truncConstantSplat"}> ({
    %128 = "arith.constant"() <{value = dense<-2> : vector<4xi8>}> : () -> vector<4xi8>
    "func.return"(%128) : (vector<4xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<4xi8>, sym_name = "truncConstantVector"}> ({
    %127 = "arith.constant"() <{value = dense<[1, 3, 5, 7]> : vector<4xi8>}> : () -> vector<4xi8>
    "func.return"(%127) : (vector<4xi8>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i8, sym_name = "truncTrunc"}> ({
  ^bb0(%arg94: i64):
    %126 = "arith.trunci"(%arg94) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i8
    "func.return"(%126) : (i8) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPConstant"}> ({
    %125 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    "func.return"(%125) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPToNearestEvenConstant"}> ({
    %124 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    "func.return"(%124) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPDownwardConstant"}> ({
    %123 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    "func.return"(%123) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPUpwardConstant"}> ({
    %122 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    "func.return"(%122) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPTowardZeroConstant"}> ({
    %121 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    "func.return"(%121) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPToNearestAwayConstant"}> ({
    %120 = "arith.constant"() <{value = 1.000000e+00 : bf16}> : () -> bf16
    "func.return"(%120) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> vector<2xbf16>, sym_name = "truncFPVectorConstant"}> ({
    %119 = "arith.constant"() <{value = dense<[0.000000e+00, 1.000000e+00]> : vector<2xbf16>}> : () -> vector<2xbf16>
    "func.return"(%119) : (vector<2xbf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> bf16, sym_name = "truncFPConstantRounding"}> ({
    %117 = "arith.constant"() <{value = 1.444000e+25 : f32}> : () -> f32
    %118 = "arith.truncf"(%117) : (f32) -> bf16
    "func.return"(%118) : (bf16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddAdd"}> ({
  ^bb0(%arg93: index):
    %115 = "arith.constant"() <{value = 59 : index}> : () -> index
    %116 = "arith.addi"(%arg93, %115) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%116) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddAddOvf1"}> ({
  ^bb0(%arg92: index):
    %113 = "arith.constant"() <{value = 59 : index}> : () -> index
    %114 = "arith.addi"(%arg92, %113) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%114) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddAddOvf2"}> ({
  ^bb0(%arg91: index):
    %111 = "arith.constant"() <{value = 59 : index}> : () -> index
    %112 = "arith.addi"(%arg91, %111) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%112) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<10xi32>, tensor<?x?xi32>) -> (tensor<10xi32>, tensor<?x?xi32>), sym_name = "foldSubXX_tensor"}> ({
  ^bb0(%arg89: tensor<10xi32>, %arg90: tensor<?x?xi32>):
    %109 = "arith.constant"() <{value = dense<0> : tensor<10xi32>}> : () -> tensor<10xi32>
    %110 = "arith.subi"(%arg90, %arg90) <{overflowFlags = #arith.overflow<none>}> : (tensor<?x?xi32>, tensor<?x?xi32>) -> tensor<?x?xi32>
    "func.return"(%109, %110) : (tensor<10xi32>, tensor<?x?xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xi32>, vector<[4]xi32>) -> (vector<8xi32>, vector<[4]xi32>), sym_name = "foldSubXX_vector"}> ({
  ^bb0(%arg87: vector<8xi32>, %arg88: vector<[4]xi32>):
    %107 = "arith.constant"() <{value = dense<0> : vector<8xi32>}> : () -> vector<8xi32>
    %108 = "arith.constant"() <{value = dense<0> : vector<[4]xi32>}> : () -> vector<[4]xi32>
    "func.return"(%107, %108) : (vector<8xi32>, vector<[4]xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub0"}> ({
  ^bb0(%arg86: index):
    %105 = "arith.constant"() <{value = 59 : index}> : () -> index
    %106 = "arith.subi"(%105, %arg86) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%106) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub0Ovf"}> ({
  ^bb0(%arg85: index):
    %103 = "arith.constant"() <{value = 59 : index}> : () -> index
    %104 = "arith.subi"(%103, %arg85) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%104) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub1"}> ({
  ^bb0(%arg84: index):
    %101 = "arith.constant"() <{value = 25 : index}> : () -> index
    %102 = "arith.addi"(%arg84, %101) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%102) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleAddSub1Ovf"}> ({
  ^bb0(%arg83: index):
    %99 = "arith.constant"() <{value = 25 : index}> : () -> index
    %100 = "arith.addi"(%arg83, %99) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%100) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubAdd0"}> ({
  ^bb0(%arg82: index):
    %97 = "arith.constant"() <{value = 25 : index}> : () -> index
    %98 = "arith.subi"(%97, %arg82) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%98) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubAdd0Ovf"}> ({
  ^bb0(%arg81: index):
    %95 = "arith.constant"() <{value = 25 : index}> : () -> index
    %96 = "arith.subi"(%95, %arg81) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%96) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubAdd1"}> ({
  ^bb0(%arg80: index):
    %93 = "arith.constant"() <{value = -25 : index}> : () -> index
    %94 = "arith.addi"(%arg80, %93) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%94) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subSub0"}> ({
  ^bb0(%arg78: index, %arg79: index):
    %91 = "arith.constant"() <{value = 0 : index}> : () -> index
    %92 = "arith.subi"(%91, %arg79) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%92) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subSub0Ovf"}> ({
  ^bb0(%arg76: index, %arg77: index):
    %89 = "arith.constant"() <{value = 0 : index}> : () -> index
    %90 = "arith.subi"(%89, %arg77) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%90) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub0"}> ({
  ^bb0(%arg75: index):
    %87 = "arith.constant"() <{value = 25 : index}> : () -> index
    %88 = "arith.addi"(%arg75, %87) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%88) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub0Ovf"}> ({
  ^bb0(%arg74: index):
    %85 = "arith.constant"() <{value = 25 : index}> : () -> index
    %86 = "arith.addi"(%arg74, %85) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%86) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub1"}> ({
  ^bb0(%arg73: index):
    %83 = "arith.constant"() <{value = -25 : index}> : () -> index
    %84 = "arith.subi"(%83, %arg73) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%84) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub1Ovf"}> ({
  ^bb0(%arg72: index):
    %81 = "arith.constant"() <{value = -25 : index}> : () -> index
    %82 = "arith.subi"(%81, %arg72) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%82) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub2"}> ({
  ^bb0(%arg71: index):
    %79 = "arith.constant"() <{value = 59 : index}> : () -> index
    %80 = "arith.subi"(%79, %arg71) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%80) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub2Ovf"}> ({
  ^bb0(%arg70: index):
    %77 = "arith.constant"() <{value = 59 : index}> : () -> index
    %78 = "arith.subi"(%77, %arg70) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%78) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub3"}> ({
  ^bb0(%arg69: index):
    %75 = "arith.constant"() <{value = 59 : index}> : () -> index
    %76 = "arith.subi"(%arg69, %75) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%76) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleSubSub3Ovf"}> ({
  ^bb0(%arg68: index):
    %73 = "arith.constant"() <{value = 59 : index}> : () -> index
    %74 = "arith.subi"(%arg68, %73) <{overflowFlags = #arith.overflow<nsw, nuw>}> : (index, index) -> index
    "func.return"(%74) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subAdd1"}> ({
  ^bb0(%arg66: index, %arg67: index):
    "func.return"(%arg66) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "subAdd2"}> ({
  ^bb0(%arg64: index, %arg65: index):
    "func.return"(%arg65) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "doubleAddSub1"}> ({
  ^bb0(%arg62: index, %arg63: index):
    "func.return"(%arg62) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "doubleAddSub2"}> ({
  ^bb0(%arg60: index, %arg61: index):
    "func.return"(%arg60) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "nested_muli"}> ({
    %68 = "test.constant"() <{value = 2147483647 : i64}> : () -> i32
    %69 = "test.constant"() <{value = -2147483648 : i64}> : () -> i32
    %70 = "test.constant"() <{value = 2147483648 : i64}> : () -> i32
    %71 = "arith.muli"(%68, %69) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %72 = "arith.muli"(%71, %70) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%72) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "tripleMulIMulIIndex"}> ({
  ^bb0(%arg59: index):
    %66 = "arith.constant"() <{value = 15 : index}> : () -> index
    %67 = "arith.muli"(%arg59, %66) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%67) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "tripleMulIMulII32"}> ({
  ^bb0(%arg58: i32):
    %64 = "arith.constant"() <{value = -21 : i32}> : () -> i32
    %65 = "arith.muli"(%arg58, %64) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%65) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i256) -> i256, sym_name = "tripleMulLargeInt"}> ({
  ^bb0(%arg57: i256):
    %62 = "arith.constant"() <{value = 3618502788666131213697322783095070105623107215331596699973092056135872020482 : i256}> : () -> i256
    %63 = "arith.addi"(%arg57, %62) <{overflowFlags = #arith.overflow<none>}> : (i256, i256) -> i256
    "func.return"(%63) : (i256) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "addiMuliToSubiRhsI32"}> ({
  ^bb0(%arg55: i32, %arg56: i32):
    %61 = "arith.subi"(%arg55, %arg56) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%61) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "addiMuliToSubiRhsIndex"}> ({
  ^bb0(%arg53: index, %arg54: index):
    %60 = "arith.subi"(%arg53, %arg54) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%60) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> vector<3xi64>, sym_name = "addiMuliToSubiRhsVector"}> ({
  ^bb0(%arg51: vector<3xi64>, %arg52: vector<3xi64>):
    %59 = "arith.subi"(%arg51, %arg52) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "func.return"(%59) : (vector<3xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "addiMuliToSubiLhsI32"}> ({
  ^bb0(%arg49: i32, %arg50: i32):
    %58 = "arith.subi"(%arg49, %arg50) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%58) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> index, sym_name = "addiMuliToSubiLhsIndex"}> ({
  ^bb0(%arg47: index, %arg48: index):
    %57 = "arith.subi"(%arg47, %arg48) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    "func.return"(%57) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi64>, vector<3xi64>) -> vector<3xi64>, sym_name = "addiMuliToSubiLhsVector"}> ({
  ^bb0(%arg45: vector<3xi64>, %arg46: vector<3xi64>):
    %56 = "arith.subi"(%arg45, %arg46) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi64>, vector<3xi64>) -> vector<3xi64>
    "func.return"(%56) : (vector<3xi64>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "adduiExtendedZeroRhs"}> ({
  ^bb0(%arg44: i32):
    %55 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%arg44, %55) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi32>) -> (vector<4xi32>, vector<4xi1>), sym_name = "adduiExtendedZeroRhsSplat"}> ({
  ^bb0(%arg43: vector<4xi32>):
    %54 = "arith.constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%arg43, %54) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (i32, i1), sym_name = "adduiExtendedZeroLhs"}> ({
  ^bb0(%arg42: i32):
    %53 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%arg42, %53) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "adduiExtendedUnusedOverflowScalar"}> ({
  ^bb0(%arg40: i32, %arg41: i32):
    %52 = "arith.addi"(%arg40, %arg41) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%52) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<3xi32>, vector<3xi32>) -> vector<3xi32>, sym_name = "adduiExtendedUnusedOverflowVector"}> ({
  ^bb0(%arg38: vector<3xi32>, %arg39: vector<3xi32>):
    %51 = "arith.addi"(%arg38, %arg39) <{overflowFlags = #arith.overflow<none>}> : (vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    "func.return"(%51) : (vector<3xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedConstants"}> ({
    %49 = "arith.constant"() <{value = 50 : i32}> : () -> i32
    %50 = "arith.constant"() <{value = false}> : () -> i1
    "func.return"(%49, %50) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedConstantsOverflow1"}> ({
    %47 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %48 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%47, %48) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i1), sym_name = "adduiExtendedConstantsOverflow2"}> ({
    %45 = "arith.constant"() <{value = -2 : i32}> : () -> i32
    %46 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%45, %46) : (i32, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<4xi32>, vector<4xi1>), sym_name = "adduiExtendedConstantsOverflowVector"}> ({
    %43 = "arith.constant"() <{value = dense<[1, 6, 2, 14]> : vector<4xi32>}> : () -> vector<4xi32>
    %44 = "arith.constant"() <{value = dense<[false, false, true, false]> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%43, %44) : (vector<4xi32>, vector<4xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (vector<4xi32>, vector<4xi1>), sym_name = "adduiExtendedConstantsSplatVector"}> ({
    %41 = "arith.constant"() <{value = dense<3> : vector<4xi32>}> : () -> vector<4xi32>
    %42 = "arith.constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%41, %42) : (vector<4xi32>, vector<4xi1>) -> ()
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
  ^bb0(%arg4: i1):
    "func.return"(%arg4) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "xorOfExtSI"}> ({
  ^bb0(%arg2: i8, %arg3: i8):
    %2 = "arith.xori"(%arg2, %arg3) : (i8, i8) -> i8
    %3 = "arith.extsi"(%2) : (i8) -> i64
    "func.return"(%3) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, i8) -> i64, sym_name = "xorOfExtUI"}> ({
  ^bb0(%arg0: i8, %arg1: i8):
    %0 = "arith.xori"(%arg0, %arg1) : (i8, i8) -> i8
    %1 = "arith.extui"(%0) : (i8) -> i64
    "func.return"(%1) : (i64) -> ()
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
  ^bb0(%arg0: f16):
    %0 = "arith.constant"() <{value = -1.000000e+00 : f16}> : () -> f16
    %1 = "arith.constant"() <{value = -0.000000e+00 : f16}> : () -> f16
    %2 = "arith.subf"(%arg0, %1) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
    "func.return"(%arg0, %2, %0) : (f16, f16, f16) -> ()
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
    %65 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %66 = "arith.shrui"(%arg28, %65) : (i64, i64) -> i64
    %67 = "arith.trunci"(%66) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%67) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIExactToTrunciShrUIExact"}> ({
  ^bb0(%arg27: i64):
    %62 = "arith.constant"() <{value = 32 : i64}> : () -> i64
    %63 = "arith.shrui"(%arg27, %62) <{isExact}> : (i64, i64) -> i64
    %64 = "arith.trunci"(%63) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%64) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIToTrunciShrUIBadShiftAmt1"}> ({
  ^bb0(%arg26: i64):
    %59 = "arith.constant"() <{value = 33 : i64}> : () -> i64
    %60 = "arith.shrsi"(%arg26, %59) : (i64, i64) -> i64
    %61 = "arith.trunci"(%60) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%61) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64) -> i32, sym_name = "truncIShrSIToTrunciShrUIBadShiftAmt2"}> ({
  ^bb0(%arg25: i64):
    %56 = "arith.constant"() <{value = 31 : i64}> : () -> i64
    %57 = "arith.shrsi"(%arg25, %56) : (i64, i64) -> i64
    %58 = "arith.trunci"(%57) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
    "func.return"(%58) : (i32) -> ()
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
    %55 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%55) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor2"}> ({
  ^bb0(%arg20: i1):
    %54 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%54) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor3"}> ({
  ^bb0(%arg19: i1):
    %53 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%53) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i1, sym_name = "foldOrXor4"}> ({
  ^bb0(%arg18: i1):
    %52 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%52) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "foldOrXor5"}> ({
  ^bb0(%arg17: i32):
    %51 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    "func.return"(%51) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "foldOrXor6"}> ({
  ^bb0(%arg16: index):
    %50 = "arith.constant"() <{value = -1 : index}> : () -> index
    "func.return"(%50) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32) -> (i32, i32, i32, i32), sym_name = "selectOfPoison"}> ({
  ^bb0(%arg14: i1, %arg15: i32):
    %49 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    "func.return"(%arg15, %arg15, %49, %arg15) : (i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "addi_poison1"}> ({
  ^bb0(%arg13: i32):
    %48 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    "func.return"(%48) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "addi_poison2"}> ({
  ^bb0(%arg12: i32):
    %47 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    "func.return"(%47) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "addf_poison1"}> ({
  ^bb0(%arg11: f32):
    %46 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    "func.return"(%46) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "addf_poison2"}> ({
  ^bb0(%arg10: f32):
    %45 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    "func.return"(%45) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> f32, sym_name = "negf_poison"}> ({
    %44 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    "func.return"(%44) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i64, sym_name = "extsi_poison"}> ({
    %43 = "ub.poison"() <{value = #ub.poison}> : () -> i64
    "func.return"(%43) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> tensor<i16>, sym_name = "unsignedExtendConstantResource"}> ({
    %41 = "arith.constant"() <{value = dense_resource<blob1> : tensor<i8>}> : () -> tensor<i8>
    %42 = "arith.extui"(%41) : (tensor<i8>) -> tensor<i16>
    "func.return"(%42) : (tensor<i16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "extsi_i0"}> ({
    %40 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    "func.return"(%40) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i16, sym_name = "extui_i0"}> ({
    %39 = "arith.constant"() <{value = 0 : i16}> : () -> i16
    "func.return"(%39) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i0, sym_name = "trunc_i0"}> ({
    %38 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    "func.return"(%38) : (i0) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i0, sym_name = "shli_i0"}> ({
    %37 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    "func.return"(%37) : (i0) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i0, sym_name = "shrsi_i0"}> ({
    %36 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    "func.return"(%36) : (i0) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i0, sym_name = "shrui_i0"}> ({
    %35 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    "func.return"(%35) : (i0) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i0, sym_name = "maxsi_i0"}> ({
    %34 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    "func.return"(%34) : (i0) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i0, sym_name = "minsi_i0"}> ({
    %33 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    "func.return"(%33) : (i0) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i0, i0), sym_name = "mulsi_extended_i0"}> ({
    %32 = "arith.constant"() <{value = 0 : i0}> : () -> i0
    "func.return"(%32, %32) : (i0, i0) -> ()
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

