"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<2xf32>, memref<2xf32>) -> (), sym_name = "condBranch"}> ({
  ^bb0(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>):
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%arg1)[^bb3] : (memref<2xf32>) -> ()
  ^bb2:  // pred: ^bb0
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "test.buffer_based"(%arg1, %0) : (memref<2xf32>, memref<2xf32>) -> ()
    "cf.br"(%0)[^bb3] : (memref<2xf32>) -> ()
  ^bb3(%1: memref<2xf32>):  // 2 preds: ^bb1, ^bb2
    "test.copy"(%1, %arg2) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<?xf32>, memref<?xf32>, index) -> (), sym_name = "condBranchDynamicType"}> ({
  ^bb0(%arg0: i1, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: index):
    "cf.cond_br"(%arg0, %arg3)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, index) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%arg1)[^bb3] : (memref<?xf32>) -> ()
  ^bb2(%0: index):  // pred: ^bb0
    %1 = "memref.alloc"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "test.buffer_based"(%arg1, %1) : (memref<?xf32>, memref<?xf32>) -> ()
    "cf.br"(%1)[^bb3] : (memref<?xf32>) -> ()
  ^bb3(%2: memref<?xf32>):  // 2 preds: ^bb1, ^bb2
    "test.copy"(%2, %arg2) : (memref<?xf32>, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> (), sym_name = "dynamicRanked"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "memref.rank"(%arg0) : (memref<*xf32>) -> index
    %1 = "memref.alloca"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> (), sym_name = "dynamicRanked2D"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "memref.rank"(%arg0) : (memref<*xf32>) -> index
    %1 = "memref.alloc"(%0, %0) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "dynamicNoRank"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"(%arg0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4xf32>) -> (), sym_name = "emptyUsesValue"}> ({
  ^bb0(%arg0: memref<4xf32>):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<2xf32>, memref<2xf32>) -> (), sym_name = "criticalEdge"}> ({
  ^bb0(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>):
    "cf.cond_br"(%arg0, %arg1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, memref<2xf32>) -> ()
  ^bb1:  // pred: ^bb0
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "test.buffer_based"(%arg1, %0) : (memref<2xf32>, memref<2xf32>) -> ()
    "cf.br"(%0)[^bb2] : (memref<2xf32>) -> ()
  ^bb2(%1: memref<2xf32>):  // 2 preds: ^bb0, ^bb1
    "test.copy"(%1, %arg2) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<2xf32>, memref<2xf32>) -> (), sym_name = "invCriticalEdge"}> ({
  ^bb0(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "test.buffer_based"(%arg1, %0) : (memref<2xf32>, memref<2xf32>) -> ()
    "cf.cond_br"(%arg0, %arg1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, memref<2xf32>) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%0)[^bb2] : (memref<2xf32>) -> ()
  ^bb2(%1: memref<2xf32>):  // 2 preds: ^bb0, ^bb1
    "test.copy"(%1, %arg2) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<2xf32>, memref<2xf32>) -> (), sym_name = "ifElse"}> ({
  ^bb0(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "test.buffer_based"(%arg1, %0) : (memref<2xf32>, memref<2xf32>) -> ()
    "cf.cond_br"(%arg0, %arg1, %0, %0, %arg1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 2, 2>}> : (i1, memref<2xf32>, memref<2xf32>, memref<2xf32>, memref<2xf32>) -> ()
  ^bb1(%1: memref<2xf32>, %2: memref<2xf32>):  // pred: ^bb0
    "cf.br"(%1, %2)[^bb3] : (memref<2xf32>, memref<2xf32>) -> ()
  ^bb2(%3: memref<2xf32>, %4: memref<2xf32>):  // pred: ^bb0
    "cf.br"(%3, %4)[^bb3] : (memref<2xf32>, memref<2xf32>) -> ()
  ^bb3(%5: memref<2xf32>, %6: memref<2xf32>):  // 2 preds: ^bb1, ^bb2
    %7 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "test.buffer_based"(%5, %7) : (memref<2xf32>, memref<2xf32>) -> ()
    "test.copy"(%7, %arg2) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<2xf32>, memref<2xf32>) -> (), sym_name = "ifElseNoUsers"}> ({
  ^bb0(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "test.buffer_based"(%arg1, %0) : (memref<2xf32>, memref<2xf32>) -> ()
    "cf.cond_br"(%arg0, %arg1, %0, %0, %arg1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 2, 2>}> : (i1, memref<2xf32>, memref<2xf32>, memref<2xf32>, memref<2xf32>) -> ()
  ^bb1(%1: memref<2xf32>, %2: memref<2xf32>):  // pred: ^bb0
    "cf.br"(%1, %2)[^bb3] : (memref<2xf32>, memref<2xf32>) -> ()
  ^bb2(%3: memref<2xf32>, %4: memref<2xf32>):  // pred: ^bb0
    "cf.br"(%3, %4)[^bb3] : (memref<2xf32>, memref<2xf32>) -> ()
  ^bb3(%5: memref<2xf32>, %6: memref<2xf32>):  // 2 preds: ^bb1, ^bb2
    "test.copy"(%arg1, %arg2) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<2xf32>, memref<2xf32>) -> (), sym_name = "ifElseNested"}> ({
  ^bb0(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "test.buffer_based"(%arg1, %0) : (memref<2xf32>, memref<2xf32>) -> ()
    "cf.cond_br"(%arg0, %arg1, %0, %0, %arg1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 2, 2>}> : (i1, memref<2xf32>, memref<2xf32>, memref<2xf32>, memref<2xf32>) -> ()
  ^bb1(%1: memref<2xf32>, %2: memref<2xf32>):  // pred: ^bb0
    "cf.br"(%1, %2)[^bb5] : (memref<2xf32>, memref<2xf32>) -> ()
  ^bb2(%3: memref<2xf32>, %4: memref<2xf32>):  // pred: ^bb0
    "cf.cond_br"(%arg0, %3, %4)[^bb3, ^bb4] <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (i1, memref<2xf32>, memref<2xf32>) -> ()
  ^bb3(%5: memref<2xf32>):  // pred: ^bb2
    "cf.br"(%5, %3)[^bb5] : (memref<2xf32>, memref<2xf32>) -> ()
  ^bb4(%6: memref<2xf32>):  // pred: ^bb2
    "cf.br"(%3, %6)[^bb5] : (memref<2xf32>, memref<2xf32>) -> ()
  ^bb5(%7: memref<2xf32>, %8: memref<2xf32>):  // 3 preds: ^bb1, ^bb3, ^bb4
    %9 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "test.buffer_based"(%7, %9) : (memref<2xf32>, memref<2xf32>) -> ()
    "test.copy"(%9, %arg2) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xf32>) -> (), sym_name = "redundantOperations"}> ({
  ^bb0(%arg0: memref<2xf32>):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "test.buffer_based"(%arg0, %0) : (memref<2xf32>, memref<2xf32>) -> ()
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "test.buffer_based"(%0, %1) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<2xf32>, memref<2xf32>) -> (), sym_name = "moving_alloc_and_inserting_missing_dealloc"}> ({
  ^bb0(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>):
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "test.buffer_based"(%arg1, %0) : (memref<2xf32>, memref<2xf32>) -> ()
    "cf.br"(%0)[^bb3] : (memref<2xf32>) -> ()
  ^bb2:  // pred: ^bb0
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "test.buffer_based"(%arg1, %1) : (memref<2xf32>, memref<2xf32>) -> ()
    "cf.br"(%1)[^bb3] : (memref<2xf32>) -> ()
  ^bb3(%2: memref<2xf32>):  // 2 preds: ^bb1, ^bb2
    "test.copy"(%2, %arg2) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, memref<2xf32>, memref<2xf32>) -> (), sym_name = "nested_regions_and_cond_branch"}> ({
  ^bb0(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>):
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%arg1)[^bb3] : (memref<2xf32>) -> ()
  ^bb2:  // pred: ^bb0
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "test.region_buffer_based"(%arg1, %0) ({
    ^bb0(%arg3: f32, %arg4: f32):
      %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
      "test.buffer_based"(%arg1, %2) : (memref<2xf32>, memref<2xf32>) -> ()
      %3 = "math.exp"(%arg3) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "test.region_yield"(%3) : (f32) -> ()
    }) : (memref<2xf32>, memref<2xf32>) -> ()
    "cf.br"(%0)[^bb3] : (memref<2xf32>) -> ()
  ^bb3(%1: memref<2xf32>):  // 2 preds: ^bb1, ^bb2
    "test.copy"(%1, %arg2) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<5xf32>, memref<10xf32>, memref<5xf32>) -> (memref<10xf32>, memref<15xf32>), sym_name = "memref_in_function_results"}> ({
  ^bb0(%arg0: memref<5xf32>, %arg1: memref<10xf32>, %arg2: memref<5xf32>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<15xf32>
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "test.buffer_based"(%arg0, %1) : (memref<5xf32>, memref<5xf32>) -> ()
    "test.copy"(%1, %arg2) : (memref<5xf32>, memref<5xf32>) -> ()
    "func.return"(%arg1, %0) : (memref<10xf32>, memref<15xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> memref<?x?xf32>, sym_name = "nested_region_control_flow"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.cmpi"(%arg0, %arg1) <{predicate = 0 : i64}> : (index, index) -> i1
    %1 = "memref.alloc"(%arg0, %arg0) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    %2 = "scf.if"(%0) ({
      "scf.yield"(%1) : (memref<?x?xf32>) -> ()
    }, {
      %3 = "memref.alloc"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
      "scf.yield"(%1) : (memref<?x?xf32>) -> ()
    }) : (i1) -> memref<?x?xf32>
    "func.return"(%2) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> memref<2x2xf32>, sym_name = "inner_region_control_flow"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x2xf32>
    %1 = "test.region_if"(%0) ({
    ^bb0(%arg3: memref<2x2xf32>):
      "test.region_if_yield"(%arg3) : (memref<2x2xf32>) -> ()
    }, {
    ^bb0(%arg2: memref<2x2xf32>):
      "test.region_if_yield"(%arg2) : (memref<2x2xf32>) -> ()
    }, {
    ^bb0(%arg1: memref<2x2xf32>):
      "test.region_if_yield"(%arg1) : (memref<2x2xf32>) -> ()
    }) : (memref<2x2xf32>) -> memref<2x2xf32>
    "func.return"(%1) : (memref<2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, memref<2xf32>, memref<2xf32>) -> (), sym_name = "loop_alloc"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<2xf32>, %arg4: memref<2xf32>):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    %1 = "scf.for"(%arg0, %arg1, %arg2, %arg3) ({
    ^bb0(%arg5: index, %arg6: memref<2xf32>):
      %2 = "arith.cmpi"(%arg5, %arg1) <{predicate = 0 : i64}> : (index, index) -> i1
      %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
      "scf.yield"(%3) : (memref<2xf32>) -> ()
    }) : (index, index, index, memref<2xf32>) -> memref<2xf32>
    "test.copy"(%1, %arg4) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, memref<2xf32>, memref<2xf32>) -> (), sym_name = "loop_nested_if_no_alloc"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<2xf32>, %arg4: memref<2xf32>):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    %1 = "scf.for"(%arg0, %arg1, %arg2, %arg3) ({
    ^bb0(%arg5: index, %arg6: memref<2xf32>):
      %2 = "arith.cmpi"(%arg5, %arg1) <{predicate = 0 : i64}> : (index, index) -> i1
      %3 = "scf.if"(%2) ({
        "scf.yield"(%0) : (memref<2xf32>) -> ()
      }, {
        "scf.yield"(%arg6) : (memref<2xf32>) -> ()
      }) : (i1) -> memref<2xf32>
      "scf.yield"(%3) : (memref<2xf32>) -> ()
    }) : (index, index, index, memref<2xf32>) -> memref<2xf32>
    "test.copy"(%1, %arg4) : (memref<2xf32>, memref<2xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, memref<2xf32>) -> memref<2xf32>, sym_name = "loop_nested_if_alloc"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<2xf32>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    %1 = "scf.for"(%arg0, %arg1, %arg2, %arg3) ({
    ^bb0(%arg4: index, %arg5: memref<2xf32>):
      %2 = "arith.cmpi"(%arg4, %arg1) <{predicate = 0 : i64}> : (index, index) -> i1
      %3 = "scf.if"(%2) ({
        %4 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
        "scf.yield"(%4) : (memref<2xf32>) -> ()
      }, {
        "scf.yield"(%0) : (memref<2xf32>) -> ()
      }) : (i1) -> memref<2xf32>
      "scf.yield"(%3) : (memref<2xf32>) -> ()
    }) : (index, index, index, memref<2xf32>) -> memref<2xf32>
    "func.return"(%1) : (memref<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2048xf32>) -> (), sym_name = "large_buffer_allocation"}> ({
  ^bb0(%arg0: memref<2048xf32>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2048xf32>
    "test.copy"(%0, %arg0) : (memref<2048xf32>, memref<2048xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "indexElementType"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "bigIndexElementType"}> ({
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> {custom_attr} : () -> memref<4xindex>
    "func.return"() : () -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<index = 256 : i64>} : () -> ()

