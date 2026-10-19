module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @fpclassify(%arg0: f32, %arg1: vector<4xf32>) {
    %0 = spirv.IsFinite %arg0 : f32
    %1 = spirv.IsFinite %arg1 : vector<4xf32>
    %2 = spirv.IsNan %arg0 : f32
    %3 = spirv.IsNan %arg1 : vector<4xf32>
    %4 = spirv.IsInf %arg0 : f32
    %5 = spirv.IsInf %arg1 : vector<4xf32>
    return
  }
}

