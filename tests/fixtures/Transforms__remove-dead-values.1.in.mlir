"builtin.module"() ({
  "memref.global"() <{alignment = 16 : i64, constant, initial_value = dense<[1, 2, 3, 4]> : tensor<4xi32>, sym_name = "__constant_4xi32", sym_visibility = "private", type = memref<4xi32>}> : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "main"}> ({
  ^bb0(%arg0: i32):
    %0 = "tensor.empty"() : () -> tensor<10xbf16>
    %1 = "memref.get_global"() <{name = @__constant_4xi32}> : () -> memref<4xi32>
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "named_module_acceptable"}> ({
  "func.func"() <{function_type = (tensor<10xf32>) -> tensor<10xf32>, sym_name = "main"}> ({
  ^bb0(%arg0: tensor<10xf32>):
    %0 = "tensor.empty"() : () -> tensor<10xbf16>
    "func.return"(%arg0) : (tensor<10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "acceptable_ir_has_cleanable_loop_of_conditional_and_branch_op"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "cf.br"(%0)[^bb1] : (i32) -> ()
  ^bb1(%1: i32):  // 2 preds: ^bb0, ^bb2
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.br"(%1, %2)[^bb2] : (i32, i32) -> ()
  ^bb2(%3: i32, %4: i32):  // pred: ^bb1
    "cf.cond_br"(%arg0, %3, %3)[^bb1, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i32, i32) -> ()
  ^bb3(%5: i32):  // pred: ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "cleanable_loop_iter_args_value"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 10 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4:2 = "scf.for"(%0, %2, %1, %arg0, %3) ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index):
      %5 = "arith.addi"(%arg2, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%5, %arg3) : (index, index) -> ()
    }) : (index, index, index, index, index) -> (index, index)
    "func.return"(%4#0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "dead_linalg_generic"}> ({
    %0 = "arith.constant"() <{value = dense<54> : tensor<1x25x13xi32>}> : () -> tensor<1x25x13xi32>
    %1 = "arith.constant"() <{value = dense<11> : tensor<1x25x13xi32>}> : () -> tensor<1x25x13xi32>
    %2 = "tensor.empty"() : () -> tensor<1x25x13xi32>
    %3 = "linalg.generic"(%0, %1, %2) <{indexing_maps = [#map, #map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg0: i32, %arg1: i32, %arg2: i32):
      %4 = "arith.xori"(%arg0, %arg1) : (i32, i32) -> i32
      "linalg.yield"(%4) : (i32) -> ()
    }) : (tensor<1x25x13xi32>, tensor<1x25x13xi32>, tensor<1x25x13xi32>) -> tensor<1x25x13xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "clean_func_op_remove_argument_and_return_value", sym_visibility = "private"}> ({
  ^bb0(%arg1: i32):
    "func.return"(%arg1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "main"}> ({
  ^bb0(%arg0: i32):
    %0 = "func.call"(%arg0) <{callee = @clean_func_op_remove_argument_and_return_value}> : (i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "clean_func_op_remove_side_effecting_op", sym_visibility = "private"}> ({
  ^bb0(%arg0: i32):
    "vector.print"(%arg0) <{punctuation = #vector.punctuation<newline>}> : (i32) -> ()
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>, i32) -> (i32, i32), sym_name = "clean_func_op_remove_arguments", sym_visibility = "private"}> ({
  ^bb0(%arg3: memref<i32>, %arg4: i32):
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.addi"(%arg4, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%1, %arg4) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32>, i32, i32) -> (i32, memref<i32>), sym_name = "main"}> ({
  ^bb0(%arg0: memref<i32>, %arg1: i32, %arg2: i32):
    %0:2 = "test.call_on_device"(%arg0, %arg1, %arg2) <{callee = @clean_func_op_remove_arguments}> : (memref<i32>, i32, i32) -> (i32, i32)
    "func.return"(%0#0, %arg0) : (i32, memref<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>) -> (i32, i32), sym_name = "clean_func_op_remove_return_values", sym_visibility = "private"}> ({
  ^bb0(%arg1: memref<i32>):
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "memref.store"(%2, %arg1) : (i32, memref<i32>) -> ()
    "func.return"(%2, %2) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32>) -> i32, sym_name = "main"}> ({
  ^bb0(%arg0: memref<i32>):
    %0:2 = "func.call"(%arg0) <{callee = @clean_func_op_remove_return_values}> : (memref<i32>) -> (i32, i32)
    %1:2 = "func.call"(%arg0) <{callee = @clean_func_op_remove_return_values}> : (memref<i32>) -> (i32, i32)
    "func.return"(%0#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "clean_func_op_dont_remove_return_values", sym_visibility = "private"}> ({
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%2, %2) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "main"}> ({
    %0:2 = "func.call"() <{callee = @clean_func_op_dont_remove_return_values}> : () -> (i32, i32)
    %1:2 = "func.call"() <{callee = @clean_func_op_dont_remove_return_values}> : () -> (i32, i32)
    "func.return"(%0#0, %1#1) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i32, i32) -> i32, sym_name = "clean_region_branch_op_dont_remove_first_2_results_but_remove_first_operand"}> ({
  ^bb0(%arg0: i1, %arg1: i32, %arg2: i32):
    %0:3 = "scf.while"(%arg1, %arg2) ({
    ^bb0(%arg6: i32, %arg7: i32):
      %2 = "arith.addi"(%arg7, %arg7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %3 = "arith.addi"(%arg6, %arg6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.condition"(%arg0, %2, %arg7, %3) : (i1, i32, i32, i32) -> ()
    }, {
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
      %1 = "arith.addi"(%arg4, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%arg5, %1) : (i32, i32) -> ()
    }) : (i32, i32) -> (i32, i32, i32)
    "func.return"(%0#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "clean_region_branch_op_remove_last_2_results_last_2_arguments_and_last_operand"}> ({
  ^bb0(%arg1: i1):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3:4 = "scf.while"(%0, %1, %2) ({
    ^bb0(%arg6: i32, %arg7: i32, %arg8: i32):
      %5 = "arith.addi"(%arg8, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %6 = "func.call"(%arg8) <{callee = @identity}> : (i32) -> i32
      "scf.condition"(%arg1, %arg7, %arg6, %5, %6) : (i1, i32, i32, i32, i32) -> ()
    }, {
    ^bb0(%arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32):
      %4 = "arith.addi"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%arg2, %arg3, %4) : (i32, i32, i32) -> ()
    }) : (i32, i32, i32) -> (i32, i32, i32, i32)
    "func.return"(%3#0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "identity", sym_visibility = "private"}> ({
  ^bb0(%arg0: i32):
    "func.return"(%arg0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<i32>) -> (), sym_name = "clean_region_branch_op_remove_result"}> ({
  ^bb0(%arg0: index, %arg1: memref<i32>):
    %0 = "scf.index_switch"(%arg0) <{cases = array<i64: 1>}> ({
      %2 = "arith.constant"() <{value = 11 : i32}> : () -> i32
      "scf.yield"(%2) : (i32) -> ()
    }, {
      %1 = "arith.constant"() <{value = 10 : i32}> : () -> i32
      "memref.store"(%1, %arg1) : (i32, memref<i32>) -> ()
      "scf.yield"(%1) : (i32) -> ()
    }) : (index) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, memref<i32>, i32) -> (i32, i32, i32, i32), sym_name = "clean_simple_ops", sym_visibility = "private"}> ({
  ^bb0(%arg3: i32, %arg4: memref<i32>, %arg5: i32):
    %1 = "arith.addi"(%arg3, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %3 = "arith.muli"(%1, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %4 = "arith.addi"(%3, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %5 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %6 = "arith.subi"(%arg3, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %7 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %8 = "arith.addi"(%arg3, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "memref.store"(%8, %arg4) : (i32, memref<i32>) -> ()
    "func.return"(%3, %4, %5, %6) : (i32, i32, i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, memref<i32>, i32) -> i32, sym_name = "main"}> ({
  ^bb0(%arg0: i32, %arg1: memref<i32>, %arg2: i32):
    %0:4 = "func.call"(%arg0, %arg1, %arg2) <{callee = @clean_simple_ops}> : (i32, memref<i32>, i32) -> (i32, i32, i32, i32)
    "func.return"(%0#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "clean_region_branch_op_erase_it", sym_visibility = "private"}> ({
  ^bb0(%arg2: i32, %arg3: i1):
    %1 = "scf.while"(%arg2) ({
    ^bb0(%arg5: i32):
      "scf.condition"(%arg3, %arg5) : (i1, i32) -> ()
    }, {
    ^bb0(%arg4: i32):
      "scf.yield"(%arg4) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> (), sym_name = "main"}> ({
  ^bb0(%arg0: i32, %arg1: i1):
    %0 = "func.call"(%arg0, %arg1) <{callee = @clean_region_branch_op_erase_it}> : (i32, i1) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<f32>) -> (), sym_name = "clean_region_branch_op_with_empty_region"}> ({
  ^bb0(%arg0: i1, %arg1: memref<f32>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "scf.if"(%arg0) ({
      "memref.store"(%0, %arg1) : (f32, memref<f32>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<18xf32>) -> (), sym_name = "kernel"}> ({
  ^bb0(%arg0: memref<18xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 18 : index}> : () -> index
    "gpu.launch"(%1, %1, %1, %0, %0, %0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      %2 = "arith.constant"() <{value = 1 : index}> : () -> index
      %3 = "arith.constant"() <{value = 0 : index}> : () -> index
      %4 = "arith.constant"() <{value = 25.4669495 : f32}> : () -> f32
      %5 = "affine.apply"(%arg1, %2, %3) <{map = #map}> : (index, index, index) -> index
      "memref.store"(%4, %arg0, %5) : (f32, memref<18xf32>, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "builtin.module"() <{sym_name = "llvm_unreachable"}> ({
    "func.func"() <{function_type = (tensor<4x4xf32>) -> tensor<4x4xi1>, sym_name = "fn_with_llvm_unreachable", sym_visibility = "private"}> ({
    ^bb0(%arg1: tensor<4x4xf32>):
      "llvm.unreachable"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = (tensor<4x4xf32>) -> (), sym_name = "main", sym_visibility = "private"}> ({
    ^bb0(%arg0: tensor<4x4xf32>):
      %0 = "func.call"(%arg0) <{callee = @fn_with_llvm_unreachable}> : (tensor<4x4xf32>) -> tensor<4x4xi1>
      "llvm.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_block_func_declaration", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<void ()>, linkage = #llvm.linkage<external>, sym_name = "no_block_external_func", sym_visibility = "private", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module_3"}> ({
    "gpu.func"() <{function_type = () -> ()}> ({
      %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %1 = "gpu.all_reduce"(%0) <{uniform}> ({
      ^bb0(%arg0: i32, %arg1: i32):
        %2 = "arith.xori"(%arg0, %arg1) : (i32, i32) -> i32
        "gpu.yield"(%2) : (i32) -> ()
      }) : (i32) -> i32
      "gpu.return"() : () -> ()
    }) {sym_name = "gpu_all_reduce_region", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<1xf32>) -> tensor<1xf32>, sym_name = "linalg_red_add"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<1xf32>):
    %0 = "linalg.generic"(%arg0, %arg1) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %1 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %2 = "arith.subf"(%1, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%1) : (f32) -> ()
    }) : (tensor<?xf32>, tensor<1xf32>) -> tensor<1xf32>
    "func.return"(%0) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xindex>, memref<10xf32>) -> (), sym_name = "test_zero_operands"}> ({
  ^bb0(%arg0: memref<10xindex>, %arg1: memref<10xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.alloca_scope"() ({
      %2 = "arith.addi"(%0, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "memref.store"(%2, %arg0, %0) : (index, memref<10xindex>, index) -> ()
      "memref.alloca_scope.return"(%2) : (index) -> ()
    }) : () -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10xf32>, index) -> (), sym_name = "test_atomic_yield"}> ({
  ^bb0(%arg0: memref<10xf32>, %arg1: index):
    %0 = "memref.generic_atomic_rmw"(%arg0, %arg1) ({
    ^bb0(%arg2: f32):
      %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      "memref.atomic_yield"(%1) : (f32) -> ()
    }) : (memref<10xf32>, index) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "return_void_with_unused_argument"}> ({
  "func.func"() <{function_type = (i32, memref<4xi32>) -> (), sym_name = "fn_return_void_with_unused_argument", sym_visibility = "private"}> ({
  ^bb0(%arg1: i32, %arg2: memref<4xi32>):
    %1 = "arith.addi"(%arg1, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xi32>
    "memref.store"(%1, %3, %2) : (i32, memref<1xi32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> memref<4xi32>, sym_name = "main"}> ({
  ^bb0(%arg0: i32):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xi32>
    "func.call"(%arg0, %0) <{callee = @fn_return_void_with_unused_argument}> : (i32, memref<4xi32>) -> ()
    "func.return"(%0) : (memref<4xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "builtin.module"() <{sym_name = "dynamically_unreachable"}> ({
    "func.func"() <{function_type = () -> (), sym_name = "dynamically_unreachable"}> ({
      %6 = "arith.constant"() <{value = 0 : i64}> : () -> i64
      %7 = "arith.constant"() <{value = false}> : () -> i1
      "cf.cond_br"(%7)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %8 = "arith.cmpi"(%6, %6) <{predicate = 0 : i64}> : (i64, i64) -> i1
      "cf.br"()[^bb1] : () -> ()
    ^bb2:  // pred: ^bb0
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
  "builtin.module"() <{sym_name = "last_block_not_exit"}> ({
    "func.func"() <{function_type = (i1, i1) -> i1, sym_name = "terminated_with_condbr", sym_visibility = "private"}> ({
    ^bb0(%arg0: i1, %arg1: i1):
      %3 = "arith.constant"() <{value = true}> : () -> i1
      %4 = "arith.constant"() <{value = false}> : () -> i1
      "cf.cond_br"(%arg0, %4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i1) -> ()
    ^bb1(%5: i1):  // 3 preds: ^bb0, ^bb2, ^bb2
      "func.return"(%5) : (i1) -> ()
    ^bb2:  // pred: ^bb0
      "cf.cond_br"(%arg1, %4, %3)[^bb1, ^bb1] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i1, i1) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "call_private_but_not_use", sym_visibility = "public"}> ({
      %0 = "arith.constant"() <{value = false}> : () -> i1
      %1 = "arith.constant"() <{value = true}> : () -> i1
      %2 = "func.call"(%0, %1) <{callee = @terminated_with_condbr}> : (i1, i1) -> i1
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "single_parameter", sym_visibility = "private"}> ({
  ^bb0(%arg8: index):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "mutl_parameter", sym_visibility = "private"}> ({
  ^bb0(%arg5: index, %arg6: index, %arg7: index):
    "func.return"(%arg6) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> (), sym_name = "eliminate_parameter", sym_visibility = "private"}> ({
  ^bb0(%arg3: index, %arg4: index):
    "func.call"(%arg3) <{callee = @single_parameter}> : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "callee"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    "func.call"(%arg0, %arg1) <{callee = @eliminate_parameter}> : (index, index) -> ()
    %0 = "func.call"(%arg0, %arg1, %arg2) <{callee = @mutl_parameter}> : (index, index, index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, i1) -> i1, sym_name = "dead_value_loop_ivs_has_result"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: i1):
    %0 = "scf.for"(%arg0, %arg1, %arg2, %arg3) ({
    ^bb0(%arg4: index, %arg5: i1):
      "cf.assert"(%arg3) <{msg = "loop not dead"}> : (i1) -> ()
      "scf.yield"(%arg3) : (i1) -> ()
    }) : (index, index, index, i1) -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, memref<?xf32>, f32, index) -> (), sym_name = "dead_value_loop_ivs_no_result"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<?xf32>, %arg4: f32, %arg5: index):
    "scf.for"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg6: index):
      "memref.store"(%arg4, %arg3, %arg5) : (f32, memref<?xf32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, i1) -> (), sym_name = "op_block_have_dead_arg"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: i1):
    "scf.execute_region"() ({
      "cf.cond_br"(%arg2, %arg0, %arg1)[^bb1, ^bb1] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, index, index) -> ()
    ^bb1(%0: index):  // 2 preds: ^bb0, ^bb0
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i64, i64) -> i64, sym_name = "remove_dead_branch_op", sym_visibility = "private"}> ({
  ^bb0(%arg0: i1, %arg1: i64, %arg2: i64):
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%arg1) : (i64) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%arg2) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (79)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "affine_loop_no_use_iv_has_side_effect_op"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xindex>
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg0: index):
      "memref.store"(%0, %1, %0) : (index, memref<10xindex>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "scf_while_dead_iter_args"}> ({
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1:2 = "scf.while"(%0) ({
    ^bb0(%arg2: i32):
      "vector.print"(%arg2) <{punctuation = #vector.punctuation<newline>}> : (i32) -> ()
      %3 = "arith.cmpi"(%arg2, %0) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%3, %arg2, %arg2) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg0: i32, %arg1: i32):
      %2 = "scf.execute_region"() ({
        "scf.yield"(%arg1) : (i32) -> ()
      }) : () -> i32
      "scf.yield"(%2) : (i32) -> ()
    }) : (i32) -> (i32, i32)
    "func.return"(%1#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

