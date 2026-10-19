"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "simple_constant"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%0, %0) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 mod 2)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index), sym_name = "basic"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.apply"(%0) <{map = #map}> : (index) -> index
    "func.return"(%1, %1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> f32, sym_name = "many"}> ({
  ^bb0(%arg0: f32, %arg1: f32):
    %0 = "arith.addf"(%arg0, %arg1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %1 = "arith.addf"(%0, %0) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %2 = "arith.addf"(%1, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    %3 = "arith.addf"(%2, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "different_ops"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%0, %1) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>) -> (tensor<?x?xf32>, tensor<4x?xf32>), sym_name = "different_results"}> ({
  ^bb0(%arg0: tensor<*xf32>):
    %0 = "tensor.cast"(%arg0) : (tensor<*xf32>) -> tensor<?x?xf32>
    %1 = "tensor.cast"(%arg0) : (tensor<*xf32>) -> tensor<4x?xf32>
    "func.return"(%0, %1) : (tensor<?x?xf32>, tensor<4x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (i1, i1, i1), sym_name = "different_attributes"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.cmpi"(%arg0, %arg1) <{predicate = 2 : i64}> : (index, index) -> i1
    %1 = "arith.cmpi"(%arg0, %arg1) <{predicate = 1 : i64}> : (index, index) -> i1
    "func.return"(%0, %1, %1) : (i1, i1, i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (memref<2x1xf32>, memref<2x1xf32>), sym_name = "side_effect"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x1xf32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x1xf32>
    "func.return"(%0, %1) : (memref<2x1xf32>, memref<2x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (4)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "down_propagate_for"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg0: index):
      "foo"(%0, %0) : (i32, i32) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "down_propagate"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = true}> : () -> i1
    "cf.cond_br"(%1, %0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%0)[^bb2] : (i32) -> ()
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (4)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "up_propagate_for"}> ({
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg0: index):
      %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "foo"(%1) : (i32) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "up_propagate"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = true}> : () -> i1
    "cf.cond_br"(%1, %0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.br"(%2)[^bb2] : (i32) -> ()
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %5 = "arith.addi"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "up_propagate_region"}> ({
    %0 = "foo.region"() ({
      %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = true}> : () -> i1
      "cf.cond_br"(%2, %1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
    ^bb1:  // pred: ^bb0
      %3 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "cf.br"(%3)[^bb2] : (i32) -> ()
    ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
      %5 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "foo.yield"(%6) : (i32) -> ()
    }) : () -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "nested_isolated"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "builtin.module"() ({
      "func.func"() <{function_type = () -> (), sym_name = "nested_func"}> ({
        %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
        "foo.yield"(%2) : (i32) -> ()
      }) : () -> ()
    }) : () -> ()
    "foo.region"() ({
      %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "foo.yield"(%1) : (i32) -> ()
    }) : () -> ()
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "use_before_def"}> ({
    "test.graph_region"() ({
      %0 = "arith.addi"(%1, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      "foo.yield"(%0) : (i32) -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "remove_direct_duplicated_read_op"}> ({
    %0 = "test.op_with_memread"() : () -> i32
    %1 = "arith.addi"(%0, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i64, sym_name = "remove_multiple_duplicated_read_op"}> ({
    %0 = "test.op_with_memread"() : () -> i64
    %1 = "arith.addi"(%0, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %2 = "arith.addi"(%1, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    %3 = "arith.addi"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
    "func.return"(%3) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "dont_remove_duplicated_read_op_with_sideeffecting"}> ({
    %0 = "test.op_with_memread"() : () -> i32
    "test.op_with_memwrite"() : () -> ()
    %1 = "test.op_with_memread"() : () -> i32
    %2 = "arith.addi"(%0, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>), sym_name = "cse_single_block_ops"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>):
    %0 = "test.cse_of_single_block_op"(%arg0, %arg1) ({
    ^bb0(%arg2: f32):
      "test.region_yield"(%arg2) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0, %0) : (tensor<?x?xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>), sym_name = "no_cse_varied_bbargs"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>):
    %0 = "test.cse_of_single_block_op"(%arg0, %arg1) ({
    ^bb0(%arg3: f32, %arg4: f32):
      "test.region_yield"(%arg3) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %1 = "test.cse_of_single_block_op"(%arg0, %arg1) ({
    ^bb0(%arg2: f32):
      "test.region_yield"(%arg2) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0, %1) : (tensor<?x?xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>), sym_name = "no_cse_region_difference_simple"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>):
    %0 = "test.cse_of_single_block_op"(%arg0, %arg1) ({
    ^bb0(%arg4: f32, %arg5: f32):
      "test.region_yield"(%arg4) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %1 = "test.cse_of_single_block_op"(%arg0, %arg1) ({
    ^bb0(%arg2: f32, %arg3: f32):
      "test.region_yield"(%arg3) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0, %1) : (tensor<?x?xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>, f32, i1) -> (tensor<?x?xf32>, tensor<?x?xf32>), sym_name = "cse_single_block_ops_identical_bodies"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: f32, %arg3: i1):
    %0 = "test.cse_of_single_block_op"(%arg0, %arg1) ({
    ^bb0(%arg4: f32, %arg5: f32):
      %1 = "arith.divf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %2 = "arith.remf"(%arg4, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %3 = "arith.select"(%arg3, %1, %2) : (i1, f32, f32) -> f32
      "test.region_yield"(%3) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0, %0) : (tensor<?x?xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>, f32, i1) -> (tensor<?x?xf32>, tensor<?x?xf32>), sym_name = "no_cse_single_block_ops_different_bodies"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: f32, %arg3: i1):
    %0 = "test.cse_of_single_block_op"(%arg0, %arg1) ({
    ^bb0(%arg6: f32, %arg7: f32):
      %5 = "arith.divf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %6 = "arith.remf"(%arg6, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.select"(%arg3, %5, %6) : (i1, f32, f32) -> f32
      "test.region_yield"(%7) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    %1 = "test.cse_of_single_block_op"(%arg0, %arg1) ({
    ^bb0(%arg4: f32, %arg5: f32):
      %2 = "arith.divf"(%arg4, %arg5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %3 = "arith.remf"(%arg4, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %4 = "arith.select"(%arg3, %3, %2) : (i1, f32, f32) -> f32
      "test.region_yield"(%4) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0, %1) : (tensor<?x?xf32>, tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x2xi1>, f32, tensor<2xi1>) -> (tensor<2xi1>, tensor<2xi1>), sym_name = "failing_issue_59135"}> ({
  ^bb0(%arg0: tensor<2x2xi1>, %arg1: f32, %arg2: tensor<2xi1>):
    %0 = "arith.constant"() <{value = false}> : () -> i1
    %1 = "arith.constant"() <{value = true}> : () -> i1
    %2 = "test.cse_of_single_block_op"(%arg2) ({
    ^bb0(%arg3: i1):
      "test.region_yield"(%1) : (i1) -> ()
    }) : (tensor<2xi1>) -> tensor<2xi1>
    "func.return"(%2, %2) : (tensor<2xi1>, tensor<2xi1>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, tensor<5xf32>) -> (tensor<5xf32>, tensor<5xf32>), sym_name = "cse_multiple_regions"}> ({
  ^bb0(%arg0: i1, %arg1: tensor<5xf32>):
    %0 = "scf.if"(%arg0) ({
      %1 = "tensor.empty"() : () -> tensor<5xf32>
      "scf.yield"(%1) : (tensor<5xf32>) -> ()
    }, {
      "scf.yield"(%arg1) : (tensor<5xf32>) -> ()
    }) : (i1) -> tensor<5xf32>
    "func.return"(%0, %0) : (tensor<5xf32>, tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "cse_recursive_effects_success"}> ({
    %0 = "test.op_with_memread"() : () -> i32
    %1 = "arith.constant"() <{value = true}> : () -> i1
    %2 = "scf.if"(%1) ({
      %4 = "arith.constant"() <{value = 42 : i32}> : () -> i32
      "scf.yield"(%4) : (i32) -> ()
    }, {
      %3 = "arith.constant"() <{value = 24 : i32}> : () -> i32
      "scf.yield"(%3) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%0, %0, %2) : (i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32, i32), sym_name = "cse_recursive_effects_failure"}> ({
    %0 = "test.op_with_memread"() : () -> i32
    %1 = "arith.constant"() <{value = true}> : () -> i1
    %2 = "scf.if"(%1) ({
      "test.op_with_memwrite"() : () -> ()
      %5 = "arith.constant"() <{value = 42 : i32}> : () -> i32
      "scf.yield"(%5) : (i32) -> ()
    }, {
      %4 = "arith.constant"() <{value = 24 : i32}> : () -> i32
      "scf.yield"(%4) : (i32) -> ()
    }) : (i1) -> i32
    %3 = "test.op_with_memread"() : () -> i32
    "func.return"(%0, %3, %2) : (i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

