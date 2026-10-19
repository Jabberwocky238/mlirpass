"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "map1d"}> ({
  ^bb0(%arg4: index, %arg5: index, %arg6: index):
    %2:2 = "new_processor_id_and_range"() : () -> (index, index)
    "scf.for"(%arg4, %arg5, %arg6) ({
    ^bb0(%arg7: index):
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "map2d"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0:2 = "new_processor_id_and_range"() : () -> (index, index)
    %1:2 = "new_processor_id_and_range"() : () -> (index, index)
    "scf.for"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg3: index):
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

