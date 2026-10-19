"builtin.module"() ({
  "func.func"() <{function_type = () -> (index, index, index, index), sym_name = "merge_constants"}> ({
    %0 = "arith.constant"() <{value = 42 : index}> : () -> index loc(#loc2)
    "func.return"(%0, %0, %0, %0) : (index, index, index, index) -> () loc(#loc3)
  }) : () -> () loc(#loc1)
}) : () -> () loc(#loc)
#loc = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":0:0)
#loc1 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":4:1)
#loc2 = loc(unknown)
#loc3 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":10:3)

// -----
#loc2 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":17:25)
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8xi32>) -> i32, sym_name = "simple_hoist"}> ({
  ^bb0(%arg0: memref<8xi32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":17:25)):
    %0 = "arith.constant"() <{value = 88 : i32}> : () -> i32 loc(#loc3)
    %1 = "arith.constant"() <{value = 42 : i32}> : () -> i32 loc(#loc4)
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index loc(#loc5)
    "memref.store"(%1, %arg0, %2) : (i32, memref<8xi32>, index) -> () loc(#loc6)
    "func.return"(%0) : (i32) -> () loc(#loc7)
  }) : () -> () loc(#loc1)
}) : () -> () loc(#loc)
#loc = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":14:9)
#loc1 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":17:1)
#loc3 = loc("simple_hoist":2:0)
#loc4 = loc("simple_hoist":0:0)
#loc5 = loc("simple_hoist":1:0)
#loc6 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":23:3)
#loc7 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":27:3)

// -----
#loc2 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":36:28)
#loc5 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":38:14)
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (8)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8xi32>) -> (), sym_name = "hoist_and_merge"}> ({
  ^bb0(%arg0: memref<8xi32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":36:28)):
    %0 = "arith.constant"() <{value = 42 : i32}> : () -> i32 loc(#loc3)
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg1: index loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":38:14)):
      "memref.store"(%0, %arg0, %arg1) : (i32, memref<8xi32>, index) -> () loc(#loc6)
      "memref.store"(%0, %arg0, %arg1) : (i32, memref<8xi32>, index) -> () loc(#loc7)
      "affine.yield"() : () -> () loc(#loc4)
    }) : () -> () loc(#loc4)
    "func.return"() : () -> () loc(#loc8)
  }) : () -> () loc(#loc1)
}) : () -> () loc(#loc)
#loc = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":33:9)
#loc1 = loc("hoist_and_merge":2:0)
#loc3 = loc(unknown)
#loc4 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":38:3)
#loc6 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":41:5)
#loc7 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":42:5)
#loc8 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":44:3)

