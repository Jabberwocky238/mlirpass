"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "alloc_with_custom_element_type"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10x!test.memref_element>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x!test.memref_element>, memref<10x!test.memref_element>) -> (), sym_name = "copy_with_custom_element_type"}> ({
  ^bb0(%arg0: memref<10x!test.memref_element>, %arg1: memref<10x!test.memref_element>):
    "memref.copy"(%arg0, %arg1) : (memref<10x!test.memref_element>, memref<10x!test.memref_element>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!test.memref_element, index) -> (), sym_name = "store_with_custom_element_type"}> ({
  ^bb0(%arg0: !test.memref_element, %arg1: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x!test.memref_element>
    "memref.store"(%arg0, %0, %arg1) : (!test.memref_element, memref<4x!test.memref_element>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> !test.memref_element, sym_name = "load_with_custom_element_type"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x!test.memref_element>
    %1 = "memref.load"(%0, %arg0) : (memref<4x!test.memref_element>, index) -> !test.memref_element
    "func.return"(%1) : (!test.memref_element) -> ()
  }) : () -> ()
}) : () -> ()

