"builtin.module"() ({
  "func.func"() <{function_type = (f32, vector<4xf32>) -> (), sym_name = "fpclassify"}> ({
  ^bb0(%arg0: f32, %arg1: vector<4xf32>):
    %0 = "spirv.IsFinite"(%arg0) : (f32) -> i1
    %1 = "spirv.IsFinite"(%arg1) : (vector<4xf32>) -> vector<4xi1>
    %2 = "spirv.IsNan"(%arg0) : (f32) -> i1
    %3 = "spirv.IsNan"(%arg1) : (vector<4xf32>) -> vector<4xi1>
    %4 = "spirv.IsInf"(%arg0) : (f32) -> i1
    %5 = "spirv.IsInf"(%arg1) : (vector<4xf32>) -> vector<4xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} : () -> ()

