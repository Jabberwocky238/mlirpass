"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader], []>}> ({
  "spirv.GlobalVariable"() <{sym_name = "var2", type = !spirv.ptr<f32, Input>}> : () -> ()
  "spirv.GlobalVariable"() <{sym_name = "var3", type = !spirv.ptr<f32, Output>}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "noop"}> ({
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<GLCompute>, fn = @noop, interface = [@var2, @var3]}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @noop, values = [1 : i32, 1 : i32, 1 : i32]}> : () -> ()
}) : () -> ()

