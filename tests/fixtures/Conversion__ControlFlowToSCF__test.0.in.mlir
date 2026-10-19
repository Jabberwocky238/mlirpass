"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "simple_if"}> ({
    %0 = "test.test1"() : () -> i1
    "cf.cond_br"(%0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "test.test2"() : () -> ()
    "cf.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    "test.test3"() : () -> ()
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "test.test4"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "if_with_block_args"}> ({
    %0 = "test.test1"() : () -> i1
    "cf.cond_br"(%0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %1 = "test.test2"() : () -> index
    "cf.br"(%1)[^bb3] : (index) -> ()
  ^bb2:  // pred: ^bb0
    %2 = "test.test3"() : () -> index
    "cf.br"(%2)[^bb3] : (index) -> ()
  ^bb3(%3: index):  // 2 preds: ^bb1, ^bb2
    "test.test4"() : () -> ()
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "empty_else"}> ({
    %0 = "test.test1"() : () -> i1
    "cf.cond_br"(%0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "test.test2"() : () -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "test.test4"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "while_loop"}> ({
    "test.test1"() : () -> ()
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %0 = "test.test2"() : () -> i1
    "cf.cond_br"(%0)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "test.test3"() : () -> ()
    "cf.br"()[^bb1] : () -> ()
  ^bb3:  // pred: ^bb1
    "test.test4"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i64, sym_name = "while_loop_with_block_args"}> ({
    %0 = "test.test1"() : () -> index
    "cf.br"(%0)[^bb1] : (index) -> ()
  ^bb1(%1: index):  // 2 preds: ^bb0, ^bb2
    %2:2 = "test.test2"() : () -> (i1, i64)
    "cf.cond_br"(%2#0, %2#1, %2#1)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i64, i64) -> ()
  ^bb2(%3: i64):  // pred: ^bb1
    %4 = "test.test3"(%3) : (i64) -> index
    "cf.br"(%4)[^bb1] : (index) -> ()
  ^bb3(%5: i64):  // pred: ^bb1
    "test.test4"() : () -> ()
    "func.return"(%5) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "multi_exit_loop"}> ({
    "test.test1"() : () -> ()
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %0 = "test.test2"() : () -> i1
    "cf.cond_br"(%0)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %1 = "test.test3"() : () -> i1
    "cf.cond_br"(%1)[^bb3, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "test.test4"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> (), sym_name = "bar", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32, f32, f32) -> (), sym_name = "switch_with_fallthrough"}> ({
  ^bb0(%arg0: i32, %arg1: f32, %arg2: f32):
    "cf.switch"(%arg0, %arg1, %arg2)[^bb1, ^bb2, ^bb3] <{case_operand_segments = array<i32: 1, 0>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 1, 1>}> : (i32, f32, f32) -> ()
  ^bb1(%0: f32):  // pred: ^bb0
    %1 = "func.call"(%0) <{callee = @foo}> : (f32) -> f32
    "cf.br"(%1)[^bb2] : (f32) -> ()
  ^bb2(%2: f32):  // 2 preds: ^bb0, ^bb1
    "func.call"(%2) <{callee = @bar}> : (f32) -> ()
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb0, ^bb2
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (i1, f32), sym_name = "bar", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "already_structured_loop"}> ({
  ^bb0(%arg0: f32):
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %0:2 = "func.call"(%arg0) <{callee = @bar}> : (f32) -> (i1, f32)
    "cf.cond_br"(%0#0)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "func.return"(%0#1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (i1, f32), sym_name = "bar", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "exit_loop_iter_use"}> ({
  ^bb0(%arg0: f32):
    "cf.br"(%arg0)[^bb1] : (f32) -> ()
  ^bb1(%0: f32):  // 2 preds: ^bb0, ^bb1
    %1:2 = "func.call"(%0) <{callee = @bar}> : (f32) -> (i1, f32)
    "cf.cond_br"(%1#0, %1#1)[^bb2, ^bb1] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, f32) -> ()
  ^bb2:  // pred: ^bb1
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "bar", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "infinite_loop"}> ({
  ^bb0(%arg0: f32):
    "cf.br"(%arg0)[^bb1] : (f32) -> ()
  ^bb1(%0: f32):  // 2 preds: ^bb0, ^bb1
    %1 = "func.call"(%0) <{callee = @bar}> : (f32) -> f32
    "cf.br"(%1)[^bb1] : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "multi_return"}> ({
    %0 = "test.test1"() : () -> i1
    "cf.cond_br"(%0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %1 = "test.test2"() : () -> i32
    "func.return"(%1) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %2 = "test.test4"() : () -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "bar", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, i1) -> f32, sym_name = "conditional_infinite_loop"}> ({
  ^bb0(%arg0: f32, %arg1: i1):
    "cf.cond_br"(%arg1, %arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, f32) -> ()
  ^bb1(%0: f32):  // 2 preds: ^bb0, ^bb1
    %1 = "func.call"(%0) <{callee = @bar}> : (f32) -> f32
    "cf.br"(%1)[^bb1] : (f32) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%arg0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "bar", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1, i1) -> (), sym_name = "mixing_return_like"}> ({
  ^bb0(%arg0: i1, %arg1: i1, %arg2: i1):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.cond_br"(%arg0)[^bb1, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "cf.cond_br"(%arg1, %0, %1)[^bb2, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i32, i32) -> ()
  ^bb2(%2: i32):  // 2 preds: ^bb1, ^bb1
    "func.call"(%2) <{callee = @bar}> : (i32) -> ()
    "test.returnLike"() : () -> ()
  ^bb3:  // pred: ^bb0
    "cf.cond_br"(%arg2, %1, %0)[^bb4, ^bb4] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i32, i32) -> ()
  ^bb4(%3: i32):  // 2 preds: ^bb3, ^bb3
    "func.call"(%3) <{callee = @bar}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "some_successors_with_different_return"}> ({
  ^bb0(%arg0: i32):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 6 : i32}> : () -> i32
    "cf.switch"(%arg0, %0, %1)[^bb1, ^bb2, ^bb2] <{case_operand_segments = array<i32: 1, 1>, case_values = dense<[0, 1]> : vector<2xi32>, operandSegmentSizes = array<i32: 1, 0, 2>}> : (i32, i32, i32) -> ()
  ^bb1:  // pred: ^bb0
    "test.returnLike"() : () -> ()
  ^bb2(%2: i32):  // 3 preds: ^bb0, ^bb0, ^bb2
    "cf.br"(%2)[^bb2] : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "select_like"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.cond_br"(%arg0, %0, %1)[^bb1, ^bb1] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i32, i32) -> ()
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb0
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1, i1) -> (), sym_name = "return_like_dominated_by_condition"}> ({
  ^bb0(%arg0: i1, %arg1: i1, %arg2: i1):
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "cf.cond_br"(%arg1)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // 2 preds: ^bb2, ^bb4
    "test.unreachable"() : () -> ()
  ^bb4:  // pred: ^bb2
    "cf.cond_br"(%arg2)[^bb3, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb5:  // pred: ^bb4
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> i32, sym_name = "dominator_issue"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    "test.unreachable"() : () -> ()
  ^bb2:  // pred: ^bb0
    %0 = "test.def"() : () -> i32
    "cf.cond_br"(%arg1)[^bb1, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "bar", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> i32, sym_name = "dominator_issue_loop"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    "cf.cond_br"(%arg0)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %1 = "test.def"() : () -> i32
    "cf.cond_br"(%arg1)[^bb1, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"(%0) : (i32) -> ()
  ^bb4:  // pred: ^bb2
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i1, sym_name = "comp1", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i1, sym_name = "comp2", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "multi_entry_loop"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 6 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %2 = "func.call"(%0) <{callee = @comp1}> : (i32) -> i1
    "cf.cond_br"(%2, %0)[^bb3, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %3 = "func.call"(%1) <{callee = @comp2}> : (i32) -> i1
    "cf.cond_br"(%3, %1)[^bb3, ^bb1] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    "func.call"(%4) <{callee = @foo}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "nested_region"}> ({
    "scf.execute_region"() ({
      %0 = "test.test1"() : () -> i1
      "cf.cond_br"(%0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "test.test2"() : () -> ()
      "cf.br"()[^bb3] : () -> ()
    ^bb2:  // pred: ^bb0
      "test.test3"() : () -> ()
      "cf.br"()[^bb3] : () -> ()
    ^bb3:  // 2 preds: ^bb1, ^bb2
      "test.test4"() : () -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "nested_region_inside_loop_use"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %0 = "test.test1"() : () -> i32
    "scf.execute_region"() ({
      "test.foo"(%0) : (i32) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "nested_region_outside_loop_use"}> ({
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %0 = "test.test1"() : () -> i32
    %1 = "test.test2"() : () -> i1
    "cf.cond_br"(%1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "scf.execute_region"() ({
      "test.foo"(%0) : (i32) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

