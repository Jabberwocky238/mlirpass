"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<f32>, sym_name = "basic"}> ({
    %2 = "test.source"() : () -> memref<f32>
    "func.return"(%2) : (memref<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xf32>) -> memref<2xf32>, sym_name = "presence_of_existing_arguments"}> ({
  ^bb0(%arg0: memref<1xf32>):
    %1 = "test.source"() : () -> memref<2xf32>
    "func.return"(%1) : (memref<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (memref<1xf32>, memref<2xf32>), sym_name = "multiple_results"}> ({
    %0:2 = "test.source"() : () -> (memref<1xf32>, memref<2xf32>)
    "func.return"(%0#0, %0#1) : (memref<1xf32>, memref<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

