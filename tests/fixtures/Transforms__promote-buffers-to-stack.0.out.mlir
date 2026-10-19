module {
  func.func @condBranch(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>) {
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    cf.br ^bb3(%arg1 : memref<2xf32>)
  ^bb2:  // pred: ^bb0
    %alloca = memref.alloca() : memref<2xf32>
    test.buffer_based in(%arg1 : memref<2xf32>) out(%alloca : memref<2xf32>)
    cf.br ^bb3(%alloca : memref<2xf32>)
  ^bb3(%0: memref<2xf32>):  // 2 preds: ^bb1, ^bb2
    test.copy(%0, %arg2) : (memref<2xf32>, memref<2xf32>)
    return
  }
}

// -----
module {
  func.func @condBranchDynamicType(%arg0: i1, %arg1: memref<?xf32>, %arg2: memref<?xf32>, %arg3: index) {
    cf.cond_br %arg0, ^bb1, ^bb2(%arg3 : index)
  ^bb1:  // pred: ^bb0
    cf.br ^bb3(%arg1 : memref<?xf32>)
  ^bb2(%0: index):  // pred: ^bb0
    %alloc = memref.alloc(%0) : memref<?xf32>
    test.buffer_based in(%arg1 : memref<?xf32>) out(%alloc : memref<?xf32>)
    cf.br ^bb3(%alloc : memref<?xf32>)
  ^bb3(%1: memref<?xf32>):  // 2 preds: ^bb1, ^bb2
    test.copy(%1, %arg2) : (memref<?xf32>, memref<?xf32>)
    return
  }
}

// -----
module {
  func.func @dynamicRanked(%arg0: memref<*xf32>) {
    %0 = memref.rank %arg0 : memref<*xf32>
    %alloca = memref.alloca(%0) : memref<?xindex>
    return
  }
}

// -----
module {
  func.func @dynamicRanked2D(%arg0: memref<*xf32>) {
    %0 = memref.rank %arg0 : memref<*xf32>
    %alloc = memref.alloc(%0, %0) : memref<?x?xindex>
    return
  }
}

// -----
module {
  func.func @dynamicNoRank(%arg0: index) {
    %alloc = memref.alloc(%arg0) : memref<?xindex>
    return
  }
}

// -----
module {
  func.func @emptyUsesValue(%arg0: memref<4xf32>) {
    %alloca = memref.alloca() : memref<4xf32>
    return
  }
}

// -----
module {
  func.func @criticalEdge(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>) {
    cf.cond_br %arg0, ^bb1, ^bb2(%arg1 : memref<2xf32>)
  ^bb1:  // pred: ^bb0
    %alloca = memref.alloca() : memref<2xf32>
    test.buffer_based in(%arg1 : memref<2xf32>) out(%alloca : memref<2xf32>)
    cf.br ^bb2(%alloca : memref<2xf32>)
  ^bb2(%0: memref<2xf32>):  // 2 preds: ^bb0, ^bb1
    test.copy(%0, %arg2) : (memref<2xf32>, memref<2xf32>)
    return
  }
}

// -----
module {
  func.func @invCriticalEdge(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>) {
    %alloca = memref.alloca() : memref<2xf32>
    test.buffer_based in(%arg1 : memref<2xf32>) out(%alloca : memref<2xf32>)
    cf.cond_br %arg0, ^bb1, ^bb2(%arg1 : memref<2xf32>)
  ^bb1:  // pred: ^bb0
    cf.br ^bb2(%alloca : memref<2xf32>)
  ^bb2(%0: memref<2xf32>):  // 2 preds: ^bb0, ^bb1
    test.copy(%0, %arg2) : (memref<2xf32>, memref<2xf32>)
    return
  }
}

// -----
module {
  func.func @ifElse(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>) {
    %alloca = memref.alloca() : memref<2xf32>
    test.buffer_based in(%arg1 : memref<2xf32>) out(%alloca : memref<2xf32>)
    cf.cond_br %arg0, ^bb1(%arg1, %alloca : memref<2xf32>, memref<2xf32>), ^bb2(%alloca, %arg1 : memref<2xf32>, memref<2xf32>)
  ^bb1(%0: memref<2xf32>, %1: memref<2xf32>):  // pred: ^bb0
    cf.br ^bb3(%0, %1 : memref<2xf32>, memref<2xf32>)
  ^bb2(%2: memref<2xf32>, %3: memref<2xf32>):  // pred: ^bb0
    cf.br ^bb3(%2, %3 : memref<2xf32>, memref<2xf32>)
  ^bb3(%4: memref<2xf32>, %5: memref<2xf32>):  // 2 preds: ^bb1, ^bb2
    %alloca_0 = memref.alloca() : memref<2xf32>
    test.buffer_based in(%4 : memref<2xf32>) out(%alloca_0 : memref<2xf32>)
    test.copy(%alloca_0, %arg2) : (memref<2xf32>, memref<2xf32>)
    return
  }
}

// -----
module {
  func.func @ifElseNoUsers(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>) {
    %alloca = memref.alloca() : memref<2xf32>
    test.buffer_based in(%arg1 : memref<2xf32>) out(%alloca : memref<2xf32>)
    cf.cond_br %arg0, ^bb1(%arg1, %alloca : memref<2xf32>, memref<2xf32>), ^bb2(%alloca, %arg1 : memref<2xf32>, memref<2xf32>)
  ^bb1(%0: memref<2xf32>, %1: memref<2xf32>):  // pred: ^bb0
    cf.br ^bb3(%0, %1 : memref<2xf32>, memref<2xf32>)
  ^bb2(%2: memref<2xf32>, %3: memref<2xf32>):  // pred: ^bb0
    cf.br ^bb3(%2, %3 : memref<2xf32>, memref<2xf32>)
  ^bb3(%4: memref<2xf32>, %5: memref<2xf32>):  // 2 preds: ^bb1, ^bb2
    test.copy(%arg1, %arg2) : (memref<2xf32>, memref<2xf32>)
    return
  }
}

// -----
module {
  func.func @ifElseNested(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>) {
    %alloca = memref.alloca() : memref<2xf32>
    test.buffer_based in(%arg1 : memref<2xf32>) out(%alloca : memref<2xf32>)
    cf.cond_br %arg0, ^bb1(%arg1, %alloca : memref<2xf32>, memref<2xf32>), ^bb2(%alloca, %arg1 : memref<2xf32>, memref<2xf32>)
  ^bb1(%0: memref<2xf32>, %1: memref<2xf32>):  // pred: ^bb0
    cf.br ^bb5(%0, %1 : memref<2xf32>, memref<2xf32>)
  ^bb2(%2: memref<2xf32>, %3: memref<2xf32>):  // pred: ^bb0
    cf.cond_br %arg0, ^bb3(%2 : memref<2xf32>), ^bb4(%3 : memref<2xf32>)
  ^bb3(%4: memref<2xf32>):  // pred: ^bb2
    cf.br ^bb5(%4, %2 : memref<2xf32>, memref<2xf32>)
  ^bb4(%5: memref<2xf32>):  // pred: ^bb2
    cf.br ^bb5(%2, %5 : memref<2xf32>, memref<2xf32>)
  ^bb5(%6: memref<2xf32>, %7: memref<2xf32>):  // 3 preds: ^bb1, ^bb3, ^bb4
    %alloca_0 = memref.alloca() : memref<2xf32>
    test.buffer_based in(%6 : memref<2xf32>) out(%alloca_0 : memref<2xf32>)
    test.copy(%alloca_0, %arg2) : (memref<2xf32>, memref<2xf32>)
    return
  }
}

// -----
module {
  func.func @redundantOperations(%arg0: memref<2xf32>) {
    %alloca = memref.alloca() : memref<2xf32>
    test.buffer_based in(%arg0 : memref<2xf32>) out(%alloca : memref<2xf32>)
    %alloca_0 = memref.alloca() : memref<2xf32>
    test.buffer_based in(%alloca : memref<2xf32>) out(%alloca_0 : memref<2xf32>)
    return
  }
}

// -----
module {
  func.func @moving_alloc_and_inserting_missing_dealloc(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>) {
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %alloca = memref.alloca() : memref<2xf32>
    test.buffer_based in(%arg1 : memref<2xf32>) out(%alloca : memref<2xf32>)
    cf.br ^bb3(%alloca : memref<2xf32>)
  ^bb2:  // pred: ^bb0
    %alloca_0 = memref.alloca() : memref<2xf32>
    test.buffer_based in(%arg1 : memref<2xf32>) out(%alloca_0 : memref<2xf32>)
    cf.br ^bb3(%alloca_0 : memref<2xf32>)
  ^bb3(%0: memref<2xf32>):  // 2 preds: ^bb1, ^bb2
    test.copy(%0, %arg2) : (memref<2xf32>, memref<2xf32>)
    return
  }
}

// -----
module {
  func.func @nested_regions_and_cond_branch(%arg0: i1, %arg1: memref<2xf32>, %arg2: memref<2xf32>) {
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    cf.br ^bb3(%arg1 : memref<2xf32>)
  ^bb2:  // pred: ^bb0
    %alloca = memref.alloca() : memref<2xf32>
    test.region_buffer_based in(%arg1 : memref<2xf32>) out(%alloca : memref<2xf32>) {
    ^bb0(%arg3: f32, %arg4: f32):
      %alloc = memref.alloc() : memref<2xf32>
      test.buffer_based in(%arg1 : memref<2xf32>) out(%alloc : memref<2xf32>)
      %1 = math.exp %arg3 : f32
      test.region_yield %1 : f32
    }
    cf.br ^bb3(%alloca : memref<2xf32>)
  ^bb3(%0: memref<2xf32>):  // 2 preds: ^bb1, ^bb2
    test.copy(%0, %arg2) : (memref<2xf32>, memref<2xf32>)
    return
  }
}

// -----
module {
  func.func @memref_in_function_results(%arg0: memref<5xf32>, %arg1: memref<10xf32>, %arg2: memref<5xf32>) -> (memref<10xf32>, memref<15xf32>) {
    %alloc = memref.alloc() : memref<15xf32>
    %alloca = memref.alloca() : memref<5xf32>
    test.buffer_based in(%arg0 : memref<5xf32>) out(%alloca : memref<5xf32>)
    test.copy(%alloca, %arg2) : (memref<5xf32>, memref<5xf32>)
    return %arg1, %alloc : memref<10xf32>, memref<15xf32>
  }
}

// -----
module {
  func.func @nested_region_control_flow(%arg0: index, %arg1: index) -> memref<?x?xf32> {
    %0 = arith.cmpi eq, %arg0, %arg1 : index
    %alloc = memref.alloc(%arg0, %arg0) : memref<?x?xf32>
    %1 = scf.if %0 -> (memref<?x?xf32>) {
      scf.yield %alloc : memref<?x?xf32>
    } else {
      %alloc_0 = memref.alloc(%arg0, %arg1) : memref<?x?xf32>
      scf.yield %alloc : memref<?x?xf32>
    }
    return %1 : memref<?x?xf32>
  }
}

// -----
module {
  func.func @inner_region_control_flow(%arg0: index) -> memref<2x2xf32> {
    %alloc = memref.alloc() : memref<2x2xf32>
    %0 = test.region_if %alloc: memref<2x2xf32> -> memref<2x2xf32> then {
    ^bb0(%arg1: memref<2x2xf32>):
      test.region_if_yield %arg1 : memref<2x2xf32>
    } else {
    ^bb0(%arg1: memref<2x2xf32>):
      test.region_if_yield %arg1 : memref<2x2xf32>
    } join {
    ^bb0(%arg1: memref<2x2xf32>):
      test.region_if_yield %arg1 : memref<2x2xf32>
    }
    return %0 : memref<2x2xf32>
  }
}

// -----
module {
  func.func @loop_alloc(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<2xf32>, %arg4: memref<2xf32>) {
    %alloca = memref.alloca() : memref<2xf32>
    %0 = scf.for %arg5 = %arg0 to %arg1 step %arg2 iter_args(%arg6 = %arg3) -> (memref<2xf32>) {
      %1 = arith.cmpi eq, %arg5, %arg1 : index
      %alloc = memref.alloc() : memref<2xf32>
      scf.yield %alloc : memref<2xf32>
    }
    test.copy(%0, %arg4) : (memref<2xf32>, memref<2xf32>)
    return
  }
}

// -----
module {
  func.func @loop_nested_if_no_alloc(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<2xf32>, %arg4: memref<2xf32>) {
    %alloca = memref.alloca() : memref<2xf32>
    %0 = scf.for %arg5 = %arg0 to %arg1 step %arg2 iter_args(%arg6 = %arg3) -> (memref<2xf32>) {
      %1 = arith.cmpi eq, %arg5, %arg1 : index
      %2 = scf.if %1 -> (memref<2xf32>) {
        scf.yield %alloca : memref<2xf32>
      } else {
        scf.yield %arg6 : memref<2xf32>
      }
      scf.yield %2 : memref<2xf32>
    }
    test.copy(%0, %arg4) : (memref<2xf32>, memref<2xf32>)
    return
  }
}

// -----
module {
  func.func @loop_nested_if_alloc(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<2xf32>) -> memref<2xf32> {
    %alloc = memref.alloc() : memref<2xf32>
    %0 = scf.for %arg4 = %arg0 to %arg1 step %arg2 iter_args(%arg5 = %arg3) -> (memref<2xf32>) {
      %1 = arith.cmpi eq, %arg4, %arg1 : index
      %2 = scf.if %1 -> (memref<2xf32>) {
        %alloc_0 = memref.alloc() : memref<2xf32>
        scf.yield %alloc_0 : memref<2xf32>
      } else {
        scf.yield %alloc : memref<2xf32>
      }
      scf.yield %2 : memref<2xf32>
    }
    return %0 : memref<2xf32>
  }
}

// -----
module {
  func.func @large_buffer_allocation(%arg0: memref<2048xf32>) {
    %alloc = memref.alloc() : memref<2048xf32>
    test.copy(%alloc, %arg0) : (memref<2048xf32>, memref<2048xf32>)
    return
  }
}

// -----
module {
  func.func @indexElementType() {
    %alloca = memref.alloca() : memref<4xindex>
    return
  }
}

// -----
module attributes {dlti.dl_spec = #dlti.dl_spec<index = 256 : i64>} {
  func.func @bigIndexElementType() {
    %alloca = memref.alloca() {alignment = 64 : i64, custom_attr} : memref<4xindex>
    return
  }
}

