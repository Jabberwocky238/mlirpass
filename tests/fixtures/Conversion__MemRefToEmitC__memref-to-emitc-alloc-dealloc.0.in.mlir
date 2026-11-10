"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "alloc_and_dealloc"}> ({
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<999xi32>
    "memref.dealloc"(%3) : (memref<999xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "alloc_and_dealloc_aligned"}> ({
    %2 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<999xf32>
    "memref.dealloc"(%2) : (memref<999xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "allocating_and_deallocating_multi"}> ({
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<7x999xi32>
    "memref.dealloc"(%1) : (memref<7x999xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "alloc_and_dealloc_rank0"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.dealloc"(%0) : (memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

