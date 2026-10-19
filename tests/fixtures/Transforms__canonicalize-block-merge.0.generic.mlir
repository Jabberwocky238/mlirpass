"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "return_blocks"}> ({
    "foo.cond_br"()[^bb1, ^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb0
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "matching_arguments"}> ({
    "foo.cond_br"()[^bb1, ^bb1] : () -> ()
  ^bb1(%23: i32):  // 2 preds: ^bb0, ^bb0
    "func.return"(%23) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "mismatch_unknown_terminator"}> ({
  ^bb0(%arg32: i32, %arg33: i32):
    "foo.cond_br"()[^bb1, ^bb2] : () -> ()
  ^bb1:  // pred: ^bb0
    "func.return"(%arg32) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "func.return"(%arg33) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32, i32) -> i32, sym_name = "mismatch_operands"}> ({
  ^bb0(%arg29: i1, %arg30: i32, %arg31: i32):
    %22 = "arith.select"(%arg29, %arg30, %arg31) : (i1, i32, i32) -> i32
    "func.return"(%22) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32, i32) -> (i32, i32), sym_name = "mismatch_operands_matching_arguments"}> ({
  ^bb0(%arg26: i1, %arg27: i32, %arg28: i32):
    %20 = "arith.select"(%arg26, %arg28, %arg27) : (i1, i32, i32) -> i32
    %21 = "arith.select"(%arg26, %arg27, %arg28) : (i1, i32, i32) -> i32
    "func.return"(%21, %20) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32, i32) -> (i32, i32), sym_name = "mismatch_argument_uses"}> ({
  ^bb0(%arg23: i1, %arg24: i32, %arg25: i32):
    "func.return"(%arg24, %arg25) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32, i16) -> (), sym_name = "mismatch_argument_types"}> ({
  ^bb0(%arg20: i1, %arg21: i32, %arg22: i16):
    "cf.cond_br"(%arg20)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "foo.return"(%arg21) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "foo.return"(%arg22) : (i16) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32) -> (), sym_name = "mismatch_argument_count"}> ({
  ^bb0(%arg18: i1, %arg19: i32):
    "cf.cond_br"(%arg18)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "foo.return"(%arg19) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "foo.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "mismatch_operations"}> ({
  ^bb0(%arg17: i1):
    "cf.cond_br"(%arg17)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "foo.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "mismatch_operation_count"}> ({
  ^bb0(%arg16: i1):
    "cf.cond_br"(%arg16)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "foo.op"() : () -> ()
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "contains_regions"}> ({
  ^bb0(%arg15: i1):
    "cf.cond_br"(%arg15)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "foo.op"() : () -> ()
    "func.return"() : () -> ()
  ^bb2:  // pred: ^bb0
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i1) -> (), sym_name = "mismatch_loop"}> ({
  ^bb0(%arg13: i1, %arg14: i1):
    %18 = "foo.op"() : () -> i1
    "cf.cond_br"(%arg13, %arg14)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i1) -> ()
  ^bb1(%19: i1):  // 2 preds: ^bb0, ^bb1
    "cf.cond_br"(%19, %18)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (i1, i1) -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, memref<i32>, memref<i1>) -> (), sym_name = "mismatch_operand_types"}> ({
  ^bb0(%arg10: i1, %arg11: memref<i32>, %arg12: memref<i1>):
    %16 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %17 = "arith.constant"() <{value = true}> : () -> i1
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 3 preds: ^bb0, ^bb2, ^bb3
    "cf.cond_br"(%arg10)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "memref.store"(%16, %arg11) : (i32, memref<i32>) -> ()
    "cf.br"()[^bb1] : () -> ()
  ^bb3:  // pred: ^bb1
    "memref.store"(%17, %arg12) : (i1, memref<i1>) -> ()
    "cf.br"()[^bb1] : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "print", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> (), sym_name = "nomerge"}> ({
  ^bb0(%arg8: i32, %arg9: i32):
    %10 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %11 = "arith.cmpi"(%arg9, %arg8) <{predicate = 2 : i64}> : (i32, i32) -> i1
    "cf.cond_br"(%11)[^bb1, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %12 = "arith.addi"(%arg9, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "cf.br"(%12)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb3
    %13 = "arith.addi"(%14, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "cf.br"(%13)[^bb3] : (i32) -> ()
  ^bb3(%14: i32):  // 2 preds: ^bb1, ^bb2
    %15 = "arith.cmpi"(%14, %arg8) <{predicate = 2 : i64}> : (i32, i32) -> i1
    "func.call"(%14, %12) <{callee = @print}> : (i32, i32) -> ()
    "cf.cond_br"(%15)[^bb2, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // 2 preds: ^bb0, ^bb3
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "mismatch_dominance"}> ({
    %7 = "test.producing_br"()[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 0, 0>}> : () -> i32
  ^bb1:  // pred: ^bb0
    "test.br"(%7)[^bb4] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %8 = "foo.def"() : () -> i32
    "test.br"()[^bb3] : () -> ()
  ^bb3:  // pred: ^bb2
    "test.br"(%8)[^bb4] : (i32) -> ()
  ^bb4(%9: i32):  // 2 preds: ^bb1, ^bb3
    "func.return"(%9) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> (), sym_name = "dead_dealloc_fold_multi_use"}> ({
  ^bb0(%arg7: i1):
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i32, i32, i32, i1) -> (), sym_name = "nested_loop"}> ({
  ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i1):
    "test.foo_br"(%arg1, %arg5)[^bb2] : (i32, i32) -> ()
  ^bb1:  // 2 preds: ^bb2, ^bb3
    "test.foo_br2"(%3)[^bb4, ^bb2, ^bb3] : (i32) -> ()
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = "test.bar"(%3) : (i32) -> i32
    "cf.br"()[^bb1] : () -> ()
  ^bb3(%5: i32):  // pred: ^bb1
    %6 = "test.bar"(%5) : (i32) -> i32
    "cf.br"()[^bb1] : () -> ()
  ^bb4:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "produced_operand_not_dropped"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    "test.internal_br"()[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 0, 0>}> : () -> ()
  ^bb1:  // pred: ^bb0
    "test.terminator"() : () -> ()
  ^bb2(%1: i32):  // pred: ^bb0
    %2 = "arith.addi"(%1, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

