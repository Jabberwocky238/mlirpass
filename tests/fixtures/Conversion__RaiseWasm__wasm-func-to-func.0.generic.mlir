"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> i32, sym_name = "callee"}> ({
  ^bb0(%arg1: i32):
    %4 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg1, %4) : (i32, memref<i32>) -> ()
    %5 = "memref.load"(%4) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    "func.return"(%5) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> i32, sym_name = "caller"}> ({
  ^bb0(%arg0: i32):
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg0, %1) : (i32, memref<i32>) -> ()
    %2 = "memref.load"(%1) <{invariant = false, nontemporal = false}> : (memref<i32>) -> i32
    %3 = "func.call"(%2) <{callee = @callee}> : (i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "my_module::foo", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "user_of_func0"}> ({
    %0 = "func.call"() <{callee = @"my_module::foo"}> : () -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

