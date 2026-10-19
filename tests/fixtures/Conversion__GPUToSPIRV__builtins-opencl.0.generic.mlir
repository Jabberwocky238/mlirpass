"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "builtin"}> ({
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%3, %3, %3, %3, %3, %3) <{kernel = @kernels::@builtin_workgroup_id_x, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.GlobalVariable"() <{built_in = "WorkgroupId", sym_name = "__builtin__WorkgroupId__", type = !spirv.ptr<vector<3xi32>, Input>}> : () -> ()
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_workgroup_id_x"}> ({
        %0 = "spirv.mlir.addressof"() <{variable = @__builtin__WorkgroupId__}> : () -> !spirv.ptr<vector<3xi32>, Input>
        %1 = "spirv.Load"(%0) : (!spirv.ptr<vector<3xi32>, Input>) -> vector<3xi32>
        %2 = "spirv.CompositeExtract"(%1) <{indices = [0 : i32]}> : (vector<3xi32>) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "builtin_workgroup_id_x"}> ({
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Kernel, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.GlobalVariable"() <{built_in = "SubgroupSize", sym_name = "__builtin__SubgroupSize__", type = !spirv.ptr<i32, Input>}> : () -> ()
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_subgroup_size"}> ({
        %0 = "spirv.mlir.addressof"() <{variable = @__builtin__SubgroupSize__}> : () -> !spirv.ptr<i32, Input>
        %1 = "spirv.Load"(%0) : (!spirv.ptr<i32, Input>) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "builtin_subgroup_size"}> ({
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Kernel, Int64], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.GlobalVariable"() <{built_in = "SubgroupLocalInvocationId", sym_name = "__builtin__SubgroupLocalInvocationId__", type = !spirv.ptr<i32, Input>}> : () -> ()
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = () -> (), sym_name = "builtin_laneid"}> ({
        %0 = "spirv.mlir.addressof"() <{variable = @__builtin__SubgroupLocalInvocationId__}> : () -> !spirv.ptr<i32, Input>
        %1 = "spirv.Load"(%0) : (!spirv.ptr<i32, Input>) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "builtin_laneid"}> ({
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Kernel, Int64], []>, #spirv.resource_limits<>>} : () -> ()

