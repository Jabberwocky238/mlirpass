module attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [], []>, #spirv.resource_limits<>>} {
  spirv.func @return_none_val() "None" {
    spirv.Return
  }
  spirv.func @return_one_val(%arg0: f32) -> f32 "None" {
    spirv.ReturnValue %arg0 : f32
  }
  func.func @return_multi_val(%arg0: f32) -> (f32, f32) {
    return %arg0, %arg0 : f32, f32
  }
  spirv.func @return_one_index(%arg0: i32) -> i32 "None" {
    spirv.ReturnValue %arg0 : i32
  }
  spirv.func @call_functions(%arg0: i32) -> i32 "None" {
    spirv.FunctionCall @return_none_val() : () -> ()
    %0 = spirv.FunctionCall @return_one_index(%arg0) : (i32) -> i32
    spirv.ReturnValue %0 : i32
  }
}

// -----
// -----
module {
}

