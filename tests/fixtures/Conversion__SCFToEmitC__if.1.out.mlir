module {
  func.func @test_if(%arg0: i1, %arg1: f32) {
    emitc.if %arg0 {
      %0 = call_opaque "func_const"(%arg1) : (f32) -> i32
    }
    return
  }
  func.func @test_if_else(%arg0: i1, %arg1: f32) {
    emitc.if %arg0 {
      %0 = call_opaque "func_true"(%arg1) : (f32) -> i32
    } else {
      %0 = call_opaque "func_false"(%arg1) : (f32) -> i32
    }
    return
  }
  func.func @test_if_yield(%arg0: i1, %arg1: f32) -> (i32, f64) {
    %c0_i8 = arith.constant 0 : i8
    %0 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %1 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<f64>
    emitc.if %arg0 {
      %4 = call_opaque "func_true_1"(%arg1) : (f32) -> i32
      %5 = call_opaque "func_true_2"(%arg1) : (f32) -> f64
      assign %4 : i32 to %0 : <i32>
      assign %5 : f64 to %1 : <f64>
    } else {
      %4 = call_opaque "func_false_1"(%arg1) : (f32) -> i32
      %5 = call_opaque "func_false_2"(%arg1) : (f32) -> f64
      assign %4 : i32 to %0 : <i32>
      assign %5 : f64 to %1 : <f64>
    }
    %2 = emitc.load %0 : <i32>
    %3 = emitc.load %1 : <f64>
    return %2, %3 : i32, f64
  }
}

