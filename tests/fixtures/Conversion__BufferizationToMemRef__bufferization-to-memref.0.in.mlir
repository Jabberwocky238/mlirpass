"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xf32>) -> memref<2xf32>, sym_name = "conversion_static"}> ({
  ^bb0(%arg0: memref<2xf32>):
    %0 = "bufferization.clone"(%arg0) : (memref<2xf32>) -> memref<2xf32>
    "memref.dealloc"(%arg0) : (memref<2xf32>) -> ()
    "func.return"(%0) : (memref<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<?xf32>, sym_name = "conversion_dynamic"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "bufferization.clone"(%arg0) : (memref<?xf32>) -> memref<?xf32>
    "memref.dealloc"(%arg0) : (memref<?xf32>) -> ()
    "func.return"(%0) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> memref<*xf32>, sym_name = "conversion_unknown"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "bufferization.clone"(%arg0) : (memref<*xf32>) -> memref<*xf32>
    "memref.dealloc"(%arg0) : (memref<*xf32>) -> ()
    "func.return"(%0) : (memref<*xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "conversion_with_layout_map"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "bufferization.clone"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>
    "memref.dealloc"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[10], offset: ?>>) -> memref<?xf32, strided<[10], offset: ?>>, sym_name = "conversion_with_invalid_layout_map"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[10], offset: ?>>):
    %0 = "bufferization.clone"(%arg0) : (memref<?xf32, strided<[10], offset: ?>>) -> memref<?xf32, strided<[10], offset: ?>>
    "memref.dealloc"(%arg0) : (memref<?xf32, strided<[10], offset: ?>>) -> ()
    "func.return"(%0) : (memref<?xf32, strided<[10], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xf32>, i1) -> (), sym_name = "conversion_dealloc_simple"}> ({
  ^bb0(%arg0: memref<2xf32>, %arg1: i1):
    "bufferization.dealloc"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0>}> : (memref<2xf32>, i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

