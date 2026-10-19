"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "simple_std_for_loop"}> ({
  ^bb0(%arg28: index, %arg29: index, %arg30: index):
    "scf.for"(%arg28, %arg29, %arg30) ({
    ^bb0(%arg31: index):
      %15 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "simple_std_2_for_loops"}> ({
  ^bb0(%arg23: index, %arg24: index, %arg25: index):
    "scf.for"(%arg23, %arg24, %arg25) ({
    ^bb0(%arg26: index):
      %13 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.for"(%arg23, %arg24, %arg25) ({
      ^bb0(%arg27: index):
        %14 = "arith.constant"() <{value = 1 : index}> : () -> index
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (f32, f32), sym_name = "for_yield"}> ({
  ^bb0(%arg17: index, %arg18: index, %arg19: index):
    %9 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %10 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %11:2 = "scf.for"(%arg17, %arg18, %arg19, %9, %10) ({
    ^bb0(%arg20: index, %arg21: f32, %arg22: f32):
      %12 = "arith.addf"(%arg21, %arg22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "scf.yield"(%12, %12) : (f32, f32) -> ()
    }) : (index, index, index, f32, f32) -> (f32, f32)
    "func.return"(%11#0, %11#1) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> f32, sym_name = "nested_for_yield"}> ({
  ^bb0(%arg10: index, %arg11: index, %arg12: index):
    %5 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %6 = "scf.for"(%arg10, %arg11, %arg12, %5) ({
    ^bb0(%arg13: index, %arg14: f32):
      %7 = "scf.for"(%arg10, %arg11, %arg12, %arg14) ({
      ^bb0(%arg15: index, %arg16: f32):
        %8 = "arith.addf"(%arg16, %arg16) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "scf.yield"(%8) : (f32) -> ()
      }) : (index, index, index, f32) -> f32
      "scf.yield"(%7) : (f32) -> ()
    }) : (index, index, index, f32) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "for_yield_index"}> ({
  ^bb0(%arg5: index, %arg6: index, %arg7: index):
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "scf.for"(%arg5, %arg6, %arg7, %3) ({
    ^bb0(%arg8: index, %arg9: index):
      "scf.yield"(%arg9) : (index) -> ()
    }) : (index, index, index, index) -> index
    "func.return"(%4) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "for_yield_update_loop_carried_var"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "scf.for"(%arg0, %arg1, %arg2, %0) ({
    ^bb0(%arg3: index, %arg4: index):
      %2 = "arith.addi"(%arg4, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%2) : (index) -> ()
    }) : (index, index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

