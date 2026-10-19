module {
  func.func @simple_std_for_loop(%arg0: index, %arg1: index, %arg2: index) {
    cf.br ^bb1(%arg0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %arg1 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %c1 = arith.constant 1 : index
    %2 = arith.addi %0, %arg2 : index
    cf.br ^bb1(%2 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @unsigned_loop(%arg0: index, %arg1: index, %arg2: index) {
    cf.br ^bb1(%arg0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi ult, %0, %arg1 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %c1 = arith.constant 1 : index
    %2 = arith.addi %0, %arg2 : index
    cf.br ^bb1(%2 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @simple_std_2_for_loops(%arg0: index, %arg1: index, %arg2: index) {
    cf.br ^bb1(%arg0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb5
    %1 = arith.cmpi slt, %0, %arg1 : index
    cf.cond_br %1, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    %c1 = arith.constant 1 : index
    cf.br ^bb3(%arg0 : index)
  ^bb3(%2: index):  // 2 preds: ^bb2, ^bb4
    %3 = arith.cmpi slt, %2, %arg1 : index
    cf.cond_br %3, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %c1_0 = arith.constant 1 : index
    %4 = arith.addi %2, %arg2 : index
    cf.br ^bb3(%4 : index)
  ^bb5:  // pred: ^bb3
    %5 = arith.addi %0, %arg2 : index
    cf.br ^bb1(%5 : index)
  ^bb6:  // pred: ^bb1
    return
  }
  func.func @simple_std_if(%arg0: i1) {
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %c1 = arith.constant 1 : index
    cf.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    return
  }
  func.func @simple_std_if_else(%arg0: i1) {
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %c1 = arith.constant 1 : index
    cf.br ^bb3
  ^bb2:  // pred: ^bb0
    %c1_0 = arith.constant 1 : index
    cf.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    return
  }
  func.func @simple_std_2_ifs(%arg0: i1) {
    cf.cond_br %arg0, ^bb1, ^bb5
  ^bb1:  // pred: ^bb0
    %c1 = arith.constant 1 : index
    cf.cond_br %arg0, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %c1_0 = arith.constant 1 : index
    cf.br ^bb4
  ^bb3:  // pred: ^bb1
    %c1_1 = arith.constant 1 : index
    cf.br ^bb4
  ^bb4:  // 2 preds: ^bb2, ^bb3
    cf.br ^bb5
  ^bb5:  // 2 preds: ^bb0, ^bb4
    return
  }
  func.func @simple_std_for_loop_with_2_ifs(%arg0: index, %arg1: index, %arg2: index, %arg3: i1) {
    cf.br ^bb1(%arg0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb7
    %1 = arith.cmpi slt, %0, %arg1 : index
    cf.cond_br %1, ^bb2, ^bb8
  ^bb2:  // pred: ^bb1
    %c1 = arith.constant 1 : index
    cf.cond_br %arg3, ^bb3, ^bb7
  ^bb3:  // pred: ^bb2
    %c1_0 = arith.constant 1 : index
    cf.cond_br %arg3, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %c1_1 = arith.constant 1 : index
    cf.br ^bb6
  ^bb5:  // pred: ^bb3
    %c1_2 = arith.constant 1 : index
    cf.br ^bb6
  ^bb6:  // 2 preds: ^bb4, ^bb5
    cf.br ^bb7
  ^bb7:  // 2 preds: ^bb2, ^bb6
    %2 = arith.addi %0, %arg2 : index
    cf.br ^bb1(%2 : index)
  ^bb8:  // pred: ^bb1
    return
  }
  func.func @simple_if_yield(%arg0: i1) -> (i1, i1) {
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %false = arith.constant false
    %true = arith.constant true
    cf.br ^bb3(%false, %true : i1, i1)
  ^bb2:  // pred: ^bb0
    %false_0 = arith.constant false
    %true_1 = arith.constant true
    cf.br ^bb3(%true_1, %false_0 : i1, i1)
  ^bb3(%0: i1, %1: i1):  // 2 preds: ^bb1, ^bb2
    cf.br ^bb4
  ^bb4:  // pred: ^bb3
    return %0, %1 : i1, i1
  }
  func.func @nested_if_yield(%arg0: i1) -> index {
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %true = arith.constant true
    cf.br ^bb3(%true : i1)
  ^bb2:  // pred: ^bb0
    %false = arith.constant false
    cf.br ^bb3(%false : i1)
  ^bb3(%0: i1):  // 2 preds: ^bb1, ^bb2
    cf.br ^bb4
  ^bb4:  // pred: ^bb3
    cf.cond_br %0, ^bb5, ^bb10
  ^bb5:  // pred: ^bb4
    cf.cond_br %arg0, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %c40 = arith.constant 40 : index
    cf.br ^bb8(%c40 : index)
  ^bb7:  // pred: ^bb5
    %c41 = arith.constant 41 : index
    cf.br ^bb8(%c41 : index)
  ^bb8(%1: index):  // 2 preds: ^bb6, ^bb7
    cf.br ^bb9
  ^bb9:  // pred: ^bb8
    cf.br ^bb11(%1 : index)
  ^bb10:  // pred: ^bb4
    %c42 = arith.constant 42 : index
    cf.br ^bb11(%c42 : index)
  ^bb11(%2: index):  // 2 preds: ^bb9, ^bb10
    cf.br ^bb12
  ^bb12:  // pred: ^bb11
    return %2 : index
  }
  func.func @parallel_loop(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index) {
    %c1 = arith.constant 1 : index
    cf.br ^bb1(%arg0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb5
    %1 = arith.cmpi slt, %0, %arg2 : index
    cf.cond_br %1, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    cf.br ^bb3(%arg1 : index)
  ^bb3(%2: index):  // 2 preds: ^bb2, ^bb4
    %3 = arith.cmpi slt, %2, %arg3 : index
    cf.cond_br %3, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %c1_0 = arith.constant 1 : index
    %4 = arith.addi %2, %c1 : index
    cf.br ^bb3(%4 : index)
  ^bb5:  // pred: ^bb3
    %5 = arith.addi %0, %arg4 : index
    cf.br ^bb1(%5 : index)
  ^bb6:  // pred: ^bb1
    return
  }
  func.func @for_yield(%arg0: index, %arg1: index, %arg2: index) -> (f32, f32) {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    cf.br ^bb1(%arg0, %cst, %cst_0 : index, f32, f32)
  ^bb1(%0: index, %1: f32, %2: f32):  // 2 preds: ^bb0, ^bb2
    %3 = arith.cmpi slt, %0, %arg1 : index
    cf.cond_br %3, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %4 = arith.addf %1, %2 : f32
    %5 = arith.addi %0, %arg2 : index
    cf.br ^bb1(%5, %4, %4 : index, f32, f32)
  ^bb3:  // pred: ^bb1
    return %1, %2 : f32, f32
  }
  func.func @nested_for_yield(%arg0: index, %arg1: index, %arg2: index) -> f32 {
    %cst = arith.constant 1.000000e+00 : f32
    cf.br ^bb1(%arg0, %cst : index, f32)
  ^bb1(%0: index, %1: f32):  // 2 preds: ^bb0, ^bb5
    %2 = arith.cmpi slt, %0, %arg1 : index
    cf.cond_br %2, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    cf.br ^bb3(%arg0, %1 : index, f32)
  ^bb3(%3: index, %4: f32):  // 2 preds: ^bb2, ^bb4
    %5 = arith.cmpi slt, %3, %arg1 : index
    cf.cond_br %5, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %6 = arith.addf %4, %4 : f32
    %7 = arith.addi %3, %arg2 : index
    cf.br ^bb3(%7, %6 : index, f32)
  ^bb5:  // pred: ^bb3
    %8 = arith.addi %0, %arg2 : index
    cf.br ^bb1(%8, %4 : index, f32)
  ^bb6:  // pred: ^bb1
    return %1 : f32
  }
  func.func private @generate() -> i64
  func.func @simple_parallel_reduce_loop(%arg0: index, %arg1: index, %arg2: index, %arg3: f32) -> f32 {
    cf.br ^bb1(%arg0, %arg3 : index, f32)
  ^bb1(%0: index, %1: f32):  // 2 preds: ^bb0, ^bb2
    %2 = arith.cmpi slt, %0, %arg1 : index
    cf.cond_br %2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %cst = arith.constant 4.200000e+01 : f32
    %3 = arith.mulf %1, %cst : f32
    %4 = arith.addi %0, %arg2 : index
    cf.br ^bb1(%4, %3 : index, f32)
  ^bb3:  // pred: ^bb1
    return %1 : f32
  }
  func.func @parallel_reduce_loop(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: f32) -> (f32, i64) {
    %c1 = arith.constant 1 : index
    %c42_i64 = arith.constant 42 : i64
    cf.br ^bb1(%arg0, %arg5, %c42_i64 : index, f32, i64)
  ^bb1(%0: index, %1: f32, %2: i64):  // 2 preds: ^bb0, ^bb5
    %3 = arith.cmpi slt, %0, %arg2 : index
    cf.cond_br %3, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    cf.br ^bb3(%arg1, %1, %2 : index, f32, i64)
  ^bb3(%4: index, %5: f32, %6: i64):  // 2 preds: ^bb2, ^bb4
    %7 = arith.cmpi slt, %4, %arg3 : index
    cf.cond_br %7, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %cst = arith.constant 4.200000e+01 : f32
    %8 = call @generate() : () -> i64
    %9 = arith.addf %5, %cst : f32
    %10 = arith.ori %6, %8 : i64
    %11 = arith.addi %4, %c1 : index
    cf.br ^bb3(%11, %9, %10 : index, f32, i64)
  ^bb5:  // pred: ^bb3
    %12 = arith.addi %0, %arg4 : index
    cf.br ^bb1(%12, %5, %6 : index, f32, i64)
  ^bb6:  // pred: ^bb1
    return %1, %2 : f32, i64
  }
  func.func @unknown_op_inside_loop(%arg0: index, %arg1: index, %arg2: index) {
    cf.br ^bb1(%arg0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %arg1 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    "unknown.op"() : () -> ()
    %2 = arith.addi %0, %arg2 : index
    cf.br ^bb1(%2 : index)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @minimal_while() {
    %0 = "test.make_condition"() : () -> i1
    cf.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    cf.cond_br %0, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    "test.some_payload"() : () -> ()
    cf.br ^bb1
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @do_while(%arg0: f32) {
    cf.br ^bb1(%arg0 : f32)
  ^bb1(%0: f32):  // 2 preds: ^bb0, ^bb1
    %1 = "test.make_condition"() : () -> i1
    cf.cond_br %1, ^bb1(%0 : f32), ^bb2
  ^bb2:  // pred: ^bb1
    return
  }
  func.func @while_values(%arg0: i32, %arg1: f32) {
    %0 = "test.make_condition"() : () -> i1
    %c0_i32 = arith.constant 0 : i32
    %cst = arith.constant 0.000000e+00 : f32
    cf.br ^bb1(%arg0, %arg1 : i32, f32)
  ^bb1(%1: i32, %2: f32):  // 2 preds: ^bb0, ^bb2
    %3 = arith.extui %arg0 : i32 to i64
    %4 = arith.extf %2 : f32 to f64
    cf.cond_br %0, ^bb2(%3, %4 : i64, f64), ^bb3
  ^bb2(%5: i64, %6: f64):  // pred: ^bb1
    cf.br ^bb1(%c0_i32, %cst : i32, f32)
  ^bb3:  // pred: ^bb1
    return
  }
  func.func @nested_while_ops(%arg0: f32) -> i64 {
    cf.br ^bb1(%arg0 : f32)
  ^bb1(%0: f32):  // 2 preds: ^bb0, ^bb8
    %1 = "test.outer_before_pre"() : () -> i1
    cf.br ^bb2(%0 : f32)
  ^bb2(%2: f32):  // 2 preds: ^bb1, ^bb3
    %3:2 = "test.inner_before"(%2) : (f32) -> (i1, i64)
    cf.cond_br %3#0, ^bb3(%3#1 : i64), ^bb4
  ^bb3(%4: i64):  // pred: ^bb2
    %5 = "test.inner_after"(%4) : (i64) -> f32
    cf.br ^bb2(%5 : f32)
  ^bb4:  // pred: ^bb2
    "test.outer_before_post"() : () -> ()
    cf.cond_br %1, ^bb5(%3#1 : i64), ^bb9
  ^bb5(%6: i64):  // pred: ^bb4
    "test.outer_after_pre"(%6) : (i64) -> ()
    cf.br ^bb6(%6 : i64)
  ^bb6(%7: i64):  // 2 preds: ^bb5, ^bb7
    %8:2 = "test.inner2_before"(%7) : (i64) -> (i1, f32)
    cf.cond_br %8#0, ^bb7(%8#1 : f32), ^bb8
  ^bb7(%9: f32):  // pred: ^bb6
    %10 = "test.inner2_after"(%9) : (f32) -> i64
    cf.br ^bb6(%10 : i64)
  ^bb8:  // pred: ^bb6
    "test.outer_after_post"() : () -> ()
    cf.br ^bb1(%8#1 : f32)
  ^bb9:  // pred: ^bb4
    return %3#1 : i64
  }
  func.func @ifs_in_parallel(%arg0: index, %arg1: index, %arg2: index, %arg3: i1, %arg4: i1) {
    cf.br ^bb1(%arg0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb8
    %1 = arith.cmpi slt, %0, %arg1 : index
    cf.cond_br %1, ^bb2, ^bb9
  ^bb2:  // pred: ^bb1
    cf.cond_br %arg3, ^bb3, ^bb8
  ^bb3:  // pred: ^bb2
    cf.cond_br %arg4, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %2 = "test.if2"() : () -> index
    cf.br ^bb6(%2 : index)
  ^bb5:  // pred: ^bb3
    %3 = "test.else2"() : () -> index
    cf.br ^bb6(%3 : index)
  ^bb6(%4: index):  // 2 preds: ^bb4, ^bb5
    cf.br ^bb7
  ^bb7:  // pred: ^bb6
    cf.br ^bb8
  ^bb8:  // 2 preds: ^bb2, ^bb7
    %5 = arith.addi %0, %arg2 : index
    cf.br ^bb1(%5 : index)
  ^bb9:  // pred: ^bb1
    return
  }
  func.func @func_execute_region_elim_multi_yield() {
    "test.foo"() : () -> ()
    cf.br ^bb1
  ^bb1:  // pred: ^bb0
    %0 = "test.cmp"() : () -> i1
    cf.cond_br %0, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %1 = "test.val1"() : () -> i64
    cf.br ^bb4(%1 : i64)
  ^bb3:  // pred: ^bb1
    %2 = "test.val2"() : () -> i64
    cf.br ^bb4(%2 : i64)
  ^bb4(%3: i64):  // 2 preds: ^bb2, ^bb3
    "test.bar"(%3) : (i64) -> ()
    return
  }
  func.func @index_switch(%arg0: index, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = arith.index_cast %arg0 : index to i32
    cf.switch %0 : i32, [
      default: ^bb3,
      0: ^bb1,
      1: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    cf.br ^bb4(%arg1 : i32)
  ^bb2:  // pred: ^bb0
    cf.br ^bb4(%arg2 : i32)
  ^bb3:  // pred: ^bb0
    cf.br ^bb4(%arg3 : i32)
  ^bb4(%1: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    return %1 : i32
  }
  func.func @forall(%arg0: index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb2
    %1 = arith.cmpi slt, %0, %arg0 : index
    cf.cond_br %1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    "test.foo"(%0) : (index) -> ()
    %2 = arith.addi %0, %c1 : index
    cf.br ^bb1(%2 : index)
  ^bb3:  // pred: ^bb1
    return
  }
}

// -----
#loop_unroll = #llvm.loop_unroll<full = true>
#loop_unroll1 = #llvm.loop_unroll<disable = true>
#loop_annotation = #llvm.loop_annotation<unroll = #loop_unroll>
#loop_annotation1 = #llvm.loop_annotation<unroll = #loop_unroll1>
module {
  func.func @simple_std_for_loops_annotation(%arg0: index, %arg1: index, %arg2: index) {
    cf.br ^bb1(%arg0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb5
    %1 = arith.cmpi slt, %0, %arg1 : index
    cf.cond_br %1, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    cf.br ^bb3(%c0 : index)
  ^bb3(%2: index):  // 2 preds: ^bb2, ^bb4
    %3 = arith.cmpi slt, %2, %c4 : index
    cf.cond_br %3, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %c1_0 = arith.constant 1 : index
    %4 = arith.addi %2, %c1 : index
    cf.br ^bb3(%4 : index) {llvm.loop_annotation = #loop_annotation}
  ^bb5:  // pred: ^bb3
    %5 = arith.addi %0, %arg2 : index
    cf.br ^bb1(%5 : index) {llvm.loop_annotation = #loop_annotation1}
  ^bb6:  // pred: ^bb1
    return
  }
}

// -----
#loop_unroll = #llvm.loop_unroll<disable = true>
#loop_annotation = #llvm.loop_annotation<unroll = #loop_unroll>
module {
  func.func @simple_while_loops_annotation(%arg0: i1) {
    cf.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    cf.cond_br %arg0, ^bb1, ^bb2 {llvm.loop_annotation = #loop_annotation}
  ^bb2:  // pred: ^bb1
    return
  }
}

// -----
#loop_unroll = #llvm.loop_unroll<disable = true>
#loop_annotation = #llvm.loop_annotation<unroll = #loop_unroll>
module {
  func.func @do_while_loops_annotation() {
    %c0_i32 = arith.constant 0 : i32
    cf.br ^bb1(%c0_i32 : i32)
  ^bb1(%0: i32):  // 2 preds: ^bb0, ^bb2
    %1 = "test.make_condition"() : () -> i1
    cf.cond_br %1, ^bb2(%c0_i32 : i32), ^bb3
  ^bb2(%2: i32):  // pred: ^bb1
    cf.br ^bb1(%c0_i32 : i32) {llvm.loop_annotation = #loop_annotation}
  ^bb3:  // pred: ^bb1
    return
  }
}

