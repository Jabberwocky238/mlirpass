"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> vector<3xindex>, sym_name = "unsupported_type_vector"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = dense<0> : vector<3xindex>}> : () -> vector<3xindex>
    %1 = "scf.for"(%arg0, %arg1, %arg2, %0) ({
    ^bb0(%arg3: index, %arg4: vector<3xindex>):
      "scf.yield"(%arg4) : (vector<3xindex>) -> ()
    }) : (index, index, index, vector<3xindex>) -> vector<3xindex>
    "func.return"(%1) : (vector<3xindex>) -> ()
  }) : () -> ()
}) : () -> ()

