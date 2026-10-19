"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%4, %4, %4, %4, %4, %4) <{kernel = @kernels::@builtin_workgroup_id_x, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "WorkgroupId", sym_name = "__builtin__WorkgroupId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_workgroup_id_x"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %3 = "spirv.CompositeExtract"(%2) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_workgroup_id_x", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    "gpu.launch_func"(%4, %4, %4, %4, %4, %4, %5) <{kernel = @kernels::@builtin_workgroup_id_y, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0>}> : (index, index, index, index, index, index, i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "WorkgroupId", sym_name = "__builtin__WorkgroupId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_workgroup_id_y"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %3 = "spirv.CompositeExtract"(%2) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_workgroup_id_y", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%4, %4, %4, %4, %4, %4) <{kernel = @kernels::@builtin_workgroup_id_z, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "WorkgroupId", sym_name = "__builtin__WorkgroupId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_workgroup_id_z"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %3 = "spirv.CompositeExtract"(%2) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_workgroup_id_z", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%2, %2, %2, %2, %2, %2) <{kernel = @kernels::@builtin_workgroup_size_x, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_workgroup_size_x"}> ({
      %1 = "spirv.Constant"() <{value = 32 : i32}> : () -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>, sym_name = "builtin_workgroup_size_x", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%2, %2, %2, %2, %2, %2) <{kernel = @kernels::@builtin_workgroup_size_y, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_workgroup_size_y"}> ({
      %1 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "builtin_workgroup_size_y", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%2, %2, %2, %2, %2, %2) <{kernel = @kernels::@builtin_workgroup_size_z, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_workgroup_size_z"}> ({
      %1 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "builtin_workgroup_size_z", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%4, %4, %4, %4, %4, %4) <{kernel = @kernels::@builtin_local_id_x, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "LocalInvocationId", sym_name = "__builtin__LocalInvocationId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_local_id_x"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__LocalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %3 = "spirv.CompositeExtract"(%2) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_local_id_x", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%4, %4, %4, %4, %4, %4) <{kernel = @kernels::@builtin_num_workgroups_x, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "NumWorkgroups", sym_name = "__builtin__NumWorkgroups__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_num_workgroups_x"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__NumWorkgroups__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %3 = "spirv.CompositeExtract"(%2) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_num_workgroups_x", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "SubgroupId", sym_name = "__builtin__SubgroupId__", type = !spirv.ptr<i32, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_subgroup_id"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__SubgroupId__}> : () -> !spirv.ptr<i32, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<i32, Input>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.subgroup_id"() : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_subgroup_id", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "NumSubgroups", sym_name = "__builtin__NumSubgroups__", type = !spirv.ptr<i32, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_num_subgroups"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__NumSubgroups__}> : () -> !spirv.ptr<i32, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<i32, Input>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.num_subgroups"() : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_num_subgroups", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%4, %4, %4, %4, %4, %4) <{kernel = @kernels::@builtin_workgroup_size_x, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "WorkgroupSize", sym_name = "__builtin__WorkgroupSize__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_workgroup_size_x"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__WorkgroupSize__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %3 = "spirv.CompositeExtract"(%2) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<>, sym_name = "builtin_workgroup_size_x", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%4, %4, %4, %4, %4, %4) <{kernel = @kernels::@builtin_workgroup_size_y, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "WorkgroupSize", sym_name = "__builtin__WorkgroupSize__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_workgroup_size_y"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__WorkgroupSize__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %3 = "spirv.CompositeExtract"(%2) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<>, sym_name = "builtin_workgroup_size_y", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%4, %4, %4, %4, %4, %4) <{kernel = @kernels::@builtin_workgroup_size_z, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "WorkgroupSize", sym_name = "__builtin__WorkgroupSize__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_workgroup_size_z"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__WorkgroupSize__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %3 = "spirv.CompositeExtract"(%2) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<>, sym_name = "builtin_workgroup_size_z", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%4, %4, %4, %4, %4, %4) <{kernel = @kernels::@builtin_global_id_x, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "GlobalInvocationId", sym_name = "__builtin__GlobalInvocationId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_global_id_x"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__GlobalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %3 = "spirv.CompositeExtract"(%2) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.global_id"() <{dimension = #gpu<dim x>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_global_id_x", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%4, %4, %4, %4, %4, %4) <{kernel = @kernels::@builtin_global_id_y, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "GlobalInvocationId", sym_name = "__builtin__GlobalInvocationId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_global_id_y"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__GlobalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %3 = "spirv.CompositeExtract"(%2) <{indices = [1 : i32]}> : (vector<3xi32>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.global_id"() <{dimension = #gpu<dim y>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_global_id_y", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%4, %4, %4, %4, %4, %4) <{kernel = @kernels::@builtin_global_id_z, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "GlobalInvocationId", sym_name = "__builtin__GlobalInvocationId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_global_id_z"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__GlobalInvocationId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
      %3 = "spirv.CompositeExtract"(%2) <{indices = [2 : i32]}> : (vector<3xi32>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.global_id"() <{dimension = #gpu<dim z>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_global_id_z", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.GlobalVariable"() <{built_in = "SubgroupSize", sym_name = "__builtin__SubgroupSize__", type = !spirv.ptr<i32, Input>}> : () -> ()
    "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_subgroup_size"}> ({
      %1 = "spirv.mlir.addressof"() <{variable = @__builtin__SubgroupSize__}> : () -> !spirv.ptr<i32, Input>
      %2 = "spirv.Load"(%1) : (!spirv.ptr<i32, Input>) -> i32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.subgroup_size"() : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "builtin_subgroup_size", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader, Int64], []>, #spirv.resource_limits<>>} : () -> ()

