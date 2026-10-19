"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "copy_sign_scalar"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "math.copysign"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<3xf16>, vector<3xf16>) -> vector<3xf16>, sym_name = "copy_sign_vector"}> ({
  ^bb0(%arg0: vector<3xf16>, %arg1: vector<3xf16>):
    %0 = "math.copysign"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<3xf16>, vector<3xf16>) -> vector<3xf16>
    "func.return"(%0) : (vector<3xf16>) -> ()
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
    %0 = "math.copysign"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (vector<1xf16>, vector<1xf16>) -> vector<1xf16>
    "func.return"(%0) : (vector<1xf16>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16, Int16], []>, #spirv.resource_limits<>>} : () -> ()

