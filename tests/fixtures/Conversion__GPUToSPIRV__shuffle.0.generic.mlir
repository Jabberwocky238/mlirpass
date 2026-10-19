"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "shuffle_xor"}> ({
      %4 = "spirv.Constant"() <{value = 8 : i32}> : () -> i32
      %5 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
      %6 = "spirv.Constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %7 = "spirv.GroupNonUniformShuffleXor"(%6, %4) <{execution_scope = #spirv.scope<Subgroup>}> : (f32, i32) -> f32
      %8 = "spirv.Constant"() <{value = true}> : () -> i1
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %3:2 = "gpu.shuffle"(%2, %0, %1) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "shuffle_xor", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformShuffle], []>, #spirv.resource_limits<subgroup_size = 16>>} : () -> ()

// -----
// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "shuffle_idx"}> ({
      %4 = "spirv.Constant"() <{value = 8 : i32}> : () -> i32
      %5 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
      %6 = "spirv.Constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %7 = "spirv.GroupNonUniformShuffle"(%6, %4) <{execution_scope = #spirv.scope<Subgroup>}> : (f32, i32) -> f32
      %8 = "spirv.Constant"() <{value = true}> : () -> i1
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %3:2 = "gpu.shuffle"(%2, %0, %1) <{mode = #gpu<shuffle_mode idx>}> : (f32, i32, i32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "shuffle_idx", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformShuffle], []>, #spirv.resource_limits<subgroup_size = 16>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "SubgroupLocalInvocationId", sym_name = "__builtin__SubgroupLocalInvocationId__", type = !spirv.ptr<i32, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "shuffle_down"}> ({
      %4 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %5 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
      %6 = "spirv.Constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %7 = "spirv.GroupNonUniformShuffleDown"(%6, %4) <{execution_scope = #spirv.scope<Subgroup>}> : (f32, i32) -> f32
      %8 = "spirv.mlir.addressof"() <{variable = @__builtin__SubgroupLocalInvocationId__}> : () -> !spirv.ptr<i32, Input>
      %9 = "spirv.Load"(%8) : (!spirv.ptr<i32, Input>) -> i32
      %10 = "spirv.IAdd"(%9, %4) : (i32, i32) -> i32
      %11 = "spirv.ULessThan"(%10, %5) : (i32, i32) -> i1
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %3:2 = "gpu.shuffle"(%2, %0, %1) <{mode = #gpu<shuffle_mode down>}> : (f32, i32, i32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "shuffle_down", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformShuffle, GroupNonUniformShuffleRelative], []>, #spirv.resource_limits<subgroup_size = 16>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "SubgroupLocalInvocationId", sym_name = "__builtin__SubgroupLocalInvocationId__", type = !spirv.ptr<i32, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "shuffle_up"}> ({
      %4 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %5 = "spirv.Constant"() <{value = 16 : i32}> : () -> i32
      %6 = "spirv.Constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %7 = "spirv.GroupNonUniformShuffleUp"(%6, %4) <{execution_scope = #spirv.scope<Subgroup>}> : (f32, i32) -> f32
      %8 = "spirv.mlir.addressof"() <{variable = @__builtin__SubgroupLocalInvocationId__}> : () -> !spirv.ptr<i32, Input>
      %9 = "spirv.Load"(%8) : (!spirv.ptr<i32, Input>) -> i32
      %10 = "spirv.ISub"(%9, %4) : (i32, i32) -> i32
      %11 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %12 = "spirv.SGreaterThanEqual"(%10, %11) : (i32, i32) -> i1
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %3:2 = "gpu.shuffle"(%2, %0, %1) <{mode = #gpu<shuffle_mode up>}> : (f32, i32, i32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "shuffle_up", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformShuffle, GroupNonUniformShuffleRelative], []>, #spirv.resource_limits<subgroup_size = 16>>} : () -> ()

