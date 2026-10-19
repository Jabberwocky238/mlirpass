#map = affine_map<() -> (3)>
#map1 = affine_map<() -> (19)>
#map2 = affine_map<() -> (5)>
#map3 = affine_map<() -> (15)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "step_var"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: memref<?x?xf32>):
    "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 4 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg2: index):
      "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 7 : index, upperBoundMap = #map1}> ({
      ^bb0(%arg3: index):
        %0 = "memref.load"(%arg0, %arg2, %arg3) : (memref<?x?xf32>, index, index) -> f32
        "memref.store"(%0, %arg1, %arg2, %arg3) : (f32, memref<?x?xf32>, index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

