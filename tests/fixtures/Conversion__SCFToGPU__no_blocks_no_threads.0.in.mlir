#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (42)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "one_d_loop"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg2: index):
      %0 = "memref.load"(%arg0, %arg2) : (memref<?xf32>, index) -> f32
      "memref.store"(%0, %arg1, %arg2) : (f32, memref<?xf32>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

