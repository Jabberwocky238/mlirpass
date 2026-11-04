"builtin.module"() ({
  "test.symbol_scope_isolated"() ({
    "func.func"() <{function_type = (memref<?xf32>) -> (memref<?xf32>, f32), sym_name = "inner_func"}> ({
    ^bb0(%arg1: memref<?xf32>):
      %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %2 = "arith.constant"() <{value = 0 : index}> : () -> index
      %3 = "arith.constant"() <{value = 1 : index}> : () -> index
      "memref.store"(%1, %arg1, %2) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
      %4 = "memref.load"(%arg1, %3) <{nontemporal = false}> : (memref<?xf32>, index) -> f32
      "func.return"(%arg1, %4) : (memref<?xf32>, f32) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (memref<?xf32>) -> (f32, memref<?xf32>), sym_name = "call_func_with_non_tensor_return"}> ({
    ^bb0(%arg0: memref<?xf32>):
      %0:2 = "func.call"(%arg0) <{callee = @inner_func}> : (memref<?xf32>) -> (memref<?xf32>, f32)
      "func.return"(%0#1, %0#0) : (f32, memref<?xf32>) -> ()
    }) : () -> ()
    "test.finish"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "test.symbol_scope_isolated"() ({
    "func.func"() <{function_type = (memref<?xf32, #test.memref_layout<"hello">>) -> memref<?xf32, #test.memref_layout<"hello">>, sym_name = "inner_func"}> ({
    ^bb0(%arg1: memref<?xf32, #test.memref_layout<"hello">>):
      "func.return"(%arg1) : (memref<?xf32, #test.memref_layout<"hello">>) -> ()
    }) : () -> ()
    "func.func"() <{function_type = (memref<?xf32, #test.memref_layout<"hello">>) -> (memref<?xf32, #test.memref_layout<"hello">>, memref<?xf32, #test.memref_layout<"not hello">>), sym_name = "outer_func"}> ({
    ^bb0(%arg0: memref<?xf32, #test.memref_layout<"hello">>):
      %0 = "func.call"(%arg0) <{callee = @inner_func}> : (memref<?xf32, #test.memref_layout<"hello">>) -> memref<?xf32, #test.memref_layout<"hello">>
      %1 = "test.create_memref_op"() : () -> memref<?xf32, #test.memref_layout<"not hello">>
      %2 = "test.dummy_memref_op"(%1) : (memref<?xf32, #test.memref_layout<"not hello">>) -> memref<?xf32, #test.memref_layout<"not hello">>
      "func.return"(%0, %2) : (memref<?xf32, #test.memref_layout<"hello">>, memref<?xf32, #test.memref_layout<"not hello">>) -> ()
    }) : () -> ()
    "test.finish"() : () -> ()
  }) : () -> ()
}) : () -> ()

