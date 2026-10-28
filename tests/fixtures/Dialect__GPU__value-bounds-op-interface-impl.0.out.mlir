module {
  func.func @launch_func(%arg0: index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c4 = arith.constant 4 : index
    %c64 = arith.constant 64 : index
    gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %arg0, %arg8 = %c4, %arg9 = %c2) threads(%arg4, %arg5, %arg6) in (%arg10 = %c64, %arg11 = %c4, %arg12 = %c2) {
      "test.compare"(%arg4, %c1) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg4, %c64) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg7, %c1) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg7, %arg0) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg8, %c4) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg9, %c2) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg1, %c0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg1, %arg0) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%arg2, %c0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg2, %c4) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%arg3, %c0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg3, %c2) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%arg10, %c64) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg11, %c4) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg12, %c2) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg4, %c0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg4, %c64) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%arg5, %c0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg5, %c4) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%arg6, %c0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg6, %c2) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%arg4, %arg10) <{cmp = "LT"}> : (index, index) -> ()
      gpu.terminator
    }
    return
  }
}

// -----
module attributes {gpu.container_module} {
  gpu.module @gpu_module {
    llvm.func @kernel() attributes {gpu.kernel} {
      %c0 = arith.constant 0 : index
      %c4294967295 = arith.constant 4294967295 : index
      %thread_id_x = gpu.thread_id  x
      "test.compare"(%thread_id_x, %c0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%thread_id_x, %c4294967295) <{cmp = "LT"}> : (index, index) -> ()
      llvm.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  gpu.module @gpu_module {
    gpu.func @annotated_kernel() kernel attributes {known_block_size = array<i32: 8, 12, 16>, known_grid_size = array<i32: 20, 24, 28>} {
      %c0 = arith.constant 0 : index
      %c8 = arith.constant 8 : index
      %thread_id_x = gpu.thread_id  x
      "test.compare"(%thread_id_x, %c0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%thread_id_x, %c8) <{cmp = "LT"}> : (index, index) -> ()
      %block_dim_x = gpu.block_dim  x
      "test.compare"(%block_dim_x, %c8) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%thread_id_x, %block_dim_x) <{cmp = "LT"}> : (index, index) -> ()
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  gpu.module @gpu_module {
    gpu.func @local_bounds_kernel() kernel {
      %c0 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      %c8 = arith.constant 8 : index
      %block_dim_x = gpu.block_dim  x upper_bound 8
      "test.compare"(%block_dim_x, %c1) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%block_dim_x, %c8) <{cmp = "LE"}> : (index, index) -> ()
      "test.compare"(%block_dim_x, %c8) <{cmp = "EQ"}> : (index, index) -> ()
      %thread_id_x = gpu.thread_id  x upper_bound 8
      "test.compare"(%thread_id_x, %c0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%thread_id_x, %c8) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%thread_id_x, %block_dim_x) <{cmp = "LT"}> : (index, index) -> ()
      gpu.return
    }
  }
}

