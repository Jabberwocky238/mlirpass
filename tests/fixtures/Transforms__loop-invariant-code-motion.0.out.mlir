module {
  func.func @nested_loops_both_having_invariant_code() {
    %alloc = memref.alloc() : memref<10xf32>
    %cst = arith.constant 7.000000e+00 : f32
    %cst_0 = arith.constant 8.000000e+00 : f32
    %0 = arith.addf %cst, %cst_0 : f32
    %1 = arith.addf %0, %cst_0 : f32
    affine.for %arg0 = 0 to 10 {
      affine.for %arg1 = 0 to 10 {
        affine.store %0, %alloc[%arg0] : memref<10xf32>
      }
    }
    return
  }
}

// -----
module {
  func.func @nested_loops_code_invariant_to_both() {
    %alloc = memref.alloc() : memref<10xf32>
    %cst = arith.constant 7.000000e+00 : f32
    %cst_0 = arith.constant 8.000000e+00 : f32
    %0 = arith.addf %cst, %cst_0 : f32
    affine.for %arg0 = 0 to 10 {
    }
    affine.for %arg0 = 0 to 10 {
    }
    return
  }
}

// -----
module {
  func.func @single_loop_nothing_invariant() {
    %alloc = memref.alloc() : memref<10xf32>
    %alloc_0 = memref.alloc() : memref<10xf32>
    affine.for %arg0 = 0 to 10 {
      %0 = affine.load %alloc[%arg0] : memref<10xf32>
      %1 = affine.load %alloc_0[%arg0] : memref<10xf32>
      %2 = arith.addf %0, %1 : f32
      affine.store %2, %alloc[%arg0] : memref<10xf32>
    }
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0 + 1)>
#set = affine_set<(d0, d1) : (d1 - d0 >= 0)>
module {
  func.func @invariant_code_inside_affine_if() {
    %alloc = memref.alloc() : memref<10xf32>
    %cst = arith.constant 8.000000e+00 : f32
    affine.for %arg0 = 0 to 10 {
      %0 = affine.apply #map(%arg0)
      affine.if #set(%arg0, %0) {
        %1 = arith.addf %cst, %cst : f32
        affine.store %1, %alloc[%arg0] : memref<10xf32>
      }
    }
    return
  }
}

// -----
#set = affine_set<(d0, d1) : (d1 - d0 >= 0)>
module {
  func.func @invariant_affine_if() {
    %alloc = memref.alloc() : memref<10xf32>
    %cst = arith.constant 8.000000e+00 : f32
    affine.for %arg0 = 0 to 20 {
    }
    affine.for %arg0 = 0 to 10 {
      affine.if #set(%arg0, %arg0) {
        %0 = arith.addf %cst, %cst : f32
      }
    }
    return
  }
}

// -----
#set = affine_set<() : (0 == 0)>
module {
  func.func @hoist_invariant_affine_if_success(%arg0: index, %arg1: index, %arg2: index) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %c42_i32 = arith.constant 42 : i32
    %0 = affine.if #set() -> i32 {
      %2 = arith.addi %c42_i32, %c42_i32 : i32
      affine.yield %2 : i32
    } else {
      %2 = ub.poison : i32
      affine.yield %2 : i32
    }
    %1 = affine.for %arg3 = %arg0 to %arg1 iter_args(%arg4 = %c0_i32) -> (i32) {
      %2 = arith.addi %arg4, %0 : i32
      affine.yield %2 : i32
    }
    return %1 : i32
  }
}

// -----
#set = affine_set<(d0, d1) : (d1 - d0 >= 0)>
module {
  func.func @hoist_variant_affine_if_failure(%arg0: index, %arg1: index, %arg2: index) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %c42_i32 = arith.constant 42 : i32
    %c7 = arith.constant 7 : index
    %0 = affine.for %arg3 = %arg0 to %arg1 iter_args(%arg4 = %c0_i32) -> (i32) {
      %1 = affine.if #set(%arg3, %c7) -> i32 {
        %3 = arith.addi %c42_i32, %c42_i32 : i32
        affine.yield %3 : i32
      } else {
        %3 = ub.poison : i32
        affine.yield %3 : i32
      }
      %2 = arith.addi %arg4, %1 : i32
      affine.yield %2 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @hoist_affine_for_with_unknown_trip_count(%arg0: index, %arg1: index) {
    affine.for %arg2 = %arg0 to %arg1 {
    }
    affine.for %arg2 = 0 to 10 {
    }
    return
  }
}

// -----
module {
  func.func @hoist_affine_for_with_unknown_trip_count_non_unit_step(%arg0: index, %arg1: index) {
    affine.for %arg2 = 0 to 10 {
      affine.for %arg3 = %arg0 to %arg1 step 2 {
      }
    }
    return
  }
}

// -----
module {
  func.func @hoist_scf_for_with_unknown_trip_count_unit_step(%arg0: index, %arg1: index) {
    %c1 = arith.constant 1 : index
    scf.for %arg2 = %arg0 to %arg1 step %c1 {
    }
    scf.for %arg2 = %arg0 to %arg1 step %c1 {
    }
    return
  }
}

// -----
module {
  func.func @hoist_scf_for_with_unknown_trip_count_non_unit_constant_step(%arg0: index, %arg1: index) {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    scf.for %arg2 = %arg0 to %arg1 step %c1 {
      scf.for %arg3 = %arg0 to %arg1 step %c2 {
      }
    }
    return
  }
}

// -----
module {
  func.func @hoist_scf_for_with_unknown_trip_count_unknown_step(%arg0: index, %arg1: index, %arg2: index) {
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %arg0 to %arg1 step %c1 {
      scf.for %arg4 = %arg0 to %arg1 step %arg2 {
      }
    }
    return
  }
}

// -----
#set = affine_set<(d0, d1) : (d1 - d0 >= 0)>
module {
  func.func @invariant_affine_if2() {
    %alloc = memref.alloc() : memref<10xf32>
    %cst = arith.constant 8.000000e+00 : f32
    affine.for %arg0 = 0 to 10 {
      affine.for %arg1 = 0 to 10 {
        affine.if #set(%arg0, %arg0) {
          %0 = arith.addf %cst, %cst : f32
          affine.store %0, %alloc[%arg1] : memref<10xf32>
        }
      }
    }
    return
  }
}

// -----
#set = affine_set<(d0, d1) : (d1 - d0 >= 0)>
module {
  func.func @invariant_affine_nested_if() {
    %alloc = memref.alloc() : memref<10xf32>
    %cst = arith.constant 8.000000e+00 : f32
    affine.for %arg0 = 0 to 10 {
    }
    affine.for %arg0 = 0 to 10 {
      affine.if #set(%arg0, %arg0) {
        %0 = arith.addf %cst, %cst : f32
        affine.if #set(%arg0, %arg0) {
          %1 = arith.addf %0, %0 : f32
        }
      }
    }
    return
  }
}

// -----
#set = affine_set<(d0, d1) : (d1 - d0 >= 0)>
module {
  func.func @invariant_affine_nested_if_else() {
    %alloc = memref.alloc() : memref<10xf32>
    %cst = arith.constant 8.000000e+00 : f32
    affine.for %arg0 = 0 to 10 {
      affine.for %arg1 = 0 to 10 {
        affine.if #set(%arg0, %arg0) {
          %0 = arith.addf %cst, %cst : f32
          affine.store %0, %alloc[%arg0] : memref<10xf32>
          affine.if #set(%arg0, %arg0) {
            %1 = arith.addf %0, %0 : f32
          } else {
            affine.store %0, %alloc[%arg1] : memref<10xf32>
          }
        }
      }
    }
    return
  }
}

// -----
module {
  func.func @invariant_loop_dialect() {
    %c0 = arith.constant 0 : index
    %c10 = arith.constant 10 : index
    %c1 = arith.constant 1 : index
    %alloc = memref.alloc() : memref<10xf32>
    %cst = arith.constant 7.000000e+00 : f32
    %cst_0 = arith.constant 8.000000e+00 : f32
    %0 = arith.addf %cst, %cst_0 : f32
    scf.for %arg0 = %c0 to %c10 step %c1 {
    }
    scf.for %arg0 = %c0 to %c10 step %c1 {
    }
    return
  }
}

// -----
module {
  func.func @variant_loop_dialect() {
    %c0 = arith.constant 0 : index
    %c10 = arith.constant 10 : index
    %c1 = arith.constant 1 : index
    %alloc = memref.alloc() : memref<10xf32>
    scf.for %arg0 = %c0 to %c10 step %c1 {
      scf.for %arg1 = %c0 to %c10 step %c1 {
        %0 = arith.addi %arg0, %arg1 : index
      }
    }
    return
  }
}

// -----
module {
  func.func @parallel_loop_with_invariant() {
    %c0 = arith.constant 0 : index
    %c10 = arith.constant 10 : index
    %c1 = arith.constant 1 : index
    %c7_i32 = arith.constant 7 : i32
    %c8_i32 = arith.constant 8 : i32
    %0 = arith.addi %c7_i32, %c8_i32 : i32
    scf.parallel (%arg0, %arg1) = (%c0, %c0) to (%c10, %c10) step (%c1, %c1) {
      %1 = arith.addi %arg0, %arg1 : index
      scf.reduce 
    }
    return
  }
}

// -----
module {
  func.func @hoist_invariant_scf_if_success(%arg0: index, %arg1: index, %arg2: index) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %c42_i32 = arith.constant 42 : i32
    %true = arith.constant true
    %0 = scf.if %true -> (i32) {
      %2 = arith.addi %c42_i32, %c42_i32 : i32
      scf.yield %2 : i32
    } else {
      %2 = ub.poison : i32
      scf.yield %2 : i32
    }
    %1 = scf.for %arg3 = %arg0 to %arg1 step %arg2 iter_args(%arg4 = %c0_i32) -> (i32) {
      %2 = arith.addi %arg4, %0 : i32
      scf.yield %2 : i32
    }
    return %1 : i32
  }
}

// -----
module {
  func.func @hoist_variant_scf_if_failure(%arg0: index, %arg1: index, %arg2: index) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %c42_i32 = arith.constant 42 : i32
    %c7 = arith.constant 7 : index
    %0 = scf.for %arg3 = %arg0 to %arg1 step %arg2 iter_args(%arg4 = %c0_i32) -> (i32) {
      %1 = arith.cmpi ult, %arg3, %c7 : index
      %2 = scf.if %1 -> (i32) {
        %4 = arith.addi %c42_i32, %c42_i32 : i32
        scf.yield %4 : i32
      } else {
        %4 = ub.poison : i32
        scf.yield %4 : i32
      }
      %3 = arith.addi %arg4, %2 : i32
      scf.yield %3 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func private @make_val() -> index
  func.func @nested_uses_inside(%arg0: index, %arg1: index, %arg2: index) {
    %true = arith.constant true
    scf.for %arg3 = %arg0 to %arg1 step %arg2 {
      %0 = func.call @make_val() : () -> index
      %1 = func.call @make_val() : () -> index
      %2 = scf.if %true -> (index) {
        scf.yield %0 : index
      } else {
        scf.yield %1 : index
      }
    }
    return
  }
}

// -----
module {
  func.func @invariant_subgraph(%arg0: index, %arg1: index, %arg2: index, %arg3: i32) {
    %0 = arith.addi %arg3, %arg3 : i32
    %1 = arith.addi %arg3, %0 : i32
    scf.for %arg4 = %arg0 to %arg1 step %arg2 {
      "test.sink"(%1) : (i32) -> ()
    }
    return
  }
}

// -----
module {
  func.func @test_invariant_nested_loop() {
    %c5_i32 = arith.constant 5 : i32
    %0 = arith.addi %c5_i32, %c5_i32 : i32
    %1 = arith.addi %0, %c5_i32 : i32
    test.graph_loop  {
    ^bb0(%arg0: i32):
      %2 = arith.subi %arg0, %arg0 : i32
      test.region_yield %2 : i32
    } : () -> ()
    test.graph_loop  {
      test.region_yield %1 : i32
    } : () -> ()
    return
  }
}

// -----
module {
  func.func @test_invariants_in_graph_region() {
    test.single_no_terminator_op : {
      %c5_i32 = arith.constant 5 : i32
      %0 = arith.addi %c5_i32, %c5_i32 : i32
      %1 = arith.addi %c5_i32, %0 : i32
      test.graph_loop  {
        test.region_yield %1 : i32
      } : () -> ()
    }
    return
  }
}

// -----
module {
  func.func @test_invariant_backedge() {
    %c5_i32 = arith.constant 5 : i32
    %0 = arith.addi %c5_i32, %c5_i32 : i32
    %1 = arith.addi %c5_i32, %0 : i32
    test.graph_loop  {
      test.region_yield %1 : i32
    } : () -> ()
    return
  }
}

// -----
module {
  func.func @test_invariant_cycle_not_hoisted() {
    test.graph_loop  {
      %0 = "test.a"(%1) : (i32) -> i32
      %1 = "test.b"(%0) : (i32) -> i32
      test.region_yield %0 : i32
    } : () -> ()
    return
  }
}

// -----
module {
  func.func @test_always_speculatable_op(%arg0: index, %arg1: index, %arg2: index) {
    %0 = "test.always_speculatable_op"() : () -> i32
    scf.for %arg3 = %arg0 to %arg1 step %arg2 {
    }
    return
  }
  func.func @test_never_speculatable_op(%arg0: index, %arg1: index, %arg2: index) {
    scf.for %arg3 = %arg0 to %arg1 step %arg2 {
      %0 = "test.never_speculatable_op"() : () -> i32
    }
    return
  }
  func.func @test_conditionally_speculatable_op_success(%arg0: index, %arg1: index, %arg2: index) {
    %c5_i32 = arith.constant 5 : i32
    %0 = "test.conditionally_speculatable_op"(%c5_i32) : (i32) -> i32
    scf.for %arg3 = %arg0 to %arg1 step %arg2 {
    }
    return
  }
  func.func @test_conditionally_speculatable_op_failure(%arg0: index, %arg1: index, %arg2: index, %arg3: i32) {
    %c5_i32 = arith.constant 5 : i32
    %0 = arith.addi %arg3, %c5_i32 : i32
    scf.for %arg4 = %arg0 to %arg1 step %arg2 {
      %1 = "test.conditionally_speculatable_op"(%0) : (i32) -> i32
    }
    return
  }
  func.func @test_recursively_speculatable_op_success(%arg0: index, %arg1: index, %arg2: index, %arg3: i32) {
    %0 = "test.recursively_speculatable_op"() ({
      %1 = arith.addi %arg3, %arg3 : i32
      test.region_yield %1 : i32
    }) : () -> i32
    scf.for %arg4 = %arg0 to %arg1 step %arg2 {
    }
    return
  }
  func.func @test_recursively_speculatable_op_failure(%arg0: index, %arg1: index, %arg2: index, %arg3: i32) {
    scf.for %arg4 = %arg0 to %arg1 step %arg2 {
      %0 = "test.recursively_speculatable_op"() ({
        %1 = "test.never_speculatable_op"() : () -> i32
        test.region_yield %1 : i32
      }) : () -> i32
    }
    return
  }
}

// -----
module {
  func.func @speculate_tensor_dim_unknown_rank_unknown_dim(%arg0: tensor<*xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) {
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %dim = tensor.dim %arg0, %arg1 : tensor<*xf32>
    }
    return
  }
  func.func @speculate_tensor_dim_known_rank_unknown_dim(%arg0: tensor<?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) {
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %dim = tensor.dim %arg0, %arg1 : tensor<?x?x?x?xf32>
    }
    return
  }
  func.func @speculate_tensor_dim_unknown_rank_known_dim(%arg0: tensor<*xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) {
    %c0 = arith.constant 0 : index
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %dim = tensor.dim %arg0, %c0 : tensor<*xf32>
    }
    return
  }
  func.func @speculate_tensor_dim_known_rank_known_dim_inbounds(%arg0: tensor<?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) {
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c1 : tensor<?x?x?x?xf32>
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
    }
    return
  }
}

// -----
module {
  func.func @speculate_memref_dim_unknown_rank_unknown_dim(%arg0: memref<*xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) {
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %dim = memref.dim %arg0, %arg1 : memref<*xf32>
    }
    return
  }
  func.func @speculate_memref_dim_known_rank_unknown_dim(%arg0: memref<?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) {
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %dim = memref.dim %arg0, %arg1 : memref<?x?x?x?xf32>
    }
    return
  }
  func.func @speculate_memref_dim_unknown_rank_known_dim(%arg0: memref<*xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) {
    %c0 = arith.constant 0 : index
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %dim = memref.dim %arg0, %c0 : memref<*xf32>
    }
    return
  }
  func.func @speculate_memref_dim_known_rank_known_dim_inbounds(%arg0: memref<?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) {
    %c1 = arith.constant 1 : index
    %dim = memref.dim %arg0, %c1 : memref<?x?x?x?xf32>
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
    }
    return
  }
}

// -----
module {
  func.func @speculate_memref_dim_known_rank_known_dim_inbounds() {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c22 = arith.constant 22 : index
    %alloc = memref.alloc(%c22) : memref<?xi1>
    %dim = memref.dim %alloc, %c0 : memref<?xi1>
    scf.for %arg0 = %c0 to %c22 step %c1 {
    }
    return
  }
}

// -----
module {
  func.func @speculate_tensor_dim_known_rank_known_dim_inbounds() {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c22 = arith.constant 22 : index
    %0 = tensor.empty(%c22, %c22) : tensor<?x?xi1>
    %dim = tensor.dim %0, %c1 : tensor<?x?xi1>
    scf.for %arg0 = %c0 to %c22 step %c1 {
    }
    return
  }
}

// -----
module {
  func.func @no_speculate_memref_dim_known_rank_known_dim_out_of_bounds() {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c22 = arith.constant 22 : index
    %alloc = memref.alloc(%c22) : memref<?xi1>
    scf.for %arg0 = %c0 to %c22 step %c1 {
      %dim = memref.dim %alloc, %c1 : memref<?xi1>
    }
    return
  }
}

// -----
module {
  func.func @no_speculate_divui(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %0 = arith.divui %arg0, %arg1 : i32
    }
    return
  }
  func.func @no_speculate_udiv(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %0 = llvm.udiv %arg0, %arg1 : i32
    }
    return
  }
  func.func @no_speculate_divsi(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %0 = arith.divsi %arg0, %arg1 : i32
    }
    return
  }
  func.func @no_speculate_sdiv(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %0 = llvm.sdiv %arg0, %arg1 : i32
    }
    return
  }
  func.func @no_speculate_ceildivui(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %0 = arith.ceildivui %arg0, %arg1 : i32
    }
    return
  }
  func.func @no_speculate_ceildivsi(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %0 = arith.ceildivsi %arg0, %arg1 : i32
    }
    return
  }
  func.func @no_speculate_divui_const(%arg0: i32, %arg1: index, %arg2: index, %arg3: index) {
    %c0_i32 = arith.constant 0 : i32
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
      %0 = arith.divui %arg0, %c0_i32 : i32
    }
    return
  }
  func.func @no_speculate_udiv_const(%arg0: i32, %arg1: index, %arg2: index, %arg3: index) {
    %c0_i32 = arith.constant 0 : i32
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
      %0 = llvm.udiv %arg0, %c0_i32 : i32
    }
    return
  }
  func.func @speculate_divui_const(%arg0: i32, %arg1: index, %arg2: index, %arg3: index) {
    %c5_i32 = arith.constant 5 : i32
    %0 = arith.divui %arg0, %c5_i32 : i32
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
    }
    return
  }
  func.func @speculate_udiv_const(%arg0: i32, %arg1: index, %arg2: index, %arg3: index) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.udiv %arg0, %0 : i32
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
    }
    return
  }
  func.func @no_speculate_ceildivui_const(%arg0: i32, %arg1: index, %arg2: index, %arg3: index) {
    %c0_i32 = arith.constant 0 : i32
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
      %0 = arith.ceildivui %arg0, %c0_i32 : i32
    }
    return
  }
  func.func @speculate_ceildivui_const(%arg0: i32, %arg1: index, %arg2: index, %arg3: index) {
    %c5_i32 = arith.constant 5 : i32
    %0 = arith.ceildivui %arg0, %c5_i32 : i32
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
    }
    return
  }
  func.func @no_speculate_divsi_const0(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    %c0_i32 = arith.constant 0 : i32
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %0 = arith.divsi %arg0, %c0_i32 : i32
    }
    return
  }
  func.func @no_speculate_sdiv_const0(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    %c0_i32 = arith.constant 0 : i32
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %0 = llvm.sdiv %arg0, %c0_i32 : i32
    }
    return
  }
  func.func @no_speculate_divsi_const_minus1(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    %c-1_i32 = arith.constant -1 : i32
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %0 = arith.divsi %arg0, %c-1_i32 : i32
    }
    return
  }
  func.func @no_speculate_sdiv_const_minus1(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    %c-1_i32 = arith.constant -1 : i32
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %0 = llvm.sdiv %arg0, %c-1_i32 : i32
    }
    return
  }
  func.func @speculate_divsi_const(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    %c5_i32 = arith.constant 5 : i32
    %0 = arith.divsi %arg0, %c5_i32 : i32
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
    }
    return
  }
  func.func @speculate_sdiv_const(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    %c5_i32 = arith.constant 5 : i32
    %0 = llvm.sdiv %arg0, %c5_i32 : i32
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
    }
    return
  }
  func.func @no_speculate_ceildivsi_const0(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    %c0_i32 = arith.constant 0 : i32
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %0 = arith.ceildivsi %arg0, %c0_i32 : i32
    }
    return
  }
  func.func @no_speculate_ceildivsi_const_minus1(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    %c-1_i32 = arith.constant -1 : i32
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
      %0 = arith.ceildivsi %arg0, %c-1_i32 : i32
    }
    return
  }
  func.func @speculate_ceildivsi_const(%arg0: i32, %arg1: i32, %arg2: index, %arg3: index, %arg4: index) {
    %c5_i32 = arith.constant 5 : i32
    %0 = arith.ceildivsi %arg0, %c5_i32 : i32
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
    }
    return
  }
  func.func @no_speculate_divui_range(%arg0: i8, %arg1: index, %arg2: index, %arg3: index) {
    %0 = test.with_bounds {smax = 127 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
      %1 = arith.divui %arg0, %0 : i8
    }
    return
  }
  func.func @no_speculate_udiv_range(%arg0: i8, %arg1: index, %arg2: index, %arg3: index) {
    %0 = test.with_bounds {smax = 127 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
      %1 = llvm.udiv %arg0, %0 : i8
    }
    return
  }
  func.func @no_speculate_divsi_range(%arg0: i8, %arg1: index, %arg2: index, %arg3: index) {
    %0 = test.with_bounds {smax = -1 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    %1 = test.with_bounds {smax = 127 : i8, smin = 0 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
      %2 = arith.divsi %arg0, %0 : i8
      %3 = arith.divsi %arg0, %1 : i8
    }
    return
  }
  func.func @no_speculate_sdiv_range(%arg0: i8, %arg1: index, %arg2: index, %arg3: index) {
    %0 = test.with_bounds {smax = -1 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    %1 = test.with_bounds {smax = 127 : i8, smin = 0 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
      %2 = llvm.sdiv %arg0, %0 : i8
      %3 = llvm.sdiv %arg0, %1 : i8
    }
    return
  }
  func.func @no_speculate_ceildivui_range(%arg0: i8, %arg1: index, %arg2: index, %arg3: index) {
    %0 = test.with_bounds {smax = 127 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
      %1 = arith.ceildivui %arg0, %0 : i8
    }
    return
  }
  func.func @no_speculate_ceildivsi_range(%arg0: i8, %arg1: index, %arg2: index, %arg3: index) {
    %0 = test.with_bounds {smax = -1 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    %1 = test.with_bounds {smax = 127 : i8, smin = 0 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
      %2 = arith.ceildivsi %arg0, %0 : i8
      %3 = arith.ceildivsi %arg0, %1 : i8
    }
    return
  }
  func.func @speculate_divui_range(%arg0: i8, %arg1: index, %arg2: index, %arg3: index) {
    %0 = test.with_bounds {smax = 127 : i8, smin = -128 : i8, umax = -1 : i8, umin = 1 : i8} : i8
    %1 = arith.divui %arg0, %0 : i8
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
    }
    return
  }
  func.func @speculate_udiv_range(%arg0: i8, %arg1: index, %arg2: index, %arg3: index) {
    %0 = test.with_bounds {smax = 127 : i8, smin = -128 : i8, umax = -1 : i8, umin = 1 : i8} : i8
    %1 = llvm.udiv %arg0, %0 : i8
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
    }
    return
  }
  func.func @speculate_divsi_range(%arg0: i8, %arg1: index, %arg2: index, %arg3: index) {
    %0 = test.with_bounds {smax = 127 : i8, smin = 1 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    %1 = test.with_bounds {smax = -2 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    %2 = arith.divsi %arg0, %0 : i8
    %3 = arith.divsi %arg0, %1 : i8
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
    }
    return
  }
  func.func @speculate_sdiv_range(%arg0: i8, %arg1: index, %arg2: index, %arg3: index) {
    %0 = test.with_bounds {smax = 127 : i8, smin = 1 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    %1 = test.with_bounds {smax = -2 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    %2 = llvm.sdiv %arg0, %0 : i8
    %3 = llvm.sdiv %arg0, %1 : i8
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
    }
    return
  }
  func.func @speculate_ceildivui_range(%arg0: i8, %arg1: index, %arg2: index, %arg3: index) {
    %0 = test.with_bounds {smax = 127 : i8, smin = -128 : i8, umax = -1 : i8, umin = 1 : i8} : i8
    %1 = arith.ceildivui %arg0, %0 : i8
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
    }
    return
  }
  func.func @speculate_ceildivsi_range(%arg0: i8, %arg1: index, %arg2: index, %arg3: index) {
    %0 = test.with_bounds {smax = 127 : i8, smin = 1 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    %1 = test.with_bounds {smax = -2 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8} : i8
    %2 = arith.ceildivsi %arg0, %0 : i8
    %3 = arith.ceildivsi %arg0, %1 : i8
    scf.for %arg4 = %arg1 to %arg2 step %arg3 {
    }
    return
  }
}

// -----
module {
  func.func @speculate_static_pack_and_unpack(%arg0: tensor<128x256xf32>, %arg1: tensor<4x16x32x16xf32>, %arg2: index, %arg3: index, %arg4: index) {
    %pack = linalg.pack %arg0 inner_dims_pos = [0, 1] inner_tiles = [32, 16] into %arg1 : tensor<128x256xf32> -> tensor<4x16x32x16xf32>
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
    }
    %unpack = linalg.unpack %arg1 inner_dims_pos = [0, 1] inner_tiles = [32, 16] into %arg0 : tensor<4x16x32x16xf32> -> tensor<128x256xf32>
    scf.for %arg5 = %arg2 to %arg3 step %arg4 {
    }
    return
  }
}

// -----
module {
  func.func @speculate_dynamic_pack_and_unpack(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: f32) {
    scf.for %arg8 = %arg2 to %arg3 step %arg4 {
      %pack_0 = linalg.pack %arg0 inner_dims_pos = [0, 1] inner_tiles = [%arg6, %arg5] into %arg1 : tensor<?x?xf32> -> tensor<?x?x?x?xf32>
    }
    scf.for %arg8 = %arg2 to %arg3 step %arg4 {
      %unpack = linalg.unpack %arg1 inner_dims_pos = [0, 1] inner_tiles = [%arg6, %arg5] into %arg0 : tensor<?x?x?x?xf32> -> tensor<?x?xf32>
    }
    %pack = linalg.pack %arg0 padding_value(%arg7 : f32) inner_dims_pos = [0, 1] inner_tiles = [%arg6, %arg5] into %arg1 : tensor<?x?xf32> -> tensor<?x?x?x?xf32>
    scf.for %arg8 = %arg2 to %arg3 step %arg4 {
    }
    return
  }
}

// -----
module {
  func.func @hoist_from_scf_while(%arg0: i32, %arg1: i32) -> i32 {
    %c2_i32 = arith.constant 2 : i32
    %c10_i32 = arith.constant 10 : i32
    %0 = arith.addi %arg0, %c2_i32 : i32
    %c1_i32 = arith.constant 1 : i32
    %1 = scf.while (%arg2 = %arg1) : (i32) -> i32 {
      %2 = arith.cmpi slt, %arg2, %0 : i32
      scf.condition(%2) %arg2 : i32
    } do {
    ^bb0(%arg2: i32):
      %2 = arith.addi %c1_i32, %arg2 : i32
      scf.yield %2 : i32
    }
    return %1 : i32
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @hoist_linalg_ops(%arg0: tensor<128x128xf32>, %arg1: tensor<128x128xf32>, %arg2: tensor<128x128xf32>, %arg3: index, %arg4: index, %arg5: index, %arg6: tensor<?x128xf32>) -> tensor<?x128xf32> {
    %0 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg0, %arg1 : tensor<128x128xf32>, tensor<128x128xf32>) outs(%arg2 : tensor<128x128xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.mulf %in, %in_0 : f32
      %3 = arith.addf %2, %out : f32
      linalg.yield %out : f32
    } -> tensor<128x128xf32>
    %1 = scf.for %arg7 = %arg3 to %arg4 step %arg5 iter_args(%arg8 = %arg6) -> (tensor<?x128xf32>) {
      %inserted_slice = tensor.insert_slice %0 into %arg6[%arg7, 0] [128, 128] [1, 1] : tensor<128x128xf32> into tensor<?x128xf32>
      scf.yield %inserted_slice : tensor<?x128xf32>
    }
    return %1 : tensor<?x128xf32>
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @hoist_linalg_ops_div_by_zero(%arg0: tensor<128x128xi32>, %arg1: tensor<128x128xi32>, %arg2: tensor<128x128xi32>, %arg3: index, %arg4: index, %arg5: index, %arg6: tensor<?x128xi32>) -> tensor<?x128xi32> {
    %c0_i32 = arith.constant 0 : i32
    %0 = scf.for %arg7 = %arg3 to %arg4 step %arg5 iter_args(%arg8 = %arg6) -> (tensor<?x128xi32>) {
      %1 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg0, %arg1 : tensor<128x128xi32>, tensor<128x128xi32>) outs(%arg2 : tensor<128x128xi32>) {
      ^bb0(%in: i32, %in_0: i32, %out: i32):
        %2 = arith.divui %in, %in_0 : i32
        %3 = arith.addi %2, %out : i32
        linalg.yield %out : i32
      } -> tensor<128x128xi32>
      %inserted_slice = tensor.insert_slice %1 into %arg6[%arg7, 0] [128, 128] [1, 1] : tensor<128x128xi32> into tensor<?x128xi32>
      scf.yield %inserted_slice : tensor<?x128xi32>
    }
    return %0 : tensor<?x128xi32>
  }
}

// -----
module {
  func.func @hoist_vector_transfer_ops(%arg0: tensor<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index) -> vector<4x4xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant dense<0.000000e+00> : vector<4x4xf32>
    %0 = vector.transfer_read %arg0[%arg4, %arg5], %cst : tensor<128x128xf32>, vector<4x4xf32>
    %1 = scf.for %arg6 = %arg1 to %arg2 step %arg3 iter_args(%arg7 = %cst_0) -> (vector<4x4xf32>) {
      %2 = arith.addf %0, %arg7 : vector<4x4xf32>
      scf.yield %2 : vector<4x4xf32>
    }
    return %1 : vector<4x4xf32>
  }
}

// -----
module {
  func.func @hoist_vector_transfer_ops(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> vector<4x4xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant dense<0.000000e+00> : vector<4x4xf32>
    %0 = tensor.empty() : tensor<4x4xf32>
    %1 = vector.transfer_write %cst_0, %0[%c0, %c0] : vector<4x4xf32>, tensor<4x4xf32>
    %2 = vector.transfer_read %1[%c0, %c0], %cst : tensor<4x4xf32>, vector<4x4xf32>
    %3 = scf.for %arg5 = %arg0 to %arg1 step %arg2 iter_args(%arg6 = %cst_0) -> (vector<4x4xf32>) {
      %4 = arith.addf %2, %arg6 : vector<4x4xf32>
      scf.yield %4 : vector<4x4xf32>
    }
    return %3 : vector<4x4xf32>
  }
}

// -----
module {
  func.func @do_not_hoist_vector_transfer_ops_loop_dep(%arg0: tensor<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> vector<4x4xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant dense<0.000000e+00> : vector<4x4xf32>
    %0 = scf.for %arg5 = %arg1 to %arg2 step %arg3 iter_args(%arg6 = %cst_0) -> (vector<4x4xf32>) {
      %1 = vector.transfer_read %arg0[%arg4, %arg5], %cst : tensor<128x128xf32>, vector<4x4xf32>
      %2 = arith.addf %1, %arg6 : vector<4x4xf32>
      scf.yield %2 : vector<4x4xf32>
    }
    return %0 : vector<4x4xf32>
  }
}

// -----
module {
  func.func @do_not_hoist_vector_transfer_ops_memref(%arg0: memref<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index) -> vector<4x4xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant dense<0.000000e+00> : vector<4x4xf32>
    %0 = scf.for %arg6 = %arg1 to %arg2 step %arg3 iter_args(%arg7 = %cst_0) -> (vector<4x4xf32>) {
      %1 = vector.transfer_read %arg0[%arg4, %arg5], %cst : memref<128x128xf32>, vector<4x4xf32>
      %2 = arith.addf %1, %arg7 : vector<4x4xf32>
      scf.yield %2 : vector<4x4xf32>
    }
    return %0 : vector<4x4xf32>
  }
}

