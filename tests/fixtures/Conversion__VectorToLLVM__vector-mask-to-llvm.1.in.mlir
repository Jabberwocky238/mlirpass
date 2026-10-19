"builtin.module"() ({
  "func.func"() <{function_type = (index) -> vector<11xi1>, sym_name = "genbool_var_1d"}> ({
  ^bb0(%arg1: index):
    %1 = "vector.create_mask"(%arg1) : (index) -> vector<11xi1>
    "func.return"(%1) : (vector<11xi1>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index) -> vector<[11]xi1>, sym_name = "genbool_var_1d_scalable"}> ({
  ^bb0(%arg0: index):
    %0 = "vector.create_mask"(%arg0) : (index) -> vector<[11]xi1>
    "func.return"(%0) : (vector<[11]xi1>) -> ()
  }) : () -> ()
}) : () -> ()

