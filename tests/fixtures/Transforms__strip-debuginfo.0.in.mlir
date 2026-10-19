"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "inline_notation"}> ({
    %0 = "foo"() : () -> i32 loc("foo")
    "affine.for"() <{lowerBoundMap = affine_map<() -> (0)>, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = affine_map<() -> (8)>}> ({
    ^bb0(%arg2: index loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/strip-debuginfo.mlir":12:14)):
      "affine.yield"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/strip-debuginfo.mlir":12:3)
    }) : () -> () loc(fused["foo", "mysource.cc":10:8])
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/strip-debuginfo.mlir":16:8)
    "affine.if"(%1) <{condition = affine_set<(d0) : (1 == 0)>}> ({
      "affine.yield"() : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/strip-debuginfo.mlir":17:3)
    }, {
    }) : (index) -> () loc(fused<"myPass">["foo", "foo2"])
    "foo.region"() ({
    ^bb0(%arg0: i32 loc("argloc"), %arg1: i32 loc("argloc2")):
      %2 = "arith.addi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/strip-debuginfo.mlir":23:10)
      "foo.yield"(%2) : (i32) -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/strip-debuginfo.mlir":24:5)
    }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/strip-debuginfo.mlir":20:3)
    "func.return"(%0) : (i32) -> () loc("bar")
  }) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/strip-debuginfo.mlir":7:1)
}) : () -> () loc("/home/zq/coding/dopamine/jw238/llvm-project/mlir/test/Transforms/strip-debuginfo.mlir":0:0)
