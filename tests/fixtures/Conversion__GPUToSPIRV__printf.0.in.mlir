"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%0, %0, %0, %0, %0, %0) <{kernel = @kernels::@printf, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.printf"() <{format = "\0AHello\0A"}> : () -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<>, sym_name = "printf", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Int8, Kernel], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 100 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 3.144000e+02 : f32}> : () -> f32
    "gpu.launch_func"(%3, %3, %3, %3, %3, %3, %4, %5) <{kernel = @kernels1::@printf_args, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, i32, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kernels1"}> ({
    "gpu.func"() <{function_type = (i32, f32) -> ()}> ({
    ^bb0(%arg0: i32, %arg1: f32):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      "gpu.printf"(%arg0, %arg1, %2) <{format = "\0AHello, world : %d %f \0A Thread id: %d\0A"}> : (i32, f32, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, spirv.entry_point_abi = #spirv.entry_point_abi<>, sym_name = "printf_args", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.0, [Addresses, Int8, Kernel], []>, #spirv.resource_limits<>>} : () -> ()

