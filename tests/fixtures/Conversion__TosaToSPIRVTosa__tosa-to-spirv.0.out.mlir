module {
  spirv.module @_spirv_tosa_argmax_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @argmax_int(%arg0: !spirv.arm.tensor<2x3x4xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<2x4xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.ArgMax axis = 1, nan_mode = <Propagate>, %arg0 : !spirv.arm.tensor<2x3x4xi8> -> !spirv.arm.tensor<2x4xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x4xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_avg_pool2d_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @avg_pool2d_int(%arg0: !spirv.arm.tensor<1x4x4x1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) -> (!spirv.arm.tensor<1x2x2x1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.AvgPool2D kernel = [2, 2], stride = [2, 2], pad = [0, 0, 0, 0], acc_type = <INT32>, %arg0, %arg1, %arg2 : !spirv.arm.tensor<1x4x4x1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8> -> !spirv.arm.tensor<1x2x2x1xi8>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<1x2x2x1xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_conv2d_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @conv2d_int(%arg0: !spirv.arm.tensor<1x4x4x1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<2x3x3x1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.arm.tensor<2xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, %arg3: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}, %arg4: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4)>}) -> (!spirv.arm.tensor<1x2x2x2xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 5)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Conv2D pad = [0, 0, 0, 0], stride = [1, 1], dilation = [1, 1], acc_type = <INT32>, local_bound = false, %arg0, %arg1, %arg2, %arg3, %arg4 : !spirv.arm.tensor<1x4x4x1xi8>, !spirv.arm.tensor<2x3x3x1xi8>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8> -> !spirv.arm.tensor<1x2x2x2xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<1x2x2x2xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_conv3d_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @conv3d_int(%arg0: !spirv.arm.tensor<1x4x4x4x1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<2x2x2x2x1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.arm.tensor<2xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, %arg3: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}, %arg4: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4)>}) -> (!spirv.arm.tensor<1x3x3x3x2xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 5)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Conv3D pad = [0, 0, 0, 0, 0, 0], stride = [1, 1, 1], dilation = [1, 1, 1], acc_type = <INT32>, local_bound = false, %arg0, %arg1, %arg2, %arg3, %arg4 : !spirv.arm.tensor<1x4x4x4x1xi8>, !spirv.arm.tensor<2x2x2x2x1xi8>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8> -> !spirv.arm.tensor<1x3x3x3x2xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<1x3x3x3x2xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_depthwise_conv2d_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @depthwise_conv2d_int(%arg0: !spirv.arm.tensor<1x4x4x1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<3x3x1x2xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.arm.tensor<2xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, %arg3: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}, %arg4: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4)>}) -> (!spirv.arm.tensor<1x2x2x2xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 5)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.DepthwiseConv2D pad = [0, 0, 0, 0], stride = [1, 1], dilation = [1, 1], acc_type = <INT32>, local_bound = false, %arg0, %arg1, %arg2, %arg3, %arg4 : !spirv.arm.tensor<1x4x4x1xi8>, !spirv.arm.tensor<3x3x1x2xi8>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8> -> !spirv.arm.tensor<1x2x2x2xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<1x2x2x2xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_fft2d_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @fft2d_fp(%arg0: !spirv.arm.tensor<1x32x32xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<1x32x32xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<1x32x32xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, !spirv.arm.tensor<1x32x32xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.FFT2D inverse = true, local_bound = false, %arg0, %arg1 : !spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32> -> !spirv.struct<(!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>)>
      %1 = spirv.CompositeExtract %0[0 : i32] : !spirv.struct<(!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>)>
      %2 = spirv.CompositeExtract %0[1 : i32] : !spirv.struct<(!spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>)>
      spirv.ARM.GraphOutputs %1, %2 : !spirv.arm.tensor<1x32x32xf32>, !spirv.arm.tensor<1x32x32xf32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_matmul_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @matmul_int(%arg0: !spirv.arm.tensor<1x2x3xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<1x3x4xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, %arg3: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}) -> (!spirv.arm.tensor<1x2x4xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.MatMul %arg0, %arg1, %arg2, %arg3 : !spirv.arm.tensor<1x2x3xi8>, !spirv.arm.tensor<1x3x4xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8> -> !spirv.arm.tensor<1x2x4xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<1x2x4xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_max_pool2d_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @max_pool2d_fp(%arg0: !spirv.arm.tensor<1x4x4x1xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<1x2x2x1xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.MaxPool2D kernel = [2, 2], stride = [2, 2], pad = [0, 0, 0, 0], nan_mode = <Propagate>, %arg0 : !spirv.arm.tensor<1x4x4x1xf32> -> !spirv.arm.tensor<1x2x2x1xf32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<1x2x2x1xf32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_rfft2d_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @rfft2d_fp(%arg0: !spirv.arm.tensor<1x32x32xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<1x32x17xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, !spirv.arm.tensor<1x32x17xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.RFFT2D local_bound = false, %arg0 : !spirv.arm.tensor<1x32x32xf32> -> !spirv.struct<(!spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>)>
      %1 = spirv.CompositeExtract %0[0 : i32] : !spirv.struct<(!spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>)>
      %2 = spirv.CompositeExtract %0[1 : i32] : !spirv.struct<(!spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>)>
      spirv.ARM.GraphOutputs %1, %2 : !spirv.arm.tensor<1x32x17xf32>, !spirv.arm.tensor<1x32x17xf32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_transpose_conv2d_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @transpose_conv2d_int(%arg0: !spirv.arm.tensor<1x2x2x1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<2x3x3x1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.arm.tensor<2xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, %arg3: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}, %arg4: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4)>}) -> (!spirv.arm.tensor<1x4x4x2xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 5)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.TransposeConv2D out_pad = [0, 0, 0, 0], stride = [1, 1], acc_type = <INT32>, local_bound = false, %arg0, %arg1, %arg2, %arg3, %arg4 : !spirv.arm.tensor<1x2x2x1xi8>, !spirv.arm.tensor<2x3x3x1xi8>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8> -> !spirv.arm.tensor<1x4x4x2xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<1x4x4x2xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_clamp_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @clamp_int(%arg0: !spirv.arm.tensor<4x8xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<4x8xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Clamp min_val = -2 : i8, max_val = 3 : i8, nan_mode = <Propagate>, %arg0 : !spirv.arm.tensor<4x8xi8> -> !spirv.arm.tensor<4x8xi8>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<4x8xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_erf_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @erf_fp(%arg0: !spirv.arm.tensor<47x38x51xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<47x38x51xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Erf %arg0 : !spirv.arm.tensor<47x38x51xf32> -> !spirv.arm.tensor<47x38x51xf32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<47x38x51xf32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_sigmoid_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @sigmoid_fp(%arg0: !spirv.arm.tensor<28x43x45xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<28x43x45xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Sigmoid %arg0 : !spirv.arm.tensor<28x43x45xf32> -> !spirv.arm.tensor<28x43x45xf32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<28x43x45xf32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_tanh_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @tanh_fp(%arg0: !spirv.arm.tensor<46x50x36xf16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<46x50x36xf16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Tanh %arg0 : !spirv.arm.tensor<46x50x36xf16> -> !spirv.arm.tensor<46x50x36xf16>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<46x50x36xf16>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_add_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @add_int(%arg0: !spirv.arm.tensor<4x7x3x10xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<4x7x3x1xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<4x7x3x10xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Add %arg0, %arg1 : !spirv.arm.tensor<4x7x3x10xi32>, !spirv.arm.tensor<4x7x3x1xi32> -> !spirv.arm.tensor<4x7x3x10xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<4x7x3x10xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_arithmetic_right_shift_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @arithmetic_right_shift_int(%arg0: !spirv.arm.tensor<1x4xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<3x4xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<3x4xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.ArithmeticRightShift round = true, %arg0, %arg1 : !spirv.arm.tensor<1x4xi16>, !spirv.arm.tensor<3x4xi16> -> !spirv.arm.tensor<3x4xi16>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<3x4xi16>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_bitwiseand_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @bitwiseand_int(%arg0: !spirv.arm.tensor<4x1x7x12xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<4x13x7x12xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<4x13x7x12xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.BitwiseAnd %arg0, %arg1 : !spirv.arm.tensor<4x1x7x12xi16>, !spirv.arm.tensor<4x13x7x12xi16> -> !spirv.arm.tensor<4x13x7x12xi16>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<4x13x7x12xi16>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_bitwiseor_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @bitwiseor_int(%arg0: !spirv.arm.tensor<11x30x23xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<1x30x23xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<11x30x23xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.BitwiseOr %arg0, %arg1 : !spirv.arm.tensor<11x30x23xi32>, !spirv.arm.tensor<1x30x23xi32> -> !spirv.arm.tensor<11x30x23xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<11x30x23xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_bitwisexor_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @bitwisexor_int(%arg0: !spirv.arm.tensor<4x8x13x9xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<4x8x1x9xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<4x8x13x9xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.BitwiseXor %arg0, %arg1 : !spirv.arm.tensor<4x8x13x9xi16>, !spirv.arm.tensor<4x8x1x9xi16> -> !spirv.arm.tensor<4x8x13x9xi16>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<4x8x13x9xi16>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_intdiv_any Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @intdiv_any(%arg0: !spirv.arm.tensor<1x65533x1xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<2x65533x1xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<2x65533x1xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.IntDiv %arg0, %arg1 : !spirv.arm.tensor<1x65533x1xi32>, !spirv.arm.tensor<2x65533x1xi32> -> !spirv.arm.tensor<2x65533x1xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x65533x1xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_logicaland_any Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @logicaland_any(%arg0: !spirv.arm.tensor<2x1x7x11xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<2x4x7x11xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<2x4x7x11xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.LogicalAnd %arg0, %arg1 : !spirv.arm.tensor<2x1x7x11xi1>, !spirv.arm.tensor<2x4x7x11xi1> -> !spirv.arm.tensor<2x4x7x11xi1>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x4x7x11xi1>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_logicalleftshift_any Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @logicalleftshift_any(%arg0: !spirv.arm.tensor<7x1x11x4xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<7x8x11x4xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<7x8x11x4xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.LogicalLeftShift %arg0, %arg1 : !spirv.arm.tensor<7x1x11x4xi8>, !spirv.arm.tensor<7x8x11x4xi8> -> !spirv.arm.tensor<7x8x11x4xi8>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<7x8x11x4xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_logicalrightshift_any Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @logicalrightshift_any(%arg0: !spirv.arm.tensor<6x13x1x19xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<6x13x6x19xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<6x13x6x19xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.LogicalRightShift %arg0, %arg1 : !spirv.arm.tensor<6x13x1x19xi8>, !spirv.arm.tensor<6x13x6x19xi8> -> !spirv.arm.tensor<6x13x6x19xi8>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<6x13x6x19xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_logicalor_any Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @logicalor_any(%arg0: !spirv.arm.tensor<3x6x12x5xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<3x6x1x5xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<3x6x12x5xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.LogicalOr %arg0, %arg1 : !spirv.arm.tensor<3x6x12x5xi1>, !spirv.arm.tensor<3x6x1x5xi1> -> !spirv.arm.tensor<3x6x12x5xi1>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<3x6x12x5xi1>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_logicalxor_any Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @logicalxor_any(%arg0: !spirv.arm.tensor<11x4x9x12xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<11x4x9x1xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<11x4x9x12xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.LogicalXor %arg0, %arg1 : !spirv.arm.tensor<11x4x9x12xi1>, !spirv.arm.tensor<11x4x9x1xi1> -> !spirv.arm.tensor<11x4x9x12xi1>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<11x4x9x12xi1>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_maximum_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @maximum_int(%arg0: !spirv.arm.tensor<1x2x65533x1xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<1x2x65533x2xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<1x2x65533x2xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Maximum nan_mode = <Propagate>, %arg0, %arg1 : !spirv.arm.tensor<1x2x65533x1xi32>, !spirv.arm.tensor<1x2x65533x2xi32> -> !spirv.arm.tensor<1x2x65533x2xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<1x2x65533x2xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_minimum_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @minimum_int(%arg0: !spirv.arm.tensor<15x2x10x11xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<15x1x10x11xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<15x2x10x11xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Minimum nan_mode = <Propagate>, %arg0, %arg1 : !spirv.arm.tensor<15x2x10x11xi32>, !spirv.arm.tensor<15x1x10x11xi32> -> !spirv.arm.tensor<15x2x10x11xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<15x2x10x11xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_mul_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @mul_int(%arg0: !spirv.arm.tensor<2x4xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<2x1xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) -> (!spirv.arm.tensor<2x4xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Mul %arg0, %arg1, %arg2 : !spirv.arm.tensor<2x4xi32>, !spirv.arm.tensor<2x1xi32>, !spirv.arm.tensor<1xi8> -> !spirv.arm.tensor<2x4xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x4xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_pow_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @pow_fp(%arg0: !spirv.arm.tensor<1x52x53xf16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<44x52x53xf16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<44x52x53xf16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Pow %arg0, %arg1 : !spirv.arm.tensor<1x52x53xf16>, !spirv.arm.tensor<44x52x53xf16> -> !spirv.arm.tensor<44x52x53xf16>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<44x52x53xf16>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_sub_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @sub_int(%arg0: !spirv.arm.tensor<6x10x6x6xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<1x10x6x6xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<6x10x6x6xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Sub %arg0, %arg1 : !spirv.arm.tensor<6x10x6x6xi32>, !spirv.arm.tensor<1x10x6x6xi32> -> !spirv.arm.tensor<6x10x6x6xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<6x10x6x6xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_table_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @table_int(%arg0: !spirv.arm.tensor<3x2xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<256xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<3x2xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Table %arg0, %arg1 : !spirv.arm.tensor<3x2xi8>, !spirv.arm.tensor<256xi8> -> !spirv.arm.tensor<3x2xi8>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<3x2xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_abs_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @abs_int(%arg0: !spirv.arm.tensor<5x1x4x4xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<5x1x4x4xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Abs %arg0 : !spirv.arm.tensor<5x1x4x4xi32> -> !spirv.arm.tensor<5x1x4x4xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<5x1x4x4xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_bitwisenot_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @bitwisenot_int(%arg0: !spirv.arm.tensor<12x56x50xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<12x56x50xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.BitwiseNot %arg0 : !spirv.arm.tensor<12x56x50xi32> -> !spirv.arm.tensor<12x56x50xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<12x56x50xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_ceil_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @ceil_fp(%arg0: !spirv.arm.tensor<46x55x53xf16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<46x55x53xf16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Ceil %arg0 : !spirv.arm.tensor<46x55x53xf16> -> !spirv.arm.tensor<46x55x53xf16>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<46x55x53xf16>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_clz_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @clz_int(%arg0: !spirv.arm.tensor<14x10x7x5xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<14x10x7x5xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Clz %arg0 : !spirv.arm.tensor<14x10x7x5xi32> -> !spirv.arm.tensor<14x10x7x5xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<14x10x7x5xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_cos_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @cos_fp(%arg0: !spirv.arm.tensor<44x49x51xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<44x49x51xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Cos %arg0 : !spirv.arm.tensor<44x49x51xf32> -> !spirv.arm.tensor<44x49x51xf32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<44x49x51xf32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_exp_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @exp_fp(%arg0: !spirv.arm.tensor<37x53x47xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<37x53x47xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Exp %arg0 : !spirv.arm.tensor<37x53x47xf32> -> !spirv.arm.tensor<37x53x47xf32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<37x53x47xf32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_floor_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @floor_fp(%arg0: !spirv.arm.tensor<40x52x42xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<40x52x42xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Floor %arg0 : !spirv.arm.tensor<40x52x42xf32> -> !spirv.arm.tensor<40x52x42xf32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<40x52x42xf32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_log_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @log_fp(%arg0: !spirv.arm.tensor<45x43x36xf16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<45x43x36xf16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Log %arg0 : !spirv.arm.tensor<45x43x36xf16> -> !spirv.arm.tensor<45x43x36xf16>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<45x43x36xf16>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_logicalnot_any Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @logicalnot_any(%arg0: !spirv.arm.tensor<54x26x10xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<54x26x10xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.LogicalNot %arg0 : !spirv.arm.tensor<54x26x10xi1> -> !spirv.arm.tensor<54x26x10xi1>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<54x26x10xi1>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_negate_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @negate_int(%arg0: !spirv.arm.tensor<2x3xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) -> (!spirv.arm.tensor<2x3xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Negate %arg0, %arg1, %arg2 : !spirv.arm.tensor<2x3xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8> -> !spirv.arm.tensor<2x3xi8>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x3xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_reciprocal_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @reciprocal_fp(%arg0: !spirv.arm.tensor<38x47x44xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<38x47x44xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Reciprocal %arg0 : !spirv.arm.tensor<38x47x44xf32> -> !spirv.arm.tensor<38x47x44xf32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<38x47x44xf32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_rsqrt_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @rsqrt_fp(%arg0: !spirv.arm.tensor<40x57x56xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<40x57x56xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Rsqrt %arg0 : !spirv.arm.tensor<40x57x56xf32> -> !spirv.arm.tensor<40x57x56xf32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<40x57x56xf32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_sin_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @sin_fp(%arg0: !spirv.arm.tensor<49x38x58xf16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<49x38x58xf16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Sin %arg0 : !spirv.arm.tensor<49x38x58xf16> -> !spirv.arm.tensor<49x38x58xf16>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<49x38x58xf16>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_select_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @select_int(%arg0: !spirv.arm.tensor<2x1xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<2x4xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.arm.tensor<2x4xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) -> (!spirv.arm.tensor<2x4xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Select %arg0, %arg1, %arg2 : !spirv.arm.tensor<2x1xi1>, !spirv.arm.tensor<2x4xi8>, !spirv.arm.tensor<2x4xi8> -> !spirv.arm.tensor<2x4xi8>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x4xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_equal_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @equal_int(%arg0: !spirv.arm.tensor<51x28x59xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<51x1x59xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<51x28x59xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Equal %arg0, %arg1 : !spirv.arm.tensor<51x28x59xi32>, !spirv.arm.tensor<51x1x59xi32> -> !spirv.arm.tensor<51x28x59xi1>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<51x28x59xi1>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_greater_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @greater_int(%arg0: !spirv.arm.tensor<11x10x10x2xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<11x10x10x1xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<11x10x10x2xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Greater %arg0, %arg1 : !spirv.arm.tensor<11x10x10x2xi32>, !spirv.arm.tensor<11x10x10x1xi32> -> !spirv.arm.tensor<11x10x10x2xi1>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<11x10x10x2xi1>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_greaterequal_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @greaterequal_int(%arg0: !spirv.arm.tensor<10x17x7x1xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<10x17x7x16xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<10x17x7x16xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.GreaterEqual %arg0, %arg1 : !spirv.arm.tensor<10x17x7x1xi32>, !spirv.arm.tensor<10x17x7x16xi32> -> !spirv.arm.tensor<10x17x7x16xi1>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<10x17x7x16xi1>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_reduce_all Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @reduce_all(%arg0: !spirv.arm.tensor<2x3x4xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<2x1x4xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.ReduceAll axis = 1, %arg0 : !spirv.arm.tensor<2x3x4xi1> -> !spirv.arm.tensor<2x1x4xi1>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x1x4xi1>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_reduce_any Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @reduce_any(%arg0: !spirv.arm.tensor<2x3x4xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<2x1x4xi1> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.ReduceAny axis = 1, %arg0 : !spirv.arm.tensor<2x3x4xi1> -> !spirv.arm.tensor<2x1x4xi1>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x1x4xi1>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_reduce_max_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @reduce_max_int(%arg0: !spirv.arm.tensor<2x3x4xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<2x1x4xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.ReduceMax axis = 1, nan_mode = <Propagate>, %arg0 : !spirv.arm.tensor<2x3x4xi8> -> !spirv.arm.tensor<2x1x4xi8>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x1x4xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_reduce_min_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @reduce_min_int(%arg0: !spirv.arm.tensor<2x3x4xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<2x1x4xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.ReduceMin axis = 1, nan_mode = <Propagate>, %arg0 : !spirv.arm.tensor<2x3x4xi8> -> !spirv.arm.tensor<2x1x4xi8>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x1x4xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_reduce_product_fp Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @reduce_product_fp(%arg0: !spirv.arm.tensor<2x3x4xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<2x1x4xf32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.ReduceProduct axis = 1, %arg0 : !spirv.arm.tensor<2x3x4xf32> -> !spirv.arm.tensor<2x1x4xf32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x1x4xf32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_reduce_sum_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @reduce_sum_int(%arg0: !spirv.arm.tensor<2x3x4xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<2x1x4xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.ReduceSum axis = 1, %arg0 : !spirv.arm.tensor<2x3x4xi32> -> !spirv.arm.tensor<2x1x4xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x1x4xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_concat_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @concat_int(%arg0: !spirv.arm.tensor<2x3xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<2x4xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<2x7xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Concat axis = 1, %arg0, %arg1 : !spirv.arm.tensor<2x3xi8>, !spirv.arm.tensor<2x4xi8> -> !spirv.arm.tensor<2x7xi8>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x7xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_concat_split_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @concat_split_int(%arg0: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}, %arg3: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}, %arg4: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 4)>}, %arg5: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 5)>}, %arg6: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 6)>}, %arg7: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 7)>}, %arg8: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 8)>}, %arg9: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 9)>}, %arg10: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 10)>}, %arg11: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 11)>}, %arg12: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 12)>}, %arg13: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 13)>}, %arg14: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 14)>}, %arg15: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 15)>}, %arg16: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 16)>}, %arg17: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 17)>}, %arg18: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 18)>}, %arg19: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 19)>}, %arg20: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 20)>}, %arg21: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 21)>}, %arg22: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 22)>}, %arg23: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 23)>}, %arg24: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 24)>}, %arg25: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 25)>}, %arg26: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 26)>}, %arg27: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 27)>}, %arg28: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 28)>}, %arg29: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 29)>}, %arg30: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 30)>}, %arg31: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 31)>}, %arg32: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 32)>}, %arg33: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 33)>}, %arg34: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 34)>}, %arg35: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 35)>}, %arg36: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 36)>}, %arg37: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 37)>}, %arg38: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 38)>}, %arg39: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 39)>}, %arg40: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 40)>}, %arg41: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 41)>}, %arg42: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 42)>}, %arg43: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 43)>}, %arg44: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 44)>}, %arg45: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 45)>}, %arg46: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 46)>}, %arg47: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 47)>}, %arg48: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 48)>}, %arg49: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 49)>}, %arg50: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 50)>}, %arg51: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 51)>}, %arg52: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 52)>}, %arg53: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 53)>}, %arg54: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 54)>}, %arg55: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 55)>}, %arg56: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 56)>}, %arg57: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 57)>}, %arg58: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 58)>}, %arg59: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 59)>}, %arg60: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 60)>}, %arg61: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 61)>}, %arg62: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 62)>}, %arg63: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 63)>}, %arg64: !spirv.arm.tensor<1xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 64)>}) -> (!spirv.arm.tensor<65xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 65)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Concat axis = 0, %arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8, %arg9, %arg10, %arg11, %arg12, %arg13, %arg14, %arg15, %arg16, %arg17, %arg18, %arg19, %arg20, %arg21, %arg22, %arg23, %arg24, %arg25, %arg26, %arg27, %arg28, %arg29, %arg30, %arg31, %arg32, %arg33, %arg34, %arg35, %arg36, %arg37, %arg38, %arg39, %arg40, %arg41, %arg42, %arg43, %arg44, %arg45, %arg46, %arg47, %arg48, %arg49, %arg50, %arg51, %arg52, %arg53, %arg54, %arg55, %arg56, %arg57, %arg58, %arg59, %arg60, %arg61, %arg62, %arg63 : !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi8> -> !spirv.arm.tensor<64xi8>
      %1 = spirv.Tosa.Concat axis = 0, %0, %arg64 : !spirv.arm.tensor<64xi8>, !spirv.arm.tensor<1xi8> -> !spirv.arm.tensor<65xi8>
      spirv.ARM.GraphOutputs %1 : !spirv.arm.tensor<65xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_concat_split_dynamic Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @concat_split_dynamic(%arg0: !spirv.arm.tensor<?xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<?xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Concat axis = 0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0 : !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8> -> !spirv.arm.tensor<?xi8>
      %1 = spirv.Tosa.Concat axis = 0, %0, %arg0 : !spirv.arm.tensor<?xi8>, !spirv.arm.tensor<?xi8> -> !spirv.arm.tensor<?xi8>
      spirv.ARM.GraphOutputs %1 : !spirv.arm.tensor<?xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_pad_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @pad_int(%arg0: !spirv.arm.tensor<1x2xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<4x8xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %cst = spirv.Constant dense<[1, 2, 3, 3]> : !spirv.arm.tensor<4xi32>
      %cst_0 = spirv.Constant dense<7> : !spirv.arm.tensor<1xi8>
      %0 = spirv.Tosa.Pad %arg0, %cst, %cst_0 : !spirv.arm.tensor<1x2xi8>, !spirv.arm.tensor<4xi32>, !spirv.arm.tensor<1xi8> -> !spirv.arm.tensor<4x8xi8>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<4x8xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_reshape_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @reshape_int(%arg0: !spirv.arm.tensor<25x6x29x35xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<125x6x7x29xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %cst = spirv.Constant dense<[125, 6, 7, 29]> : !spirv.arm.tensor<4xi32>
      %0 = spirv.Tosa.Reshape %arg0, %cst : !spirv.arm.tensor<25x6x29x35xi16>, !spirv.arm.tensor<4xi32> -> !spirv.arm.tensor<125x6x7x29xi16>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<125x6x7x29xi16>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_reverse_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @reverse_int(%arg0: !spirv.arm.tensor<20x5x28x31xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<20x5x28x31xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Reverse axis = 2, %arg0 : !spirv.arm.tensor<20x5x28x31xi32> -> !spirv.arm.tensor<20x5x28x31xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<20x5x28x31xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_slice_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @slice_int(%arg0: !spirv.arm.tensor<32x19x41xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<21x5x2xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %cst = spirv.Constant dense<[8, 11, 39]> : !spirv.arm.tensor<3xi32>
      %cst_0 = spirv.Constant dense<[21, 5, 2]> : !spirv.arm.tensor<3xi32>
      %0 = spirv.Tosa.Slice %arg0, %cst, %cst_0 : !spirv.arm.tensor<32x19x41xi8>, !spirv.arm.tensor<3xi32>, !spirv.arm.tensor<3xi32> -> !spirv.arm.tensor<21x5x2xi8>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<21x5x2xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_tile_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @tile_int(%arg0: !spirv.arm.tensor<10x28x21xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<10x28x63xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %cst = spirv.Constant dense<[1, 1, 3]> : !spirv.arm.tensor<3xi32>
      %0 = spirv.Tosa.Tile %arg0, %cst : !spirv.arm.tensor<10x28x21xi16>, !spirv.arm.tensor<3xi32> -> !spirv.arm.tensor<10x28x63xi16>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<10x28x63xi16>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_transpose_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @transpose_int(%arg0: !spirv.arm.tensor<14x28x1x61xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<1x14x28x61xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Transpose perms = [2, 0, 1, 3], %arg0 : !spirv.arm.tensor<14x28x1x61xi16> -> !spirv.arm.tensor<1x14x28x61xi16>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<1x14x28x61xi16>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_gather_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @gather_int(%arg0: !spirv.arm.tensor<31x11x45xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<31x15xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) -> (!spirv.arm.tensor<31x15x45xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Gather %arg0, %arg1 : !spirv.arm.tensor<31x11x45xi32>, !spirv.arm.tensor<31x15xi32> -> !spirv.arm.tensor<31x15x45xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<31x15x45xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_scatter_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @scatter_int(%arg0: !spirv.arm.tensor<34x28x54xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}, %arg1: !spirv.arm.tensor<34x18xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}, %arg2: !spirv.arm.tensor<34x18x54xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 2)>}) -> (!spirv.arm.tensor<34x28x54xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 3)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Scatter %arg0, %arg1, %arg2 : !spirv.arm.tensor<34x28x54xi32>, !spirv.arm.tensor<34x18xi32>, !spirv.arm.tensor<34x18x54xi32> -> !spirv.arm.tensor<34x28x54xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<34x28x54xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_resize_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @resize_int(%arg0: !spirv.arm.tensor<1x1x31x55xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<1x1x278x55xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %cst = spirv.Constant dense<[16, 1, 9, 1]> : !spirv.arm.tensor<4xi32>
      %cst_0 = spirv.Constant dense<0> : !spirv.arm.tensor<2xi32>
      %cst_1 = spirv.Constant dense<[0, 7]> : !spirv.arm.tensor<2xi32>
      %0 = spirv.Tosa.Resize mode = <NearestNeighbor>, %arg0, %cst, %cst_0, %cst_1 : !spirv.arm.tensor<1x1x31x55xi8>, !spirv.arm.tensor<4xi32>, !spirv.arm.tensor<2xi32>, !spirv.arm.tensor<2xi32> -> !spirv.arm.tensor<1x1x278x55xi8>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<1x1x278x55xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_cast_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @cast_int(%arg0: !spirv.arm.tensor<2x3xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<2x3xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %0 = spirv.Tosa.Cast %arg0 : !spirv.arm.tensor<2x3xi8> -> !spirv.arm.tensor<2x3xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x3xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_rescale_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @rescale_int(%arg0: !spirv.arm.tensor<2x3xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<2x3xi16> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      %cst = spirv.Constant dense<1073741824> : !spirv.arm.tensor<1xi32>
      %cst_0 = spirv.Constant dense<30> : !spirv.arm.tensor<1xi8>
      %cst_1 = spirv.Constant dense<0> : !spirv.arm.tensor<1xi16>
      %cst_2 = spirv.Constant dense<0> : !spirv.arm.tensor<1xi16>
      %0 = spirv.Tosa.Rescale scale32 = true, rounding_mode = <DoubleRound>, per_channel = false, input_unsigned = false, output_unsigned = false, %arg0, %cst, %cst_0, %cst_1, %cst_2 : !spirv.arm.tensor<2x3xi16>, !spirv.arm.tensor<1xi32>, !spirv.arm.tensor<1xi8>, !spirv.arm.tensor<1xi16>, !spirv.arm.tensor<1xi16> -> !spirv.arm.tensor<2x3xi16>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<2x3xi16>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_const_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @const_int() -> (!spirv.arm.tensor<2x3xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) attributes {entry_point = true} {
      %cst = spirv.Constant dense<[[1, 2, 3], [4, 5, 6]]> : !spirv.arm.tensor<2x3xi8>
      spirv.ARM.GraphOutputs %cst : !spirv.arm.tensor<2x3xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_graph_constant Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @graph_constant() -> (!spirv.arm.tensor<17xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) attributes {entry_point = true} {
      %0 = spirv.ARM.GraphConstant {graph_constant_id = 7 : i32} : !spirv.arm.tensor<17xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<17xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_const_i4 Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @const_i4() -> (!spirv.arm.tensor<2xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) attributes {entry_point = true} {
      %cst = spirv.Constant dense<[7, -8]> : !spirv.arm.tensor<2xi8>
      spirv.ARM.GraphOutputs %cst : !spirv.arm.tensor<2xi8>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_const_i48 Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @const_i48() -> (!spirv.arm.tensor<2xi64> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) attributes {entry_point = true} {
      %cst = spirv.Constant dense<[140737488355327, -140737488355328]> : !spirv.arm.tensor<2xi64>
      spirv.ARM.GraphOutputs %cst : !spirv.arm.tensor<2xi64>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_const_shape_empty Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @const_shape_empty() -> (!spirv.arm.tensor<1xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) attributes {entry_point = true} {
      %cst = spirv.Constant dense<1> : !spirv.arm.tensor<1xi32>
      spirv.ARM.GraphOutputs %cst : !spirv.arm.tensor<1xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_graph_constant_shape Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @graph_constant_shape() -> (!spirv.arm.tensor<33xi32> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) attributes {entry_point = true} {
      %0 = spirv.ARM.GraphConstant {graph_constant_id = 8 : i32} : !spirv.arm.tensor<33xi32>
      spirv.ARM.GraphOutputs %0 : !spirv.arm.tensor<33xi32>
    }
  }
}

// -----
module {
  spirv.module @_spirv_tosa_identity_int Logical Vulkan attributes {spirv.target_env = #spirv.target_env<#spirv.vce<v1.5, [VulkanMemoryModel, Shader, Int8, Int16, Int64, Float16, BFloat16TypeKHR, Float8EXT, TensorsARM, GraphARM, ReplicatedCompositesEXT], [SPV_ARM_tensors, SPV_ARM_graph, SPV_KHR_vulkan_memory_model, SPV_EXT_replicated_composites, SPV_KHR_bfloat16, SPV_EXT_float8, SPV_KHR_non_semantic_info]>, #spirv.resource_limits<>>} {
    spirv.ARM.Graph @identity_int(%arg0: !spirv.arm.tensor<2x3xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 0)>}) -> (!spirv.arm.tensor<2x3xi8> {spirv.interface_var_abi = #spirv.interface_var_abi<(0, 1)>}) attributes {entry_point = true} {
      spirv.ARM.GraphOutputs %arg0 : !spirv.arm.tensor<2x3xi8>
    }
  }
}

