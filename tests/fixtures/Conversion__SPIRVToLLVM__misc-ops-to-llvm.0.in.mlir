"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.array<4 x !spirv.array<4 x f32>>) -> (), sym_name = "composite_extract_array"}> ({
  ^bb0(%arg17: !spirv.array<4 x !spirv.array<4 x f32>>):
    %10 = "spirv.CompositeExtract"(%arg17) <{indices = [1 : i32, 3 : i32]}> : (!spirv.array<4 x !spirv.array<4 x f32>>) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xf32>) -> (), sym_name = "composite_extract_vector"}> ({
  ^bb0(%arg16: vector<3xf32>):
    %9 = "spirv.CompositeExtract"(%arg16) <{indices = [0 : i32]}> : (vector<3xf32>) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32, !spirv.struct<(f32, !spirv.array<4 x i32>)>) -> (), sym_name = "composite_insert_struct"}> ({
  ^bb0(%arg14: i32, %arg15: !spirv.struct<(f32, !spirv.array<4 x i32>)>):
    %8 = "spirv.CompositeInsert"(%arg14, %arg15) <{indices = [1 : i32, 3 : i32]}> : (i32, !spirv.struct<(f32, !spirv.array<4 x i32>)>) -> !spirv.struct<(f32, !spirv.array<4 x i32>)>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xf32>, f32) -> (), sym_name = "composite_insert_vector"}> ({
  ^bb0(%arg12: vector<3xf32>, %arg13: f32):
    %7 = "spirv.CompositeInsert"(%arg13, %arg12) <{indices = [1 : i32]}> : (f32, vector<3xf32>) -> vector<3xf32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i1, vector<3xi32>, vector<3xi32>, f32, f32) -> (), sym_name = "select_scalar"}> ({
  ^bb0(%arg7: i1, %arg8: vector<3xi32>, %arg9: vector<3xi32>, %arg10: f32, %arg11: f32):
    %5 = "spirv.Select"(%arg7, %arg8, %arg9) : (i1, vector<3xi32>, vector<3xi32>) -> vector<3xi32>
    %6 = "spirv.Select"(%arg7, %arg10, %arg11) : (i1, f32, f32) -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> (), sym_name = "select_vector"}> ({
  ^bb0(%arg4: vector<2xi1>, %arg5: vector<2xi32>, %arg6: vector<2xi32>):
    %4 = "spirv.Select"(%arg4, %arg5, %arg6) : (vector<2xi1>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<2xf32>, vector<2xf32>) -> vector<3xf32>, sym_name = "vector_shuffle_same_size"}> ({
  ^bb0(%arg2: vector<2xf32>, %arg3: vector<2xf32>):
    %3 = "spirv.VectorShuffle"(%arg2, %arg3) <{components = [0 : i32, 2 : i32, -1 : i32]}> : (vector<2xf32>, vector<2xf32>) -> vector<3xf32>
    "spirv.ReturnValue"(%3) : (vector<3xf32>) -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (vector<3xf32>, vector<2xf32>) -> vector<3xf32>, sym_name = "vector_shuffle_different_size"}> ({
  ^bb0(%arg0: vector<3xf32>, %arg1: vector<2xf32>):
    %2 = "spirv.VectorShuffle"(%arg0, %arg1) <{components = [0 : i32, 4 : i32, -1 : i32]}> : (vector<3xf32>, vector<2xf32>) -> vector<3xf32>
    "spirv.ReturnValue"(%2) : (vector<3xf32>) -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<OpenCL>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "empty"}> ({
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Kernel>, fn = @empty, interface = []}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<ContractionOff>, fn = @empty, values = []}> : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<OpenCL>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "bar"}> ({
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Kernel>, fn = @bar, interface = []}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<ContractionOff>, fn = @bar, values = []}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSizeHint>, fn = @bar, values = [32 : i32, 1 : i32, 1 : i32]}> : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "undef_scalar"}> ({
    %1 = "spirv.Undef"() : () -> f32
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "undef_vector"}> ({
    %0 = "spirv.Undef"() : () -> vector<2xi32>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

