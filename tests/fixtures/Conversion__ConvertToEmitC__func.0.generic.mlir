"builtin.module"() ({
  "emitc.func"() <{function_type = (i32) -> i32, sym_name = "int"}> ({
  ^bb0(%arg1: i32):
    "emitc.return"(%arg1) : (i32) -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (!emitc.size_t) -> !emitc.size_t, sym_name = "index"}> ({
  ^bb0(%arg0: !emitc.size_t):
    "emitc.return"(%arg0) : (!emitc.size_t) -> ()
  }) : () -> ()
}) : () -> ()

