"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupFAdd"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupNonUniformFAdd"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupIAdd"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupNonUniformIAdd"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupFAdd"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupNonUniformFAdd"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupIAdd"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupNonUniformIAdd"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.KHR.GroupFMul"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupNonUniformFMul"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.KHR.GroupIMul"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupNonUniformIMul"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.KHR.GroupFMul"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupNonUniformFMul"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.KHR.GroupIMul"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupNonUniformIMul"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupFMin"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupNonUniformFMin"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupSMin"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        %1 = "spirv.GroupUMin"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupNonUniformSMin"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        %1 = "spirv.GroupNonUniformUMin"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupFMin"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupNonUniformFMin"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupSMin"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        %1 = "spirv.GroupUMin"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupNonUniformSMin"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        %1 = "spirv.GroupNonUniformUMin"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupFMax"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupNonUniformFMax"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupSMax"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        %1 = "spirv.GroupUMax"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupNonUniformSMax"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        %1 = "spirv.GroupNonUniformUMax"(%arg1) <{execution_scope = #spirv.scope<Workgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupFMax"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.GroupNonUniformFMax"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (f32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupSMax"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        %1 = "spirv.GroupUMax"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupNonUniformSMax"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        %1 = "spirv.GroupNonUniformUMax"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (i32) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: i32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (i32) -> (), sym_name = "test"}> ({
      ^bb0(%arg1: i32):
        %0 = "spirv.GroupNonUniformSMax"(%arg1) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<Reduce>}> : (i32) -> i32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (vector<1xi32>) -> (), sym_name = "test"}> ({
    ^bb0(%arg0: vector<1xi32>):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
// -----
// -----
// -----
// -----
// -----
// -----
// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "spirv.module"() <{addressing_model = #spirv.addressing_model<Physical32>, memory_model = #spirv.memory_model<OpenCL>, sym_name = "__spv__kernels"}> ({
      "spirv.func"() <{function_control = #spirv.function_control<None>, function_type = (f32) -> (), sym_name = "test_subgroup_reduce_clustered"}> ({
      ^bb0(%arg1: f32):
        %0 = "spirv.Constant"() <{value = 8 : i32}> : () -> i32
        %1 = "spirv.GroupNonUniformFAdd"(%arg1, %0) <{execution_scope = #spirv.scope<Subgroup>, group_operation = #spirv.group_operation<ClusteredReduce>}> : (f32, i32) -> f32
        "spirv.Return"() : () -> ()
      }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, workgroup_attributions = 0 : i64} : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (f32) -> (), sym_name = "test_subgroup_reduce_clustered"}> ({
    ^bb0(%arg0: f32):
      "func.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupUniformArithmeticKHR, GroupNonUniformClustered], []>, #spirv.resource_limits<>>} : () -> ()

// -----
