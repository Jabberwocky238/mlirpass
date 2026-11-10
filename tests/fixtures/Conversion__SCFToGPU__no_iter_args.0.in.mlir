#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<()[s0] -> (s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<1024xf32>) -> f32, sym_name = "reduction_loop"}> ({
  ^bb0(%arg0: memref<1024xf32>):
    %0 = "arith.constant"() <{value = 10 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "affine.for"(%0, %1) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 1>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg1: index, %arg2: f32):
      %3 = "affine.load"(%arg0, %arg1) <{map = #map}> : (memref<1024xf32>, index) -> f32
      %4 = "arith.addf"(%arg2, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "affine.yield"(%4) : (f32) -> ()
    }) : (index, f32) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

