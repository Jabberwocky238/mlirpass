"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "test_simple_sink"}> ({
  ^bb0(%arg27: i32, %arg28: i32, %arg29: i32):
    %22 = "arith.subi"(%arg29, %arg28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %23 = "test.region_if"(%arg27) ({
    ^bb0(%arg32: i32):
      %28 = "arith.subi"(%arg28, %arg29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "test.region_if_yield"(%28) : (i32) -> ()
    }, {
    ^bb0(%arg31: i32):
      %26 = "arith.addi"(%arg28, %arg28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %27 = "arith.addi"(%22, %26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "test.region_if_yield"(%27) : (i32) -> ()
    }, {
    ^bb0(%arg30: i32):
      %24 = "arith.addi"(%arg29, %arg29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %25 = "arith.addi"(%24, %22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "test.region_if_yield"(%25) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%23) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "test_region_sink"}> ({
  ^bb0(%arg18: i32, %arg19: i32, %arg20: i32):
    %19 = "test.region_if"(%arg18) ({
    ^bb0(%arg23: i32):
      %20 = "test.region_if"(%arg18) ({
      ^bb0(%arg26: i32):
        "test.region_if_yield"(%arg19) : (i32) -> ()
      }, {
      ^bb0(%arg25: i32):
        %21 = "arith.subi"(%arg19, %arg20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "test.region_if_yield"(%21) : (i32) -> ()
      }, {
      ^bb0(%arg24: i32):
        "test.region_if_yield"(%arg20) : (i32) -> ()
      }) : (i32) -> i32
      "test.region_if_yield"(%20) : (i32) -> ()
    }, {
    ^bb0(%arg22: i32):
      "test.region_if_yield"(%arg19) : (i32) -> ()
    }, {
    ^bb0(%arg21: i32):
      "test.region_if_yield"(%arg20) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%19) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "test_subgraph_sink"}> ({
  ^bb0(%arg12: i32, %arg13: i32, %arg14: i32):
    %12 = "test.region_if"(%arg12) ({
    ^bb0(%arg17: i32):
      %13 = "arith.subi"(%arg13, %arg14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %14 = "arith.addi"(%arg13, %arg14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %15 = "arith.subi"(%arg14, %arg13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %16 = "arith.muli"(%15, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %17 = "arith.muli"(%14, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %18 = "arith.addi"(%17, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "test.region_if_yield"(%18) : (i32) -> ()
    }, {
    ^bb0(%arg16: i32):
      "test.region_if_yield"(%arg13) : (i32) -> ()
    }, {
    ^bb0(%arg15: i32):
      "test.region_if_yield"(%arg14) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%12) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i32) -> i32, sym_name = "test_multiblock_region_sink"}> ({
  ^bb0(%arg9: i32, %arg10: i32, %arg11: i32):
    %5 = "arith.addi"(%arg10, %arg11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    %6 = "test.any_cond"() ({
      %8 = "arith.addi"(%5, %arg11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %9 = "arith.addi"(%8, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "cf.br"(%9)[^bb1] : (i32) -> ()
    ^bb1(%10: i32):  // pred: ^bb0
      %11 = "arith.addi"(%10, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "test.yield"(%11) : (i32) -> ()
    }) : () -> i32
    %7 = "arith.addi"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "func.return"(%7) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "test_nested_region_sink"}> ({
  ^bb0(%arg1: i32, %arg2: i32):
    %2 = "test.region_if"(%arg1) ({
    ^bb0(%arg5: i32):
      %3 = "test.region_if"(%arg1) ({
      ^bb0(%arg8: i32):
        %4 = "arith.addi"(%arg2, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "test.region_if_yield"(%4) : (i32) -> ()
      }, {
      ^bb0(%arg7: i32):
        "test.region_if_yield"(%arg2) : (i32) -> ()
      }, {
      ^bb0(%arg6: i32):
        "test.region_if_yield"(%arg2) : (i32) -> ()
      }) : (i32) -> i32
      "test.region_if_yield"(%3) : (i32) -> ()
    }, {
    ^bb0(%arg4: i32):
      "test.region_if_yield"(%arg2) : (i32) -> ()
    }, {
    ^bb0(%arg3: i32):
      "test.region_if_yield"(%arg2) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "test_not_sunk_deeply"}> ({
  ^bb0(%arg0: i32):
    %0 = "test.any_cond"() ({
      %1 = "arith.addi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "cf.br"()[^bb1] : () -> ()
    ^bb1:  // pred: ^bb0
      "test.yield"(%1) : (i32) -> ()
    }) : () -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

