"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "test_dpp"}> ({
  ^bb0(%arg24: i32, %arg25: i32):
    %45 = "rocdl.update.dpp"(%arg24, %arg25) <{bankMask = 15 : i32, boundCtrl = false, dppCtrl = 257 : i32, rowMask = 10 : i32}> : (i32, i32) -> i32
    "func.return"(%45) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "quad_dpp"}> ({
  ^bb0(%arg22: i32, %arg23: i32):
    %44 = "rocdl.update.dpp"(%arg22, %arg23) <{bankMask = 1 : i32, boundCtrl = true, dppCtrl = 145 : i32, rowMask = 1 : i32}> : (i32, i32) -> i32
    "func.return"(%44) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "wave_shr_dpp"}> ({
  ^bb0(%arg20: i32, %arg21: i32):
    %43 = "rocdl.update.dpp"(%arg20, %arg21) <{bankMask = 1 : i32, boundCtrl = true, dppCtrl = 312 : i32, rowMask = 10 : i32}> : (i32, i32) -> i32
    "func.return"(%43) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "row_half_mirror_update_dpp"}> ({
  ^bb0(%arg18: i32, %arg19: i32):
    %42 = "rocdl.update.dpp"(%arg18, %arg19) <{bankMask = 1 : i32, boundCtrl = false, dppCtrl = 321 : i32, rowMask = 15 : i32}> : (i32, i32) -> i32
    "func.return"(%42) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "wave_rol_update_dpp"}> ({
  ^bb0(%arg16: i32, %arg17: i32):
    %41 = "rocdl.update.dpp"(%arg16, %arg17) <{bankMask = 1 : i32, boundCtrl = false, dppCtrl = 308 : i32, rowMask = 10 : i32}> : (i32, i32) -> i32
    "func.return"(%41) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "row_bcast_dpp_f32"}> ({
  ^bb0(%arg14: f32, %arg15: f32):
    %40 = "rocdl.update.dpp"(%arg14, %arg15) <{bankMask = 15 : i32, boundCtrl = true, dppCtrl = 322 : i32, rowMask = 15 : i32}> : (f32, f32) -> f32
    "func.return"(%40) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "test_dpp_f32"}> ({
  ^bb0(%arg12: f32, %arg13: f32):
    %39 = "rocdl.update.dpp"(%arg12, %arg13) <{bankMask = 4 : i32, boundCtrl = true, dppCtrl = 320 : i32, rowMask = 1 : i32}> : (f32, f32) -> f32
    "func.return"(%39) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "quad_perm_update_dpp_f32"}> ({
  ^bb0(%arg10: f32, %arg11: f32):
    %38 = "rocdl.update.dpp"(%arg10, %arg11) <{bankMask = 1 : i32, boundCtrl = false, dppCtrl = 88 : i32, rowMask = 15 : i32}> : (f32, f32) -> f32
    "func.return"(%38) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i64, i64) -> i64, sym_name = "quad_perm_dpp"}> ({
  ^bb0(%arg8: i64, %arg9: i64):
    %37 = "rocdl.update.dpp"(%arg8, %arg9) <{bankMask = 15 : i32, boundCtrl = false, dppCtrl = 88 : i32, rowMask = 15 : i32}> : (i64, i64) -> i64
    "func.return"(%37) : (i64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f64, f64) -> f64, sym_name = "row_bcast_dpp"}> ({
  ^bb0(%arg6: f64, %arg7: f64):
    %36 = "rocdl.update.dpp"(%arg6, %arg7) <{bankMask = 1 : i32, boundCtrl = false, dppCtrl = 323 : i32, rowMask = 4 : i32}> : (f64, f64) -> f64
    "func.return"(%36) : (f64) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, f16) -> f16, sym_name = "test_dpp_f16"}> ({
  ^bb0(%arg4: f16, %arg5: f16):
    %23 = "llvm.bitcast"(%arg5) : (f16) -> i16
    %24 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %25 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %26 = "llvm.insertelement"(%24, %23, %25) : (vector<2xi16>, i16, i32) -> vector<2xi16>
    %27 = "llvm.bitcast"(%26) : (vector<2xi16>) -> i32
    %28 = "llvm.bitcast"(%arg4) : (f16) -> i16
    %29 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %30 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %31 = "llvm.insertelement"(%29, %28, %30) : (vector<2xi16>, i16, i32) -> vector<2xi16>
    %32 = "llvm.bitcast"(%31) : (vector<2xi16>) -> i32
    %33 = "rocdl.update.dpp"(%32, %27) <{bankMask = 3 : i32, boundCtrl = false, dppCtrl = 273 : i32, rowMask = 15 : i32}> : (i32, i32) -> i32
    %34 = "llvm.trunc"(%33) <{overflowFlags = 0 : i32}> : (i32) -> i16
    %35 = "llvm.bitcast"(%34) : (i16) -> f16
    "func.return"(%35) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i16, i16) -> i16, sym_name = "row_shl_dpp_i16"}> ({
  ^bb0(%arg2: i16, %arg3: i16):
    %13 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %14 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %15 = "llvm.insertelement"(%13, %arg3, %14) : (vector<2xi16>, i16, i32) -> vector<2xi16>
    %16 = "llvm.bitcast"(%15) : (vector<2xi16>) -> i32
    %17 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %18 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %19 = "llvm.insertelement"(%17, %arg2, %18) : (vector<2xi16>, i16, i32) -> vector<2xi16>
    %20 = "llvm.bitcast"(%19) : (vector<2xi16>) -> i32
    %21 = "rocdl.update.dpp"(%20, %16) <{bankMask = 1 : i32, boundCtrl = false, dppCtrl = 298 : i32, rowMask = 10 : i32}> : (i32, i32) -> i32
    %22 = "llvm.trunc"(%21) <{overflowFlags = 0 : i32}> : (i32) -> i16
    "func.return"(%22) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, f16) -> f16, sym_name = "row_bcast_update_dpp_f16"}> ({
  ^bb0(%arg0: f16, %arg1: f16):
    %0 = "llvm.bitcast"(%arg1) : (f16) -> i16
    %1 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %2 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "llvm.insertelement"(%1, %0, %2) : (vector<2xi16>, i16, i32) -> vector<2xi16>
    %4 = "llvm.bitcast"(%3) : (vector<2xi16>) -> i32
    %5 = "llvm.bitcast"(%arg0) : (f16) -> i16
    %6 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %7 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %8 = "llvm.insertelement"(%6, %5, %7) : (vector<2xi16>, i16, i32) -> vector<2xi16>
    %9 = "llvm.bitcast"(%8) : (vector<2xi16>) -> i32
    %10 = "rocdl.update.dpp"(%9, %4) <{bankMask = 15 : i32, boundCtrl = true, dppCtrl = 322 : i32, rowMask = 15 : i32}> : (i32, i32) -> i32
    %11 = "llvm.trunc"(%10) <{overflowFlags = 0 : i32}> : (i32) -> i16
    %12 = "llvm.bitcast"(%11) : (i16) -> f16
    "func.return"(%12) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

