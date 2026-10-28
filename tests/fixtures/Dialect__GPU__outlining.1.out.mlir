module attributes {gpu.container_module} {
  func.func @launch() {
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<?xf32, 1>
    %c8 = arith.constant 8 : index
    %c12 = arith.constant 12 : index
    %c16 = arith.constant 16 : index
    %c20 = arith.constant 20 : index
    %c24 = arith.constant 24 : index
    %c28 = arith.constant 28 : index
    gpu.launch_func  @launch_kernel::@launch_kernel blocks in (%c8, %c12, %c16) threads in (%c20, %c24, %c28)  args(%0 : f32, %1 : memref<?xf32, 1>)
    return
  }
  gpu.module @launch_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @launch_kernel(%arg0: f32, %arg1: memref<?xf32, 1>) kernel attributes {known_block_size = array<i32: 20, 24, 28>, known_grid_size = array<i32: 8, 12, 16>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      "use"(%arg0) : (f32) -> ()
      "some_op"(%block_id_x, %block_dim_x) : (index, index) -> ()
      %0 = memref.load %arg1[%thread_id_x] : memref<?xf32, 1>
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @launchCFG() {
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<?xf32, 1>
    %c8 = arith.constant 8 : index
    %c12 = arith.constant 12 : index
    %c16 = arith.constant 16 : index
    %c20 = arith.constant 20 : index
    %c24 = arith.constant 24 : index
    %c28 = arith.constant 28 : index
    gpu.launch_func  @launchCFG_kernel::@launchCFG_kernel blocks in (%c8, %c12, %c16) threads in (%c20, %c24, %c28)  args(%0 : f32, %1 : memref<?xf32, 1>)
    return
  }
  gpu.module @launchCFG_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @launchCFG_kernel(%arg0: f32, %arg1: memref<?xf32, 1>) kernel attributes {known_block_size = array<i32: 20, 24, 28>, known_grid_size = array<i32: 8, 12, 16>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      "use"(%arg0) : (f32) -> ()
      cf.br ^bb1
    ^bb1:  // pred: ^bb0
      "some_op"(%block_id_x, %block_dim_x) : (index, index) -> ()
      %0 = memref.load %arg1[%thread_id_x] : memref<?xf32, 1>
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  llvm.func @launch_from_llvm_func() {
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<?xf32, 1>
    %c1 = arith.constant 1 : index
    gpu.launch_func  @launch_from_llvm_func_kernel::@launch_from_llvm_func_kernel blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  args(%0 : f32, %1 : memref<?xf32, 1>)
    llvm.return
  }
  gpu.module @launch_from_llvm_func_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @launch_from_llvm_func_kernel(%arg0: f32, %arg1: memref<?xf32, 1>) kernel attributes {known_block_size = array<i32: 1, 1, 1>, known_grid_size = array<i32: 1, 1, 1>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      "use"(%arg0) : (f32) -> ()
      "some_op"(%block_id_x, %block_dim_x) : (index, index) -> ()
      %0 = memref.load %arg1[%thread_id_x] : memref<?xf32, 1>
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @multiple_launches() {
    %c8 = arith.constant 8 : index
    gpu.launch_func  @multiple_launches_kernel::@multiple_launches_kernel blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  
    gpu.launch_func  @multiple_launches_kernel_0::@multiple_launches_kernel blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  
    %0 = gpu.wait async
    %1 = gpu.launch_func async [%0] @multiple_launches_kernel_1::@multiple_launches_kernel blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  
    %2 = gpu.launch_func async @multiple_launches_kernel_2::@multiple_launches_kernel blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  
    return
  }
  gpu.module @multiple_launches_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @multiple_launches_kernel() kernel attributes {known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      gpu.return
    }
  }
  gpu.module @multiple_launches_kernel_0 attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @multiple_launches_kernel() kernel attributes {known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      gpu.return
    }
  }
  gpu.module @multiple_launches_kernel_1 attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @multiple_launches_kernel() kernel attributes {known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      gpu.return
    }
  }
  gpu.module @multiple_launches_kernel_2 attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @multiple_launches_kernel() kernel attributes {known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @extra_constants_not_inlined(%arg0: memref<?xf32>) {
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %0 = "secret_constant"() : () -> index
    gpu.launch_func  @extra_constants_not_inlined_kernel::@extra_constants_not_inlined_kernel blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  args(%arg0 : memref<?xf32>, %0 : index)
    return
  }
  gpu.module @extra_constants_not_inlined_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @extra_constants_not_inlined_kernel(%arg0: memref<?xf32>, %arg1: index) kernel attributes {known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      %c2 = arith.constant 2 : index
      "use"(%c2, %arg0, %arg1) : (index, memref<?xf32>, index) -> ()
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @extra_constants(%arg0: memref<?xf32>) {
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    gpu.launch_func  @extra_constants_kernel::@extra_constants_kernel blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  args(%arg0 : memref<?xf32>)
    return
  }
  gpu.module @extra_constants_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @extra_constants_kernel(%arg0: memref<?xf32>) kernel attributes {known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      %c2 = arith.constant 2 : index
      %c0 = arith.constant 0 : index
      %dim = memref.dim %arg0, %c0 : memref<?xf32>
      "use"(%c2, %arg0, %dim) : (index, memref<?xf32>, index) -> ()
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @extra_constants_noarg(%arg0: memref<?xf32>, %arg1: memref<?xf32>) {
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg1, %c0 : memref<?xf32>
    gpu.launch_func  @extra_constants_noarg_kernel::@extra_constants_noarg_kernel blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  args(%arg0 : memref<?xf32>, %dim : index)
    return
  }
  gpu.module @extra_constants_noarg_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @extra_constants_noarg_kernel(%arg0: memref<?xf32>, %arg1: index) kernel attributes {known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      %c2 = arith.constant 2 : index
      "use"(%c2, %arg0, %arg1) : (index, memref<?xf32>, index) -> ()
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @multiple_uses(%arg0: memref<?xf32>) {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    gpu.launch_func  @multiple_uses_kernel::@multiple_uses_kernel blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  gpu.module @multiple_uses_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @multiple_uses_kernel() kernel attributes {known_block_size = array<i32: 1, 1, 1>, known_grid_size = array<i32: 1, 1, 1>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      %c2 = arith.constant 2 : index
      "use1"(%c2, %c2) : (index, index) -> ()
      "use2"(%c2) : (index) -> ()
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @multiple_uses2(%arg0: memref<*xf32>) {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %dim = memref.dim %arg0, %c2 : memref<*xf32>
    gpu.launch_func  @multiple_uses2_kernel::@multiple_uses2_kernel blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  args(%arg0 : memref<*xf32>)
    return
  }
  gpu.module @multiple_uses2_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @multiple_uses2_kernel(%arg0: memref<*xf32>) kernel attributes {known_block_size = array<i32: 1, 1, 1>, known_grid_size = array<i32: 1, 1, 1>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      %c2 = arith.constant 2 : index
      %dim = memref.dim %arg0, %c2 : memref<*xf32>
      "use1"(%dim) : (index) -> ()
      "use2"(%c2, %c2) : (index, index) -> ()
      "use3"(%arg0) : (memref<*xf32>) -> ()
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  llvm.mlir.global internal @global(42 : i64) {addr_space = 0 : i32} : i64
  func.func @function_call(%arg0: memref<?xf32>) {
    %c8 = arith.constant 8 : index
    gpu.launch_func  @function_call_kernel::@function_call_kernel blocks in (%c8, %c8, %c8) threads in (%c8, %c8, %c8)  
    return
  }
  gpu.module @function_call_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @function_call_kernel() kernel attributes {known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      func.call @device_function() : () -> ()
      func.call @device_function() : () -> ()
      %0 = llvm.mlir.addressof @global : !llvm.ptr
      gpu.return
    }
    func.func @device_function() {
      call @recursive_device_function() : () -> ()
      return
    }
    llvm.mlir.global internal @global(42 : i64) {addr_space = 0 : i32} : i64
    func.func @recursive_device_function() {
      call @recursive_device_function() : () -> ()
      return
    }
  }
  func.func @device_function() {
    call @recursive_device_function() : () -> ()
    return
  }
  func.func @recursive_device_function() {
    call @recursive_device_function() : () -> ()
    return
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @non_constant_launches(%arg0: index) {
    gpu.launch_func  @non_constant_launches_kernel::@non_constant_launches_kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  
    return
  }
  gpu.module @non_constant_launches_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @non_constant_launches_kernel() kernel {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @launch_memory_attributions_0() {
    %0 = "op"() : () -> memref<?xf32, 1>
    %c128 = arith.constant 128 : index
    gpu.launch_func  @launch_memory_attributions_0_kernel::@launch_memory_attributions_0_kernel blocks in (%c128, %c128, %c128) threads in (%c128, %c128, %c128)  args(%0 : memref<?xf32, 1>)
    return
  }
  gpu.module @launch_memory_attributions_0_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @launch_memory_attributions_0_kernel(%arg0: memref<?xf32, 1>) workgroup(%arg1 : memref<42xf32, 3>) private(%arg2 : memref<2xf32, 5>, %arg3 : memref<1xf32, 5>) kernel attributes {known_block_size = array<i32: 128, 128, 128>, known_grid_size = array<i32: 128, 128, 128>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      "some_op"(%block_id_x, %block_dim_x) : (index, index) -> ()
      %0 = memref.load %arg0[%thread_id_x] : memref<?xf32, 1>
      %1 = memref.load %arg1[%thread_id_x] : memref<42xf32, 3>
      %2 = memref.load %arg3[%thread_id_x] : memref<1xf32, 5>
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @launch_memory_attributions_1(%arg0: memref<*xf32>) {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %dim = memref.dim %arg0, %c2 : memref<*xf32>
    gpu.launch_func  @launch_memory_attributions_1_kernel::@launch_memory_attributions_1_kernel blocks in (%c1, %c1, %c1) threads in (%c1, %c1, %c1)  
    return
  }
  gpu.module @launch_memory_attributions_1_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @launch_memory_attributions_1_kernel() private(%arg0 : memref<3xf32, 5>) kernel attributes {known_block_size = array<i32: 1, 1, 1>, known_grid_size = array<i32: 1, 1, 1>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      %c2 = arith.constant 2 : index
      %0 = memref.load %arg0[%c2] : memref<3xf32, 5>
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @launch_cluster() {
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<?xf32, 1>
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c1_0 = arith.constant 1 : index
    %c8 = arith.constant 8 : index
    %c12 = arith.constant 12 : index
    %c16 = arith.constant 16 : index
    %c20 = arith.constant 20 : index
    %c24 = arith.constant 24 : index
    %c28 = arith.constant 28 : index
    gpu.launch_func  @launch_cluster_kernel::@launch_cluster_kernel clusters in (%c1, %c2, %c1_0) blocks in (%c8, %c12, %c16) threads in (%c20, %c24, %c28)  args(%0 : f32, %1 : memref<?xf32, 1>)
    return
  }
  gpu.module @launch_cluster_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @launch_cluster_kernel(%arg0: f32, %arg1: memref<?xf32, 1>) kernel attributes {known_block_size = array<i32: 20, 24, 28>, known_grid_size = array<i32: 8, 12, 16>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      %cluster_id_x = gpu.cluster_id  x
      %cluster_id_y = gpu.cluster_id  y
      %cluster_id_z = gpu.cluster_id  z
      %cluster_dim_x = gpu.cluster_dim  x
      %cluster_dim_y = gpu.cluster_dim  y
      %cluster_dim_z = gpu.cluster_dim  z
      "use"(%arg0) : (f32) -> ()
      "some_op"(%cluster_id_x, %block_id_x, %block_dim_x) : (index, index, index) -> ()
      %0 = memref.load %arg1[%thread_id_x] : memref<?xf32, 1>
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @testKernelAttributes() {
    %c8 = arith.constant 8 : index
    %c12 = arith.constant 12 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %c16_0 = arith.constant 16 : index
    %c8_1 = arith.constant 8 : index
    gpu.launch_func  @test_module::@test_kernel_func blocks in (%c8, %c12, %c16) threads in (%c32, %c16_0, %c8_1)  
    return
  }
  gpu.module @test_module attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @test_kernel_func() kernel attributes {known_block_size = array<i32: 32, 16, 8>, known_grid_size = array<i32: 8, 12, 16>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      "some_op"(%block_id_x, %thread_id_x) : (index, index) -> ()
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  gpu.module @existing_module attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @test_kernel_func() {
      gpu.return
    }
    gpu.func @test_kernel_func_0() kernel attributes {known_block_size = array<i32: 32, 16, 8>, known_grid_size = array<i32: 8, 12, 16>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      "some_op"(%block_id_x, %thread_id_x) : (index, index) -> ()
      gpu.return
    }
  }
  func.func @testExistingModule() {
    %c8 = arith.constant 8 : index
    %c12 = arith.constant 12 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %c16_0 = arith.constant 16 : index
    %c8_1 = arith.constant 8 : index
    gpu.launch_func  @existing_module::@test_kernel_func_0 blocks in (%c8, %c12, %c16) threads in (%c32, %c16_0, %c8_1)  
    return
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @testKernelModuleOnly() {
    %c8 = arith.constant 8 : index
    %c12 = arith.constant 12 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %c16_0 = arith.constant 16 : index
    %c8_1 = arith.constant 8 : index
    gpu.launch_func  @test_module::@testKernelModuleOnly_kernel blocks in (%c8, %c12, %c16) threads in (%c32, %c16_0, %c8_1)  
    return
  }
  gpu.module @test_module attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @testKernelModuleOnly_kernel() kernel attributes {known_block_size = array<i32: 32, 16, 8>, known_grid_size = array<i32: 8, 12, 16>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      "some_op"(%block_id_x, %thread_id_x) : (index, index) -> ()
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @testKernelFuncOnly() {
    %c8 = arith.constant 8 : index
    %c12 = arith.constant 12 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %c16_0 = arith.constant 16 : index
    %c8_1 = arith.constant 8 : index
    gpu.launch_func  @test_kernel_func::@test_kernel_func blocks in (%c8, %c12, %c16) threads in (%c32, %c16_0, %c8_1)  
    return
  }
  gpu.module @test_kernel_func attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @test_kernel_func() kernel attributes {known_block_size = array<i32: 32, 16, 8>, known_grid_size = array<i32: 8, 12, 16>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      "some_op"(%block_id_x, %thread_id_x) : (index, index) -> ()
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @testNoAttributes() {
    %c8 = arith.constant 8 : index
    %c12 = arith.constant 12 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %c16_0 = arith.constant 16 : index
    %c8_1 = arith.constant 8 : index
    gpu.launch_func  @testNoAttributes_kernel::@testNoAttributes_kernel blocks in (%c8, %c12, %c16) threads in (%c32, %c16_0, %c8_1)  
    return
  }
  gpu.module @testNoAttributes_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @testNoAttributes_kernel() kernel attributes {known_block_size = array<i32: 32, 16, 8>, known_grid_size = array<i32: 8, 12, 16>} {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      "some_op"(%block_id_x, %thread_id_x) : (index, index) -> ()
      gpu.return
    }
  }
}

// -----
module attributes {gpu.container_module} {
  func.func @nested_launch(%arg0: index) {
    gpu.launch_func  @nested_launch_kernel_0::@nested_launch_kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  args(%arg0 : index)
    return
  }
  gpu.module @nested_launch_kernel attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @nested_launch_kernel() kernel {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      "some_op"(%block_id_x, %thread_id_x) : (index, index) -> ()
      gpu.return
    }
  }
  gpu.module @nested_launch_kernel_0 attributes {dlti.dl_spec = #dlti.dl_spec<index = 32 : i32>} {
    gpu.func @nested_launch_kernel(%arg0: index) kernel {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %grid_dim_x = gpu.grid_dim  x
      %grid_dim_y = gpu.grid_dim  y
      %grid_dim_z = gpu.grid_dim  z
      %block_dim_x = gpu.block_dim  x
      %block_dim_y = gpu.block_dim  y
      %block_dim_z = gpu.block_dim  z
      gpu.launch_func  @nested_launch_kernel::@nested_launch_kernel blocks in (%arg0, %arg0, %arg0) threads in (%arg0, %arg0, %arg0)  
      gpu.return
    }
  }
}

