"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "foo"}> ({
    %0 = "gpu.wait"() : () -> !gpu.async.token
    %1 = "gpu.wait"(%0) : (!gpu.async.token) -> !gpu.async.token
    "gpu.wait"(%0, %1) : (!gpu.async.token, !gpu.async.token) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) {gpu.container_module} : () -> ()

