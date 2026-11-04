"builtin.module"() ({
  "gpu.module"() <{sym_name = "memref_conversions"}> ({
    "gpu.func"() <{function_type = (memref<8xf32>) -> ()}> ({
    ^bb0(%arg0: memref<8xf32>):
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "kern", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

