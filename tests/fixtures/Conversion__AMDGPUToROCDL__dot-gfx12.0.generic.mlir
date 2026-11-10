"builtin.module"() ({
  "func.func"() <{function_type = (vector<4xf8E4M3FN>, vector<4xf8E4M3FN>, f32) -> f32, sym_name = "dot_fp8_fp8"}> ({
  ^bb0(%arg9: vector<4xf8E4M3FN>, %arg10: vector<4xf8E4M3FN>, %arg11: f32):
    %15 = "builtin.unrealized_conversion_cast"(%arg10) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %16 = "builtin.unrealized_conversion_cast"(%arg9) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %17 = "llvm.bitcast"(%16) : (vector<4xi8>) -> i32
    %18 = "llvm.bitcast"(%15) : (vector<4xi8>) -> i32
    %19 = "rocdl.dot4.f32.fp8.fp8"(%17, %18, %arg11) : (i32, i32, f32) -> f32
    "func.return"(%19) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E4M3FN>, vector<4xf8E5M2>, f32) -> f32, sym_name = "dot_fp8_bf8"}> ({
  ^bb0(%arg6: vector<4xf8E4M3FN>, %arg7: vector<4xf8E5M2>, %arg8: f32):
    %10 = "builtin.unrealized_conversion_cast"(%arg7) : (vector<4xf8E5M2>) -> vector<4xi8>
    %11 = "builtin.unrealized_conversion_cast"(%arg6) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %12 = "llvm.bitcast"(%11) : (vector<4xi8>) -> i32
    %13 = "llvm.bitcast"(%10) : (vector<4xi8>) -> i32
    %14 = "rocdl.dot4.f32.fp8.bf8"(%12, %13, %arg8) : (i32, i32, f32) -> f32
    "func.return"(%14) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E5M2>, vector<4xf8E4M3FN>, f32) -> f32, sym_name = "dot_bf8_fp8"}> ({
  ^bb0(%arg3: vector<4xf8E5M2>, %arg4: vector<4xf8E4M3FN>, %arg5: f32):
    %5 = "builtin.unrealized_conversion_cast"(%arg4) : (vector<4xf8E4M3FN>) -> vector<4xi8>
    %6 = "builtin.unrealized_conversion_cast"(%arg3) : (vector<4xf8E5M2>) -> vector<4xi8>
    %7 = "llvm.bitcast"(%6) : (vector<4xi8>) -> i32
    %8 = "llvm.bitcast"(%5) : (vector<4xi8>) -> i32
    %9 = "rocdl.dot4.f32.bf8.fp8"(%7, %8, %arg5) : (i32, i32, f32) -> f32
    "func.return"(%9) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf8E5M2>, vector<4xf8E5M2>, f32) -> f32, sym_name = "dot_bf8_bf8"}> ({
  ^bb0(%arg0: vector<4xf8E5M2>, %arg1: vector<4xf8E5M2>, %arg2: f32):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<4xf8E5M2>) -> vector<4xi8>
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<4xf8E5M2>) -> vector<4xi8>
    %2 = "llvm.bitcast"(%1) : (vector<4xi8>) -> i32
    %3 = "llvm.bitcast"(%0) : (vector<4xi8>) -> i32
    %4 = "rocdl.dot4.f32.bf8.bf8"(%2, %3, %arg2) : (i32, i32, f32) -> f32
    "func.return"(%4) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

