"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "rotate"}> ({
      %2 = "spirv.Constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %3 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %4 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
      %5 = "spirv.GroupNonUniformRotateKHR"(%2, %3, %4) <{execution_scope = #spirv.scope<Subgroup>}> : (f32, i32, i32) -> f32
      %6 = "spirv.Constant"() <{value = true}> : () -> i1
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %1:2 = "gpu.rotate"(%0) <{offset = 4 : i32, width = 16 : i32}> : (f32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "rotate", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformRotateKHR], []>, #spirv.resource_limits<subgroup_size = 16>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "SubgroupLocalInvocationId", sym_name = "__builtin__SubgroupLocalInvocationId__", type = !spirv.ptr<i32, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "rotate_width_less_than_subgroup_size"}> ({
      %2 = "spirv.Constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %3 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %4 = "spirv.Constant"() <{value = 8 : i32}> : () -> i32
      %5 = "spirv.GroupNonUniformRotateKHR"(%2, %3, %4) <{execution_scope = #spirv.scope<Subgroup>}> : (f32, i32, i32) -> f32
      %6 = "spirv.mlir.addressof"() <{variable = @__builtin__SubgroupLocalInvocationId__}> : () -> !spirv.ptr<i32, Input>
      %7 = "spirv.Load"(%6) : (!spirv.ptr<i32, Input>) -> i32
      %8 = "spirv.ULessThan"(%7, %4) : (i32, i32) -> i1
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %1:2 = "gpu.rotate"(%0) <{offset = 4 : i32, width = 8 : i32}> : (f32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "rotate_width_less_than_subgroup_size", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformRotateKHR], []>, #spirv.resource_limits<subgroup_size = 16>>} : () -> ()

// -----
