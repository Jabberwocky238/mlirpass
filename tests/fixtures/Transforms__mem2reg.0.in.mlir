"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "multi_slot_alloca"}> ({
    %0:2 = "test.multi_slot_alloca"() : () -> (memref<i32>, memref<i32>)
    %1 = "memref.load"(%0#0) : (memref<i32>) -> i32
    %2 = "memref.load"(%0#1) : (memref<i32>) -> i32
    "func.return"(%1, %2) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>) -> (), sym_name = "consumer", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "multi_slot_alloca_only_second"}> ({
    %0:2 = "test.multi_slot_alloca"() : () -> (memref<i32>, memref<i32>)
    "func.call"(%0#0) <{callee = @consumer}> : (memref<i32>) -> ()
    %1 = "memref.load"(%0#0) : (memref<i32>) -> i32
    %2 = "memref.load"(%0#1) : (memref<i32>) -> i32
    "func.return"(%1, %2) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "test.isolated_graph_region"() ({
    %0 = "test.multi_slot_alloca"() : () -> memref<i32>
    "memref.store"(%1, %0) : (i32, memref<i32>) -> ()
    %1 = "memref.load"(%0) : (memref<i32>) -> i32
    "test.foo"() : () -> ()
  }) : () -> ()
}) : () -> ()

