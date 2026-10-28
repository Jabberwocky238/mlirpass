"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32) -> (), sym_name = "side_effect", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (f32, i32, index) -> (), sym_name = "broadcast_hoisting"}> ({
  ^bb0(%arg0: f32, %arg1: i32, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%0, %arg2, %1) ({
    ^bb0(%arg3: index):
      %2 = "gpu.subgroup_broadcast"(%arg0) <{broadcast_type = #gpu<broadcast first_active_lane>}> : (f32) -> f32
      %3 = "gpu.subgroup_broadcast"(%arg0, %arg1) <{broadcast_type = #gpu<broadcast specific_lane>}> : (f32, i32) -> f32
      "func.call"(%2, %3) <{callee = @side_effect}> : (f32, f32) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

