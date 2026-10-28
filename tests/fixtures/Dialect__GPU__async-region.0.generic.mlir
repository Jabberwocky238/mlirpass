"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernels"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kernel", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "async"}> ({
  ^bb0(%arg10: index):
    %36 = "gpu.wait"() : () -> !gpu.async.token
    %37 = "gpu.launch_func"(%36, %arg10, %arg10, %arg10, %arg10, %arg10, %arg10) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    %38 = "gpu.launch_func"(%37, %arg10, %arg10, %arg10, %arg10, %arg10, %arg10) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    %39:2 = "gpu.alloc"(%38) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (!gpu.async.token) -> (memref<7xf32>, !gpu.async.token)
    %40 = "gpu.dealloc"(%39#1, %39#0) : (!gpu.async.token, memref<7xf32>) -> !gpu.async.token
    "gpu.wait"(%40) : (!gpu.async.token) -> ()
    "func.call"() <{callee = @foo}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "defer_wait"}> ({
  ^bb0(%arg8: index):
    %29:2 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %34 = "gpu.wait"() : () -> !gpu.async.token
      %35 = "gpu.launch_func"(%34, %arg8, %arg8, %arg8, %arg8, %arg8, %arg8) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
      "async.yield"(%35) : (!gpu.async.token) -> ()
    }) : () -> (!async.token, !async.value<!gpu.async.token>)
    %30:2 = "async.execute"(%29#0, %29#1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: !gpu.async.token):
      %32 = "gpu.wait"(%arg9) : (!gpu.async.token) -> !gpu.async.token
      %33 = "gpu.launch_func"(%32, %arg8, %arg8, %arg8, %arg8, %arg8, %arg8) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
      "async.yield"(%33) : (!gpu.async.token) -> ()
    }) : (!async.token, !async.value<!gpu.async.token>) -> (!async.token, !async.value<!gpu.async.token>)
    "async.await"(%30#0) : (!async.token) -> ()
    %31 = "async.await"(%30#1) : (!async.value<!gpu.async.token>) -> !gpu.async.token
    "gpu.wait"(%31) : (!gpu.async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "defer_wait_blocked_by_side_effect"}> ({
  ^bb0(%arg7: index):
    %26 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %27 = "gpu.wait"() : () -> !gpu.async.token
      %28 = "gpu.launch_func"(%27, %arg7, %arg7, %arg7, %arg7, %arg7, %arg7) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
      "gpu.wait"(%28) : (!gpu.async.token) -> ()
      "func.call"() <{callee = @foo}> : () -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    "async.await"(%26) : (!async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "defer_wait_pass_through"}> ({
  ^bb0(%arg5: index):
    %21:2 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %24 = "gpu.wait"() : () -> !gpu.async.token
      %25 = "gpu.launch_func"(%24, %arg5, %arg5, %arg5, %arg5, %arg5, %arg5) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
      "async.yield"(%25) : (!gpu.async.token) -> ()
    }) : () -> (!async.token, !async.value<!gpu.async.token>)
    %22:2 = "async.execute"(%21#0, %21#1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: !gpu.async.token):
      "async.yield"(%arg6) : (!gpu.async.token) -> ()
    }) : (!async.token, !async.value<!gpu.async.token>) -> (!async.token, !async.value<!gpu.async.token>)
    "async.await"(%22#0) : (!async.token) -> ()
    %23 = "async.await"(%22#1) : (!async.value<!gpu.async.token>) -> !gpu.async.token
    "gpu.wait"(%23) : (!gpu.async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "async_execute_with_result"}> ({
  ^bb0(%arg4: index):
    %16:3 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %19 = "gpu.wait"() : () -> !gpu.async.token
      %20 = "gpu.launch_func"(%19, %arg4, %arg4, %arg4, %arg4, %arg4, %arg4) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
      "async.yield"(%arg4, %20) : (index, !gpu.async.token) -> ()
    }) : () -> (!async.token, !async.value<index>, !async.value<!gpu.async.token>)
    "async.await"(%16#0) : (!async.token) -> ()
    %17 = "async.await"(%16#2) : (!async.value<!gpu.async.token>) -> !gpu.async.token
    "gpu.wait"(%17) : (!gpu.async.token) -> ()
    %18 = "async.await"(%16#1) : (!async.value<index>) -> index
    "func.return"(%18) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "async_execute_no_use"}> ({
  ^bb0(%arg3: index):
    %13 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %14 = "gpu.wait"() : () -> !gpu.async.token
      %15 = "gpu.launch_func"(%14, %arg3, %arg3, %arg3, %arg3, %arg3, %arg3) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
      "gpu.wait"(%15) : (!gpu.async.token) -> ()
      "async.yield"() : () -> ()
    }) : () -> !async.token
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "async_execute_fork"}> ({
  ^bb0(%arg0: index):
    %4:3 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %11 = "gpu.wait"() : () -> !gpu.async.token
      %12 = "gpu.launch_func"(%11, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
      "async.yield"(%12, %12) : (!gpu.async.token, !gpu.async.token) -> ()
    }) : () -> (!async.token, !async.value<!gpu.async.token>, !async.value<!gpu.async.token>)
    %5 = "async.execute"(%4#0, %4#1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: !gpu.async.token):
      %9 = "gpu.wait"(%arg2) : (!gpu.async.token) -> !gpu.async.token
      %10 = "gpu.launch_func"(%9, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
      "gpu.wait"(%10) : (!gpu.async.token) -> ()
      "async.yield"() : () -> ()
    }) : (!async.token, !async.value<!gpu.async.token>) -> !async.token
    %6 = "async.execute"(%4#0, %4#2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: !gpu.async.token):
      %7 = "gpu.wait"(%arg1) : (!gpu.async.token) -> !gpu.async.token
      %8 = "gpu.launch_func"(%7, %arg0, %arg0, %arg0, %arg0, %arg0, %arg0) <{kernel = @kernels::@kernel, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0>}> : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
      "gpu.wait"(%8) : (!gpu.async.token) -> ()
      "async.yield"() : () -> ()
    }) : (!async.token, !async.value<!gpu.async.token>) -> !async.token
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "existing_tokens"}> ({
    %0 = "gpu.wait"() : () -> !gpu.async.token
    %1 = "gpu.wait"(%0) : (!gpu.async.token) -> !gpu.async.token
    %2:2 = "gpu.alloc"(%1, %0) <{operandSegmentSizes = array<i32: 2, 0, 0>}> : (!gpu.async.token, !gpu.async.token) -> (memref<7xf32>, !gpu.async.token)
    %3 = "gpu.dealloc"(%2#1, %2#0) : (!gpu.async.token, memref<7xf32>) -> !gpu.async.token
    "gpu.wait"(%3) : (!gpu.async.token) -> ()
    "gpu.wait"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

