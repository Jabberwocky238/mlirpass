"spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>, vce_triple = #spirv.vce<v1.1, [Kernel, Addresses, NamedBarrier, Linkage], []>}> ({
  "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "named_barrier"}> ({
  ^bb0(%arg0: i32):
    %0 = "spirv.NamedBarrierInitialize"(%arg0) : (i32) -> !spirv.named_barrier
    "spirv.MemoryNamedBarrier"(%0) <{memory_scope = #spirv.scope<Workgroup>, memory_semantics = #spirv.memory_semantics<AcquireRelease|WorkgroupMemory>}> : (!spirv.named_barrier) -> ()
    "spirv.Return"() : () -> ()
  }) : () -> ()
}) : () -> ()

