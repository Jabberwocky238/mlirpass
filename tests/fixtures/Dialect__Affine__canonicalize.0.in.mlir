"builtin.module"() ({
^bb0:
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 - 1)>
#map1 = affine_map<(d0, d1) -> (d0)>
#map2 = affine_map<(d0, d1) -> (d1)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<() -> (0)>
#map5 = affine_map<() -> (15)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "compose_affine_maps_1dto2d_no_symbols"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x4xf32>
    "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
    ^bb0(%arg0: index):
      %1 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
      %2 = "affine.apply"(%1, %1) <{map = #map1}> : (index, index) -> index
      %3 = "affine.apply"(%1, %1) <{map = #map2}> : (index, index) -> index
      %4 = "memref.load"(%0, %2, %3) : (memref<4x4xf32>, index, index) -> f32
      %5 = "affine.apply"(%arg0) <{map = #map3}> : (index) -> index
      %6 = "affine.apply"(%5, %5) <{map = #map1}> : (index, index) -> index
      %7 = "affine.apply"(%5, %5) <{map = #map2}> : (index, index) -> index
      "memref.store"(%4, %0, %6, %7) : (f32, memref<4x4xf32>, index, index) -> ()
      %8 = "affine.apply"(%1, %5) <{map = #map1}> : (index, index) -> index
      %9 = "affine.apply"(%1, %5) <{map = #map2}> : (index, index) -> index
      "memref.store"(%4, %0, %8, %9) : (f32, memref<4x4xf32>, index, index) -> ()
      %10 = "affine.apply"(%5, %1) <{map = #map1}> : (index, index) -> index
      %11 = "affine.apply"(%5, %1) <{map = #map2}> : (index, index) -> index
      "memref.store"(%4, %0, %10, %11) : (f32, memref<4x4xf32>, index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 - s0)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0, d1) -> (d0 + d1)>
#map3 = affine_map<(d0)[s0] -> (d0 + s0)>
#map4 = affine_map<() -> (0)>
#map5 = affine_map<() -> (15)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "compose_affine_maps_1dto2d_with_symbols"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x4xf32>
    "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
    ^bb0(%arg0: index):
      %1 = "arith.constant"() <{value = 4 : index}> : () -> index
      %2 = "affine.apply"(%arg0, %1) <{map = #map}> : (index, index) -> index
      %3 = "memref.load"(%0, %2, %2) : (memref<4x4xf32>, index, index) -> f32
      %4 = "affine.apply"(%arg0) <{map = #map1}> : (index) -> index
      %5 = "affine.apply"(%2, %4) <{map = #map2}> : (index, index) -> index
      "memref.store"(%3, %0, %5, %5) : (f32, memref<4x4xf32>, index, index) -> ()
      %6 = "affine.apply"(%4, %2) <{map = #map2}> : (index, index) -> index
      "memref.store"(%3, %0, %6, %6) : (f32, memref<4x4xf32>, index, index) -> ()
      %7 = "arith.constant"() <{value = 5 : index}> : () -> index
      %8 = "affine.apply"(%arg0, %7) <{map = #map3}> : (index, index) -> index
      %9 = "affine.apply"(%8, %2) <{map = #map2}> : (index, index) -> index
      "memref.store"(%3, %0, %9, %9) : (f32, memref<4x4xf32>, index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 ceildiv s0)>
#map1 = affine_map<(d0)[s0] -> (d0 mod s0)>
#map2 = affine_map<(d0, d1, d2, d3)[s0, s1] -> (d0 * s0 + d2)>
#map3 = affine_map<(d0, d1, d2, d3)[s0, s1] -> (d1 * s1 + d3)>
#map4 = affine_map<() -> (0)>
#map5 = affine_map<() -> (16)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x32xf32>, memref<16x32xf32>) -> (), sym_name = "compose_affine_maps_2d_tile"}> ({
  ^bb0(%arg0: memref<16x32xf32>, %arg1: memref<16x32xf32>):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "arith.constant"() <{value = 8 : index}> : () -> index
    "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
    ^bb0(%arg2: index):
      %2 = "affine.apply"(%arg2, %0) <{map = #map}> : (index, index) -> index
      "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
      ^bb0(%arg3: index):
        %3 = "affine.apply"(%arg3, %1) <{map = #map}> : (index, index) -> index
        "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
        ^bb0(%arg4: index):
          %4 = "affine.apply"(%arg4, %0) <{map = #map1}> : (index, index) -> index
          "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
          ^bb0(%arg5: index):
            %5 = "affine.apply"(%arg5, %1) <{map = #map1}> : (index, index) -> index
            %6 = "affine.apply"(%2, %3, %4, %5, %0, %1) <{map = #map2}> : (index, index, index, index, index, index) -> index
            %7 = "affine.apply"(%2, %3, %4, %5, %0, %1) <{map = #map3}> : (index, index, index, index, index, index) -> index
            %8 = "memref.load"(%arg0, %6, %7) : (memref<16x32xf32>, index, index) -> f32
            "memref.store"(%8, %arg1, %6, %7) : (f32, memref<16x32xf32>, index, index) -> ()
            "affine.yield"() : () -> ()
          }) : () -> ()
          "affine.yield"() : () -> ()
        }) : () -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2)[s0, s1] -> (d0 + s0)>
#map1 = affine_map<(d0, d1, d2)[s0, s1] -> (d1 - s1)>
#map2 = affine_map<(d0, d1, d2)[s0, s1] -> (d2 * s0)>
#map3 = affine_map<(d0, d1)[s0, s1] -> (d0 * s1)>
#map4 = affine_map<(d0, d1)[s0, s1] -> (d1 ceildiv s0)>
#map5 = affine_map<() -> (0)>
#map6 = affine_map<() -> (3)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "compose_affine_maps_dependent_loads"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xf32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xf32>
    "affine.for"() <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg0: index):
      "affine.for"() <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map6}> ({
      ^bb0(%arg1: index):
        "affine.for"() <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map6}> ({
        ^bb0(%arg2: index):
          %2 = "arith.constant"() <{value = 3 : index}> : () -> index
          %3 = "arith.constant"() <{value = 7 : index}> : () -> index
          %4 = "affine.apply"(%arg0, %arg1, %arg2, %2, %3) <{map = #map}> : (index, index, index, index, index) -> index
          %5 = "affine.apply"(%arg0, %arg1, %arg2, %2, %3) <{map = #map1}> : (index, index, index, index, index) -> index
          %6 = "affine.apply"(%arg0, %arg1, %arg2, %2, %3) <{map = #map2}> : (index, index, index, index, index) -> index
          %7 = "memref.load"(%0, %4, %5) : (memref<16x32xf32>, index, index) -> f32
          "memref.store"(%7, %0, %4, %6) : (f32, memref<16x32xf32>, index, index) -> ()
          "memref.store"(%7, %0, %5, %4) : (f32, memref<16x32xf32>, index, index) -> ()
          %8 = "affine.apply"(%5, %4, %2, %3) <{map = #map3}> : (index, index, index, index) -> index
          %9 = "affine.apply"(%5, %4, %2, %3) <{map = #map4}> : (index, index, index, index) -> index
          "memref.store"(%7, %0, %8, %9) : (f32, memref<16x32xf32>, index, index) -> ()
          "affine.yield"() : () -> ()
        }) : () -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 - 1)>
#map1 = affine_map<(d0) -> (d0 + 7)>
#map2 = affine_map<(d0) -> (d0 * 4)>
#map3 = affine_map<(d0, d1) -> (d0 ceildiv 8)>
#map4 = affine_map<(d0, d1) -> (d1 floordiv 3)>
#map5 = affine_map<() -> (0)>
#map6 = affine_map<() -> (15)>
"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<4x4xf32>) -> (), sym_name = "compose_affine_maps_diamond_dependency"}> ({
  ^bb0(%arg0: f32, %arg1: memref<4x4xf32>):
    "affine.for"() <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg2: index):
      %0 = "affine.apply"(%arg2) <{map = #map}> : (index) -> index
      %1 = "affine.apply"(%0) <{map = #map1}> : (index) -> index
      %2 = "affine.apply"(%0) <{map = #map2}> : (index) -> index
      %3 = "affine.apply"(%1, %2) <{map = #map3}> : (index, index) -> index
      %4 = "affine.apply"(%1, %2) <{map = #map4}> : (index, index) -> index
      "memref.store"(%arg0, %arg1, %3, %4) : (f32, memref<4x4xf32>, index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0)>
#map1 = affine_map<(d0) -> (d0 * 4)>
#map2 = affine_map<(d0)[s0] -> (d0 floordiv s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "compose_affine_maps_multiple_symbols"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.apply"(%arg0, %arg1) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%0) <{map = #map1}> : (index) -> index
    %2 = "affine.apply"(%1, %arg1) <{map = #map2}> : (index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1)[s0, s1] -> (d1 + s0 + s1)>
#map1 = affine_map<(d0, d1, d2) -> (d2 - (d0 + d1))>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<() -> (100)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<100x100xf32>, index, f32) -> (memref<100x100xf32, 1>, memref<1xi32>), sym_name = "arg_used_as_dim_and_symbol"}> ({
  ^bb0(%arg0: memref<100x100xf32>, %arg1: index, %arg2: f32):
    %0 = "arith.constant"() <{value = 9 : index}> : () -> index
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100x100xf32, 1>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xi32>
    "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg3: index):
      "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
      ^bb0(%arg4: index):
        %3 = "affine.apply"(%arg3, %arg4, %arg1, %0) <{map = #map}> : (index, index, index, index) -> index
        %4 = "affine.apply"(%arg1, %0, %3) <{map = #map1}> : (index, index, index) -> index
        "memref.store"(%arg2, %1, %4, %arg1) : (f32, memref<100x100xf32, 1>, index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"(%1, %2) : (memref<100x100xf32, 1>, memref<1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (10)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "trivial_maps"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg0: index):
      %3 = "affine.apply"(%1) <{map = #map}> : (index) -> index
      "memref.store"(%2, %0, %3) : (f32, memref<10xf32>, index) -> ()
      %4 = "memref.load"(%0, %1) : (memref<10xf32>, index) -> f32
      %5 = "affine.apply"() <{map = #map1}> : () -> index
      "memref.store"(%2, %0, %5) : (f32, memref<10xf32>, index) -> ()
      "memref.store"(%4, %0, %1) : (f32, memref<10xf32>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 - d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "partial_fold_map"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 42 : index}> : () -> index
    %1 = "affine.apply"(%arg0, %0) <{map = #map}> : (index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 * 4)>
#map1 = affine_map<()[s0, s1] -> (s0 * 8)>
#map2 = affine_map<()[s0, s1] -> (s1 * 16)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "symbolic_composition_a"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.apply"(%0, %arg0) <{map = #map1}> : (index, index) -> index
    %2 = "affine.apply"(%arg1, %1) <{map = #map2}> : (index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<()[s0, s1, s2, s3] -> (s0 + s1 + s2 + s3)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> index, sym_name = "symbolic_composition_b"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.apply"(%0, %0, %0, %0) <{map = #map1}> : (index, index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<()[s0, s1, s2, s3] -> (s0 + s1 + s2 + s3)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> index, sym_name = "symbolic_composition_c"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.apply"(%arg1) <{map = #map}> : (index) -> index
    %2 = "affine.apply"(%0, %0, %0, %1) <{map = #map1}> : (index, index, index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<()[s0] -> (s0)>
#map2 = affine_map<()[s0, s1, s2, s3] -> (s0 + s1 + s2 + s3)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> index, sym_name = "symbolic_composition_d"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
    %2 = "affine.apply"(%0, %0, %0, %1) <{map = #map2}> : (index, index, index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0 * 42 - 1)>
#map1 = affine_map<(d0) -> (d0 + 7)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "mix_dims_and_symbols_b"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.apply"(%arg0, %arg1) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%0) <{map = #map1}> : (index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0 * 42 - 1)>
#map1 = affine_map<(d0) -> (d0 + 7)>
#map2 = affine_map<(d0) -> (d0 * 4)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "mix_dims_and_symbols_c"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.apply"(%arg0, %arg1) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%0) <{map = #map1}> : (index) -> index
    %2 = "affine.apply"(%0) <{map = #map2}> : (index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0 * 42 - 1)>
#map1 = affine_map<(d0) -> (d0 + 7)>
#map2 = affine_map<(d0) -> (d0 * 4)>
#map3 = affine_map<()[s0] -> (s0 ceildiv 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "mix_dims_and_symbols_d"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.apply"(%arg0, %arg1) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%0) <{map = #map1}> : (index) -> index
    %2 = "affine.apply"(%0) <{map = #map2}> : (index) -> index
    %3 = "affine.apply"(%1) <{map = #map3}> : (index) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0 * 42 - 1)>
#map1 = affine_map<(d0) -> (d0 + 7)>
#map2 = affine_map<(d0) -> (d0 * 4)>
#map3 = affine_map<()[s0] -> (s0 ceildiv 8)>
#map4 = affine_map<(d0) -> (d0 floordiv 3)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "mix_dims_and_symbols_e"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.apply"(%arg0, %arg1) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%0) <{map = #map1}> : (index) -> index
    %2 = "affine.apply"(%0) <{map = #map2}> : (index) -> index
    %3 = "affine.apply"(%1) <{map = #map3}> : (index) -> index
    %4 = "affine.apply"(%2) <{map = #map4}> : (index) -> index
    "func.return"(%4) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 + s0 * 42 - 1)>
#map1 = affine_map<(d0) -> (d0 + 7)>
#map2 = affine_map<(d0) -> (d0 * 4)>
#map3 = affine_map<()[s0] -> (s0 ceildiv 8)>
#map4 = affine_map<(d0) -> (d0 floordiv 3)>
#map5 = affine_map<(d0, d1)[s0, s1] -> (d0 - s1 + d1 - s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "mix_dims_and_symbols_f"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.apply"(%arg0, %arg1) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%0) <{map = #map1}> : (index) -> index
    %2 = "affine.apply"(%0) <{map = #map2}> : (index) -> index
    %3 = "affine.apply"(%1) <{map = #map3}> : (index) -> index
    %4 = "affine.apply"(%2) <{map = #map4}> : (index) -> index
    %5 = "affine.apply"(%3, %4, %4, %3) <{map = #map5}> : (index, index, index, index) -> index
    "func.return"(%5) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 * 4)>
#map1 = affine_map<()[s0, s1] -> (s0 * 4)>
#map2 = affine_map<()[s0, s1] -> (s1)>
#map3 = affine_map<()[s0, s1] -> (1024)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (index, index, index), sym_name = "mix_dims_and_symbols_g"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.apply"(%arg1, %0) <{map = #map1}> : (index, index) -> index
    %2 = "affine.apply"(%arg1, %0) <{map = #map2}> : (index, index) -> index
    %3 = "affine.apply"(%arg1, %0) <{map = #map3}> : (index, index) -> index
    "func.return"(%1, %2, %3) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 1)>
#map1 = affine_map<(d0)[s0] -> (d0 floordiv s0)>
#map2 = affine_map<() -> (1)>
#map3 = affine_map<() -> (100)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<?xf32>) -> (), sym_name = "symbolic_semi_affine"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<?xf32>):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg3: index):
      %1 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
      %2 = "affine.apply"(%arg3, %1) <{map = #map1}> : (index, index) -> index
      "memref.store"(%0, %arg2, %2) : (f32, memref<?xf32>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 + d1)>
#map1 = affine_map<(d0, d1) -> (0, d0 + d1)>
#map2 = affine_map<(d0, d1) -> (d0 - 2, d1 * 32)>
#map3 = affine_map<(d0) -> (0, 1)>
#map4 = affine_map<(d0, d1) -> (7, 9)>
#map5 = affine_map<()[s0] -> (0, s0)>
#map6 = affine_map<()[s0] -> (100, s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "constant_fold_bounds"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 9 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "affine.apply"(%1, %2) <{map = #map}> : (index, index) -> index
    %4 = "foo"() : () -> index
    "affine.for"(%2, %3, %0, %1) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 2, 2, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg3: index):
      "foo"(%arg3, %3) : (index, index) -> ()
      "affine.yield"() : () -> ()
    }) : (index, index, index, index) -> ()
    "affine.for"(%arg0, %arg0, %4) <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 1, 2, 0>, step = 1 : index, upperBoundMap = #map4}> ({
    ^bb0(%arg2: index):
      "foo"(%arg2, %3) : (index, index) -> ()
      "affine.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "affine.for"(%4, %arg0) <{lowerBoundMap = #map5, operandSegmentSizes = array<i32: 1, 1, 0>, step = 1 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg1: index):
      "foo"(%arg1, %3) : (index, index) -> ()
      "affine.yield"() : () -> ()
    }) : (index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (10)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "fold_empty_loops"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg2: index):
      "affine.yield"() : () -> ()
    }) : () -> ()
    %1 = "affine.for"(%0) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 1>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg0: index, %arg1: index):
      "affine.yield"(%arg1) : (index) -> ()
    }) : (index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (10)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index), sym_name = "fold_empty_loop"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3:2 = "affine.for"(%0, %1) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 2>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index):
      "affine.yield"(%2, %arg2) : (index, index) -> ()
    }) : (index, index) -> (index, index)
    "func.return"(%3#0, %3#1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (1)>
#map2 = affine_map<() -> (2)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index, index, index), sym_name = "fold_empty_loops_trip_count_1"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3:2 = "affine.for"(%2, %0) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 2>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg3: index, %arg4: index, %arg5: index):
      "affine.yield"(%1, %arg4) : (index, index) -> ()
    }) : (index, index) -> (index, index)
    %4:2 = "affine.for"(%2, %0) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 2>, step = 3 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index):
      "affine.yield"(%arg2, %arg1) : (index, index) -> ()
    }) : (index, index) -> (index, index)
    "func.return"(%3#0, %3#1, %4#0, %4#1) : (index, index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index), sym_name = "fold_empty_loop_trip_count_0"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3:2 = "affine.for"(%2, %0) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 2>, step = 1 : index, upperBoundMap = #map}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index):
      "affine.yield"(%1, %arg1) : (index, index) -> ()
    }) : (index, index) -> (index, index)
    "func.return"(%3#0, %3#1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (index, index), sym_name = "fold_empty_loop_trip_count_unknown"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2:2 = "affine.for"(%arg0, %0, %1) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 1, 2>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index):
      "affine.yield"(%arg2, %arg3) : (index, index) -> ()
    }) : (index, index, index) -> (index, index)
    "func.return"(%2#0, %2#1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "empty_loops_not_folded_1"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "affine.for"(%arg0, %0) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 1, 1>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg1: index, %arg2: index):
      "affine.yield"(%1) : (index) -> ()
    }) : (index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (index, index), sym_name = "empty_loops_not_folded_2"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2:2 = "affine.for"(%arg0, %0, %1) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 1, 2>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index):
      "affine.yield"(%arg3, %arg2) : (index, index) -> ()
    }) : (index, index, index) -> (index, index)
    "func.return"(%2#0, %2#1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (10)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index), sym_name = "empty_loops_not_folded_3"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2:2 = "affine.for"(%0, %1) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 2>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index):
      "affine.yield"(%arg2, %arg1) : (index, index) -> ()
    }) : (index, index) -> (index, index)
    "func.return"(%2#0, %2#1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<() -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "zero_iter_loop_not_folded"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg0: index):
      %1 = "affine.load"(%0, %arg0) <{map = #map}> : (memref<4xf32>, index) -> f32
      "affine.store"(%1, %0, %arg0) <{map = #map}> : (f32, memref<4xf32>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "fold_zero_iter_loops"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "affine.for"(%arg0) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 1>, step = 1 : index, upperBoundMap = #map}> ({
    ^bb0(%arg1: index, %arg2: index):
      %2 = "arith.addi"(%arg2, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "affine.yield"(%2) : (index) -> ()
    }) : (index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<()[s0] -> (s0)>
#map2 = affine_map<() -> (1024)>
#set = affine_set<(d0, d1, d2, d3)[s0] : (d1 >= 0, d0 - d1 >= 0, d2 >= 0, d3 - d2 - 2 >= 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "canonicalize_affine_if"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 1022 : index}> : () -> index
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg2: index):
      "affine.for"(%arg1) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map1}> ({
      ^bb0(%arg3: index):
        "affine.if"(%0, %arg2, %arg3, %arg1, %arg0) <{condition = #set}> ({
          "foo"() : () -> ()
          "affine.yield"() : () -> ()
        }, {
        }) : (index, index, index, index, index) -> ()
        "bar"() : () -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 10)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<() -> (100)>
#map4 = affine_map<() -> (1024)>
#set = affine_set<(d0, d1)[s0] : (d0 - 1 >= 0, d1 - 2 == 0, -d0 + s0 >= 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "canonicalize_affine_if_compose_apply"}> ({
  ^bb0(%arg0: index):
    %0 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
    "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map4}> ({
    ^bb0(%arg1: index):
      "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
      ^bb0(%arg2: index):
        %1 = "affine.apply"(%arg2) <{map = #map1}> : (index) -> index
        "affine.if"(%arg1, %1, %0) <{condition = #set}> ({
          "test.foo"() : () -> ()
          "affine.yield"() : () -> ()
        }, {
        }) : (index, index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1 + d2)>
#map2 = affine_map<(d0) -> (d0 * 4)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
#map4 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "canonicalize_bounds"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1024 : index}> : () -> index
    "affine.for"(%1, %arg0, %arg0, %arg1) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 4, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg4: index):
      "foo"() : () -> ()
      "affine.yield"() : () -> ()
    }) : (index, index, index, index) -> ()
    "affine.for"(%arg0) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg3: index):
      "foo"() : () -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "affine.for"(%0, %arg1, %arg0) <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 2, 1, 0>, step = 1 : index, upperBoundMap = #map4}> ({
    ^bb0(%arg2: index):
      "foo"() : () -> ()
      "affine.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 + 1)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<() -> (1024)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1024xf32>, index) -> (), sym_name = "compose_into_affine_load_store"}> ({
  ^bb0(%arg0: memref<1024xf32>, %arg1: index):
    "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg2: index):
      %0 = "affine.apply"(%arg2, %arg1) <{map = #map}> : (index, index) -> index
      %1 = "affine.load"(%arg0, %0) <{map = #map1}> : (memref<1024xf32>, index) -> f32
      "affine.store"(%1, %arg0, %0) <{map = #map1}> : (f32, memref<1024xf32>, index) -> ()
      %2 = "affine.apply"(%arg2) <{map = #map1}> : (index) -> index
      %3 = "affine.load"(%arg0, %2) <{map = #map1}> : (memref<1024xf32>, index) -> f32
      "prevent.dce"(%3) : (f32) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (1000, d0 + 512, s0 + 1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "affine_min"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 511 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "affine.min"(%1, %0) <{map = #map}> : (index, index) -> index
    "op0"(%2) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (1000, d0 floordiv 4, s0 mod 5 + 1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "affine_min"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "arith.constant"() <{value = 20 : index}> : () -> index
    %2 = "affine.min"(%1, %0) <{map = #map}> : (index, index) -> index
    "op0"(%2) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (1000, d0 + 512, s0 + 1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "affine_max"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 511 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "affine.max"(%1, %0) <{map = #map}> : (index, index) -> index
    "op0"(%2) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (1000, d0 floordiv 4, s0 mod 5 + 1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "affine_max"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "arith.constant"() <{value = 20 : index}> : () -> index
    %2 = "affine.max"(%1, %0) <{map = #map}> : (index, index) -> index
    "op0"(%2) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1 - d2)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_min"}> ({
  ^bb0(%arg0: index):
    "affine.for"(%arg0) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg1: index):
      "affine.for"(%arg0) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg2: index):
        %0 = "arith.constant"() <{value = 2 : index}> : () -> index
        %1 = "affine.min"(%arg1, %arg2, %0) <{map = #map}> : (index, index, index) -> index
        "consumer"(%1) : (index) -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
#map1 = affine_map<(d0)[s0] -> (1024, -d0 + s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "rep"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1024 : index}> : () -> index
    %2 = "affine.apply"(%arg0, %1, %0) <{map = #map}> : (index, index, index) -> index
    %3 = "affine.min"(%2, %arg1) <{map = #map1}> : (index, index) -> index
    "func.return"(%3) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0, d0)>
#map1 = affine_map<(d0) -> (d0 + 2, d0 + 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "drop_duplicate_bounds"}> ({
  ^bb0(%arg0: index):
    "affine.for"(%arg0, %arg0) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 1, 1, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg1: index):
      "foo"() : () -> ()
      "affine.yield"() : () -> ()
    }) : (index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 * 5)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<(d0, d1) -> (d0 + d1)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "affine_parallel_const_bounds"}> ({
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    "affine.parallel"(%1, %1, %2) <{lowerBoundsGroups = dense<1> : tensor<1xi32>, lowerBoundsMap = #map1, reductions = [], steps = [1], upperBoundsGroups = dense<1> : tensor<1xi32>, upperBoundsMap = #map2}> ({
    ^bb0(%arg0: index):
      %4 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
      "affine.parallel"(%1, %4) <{lowerBoundsGroups = dense<1> : tensor<1xi32>, lowerBoundsMap = #map1, reductions = [], steps = [1], upperBoundsGroups = dense<1> : tensor<1xi32>, upperBoundsMap = #map1}> ({
      ^bb0(%arg1: index):
        "affine.store"(%0, %3, %arg1) <{map = #map1}> : (f32, memref<4xf32>, index) -> ()
        "affine.yield"() : () -> ()
      }) : (index, index) -> ()
      "affine.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 * 2)>
#map1 = affine_map<()[s0] -> (s0 * 3)>
#map2 = affine_map<(d0)[s0, s1] -> (d0 mod s1 + s0 * s1 + s0 * 4)>
#map3 = affine_map<(d0)[s0, s1] -> (d0 ceildiv s1 + s0 + s0 * 3)>
#map4 = affine_map<() -> (0)>
#map5 = affine_map<() -> (3)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i64>, index, index) -> (), sym_name = "compose_affine_maps_div_symbol"}> ({
  ^bb0(%arg0: memref<i64>, %arg1: index, %arg2: index):
    %0 = "affine.apply"(%arg1) <{map = #map}> : (index) -> index
    %1 = "affine.apply"(%arg1) <{map = #map1}> : (index) -> index
    %2 = "affine.apply"(%arg2, %0, %1) <{map = #map2}> : (index, index, index) -> index
    %3 = "arith.index_cast"(%2) : (index) -> i64
    "memref.store"(%3, %arg0) : (i64, memref<i64>) -> ()
    "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
    ^bb0(%arg3: index):
      %4 = "affine.apply"(%arg3, %0, %1) <{map = #map3}> : (index, index, index) -> index
      %5 = "arith.index_cast"(%4) : (index) -> i64
      "memref.store"(%5, %arg0) : (i64, memref<i64>) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1, s0 * s1, s0 + s1, s0 * s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "deduplicate_affine_min_expressions"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.min"(%arg0, %arg1) <{map = #map}> : (index, index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1, s0 * s1, s0 + s1, s0 * s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "deduplicate_affine_max_expressions"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.max"(%arg0, %arg1) <{map = #map}> : (index, index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (16, d0 - s0)>
#map1 = affine_map<(d0)[s0] -> (s0 * 3, d0)>
#map2 = affine_map<(d0)[s0] -> (s0, -d0 + 5)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> (index, index), sym_name = "merge_affine_min_ops"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "affine.min"(%arg0, %arg1) <{map = #map}> : (index, index) -> index
    %1 = "affine.min"(%0, %arg2) <{map = #map1}> : (index, index) -> index
    %2 = "affine.min"(%arg3, %0) <{map = #map2}> : (index, index) -> index
    "func.return"(%1, %2) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0] -> (s0 + 8, s0 * 4)>
#map2 = affine_map<()[s0, s1, s2] -> (s0, s1 + 7, s2)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "merge_multiple_affine_min_ops"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "affine.min"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.min"(%arg1) <{map = #map1}> : (index) -> index
    %2 = "affine.min"(%0, %arg2, %1) <{map = #map2}> : (index, index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0, s1, s2] -> (s0, s1, s2 * 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "merge_multiple_uses_of_affine_min_ops"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.min"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.min"(%0, %0, %arg1) <{map = #map1}> : (index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0, s1, s2] -> (s0, s1 + 1, s2 * 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "merge_mixed_uses_of_affine_min_ops"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.min"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.min"(%0, %0, %arg1) <{map = #map1}> : (index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<(d0)[s0] -> (s0 + 4, d0 + 7)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "dont_merge_affine_min_if_not_single_dim"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "affine.min"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.min"(%0, %arg2) <{map = #map1}> : (index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0, s1] -> (s0 + 4, s1 + 7)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "dont_merge_affine_min_if_not_single_sym"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "affine.min"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.min"(%0, %arg2) <{map = #map1}> : (index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (16, d0 - s0)>
#map1 = affine_map<(d0)[s0] -> (s0 * 3, d0)>
#map2 = affine_map<(d0)[s0] -> (s0, -d0 + 5)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> (index, index), sym_name = "merge_affine_max_ops"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "affine.max"(%arg0, %arg1) <{map = #map}> : (index, index) -> index
    %1 = "affine.max"(%0, %arg2) <{map = #map1}> : (index, index) -> index
    %2 = "affine.max"(%arg3, %0) <{map = #map2}> : (index, index) -> index
    "func.return"(%1, %2) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0] -> (s0 + 8, s0 * 4)>
#map2 = affine_map<()[s0, s1, s2] -> (s0, s1 + 7, s2)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "merge_multiple_affine_max_ops"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "affine.max"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.max"(%arg1) <{map = #map1}> : (index) -> index
    %2 = "affine.max"(%0, %arg2, %1) <{map = #map2}> : (index, index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0, s1, s2] -> (s0, s1, s2 * 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "merge_multiple_uses_of_affine_max_ops"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.max"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.max"(%0, %0, %arg1) <{map = #map1}> : (index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0, s1, s2] -> (s0, s1 + 1, s2 * 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "merge_mixed_uses_of_affine_max_ops"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.max"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.max"(%0, %0, %arg1) <{map = #map1}> : (index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<(d0)[s0] -> (s0 + 4, d0 + 7)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "dont_merge_affine_max_if_not_single_dim"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "affine.max"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.max"(%0, %arg2) <{map = #map1}> : (index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 16, s0 * 8)>
#map1 = affine_map<()[s0, s1] -> (s0 + 4, s1 + 7)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "dont_merge_affine_max_if_not_single_sym"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "affine.max"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.max"(%0, %arg2) <{map = #map1}> : (index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 + 2)>
#map1 = affine_map<(d0) -> (d0 - 2)>
#map2 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "compose_affine_for_bounds"}> ({
  ^bb0(%arg0: index):
    %0 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.apply"(%arg0) <{map = #map1}> : (index) -> index
    "affine.for"(%1, %0) <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 1, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg1: index):
      "foo"() : () -> ()
      "affine.yield"() : () -> ()
    }) : (index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 + 1)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<() -> (1024)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1024xf32>, index) -> (), sym_name = "compose_into_affine_vector_load_vector_store"}> ({
  ^bb0(%arg0: memref<1024xf32>, %arg1: index):
    "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg2: index):
      %0 = "affine.apply"(%arg2, %arg1) <{map = #map}> : (index, index) -> index
      %1 = "affine.vector_load"(%arg0, %0) <{map = #map1}> : (memref<1024xf32>, index) -> vector<8xf32>
      "affine.vector_store"(%1, %arg0, %0) <{map = #map1}> : (vector<8xf32>, memref<1024xf32>, index) -> ()
      %2 = "affine.apply"(%arg2) <{map = #map1}> : (index) -> index
      %3 = "affine.vector_load"(%arg0, %2) <{map = #map1}> : (memref<1024xf32>, index) -> vector<8xf32>
      "prevent.dce"(%3) : (vector<8xf32>) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<32xi8>, memref<memref<?xi8>>) -> (), sym_name = "no_fold_of_store"}> ({
  ^bb0(%arg0: memref<32xi8>, %arg1: memref<memref<?xi8>>):
    %0 = "memref.cast"(%arg0) : (memref<32xi8>) -> memref<?xi8>
    "affine.store"(%0, %arg1) <{map = #map}> : (memref<?xi8>, memref<memref<?xi8>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 + 16)>
#map1 = affine_map<()[s0] -> (s0 * 4)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (index, index), sym_name = "canonicalize_single_min_max"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.min"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.min"(%arg1) <{map = #map1}> : (index) -> index
    "func.return"(%0, %1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1, s1 + 16, 32)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1, 32, s1 + 16)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (index, index), sym_name = "canonicalize_multi_min_max"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.min"(%arg0, %arg1) <{map = #map}> : (index, index) -> index
    %1 = "affine.max"(%arg0, %arg1) <{map = #map1}> : (index, index) -> index
    "func.return"(%0, %1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0, 0, 0)>
#map1 = affine_map<() -> (0, 1, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<() -> (0)>
#map4 = affine_map<() -> (64)>
#map5 = affine_map<() -> (32)>
"builtin.module"() ({
  "memref.global"() <{constant, initial_value = dense<[[[6.250000e-02], [2.500000e-01], [3.750000e-01], [2.500000e-01], [6.250000e-02]]]> : tensor<1x5x1xf32>, sym_name = "__constant_1x5x1xf32", sym_visibility = "private", type = memref<1x5x1xf32>}> : () -> ()
  "memref.global"() <{constant, initial_value = dense<0.000000e+00> : tensor<32x64xf32>, sym_name = "__constant_32x64xf32", sym_visibility = "private", type = memref<32x64xf32>}> : () -> ()
  "func.func"() <{function_type = () -> (f32, f32), sym_name = "fold_const_init_global_memref"}> ({
    %3 = "memref.get_global"() <{name = @__constant_1x5x1xf32}> : () -> memref<1x5x1xf32>
    %4 = "affine.load"(%3) <{map = #map}> : (memref<1x5x1xf32>) -> f32
    %5 = "affine.load"(%3) <{map = #map1}> : (memref<1x5x1xf32>) -> f32
    "func.return"(%4, %5) : (f32, f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> memref<32x64xf32>, sym_name = "fold_const_splat_global"}> ({
    %0 = "memref.get_global"() <{name = @__constant_32x64xf32}> : () -> memref<32x64xf32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x64xf32>
    "affine.for"() <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
    ^bb0(%arg0: index):
      "affine.for"() <{lowerBoundMap = #map3, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map4}> ({
      ^bb0(%arg1: index):
        %2 = "affine.load"(%0, %arg0, %arg1) <{map = #map2}> : (memref<32x64xf32>, index, index) -> f32
        "affine.store"(%2, %1, %arg0, %arg1) <{map = #map2}> : (f32, memref<32x64xf32>, index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"(%1) : (memref<32x64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0 floordiv 32, d1 mod 32)>
#map1 = affine_map<(d0, d1) -> ((d0 + d1) floordiv 32, (d0 + d1) mod 16)>
#map2 = affine_map<(d0, d1) -> ((d0 + d1) floordiv 64, (d0 + d1) mod 64)>
#map3 = affine_map<(d0, d1) -> ((d0 + d1) floordiv 16, (d0 + d1) mod 16)>
#map4 = affine_map<() -> (0)>
#map5 = affine_map<() -> (32)>
#map6 = affine_map<()[s0] -> (s0)>
#map7 = affine_map<(d0) -> (d0 floordiv 32, d0 mod 32)>
#map8 = affine_map<() -> (-1)>
#map9 = affine_map<(d0, d1, d2) -> (((d0 + d2) mod 458313) floordiv 227 + d1 floordiv 256)>
#map10 = affine_map<() -> (128)>
#map11 = affine_map<(d0) -> (d0 floordiv 32)>
#map12 = affine_map<(d0) -> ((d0 + 1) ceildiv 32)>
#map13 = affine_map<(d0) -> (d0 mod 32)>
#map14 = affine_map<(d0) -> ((d0 * 2) floordiv 64)>
#map15 = affine_map<(d0) -> ((d0 mod 16) floordiv 16)>
#map16 = affine_map<(d0) -> (d0 floordiv 16)>
#map17 = affine_map<(d0) -> (d0 mod 16)>
#map18 = affine_map<(d0) -> ((d0 mod 16) floordiv 15)>
#map19 = affine_map<(d0) -> (d0 mod 31)>
#map20 = affine_map<(d0) -> ((d0 - 96) floordiv 64 + 2)>
#map21 = affine_map<() -> (-8)>
#map22 = affine_map<(d0) -> (d0 floordiv 8)>
#map23 = affine_map<(d0) -> ((d0 + 1) ceildiv 8)>
#map24 = affine_map<(d0) -> (d0 mod 8)>
#map25 = affine_map<(d0) -> ((d0 mod 32) floordiv 16)>
#map26 = affine_map<(d0) -> ((d0 mod 16) floordiv 8)>
#map27 = affine_map<() -> (8)>
#map28 = affine_map<() -> (16)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<?x32xf32>) -> (), sym_name = "simplify_with_operands"}> ({
  ^bb0(%arg6: index, %arg7: memref<?x32xf32>):
    "affine.for"(%arg6) <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 1, 0>, step = 32 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg12: index):
      "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
      ^bb0(%arg13: index):
        %3 = "affine.load"(%arg7, %arg13, %arg12) <{map = #map}> : (memref<?x32xf32>, index, index) -> f32
        "test.foo"(%3) : (f32) -> ()
        %4 = "affine.load"(%arg7, %arg12, %arg13) <{map = #map1}> : (memref<?x32xf32>, index, index) -> f32
        "test.foo"(%4) : (f32) -> ()
        %5 = "affine.load"(%arg7, %arg12, %arg13) <{map = #map2}> : (memref<?x32xf32>, index, index) -> f32
        "test.foo"(%5) : (f32) -> ()
        %6 = "affine.load"(%arg7, %arg12, %arg13) <{map = #map3}> : (memref<?x32xf32>, index, index) -> f32
        "test.foo"(%6) : (f32) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "affine.for"() <{lowerBoundMap = #map8, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
    ^bb0(%arg11: index):
      %2 = "affine.load"(%arg7, %arg11) <{map = #map7}> : (memref<?x32xf32>, index) -> f32
      "test.foo"(%2) : (f32) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "affine.for"(%arg6) <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 1, 0>, step = 128 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg8: index):
      "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 32 : index, upperBoundMap = #map5}> ({
      ^bb0(%arg9: index):
        "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map10}> ({
        ^bb0(%arg10: index):
          %1 = "affine.apply"(%arg8, %arg9, %arg10) <{map = #map9}> : (index, index, index) -> index
          "test.foo"(%1) : (index) -> ()
          "affine.yield"() : () -> ()
        }) : () -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, memref<64xf32>, index) -> (), sym_name = "simplify_div_mod_with_operands"}> ({
  ^bb0(%arg0: index, %arg1: memref<64xf32>, %arg2: index):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
    ^bb0(%arg5: index):
      "affine.store"(%0, %arg1, %arg5) <{map = #map11}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg5) <{map = #map12}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg5) <{map = #map13}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg5) <{map = #map14}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg5) <{map = #map15}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg5) <{map = #map16}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg5) <{map = #map17}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg5) <{map = #map18}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg5) <{map = #map19}> : (f32, memref<64xf32>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "affine.for"() <{lowerBoundMap = #map21, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
    ^bb0(%arg4: index):
      "affine.store"(%0, %arg1, %arg4) <{map = #map11}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg4) <{map = #map13}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg4) <{map = #map20}> : (f32, memref<64xf32>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "affine.for"() <{lowerBoundMap = #map27, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map28}> ({
    ^bb0(%arg3: index):
      "affine.store"(%0, %arg1, %arg3) <{map = #map22}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg3) <{map = #map23}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg3) <{map = #map24}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg3) <{map = #map13}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg3) <{map = #map25}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg3) <{map = #map26}> : (f32, memref<64xf32>, index) -> ()
      "affine.store"(%0, %arg1, %arg2) <{map = #map15}> : (f32, memref<64xf32>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<(d0) -> (3, 5, d0)>
#map2 = affine_map<(d0) -> (3, 3, d0)>
#map3 = affine_map<() -> (10)>
#map4 = affine_map<(d0) -> (5, 5, d0)>
#map5 = affine_map<(d0) -> (16, d0 * -16 + 32)>
#map6 = affine_map<() -> (2)>
#map7 = affine_map<(d0) -> (32, d0 * -32 + 64)>
#map8 = affine_map<(d0) -> (32, d0 * -32 + 32)>
#map9 = affine_map<() -> (1)>
#map10 = affine_map<(d0) -> (5, d0 * 4)>
#map11 = affine_map<(d0) -> (d0 * 4 + 3)>
#map12 = affine_map<() -> (-10)>
#map13 = affine_map<(d0, d1) -> (d0 * 4 - d1 * 3, -9)>
#map14 = affine_map<() -> (4)>
#map15 = affine_map<(d0, d1) -> (d0 * 4 - d1 * 3, -9, d0 * 4 - d1 * 4)>
#map16 = affine_map<(d0) -> (d0 floordiv 2, 0)>
#map17 = affine_map<() -> (8)>
#map18 = affine_map<(d0) -> (d0 * 2, 2)>
#map19 = affine_map<(d0)[s0] -> (d0, s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "simplify_min_max_bounds_simple"}> ({
  ^bb0(%arg22: index):
    "affine.for"(%arg22) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg26: index):
      "test.foo"() : () -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "affine.for"(%arg22) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg25: index):
      "test.foo"() : () -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "affine.for"(%arg22) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 1, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg24: index):
      "test.foo"() : () -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "affine.for"(%arg22) <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 1, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg23: index):
      "test.foo"() : () -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "simplify_bounds_tiled"}> ({
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map9}> ({
    ^bb0(%arg16: index):
      "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map6}> ({
      ^bb0(%arg17: index):
        "affine.for"(%arg16) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 1, 0>, step = 16 : index, upperBoundMap = #map8}> ({
        ^bb0(%arg18: index):
          "affine.for"(%arg17) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 1, 0>, step = 16 : index, upperBoundMap = #map7}> ({
          ^bb0(%arg19: index):
            "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map6}> ({
            ^bb0(%arg20: index):
              "affine.for"(%arg20) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 1, 0>, step = 16 : index, upperBoundMap = #map5}> ({
              ^bb0(%arg21: index):
                "test.foo"() : () -> ()
                "affine.yield"() : () -> ()
              }) : (index) -> ()
              "affine.yield"() : () -> ()
            }) : () -> ()
            "affine.yield"() : () -> ()
          }) : (index) -> ()
          "affine.yield"() : () -> ()
        }) : (index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "simplify_min_max_multi_expr"}> ({
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg14: index):
      "affine.for"(%arg14, %arg14) <{lowerBoundMap = #map10, operandSegmentSizes = array<i32: 1, 1, 0>, step = 1 : index, upperBoundMap = #map11}> ({
      ^bb0(%arg15: index):
        "test.foo"() : () -> ()
        "affine.yield"() : () -> ()
      }) : (index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg11: index):
      "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map14}> ({
      ^bb0(%arg12: index):
        "affine.for"(%arg11, %arg12) <{lowerBoundMap = #map12, operandSegmentSizes = array<i32: 0, 2, 0>, step = 1 : index, upperBoundMap = #map13}> ({
        ^bb0(%arg13: index):
          "test.foo"() : () -> ()
          "affine.yield"() : () -> ()
        }) : (index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg8: index):
      "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map14}> ({
      ^bb0(%arg9: index):
        "affine.for"(%arg8, %arg9) <{lowerBoundMap = #map12, operandSegmentSizes = array<i32: 0, 2, 0>, step = 1 : index, upperBoundMap = #map15}> ({
        ^bb0(%arg10: index):
          "test.foo"() : () -> ()
          "affine.yield"() : () -> ()
        }) : (index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg6: index):
      "affine.for"(%arg6) <{lowerBoundMap = #map16, operandSegmentSizes = array<i32: 1, 0, 0>, step = 1 : index, upperBoundMap = #map9}> ({
      ^bb0(%arg7: index):
        "test.foo"() : () -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map17}> ({
    ^bb0(%arg4: index):
      "affine.for"(%arg4) <{lowerBoundMap = #map16, operandSegmentSizes = array<i32: 1, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
      ^bb0(%arg5: index):
        "test.foo"() : () -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> (), sym_name = "no_simplify_min_max"}> ({
  ^bb0(%arg0: index):
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map14}> ({
    ^bb0(%arg1: index):
      "affine.for"(%arg1) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map18}> ({
      ^bb0(%arg3: index):
        "test.foo"() : () -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.for"(%arg1, %arg0) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 2, 0>, step = 1 : index, upperBoundMap = #map19}> ({
      ^bb0(%arg2: index):
        "test.foo"() : () -> ()
        "affine.yield"() : () -> ()
      }) : (index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (-d0 + 40961)>
#map1 = affine_map<(d0)[s0] -> (d0 * (s0 ceildiv 512))>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "regression_do_not_perform_invalid_replacements"}> ({
  ^bb0(%arg0: index):
    %0 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
    %1 = "affine.apply"(%arg0, %0) <{map = #map1}> : (index, index) -> index
    "test.foo"(%1) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "min.oneval"}> ({
  ^bb0(%arg0: index):
    %0 = "affine.min"(%arg0) <{map = #map}> : (index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "max.oneval"}> ({
  ^bb0(%arg0: index):
    %0 = "affine.max"(%arg0) <{map = #map}> : (index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> ((s0 - s0 mod s1) mod s1)>
#map1 = affine_map<()[s0, s1, s2] -> ((s0 - (s0 - s2) mod s1 - s2) mod s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (index, index), sym_name = "mod_of_mod"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "affine.apply"(%arg1, %arg2) <{map = #map}> : (index, index) -> index
    %1 = "affine.apply"(%arg1, %arg2, %arg0) <{map = #map1}> : (index, index, index) -> index
    "func.return"(%0, %1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 * 64)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<() -> (8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<512xf32>) -> (), sym_name = "prefetch_canonicalize"}> ({
  ^bb0(%arg0: memref<512xf32>):
    "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg1: index):
      %0 = "affine.apply"(%arg1) <{map = #map}> : (index) -> index
      "affine.prefetch"(%arg0, %0) <{isDataCache = true, isWrite = false, localityHint = 3 : i32, map = #map1}> : (memref<512xf32>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index, index), sym_name = "delinearize_fold_constant"}> ({
    %0 = "arith.constant"() <{value = 22 : index}> : () -> index
    %1:3 = "affine.delinearize_index"(%0) <{static_basis = array<i64: 2, 3, 5>}> : (index) -> (index, index, index)
    "func.return"(%1#0, %1#1, %1#2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index, index), sym_name = "delinearize_fold_negative_constant"}> ({
    %0 = "arith.constant"() <{value = -22 : index}> : () -> index
    %1:3 = "affine.delinearize_index"(%0) <{static_basis = array<i64: 2, 3, 5>}> : (index) -> (index, index, index)
    "func.return"(%1#0, %1#1, %1#2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index, index), sym_name = "delinearize_fold_negative_constant_no_outer_bound"}> ({
    %0 = "arith.constant"() <{value = -22 : index}> : () -> index
    %1:3 = "affine.delinearize_index"(%0) <{static_basis = array<i64: 3, 5>}> : (index) -> (index, index, index)
    "func.return"(%1#0, %1#1, %1#2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (index, index, index), sym_name = "delinearize_dont_fold_constant_dynamic_basis"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 22 : index}> : () -> index
    %1:3 = "affine.delinearize_index"(%0, %arg0) <{static_basis = array<i64: 2, -9223372036854775808, 5>}> : (index, index) -> (index, index, index)
    "func.return"(%1#0, %1#1, %1#2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (index, index, index, index, index, index), sym_name = "drop_unit_basis_in_delinearize"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1:6 = "affine.delinearize_index"(%arg0, %arg1, %arg2, %0) <{static_basis = array<i64: 1, -9223372036854775808, 1, 1, -9223372036854775808, -9223372036854775808>}> : (index, index, index, index) -> (index, index, index, index, index, index)
    "func.return"(%1#0, %1#1, %1#2, %1#3, %1#4, %1#5) : (index, index, index, index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (index, index, index, index, index, index), sym_name = "drop_unit_basis_in_delinearize_no_outer_bound"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1:6 = "affine.delinearize_index"(%arg0, %arg1, %arg2, %0) <{static_basis = array<i64: -9223372036854775808, 1, 1, -9223372036854775808, -9223372036854775808>}> : (index, index, index, index) -> (index, index, index, index, index, index)
    "func.return"(%1#0, %1#1, %1#2, %1#3, %1#4, %1#5) : (index, index, index, index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (index, index), sym_name = "drop_all_unit_bases"}> ({
  ^bb0(%arg0: index):
    %0:2 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 1, 1>}> : (index) -> (index, index)
    "func.return"(%0#0, %0#1) : (index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (index, index, index), sym_name = "drop_all_unit_bases_no_outer_bound"}> ({
  ^bb0(%arg0: index):
    %0:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 1, 1>}> : (index) -> (index, index, index)
    "func.return"(%0#0, %0#1, %0#2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "drop_single_loop_delinearize"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "scf.for"(%0, %arg1, %1, %0) ({
    ^bb0(%arg2: index, %arg3: index):
      %3 = "affine.delinearize_index"(%arg2, %arg1) <{static_basis = array<i64: -9223372036854775808>}> : (index, index) -> index
      %4 = "some_use"(%arg3, %3) : (index, index) -> index
      "scf.yield"(%4) : (index) -> ()
    }) : (index, index, index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1, s2] -> (d0 + s0 + s1 * 64 + s2 * 128)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, index, index, index, index) -> index, sym_name = "delinearize_non_induction_variable"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "affine.apply"(%arg1, %arg2, %arg3, %arg4) <{map = #map}> : (index, index, index, index) -> index
    %1 = "affine.delinearize_index"(%0) <{static_basis = array<i64: 1024>}> : (index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi32>, index) -> index, sym_name = "delinearize_non_loop_like"}> ({
  ^bb0(%arg0: memref<?xi32>, %arg1: index):
    %0 = "affine.delinearize_index"(%arg1) <{static_basis = array<i64: 1024>}> : (index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "delinearize_empty_basis"}> ({
  ^bb0(%arg0: index):
    %0 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64>}> : (index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "linearize_fold_constants"}> ({
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "affine.linearize_index"(%1, %1, %0) <{disjoint = false, operandSegmentSizes = array<i32: 3, 0>, static_basis = array<i64: 2, 3, 5>}> : (index, index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "linearize_fold_constants_no_outer_bound"}> ({
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "affine.linearize_index"(%1, %1, %0) <{disjoint = false, operandSegmentSizes = array<i32: 3, 0>, static_basis = array<i64: 3, 5>}> : (index, index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "linearize_fold_empty_basis"}> ({
  ^bb0(%arg0: index):
    %0 = "affine.linearize_index"(%arg0) <{disjoint = false, operandSegmentSizes = array<i32: 1, 0>, static_basis = array<i64>}> : (index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "linearize_fold_only_outer_bound"}> ({
  ^bb0(%arg0: index):
    %0 = "affine.linearize_index"(%arg0) <{disjoint = false, operandSegmentSizes = array<i32: 1, 0>, static_basis = array<i64: 2>}> : (index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> index, sym_name = "linearize_dont_fold_dynamic_basis"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "affine.linearize_index"(%1, %1, %0, %arg0) <{disjoint = false, operandSegmentSizes = array<i32: 3, 1>, static_basis = array<i64: 2, -9223372036854775808, 5>}> : (index, index, index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index) -> (index, index, index), sym_name = "cancel_delinearize_linearize_disjoint_exact"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "affine.linearize_index"(%arg0, %arg1, %arg2, %arg3, %arg4) <{disjoint, operandSegmentSizes = array<i32: 3, 2>, static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (index, index, index, index, index) -> index
    %1:3 = "affine.delinearize_index"(%0, %arg3, %arg4) <{static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (index, index, index) -> (index, index, index)
    "func.return"(%1#0, %1#1, %1#2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index) -> (index, index, index), sym_name = "cancel_delinearize_linearize_disjoint_linearize_extra_bound"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "affine.linearize_index"(%arg0, %arg1, %arg2, %arg4) <{disjoint, operandSegmentSizes = array<i32: 3, 1>, static_basis = array<i64: 4, -9223372036854775808>}> : (index, index, index, index) -> index
    %1:3 = "affine.delinearize_index"(%0, %arg4) <{static_basis = array<i64: 4, -9223372036854775808>}> : (index, index) -> (index, index, index)
    "func.return"(%1#0, %1#1, %1#2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index) -> (index, index, index), sym_name = "cancel_delinearize_linearize_disjoint_delinearize_extra_bound"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "affine.linearize_index"(%arg0, %arg1, %arg2, %arg4) <{disjoint, operandSegmentSizes = array<i32: 3, 1>, static_basis = array<i64: 4, -9223372036854775808>}> : (index, index, index, index) -> index
    %1:3 = "affine.delinearize_index"(%0, %arg3, %arg4) <{static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (index, index, index) -> (index, index, index)
    "func.return"(%1#0, %1#1, %1#2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index) -> (index, index, index), sym_name = "cancel_delinearize_linearize_disjoint_partial"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "affine.linearize_index"(%arg0, %arg1, %arg2, %arg3, %arg4) <{disjoint, operandSegmentSizes = array<i32: 3, 2>, static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (index, index, index, index, index) -> index
    %1:3 = "affine.delinearize_index"(%0, %arg4) <{static_basis = array<i64: 8, -9223372036854775808>}> : (index, index) -> (index, index, index)
    "func.return"(%1#0, %1#1, %1#2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index) -> (index, index, index), sym_name = "no_cancel_delinearize_linearize_exact"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "affine.linearize_index"(%arg0, %arg1, %arg2, %arg3, %arg4) <{disjoint = false, operandSegmentSizes = array<i32: 3, 2>, static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (index, index, index, index, index) -> index
    %1:3 = "affine.delinearize_index"(%0, %arg3, %arg4) <{static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (index, index, index) -> (index, index, index)
    "func.return"(%1#0, %1#1, %1#2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index) -> (index, index, index), sym_name = "no_cancel_delinearize_linearize_different_basis"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "affine.linearize_index"(%arg0, %arg1, %arg2, %arg3, %arg4) <{disjoint = false, operandSegmentSizes = array<i32: 3, 2>, static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (index, index, index, index, index) -> index
    %1:3 = "affine.delinearize_index"(%0, %arg3, %arg4) <{static_basis = array<i64: -9223372036854775808, 8, -9223372036854775808>}> : (index, index, index) -> (index, index, index)
    "func.return"(%1#0, %1#1, %1#2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (index, index, index, index), sym_name = "split_delinearize_spanning_final_part"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "affine.linearize_index"(%arg0, %arg1, %arg2) <{disjoint, operandSegmentSizes = array<i32: 3, 0>, static_basis = array<i64: 2, 4, 64>}> : (index, index, index) -> index
    %1:4 = "affine.delinearize_index"(%0) <{static_basis = array<i64: 2, 8, 8>}> : (index) -> (index, index, index, index)
    "func.return"(%1#0, %1#1, %1#2, %1#3) : (index, index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (index, index, index, index), sym_name = "split_delinearize_spanning_final_part_and_cancel"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "affine.linearize_index"(%arg0, %arg1, %arg2) <{disjoint, operandSegmentSizes = array<i32: 3, 0>, static_basis = array<i64: 2, 4, 64>}> : (index, index, index) -> index
    %1:4 = "affine.delinearize_index"(%0) <{static_basis = array<i64: 2, 4, 8, 8>}> : (index) -> (index, index, index, index)
    "func.return"(%1#0, %1#1, %1#2, %1#3) : (index, index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (index, index, index, index), sym_name = "dont_split_delinearize_overshooting_target"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "affine.linearize_index"(%arg0, %arg1, %arg2) <{disjoint, operandSegmentSizes = array<i32: 3, 0>, static_basis = array<i64: 2, 4, 64>}> : (index, index, index) -> index
    %1:4 = "affine.delinearize_index"(%0) <{static_basis = array<i64: 2, 16, 8>}> : (index) -> (index, index, index, index)
    "func.return"(%1#0, %1#1, %1#2, %1#3) : (index, index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (index, index, index), sym_name = "dont_split_delinearize_undershooting_target"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.linearize_index"(%arg0, %arg1) <{disjoint, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 2, 64>}> : (index, index) -> index
    %1:3 = "affine.delinearize_index"(%0) <{static_basis = array<i64: 4, 8>}> : (index) -> (index, index, index)
    "func.return"(%1#0, %1#1, %1#2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> index, sym_name = "linearize_unit_basis_disjoint"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "affine.linearize_index"(%arg0, %arg1, %arg2, %arg3) <{disjoint, operandSegmentSizes = array<i32: 3, 1>, static_basis = array<i64: 3, 1, -9223372036854775808>}> : (index, index, index, index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index) -> index, sym_name = "linearize_unit_basis_disjoint_no_outer_bound"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index):
    %0 = "affine.linearize_index"(%arg0, %arg1, %arg2, %arg3) <{disjoint, operandSegmentSizes = array<i32: 3, 1>, static_basis = array<i64: 1, -9223372036854775808>}> : (index, index, index, index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "linearize_unit_basis_zero"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%arg0, %0, %arg1, %arg2) <{disjoint = false, operandSegmentSizes = array<i32: 3, 1>, static_basis = array<i64: 3, 1, -9223372036854775808>}> : (index, index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "linearize_all_zero_unit_basis"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%0, %0) <{disjoint = false, operandSegmentSizes = array<i32: 2, 0>, static_basis = array<i64: 1, 1>}> : (index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "linearize_one_element_basis"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "affine.linearize_index"(%arg0, %arg1) <{disjoint = false, operandSegmentSizes = array<i32: 1, 1>, static_basis = array<i64: -9223372036854775808>}> : (index, index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "cancel_linearize_delinearize_exact"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0:3 = "affine.delinearize_index"(%arg0, %arg1, %arg2) <{static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (index, index, index) -> (index, index, index)
    %1 = "affine.linearize_index"(%0#0, %0#1, %0#2, %arg1, %arg2) <{disjoint = false, operandSegmentSizes = array<i32: 3, 2>, static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (index, index, index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "cancel_linearize_delinearize_linearize_extra_bound"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0:3 = "affine.delinearize_index"(%arg0, %arg2) <{static_basis = array<i64: 4, -9223372036854775808>}> : (index, index) -> (index, index, index)
    %1 = "affine.linearize_index"(%0#0, %0#1, %0#2, %arg1, %arg2) <{disjoint = false, operandSegmentSizes = array<i32: 3, 2>, static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (index, index, index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "cancel_linearize_delinearize_delinearize_extra_bound"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0:3 = "affine.delinearize_index"(%arg0, %arg1, %arg2) <{static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (index, index, index) -> (index, index, index)
    %1 = "affine.linearize_index"(%0#0, %0#1, %0#2, %arg2) <{disjoint = false, operandSegmentSizes = array<i32: 3, 1>, static_basis = array<i64: 4, -9223372036854775808>}> : (index, index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "cancel_linearize_delinearize_head"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 3, 4, 8>}> : (index) -> (index, index, index)
    %1 = "affine.linearize_index"(%0#0, %0#1, %arg1) <{disjoint = false, operandSegmentSizes = array<i32: 3, 0>, static_basis = array<i64: 3, 4, 16>}> : (index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "cancel_linearize_delinearize_head_delinearize_unbounded"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 4, 8>}> : (index) -> (index, index, index)
    %1 = "affine.linearize_index"(%0#0, %0#1, %arg1) <{disjoint = false, operandSegmentSizes = array<i32: 3, 0>, static_basis = array<i64: 3, 4, 16>}> : (index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "cancel_linearize_delinearize_head_linearize_unbounded"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 3, 4, 8>}> : (index) -> (index, index, index)
    %1 = "affine.linearize_index"(%0#0, %0#1, %arg1) <{disjoint = false, operandSegmentSizes = array<i32: 3, 0>, static_basis = array<i64: 4, 16>}> : (index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "cancel_linearize_delinearize_head_both_unbounded"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 4, 8>}> : (index) -> (index, index, index)
    %1 = "affine.linearize_index"(%0#0, %0#1, %arg1) <{disjoint = false, operandSegmentSizes = array<i32: 3, 0>, static_basis = array<i64: 4, 16>}> : (index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "cancel_linearize_delinearize_tail"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 3, 4, 8>}> : (index) -> (index, index, index)
    %1 = "affine.linearize_index"(%arg1, %0#1, %0#2) <{disjoint = false, operandSegmentSizes = array<i32: 3, 0>, static_basis = array<i64: 5, 4, 8>}> : (index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "cancel_linearize_delinearize_middle_exact"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 2, 3, 5>}> : (index) -> (index, index, index)
    %1 = "affine.linearize_index"(%arg1, %0#0, %0#1, %0#2, %arg2) <{disjoint = false, operandSegmentSizes = array<i32: 5, 0>, static_basis = array<i64: 9, 2, 3, 5, 7>}> : (index, index, index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "cancel_linearize_delinearize_middle_exact_dynamic_basis"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1:4 = "affine.delinearize_index"(%arg0, %arg1, %arg2) <{static_basis = array<i64: 2, -9223372036854775808, -9223372036854775808, 8>}> : (index, index, index) -> (index, index, index, index)
    %2 = "affine.linearize_index"(%0, %1#0, %1#1, %1#2, %1#3, %0, %arg1, %arg2) <{disjoint = false, operandSegmentSizes = array<i32: 6, 2>, static_basis = array<i64: 3, 2, -9223372036854775808, -9223372036854775808, 8, 4>}> : (index, index, index, index, index, index, index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "cancel_linearize_delinearize_middle_exact_delinearize_unbounded_disjoint"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 3, 5>}> : (index) -> (index, index, index)
    %1 = "affine.linearize_index"(%arg1, %0#0, %0#1, %0#2, %arg2) <{disjoint, operandSegmentSizes = array<i32: 5, 0>, static_basis = array<i64: 9, 2, 3, 5, 7>}> : (index, index, index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "dont_cancel_linearize_delinearize_middle_exact_delinearize_unbounded"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0:2 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 3>}> : (index) -> (index, index)
    %1 = "affine.linearize_index"(%arg1, %0#0, %0#1, %arg2) <{disjoint = false, operandSegmentSizes = array<i32: 4, 0>, static_basis = array<i64: 9, 2, 3, 7>}> : (index, index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "cancel_linearize_delinearize_middle_delinearize_unbounded_disjoint_implied_bound"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 3, 5>}> : (index) -> (index, index, index)
    %1 = "affine.linearize_index"(%arg1, %0#0, %0#1, %arg2) <{disjoint, operandSegmentSizes = array<i32: 4, 0>, static_basis = array<i64: 9, 2, 3, 7>}> : (index, index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "cancel_linearize_delinearize_multiple_matches"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1:7 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 4, 4, 4, 4, 4, 4, 4>}> : (index) -> (index, index, index, index, index, index, index)
    %2 = "affine.linearize_index"(%arg1, %1#1, %1#2, %0, %1#4, %1#5, %1#6) <{disjoint = false, operandSegmentSizes = array<i32: 7, 0>, static_basis = array<i64: 4, 4, 4, 4, 4, 4, 4>}> : (index, index, index, index, index, index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "cancel_linearize_delinearize_multiple_delinearizes"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0:2 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 4, 8>}> : (index) -> (index, index)
    %1:2 = "affine.delinearize_index"(%arg1) <{static_basis = array<i64: 2, 16>}> : (index) -> (index, index)
    %2 = "affine.linearize_index"(%0#0, %0#1, %1#0, %1#1) <{disjoint = false, operandSegmentSizes = array<i32: 4, 0>, static_basis = array<i64: 4, 8, 2, 16>}> : (index, index, index, index) -> index
    "func.return"(%2) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "no_cancel_linearize_delinearize_permuted"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0:3 = "affine.delinearize_index"(%arg0, %arg1, %arg2) <{static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (index, index, index) -> (index, index, index)
    %1 = "affine.linearize_index"(%0#0, %0#2, %0#1, %arg1, %arg2) <{disjoint = false, operandSegmentSizes = array<i32: 3, 2>, static_basis = array<i64: -9223372036854775808, -9223372036854775808, 4>}> : (index, index, index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "partial_cancel_linearize_delinearize_not_fully_permuted"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0:4 = "affine.delinearize_index"(%arg0, %arg1, %arg2) <{static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808, 3>}> : (index, index, index) -> (index, index, index, index)
    %1 = "affine.linearize_index"(%0#0, %0#2, %0#3, %0#1, %arg1, %arg2) <{disjoint = false, operandSegmentSizes = array<i32: 4, 2>, static_basis = array<i64: -9223372036854775808, -9223372036854775808, 3, 4>}> : (index, index, index, index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (index, index, index), sym_name = "cancel_linearize_delinearize_placement"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 8, 8, 4>}> : (index) -> (index, index, index)
    %2 = "affine.linearize_index"(%1#2, %1#0, %0, %0) <{disjoint, operandSegmentSizes = array<i32: 4, 0>, static_basis = array<i64: 4, 8, 4, 8>}> : (index, index, index, index) -> index
    %3 = "affine.linearize_index"(%1#1, %1#2, %0, %0) <{disjoint, operandSegmentSizes = array<i32: 4, 0>, static_basis = array<i64: 8, 4, 8, 4>}> : (index, index, index, index) -> index
    %4 = "affine.linearize_index"(%1#1, %1#0, %0, %0) <{disjoint, operandSegmentSizes = array<i32: 4, 0>, static_basis = array<i64: 8, 8, 4, 4>}> : (index, index, index, index) -> index
    "func.return"(%2, %3, %4) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "no_cancel_linearize_delinearize_different_basis"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0:3 = "affine.delinearize_index"(%arg0, %arg1, %arg2) <{static_basis = array<i64: -9223372036854775808, 4, -9223372036854775808>}> : (index, index, index) -> (index, index, index)
    %1 = "affine.linearize_index"(%0#0, %0#1, %0#2, %arg1, %arg2) <{disjoint = false, operandSegmentSizes = array<i32: 3, 2>, static_basis = array<i64: -9223372036854775808, 8, -9223372036854775808>}> : (index, index, index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "affine_leading_zero"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%0, %arg0, %arg1) <{disjoint = false, operandSegmentSizes = array<i32: 3, 0>, static_basis = array<i64: 2, 3, 5>}> : (index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> index, sym_name = "affine_leading_zero_no_outer_bound"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "affine.linearize_index"(%0, %arg0, %arg1) <{disjoint = false, operandSegmentSizes = array<i32: 3, 0>, static_basis = array<i64: 3, 5>}> : (index, index, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * 5 + s2 * 20)>
#map1 = affine_map<()[s0, s1, s2] -> (s0 + s2 * 20 + s1 * 5)>
#map2 = affine_map<()[s0, s1, s2] -> (s1 * 20 + s2 * 5 + s0)>
#map3 = affine_map<()[s0, s1] -> (s0 + s1 * 20)>
#map4 = affine_map<()[s0, s1] -> (s1 * 20 + s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<?xindex>) -> (), sym_name = "delin_apply_cancel_exact"}> ({
  ^bb0(%arg0: index, %arg1: memref<?xindex>):
    %0:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 4, 5>}> : (index) -> (index, index, index)
    %1:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 3, 4, 5>}> : (index) -> (index, index, index)
    %2:2 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 20>}> : (index) -> (index, index)
    %3 = "affine.apply"(%0#2, %0#1, %0#0) <{map = #map}> : (index, index, index) -> index
    "memref.store"(%3, %arg1, %3) : (index, memref<?xindex>, index) -> ()
    %4 = "affine.apply"(%0#2, %0#1, %0#0) <{map = #map1}> : (index, index, index) -> index
    "memref.store"(%4, %arg1, %4) : (index, memref<?xindex>, index) -> ()
    %5 = "affine.apply"(%0#2, %0#0, %0#1) <{map = #map2}> : (index, index, index) -> index
    "memref.store"(%5, %arg1, %5) : (index, memref<?xindex>, index) -> ()
    %6 = "affine.apply"(%1#2, %1#1, %1#0) <{map = #map}> : (index, index, index) -> index
    "memref.store"(%6, %arg1, %6) : (index, memref<?xindex>, index) -> ()
    %7 = "affine.apply"(%2#1, %2#0) <{map = #map3}> : (index, index) -> index
    "memref.store"(%7, %arg1, %7) : (index, memref<?xindex>, index) -> ()
    %8 = "affine.apply"(%2#1, %2#0) <{map = #map4}> : (index, index) -> index
    "memref.store"(%8, %arg1, %7) : (index, memref<?xindex>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0 + d1 * 128 + d2 * 64)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (256)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xindex>) -> (), sym_name = "delin_apply_cancel_exact_dim"}> ({
  ^bb0(%arg0: memref<?xindex>):
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg1: index):
      %0:3 = "affine.delinearize_index"(%arg1) <{static_basis = array<i64: 2, 2, 64>}> : (index) -> (index, index, index)
      %1 = "affine.apply"(%0#2, %0#0, %0#1) <{map = #map}> : (index, index, index) -> index
      "memref.store"(%1, %arg0, %1) : (index, memref<?xindex>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * 128 + s2 * 64 + 512)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<?xindex>) -> (), sym_name = "delin_apply_cancel_const_term"}> ({
  ^bb0(%arg0: index, %arg1: memref<?xindex>):
    %0:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 2, 2, 64>}> : (index) -> (index, index, index)
    %1 = "affine.apply"(%0#2, %0#0, %0#1) <{map = #map}> : (index, index, index) -> index
    "memref.store"(%1, %arg1, %1) : (index, memref<?xindex>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1, s2, s3] -> (s0 + s1 * 128 + s2 * 64 + s3 + 512)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<?xindex>, index) -> (), sym_name = "delin_apply_cancel_var_term"}> ({
  ^bb0(%arg0: index, %arg1: memref<?xindex>, %arg2: index):
    %0:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 2, 2, 64>}> : (index) -> (index, index, index)
    %1 = "affine.apply"(%0#2, %0#0, %0#1, %arg2) <{map = #map}> : (index, index, index, index) -> index
    "memref.store"(%1, %arg1, %1) : (index, memref<?xindex>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> ((s0 + s1 * 20) ceildiv 4 + (s1 * 20 + s0) * 2)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<?xindex>) -> (), sym_name = "delin_apply_cancel_nested_exprs"}> ({
  ^bb0(%arg0: index, %arg1: memref<?xindex>):
    %0:2 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 20>}> : (index) -> (index, index)
    %1 = "affine.apply"(%0#1, %0#0) <{map = #map}> : (index, index) -> index
    "memref.store"(%1, %arg1, %1) : (index, memref<?xindex>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 20 + s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<?xindex>) -> (), sym_name = "delin_apply_cancel_preserve_rotation"}> ({
  ^bb0(%arg0: index, %arg1: memref<?xindex>):
    %0:2 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 20>}> : (index) -> (index, index)
    %1 = "affine.apply"(%0#1, %0#0) <{map = #map}> : (index, index) -> index
    "memref.store"(%1, %arg1, %1) : (index, memref<?xindex>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 5)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<?xindex>) -> (), sym_name = "delin_apply_dont_cancel_partial"}> ({
  ^bb0(%arg0: index, %arg1: memref<?xindex>):
    %0:3 = "affine.delinearize_index"(%arg0) <{static_basis = array<i64: 3, 4, 5>}> : (index) -> (index, index, index)
    %1 = "affine.apply"(%0#2, %0#1) <{map = #map}> : (index, index) -> index
    "memref.store"(%1, %arg1, %1) : (index, memref<?xindex>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (index, index, index), sym_name = "cst_value_to_cst_attr_basis_delinearize_index"}> ({
  ^bb0(%arg0: index):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    %1 = "arith.constant"() <{value = 3 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3:3 = "affine.delinearize_index"(%arg0, %1, %0, %2) <{static_basis = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (index, index, index, index) -> (index, index, index)
    "func.return"(%3#0, %3#1, %3#2) : (index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (114)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> index, sym_name = "cst_value_to_cst_attr_basis_linearize_index"}> ({
  ^bb0(%arg2: index, %arg3: index, %arg4: index):
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "affine.linearize_index"(%arg2, %arg3, %arg4, %3, %2) <{disjoint, operandSegmentSizes = array<i32: 3, 2>, static_basis = array<i64: -9223372036854775808, 3, -9223372036854775808>}> : (index, index, index, index, index) -> index
    "func.return"(%4) : (index) -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> index, sym_name = "for_empty_body_folder_iv_yield"}> ({
    %0 = "arith.constant"() <{value = 18 : index}> : () -> index
    %1 = "affine.for"(%0) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 1>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg0: index, %arg1: index):
      "affine.yield"(%arg0) : (index) -> ()
    }) : (index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

