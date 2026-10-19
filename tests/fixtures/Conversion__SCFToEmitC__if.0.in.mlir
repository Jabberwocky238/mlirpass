"builtin.module"() ({
  "func.func"() <{function_type = (i1, f32) -> (), sym_name = "test_if"}> ({
  ^bb0(%arg4: i1, %arg5: f32):
    "scf.if"(%arg4) ({
      %8 = "emitc.call_opaque"(%arg5) <{callee = "func_const"}> : (f32) -> i32
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, f32) -> (), sym_name = "test_if_else"}> ({
  ^bb0(%arg2: i1, %arg3: f32):
    "scf.if"(%arg2) ({
      %7 = "emitc.call_opaque"(%arg3) <{callee = "func_true"}> : (f32) -> i32
      "scf.yield"() : () -> ()
    }, {
      %6 = "emitc.call_opaque"(%arg3) <{callee = "func_false"}> : (f32) -> i32
      "scf.yield"() : () -> ()
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, f32) -> (i32, f64), sym_name = "test_if_yield"}> ({
  ^bb0(%arg0: i1, %arg1: f32):
    %0 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %1:2 = "scf.if"(%arg0) ({
      %4 = "emitc.call_opaque"(%arg1) <{callee = "func_true_1"}> : (f32) -> i32
      %5 = "emitc.call_opaque"(%arg1) <{callee = "func_true_2"}> : (f32) -> f64
      "scf.yield"(%4, %5) : (i32, f64) -> ()
    }, {
      %2 = "emitc.call_opaque"(%arg1) <{callee = "func_false_1"}> : (f32) -> i32
      %3 = "emitc.call_opaque"(%arg1) <{callee = "func_false_2"}> : (f32) -> f64
      "scf.yield"(%2, %3) : (i32, f64) -> ()
    }) : (i1) -> (i32, f64)
    "func.return"(%1#0, %1#1) : (i32, f64) -> ()
  }) : () -> ()
}) : () -> ()

