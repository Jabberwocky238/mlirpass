"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "simple_std_for_loop"}> ({
  ^bb0(%arg22: index, %arg23: index, %arg24: index):
    %49 = "builtin.unrealized_conversion_cast"(%arg24) : (index) -> !emitc.size_t
    %50 = "builtin.unrealized_conversion_cast"(%arg23) : (index) -> !emitc.size_t
    %51 = "builtin.unrealized_conversion_cast"(%arg22) : (index) -> !emitc.size_t
    "emitc.for"(%51, %50, %49) ({
    ^bb0(%arg25: !emitc.size_t):
      %52 = "arith.constant"() <{value = 1 : index}> : () -> index
      "emitc.yield"() : () -> ()
    }) : (!emitc.size_t, !emitc.size_t, !emitc.size_t) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "simple_std_2_for_loops"}> ({
  ^bb0(%arg17: index, %arg18: index, %arg19: index):
    %44 = "builtin.unrealized_conversion_cast"(%arg19) : (index) -> !emitc.size_t
    %45 = "builtin.unrealized_conversion_cast"(%arg18) : (index) -> !emitc.size_t
    %46 = "builtin.unrealized_conversion_cast"(%arg17) : (index) -> !emitc.size_t
    "emitc.for"(%46, %45, %44) ({
    ^bb0(%arg20: !emitc.size_t):
      %47 = "arith.constant"() <{value = 1 : index}> : () -> index
      "emitc.for"(%46, %45, %44) ({
      ^bb0(%arg21: !emitc.size_t):
        %48 = "arith.constant"() <{value = 1 : index}> : () -> index
        "emitc.yield"() : () -> ()
      }) : (!emitc.size_t, !emitc.size_t, !emitc.size_t) -> ()
      "emitc.yield"() : () -> ()
    }) : (!emitc.size_t, !emitc.size_t, !emitc.size_t) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (f32, f32), sym_name = "for_yield"}> ({
  ^bb0(%arg13: index, %arg14: index, %arg15: index):
    %32 = "builtin.unrealized_conversion_cast"(%arg15) : (index) -> !emitc.size_t
    %33 = "builtin.unrealized_conversion_cast"(%arg14) : (index) -> !emitc.size_t
    %34 = "builtin.unrealized_conversion_cast"(%arg13) : (index) -> !emitc.size_t
    %35 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %36 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %37 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<f32>
    %38 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<f32>
    "emitc.assign"(%37, %35) : (!emitc.lvalue<f32>, f32) -> ()
    "emitc.assign"(%38, %36) : (!emitc.lvalue<f32>, f32) -> ()
    "emitc.for"(%34, %33, %32) ({
    ^bb0(%arg16: !emitc.size_t):
      %41 = "emitc.load"(%37) : (!emitc.lvalue<f32>) -> f32
      %42 = "emitc.load"(%38) : (!emitc.lvalue<f32>) -> f32
      %43 = "arith.addf"(%41, %42) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "emitc.assign"(%37, %43) : (!emitc.lvalue<f32>, f32) -> ()
      "emitc.assign"(%38, %43) : (!emitc.lvalue<f32>, f32) -> ()
      "emitc.yield"() : () -> ()
    }) : (!emitc.size_t, !emitc.size_t, !emitc.size_t) -> ()
    %39 = "emitc.load"(%37) : (!emitc.lvalue<f32>) -> f32
    %40 = "emitc.load"(%38) : (!emitc.lvalue<f32>) -> f32
    "func.return"(%39, %40) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> f32, sym_name = "nested_for_yield"}> ({
  ^bb0(%arg8: index, %arg9: index, %arg10: index):
    %21 = "builtin.unrealized_conversion_cast"(%arg10) : (index) -> !emitc.size_t
    %22 = "builtin.unrealized_conversion_cast"(%arg9) : (index) -> !emitc.size_t
    %23 = "builtin.unrealized_conversion_cast"(%arg8) : (index) -> !emitc.size_t
    %24 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %25 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<f32>
    "emitc.assign"(%25, %24) : (!emitc.lvalue<f32>, f32) -> ()
    "emitc.for"(%23, %22, %21) ({
    ^bb0(%arg11: !emitc.size_t):
      %27 = "emitc.load"(%25) : (!emitc.lvalue<f32>) -> f32
      %28 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<f32>
      "emitc.assign"(%28, %27) : (!emitc.lvalue<f32>, f32) -> ()
      "emitc.for"(%23, %22, %21) ({
      ^bb0(%arg12: !emitc.size_t):
        %30 = "emitc.load"(%28) : (!emitc.lvalue<f32>) -> f32
        %31 = "arith.addf"(%30, %30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "emitc.assign"(%28, %31) : (!emitc.lvalue<f32>, f32) -> ()
        "emitc.yield"() : () -> ()
      }) : (!emitc.size_t, !emitc.size_t, !emitc.size_t) -> ()
      %29 = "emitc.load"(%28) : (!emitc.lvalue<f32>) -> f32
      "emitc.assign"(%25, %29) : (!emitc.lvalue<f32>, f32) -> ()
      "emitc.yield"() : () -> ()
    }) : (!emitc.size_t, !emitc.size_t, !emitc.size_t) -> ()
    %26 = "emitc.load"(%25) : (!emitc.lvalue<f32>) -> f32
    "func.return"(%26) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "for_yield_index"}> ({
  ^bb0(%arg4: index, %arg5: index, %arg6: index):
    %12 = "builtin.unrealized_conversion_cast"(%arg6) : (index) -> !emitc.size_t
    %13 = "builtin.unrealized_conversion_cast"(%arg5) : (index) -> !emitc.size_t
    %14 = "builtin.unrealized_conversion_cast"(%arg4) : (index) -> !emitc.size_t
    %15 = "arith.constant"() <{value = 0 : index}> : () -> index
    %16 = "builtin.unrealized_conversion_cast"(%15) : (index) -> !emitc.size_t
    %17 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.size_t>
    "emitc.assign"(%17, %16) : (!emitc.lvalue<!emitc.size_t>, !emitc.size_t) -> ()
    "emitc.for"(%14, %13, %12) ({
    ^bb0(%arg7: !emitc.size_t):
      %20 = "emitc.load"(%17) : (!emitc.lvalue<!emitc.size_t>) -> !emitc.size_t
      "emitc.assign"(%17, %20) : (!emitc.lvalue<!emitc.size_t>, !emitc.size_t) -> ()
      "emitc.yield"() : () -> ()
    }) : (!emitc.size_t, !emitc.size_t, !emitc.size_t) -> ()
    %18 = "emitc.load"(%17) : (!emitc.lvalue<!emitc.size_t>) -> !emitc.size_t
    %19 = "builtin.unrealized_conversion_cast"(%18) : (!emitc.size_t) -> index
    "func.return"(%19) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "for_yield_update_loop_carried_var"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> !emitc.size_t
    %1 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> !emitc.size_t
    %2 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> !emitc.size_t
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "builtin.unrealized_conversion_cast"(%3) : (index) -> !emitc.size_t
    %5 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.size_t>
    "emitc.assign"(%5, %4) : (!emitc.lvalue<!emitc.size_t>, !emitc.size_t) -> ()
    "emitc.for"(%2, %1, %0) ({
    ^bb0(%arg3: !emitc.size_t):
      %8 = "emitc.load"(%5) : (!emitc.lvalue<!emitc.size_t>) -> !emitc.size_t
      %9 = "builtin.unrealized_conversion_cast"(%8) : (!emitc.size_t) -> index
      %10 = "arith.addi"(%9, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "builtin.unrealized_conversion_cast"(%10) : (index) -> !emitc.size_t
      "emitc.assign"(%5, %11) : (!emitc.lvalue<!emitc.size_t>, !emitc.size_t) -> ()
      "emitc.yield"() : () -> ()
    }) : (!emitc.size_t, !emitc.size_t, !emitc.size_t) -> ()
    %6 = "emitc.load"(%5) : (!emitc.lvalue<!emitc.size_t>) -> !emitc.size_t
    %7 = "builtin.unrealized_conversion_cast"(%6) : (!emitc.size_t) -> index
    "func.return"(%7) : (index) -> ()
  }) : () -> ()
}) : () -> ()

