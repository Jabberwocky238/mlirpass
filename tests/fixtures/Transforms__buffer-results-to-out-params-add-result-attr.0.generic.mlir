"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferize.result}], function_type = (memref<f32>) -> (), sym_name = "basic", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "test.source"() : () -> memref<f32>
    "memref.copy"(%0, %arg0) : (memref<f32>, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{arg_attrs = [{bufferize.result}, {bufferize.result}], function_type = (memref<1xf32>, memref<2xf32>) -> (), sym_name = "multiple_results", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<1xf32>, %arg1: memref<2xf32>):
    %0:2 = "test.source"() : () -> (memref<1xf32>, memref<2xf32>)
    "memref.copy"(%0#0, %arg0) : (memref<1xf32>, memref<1xf32>) -> ()
    "memref.copy"(%0#1, %arg1) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

