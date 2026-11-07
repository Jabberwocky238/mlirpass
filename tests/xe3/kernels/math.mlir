// acgpu's examples/math_ops shaders as SPIR-V (a gpu.module of their spirv.module).
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
  "spirv.GlobalVariable"() <{sym_name = "vs_in0", type = !spirv.ptr<vector<2xf32>, Input>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "vs_in1", type = !spirv.ptr<vector<2xf32>, Input>}> {location = 1 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "vs_out0", type = !spirv.ptr<vector<4xf32>, Output>}> {built_in = "Position"} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "vs_out1", type = !spirv.ptr<vector<2xf32>, Output>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "arith_fs_in0", type = !spirv.ptr<vector<2xf32>, Input>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "arith_fs_out0", type = !spirv.ptr<vector<4xf32>, Output>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "select_fs_in0", type = !spirv.ptr<vector<2xf32>, Input>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "select_fs_out0", type = !spirv.ptr<vector<4xf32>, Output>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "tex0", type = !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, UniformConstant>}> {binding = 0 : i32, descriptor_set = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "tex1", type = !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, UniformConstant>}> {binding = 1 : i32, descriptor_set = 0 : i32} : () -> ()
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
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "arith_fs"}> ({
    %t1 = "spirv.mlir.addressof"() <{variable = @arith_fs_in0}> : () -> !spirv.ptr<vector<2xf32>, Input>
    %uv = "spirv.Load"(%t1) : (!spirv.ptr<vector<2xf32>, Input>) -> vector<2xf32>
    %t2 = "spirv.mlir.addressof"() <{variable = @tex0}> : () -> !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, UniformConstant>
    %t3 = "spirv.Load"(%t2) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
    %raw = "spirv.ImageSampleImplicitLod"(%t3, %uv) : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>) -> vector<4xf32>
    %t4 = "spirv.mlir.addressof"() <{variable = @tex1}> : () -> !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, UniformConstant>
    %t5 = "spirv.Load"(%t4) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
    %scale = "spirv.ImageSampleImplicitLod"(%t5, %uv) : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>) -> vector<4xf32>
    %t = "spirv.FMul"(%raw, %scale) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %a = "spirv.CompositeExtract"(%t) <{indices = [0 : i32]}> : (vector<4xf32>) -> f32
    %b = "spirv.CompositeExtract"(%t) <{indices = [1 : i32]}> : (vector<4xf32>) -> f32
    %c = "spirv.CompositeExtract"(%t) <{indices = [2 : i32]}> : (vector<4xf32>) -> f32
    %q = "spirv.FDiv"(%a, %b) : (f32, f32) -> f32
    %m = "spirv.GL.FAbs"(%a) : (f32) -> f32
    %s = "spirv.GL.Sqrt"(%m) : (f32) -> f32
    %f = "spirv.GL.Fma"(%a, %b, %c) : (f32, f32, f32) -> f32
    %fl = "spirv.GL.Floor"(%c) : (f32) -> f32
    %r = "spirv.CompositeConstruct"(%q, %s, %f, %fl) : (f32, f32, f32, f32) -> vector<4xf32>
    %t6 = "spirv.mlir.addressof"() <{variable = @arith_fs_out0}> : () -> !spirv.ptr<vector<4xf32>, Output>
    "spirv.Store"(%t6, %r) : (!spirv.ptr<vector<4xf32>, Output>, vector<4xf32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "select_fs"}> ({
    %t1 = "spirv.mlir.addressof"() <{variable = @select_fs_in0}> : () -> !spirv.ptr<vector<2xf32>, Input>
    %uv = "spirv.Load"(%t1) : (!spirv.ptr<vector<2xf32>, Input>) -> vector<2xf32>
    %t2 = "spirv.mlir.addressof"() <{variable = @tex0}> : () -> !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, UniformConstant>
    %t3 = "spirv.Load"(%t2) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
    %raw = "spirv.ImageSampleImplicitLod"(%t3, %uv) : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>) -> vector<4xf32>
    %t4 = "spirv.mlir.addressof"() <{variable = @tex1}> : () -> !spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, UniformConstant>
    %t5 = "spirv.Load"(%t4) : (!spirv.ptr<!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, UniformConstant>) -> !spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>
    %scale = "spirv.ImageSampleImplicitLod"(%t5, %uv) : (!spirv.sampled_image<!spirv.image<f32, Dim2D, NoDepth, NonArrayed, SingleSampled, NeedSampler, Unknown>>, vector<2xf32>) -> vector<4xf32>
    %t = "spirv.FMul"(%raw, %scale) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %a = "spirv.CompositeExtract"(%t) <{indices = [0 : i32]}> : (vector<4xf32>) -> f32
    %b = "spirv.CompositeExtract"(%t) <{indices = [1 : i32]}> : (vector<4xf32>) -> f32
    %c = "spirv.CompositeExtract"(%t) <{indices = [2 : i32]}> : (vector<4xf32>) -> f32
    %d = "spirv.CompositeExtract"(%t) <{indices = [3 : i32]}> : (vector<4xf32>) -> f32
    %lo = "spirv.GL.FMin"(%a, %b) : (f32, f32) -> f32
    %hi = "spirv.GL.FMax"(%a, %b) : (f32, f32) -> f32
    %lt = "spirv.FOrdLessThan"(%a, %b) : (f32, f32) -> i1
    %x = "spirv.Select"(%lt, %c, %d) : (i1, f32, f32) -> f32
    %ge = "spirv.FOrdGreaterThanEqual"(%a, %b) : (f32, f32) -> i1
    %y = "spirv.Select"(%ge, %c, %d) : (i1, f32, f32) -> f32
    %r = "spirv.CompositeConstruct"(%lo, %hi, %x, %y) : (f32, f32, f32, f32) -> vector<4xf32>
    %t6 = "spirv.mlir.addressof"() <{variable = @select_fs_out0}> : () -> !spirv.ptr<vector<4xf32>, Output>
    "spirv.Store"(%t6, %r) : (!spirv.ptr<vector<4xf32>, Output>, vector<4xf32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Vertex>, fn = @vs, interface = [@vs_in0, @vs_in1, @vs_out0, @vs_out1]}> : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Fragment>, fn = @arith_fs, interface = [@arith_fs_in0, @arith_fs_out0]}> : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Fragment>, fn = @select_fs, interface = [@select_fs_in0, @select_fs_out0]}> : () -> ()
}) : () -> ()
}
}
