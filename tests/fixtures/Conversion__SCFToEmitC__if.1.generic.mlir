"builtin.module"() ({
  "func.func"() <{function_type = (i1, f32) -> (), sym_name = "test_if"}> ({
  ^bb0(%arg4: i1, %arg5: f32):
    "emitc.if"(%arg4) ({
      %11 = "emitc.call_opaque"(%arg5) <{callee = "func_const"}> : (f32) -> i32
      "emitc.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, f32) -> (), sym_name = "test_if_else"}> ({
  ^bb0(%arg2: i1, %arg3: f32):
    "emitc.if"(%arg2) ({
      %10 = "emitc.call_opaque"(%arg3) <{callee = "func_true"}> : (f32) -> i32
      "emitc.yield"() : () -> ()
    }, {
      %9 = "emitc.call_opaque"(%arg3) <{callee = "func_false"}> : (f32) -> i32
      "emitc.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, f32) -> (i32, f64), sym_name = "test_if_yield"}> ({
  ^bb0(%arg0: i1, %arg1: f32):
    %0 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %1 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %2 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<f64>
    "emitc.if"(%arg0) ({
      %7 = "emitc.call_opaque"(%arg1) <{callee = "func_true_1"}> : (f32) -> i32
      %8 = "emitc.call_opaque"(%arg1) <{callee = "func_true_2"}> : (f32) -> f64
      "emitc.assign"(%1, %7) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.assign"(%2, %8) : (!emitc.lvalue<f64>, f64) -> ()
      "emitc.yield"() : () -> ()
    }, {
      %5 = "emitc.call_opaque"(%arg1) <{callee = "func_false_1"}> : (f32) -> i32
      %6 = "emitc.call_opaque"(%arg1) <{callee = "func_false_2"}> : (f32) -> f64
      "emitc.assign"(%1, %5) : (!emitc.lvalue<i32>, i32) -> ()
      "emitc.assign"(%2, %6) : (!emitc.lvalue<f64>, f64) -> ()
      "emitc.yield"() : () -> ()
    }) : (i1) -> ()
    %3 = "emitc.load"(%1) : (!emitc.lvalue<i32>) -> i32
    %4 = "emitc.load"(%2) : (!emitc.lvalue<f64>) -> f64
    "func.return"(%3, %4) : (i32, f64) -> ()
  }) : () -> ()
}) : () -> ()

