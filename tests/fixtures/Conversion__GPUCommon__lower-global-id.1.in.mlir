"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{function_type = () -> index}> ({
      %0 = "gpu.global_id"() <{dimension = #gpu<dim x>}> : () -> index
      "gpu.return"(%0) : (index) -> ()
    }) {sym_name = "gpu_global_id", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

