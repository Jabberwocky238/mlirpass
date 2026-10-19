"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "set_default_device"}> ({
  ^bb0(%arg0: i32):
    "gpu.set_default_device"(%arg0) : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

