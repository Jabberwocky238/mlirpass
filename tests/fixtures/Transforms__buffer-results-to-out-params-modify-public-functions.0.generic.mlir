"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "basic"}> ({
  ^bb0(%arg4: memref<f32>):
    %2 = "test.source"() : () -> memref<f32>
    "memref.copy"(%2, %arg4) : (memref<f32>, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xf32>, memref<2xf32>) -> (), sym_name = "presence_of_existing_arguments"}> ({
  ^bb0(%arg2: memref<1xf32>, %arg3: memref<2xf32>):
    %1 = "test.source"() : () -> memref<2xf32>
    "memref.copy"(%1, %arg3) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xf32>, memref<2xf32>) -> (), sym_name = "multiple_results"}> ({
  ^bb0(%arg0: memref<1xf32>, %arg1: memref<2xf32>):
    %0:2 = "test.source"() : () -> (memref<1xf32>, memref<2xf32>)
    "memref.copy"(%0#0, %arg0) : (memref<1xf32>, memref<1xf32>) -> ()
    "memref.copy"(%0#1, %arg1) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

