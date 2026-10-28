module {
  func.func @launch_func(%arg0: index) {
    %0 = test.with_bounds {smax = 5 : index, smin = 3 : index, umax = 5 : index, umin = 3 : index} : index
    %1 = test.with_bounds {smax = 11 : index, smin = 7 : index, umax = 11 : index, umin = 7 : index} : index
    gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %0, %arg8 = %1, %arg9 = %arg0) threads(%arg4, %arg5, %arg6) in (%arg10 = %arg0, %arg11 = %0, %arg12 = %1) {
      %2 = test.reflect_bounds {smax = 5 : index, smin = 3 : index, umax = 5 : index, umin = 3 : index} %arg7 : index
      %3 = test.reflect_bounds {smax = 11 : index, smin = 7 : index, umax = 11 : index, umin = 7 : index} %arg8 : index
      %4 = test.reflect_bounds {smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index} %arg9 : index
      %5 = test.reflect_bounds {smax = 4 : index, smin = 0 : index, umax = 4 : index, umin = 0 : index} %arg1 : index
      %6 = test.reflect_bounds {smax = 10 : index, smin = 0 : index, umax = 10 : index, umin = 0 : index} %arg2 : index
      %7 = test.reflect_bounds {smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index} %arg3 : index
      %8 = test.reflect_bounds {smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index} %arg10 : index
      %9 = test.reflect_bounds {smax = 5 : index, smin = 3 : index, umax = 5 : index, umin = 3 : index} %arg11 : index
      %10 = test.reflect_bounds {smax = 11 : index, smin = 7 : index, umax = 11 : index, umin = 7 : index} %arg12 : index
      %11 = test.reflect_bounds {smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index} %arg4 : index
      %12 = test.reflect_bounds {smax = 4 : index, smin = 0 : index, umax = 4 : index, umin = 0 : index} %arg5 : index
      %13 = test.reflect_bounds {smax = 10 : index, smin = 0 : index, umax = 10 : index, umin = 0 : index} %arg6 : index
      %thread_id_y = gpu.thread_id  y
      %14 = test.reflect_bounds {smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index} %thread_id_y : index
      gpu.terminator
    }
    return
  }
}

// -----
module attributes {gpu.container_module} {
  gpu.module @gpu_module {
    llvm.func @kernel() attributes {gpu.kernel} {
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %0 = test.reflect_bounds {smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index} %grid_dim_x : index
      %1 = test.reflect_bounds {smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index} %grid_dim_y : index
      %2 = test.reflect_bounds {smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index} %grid_dim_z : index
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %3 = test.reflect_bounds {smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index} %block_id_x : index
      %4 = test.reflect_bounds {smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index} %block_id_y : index
      %5 = test.reflect_bounds {smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index} %block_id_z : index
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      %6 = test.reflect_bounds {smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index} %block_dim_x : index
      %7 = test.reflect_bounds {smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index} %block_dim_y : index
      %8 = test.reflect_bounds {smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index} %block_dim_z : index
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %9 = test.reflect_bounds {smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index} %thread_id_x : index
      %10 = test.reflect_bounds {smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index} %thread_id_y : index
      %11 = test.reflect_bounds {smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index} %thread_id_z : index
      %global_id_x = gpu.global_id  x
      %global_id_y = gpu.global_id  y
      %global_id_z = gpu.global_id  z
      %12 = test.reflect_bounds {smax = 9223372036854775807 : index, smin = -9223372036854775808 : index, umax = -8589934592 : index, umin = 0 : index} %global_id_x : index
      %13 = test.reflect_bounds {smax = 9223372036854775807 : index, smin = -9223372036854775808 : index, umax = -8589934592 : index, umin = 0 : index} %global_id_y : index
      %14 = test.reflect_bounds {smax = 9223372036854775807 : index, smin = -9223372036854775808 : index, umax = -8589934592 : index, umin = 0 : index} %global_id_z : index
      %15 = gpu.subgroup_size : index
      %16 = gpu.lane_id
      %17 = gpu.num_subgroups : index
      %18 = gpu.subgroup_id : index
      %19 = test.reflect_bounds {smax = 128 : index, smin = 1 : index, umax = 128 : index, umin = 1 : index} %15 : index
      %20 = test.reflect_bounds {smax = 127 : index, smin = 0 : index, umax = 127 : index, umin = 0 : index} %16 : index
      %21 = test.reflect_bounds {smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index} %17 : index
      %22 = test.reflect_bounds {smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index} %18 : index
      llvm.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  gpu.module @gpu_module {
    gpu.func @annotated_kernel() kernel attributes {known_block_size = array<i32: 8, 12, 16>, known_grid_size = array<i32: 20, 24, 28>} {
      %c16 = arith.constant 16 : index
      %c12 = arith.constant 12 : index
      %c8 = arith.constant 8 : index
      %c20 = arith.constant 20 : index
      %c24 = arith.constant 24 : index
      %c28 = arith.constant 28 : index
      %0 = test.reflect_bounds {smax = 20 : index, smin = 20 : index, umax = 20 : index, umin = 20 : index} %c20 : index
      %1 = test.reflect_bounds {smax = 24 : index, smin = 24 : index, umax = 24 : index, umin = 24 : index} %c24 : index
      %2 = test.reflect_bounds {smax = 28 : index, smin = 28 : index, umax = 28 : index, umin = 28 : index} %c28 : index
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %3 = test.reflect_bounds {smax = 19 : index, smin = 0 : index, umax = 19 : index, umin = 0 : index} %block_id_x : index
      %4 = test.reflect_bounds {smax = 23 : index, smin = 0 : index, umax = 23 : index, umin = 0 : index} %block_id_y : index
      %5 = test.reflect_bounds {smax = 27 : index, smin = 0 : index, umax = 27 : index, umin = 0 : index} %block_id_z : index
      %6 = test.reflect_bounds {smax = 8 : index, smin = 8 : index, umax = 8 : index, umin = 8 : index} %c8 : index
      %7 = test.reflect_bounds {smax = 12 : index, smin = 12 : index, umax = 12 : index, umin = 12 : index} %c12 : index
      %8 = test.reflect_bounds {smax = 16 : index, smin = 16 : index, umax = 16 : index, umin = 16 : index} %c16 : index
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %9 = test.reflect_bounds {smax = 7 : index, smin = 0 : index, umax = 7 : index, umin = 0 : index} %thread_id_x : index
      %10 = test.reflect_bounds {smax = 11 : index, smin = 0 : index, umax = 11 : index, umin = 0 : index} %thread_id_y : index
      %11 = test.reflect_bounds {smax = 15 : index, smin = 0 : index, umax = 15 : index, umin = 0 : index} %thread_id_z : index
      %global_id_x = gpu.global_id  x
      %global_id_y = gpu.global_id  y
      %global_id_z = gpu.global_id  z
      %12 = test.reflect_bounds {smax = 159 : index, smin = 0 : index, umax = 159 : index, umin = 0 : index} %global_id_x : index
      %13 = test.reflect_bounds {smax = 287 : index, smin = 0 : index, umax = 287 : index, umin = 0 : index} %global_id_y : index
      %14 = test.reflect_bounds {smax = 447 : index, smin = 0 : index, umax = 447 : index, umin = 0 : index} %global_id_z : index
      %15 = gpu.subgroup_size : index
      %16 = gpu.lane_id
      %17 = gpu.num_subgroups : index
      %18 = gpu.subgroup_id : index
      %19 = test.reflect_bounds {smax = 128 : index, smin = 1 : index, umax = 128 : index, umin = 1 : index} %15 : index
      %20 = test.reflect_bounds {smax = 127 : index, smin = 0 : index, umax = 127 : index, umin = 0 : index} %16 : index
      %21 = test.reflect_bounds {smax = 4294967295 : index, smin = 1 : index, umax = 4294967295 : index, umin = 1 : index} %17 : index
      %22 = test.reflect_bounds {smax = 4294967294 : index, smin = 0 : index, umax = 4294967294 : index, umin = 0 : index} %18 : index
      gpu.return
    }
  }
}

// -----
module {
  func.func @annotated_kernel() attributes {gpu.known_block_size = array<i32: 8, 12, 16>, gpu.known_grid_size = array<i32: 20, 24, 28>} {
    %block_id_x = gpu.block_id  x
    %block_id_y = gpu.block_id  y
    %block_id_z = gpu.block_id  z
    %0 = test.reflect_bounds {smax = 19 : index, smin = 0 : index, umax = 19 : index, umin = 0 : index} %block_id_x : index
    %1 = test.reflect_bounds {smax = 23 : index, smin = 0 : index, umax = 23 : index, umin = 0 : index} %block_id_y : index
    %2 = test.reflect_bounds {smax = 27 : index, smin = 0 : index, umax = 27 : index, umin = 0 : index} %block_id_z : index
    %thread_id_x = gpu.thread_id  x
    %thread_id_y = gpu.thread_id  y
    %thread_id_z = gpu.thread_id  z
    %3 = test.reflect_bounds {smax = 7 : index, smin = 0 : index, umax = 7 : index, umin = 0 : index} %thread_id_x : index
    %4 = test.reflect_bounds {smax = 11 : index, smin = 0 : index, umax = 11 : index, umin = 0 : index} %thread_id_y : index
    %5 = test.reflect_bounds {smax = 15 : index, smin = 0 : index, umax = 15 : index, umin = 0 : index} %thread_id_z : index
    return
  }
}

// -----
module attributes {gpu.container_module} {
  gpu.module @gpu_module {
    gpu.func @local_bounds_kernel() kernel {
      %grid_dim_x = gpu.grid_dim  x upper_bound 20
      %grid_dim_y = gpu.grid_dim  y upper_bound 24
      %grid_dim_z = gpu.grid_dim  z upper_bound 28
      %0 = test.reflect_bounds {smax = 20 : index, smin = 1 : index, umax = 20 : index, umin = 1 : index} %grid_dim_x : index
      %1 = test.reflect_bounds {smax = 24 : index, smin = 1 : index, umax = 24 : index, umin = 1 : index} %grid_dim_y : index
      %2 = test.reflect_bounds {smax = 28 : index, smin = 1 : index, umax = 28 : index, umin = 1 : index} %grid_dim_z : index
      %block_id_x = gpu.block_id  x upper_bound 20
      %block_id_y = gpu.block_id  y upper_bound 24
      %block_id_z = gpu.block_id  z upper_bound 28
      %3 = test.reflect_bounds {smax = 19 : index, smin = 0 : index, umax = 19 : index, umin = 0 : index} %block_id_x : index
      %4 = test.reflect_bounds {smax = 23 : index, smin = 0 : index, umax = 23 : index, umin = 0 : index} %block_id_y : index
      %5 = test.reflect_bounds {smax = 27 : index, smin = 0 : index, umax = 27 : index, umin = 0 : index} %block_id_z : index
      %block_dim_x = gpu.block_dim  x upper_bound 8
      %block_dim_y = gpu.block_dim  y upper_bound 12
      %block_dim_z = gpu.block_dim  z upper_bound 16
      %6 = test.reflect_bounds {smax = 8 : index, smin = 1 : index, umax = 8 : index, umin = 1 : index} %block_dim_x : index
      %7 = test.reflect_bounds {smax = 12 : index, smin = 1 : index, umax = 12 : index, umin = 1 : index} %block_dim_y : index
      %8 = test.reflect_bounds {smax = 16 : index, smin = 1 : index, umax = 16 : index, umin = 1 : index} %block_dim_z : index
      %thread_id_x = gpu.thread_id  x upper_bound 8
      %thread_id_y = gpu.thread_id  y upper_bound 12
      %thread_id_z = gpu.thread_id  z upper_bound 16
      %9 = test.reflect_bounds {smax = 7 : index, smin = 0 : index, umax = 7 : index, umin = 0 : index} %thread_id_x : index
      %10 = test.reflect_bounds {smax = 11 : index, smin = 0 : index, umax = 11 : index, umin = 0 : index} %thread_id_y : index
      %11 = test.reflect_bounds {smax = 15 : index, smin = 0 : index, umax = 15 : index, umin = 0 : index} %thread_id_z : index
      %global_id_x = gpu.global_id  x upper_bound 160
      %global_id_y = gpu.global_id  y upper_bound 288
      %global_id_z = gpu.global_id  z upper_bound 448
      %12 = test.reflect_bounds {smax = 159 : index, smin = 0 : index, umax = 159 : index, umin = 0 : index} %global_id_x : index
      %13 = test.reflect_bounds {smax = 287 : index, smin = 0 : index, umax = 287 : index, umin = 0 : index} %global_id_y : index
      %14 = test.reflect_bounds {smax = 447 : index, smin = 0 : index, umax = 447 : index, umin = 0 : index} %global_id_z : index
      %15 = gpu.subgroup_size upper_bound 32 : index
      %16 = gpu.subgroup_id upper_bound 32 : index
      %17 = gpu.num_subgroups upper_bound 8 : index
      %18 = gpu.lane_id upper_bound 64
      %19 = test.reflect_bounds {smax = 32 : index, smin = 1 : index, umax = 32 : index, umin = 1 : index} %15 : index
      %20 = test.reflect_bounds {smax = 31 : index, smin = 0 : index, umax = 31 : index, umin = 0 : index} %16 : index
      %21 = test.reflect_bounds {smax = 8 : index, smin = 1 : index, umax = 8 : index, umin = 1 : index} %17 : index
      %22 = test.reflect_bounds {smax = 63 : index, smin = 0 : index, umax = 63 : index, umin = 0 : index} %18 : index
      gpu.return
    }
  }
}

// -----
module {
  func.func @broadcast(%arg0: i32) {
    %0 = test.with_bounds {smax = 10 : index, smin = 0 : index, umax = 10 : index, umin = 0 : index} : index
    %1 = gpu.subgroup_broadcast %0,  first_active_lane : index
    %2 = gpu.subgroup_broadcast %0,  specific_lane %arg0 : index
    %3 = test.reflect_bounds {smax = 10 : index, smin = 0 : index, umax = 10 : index, umin = 0 : index} %1 : index
    %4 = test.reflect_bounds {smax = 10 : index, smin = 0 : index, umax = 10 : index, umin = 0 : index} %2 : index
    return
  }
}

