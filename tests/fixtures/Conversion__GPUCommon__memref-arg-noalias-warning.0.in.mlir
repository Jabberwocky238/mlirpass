"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{arg_attrs = [{llvm.noalias}], function_type = (memref<f32>) -> ()}> ({
    ^bb0(%arg0: memref<f32>):
      "gpu.return"() : () -> ()
    }) {sym_name = "func_warning_for_not_bare_pointer", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

