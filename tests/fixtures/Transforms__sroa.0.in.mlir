"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "multi_slot_alloca"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1:2 = "test.multi_slot_alloca"() : () -> (memref<2xi32>, memref<4xi32>)
    %2 = "memref.load"(%1#0, %0) {first} : (memref<2xi32>, index) -> i32
    %3 = "memref.load"(%1#1, %0) {second} : (memref<4xi32>, index) -> i32
    "func.return"(%2, %3) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xi32>) -> (), sym_name = "consumer", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "multi_slot_alloca_only_second"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1:2 = "test.multi_slot_alloca"() : () -> (memref<2xi32>, memref<4xi32>)
    "func.call"(%1#0) <{callee = @consumer}> : (memref<2xi32>) -> ()
    %2 = "memref.load"(%1#0, %0) : (memref<2xi32>, index) -> i32
    %3 = "memref.load"(%1#1, %0) : (memref<4xi32>, index) -> i32
    "func.return"(%2, %3) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

