module {
  "test.symbol_scope_isolated"() ({
    func.func @inner_func(%arg0: memref<?xf32>) -> (memref<?xf32>, f32) {
      %cst = arith.constant 1.000000e+00 : f32
      %c0 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      memref.store %cst, %arg0[%c0] : memref<?xf32>
      %0 = memref.load %arg0[%c1] : memref<?xf32>
      return %arg0, %0 : memref<?xf32>, f32
    }
    func.func @call_func_with_non_tensor_return(%arg0: memref<?xf32>) -> (f32, memref<?xf32>) {
      %0:2 = call @inner_func(%arg0) : (memref<?xf32>) -> (memref<?xf32>, f32)
      return %0#1, %0#0 : f32, memref<?xf32>
    }
    "test.finish"() : () -> ()
  }) : () -> ()
}

// -----
module {
  "test.symbol_scope_isolated"() ({
    func.func @inner_func(%arg0: memref<?xf32, #test.memref_layout<"hello">>) -> memref<?xf32, #test.memref_layout<"hello">> {
      return %arg0 : memref<?xf32, #test.memref_layout<"hello">>
    }
    func.func @outer_func(%arg0: memref<?xf32, #test.memref_layout<"hello">>) -> (memref<?xf32, #test.memref_layout<"hello">>, memref<?xf32, #test.memref_layout<"not hello">>) {
      %0 = call @inner_func(%arg0) : (memref<?xf32, #test.memref_layout<"hello">>) -> memref<?xf32, #test.memref_layout<"hello">>
      %1 = "test.create_memref_op"() : () -> memref<?xf32, #test.memref_layout<"not hello">>
      %2 = "test.dummy_memref_op"(%1) : (memref<?xf32, #test.memref_layout<"not hello">>) -> memref<?xf32, #test.memref_layout<"not hello">>
      return %0, %2 : memref<?xf32, #test.memref_layout<"hello">>, memref<?xf32, #test.memref_layout<"not hello">>
    }
    "test.finish"() : () -> ()
  }) : () -> ()
}

