"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "br_folding"}> ({
    %39 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "cf.br"(%39)[^bb1] : (i32) -> ()
  ^bb1(%40: i32):  // pred: ^bb0
    "func.return"(%40) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "br_passthrough"}> ({
  ^bb0(%arg46: i32, %arg47: i32):
    "foo.switch"()[^bb1, ^bb2, ^bb3] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%arg46)[^bb2] : (i32) -> ()
  ^bb2(%36: i32):  // 2 preds: ^bb0, ^bb1
    "cf.br"(%36, %arg47)[^bb3] : (i32, i32) -> ()
  ^bb3(%37: i32, %38: i32):  // 2 preds: ^bb0, ^bb2
    "func.return"(%37, %38) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32) -> (), sym_name = "cond_br_folding"}> ({
  ^bb0(%arg44: i1, %arg45: i32):
    %33 = "arith.constant"() <{value = false}> : () -> i1
    %34 = "arith.constant"() <{value = true}> : () -> i1
    "cf.cond_br"(%arg44, %arg45)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    "cf.cond_br"(%34, %arg45)[^bb3, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb2(%35: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    "cf.cond_br"(%33, %35)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32) -> (), sym_name = "cond_br_same_successor"}> ({
  ^bb0(%arg42: i1, %arg43: i32):
    "cf.cond_br"(%arg42, %arg43, %arg43)[^bb1, ^bb1] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i32, i32) -> ()
  ^bb1(%32: i32):  // 2 preds: ^bb0, ^bb0
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32, i32, tensor<2xi32>, tensor<2xi32>) -> (i32, tensor<2xi32>), sym_name = "cond_br_same_successor_insert_select"}> ({
  ^bb0(%arg37: i1, %arg38: i32, %arg39: i32, %arg40: tensor<2xi32>, %arg41: tensor<2xi32>):
    "cf.cond_br"(%arg37, %arg38, %arg40, %arg39, %arg41)[^bb1, ^bb1] <{operandSegmentSizes = array<i32: 1, 2, 2>}> : (i1, i32, tensor<2xi32>, i32, tensor<2xi32>) -> ()
  ^bb1(%30: i32, %31: tensor<2xi32>):  // 2 preds: ^bb0, ^bb0
    "func.return"(%30, %31) : (i32, tensor<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "cond_br_and_br_folding"}> ({
  ^bb0(%arg36: i32):
    %27 = "arith.constant"() <{value = false}> : () -> i1
    %28 = "arith.constant"() <{value = true}> : () -> i1
    "cf.cond_br"(%28, %arg36)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb1(%29: i32):  // 2 preds: ^bb0, ^bb1
    "cf.cond_br"(%27, %29)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i1) -> i32, sym_name = "cond_br_passthrough_weights"}> ({
  ^bb0(%arg33: i32, %arg34: i32, %arg35: i1):
    "cf.cond_br"(%arg35)[^bb1, ^bb2] <{branch_weights = array<i32: 30, 70>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    "cf.br"()[^bb4] : () -> ()
  ^bb3:  // pred: ^bb1
    "func.return"(%arg33) : (i32) -> ()
  ^bb4:  // pred: ^bb2
    "func.return"(%arg34) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i32, i1) -> (i32, i32), sym_name = "cond_br_passthrough"}> ({
  ^bb0(%arg29: i32, %arg30: i32, %arg31: i32, %arg32: i1):
    "cf.cond_br"(%arg32, %arg29, %arg31, %arg31)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 2>}> : (i1, i32, i32, i32) -> ()
  ^bb1(%24: i32):  // pred: ^bb0
    "cf.br"(%24, %arg30)[^bb2] : (i32, i32) -> ()
  ^bb2(%25: i32, %26: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%25, %26) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "cond_br_pass_through_fail"}> ({
  ^bb0(%arg28: i1):
    "cf.cond_br"(%arg28)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "foo.op"() : () -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, f32) -> (), sym_name = "switch_only_default"}> ({
  ^bb0(%arg26: i32, %arg27: f32):
    "foo.pred"()[^bb1, ^bb2] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.switch"(%arg26, %arg27)[^bb2] <{case_operand_segments = array<i32>, operandSegmentSizes = array<i32: 1, 1, 0>}> : (i32, f32) -> ()
  ^bb2(%23: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb2Terminator"(%23) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, f32, f32) -> (), sym_name = "switch_case_matching_default"}> ({
  ^bb0(%arg23: i32, %arg24: f32, %arg25: f32):
    "foo.pred"()[^bb1, ^bb2, ^bb3] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.switch"(%arg23, %arg24, %arg24, %arg25, %arg24)[^bb2, ^bb2, ^bb3, ^bb2] <{case_operand_segments = array<i32: 1, 1, 1>, case_values = dense<[42, 10, 17]> : vector<3xi32>, operandSegmentSizes = array<i32: 1, 1, 3>}> : (i32, f32, f32, f32, f32) -> ()
  ^bb2(%21: f32):  // 4 preds: ^bb0, ^bb1, ^bb1, ^bb1
    "foo.bb2Terminator"(%21) : (f32) -> ()
  ^bb3(%22: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb3Terminator"(%22) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "switch_on_const_no_match"}> ({
  ^bb0(%arg20: f32, %arg21: f32, %arg22: f32):
    "foo.pred"()[^bb1, ^bb2, ^bb3, ^bb4] : () -> ()
  ^bb1:  // pred: ^bb0
    %17 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "cf.switch"(%17, %arg20, %arg21, %arg22)[^bb2, ^bb3, ^bb4] <{case_operand_segments = array<i32: 1, 1>, case_values = dense<[-1, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 1, 2>}> : (i32, f32, f32, f32) -> ()
  ^bb2(%18: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb2Terminator"(%18) : (f32) -> ()
  ^bb3(%19: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb3Terminator"(%19) : (f32) -> ()
  ^bb4(%20: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb4Terminator"(%20) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "switch_on_const_with_match"}> ({
  ^bb0(%arg17: f32, %arg18: f32, %arg19: f32):
    "foo.pred"()[^bb1, ^bb2, ^bb3, ^bb4] : () -> ()
  ^bb1:  // pred: ^bb0
    %13 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.switch"(%13, %arg17, %arg18, %arg19)[^bb2, ^bb3, ^bb4] <{case_operand_segments = array<i32: 1, 1>, case_values = dense<[-1, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 1, 2>}> : (i32, f32, f32, f32) -> ()
  ^bb2(%14: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb2Terminator"(%14) : (f32) -> ()
  ^bb3(%15: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb3Terminator"(%15) : (f32) -> ()
  ^bb4(%16: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb4Terminator"(%16) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, f32, f32, f32, f32) -> (), sym_name = "switch_passthrough"}> ({
  ^bb0(%arg12: i32, %arg13: f32, %arg14: f32, %arg15: f32, %arg16: f32):
    "foo.pred"()[^bb1, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.switch"(%arg12, %arg13, %arg14, %arg15)[^bb2, ^bb3, ^bb4] <{case_operand_segments = array<i32: 1, 1>, case_values = dense<[43, 44]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 1, 2>}> : (i32, f32, f32, f32) -> ()
  ^bb2(%8: f32):  // 2 preds: ^bb0, ^bb1
    "cf.br"(%8)[^bb5] : (f32) -> ()
  ^bb3(%9: f32):  // 2 preds: ^bb0, ^bb1
    "cf.br"(%9)[^bb6] : (f32) -> ()
  ^bb4(%10: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb4Terminator"(%10) : (f32) -> ()
  ^bb5(%11: f32):  // 2 preds: ^bb0, ^bb2
    "foo.bb5Terminator"(%11) : (f32) -> ()
  ^bb6(%12: f32):  // 2 preds: ^bb0, ^bb3
    "foo.bb6Terminator"(%12) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, f32, f32) -> (), sym_name = "switch_from_switch_with_same_value_with_match"}> ({
  ^bb0(%arg9: i32, %arg10: f32, %arg11: f32):
    "foo.pred"()[^bb1, ^bb2, ^bb4, ^bb5] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.switch"(%arg9)[^bb2, ^bb3] <{case_operand_segments = array<i32: 0>, case_values = dense<42> : vector<1xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "foo.bb2Terminator"() : () -> ()
  ^bb3:  // pred: ^bb1
    "foo.op"() : () -> ()
    "cf.switch"(%arg9, %arg10, %arg11)[^bb4, ^bb5] <{case_operand_segments = array<i32: 1>, case_values = dense<42> : vector<1xi32>, operandSegmentSizes = array<i32: 1, 1, 1>}> : (i32, f32, f32) -> ()
  ^bb4(%6: f32):  // 2 preds: ^bb0, ^bb3
    "foo.bb4Terminator"(%6) : (f32) -> ()
  ^bb5(%7: f32):  // 2 preds: ^bb0, ^bb3
    "foo.bb5Terminator"(%7) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, f32, f32, f32) -> (), sym_name = "switch_from_switch_with_same_value_no_match"}> ({
  ^bb0(%arg5: i32, %arg6: f32, %arg7: f32, %arg8: f32):
    "foo.pred"()[^bb1, ^bb2, ^bb4, ^bb5, ^bb6] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.switch"(%arg5)[^bb2, ^bb3] <{case_operand_segments = array<i32: 0>, case_values = dense<42> : vector<1xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "foo.bb2Terminator"() : () -> ()
  ^bb3:  // pred: ^bb1
    "foo.op"() : () -> ()
    "cf.switch"(%arg5, %arg6, %arg7, %arg8)[^bb4, ^bb5, ^bb6] <{case_operand_segments = array<i32: 1, 1>, case_values = dense<[0, 43]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 1, 2>}> : (i32, f32, f32, f32) -> ()
  ^bb4(%3: f32):  // 2 preds: ^bb0, ^bb3
    "foo.bb4Terminator"(%3) : (f32) -> ()
  ^bb5(%4: f32):  // 2 preds: ^bb0, ^bb3
    "foo.bb5Terminator"(%4) : (f32) -> ()
  ^bb6(%5: f32):  // 2 preds: ^bb0, ^bb3
    "foo.bb6Terminator"(%5) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, f32, f32, f32) -> (), sym_name = "switch_from_switch_default_with_same_value"}> ({
  ^bb0(%arg1: i32, %arg2: f32, %arg3: f32, %arg4: f32):
    "foo.pred"()[^bb1, ^bb2, ^bb4, ^bb5, ^bb6] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.switch"(%arg1)[^bb3, ^bb2] <{case_operand_segments = array<i32: 0>, case_values = dense<42> : vector<1xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "foo.bb2Terminator"() : () -> ()
  ^bb3:  // pred: ^bb1
    "foo.op"() : () -> ()
    "cf.switch"(%arg1, %arg2, %arg3, %arg4)[^bb4, ^bb5, ^bb6] <{case_operand_segments = array<i32: 1, 1>, case_values = dense<[42, 43]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 1, 2>}> : (i32, f32, f32, f32) -> ()
  ^bb4(%0: f32):  // 2 preds: ^bb0, ^bb3
    "foo.bb4Terminator"(%0) : (f32) -> ()
  ^bb5(%1: f32):  // 2 preds: ^bb0, ^bb3
    "foo.bb5Terminator"(%1) : (f32) -> ()
  ^bb6(%2: f32):  // 2 preds: ^bb0, ^bb3
    "foo.bb6Terminator"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "cond_br_from_cond_br_with_same_condition"}> ({
  ^bb0(%arg0: i1):
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "cf.cond_br"(%arg0)[^bb3, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "foo.terminator"() : () -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "assert_true"}> ({
    %0 = "arith.constant"() <{value = true}> : () -> i1
    "cf.assert"(%0) <{msg = "Computer says no"}> : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "cf.assert"}> ({
  ^bb0(%arg0: i1):
    "cf.assert"(%arg0) <{msg = "Computer says no"}> : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "branchCondProp"}> ({
  ^bb0(%arg0: i1):
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "test.consumer1"(%arg0) : (i1) -> ()
    "cf.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    "test.consumer2"(%arg0) : (i1) -> ()
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "cycle_2_blocks"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "no_cycle_2_blocks"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // pred: ^bb2
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "cycle_4_blocks"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb4
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // pred: ^bb2
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "no_cycle_4_blocks"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // pred: ^bb2
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    "cf.br"()[^bb5] : () -> ()
  ^bb5:  // pred: ^bb4
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "delayed_3_cycle"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb2, ^bb5
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    "cf.br"()[^bb5] : () -> ()
  ^bb5:  // pred: ^bb4
    "cf.br"()[^bb3] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "cycle_1_block"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb1, ^bb2
    "cf.br"()[^bb2] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "unsimplified_cycle_1"}> ({
  ^bb0(%arg3: i1):
    "cf.cond_br"(%arg3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb2, ^bb4
    "cf.br"()[^bb4] : () -> ()
  ^bb4:  // pred: ^bb3
    "cf.br"()[^bb3] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "unsimplified_cycle_2"}> ({
  ^bb0(%arg2: i1):
    "cf.cond_br"(%arg2)[^bb1, ^bb7] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb7
    "cf.br"()[^bb2] {F} : () -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"()[^bb3] {A} : () -> ()
  ^bb3:  // 2 preds: ^bb2, ^bb6
    "cf.br"()[^bb4] {B} : () -> ()
  ^bb4:  // pred: ^bb3
    "cf.br"()[^bb5] {C} : () -> ()
  ^bb5:  // pred: ^bb4
    "cf.br"()[^bb6] {D} : () -> ()
  ^bb6:  // pred: ^bb5
    "cf.br"()[^bb3] {E} : () -> ()
  ^bb7:  // pred: ^bb0
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "drop_unreachable_branch_1"}> ({
  ^bb0(%arg1: i1):
    "cf.cond_br"(%arg1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "test.foo"() : () -> ()
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "ub.unreachable"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "drop_unreachable_branch_2"}> ({
  ^bb0(%arg0: i1):
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "ub.unreachable"() : () -> ()
  ^bb2:  // pred: ^bb0
    "ub.unreachable"() : () -> ()
  }) : () -> ()
}) : () -> ()

