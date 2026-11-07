// acgpu's src/resolve shaders as SPIR-V (a gpu.module of their spirv.module).
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
  "spirv.GlobalVariable"() <{sym_name = "resolve_vs_in0", type = !spirv.ptr<vector<4xf32>, Input>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "resolve_vs_in1", type = !spirv.ptr<vector<2xf32>, Input>}> {location = 1 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "resolve_vs_out0", type = !spirv.ptr<vector<4xf32>, Output>}> {built_in = "Position"} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "resolve_vs_out1", type = !spirv.ptr<vector<2xf32>, Output>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "resolve_fs_in0", type = !spirv.ptr<vector<2xf32>, Input>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "resolve_fs_out0", type = !spirv.ptr<vector<4xf32>, Output>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "ms0", type = !spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>}> {binding = 0 : i32, descriptor_set = 0 : i32} : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "resolve_vs"}> ({
    %t1 = "spirv.mlir.addressof"() <{variable = @resolve_vs_in0}> : () -> !spirv.ptr<vector<4xf32>, Input>
    %p = "spirv.Load"(%t1) : (!spirv.ptr<vector<4xf32>, Input>) -> vector<4xf32>
    %t2 = "spirv.mlir.addressof"() <{variable = @resolve_vs_in1}> : () -> !spirv.ptr<vector<2xf32>, Input>
    %px = "spirv.Load"(%t2) : (!spirv.ptr<vector<2xf32>, Input>) -> vector<2xf32>
    %t3 = "spirv.mlir.addressof"() <{variable = @resolve_vs_out0}> : () -> !spirv.ptr<vector<4xf32>, Output>
    "spirv.Store"(%t3, %p) : (!spirv.ptr<vector<4xf32>, Output>, vector<4xf32>) -> ()
    %t4 = "spirv.mlir.addressof"() <{variable = @resolve_vs_out1}> : () -> !spirv.ptr<vector<2xf32>, Output>
    "spirv.Store"(%t4, %px) : (!spirv.ptr<vector<2xf32>, Output>, vector<2xf32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "resolve_fs"}> ({
    %t1 = "spirv.mlir.addressof"() <{variable = @resolve_fs_in0}> : () -> !spirv.ptr<vector<2xf32>, Input>
    %px = "spirv.Load"(%t1) : (!spirv.ptr<vector<2xf32>, Input>) -> vector<2xf32>
    %f = "spirv.GL.Floor"(%px) : (vector<2xf32>) -> vector<2xf32>
    %xy = "spirv.ConvertFToS"(%f) : (vector<2xf32>) -> vector<2xi32>
    %s0 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %s1 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %s2 = "spirv.Constant"() <{value = 2 : i32}> : () -> i32
    %s3 = "spirv.Constant"() <{value = 3 : i32}> : () -> i32
    %t2 = "spirv.mlir.addressof"() <{variable = @ms0}> : () -> !spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>
    %t3 = "spirv.Load"(%t2) : (!spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>) -> !spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>
    %c0 = "spirv.ImageFetch"(%t3, %xy, %s0) <{image_operands = #spirv.image_operands<Sample>}> : (!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, vector<2xi32>, i32) -> vector<4xf32>
    %t4 = "spirv.mlir.addressof"() <{variable = @ms0}> : () -> !spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>
    %t5 = "spirv.Load"(%t4) : (!spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>) -> !spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>
    %c1 = "spirv.ImageFetch"(%t5, %xy, %s1) <{image_operands = #spirv.image_operands<Sample>}> : (!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, vector<2xi32>, i32) -> vector<4xf32>
    %t6 = "spirv.mlir.addressof"() <{variable = @ms0}> : () -> !spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>
    %t7 = "spirv.Load"(%t6) : (!spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>) -> !spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>
    %c2 = "spirv.ImageFetch"(%t7, %xy, %s2) <{image_operands = #spirv.image_operands<Sample>}> : (!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, vector<2xi32>, i32) -> vector<4xf32>
    %t8 = "spirv.mlir.addressof"() <{variable = @ms0}> : () -> !spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>
    %t9 = "spirv.Load"(%t8) : (!spirv.ptr<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>) -> !spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>
    %c3 = "spirv.ImageFetch"(%t9, %xy, %s3) <{image_operands = #spirv.image_operands<Sample>}> : (!spirv.image<f32, Dim2D, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>, vector<2xi32>, i32) -> vector<4xf32>
    %a = "spirv.FAdd"(%c0, %c1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %b = "spirv.FAdd"(%c2, %c3) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %sum = "spirv.FAdd"(%a, %b) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %q = "spirv.Constant"() <{value = dense<0.25> : vector<4xf32>}> : () -> vector<4xf32>
    %mean = "spirv.FMul"(%sum, %q) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %t10 = "spirv.mlir.addressof"() <{variable = @resolve_fs_out0}> : () -> !spirv.ptr<vector<4xf32>, Output>
    "spirv.Store"(%t10, %mean) : (!spirv.ptr<vector<4xf32>, Output>, vector<4xf32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Vertex>, fn = @resolve_vs, interface = [@resolve_vs_in0, @resolve_vs_in1, @resolve_vs_out0, @resolve_vs_out1]}> : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Fragment>, fn = @resolve_fs, interface = [@resolve_fs_in0, @resolve_fs_out0]}> : () -> ()
}) : () -> ()
}
}
