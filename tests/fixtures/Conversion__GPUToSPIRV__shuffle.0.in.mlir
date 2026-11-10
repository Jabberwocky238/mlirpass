"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %3:2 = "gpu.shuffle"(%2, %0, %1) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "shuffle_xor"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformShuffle], []>, #spirv.resource_limits<subgroup_size = 16>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %3:2 = "gpu.shuffle"(%2, %0, %1) <{mode = #gpu<shuffle_mode xor>}> : (f32, i32, i32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "shuffle_xor"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformShuffle], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %3:2 = "gpu.shuffle"(%2, %0, %1) <{mode = #gpu<shuffle_mode idx>}> : (f32, i32, i32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "shuffle_idx"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformShuffle], []>, #spirv.resource_limits<subgroup_size = 16>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %3:2 = "gpu.shuffle"(%2, %0, %1) <{mode = #gpu<shuffle_mode down>}> : (f32, i32, i32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "shuffle_down"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformShuffle, GroupNonUniformShuffleRelative], []>, #spirv.resource_limits<subgroup_size = 16>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      %3:2 = "gpu.shuffle"(%2, %0, %1) <{mode = #gpu<shuffle_mode up>}> : (f32, i32, i32) -> (f32, i1)
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "shuffle_up"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader, GroupNonUniformShuffle, GroupNonUniformShuffleRelative], []>, #spirv.resource_limits<subgroup_size = 16>>} : () -> ()

