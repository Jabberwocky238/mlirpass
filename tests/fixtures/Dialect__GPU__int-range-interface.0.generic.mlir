"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "launch_func"}> ({
  ^bb0(%arg0: index):
    %0 = "test.with_bounds"() <{smax = 5 : index, smin = 3 : index, umax = 5 : index, umin = 3 : index}> : () -> index
    %1 = "test.with_bounds"() <{smax = 11 : index, smin = 7 : index, umax = 11 : index, umin = 7 : index}> : () -> index
    "gpu.launch"(%0, %1, %arg0, %arg0, %0, %1) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      %2 = "test.reflect_bounds"(%arg7) <{smax = 5 : index, smin = 3 : index, umax = 5 : index, umin = 3 : index}> : (index) -> index
      %3 = "test.reflect_bounds"(%arg8) <{smax = 11 : index, smin = 7 : index, umax = 11 : index, umin = 7 : index}> : (index) -> index
      %4 = "test.reflect_bounds"(%arg9) <{smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index}> : (index) -> index
      %5 = "test.reflect_bounds"(%arg1) <{smax = 4 : index, smin = 0 : index, umax = 4 : index, umin = 0 : index}> : (index) -> index
      %6 = "test.reflect_bounds"(%arg2) <{smax = 10 : index, smin = 0 : index, umax = 10 : index, umin = 0 : index}> : (index) -> index
      %7 = "test.reflect_bounds"(%arg3) <{smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index}> : (index) -> index
      %8 = "test.reflect_bounds"(%arg10) <{smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index}> : (index) -> index
      %9 = "test.reflect_bounds"(%arg11) <{smax = 5 : index, smin = 3 : index, umax = 5 : index, umin = 3 : index}> : (index) -> index
      %10 = "test.reflect_bounds"(%arg12) <{smax = 11 : index, smin = 7 : index, umax = 11 : index, umin = 7 : index}> : (index) -> index
      %11 = "test.reflect_bounds"(%arg4) <{smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index}> : (index) -> index
      %12 = "test.reflect_bounds"(%arg5) <{smax = 4 : index, smin = 0 : index, umax = 4 : index, umin = 0 : index}> : (index) -> index
      %13 = "test.reflect_bounds"(%arg6) <{smax = 10 : index, smin = 0 : index, umax = 10 : index, umin = 0 : index}> : (index) -> index
      %14 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %15 = "test.reflect_bounds"(%14) <{smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index}> : (index) -> index
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "gpu_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "kernel", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
      %0 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "test.reflect_bounds"(%0) <{smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index}> : (index) -> index
      %4 = "test.reflect_bounds"(%1) <{smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index}> : (index) -> index
      %5 = "test.reflect_bounds"(%2) <{smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index}> : (index) -> index
      %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "test.reflect_bounds"(%6) <{smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index}> : (index) -> index
      %10 = "test.reflect_bounds"(%7) <{smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index}> : (index) -> index
      %11 = "test.reflect_bounds"(%8) <{smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index}> : (index) -> index
      %12 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %13 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %14 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %15 = "test.reflect_bounds"(%12) <{smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index}> : (index) -> index
      %16 = "test.reflect_bounds"(%13) <{smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index}> : (index) -> index
      %17 = "test.reflect_bounds"(%14) <{smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index}> : (index) -> index
      %18 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %19 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %20 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %21 = "test.reflect_bounds"(%18) <{smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index}> : (index) -> index
      %22 = "test.reflect_bounds"(%19) <{smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index}> : (index) -> index
      %23 = "test.reflect_bounds"(%20) <{smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index}> : (index) -> index
      %24 = "gpu.global_id"() <{dimension = #gpu<dim x>}> : () -> index
      %25 = "gpu.global_id"() <{dimension = #gpu<dim y>}> : () -> index
      %26 = "gpu.global_id"() <{dimension = #gpu<dim z>}> : () -> index
      %27 = "test.reflect_bounds"(%24) <{smax = 9223372036854775807 : index, smin = -9223372036854775808 : index, umax = -8589934592 : index, umin = 0 : index}> : (index) -> index
      %28 = "test.reflect_bounds"(%25) <{smax = 9223372036854775807 : index, smin = -9223372036854775808 : index, umax = -8589934592 : index, umin = 0 : index}> : (index) -> index
      %29 = "test.reflect_bounds"(%26) <{smax = 9223372036854775807 : index, smin = -9223372036854775808 : index, umax = -8589934592 : index, umin = 0 : index}> : (index) -> index
      %30 = "gpu.subgroup_size"() : () -> index
      %31 = "gpu.lane_id"() : () -> index
      %32 = "gpu.num_subgroups"() : () -> index
      %33 = "gpu.subgroup_id"() : () -> index
      %34 = "test.reflect_bounds"(%30) <{smax = 128 : index, smin = 1 : index, umax = 128 : index, umin = 1 : index}> : (index) -> index
      %35 = "test.reflect_bounds"(%31) <{smax = 127 : index, smin = 0 : index, umax = 127 : index, umin = 0 : index}> : (index) -> index
      %36 = "test.reflect_bounds"(%32) <{smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index}> : (index) -> index
      %37 = "test.reflect_bounds"(%33) <{smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index}> : (index) -> index
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "gpu_module"}> ({
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 8, 12, 16>, known_grid_size = array<i32: 20, 24, 28>}> ({
      %0 = "arith.constant"() <{value = 16 : index}> : () -> index
      %1 = "arith.constant"() <{value = 12 : index}> : () -> index
      %2 = "arith.constant"() <{value = 8 : index}> : () -> index
      %3 = "arith.constant"() <{value = 20 : index}> : () -> index
      %4 = "arith.constant"() <{value = 24 : index}> : () -> index
      %5 = "arith.constant"() <{value = 28 : index}> : () -> index
      %6 = "test.reflect_bounds"(%3) <{smax = 20 : index, smin = 20 : index, umax = 20 : index, umin = 20 : index}> : (index) -> index
      %7 = "test.reflect_bounds"(%4) <{smax = 24 : index, smin = 24 : index, umax = 24 : index, umin = 24 : index}> : (index) -> index
      %8 = "test.reflect_bounds"(%5) <{smax = 28 : index, smin = 28 : index, umax = 28 : index, umin = 28 : index}> : (index) -> index
      %9 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "test.reflect_bounds"(%9) <{smax = 19 : index, smin = 0 : index, umax = 19 : index, umin = 0 : index}> : (index) -> index
      %13 = "test.reflect_bounds"(%10) <{smax = 23 : index, smin = 0 : index, umax = 23 : index, umin = 0 : index}> : (index) -> index
      %14 = "test.reflect_bounds"(%11) <{smax = 27 : index, smin = 0 : index, umax = 27 : index, umin = 0 : index}> : (index) -> index
      %15 = "test.reflect_bounds"(%2) <{smax = 8 : index, smin = 8 : index, umax = 8 : index, umin = 8 : index}> : (index) -> index
      %16 = "test.reflect_bounds"(%1) <{smax = 12 : index, smin = 12 : index, umax = 12 : index, umin = 12 : index}> : (index) -> index
      %17 = "test.reflect_bounds"(%0) <{smax = 16 : index, smin = 16 : index, umax = 16 : index, umin = 16 : index}> : (index) -> index
      %18 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %19 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %20 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %21 = "test.reflect_bounds"(%18) <{smax = 7 : index, smin = 0 : index, umax = 7 : index, umin = 0 : index}> : (index) -> index
      %22 = "test.reflect_bounds"(%19) <{smax = 11 : index, smin = 0 : index, umax = 11 : index, umin = 0 : index}> : (index) -> index
      %23 = "test.reflect_bounds"(%20) <{smax = 15 : index, smin = 0 : index, umax = 15 : index, umin = 0 : index}> : (index) -> index
      %24 = "gpu.global_id"() <{dimension = #gpu<dim x>}> : () -> index
      %25 = "gpu.global_id"() <{dimension = #gpu<dim y>}> : () -> index
      %26 = "gpu.global_id"() <{dimension = #gpu<dim z>}> : () -> index
      %27 = "test.reflect_bounds"(%24) <{smax = 159 : index, smin = 0 : index, umax = 159 : index, umin = 0 : index}> : (index) -> index
      %28 = "test.reflect_bounds"(%25) <{smax = 287 : index, smin = 0 : index, umax = 287 : index, umin = 0 : index}> : (index) -> index
      %29 = "test.reflect_bounds"(%26) <{smax = 447 : index, smin = 0 : index, umax = 447 : index, umin = 0 : index}> : (index) -> index
      %30 = "gpu.subgroup_size"() : () -> index
      %31 = "gpu.lane_id"() : () -> index
      %32 = "gpu.num_subgroups"() : () -> index
      %33 = "gpu.subgroup_id"() : () -> index
      %34 = "test.reflect_bounds"(%30) <{smax = 128 : index, smin = 1 : index, umax = 128 : index, umin = 1 : index}> : (index) -> index
      %35 = "test.reflect_bounds"(%31) <{smax = 127 : index, smin = 0 : index, umax = 127 : index, umin = 0 : index}> : (index) -> index
      %36 = "test.reflect_bounds"(%32) <{smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index}> : (index) -> index
      %37 = "test.reflect_bounds"(%33) <{smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index}> : (index) -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "annotated_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "annotated_kernel"}> ({
    %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
    %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
    %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
    %3 = "test.reflect_bounds"(%0) <{smax = 19 : index, smin = 0 : index, umax = 19 : index, umin = 0 : index}> : (index) -> index
    %4 = "test.reflect_bounds"(%1) <{smax = 23 : index, smin = 0 : index, umax = 23 : index, umin = 0 : index}> : (index) -> index
    %5 = "test.reflect_bounds"(%2) <{smax = 27 : index, smin = 0 : index, umax = 27 : index, umin = 0 : index}> : (index) -> index
    %6 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
    %7 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
    %8 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
    %9 = "test.reflect_bounds"(%6) <{smax = 7 : index, smin = 0 : index, umax = 7 : index, umin = 0 : index}> : (index) -> index
    %10 = "test.reflect_bounds"(%7) <{smax = 11 : index, smin = 0 : index, umax = 11 : index, umin = 0 : index}> : (index) -> index
    %11 = "test.reflect_bounds"(%8) <{smax = 15 : index, smin = 0 : index, umax = 15 : index, umin = 0 : index}> : (index) -> index
    "func.return"() : () -> ()
  }) {gpu.known_block_size = array<i32: 8, 12, 16>, gpu.known_grid_size = array<i32: 20, 24, 28>} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "gpu_module"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.grid_dim"() <{dimension = #gpu<dim x>, upper_bound = 20 : index}> : () -> index
      %1 = "gpu.grid_dim"() <{dimension = #gpu<dim y>, upper_bound = 24 : index}> : () -> index
      %2 = "gpu.grid_dim"() <{dimension = #gpu<dim z>, upper_bound = 28 : index}> : () -> index
      %3 = "test.reflect_bounds"(%0) <{smax = 20 : index, smin = 1 : index, umax = 20 : index, umin = 1 : index}> : (index) -> index
      %4 = "test.reflect_bounds"(%1) <{smax = 24 : index, smin = 1 : index, umax = 24 : index, umin = 1 : index}> : (index) -> index
      %5 = "test.reflect_bounds"(%2) <{smax = 28 : index, smin = 1 : index, umax = 28 : index, umin = 1 : index}> : (index) -> index
      %6 = "gpu.block_id"() <{dimension = #gpu<dim x>, upper_bound = 20 : index}> : () -> index
      %7 = "gpu.block_id"() <{dimension = #gpu<dim y>, upper_bound = 24 : index}> : () -> index
      %8 = "gpu.block_id"() <{dimension = #gpu<dim z>, upper_bound = 28 : index}> : () -> index
      %9 = "test.reflect_bounds"(%6) <{smax = 19 : index, smin = 0 : index, umax = 19 : index, umin = 0 : index}> : (index) -> index
      %10 = "test.reflect_bounds"(%7) <{smax = 23 : index, smin = 0 : index, umax = 23 : index, umin = 0 : index}> : (index) -> index
      %11 = "test.reflect_bounds"(%8) <{smax = 27 : index, smin = 0 : index, umax = 27 : index, umin = 0 : index}> : (index) -> index
      %12 = "gpu.block_dim"() <{dimension = #gpu<dim x>, upper_bound = 8 : index}> : () -> index
      %13 = "gpu.block_dim"() <{dimension = #gpu<dim y>, upper_bound = 12 : index}> : () -> index
      %14 = "gpu.block_dim"() <{dimension = #gpu<dim z>, upper_bound = 16 : index}> : () -> index
      %15 = "test.reflect_bounds"(%12) <{smax = 8 : index, smin = 1 : index, umax = 8 : index, umin = 1 : index}> : (index) -> index
      %16 = "test.reflect_bounds"(%13) <{smax = 12 : index, smin = 1 : index, umax = 12 : index, umin = 1 : index}> : (index) -> index
      %17 = "test.reflect_bounds"(%14) <{smax = 16 : index, smin = 1 : index, umax = 16 : index, umin = 1 : index}> : (index) -> index
      %18 = "gpu.thread_id"() <{dimension = #gpu<dim x>, upper_bound = 8 : index}> : () -> index
      %19 = "gpu.thread_id"() <{dimension = #gpu<dim y>, upper_bound = 12 : index}> : () -> index
      %20 = "gpu.thread_id"() <{dimension = #gpu<dim z>, upper_bound = 16 : index}> : () -> index
      %21 = "test.reflect_bounds"(%18) <{smax = 7 : index, smin = 0 : index, umax = 7 : index, umin = 0 : index}> : (index) -> index
      %22 = "test.reflect_bounds"(%19) <{smax = 11 : index, smin = 0 : index, umax = 11 : index, umin = 0 : index}> : (index) -> index
      %23 = "test.reflect_bounds"(%20) <{smax = 15 : index, smin = 0 : index, umax = 15 : index, umin = 0 : index}> : (index) -> index
      %24 = "gpu.global_id"() <{dimension = #gpu<dim x>, upper_bound = 160 : index}> : () -> index
      %25 = "gpu.global_id"() <{dimension = #gpu<dim y>, upper_bound = 288 : index}> : () -> index
      %26 = "gpu.global_id"() <{dimension = #gpu<dim z>, upper_bound = 448 : index}> : () -> index
      %27 = "test.reflect_bounds"(%24) <{smax = 159 : index, smin = 0 : index, umax = 159 : index, umin = 0 : index}> : (index) -> index
      %28 = "test.reflect_bounds"(%25) <{smax = 287 : index, smin = 0 : index, umax = 287 : index, umin = 0 : index}> : (index) -> index
      %29 = "test.reflect_bounds"(%26) <{smax = 447 : index, smin = 0 : index, umax = 447 : index, umin = 0 : index}> : (index) -> index
      %30 = "gpu.subgroup_size"() <{upper_bound = 32 : index}> : () -> index
      %31 = "gpu.subgroup_id"() <{upper_bound = 32 : index}> : () -> index
      %32 = "gpu.num_subgroups"() <{upper_bound = 8 : index}> : () -> index
      %33 = "gpu.lane_id"() <{upper_bound = 64 : index}> : () -> index
      %34 = "test.reflect_bounds"(%30) <{smax = 32 : index, smin = 1 : index, umax = 32 : index, umin = 1 : index}> : (index) -> index
      %35 = "test.reflect_bounds"(%31) <{smax = 31 : index, smin = 0 : index, umax = 31 : index, umin = 0 : index}> : (index) -> index
      %36 = "test.reflect_bounds"(%32) <{smax = 8 : index, smin = 1 : index, umax = 8 : index, umin = 1 : index}> : (index) -> index
      %37 = "test.reflect_bounds"(%33) <{smax = 63 : index, smin = 0 : index, umax = 63 : index, umin = 0 : index}> : (index) -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "local_bounds_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "broadcast"}> ({
  ^bb0(%arg0: i32):
    %0 = "test.with_bounds"() <{smax = 10 : index, smin = 0 : index, umax = 10 : index, umin = 0 : index}> : () -> index
    %1 = "gpu.subgroup_broadcast"(%0) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (index) -> index
    %2 = "gpu.subgroup_broadcast"(%0, %arg0) <{broadcast_type = #gpu<broadcast specific_lane>}> : (index, i32) -> index
    %3 = "test.reflect_bounds"(%1) <{smax = 10 : index, smin = 0 : index, umax = 10 : index, umin = 0 : index}> : (index) -> index
    %4 = "test.reflect_bounds"(%2) <{smax = 10 : index, smin = 0 : index, umax = 10 : index, umin = 0 : index}> : (index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

