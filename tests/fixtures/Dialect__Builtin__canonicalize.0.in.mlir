"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> (i32, i32), sym_name = "multiple_conversion_casts"}> ({
  ^bb0(%arg3: i32, %arg4: i32):
    %2:2 = "builtin.unrealized_conversion_cast"(%arg3, %arg4) : (i32, i32) -> (i64, i64)
    %3:2 = "builtin.unrealized_conversion_cast"(%2#0, %2#1) : (i64, i64) -> (i32, i32)
    "func.return"(%3#0, %3#1) : (i32, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, i64) -> (i32, i32), sym_name = "multiple_conversion_casts_failure"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i64):
    %0:2 = "builtin.unrealized_conversion_cast"(%arg0, %arg1) : (i32, i32) -> (i64, i64)
    %1:2 = "builtin.unrealized_conversion_cast"(%arg2, %0#1) : (i64, i64) -> (i32, i32)
    "func.return"(%1#0, %1#1) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

