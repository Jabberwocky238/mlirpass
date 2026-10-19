"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "multi_slot_alloca"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "test.multi_slot_alloca"() : () -> memref<i32>
    %2 = "test.multi_slot_alloca"() : () -> memref<i32>
    %3 = "memref.load"(%2) {first} : (memref<i32>) -> i32
    %4 = "memref.load"(%1) {second} : (memref<i32>) -> i32
    "func.return"(%3, %4) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xi32>) -> (), sym_name = "consumer", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "multi_slot_alloca_only_second"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "test.multi_slot_alloca"() : () -> memref<2xi32>
    %2 = "test.multi_slot_alloca"() : () -> memref<i32>
    "func.call"(%1) <{callee = @consumer}> : (memref<2xi32>) -> ()
    %3 = "memref.load"(%1, %0) : (memref<2xi32>, index) -> i32
    %4 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3, %4) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

