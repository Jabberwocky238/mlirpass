"builtin.module"() ({
  "gpu.module"() <{sym_name = "memref_conversions"}> ({
    "gpu.func"() <{function_type = (memref<8xf32>) -> (), kernel}> ({
    ^bb0(%arg0: memref<8xf32>):
      "gpu.return"() : () -> ()
    }) {sym_name = "kern"} : () -> ()
  }) : () -> ()
}) : () -> ()

