"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index, index, index), sym_name = "merge_constants"}> ({
    %0 = "arith.constant"() <{value = 42 : index}> : () -> index
    %1 = "arith.constant"() <{value = 42 : index}> : () -> index
    %2 = "arith.constant"() <{value = 42 : index}> : () -> index
    %3 = "arith.constant"() <{value = 42 : index}> : () -> index
    "func.return"(%0, %1, %2, %3) : (index, index, index, index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8xi32>) -> i32, sym_name = "simple_hoist"}> ({
  ^bb0(%arg0: memref<8xi32>):
    %0 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    "memref.store"(%0, %arg0, %1) : (i32, memref<8xi32>, index) -> ()
    %2 = "arith.constant"() <{value = 88 : i32}> : () -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8xi32>) -> (), sym_name = "hoist_and_merge"}> ({
  ^bb0(%arg0: memref<8xi32>):
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg1: index):
      %0 = "arith.constant"() <{value = 42 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 42 : i32}> : () -> i32
      "memref.store"(%0, %arg0, %arg1) : (i32, memref<8xi32>, index) -> ()
      "memref.store"(%1, %arg0, %arg1) : (i32, memref<8xi32>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

