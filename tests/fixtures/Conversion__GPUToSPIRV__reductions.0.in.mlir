"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op add>, uniform}> ({
      }) : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op add>}> ({
      }) : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op add>, uniform}> ({
      }) : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op add>}> ({
      }) : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>, uniform}> : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>}> : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op mul>, uniform}> ({
      }) : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op mul>}> ({
      }) : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op mul>, uniform}> ({
      }) : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op mul>}> ({
      }) : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op mul>, uniform}> : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op mul>}> : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op mul>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op mul>}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op minnumf>, uniform}> ({
      }) : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op minnumf>}> ({
      }) : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op minsi>, uniform}> ({
      }) : (i32) -> i32
      %1 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op minui>, uniform}> ({
      }) : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op minsi>}> ({
      }) : (i32) -> i32
      %1 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op minui>}> ({
      }) : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op minnumf>, uniform}> : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op minnumf>}> : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op minsi>, uniform}> : (i32) -> i32
      %1 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op minui>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op minsi>}> : (i32) -> i32
      %1 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op minui>}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op maxnumf>, uniform}> ({
      }) : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op maxnumf>}> ({
      }) : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op maxsi>, uniform}> ({
      }) : (i32) -> i32
      %1 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op maxui>, uniform}> ({
      }) : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op maxsi>}> ({
      }) : (i32) -> i32
      %1 = "gpu.all_reduce"(%arg0) <{op = #gpu<all_reduce_op maxui>}> ({
      }) : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op maxnumf>, uniform}> : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op maxnumf>}> : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op maxsi>, uniform}> : (i32) -> i32
      %1 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op maxui>, uniform}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i32) -> (), kernel}> ({
    ^bb0(%arg0: i32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op maxsi>}> : (i32) -> i32
      %1 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op maxui>}> : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (vector<1xi32>) -> (), kernel}> ({
    ^bb0(%arg0: vector<1xi32>):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op maxsi>}> : (vector<1xi32>) -> vector<1xi32>
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i1) -> (), kernel}> ({
    ^bb0(%arg0: i1):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>}> : (i1) -> i1
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "add"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i1) -> (), kernel}> ({
    ^bb0(%arg0: i1):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op mul>}> : (i1) -> i1
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "mul"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i1) -> (), kernel}> ({
    ^bb0(%arg0: i1):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op minsi>}> : (i1) -> i1
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "minsi"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i1) -> (), kernel}> ({
    ^bb0(%arg0: i1):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op minui>}> : (i1) -> i1
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "minui"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i1) -> (), kernel}> ({
    ^bb0(%arg0: i1):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op maxsi>}> : (i1) -> i1
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "maxsi"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (i1) -> (), kernel}> ({
    ^bb0(%arg0: i1):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op maxui>}> : (i1) -> i1
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "maxui"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (vector<2xi32>) -> (), kernel}> ({
    ^bb0(%arg0: vector<2xi32>):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op maxui>}> : (vector<2xi32>) -> vector<2xi32>
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "maxui"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupNonUniformArithmetic, GroupUniformArithmeticKHR], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_size = 8 : i32, cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>}> : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test_subgroup_reduce_clustered"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupUniformArithmeticKHR, GroupNonUniformClustered], []>, #spirv.resource_limits<>>} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (f32) -> (), kernel}> ({
    ^bb0(%arg0: f32):
      %0 = "gpu.subgroup_reduce"(%arg0) <{cluster_size = 8 : i32, cluster_stride = 2 : i32, op = #gpu<all_reduce_op add>}> : (f32) -> f32
      "gpu.return"() : () -> ()
    }) {spirv.entry_point_abi = #spirv.entry_point_abi<workgroup_size = [16, 1, 1]>, sym_name = "test_invalid_subgroup_reduce_clustered_stride"} : () -> ()
  }) : () -> ()
}) {gpu.container_module, spirv.target_env = #spirv.target_env<#spirv.vce<v1.3, [Kernel, Addresses, Groups, GroupUniformArithmeticKHR, GroupNonUniformClustered], []>, #spirv.resource_limits<>>} : () -> ()

