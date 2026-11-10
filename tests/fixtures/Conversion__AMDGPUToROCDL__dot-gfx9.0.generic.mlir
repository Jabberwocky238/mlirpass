"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf16>, f32) -> f32, sym_name = "dot_fdot2"}> ({
  ^bb0(%arg21: vector<2xf16>, %arg22: vector<2xf16>, %arg23: f32):
    %15 = "rocdl.fdot2"(%arg21, %arg22, %arg23) <{clamp = false}> : (vector<2xf16>, vector<2xf16>, f32) -> f32
    "func.return"(%15) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf16>, vector<2xf16>, f32) -> f32, sym_name = "dot_fdot2_clamp"}> ({
  ^bb0(%arg18: vector<2xf16>, %arg19: vector<2xf16>, %arg20: f32):
    %14 = "rocdl.fdot2"(%arg18, %arg19, %arg20) <{clamp = true}> : (vector<2xf16>, vector<2xf16>, f32) -> f32
    "func.return"(%14) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi16>, vector<2xi16>, i32) -> i32, sym_name = "dot_sdot2"}> ({
  ^bb0(%arg15: vector<2xi16>, %arg16: vector<2xi16>, %arg17: i32):
    %13 = "rocdl.sdot2"(%arg15, %arg16, %arg17) <{clamp = false}> : (vector<2xi16>, vector<2xi16>, i32) -> i32
    "func.return"(%13) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi16>, vector<2xi16>, i32) -> i32, sym_name = "dot_udot2_clamp"}> ({
  ^bb0(%arg12: vector<2xi16>, %arg13: vector<2xi16>, %arg14: i32):
    %12 = "rocdl.udot2"(%arg12, %arg13, %arg14) <{clamp = true}> : (vector<2xi16>, vector<2xi16>, i32) -> i32
    "func.return"(%12) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi8>, vector<4xi8>, i32) -> i32, sym_name = "dot_sdot4"}> ({
  ^bb0(%arg9: vector<4xi8>, %arg10: vector<4xi8>, %arg11: i32):
    %9 = "llvm.bitcast"(%arg9) : (vector<4xi8>) -> i32
    %10 = "llvm.bitcast"(%arg10) : (vector<4xi8>) -> i32
    %11 = "rocdl.sdot4"(%9, %10, %arg11) <{clamp = false}> : (i32, i32, i32) -> i32
    "func.return"(%11) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xi8>, vector<4xi8>, i32) -> i32, sym_name = "dot_udot4_clamp"}> ({
  ^bb0(%arg6: vector<4xi8>, %arg7: vector<4xi8>, %arg8: i32):
    %6 = "llvm.bitcast"(%arg6) : (vector<4xi8>) -> i32
    %7 = "llvm.bitcast"(%arg7) : (vector<4xi8>) -> i32
    %8 = "rocdl.udot4"(%6, %7, %arg8) <{clamp = true}> : (i32, i32, i32) -> i32
    "func.return"(%8) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xi4>, vector<8xi4>, i32) -> i32, sym_name = "dot_sdot8"}> ({
  ^bb0(%arg3: vector<8xi4>, %arg4: vector<8xi4>, %arg5: i32):
    %3 = "llvm.bitcast"(%arg3) : (vector<8xi4>) -> i32
    %4 = "llvm.bitcast"(%arg4) : (vector<8xi4>) -> i32
    %5 = "rocdl.sdot8"(%3, %4, %arg5) <{clamp = false}> : (i32, i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<8xi4>, vector<8xi4>, i32) -> i32, sym_name = "dot_udot8"}> ({
  ^bb0(%arg0: vector<8xi4>, %arg1: vector<8xi4>, %arg2: i32):
    %0 = "llvm.bitcast"(%arg0) : (vector<8xi4>) -> i32
    %1 = "llvm.bitcast"(%arg1) : (vector<8xi4>) -> i32
    %2 = "rocdl.udot8"(%0, %1, %arg2) <{clamp = false}> : (i32, i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

