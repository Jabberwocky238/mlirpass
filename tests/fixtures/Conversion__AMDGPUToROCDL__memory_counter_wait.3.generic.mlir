"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "memory_counter_wait"}> ({
    "rocdl.s.wait.loadcnt"() <{count = 0 : i16}> : () -> ()
    "rocdl.s.wait.storecnt"() <{count = 0 : i16}> : () -> ()
    "rocdl.s.wait.expcnt"() <{count = 0 : i16}> : () -> ()
    "rocdl.s.wait.dscnt"() <{count = 0 : i16}> : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

