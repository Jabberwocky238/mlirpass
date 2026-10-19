"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<8x64xf32>, sym_name = "basic", sym_visibility = "private"}> ({
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x64xf32>
    "test.source"(%2) : (memref<8x64xf32>) -> ()
    "func.return"(%2) : (memref<8x64xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<f32>, sym_name = "basic_no_change", sym_visibility = "private"}> ({
    %1 = "test.source"() : () -> memref<f32>
    "func.return"(%1) : (memref<f32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> memref<?xf32>, sym_name = "basic_dynamic", sym_visibility = "private"}> ({
  ^bb0(%arg2: index):
    %0 = "memref.alloc"(%arg2) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "test.source"(%0) : (memref<?xf32>) -> ()
    "func.return"(%0) : (memref<?xf32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x256xf32>, memref<128x256xf32>) -> memref<128x256xf32>, sym_name = "return_arg", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<128x256xf32>, %arg1: memref<128x256xf32>):
    "test.source"(%arg0, %arg1) : (memref<128x256xf32>, memref<128x256xf32>) -> ()
    "func.return"(%arg0) : (memref<128x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

