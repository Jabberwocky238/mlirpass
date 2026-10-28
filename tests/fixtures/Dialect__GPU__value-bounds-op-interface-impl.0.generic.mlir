"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "launch_func"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 4 : index}> : () -> index
    %4 = "arith.constant"() <{value = 64 : index}> : () -> index
    "gpu.launch"(%arg0, %3, %2, %4, %3, %2) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      "test.compare"(%arg4, %1) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg4, %4) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg7, %1) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg7, %arg0) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg8, %3) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg9, %2) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg1, %0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg1, %arg0) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%arg2, %0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg2, %3) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%arg3, %0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg3, %2) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%arg10, %4) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg11, %3) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg12, %2) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%arg4, %0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg4, %4) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%arg5, %0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg5, %3) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%arg6, %0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%arg6, %2) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%arg4, %arg10) <{cmp = "LT"}> : (index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "gpu_module"}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "kernel", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = 4294967295 : index}> : () -> index
      %2 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      "test.compare"(%2, %0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%2, %1) <{cmp = "LT"}> : (index, index) -> ()
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "gpu_module"}> ({
    "gpu.func"() <{function_type = () -> (), known_block_size = array<i32: 8, 12, 16>, known_grid_size = array<i32: 20, 24, 28>}> ({
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = 8 : index}> : () -> index
      %2 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      "test.compare"(%2, %0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%2, %1) <{cmp = "LT"}> : (index, index) -> ()
      %3 = "gpu.block_dim"() <{dimension = #gpu<dim x>}> : () -> index
      "test.compare"(%3, %1) <{cmp = "EQ"}> : (index, index) -> ()
      "test.compare"(%2, %3) <{cmp = "LT"}> : (index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "annotated_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "gpu_module"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = 1 : index}> : () -> index
      %2 = "arith.constant"() <{value = 8 : index}> : () -> index
      %3 = "gpu.block_dim"() <{dimension = #gpu<dim x>, upper_bound = 8 : index}> : () -> index
      "test.compare"(%3, %1) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%3, %2) <{cmp = "LE"}> : (index, index) -> ()
      "test.compare"(%3, %2) <{cmp = "EQ"}> : (index, index) -> ()
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim x>, upper_bound = 8 : index}> : () -> index
      "test.compare"(%4, %0) <{cmp = "GE"}> : (index, index) -> ()
      "test.compare"(%4, %2) <{cmp = "LT"}> : (index, index) -> ()
      "test.compare"(%4, %3) <{cmp = "LT"}> : (index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "local_bounds_kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

