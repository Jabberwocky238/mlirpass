"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f16, sym_name = "scalar_trunc"}> ({
  ^bb0(%arg2: f32):
    %25 = "llvm.mlir.poison"() : () -> f32
    %26 = "rocdl.cvt.pkrtz"(%arg2, %25) : (f32, f32) -> vector<2xf16>
    %27 = "vector.extract"(%26) <{static_position = array<i64: 0>}> : (vector<2xf16>) -> f16
    "func.return"(%27) : (f16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<2xf32>) -> vector<2xf16>, sym_name = "vector_trunc_short"}> ({
  ^bb0(%arg1: vector<2xf32>):
    %22 = "vector.extract"(%arg1) <{static_position = array<i64: 0>}> : (vector<2xf32>) -> f32
    %23 = "vector.extract"(%arg1) <{static_position = array<i64: 1>}> : (vector<2xf32>) -> f32
    %24 = "rocdl.cvt.pkrtz"(%22, %23) : (f32, f32) -> vector<2xf16>
    "func.return"(%24) : (vector<2xf16>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<9xf32>) -> vector<9xf16>, sym_name = "vector_trunc_long"}> ({
  ^bb0(%arg0: vector<9xf32>):
    %0 = "llvm.mlir.poison"() : () -> f32
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<9xf16>}> : () -> vector<9xf16>
    %2 = "vector.extract"(%arg0) <{static_position = array<i64: 0>}> : (vector<9xf32>) -> f32
    %3 = "vector.extract"(%arg0) <{static_position = array<i64: 1>}> : (vector<9xf32>) -> f32
    %4 = "rocdl.cvt.pkrtz"(%2, %3) : (f32, f32) -> vector<2xf16>
    %5 = "vector.insert_strided_slice"(%4, %1) <{offsets = [0], strides = [1]}> : (vector<2xf16>, vector<9xf16>) -> vector<9xf16>
    %6 = "vector.extract"(%arg0) <{static_position = array<i64: 2>}> : (vector<9xf32>) -> f32
    %7 = "vector.extract"(%arg0) <{static_position = array<i64: 3>}> : (vector<9xf32>) -> f32
    %8 = "rocdl.cvt.pkrtz"(%6, %7) : (f32, f32) -> vector<2xf16>
    %9 = "vector.insert_strided_slice"(%8, %5) <{offsets = [2], strides = [1]}> : (vector<2xf16>, vector<9xf16>) -> vector<9xf16>
    %10 = "vector.extract"(%arg0) <{static_position = array<i64: 4>}> : (vector<9xf32>) -> f32
    %11 = "vector.extract"(%arg0) <{static_position = array<i64: 5>}> : (vector<9xf32>) -> f32
    %12 = "rocdl.cvt.pkrtz"(%10, %11) : (f32, f32) -> vector<2xf16>
    %13 = "vector.insert_strided_slice"(%12, %9) <{offsets = [4], strides = [1]}> : (vector<2xf16>, vector<9xf16>) -> vector<9xf16>
    %14 = "vector.extract"(%arg0) <{static_position = array<i64: 6>}> : (vector<9xf32>) -> f32
    %15 = "vector.extract"(%arg0) <{static_position = array<i64: 7>}> : (vector<9xf32>) -> f32
    %16 = "rocdl.cvt.pkrtz"(%14, %15) : (f32, f32) -> vector<2xf16>
    %17 = "vector.insert_strided_slice"(%16, %13) <{offsets = [6], strides = [1]}> : (vector<2xf16>, vector<9xf16>) -> vector<9xf16>
    %18 = "vector.extract"(%arg0) <{static_position = array<i64: 8>}> : (vector<9xf32>) -> f32
    %19 = "rocdl.cvt.pkrtz"(%18, %0) : (f32, f32) -> vector<2xf16>
    %20 = "vector.extract_strided_slice"(%19) <{offsets = [0], sizes = [1], strides = [1]}> : (vector<2xf16>) -> vector<1xf16>
    %21 = "vector.insert_strided_slice"(%20, %17) <{offsets = [8], strides = [1]}> : (vector<1xf16>, vector<9xf16>) -> vector<9xf16>
    "func.return"(%21) : (vector<9xf16>) -> ()
  }) : () -> ()
}) : () -> ()

