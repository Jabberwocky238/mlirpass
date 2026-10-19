module {
  func.func @simple(%arg0: i32) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %true = arith.constant true
    return %c1_i32 : i32
  }
  func.func @simple_both_same(%arg0: i1) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    return %c1_i32 : i32
  }
  func.func @overdefined_unknown_condition(%arg0: i1, %arg1: i32) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %0 = scf.if %arg0 -> (i32) {
      scf.yield %c1_i32 : i32
    } else {
      scf.yield %arg1 : i32
    }
    return %0 : i32
  }
  func.func @overdefined_different_constants(%arg0: i1) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %c2_i32 = arith.constant 2 : i32
    %0 = scf.if %arg0 -> (i32) {
      scf.yield %c1_i32 : i32
    } else {
      scf.yield %c2_i32 : i32
    }
    return %0 : i32
  }
  func.func @simple_loop(%arg0: index, %arg1: index, %arg2: index) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
  func.func @loop_overdefined(%arg0: index, %arg1: index, %arg2: index) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %0 = scf.for %arg3 = %arg0 to %arg1 step %arg2 iter_args(%arg4 = %c1_i32) -> (i32) {
      %1 = arith.addi %arg4, %arg4 : i32
      scf.yield %1 : i32
    }
    return %0 : i32
  }
  func.func @loop_inner_control_flow(%arg0: index, %arg1: index, %arg2: index) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    return %c1_i32 : i32
  }
  func.func @loop_region_branch_terminator_op(%arg0: i32) {
    %c2_i32 = arith.constant 2 : i32
    return
  }
  func.func @affine_loop_one_iter() -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    return %c1_i32 : i32
  }
  func.func @affine_loop_zero_iter() -> i32 {
    %c1_i32 = arith.constant 1 : i32
    return %c1_i32 : i32
  }
  func.func @affine_loop_unknown_trip_count(%arg0: index) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
  func.func @while_loop_different_arg_count() -> index {
    %true = arith.constant true
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %0 = scf.while (%arg0 = %c0, %arg1 = %c1) : (index, index) -> index {
      scf.condition(%true) %c1 : index
    } do {
    ^bb0(%arg0: index):
      scf.yield %c0, %c1 : index, index
    }
    return %0 : index
  }
  func.func @while_loop_false_condition(%arg0: index) -> index {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    return %c0 : index
  }
}

