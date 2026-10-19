"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "fold_wait_op_test1"}> ({
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "erase_barriers"}> ({
    "gpu.barrier"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (memref<5xf16>, memref<5xf16>), sym_name = "fold_wait_op_test2"}> ({
  ^bb0(%arg0: i1):
    %0 = "gpu.wait"() : () -> !gpu.async.token
    %1:2 = "gpu.alloc"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (!gpu.async.token) -> (memref<5xf16>, !gpu.async.token)
    %2 = "gpu.wait"() : () -> !gpu.async.token
    %3:2 = "gpu.alloc"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (!gpu.async.token) -> (memref<5xf16>, !gpu.async.token)
    "func.return"(%1#0, %3#0) : (memref<5xf16>, memref<5xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "fold_memcpy_op"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %1 = "gpu.wait"() : () -> !gpu.async.token
    %2:2 = "gpu.alloc"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (!gpu.async.token) -> (memref<2xf16>, !gpu.async.token)
    "affine.store"(%0, %2#0) <{map = #map}> : (f16, memref<2xf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<2xf16>) -> (), sym_name = "do_not_fold_memcpy_op1"}> ({
  ^bb0(%arg0: i1, %arg1: memref<2xf16>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %1 = "gpu.wait"() : () -> !gpu.async.token
    %2:2 = "gpu.alloc"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (!gpu.async.token) -> (memref<2xf16>, !gpu.async.token)
    "affine.store"(%0, %2#0) <{map = #map}> : (f16, memref<2xf16>) -> ()
    %3 = "gpu.wait"() : () -> !gpu.async.token
    %4 = "gpu.memcpy"(%3, %arg1, %2#0) : (!gpu.async.token, memref<2xf16>, memref<2xf16>) -> !gpu.async.token
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (i1, index) -> f16, sym_name = "do_not_fold_memcpy_op2"}> ({
  ^bb0(%arg0: i1, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf16>
    %2 = "gpu.wait"() : () -> !gpu.async.token
    %3:2 = "gpu.alloc"(%2) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (!gpu.async.token) -> (memref<2xf16>, !gpu.async.token)
    "affine.store"(%0, %3#0) <{map = #map}> : (f16, memref<2xf16>) -> ()
    %4 = "gpu.wait"() : () -> !gpu.async.token
    %5 = "gpu.memcpy"(%4, %1, %3#0) : (!gpu.async.token, memref<2xf16>, memref<2xf16>) -> !gpu.async.token
    %6 = "memref.load"(%1, %arg1) : (memref<2xf16>, index) -> f16
    "func.return"(%6) : (f16) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1xi8>, memref<i1>) -> (), sym_name = "do_not_fold_memcpy_op3"}> ({
  ^bb0(%arg0: memref<1xi8>, %arg1: memref<i1>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.view"(%arg0, %0) : (memref<1xi8>, index) -> memref<i1>
    "gpu.memcpy"(%1, %arg1) : (memref<i1>, memref<i1>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32>, memref<10xf32>) -> (), sym_name = "memcpy_after_cast"}> ({
  ^bb0(%arg0: memref<10xf32>, %arg1: memref<10xf32>):
    "gpu.memcpy"(%arg0, %arg1) : (memref<10xf32>, memref<10xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32>, f32) -> (), sym_name = "memset_after_cast"}> ({
  ^bb0(%arg0: memref<10xf32>, %arg1: f32):
    "gpu.memset"(%arg0, %arg1) : (memref<10xf32>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "gpu_dim_of_alloc"}> ({
  ^bb0(%arg0: index):
    "func.return"(%arg0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi8>, index) -> index, sym_name = "out_of_bound_memref.dim"}> ({
  ^bb0(%arg0: memref<?xi8>, %arg1: index):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xi8>, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "simplify_gpu_launch"}> ({
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x16x16xf32>
    "scf.for"(%5, %4, %1) ({
    ^bb0(%arg12: index):
      "scf.for"(%5, %3, %1) ({
      ^bb0(%arg13: index):
        "scf.for"(%5, %3, %1) ({
        ^bb0(%arg14: index):
          "memref.store"(%0, %6, %arg12, %arg13, %arg14) : (f32, memref<2x16x16xf32>, index, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    %7 = "gpu.wait"() : () -> !gpu.async.token
    %8:2 = "gpu.alloc"(%7) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (!gpu.async.token) -> (memref<2x16x16xf32>, !gpu.async.token)
    %9 = "gpu.memcpy"(%7, %8#0, %6) : (!gpu.async.token, memref<2x16x16xf32>, memref<2x16x16xf32>) -> !gpu.async.token
    "gpu.launch"(%1, %1, %1, %2, %1, %1) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %10 = "arith.divui"(%arg3, %2) : (index, index) -> index
      %11 = "arith.muli"(%10, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "memref.load"(%8#0, %11, %5, %5) : (memref<2x16x16xf32>, index, index, index) -> f32
      %13 = "arith.addi"(%11, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "memref.load"(%8#0, %13, %5, %5) : (memref<2x16x16xf32>, index, index, index) -> f32
      "memref.store"(%12, %8#0, %11, %5, %5) : (f32, memref<2x16x16xf32>, index, index, index) -> ()
      "memref.store"(%14, %8#0, %13, %5, %5) : (f32, memref<2x16x16xf32>, index, index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) {llvm.emit_c_interface} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "make_reduce_uniform"}> ({
    %0:6 = "test.test1"() : () -> (index, index, index, index, index, index)
    "gpu.launch"(%0#0, %0#1, %0#2, %0#3, %0#4, %0#5) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %1 = "test.test2"() : () -> i32
      %2 = "gpu.all_reduce"(%1) <{op = #gpu<all_reduce_op add>, uniform}> ({
      }) : (i32) -> i32
      "test.test3"(%2) : (i32) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "make_subgroup_reduce_uniform"}> ({
    %0:6 = "test.test1"() : () -> (index, index, index, index, index, index)
    "gpu.launch"(%0#0, %0#1, %0#2, %0#3, %0#4, %0#5) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %1 = "test.test2"() : () -> i32
      %2 = "gpu.subgroup_reduce"(%1) <{cluster_stride = 1 : i32, op = #gpu<all_reduce_op add>, uniform}> : (i32) -> i32
      "test.test3"(%2) : (i32) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "subgroup_reduce_cluster_size_1"}> ({
    %0:6 = "test.test1"() : () -> (index, index, index, index, index, index)
    "gpu.launch"(%0#0, %0#1, %0#2, %0#3, %0#4, %0#5) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %1 = "test.test2"() : () -> i32
      "test.test3"(%1) : (i32) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "gpu_launch_without_side_effects"}> ({
    %0:6 = "test.test1"() : () -> (index, index, index, index, index, index)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, i32) -> f32, sym_name = "broadcast_of_broadcast1"}> ({
  ^bb0(%arg2: f32, %arg3: i32):
    %1 = "gpu.subgroup_broadcast"(%arg2) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (f32) -> f32
    "func.return"(%1) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32) -> f32, sym_name = "broadcast_of_broadcast2"}> ({
  ^bb0(%arg0: f32, %arg1: i32):
    %0 = "gpu.subgroup_broadcast"(%arg0, %arg1) <{broadcast_type = #gpu<broadcast specific_lane>}> : (f32, i32) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

