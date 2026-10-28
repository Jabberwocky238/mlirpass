"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32>)>, CrossWorkgroup>) -> (), sym_name = "kernel"}> ({
    ^bb0(%arg0: f32, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32>)>, CrossWorkgroup>):
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<subgroup_size = 64>} : () -> ()
    "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Kernel>, fn = @kernel, interface = []}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @kernel, values = [32 : i32, 1 : i32, 1 : i32]}> : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32>)>, CrossWorkgroup>) -> (), sym_name = "kernel"}> ({
    ^bb0(%arg0: f32, %arg1: !spirv.ptr<!spirv.struct<(!spirv.array<12 x f32>)>, CrossWorkgroup>):
      "spirv.Return"() : () -> ()
    }) : () -> ()
    "spirv.EntryPoint"() <{execution_model = #spirv.execution_model<Kernel>, fn = @kernel, interface = []}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<LocalSize>, fn = @kernel, values = [32 : i32, 1 : i32, 1 : i32]}> : () -> ()
    "spirv.ExecutionMode"() <{execution_mode = #spirv.execution_mode<SubgroupSize>, fn = @kernel, values = [64 : i32]}> : () -> ()
  }) : () -> ()
}) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, SubgroupDispatch], []>, #spirv.resource_limits<>>} : () -> ()

