"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<f32>, sym_name = "basic", sym_visibility = "private"}> ({
    %0 = "test.source"() : () -> memref<f32>
    "func.return"(%0) : (memref<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (memref<1xf32>, memref<2xf32>), sym_name = "multiple_results", sym_visibility = "private"}> ({
    %0:2 = "test.source"() : () -> (memref<1xf32>, memref<2xf32>)
    "func.return"(%0#0, %0#1) : (memref<1xf32>, memref<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

