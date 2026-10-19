"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "check_poison"}> ({
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> index
    %1 = "ub.poison"() <{value = #ub.poison}> : () -> i16
    %2 = "ub.poison"() <{value = #ub.poison}> : () -> f64
    %3 = "ub.poison"() <{value = #ub.poison}> : () -> !llvm.ptr
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "check_unrechable"}> ({
    "ub.unreachable"() : () -> ()
  }) : () -> ()
}) : () -> ()

