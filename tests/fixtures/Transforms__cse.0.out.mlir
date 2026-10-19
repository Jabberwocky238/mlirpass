module {
  func.func @simple_constant() -> (i32, i32) {
    %c1_i32 = arith.constant 1 : i32
    return %c1_i32, %c1_i32 : i32, i32
  }
}

// -----
#map = affine_map<(d0) -> (d0 mod 2)>
module {
  func.func @basic() -> (index, index) {
    %c0 = arith.constant 0 : index
    %0 = affine.apply #map(%c0)
    return %0, %0 : index, index
  }
}

// -----
module {
  func.func @many(%arg0: f32, %arg1: f32) -> f32 {
    %0 = arith.addf %arg0, %arg1 : f32
    %1 = arith.addf %0, %0 : f32
    %2 = arith.addf %1, %1 : f32
    %3 = arith.addf %2, %2 : f32
    return %3 : f32
  }
}

// -----
module {
  func.func @different_ops() -> (i32, i32) {
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    return %c0_i32, %c1_i32 : i32, i32
  }
}

// -----
module {
  func.func @different_results(%arg0: tensor<*xf32>) -> (tensor<?x?xf32>, tensor<4x?xf32>) {
    %cast = tensor.cast %arg0 : tensor<*xf32> to tensor<?x?xf32>
    %cast_0 = tensor.cast %arg0 : tensor<*xf32> to tensor<4x?xf32>
    return %cast, %cast_0 : tensor<?x?xf32>, tensor<4x?xf32>
  }
}

// -----
module {
  func.func @different_attributes(%arg0: index, %arg1: index) -> (i1, i1, i1) {
    %0 = arith.cmpi slt, %arg0, %arg1 : index
    %1 = arith.cmpi ne, %arg0, %arg1 : index
    return %0, %1, %1 : i1, i1, i1
  }
}

// -----
module {
  func.func @side_effect() -> (memref<2x1xf32>, memref<2x1xf32>) {
    %alloc = memref.alloc() : memref<2x1xf32>
    %alloc_0 = memref.alloc() : memref<2x1xf32>
    return %alloc, %alloc_0 : memref<2x1xf32>, memref<2x1xf32>
  }
}

// -----
module {
  func.func @down_propagate_for() {
    %c1_i32 = arith.constant 1 : i32
    affine.for %arg0 = 0 to 4 {
      "foo"(%c1_i32, %c1_i32) : (i32, i32) -> ()
    }
    return
  }
}

// -----
module {
  func.func @down_propagate() -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %true = arith.constant true
    cf.cond_br %true, ^bb1, ^bb2(%c1_i32 : i32)
  ^bb1:  // pred: ^bb0
    cf.br ^bb2(%c1_i32 : i32)
  ^bb2(%0: i32):  // 2 preds: ^bb0, ^bb1
    return %0 : i32
  }
}

// -----
module {
  func.func @up_propagate_for() -> i32 {
    affine.for %arg0 = 0 to 4 {
      %c1_i32_0 = arith.constant 1 : i32
      "foo"(%c1_i32_0) : (i32) -> ()
    }
    %c1_i32 = arith.constant 1 : i32
    return %c1_i32 : i32
  }
}

// -----
module {
  func.func @up_propagate() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %true = arith.constant true
    cf.cond_br %true, ^bb1, ^bb2(%c0_i32 : i32)
  ^bb1:  // pred: ^bb0
    %c1_i32 = arith.constant 1 : i32
    cf.br ^bb2(%c1_i32 : i32)
  ^bb2(%0: i32):  // 2 preds: ^bb0, ^bb1
    %c1_i32_0 = arith.constant 1 : i32
    %1 = arith.addi %0, %c1_i32_0 : i32
    return %1 : i32
  }
}

// -----
module {
  func.func @up_propagate_region() -> i32 {
    %0 = "foo.region"() ({
      %c0_i32 = arith.constant 0 : i32
      %true = arith.constant true
      cf.cond_br %true, ^bb1, ^bb2(%c0_i32 : i32)
    ^bb1:  // pred: ^bb0
      %c1_i32 = arith.constant 1 : i32
      cf.br ^bb2(%c1_i32 : i32)
    ^bb2(%1: i32):  // 2 preds: ^bb0, ^bb1
      %c1_i32_0 = arith.constant 1 : i32
      %2 = arith.addi %1, %c1_i32_0 : i32
      "foo.yield"(%2) : (i32) -> ()
    }) : () -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func @nested_isolated() -> i32 {
    %c1_i32 = arith.constant 1 : i32
    builtin.module {
      func.func @nested_func() {
        %c1_i32_0 = arith.constant 1 : i32
        "foo.yield"(%c1_i32_0) : (i32) -> ()
      }
    }
    "foo.region"() ({
      %c1_i32_0 = arith.constant 1 : i32
      "foo.yield"(%c1_i32_0) : (i32) -> ()
    }) : () -> ()
    return %c1_i32 : i32
  }
}

// -----
module {
  func.func @use_before_def() {
    test.graph_region {
      %0 = arith.addi %c1_i32, %c1_i32_0 : i32
      %c1_i32 = arith.constant 1 : i32
      %c1_i32_0 = arith.constant 1 : i32
      "foo.yield"(%0) : (i32) -> ()
    }
    return
  }
}

// -----
module {
  func.func @remove_direct_duplicated_read_op() -> i32 {
    %0 = "test.op_with_memread"() : () -> i32
    %1 = arith.addi %0, %0 : i32
    return %1 : i32
  }
}

// -----
module {
  func.func @remove_multiple_duplicated_read_op() -> i64 {
    %0 = "test.op_with_memread"() : () -> i64
    %1 = arith.addi %0, %0 : i64
    %2 = arith.addi %1, %0 : i64
    %3 = arith.addi %2, %0 : i64
    return %3 : i64
  }
}

// -----
module {
  func.func @dont_remove_duplicated_read_op_with_sideeffecting() -> i32 {
    %0 = "test.op_with_memread"() : () -> i32
    "test.op_with_memwrite"() : () -> ()
    %1 = "test.op_with_memread"() : () -> i32
    %2 = arith.addi %0, %1 : i32
    return %2 : i32
  }
}

// -----
module {
  func.func @cse_single_block_ops(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>) {
    %0 = test.cse_of_single_block_op inputs(%arg0, %arg1) {
    ^bb0(%arg2: f32):
      test.region_yield %arg2 : f32
    } : tensor<?x?xf32>, tensor<?x?xf32> -> tensor<?x?xf32>
    return %0, %0 : tensor<?x?xf32>, tensor<?x?xf32>
  }
}

// -----
module {
  func.func @no_cse_varied_bbargs(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>) {
    %0 = test.cse_of_single_block_op inputs(%arg0, %arg1) {
    ^bb0(%arg2: f32, %arg3: f32):
      test.region_yield %arg2 : f32
    } : tensor<?x?xf32>, tensor<?x?xf32> -> tensor<?x?xf32>
    %1 = test.cse_of_single_block_op inputs(%arg0, %arg1) {
    ^bb0(%arg2: f32):
      test.region_yield %arg2 : f32
    } : tensor<?x?xf32>, tensor<?x?xf32> -> tensor<?x?xf32>
    return %0, %1 : tensor<?x?xf32>, tensor<?x?xf32>
  }
}

// -----
module {
  func.func @no_cse_region_difference_simple(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>) -> (tensor<?x?xf32>, tensor<?x?xf32>) {
    %0 = test.cse_of_single_block_op inputs(%arg0, %arg1) {
    ^bb0(%arg2: f32, %arg3: f32):
      test.region_yield %arg2 : f32
    } : tensor<?x?xf32>, tensor<?x?xf32> -> tensor<?x?xf32>
    %1 = test.cse_of_single_block_op inputs(%arg0, %arg1) {
    ^bb0(%arg2: f32, %arg3: f32):
      test.region_yield %arg3 : f32
    } : tensor<?x?xf32>, tensor<?x?xf32> -> tensor<?x?xf32>
    return %0, %1 : tensor<?x?xf32>, tensor<?x?xf32>
  }
}

// -----
module {
  func.func @cse_single_block_ops_identical_bodies(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: f32, %arg3: i1) -> (tensor<?x?xf32>, tensor<?x?xf32>) {
    %0 = test.cse_of_single_block_op inputs(%arg0, %arg1) {
    ^bb0(%arg4: f32, %arg5: f32):
      %1 = arith.divf %arg4, %arg5 : f32
      %2 = arith.remf %arg4, %arg2 : f32
      %3 = arith.select %arg3, %1, %2 : f32
      test.region_yield %3 : f32
    } : tensor<?x?xf32>, tensor<?x?xf32> -> tensor<?x?xf32>
    return %0, %0 : tensor<?x?xf32>, tensor<?x?xf32>
  }
}

// -----
module {
  func.func @no_cse_single_block_ops_different_bodies(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>, %arg2: f32, %arg3: i1) -> (tensor<?x?xf32>, tensor<?x?xf32>) {
    %0 = test.cse_of_single_block_op inputs(%arg0, %arg1) {
    ^bb0(%arg4: f32, %arg5: f32):
      %2 = arith.divf %arg4, %arg5 : f32
      %3 = arith.remf %arg4, %arg2 : f32
      %4 = arith.select %arg3, %2, %3 : f32
      test.region_yield %4 : f32
    } : tensor<?x?xf32>, tensor<?x?xf32> -> tensor<?x?xf32>
    %1 = test.cse_of_single_block_op inputs(%arg0, %arg1) {
    ^bb0(%arg4: f32, %arg5: f32):
      %2 = arith.divf %arg4, %arg5 : f32
      %3 = arith.remf %arg4, %arg2 : f32
      %4 = arith.select %arg3, %3, %2 : f32
      test.region_yield %4 : f32
    } : tensor<?x?xf32>, tensor<?x?xf32> -> tensor<?x?xf32>
    return %0, %1 : tensor<?x?xf32>, tensor<?x?xf32>
  }
}

// -----
module {
  func.func @failing_issue_59135(%arg0: tensor<2x2xi1>, %arg1: f32, %arg2: tensor<2xi1>) -> (tensor<2xi1>, tensor<2xi1>) {
    %false = arith.constant false
    %true = arith.constant true
    %0 = test.cse_of_single_block_op inputs(%arg2) {
    ^bb0(%arg3: i1):
      test.region_yield %true : i1
    } : tensor<2xi1> -> tensor<2xi1>
    return %0, %0 : tensor<2xi1>, tensor<2xi1>
  }
}

// -----
module {
  func.func @cse_multiple_regions(%arg0: i1, %arg1: tensor<5xf32>) -> (tensor<5xf32>, tensor<5xf32>) {
    %0 = scf.if %arg0 -> (tensor<5xf32>) {
      %1 = tensor.empty() : tensor<5xf32>
      scf.yield %1 : tensor<5xf32>
    } else {
      scf.yield %arg1 : tensor<5xf32>
    }
    return %0, %0 : tensor<5xf32>, tensor<5xf32>
  }
}

// -----
module {
  func.func @cse_recursive_effects_success() -> (i32, i32, i32) {
    %0 = "test.op_with_memread"() : () -> i32
    %true = arith.constant true
    %1 = scf.if %true -> (i32) {
      %c42_i32 = arith.constant 42 : i32
      scf.yield %c42_i32 : i32
    } else {
      %c24_i32 = arith.constant 24 : i32
      scf.yield %c24_i32 : i32
    }
    return %0, %0, %1 : i32, i32, i32
  }
}

// -----
module {
  func.func @cse_recursive_effects_failure() -> (i32, i32, i32) {
    %0 = "test.op_with_memread"() : () -> i32
    %true = arith.constant true
    %1 = scf.if %true -> (i32) {
      "test.op_with_memwrite"() : () -> ()
      %c42_i32 = arith.constant 42 : i32
      scf.yield %c42_i32 : i32
    } else {
      %c24_i32 = arith.constant 24 : i32
      scf.yield %c24_i32 : i32
    }
    %2 = "test.op_with_memread"() : () -> i32
    return %0, %2, %1 : i32, i32, i32
  }
}

