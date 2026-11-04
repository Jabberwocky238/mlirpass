"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32, strided<[?], offset: ?>>) -> (), sym_name = "br"}> ({
  ^bb0(%arg0: memref<5xf32, strided<[?], offset: ?>>):
    %0 = "scf.execute_region"() ({
      "cf.br"(%arg0)[^bb1] : (memref<5xf32, strided<[?], offset: ?>>) -> ()
    ^bb1(%1: memref<5xf32, strided<[?], offset: ?>>):  // pred: ^bb0
      "scf.yield"(%1) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
    }) : () -> memref<5xf32, strided<[?], offset: ?>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32, strided<[?], offset: ?>>, i1) -> (), sym_name = "cond_br"}> ({
  ^bb0(%arg0: memref<5xf32, strided<[?], offset: ?>>, %arg1: i1):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    %1 = "scf.execute_region"() ({
      "cf.cond_br"(%arg1, %arg0, %0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, memref<5xf32, strided<[?], offset: ?>>, memref<5xf32>) -> ()
    ^bb1(%2: memref<5xf32, strided<[?], offset: ?>>):  // 2 preds: ^bb0, ^bb2
      "scf.yield"(%2) : (memref<5xf32, strided<[?], offset: ?>>) -> ()
    ^bb2(%3: memref<5xf32>):  // pred: ^bb0
      %4 = "memref.cast"(%3) : (memref<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
      "cf.br"(%4)[^bb1] : (memref<5xf32, strided<[?], offset: ?>>) -> ()
    }) : () -> memref<5xf32, strided<[?], offset: ?>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<5xf32>, sym_name = "looping_branches"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "cf.br"(%0)[^bb1] : (memref<5xf32>) -> ()
  ^bb1(%1: memref<5xf32>):  // 2 preds: ^bb0, ^bb1
    %2 = "test.foo"() : () -> index
    %3 = "test.bar"() : () -> f32
    "memref.store"(%3, %1, %2) <{nontemporal = false}> : (f32, memref<5xf32>, index) -> ()
    %4 = "test.qux"() : () -> i1
    "cf.cond_br"(%4, %1, %1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, memref<5xf32>, memref<5xf32>) -> ()
  ^bb2(%5: memref<5xf32>):  // pred: ^bb1
    %6 = "memref.cast"(%5) : (memref<5xf32>) -> memref<5xf32, strided<[?], offset: ?>>
    "func.return"(%5) : (memref<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

