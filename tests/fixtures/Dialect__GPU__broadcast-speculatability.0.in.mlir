"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "side_effect", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "use_i32", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32, index) -> (), sym_name = "broadcast_hoisting"}> ({
  ^bb0(%arg3: f32, %arg4: i32, %arg5: index):
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%3, %arg5, %4) ({
    ^bb0(%arg6: index):
      %5 = "gpu.subgroup_broadcast"(%arg3) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (f32) -> f32
      %6 = "gpu.subgroup_broadcast"(%arg3, %arg4) <{broadcast_type = #gpu<broadcast specific_lane>}> : (f32, i32) -> f32
      "func.call"(%5, %6) <{callee = @side_effect}> : (f32, f32) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i1, index) -> (), sym_name = "ballot_no_hoisting"}> ({
  ^bb0(%arg0: i1, %arg1: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%0, %arg1, %1) ({
    ^bb0(%arg2: index):
      %2 = "gpu.ballot"(%arg0) : (i1) -> i32
      "func.call"(%2) <{callee = @use_i32}> : (i32) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

