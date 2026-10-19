"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "control_barrier"}> ({
    "spirv.ControlBarrier"() <{execution_scope = #spirv.scope<Workgroup>, memory_scope = #spirv.scope<Workgroup>, memory_semantics = #spirv.memory_semantics<WorkgroupMemory|CrossWorkgroupMemory>}> : () -> ()
    "spirv.ControlBarrier"() <{execution_scope = #spirv.scope<Workgroup>, memory_scope = #spirv.scope<Workgroup>, memory_semantics = #spirv.memory_semantics<WorkgroupMemory>}> : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "split_barrier"}> ({
    "spirv.INTEL.ControlBarrierArrive"() <{execution_scope = #spirv.scope<Workgroup>, memory_scope = #spirv.scope<Workgroup>, memory_semantics = #spirv.memory_semantics<WorkgroupMemory|CrossWorkgroupMemory>}> : () -> ()
    "spirv.INTEL.ControlBarrierWait"() <{execution_scope = #spirv.scope<Workgroup>, memory_scope = #spirv.scope<Workgroup>, memory_semantics = #spirv.memory_semantics<WorkgroupMemory>}> : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

