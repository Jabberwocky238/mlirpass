// -----
// -----
// -----
// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, index, index) -> f32, sym_name = "yield_alloc_dominance_test_2"}> ({
  ^bb0(%arg0: f32, %arg1: index, %arg2: index):
    %0 = "memref.alloc"(%arg1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    %1 = "scf.execute_region"() ({
      "scf.yield"(%0) : (memref<?xf32>) -> ()
    }) : () -> memref<?xf32>
    "memref.store"(%arg0, %1, %arg1) <{nontemporal = false}> : (f32, memref<?xf32>, index) -> ()
    %2 = "memref.load"(%1, %arg2) <{nontemporal = false}> : (memref<?xf32>, index) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
// -----
// -----
// -----
