"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "async"}> ({
  ^bb0(%arg6: index):
    "gpu.launch_func"(%arg6, %arg6, %arg6, %arg6, %arg6, %arg6) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    "gpu.launch_func"(%arg6, %arg6, %arg6, %arg6, %arg6, %arg6) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
    %15 = "gpu.alloc"() <{operandSegmentSizes = array<i32: 0, 0, 0>}> : () -> memref<7xf32>
    "gpu.dealloc"(%15) : (memref<7xf32>) -> ()
    "func.call"() <{callee = @foo}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "defer_wait"}> ({
  ^bb0(%arg5: index):
    %13 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      "gpu.launch_func"(%arg5, %arg5, %arg5, %arg5, %arg5, %arg5) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    %14 = "async.execute"(%13) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      "gpu.launch_func"(%arg5, %arg5, %arg5, %arg5, %arg5, %arg5) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
      "async.yield"() : () -> ()
    }) : (!async.token) -> !async.token
    "async.await"(%14) : (!async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "defer_wait_blocked_by_side_effect"}> ({
  ^bb0(%arg4: index):
    %12 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      "gpu.launch_func"(%arg4, %arg4, %arg4, %arg4, %arg4, %arg4) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
      "func.call"() <{callee = @foo}> : () -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    "async.await"(%12) : (!async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "defer_wait_pass_through"}> ({
  ^bb0(%arg3: index):
    %10 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      "gpu.launch_func"(%arg3, %arg3, %arg3, %arg3, %arg3, %arg3) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    %11 = "async.execute"(%10) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      "async.yield"() : () -> ()
    }) : (!async.token) -> !async.token
    "async.await"(%11) : (!async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "async_execute_with_result"}> ({
  ^bb0(%arg2: index):
    %8:2 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      "gpu.launch_func"(%arg2, %arg2, %arg2, %arg2, %arg2, %arg2) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
      "async.yield"(%arg2) : (index) -> ()
    }) : () -> (!async.token, !async.value<index>)
    "async.await"(%8#0) : (!async.token) -> ()
    %9 = "async.await"(%8#1) : (!async.value<index>) -> index
    "func.return"(%9) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "async_execute_no_use"}> ({
  ^bb0(%arg1: index):
    %7 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      "gpu.launch_func"(%arg1, %arg1, %arg1, %arg1, %arg1, %arg1) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "async_execute_fork"}> ({
  ^bb0(%arg0: index):
    %4 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      "gpu.launch_func"(%arg0, %arg0, %arg0, %arg0, %arg0, %arg0) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    %5 = "async.execute"(%4) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      "gpu.launch_func"(%arg0, %arg0, %arg0, %arg0, %arg0, %arg0) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
      "async.yield"() : () -> ()
    }) : (!async.token) -> !async.token
    %6 = "async.execute"(%4) <{operandSegmentSizes = array<i32: 1, 0>}> ({
      "gpu.launch_func"(%arg0, %arg0, %arg0, %arg0, %arg0, %arg0) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (index, index, index, index, index, index) -> ()
      "async.yield"() : () -> ()
    }) : (!async.token) -> !async.token
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "existing_tokens"}> ({
    %0 = "gpu.wait"() : () -> !gpu.async.token
    %1 = "gpu.wait"(%0) : (!gpu.async.token) -> !gpu.async.token
    %2 = "gpu.alloc"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (!gpu.async.token) -> memref<7xf32>
    %3 = "gpu.dealloc"(%2) : (memref<7xf32>) -> !gpu.async.token
    "gpu.wait"() : () -> ()
    "gpu.wait"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

