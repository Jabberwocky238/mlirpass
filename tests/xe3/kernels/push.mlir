// acgpu's examples/push_pushed shaders as SPIR-V (a gpu.module of their spirv.module).
module attributes {gpu.container_module} {
gpu.module @shaders [#xevm.target<chip = "ptl">] {
"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>}> ({
  "spirv.GlobalVariable"() <{sym_name = "vs_in0", type = !spirv.ptr<vector<2xf32>, Input>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "vs_out0", type = !spirv.ptr<vector<4xf32>, Output>}> {built_in = "Position"} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "fs_out0", type = !spirv.ptr<vector<4xf32>, Output>}> {location = 0 : i32} : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "push", type = !spirv.ptr<!spirv.struct<(vector<2xf32> [0], vector<4xf32> [16])>, PushConstant>}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "vs"}> ({
    %t1 = "spirv.mlir.addressof"() <{variable = @vs_in0}> : () -> !spirv.ptr<vector<2xf32>, Input>
    %p = "spirv.Load"(%t1) : (!spirv.ptr<vector<2xf32>, Input>) -> vector<2xf32>
    %t2 = "spirv.mlir.addressof"() <{variable = @push}> : () -> !spirv.ptr<!spirv.struct<(vector<2xf32> [0], vector<4xf32> [16])>, PushConstant>
    %t3 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %t4 = "spirv.AccessChain"(%t2, %t3) : (!spirv.ptr<!spirv.struct<(vector<2xf32> [0], vector<4xf32> [16])>, PushConstant>, i32) -> !spirv.ptr<vector<2xf32>, PushConstant>
    %t = "spirv.Load"(%t4) : (!spirv.ptr<vector<2xf32>, PushConstant>) -> vector<2xf32>
    %q = "spirv.FAdd"(%p, %t) : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %zw = "spirv.Constant"() <{value = dense<[0.0, 1.0]> : vector<2xf32>}> : () -> vector<2xf32>
    %pos = "spirv.VectorShuffle"(%q, %zw) <{components = [0 : i32, 1 : i32, 2 : i32, 3 : i32]}> : (vector<2xf32>, vector<2xf32>) -> vector<4xf32>
    %t5 = "spirv.mlir.addressof"() <{variable = @vs_out0}> : () -> !spirv.ptr<vector<4xf32>, Output>
    "spirv.Store"(%t5, %pos) : (!spirv.ptr<vector<4xf32>, Output>, vector<4xf32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "fs"}> ({
    %t1 = "spirv.mlir.addressof"() <{variable = @push}> : () -> !spirv.ptr<!spirv.struct<(vector<2xf32> [0], vector<4xf32> [16])>, PushConstant>
    %t2 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %t3 = "spirv.AccessChain"(%t1, %t2) : (!spirv.ptr<!spirv.struct<(vector<2xf32> [0], vector<4xf32> [16])>, PushConstant>, i32) -> !spirv.ptr<vector<4xf32>, PushConstant>
    %c = "spirv.Load"(%t3) : (!spirv.ptr<vector<4xf32>, PushConstant>) -> vector<4xf32>
    %t4 = "spirv.mlir.addressof"() <{variable = @fs_out0}> : () -> !spirv.ptr<vector<4xf32>, Output>
    "spirv.Store"(%t4, %c) : (!spirv.ptr<vector<4xf32>, Output>, vector<4xf32>) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Vertex>, fn = @vs, interface = [@vs_in0, @vs_out0]}> : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Fragment>, fn = @fs, interface = [@fs_out0]}> : () -> ()
}) : () -> ()
}
}
