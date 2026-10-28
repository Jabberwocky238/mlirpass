module {
  func.func private @side_effect(f32, f32)
  func.func @broadcast_hoisting(%arg0: f32, %arg1: i32, %arg2: index) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0 = gpu.subgroup_broadcast %arg0,  specific_lane %arg1 : f32
    scf.for %arg3 = %c0 to %arg2 step %c1 {
      %1 = gpu.subgroup_broadcast %arg0,  first_active_lane : f32
      func.call @side_effect(%1, %0) : (f32, f32) -> ()
    }
    return
  }
}

