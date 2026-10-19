"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "b0"}> ({
    "func.call"() <{callee = @b0}> : () -> ()
    "func.call"() <{callee = @b1}> : () -> ()
    "func.call"() <{callee = @b0}> : () -> ()
    "func.call"() <{callee = @b1}> : () -> ()
    "func.call"() <{callee = @b0}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "b1"}> ({
    "func.call"() <{callee = @b1}> : () -> ()
    "func.call"() <{callee = @b1}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

