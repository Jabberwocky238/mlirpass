"builtin.module"() ({
  "emitc.func"() <{function_type = (i32) -> i32, sym_name = "payload_one_result"}> ({
  ^bb0(%arg17: i32):
    %38 = "emitc.add"(%arg17, %arg17) : (i32, i32) -> i32
    "emitc.return"(%38) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "one_result"}> ({
    %30 = "emitc.literal"() <{value = "1.0"}> : () -> i32
    %31 = "emitc.literal"() <{value = "1.0"}> : () -> i32
    %32 = "emitc.literal"() <{value = "10.0"}> : () -> i32
    %33 = "scf.while"(%30) ({
    ^bb0(%arg16: i32):
      %35 = "emitc.add"(%arg16, %31) : (i32, i32) -> i32
      %36 = "emitc.cmp"(%35, %32) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %37 = "emitc.add"(%arg16, %arg16) : (i32, i32) -> i32
      "scf.condition"(%36, %37) : (i1, i32) -> ()
    }, {
    ^bb0(%arg15: i32):
      %34 = "emitc.call"(%arg15) <{callee = @payload_one_result}> : (i32) -> i32
      "scf.yield"(%34) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%33) : (i32) -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32) -> i32, sym_name = "payload_two_results"}> ({
  ^bb0(%arg14: i32):
    %29 = "emitc.add"(%arg14, %arg14) : (i32, i32) -> i32
    "emitc.return"(%29) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "two_results"}> ({
    %22 = "emitc.literal"() <{value = "1.0"}> : () -> i32
    %23 = "emitc.literal"() <{value = "10.0"}> : () -> i32
    %24:2 = "scf.while"(%22, %22) ({
    ^bb0(%arg12: i32, %arg13: i32):
      %27 = "emitc.add"(%arg12, %arg13) : (i32, i32) -> i32
      %28 = "emitc.cmp"(%27, %23) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%28, %22, %arg13) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg10: i32, %arg11: i32):
      %25 = "emitc.call"(%arg10) <{callee = @payload_two_results}> : (i32) -> i32
      %26 = "emitc.call"(%arg11) <{callee = @payload_two_results}> : (i32) -> i32
      "scf.yield"(%25, %26) : (i32, i32) -> ()
    }) : (i32, i32) -> (i32, i32)
    "func.return"(%24#0) : (i32) -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32) -> i32, sym_name = "payload_double_use"}> ({
  ^bb0(%arg9: i32):
    %21 = "emitc.add"(%arg9, %arg9) : (i32, i32) -> i32
    "emitc.return"(%21) : (i32) -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32, !emitc.ptr<i32>) -> i32, sym_name = "foo_with_side_effect"}> ({
  ^bb0(%arg7: i32, %arg8: !emitc.ptr<i32>):
    %20 = "emitc.add"(%arg7, %arg7) : (i32, i32) -> i32
    "emitc.verbatim"(%arg8, %20) <{value = "{}[0] = {};"}> : (!emitc.ptr<i32>, i32) -> ()
    "emitc.return"(%20) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!emitc.ptr<i32>) -> i32, sym_name = "double_use"}> ({
  ^bb0(%arg4: !emitc.ptr<i32>):
    %11 = "emitc.literal"() <{value = "1.0"}> : () -> i32
    %12 = "emitc.literal"() <{value = "1.0"}> : () -> i32
    %13 = "emitc.literal"() <{value = "10.0"}> : () -> i32
    %14 = "scf.while"(%11) ({
    ^bb0(%arg6: i32):
      %16 = "emitc.call"(%arg6, %arg4) <{callee = @foo_with_side_effect}> : (i32, !emitc.ptr<i32>) -> i32
      %17 = "emitc.add"(%16, %16) : (i32, i32) -> i32
      %18 = "emitc.add"(%arg6, %17) : (i32, i32) -> i32
      %19 = "emitc.cmp"(%18, %13) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%19, %arg6) : (i1, i32) -> ()
    }, {
    ^bb0(%arg5: i32):
      %15 = "emitc.call"(%arg5) <{callee = @payload_double_use}> : (i32) -> i32
      "scf.yield"(%15) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%14) : (i32) -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = () -> i1, sym_name = "payload_empty_after_region"}> ({
    %10 = "emitc.literal"() <{value = "true"}> : () -> i1
    "emitc.return"(%10) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "empty_after_region"}> ({
    "scf.while"() ({
      %9 = "emitc.call"() <{callee = @payload_empty_after_region}> : () -> i1
      "scf.condition"(%9) : (i1) -> ()
    }, {
      "scf.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32) -> i32, sym_name = "payload_different_number_of_vars"}> ({
  ^bb0(%arg3: i32):
    %8 = "emitc.add"(%arg3, %arg3) : (i32, i32) -> i32
    "emitc.return"(%8) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "different_number_of_vars"}> ({
    %0 = "emitc.literal"() <{value = "1.0"}> : () -> i32
    %1 = "emitc.literal"() <{value = "7.0"}> : () -> i32
    %2 = "emitc.literal"() <{value = "10.0"}> : () -> i32
    %3:2 = "scf.while"(%0) ({
    ^bb0(%arg2: i32):
      %5 = "emitc.add"(%arg2, %1) : (i32, i32) -> i32
      %6 = "emitc.cmp"(%5, %2) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %7 = "emitc.add"(%arg2, %arg2) : (i32, i32) -> i32
      "scf.condition"(%6, %7, %5) : (i1, i32, i32) -> ()
    }, {
    ^bb0(%arg0: i32, %arg1: i32):
      %4 = "emitc.call"(%arg0) <{callee = @payload_different_number_of_vars}> : (i32) -> i32
      "scf.yield"(%4) : (i32) -> ()
    }) : (i32) -> (i32, i32)
    "func.return"(%3#0, %3#1) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

