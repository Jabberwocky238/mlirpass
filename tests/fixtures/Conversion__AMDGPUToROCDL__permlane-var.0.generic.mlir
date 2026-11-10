"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "test_permlane_var_i32"}> ({
  ^bb0(%arg12: i32, %arg13: i32):
    %26 = "rocdl.permlane16.var"(%arg12, %arg12, %arg13) <{boundControl = false, fi = false}> : (i32, i32, i32) -> i32
    "func.return"(%26) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "test_permlane_var_cross_i32"}> ({
  ^bb0(%arg10: i32, %arg11: i32):
    %25 = "rocdl.permlanex16.var"(%arg10, %arg10, %arg11) <{boundControl = false, fi = false}> : (i32, i32, i32) -> i32
    "func.return"(%25) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32) -> f32, sym_name = "test_permlane_var_f32"}> ({
  ^bb0(%arg8: f32, %arg9: i32):
    %22 = "llvm.bitcast"(%arg8) : (f32) -> i32
    %23 = "rocdl.permlane16.var"(%22, %22, %arg9) <{boundControl = false, fi = false}> : (i32, i32, i32) -> i32
    %24 = "llvm.bitcast"(%23) : (i32) -> f32
    "func.return"(%24) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, i32) -> f16, sym_name = "test_permlane_var_f16"}> ({
  ^bb0(%arg6: f16, %arg7: i32):
    %17 = "llvm.bitcast"(%arg6) : (f16) -> i16
    %18 = "llvm.zext"(%17) : (i16) -> i32
    %19 = "rocdl.permlane16.var"(%18, %18, %arg7) <{boundControl = false, fi = false}> : (i32, i32, i32) -> i32
    %20 = "llvm.trunc"(%19) <{overflowFlags = 0 : i32}> : (i32) -> i16
    %21 = "llvm.bitcast"(%20) : (i16) -> f16
    "func.return"(%21) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16, i32) -> f16, sym_name = "test_permlane_var_cross_f16"}> ({
  ^bb0(%arg4: f16, %arg5: i32):
    %12 = "llvm.bitcast"(%arg4) : (f16) -> i16
    %13 = "llvm.zext"(%12) : (i16) -> i32
    %14 = "rocdl.permlanex16.var"(%13, %13, %arg5) <{boundControl = false, fi = false}> : (i32, i32, i32) -> i32
    %15 = "llvm.trunc"(%14) <{overflowFlags = 0 : i32}> : (i32) -> i16
    %16 = "llvm.bitcast"(%15) : (i16) -> f16
    "func.return"(%16) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>, i32) -> vector<4xf16>, sym_name = "test_permlane_var_4xf16"}> ({
  ^bb0(%arg2: vector<4xf16>, %arg3: i32):
    %1 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "llvm.bitcast"(%arg2) : (vector<4xf16>) -> vector<2xi32>
    %5 = "llvm.extractelement"(%4, %3) : (vector<2xi32>, i32) -> i32
    %6 = "llvm.extractelement"(%4, %2) : (vector<2xi32>, i32) -> i32
    %7 = "rocdl.permlane16.var"(%5, %5, %arg3) <{boundControl = false, fi = false}> : (i32, i32, i32) -> i32
    %8 = "rocdl.permlane16.var"(%6, %6, %arg3) <{boundControl = false, fi = false}> : (i32, i32, i32) -> i32
    %9 = "llvm.insertelement"(%1, %7, %3) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %10 = "llvm.insertelement"(%9, %8, %2) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %11 = "llvm.bitcast"(%10) : (vector<2xi32>) -> vector<4xf16>
    "func.return"(%11) : (vector<4xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "test_permlane_var_attrs"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "rocdl.permlanex16.var"(%arg0, %arg0, %arg1) <{boundControl = true, fi = true}> : (i32, i32, i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

