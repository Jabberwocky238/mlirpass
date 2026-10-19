"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "switch_no_result"}> ({
  ^bb0(%arg2: index):
    %17 = "builtin.unrealized_conversion_cast"(%arg2) : (index) -> !emitc.size_t
    "emitc.switch"(%17) <{cases = array<i64: 2, 5>}> ({
      %20 = "arith.constant"() <{value = 30 : i32}> : () -> i32
      "emitc.yield"() : () -> ()
    }, {
      %19 = "arith.constant"() <{value = 10 : i32}> : () -> i32
      "emitc.yield"() : () -> ()
    }, {
      %18 = "arith.constant"() <{value = 20 : i32}> : () -> i32
      "emitc.yield"() : () -> ()
    }) : (!emitc.size_t) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "switch_one_result"}> ({
  ^bb0(%arg1: index):
    %11 = "builtin.unrealized_conversion_cast"(%arg1) : (index) -> !emitc.size_t
    %12 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    "emitc.switch"(%11) <{cases = array<i64: 2, 5>}> ({
      %16 = "arith.constant"() <{value = 30 : i32}> : () -> i32
      "emitc.assign"(%12, %16) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.yield"() : () -> ()
    }, {
      %15 = "arith.constant"() <{value = 10 : i32}> : () -> i32
      "emitc.assign"(%12, %15) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.yield"() : () -> ()
    }, {
      %14 = "arith.constant"() <{value = 20 : i32}> : () -> i32
      "emitc.assign"(%12, %14) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.yield"() : () -> ()
    }) : (!emitc.size_t) -> ()
    %13 = "emitc.load"(%12) : (!emitc.lvalue<i32>) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (i32, f32), sym_name = "switch_two_results"}> ({
  ^bb0(%arg0: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (index) -> !emitc.size_t
    %1 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %2 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<f32>
    "emitc.switch"(%0) <{cases = array<i64: 2, 5>}> ({
      %9 = "arith.constant"() <{value = 30 : i32}> : () -> i32
      %10 = "arith.constant"() <{value = 3.600000e+00 : f32}> : () -> f32
      "emitc.assign"(%1, %9) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.assign"(%2, %10) : (!emitc.lvalue<f32>, f32) -> ()
      "emitc.yield"() : () -> ()
    }, {
      %7 = "arith.constant"() <{value = 10 : i32}> : () -> i32
      %8 = "arith.constant"() <{value = 1.200000e+00 : f32}> : () -> f32
      "emitc.assign"(%1, %7) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.assign"(%2, %8) : (!emitc.lvalue<f32>, f32) -> ()
      "emitc.yield"() : () -> ()
    }, {
      %5 = "arith.constant"() <{value = 20 : i32}> : () -> i32
      %6 = "arith.constant"() <{value = 2.400000e+00 : f32}> : () -> f32
      "emitc.assign"(%1, %5) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.assign"(%2, %6) : (!emitc.lvalue<f32>, f32) -> ()
      "emitc.yield"() : () -> ()
    }) : (!emitc.size_t) -> ()
    %3 = "emitc.load"(%1) : (!emitc.lvalue<i32>) -> i32
    %4 = "emitc.load"(%2) : (!emitc.lvalue<f32>) -> f32
    "func.return"(%3, %4) : (i32, f32) -> ()
  }) : () -> ()
}) : () -> ()

