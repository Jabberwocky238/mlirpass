"builtin.module"() ({
  "emitc.func"() <{function_type = (i32) -> i32, sym_name = "int"}> ({
  ^bb0(%arg2: i32):
    "emitc.return"(%arg2) : (i32) -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (!emitc.size_t) -> !emitc.size_t, sym_name = "index"}> ({
  ^bb0(%arg1: !emitc.size_t):
    "emitc.return"(%arg1) : (!emitc.size_t) -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (!emitc.size_t) -> !emitc.size_t, sym_name = "call_with_one_result"}> ({
  ^bb0(%arg0: !emitc.size_t):
    %0 = "emitc.call"(%arg0) <{callee = @index}> : (!emitc.size_t) -> !emitc.size_t
    "emitc.return"(%0) : (!emitc.size_t) -> ()
  }) : () -> ()
}) : () -> ()

