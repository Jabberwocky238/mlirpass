module {
  spirv.func @add_scalar(%arg0: i32) -> i32 "None" {
    %0 = spirv.IAdd %arg0, %arg0 : i32
    spirv.ReturnValue %0 : i32
  }
  spirv.func @add_index(%arg0: i32) -> i32 "None" {
    %0 = spirv.IAdd %arg0, %arg0 : i32
    spirv.ReturnValue %0 : i32
  }
}

