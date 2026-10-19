module {
  func.func @switch_no_result(%arg0: index) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to !emitc.size_t
    emitc.switch %0 : !emitc.size_t 
    case 2 {
      %c10_i32 = arith.constant 10 : i32
      yield
    }
    case 5 {
      %c20_i32 = arith.constant 20 : i32
      yield
    }
    default {
      %c30_i32 = arith.constant 30 : i32
    }
    return
  }
  func.func @switch_one_result(%arg0: index) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to !emitc.size_t
    %1 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    emitc.switch %0 : !emitc.size_t 
    case 2 {
      %c10_i32 = arith.constant 10 : i32
      assign %c10_i32 : i32 to %1 : <i32>
      yield
    }
    case 5 {
      %c20_i32 = arith.constant 20 : i32
      assign %c20_i32 : i32 to %1 : <i32>
      yield
    }
    default {
      %c30_i32 = arith.constant 30 : i32
      assign %c30_i32 : i32 to %1 : <i32>
    }
    %2 = emitc.load %1 : <i32>
    return
  }
  func.func @switch_two_results(%arg0: index) -> (i32, f32) {
    %0 = builtin.unrealized_conversion_cast %arg0 : index to !emitc.size_t
    %1 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %2 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<f32>
    emitc.switch %0 : !emitc.size_t 
    case 2 {
      %c10_i32 = arith.constant 10 : i32
      %cst = arith.constant 1.200000e+00 : f32
      assign %c10_i32 : i32 to %1 : <i32>
      assign %cst : f32 to %2 : <f32>
      yield
    }
    case 5 {
      %c20_i32 = arith.constant 20 : i32
      %cst = arith.constant 2.400000e+00 : f32
      assign %c20_i32 : i32 to %1 : <i32>
      assign %cst : f32 to %2 : <f32>
      yield
    }
    default {
      %c30_i32 = arith.constant 30 : i32
      %cst = arith.constant 3.600000e+00 : f32
      assign %c30_i32 : i32 to %1 : <i32>
      assign %cst : f32 to %2 : <f32>
    }
    %3 = emitc.load %1 : <i32>
    %4 = emitc.load %2 : <f32>
    return %3, %4 : i32, f32
  }
}

