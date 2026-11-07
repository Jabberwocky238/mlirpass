// acgpu's examples/triangle/spirv.mlir shaders: a gpu.module of their spirv.module.
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
  "spirv.GlobalVariable"() <{sym_name = "in_pos", type = !spirv.ptr<vector<2xf32>, Input>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "out_pos", type = !spirv.ptr<vector<4xf32>, Output>}> {built_in = "Position"} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "out_color", type = !spirv.ptr<vector<4xf32>, Output>}> {location = 0 : i32} : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "vs"}> ({
    %0 = "spirv.mlir.addressof"() <{variable = @in_pos}> : () -> !spirv.ptr<vector<2xf32>, Input>
    %1 = "spirv.Load"(%0) : (!spirv.ptr<vector<2xf32>, Input>) -> vector<2xf32>
    %2 = "spirv.CompositeExtract"(%1) <{indices = [0 : i32]}> : (vector<2xf32>) -> f32
    %3 = "spirv.CompositeExtract"(%1) <{indices = [1 : i32]}> : (vector<2xf32>) -> f32
    %4 = "spirv.Constant"() <{value = 0.0 : f32}> : () -> f32
    %5 = "spirv.Constant"() <{value = 1.0 : f32}> : () -> f32
    %6 = "spirv.CompositeConstruct"(%2, %3, %4, %5) : (f32, f32, f32, f32) -> vector<4xf32>
    %7 = "spirv.mlir.addressof"() <{variable = @out_pos}> : () -> !spirv.ptr<vector<4xf32>, Output>
    "spirv.Store"(%7, %6) : (!spirv.ptr<vector<4xf32>, Output>, vector<4xf32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "fs"}> ({
    %0 = "spirv.Constant"() <{value = dense<[1.0, 0.5, 0.25, 1.0]> : vector<4xf32>}> : () -> vector<4xf32>
    %1 = "spirv.mlir.addressof"() <{variable = @out_color}> : () -> !spirv.ptr<vector<4xf32>, Output>
    "spirv.Store"(%1, %0) : (!spirv.ptr<vector<4xf32>, Output>, vector<4xf32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Vertex>, fn = @vs, interface = [@in_pos, @out_pos]}> : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Fragment>, fn = @fs, interface = [@out_color]}> : () -> ()
}) : () -> ()
}
}
