"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Geometry], []>}> ({
  "spirv.GlobalVariable"() <{sym_name = "out", type = !spirv.ptr<!spirv.struct<(vector<4xf32>, f32, !spirv.array<1 x f32>)>, Output>}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "primitive_ops"}> ({
    "spirv.EmitVertex"() : () -> ()
    "spirv.EndPrimitive"() : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Geometry>, fn = @primitive_ops, interface = [@out]}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<InputPoints>, fn = @primitive_ops, values = []}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<Invocations>, fn = @primitive_ops, values = [1 : i32]}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<OutputLineStrip>, fn = @primitive_ops, values = []}> : () -> ()
  "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<OutputVertices>, fn = @primitive_ops, values = [2 : i32]}> : () -> ()
}) : () -> ()

