"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "load_kernel"}> ({
    ^bb0(%arg1: !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>):
      %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %3 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %4 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %5 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %6 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %7 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %8 = "spirv.AccessChain"(%arg1, %3, %2) : (!spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %9 = "spirv.Load"(%8) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()
  "gpu.module"() <{sym_name = "kernels", targets = [#spirv.target_env<#spirv.vce<v1.0, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>]}> ({
    "gpu.func"() <{function_type = (memref<12x4xf32>) -> ()}> ({
    ^bb0(%arg0: memref<12x4xf32>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "memref.load"(%arg0, %0, %0) : (memref<12x4xf32>, index, index) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "load_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<GLSL450>, sym_name = "__spv__kernels"}> ({
    "spirv.func"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], function_control = #spirv.function_control<None>, function_type = (!spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>) -> (), sym_name = "load_kernel"}> ({
    ^bb0(%arg1: !spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>):
      %2 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %3 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %4 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %5 = "spirv.Constant"() <{value = 4 : i32}> : () -> i32
      %6 = "spirv.Constant"() <{value = 0 : i32}> : () -> i32
      %7 = "spirv.Constant"() <{value = 1 : i32}> : () -> i32
      %8 = "spirv.AccessChain"(%arg1, %3, %2) : (!spirv.ptr<!spirv.struct<(!spirv.array<48 x f32, stride=4> [0])>, StorageBuffer>, i32, i32) -> !spirv.ptr<f32, StorageBuffer>
      %9 = "spirv.Load"(%8) : (!spirv.ptr<f32, StorageBuffer>) -> f32
      "spirv.Return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.4, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>} : () -> ()
  "gpu.module"() <{sym_name = "kernels", targets = [#spirv.target_env<#spirv.vce<v1.4, [Shader], [SPV_KHR_storage_buffer_storage_class]>, #spirv.resource_limits<>>, #spirv.target_env<#spirv.vce<v1.0, [Kernel], []>, #spirv.resource_limits<>>, #spirv.target_env<#spirv.vce<v1.0, [Shader], []>, #spirv.resource_limits<>>]}> ({
    "gpu.func"() <{function_type = (memref<12x4xf32>) -> ()}> ({
    ^bb0(%arg0: memref<12x4xf32>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "memref.load"(%arg0, %0, %0) : (memref<12x4xf32>, index, index) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "load_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

