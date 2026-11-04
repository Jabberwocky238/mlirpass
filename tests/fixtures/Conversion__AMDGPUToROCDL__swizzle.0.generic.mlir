"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "test_swizzle_i32"}> ({
  ^bb0(%arg4: i32):
    %32 = "llvm.mlir.constant"() <{value = 4161 : i32}> : () -> i32
    %33 = "rocdl.ds_swizzle"(%arg4, %32) : (i32, i32) -> i32
    "func.return"(%33) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "test_swizzle_f32"}> ({
  ^bb0(%arg3: f32):
    %28 = "llvm.mlir.constant"() <{value = 4161 : i32}> : () -> i32
    %29 = "llvm.bitcast"(%arg3) : (f32) -> i32
    %30 = "rocdl.ds_swizzle"(%29, %28) : (i32, i32) -> i32
    %31 = "llvm.bitcast"(%30) : (i32) -> f32
    "func.return"(%31) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f16) -> f16, sym_name = "test_swizzle_f16"}> ({
  ^bb0(%arg2: f16):
    %22 = "llvm.mlir.constant"() <{value = 4161 : i32}> : () -> i32
    %23 = "llvm.bitcast"(%arg2) : (f16) -> i16
    %24 = "llvm.zext"(%23) : (i16) -> i32
    %25 = "rocdl.ds_swizzle"(%24, %22) : (i32, i32) -> i32
    %26 = "llvm.trunc"(%25) <{overflowFlags = 0 : i32}> : (i32) -> i16
    %27 = "llvm.bitcast"(%26) : (i16) -> f16
    "func.return"(%27) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xi32>) -> vector<2xi32>, sym_name = "test_swizzle_2xi32"}> ({
  ^bb0(%arg1: vector<2xi32>):
    %12 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %13 = "llvm.mlir.constant"() <{value = 4161 : i32}> : () -> i32
    %14 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %15 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %16 = "llvm.extractelement"(%arg1, %15) : (vector<2xi32>, i32) -> i32
    %17 = "llvm.extractelement"(%arg1, %14) : (vector<2xi32>, i32) -> i32
    %18 = "rocdl.ds_swizzle"(%16, %13) : (i32, i32) -> i32
    %19 = "rocdl.ds_swizzle"(%17, %13) : (i32, i32) -> i32
    %20 = "llvm.insertelement"(%12, %18, %15) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %21 = "llvm.insertelement"(%20, %19, %14) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    "func.return"(%21) : (vector<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf16>) -> vector<4xf16>, sym_name = "test_swizzle_4xf16"}> ({
  ^bb0(%arg0: vector<4xf16>):
    %0 = "llvm.mlir.poison"() : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() <{value = 4161 : i32}> : () -> i32
    %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "llvm.bitcast"(%arg0) : (vector<4xf16>) -> vector<2xi32>
    %5 = "llvm.extractelement"(%4, %3) : (vector<2xi32>, i32) -> i32
    %6 = "llvm.extractelement"(%4, %2) : (vector<2xi32>, i32) -> i32
    %7 = "rocdl.ds_swizzle"(%5, %1) : (i32, i32) -> i32
    %8 = "rocdl.ds_swizzle"(%6, %1) : (i32, i32) -> i32
    %9 = "llvm.insertelement"(%0, %7, %3) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %10 = "llvm.insertelement"(%9, %8, %2) : (vector<2xi32>, i32, i32) -> vector<2xi32>
    %11 = "llvm.bitcast"(%10) : (vector<2xi32>) -> vector<4xf16>
    "func.return"(%11) : (vector<4xf16>) -> ()
  }) : () -> ()
}) : () -> ()

