"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_argmax_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x3x4xi8>) -> !spirv.arm.tensor<2x4xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "argmax_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x3x4xi8>):
      %0 = "spirv.Tosa.ArgMax"(%arg0) <{axis = 1 : i32, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<2x3x4xi8>) -> !spirv.arm.tensor<2x4xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x4xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_avg_pool2d_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x4x4x1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x2x2x1xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}], sym_name = "avg_pool2d_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x4x4x1xi8>, %arg1: !spirv.arm.tensor<1xi8>, %arg2: !spirv.arm.tensor<1xi8>):
      %0 = "spirv.Tosa.AvgPool2D"(%arg0, %arg1, %arg2) <{acc_type = #spirv.tosa_ext_acc_type<INT32>, kernel = dense<2> : !spirv.arm.tensor<2xi32>, pad = dense<0> : !spirv.arm.tensor<4xi32>, stride = dense<2> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x4x4x1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x2x2x1xi8>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<1x2x2x1xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_conv2d_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x4x4x1xi8>, !spirv.arm.tensor<2x3x3x1xi8>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x2x2x2xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 5)>}], sym_name = "conv2d_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x4x4x1xi8>, %arg1: !spirv.arm.tensor<2x3x3x1xi8>, %arg2: !spirv.arm.tensor<2xi32>, %arg3: !spirv.arm.tensor<1xi8>, %arg4: !spirv.arm.tensor<1xi8>):
      %0 = "spirv.Tosa.Conv2D"(%arg0, %arg1, %arg2, %arg3, %arg4) <{acc_type = #spirv.tosa_ext_acc_type<INT32>, dilation = dense<1> : !spirv.arm.tensor<2xi32>, local_bound = false, pad = dense<0> : !spirv.arm.tensor<4xi32>, stride = dense<1> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x4x4x1xi8>, !spirv.arm.tensor<2x3x3x1xi8>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x2x2x2xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<1x2x2x2xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_conv3d_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x4x4x4x1xi8>, !spirv.arm.tensor<2x2x2x2x1xi8>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x3x3x3x2xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 5)>}], sym_name = "conv3d_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x4x4x4x1xi8>, %arg1: !spirv.arm.tensor<2x2x2x2x1xi8>, %arg2: !spirv.arm.tensor<2xi32>, %arg3: !spirv.arm.tensor<1xi8>, %arg4: !spirv.arm.tensor<1xi8>):
      %0 = "spirv.Tosa.Conv3D"(%arg0, %arg1, %arg2, %arg3, %arg4) <{acc_type = #spirv.tosa_ext_acc_type<INT32>, dilation = dense<1> : !spirv.arm.tensor<3xi32>, local_bound = false, pad = dense<0> : !spirv.arm.tensor<6xi32>, stride = dense<1> : !spirv.arm.tensor<3xi32>}> : (!spirv.arm.tensor<1x4x4x4x1xi8>, !spirv.arm.tensor<2x2x2x2x1xi8>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x3x3x3x2xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<1x3x3x3x2xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_depthwise_conv2d_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x4x4x1xi8>, !spirv.arm.tensor<3x3x1x2xi8>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x2x2x2xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 5)>}], sym_name = "depthwise_conv2d_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x4x4x1xi8>, %arg1: !spirv.arm.tensor<3x3x1x2xi8>, %arg2: !spirv.arm.tensor<2xi32>, %arg3: !spirv.arm.tensor<1xi8>, %arg4: !spirv.arm.tensor<1xi8>):
      %0 = "spirv.Tosa.DepthwiseConv2D"(%arg0, %arg1, %arg2, %arg3, %arg4) <{acc_type = #spirv.tosa_ext_acc_type<INT32>, dilation = dense<1> : !spirv.arm.tensor<2xi32>, local_bound = false, pad = dense<0> : !spirv.arm.tensor<4xi32>, stride = dense<1> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x4x4x1xi8>, !spirv.arm.tensor<3x3x1x2xi8>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x2x2x2xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<1x2x2x2xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_fft2d_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>) -> (!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>), res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}], sym_name = "fft2d_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x32x32xf32>, %arg1: !spirv.arm.tensor<1x32x32xf32>):
      %0 = "spirv.Tosa.FFT2D"(%arg0, %arg1) <{inverse = true, local_bound = false}> : (!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>) -> !spirv.struct<(!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>)>
      %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (!spirv.struct<(!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>)>) -> !spirv.arm.tensor<1x32x32xf32>
      %2 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (!spirv.struct<(!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>)>) -> !spirv.arm.tensor<1x32x32xf32>
      "spirv.ARM.GraphOutputs"(%1, %2) : (!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_matmul_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x2x3xi8>, !spirv.arm.tensor<1x3x4xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x2x4xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4)>}], sym_name = "matmul_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x2x3xi8>, %arg1: !spirv.arm.tensor<1x3x4xi8>, %arg2: !spirv.arm.tensor<1xi8>, %arg3: !spirv.arm.tensor<1xi8>):
      %0 = "spirv.Tosa.MatMul"(%arg0, %arg1, %arg2, %arg3) : (!spirv.arm.tensor<1x2x3xi8>, !spirv.arm.tensor<1x3x4xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x2x4xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<1x2x4xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_max_pool2d_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x4x4x1xf32>) -> !spirv.arm.tensor<1x2x2x1xf32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "max_pool2d_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x4x4x1xf32>):
      %0 = "spirv.Tosa.MaxPool2D"(%arg0) <{kernel = dense<2> : !spirv.arm.tensor<2xi32>, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>, pad = dense<0> : !spirv.arm.tensor<4xi32>, stride = dense<2> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x4x4x1xf32>) -> !spirv.arm.tensor<1x2x2x1xf32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<1x2x2x1xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_rfft2d_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x32x32xf32>) -> (!spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>), res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "rfft2d_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x32x32xf32>):
      %0 = "spirv.Tosa.RFFT2D"(%arg0) <{local_bound = false}> : (!spirv.arm.tensor<1x32x32xf32>) -> !spirv.struct<(!spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>)>
      %1 = "spirv.CompositeExtract"(%0) <{indices = [0 : i32]}> : (!spirv.struct<(!spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>)>) -> !spirv.arm.tensor<1x32x17xf32>
      %2 = "spirv.CompositeExtract"(%0) <{indices = [1 : i32]}> : (!spirv.struct<(!spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>)>) -> !spirv.arm.tensor<1x32x17xf32>
      "spirv.ARM.GraphOutputs"(%1, %2) : (!spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_transpose_conv2d_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x2x2x1xi8>, !spirv.arm.tensor<2x3x3x1xi8>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x4x4x2xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 5)>}], sym_name = "transpose_conv2d_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x2x2x1xi8>, %arg1: !spirv.arm.tensor<2x3x3x1xi8>, %arg2: !spirv.arm.tensor<2xi32>, %arg3: !spirv.arm.tensor<1xi8>, %arg4: !spirv.arm.tensor<1xi8>):
      %0 = "spirv.Tosa.TransposeConv2D"(%arg0, %arg1, %arg2, %arg3, %arg4) <{acc_type = #spirv.tosa_ext_acc_type<INT32>, local_bound = false, out_pad = dense<0> : !spirv.arm.tensor<4xi32>, stride = dense<1> : !spirv.arm.tensor<2xi32>}> : (!spirv.arm.tensor<1x2x2x1xi8>, !spirv.arm.tensor<2x3x3x1xi8>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<1x4x4x2xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<1x4x4x2xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_clamp_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<4x8xi8>) -> !spirv.arm.tensor<4x8xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "clamp_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<4x8xi8>):
      %0 = "spirv.Tosa.Clamp"(%arg0) <{max_val = 3 : i8, min_val = -2 : i8, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<4x8xi8>) -> !spirv.arm.tensor<4x8xi8>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<4x8xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_erf_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<47x38x51xf32>) -> !spirv.arm.tensor<47x38x51xf32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "erf_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<47x38x51xf32>):
      %0 = "spirv.Tosa.Erf"(%arg0) : (!spirv.arm.tensor<47x38x51xf32>) -> !spirv.arm.tensor<47x38x51xf32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<47x38x51xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_sigmoid_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<28x43x45xf32>) -> !spirv.arm.tensor<28x43x45xf32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "sigmoid_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<28x43x45xf32>):
      %0 = "spirv.Tosa.Sigmoid"(%arg0) : (!spirv.arm.tensor<28x43x45xf32>) -> !spirv.arm.tensor<28x43x45xf32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<28x43x45xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_tanh_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<46x50x36xf16>) -> !spirv.arm.tensor<46x50x36xf16>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "tanh_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<46x50x36xf16>):
      %0 = "spirv.Tosa.Tanh"(%arg0) : (!spirv.arm.tensor<46x50x36xf16>) -> !spirv.arm.tensor<46x50x36xf16>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<46x50x36xf16>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_add_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<4x7x3x10xi32>, !spirv.arm.tensor<4x7x3x1xi32>) -> !spirv.arm.tensor<4x7x3x10xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "add_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<4x7x3x10xi32>, %arg1: !spirv.arm.tensor<4x7x3x1xi32>):
      %0 = "spirv.Tosa.Add"(%arg0, %arg1) : (!spirv.arm.tensor<4x7x3x10xi32>, !spirv.arm.tensor<4x7x3x1xi32>) -> !spirv.arm.tensor<4x7x3x10xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<4x7x3x10xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_arithmetic_right_shift_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x4xi16>, !spirv.arm.tensor<3x4xi16>) -> !spirv.arm.tensor<3x4xi16>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "arithmetic_right_shift_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x4xi16>, %arg1: !spirv.arm.tensor<3x4xi16>):
      %0 = "spirv.Tosa.ArithmeticRightShift"(%arg0, %arg1) <{round = true}> : (!spirv.arm.tensor<1x4xi16>, !spirv.arm.tensor<3x4xi16>) -> !spirv.arm.tensor<3x4xi16>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<3x4xi16>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_bitwiseand_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<4x1x7x12xi16>, !spirv.arm.tensor<4x13x7x12xi16>) -> !spirv.arm.tensor<4x13x7x12xi16>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "bitwiseand_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<4x1x7x12xi16>, %arg1: !spirv.arm.tensor<4x13x7x12xi16>):
      %0 = "spirv.Tosa.BitwiseAnd"(%arg0, %arg1) : (!spirv.arm.tensor<4x1x7x12xi16>, !spirv.arm.tensor<4x13x7x12xi16>) -> !spirv.arm.tensor<4x13x7x12xi16>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<4x13x7x12xi16>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_bitwiseor_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<11x30x23xi32>, !spirv.arm.tensor<1x30x23xi32>) -> !spirv.arm.tensor<11x30x23xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "bitwiseor_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<11x30x23xi32>, %arg1: !spirv.arm.tensor<1x30x23xi32>):
      %0 = "spirv.Tosa.BitwiseOr"(%arg0, %arg1) : (!spirv.arm.tensor<11x30x23xi32>, !spirv.arm.tensor<1x30x23xi32>) -> !spirv.arm.tensor<11x30x23xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<11x30x23xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_bitwisexor_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<4x8x13x9xi16>, !spirv.arm.tensor<4x8x1x9xi16>) -> !spirv.arm.tensor<4x8x13x9xi16>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "bitwisexor_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<4x8x13x9xi16>, %arg1: !spirv.arm.tensor<4x8x1x9xi16>):
      %0 = "spirv.Tosa.BitwiseXor"(%arg0, %arg1) : (!spirv.arm.tensor<4x8x13x9xi16>, !spirv.arm.tensor<4x8x1x9xi16>) -> !spirv.arm.tensor<4x8x13x9xi16>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<4x8x13x9xi16>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_intdiv_any"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x65533x1xi32>, !spirv.arm.tensor<2x65533x1xi32>) -> !spirv.arm.tensor<2x65533x1xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "intdiv_any"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x65533x1xi32>, %arg1: !spirv.arm.tensor<2x65533x1xi32>):
      %0 = "spirv.Tosa.IntDiv"(%arg0, %arg1) : (!spirv.arm.tensor<1x65533x1xi32>, !spirv.arm.tensor<2x65533x1xi32>) -> !spirv.arm.tensor<2x65533x1xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x65533x1xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_logicaland_any"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x1x7x11xi1>, !spirv.arm.tensor<2x4x7x11xi1>) -> !spirv.arm.tensor<2x4x7x11xi1>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "logicaland_any"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x1x7x11xi1>, %arg1: !spirv.arm.tensor<2x4x7x11xi1>):
      %0 = "spirv.Tosa.LogicalAnd"(%arg0, %arg1) : (!spirv.arm.tensor<2x1x7x11xi1>, !spirv.arm.tensor<2x4x7x11xi1>) -> !spirv.arm.tensor<2x4x7x11xi1>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x4x7x11xi1>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_logicalleftshift_any"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<7x1x11x4xi8>, !spirv.arm.tensor<7x8x11x4xi8>) -> !spirv.arm.tensor<7x8x11x4xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "logicalleftshift_any"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<7x1x11x4xi8>, %arg1: !spirv.arm.tensor<7x8x11x4xi8>):
      %0 = "spirv.Tosa.LogicalLeftShift"(%arg0, %arg1) : (!spirv.arm.tensor<7x1x11x4xi8>, !spirv.arm.tensor<7x8x11x4xi8>) -> !spirv.arm.tensor<7x8x11x4xi8>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<7x8x11x4xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_logicalrightshift_any"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<6x13x1x19xi8>, !spirv.arm.tensor<6x13x6x19xi8>) -> !spirv.arm.tensor<6x13x6x19xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "logicalrightshift_any"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<6x13x1x19xi8>, %arg1: !spirv.arm.tensor<6x13x6x19xi8>):
      %0 = "spirv.Tosa.LogicalRightShift"(%arg0, %arg1) : (!spirv.arm.tensor<6x13x1x19xi8>, !spirv.arm.tensor<6x13x6x19xi8>) -> !spirv.arm.tensor<6x13x6x19xi8>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<6x13x6x19xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_logicalor_any"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<3x6x12x5xi1>, !spirv.arm.tensor<3x6x1x5xi1>) -> !spirv.arm.tensor<3x6x12x5xi1>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "logicalor_any"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<3x6x12x5xi1>, %arg1: !spirv.arm.tensor<3x6x1x5xi1>):
      %0 = "spirv.Tosa.LogicalOr"(%arg0, %arg1) : (!spirv.arm.tensor<3x6x12x5xi1>, !spirv.arm.tensor<3x6x1x5xi1>) -> !spirv.arm.tensor<3x6x12x5xi1>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<3x6x12x5xi1>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_logicalxor_any"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<11x4x9x12xi1>, !spirv.arm.tensor<11x4x9x1xi1>) -> !spirv.arm.tensor<11x4x9x12xi1>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "logicalxor_any"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<11x4x9x12xi1>, %arg1: !spirv.arm.tensor<11x4x9x1xi1>):
      %0 = "spirv.Tosa.LogicalXor"(%arg0, %arg1) : (!spirv.arm.tensor<11x4x9x12xi1>, !spirv.arm.tensor<11x4x9x1xi1>) -> !spirv.arm.tensor<11x4x9x12xi1>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<11x4x9x12xi1>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_maximum_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x2x65533x1xi32>, !spirv.arm.tensor<1x2x65533x2xi32>) -> !spirv.arm.tensor<1x2x65533x2xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "maximum_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x2x65533x1xi32>, %arg1: !spirv.arm.tensor<1x2x65533x2xi32>):
      %0 = "spirv.Tosa.Maximum"(%arg0, %arg1) <{nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<1x2x65533x1xi32>, !spirv.arm.tensor<1x2x65533x2xi32>) -> !spirv.arm.tensor<1x2x65533x2xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<1x2x65533x2xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_minimum_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<15x2x10x11xi32>, !spirv.arm.tensor<15x1x10x11xi32>) -> !spirv.arm.tensor<15x2x10x11xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "minimum_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<15x2x10x11xi32>, %arg1: !spirv.arm.tensor<15x1x10x11xi32>):
      %0 = "spirv.Tosa.Minimum"(%arg0, %arg1) <{nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<15x2x10x11xi32>, !spirv.arm.tensor<15x1x10x11xi32>) -> !spirv.arm.tensor<15x2x10x11xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<15x2x10x11xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_mul_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x4xi32>, !spirv.arm.tensor<2x1xi32>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<2x4xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}], sym_name = "mul_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x4xi32>, %arg1: !spirv.arm.tensor<2x1xi32>, %arg2: !spirv.arm.tensor<1xi8>):
      %0 = "spirv.Tosa.Mul"(%arg0, %arg1, %arg2) : (!spirv.arm.tensor<2x4xi32>, !spirv.arm.tensor<2x1xi32>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<2x4xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x4xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_pow_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x52x53xf16>, !spirv.arm.tensor<44x52x53xf16>) -> !spirv.arm.tensor<44x52x53xf16>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "pow_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x52x53xf16>, %arg1: !spirv.arm.tensor<44x52x53xf16>):
      %0 = "spirv.Tosa.Pow"(%arg0, %arg1) : (!spirv.arm.tensor<1x52x53xf16>, !spirv.arm.tensor<44x52x53xf16>) -> !spirv.arm.tensor<44x52x53xf16>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<44x52x53xf16>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_sub_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<6x10x6x6xi32>, !spirv.arm.tensor<1x10x6x6xi32>) -> !spirv.arm.tensor<6x10x6x6xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "sub_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<6x10x6x6xi32>, %arg1: !spirv.arm.tensor<1x10x6x6xi32>):
      %0 = "spirv.Tosa.Sub"(%arg0, %arg1) : (!spirv.arm.tensor<6x10x6x6xi32>, !spirv.arm.tensor<1x10x6x6xi32>) -> !spirv.arm.tensor<6x10x6x6xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<6x10x6x6xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_table_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<3x2xi8>, !spirv.arm.tensor<256xi8>) -> !spirv.arm.tensor<3x2xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "table_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<3x2xi8>, %arg1: !spirv.arm.tensor<256xi8>):
      %0 = "spirv.Tosa.Table"(%arg0, %arg1) : (!spirv.arm.tensor<3x2xi8>, !spirv.arm.tensor<256xi8>) -> !spirv.arm.tensor<3x2xi8>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<3x2xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_abs_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<5x1x4x4xi32>) -> !spirv.arm.tensor<5x1x4x4xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "abs_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<5x1x4x4xi32>):
      %0 = "spirv.Tosa.Abs"(%arg0) : (!spirv.arm.tensor<5x1x4x4xi32>) -> !spirv.arm.tensor<5x1x4x4xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<5x1x4x4xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_bitwisenot_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<12x56x50xi32>) -> !spirv.arm.tensor<12x56x50xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "bitwisenot_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<12x56x50xi32>):
      %0 = "spirv.Tosa.BitwiseNot"(%arg0) : (!spirv.arm.tensor<12x56x50xi32>) -> !spirv.arm.tensor<12x56x50xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<12x56x50xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_ceil_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<46x55x53xf16>) -> !spirv.arm.tensor<46x55x53xf16>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "ceil_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<46x55x53xf16>):
      %0 = "spirv.Tosa.Ceil"(%arg0) : (!spirv.arm.tensor<46x55x53xf16>) -> !spirv.arm.tensor<46x55x53xf16>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<46x55x53xf16>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_clz_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<14x10x7x5xi32>) -> !spirv.arm.tensor<14x10x7x5xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "clz_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<14x10x7x5xi32>):
      %0 = "spirv.Tosa.Clz"(%arg0) : (!spirv.arm.tensor<14x10x7x5xi32>) -> !spirv.arm.tensor<14x10x7x5xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<14x10x7x5xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_cos_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<44x49x51xf32>) -> !spirv.arm.tensor<44x49x51xf32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "cos_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<44x49x51xf32>):
      %0 = "spirv.Tosa.Cos"(%arg0) : (!spirv.arm.tensor<44x49x51xf32>) -> !spirv.arm.tensor<44x49x51xf32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<44x49x51xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_exp_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<37x53x47xf32>) -> !spirv.arm.tensor<37x53x47xf32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "exp_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<37x53x47xf32>):
      %0 = "spirv.Tosa.Exp"(%arg0) : (!spirv.arm.tensor<37x53x47xf32>) -> !spirv.arm.tensor<37x53x47xf32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<37x53x47xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_floor_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<40x52x42xf32>) -> !spirv.arm.tensor<40x52x42xf32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "floor_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<40x52x42xf32>):
      %0 = "spirv.Tosa.Floor"(%arg0) : (!spirv.arm.tensor<40x52x42xf32>) -> !spirv.arm.tensor<40x52x42xf32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<40x52x42xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_log_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<45x43x36xf16>) -> !spirv.arm.tensor<45x43x36xf16>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "log_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<45x43x36xf16>):
      %0 = "spirv.Tosa.Log"(%arg0) : (!spirv.arm.tensor<45x43x36xf16>) -> !spirv.arm.tensor<45x43x36xf16>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<45x43x36xf16>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_logicalnot_any"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<54x26x10xi1>) -> !spirv.arm.tensor<54x26x10xi1>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "logicalnot_any"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<54x26x10xi1>):
      %0 = "spirv.Tosa.LogicalNot"(%arg0) : (!spirv.arm.tensor<54x26x10xi1>) -> !spirv.arm.tensor<54x26x10xi1>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<54x26x10xi1>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_negate_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x3xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<2x3xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}], sym_name = "negate_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x3xi8>, %arg1: !spirv.arm.tensor<1xi8>, %arg2: !spirv.arm.tensor<1xi8>):
      %0 = "spirv.Tosa.Negate"(%arg0, %arg1, %arg2) : (!spirv.arm.tensor<2x3xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<2x3xi8>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x3xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_reciprocal_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<38x47x44xf32>) -> !spirv.arm.tensor<38x47x44xf32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "reciprocal_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<38x47x44xf32>):
      %0 = "spirv.Tosa.Reciprocal"(%arg0) : (!spirv.arm.tensor<38x47x44xf32>) -> !spirv.arm.tensor<38x47x44xf32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<38x47x44xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_rsqrt_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<40x57x56xf32>) -> !spirv.arm.tensor<40x57x56xf32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "rsqrt_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<40x57x56xf32>):
      %0 = "spirv.Tosa.Rsqrt"(%arg0) : (!spirv.arm.tensor<40x57x56xf32>) -> !spirv.arm.tensor<40x57x56xf32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<40x57x56xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_sin_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<49x38x58xf16>) -> !spirv.arm.tensor<49x38x58xf16>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "sin_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<49x38x58xf16>):
      %0 = "spirv.Tosa.Sin"(%arg0) : (!spirv.arm.tensor<49x38x58xf16>) -> !spirv.arm.tensor<49x38x58xf16>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<49x38x58xf16>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_select_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x1xi1>, !spirv.arm.tensor<2x4xi8>, !spirv.arm.tensor<2x4xi8>) -> !spirv.arm.tensor<2x4xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}], sym_name = "select_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x1xi1>, %arg1: !spirv.arm.tensor<2x4xi8>, %arg2: !spirv.arm.tensor<2x4xi8>):
      %0 = "spirv.Tosa.Select"(%arg0, %arg1, %arg2) : (!spirv.arm.tensor<2x1xi1>, !spirv.arm.tensor<2x4xi8>, !spirv.arm.tensor<2x4xi8>) -> !spirv.arm.tensor<2x4xi8>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x4xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_equal_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<51x28x59xi32>, !spirv.arm.tensor<51x1x59xi32>) -> !spirv.arm.tensor<51x28x59xi1>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "equal_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<51x28x59xi32>, %arg1: !spirv.arm.tensor<51x1x59xi32>):
      %0 = "spirv.Tosa.Equal"(%arg0, %arg1) : (!spirv.arm.tensor<51x28x59xi32>, !spirv.arm.tensor<51x1x59xi32>) -> !spirv.arm.tensor<51x28x59xi1>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<51x28x59xi1>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_greater_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<11x10x10x2xi32>, !spirv.arm.tensor<11x10x10x1xi32>) -> !spirv.arm.tensor<11x10x10x2xi1>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "greater_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<11x10x10x2xi32>, %arg1: !spirv.arm.tensor<11x10x10x1xi32>):
      %0 = "spirv.Tosa.Greater"(%arg0, %arg1) : (!spirv.arm.tensor<11x10x10x2xi32>, !spirv.arm.tensor<11x10x10x1xi32>) -> !spirv.arm.tensor<11x10x10x2xi1>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<11x10x10x2xi1>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_greaterequal_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<10x17x7x1xi32>, !spirv.arm.tensor<10x17x7x16xi32>) -> !spirv.arm.tensor<10x17x7x16xi1>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "greaterequal_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<10x17x7x1xi32>, %arg1: !spirv.arm.tensor<10x17x7x16xi32>):
      %0 = "spirv.Tosa.GreaterEqual"(%arg0, %arg1) : (!spirv.arm.tensor<10x17x7x1xi32>, !spirv.arm.tensor<10x17x7x16xi32>) -> !spirv.arm.tensor<10x17x7x16xi1>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<10x17x7x16xi1>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_reduce_all"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x3x4xi1>) -> !spirv.arm.tensor<2x1x4xi1>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "reduce_all"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x3x4xi1>):
      %0 = "spirv.Tosa.ReduceAll"(%arg0) <{axis = 1 : i32}> : (!spirv.arm.tensor<2x3x4xi1>) -> !spirv.arm.tensor<2x1x4xi1>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x1x4xi1>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_reduce_any"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x3x4xi1>) -> !spirv.arm.tensor<2x1x4xi1>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "reduce_any"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x3x4xi1>):
      %0 = "spirv.Tosa.ReduceAny"(%arg0) <{axis = 1 : i32}> : (!spirv.arm.tensor<2x3x4xi1>) -> !spirv.arm.tensor<2x1x4xi1>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x1x4xi1>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_reduce_max_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x3x4xi8>) -> !spirv.arm.tensor<2x1x4xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "reduce_max_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x3x4xi8>):
      %0 = "spirv.Tosa.ReduceMax"(%arg0) <{axis = 1 : i32, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<2x3x4xi8>) -> !spirv.arm.tensor<2x1x4xi8>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x1x4xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_reduce_min_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x3x4xi8>) -> !spirv.arm.tensor<2x1x4xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "reduce_min_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x3x4xi8>):
      %0 = "spirv.Tosa.ReduceMin"(%arg0) <{axis = 1 : i32, nan_mode = #spirv.tosa_ext_nan_propagation_mode_type<Propagate>}> : (!spirv.arm.tensor<2x3x4xi8>) -> !spirv.arm.tensor<2x1x4xi8>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x1x4xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_reduce_product_fp"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x3x4xf32>) -> !spirv.arm.tensor<2x1x4xf32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "reduce_product_fp"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x3x4xf32>):
      %0 = "spirv.Tosa.ReduceProduct"(%arg0) <{axis = 1 : i32}> : (!spirv.arm.tensor<2x3x4xf32>) -> !spirv.arm.tensor<2x1x4xf32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x1x4xf32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_reduce_sum_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x3x4xi32>) -> !spirv.arm.tensor<2x1x4xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "reduce_sum_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x3x4xi32>):
      %0 = "spirv.Tosa.ReduceSum"(%arg0) <{axis = 1 : i32}> : (!spirv.arm.tensor<2x3x4xi32>) -> !spirv.arm.tensor<2x1x4xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x1x4xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_concat_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x3xi8>, !spirv.arm.tensor<2x4xi8>) -> !spirv.arm.tensor<2x7xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "concat_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x3xi8>, %arg1: !spirv.arm.tensor<2x4xi8>):
      %0 = "spirv.Tosa.Concat"(%arg0, %arg1) <{axis = 1 : i32}> : (!spirv.arm.tensor<2x3xi8>, !spirv.arm.tensor<2x4xi8>) -> !spirv.arm.tensor<2x7xi8>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x7xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_concat_split_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 5)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 6)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 7)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 8)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 9)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 10)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 11)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 12)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 13)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 14)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 15)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 16)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 17)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 18)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 19)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 20)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 21)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 22)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 23)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 24)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 25)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 26)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 27)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 28)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 29)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 30)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 31)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 32)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 33)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 34)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 35)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 36)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 37)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 38)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 39)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 40)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 41)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 42)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 43)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 44)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 45)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 46)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 47)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 48)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 49)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 50)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 51)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 52)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 53)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 54)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 55)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 56)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 57)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 58)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 59)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 60)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 61)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 62)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 63)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 64)>}], entry_point = true, function_type = (!spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<65xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 65)>}], sym_name = "concat_split_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1xi8>, %arg1: !spirv.arm.tensor<1xi8>, %arg2: !spirv.arm.tensor<1xi8>, %arg3: !spirv.arm.tensor<1xi8>, %arg4: !spirv.arm.tensor<1xi8>, %arg5: !spirv.arm.tensor<1xi8>, %arg6: !spirv.arm.tensor<1xi8>, %arg7: !spirv.arm.tensor<1xi8>, %arg8: !spirv.arm.tensor<1xi8>, %arg9: !spirv.arm.tensor<1xi8>, %arg10: !spirv.arm.tensor<1xi8>, %arg11: !spirv.arm.tensor<1xi8>, %arg12: !spirv.arm.tensor<1xi8>, %arg13: !spirv.arm.tensor<1xi8>, %arg14: !spirv.arm.tensor<1xi8>, %arg15: !spirv.arm.tensor<1xi8>, %arg16: !spirv.arm.tensor<1xi8>, %arg17: !spirv.arm.tensor<1xi8>, %arg18: !spirv.arm.tensor<1xi8>, %arg19: !spirv.arm.tensor<1xi8>, %arg20: !spirv.arm.tensor<1xi8>, %arg21: !spirv.arm.tensor<1xi8>, %arg22: !spirv.arm.tensor<1xi8>, %arg23: !spirv.arm.tensor<1xi8>, %arg24: !spirv.arm.tensor<1xi8>, %arg25: !spirv.arm.tensor<1xi8>, %arg26: !spirv.arm.tensor<1xi8>, %arg27: !spirv.arm.tensor<1xi8>, %arg28: !spirv.arm.tensor<1xi8>, %arg29: !spirv.arm.tensor<1xi8>, %arg30: !spirv.arm.tensor<1xi8>, %arg31: !spirv.arm.tensor<1xi8>, %arg32: !spirv.arm.tensor<1xi8>, %arg33: !spirv.arm.tensor<1xi8>, %arg34: !spirv.arm.tensor<1xi8>, %arg35: !spirv.arm.tensor<1xi8>, %arg36: !spirv.arm.tensor<1xi8>, %arg37: !spirv.arm.tensor<1xi8>, %arg38: !spirv.arm.tensor<1xi8>, %arg39: !spirv.arm.tensor<1xi8>, %arg40: !spirv.arm.tensor<1xi8>, %arg41: !spirv.arm.tensor<1xi8>, %arg42: !spirv.arm.tensor<1xi8>, %arg43: !spirv.arm.tensor<1xi8>, %arg44: !spirv.arm.tensor<1xi8>, %arg45: !spirv.arm.tensor<1xi8>, %arg46: !spirv.arm.tensor<1xi8>, %arg47: !spirv.arm.tensor<1xi8>, %arg48: !spirv.arm.tensor<1xi8>, %arg49: !spirv.arm.tensor<1xi8>, %arg50: !spirv.arm.tensor<1xi8>, %arg51: !spirv.arm.tensor<1xi8>, %arg52: !spirv.arm.tensor<1xi8>, %arg53: !spirv.arm.tensor<1xi8>, %arg54: !spirv.arm.tensor<1xi8>, %arg55: !spirv.arm.tensor<1xi8>, %arg56: !spirv.arm.tensor<1xi8>, %arg57: !spirv.arm.tensor<1xi8>, %arg58: !spirv.arm.tensor<1xi8>, %arg59: !spirv.arm.tensor<1xi8>, %arg60: !spirv.arm.tensor<1xi8>, %arg61: !spirv.arm.tensor<1xi8>, %arg62: !spirv.arm.tensor<1xi8>, %arg63: !spirv.arm.tensor<1xi8>, %arg64: !spirv.arm.tensor<1xi8>):
      %0 = "spirv.Tosa.Concat"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16, %arg17, %arg18, %arg19, %arg20, %arg21, %arg22, %arg23, %arg24, %arg25, %arg26, %arg27, %arg28, %arg29, %arg30, %arg31, %arg32, %arg33, %arg34, %arg35, %arg36, %arg37, %arg38, %arg39, %arg40, %arg41, %arg42, %arg43, %arg44, %arg45, %arg46, %arg47, %arg48, %arg49, %arg50, %arg51, %arg52, %arg53, %arg54, %arg55, %arg56, %arg57, %arg58, %arg59, %arg60, %arg61, %arg62, %arg63) <{axis = 0 : i32}> : (!spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<64xi8>
      %1 = "spirv.Tosa.Concat"(%0, %arg64) <{axis = 0 : i32}> : (!spirv.arm.tensor<64xi8>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<65xi8>
      "spirv.ARM.GraphOutputs"(%1) : (!spirv.arm.tensor<65xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_concat_split_dynamic"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<?xi8>) -> !spirv.arm.tensor<?xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "concat_split_dynamic"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<?xi8>):
      %0 = "spirv.Tosa.Concat"(%arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0) <{axis = 0 : i32}> : (!spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>) -> !spirv.arm.tensor<?xi8>
      %1 = "spirv.Tosa.Concat"(%0, %arg0) <{axis = 0 : i32}> : (!spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>) -> !spirv.arm.tensor<?xi8>
      "spirv.ARM.GraphOutputs"(%1) : (!spirv.arm.tensor<?xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_pad_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x2xi8>) -> !spirv.arm.tensor<4x8xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "pad_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x2xi8>):
      %0 = "spirv.Constant"() <{value = dense<[1, 2, 3, 3]> : !spirv.arm.tensor<4xi32>}> : () -> !spirv.arm.tensor<4xi32>
      %1 = "spirv.Constant"() <{value = dense<7> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
      %2 = "spirv.Tosa.Pad"(%arg0, %0, %1) : (!spirv.arm.tensor<1x2xi8>, !spirv.arm.tensor<4xi32>, !spirv.arm.tensor<1xi8>) -> !spirv.arm.tensor<4x8xi8>
      "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<4x8xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_reshape_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<25x6x29x35xi16>) -> !spirv.arm.tensor<125x6x7x29xi16>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "reshape_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<25x6x29x35xi16>):
      %0 = "spirv.Constant"() <{value = dense<[125, 6, 7, 29]> : !spirv.arm.tensor<4xi32>}> : () -> !spirv.arm.tensor<4xi32>
      %1 = "spirv.Tosa.Reshape"(%arg0, %0) : (!spirv.arm.tensor<25x6x29x35xi16>, !spirv.arm.tensor<4xi32>) -> !spirv.arm.tensor<125x6x7x29xi16>
      "spirv.ARM.GraphOutputs"(%1) : (!spirv.arm.tensor<125x6x7x29xi16>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_reverse_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<20x5x28x31xi32>) -> !spirv.arm.tensor<20x5x28x31xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "reverse_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<20x5x28x31xi32>):
      %0 = "spirv.Tosa.Reverse"(%arg0) <{axis = 2 : i32}> : (!spirv.arm.tensor<20x5x28x31xi32>) -> !spirv.arm.tensor<20x5x28x31xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<20x5x28x31xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_slice_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<32x19x41xi8>) -> !spirv.arm.tensor<21x5x2xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "slice_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<32x19x41xi8>):
      %0 = "spirv.Constant"() <{value = dense<[8, 11, 39]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
      %1 = "spirv.Constant"() <{value = dense<[21, 5, 2]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
      %2 = "spirv.Tosa.Slice"(%arg0, %0, %1) : (!spirv.arm.tensor<32x19x41xi8>, !spirv.arm.tensor<3xi32>, !spirv.arm.tensor<3xi32>) -> !spirv.arm.tensor<21x5x2xi8>
      "spirv.ARM.GraphOutputs"(%2) : (!spirv.arm.tensor<21x5x2xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_tile_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<10x28x21xi16>) -> !spirv.arm.tensor<10x28x63xi16>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "tile_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<10x28x21xi16>):
      %0 = "spirv.Constant"() <{value = dense<[1, 1, 3]> : !spirv.arm.tensor<3xi32>}> : () -> !spirv.arm.tensor<3xi32>
      %1 = "spirv.Tosa.Tile"(%arg0, %0) : (!spirv.arm.tensor<10x28x21xi16>, !spirv.arm.tensor<3xi32>) -> !spirv.arm.tensor<10x28x63xi16>
      "spirv.ARM.GraphOutputs"(%1) : (!spirv.arm.tensor<10x28x63xi16>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_transpose_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<14x28x1x61xi16>) -> !spirv.arm.tensor<1x14x28x61xi16>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "transpose_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<14x28x1x61xi16>):
      %0 = "spirv.Tosa.Transpose"(%arg0) <{perms = dense<[2, 0, 1, 3]> : !spirv.arm.tensor<4xi32>}> : (!spirv.arm.tensor<14x28x1x61xi16>) -> !spirv.arm.tensor<1x14x28x61xi16>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<1x14x28x61xi16>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_gather_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], entry_point = true, function_type = (!spirv.arm.tensor<31x11x45xi32>, !spirv.arm.tensor<31x15xi32>) -> !spirv.arm.tensor<31x15x45xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], sym_name = "gather_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<31x11x45xi32>, %arg1: !spirv.arm.tensor<31x15xi32>):
      %0 = "spirv.Tosa.Gather"(%arg0, %arg1) : (!spirv.arm.tensor<31x11x45xi32>, !spirv.arm.tensor<31x15xi32>) -> !spirv.arm.tensor<31x15x45xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<31x15x45xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_scatter_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}], entry_point = true, function_type = (!spirv.arm.tensor<34x28x54xi32>, !spirv.arm.tensor<34x18xi32>, !spirv.arm.tensor<34x18x54xi32>) -> !spirv.arm.tensor<34x28x54xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}], sym_name = "scatter_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<34x28x54xi32>, %arg1: !spirv.arm.tensor<34x18xi32>, %arg2: !spirv.arm.tensor<34x18x54xi32>):
      %0 = "spirv.Tosa.Scatter"(%arg0, %arg1, %arg2) : (!spirv.arm.tensor<34x28x54xi32>, !spirv.arm.tensor<34x18xi32>, !spirv.arm.tensor<34x18x54xi32>) -> !spirv.arm.tensor<34x28x54xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<34x28x54xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_resize_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<1x1x31x55xi8>) -> !spirv.arm.tensor<1x1x278x55xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "resize_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<1x1x31x55xi8>):
      %0 = "spirv.Constant"() <{value = dense<[16, 1, 9, 1]> : !spirv.arm.tensor<4xi32>}> : () -> !spirv.arm.tensor<4xi32>
      %1 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<2xi32>}> : () -> !spirv.arm.tensor<2xi32>
      %2 = "spirv.Constant"() <{value = dense<[0, 7]> : !spirv.arm.tensor<2xi32>}> : () -> !spirv.arm.tensor<2xi32>
      %3 = "spirv.Tosa.Resize"(%arg0, %0, %1, %2) <{mode = #spirv.tosa_ext_resize_mode_type<NearestNeighbor>}> : (!spirv.arm.tensor<1x1x31x55xi8>, !spirv.arm.tensor<4xi32>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<2xi32>) -> !spirv.arm.tensor<1x1x278x55xi8>
      "spirv.ARM.GraphOutputs"(%3) : (!spirv.arm.tensor<1x1x278x55xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_cast_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x3xi8>) -> !spirv.arm.tensor<2x3xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "cast_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x3xi8>):
      %0 = "spirv.Tosa.Cast"(%arg0) : (!spirv.arm.tensor<2x3xi8>) -> !spirv.arm.tensor<2x3xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x3xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_rescale_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x3xi16>) -> !spirv.arm.tensor<2x3xi16>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "rescale_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x3xi16>):
      %0 = "spirv.Constant"() <{value = dense<1073741824> : !spirv.arm.tensor<1xi32>}> : () -> !spirv.arm.tensor<1xi32>
      %1 = "spirv.Constant"() <{value = dense<30> : !spirv.arm.tensor<1xi8>}> : () -> !spirv.arm.tensor<1xi8>
      %2 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
      %3 = "spirv.Constant"() <{value = dense<0> : !spirv.arm.tensor<1xi16>}> : () -> !spirv.arm.tensor<1xi16>
      %4 = "spirv.Tosa.Rescale"(%arg0, %0, %1, %2, %3) <{input_unsigned = false, output_unsigned = false, per_channel = false, rounding_mode = #spirv.tosa_ext_rounding_mode_type<DoubleRound>, scale32 = true}> : (!spirv.arm.tensor<2x3xi16>, !spirv.arm.tensor<1xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<1xi16>) -> !spirv.arm.tensor<2x3xi16>
      "spirv.ARM.GraphOutputs"(%4) : (!spirv.arm.tensor<2x3xi16>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_const_int"}> ({
    "spirv.ARM.Graph"() <{entry_point = true, function_type = () -> !spirv.arm.tensor<2x3xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], sym_name = "const_int"}> ({
      %0 = "spirv.Constant"() <{value = dense<[[1, 2, 3], [4, 5, 6]]> : !spirv.arm.tensor<2x3xi8>}> : () -> !spirv.arm.tensor<2x3xi8>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2x3xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_graph_constant"}> ({
    "spirv.ARM.Graph"() <{entry_point = true, function_type = () -> !spirv.arm.tensor<17xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], sym_name = "graph_constant"}> ({
      %0 = "spirv.ARM.GraphConstant"() <{graph_constant_id = 7 : i32}> : () -> !spirv.arm.tensor<17xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<17xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_const_i4"}> ({
    "spirv.ARM.Graph"() <{entry_point = true, function_type = () -> !spirv.arm.tensor<2xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], sym_name = "const_i4"}> ({
      %0 = "spirv.Constant"() <{value = dense<[7, -8]> : !spirv.arm.tensor<2xi8>}> : () -> !spirv.arm.tensor<2xi8>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_const_i48"}> ({
    "spirv.ARM.Graph"() <{entry_point = true, function_type = () -> !spirv.arm.tensor<2xi64>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], sym_name = "const_i48"}> ({
      %0 = "spirv.Constant"() <{value = dense<[140737488355327, -140737488355328]> : !spirv.arm.tensor<2xi64>}> : () -> !spirv.arm.tensor<2xi64>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<2xi64>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_const_shape_empty"}> ({
    "spirv.ARM.Graph"() <{entry_point = true, function_type = () -> !spirv.arm.tensor<1xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], sym_name = "const_shape_empty"}> ({
      %0 = "spirv.Constant"() <{value = dense<1> : !spirv.arm.tensor<1xi32>}> : () -> !spirv.arm.tensor<1xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<1xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_graph_constant_shape"}> ({
    "spirv.ARM.Graph"() <{entry_point = true, function_type = () -> !spirv.arm.tensor<33xi32>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], sym_name = "graph_constant_shape"}> ({
      %0 = "spirv.ARM.GraphConstant"() <{graph_constant_id = 8 : i32}> : () -> !spirv.arm.tensor<33xi32>
      "spirv.ARM.GraphOutputs"(%0) : (!spirv.arm.tensor<33xi32>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "spirv.module"() <{addressing_model = #spirv.addressing_model<Logical>, memory_model = #spirv.memory_model<Vulkan>, sym_name = "_spirv_tosa_identity_int"}> ({
    "spirv.ARM.Graph"() <{arg_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}], entry_point = true, function_type = (!spirv.arm.tensor<2x3xi8>) -> !spirv.arm.tensor<2x3xi8>, res_attrs = [{spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}], sym_name = "identity_int"}> ({
    ^bb0(%arg0: !spirv.arm.tensor<2x3xi8>):
      "spirv.ARM.GraphOutputs"(%arg0) : (!spirv.arm.tensor<2x3xi8>) -> ()
    }) : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} : () -> ()
}) : () -> ()

