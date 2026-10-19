"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<StorageBuffer>>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "basic_module_structure", workgroup_attributions = 0 : i64} : () -> ()
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
    "gpu.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(1, 2), StorageBuffer>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(3, 0)>}], function_type = (f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<StorageBuffer>>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "basic_module_structure_preset_ABI", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<StorageBuffer>>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "missing_entry_point_abi", workgroup_attributions = 0 : i64} : () -> ()
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
    "gpu.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(1, 2), StorageBuffer>}, {}], function_type = (f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<StorageBuffer>>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "missing_entry_point_abi", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{arg_attrs = [{}, {spirv.interface_var_abi = #spirv.interface_var_abi<(3, 0)>}], function_type = (f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<StorageBuffer>>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "missing_entry_point_abi", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> ()}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<StorageBuffer>>):
      "gpu.barrier"() : () -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, sym_name = "barrier", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<12xf32, #spirv.storage_class<StorageBuffer>>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%2, %2, %2, %2, %2, %2, %0, %1) <{kernel = @kernels::@barrier, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<12xf32, #spirv.storage_class<StorageBuffer>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

