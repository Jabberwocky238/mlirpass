module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  func.func @cmpf_ordered(%arg0: f32, %arg1: f32) -> i1 {
    %true = spirv.Constant true
    return %true : i1
  }
  func.func @cmpf_unordered(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xi1> {
    %cst_vec_4xi1 = spirv.Constant dense<false> : vector<4xi1>
    return %cst_vec_4xi1 : vector<4xi1>
  }
}

// -----
module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>} {
  func.func @minimumf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = spirv.GL.FMin %arg0, %arg1 : f32
    return %0 : f32
  }
  func.func @maximumf(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = spirv.GL.FMax %arg0, %arg1 : vector<4xf32>
    return %0 : vector<4xf32>
  }
  func.func @minnumf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = spirv.GL.FMin %arg0, %arg1 : f32
    return %0 : f32
  }
  func.func @maxnumf(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = spirv.GL.FMax %arg0, %arg1 : vector<4xf32>
    return %0 : vector<4xf32>
  }
}

