"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (), sym_name = "experimental_constrained_fptrunc"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.truncf"(%arg0) <{roundingmode = 4 : i32}> : (f32) -> f16
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Float16, Kernel], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<5xi32>) -> (), sym_name = "unsupported_5elem_vector"}> ({
  ^bb0(%arg0: vector<5xi32>):
    %0 = "arith.subi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (vector<5xi32>, vector<5xi32>) -> vector<5xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2x2xi32>) -> (), sym_name = "unsupported_2x2elem_vector"}> ({
  ^bb0(%arg0: vector<2x2xi32>):
    %0 = "arith.muli"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (vector<2x2xi32>, vector<2x2xi32>) -> vector<2x2xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Int8, Int16, Int64, Float16, Float64, Shader], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi16>) -> (), sym_name = "int_vector4_invalid"}> ({
  ^bb0(%arg0: vector<2xi16>):
    %0 = "arith.divui"(%arg0, %arg0) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (vector<2xi12>) -> (), sym_name = "int_vector_invalid_bitwidth"}> ({
  ^bb0(%arg0: vector<2xi12>):
    %0 = "arith.addi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (vector<2xi12>, vector<2xi12>) -> vector<2xi12>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "unsupported_constant_i64_0"}> ({
    %0 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "unsupported_constant_i64_1"}> ({
    %0 = "arith.constant"() <{value = 4294967296 : i64}> : () -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "unsupported_constant_vector_2xi64_0"}> ({
    %0 = "arith.constant"() <{value = dense<0> : vector<2xi64>}> : () -> vector<2xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "unsupported_constant_f64_0"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f64}> : () -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "unsupported_constant_vector_2xf64_0"}> ({
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : vector<2xf64>}> : () -> vector<2xf64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "unsupported_constant_tensor_2xf64_0"}> ({
    %0 = "arith.constant"() <{value = dense<0.000000e+00> : tensor<2xf64>}> : () -> tensor<2xf64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "constant_dense_resource_non_existant"}> ({
    %0 = "arith.constant"() <{value = dense_resource<non_existant> : tensor<5xf32>}> : () -> tensor<5xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "constant_dense_resource_invalid_buffer"}> ({
    %0 = "arith.constant"() <{value = dense_resource<dense_resource_test_2xi32> : vector<2xi32>}> : () -> vector<2xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

{-#
  dialect_resources: {
    builtin: {
      dense_resource_test_2xi32: "0x0800000054A3B53ED6C0B33E55D1A2BDE5D2BB3E"
    }
  }
#-}

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i64) -> (), sym_name = "unsupported_i64"}> ({
  ^bb0(%arg0: i64):
    %0 = "arith.addi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "unsupported_f64"}> ({
  ^bb0(%arg0: f64):
    %0 = "arith.addf"(%arg0, %arg0) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "type_conversion_failure"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.extsi"(%arg0) : (i32) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

