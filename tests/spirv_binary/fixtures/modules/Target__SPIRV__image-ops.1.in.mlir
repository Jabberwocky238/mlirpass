"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, StorageImageWriteWithoutFormat, StorageImageReadWithoutFormat, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, vector<2xsi32>) -> (), sym_name = "image_read_write"}> ({
  ^bb0(%arg0: !spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, %arg1: vector<2xsi32>):
    %0 = "spirv.ImageRead"(%arg0, %arg1) : (!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, vector<2xsi32>) -> vector<4xf32>
    "spirv.ImageWrite"(%arg0, %arg1, %0) : (!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, vector<2xsi32>, vector<4xf32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

