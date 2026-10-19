"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_many_dims"}> ({
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "arith.constant"() <{value = 6 : index}> : () -> index
    %2 = "arith.constant"() <{value = 12 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 2 : index}> : () -> index
    %6 = "arith.constant"() <{value = 4 : index}> : () -> index
    "scf.parallel"(%3, %6, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg0: index):
      %7 = "arith.remsi"(%arg0, %5) : (index, index) -> index
      %8 = "arith.divsi"(%arg0, %5) : (index, index) -> index
      %9 = "affine.apply"(%7) <{map = affine_map<(d0) -> (d0 * 10 + 9)>}> : (index) -> index
      %10 = "magic.op"(%8, %0, %1, %9, %2) : (index, index, index, index, index) -> index
      "scf.reduce"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()
