"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "br_folding"}> ({
    %29 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%29) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "br_passthrough"}> ({
  ^bb0(%arg46: i32, %arg47: i32):
    "foo.switch"()[^bb1, ^bb2, ^bb3] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%arg46, %arg47)[^bb3] : (i32, i32) -> ()
  ^bb2(%26: i32):  // pred: ^bb0
    "cf.br"(%26, %arg47)[^bb3] : (i32, i32) -> ()
  ^bb3(%27: i32, %28: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    "func.return"(%27, %28) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32) -> (), sym_name = "cond_br_folding"}> ({
  ^bb0(%arg44: i1, %arg45: i32):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32) -> (), sym_name = "cond_br_same_successor"}> ({
  ^bb0(%arg42: i1, %arg43: i32):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32, i32, tensor<2xi32>, tensor<2xi32>) -> (i32, tensor<2xi32>), sym_name = "cond_br_same_successor_insert_select"}> ({
  ^bb0(%arg37: i1, %arg38: i32, %arg39: i32, %arg40: tensor<2xi32>, %arg41: tensor<2xi32>):
    %24 = "arith.select"(%arg37, %arg38, %arg39) : (i1, i32, i32) -> i32
    %25 = "arith.select"(%arg37, %arg40, %arg41) : (i1, tensor<2xi32>, tensor<2xi32>) -> tensor<2xi32>
    "func.return"(%24, %25) : (i32, tensor<2xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "cond_br_and_br_folding"}> ({
  ^bb0(%arg36: i32):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i1) -> i32, sym_name = "cond_br_passthrough_weights"}> ({
  ^bb0(%arg33: i32, %arg34: i32, %arg35: i1):
    "cf.cond_br"(%arg35)[^bb1, ^bb2] <{branch_weights = array<i32: 30, 70>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%arg33) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%arg34) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i32, i1) -> (i32, i32), sym_name = "cond_br_passthrough"}> ({
  ^bb0(%arg29: i32, %arg30: i32, %arg31: i32, %arg32: i1):
    %22 = "arith.select"(%arg32, %arg29, %arg31) : (i1, i32, i32) -> i32
    %23 = "arith.select"(%arg32, %arg30, %arg31) : (i1, i32, i32) -> i32
    "func.return"(%22, %23) : (i32, i32) -> ()
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
    "cf.br"(%arg27)[^bb2] : (f32) -> ()
  ^bb2(%21: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb2Terminator"(%21) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, f32, f32) -> (), sym_name = "switch_case_matching_default"}> ({
  ^bb0(%arg23: i32, %arg24: f32, %arg25: f32):
    "foo.pred"()[^bb1, ^bb2, ^bb3] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.switch"(%arg23, %arg24, %arg25)[^bb2, ^bb3] <{case_operand_segments = array<i32: 1>, case_values = dense<10> : vector<1xi32>, operandSegmentSizes = array<i32: 1, 1, 1>}> : (i32, f32, f32) -> ()
  ^bb2(%19: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb2Terminator"(%19) : (f32) -> ()
  ^bb3(%20: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb3Terminator"(%20) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "switch_on_const_no_match"}> ({
  ^bb0(%arg20: f32, %arg21: f32, %arg22: f32):
    "foo.pred"()[^bb1, ^bb2, ^bb3, ^bb4] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%arg20)[^bb2] : (f32) -> ()
  ^bb2(%16: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb2Terminator"(%16) : (f32) -> ()
  ^bb3(%17: f32):  // pred: ^bb0
    "foo.bb3Terminator"(%17) : (f32) -> ()
  ^bb4(%18: f32):  // pred: ^bb0
    "foo.bb4Terminator"(%18) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (f32, f32, f32) -> (), sym_name = "switch_on_const_with_match"}> ({
  ^bb0(%arg17: f32, %arg18: f32, %arg19: f32):
    "foo.pred"()[^bb1, ^bb2, ^bb3, ^bb4] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%arg19)[^bb4] : (f32) -> ()
  ^bb2(%13: f32):  // pred: ^bb0
    "foo.bb2Terminator"(%13) : (f32) -> ()
  ^bb3(%14: f32):  // pred: ^bb0
    "foo.bb3Terminator"(%14) : (f32) -> ()
  ^bb4(%15: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb4Terminator"(%15) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, f32, f32, f32, f32) -> (), sym_name = "switch_passthrough"}> ({
  ^bb0(%arg12: i32, %arg13: f32, %arg14: f32, %arg15: f32, %arg16: f32):
    "foo.pred"()[^bb1, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.switch"(%arg12, %arg13, %arg14, %arg15)[^bb5, ^bb6, ^bb4] <{case_operand_segments = array<i32: 1, 1>, case_values = dense<[43, 44]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 1, 2>}> : (i32, f32, f32, f32) -> ()
  ^bb2(%8: f32):  // pred: ^bb0
    "cf.br"(%8)[^bb5] : (f32) -> ()
  ^bb3(%9: f32):  // pred: ^bb0
    "cf.br"(%9)[^bb6] : (f32) -> ()
  ^bb4(%10: f32):  // 2 preds: ^bb0, ^bb1
    "foo.bb4Terminator"(%10) : (f32) -> ()
  ^bb5(%11: f32):  // 3 preds: ^bb0, ^bb1, ^bb2
    "foo.bb5Terminator"(%11) : (f32) -> ()
  ^bb6(%12: f32):  // 3 preds: ^bb0, ^bb1, ^bb3
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
    "cf.br"(%arg11)[^bb5] : (f32) -> ()
  ^bb4(%6: f32):  // pred: ^bb0
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
    "cf.br"(%arg6)[^bb4] : (f32) -> ()
  ^bb4(%3: f32):  // 2 preds: ^bb0, ^bb3
    "foo.bb4Terminator"(%3) : (f32) -> ()
  ^bb5(%4: f32):  // pred: ^bb0
    "foo.bb5Terminator"(%4) : (f32) -> ()
  ^bb6(%5: f32):  // pred: ^bb0
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
    "cf.switch"(%arg1, %arg2, %arg4)[^bb4, ^bb6] <{case_operand_segments = array<i32: 1>, case_values = dense<43> : vector<1xi32>, operandSegmentSizes = array<i32: 1, 1, 1>}> : (i32, f32, f32) -> ()
  ^bb4(%0: f32):  // 2 preds: ^bb0, ^bb3
    "foo.bb4Terminator"(%0) : (f32) -> ()
  ^bb5(%1: f32):  // pred: ^bb0
    "foo.bb5Terminator"(%1) : (f32) -> ()
  ^bb6(%2: f32):  // 2 preds: ^bb0, ^bb3
    "foo.bb6Terminator"(%2) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "cond_br_from_cond_br_with_same_condition"}> ({
  ^bb0(%arg0: i1):
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "foo.terminator"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "assert_true"}> ({
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
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "arith.constant"() <{value = false}> : () -> i1
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "test.consumer1"(%0) : (i1) -> ()
    "cf.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    "test.consumer2"(%1) : (i1) -> ()
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "cycle_2_blocks"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "no_cycle_2_blocks"}> ({
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "cycle_4_blocks"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "no_cycle_4_blocks"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "delayed_3_cycle"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "cycle_1_block"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "unsimplified_cycle_1"}> ({
  ^bb0(%arg3: i1):
    "cf.cond_br"(%arg3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb2, ^bb3
    "cf.br"()[^bb3] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "unsimplified_cycle_2"}> ({
  ^bb0(%arg2: i1):
    "cf.cond_br"(%arg2)[^bb1, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb3
    "cf.br"()[^bb2] {A} : () -> ()
  ^bb2:  // 2 preds: ^bb1, ^bb2
    "cf.br"()[^bb2] {E} : () -> ()
  ^bb3:  // pred: ^bb0
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "drop_unreachable_branch_1"}> ({
  ^bb0(%arg1: i1):
    "test.foo"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "drop_unreachable_branch_2"}> ({
  ^bb0(%arg0: i1):
    "ub.unreachable"() : () -> ()
  }) : () -> ()
}) : () -> ()

