"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "inline_notation"}> ({
    %0 = "foo"() : () -> i32 loc(unknown)
    "affine.for"() <{lowerBoundMap = affine_map<() -> (0)>, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = affine_map<() -> (8)>}> ({
    ^bb0(%arg2: index loc(unknown)):
      "affine.yield"() : () -> () loc(unknown)
    }) : () -> () loc(unknown)
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index loc(unknown)
    "affine.if"(%1) <{condition = affine_set<(d0) : (1 == 0)>}> ({
      "affine.yield"() : () -> () loc(unknown)
    }, {
    }) : (index) -> () loc(unknown)
    "foo.region"() ({
    ^bb0(%arg0: i32 loc(unknown), %arg1: i32 loc(unknown)):
      %2 = "arith.addi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32 loc(unknown)
      "foo.yield"(%2) : (i32) -> () loc(unknown)
    }) : () -> () loc(unknown)
    "func.return"(%0) : (i32) -> () loc(unknown)
  }) : () -> () loc(unknown)
}) : () -> () loc(unknown)
