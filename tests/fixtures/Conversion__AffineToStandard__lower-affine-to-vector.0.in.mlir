#map = affine_map<(d0)[s0] -> (d0 + s0 + 7)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (16)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_vector_load"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100xf32>
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg1: index):
      %1 = "affine.vector_load"(%0, %arg1, %arg0) <{map = #map}> : (memref<100xf32>, index, index) -> vector<8xf32>
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (d0 - s0 + 7)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (16)>
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_vector_store"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100xf32>
    %1 = "arith.constant"() <{value = dense<1.100000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg1: index):
      "affine.vector_store"(%1, %0, %arg1, %arg0) <{map = #map}> : (vector<4xf32>, memref<100xf32>, index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (16)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "vector_load_2d"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100x100xf32>
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 2 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg0: index):
      "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 8 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg1: index):
        %1 = "affine.vector_load"(%0, %arg0, %arg1) <{map = #map}> : (memref<100x100xf32>, index, index) -> vector<2x8xf32>
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (16)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "vector_store_2d"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100x100xf32>
    %1 = "arith.constant"() <{value = dense<1.100000e+01> : vector<2x8xf32>}> : () -> vector<2x8xf32>
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 2 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg0: index):
      "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 8 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg1: index):
        "affine.vector_store"(%1, %0, %arg0, %arg1) <{map = #map}> : (vector<2x8xf32>, memref<100x100xf32>, index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

