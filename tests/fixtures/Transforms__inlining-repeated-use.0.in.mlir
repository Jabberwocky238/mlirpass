"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "A"}> ({
    "func.call"() <{callee = @B}> {inA} : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "B"}> ({
    "func.call"() <{callee = @E}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "C"}> ({
    "func.call"() <{callee = @D}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "D", sym_visibility = "private"}> ({
    "func.call"() <{callee = @B}> {inD} : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "E"}> ({
    "func.call"() <{callee = @fabsf}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "fabsf", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

