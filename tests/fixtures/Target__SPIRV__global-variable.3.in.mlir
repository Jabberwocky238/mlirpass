"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage], []>}> ({
  "spirv.GlobalVariable"() <{built_in = "GlobalInvocationId", sym_name = "globalInvocationID", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "foo"}> ({
    %0 = "spirv.mlir.addressof"() <{variable = @globalInvocationID}> : () -> !spirv.ptr<vector<3xi32>, Input>
    %1 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
    %2 = "spirv.AccessChain"(%0, %1) : (!spirv.ptr<vector<3xi32>, Input>, i32) -> !spirv.ptr<i32, Input>
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

