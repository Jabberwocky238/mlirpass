"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>) -> (), sym_name = "fpclassify"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4xf32>):
    %0 = "math.isfinite"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    %1 = "math.isfinite"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    %2 = "math.isnan"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    %3 = "math.isnan"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    %4 = "math.isinf"(%arg0) <{fastmath = #arith.fastmath<none>}> : (f32) -> i1
    %5 = "math.isinf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (vector<4xf32>) -> vector<4xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

