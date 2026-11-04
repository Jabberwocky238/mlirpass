"builtin.module"() ({
  "gpu.module"() <{sym_name = "builtins"}> ({
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "gpu_block_id"}> ({
      %12 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %13 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %14 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      "func.return"(%12, %13, %14) : (index, index, index) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "gpu_global_id"}> ({
      %9 = "gpu.global_id"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.global_id"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.global_id"() <{dimension = #gpu<dim z>}> : () -> index
      "func.return"(%9, %10, %11) : (index, index, index) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "gpu_block_dim"}> ({
      %6 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "func.return"(%6, %7, %8) : (index, index, index) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "gpu_thread_id"}> ({
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      "func.return"(%3, %4, %5) : (index, index, index) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (index, index, index), sym_name = "gpu_grid_dim"}> ({
      %0 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "func.return"(%0, %1, %2) : (index, index, index) -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "barriers"}> ({
    "func.func"() <{function_type = () -> (), sym_name = "gpu_barrier"}> ({
      "gpu.barrier"() : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "shuffles"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i8, i16, i32, i64, f16, f32, f64, bf16, i1, i32)>, intel_reqd_sub_group_size = 16 : i32, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffles", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i8, %arg1: i16, %arg2: i32, %arg3: i64, %arg4: f16, %arg5: f32, %arg6: f64, %arg7: bf16, %arg8: i1, %arg9: i32):
      %0 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %1:2 = "gpu.shuffle"(%arg0, %arg9, %0) <{mode = #gpu<shuffle_mode idx>}> : (i8, i32, i32) -> (i8, i1)
      %2:2 = "gpu.shuffle"(%arg1, %arg9, %0) <{mode = #gpu<shuffle_mode xor>}> : (i16, i32, i32) -> (i16, i1)
      %3:2 = "gpu.shuffle"(%arg2, %arg9, %0) <{mode = #gpu<shuffle_mode idx>}> : (i32, i32, i32) -> (i32, i1)
      %4:2 = "gpu.shuffle"(%arg3, %arg9, %0) <{mode = #gpu<shuffle_mode xor>}> : (i64, i32, i32) -> (i64, i1)
      %5:2 = "gpu.shuffle"(%arg4, %arg9, %0) <{mode = #gpu<shuffle_mode up>}> : (f16, i32, i32) -> (f16, i1)
      %6:2 = "gpu.shuffle"(%arg5, %arg9, %0) <{mode = #gpu<shuffle_mode up>}> : (f32, i32, i32) -> (f32, i1)
      %7:2 = "gpu.shuffle"(%arg6, %arg9, %0) <{mode = #gpu<shuffle_mode down>}> : (f64, i32, i32) -> (f64, i1)
      %8:2 = "gpu.shuffle"(%arg7, %arg9, %0) <{mode = #gpu<shuffle_mode down>}> : (bf16, i32, i32) -> (bf16, i1)
      %9:2 = "gpu.shuffle"(%arg8, %arg9, %0) <{mode = #gpu<shuffle_mode xor>}> : (i1, i32, i32) -> (i1, i1)
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "shuffles_mismatch"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32)>, intel_reqd_sub_group_size = 32 : i32, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffles", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i32, %arg1: i32):
      %0 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %1:2 = "gpu.shuffle"(%arg0, %arg1, %0) <{mode = #gpu<shuffle_mode idx>}> : (i32, i32, i32) -> (i32, i1)
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "shuffles_mismatch"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, i32, i32)>, intel_reqd_sub_group_size = 32 : i32, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffles", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
      %0:2 = "gpu.shuffle"(%arg0, %arg1, %arg2) <{mode = #gpu<shuffle_mode idx>}> : (i32, i32, i32) -> (i32, i1)
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "not_supported_lowering"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (f128, i32)>, intel_reqd_sub_group_size = 32 : i32, linkage = #llvm.linkage<external>, sym_name = "gpu_shuffles", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg0: f128, %arg1: i32):
      %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
      %1:2 = "gpu.shuffle"(%arg0, %arg1, %0) <{mode = #gpu<shuffle_mode xor>}> : (f128, i32, i32) -> (f128, i1)
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.return"() : () -> ()
    }) {sym_name = "no_kernel", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_no_arg", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (f32, i64) -> ()}> ({
    ^bb0(%arg4: f32, %arg5: i64):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_args", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (index, memref<index>) -> ()}> ({
    ^bb0(%arg2: index, %arg3: memref<index>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_conv_args", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<1xindex>) -> ()}> ({
    ^bb0(%arg1: memref<1xindex>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_sized_memref", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<128x128x128xindex>) -> ()}> ({
    ^bb0(%arg0: memref<128x128x128xindex>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_ND_memref", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
    ^bb0(%arg6: memref<32xf32, #gpu.address_space<private>>, %arg7: memref<16xi16, #gpu.address_space<private>>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_private_attributions", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = () -> ()}> ({
    ^bb0(%arg4: memref<32xf32, #gpu.address_space<workgroup>>, %arg5: memref<16xi16, #gpu.address_space<workgroup>>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_workgoup_attributions", workgroup_attributions = 2 : i64} : () -> ()
    "gpu.func"() <{function_type = () -> ()}> ({
    ^bb0(%arg0: memref<8xf32, #gpu.address_space<workgroup>>, %arg1: memref<16xindex, #gpu.address_space<workgroup>>, %arg2: memref<32xi32, #gpu.address_space<private>>, %arg3: memref<32xindex, #gpu.address_space<private>>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_with_both_attributions", workgroup_attributions = 2 : i64} : () -> ()
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 128, 128, 256>}> ({
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel_known_block_size", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<f32, #gpu.address_space<global>>, memref<f32, #gpu.address_space<workgroup>>, memref<f32, #gpu.address_space<private>>) -> ()}> ({
    ^bb0(%arg0: memref<f32, #gpu.address_space<global>>, %arg1: memref<f32, #gpu.address_space<workgroup>>, %arg2: memref<f32, #gpu.address_space<private>>):
      "gpu.return"() : () -> ()
    }) {sym_name = "address_spaces", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = (memref<f32>, memref<f32, #gpu.address_space<global>>, memref<f32>) -> ()}> ({
    ^bb0(%arg4: memref<f32>, %arg5: memref<f32, #gpu.address_space<global>>, %arg6: memref<f32>):
      "gpu.return"() : () -> ()
    }) {sym_name = "no_address_spaces", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<2x2xf32>, memref<4xf32>) -> ()}> ({
    ^bb0(%arg2: memref<2x2xf32>, %arg3: memref<4xf32>):
      "func.call"(%arg2, %arg3) <{callee = @no_address_spaces_callee}> : (memref<2x2xf32>, memref<4xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "no_address_spaces_complex", workgroup_attributions = 0 : i64} : () -> ()
    "func.func"() <{function_type = (memref<2x2xf32>, memref<4xf32>) -> (), sym_name = "no_address_spaces_callee"}> ({
    ^bb0(%arg0: memref<2x2xf32>, %arg1: memref<4xf32>):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "memref.load"(%arg0, %0, %0) : (memref<2x2xf32>, index, index) -> f32
      "memref.store"(%1, %arg1, %0) : (f32, memref<4xf32>, index) -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "subgroup_operations"}> ({
    "func.func"() <{function_type = () -> (), sym_name = "gpu_subgroup"}> ({
      %0 = "gpu.subgroup_id"() : () -> index
      %1 = "gpu.lane_id"() : () -> index
      %2 = "gpu.num_subgroups"() : () -> index
      %3 = "gpu.subgroup_size"() : () -> index
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

