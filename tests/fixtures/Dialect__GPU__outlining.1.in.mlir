"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "launch"}> ({
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<?xf32, 1>
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "arith.constant"() <{value = 12 : index}> : () -> index
    %4 = "arith.constant"() <{value = 16 : index}> : () -> index
    %5 = "arith.constant"() <{value = 20 : index}> : () -> index
    %6 = "arith.constant"() <{value = 24 : index}> : () -> index
    %7 = "arith.constant"() <{value = 28 : index}> : () -> index
    "gpu.launch"(%2, %3, %4, %5, %6, %7) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "use"(%0) : (f32) -> ()
      "some_op"(%arg0, %arg9) : (index, index) -> ()
      %8 = "memref.load"(%1, %arg3) : (memref<?xf32, 1>, index) -> f32
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "launchCFG"}> ({
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<?xf32, 1>
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "arith.constant"() <{value = 12 : index}> : () -> index
    %4 = "arith.constant"() <{value = 16 : index}> : () -> index
    %5 = "arith.constant"() <{value = 20 : index}> : () -> index
    %6 = "arith.constant"() <{value = 24 : index}> : () -> index
    %7 = "arith.constant"() <{value = 28 : index}> : () -> index
    "gpu.launch"(%2, %3, %4, %5, %6, %7) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "use"(%0) : (f32) -> ()
      "cf.br"()[^bb1] : () -> ()
    ^bb1:  // pred: ^bb0
      "some_op"(%arg0, %arg9) : (index, index) -> ()
      %8 = "memref.load"(%1, %arg3) : (memref<?xf32, 1>, index) -> f32
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "launch_from_llvm_func", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<?xf32, 1>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch"(%2, %2, %2, %2, %2, %2) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "use"(%0) : (f32) -> ()
      "some_op"(%arg0, %arg9) : (index, index) -> ()
      %3 = "memref.load"(%1, %arg3) : (memref<?xf32, 1>, index) -> f32
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "multiple_launches"}> ({
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch"(%0, %0, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg36: index, %arg37: index, %arg38: index, %arg39: index, %arg40: index, %arg41: index, %arg42: index, %arg43: index, %arg44: index, %arg45: index, %arg46: index, %arg47: index):
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "gpu.launch"(%0, %0, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg24: index, %arg25: index, %arg26: index, %arg27: index, %arg28: index, %arg29: index, %arg30: index, %arg31: index, %arg32: index, %arg33: index, %arg34: index, %arg35: index):
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    %1 = "gpu.wait"() : () -> !gpu.async.token
    %2 = "gpu.launch"(%1, %0, %0, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index, %arg18: index, %arg19: index, %arg20: index, %arg21: index, %arg22: index, %arg23: index):
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (!gpu.async.token, index, index, index, index, index, index) -> !gpu.async.token
    %3 = "gpu.launch"(%0, %0, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> !gpu.async.token
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "extra_constants_not_inlined"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "secret_constant"() : () -> index
    "gpu.launch"(%0, %0, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      "use"(%1, %arg0, %3) : (index, memref<?xf32>, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "extra_constants"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %2) : (memref<?xf32>, index) -> index
    "gpu.launch"(%0, %0, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      "use"(%1, %arg0, %3) : (index, memref<?xf32>, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "extra_constants_noarg"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%arg1, %2) : (memref<?xf32>, index) -> index
    "gpu.launch"(%0, %0, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index):
      "use"(%1, %arg0, %3) : (index, memref<?xf32>, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "multiple_uses"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    "gpu.launch"(%0, %0, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      "use1"(%1, %1) : (index, index) -> ()
      "use2"(%1) : (index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> (), sym_name = "multiple_uses2"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %1) : (memref<*xf32>, index) -> index
    "gpu.launch"(%0, %0, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      "use1"(%2) : (index) -> ()
      "use2"(%1, %1) : (index, index) -> ()
      "use3"(%arg0) : (memref<*xf32>) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.mlir.global"() <{addr_space = 0 : i32, global_type = i64, linkage = #llvm.linkage<internal>, sym_name = "global", unnamed_addr = 0 : i64, value = 42 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "function_call"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch"(%0, %0, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      "func.call"() <{callee = @device_function}> : () -> ()
      "func.call"() <{callee = @device_function}> : () -> ()
      %1 = "llvm.mlir.addressof"() <{global_name = @global}> : () -> !llvm.ptr
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "device_function"}> ({
    "func.call"() <{callee = @recursive_device_function}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "recursive_device_function"}> ({
    "func.call"() <{callee = @recursive_device_function}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "non_constant_launches"}> ({
  ^bb0(%arg0: index):
    "gpu.launch"(%arg0, %arg0, %arg0, %arg0, %arg0, %arg0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "launch_memory_attributions_0"}> ({
    %0 = "op"() : () -> memref<?xf32, 1>
    %1 = "arith.constant"() <{value = 128 : index}> : () -> index
    "gpu.launch"(%1, %1, %1, %1, %1, %1) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: memref<42xf32, 3>, %arg13: memref<2xf32, 5>, %arg14: memref<1xf32, 5>):
      "some_op"(%arg0, %arg9) : (index, index) -> ()
      %2 = "memref.load"(%0, %arg3) : (memref<?xf32, 1>, index) -> f32
      %3 = "memref.load"(%arg12, %arg3) : (memref<42xf32, 3>, index) -> f32
      %4 = "memref.load"(%arg14, %arg3) : (memref<1xf32, 5>, index) -> f32
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 1 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> (), sym_name = "launch_memory_attributions_1"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %1) : (memref<*xf32>, index) -> index
    "gpu.launch"(%0, %0, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: memref<3xf32, 5>):
      %3 = "memref.load"(%arg13, %1) : (memref<3xf32, 5>, index) -> f32
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "launch_cluster"}> ({
    %0 = "op"() : () -> f32
    %1 = "op"() : () -> memref<?xf32, 1>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 8 : index}> : () -> index
    %6 = "arith.constant"() <{value = 12 : index}> : () -> index
    %7 = "arith.constant"() <{value = 16 : index}> : () -> index
    %8 = "arith.constant"() <{value = 20 : index}> : () -> index
    %9 = "arith.constant"() <{value = 24 : index}> : () -> index
    %10 = "arith.constant"() <{value = 28 : index}> : () -> index
    "gpu.launch"(%5, %6, %7, %8, %9, %10, %2, %3, %4) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      "use"(%0) : (f32) -> ()
      "some_op"(%arg12, %arg0, %arg9) : (index, index, index) -> ()
      %11 = "memref.load"(%1, %arg3) : (memref<?xf32, 1>, index) -> f32
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "testKernelAttributes"}> ({
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 12 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "arith.constant"() <{value = 32 : index}> : () -> index
    %4 = "arith.constant"() <{value = 16 : index}> : () -> index
    %5 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch"(%0, %1, %2, %3, %4, %5) <{function = @test_kernel_func, module = @test_module, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "some_op"(%arg0, %arg3) : (index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "existing_module"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      "gpu.return"() : () -> ()
    }) {sym_name = "test_kernel_func", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "testExistingModule"}> ({
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 12 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "arith.constant"() <{value = 32 : index}> : () -> index
    %4 = "arith.constant"() <{value = 16 : index}> : () -> index
    %5 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch"(%0, %1, %2, %3, %4, %5) <{function = @test_kernel_func, module = @existing_module, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "some_op"(%arg0, %arg3) : (index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "testKernelModuleOnly"}> ({
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 12 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "arith.constant"() <{value = 32 : index}> : () -> index
    %4 = "arith.constant"() <{value = 16 : index}> : () -> index
    %5 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch"(%0, %1, %2, %3, %4, %5) <{module = @test_module, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "some_op"(%arg0, %arg3) : (index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "testKernelFuncOnly"}> ({
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 12 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "arith.constant"() <{value = 32 : index}> : () -> index
    %4 = "arith.constant"() <{value = 16 : index}> : () -> index
    %5 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch"(%0, %1, %2, %3, %4, %5) <{function = @test_kernel_func, operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "some_op"(%arg0, %arg3) : (index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "testNoAttributes"}> ({
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 12 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "arith.constant"() <{value = 32 : index}> : () -> index
    %4 = "arith.constant"() <{value = 16 : index}> : () -> index
    %5 = "arith.constant"() <{value = 8 : index}> : () -> index
    "gpu.launch"(%0, %1, %2, %3, %4, %5) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      "some_op"(%arg0, %arg3) : (index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "nested_launch"}> ({
  ^bb0(%arg0: index):
    "gpu.launch"(%arg0, %arg0, %arg0, %arg0, %arg0, %arg0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      "gpu.launch"(%arg0, %arg0, %arg0, %arg0, %arg0, %arg0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
      ^bb0(%arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index, %arg18: index, %arg19: index, %arg20: index, %arg21: index, %arg22: index, %arg23: index, %arg24: index):
        "some_op"(%arg13, %arg16) : (index, index) -> ()
        "gpu.terminator"() : () -> ()
      }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

