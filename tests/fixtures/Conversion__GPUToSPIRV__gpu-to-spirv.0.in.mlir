"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<StorageBuffer>>):
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "basic_module_structure"} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<12xf32, #spirv.storage_class<StorageBuffer>>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%2, %2, %2, %2, %2, %2, %0, %1) <{kernel = @kernels::@basic_module_structure, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(1, 2), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(3, 0)>}], function_type = (f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<StorageBuffer>>):
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "basic_module_structure_preset_ABI"} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<StorageBuffer>>):
      "gpu.return"() : () -> ()
    }) {sym_name = "missing_entry_point_abi"} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<12xf32, #spirv.storage_class<StorageBuffer>>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%2, %2, %2, %2, %2, %2, %0, %1) <{kernel = @kernels::@missing_entry_point_abi, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(1, 2), StorageBuffer>}, {}], function_type = (f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<StorageBuffer>>):
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "missing_entry_point_abi"} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{arg_attrs = [{}, {spirv.interface_var_abi = #spirv.interface_var_abi<(3, 0)>}], function_type = (f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<StorageBuffer>>):
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "missing_entry_point_abi"} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> (), kernel}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<StorageBuffer>>):
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "barrier"} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<12xf32, #spirv.storage_class<StorageBuffer>>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%2, %2, %2, %2, %2, %2, %0, %1) <{kernel = @kernels::@barrier, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      "gpu.barrier"() <{scope = #gpu.barrier_scope<subgroup>}> : () -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>, sym_name = "barrier_subgroup_scope"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.1, [Kernel, Addresses, NamedBarrier], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.initialize_named_barrier"(%arg0) : (i32) -> !gpu.named_barrier
      "gpu.barrier"(%0) <{scope = #gpu.barrier_scope<workgroup>}> : (!gpu.named_barrier) -> ()
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 1, 1]>, sym_name = "named_barrier"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.1, [Kernel, Addresses, NamedBarrier], []>, #spirv.resource_limits<>>} : () -> ()

