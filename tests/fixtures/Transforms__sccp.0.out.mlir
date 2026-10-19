module {
  func.func @no_control_flow(%arg0: i32) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %true = arith.constant true
    return %c1_i32 : i32
  }
  func.func @simple_control_flow(%arg0: i32) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %true = arith.constant true
    cf.cond_br %true, ^bb1, ^bb2(%arg0 : i32)
  ^bb1:  // pred: ^bb0
    cf.br ^bb2(%c1_i32 : i32)
  ^bb2(%0: i32):  // 2 preds: ^bb0, ^bb1
    return %c1_i32 : i32
  }
  func.func @simple_control_flow_overdefined(%arg0: i32, %arg1: i1) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    cf.cond_br %arg1, ^bb1, ^bb2(%arg0 : i32)
  ^bb1:  // pred: ^bb0
    cf.br ^bb2(%c1_i32 : i32)
  ^bb2(%0: i32):  // 2 preds: ^bb0, ^bb1
    return %0 : i32
  }
  func.func @simple_control_flow_constant_overdefined(%arg0: i32, %arg1: i1) -> i32 {
    %c2_i32 = arith.constant 2 : i32
    %c1_i32 = arith.constant 1 : i32
    cf.cond_br %arg1, ^bb1, ^bb2(%arg0 : i32)
  ^bb1:  // pred: ^bb0
    cf.br ^bb2(%c2_i32 : i32)
  ^bb2(%0: i32):  // 2 preds: ^bb0, ^bb1
    return %0 : i32
  }
  func.func @unknown_terminator(%arg0: i32, %arg1: i1) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    "foo.cond_br"()[^bb1, ^bb2] : () -> ()
  ^bb1:  // pred: ^bb0
    cf.br ^bb2(%c1_i32 : i32)
  ^bb2(%0: i32):  // 2 preds: ^bb0, ^bb1
    return %0 : i32
  }
  func.func private @ext_cond_fn() -> i1
  func.func @simple_loop(%arg0: i32, %arg1: i1) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    cf.cond_br %arg1, ^bb1(%c1_i32 : i32), ^bb2(%c1_i32 : i32)
  ^bb1(%0: i32):  // 2 preds: ^bb0, ^bb1
    %1 = call @ext_cond_fn() : () -> i1
    cf.cond_br %1, ^bb1(%c1_i32 : i32), ^bb2(%c1_i32 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    return %c1_i32 : i32
  }
  func.func @simple_loop_inner_control_flow(%arg0: i32) -> i32 {
    %true = arith.constant true
    %c20_i32 = arith.constant 20 : i32
    %c1_i32 = arith.constant 1 : i32
    cf.br ^bb1(%c1_i32 : i32)
  ^bb1(%0: i32):  // 3 preds: ^bb0, ^bb3, ^bb4
    %1 = call @ext_cond_fn() : () -> i1
    cf.cond_br %1, ^bb5(%c1_i32 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    cf.cond_br %true, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    cf.br ^bb1(%c1_i32 : i32)
  ^bb4:  // pred: ^bb2
    %2 = arith.addi %c1_i32, %c1_i32 : i32
    cf.br ^bb1(%2 : i32)
  ^bb5(%3: i32):  // pred: ^bb1
    return %c1_i32 : i32
  }
  func.func private @ext_cond_and_value_fn() -> (i1, i32)
  func.func @simple_loop_overdefined(%arg0: i32, %arg1: i1) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    cf.cond_br %arg1, ^bb1(%c1_i32 : i32), ^bb2(%c1_i32 : i32)
  ^bb1(%0: i32):  // 2 preds: ^bb0, ^bb1
    %1:2 = call @ext_cond_and_value_fn() : () -> (i1, i32)
    cf.cond_br %1#0, ^bb1(%1#1 : i32), ^bb2(%1#1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    return %2 : i32
  }
  func.func @recheck_executable_edge(%arg0: i1) -> (i1, i1) {
    %false = arith.constant false
    %true = arith.constant true
    cf.cond_br %arg0, ^bb1, ^bb2(%false : i1)
  ^bb1:  // pred: ^bb0
    cf.br ^bb2(%true : i1)
  ^bb2(%0: i1):  // 2 preds: ^bb0, ^bb1
    cf.br ^bb3(%0 : i1)
  ^bb3(%1: i1):  // pred: ^bb2
    return %0, %1 : i1, i1
  }
  func.func @simple_produced_operand() -> (i32, i32) {
    %c1_i32 = arith.constant 1 : i32
    "test.internal_br"(%c1_i32)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 0, 1>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    cf.br ^bb2(%c1_i32, %c1_i32 : i32, i32)
  ^bb2(%0: i32, %1: i32):  // 2 preds: ^bb0, ^bb1
    return %0, %c1_i32 : i32, i32
  }
  func.func @inplace_fold() -> i32 {
    %c10_i32 = arith.constant 10 : i32
    %c5_i32 = arith.constant 5 : i32
    %0 = "test.op_in_place_fold_success"() : () -> i1
    cf.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return %c10_i32 : i32
  ^bb2:  // pred: ^bb0
    return %c5_i32 : i32
  }
  func.func @op_with_region() -> i32 {
    %c10_i32 = arith.constant 10 : i32
    %c5_i32 = arith.constant 5 : i32
    %0 = "test.op_with_region"() ({
    }) : () -> i1
    cf.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return %c10_i32 : i32
  ^bb2:  // pred: ^bb0
    return %c5_i32 : i32
  }
  func.func @no_crash_with_different_source_type() {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = vector.broadcast %0 : i64 to vector<128xi64>
    llvm.return
  }
}

