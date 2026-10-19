"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> i1, sym_name = "cmpf_ordered"}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %1 = "arith.cmpf"(%arg2, %arg3) <{fastmath = #arith.fastmath<fast>, predicate = 7 : i64}> : (f32, f32) -> i1
    "func.return"(%1) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> vector<4xi1>, sym_name = "cmpf_unordered"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):
    %0 = "arith.cmpf"(%arg0, %arg1) <{fastmath = #arith.fastmath<nnan>, predicate = 14 : i64}> : (vector<4xf32>, vector<4xf32>) -> vector<4xi1>
    "func.return"(%0) : (vector<4xi1>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "minimumf"}> ({
  ^bb0(%arg6: f32, %arg7: f32):
    %3 = "arith.minimumf"(%arg6, %arg7) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> vector<4xf32>, sym_name = "maximumf"}> ({
  ^bb0(%arg4: vector<4xf32>, %arg5: vector<4xf32>):
    %2 = "arith.maximumf"(%arg4, %arg5) <{fastmath = #arith.fastmath<fast>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%2) : (vector<4xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "minnumf"}> ({
  ^bb0(%arg2: f32, %arg3: f32):
    %1 = "arith.minnumf"(%arg2, %arg3) <{fastmath = #arith.fastmath<fast>}> : (f32, f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (vector<4xf32>, vector<4xf32>) -> vector<4xf32>, sym_name = "maxnumf"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):
    %0 = "arith.maxnumf"(%arg0, %arg1) <{fastmath = #arith.fastmath<fast>}> : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "func.return"(%0) : (vector<4xf32>) -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

