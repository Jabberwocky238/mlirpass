"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel_module", targets = [#nvvm.target]}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "kernel", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg1: i32, %arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: i64, %arg5: i64, %arg6: i64):
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "foo"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    "gpu.launch_func"(%0, %0, %0, %0, %0, %0, %2, %1, %arg0) <{kernel = @kernel_module::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 2, 0>}> : (index, index, index, index, index, index, i32, i32, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel_module", targets = [#nvvm.target]}> ({
    "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void (i32, ptr, ptr, i64, i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "kernel", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    ^bb0(%arg1: i32, %arg2: !llvm.ptr, %arg3: !llvm.ptr, %arg4: i64, %arg5: i64, %arg6: i64):
      "llvm.return"() : () -> ()
    }) {gpu.kernel} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "foo"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    "gpu.launch_func"(%0, %0, %0, %0, %0, %0, %3, %3, %3, %2, %1, %arg0) <{kernel = @kernel_module::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0>}> : (index, index, index, index, index, index, index, index, index, i32, i32, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

// -----
"builtin.module"() ({
  "gpu.binary"() <{objects = [#gpu.object<#rocdl.target, "blob">], offloadingHandler = #gpu.select_object, sym_name = "kernel_module"}> : () -> ()
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "foo"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 256 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    "gpu.launch_func"(%0, %0, %0, %0, %0, %0, %3, %3, %3, %2, %1, %arg0) <{kernel = @kernel_module::@kernel, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0>}> : (index, index, index, index, index, index, index, index, index, i32, i32, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

