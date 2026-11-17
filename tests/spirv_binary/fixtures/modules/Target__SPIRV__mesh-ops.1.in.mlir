"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.4, [MeshShadingEXT], [SPV_EXT_mesh_shader]>}> ({
  "spirv.GlobalVariable"() <{sym_name = "payload", type = !spirv.ptr<i32, TaskPayloadWorkgroupEXT>}> : () -> ()
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "emit_mesh_tasks_payload"}> ({
    %0 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
    %1 = "spirv.mlir.addressof"() <{variable = @payload}> : () -> !spirv.ptr<i32, TaskPayloadWorkgroupEXT>
    "spirv.EXT.EmitMeshTasks"(%0, %0, %0, %1) : (i32, i32, i32, !spirv.ptr<i32, TaskPayloadWorkgroupEXT>) -> ()
  }) : () -> ()
  "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<TaskEXT>, fn = @emit_mesh_tasks_payload, interface = [@payload]}> : () -> ()
}) : () -> ()

