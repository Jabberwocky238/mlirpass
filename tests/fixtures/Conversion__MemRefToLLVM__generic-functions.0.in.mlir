"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<f32>, sym_name = "zero_d_alloc"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "func.return"(%0) : (memref<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "dealloc"}> ({
  ^bb0(%arg0: memref<f32>):
    "memref.dealloc"(%arg0) : (memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

