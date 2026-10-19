"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<f32>, sym_name = "basic", sym_visibility = "private"}> ({
    %3 = "test.source"() : () -> memref<f32>
    "func.return"(%3) : (memref<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<1xf32>) -> memref<2xf32>, sym_name = "presence_of_existing_arguments", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<1xf32>):
    %2 = "test.source"() : () -> memref<2xf32>
    "func.return"(%2) : (memref<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (memref<1xf32>, memref<2xf32>), sym_name = "multiple_results", sym_visibility = "private"}> ({
    %1:2 = "test.source"() : () -> (memref<1xf32>, memref<2xf32>)
    "func.return"(%1#0, %1#1) : (memref<1xf32>, memref<2xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (i1, memref<f32>, i32), sym_name = "non_memref_types", sym_visibility = "private"}> ({
    %0:3 = "test.source"() : () -> (i1, memref<f32>, i32)
    "func.return"(%0#0, %0#1, %0#2) : (i1, memref<f32>, i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<f32>, sym_name = "external_function", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<f32>, res_attrs = [{test.some_attr}], sym_name = "result_attrs", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (memref<1xf32>, memref<2xf32>, memref<3xf32>), res_attrs = [{}, {test.some_attr}, {}], sym_name = "mixed_result_attrs", sym_visibility = "private"}> ({
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<1xf32>, sym_name = "callee", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "call_basic"}> ({
    %0 = "func.call"() <{callee = @callee}> : () -> memref<1xf32>
    "test.sink"(%0) : (memref<1xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (memref<1xf32>, memref<2xf32>), sym_name = "callee", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "call_multiple_result"}> ({
    %0:2 = "func.call"() <{callee = @callee}> : () -> (memref<1xf32>, memref<2xf32>)
    "test.sink"(%0#0, %0#1) : (memref<1xf32>, memref<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (i1, memref<1xf32>, i32), sym_name = "callee", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "call_non_memref_result"}> ({
    %0:3 = "func.call"() <{callee = @callee}> : () -> (i1, memref<1xf32>, i32)
    "test.sink"(%0#0, %0#1, %0#2) : (i1, memref<1xf32>, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> memref<?xf32>, sym_name = "callee", sym_visibility = "private"}> ({
  ^bb0(%arg1: index):
    %1 = "memref.alloc"(%arg1) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "func.return"(%1) : (memref<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "call_non_memref_result"}> ({
  ^bb0(%arg0: index):
    %0 = "func.call"(%arg0) <{callee = @callee}> : (index) -> memref<?xf32>
    "test.sink"(%0) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

