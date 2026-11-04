"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> (), sym_name = "br"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
    %1 = "scf.execute_region"() ({
      "cf.br"(%0)[^bb1] : (memref<5xf32, strided<[?], offset: ?>>) -> ()
    ^bb1(%2: memref<5xf32, strided<[?], offset: ?>>):  // pred: ^bb0
      "scf.yield"(%2) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
    }) : () -> memref<5xf32, strided<[?], offset: ?>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, i1) -> (), sym_name = "cond_br"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: i1):
    %0 = "bufferization.to_buffer"(%arg0) : (tensor<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    %2 = "scf.execute_region"() ({
      "cf.cond_br"(%arg1, %0, %1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, memref<5xf32, strided<[?], offset: ?>>, memref<5xf32>) -> ()
    ^bb1(%3: memref<5xf32, strided<[?], offset: ?>>):  // 2 preds: ^bb0, ^bb2
      "scf.yield"(%3) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
    ^bb2(%4: memref<5xf32>):  // pred: ^bb0
      %5 = "memref.cast"(%4) : (memref<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
      "cf.br"(%5)[^bb1] : (memref<5xf32, strided<[?], offset: ?>>) -> ()
    }) : () -> memref<5xf32, strided<[?], offset: ?>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<5xf32>, sym_name = "looping_branches"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    %1 = "bufferization.to_tensor"(%0) : (memref<5xf32>) -> tensor<5xf32>
    "cf.br"(%1)[^bb1] : (tensor<5xf32>) -> ()
  ^bb1(%2: tensor<5xf32>):  // 2 preds: ^bb0, ^bb1
    %3 = "bufferization.to_buffer"(%2) : (tensor<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
    %4 = "test.foo"() : () -> index
    %5 = "test.bar"() : () -> f32
    %6 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "memref.copy"(%3, %6) : (memref<5xf32, strided<[?], offset: ?>>, memref<5xf32>) -> ()
    "memref.store"(%5, %6, %4) <{nontemporal = false}> : (f32, memref<5xf32>, index) -> ()
    %7 = "bufferization.to_tensor"(%6) : (memref<5xf32>) -> tensor<5xf32>
    %8 = "test.qux"() : () -> i1
    "cf.cond_br"(%8, %7, %7)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, tensor<5xf32>, tensor<5xf32>) -> ()
  ^bb2(%9: tensor<5xf32>):  // pred: ^bb1
    "func.return"(%9) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

