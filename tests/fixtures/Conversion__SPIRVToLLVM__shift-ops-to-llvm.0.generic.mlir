"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32, i16, i16)>, linkage = #llvm.linkage<external>, sym_name = "shift_right_arithmetic_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg20: i32, %arg21: i32, %arg22: i16, %arg23: i16):
    %30 = "llvm.ashr"(%arg20, %arg20) : (i32, i32) -> i32
    %31 = "llvm.ashr"(%arg20, %arg21) : (i32, i32) -> i32
    %32 = "llvm.sext"(%arg22) : (i16) -> i32
    %33 = "llvm.ashr"(%arg20, %32) : (i32, i32) -> i32
    %34 = "llvm.zext"(%arg23) : (i16) -> i32
    %35 = "llvm.ashr"(%arg20, %34) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi64>, vector<4xi64>, vector<4xi32>, vector<4xi32>)>, linkage = #llvm.linkage<external>, sym_name = "shift_right_arithmetic_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg16: vector<4xi64>, %arg17: vector<4xi64>, %arg18: vector<4xi32>, %arg19: vector<4xi32>):
    %24 = "llvm.ashr"(%arg16, %arg16) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %25 = "llvm.ashr"(%arg16, %arg17) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %26 = "llvm.sext"(%arg18) : (vector<4xi32>) -> vector<4xi64>
    %27 = "llvm.ashr"(%arg16, %26) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %28 = "llvm.zext"(%arg19) : (vector<4xi32>) -> vector<4xi64>
    %29 = "llvm.ashr"(%arg16, %28) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32, i16, i16)>, linkage = #llvm.linkage<external>, sym_name = "shift_right_logical_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg12: i32, %arg13: i32, %arg14: i16, %arg15: i16):
    %18 = "llvm.lshr"(%arg12, %arg12) : (i32, i32) -> i32
    %19 = "llvm.lshr"(%arg12, %arg13) : (i32, i32) -> i32
    %20 = "llvm.sext"(%arg14) : (i16) -> i32
    %21 = "llvm.lshr"(%arg12, %20) : (i32, i32) -> i32
    %22 = "llvm.zext"(%arg15) : (i16) -> i32
    %23 = "llvm.lshr"(%arg12, %22) : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi64>, vector<4xi64>, vector<4xi32>, vector<4xi32>)>, linkage = #llvm.linkage<external>, sym_name = "shift_right_logical_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg8: vector<4xi64>, %arg9: vector<4xi64>, %arg10: vector<4xi32>, %arg11: vector<4xi32>):
    %12 = "llvm.lshr"(%arg8, %arg8) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %13 = "llvm.lshr"(%arg8, %arg9) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %14 = "llvm.sext"(%arg10) : (vector<4xi32>) -> vector<4xi64>
    %15 = "llvm.lshr"(%arg8, %14) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %16 = "llvm.zext"(%arg11) : (vector<4xi32>) -> vector<4xi64>
    %17 = "llvm.lshr"(%arg8, %16) : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32, i16, i16)>, linkage = #llvm.linkage<external>, sym_name = "shift_left_logical_scalar", visibility_ = 0 : i64}> ({
  ^bb0(%arg4: i32, %arg5: i32, %arg6: i16, %arg7: i16):
    %6 = "llvm.shl"(%arg4, %arg4) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %7 = "llvm.shl"(%arg4, %arg5) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %8 = "llvm.sext"(%arg6) : (i16) -> i32
    %9 = "llvm.shl"(%arg4, %8) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    %10 = "llvm.zext"(%arg7) : (i16) -> i32
    %11 = "llvm.shl"(%arg4, %10) <{overflowFlags = 0 : i32}> : (i32, i32) -> i32
    "llvm.return"() : () -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (vector<4xi64>, vector<4xi64>, vector<4xi32>, vector<4xi32>)>, linkage = #llvm.linkage<external>, sym_name = "shift_left_logical_vector", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: vector<4xi64>, %arg1: vector<4xi64>, %arg2: vector<4xi32>, %arg3: vector<4xi32>):
    %0 = "llvm.shl"(%arg0, %arg0) <{overflowFlags = 0 : i32}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %1 = "llvm.shl"(%arg0, %arg1) <{overflowFlags = 0 : i32}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %2 = "llvm.sext"(%arg2) : (vector<4xi32>) -> vector<4xi64>
    %3 = "llvm.shl"(%arg0, %2) <{overflowFlags = 0 : i32}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    %4 = "llvm.zext"(%arg3) : (vector<4xi32>) -> vector<4xi64>
    %5 = "llvm.shl"(%arg0, %4) <{overflowFlags = 0 : i32}> : (vector<4xi64>, vector<4xi64>) -> vector<4xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

