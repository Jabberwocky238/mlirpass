"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>) -> (), sym_name = "yield_launch_token"}> ({
  ^bb0(%arg5: memref<?xi32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1:2 = "async.execute"() <{operandSegmentSizes = array<i32: 0, 0>}> ({
      %2 = "gpu.wait"() : () -> !gpu.async.token
      %3 = "gpu.launch_func"(%2, %0, %0, %0, %0, %0, %0, %arg5) <{kernel = @kmod::@kernel, operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0>}> : (!gpu.async.token, index, index, index, index, index, index, memref<?xi32>) -> !gpu.async.token
      "async.yield"(%3) : (!gpu.async.token) -> ()
    }) : () -> (!async.token, !async.value<!gpu.async.token>)
    "func.return"() : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "kmod", targets = [#nvvm.target]}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "kernel", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64, %arg4: i64):
      "llvm.return"() : () -> ()
    }) {gpu.kernel, nvvm.kernel} : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

