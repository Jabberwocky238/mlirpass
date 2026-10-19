"builtin.module"() ({
  "func.func"() <{function_type = (vector<11xf32>) -> vector<11xf32>, sym_name = "func"}> ({
  ^bb0(%arg0: vector<11xf32>):
    %0 = "arith.constant"() <{value = dense<true> : vector<11xi1>}> : () -> vector<11xi1>
    %1 = "vector.mask"(%0) ({
      "vector.yield"(%arg0) : (vector<11xf32>) -> ()
    }) : (vector<11xi1>) -> vector<11xf32>
    "func.return"(%1) : (vector<11xf32>) -> ()
  }) : () -> ()
}) : () -> ()

