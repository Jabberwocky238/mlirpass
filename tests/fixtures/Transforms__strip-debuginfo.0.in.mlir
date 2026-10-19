#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (8)>
#set = affine_set<(d0) : (1 == 0)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> i32, sym_name = "inline_notation"}> ({
    %0 = "foo"() : () -> i32
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg2: index):
      "affine.yield"() : () -> ()
    }) : () -> ()
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    "affine.if"(%1) <{condition = #set}> ({
      "affine.yield"() : () -> ()
    }, {
    }) : (index) -> ()
    "foo.region"() ({
    ^bb0(%arg0: i32, %arg1: i32):
      %2 = "arith.addi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "foo.yield"(%2) : (i32) -> ()
    }) : () -> ()
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

