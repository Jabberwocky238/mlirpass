"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "collapse_to_single"}> ({
    %0 = "arith.constant"() <{value = 6 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 18 : index}> : () -> index
    "scf.parallel"(%1, %3, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg0: index):
      %4 = "arith.remsi"(%arg0, %0) : (index, index) -> index
      %5 = "arith.divsi"(%arg0, %0) : (index, index) -> index
      %6 = "affine.apply"(%4) <{map = affine_map<(d0) -> (d0 * 4 + 7)>}> : (index) -> index
      %7 = "affine.apply"(%5) <{map = affine_map<(d0) -> (d0 * 3 + 3)>}> : (index) -> index
      %8 = "magic.op"(%7, %6) : (index, index) -> index
      "scf.reduce"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()
