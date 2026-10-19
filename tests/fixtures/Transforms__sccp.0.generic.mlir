"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "no_control_flow"}> ({
  ^bb0(%arg13: i32):
    %41 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %42 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%41) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "simple_control_flow"}> ({
  ^bb0(%arg12: i32):
    %38 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %39 = "arith.constant"() <{value = true}> : () -> i1
    "cf.cond_br"(%39, %arg12)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%38)[^bb2] : (i32) -> ()
  ^bb2(%40: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%38) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "simple_control_flow_overdefined"}> ({
  ^bb0(%arg10: i32, %arg11: i1):
    %36 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.cond_br"(%arg11, %arg10)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%36)[^bb2] : (i32) -> ()
  ^bb2(%37: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%37) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "simple_control_flow_constant_overdefined"}> ({
  ^bb0(%arg8: i32, %arg9: i1):
    %33 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %34 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.cond_br"(%arg9, %arg8)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%33)[^bb2] : (i32) -> ()
  ^bb2(%35: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%35) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "unknown_terminator"}> ({
  ^bb0(%arg6: i32, %arg7: i1):
    %31 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "foo.cond_br"()[^bb1, ^bb2] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%31)[^bb2] : (i32) -> ()
  ^bb2(%32: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%32) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "ext_cond_fn", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "simple_loop"}> ({
  ^bb0(%arg4: i32, %arg5: i1):
    %26 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %27 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.cond_br"(%arg5, %27, %27)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i32, i32) -> ()
  ^bb1(%28: i32):  // 2 preds: ^bb0, ^bb1
    %29 = "func.call"() <{callee = @ext_cond_fn}> : () -> i1
    "cf.cond_br"(%29, %27, %27)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i32, i32) -> ()
  ^bb2(%30: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%27) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "simple_loop_inner_control_flow"}> ({
  ^bb0(%arg3: i32):
    %19 = "arith.constant"() <{value = true}> : () -> i1
    %20 = "arith.constant"() <{value = 20 : i32}> : () -> i32
    %21 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.br"(%21)[^bb1] : (i32) -> ()
  ^bb1(%22: i32):  // 3 preds: ^bb0, ^bb3, ^bb4
    %23 = "func.call"() <{callee = @ext_cond_fn}> : () -> i1
    "cf.cond_br"(%23, %21)[^bb5, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
  ^bb2:  // pred: ^bb1
    "cf.cond_br"(%19)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "cf.br"(%21)[^bb1] : (i32) -> ()
  ^bb4:  // pred: ^bb2
    %24 = "arith.addi"(%21, %21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "cf.br"(%24)[^bb1] : (i32) -> ()
  ^bb5(%25: i32):  // pred: ^bb1
    "func.return"(%21) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, i32), sym_name = "ext_cond_and_value_fn", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "simple_loop_overdefined"}> ({
  ^bb0(%arg1: i32, %arg2: i1):
    %15 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.cond_br"(%arg2, %15, %15)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i32, i32) -> ()
  ^bb1(%16: i32):  // 2 preds: ^bb0, ^bb1
    %17:2 = "func.call"() <{callee = @ext_cond_and_value_fn}> : () -> (i1, i32)
    "cf.cond_br"(%17#0, %17#1, %17#1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i32, i32) -> ()
  ^bb2(%18: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%18) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (i1, i1), sym_name = "recheck_executable_edge"}> ({
  ^bb0(%arg0: i1):
    %11 = "arith.constant"() <{value = false}> : () -> i1
    %12 = "arith.constant"() <{value = true}> : () -> i1
    "cf.cond_br"(%arg0, %11)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i1) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%12)[^bb2] : (i1) -> ()
  ^bb2(%13: i1):  // 2 preds: ^bb0, ^bb1
    "cf.br"(%13)[^bb3] : (i1) -> ()
  ^bb3(%14: i1):  // pred: ^bb2
    "func.return"(%13, %14) : (i1, i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "simple_produced_operand"}> ({
    %8 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "test.internal_br"(%8)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 0, 1>}> : (i32) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%8, %8)[^bb2] : (i32, i32) -> ()
  ^bb2(%9: i32, %10: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%9, %8) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inplace_fold"}> ({
    %5 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %6 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %7 = "test.op_in_place_fold_success"() : () -> i1
    "cf.cond_br"(%7)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%5) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "op_with_region"}> ({
    %2 = "arith.constant"() <{value = 10 : i32}> : () -> i32
    %3 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %4 = "test.op_with_region"() ({
    }) : () -> i1
    "cf.cond_br"(%4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%2) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_crash_with_different_source_type"}> ({
    %0 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %1 = "vector.broadcast"(%0) : (i64) -> vector<128xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

