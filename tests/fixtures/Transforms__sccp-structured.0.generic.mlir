"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "simple"}> ({
  ^bb0(%arg21: i32):
    %22 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %23 = "arith.constant"() <{value = true}> : () -> i1
    "func.return"(%22) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "simple_both_same"}> ({
  ^bb0(%arg20: i1):
    %21 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%21) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, i32) -> i32, sym_name = "overdefined_unknown_condition"}> ({
  ^bb0(%arg18: i1, %arg19: i32):
    %19 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %20 = "scf.if"(%arg18) ({
      "scf.yield"(%19) : (i32) -> ()
    }, {
      "scf.yield"(%arg19) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%20) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1) -> i32, sym_name = "overdefined_different_constants"}> ({
  ^bb0(%arg17: i1):
    %16 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %17 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    %18 = "scf.if"(%arg17) ({
      "scf.yield"(%16) : (i32) -> ()
    }, {
      "scf.yield"(%17) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%18) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "simple_loop"}> ({
  ^bb0(%arg14: index, %arg15: index, %arg16: index):
    %15 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%15) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "loop_overdefined"}> ({
  ^bb0(%arg9: index, %arg10: index, %arg11: index):
    %12 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %13 = "scf.for"(%arg9, %arg10, %arg11, %12) ({
    ^bb0(%arg12: index, %arg13: i32):
      %14 = "arith.addi"(%arg13, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%14) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%13) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "loop_inner_control_flow"}> ({
  ^bb0(%arg6: index, %arg7: index, %arg8: index):
    %11 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%11) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "loop_region_branch_terminator_op"}> ({
  ^bb0(%arg5: i32):
    %10 = "arith.constant"() <{value = 2 : i32}> : () -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "affine_loop_one_iter"}> ({
    %8 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%8) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "affine_loop_zero_iter"}> ({
    %7 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "func.return"(%7) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> i32, sym_name = "affine_loop_unknown_trip_count"}> ({
  ^bb0(%arg4: index):
    %6 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "func.return"(%6) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "while_loop_different_arg_count"}> ({
    %2 = "arith.constant"() <{value = true}> : () -> i1
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "scf.while"(%4, %3) ({
    ^bb0(%arg2: index, %arg3: index):
      "scf.condition"(%2, %3) : (i1, index) -> ()
    }, {
    ^bb0(%arg1: index):
      "scf.yield"(%4, %3) : (index, index) -> ()
    }) : (index, index) -> index
    "func.return"(%5) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> index, sym_name = "while_loop_false_condition"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

