"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (f32, f32), sym_name = "out_of_place_bufferization"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %1 = "bufferization.to_buffer"(%arg0) : (tensor<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 5 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "memref.dim"(%1, %4) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %6 = "memref.alloc"(%5) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%1, %6) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    "memref.store"(%2, %6, %3) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
    %7 = "memref.load"(%0, %3) <{nontemporal = false}> : (memref<?xf32, strided<[?], offset: ?>>, index) -> f32
    %8 = "memref.load"(%6, %3) <{nontemporal = false}> : (memref<?xf32>, index) -> f32
    "func.return"(%7, %8) : (f32, f32) -> ()
  }) : () -> ()
}) : () -> ()

