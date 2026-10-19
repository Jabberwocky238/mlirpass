module {
}

// -----
#map = affine_map<(d0) -> (d0 - 1)>
#map1 = affine_map<(d0) -> (d0 + 1)>
module {
  func.func @compose_affine_maps_1dto2d_no_symbols() {
    %alloc = memref.alloc() : memref<4x4xf32>
    affine.for %arg0 = 0 to 15 {
      %0 = affine.apply #map(%arg0)
      %1 = memref.load %alloc[%0, %0] : memref<4x4xf32>
      %2 = affine.apply #map1(%arg0)
      memref.store %1, %alloc[%2, %2] : memref<4x4xf32>
      memref.store %1, %alloc[%0, %2] : memref<4x4xf32>
      memref.store %1, %alloc[%2, %0] : memref<4x4xf32>
    }
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0 - 4)>
#map1 = affine_map<(d0) -> (d0 * 2 - 3)>
#map2 = affine_map<(d0) -> (d0 * 2 + 1)>
module {
  func.func @compose_affine_maps_1dto2d_with_symbols() {
    %alloc = memref.alloc() : memref<4x4xf32>
    affine.for %arg0 = 0 to 15 {
      %0 = affine.apply #map(%arg0)
      %1 = memref.load %alloc[%0, %0] : memref<4x4xf32>
      %2 = affine.apply #map1(%arg0)
      memref.store %1, %alloc[%2, %2] : memref<4x4xf32>
      %3 = affine.apply #map1(%arg0)
      memref.store %1, %alloc[%3, %3] : memref<4x4xf32>
      %4 = affine.apply #map2(%arg0)
      memref.store %1, %alloc[%4, %4] : memref<4x4xf32>
    }
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1 + (d0 ceildiv 4) * 4 - (d1 floordiv 4) * 4)>
#map1 = affine_map<(d0, d1) -> (d1 + (d0 ceildiv 8) * 8 - (d1 floordiv 8) * 8)>
module {
  func.func @compose_affine_maps_2d_tile(%arg0: memref<16x32xf32>, %arg1: memref<16x32xf32>) {
    affine.for %arg2 = 0 to 16 {
      affine.for %arg3 = 0 to 16 {
        affine.for %arg4 = 0 to 16 {
          affine.for %arg5 = 0 to 16 {
            %0 = affine.apply #map(%arg2, %arg4)
            %1 = affine.apply #map1(%arg3, %arg5)
            %2 = memref.load %arg0[%0, %1] : memref<16x32xf32>
            memref.store %2, %arg1[%0, %1] : memref<16x32xf32>
          }
        }
      }
    }
    return
  }
}

// -----
#map = affine_map<(d0) -> (d0 + 3)>
#map1 = affine_map<(d0) -> (d0 - 7)>
#map2 = affine_map<(d0) -> (d0 * 3)>
#map3 = affine_map<(d0) -> (d0 * 7 - 49)>
#map4 = affine_map<(d0) -> ((d0 + 3) ceildiv 3)>
module {
  func.func @compose_affine_maps_dependent_loads() {
    %alloc = memref.alloc() : memref<16x32xf32>
    affine.for %arg0 = 0 to 3 {
      affine.for %arg1 = 0 to 3 {
        affine.for %arg2 = 0 to 3 {
          %0 = affine.apply #map(%arg0)
          %1 = affine.apply #map1(%arg1)
          %2 = affine.apply #map2(%arg2)
          %3 = memref.load %alloc[%0, %1] : memref<16x32xf32>
          memref.store %3, %alloc[%0, %2] : memref<16x32xf32>
          memref.store %3, %alloc[%1, %0] : memref<16x32xf32>
          %4 = affine.apply #map3(%arg1)
          %5 = affine.apply #map4(%arg0)
          memref.store %3, %alloc[%4, %5] : memref<16x32xf32>
        }
      }
    }
    return
  }
}

// -----
#map = affine_map<(d0) -> ((d0 + 6) ceildiv 8)>
#map1 = affine_map<(d0) -> ((d0 * 4 - 4) floordiv 3)>
module {
  func.func @compose_affine_maps_diamond_dependency(%arg0: f32, %arg1: memref<4x4xf32>) {
    affine.for %arg2 = 0 to 15 {
      %0 = affine.apply #map(%arg2)
      %1 = affine.apply #map1(%arg2)
      memref.store %arg0, %arg1[%0, %1] : memref<4x4xf32>
    }
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> ((s0 * 4 + s1 * 4) floordiv s0)>
module {
  func.func @compose_affine_maps_multiple_symbols(%arg0: index, %arg1: index) -> index {
    %0 = affine.apply #map()[%arg1, %arg0]
    return %0 : index
  }
}

// -----
module {
  func.func @arg_used_as_dim_and_symbol(%arg0: memref<100x100xf32>, %arg1: index, %arg2: f32) -> (memref<100x100xf32, 1>, memref<1xi32>) {
    %alloc = memref.alloc() : memref<100x100xf32, 1>
    %alloc_0 = memref.alloc() : memref<1xi32>
    affine.for %arg3 = 0 to 100 {
      affine.for %arg4 = 0 to 100 {
        memref.store %arg2, %alloc[%arg4, %arg1] : memref<100x100xf32, 1>
      }
    }
    return %alloc, %alloc_0 : memref<100x100xf32, 1>, memref<1xi32>
  }
}

// -----
module {
  func.func @trivial_maps() {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<10xf32>
    affine.for %arg0 = 0 to 10 {
      memref.store %cst, %alloc[%c0] : memref<10xf32>
      %0 = memref.load %alloc[%c0] : memref<10xf32>
      memref.store %cst, %alloc[%c0] : memref<10xf32>
      memref.store %0, %alloc[%c0] : memref<10xf32>
    }
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 - 42)>
module {
  func.func @partial_fold_map(%arg0: index, %arg1: index) -> index {
    %0 = affine.apply #map()[%arg0]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0] -> (s0 * 512)>
module {
  func.func @symbolic_composition_a(%arg0: index, %arg1: index) -> index {
    %0 = affine.apply #map()[%arg0]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0] -> (s0 * 4)>
module {
  func.func @symbolic_composition_b(%arg0: index, %arg1: index, %arg2: index, %arg3: index) -> index {
    %0 = affine.apply #map()[%arg0]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 * 3 + s1)>
module {
  func.func @symbolic_composition_c(%arg0: index, %arg1: index, %arg2: index, %arg3: index) -> index {
    %0 = affine.apply #map()[%arg0, %arg1]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 * 3 + s1)>
module {
  func.func @symbolic_composition_d(%arg0: index, %arg1: index, %arg2: index, %arg3: index) -> index {
    %0 = affine.apply #map()[%arg0, %arg1]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 * 42 + s1 + 6)>
module {
  func.func @mix_dims_and_symbols_b(%arg0: index, %arg1: index) -> index {
    %0 = affine.apply #map()[%arg1, %arg0]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 * 168 + s1 * 4 - 4)>
module {
  func.func @mix_dims_and_symbols_c(%arg0: index, %arg1: index) -> index {
    %0 = affine.apply #map()[%arg1, %arg0]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0, s1] -> ((s0 * 42 + s1 + 6) ceildiv 8)>
module {
  func.func @mix_dims_and_symbols_d(%arg0: index, %arg1: index) -> index {
    %0 = affine.apply #map()[%arg1, %arg0]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0, s1] -> ((s0 * 168 + s1 * 4 - 4) floordiv 3)>
module {
  func.func @mix_dims_and_symbols_e(%arg0: index, %arg1: index) -> index {
    %0 = affine.apply #map()[%arg1, %arg0]
    return %0 : index
  }
}

// -----
module {
  func.func @mix_dims_and_symbols_f(%arg0: index, %arg1: index) -> index {
    %c0 = arith.constant 0 : index
    return %c0 : index
  }
}

// -----
#map = affine_map<()[s0] -> (s0 * 4)>
module {
  func.func @mix_dims_and_symbols_g(%arg0: index, %arg1: index) -> (index, index, index) {
    %c1024 = arith.constant 1024 : index
    %0 = affine.apply #map()[%arg0]
    %1 = affine.apply #map()[%arg1]
    return %1, %0, %c1024 : index, index, index
  }
}

// -----
#map = affine_map<(d0)[s0] -> (d0 floordiv (s0 + 1))>
module {
  func.func @symbolic_semi_affine(%arg0: index, %arg1: index, %arg2: memref<?xf32>) {
    %cst = arith.constant 1.000000e+00 : f32
    affine.for %arg3 = 1 to 100 {
      %0 = affine.apply #map(%arg3)[%arg0]
      memref.store %cst, %arg2[%0] : memref<?xf32>
    }
    return
  }
}

// -----
#map = affine_map<()[s0] -> (0, s0)>
#map1 = affine_map<()[s0] -> (100, s0)>
module {
  func.func @constant_fold_bounds(%arg0: index) {
    %c3 = arith.constant 3 : index
    %0 = "foo"() : () -> index
    affine.for %arg1 = 5 to 7 {
      "foo"(%arg1, %c3) : (index, index) -> ()
    }
    affine.for %arg1 = 1 to 7 {
      "foo"(%arg1, %c3) : (index, index) -> ()
    }
    affine.for %arg1 = max #map()[%0] to min #map1()[%arg0] {
      "foo"(%arg1, %c3) : (index, index) -> ()
    }
    return
  }
}

// -----
module {
  func.func @fold_empty_loops() -> index {
    %c0 = arith.constant 0 : index
    return %c0 : index
  }
}

// -----
module {
  func.func @fold_empty_loop() -> (index, index) {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    return %c2, %c1 : index, index
  }
}

// -----
module {
  func.func @fold_empty_loops_trip_count_1() -> (index, index, index, index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    return %c1, %c2, %c0, %c2 : index, index, index, index
  }
}

// -----
module {
  func.func @fold_empty_loop_trip_count_0() -> (index, index) {
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    return %c2, %c0 : index, index
  }
}

// -----
module {
  func.func @fold_empty_loop_trip_count_unknown(%arg0: index) -> (index, index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    return %c0, %c1 : index, index
  }
}

// -----
module {
  func.func @empty_loops_not_folded_1(%arg0: index) -> index {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0 = affine.for %arg1 = 0 to %arg0 iter_args(%arg2 = %c0) -> (index) {
      affine.yield %c1 : index
    }
    return %0 : index
  }
}

// -----
module {
  func.func @empty_loops_not_folded_2(%arg0: index) -> (index, index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0:2 = affine.for %arg1 = 0 to %arg0 iter_args(%arg2 = %c0, %arg3 = %c1) -> (index, index) {
      affine.yield %arg3, %arg2 : index, index
    }
    return %0#0, %0#1 : index, index
  }
}

// -----
module {
  func.func @empty_loops_not_folded_3() -> (index, index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0:2 = affine.for %arg0 = 0 to 10 iter_args(%arg1 = %c0, %arg2 = %c1) -> (index, index) {
      affine.yield %arg2, %arg1 : index, index
    }
    return %0#0, %0#1 : index, index
  }
}

// -----
module {
  func.func @zero_iter_loop_not_folded() {
    %alloc = memref.alloc() : memref<4xf32>
    affine.for %arg0 = 0 to 0 {
      %0 = affine.load %alloc[%arg0] : memref<4xf32>
      affine.store %0, %alloc[%arg0] : memref<4xf32>
    }
    return
  }
}

// -----
module {
  func.func @fold_zero_iter_loops(%arg0: index) -> index {
    return %arg0 : index
  }
}

// -----
#set = affine_set<(d0, d1)[s0] : (d0 >= 0, -d0 + 1022 >= 0, d1 >= 0, -d1 + s0 - 2 >= 0)>
module {
  func.func @canonicalize_affine_if(%arg0: index, %arg1: index) {
    affine.for %arg2 = 0 to 1024 {
      affine.for %arg3 = 0 to %arg1 {
        affine.if #set(%arg2, %arg3)[%arg1] {
          "foo"() : () -> ()
        }
        "bar"() : () -> ()
      }
    }
    return
  }
}

// -----
#set = affine_set<(d0, d1)[s0] : (d0 - 1 >= 0, d1 - 1 == 0, -d0 + s0 + 10 >= 0)>
module {
  func.func @canonicalize_affine_if_compose_apply(%arg0: index) {
    affine.for %arg1 = 0 to 1024 {
      affine.for %arg2 = 0 to 100 {
        affine.if #set(%arg1, %arg2)[%arg0] {
          "test.foo"() : () -> ()
        }
      }
    }
    return
  }
}

// -----
#map = affine_map<()[s0] -> (1024, s0 * 2)>
#map1 = affine_map<()[s0] -> (s0 * 4)>
#map2 = affine_map<()[s0] -> (0, s0)>
module {
  func.func @canonicalize_bounds(%arg0: index, %arg1: index) {
    affine.for %arg2 = 0 to min #map()[%arg0] {
      "foo"() : () -> ()
    }
    affine.for %arg2 = 0 to #map1()[%arg0] {
      "foo"() : () -> ()
    }
    affine.for %arg2 = max #map2()[%arg1] to %arg0 {
      "foo"() : () -> ()
    }
    return
  }
}

// -----
module {
  func.func @compose_into_affine_load_store(%arg0: memref<1024xf32>, %arg1: index) {
    affine.for %arg2 = 0 to 1024 {
      %0 = affine.load %arg0[%arg2 + 1] : memref<1024xf32>
      affine.store %0, %arg0[%arg2 + 1] : memref<1024xf32>
      %1 = affine.load %arg0[%arg2] : memref<1024xf32>
      "prevent.dce"(%1) : (f32) -> ()
    }
    return
  }
}

// -----
module {
  func.func @affine_min(%arg0: index, %arg1: index, %arg2: index) {
    %c512 = arith.constant 512 : index
    "op0"(%c512) : (index) -> ()
    return
  }
}

// -----
module {
  func.func @affine_min(%arg0: index, %arg1: index, %arg2: index) {
    %c4 = arith.constant 4 : index
    "op0"(%c4) : (index) -> ()
    return
  }
}

// -----
module {
  func.func @affine_max(%arg0: index, %arg1: index, %arg2: index) {
    %c1000 = arith.constant 1000 : index
    "op0"(%c1000) : (index) -> ()
    return
  }
}

// -----
module {
  func.func @affine_max(%arg0: index, %arg1: index, %arg2: index) {
    %c1000 = arith.constant 1000 : index
    "op0"(%c1000) : (index) -> ()
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1 - 2, d0)>
module {
  func.func @affine_min(%arg0: index) {
    affine.for %arg1 = 0 to %arg0 {
      affine.for %arg2 = 0 to %arg0 {
        %0 = affine.min #map(%arg1, %arg2)
        "consumer"(%0) : (index) -> ()
      }
    }
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> (1024, s0 - s1 * 1024)>
module {
  func.func @rep(%arg0: index, %arg1: index) -> index {
    %0 = affine.min #map()[%arg1, %arg0]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 2)>
module {
  func.func @drop_duplicate_bounds(%arg0: index) {
    affine.for %arg1 = %arg0 to #map()[%arg0] {
      "foo"() : () -> ()
    }
    return
  }
}

// -----
module {
  func.func @affine_parallel_const_bounds() {
    %cst = arith.constant 1.000000e+00 : f32
    %alloc = memref.alloc() : memref<4xf32>
    affine.parallel (%arg0) = (0) to (4) {
      affine.parallel (%arg1) = (0) to (%arg0 * 5) {
        affine.store %cst, %alloc[%arg1] : memref<4xf32>
      }
    }
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 * 8 + (s0 * s0) * 6 + s1 mod (s0 * 3))>
#map1 = affine_map<(d0)[s0] -> (d0 ceildiv (s0 * 3) + s0 * 8)>
module {
  func.func @compose_affine_maps_div_symbol(%arg0: memref<i64>, %arg1: index, %arg2: index) {
    %0 = affine.apply #map()[%arg1, %arg2]
    %1 = arith.index_cast %0 : index to i64
    memref.store %1, %arg0[] : memref<i64>
    affine.for %arg3 = 0 to 3 {
      %2 = affine.apply #map1(%arg3)[%arg1]
      %3 = arith.index_cast %2 : index to i64
      memref.store %3, %arg0[] : memref<i64>
    }
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1, s0 * s1)>
module {
  func.func @deduplicate_affine_min_expressions(%arg0: index, %arg1: index) -> index {
    %0 = affine.min #map()[%arg0, %arg1]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1, s0 * s1)>
module {
  func.func @deduplicate_affine_max_expressions(%arg0: index, %arg1: index) -> index {
    %0 = affine.max #map()[%arg0, %arg1]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0, s1, s2] -> (-s1 + s2, 16, s0 * 3)>
#map1 = affine_map<()[s0, s1, s2] -> (-s0 + s2, -s1 + 5, 16)>
module {
  func.func @merge_affine_min_ops(%arg0: index, %arg1: index, %arg2: index, %arg3: index) -> (index, index) {
    %0 = affine.min #map()[%arg2, %arg1, %arg0]
    %1 = affine.min #map1()[%arg1, %arg3, %arg0]
    return %0, %1 : index, index
  }
}

// -----
#map = affine_map<()[s0, s1, s2] -> (s2 + 8, s2 * 4, s1 + 16, s1 * 8, s0 + 7)>
module {
  func.func @merge_multiple_affine_min_ops(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = affine.min #map()[%arg2, %arg0, %arg1]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s1 + 16, s1 * 8, s0 * 2)>
module {
  func.func @merge_multiple_uses_of_affine_min_ops(%arg0: index, %arg1: index) -> index {
    %0 = affine.min #map()[%arg1, %arg0]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0, s1, s2] -> (s2 + 16, s2 * 8, s1 * 2, s0 + 1)>
module {
  func.func @merge_mixed_uses_of_affine_min_ops(%arg0: index, %arg1: index) -> index {
    %0 = affine.min #map()[%arg0]
    %1 = affine.min #map1()[%0, %arg1, %arg0]
    return %1 : index
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0, s1] -> (s1 + 7, s0 + 4)>
module {
  func.func @dont_merge_affine_min_if_not_single_dim(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = affine.min #map()[%arg0]
    %1 = affine.min #map1()[%arg2, %0]
    return %1 : index
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0, s1] -> (s1 + 7, s0 + 4)>
module {
  func.func @dont_merge_affine_min_if_not_single_sym(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = affine.min #map()[%arg0]
    %1 = affine.min #map1()[%0, %arg2]
    return %1 : index
  }
}

// -----
#map = affine_map<()[s0, s1, s2] -> (-s1 + s2, 16, s0 * 3)>
#map1 = affine_map<()[s0, s1, s2] -> (-s0 + s2, -s1 + 5, 16)>
module {
  func.func @merge_affine_max_ops(%arg0: index, %arg1: index, %arg2: index, %arg3: index) -> (index, index) {
    %0 = affine.max #map()[%arg2, %arg1, %arg0]
    %1 = affine.max #map1()[%arg1, %arg3, %arg0]
    return %0, %1 : index, index
  }
}

// -----
#map = affine_map<()[s0, s1, s2] -> (s2 + 8, s2 * 4, s1 + 16, s1 * 8, s0 + 7)>
module {
  func.func @merge_multiple_affine_max_ops(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = affine.max #map()[%arg2, %arg0, %arg1]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s1 + 16, s1 * 8, s0 * 2)>
module {
  func.func @merge_multiple_uses_of_affine_max_ops(%arg0: index, %arg1: index) -> index {
    %0 = affine.max #map()[%arg1, %arg0]
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0, s1, s2] -> (s2 + 16, s2 * 8, s1 * 2, s0 + 1)>
module {
  func.func @merge_mixed_uses_of_affine_max_ops(%arg0: index, %arg1: index) -> index {
    %0 = affine.max #map()[%arg0]
    %1 = affine.max #map1()[%0, %arg1, %arg0]
    return %1 : index
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0, s1] -> (s1 + 7, s0 + 4)>
module {
  func.func @dont_merge_affine_max_if_not_single_dim(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = affine.max #map()[%arg0]
    %1 = affine.max #map1()[%arg2, %0]
    return %1 : index
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0, s1] -> (s1 + 7, s0 + 4)>
module {
  func.func @dont_merge_affine_max_if_not_single_sym(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = affine.max #map()[%arg0]
    %1 = affine.max #map1()[%0, %arg2]
    return %1 : index
  }
}

// -----
#map = affine_map<()[s0] -> (s0 - 2)>
#map1 = affine_map<()[s0] -> (s0 + 2)>
module {
  func.func @compose_affine_for_bounds(%arg0: index) {
    affine.for %arg1 = #map()[%arg0] to #map1()[%arg0] {
      "foo"() : () -> ()
    }
    return
  }
}

// -----
module {
  func.func @compose_into_affine_vector_load_vector_store(%arg0: memref<1024xf32>, %arg1: index) {
    affine.for %arg2 = 0 to 1024 {
      %0 = affine.vector_load %arg0[%arg2 + 1] : memref<1024xf32>, vector<8xf32>
      affine.vector_store %0, %arg0[%arg2 + 1] : memref<1024xf32>, vector<8xf32>
      %1 = affine.vector_load %arg0[%arg2] : memref<1024xf32>, vector<8xf32>
      "prevent.dce"(%1) : (vector<8xf32>) -> ()
    }
    return
  }
}

// -----
module {
  func.func @no_fold_of_store(%arg0: memref<32xi8>, %arg1: memref<memref<?xi8>>) {
    %cast = memref.cast %arg0 : memref<32xi8> to memref<?xi8>
    affine.store %cast, %arg1[] : memref<memref<?xi8>>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 16)>
#map1 = affine_map<()[s0] -> (s0 * 4)>
module {
  func.func @canonicalize_single_min_max(%arg0: index, %arg1: index) -> (index, index) {
    %0 = affine.apply #map()[%arg0]
    %1 = affine.apply #map1()[%arg1]
    return %0, %1 : index, index
  }
}

// -----
#map = affine_map<()[s0, s1] -> (32, s1 + 16, s0 + s1)>
module {
  func.func @canonicalize_multi_min_max(%arg0: index, %arg1: index) -> (index, index) {
    %0 = affine.min #map()[%arg0, %arg1]
    %1 = affine.max #map()[%arg0, %arg1]
    return %0, %1 : index, index
  }
}

// -----
module {
  memref.global "private" constant @__constant_1x5x1xf32 : memref<1x5x1xf32> = dense<[[[6.250000e-02], [2.500000e-01], [3.750000e-01], [2.500000e-01], [6.250000e-02]]]>
  memref.global "private" constant @__constant_32x64xf32 : memref<32x64xf32> = dense<0.000000e+00>
  func.func @fold_const_init_global_memref() -> (f32, f32) {
    %cst = arith.constant 6.250000e-02 : f32
    %cst_0 = arith.constant 2.500000e-01 : f32
    return %cst, %cst_0 : f32, f32
  }
  func.func @fold_const_splat_global() -> memref<32x64xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %alloc = memref.alloc() : memref<32x64xf32>
    affine.for %arg0 = 0 to 32 {
      affine.for %arg1 = 0 to 64 {
        affine.store %cst, %alloc[%arg0, %arg1] : memref<32x64xf32>
      }
    }
    return %alloc : memref<32x64xf32>
  }
}

// -----
#map = affine_map<(d0, d1) -> (((d0 + d1) mod 458313) floordiv 227)>
module {
  func.func @simplify_with_operands(%arg0: index, %arg1: memref<?x32xf32>) {
    affine.for %arg2 = 0 to %arg0 step 32 {
      affine.for %arg3 = 0 to 32 {
        %0 = affine.load %arg1[0, 0] : memref<?x32xf32>
        "test.foo"(%0) : (f32) -> ()
        %1 = affine.load %arg1[%arg2 floordiv 32, %arg3 mod 16] : memref<?x32xf32>
        "test.foo"(%1) : (f32) -> ()
        %2 = affine.load %arg1[%arg2 floordiv 64, (%arg2 + %arg3) mod 64] : memref<?x32xf32>
        "test.foo"(%2) : (f32) -> ()
        %3 = affine.load %arg1[(%arg2 + %arg3) floordiv 16, %arg3 mod 16] : memref<?x32xf32>
        "test.foo"(%3) : (f32) -> ()
      }
    }
    affine.for %arg2 = -1 to 32 {
      %0 = affine.load %arg1[%arg2 floordiv 32, %arg2 mod 32] : memref<?x32xf32>
      "test.foo"(%0) : (f32) -> ()
    }
    affine.for %arg2 = 0 to %arg0 step 128 {
      affine.for %arg3 = 0 to 32 step 32 {
        affine.for %arg4 = 0 to 128 {
          %0 = affine.apply #map(%arg2, %arg4)
          "test.foo"(%0) : (index) -> ()
        }
      }
    }
    return
  }
  func.func @simplify_div_mod_with_operands(%arg0: index, %arg1: memref<64xf32>, %arg2: index) {
    %cst = arith.constant 1.000000e+00 : f32
    affine.for %arg3 = 0 to 32 {
      affine.store %cst, %arg1[0] : memref<64xf32>
      affine.store %cst, %arg1[1] : memref<64xf32>
      affine.store %cst, %arg1[%arg3] : memref<64xf32>
      affine.store %cst, %arg1[0] : memref<64xf32>
      affine.store %cst, %arg1[0] : memref<64xf32>
      affine.store %cst, %arg1[%arg3 floordiv 16] : memref<64xf32>
      affine.store %cst, %arg1[%arg3 mod 16] : memref<64xf32>
      affine.store %cst, %arg1[(%arg3 mod 16) floordiv 15] : memref<64xf32>
      affine.store %cst, %arg1[%arg3 mod 31] : memref<64xf32>
    }
    affine.for %arg3 = -8 to 32 {
      affine.store %cst, %arg1[%arg3 floordiv 32] : memref<64xf32>
      affine.store %cst, %arg1[%arg3 mod 32] : memref<64xf32>
      affine.store %cst, %arg1[0] : memref<64xf32>
    }
    affine.for %arg3 = 8 to 16 {
      affine.store %cst, %arg1[1] : memref<64xf32>
      affine.store %cst, %arg1[2] : memref<64xf32>
      affine.store %cst, %arg1[%arg3 mod 8] : memref<64xf32>
      affine.store %cst, %arg1[%arg3] : memref<64xf32>
      affine.store %cst, %arg1[0] : memref<64xf32>
      affine.store %cst, %arg1[1] : memref<64xf32>
      affine.store %cst, %arg1[0] : memref<64xf32>
    }
    return
  }
}

// -----
#map = affine_map<()[s0] -> (3, s0)>
#map1 = affine_map<()[s0] -> (5, s0)>
#map2 = affine_map<(d0) -> (d0 * 4 + 3)>
#map3 = affine_map<(d0, d1) -> (-9, d0 * 4 - d1 * 4)>
#map4 = affine_map<(d0) -> (d0 floordiv 2)>
#map5 = affine_map<(d0) -> (d0 * 2, 2)>
#map6 = affine_map<(d0)[s0] -> (d0, s0)>
module {
  func.func @simplify_min_max_bounds_simple(%arg0: index) {
    affine.for %arg1 = 0 to min #map()[%arg0] {
      "test.foo"() : () -> ()
    }
    affine.for %arg1 = 0 to min #map()[%arg0] {
      "test.foo"() : () -> ()
    }
    affine.for %arg1 = max #map1()[%arg0] to 10 {
      "test.foo"() : () -> ()
    }
    affine.for %arg1 = max #map1()[%arg0] to 10 {
      "test.foo"() : () -> ()
    }
    return
  }
  func.func @simplify_bounds_tiled() {
    affine.for %arg0 = 0 to 1 {
      affine.for %arg1 = 0 to 2 {
        affine.for %arg2 = 0 to 32 step 16 {
          affine.for %arg3 = 0 to 32 step 16 {
            affine.for %arg4 = 0 to 2 {
              affine.for %arg5 = 0 to 16 step 16 {
                "test.foo"() : () -> ()
              }
            }
          }
        }
      }
    }
    return
  }
  func.func @simplify_min_max_multi_expr() {
    affine.for %arg0 = 0 to 2 {
      affine.for %arg1 = 5 to #map2(%arg0) {
        "test.foo"() : () -> ()
      }
    }
    affine.for %arg0 = 0 to 2 {
      affine.for %arg1 = 0 to 4 {
        affine.for %arg2 = -10 to -9 {
          "test.foo"() : () -> ()
        }
      }
    }
    affine.for %arg0 = 0 to 2 {
      affine.for %arg1 = 0 to 4 {
        affine.for %arg2 = -10 to min #map3(%arg0, %arg1) {
          "test.foo"() : () -> ()
        }
      }
    }
    affine.for %arg0 = 0 to 2 {
      affine.for %arg1 = 0 to 1 {
        "test.foo"() : () -> ()
      }
    }
    affine.for %arg0 = 0 to 8 {
      affine.for %arg1 = #map4(%arg0) to 10 {
        "test.foo"() : () -> ()
      }
    }
    return
  }
  func.func @no_simplify_min_max(%arg0: index) {
    affine.for %arg1 = 0 to 4 {
      affine.for %arg2 = 0 to min #map5(%arg1) {
        "test.foo"() : () -> ()
      }
      affine.for %arg2 = 0 to min #map6(%arg1)[%arg0] {
        "test.foo"() : () -> ()
      }
    }
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 * ((-s0 + 40961) ceildiv 512))>
module {
  func.func @regression_do_not_perform_invalid_replacements(%arg0: index) {
    %0 = affine.apply #map()[%arg0]
    "test.foo"(%0) : (index) -> ()
    return
  }
}

// -----
module {
  func.func @min.oneval(%arg0: index) -> index {
    return %arg0 : index
  }
}

// -----
module {
  func.func @max.oneval(%arg0: index) -> index {
    return %arg0 : index
  }
}

// -----
module {
  func.func @mod_of_mod(%arg0: index, %arg1: index, %arg2: index) -> (index, index) {
    %c0 = arith.constant 0 : index
    return %c0, %c0 : index, index
  }
}

// -----
module {
  func.func @prefetch_canonicalize(%arg0: memref<512xf32>) {
    affine.for %arg1 = 0 to 8 {
      affine.prefetch %arg0[%arg1 * 64], read, locality<3>, data : memref<512xf32>
    }
    return
  }
}

// -----
module {
  func.func @delinearize_fold_constant() -> (index, index, index) {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    return %c1, %c1, %c2 : index, index, index
  }
}

// -----
module {
  func.func @delinearize_fold_negative_constant() -> (index, index, index) {
    %c-2 = arith.constant -2 : index
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    return %c-2, %c1, %c3 : index, index, index
  }
}

// -----
module {
  func.func @delinearize_fold_negative_constant_no_outer_bound() -> (index, index, index) {
    %c-2 = arith.constant -2 : index
    %c1 = arith.constant 1 : index
    %c3 = arith.constant 3 : index
    return %c-2, %c1, %c3 : index, index, index
  }
}

// -----
module {
  func.func @delinearize_dont_fold_constant_dynamic_basis(%arg0: index) -> (index, index, index) {
    %c22 = arith.constant 22 : index
    %0:3 = affine.delinearize_index %c22 into (2, %arg0, 5) : index, index, index
    return %0#0, %0#1, %0#2 : index, index, index
  }
}

// -----
module {
  func.func @drop_unit_basis_in_delinearize(%arg0: index, %arg1: index, %arg2: index) -> (index, index, index, index, index, index) {
    %c0 = arith.constant 0 : index
    %0:2 = affine.delinearize_index %arg0 into (%arg1, %arg2) : index, index
    return %c0, %0#0, %c0, %c0, %0#1, %c0 : index, index, index, index, index, index
  }
}

// -----
module {
  func.func @drop_unit_basis_in_delinearize_no_outer_bound(%arg0: index, %arg1: index, %arg2: index) -> (index, index, index, index, index, index) {
    %c0 = arith.constant 0 : index
    %0:3 = affine.delinearize_index %arg0 into (%arg1, %arg2) : index, index, index
    return %0#0, %0#1, %c0, %c0, %0#2, %c0 : index, index, index, index, index, index
  }
}

// -----
module {
  func.func @drop_all_unit_bases(%arg0: index) -> (index, index) {
    %c0 = arith.constant 0 : index
    return %c0, %c0 : index, index
  }
}

// -----
module {
  func.func @drop_all_unit_bases_no_outer_bound(%arg0: index) -> (index, index, index) {
    %c0 = arith.constant 0 : index
    return %arg0, %c0, %c0 : index, index, index
  }
}

// -----
module {
  func.func @drop_single_loop_delinearize(%arg0: index, %arg1: index) -> index {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0 = scf.for %arg2 = %c0 to %arg1 step %c1 iter_args(%arg3 = %c0) -> (index) {
      %1 = "some_use"(%arg3, %arg2) : (index, index) -> index
      scf.yield %1 : index
    }
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0, s1, s2, s3] -> (s0 + s1 * 64 + s2 * 128 + s3)>
module {
  func.func @delinearize_non_induction_variable(%arg0: memref<?xi32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> index {
    %0 = affine.apply #map()[%arg2, %arg3, %arg4, %arg1]
    return %0 : index
  }
}

// -----
module {
  func.func @delinearize_non_loop_like(%arg0: memref<?xi32>, %arg1: index) -> index {
    return %arg1 : index
  }
}

// -----
module {
  func.func @delinearize_empty_basis(%arg0: index) -> index {
    return %arg0 : index
  }
}

// -----
module {
  func.func @linearize_fold_constants() -> index {
    %c22 = arith.constant 22 : index
    return %c22 : index
  }
}

// -----
module {
  func.func @linearize_fold_constants_no_outer_bound() -> index {
    %c22 = arith.constant 22 : index
    return %c22 : index
  }
}

// -----
module {
  func.func @linearize_fold_empty_basis(%arg0: index) -> index {
    return %arg0 : index
  }
}

// -----
module {
  func.func @linearize_fold_only_outer_bound(%arg0: index) -> index {
    return %arg0 : index
  }
}

// -----
module {
  func.func @linearize_dont_fold_dynamic_basis(%arg0: index) -> index {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %0 = affine.linearize_index [%c1, %c1, %c2] by (2, %arg0, 5) : index
    return %0 : index
  }
}

// -----
module {
  func.func @cancel_delinearize_linearize_disjoint_exact(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> (index, index, index) {
    return %arg0, %arg1, %arg2 : index, index, index
  }
}

// -----
module {
  func.func @cancel_delinearize_linearize_disjoint_linearize_extra_bound(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> (index, index, index) {
    return %arg0, %arg1, %arg2 : index, index, index
  }
}

// -----
module {
  func.func @cancel_delinearize_linearize_disjoint_delinearize_extra_bound(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> (index, index, index) {
    return %arg0, %arg1, %arg2 : index, index, index
  }
}

// -----
module {
  func.func @cancel_delinearize_linearize_disjoint_partial(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> (index, index, index) {
    %0 = affine.linearize_index disjoint [%arg0, %arg1] by (%arg3, 4) : index
    %1:2 = affine.delinearize_index %0 into (8) : index, index
    return %1#0, %1#1, %arg2 : index, index, index
  }
}

// -----
module {
  func.func @no_cancel_delinearize_linearize_exact(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> (index, index, index) {
    %0 = affine.linearize_index [%arg0, %arg1, %arg2] by (%arg3, 4, %arg4) : index
    %1:3 = affine.delinearize_index %0 into (%arg3, 4, %arg4) : index, index, index
    return %1#0, %1#1, %1#2 : index, index, index
  }
}

// -----
module {
  func.func @no_cancel_delinearize_linearize_different_basis(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index) -> (index, index, index) {
    %0 = affine.linearize_index [%arg0, %arg1, %arg2] by (%arg3, 4, %arg4) : index
    %1:3 = affine.delinearize_index %0 into (%arg3, 8, %arg4) : index, index, index
    return %1#0, %1#1, %1#2 : index, index, index
  }
}

// -----
module {
  func.func @split_delinearize_spanning_final_part(%arg0: index, %arg1: index, %arg2: index) -> (index, index, index, index) {
    %0 = affine.linearize_index disjoint [%arg0, %arg1] by (2, 4) : index
    %1:2 = affine.delinearize_index %0 into (2) : index, index
    %2:2 = affine.delinearize_index %arg2 into (8, 8) : index, index
    return %1#0, %1#1, %2#0, %2#1 : index, index, index, index
  }
}

// -----
module {
  func.func @split_delinearize_spanning_final_part_and_cancel(%arg0: index, %arg1: index, %arg2: index) -> (index, index, index, index) {
    %0:2 = affine.delinearize_index %arg2 into (8, 8) : index, index
    return %arg0, %arg1, %0#0, %0#1 : index, index, index, index
  }
}

// -----
module {
  func.func @dont_split_delinearize_overshooting_target(%arg0: index, %arg1: index, %arg2: index) -> (index, index, index, index) {
    %0 = affine.linearize_index disjoint [%arg0, %arg1, %arg2] by (2, 4, 64) : index
    %1:4 = affine.delinearize_index %0 into (2, 16, 8) : index, index, index, index
    return %1#0, %1#1, %1#2, %1#3 : index, index, index, index
  }
}

// -----
module {
  func.func @dont_split_delinearize_undershooting_target(%arg0: index, %arg1: index) -> (index, index, index) {
    %0 = affine.linearize_index disjoint [%arg0, %arg1] by (2, 64) : index
    %1:3 = affine.delinearize_index %0 into (4, 8) : index, index, index
    return %1#0, %1#1, %1#2 : index, index, index
  }
}

// -----
module {
  func.func @linearize_unit_basis_disjoint(%arg0: index, %arg1: index, %arg2: index, %arg3: index) -> index {
    %0 = affine.linearize_index disjoint [%arg0, %arg2] by (3, %arg3) : index
    return %0 : index
  }
}

// -----
module {
  func.func @linearize_unit_basis_disjoint_no_outer_bound(%arg0: index, %arg1: index, %arg2: index, %arg3: index) -> index {
    %0 = affine.linearize_index disjoint [%arg0, %arg2] by (%arg3) : index
    return %0 : index
  }
}

// -----
module {
  func.func @linearize_unit_basis_zero(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = affine.linearize_index [%arg0, %arg1] by (3, %arg2) : index
    return %0 : index
  }
}

// -----
module {
  func.func @linearize_all_zero_unit_basis() -> index {
    %c0 = arith.constant 0 : index
    return %c0 : index
  }
}

// -----
module {
  func.func @linearize_one_element_basis(%arg0: index, %arg1: index) -> index {
    return %arg0 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_exact(%arg0: index, %arg1: index, %arg2: index) -> index {
    return %arg0 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_linearize_extra_bound(%arg0: index, %arg1: index, %arg2: index) -> index {
    return %arg0 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_delinearize_extra_bound(%arg0: index, %arg1: index, %arg2: index) -> index {
    return %arg0 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_head(%arg0: index, %arg1: index) -> index {
    %0:2 = affine.delinearize_index %arg0 into (12, 8) : index, index
    %1 = affine.linearize_index [%0#0, %arg1] by (12, 16) : index
    return %1 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_head_delinearize_unbounded(%arg0: index, %arg1: index) -> index {
    %0:2 = affine.delinearize_index %arg0 into (12, 8) : index, index
    %1 = affine.linearize_index [%0#0, %arg1] by (12, 16) : index
    return %1 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_head_linearize_unbounded(%arg0: index, %arg1: index) -> index {
    %0:2 = affine.delinearize_index %arg0 into (8) : index, index
    %1 = affine.linearize_index [%0#0, %arg1] by (16) : index
    return %1 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_head_both_unbounded(%arg0: index, %arg1: index) -> index {
    %0:2 = affine.delinearize_index %arg0 into (8) : index, index
    %1 = affine.linearize_index [%0#0, %arg1] by (16) : index
    return %1 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_tail(%arg0: index, %arg1: index) -> index {
    %0:2 = affine.delinearize_index %arg0 into (3, 32) : index, index
    %1 = affine.linearize_index [%arg1, %0#1] by (5, 32) : index
    return %1 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_middle_exact(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = affine.linearize_index [%arg1, %arg0, %arg2] by (9, 30, 7) : index
    return %0 : index
  }
}

// -----
#map = affine_map<()[s0, s1] -> ((s0 * s1) * 16)>
module {
  func.func @cancel_linearize_delinearize_middle_exact_dynamic_basis(%arg0: index, %arg1: index, %arg2: index) -> index {
    %c1 = arith.constant 1 : index
    %0 = affine.apply #map()[%arg1, %arg2]
    %1 = affine.linearize_index [%c1, %arg0, %c1] by (3, %0, 4) : index
    return %1 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_middle_exact_delinearize_unbounded_disjoint(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = affine.linearize_index disjoint [%arg1, %arg0, %arg2] by (9, 30, 7) : index
    return %0 : index
  }
}

// -----
module {
  func.func @dont_cancel_linearize_delinearize_middle_exact_delinearize_unbounded(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0:2 = affine.delinearize_index %arg0 into (3) : index, index
    %1 = affine.linearize_index [%arg1, %0#0, %0#1, %arg2] by (9, 2, 3, 7) : index
    return %1 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_middle_delinearize_unbounded_disjoint_implied_bound(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0:2 = affine.delinearize_index %arg0 into (6, 5) : index, index
    %1 = affine.linearize_index disjoint [%arg1, %0#0, %arg2] by (9, 6, 7) : index
    return %1 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_multiple_matches(%arg0: index, %arg1: index) -> index {
    %c0 = arith.constant 0 : index
    %0:4 = affine.delinearize_index %arg0 into (4, 16, 4, 64) : index, index, index, index
    %1 = affine.linearize_index [%arg1, %0#1, %c0, %0#3] by (4, 16, 4, 64) : index
    return %1 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_multiple_delinearizes(%arg0: index, %arg1: index) -> index {
    %0 = affine.linearize_index [%arg0, %arg1] by (32, 32) : index
    return %0 : index
  }
}

// -----
module {
  func.func @no_cancel_linearize_delinearize_permuted(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0:3 = affine.delinearize_index %arg0 into (%arg1, 4, %arg2) : index, index, index
    %1 = affine.linearize_index [%0#0, %0#2, %0#1] by (%arg1, %arg2, 4) : index
    return %1 : index
  }
}

// -----
#map = affine_map<()[s0] -> (s0 * 3)>
module {
  func.func @partial_cancel_linearize_delinearize_not_fully_permuted(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = affine.apply #map()[%arg2]
    %1:3 = affine.delinearize_index %arg0 into (%arg1, 4, %0) : index, index, index
    %2 = affine.linearize_index [%1#0, %1#2, %1#1] by (%arg1, %0, 4) : index
    return %2 : index
  }
}

// -----
module {
  func.func @cancel_linearize_delinearize_placement(%arg0: index) -> (index, index, index) {
    %c0 = arith.constant 0 : index
    %0:2 = affine.delinearize_index %arg0 into (8, 32) : index, index
    %1:2 = affine.delinearize_index %0#1 into (8, 4) : index, index
    %2 = affine.linearize_index disjoint [%1#1, %0#0, %c0, %c0] by (4, 8, 4, 8) : index
    %3 = affine.linearize_index disjoint [%0#1, %c0, %c0] by (32, 8, 4) : index
    %4 = affine.linearize_index disjoint [%1#0, %0#0, %c0, %c0] by (8, 8, 4, 4) : index
    return %2, %3, %4 : index, index, index
  }
}

// -----
module {
  func.func @no_cancel_linearize_delinearize_different_basis(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0:3 = affine.delinearize_index %arg0 into (%arg1, 4, %arg2) : index, index, index
    %1 = affine.linearize_index [%0#0, %0#1, %0#2] by (%arg1, 8, %arg2) : index
    return %1 : index
  }
}

// -----
module {
  func.func @affine_leading_zero(%arg0: index, %arg1: index) -> index {
    %0 = affine.linearize_index [%arg0, %arg1] by (3, 5) : index
    return %0 : index
  }
}

// -----
module {
  func.func @affine_leading_zero_no_outer_bound(%arg0: index, %arg1: index) -> index {
    %0 = affine.linearize_index [%arg0, %arg1] by (3, 5) : index
    return %0 : index
  }
}

// -----
module {
  func.func @delin_apply_cancel_exact(%arg0: index, %arg1: memref<?xindex>) {
    memref.store %arg0, %arg1[%arg0] : memref<?xindex>
    memref.store %arg0, %arg1[%arg0] : memref<?xindex>
    memref.store %arg0, %arg1[%arg0] : memref<?xindex>
    memref.store %arg0, %arg1[%arg0] : memref<?xindex>
    memref.store %arg0, %arg1[%arg0] : memref<?xindex>
    memref.store %arg0, %arg1[%arg0] : memref<?xindex>
    return
  }
}

// -----
module {
  func.func @delin_apply_cancel_exact_dim(%arg0: memref<?xindex>) {
    affine.for %arg1 = 0 to 256 {
      memref.store %arg1, %arg0[%arg1] : memref<?xindex>
    }
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 + 512)>
module {
  func.func @delin_apply_cancel_const_term(%arg0: index, %arg1: memref<?xindex>) {
    %0 = affine.apply #map()[%arg0]
    memref.store %0, %arg1[%0] : memref<?xindex>
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 + 512)>
module {
  func.func @delin_apply_cancel_var_term(%arg0: index, %arg1: memref<?xindex>, %arg2: index) {
    %0 = affine.apply #map()[%arg2, %arg0]
    memref.store %0, %arg1[%0] : memref<?xindex>
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 * 2 + s0 ceildiv 4)>
module {
  func.func @delin_apply_cancel_nested_exprs(%arg0: index, %arg1: memref<?xindex>) {
    %0 = affine.apply #map()[%arg0]
    memref.store %0, %arg1[%0] : memref<?xindex>
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  func.func @delin_apply_cancel_preserve_rotation(%arg0: index, %arg1: memref<?xindex>) {
    %0:2 = affine.delinearize_index %arg0 into (20) : index, index
    %1 = affine.apply #map()[%0#1, %arg0]
    memref.store %1, %arg1[%1] : memref<?xindex>
    return
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 5)>
module {
  func.func @delin_apply_dont_cancel_partial(%arg0: index, %arg1: memref<?xindex>) {
    %0:3 = affine.delinearize_index %arg0 into (3, 4, 5) : index, index, index
    %1 = affine.apply #map()[%0#2, %0#1]
    memref.store %1, %arg1[%1] : memref<?xindex>
    return
  }
}

// -----
module {
  func.func @cst_value_to_cst_attr_basis_delinearize_index(%arg0: index) -> (index, index, index) {
    %0:3 = affine.delinearize_index %arg0 into (3, 4, 2) : index, index, index
    return %0#0, %0#1, %0#2 : index, index, index
  }
}

// -----
module {
  func.func @cst_value_to_cst_attr_basis_linearize_index(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = affine.linearize_index disjoint [%arg0, %arg1, %arg2] by (2, 3, 4) : index
    return %0 : index
  }
  func.func @for_empty_body_folder_iv_yield() -> index {
    %c18 = arith.constant 18 : index
    %0 = affine.for %arg0 = 0 to 114 iter_args(%arg1 = %c18) -> (index) {
      affine.yield %arg0 : index
    }
    return %0 : index
  }
}

