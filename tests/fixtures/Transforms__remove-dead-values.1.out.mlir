module {
  memref.global "private" constant @__constant_4xi32 : memref<4xi32> = dense<[1, 2, 3, 4]> {alignment = 16 : i64}
  func.func @main(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}

// -----
module @named_module_acceptable {
  func.func @main(%arg0: tensor<10xf32>) -> tensor<10xf32> {
    return %arg0 : tensor<10xf32>
  }
}

// -----
module {
  func.func @acceptable_ir_has_cleanable_loop_of_conditional_and_branch_op(%arg0: i1) {
    cf.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    cf.br ^bb2
  ^bb2:  // pred: ^bb1
    cf.cond_br %arg0, ^bb1, ^bb3
  ^bb3:  // pred: ^bb2
    return
  }
}

// -----
module {
  func.func @cleanable_loop_iter_args_value(%arg0: index) -> index {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c10 = arith.constant 10 : index
    %0 = ub.poison : index
    %1 = scf.for %arg1 = %c0 to %c10 step %c1 iter_args(%arg2 = %arg0) -> (index) {
      %2 = arith.addi %arg2, %arg1 : index
      %3 = ub.poison : index
      scf.yield %2 : index
    }
    return %1 : index
  }
}

// -----
module {
  func.func @dead_linalg_generic() {
    return
  }
}

// -----
module {
  func.func private @clean_func_op_remove_argument_and_return_value() {
    return
  }
  func.func @main(%arg0: i32) {
    call @clean_func_op_remove_argument_and_return_value() : () -> ()
    return
  }
}

// -----
module {
  func.func private @clean_func_op_remove_side_effecting_op() {
    return
  }
}

// -----
module {
  func.func private @clean_func_op_remove_arguments() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
  func.func @main(%arg0: memref<i32>, %arg1: i32, %arg2: i32) -> (i32, memref<i32>) {
    %0 = test.call_on_device @clean_func_op_remove_arguments(), %arg2 : (i32) -> i32
    return %0, %arg0 : i32, memref<i32>
  }
}

// -----
module {
  func.func private @clean_func_op_remove_return_values(%arg0: memref<i32>) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    memref.store %c0_i32, %arg0[] : memref<i32>
    return %c0_i32 : i32
  }
  func.func @main(%arg0: memref<i32>) -> i32 {
    %0 = call @clean_func_op_remove_return_values(%arg0) : (memref<i32>) -> i32
    %1 = call @clean_func_op_remove_return_values(%arg0) : (memref<i32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func private @clean_func_op_dont_remove_return_values() -> (i32, i32) {
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32, %c0_i32 : i32, i32
  }
  func.func @main() -> (i32, i32) {
    %0:2 = call @clean_func_op_dont_remove_return_values() : () -> (i32, i32)
    %1:2 = call @clean_func_op_dont_remove_return_values() : () -> (i32, i32)
    return %0#0, %1#1 : i32, i32
  }
}

// -----
module {
  func.func @clean_region_branch_op_dont_remove_first_2_results_but_remove_first_operand(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = ub.poison : i32
    %1:2 = scf.while (%arg3 = %arg2) : (i32) -> (i32, i32) {
      %2 = arith.addi %arg3, %arg3 : i32
      %3 = ub.poison : i32
      scf.condition(%arg0) %2, %arg3 : i32, i32
    } do {
    ^bb0(%arg3: i32, %arg4: i32):
      %2 = arith.addi %arg4, %arg4 : i32
      %3 = ub.poison : i32
      scf.yield %2 : i32
    }
    return %1#0 : i32
  }
}

// -----
module {
  func.func @clean_region_branch_op_remove_last_2_results_last_2_arguments_and_last_operand(%arg0: i1) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = ub.poison : i32
    %1:2 = scf.while (%arg1 = %c0_i32, %arg2 = %c1_i32) : (i32, i32) -> (i32, i32) {
      func.call @identity() : () -> ()
      scf.condition(%arg0) %arg1, %arg2 : i32, i32
    } do {
    ^bb0(%arg1: i32, %arg2: i32):
      scf.yield %arg2, %arg1 : i32, i32
    }
    return %1#1 : i32
  }
  func.func private @identity() {
    return
  }
}

// -----
module {
  func.func @clean_region_branch_op_remove_result(%arg0: index, %arg1: memref<i32>) {
    scf.index_switch %arg0 
    case 1 {
      %c10_i32 = arith.constant 10 : i32
      memref.store %c10_i32, %arg1[] : memref<i32>
      %0 = ub.poison : i32
      scf.yield
    }
    default {
      %0 = ub.poison : i32
    }
    return
  }
}

// -----
module {
  func.func private @clean_simple_ops(%arg0: i32, %arg1: memref<i32>) -> i32 {
    %0 = arith.addi %arg0, %arg0 : i32
    %c2_i32 = arith.constant 2 : i32
    %1 = arith.muli %0, %c2_i32 : i32
    %c3_i32 = arith.constant 3 : i32
    %2 = arith.addi %arg0, %c3_i32 : i32
    memref.store %2, %arg1[] : memref<i32>
    return %1 : i32
  }
  func.func @main(%arg0: i32, %arg1: memref<i32>, %arg2: i32) -> i32 {
    %0 = call @clean_simple_ops(%arg0, %arg1) : (i32, memref<i32>) -> i32
    return %0 : i32
  }
}

// -----
module {
  func.func private @clean_region_branch_op_erase_it() {
    return
  }
  func.func @main(%arg0: i32, %arg1: i1) {
    call @clean_region_branch_op_erase_it() : () -> ()
    return
  }
}

// -----
module {
  func.func @clean_region_branch_op_with_empty_region(%arg0: i1, %arg1: memref<f32>) {
    %cst = arith.constant 1.000000e+00 : f32
    scf.if %arg0 {
      memref.store %cst, %arg1[] : memref<f32>
    }
    return
  }
}

// -----
#map = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module {
  func.func @kernel(%arg0: memref<18xf32>) {
    %c1 = arith.constant 1 : index
    %c18 = arith.constant 18 : index
    gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %c18, %arg8 = %c18, %arg9 = %c18) threads(%arg4, %arg5, %arg6) in (%arg10 = %c1, %arg11 = %c1, %arg12 = %c1) {
      %c1_0 = arith.constant 1 : index
      %c0 = arith.constant 0 : index
      %cst = arith.constant 25.4669495 : f32
      %0 = affine.apply #map(%arg1)[%c1_0, %c0]
      memref.store %cst, %arg0[%0] : memref<18xf32>
      gpu.terminator
    } {SCFToGPU_visited}
    return
  }
}

// -----
module {
  module @llvm_unreachable {
    func.func private @fn_with_llvm_unreachable() {
      llvm.unreachable
    }
    func.func private @main() {
      call @fn_with_llvm_unreachable() : () -> ()
      llvm.return
    }
  }
  func.func private @no_block_func_declaration()
}

// -----
module {
  llvm.func @no_block_external_func() attributes {sym_visibility = "private"}
}

// -----
module {
  gpu.module @test_module_3 {
    gpu.func @gpu_all_reduce_region() {
      %c1_i32 = arith.constant 1 : i32
      %0 = gpu.all_reduce  %c1_i32 uniform {
      ^bb0(%arg0: i32, %arg1: i32):
        %1 = arith.xori %arg0, %arg1 : i32
        gpu.yield %1 : i32
      } : (i32) -> i32
      gpu.return
    }
  }
}

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (0)>
module {
  func.func @linalg_red_add(%arg0: tensor<?xf32>, %arg1: tensor<1xf32>) -> tensor<1xf32> {
    %0 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["reduction"]} ins(%arg0 : tensor<?xf32>) outs(%arg1 : tensor<1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %out : f32
      linalg.yield %1 : f32
    } -> tensor<1xf32>
    return %0 : tensor<1xf32>
  }
}

// -----
module {
  func.func @test_zero_operands(%arg0: memref<10xindex>, %arg1: memref<10xf32>) {
    %c0 = arith.constant 0 : index
    memref.store %c0, %arg0[%c0] : memref<10xindex>
    return
  }
}

// -----
module {
  func.func @test_atomic_yield(%arg0: memref<10xf32>, %arg1: index) {
    %0 = memref.generic_atomic_rmw %arg0[%arg1] : memref<10xf32> {
    ^bb0(%arg2: f32):
      %cst = arith.constant 1.000000e+00 : f32
      memref.atomic_yield %cst : f32
    }
    return
  }
}

// -----
module @return_void_with_unused_argument {
  func.func private @fn_return_void_with_unused_argument(%arg0: i32) {
    %0 = arith.addi %arg0, %arg0 : i32
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<1xi32>
    memref.store %0, %alloc[%c0] : memref<1xi32>
    return
  }
  func.func @main(%arg0: i32) -> memref<4xi32> {
    %alloc = memref.alloc() : memref<4xi32>
    call @fn_return_void_with_unused_argument(%arg0) : (i32) -> ()
    return %alloc : memref<4xi32>
  }
}

// -----
module {
  module @dynamically_unreachable {
    func.func @dynamically_unreachable() {
      %false = arith.constant false
      cf.cond_br %false, ^bb1, ^bb2
    ^bb1:  // 2 preds: ^bb0, ^bb1
      cf.br ^bb1
    ^bb2:  // pred: ^bb0
      return
    }
  }
  module @last_block_not_exit {
    func.func private @terminated_with_condbr(%arg0: i1, %arg1: i1) {
      cf.cond_br %arg0, ^bb1, ^bb2
    ^bb1:  // 3 preds: ^bb0, ^bb2, ^bb2
      return
    ^bb2:  // pred: ^bb0
      cf.cond_br %arg1, ^bb1, ^bb1
    }
    func.func public @call_private_but_not_use() {
      %false = arith.constant false
      %true = arith.constant true
      call @terminated_with_condbr(%false, %true) : (i1, i1) -> ()
      return
    }
  }
}

// -----
module {
  func.func private @single_parameter() {
    return
  }
  func.func private @mutl_parameter(%arg0: index) -> index {
    return %arg0 : index
  }
  func.func private @eliminate_parameter() {
    call @single_parameter() : () -> ()
    return
  }
  func.func @callee(%arg0: index, %arg1: index, %arg2: index) -> index {
    call @eliminate_parameter() : () -> ()
    %0 = call @mutl_parameter(%arg1) : (index) -> index
    return %0 : index
  }
}

// -----
module {
  func.func @dead_value_loop_ivs_has_result(%arg0: index, %arg1: index, %arg2: index, %arg3: i1) -> i1 {
    %0 = scf.for %arg4 = %arg0 to %arg1 step %arg2 iter_args(%arg5 = %arg3) -> (i1) {
      cf.assert %arg3, "loop not dead"
      scf.yield %arg3 : i1
    }
    return %arg3 : i1
  }
}

// -----
module {
  func.func @dead_value_loop_ivs_no_result(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<?xf32>, %arg4: f32, %arg5: index) {
    scf.for %arg6 = %arg0 to %arg1 step %arg2 {
      memref.store %arg4, %arg3[%arg5] : memref<?xf32>
    }
    return
  }
}

// -----
module {
  func.func @op_block_have_dead_arg(%arg0: index, %arg1: index, %arg2: i1) {
    return
  }
}

// -----
module {
  func.func private @remove_dead_branch_op() {
    ub.unreachable
  ^bb1:  // no predecessors
    return
  ^bb2:  // no predecessors
    return
  }
}

// -----
module {
  func.func @affine_loop_no_use_iv_has_side_effect_op() {
    %c1 = arith.constant 1 : index
    %alloc = memref.alloc() : memref<10xindex>
    affine.for %arg0 = 0 to 79 {
      memref.store %c1, %alloc[%c1] : memref<10xindex>
    }
    return
  }
}

// -----
module {
  func.func @scf_while_dead_iter_args() -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %0 = scf.while (%arg0 = %c5_i32) : (i32) -> i32 {
      vector.print %arg0 : i32
      %1 = arith.cmpi slt, %arg0, %c5_i32 : i32
      %2 = ub.poison : i32
      scf.condition(%1) %arg0 : i32
    } do {
    ^bb0(%arg0: i32):
      %1 = ub.poison : i32
      scf.yield %1 : i32
    }
    return %0 : i32
  }
}

