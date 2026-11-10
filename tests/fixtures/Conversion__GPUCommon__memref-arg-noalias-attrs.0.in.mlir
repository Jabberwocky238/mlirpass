"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{arg_attrs = [{llvm.noalias}], function_type = (memref<f32>) -> ()}> ({
    ^bb0(%arg0: memref<f32>):
      "gpu.return"() : () -> ()
    }) {sym_name = "func_with_noalias_attr"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "kernel"}> ({
    "gpu.func"() <{function_type = (memref<f32>) -> ()}> ({
    ^bb0(%arg0: memref<f32>):
      "gpu.return"() : () -> ()
    }) {sym_name = "func_without_any_attr"} : () -> ()
  }) : () -> ()
}) : () -> ()

