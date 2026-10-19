"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, !spirv.ptr<!spirv.array<12 x f32>, CrossWorkgroup>) -> (), sym_name = "basic_module_structure"}> ({
      ^bb0(%arg2: f32, %arg3: !spirv.ptr<!spirv.array<12 x f32>, CrossWorkgroup>):
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32, memref<12xf32, #spirv.storage_class<CrossWorkgroup>>) -> (), sym_name = "basic_module_structure"}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<CrossWorkgroup>>):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<12xf32, #spirv.storage_class<CrossWorkgroup>>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%2, %2, %2, %2, %2, %2, %0, %1) <{kernel = @kernels::@basic_module_structure, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<12xf32, #spirv.storage_class<CrossWorkgroup>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical64>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32, !spirv.ptr<!spirv.array<12 x f32>, CrossWorkgroup>) -> (), sym_name = "basic_module_structure"}> ({
      ^bb0(%arg2: f32, %arg3: !spirv.ptr<!spirv.array<12 x f32>, CrossWorkgroup>):
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [32, 4, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses], []>, #spirv.resource_limits<>>} : () -> ()
    "func.func"() <{function_type = (f32, memref<12xf32, #spirv.storage_class<CrossWorkgroup>>) -> (), sym_name = "basic_module_structure"}> ({
    ^bb0(%arg0: f32, %arg1: memref<12xf32, #spirv.storage_class<CrossWorkgroup>>):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) {spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Kernel, Addresses], []>, #spirv.resource_limits<>>} : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<12xf32, #spirv.storage_class<CrossWorkgroup>>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%2, %2, %2, %2, %2, %2, %0, %1) <{kernel = @kernels::@basic_module_structure, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<12xf32, #spirv.storage_class<CrossWorkgroup>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

