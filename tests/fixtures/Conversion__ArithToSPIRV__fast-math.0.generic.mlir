"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "cmpf_ordered"}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %1 = "spirv.Constant"() <{value = true}> : () -> i1
    "func.return"(%1) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> vector<4xi1>, sym_name = "cmpf_unordered"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):
    %0 = "spirv.Constant"() <{value = dense<false> : vector<4xi1>}> : () -> vector<4xi1>
    "func.return"(%0) : (vector<4xi1>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "minimumf"}> ({
  ^bb0(%arg6: f32, %arg7: f32):
    %3 = "spirv.GL.FMin"(%arg6, %arg7) : (f32, f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> vector<4xf32>, sym_name = "maximumf"}> ({
  ^bb0(%arg4: vector<4xf32>, %arg5: vector<4xf32>):
    %2 = "spirv.GL.FMax"(%arg4, %arg5) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "minnumf"}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %1 = "spirv.GL.FMin"(%arg2, %arg3) : (f32, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> vector<4xf32>, sym_name = "maxnumf"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):
    %0 = "spirv.GL.FMax"(%arg0, %arg1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

