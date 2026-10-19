"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "copy_sign_scalar"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "spirv.Constant"() <{value = -2147483648 : i32}> : () -> i32
    %1 = "spirv.Constant"() <{value = 2147483647 : i32}> : () -> i32
    %2 = "spirv.Bitcast"(%arg0) : (f32) -> i32
    %3 = "spirv.Bitcast"(%arg1) : (f32) -> i32
    %4 = "spirv.BitwiseAnd"(%2, %1) : (i32, i32) -> i32
    %5 = "spirv.BitwiseAnd"(%3, %0) : (i32, i32) -> i32
    %6 = "spirv.BitwiseOr"(%4, %5) : (i32, i32) -> i32
    %7 = "spirv.Bitcast"(%6) : (i32) -> f32
    "func.return"(%7) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf16>, vector<3xf16>) -> vector<3xf16>, sym_name = "copy_sign_vector"}> ({
  ^bb0(%arg0: vector<3xf16>, %arg1: vector<3xf16>):
    %0 = "spirv.Constant"() <{value = -32768 : i16}> : () -> i16
    %1 = "spirv.Constant"() <{value = 32767 : i16}> : () -> i16
    %2 = "spirv.CompositeConstruct"(%0, %0, %0) : (i16, i16, i16) -> vector<3xi16>
    %3 = "spirv.CompositeConstruct"(%1, %1, %1) : (i16, i16, i16) -> vector<3xi16>
    %4 = "spirv.Bitcast"(%arg0) : (vector<3xf16>) -> vector<3xi16>
    %5 = "spirv.Bitcast"(%arg1) : (vector<3xf16>) -> vector<3xi16>
    %6 = "spirv.BitwiseAnd"(%4, %3) : (vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    %7 = "spirv.BitwiseAnd"(%5, %2) : (vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    %8 = "spirv.BitwiseOr"(%6, %7) : (vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    %9 = "spirv.Bitcast"(%8) : (vector<3xi16>) -> vector<3xf16>
    "func.return"(%9) : (vector<3xf16>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16, Int16], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3x3xf32>, vector<3x3xf32>) -> vector<3x3xf32>, sym_name = "copy_sign_2d_vector"}> ({
  ^bb0(%arg0: vector<3x3xf32>, %arg1: vector<3x3xf32>):
    %0 = "math.copysign"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<3x3xf32>, vector<3x3xf32>) -> vector<3x3xf32>
    "func.return"(%0) : (vector<3x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>, sym_name = "copy_sign_tensor"}> ({
  ^bb0(%arg0: tensor<3x3xf32>, %arg1: tensor<3x3xf32>):
    %0 = "math.copysign"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
    "func.return"(%0) : (tensor<3x3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<1xf16>, vector<1xf16>) -> vector<1xf16>, sym_name = "copy_sign_vector_0D"}> ({
  ^bb0(%arg0: vector<1xf16>, %arg1: vector<1xf16>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (vector<1xf16>) -> f16
    %1 = "builtin.unrealized_conversion_cast"(%arg0) : (vector<1xf16>) -> f16
    %2 = "spirv.Constant"() <{value = -32768 : i16}> : () -> i16
    %3 = "spirv.Constant"() <{value = 32767 : i16}> : () -> i16
    %4 = "spirv.Bitcast"(%1) : (f16) -> i16
    %5 = "spirv.Bitcast"(%0) : (f16) -> i16
    %6 = "spirv.BitwiseAnd"(%4, %3) : (i16, i16) -> i16
    %7 = "spirv.BitwiseAnd"(%5, %2) : (i16, i16) -> i16
    %8 = "spirv.BitwiseOr"(%6, %7) : (i16, i16) -> i16
    %9 = "spirv.Bitcast"(%8) : (i16) -> f16
    %10 = "builtin.unrealized_conversion_cast"(%9) : (f16) -> vector<1xf16>
    "func.return"(%10) : (vector<1xf16>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16, Int16], []>, #spirv.resource_limits<>>} : () -> ()

