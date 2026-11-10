module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @fpclassify(%arg0: f32, %arg1: vector<4xf32>) {
    %0 = spirv.IsFinite %arg0 : f32
    %1 = spirv.IsFinite %arg1 : vector<4xf32>
    %2 = spirv.IsNan %arg0 : f32
    %3 = spirv.IsNan %arg1 : vector<4xf32>
    %4 = spirv.IsInf %arg0 : f32
    %5 = spirv.IsInf %arg1 : vector<4xf32>
    %6 = spirv.IsNormal %arg0 : f32
    %7 = spirv.IsNormal %arg1 : vector<4xf32>
    return
  }
  func.func @ctpop(%arg0: i32, %arg1: vector<4xi32>) {
    %0 = spirv.BitCount %arg0 : i32
    %1 = spirv.BitCount %arg1 : vector<4xi32>
    return
  }
}

