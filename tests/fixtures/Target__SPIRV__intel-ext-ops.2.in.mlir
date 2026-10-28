"spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, vce_triple = #spirv.vce<v1.0, [Shader, Linkage, SplitBarrierINTEL], [SPV_INTEL_split_barrier]>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "split_barrier"}> ({
    "spirv.INTEL.ControlBarrierArrive"() <{execution_scope = #spirv.scope<Workgroup>, memory_scope = #spirv.scope<Device>, memory_semantics = #spirv.memory_semantics<Acquire|UniformMemory>}> : () -> ()
    "spirv.INTEL.ControlBarrierWait"() <{execution_scope = #spirv.scope<Workgroup>, memory_scope = #spirv.scope<Device>, memory_semantics = #spirv.memory_semantics<Acquire|UniformMemory>}> : () -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

