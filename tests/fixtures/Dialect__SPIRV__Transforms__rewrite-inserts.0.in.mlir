"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32, i32, !spirv.array<3 x f32>) -> vector<3xf32>, sym_name = "rewrite"}> ({
    ^bb0(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i32, %arg4: !spirv.array<3 x f32>):
      %0 = "spirv.Undef"() : () -> vector<3xf32>
      %1 = "spirv.CompositeInsert"(%arg0, %0) <{indices = [0 : i32]}> : (f32, vector<3xf32>) -> vector<3xf32>
      %2 = "spirv.CompositeInsert"(%arg1, %1) <{indices = [1 : i32]}> : (f32, vector<3xf32>) -> vector<3xf32>
      %3 = "spirv.CompositeInsert"(%arg2, %2) <{indices = [2 : i32]}> : (f32, vector<3xf32>) -> vector<3xf32>
      %4 = "spirv.Undef"() : () -> !spirv.array<4 x f32>
      %5 = "spirv.CompositeInsert"(%arg0, %4) <{indices = [0 : i32]}> : (f32, !spirv.array<4 x f32>) -> !spirv.array<4 x f32>
      %6 = "spirv.CompositeInsert"(%arg1, %5) <{indices = [1 : i32]}> : (f32, !spirv.array<4 x f32>) -> !spirv.array<4 x f32>
      %7 = "spirv.CompositeInsert"(%arg2, %6) <{indices = [2 : i32]}> : (f32, !spirv.array<4 x f32>) -> !spirv.array<4 x f32>
      %8 = "spirv.CompositeInsert"(%arg0, %7) <{indices = [3 : i32]}> : (f32, !spirv.array<4 x f32>) -> !spirv.array<4 x f32>
      %9 = "spirv.Undef"() : () -> !spirv.struct<(f32, i32, f32)>
      %10 = "spirv.CompositeInsert"(%arg0, %9) <{indices = [0 : i32]}> : (f32, !spirv.struct<(f32, i32, f32)>) -> !spirv.struct<(f32, i32, f32)>
      %11 = "spirv.CompositeInsert"(%arg3, %10) <{indices = [1 : i32]}> : (i32, !spirv.struct<(f32, i32, f32)>) -> !spirv.struct<(f32, i32, f32)>
      %12 = "spirv.CompositeInsert"(%arg1, %11) <{indices = [2 : i32]}> : (f32, !spirv.struct<(f32, i32, f32)>) -> !spirv.struct<(f32, i32, f32)>
      %13 = "spirv.Undef"() : () -> !spirv.struct<(f32, !spirv.array<3 x f32>)>
      %14 = "spirv.CompositeInsert"(%arg0, %13) <{indices = [0 : i32]}> : (f32, !spirv.struct<(f32, !spirv.array<3 x f32>)>) -> !spirv.struct<(f32, !spirv.array<3 x f32>)>
      %15 = "spirv.CompositeInsert"(%arg4, %14) <{indices = [1 : i32]}> : (!spirv.array<3 x f32>, !spirv.struct<(f32, !spirv.array<3 x f32>)>) -> !spirv.struct<(f32, !spirv.array<3 x f32>)>
      "spirv.ReturnValue"(%3) : (vector<3xf32>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> !spirv.coopmatrix<4x4xf32, Subgroup, MatrixA>, sym_name = "insertCoopMatrix"}> ({
    ^bb0(%arg0: f32):
      %0 = "spirv.Undef"() : () -> !spirv.coopmatrix<4x4xf32, Subgroup, MatrixA>
      %1 = "spirv.CompositeInsert"(%arg0, %0) <{indices = [0 : i32]}> : (f32, !spirv.coopmatrix<4x4xf32, Subgroup, MatrixA>) -> !spirv.coopmatrix<4x4xf32, Subgroup, MatrixA>
      "spirv.ReturnValue"(%1) : (!spirv.coopmatrix<4x4xf32, Subgroup, MatrixA>) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

