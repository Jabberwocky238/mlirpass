#map = affine_map<() -> (5)>
#map1 = affine_map<() -> (17)>
#map2 = affine_map<() -> (2)>
#map3 = affine_map<() -> (16)>
#map4 = affine_map<() -> (0)>
#map5 = affine_map<() -> (10)>
#map6 = affine_map<() -> (42)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?x?xf32>, memref<?x?x?x?xf32>) -> (), sym_name = "step_1"}> ({
  ^bb0(%arg0: memref<?x?x?x?xf32>, %arg1: memref<?x?x?x?xf32>):
    "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map6}> ({
    ^bb0(%arg2: index):
      "affine.for"() <{lowerBoundMap = #map4, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map5}> ({
      ^bb0(%arg3: index):
        "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
        ^bb0(%arg4: index):
          "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
          ^bb0(%arg5: index):
            %0 = "memref.load"(%arg0, %arg2, %arg3, %arg4, %arg5) : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
            "memref.store"(%0, %arg1, %arg2, %arg3, %arg4, %arg5) : (f32, memref<?x?x?x?xf32>, index, index, index, index) -> ()
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

