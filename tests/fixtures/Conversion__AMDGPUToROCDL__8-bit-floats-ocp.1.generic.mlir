"builtin.module"() ({
  "func.func"() <{function_type = (f8E5M2) -> f32, sym_name = "ext_scalar"}> ({
  ^bb0(%arg15: f8E5M2):
    %49 = "builtin.unrealized_conversion_cast"(%arg15) : (f8E5M2) -> i8
    %50 = "llvm.mlir.undef"() : () -> vector<4xi8>
    %51 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %52 = "llvm.insertelement"(%50, %49, %51) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %53 = "llvm.bitcast"(%52) : (vector<4xi8>) -> i32
    %54 = "rocdl.cvt.f32.bf8"(%53) <{byteSel = 0 : i32}> : (i32) -> f32
    "func.return"(%54) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>) -> f32, sym_name = "ext_short_vec"}> ({
  ^bb0(%arg14: vector<2xf8E4M3FN>):
    %39 = "builtin.unrealized_conversion_cast"(%arg14) : (vector<2xf8E4M3FN>) -> vector<2xi8>
    %40 = "llvm.mlir.undef"() : () -> vector<4xi8>
    %41 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %42 = "llvm.extractelement"(%39, %41) : (vector<2xi8>, i32) -> i8
    %43 = "llvm.insertelement"(%40, %42, %41) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %44 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %45 = "llvm.extractelement"(%39, %44) : (vector<2xi8>, i32) -> i8
    %46 = "llvm.insertelement"(%43, %45, %44) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %47 = "llvm.bitcast"(%46) : (vector<4xi8>) -> i32
    %48 = "rocdl.cvt.f32.fp8"(%47) <{byteSel = 1 : i32}> : (i32) -> f32
    "func.return"(%48) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>) -> f32, sym_name = "ext_full_vec"}> ({
  ^bb0(%arg13: vector<4xf8E4M3FN>):
    %36 = "builtin.unrealized_conversion_cast"(%arg13) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %37 = "llvm.bitcast"(%36) : (vector<4xi8>) -> i32
    %38 = "rocdl.cvt.f32.fp8"(%37) <{byteSel = 3 : i32}> : (i32) -> f32
    "func.return"(%38) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf8E4M3FN>) -> vector<2xf32>, sym_name = "ext_packed_2xfp8"}> ({
  ^bb0(%arg12: vector<2xf8E4M3FN>):
    %26 = "builtin.unrealized_conversion_cast"(%arg12) : (vector<2xf8E4M3FN>) -> vector<2xi8>
    %27 = "llvm.mlir.undef"() : () -> vector<4xi8>
    %28 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %29 = "llvm.extractelement"(%26, %28) : (vector<2xi8>, i32) -> i8
    %30 = "llvm.insertelement"(%27, %29, %28) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %31 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %32 = "llvm.extractelement"(%26, %31) : (vector<2xi8>, i32) -> i8
    %33 = "llvm.insertelement"(%30, %32, %31) : (vector<4xi8>, i8, i32) -> vector<4xi8>
    %34 = "llvm.bitcast"(%33) : (vector<4xi8>) -> i32
    %35 = "rocdl.cvt.pk.f32.fp8"(%34) <{wordSel = false}> : (i32) -> vector<2xf32>
    "func.return"(%35) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>) -> vector<2xf32>, sym_name = "ext_packed_4xfp8"}> ({
  ^bb0(%arg11: vector<4xf8E4M3FN>):
    %23 = "builtin.unrealized_conversion_cast"(%arg11) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %24 = "llvm.bitcast"(%23) : (vector<4xi8>) -> i32
    %25 = "rocdl.cvt.pk.f32.fp8"(%24) <{wordSel = true}> : (i32) -> vector<2xf32>
    "func.return"(%25) : (vector<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> vector<4xf8E4M3FN>, sym_name = "packed_trunc"}> ({
  ^bb0(%arg10: f32):
    %18 = "llvm.mlir.undef"() : () -> f32
    %19 = "llvm.mlir.undef"() : () -> i32
    %20 = "rocdl.cvt.pk.fp8.f32"(%arg10, %18, %19) <{wordSel = false}> : (f32, f32, i32) -> i32
    %21 = "llvm.bitcast"(%20) : (i32) -> vector<4xi8>
    %22 = "builtin.unrealized_conversion_cast"(%21) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%22) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> vector<4xf8E4M3FN>, sym_name = "packed_truncx2"}> ({
  ^bb0(%arg8: f32, %arg9: f32):
    %14 = "llvm.mlir.undef"() : () -> i32
    %15 = "rocdl.cvt.pk.fp8.f32"(%arg8, %arg9, %14) <{wordSel = false}> : (f32, f32, i32) -> i32
    %16 = "llvm.bitcast"(%15) : (i32) -> vector<4xi8>
    %17 = "builtin.unrealized_conversion_cast"(%16) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%17) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, vector<4xf8E5M2>) -> vector<4xf8E5M2>, sym_name = "packed_truncx2_into"}> ({
  ^bb0(%arg5: f32, %arg6: f32, %arg7: vector<4xf8E5M2>):
    %9 = "builtin.unrealized_conversion_cast"(%arg7) : (vector<4xf8E5M2>) -> vector<4xi8>
    %10 = "llvm.bitcast"(%9) : (vector<4xi8>) -> i32
    %11 = "rocdl.cvt.pk.bf8.f32"(%arg5, %arg6, %10) <{wordSel = true}> : (f32, f32, i32) -> i32
    %12 = "llvm.bitcast"(%11) : (i32) -> vector<4xi8>
    %13 = "builtin.unrealized_conversion_cast"(%12) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%13) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32) -> vector<4xf8E4M3FN>, sym_name = "packed_stoch_round"}> ({
  ^bb0(%arg3: f32, %arg4: i32):
    %5 = "llvm.mlir.undef"() : () -> i32
    %6 = "rocdl.cvt.sr.fp8.f32"(%arg3, %arg4, %5) <{byteSel = 0 : i32}> : (f32, i32, i32) -> i32
    %7 = "llvm.bitcast"(%6) : (i32) -> vector<4xi8>
    %8 = "builtin.unrealized_conversion_cast"(%7) : (vector<4xi8>) -> vector<4xf8E4M3FN>
    "func.return"(%8) : (vector<4xf8E4M3FN>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32, vector<4xf8E5M2>) -> vector<4xf8E5M2>, sym_name = "packed_stoch_round_into"}> ({
  ^bb0(%arg0: f32, %arg1: i32, %arg2: vector<4xf8E5M2>):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (vector<4xf8E5M2>) -> vector<4xi8>
    %1 = "llvm.bitcast"(%0) : (vector<4xi8>) -> i32
    %2 = "rocdl.cvt.sr.bf8.f32"(%arg0, %arg1, %1) <{byteSel = 1 : i32}> : (f32, i32, i32) -> i32
    %3 = "llvm.bitcast"(%2) : (i32) -> vector<4xi8>
    %4 = "builtin.unrealized_conversion_cast"(%3) : (vector<4xi8>) -> vector<4xf8E5M2>
    "func.return"(%4) : (vector<4xf8E5M2>) -> ()
  }) : () -> ()
}) : () -> ()

