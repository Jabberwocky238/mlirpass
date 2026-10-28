#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<()[s0] -> (s0)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xi8>, index, index, index) -> (), sym_name = "matmul"}> ({
  ^bb0(%arg7: memref<?xi8>, %arg8: index, %arg9: index, %arg10: index):
    %12 = "arith.constant"() <{value = 0 : index}> : () -> index
    %13 = "memref.view"(%arg7, %12, %arg8, %arg10) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    %14 = "memref.view"(%arg7, %12, %arg10, %arg9) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    %15 = "memref.view"(%arg7, %12, %arg8, %arg9) : (memref<?xi8>, index, index, index) -> memref<?x?xf32>
    "affine.for"(%arg8) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg11: index):
      "affine.for"(%arg9) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg12: index):
        "affine.for"(%arg10) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
        ^bb0(%arg13: index):
          %16 = "affine.load"(%13, %arg11, %arg13) <{map = #map}> : (memref<?x?xf32>, index, index) -> f32
          %17 = "affine.load"(%14, %arg13, %arg12) <{map = #map}> : (memref<?x?xf32>, index, index) -> f32
          %18 = "affine.load"(%15, %arg11, %arg12) <{map = #map}> : (memref<?x?xf32>, index, index) -> f32
          %19 = "arith.mulf"(%16, %17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          %20 = "arith.addf"(%18, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "affine.store"(%20, %15, %arg11, %arg12) <{map = #map}> : (f32, memref<?x?xf32>, index, index) -> ()
          "affine.yield"() : () -> ()
        }) : (index) -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?xf32>, memref<?x?x?xf32>, memref<?x?x?xf32>) -> (), sym_name = "named_batch_matmul"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>, %arg1: memref<?x?x?xf32>, %arg2: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %2) : (memref<?x?x?xf32>, index) -> index
    %4 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf32>, index) -> index
    %5 = "memref.dim"(%arg0, %0) : (memref<?x?x?xf32>, index) -> index
    %6 = "memref.dim"(%arg1, %0) : (memref<?x?x?xf32>, index) -> index
    "affine.for"(%3) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg3: index):
      "affine.for"(%4) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg4: index):
        "affine.for"(%6) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
        ^bb0(%arg5: index):
          "affine.for"(%5) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 1, 0>, step = 1 : index, upperBoundMap = #map2}> ({
          ^bb0(%arg6: index):
            %7 = "affine.load"(%arg0, %arg3, %arg4, %arg6) <{map = #map3}> : (memref<?x?x?xf32>, index, index, index) -> f32
            %8 = "affine.load"(%arg1, %arg3, %arg6, %arg5) <{map = #map3}> : (memref<?x?x?xf32>, index, index, index) -> f32
            %9 = "affine.load"(%arg2, %arg3, %arg4, %arg5) <{map = #map3}> : (memref<?x?x?xf32>, index, index, index) -> f32
            %10 = "arith.mulf"(%7, %8) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            %11 = "arith.addf"(%9, %10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            "affine.store"(%11, %arg2, %arg3, %arg4, %arg5) <{map = #map3}> : (f32, memref<?x?x?xf32>, index, index, index) -> ()
            "affine.yield"() : () -> ()
          }) : (index) -> ()
          "affine.yield"() : () -> ()
        }) : (index) -> ()
        "affine.yield"() : () -> ()
      }) : (index) -> ()
      "affine.yield"() : () -> ()
    }) : (index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

