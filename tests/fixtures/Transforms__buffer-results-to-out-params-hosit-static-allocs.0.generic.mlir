"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x64xf32>) -> (), sym_name = "basic", sym_visibility = "private"}> ({
  ^bb0(%arg6: memref<8x64xf32>):
    "test.source"(%arg6) : (memref<8x64xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "basic_no_change", sym_visibility = "private"}> ({
  ^bb0(%arg5: memref<f32>):
    %1 = "test.source"() : () -> memref<f32>
    "memref.copy"(%1, %arg5) : (memref<f32>, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, memref<?xf32>) -> (), sym_name = "basic_dynamic", sym_visibility = "private"}> ({
  ^bb0(%arg3: index, %arg4: memref<?xf32>):
    %0 = "memref.alloc"(%arg3) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "test.source"(%0) : (memref<?xf32>) -> ()
    "memref.copy"(%0, %arg4) : (memref<?xf32>, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<128x256xf32>, memref<128x256xf32>, memref<128x256xf32>) -> (), sym_name = "return_arg", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<128x256xf32>, %arg1: memref<128x256xf32>, %arg2: memref<128x256xf32>):
    "test.source"(%arg0, %arg1) : (memref<128x256xf32>, memref<128x256xf32>) -> ()
    "memref.copy"(%arg0, %arg2) : (memref<128x256xf32>, memref<128x256xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

