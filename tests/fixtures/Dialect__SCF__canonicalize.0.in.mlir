"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xi32>) -> (), sym_name = "single_iteration_some"}> ({
  ^bb0(%arg0: memref<?x?x?xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.constant"() <{value = 6 : index}> : () -> index
    %5 = "arith.constant"() <{value = 7 : index}> : () -> index
    %6 = "arith.constant"() <{value = 10 : index}> : () -> index
    "scf.parallel"(%0, %3, %5, %1, %4, %6, %1, %2, %3) <{operandSegmentSizes = array<i32: 3, 3, 3, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index):
      %7 = "arith.constant"() <{value = 42 : i32}> : () -> i32
      "memref.store"(%7, %arg0, %arg1, %arg2, %arg3) : (i32, memref<?x?x?xi32>, index, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index, index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xi32>) -> (), sym_name = "single_iteration_all"}> ({
  ^bb0(%arg0: memref<?x?x?xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = 6 : index}> : () -> index
    %4 = "arith.constant"() <{value = 7 : index}> : () -> index
    %5 = "arith.constant"() <{value = 10 : index}> : () -> index
    "scf.parallel"(%0, %2, %4, %1, %3, %5, %1, %2, %2) <{operandSegmentSizes = array<i32: 3, 3, 3, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index):
      %6 = "arith.constant"() <{value = 42 : i32}> : () -> i32
      "memref.store"(%6, %arg0, %arg1, %arg2, %arg3) : (i32, memref<?x?x?xi32>, index, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index, index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (index, index), sym_name = "single_iteration_reduce"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4 = "arith.constant"() <{value = 6 : index}> : () -> index
    %5:2 = "scf.parallel"(%1, %3, %2, %4, %1, %3, %arg0, %arg1) <{operandSegmentSizes = array<i32: 2, 2, 2, 2>}> ({
    ^bb0(%arg2: index, %arg3: index):
      "scf.reduce"(%arg2, %arg3) ({
      ^bb0(%arg6: index, %arg7: index):
        %7 = "arith.addi"(%arg6, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        "scf.reduce.return"(%7) : (index) -> ()
      }, {
      ^bb0(%arg4: index, %arg5: index):
        %6 = "arith.muli"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        "scf.reduce.return"(%6) : (index) -> ()
      }) : (index, index) -> ()
    }) : (index, index, index, index, index, index, index, index) -> (index, index)
    "func.return"(%5#0, %5#1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf64>) -> memref<?x?x?xf64>, sym_name = "nested_parallel"}> ({
  ^bb0(%arg0: memref<?x?x?xf64>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %0) : (memref<?x?x?xf64>, index) -> index
    %4 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf64>, index) -> index
    %5 = "memref.dim"(%arg0, %2) : (memref<?x?x?xf64>, index) -> index
    %6 = "memref.alloc"(%3, %4, %5) <{operandSegmentSizes = array<i32: 3, 0>}> : (index, index, index) -> memref<?x?x?xf64>
    "scf.parallel"(%0, %3, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg1: index):
      "scf.parallel"(%0, %4, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
      ^bb0(%arg2: index):
        "scf.parallel"(%0, %5, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
        ^bb0(%arg3: index):
          %7 = "memref.load"(%arg0, %arg1, %arg2, %arg3) : (memref<?x?x?xf64>, index, index, index) -> f64
          "memref.store"(%7, %6, %arg1, %arg2, %arg3) : (f64, memref<?x?x?xf64>, index, index, index) -> ()
          "scf.reduce"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.reduce"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%6) : (memref<?x?x?xf64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "side_effect", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> index, sym_name = "one_unused"}> ({
  ^bb0(%arg0: i1):
    %0:2 = "scf.if"(%arg0) ({
      "func.call"() <{callee = @side_effect}> : () -> ()
      %3 = "test.value0"() : () -> index
      %4 = "test.value1"() : () -> index
      "scf.yield"(%3, %4) : (index, index) -> ()
    }, {
      %1 = "test.value2"() : () -> index
      %2 = "test.value3"() : () -> index
      "scf.yield"(%1, %2) : (index, index) -> ()
    }) : (i1) -> (index, index)
    "func.return"(%0#1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "side_effect", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> index, sym_name = "nested_unused"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0:2 = "scf.if"(%arg0) ({
      %3:2 = "scf.if"(%arg1) ({
        "func.call"() <{callee = @side_effect}> : () -> ()
        %6 = "test.value0"() : () -> index
        %7 = "test.value1"() : () -> index
        "scf.yield"(%6, %7) : (index, index) -> ()
      }, {
        %4 = "test.value2"() : () -> index
        %5 = "test.value3"() : () -> index
        "scf.yield"(%4, %5) : (index, index) -> ()
      }) : (i1) -> (index, index)
      "scf.yield"(%3#0, %3#1) : (index, index) -> ()
    }, {
      %1 = "test.value0_2"() : () -> index
      %2 = "test.value1_2"() : () -> index
      "scf.yield"(%1, %2) : (index, index) -> ()
    }) : (i1) -> (index, index)
    "func.return"(%0#1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "side_effect", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "all_unused"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2:2 = "scf.if"(%arg0) ({
      "func.call"() <{callee = @side_effect}> : () -> ()
      "scf.yield"(%0, %1) : (index, index) -> ()
    }, {
      "func.call"() <{callee = @side_effect}> : () -> ()
      "scf.yield"(%0, %1) : (index, index) -> ()
    }) : (i1) -> (index, index)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "empty_if1"}> ({
  ^bb0(%arg0: i1):
    "scf.if"(%arg0) ({
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (), sym_name = "empty_if2"}> ({
  ^bb0(%arg0: i1):
    "scf.if"(%arg0) ({
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<i1>) -> (), sym_name = "empty_else"}> ({
  ^bb0(%arg0: i1, %arg1: memref<i1>):
    "scf.if"(%arg0) ({
      "memref.store"(%arg0, %arg1) : (i1, memref<i1>) -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> index, sym_name = "to_select1"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "scf.if"(%arg0) ({
      "scf.yield"(%0) : (index) -> ()
    }, {
      "scf.yield"(%1) : (index) -> ()
    }) : (i1) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (index, index), sym_name = "to_select_same_val"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2:2 = "scf.if"(%arg0) ({
      "scf.yield"(%0, %1) : (index, index) -> ()
    }, {
      "scf.yield"(%1, %1) : (index, index) -> ()
    }) : (i1) -> (index, index)
    "func.return"(%2#0, %2#1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> index, sym_name = "to_select_with_body"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "scf.if"(%arg0) ({
      "test.op"() : () -> ()
      "scf.yield"(%0) : (index) -> ()
    }, {
      "scf.yield"(%1) : (index) -> ()
    }) : (i1) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (index, index), sym_name = "to_select2"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : index}> : () -> index
    %4:2 = "scf.if"(%arg0) ({
      "scf.yield"(%0, %1) : (index, index) -> ()
    }, {
      "scf.yield"(%2, %3) : (index, index) -> ()
    }) : (i1) -> (index, index)
    "func.return"(%4#0, %4#1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "make_i32", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "for_yields_2"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "func.call"() <{callee = @make_i32}> : () -> i32
    %1 = "scf.for"(%arg0, %arg1, %arg2, %0) ({
    ^bb0(%arg3: index, %arg4: i32):
      "scf.yield"(%arg4) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "make_i32", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (i32, i32, i32), sym_name = "for_yields_3"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "func.call"() <{callee = @make_i32}> : () -> i32
    %1 = "func.call"() <{callee = @make_i32}> : () -> i32
    %2:3 = "scf.for"(%arg0, %arg1, %arg2, %0, %0, %1) ({
    ^bb0(%arg3: index, %arg4: i32, %arg5: i32, %arg6: i32):
      %3 = "func.call"() <{callee = @make_i32}> : () -> i32
      "scf.yield"(%arg4, %3, %arg6) : (i32, i32, i32) -> ()
    }) {some_attr} : (index, index, index, i32, i32, i32) -> (i32, i32, i32)
    "func.return"(%2#0, %2#1, %2#2) : (i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "for_yields_4"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 3 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 4 : i32}> : () -> i32
    %5 = "scf.for"(%0, %2, %1, %3) ({
    ^bb0(%arg0: index, %arg1: i32):
      "scf.yield"(%4) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "constant_iter_arg"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "scf.for"(%arg0, %arg1, %arg2, %0) ({
    ^bb0(%arg3: index, %arg4: i32):
      "test.use"(%arg4) : (i32) -> ()
      "scf.yield"(%0) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "replace_true_if"}> ({
    %0 = "arith.constant"() <{value = true}> : () -> i1
    "scf.if"(%0) ({
      "test.op"() : () -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "remove_false_if"}> ({
    %0 = "arith.constant"() <{value = false}> : () -> i1
    "scf.if"(%0) ({
      "test.op"() : () -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "replace_true_if_with_values"}> ({
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "scf.if"(%0) ({
      %3 = "test.op"() : () -> i32
      "scf.yield"(%3) : (i32) -> ()
    }, {
      %2 = "test.other_op"() : () -> i32
      "scf.yield"(%2) : (i32) -> ()
    }) : (i1) -> i32
    "test.consume"(%1) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "replace_false_if_with_values"}> ({
    %0 = "arith.constant"() <{value = false}> : () -> i1
    %1 = "scf.if"(%0) ({
      %3 = "test.op"() : () -> i32
      "scf.yield"(%3) : (i32) -> ()
    }, {
      %2 = "test.other_op"() : () -> i32
      "scf.yield"(%2) : (i32) -> ()
    }) : (i1) -> i32
    "test.consume"(%1) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "merge_nested_if"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    "scf.if"(%arg0) ({
      "scf.if"(%arg1) ({
        "test.op"() : () -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> (i32, f32, i32, i8), sym_name = "merge_yielding_nested_if"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "test.op"() : () -> i32
    %1 = "test.op1"() : () -> f32
    %2 = "test.op2"() : () -> i32
    %3 = "test.op3"() : () -> i8
    %4:4 = "scf.if"(%arg0) ({
      %5:2 = "scf.if"(%arg1) ({
        %6 = "test.inop"() : () -> i32
        %7 = "test.inop1"() : () -> f32
        "scf.yield"(%6, %7) : (i32, f32) -> ()
      }, {
        "scf.yield"(%2, %1) : (i32, f32) -> ()
      }) : (i1) -> (i32, f32)
      "scf.yield"(%0, %5#1, %5#0, %3) : (i32, f32, i32, i8) -> ()
    }, {
      "scf.yield"(%0, %1, %2, %3) : (i32, f32, i32, i8) -> ()
    }) : (i1) -> (i32, f32, i32, i8)
    "func.return"(%4#0, %4#1, %4#2, %4#3) : (i32, f32, i32, i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "merge_yielding_nested_if_nv1"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "test.op"() : () -> i32
    %1 = "test.op1"() : () -> f32
    "scf.if"(%arg0) ({
      %2:2 = "scf.if"(%arg1) ({
        %3 = "test.inop"() : () -> i32
        %4 = "test.inop1"() : () -> f32
        "scf.yield"(%3, %4) : (i32, f32) -> ()
      }, {
        "scf.yield"(%0, %1) : (i32, f32) -> ()
      }) : (i1) -> (i32, f32)
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> i32, sym_name = "merge_yielding_nested_if_nv2"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "test.op"() : () -> i32
    %1 = "test.op1"() : () -> i32
    %2 = "scf.if"(%arg0) ({
      "scf.if"(%arg1) ({
        "test.run"() : () -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "scf.yield"(%0) : (i32) -> ()
    }, {
      "scf.yield"(%1) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i1) -> (i32, f32, i32, i8), sym_name = "merge_fail_yielding_nested_if"}> ({
  ^bb0(%arg0: i1, %arg1: i1):
    %0 = "test.op"() : () -> i32
    %1 = "test.op1"() : () -> f32
    %2 = "test.op2"() : () -> i32
    %3 = "test.op3"() : () -> i8
    %4:4 = "scf.if"(%arg0) ({
      %5:2 = "scf.if"(%arg1) ({
        %6 = "test.inop"() : () -> i32
        %7 = "test.inop1"() : () -> f32
        "scf.yield"(%6, %7) : (i32, f32) -> ()
      }, {
        "scf.yield"(%0, %1) : (i32, f32) -> ()
      }) : (i1) -> (i32, f32)
      "scf.yield"(%0, %5#1, %5#0, %3) : (i32, f32, i32, i8) -> ()
    }, {
      "scf.yield"(%0, %1, %2, %3) : (i32, f32, i32, i8) -> ()
    }) : (i1) -> (i32, f32, i32, i8)
    "func.return"(%4#0, %4#1, %4#2, %4#3) : (i32, f32, i32, i8) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> index, sym_name = "if_condition_swap"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "arith.xori"(%arg0, %0) : (i1, i1) -> i1
    %2 = "scf.if"(%1) ({
      %4 = "test.origTrue"() : () -> index
      "scf.yield"(%4) : (index) -> ()
    }, {
      %3 = "test.origFalse"() : () -> index
      "scf.yield"(%3) : (index) -> ()
    }) : (i1) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "remove_zero_iteration_loop"}> ({
    %0 = "arith.constant"() <{value = 42 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "test.init"() : () -> i32
    %3 = "scf.for"(%0, %1, %1, %2) ({
    ^bb0(%arg0: index, %arg1: i32):
      %4 = "test.op"(%arg0, %arg1) : (index, i32) -> i32
      "scf.yield"(%4) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "test.consume"(%3) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "remove_zero_iteration_loop_vals"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "test.init"() : () -> i32
    %2 = "scf.for"(%arg0, %arg0, %0, %1) ({
    ^bb0(%arg1: index, %arg2: i32):
      %3 = "test.op"(%arg1, %arg2) : (index, i32) -> i32
      "scf.yield"(%3) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "test.consume"(%2) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "replace_single_iteration_loop_1"}> ({
    %0 = "arith.constant"() <{value = 42 : index}> : () -> index
    %1 = "arith.constant"() <{value = 43 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "test.init"() : () -> i32
    %4 = "scf.for"(%0, %1, %2, %3) ({
    ^bb0(%arg0: index, %arg1: i32):
      %5 = "test.op"(%arg0, %arg1) : (index, i32) -> i32
      "scf.yield"(%5) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "test.consume"(%4) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "replace_single_iteration_loop_2"}> ({
    %0 = "arith.constant"() <{value = 5 : index}> : () -> index
    %1 = "arith.constant"() <{value = 6 : index}> : () -> index
    %2 = "arith.constant"() <{value = 11 : index}> : () -> index
    %3 = "test.init"() : () -> i32
    %4 = "scf.for"(%0, %2, %1, %3) ({
    ^bb0(%arg0: index, %arg1: i32):
      %5 = "test.op"(%arg0, %arg1) : (index, i32) -> i32
      "scf.yield"(%5) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "test.consume"(%4) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "replace_single_iteration_loop_non_unit_step"}> ({
    %0 = "arith.constant"() <{value = 42 : index}> : () -> index
    %1 = "arith.constant"() <{value = 47 : index}> : () -> index
    %2 = "arith.constant"() <{value = 5 : index}> : () -> index
    %3 = "test.init"() : () -> i32
    %4 = "scf.for"(%0, %1, %2, %3) ({
    ^bb0(%arg0: index, %arg1: i32):
      %5 = "test.op"(%arg0, %arg1) : (index, i32) -> i32
      "scf.yield"(%5) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "test.consume"(%4) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "replace_single_iteration_const_diff"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.addi"(%arg0, %0) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
    "scf.for"(%arg0, %2, %0) ({
    ^bb0(%arg1: index):
      %3 = "arith.muli"(%1, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "test.consume"(%3) : (index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "replace_single_iteration_loop_unsigned_cmp"}> ({
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = -100 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 2147483647 : i32}> : () -> i32
    %3 = "test.init"() : () -> i32
    %4 = "scf.for"(%0, %1, %2, %3) <{unsignedCmp}> ({
    ^bb0(%arg0: i32, %arg1: i32):
      %5 = "test.op"(%arg0, %arg1) : (i32, i32) -> i32
      "scf.yield"(%5) : (i32) -> ()
    }) : (i32, i32, i32, i32) -> i32
    "test.consume"(%4) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "remove_empty_parallel_loop"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "test.init"() : () -> f32
    %1 = "scf.parallel"(%arg0, %arg1, %arg0, %arg1, %arg1, %arg1, %arg2, %arg2, %arg2, %0) <{operandSegmentSizes = array<i32: 3, 3, 3, 1>}> ({
    ^bb0(%arg3: index, %arg4: index, %arg5: index):
      %2 = "test.produce"() : () -> f32
      "scf.reduce"(%2) ({
      ^bb0(%arg6: f32, %arg7: f32):
        %3 = "test.transform"(%arg6, %arg7) : (f32, f32) -> f32
        "scf.reduce.return"(%3) : (f32) -> ()
      }) : (f32) -> ()
    }) : (index, index, index, index, index, index, index, index, index, f32) -> f32
    "test.consume"(%1) : (f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, index, index, index) -> (i32, i32), sym_name = "fold_away_iter_with_no_use_and_yielded_input"}> ({
  ^bb0(%arg0: i32, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1:2 = "scf.for"(%arg2, %arg1, %arg3, %arg0, %0) ({
    ^bb0(%arg4: index, %arg5: i32, %arg6: i32):
      %2 = "arith.addi"(%arg5, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%2, %0) : (i32, i32) -> ()
    }) : (index, index, index, i32, i32) -> (i32, i32)
    "func.return"(%1#0, %1#1) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, index, index, index) -> i32, sym_name = "fold_away_iter_and_result_with_no_use"}> ({
  ^bb0(%arg0: i32, %arg1: index, %arg2: index, %arg3: index):
    %0 = "arith.constant"() <{value = 32 : i32}> : () -> i32
    %1:2 = "scf.for"(%arg2, %arg1, %arg3, %arg0, %0) ({
    ^bb0(%arg4: index, %arg5: i32, %arg6: i32):
      %2 = "arith.addi"(%arg5, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%2, %2) : (i32, i32) -> ()
    }) : (index, index, index, i32, i32) -> (i32, i32)
    "func.return"(%1#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index) -> (index, index, index, index), sym_name = "replace_duplicate_iter_args"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0:4 = "scf.for"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg4, %arg3) ({
    ^bb0(%arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index):
      %1 = "arith.addi"(%arg6, %arg7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %2 = "arith.addi"(%arg8, %arg9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%1, %2, %2, %1) : (index, index, index, index) -> ()
    }) : (index, index, index, index, index, index, index) -> (index, index, index, index)
    "func.return"(%0#0, %0#1, %0#2, %0#3) : (index, index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "do", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (tensor<32x1024xf32>) -> tensor<?x?xf32>, sym_name = "matmul_on_tensors"}> ({
  ^bb0(%arg0: tensor<32x1024xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 32 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %3 = "tensor.cast"(%arg0) : (tensor<32x1024xf32>) -> tensor<?x?xf32>
    %4 = "scf.for"(%0, %2, %1, %3) ({
    ^bb0(%arg1: index, %arg2: tensor<?x?xf32>):
      %5 = "func.call"(%arg2) <{callee = @do}> : (tensor<?x?xf32>) -> tensor<?x?xf32>
      "scf.yield"(%5) : (tensor<?x?xf32>) -> ()
    }) {some_attr} : (index, index, index, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%4) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> index, sym_name = "cond_prop"}> ({
  ^bb0(%arg0: i1):
    %0 = "scf.if"(%arg0) ({
      %4 = "scf.if"(%arg0) ({
        %6 = "test.get_some_value1"() : () -> index
        "scf.yield"(%6) : (index) -> ()
      }, {
        %5 = "test.get_some_value2"() : () -> index
        "scf.yield"(%5) : (index) -> ()
      }) : (i1) -> index
      "scf.yield"(%4) : (index) -> ()
    }, {
      %1 = "scf.if"(%arg0) ({
        %3 = "test.get_some_value3"() : () -> index
        "scf.yield"(%3) : (index) -> ()
      }, {
        %2 = "test.get_some_value4"() : () -> index
        "scf.yield"(%2) : (index) -> ()
      }) : (i1) -> index
      "scf.yield"(%1) : (index) -> ()
    }) : (i1) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (i32, i1), sym_name = "replace_if_with_cond1"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "arith.constant"() <{value = false}> : () -> i1
    %2:2 = "scf.if"(%arg0) ({
      %4 = "test.get_some_value"() : () -> i32
      "scf.yield"(%4, %0) : (i32, i1) -> ()
    }, {
      %3 = "test.get_some_value"() : () -> i32
      "scf.yield"(%3, %1) : (i32, i1) -> ()
    }) : (i1) -> (i32, i1)
    "func.return"(%2#0, %2#1) : (i32, i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> (i32, i1), sym_name = "replace_if_with_cond2"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "arith.constant"() <{value = false}> : () -> i1
    %2:2 = "scf.if"(%arg0) ({
      %4 = "test.get_some_value"() : () -> i32
      "scf.yield"(%4, %1) : (i32, i1) -> ()
    }, {
      %3 = "test.get_some_value"() : () -> i32
      "scf.yield"(%3, %0) : (i32, i1) -> ()
    }) : (i1) -> (i32, i1)
    "func.return"(%2#0, %2#1) : (i32, i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i64) -> (i32, i64), sym_name = "replace_if_with_cond3"}> ({
  ^bb0(%arg0: i1, %arg1: i64):
    %0:2 = "scf.if"(%arg0) ({
      %2 = "test.get_some_value"() : () -> i32
      "scf.yield"(%2, %arg1) : (i32, i64) -> ()
    }, {
      %1 = "test.get_some_value"() : () -> i32
      "scf.yield"(%1, %arg1) : (i32, i64) -> ()
    }) : (i1) -> (i32, i64)
    "func.return"(%0#0, %0#1) : (i32, i64) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "while_move_if_down"}> ({
    %0 = "test.get_some_value0"() : () -> i32
    %1 = "scf.while"() ({
      %2 = "test.get_some_value1"() : () -> i32
      %3 = "test.get_some_value2"() : () -> i32
      %4 = "test.get_some_value3"() : () -> i32
      %5 = "test.condition"() : () -> i1
      %6 = "scf.if"(%5) ({
        "test.use0"(%0) : (i32) -> ()
        "test.use1"(%2) : (i32) -> ()
        "test.alloca_scope_region"() ({
          "test.use2"(%3) : (i32) -> ()
        }) : () -> ()
        %7 = "test.get_some_value4"() : () -> i32
        "scf.yield"(%7) : (i32) -> ()
      }, {
        "scf.yield"(%4) : (i32) -> ()
      }) : (i1) -> i32
      "scf.condition"(%5, %6) : (i1, i32) -> ()
    }, {
    ^bb0(%arg0: i32):
      "test.use3"(%arg0) : (i32) -> ()
      "scf.yield"() : () -> ()
    }) : () -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i1, sym_name = "while_cond_true"}> ({
    %0 = "scf.while"() ({
      %1 = "test.condition"() : () -> i1
      "scf.condition"(%1, %1) : (i1, i1) -> ()
    }, {
    ^bb0(%arg0: i1):
      "test.use"(%arg0) : (i1) -> ()
      "scf.yield"() : () -> ()
    }) : () -> i1
    "func.return"(%0) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<i32>) -> (tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>), sym_name = "invariant_loop_args_in_same_order"}> ({
  ^bb0(%arg12: tensor<i32>):
    %8 = "arith.constant"() <{value = dense<0> : tensor<i32>}> : () -> tensor<i32>
    %9 = "arith.constant"() <{value = dense<1> : tensor<i32>}> : () -> tensor<i32>
    %10 = "arith.constant"() <{value = dense<42> : tensor<i32>}> : () -> tensor<i32>
    %11:5 = "scf.while"(%8, %arg12, %9, %9, %8) ({
    ^bb0(%arg18: tensor<i32>, %arg19: tensor<i32>, %arg20: tensor<i32>, %arg21: tensor<i32>, %arg22: tensor<i32>):
      %14 = "arith.cmpi"(%arg18, %10) <{predicate = 2 : i64}> : (tensor<i32>, tensor<i32>) -> tensor<i1>
      %15 = "tensor.extract"(%14) : (tensor<i1>) -> i1
      "scf.condition"(%15, %arg18, %arg19, %arg20, %arg21, %arg22) : (i1, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>) -> ()
    }, {
    ^bb0(%arg13: tensor<i32>, %arg14: tensor<i32>, %arg15: tensor<i32>, %arg16: tensor<i32>, %arg17: tensor<i32>):
      %12 = "arith.addi"(%arg13, %arg14) <{overflowFlags = #arith.overflow<none>}> : (tensor<i32>, tensor<i32>) -> tensor<i32>
      %13 = "arith.addi"(%arg15, %arg16) <{overflowFlags = #arith.overflow<none>}> : (tensor<i32>, tensor<i32>) -> tensor<i32>
      "scf.yield"(%12, %arg14, %13, %13, %arg17) : (tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>) -> ()
    }) : (tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>) -> (tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>)
    "func.return"(%11#0, %11#1, %11#2, %11#3, %11#4) : (tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<i32>) -> (tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>), sym_name = "while_loop_invariant_argument_different_order"}> ({
  ^bb0(%arg0: tensor<i32>):
    %0 = "arith.constant"() <{value = dense<0> : tensor<i32>}> : () -> tensor<i32>
    %1 = "arith.constant"() <{value = dense<1> : tensor<i32>}> : () -> tensor<i32>
    %2 = "arith.constant"() <{value = dense<42> : tensor<i32>}> : () -> tensor<i32>
    %3:6 = "scf.while"(%0, %1, %1, %1, %0) ({
    ^bb0(%arg7: tensor<i32>, %arg8: tensor<i32>, %arg9: tensor<i32>, %arg10: tensor<i32>, %arg11: tensor<i32>):
      %6 = "arith.cmpi"(%arg7, %arg0) <{predicate = 2 : i64}> : (tensor<i32>, tensor<i32>) -> tensor<i1>
      %7 = "tensor.extract"(%6) : (tensor<i1>) -> i1
      "scf.condition"(%7, %arg8, %arg7, %arg9, %arg7, %arg10, %arg11) : (i1, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>) -> ()
    }, {
    ^bb0(%arg1: tensor<i32>, %arg2: tensor<i32>, %arg3: tensor<i32>, %arg4: tensor<i32>, %arg5: tensor<i32>, %arg6: tensor<i32>):
      %4 = "arith.addi"(%arg1, %1) <{overflowFlags = #arith.overflow<none>}> : (tensor<i32>, tensor<i32>) -> tensor<i32>
      %5 = "arith.addi"(%arg3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (tensor<i32>, tensor<i32>) -> tensor<i32>
      "scf.yield"(%arg4, %arg2, %5, %5, %arg5) : (tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>) -> ()
    }) : (tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>) -> (tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>)
    "func.return"(%3#0, %3#1, %3#2, %3#3, %3#4, %3#5) : (tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>, tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "while_unused_result"}> ({
    %0:2 = "scf.while"() ({
      %1 = "test.condition"() : () -> i1
      %2 = "test.get_some_value"() : () -> i32
      %3 = "test.get_some_value"() : () -> i64
      "scf.condition"(%1, %2, %3) : (i1, i32, i64) -> ()
    }, {
    ^bb0(%arg0: i32, %arg1: i64):
      "test.use"(%arg0) : (i32) -> ()
      "scf.yield"() : () -> ()
    }) : () -> (i32, i64)
    "func.return"(%0#0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "while_cmp_lhs"}> ({
  ^bb0(%arg0: i32):
    %0 = "scf.while"() ({
      %3 = "test.val"() : () -> i32
      %4 = "arith.cmpi"(%3, %arg0) <{predicate = 1 : i64}> : (i32, i32) -> i1
      "scf.condition"(%4, %3) : (i1, i32) -> ()
    }, {
    ^bb0(%arg1: i32):
      %1 = "arith.cmpi"(%arg1, %arg0) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %2 = "arith.cmpi"(%arg1, %arg0) <{predicate = 0 : i64}> : (i32, i32) -> i1
      "test.use"(%1, %2, %arg1) : (i1, i1, i32) -> ()
      "scf.yield"() : () -> ()
    }) : () -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "while_cmp_rhs"}> ({
  ^bb0(%arg0: i32):
    %0 = "scf.while"() ({
      %3 = "test.val"() : () -> i32
      %4 = "arith.cmpi"(%arg0, %3) <{predicate = 1 : i64}> : (i32, i32) -> i1
      "scf.condition"(%4, %3) : (i1, i32) -> ()
    }, {
    ^bb0(%arg1: i32):
      %1 = "arith.cmpi"(%arg0, %arg1) <{predicate = 1 : i64}> : (i32, i32) -> i1
      %2 = "arith.cmpi"(%arg0, %arg1) <{predicate = 0 : i64}> : (i32, i32) -> i1
      "test.use"(%1, %2, %arg1) : (i1, i1, i32) -> ()
      "scf.yield"() : () -> ()
    }) : () -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "while_duplicated_res"}> ({
    %0:2 = "scf.while"() ({
      %1 = "test.val"() : () -> i32
      %2 = "test.condition"() : () -> i1
      "scf.condition"(%2, %1, %1) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg0: i32, %arg1: i32):
      "test.use"(%arg0, %arg1) : (i32, i32) -> ()
      "scf.yield"() : () -> ()
    }) : () -> (i32, i32)
    "func.return"(%0#0, %0#1) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, f64) -> i32, sym_name = "while_unused_arg1"}> ({
  ^bb0(%arg0: i32, %arg1: f64):
    %0 = "scf.while"(%arg0, %arg1) ({
    ^bb0(%arg3: i32, %arg4: f64):
      %2 = "test.condition"(%arg3) : (i32) -> i1
      "scf.condition"(%2, %arg3) : (i1, i32) -> ()
    }, {
    ^bb0(%arg2: i32):
      %1 = "test.use"(%arg2) : (i32) -> i32
      "scf.yield"(%1, %arg1) : (i32, f64) -> ()
    }) : (i32, f64) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "while_unused_arg2"}> ({
  ^bb0(%arg0: i32):
    %0 = "scf.while"(%arg0) ({
    ^bb0(%arg2: i32):
      %2 = "test.val"() : () -> i32
      %3 = "test.condition"() : () -> i1
      "scf.condition"(%3, %2) : (i1, i32) -> ()
    }, {
    ^bb0(%arg1: i32):
      "test.use"(%arg1) : (i32) -> ()
      %1 = "test.val1"() : () -> i32
      "scf.yield"(%1) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i64, f32, i32), sym_name = "test_align_args"}> ({
    %0 = "test.test"() : () -> f32
    %1 = "test.test"() : () -> i32
    %2 = "test.test"() : () -> i64
    %3:3 = "scf.while"(%0, %1, %2) ({
    ^bb0(%arg3: f32, %arg4: i32, %arg5: i64):
      %7 = "test.test"() : () -> i1
      "scf.condition"(%7, %arg5, %arg3, %arg4) : (i1, i64, f32, i32) -> ()
    }, {
    ^bb0(%arg0: i64, %arg1: f32, %arg2: i32):
      %4 = "test.test"(%arg0) : (i64) -> f32
      %5 = "test.test"(%arg1) : (f32) -> i32
      %6 = "test.test"(%arg2) : (i32) -> i64
      "scf.yield"(%4, %5, %6) : (f32, i32, i64) -> ()
    }) : (f32, i32, i64) -> (i64, f32, i32)
    "func.return"(%3#0, %3#1, %3#2) : (i64, f32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i64) -> (i32, i32), sym_name = "combineIfs"}> ({
  ^bb0(%arg0: i1, %arg1: i64):
    %0 = "scf.if"(%arg0) ({
      %5 = "test.firstCodeTrue"() : () -> i32
      "scf.yield"(%5) : (i32) -> ()
    }, {
      %4 = "test.firstCodeFalse"() : () -> i32
      "scf.yield"(%4) : (i32) -> ()
    }) : (i1) -> i32
    %1 = "scf.if"(%arg0) ({
      %3 = "test.secondCodeTrue"() : () -> i32
      "scf.yield"(%3) : (i32) -> ()
    }, {
      %2 = "test.secondCodeFalse"() : () -> i32
      "scf.yield"(%2) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%0, %1) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i64) -> i32, sym_name = "combineIfs2"}> ({
  ^bb0(%arg0: i1, %arg1: i64):
    "scf.if"(%arg0) ({
      "test.firstCodeTrue"() : () -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    %0 = "scf.if"(%arg0) ({
      %2 = "test.secondCodeTrue"() : () -> i32
      "scf.yield"(%2) : (i32) -> ()
    }, {
      %1 = "test.secondCodeFalse"() : () -> i32
      "scf.yield"(%1) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i64) -> i32, sym_name = "combineIfs3"}> ({
  ^bb0(%arg0: i1, %arg1: i64):
    %0 = "scf.if"(%arg0) ({
      %2 = "test.firstCodeTrue"() : () -> i32
      "scf.yield"(%2) : (i32) -> ()
    }, {
      %1 = "test.firstCodeFalse"() : () -> i32
      "scf.yield"(%1) : (i32) -> ()
    }) : (i1) -> i32
    "scf.if"(%arg0) ({
      "test.secondCodeTrue"() : () -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i64) -> (), sym_name = "combineIfs4"}> ({
  ^bb0(%arg0: i1, %arg1: i64):
    "scf.if"(%arg0) ({
      "test.firstCodeTrue"() : () -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "scf.if"(%arg0) ({
      "test.secondCodeTrue"() : () -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i64) -> (i32, i32), sym_name = "combineIfsUsed"}> ({
  ^bb0(%arg0: i1, %arg1: i64):
    %0 = "scf.if"(%arg0) ({
      %5 = "test.firstCodeTrue"() : () -> i32
      "scf.yield"(%5) : (i32) -> ()
    }, {
      %4 = "test.firstCodeFalse"() : () -> i32
      "scf.yield"(%4) : (i32) -> ()
    }) : (i1) -> i32
    %1 = "scf.if"(%arg0) ({
      %3 = "test.secondCodeTrue"(%0) : (i32) -> i32
      "scf.yield"(%3) : (i32) -> ()
    }, {
      %2 = "test.secondCodeFalse"(%0) : (i32) -> i32
      "scf.yield"(%2) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%0, %1) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i64) -> (), sym_name = "combineIfsNot"}> ({
  ^bb0(%arg0: i1, %arg1: i64):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "arith.xori"(%arg0, %0) : (i1, i1) -> i1
    "scf.if"(%arg0) ({
      "test.firstCodeTrue"() : () -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "scf.if"(%1) ({
      "test.secondCodeTrue"() : () -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i64) -> (), sym_name = "combineIfsNot2"}> ({
  ^bb0(%arg0: i1, %arg1: i64):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "arith.xori"(%arg0, %0) : (i1, i1) -> i1
    "scf.if"(%1) ({
      "test.firstCodeTrue"() : () -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "scf.if"(%arg0) ({
      "test.secondCodeTrue"() : () -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (100)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "propagate_into_execute_region"}> ({
    %0 = "arith.constant"() <{value = false}> : () -> i1
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg0: index):
      "test.foo"() : () -> ()
      %1 = "scf.execute_region"() ({
        "cf.cond_br"(%0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
      ^bb1:  // pred: ^bb0
        %2 = "arith.constant"() <{value = 1 : i64}> : () -> i64
        "cf.br"(%2)[^bb3] : (i64) -> ()
      ^bb2:  // pred: ^bb0
        %3 = "arith.constant"() <{value = 2 : i64}> : () -> i64
        "cf.br"(%3)[^bb3] : (i64) -> ()
      ^bb3(%4: i64):  // 2 preds: ^bb1, ^bb2
        "scf.yield"(%4) : (i64) -> ()
      }) : () -> i64
      "test.bar"(%1) : (i64) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (100)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "execute_region_inline"}> ({
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg0: index):
      "test.foo"() : () -> ()
      %0 = "scf.execute_region"() ({
        %1 = "test.val"() : () -> i64
        "scf.yield"(%1) : (i64) -> ()
      }) : () -> i64
      "test.bar"(%0) : (i64) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (100)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "execute_region_no_inline"}> ({
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg0: index):
      "test.foo"() : () -> ()
      %0 = "scf.execute_region"() <{no_inline}> ({
        %1 = "test.val"() : () -> i64
        "scf.yield"(%1) : (i64) -> ()
      }) : () -> i64
      "test.bar"(%0) : (i64) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "execute_region_under_func_no_inline"}> ({
    "test.foo"() : () -> ()
    %0 = "scf.execute_region"() <{no_inline}> ({
      %1 = "test.val"() : () -> i64
      "scf.yield"(%1) : (i64) -> ()
    }) : () -> i64
    "test.bar"(%0) : (i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "func_execute_region_inline"}> ({
    "test.foo"() : () -> ()
    %0 = "scf.execute_region"() ({
      %1 = "test.cmp"() : () -> i1
      "cf.cond_br"(%1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %2 = "test.val1"() : () -> i64
      "cf.br"(%2)[^bb3] : (i64) -> ()
    ^bb2:  // pred: ^bb0
      %3 = "test.val2"() : () -> i64
      "cf.br"(%3)[^bb3] : (i64) -> ()
    ^bb3(%4: i64):  // 2 preds: ^bb1, ^bb2
      "scf.yield"(%4) : (i64) -> ()
    }) : () -> i64
    "test.bar"(%0) : (i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "func_execute_region_inline_multi_yield"}> ({
    "test.foo"() : () -> ()
    %0 = "scf.execute_region"() ({
      %1 = "test.cmp"() : () -> i1
      "cf.cond_br"(%1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      %2 = "test.val1"() : () -> i64
      "scf.yield"(%2) : (i64) -> ()
    ^bb2:  // pred: ^bb0
      %3 = "test.val2"() : () -> i64
      "scf.yield"(%3) : (i64) -> ()
    }) : () -> i64
    "test.bar"(%0) : (i64) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1x60xui8>, sym_name = "execute_region_yeilding_external_value", sym_visibility = "private"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x60xui8>
    %1 = "scf.execute_region"() <{no_inline}> ({
      "func.call"() <{callee = @foo}> : () -> ()
      "scf.yield"(%0) : (memref<1x60xui8>) -> ()
    }) : () -> memref<1x60xui8>
    "func.return"(%1) : (memref<1x60xui8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (memref<1x60xui8>, memref<1x120xui8>), sym_name = "execute_region_yeilding_external_and_local_values", sym_visibility = "private"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x60xui8>
    %1:2 = "scf.execute_region"() <{no_inline}> ({
      %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x120xui8>
      "func.call"() <{callee = @foo}> : () -> ()
      "scf.yield"(%0, %2) : (memref<1x60xui8>, memref<1x120xui8>) -> ()
    }) : () -> (memref<1x60xui8>, memref<1x120xui8>)
    "func.return"(%1#0, %1#1) : (memref<1x60xui8>, memref<1x120xui8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (memref<1x60xui8>, memref<1x120xui8>), sym_name = "execute_region_multiple_yields_same_operands", sym_visibility = "private"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x60xui8>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x120xui8>
    %2:2 = "scf.execute_region"() <{no_inline}> ({
      %3 = "test.cmp"() : () -> i1
      "cf.cond_br"(%3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "func.call"() <{callee = @foo}> : () -> ()
      "scf.yield"(%0, %1) : (memref<1x60xui8>, memref<1x120xui8>) -> ()
    ^bb2:  // pred: ^bb0
      "func.call"() <{callee = @foo}> : () -> ()
      "scf.yield"(%0, %1) : (memref<1x60xui8>, memref<1x120xui8>) -> ()
    }) : () -> (memref<1x60xui8>, memref<1x120xui8>)
    "func.return"(%2#0, %2#1) : (memref<1x60xui8>, memref<1x120xui8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (memref<1x60xui8>, memref<1x120xui8>), sym_name = "execute_region_multiple_yields_different_operands", sym_visibility = "private"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x60xui8>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x120xui8>
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x120xui8>
    %3:2 = "scf.execute_region"() <{no_inline}> ({
      %4 = "test.cmp"() : () -> i1
      "cf.cond_br"(%4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "func.call"() <{callee = @foo}> : () -> ()
      "scf.yield"(%0, %1) : (memref<1x60xui8>, memref<1x120xui8>) -> ()
    ^bb2:  // pred: ^bb0
      "func.call"() <{callee = @foo}> : () -> ()
      "scf.yield"(%0, %2) : (memref<1x60xui8>, memref<1x120xui8>) -> ()
    }) : () -> (memref<1x60xui8>, memref<1x120xui8>)
    "func.return"(%3#0, %3#1) : (memref<1x60xui8>, memref<1x120xui8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<1x60xui8>, sym_name = "execute_region_multiple_yields_different_operands", sym_visibility = "private"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x60xui8>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x60xui8>
    %2 = "scf.execute_region"() <{no_inline}> ({
      %3 = "test.cmp"() : () -> i1
      "cf.cond_br"(%3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
    ^bb1:  // pred: ^bb0
      "func.call"() <{callee = @foo}> : () -> ()
      "scf.yield"(%0) : (memref<1x60xui8>) -> ()
    ^bb2:  // pred: ^bb0
      "func.call"() <{callee = @foo}> : () -> ()
      "scf.yield"(%1) : (memref<1x60xui8>) -> ()
    }) : () -> memref<1x60xui8>
    "func.return"(%2) : (memref<1x60xui8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x5xf32>, tensor<?x?xf32>, index) -> index, sym_name = "canonicalize_parallel_insert_slice_indices"}> ({
  ^bb0(%arg0: tensor<1x5xf32>, %arg1: tensor<?x?xf32>, %arg2: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "scf.forall"(%arg2, %arg1) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg3: index, %arg4: tensor<?x?xf32>):
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%arg0, %arg4, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 1, 5>, static_strides = array<i64: 1, 1>}> : (tensor<1x5xf32>, tensor<?x?xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<?x?xf32>) -> tensor<?x?xf32>
    %2 = "tensor.dim"(%1, %0) : (tensor<?x?xf32>, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x10xf32>, tensor<?x10xf32>) -> tensor<?x10xf32>, sym_name = "forall_fold_control_operands"}> ({
  ^bb0(%arg0: tensor<?x10xf32>, %arg1: tensor<?x10xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %0) : (tensor<?x10xf32>, index) -> index
    %3 = "tensor.dim"(%arg0, %1) : (tensor<?x10xf32>, index) -> index
    %4 = "scf.forall"(%0, %0, %2, %3, %1, %1, %arg1) <{operandSegmentSizes = array<i32: 2, 2, 2, 1>, staticLowerBound = array<i64: -9223372036854775808, -9223372036854775808>, staticStep = array<i64: -9223372036854775808, -9223372036854775808>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: tensor<?x10xf32>):
      %5 = "tensor.extract_slice"(%arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (tensor<?x10xf32>, index, index) -> tensor<1x1xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%5, %arg4, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (tensor<1x1xf32>, tensor<?x10xf32>, index, index) -> ()
      }) : () -> ()
    }) : (index, index, index, index, index, index, tensor<?x10xf32>) -> tensor<?x10xf32>
    "func.return"(%4) : (tensor<?x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x8xf32>) -> tensor<8x8xf32>, sym_name = "inline_forall_loop"}> ({
  ^bb0(%arg0: tensor<8x8xf32>):
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "tensor.empty"() : () -> tensor<8x8xf32>
    %5 = "scf.forall"(%1, %1, %2, %2, %0, %0, %4) <{operandSegmentSizes = array<i32: 2, 2, 2, 1>, staticLowerBound = array<i64: -9223372036854775808, -9223372036854775808>, staticStep = array<i64: -9223372036854775808, -9223372036854775808>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: tensor<8x8xf32>):
      %6 = "tensor.extract_slice"(%arg3, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 3>, static_strides = array<i64: 1, 1>}> : (tensor<8x8xf32>, index, index) -> tensor<2x3xf32>
      %7 = "linalg.fill"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg4: f32, %arg5: f32):
        "linalg.yield"(%arg4) : (f32) -> ()
      }) : (f32, tensor<2x3xf32>) -> tensor<2x3xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%7, %arg3, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 3>, static_strides = array<i64: 1, 1>}> : (tensor<2x3xf32>, tensor<8x8xf32>, index, index) -> ()
      }) : () -> ()
    }) : (index, index, index, index, index, index, tensor<8x8xf32>) -> tensor<8x8xf32>
    "func.return"(%5) : (tensor<8x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x8xf32>) -> tensor<8x8xf32>, sym_name = "do_not_inline_distributed_forall_loop"}> ({
  ^bb0(%arg0: tensor<8x8xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<8x8xf32>
    %2 = "scf.forall"(%1) <{mapping = [#gpu.thread<y>, #gpu.thread<x>], operandSegmentSizes = array<i32: 0, 0, 0, 1>, staticLowerBound = array<i64: 0, 4>, staticStep = array<i64: 8, 8>, staticUpperBound = array<i64: 1, 5>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: tensor<8x8xf32>):
      %3 = "tensor.extract_slice"(%arg3, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 3>, static_strides = array<i64: 1, 1>}> : (tensor<8x8xf32>, index, index) -> tensor<2x3xf32>
      %4 = "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg4: f32, %arg5: f32):
        "linalg.yield"(%arg4) : (f32) -> ()
      }) : (f32, tensor<2x3xf32>) -> tensor<2x3xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%4, %arg3, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 2, 3>, static_strides = array<i64: 1, 1>}> : (tensor<2x3xf32>, tensor<8x8xf32>, index, index) -> ()
      }) : () -> ()
    }) : (tensor<8x8xf32>) -> tensor<8x8xf32>
    "func.return"(%2) : (tensor<8x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<16xf32>) -> tensor<16xf32>, sym_name = "inline_empty_loop_with_empty_mapping"}> ({
  ^bb0(%arg0: tensor<16xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "tensor.empty"() : () -> tensor<16xf32>
    %2 = "scf.forall"(%1) <{mapping = [], operandSegmentSizes = array<i32: 0, 0, 0, 1>, staticLowerBound = array<i64>, staticStep = array<i64>, staticUpperBound = array<i64>}> ({
    ^bb0(%arg1: tensor<16xf32>):
      %3 = "tensor.extract_slice"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 16>, static_strides = array<i64: 1>}> : (tensor<16xf32>) -> tensor<16xf32>
      %4 = "linalg.generic"(%3, %1) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg2: f32, %arg3: f32):
        %5 = "arith.addf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%5) : (f32) -> ()
      }) : (tensor<16xf32>, tensor<16xf32>) -> tensor<16xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%4, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 16>, static_strides = array<i64: 1>}> : (tensor<16xf32>, tensor<16xf32>) -> ()
      }) : () -> ()
    }) : (tensor<16xf32>) -> tensor<16xf32>
    "func.return"(%2) : (tensor<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x8xf32>) -> tensor<8x8xf32>, sym_name = "collapse_one_dim_parallel"}> ({
  ^bb0(%arg0: tensor<8x8xf32>):
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "tensor.empty"() : () -> tensor<8x8xf32>
    %6 = "scf.forall"(%1, %3, %0, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>, staticLowerBound = array<i64: 0, -9223372036854775808>, staticStep = array<i64: 8, -9223372036854775808>, staticUpperBound = array<i64: 1, -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: tensor<8x8xf32>):
      %7 = "linalg.fill"(%4, %arg3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg4: f32, %arg5: f32):
        "linalg.yield"(%arg4) : (f32) -> ()
      }) : (f32, tensor<8x8xf32>) -> tensor<8x8xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%7, %arg3, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 8, 8>, static_strides = array<i64: 1, 1>}> : (tensor<8x8xf32>, tensor<8x8xf32>, index, index) -> ()
      }) : () -> ()
    }) : (index, index, index, tensor<8x8xf32>) -> tensor<8x8xf32>
    "func.return"(%6) : (tensor<8x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x8xf32>) -> tensor<8x8xf32>, sym_name = "remove_empty_forall"}> ({
  ^bb0(%arg0: tensor<8x8xf32>):
    %0 = "arith.constant"() <{value = 8 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "tensor.empty"() : () -> tensor<8x8xf32>
    %6 = "scf.forall"(%1, %3, %2, %3, %0, %0, %5) <{operandSegmentSizes = array<i32: 2, 2, 2, 1>, staticLowerBound = array<i64: -9223372036854775808, -9223372036854775808>, staticStep = array<i64: -9223372036854775808, -9223372036854775808>, staticUpperBound = array<i64: -9223372036854775808, -9223372036854775808>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: tensor<8x8xf32>):
      %7 = "linalg.fill"(%4, %arg3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg4: f32, %arg5: f32):
        "linalg.yield"(%arg4) : (f32) -> ()
      }) : (f32, tensor<8x8xf32>) -> tensor<8x8xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%7, %arg3, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 8, 8>, static_strides = array<i64: 1, 1>}> : (tensor<8x8xf32>, tensor<8x8xf32>, index, index) -> ()
      }) : () -> ()
    }) : (index, index, index, index, index, index, tensor<8x8xf32>) -> tensor<8x8xf32>
    "func.return"(%6) : (tensor<8x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi32>, tensor<2xi32>) -> tensor<2xi32>, sym_name = "fold_tensor_cast_into_forall"}> ({
  ^bb0(%arg0: tensor<2xi32>, %arg1: tensor<2xi32>):
    %0 = "arith.constant"() <{value = dense<100500> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tensor.cast"(%arg1) : (tensor<2xi32>) -> tensor<?xi32>
    %2 = "scf.forall"(%1) <{operandSegmentSizes = array<i32: 0, 0, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: 2>}> ({
    ^bb0(%arg2: index, %arg3: tensor<?xi32>):
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%0, %arg3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xi32>, tensor<?xi32>, index) -> ()
      }) : () -> ()
    }) : (tensor<?xi32>) -> tensor<?xi32>
    %3 = "tensor.cast"(%2) : (tensor<?xi32>) -> tensor<2xi32>
    "func.return"(%3) : (tensor<2xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xi32>, tensor<?xi32>) -> tensor<?xi32>, sym_name = "do_not_fold_tensor_cast_from_dynamic_to_static_type_into_forall"}> ({
  ^bb0(%arg0: tensor<?xi32>, %arg1: tensor<?xi32>):
    %0 = "arith.constant"() <{value = dense<100500> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tensor.cast"(%arg1) : (tensor<?xi32>) -> tensor<2xi32>
    %2 = "scf.forall"(%1) <{operandSegmentSizes = array<i32: 0, 0, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: 2>}> ({
    ^bb0(%arg2: index, %arg3: tensor<2xi32>):
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%0, %arg3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xi32>, tensor<2xi32>, index) -> ()
      }) : () -> ()
    }) : (tensor<2xi32>) -> tensor<2xi32>
    %3 = "tensor.cast"(%2) : (tensor<2xi32>) -> tensor<?xi32>
    "func.return"(%3) : (tensor<?xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 ceildiv s1)>
#map1 = affine_map<(d0)[s0] -> (d0 * s0)>
#map2 = affine_map<(d0)[s0, s1] -> (-(d0 * s1) + s0, s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>), sym_name = "fold_iter_args_not_being_modified_within_scfforall"}> ({
  ^bb0(%arg0: index, %arg1: tensor<?xf32>, %arg2: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %arg1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %3 = "tensor.dim"(%arg1, %0) : (tensor<?xf32>, index) -> index
    %4 = "affine.apply"(%3, %arg0) <{map = #map}> : (index, index) -> index
    %5:2 = "scf.forall"(%4, %arg1, %arg2) <{operandSegmentSizes = array<i32: 0, 1, 0, 2>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg3: index, %arg4: tensor<?xf32>, %arg5: tensor<?xf32>):
      %6 = "affine.apply"(%arg3, %arg0) <{map = #map1}> : (index, index) -> index
      %7 = "affine.min"(%arg3, %3, %arg0) <{map = #map2}> : (index, index, index) -> index
      %8 = "tensor.extract_slice"(%arg4, %6, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      %9 = "tensor.extract_slice"(%arg5, %6, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      %10 = "linalg.exp"(%8, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg6: f32, %arg7: f32):
        %11 = "math.exp"(%arg6) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%11) : (f32) -> ()
      }) : (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%10, %arg5, %6, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> ()
      }) : () -> ()
    }) : (index, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>)
    "func.return"(%5#0, %5#1) : (tensor<?xf32>, tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 ceildiv s1)>
#map1 = affine_map<(d0)[s0] -> (d0 * s0)>
#map2 = affine_map<(d0)[s0, s1] -> (-(d0 * s1) + s0, s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>, sym_name = "fold_iter_args_with_no_use_of_result_scfforall"}> ({
  ^bb0(%arg0: index, %arg1: tensor<?xf32>, %arg2: tensor<?xf32>, %arg3: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "linalg.fill"(%0, %arg1) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg10: f32, %arg11: f32):
      "linalg.yield"(%arg10) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %3 = "tensor.dim"(%arg1, %1) : (tensor<?xf32>, index) -> index
    %4 = "affine.apply"(%3, %arg0) <{map = #map}> : (index, index) -> index
    %5:3 = "scf.forall"(%4, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 0, 1, 0, 3>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg4: index, %arg5: tensor<?xf32>, %arg6: tensor<?xf32>, %arg7: tensor<?xf32>):
      %6 = "affine.apply"(%arg4, %arg0) <{map = #map1}> : (index, index) -> index
      %7 = "affine.min"(%arg4, %3, %arg0) <{map = #map2}> : (index, index, index) -> index
      %8 = "tensor.extract_slice"(%arg5, %6, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      %9 = "tensor.extract_slice"(%arg6, %6, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      %10 = "tensor.extract_slice"(%arg7, %6, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      %11 = "tensor.extract_slice"(%2, %6, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index, index) -> tensor<?xf32>
      %12 = "linalg.exp"(%8, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg8: f32, %arg9: f32):
        %13 = "math.exp"(%arg8) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
        "linalg.yield"(%13) : (f32) -> ()
      }) : (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%12, %arg6, %6, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> ()
        "tensor.parallel_insert_slice"(%8, %arg5, %6, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> ()
        "tensor.parallel_insert_slice"(%9, %arg7, %6, %7) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> ()
        "tensor.parallel_insert_slice"(%12, %arg7, %7, %6) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808>, static_strides = array<i64: 1>}> : (tensor<?xf32>, tensor<?xf32>, index, index) -> ()
      }) : () -> ()
    }) : (index, tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) -> (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>)
    "func.return"(%5#1) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (f32, f32), sym_name = "index_switch_fold"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "scf.index_switch"(%0) <{cases = array<i64: 1>}> ({
      %7 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      "scf.yield"(%7) : (f32) -> ()
    }, {
      %6 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      "scf.yield"(%6) : (f32) -> ()
    }) : (index) -> f32
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "scf.index_switch"(%2) <{cases = array<i64: 0>}> ({
      %5 = "arith.constant"() <{value = 4.200000e+01 : f32}> : () -> f32
      "scf.yield"(%5) : (f32) -> ()
    }, {
      %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      "scf.yield"(%4) : (f32) -> ()
    }) : (index) -> f32
    "func.return"(%1, %3) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "index_switch_fold_no_res"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.index_switch"(%0) <{cases = array<i64: 0>}> ({
      "test.op"() : () -> ()
      "scf.yield"() : () -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "scf_for_all_step_size_0"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "scf.forall"(%0) <{operandSegmentSizes = array<i32: 0, 0, 1, 0>, staticLowerBound = array<i64: 0, 4>, staticStep = array<i64: -9223372036854775808, 8>, staticUpperBound = array<i64: 1, 5>}> ({
    ^bb0(%arg0: index, %arg1: index):
      "vector.print"(%0) <{punctuation = #vector.punctuation<newline>}> : (index) -> ()
      "scf.forall.in_parallel"() ({
      ^bb0:
      }) : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<i32>) -> index, sym_name = "dead_index_switch_result"}> ({
  ^bb0(%arg0: index, %arg1: memref<i32>):
    %0:2 = "scf.index_switch"(%arg0) <{cases = array<i64: 1>}> ({
      %2 = "arith.constant"() <{value = 11 : i32}> : () -> i32
      "memref.store"(%2, %arg1) : (i32, memref<i32>) -> ()
      "scf.yield"(%2, %arg0) : (i32, index) -> ()
    }, {
      %1 = "arith.constant"() <{value = 10 : i32}> : () -> i32
      "memref.store"(%1, %arg1) : (i32, memref<i32>) -> ()
      "scf.yield"(%1, %arg0) : (i32, index) -> ()
    }) : (index) -> (i32, index)
    "func.return"(%0#1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "side_effect", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, i32, i64, f32) -> (i32, i64, i32, i64, i64, f32), sym_name = "iter_args_cycles"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: i32, %arg4: i64, %arg5: f32):
    %0:6 = "scf.for"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg3, %arg4, %arg4, %arg5) ({
    ^bb0(%arg6: index, %arg7: i32, %arg8: i64, %arg9: i32, %arg10: i64, %arg11: i64, %arg12: f32):
      "func.call"() <{callee = @side_effect}> : () -> ()
      "scf.yield"(%arg9, %arg11, %arg7, %arg8, %arg10, %arg12) : (i32, i64, i32, i64, i64, f32) -> ()
    }) : (index, index, index, i32, i64, i32, i64, i64, f32) -> (i32, i64, i32, i64, i64, f32)
    "func.return"(%0#0, %0#1, %0#2, %0#3, %0#4, %0#5) : (i32, i64, i32, i64, i64, f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "side_effect", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, i32, i32) -> (i32, i32, i32), sym_name = "iter_args_cycles_non_cycle_start"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: i32, %arg4: i32):
    %0:3 = "scf.for"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg4) ({
    ^bb0(%arg5: index, %arg6: i32, %arg7: i32, %arg8: i32):
      "func.call"(%arg6) <{callee = @side_effect}> : (i32) -> ()
      "scf.yield"(%arg7, %arg8, %arg7) : (i32, i32, i32) -> ()
    }) : (index, index, index, i32, i32, i32) -> (i32, i32, i32)
    "func.return"(%0#0, %0#1, %0#2) : (i32, i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

