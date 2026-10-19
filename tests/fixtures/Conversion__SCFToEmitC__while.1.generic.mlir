"builtin.module"() ({
  "emitc.func"() <{function_type = (i32) -> i32, sym_name = "payload_one_result"}> ({
  ^bb0(%arg11: i32):
    %71 = "emitc.add"(%arg11, %arg11) : (i32, i32) -> i32
    "emitc.return"(%71) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "one_result"}> ({
    %57 = "emitc.literal"() <{value = "1.0"}> : () -> i32
    %58 = "emitc.literal"() <{value = "1.0"}> : () -> i32
    %59 = "emitc.literal"() <{value = "10.0"}> : () -> i32
    %60 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %61 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    "emitc.assign"(%61, %57) : (!emitc.lvalue<i32>, i32) -> ()
    %62 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i1>
    "emitc.do"() ({
      %66 = "emitc.load"(%61) : (!emitc.lvalue<i32>) -> i32
      %67 = "emitc.add"(%66, %58) : (i32, i32) -> i32
      %68 = "emitc.cmp"(%67, %59) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %69 = "emitc.add"(%66, %66) : (i32, i32) -> i32
      "emitc.assign"(%60, %69) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.assign"(%62, %68) : (!emitc.lvalue<i1>, i1) -> ()
      "emitc.if"(%68) ({
        %70 = "emitc.call"(%69) <{callee = @payload_one_result}> : (i32) -> i32
        "emitc.assign"(%61, %70) : (!emitc.lvalue<i32>, i32) -> ()
        "emitc.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
    }, {
      %64 = "emitc.expression"(%62) ({
      ^bb0(%arg10: !emitc.lvalue<i1>):
        %65 = "emitc.load"(%arg10) : (!emitc.lvalue<i1>) -> i1
        "emitc.yield"(%65) : (i1) -> ()
      }) : (!emitc.lvalue<i1>) -> i1
      "emitc.yield"(%64) : (i1) -> ()
    }) : () -> ()
    %63 = "emitc.load"(%60) : (!emitc.lvalue<i32>) -> i32
    "func.return"(%63) : (i32) -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32) -> i32, sym_name = "payload_two_results"}> ({
  ^bb0(%arg9: i32):
    %56 = "emitc.add"(%arg9, %arg9) : (i32, i32) -> i32
    "emitc.return"(%56) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "two_results"}> ({
    %39 = "emitc.literal"() <{value = "1.0"}> : () -> i32
    %40 = "emitc.literal"() <{value = "10.0"}> : () -> i32
    %41 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %42 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %43 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    "emitc.assign"(%43, %39) : (!emitc.lvalue<i32>, i32) -> ()
    %44 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    "emitc.assign"(%44, %39) : (!emitc.lvalue<i32>, i32) -> ()
    %45 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i1>
    "emitc.do"() ({
      %50 = "emitc.load"(%43) : (!emitc.lvalue<i32>) -> i32
      %51 = "emitc.load"(%44) : (!emitc.lvalue<i32>) -> i32
      %52 = "emitc.add"(%50, %51) : (i32, i32) -> i32
      %53 = "emitc.cmp"(%52, %40) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "emitc.assign"(%41, %39) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.assign"(%42, %51) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.assign"(%45, %53) : (!emitc.lvalue<i1>, i1) -> ()
      "emitc.if"(%53) ({
        %54 = "emitc.call"(%39) <{callee = @payload_two_results}> : (i32) -> i32
        %55 = "emitc.call"(%51) <{callee = @payload_two_results}> : (i32) -> i32
        "emitc.assign"(%43, %54) : (!emitc.lvalue<i32>, i32) -> ()
        "emitc.assign"(%44, %55) : (!emitc.lvalue<i32>, i32) -> ()
        "emitc.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
    }, {
      %48 = "emitc.expression"(%45) ({
      ^bb0(%arg8: !emitc.lvalue<i1>):
        %49 = "emitc.load"(%arg8) : (!emitc.lvalue<i1>) -> i1
        "emitc.yield"(%49) : (i1) -> ()
      }) : (!emitc.lvalue<i1>) -> i1
      "emitc.yield"(%48) : (i1) -> ()
    }) : () -> ()
    %46 = "emitc.load"(%41) : (!emitc.lvalue<i32>) -> i32
    %47 = "emitc.load"(%42) : (!emitc.lvalue<i32>) -> i32
    "func.return"(%46) : (i32) -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32) -> i32, sym_name = "payload_double_use"}> ({
  ^bb0(%arg7: i32):
    %38 = "emitc.add"(%arg7, %arg7) : (i32, i32) -> i32
    "emitc.return"(%38) : (i32) -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32, !emitc.ptr<i32>) -> i32, sym_name = "foo_with_side_effect"}> ({
  ^bb0(%arg5: i32, %arg6: !emitc.ptr<i32>):
    %37 = "emitc.add"(%arg5, %arg5) : (i32, i32) -> i32
    "emitc.verbatim"(%arg6, %37) <{value = "{}[0] = {};"}> : (!emitc.ptr<i32>, i32) -> ()
    "emitc.return"(%37) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (!emitc.ptr<i32>) -> i32, sym_name = "double_use"}> ({
  ^bb0(%arg3: !emitc.ptr<i32>):
    %22 = "emitc.literal"() <{value = "1.0"}> : () -> i32
    %23 = "emitc.literal"() <{value = "1.0"}> : () -> i32
    %24 = "emitc.literal"() <{value = "10.0"}> : () -> i32
    %25 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %26 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    "emitc.assign"(%26, %22) : (!emitc.lvalue<i32>, i32) -> ()
    %27 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i1>
    "emitc.do"() ({
      %31 = "emitc.load"(%26) : (!emitc.lvalue<i32>) -> i32
      %32 = "emitc.call"(%31, %arg3) <{callee = @foo_with_side_effect}> : (i32, !emitc.ptr<i32>) -> i32
      %33 = "emitc.add"(%32, %32) : (i32, i32) -> i32
      %34 = "emitc.add"(%31, %33) : (i32, i32) -> i32
      %35 = "emitc.cmp"(%34, %24) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "emitc.assign"(%25, %31) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.assign"(%27, %35) : (!emitc.lvalue<i1>, i1) -> ()
      "emitc.if"(%35) ({
        %36 = "emitc.call"(%31) <{callee = @payload_double_use}> : (i32) -> i32
        "emitc.assign"(%26, %36) : (!emitc.lvalue<i32>, i32) -> ()
        "emitc.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
    }, {
      %29 = "emitc.expression"(%27) ({
      ^bb0(%arg4: !emitc.lvalue<i1>):
        %30 = "emitc.load"(%arg4) : (!emitc.lvalue<i1>) -> i1
        "emitc.yield"(%30) : (i1) -> ()
      }) : (!emitc.lvalue<i1>) -> i1
      "emitc.yield"(%29) : (i1) -> ()
    }) : () -> ()
    %28 = "emitc.load"(%25) : (!emitc.lvalue<i32>) -> i32
    "func.return"(%28) : (i32) -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = () -> i1, sym_name = "payload_empty_after_region"}> ({
    %21 = "emitc.literal"() <{value = "true"}> : () -> i1
    "emitc.return"(%21) : (i1) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "empty_after_region"}> ({
    %17 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i1>
    "emitc.do"() ({
      %20 = "emitc.call"() <{callee = @payload_empty_after_region}> : () -> i1
      "emitc.assign"(%17, %20) : (!emitc.lvalue<i1>, i1) -> ()
    }, {
      %18 = "emitc.expression"(%17) ({
      ^bb0(%arg2: !emitc.lvalue<i1>):
        %19 = "emitc.load"(%arg2) : (!emitc.lvalue<i1>) -> i1
        "emitc.yield"(%19) : (i1) -> ()
      }) : (!emitc.lvalue<i1>) -> i1
      "emitc.yield"(%18) : (i1) -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32) -> i32, sym_name = "payload_different_number_of_vars"}> ({
  ^bb0(%arg1: i32):
    %16 = "emitc.add"(%arg1, %arg1) : (i32, i32) -> i32
    "emitc.return"(%16) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "different_number_of_vars"}> ({
    %0 = "emitc.literal"() <{value = "1.0"}> : () -> i32
    %1 = "emitc.literal"() <{value = "7.0"}> : () -> i32
    %2 = "emitc.literal"() <{value = "10.0"}> : () -> i32
    %3 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %4 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %5 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    "emitc.assign"(%5, %0) : (!emitc.lvalue<i32>, i32) -> ()
    %6 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i1>
    "emitc.do"() ({
      %11 = "emitc.load"(%5) : (!emitc.lvalue<i32>) -> i32
      %12 = "emitc.add"(%11, %1) : (i32, i32) -> i32
      %13 = "emitc.cmp"(%12, %2) <{predicate = 2 : i64}> : (i32, i32) -> i1
      %14 = "emitc.add"(%11, %11) : (i32, i32) -> i32
      "emitc.assign"(%3, %14) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.assign"(%4, %12) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.assign"(%6, %13) : (!emitc.lvalue<i1>, i1) -> ()
      "emitc.if"(%13) ({
        %15 = "emitc.call"(%14) <{callee = @payload_different_number_of_vars}> : (i32) -> i32
        "emitc.assign"(%5, %15) : (!emitc.lvalue<i32>, i32) -> ()
        "emitc.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
    }, {
      %9 = "emitc.expression"(%6) ({
      ^bb0(%arg0: !emitc.lvalue<i1>):
        %10 = "emitc.load"(%arg0) : (!emitc.lvalue<i1>) -> i1
        "emitc.yield"(%10) : (i1) -> ()
      }) : (!emitc.lvalue<i1>) -> i1
      "emitc.yield"(%9) : (i1) -> ()
    }) : () -> ()
    %7 = "emitc.load"(%3) : (!emitc.lvalue<i32>) -> i32
    %8 = "emitc.load"(%4) : (!emitc.lvalue<i32>) -> i32
    "func.return"(%7, %8) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

