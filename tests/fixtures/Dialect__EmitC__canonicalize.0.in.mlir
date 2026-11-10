"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "no_fold_cast_to_f32"}> ({
  ^bb0(%arg1: i32):
    %1 = "emitc.cast"(%arg1) : (i32) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "fold_cast_to_i64"}> ({
  ^bb0(%arg0: i32):
    %0 = "emitc.cast"(%arg0) <{pure}> : (i32) -> i64
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

