"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.2, [Shader], []>}> ({
  "spirv.SpecConstant"() <{default_value = 3 : i32, sym_name = "x"}> : () -> ()
  "spirv.SpecConstant"() <{default_value = 4 : i32, sym_name = "y"}> : () -> ()
  "spirv.SpecConstant"() <{default_value = 5 : i32, sym_name = "z"}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "foo"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @foo, interface = []}> : () -> ()
  "spirv.ExecutionModeId"() <{execution_mode = #spirv.execution_mode<LocalSizeId>, fn = @foo, values = [@x, @y, @z]}> : () -> ()
}) : () -> ()

