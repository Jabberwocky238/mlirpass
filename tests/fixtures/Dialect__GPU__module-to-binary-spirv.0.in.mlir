"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel_module", targets = [#spirv.target_env<#spirv.vce<v1.0, [Int64, Int16, Kernel, Addresses], []>, #spirv.resource_limits<>>]}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernel_module", vce_triple = #spirv.vce<v1.0, [Int64, Int16, Kernel, Addresses], []>}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.array<200 x i16>, CrossWorkgroup>, !spirv.ptr<!spirv.array<200 x i16>, CrossWorkgroup>, !spirv.ptr<!spirv.array<200 x i16>, CrossWorkgroup>) -> (), sym_name = "test_kernel"}> ({
      ^bb0(%arg0: !spirv.ptr<!spirv.array<200 x i16>, CrossWorkgroup>, %arg1: !spirv.ptr<!spirv.array<200 x i16>, CrossWorkgroup>, %arg2: !spirv.ptr<!spirv.array<200 x i16>, CrossWorkgroup>):
        "spirv.Return"() : () -> ()
      }) {workgroup_attributions = 0 : i64} : () -> ()
    }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Float16Buffer, Int64, Int16, Int8, Kernel, Linkage, Vector16, GenericPointer, Groups, Float16, Float64, AtomicFloat32AddEXT, ExpectAssumeKHR], [SPV_EXT_shader_atomic_float_add, SPV_KHR_expect_assume, SPV_AMD_shader_ballot]>, api=OpenCL, #spirv.resource_limits<>>} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

