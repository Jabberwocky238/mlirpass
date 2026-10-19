"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "simple_if"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "test.test1"() : () -> i1
    "scf.if"(%1) ({
      "test.test2"() : () -> ()
      "scf.yield"() : () -> ()
    }, {
      "test.test3"() : () -> ()
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "test.test4"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "if_with_block_args"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "test.test1"() : () -> i1
    %2 = "scf.if"(%1) ({
      %4 = "test.test2"() : () -> index
      "scf.yield"(%4) : (index) -> ()
    }, {
      %3 = "test.test3"() : () -> index
      "scf.yield"(%3) : (index) -> ()
    }) : (i1) -> index
    "test.test4"() : () -> ()
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "empty_else"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "test.test1"() : () -> i1
    "scf.if"(%1) ({
      "test.test2"() : () -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "test.test4"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "while_loop"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "test.test1"() : () -> ()
    "scf.while"() ({
      %2 = "test.test2"() : () -> i1
      %3:2 = "scf.if"(%2) ({
        "test.test3"() : () -> ()
        "scf.yield"(%1, %0) : (i32, i32) -> ()
      }, {
        "scf.yield"(%0, %1) : (i32, i32) -> ()
      }) : (i1) -> (i32, i32)
      %4 = "arith.trunci"(%3#1) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
      "scf.condition"(%4) : (i1) -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : () -> ()
    "test.test4"() : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i64, sym_name = "while_loop_with_block_args"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> index
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i64
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "test.test1"() : () -> index
    %5:2 = "scf.while"(%4, %1) ({
    ^bb0(%arg2: index, %arg3: i64):
      %6:2 = "test.test2"() : () -> (i1, i64)
      %7:4 = "scf.if"(%6#0) ({
        %9 = "test.test3"(%6#1) : (i64) -> index
        "scf.yield"(%9, %1, %3, %2) : (index, i64, i32, i32) -> ()
      }, {
        "scf.yield"(%0, %6#1, %2, %3) : (index, i64, i32, i32) -> ()
      }) : (i1) -> (index, i64, i32, i32)
      %8 = "arith.trunci"(%7#3) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
      "scf.condition"(%8, %7#0, %7#1) : (i1, index, i64) -> ()
    }, {
    ^bb0(%arg0: index, %arg1: i64):
      "scf.yield"(%arg0, %arg1) : (index, i64) -> ()
    }) : (index, i64) -> (index, i64)
    "test.test4"() : () -> ()
    "func.return"(%5#1) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "multi_exit_loop"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "test.test1"() : () -> ()
    "scf.while"() ({
      %2 = "test.test2"() : () -> i1
      %3:2 = "scf.if"(%2) ({
        %5 = "test.test3"() : () -> i1
        %6:2 = "scf.if"(%5) ({
          "scf.yield"(%0, %1) : (i32, i32) -> ()
        }, {
          "scf.yield"(%1, %0) : (i32, i32) -> ()
        }) : (i1) -> (i32, i32)
        "scf.yield"(%6#0, %6#1) : (i32, i32) -> ()
      }, {
        "scf.yield"(%0, %1) : (i32, i32) -> ()
      }) : (i1) -> (i32, i32)
      %4 = "arith.trunci"(%3#1) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
      "scf.condition"(%4) : (i1) -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : () -> ()
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
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.index_castui"(%arg0) : (i32) -> index
    %4:2 = "scf.index_switch"(%3) <{cases = array<i64: 0, 1>}> ({
      %6 = "func.call"(%arg1) <{callee = @foo}> : (f32) -> f32
      "scf.yield"(%6, %2) : (f32, i32) -> ()
    }, {
      "scf.yield"(%arg2, %2) : (f32, i32) -> ()
    }, {
      "scf.yield"(%1, %0) : (f32, i32) -> ()
    }) : (index) -> (f32, i32)
    %5 = "arith.index_castui"(%4#1) : (i32) -> index
    "scf.index_switch"(%5) <{cases = array<i64: 0>}> ({
      "scf.yield"() : () -> ()
    }, {
      "func.call"(%4#0) <{callee = @bar}> : (f32) -> ()
      "scf.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (i1, f32), sym_name = "bar", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "already_structured_loop"}> ({
  ^bb0(%arg0: f32):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "scf.while"(%0) ({
    ^bb0(%arg2: f32):
      %4:2 = "func.call"(%arg0) <{callee = @bar}> : (f32) -> (i1, f32)
      %5:2 = "scf.if"(%4#0) ({
        "scf.yield"(%1, %2) : (i32, i32) -> ()
      }, {
        "scf.yield"(%2, %1) : (i32, i32) -> ()
      }) : (i1) -> (i32, i32)
      %6 = "arith.trunci"(%5#1) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
      "scf.condition"(%6, %4#1) : (i1, f32) -> ()
    }, {
    ^bb0(%arg1: f32):
      "scf.yield"(%arg1) : (f32) -> ()
    }) : (f32) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> (i1, f32), sym_name = "bar", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "exit_loop_iter_use"}> ({
  ^bb0(%arg0: f32):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3:2 = "scf.while"(%arg0, %0) ({
    ^bb0(%arg3: f32, %arg4: f32):
      %4:2 = "func.call"(%arg3) <{callee = @bar}> : (f32) -> (i1, f32)
      %5:3 = "scf.if"(%4#0) ({
        "scf.yield"(%0, %1, %2) : (f32, i32, i32) -> ()
      }, {
        "scf.yield"(%4#1, %2, %1) : (f32, i32, i32) -> ()
      }) : (i1) -> (f32, i32, i32)
      %6 = "arith.trunci"(%5#2) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
      "scf.condition"(%6, %5#0, %arg3) : (i1, f32, f32) -> ()
    }, {
    ^bb0(%arg1: f32, %arg2: f32):
      "scf.yield"(%arg1, %arg2) : (f32, f32) -> ()
    }) : (f32, f32) -> (f32, f32)
    "func.return"(%3#1) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "bar", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32) -> f32, sym_name = "infinite_loop"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "scf.while"(%arg0) ({
    ^bb0(%arg2: f32):
      %4 = "func.call"(%arg2) <{callee = @bar}> : (f32) -> f32
      %5 = "arith.trunci"(%0) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
      "scf.condition"(%5, %4) : (i1, f32) -> ()
    }, {
    ^bb0(%arg1: f32):
      "scf.yield"(%arg1) : (f32) -> ()
    }) : (f32) -> f32
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "multi_return"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "test.test1"() : () -> i1
    %2 = "scf.if"(%1) ({
      %4 = "test.test2"() : () -> i32
      "scf.yield"(%4) : (i32) -> ()
    }, {
      %3 = "test.test4"() : () -> i32
      "scf.yield"(%3) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "bar", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, i1) -> f32, sym_name = "conditional_infinite_loop"}> ({
  ^bb0(%arg0: f32, %arg1: i1):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "scf.if"(%arg1) ({
      %3 = "scf.while"(%arg0) ({
      ^bb0(%arg3: f32):
        %5 = "func.call"(%arg3) <{callee = @bar}> : (f32) -> f32
        %6 = "arith.trunci"(%0) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
        "scf.condition"(%6, %5) : (i1, f32) -> ()
      }, {
      ^bb0(%arg2: f32):
        "scf.yield"(%arg2) : (f32) -> ()
      }) : (f32) -> f32
      %4 = "ub.poison"() <{value = #ub.poison}> : () -> f32
      "scf.yield"(%4) : (f32) -> ()
    }, {
      "scf.yield"(%arg0) : (f32) -> ()
    }) : (i1) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "bar", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1, i1) -> (), sym_name = "mixing_return_like"}> ({
  ^bb0(%arg0: i1, %arg1: i1, %arg2: i1):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %3 = "scf.if"(%arg1) ({
      "scf.yield"(%1) : (i32) -> ()
    }, {
      "scf.yield"(%2) : (i32) -> ()
    }) : (i1) -> i32
    "func.call"(%3) <{callee = @bar}> : (i32) -> ()
    "test.returnLike"() : () -> ()
  ^bb2:  // pred: ^bb0
    %4 = "scf.if"(%arg2) ({
      "scf.yield"(%2) : (i32) -> ()
    }, {
      "scf.yield"(%1) : (i32) -> ()
    }) : (i1) -> i32
    "func.call"(%4) <{callee = @bar}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "some_successors_with_different_return"}> ({
  ^bb0(%arg0: i32):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 6 : i32}> : () -> i32
    %5 = "arith.index_castui"(%arg0) : (i32) -> index
    %6:2 = "scf.index_switch"(%5) <{cases = array<i64: 0, 1>}> ({
      "scf.yield"(%0, %2) : (i32, i32) -> ()
    }, {
      "scf.yield"(%3, %1) : (i32, i32) -> ()
    }, {
      "scf.yield"(%4, %1) : (i32, i32) -> ()
    }) : (index) -> (i32, i32)
    "cf.switch"(%6#1, %6#0)[^bb1, ^bb2] <{case_operand_segments = array<i32: 0>, case_values = dense<0> : vector<1xi32>, operandSegmentSizes = array<i32: 1, 1, 0>}> : (i32, i32) -> ()
  ^bb1(%7: i32):  // pred: ^bb0
    %8 = "scf.while"(%7) ({
    ^bb0(%arg2: i32):
      %10 = "arith.trunci"(%1) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
      "scf.condition"(%10, %arg2) : (i1, i32) -> ()
    }, {
    ^bb0(%arg1: i32):
      "scf.yield"(%arg1) : (i32) -> ()
    }) : (i32) -> i32
    %9 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    "func.return"(%9) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "test.returnLike"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "select_like"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "scf.if"(%arg0) ({
      "scf.yield"(%1) : (i32) -> ()
    }, {
      "scf.yield"(%2) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1, i1) -> (), sym_name = "return_like_dominated_by_condition"}> ({
  ^bb0(%arg0: i1, %arg1: i1, %arg2: i1):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "scf.if"(%arg0) ({
      "scf.yield"(%2) : (i32) -> ()
    }, {
      %4:2 = "scf.if"(%arg1) ({
        "scf.yield"(%0, %2) : (i32, i32) -> ()
      }, {
        %7:2 = "scf.if"(%arg2) ({
          "scf.yield"(%0, %2) : (i32, i32) -> ()
        }, {
          "scf.yield"(%2, %1) : (i32, i32) -> ()
        }) : (i1) -> (i32, i32)
        "scf.yield"(%7#0, %7#1) : (i32, i32) -> ()
      }) : (i1) -> (i32, i32)
      %5 = "arith.index_castui"(%4#1) : (i32) -> index
      %6 = "scf.index_switch"(%5) <{cases = array<i64: 0>}> ({
        "scf.yield"(%4#0) : (i32) -> ()
      }, {
        "scf.yield"(%1) : (i32) -> ()
      }) : (index) -> i32
      "scf.yield"(%6) : (i32) -> ()
    }) : (i1) -> i32
    "cf.switch"(%3)[^bb2, ^bb1] <{case_operand_segments = array<i32: 0>, case_values = dense<0> : vector<1xi32>, operandSegmentSizes = array<i32: 1, 0, 0>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "test.unreachable"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> i32, sym_name = "dominator_issue"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3:2 = "scf.if"(%arg0) ({
      "scf.yield"(%1, %2) : (i32, i32) -> ()
    }, {
      %5 = "test.def"() : () -> i32
      %6:2 = "scf.if"(%arg1) ({
        "scf.yield"(%1, %2) : (i32, i32) -> ()
      }, {
        "scf.yield"(%5, %0) : (i32, i32) -> ()
      }) : (i1) -> (i32, i32)
      "scf.yield"(%6#0, %6#1) : (i32, i32) -> ()
    }) : (i1) -> (i32, i32)
    "cf.switch"(%3#1, %3#0)[^bb2, ^bb1] <{case_operand_segments = array<i32: 0>, case_values = dense<0> : vector<1xi32>, operandSegmentSizes = array<i32: 1, 1, 0>}> : (i32, i32) -> ()
  ^bb1:  // pred: ^bb0
    "test.unreachable"() : () -> ()
  ^bb2(%4: i32):  // pred: ^bb0
    "func.return"(%4) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "bar", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> i32, sym_name = "dominator_issue_loop"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %1 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %5:2 = "scf.while"(%0, %0) ({
    ^bb0(%arg4: i32, %arg5: i32):
      %8:3 = "scf.if"(%arg0) ({
        %10 = "test.def"() : () -> i32
        %11:3 = "scf.if"(%arg1) ({
          "scf.yield"(%3, %2, %10) : (i32, i32, i32) -> ()
        }, {
          "scf.yield"(%2, %3, %10) : (i32, i32, i32) -> ()
        }) : (i1) -> (i32, i32, i32)
        "scf.yield"(%11#0, %11#1, %11#2) : (i32, i32, i32) -> ()
      }, {
        "scf.yield"(%1, %3, %0) : (i32, i32, i32) -> ()
      }) : (i1) -> (i32, i32, i32)
      %9 = "arith.trunci"(%8#1) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
      "scf.condition"(%9, %8#2, %8#0) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg2: i32, %arg3: i32):
      "scf.yield"(%arg2, %arg3) : (i32, i32) -> ()
    }) : (i32, i32) -> (i32, i32)
    %6 = "arith.index_castui"(%5#1) : (i32) -> index
    %7 = "scf.index_switch"(%6) <{cases = array<i64: 1>}> ({
      "scf.yield"(%4) : (i32) -> ()
    }, {
      "scf.yield"(%5#0) : (i32) -> ()
    }) : (index) -> i32
    "func.return"(%7) : (i32) -> ()
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
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 6 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %5:2 = "scf.if"(%arg0) ({
      "scf.yield"(%1, %0) : (i32, i32) -> ()
    }, {
      "scf.yield"(%2, %0) : (i32, i32) -> ()
    }) : (i1) -> (i32, i32)
    %6:2 = "scf.while"(%5#0, %5#1) ({
    ^bb0(%arg3: i32, %arg4: i32):
      %7 = "arith.index_castui"(%arg3) : (i32) -> index
      %8:4 = "scf.index_switch"(%7) <{cases = array<i64: 0>}> ({
        %12 = "func.call"(%3) <{callee = @comp1}> : (i32) -> i1
        %13:4 = "scf.if"(%12) ({
          "scf.yield"(%0, %3, %1, %2) : (i32, i32, i32, i32) -> ()
        }, {
          "scf.yield"(%2, %0, %2, %1) : (i32, i32, i32, i32) -> ()
        }) : (i1) -> (i32, i32, i32, i32)
        "scf.yield"(%13#0, %13#1, %13#2, %13#3) : (i32, i32, i32, i32) -> ()
      }, {
        %10 = "func.call"(%4) <{callee = @comp2}> : (i32) -> i1
        %11:4 = "scf.if"(%10) ({
          "scf.yield"(%0, %4, %1, %2) : (i32, i32, i32, i32) -> ()
        }, {
          "scf.yield"(%1, %0, %2, %1) : (i32, i32, i32, i32) -> ()
        }) : (i1) -> (i32, i32, i32, i32)
        "scf.yield"(%11#0, %11#1, %11#2, %11#3) : (i32, i32, i32, i32) -> ()
      }) : (index) -> (i32, i32, i32, i32)
      %9 = "arith.trunci"(%8#3) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
      "scf.condition"(%9, %8#0, %8#1) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg1: i32, %arg2: i32):
      "scf.yield"(%arg1, %arg2) : (i32, i32) -> ()
    }) : (i32, i32) -> (i32, i32)
    "func.call"(%6#1) <{callee = @foo}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "nested_region"}> ({
    "scf.execute_region"() ({
      %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %1 = "test.test1"() : () -> i1
      "scf.if"(%1) ({
        "test.test2"() : () -> ()
        "scf.yield"() : () -> ()
      }, {
        "test.test3"() : () -> ()
        "scf.yield"() : () -> ()
      }) : (i1) -> ()
      "test.test4"() : () -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "nested_region_inside_loop_use"}> ({
    %0 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "scf.while"() ({
      %2 = "test.test1"() : () -> i32
      "scf.execute_region"() ({
        "test.foo"(%2) : (i32) -> ()
        "scf.yield"() : () -> ()
      }) : () -> ()
      %3 = "arith.trunci"(%0) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
      "scf.condition"(%3) : (i1) -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "nested_region_outside_loop_use"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %3 = "scf.while"(%0) ({
    ^bb0(%arg1: i32):
      %4 = "test.test1"() : () -> i32
      %5 = "test.test2"() : () -> i1
      %6:2 = "scf.if"(%5) ({
        "scf.yield"(%2, %1) : (i32, i32) -> ()
      }, {
        "scf.yield"(%1, %2) : (i32, i32) -> ()
      }) : (i1) -> (i32, i32)
      %7 = "arith.trunci"(%6#1) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
      "scf.condition"(%7, %4) : (i1, i32) -> ()
    }, {
    ^bb0(%arg0: i32):
      "scf.yield"(%arg0) : (i32) -> ()
    }) : (i32) -> i32
    "scf.execute_region"() ({
      "test.foo"(%3) : (i32) -> ()
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

