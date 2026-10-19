module {
  func.func @merge_constants() -> (index, index, index, index) {
    %c42 = arith.constant 42 : index loc(#loc2)
    return %c42, %c42, %c42, %c42 : index, index, index, index loc(#loc3)
  } loc(#loc1)
} loc(#loc)
#loc = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":0:0)
#loc1 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":4:1)
#loc2 = loc(unknown)
#loc3 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":10:3)

// -----
#loc2 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":17:25)
module {
  func.func @simple_hoist(%arg0: memref<8xi32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":17:25)) -> i32 {
    %c88_i32 = arith.constant 88 : i32 loc(#loc3)
    %c42_i32 = arith.constant 42 : i32 loc(#loc4)
    %c0 = arith.constant 0 : index loc(#loc5)
    memref.store %c42_i32, %arg0[%c0] : memref<8xi32> loc(#loc6)
    return %c88_i32 : i32 loc(#loc7)
  } loc(#loc1)
} loc(#loc)
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
module {
  func.func @hoist_and_merge(%arg0: memref<8xi32> loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":36:28)) {
    %c42_i32 = arith.constant 42 : i32 loc(#loc3)
    affine.for %arg1 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":38:14) = 0 to 8 {
      memref.store %c42_i32, %arg0[%arg1] : memref<8xi32> loc(#loc6)
      memref.store %c42_i32, %arg0[%arg1] : memref<8xi32> loc(#loc7)
    } loc(#loc4)
    return loc(#loc8)
  } loc(#loc1)
} loc(#loc)
#loc = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":33:9)
#loc1 = loc("hoist_and_merge":2:0)
#loc3 = loc(unknown)
#loc4 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":38:3)
#loc6 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":41:5)
#loc7 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":42:5)
#loc8 = loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/canonicalize-debuginfo.mlir":44:3)

