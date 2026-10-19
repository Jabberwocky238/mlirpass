"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "no_control_flow"}> ({
  ^bb0(%arg13: i32):
    %43 = "arith.constant"() <{value = true}> : () -> i1
    %44 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %45 = "arith.select"(%43, %44, %arg13) : (i1, i32, i32) -> i32
    "func.return"(%45) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "simple_control_flow"}> ({
  ^bb0(%arg12: i32):
    %40 = "arith.constant"() <{value = true}> : () -> i1
    %41 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.cond_br"(%40, %arg12)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%41)[^bb2] : (i32) -> ()
  ^bb2(%42: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%42) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "simple_control_flow_overdefined"}> ({
  ^bb0(%arg10: i32, %arg11: i1):
    %38 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.cond_br"(%arg11, %arg10)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%38)[^bb2] : (i32) -> ()
  ^bb2(%39: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%39) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "simple_control_flow_constant_overdefined"}> ({
  ^bb0(%arg8: i32, %arg9: i1):
    %35 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %36 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    "cf.cond_br"(%arg9, %arg8)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%36)[^bb2] : (i32) -> ()
  ^bb2(%37: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%37) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "unknown_terminator"}> ({
  ^bb0(%arg6: i32, %arg7: i1):
    %33 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "foo.cond_br"()[^bb1, ^bb2] : () -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%33)[^bb2] : (i32) -> ()
  ^bb2(%34: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%34) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i1, sym_name = "ext_cond_fn", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "simple_loop"}> ({
  ^bb0(%arg4: i32, %arg5: i1):
    %27 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.cond_br"(%arg5, %27, %27)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i32, i32) -> ()
  ^bb1(%28: i32):  // 2 preds: ^bb0, ^bb1
    %29 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %30 = "arith.addi"(%28, %29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %31 = "func.call"() <{callee = @ext_cond_fn}> : () -> i1
    "cf.cond_br"(%31, %30, %30)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, i32, i32) -> ()
  ^bb2(%32: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%32) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "simple_loop_inner_control_flow"}> ({
  ^bb0(%arg3: i32):
    %19 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.br"(%19)[^bb1] : (i32) -> ()
  ^bb1(%20: i32):  // 3 preds: ^bb0, ^bb3, ^bb4
    %21 = "func.call"() <{callee = @ext_cond_fn}> : () -> i1
    "cf.cond_br"(%21, %20)[^bb5, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i32) -> ()
  ^bb2:  // pred: ^bb1
    %22 = "arith.constant"() <{value = 20 : i32}> : () -> i32
    %23 = "arith.cmpi"(%20, %22) <{predicate = 6 : i64}> : (i32, i32) -> i1
    "cf.cond_br"(%23)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb3:  // pred: ^bb2
    %24 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.br"(%24)[^bb1] : (i32) -> ()
  ^bb4:  // pred: ^bb2
    %25 = "arith.addi"(%20, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "cf.br"(%25)[^bb1] : (i32) -> ()
  ^bb5(%26: i32):  // pred: ^bb1
    "func.return"(%26) : (i32) -> ()
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
    %11 = "arith.constant"() <{value = true}> : () -> i1
    %12 = "arith.constant"() <{value = false}> : () -> i1
    "cf.cond_br"(%arg0, %12)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i1) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%11)[^bb2] : (i1) -> ()
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
    "func.return"(%9, %10) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "inplace_fold"}> ({
    %5 = "test.op_in_place_fold_success"() : () -> i1
    %6 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "cf.cond_br"(%5)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %7 = "arith.addi"(%6, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%7) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "op_with_region"}> ({
    %2 = "test.op_with_region"() ({
    }) : () -> i1
    %3 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "cf.cond_br"(%2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %4 = "arith.addi"(%3, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%4) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "no_crash_with_different_source_type"}> ({
    %0 = "llvm.mlir.constant"() <{value = 0 : index}> : () -> i64
    %1 = "vector.broadcast"(%0) : (i64) -> vector<128xi64>
    "llvm.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

