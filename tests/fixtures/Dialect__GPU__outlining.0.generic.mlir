"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "launch"}> ({
    %13 = "op"() : () -> f32
    %14 = "op"() : () -> memref<?xf32, 1>
    %15 = "arith.constant"() <{value = 8 : index}> : () -> index
    %16 = "arith.constant"() <{value = 12 : index}> : () -> index
    %17 = "arith.constant"() <{value = 16 : index}> : () -> index
    %18 = "arith.constant"() <{value = 20 : index}> : () -> index
    %19 = "arith.constant"() <{value = 24 : index}> : () -> index
    %20 = "arith.constant"() <{value = 28 : index}> : () -> index
    "gpu.launch_func"(%15, %16, %17, %18, %19, %20, %13, %14) <{kernel = @launch_kernel::@launch_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<?xf32, 1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "launch_kernel"}> ({
    "gpu.func"() <{function_type = (f32, memref<?xf32, 1>) -> (), known_block_size = array<i32: 20, 24, 28>, known_grid_size = array<i32: 8, 12, 16>}> ({
    ^bb0(%arg0: f32, %arg1: memref<?xf32, 1>):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "use"(%arg0) : (f32) -> ()
      "some_op"(%0, %9) : (index, index) -> ()
      %12 = "memref.load"(%arg1, %3) : (memref<?xf32, 1>, index) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "launch_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "launchCFG"}> ({
    %13 = "op"() : () -> f32
    %14 = "op"() : () -> memref<?xf32, 1>
    %15 = "arith.constant"() <{value = 8 : index}> : () -> index
    %16 = "arith.constant"() <{value = 12 : index}> : () -> index
    %17 = "arith.constant"() <{value = 16 : index}> : () -> index
    %18 = "arith.constant"() <{value = 20 : index}> : () -> index
    %19 = "arith.constant"() <{value = 24 : index}> : () -> index
    %20 = "arith.constant"() <{value = 28 : index}> : () -> index
    "gpu.launch_func"(%15, %16, %17, %18, %19, %20, %13, %14) <{kernel = @launchCFG_kernel::@launchCFG_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<?xf32, 1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "launchCFG_kernel"}> ({
    "gpu.func"() <{function_type = (f32, memref<?xf32, 1>) -> (), known_block_size = array<i32: 20, 24, 28>, known_grid_size = array<i32: 8, 12, 16>}> ({
    ^bb0(%arg0: f32, %arg1: memref<?xf32, 1>):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "use"(%arg0) : (f32) -> ()
      "cf.br"()[^bb1] : () -> ()
    ^bb1:  // pred: ^bb0
      "some_op"(%0, %9) : (index, index) -> ()
      %12 = "memref.load"(%arg1, %3) : (memref<?xf32, 1>, index) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "launchCFG_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "launch_from_llvm_func", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %13 = "op"() : () -> f32
    %14 = "op"() : () -> memref<?xf32, 1>
    %15 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch_func"(%15, %15, %15, %15, %15, %15, %13, %14) <{kernel = @launch_from_llvm_func_kernel::@launch_from_llvm_func_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, f32, memref<?xf32, 1>) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "launch_from_llvm_func_kernel"}> ({
    "gpu.func"() <{function_type = (f32, memref<?xf32, 1>) -> (), known_block_size = array<i32: 1, 1, 1>, known_grid_size = array<i32: 1, 1, 1>}> ({
    ^bb0(%arg0: f32, %arg1: memref<?xf32, 1>):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "use"(%arg0) : (f32) -> ()
      "some_op"(%0, %9) : (index, index) -> ()
      %12 = "memref.load"(%arg1, %3) : (memref<?xf32, 1>, index) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "launch_from_llvm_func_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "multiple_launches"}> ({
    %48 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch_func"(%48, %48, %48, %48, %48, %48) <{kernel = @multiple_launches_kernel::@multiple_launches_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "gpu.launch_func"(%48, %48, %48, %48, %48, %48) <{kernel = @multiple_launches_kernel_0::@multiple_launches_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    %49 = "gpu.wait"() : () -> !gpu.async.token
    %50 = "gpu.launch_func"(%49, %48, %48, %48, %48, %48, %48) <{kernel = @multiple_launches_kernel_1::@multiple_launches_kernel, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    %51 = "gpu.launch_func"(%48, %48, %48, %48, %48, %48) <{kernel = @multiple_launches_kernel_2::@multiple_launches_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> !gpu.async.token
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "multiple_launches_kernel"}> ({
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>}> ({
      %36 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %37 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %38 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %39 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %40 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %41 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %42 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %43 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %44 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %45 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %46 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %47 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "multiple_launches_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "multiple_launches_kernel_0"}> ({
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>}> ({
      %24 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %25 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %26 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %27 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %28 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %29 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %30 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %31 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %32 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %33 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %34 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %35 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "multiple_launches_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "multiple_launches_kernel_1"}> ({
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>}> ({
      %12 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %13 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %14 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %15 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %16 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %17 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %18 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %19 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %20 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %21 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %22 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %23 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "multiple_launches_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "multiple_launches_kernel_2"}> ({
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>}> ({
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "multiple_launches_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "extra_constants_not_inlined"}> ({
  ^bb0(%arg2: memref<?xf32>):
    %13 = "arith.constant"() <{value = 8 : index}> : () -> index
    %14 = "arith.constant"() <{value = 2 : index}> : () -> index
    %15 = "arith.constant"() <{value = 0 : index}> : () -> index
    %16 = "secret_constant"() : () -> index
    "gpu.launch_func"(%13, %13, %13, %13, %13, %13, %arg2, %16) <{kernel = @extra_constants_not_inlined_kernel::@extra_constants_not_inlined_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, memref<?xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "extra_constants_not_inlined_kernel"}> ({
    "gpu.func"() <{function_type = (memref<?xf32>, index) -> (), known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>}> ({
    ^bb0(%arg0: memref<?xf32>, %arg1: index):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "arith.constant"() <{value = 2 : index}> : () -> index
      "use"(%12, %arg0, %arg1) : (index, memref<?xf32>, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "extra_constants_not_inlined_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "extra_constants"}> ({
  ^bb0(%arg1: memref<?xf32>):
    %15 = "arith.constant"() <{value = 8 : index}> : () -> index
    %16 = "arith.constant"() <{value = 2 : index}> : () -> index
    %17 = "arith.constant"() <{value = 0 : index}> : () -> index
    %18 = "memref.dim"(%arg1, %17) : (memref<?xf32>, index) -> index
    "gpu.launch_func"(%15, %15, %15, %15, %15, %15, %arg1) <{kernel = @extra_constants_kernel::@extra_constants_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0>}> : (index, index, index, index, index, index, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "extra_constants_kernel"}> ({
    "gpu.func"() <{function_type = (memref<?xf32>) -> (), known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>}> ({
    ^bb0(%arg0: memref<?xf32>):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "arith.constant"() <{value = 2 : index}> : () -> index
      %13 = "arith.constant"() <{value = 0 : index}> : () -> index
      %14 = "memref.dim"(%arg0, %13) : (memref<?xf32>, index) -> index
      "use"(%12, %arg0, %14) : (index, memref<?xf32>, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "extra_constants_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "extra_constants_noarg"}> ({
  ^bb0(%arg2: memref<?xf32>, %arg3: memref<?xf32>):
    %13 = "arith.constant"() <{value = 8 : index}> : () -> index
    %14 = "arith.constant"() <{value = 2 : index}> : () -> index
    %15 = "arith.constant"() <{value = 0 : index}> : () -> index
    %16 = "memref.dim"(%arg3, %15) : (memref<?xf32>, index) -> index
    "gpu.launch_func"(%13, %13, %13, %13, %13, %13, %arg2, %16) <{kernel = @extra_constants_noarg_kernel::@extra_constants_noarg_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 0>}> : (index, index, index, index, index, index, memref<?xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "extra_constants_noarg_kernel"}> ({
    "gpu.func"() <{function_type = (memref<?xf32>, index) -> (), known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>}> ({
    ^bb0(%arg0: memref<?xf32>, %arg1: index):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "arith.constant"() <{value = 2 : index}> : () -> index
      "use"(%12, %arg0, %arg1) : (index, memref<?xf32>, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "extra_constants_noarg_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "multiple_uses"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %13 = "arith.constant"() <{value = 1 : index}> : () -> index
    %14 = "arith.constant"() <{value = 2 : index}> : () -> index
    "gpu.launch_func"(%13, %13, %13, %13, %13, %13) <{kernel = @multiple_uses_kernel::@multiple_uses_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "multiple_uses_kernel"}> ({
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 1, 1, 1>, known_grid_size = array<i32: 1, 1, 1>}> ({
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "arith.constant"() <{value = 2 : index}> : () -> index
      "use1"(%12, %12) : (index, index) -> ()
      "use2"(%12) : (index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "multiple_uses_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> (), sym_name = "multiple_uses2"}> ({
  ^bb0(%arg1: memref<*xf32>):
    %14 = "arith.constant"() <{value = 1 : index}> : () -> index
    %15 = "arith.constant"() <{value = 2 : index}> : () -> index
    %16 = "memref.dim"(%arg1, %15) : (memref<*xf32>, index) -> index
    "gpu.launch_func"(%14, %14, %14, %14, %14, %14, %arg1) <{kernel = @multiple_uses2_kernel::@multiple_uses2_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0>}> : (index, index, index, index, index, index, memref<*xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "multiple_uses2_kernel"}> ({
    "gpu.func"() <{function_type = (memref<*xf32>) -> (), known_block_size = array<i32: 1, 1, 1>, known_grid_size = array<i32: 1, 1, 1>}> ({
    ^bb0(%arg0: memref<*xf32>):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "arith.constant"() <{value = 2 : index}> : () -> index
      %13 = "memref.dim"(%arg0, %12) : (memref<*xf32>, index) -> index
      "use1"(%13) : (index) -> ()
      "use2"(%12, %12) : (index, index) -> ()
      "use3"(%arg0) : (memref<*xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "multiple_uses2_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = i64, linkage = #llvm.linkage<internal>, sym_name = "global", unnamed_addr = 0 : i64, value = 42 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "function_call"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %13 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch_func"(%13, %13, %13, %13, %13, %13) <{kernel = @function_call_kernel::@function_call_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "function_call_kernel"}> ({
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 8, 8, 8>, known_grid_size = array<i32: 8, 8, 8>}> ({
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "func.call"() <{callee = @device_function}> : () -> ()
      "func.call"() <{callee = @device_function}> : () -> ()
      %12 = "llvm.mlir.addressof"() <{global_name = @global}> : () -> !llvm.ptr
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "function_call_kernel", workgroup_attributions = 0 : i64} : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "device_function"}> ({
      "func.call"() <{callee = @recursive_device_function}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = i64, linkage = #llvm.linkage<internal>, sym_name = "global", unnamed_addr = 0 : i64, value = 42 : i64, visibility_ = 0 : i64}> ({
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "recursive_device_function"}> ({
      "func.call"() <{callee = @recursive_device_function}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "device_function"}> ({
    "func.call"() <{callee = @recursive_device_function}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "recursive_device_function"}> ({
    "func.call"() <{callee = @recursive_device_function}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "non_constant_launches"}> ({
  ^bb0(%arg0: index):
    "gpu.launch_func"(%arg0, %arg0, %arg0, %arg0, %arg0, %arg0) <{kernel = @non_constant_launches_kernel::@non_constant_launches_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "non_constant_launches_kernel"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "non_constant_launches_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "launch_memory_attributions_0"}> ({
    %15 = "op"() : () -> memref<?xf32, 1>
    %16 = "arith.constant"() <{value = 128 : index}> : () -> index
    "gpu.launch_func"(%16, %16, %16, %16, %16, %16, %15) <{kernel = @launch_memory_attributions_0_kernel::@launch_memory_attributions_0_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0>}> : (index, index, index, index, index, index, memref<?xf32, 1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "launch_memory_attributions_0_kernel"}> ({
    "gpu.func"() <{function_type = (memref<?xf32, 1>) -> (), known_block_size = array<i32: 128, 128, 128>, known_grid_size = array<i32: 128, 128, 128>}> ({
    ^bb0(%arg0: memref<?xf32, 1>, %arg1: memref<42xf32, 3>, %arg2: memref<2xf32, 5>, %arg3: memref<1xf32, 5>):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "some_op"(%0, %9) : (index, index) -> ()
      %12 = "memref.load"(%arg0, %3) : (memref<?xf32, 1>, index) -> f32
      %13 = "memref.load"(%arg1, %3) : (memref<42xf32, 3>, index) -> f32
      %14 = "memref.load"(%arg3, %3) : (memref<1xf32, 5>, index) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "launch_memory_attributions_0_kernel", workgroup_attributions = 1 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> (), sym_name = "launch_memory_attributions_1"}> ({
  ^bb0(%arg1: memref<*xf32>):
    %14 = "arith.constant"() <{value = 1 : index}> : () -> index
    %15 = "arith.constant"() <{value = 2 : index}> : () -> index
    %16 = "memref.dim"(%arg1, %15) : (memref<*xf32>, index) -> index
    "gpu.launch_func"(%14, %14, %14, %14, %14, %14) <{kernel = @launch_memory_attributions_1_kernel::@launch_memory_attributions_1_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "launch_memory_attributions_1_kernel"}> ({
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 1, 1, 1>, known_grid_size = array<i32: 1, 1, 1>}> ({
    ^bb0(%arg0: memref<3xf32, 5>):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "arith.constant"() <{value = 2 : index}> : () -> index
      %13 = "memref.load"(%arg0, %12) : (memref<3xf32, 5>, index) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "launch_memory_attributions_1_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "launch_cluster"}> ({
    %19 = "op"() : () -> f32
    %20 = "op"() : () -> memref<?xf32, 1>
    %21 = "arith.constant"() <{value = 1 : index}> : () -> index
    %22 = "arith.constant"() <{value = 2 : index}> : () -> index
    %23 = "arith.constant"() <{value = 1 : index}> : () -> index
    %24 = "arith.constant"() <{value = 8 : index}> : () -> index
    %25 = "arith.constant"() <{value = 12 : index}> : () -> index
    %26 = "arith.constant"() <{value = 16 : index}> : () -> index
    %27 = "arith.constant"() <{value = 20 : index}> : () -> index
    %28 = "arith.constant"() <{value = 24 : index}> : () -> index
    %29 = "arith.constant"() <{value = 28 : index}> : () -> index
    "gpu.launch_func"(%24, %25, %26, %27, %28, %29, %21, %22, %23, %19, %20) <{kernel = @launch_cluster_kernel::@launch_cluster_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 2, 0>}> : (index, index, index, index, index, index, index, index, index, f32, memref<?xf32, 1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "launch_cluster_kernel"}> ({
    "gpu.func"() <{function_type = (f32, memref<?xf32, 1>) -> (), known_block_size = array<i32: 20, 24, 28>, known_grid_size = array<i32: 8, 12, 16>}> ({
    ^bb0(%arg0: f32, %arg1: memref<?xf32, 1>):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "gpu.cluster_id"() <{dimension = #gpu<dim x>}> : () -> index
      %13 = "gpu.cluster_id"() <{dimension = #gpu<dim y>}> : () -> index
      %14 = "gpu.cluster_id"() <{dimension = #gpu<dim z>}> : () -> index
      %15 = "gpu.cluster_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %16 = "gpu.cluster_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %17 = "gpu.cluster_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "use"(%arg0) : (f32) -> ()
      "some_op"(%12, %0, %9) : (index, index, index) -> ()
      %18 = "memref.load"(%arg1, %3) : (memref<?xf32, 1>, index) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "launch_cluster_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "testKernelAttributes"}> ({
    %12 = "arith.constant"() <{value = 8 : index}> : () -> index
    %13 = "arith.constant"() <{value = 12 : index}> : () -> index
    %14 = "arith.constant"() <{value = 16 : index}> : () -> index
    %15 = "arith.constant"() <{value = 32 : index}> : () -> index
    %16 = "arith.constant"() <{value = 16 : index}> : () -> index
    %17 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch_func"(%12, %13, %14, %15, %16, %17) <{kernel = @test_module::@test_kernel_func, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module"}> ({
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 32, 16, 8>, known_grid_size = array<i32: 8, 12, 16>}> ({
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "some_op"(%0, %3) : (index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "test_kernel_func", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "existing_module"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.return"() : () -> ()
    }) {sym_name = "test_kernel_func", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 32, 16, 8>, known_grid_size = array<i32: 8, 12, 16>}> ({
      %6 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %13 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %14 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %15 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %16 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %17 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "some_op"(%6, %9) : (index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "test_kernel_func_0", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "testExistingModule"}> ({
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 12 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "arith.constant"() <{value = 32 : index}> : () -> index
    %4 = "arith.constant"() <{value = 16 : index}> : () -> index
    %5 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch_func"(%0, %1, %2, %3, %4, %5) <{kernel = @existing_module::@test_kernel_func_0, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "testKernelModuleOnly"}> ({
    %12 = "arith.constant"() <{value = 8 : index}> : () -> index
    %13 = "arith.constant"() <{value = 12 : index}> : () -> index
    %14 = "arith.constant"() <{value = 16 : index}> : () -> index
    %15 = "arith.constant"() <{value = 32 : index}> : () -> index
    %16 = "arith.constant"() <{value = 16 : index}> : () -> index
    %17 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch_func"(%12, %13, %14, %15, %16, %17) <{kernel = @test_module::@testKernelModuleOnly_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_module"}> ({
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 32, 16, 8>, known_grid_size = array<i32: 8, 12, 16>}> ({
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "some_op"(%0, %3) : (index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "testKernelModuleOnly_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "testKernelFuncOnly"}> ({
    %12 = "arith.constant"() <{value = 8 : index}> : () -> index
    %13 = "arith.constant"() <{value = 12 : index}> : () -> index
    %14 = "arith.constant"() <{value = 16 : index}> : () -> index
    %15 = "arith.constant"() <{value = 32 : index}> : () -> index
    %16 = "arith.constant"() <{value = 16 : index}> : () -> index
    %17 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch_func"(%12, %13, %14, %15, %16, %17) <{kernel = @test_kernel_func::@test_kernel_func, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "test_kernel_func"}> ({
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 32, 16, 8>, known_grid_size = array<i32: 8, 12, 16>}> ({
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "some_op"(%0, %3) : (index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "test_kernel_func", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "testNoAttributes"}> ({
    %12 = "arith.constant"() <{value = 8 : index}> : () -> index
    %13 = "arith.constant"() <{value = 12 : index}> : () -> index
    %14 = "arith.constant"() <{value = 16 : index}> : () -> index
    %15 = "arith.constant"() <{value = 32 : index}> : () -> index
    %16 = "arith.constant"() <{value = 16 : index}> : () -> index
    %17 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch_func"(%12, %13, %14, %15, %16, %17) <{kernel = @testNoAttributes_kernel::@testNoAttributes_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "testNoAttributes_kernel"}> ({
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 32, 16, 8>, known_grid_size = array<i32: 8, 12, 16>}> ({
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "some_op"(%0, %3) : (index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "testNoAttributes_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "nested_launch"}> ({
  ^bb0(%arg1: index):
    "gpu.launch_func"(%arg1, %arg1, %arg1, %arg1, %arg1, %arg1, %arg1) <{kernel = @nested_launch_kernel_0::@nested_launch_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0>}> : (index, index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "nested_launch_kernel"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %12 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %13 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %14 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %15 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %16 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %17 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %18 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %19 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %20 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %21 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %22 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %23 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "some_op"(%12, %15) : (index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "nested_launch_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "nested_launch_kernel_0"}> ({
    "gpu.func"() <{function_type = (index) -> ()}> ({
    ^bb0(%arg0: index):
      %0 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %2 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim y>}> : () -> index
      %5 = "gpu.thread_id"() <{dimension = #gpu<dim z>}> : () -> index
      %6 = "gpu.grid_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "gpu.grid_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %8 = "gpu.grid_dim"() <{dimension = #gpu<dim z>}> : () -> index
      %9 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_dim"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_dim"() <{dimension = #gpu<dim z>}> : () -> index
      "gpu.launch_func"(%arg0, %arg0, %arg0, %arg0, %arg0, %arg0) <{kernel = @nested_launch_kernel::@nested_launch_kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "nested_launch_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

