"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.struct<(f32, !spirv.struct<(!spirv.array<4 x f32>, f32)>)>, !spirv.array<4 x f32>) -> !spirv.struct<(f32, !spirv.struct<(!spirv.array<4 x f32>, f32)>)>, sym_name = "composite_insert"}> ({
  ^bb0(%arg10: !spirv.struct<(f32, !spirv.struct<(!spirv.array<4 x f32>, f32)>)>, %arg11: !spirv.array<4 x f32>):
    %4 = "spirv.CompositeInsert"(%arg11, %arg10) <{indices = [1 : i32, 0 : i32]}> : (!spirv.array<4 x f32>, !spirv.struct<(f32, !spirv.struct<(!spirv.array<4 x f32>, f32)>)>) -> !spirv.struct<(f32, !spirv.struct<(!spirv.array<4 x f32>, f32)>)>
    "spirv.ReturnValue"(%4) : (!spirv.struct<(f32, !spirv.struct<(!spirv.array<4 x f32>, f32)>)>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, f32, f32) -> vector<3xf32>, sym_name = "composite_construct_vector"}> ({
  ^bb0(%arg7: f32, %arg8: f32, %arg9: f32):
    %3 = "spirv.CompositeConstruct"(%arg7, %arg8, %arg9) : (f32, f32, f32) -> vector<3xf32>
    "spirv.ReturnValue"(%3) : (vector<3xf32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, i32) -> f32, sym_name = "vector_dynamic_extract"}> ({
  ^bb0(%arg5: vector<4xf32>, %arg6: i32):
    %2 = "spirv.VectorExtractDynamic"(%arg5, %arg6) : (vector<4xf32>, i32) -> f32
    "spirv.ReturnValue"(%2) : (f32) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, vector<4xf32>, i32) -> vector<4xf32>, sym_name = "vector_dynamic_insert"}> ({
  ^bb0(%arg2: f32, %arg3: vector<4xf32>, %arg4: i32):
    %1 = "spirv.VectorInsertDynamic"(%arg3, %arg2, %arg4) : (vector<4xf32>, f32, i32) -> vector<4xf32>
    "spirv.ReturnValue"(%1) : (vector<4xf32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<4xf32>, vector<2xf32>) -> vector<3xf32>, sym_name = "vector_shuffle"}> ({
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<2xf32>):
    %0 = "spirv.VectorShuffle"(%arg0, %arg1) <{components = [1 : i32, 3 : i32, -1 : i32]}> : (vector<4xf32>, vector<2xf32>) -> vector<3xf32>
    "spirv.ReturnValue"(%0) : (vector<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

