"builtin.module"() ({
  "func.func"() <{function_type = (memref<9x4x5x7xf32>, memref<9x4x5x7xf32>) -> (), sym_name = "copying"}> ({
  ^bb0(%arg0: memref<9x4x5x7xf32>, %arg1: memref<9x4x5x7xf32>):
    "memref.copy"(%arg0, %arg1) : (memref<9x4x5x7xf32>, memref<9x4x5x7xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>, memref<i32>) -> (), sym_name = "copying_rank0"}> ({
  ^bb0(%arg0: memref<i32>, %arg1: memref<i32>):
    "memref.copy"(%arg0, %arg1) : (memref<i32>, memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

