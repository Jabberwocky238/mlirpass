module {
  spirv.module Logical GLSL450 {
    spirv.func @rewrite(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i32, %arg4: !spirv.array<3 x f32>) -> vector<3xf32> "None" {
      %0 = spirv.Undef : vector<3xf32>
      %1 = spirv.CompositeConstruct %arg0, %arg1, %arg2 : (f32, f32, f32) -> vector<3xf32>
      %2 = spirv.Undef : !spirv.array<4 x f32>
      %3 = spirv.CompositeConstruct %arg0, %arg1, %arg2, %arg0 : (f32, f32, f32, f32) -> !spirv.array<4 x f32>
      %4 = spirv.Undef : !spirv.struct<(f32, i32, f32)>
      %5 = spirv.CompositeConstruct %arg0, %arg3, %arg1 : (f32, i32, f32) -> !spirv.struct<(f32, i32, f32)>
      %6 = spirv.Undef : !spirv.struct<(f32, !spirv.array<3 x f32>)>
      %7 = spirv.CompositeConstruct %arg0, %arg4 : (f32, !spirv.array<3 x f32>) -> !spirv.struct<(f32, !spirv.array<3 x f32>)>
      spirv.ReturnValue %1 : vector<3xf32>
    }
  }
}

// -----
module {
  spirv.module Logical GLSL450 {
    spirv.func @insertCoopMatrix(%arg0: f32) -> !spirv.coopmatrix<4x4xf32, Subgroup, MatrixA> "None" {
      %0 = spirv.Undef : !spirv.coopmatrix<4x4xf32, Subgroup, MatrixA>
      %1 = spirv.CompositeInsert %arg0, %0[0 : i32] : f32 into !spirv.coopmatrix<4x4xf32, Subgroup, MatrixA>
      spirv.ReturnValue %1 : !spirv.coopmatrix<4x4xf32, Subgroup, MatrixA>
    }
  }
}

