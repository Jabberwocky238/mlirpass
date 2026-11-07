// acgpu's examples/texture_checker shaders as SPIR-V (a gpu.module of their spirv.module).
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
  "spirv.GlobalVariable"() <{sym_name = "vs_in0", type = !spirv.ptr<vector<2xf32>, Input>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "vs_in1", type = !spirv.ptr<vector<2xf32>, Input>}> {location = 1 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "vs_out0", type = !spirv.ptr<vector<4xf32>, Output>}> {built_in = "Position"} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "vs_out1", type = !spirv.ptr<vector<2xf32>, Output>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "fs_in0", type = !spirv.ptr<vector<2xf32>, Input>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "fs_out0", type = !spirv.ptr<vector<4xf32>, Output>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "tex0", type = !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, UniformConstant>}> {binding = 0 : i32, descriptor_set = 0 : i32} : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "vs"}> ({
    %t1 = "spirv.mlir.addressof"() <{variable = @vs_in0}> : () -> !spirv.ptr<vector<2xf32>, Input>
    %p = "spirv.Load"(%t1) : (!spirv.ptr<vector<2xf32>, Input>) -> vector<2xf32>
    %t2 = "spirv.mlir.addressof"() <{variable = @vs_in1}> : () -> !spirv.ptr<vector<2xf32>, Input>
    %uv = "spirv.Load"(%t2) : (!spirv.ptr<vector<2xf32>, Input>) -> vector<2xf32>
    %zw = "spirv.Constant"() <{value = dense<[0.0, 1.0]> : vector<2xf32>}> : () -> vector<2xf32>
    %pos = "spirv.VectorShuffle"(%p, %zw) <{components = [0 : i32, 1 : i32, 2 : i32, 3 : i32]}> : (vector<2xf32>, vector<2xf32>) -> vector<4xf32>
    %t3 = "spirv.mlir.addressof"() <{variable = @vs_out0}> : () -> !spirv.ptr<vector<4xf32>, Output>
    "spirv.Store"(%t3, %pos) : (!spirv.ptr<vector<4xf32>, Output>, vector<4xf32>) -> ()
    %t4 = "spirv.mlir.addressof"() <{variable = @vs_out1}> : () -> !spirv.ptr<vector<2xf32>, Output>
    "spirv.Store"(%t4, %uv) : (!spirv.ptr<vector<2xf32>, Output>, vector<2xf32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "fs"}> ({
    %t1 = "spirv.mlir.addressof"() <{variable = @fs_in0}> : () -> !spirv.ptr<vector<2xf32>, Input>
    %uv = "spirv.Load"(%t1) : (!spirv.ptr<vector<2xf32>, Input>) -> vector<2xf32>
    %t2 = "spirv.mlir.addressof"() <{variable = @tex0}> : () -> !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, UniformConstant>
    %t3 = "spirv.Load"(%t2) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
    %c = "spirv.ImageSampleImplicitLod"(%t3, %uv) : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>) -> vector<4xf32>
    %t4 = "spirv.mlir.addressof"() <{variable = @fs_out0}> : () -> !spirv.ptr<vector<4xf32>, Output>
    "spirv.Store"(%t4, %c) : (!spirv.ptr<vector<4xf32>, Output>, vector<4xf32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Vertex>, fn = @vs, interface = [@vs_in0, @vs_in1, @vs_out0, @vs_out1]}> : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Fragment>, fn = @fs, interface = [@fs_in0, @fs_out0]}> : () -> ()
}) : () -> ()
}
}
