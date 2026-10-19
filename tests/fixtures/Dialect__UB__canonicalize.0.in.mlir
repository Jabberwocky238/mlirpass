"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "merge_poison"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    "func.return"(%0, %1) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

