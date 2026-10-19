module {
  func.func @inline_notation() -> i32 {
    %0 = "foo"() : () -> i32 loc(unknown)
    affine.for %arg0 loc(unknown) = 0 to 8 {
    } loc(unknown)
    %c4 = arith.constant 4 : index loc(unknown)
    affine.if affine_set<(d0) : (1 == 0)>(%c4) {
    } loc(unknown)
    "foo.region"() ({
    ^bb0(%arg0: i32 loc(unknown), %arg1: i32 loc(unknown)):
      %1 = arith.addi %arg0, %arg0 : i32 loc(unknown)
      "foo.yield"(%1) : (i32) -> () loc(unknown)
    }) : () -> () loc(unknown)
    return %0 : i32 loc(unknown)
  } loc(unknown)
} loc(unknown)
