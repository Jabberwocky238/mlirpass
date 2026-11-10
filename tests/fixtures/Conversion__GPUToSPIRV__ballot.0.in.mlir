"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 1 : index}> : () -> index
      %1 = "gpu.lane_id"() : () -> index
      %2 = "arith.cmpi"(%1, %0) <{predicate = 6 : i64}> : (index, index) -> i1
      %3 = "gpu.ballot"(%2) : (i1) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>, sym_name = "ballot_i32"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 1 : index}> : () -> index
      %1 = "gpu.lane_id"() : () -> index
      %2 = "arith.cmpi"(%1, %0) <{predicate = 6 : i64}> : (index, index) -> i1
      %3 = "gpu.ballot"(%2) : (i1) -> i64
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>, sym_name = "ballot_i64"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 1 : index}> : () -> index
      %1 = "gpu.lane_id"() : () -> index
      %2 = "arith.cmpi"(%1, %0) <{predicate = 6 : i64}> : (index, index) -> i1
      %3 = "gpu.ballot"(%2) : (i1) -> i8
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>, sym_name = "ballot_invalid_i8"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 1 : index}> : () -> index
      %1 = "gpu.lane_id"() : () -> index
      %2 = "arith.cmpi"(%1, %0) <{predicate = 6 : i64}> : (index, index) -> i1
      %3 = "gpu.ballot"(%2) : (i1) -> i16
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>, sym_name = "ballot_invalid_i16"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "arith.constant"() <{value = 1 : index}> : () -> index
      %1 = "gpu.lane_id"() : () -> index
      %2 = "arith.cmpi"(%1, %0) <{predicate = 6 : i64}> : (index, index) -> i1
      %3 = "gpu.ballot"(%2) : (i1) -> i128
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>, sym_name = "ballot_invalid_i128"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Shader, GroupNonUniformBallot], []>, #spirv.resource_limits<>>} : () -> ()

