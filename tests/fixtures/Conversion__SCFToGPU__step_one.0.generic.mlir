#map = affine_map<() -> (5)>
#map1 = affine_map<() -> (17)>
#map2 = affine_map<() -> (2)>
#map3 = affine_map<() -> (16)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?x?xf32>, memref<?x?x?x?xf32>) -> (), sym_name = "step_1"}> ({
  ^bb0(%arg0: memref<?x?x?x?xf32>, %arg1: memref<?x?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 42 : index}> : () -> index
    %2 = "arith.subi"(%1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 10 : index}> : () -> index
    %6 = "arith.subi"(%5, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch"(%2, %8, %8, %6, %8, %8) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index):
      %9 = "arith.addi"(%0, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %10 = "arith.addi"(%4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
      ^bb0(%arg14: index):
        "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
        ^bb0(%arg15: index):
          %11 = "memref.load"(%arg0, %9, %10, %arg14, %arg15) : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
          "memref.store"(%11, %arg1, %9, %10, %arg14, %arg15) : (f32, memref<?x?x?x?xf32>, index, index, index, index) -> ()
          "affine.yield"() : () -> ()
        }) : () -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

