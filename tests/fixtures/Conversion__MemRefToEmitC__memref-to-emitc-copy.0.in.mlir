"builtin.module"() ({
  "func.func"() <{function_type = (memref<9x4x5x7xf32>, memref<9x4x5x7xf32>) -> (), sym_name = "copying"}> ({
  ^bb0(%arg0: memref<9x4x5x7xf32>, %arg1: memref<9x4x5x7xf32>):
    "memref.copy"(%arg0, %arg1) : (memref<9x4x5x7xf32>, memref<9x4x5x7xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

