"builtin.module"() ({
  "func.func"() <{function_type = (memref<999xi32>) -> (), sym_name = "alloc_copy"}> ({
  ^bb0(%arg0: memref<999xi32>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<999xi32>
    "memref.copy"(%arg0, %0) : (memref<999xi32>, memref<999xi32>) -> ()
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<999xi32>
    "memref.copy"(%arg0, %1) : (memref<999xi32>, memref<999xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

