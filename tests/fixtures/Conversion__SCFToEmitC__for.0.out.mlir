module {
  func.func @simple_std_for_loop(%arg0: index, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to !emitc.size_t
    %1 = builtin.unrealized_conversion_cast %arg1 : index to !emitc.size_t
    %2 = builtin.unrealized_conversion_cast %arg0 : index to !emitc.size_t
    emitc.for %arg3 = %2 to %1 step %0  : !emitc.size_t {
      %c1 = arith.constant 1 : index
    }
    return
  }
  func.func @simple_std_2_for_loops(%arg0: index, %arg1: index, %arg2: index) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to !emitc.size_t
    %1 = builtin.unrealized_conversion_cast %arg1 : index to !emitc.size_t
    %2 = builtin.unrealized_conversion_cast %arg0 : index to !emitc.size_t
    emitc.for %arg3 = %2 to %1 step %0  : !emitc.size_t {
      %c1 = arith.constant 1 : index
      for %arg4 = %2 to %1 step %0  : !emitc.size_t {
        %c1_0 = arith.constant 1 : index
      }
    }
    return
  }
  func.func @for_yield(%arg0: index, %arg1: index, %arg2: index) -> (f32, f32) {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to !emitc.size_t
    %1 = builtin.unrealized_conversion_cast %arg1 : index to !emitc.size_t
    %2 = builtin.unrealized_conversion_cast %arg0 : index to !emitc.size_t
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %3 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<f32>
    %4 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<f32>
    emitc.assign %cst : f32 to %3 : <f32>
    emitc.assign %cst_0 : f32 to %4 : <f32>
    emitc.for %arg3 = %2 to %1 step %0  : !emitc.size_t {
      %7 = load %3 : <f32>
      %8 = load %4 : <f32>
      %9 = arith.addf %7, %8 : f32
      assign %9 : f32 to %3 : <f32>
      assign %9 : f32 to %4 : <f32>
    }
    %5 = emitc.load %3 : <f32>
    %6 = emitc.load %4 : <f32>
    return %5, %6 : f32, f32
  }
  func.func @nested_for_yield(%arg0: index, %arg1: index, %arg2: index) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to !emitc.size_t
    %1 = builtin.unrealized_conversion_cast %arg1 : index to !emitc.size_t
    %2 = builtin.unrealized_conversion_cast %arg0 : index to !emitc.size_t
    %cst = arith.constant 1.000000e+00 : f32
    %3 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<f32>
    emitc.assign %cst : f32 to %3 : <f32>
    emitc.for %arg3 = %2 to %1 step %0  : !emitc.size_t {
      %5 = load %3 : <f32>
      %6 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<f32>
      assign %5 : f32 to %6 : <f32>
      for %arg4 = %2 to %1 step %0  : !emitc.size_t {
        %8 = load %6 : <f32>
        %9 = arith.addf %8, %8 : f32
        assign %9 : f32 to %6 : <f32>
      }
      %7 = load %6 : <f32>
      assign %7 : f32 to %3 : <f32>
    }
    %4 = emitc.load %3 : <f32>
    return %4 : f32
  }
  func.func @for_yield_index(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to !emitc.size_t
    %1 = builtin.unrealized_conversion_cast %arg1 : index to !emitc.size_t
    %2 = builtin.unrealized_conversion_cast %arg0 : index to !emitc.size_t
    %c0 = arith.constant 0 : index
    %3 = builtin.unrealized_conversion_cast %c0 : index to !emitc.size_t
    %4 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.size_t>
    emitc.assign %3 : !emitc.size_t to %4 : <!emitc.size_t>
    emitc.for %arg3 = %2 to %1 step %0  : !emitc.size_t {
      %7 = load %4 : <!emitc.size_t>
      assign %7 : !emitc.size_t to %4 : <!emitc.size_t>
    }
    %5 = emitc.load %4 : <!emitc.size_t>
    %6 = builtin.unrealized_conversion_cast %5 : !emitc.size_t to index
    return %6 : index
  }
  func.func @for_yield_update_loop_carried_var(%arg0: index, %arg1: index, %arg2: index) -> index {
    %0 = builtin.unrealized_conversion_cast %arg2 : index to !emitc.size_t
    %1 = builtin.unrealized_conversion_cast %arg1 : index to !emitc.size_t
    %2 = builtin.unrealized_conversion_cast %arg0 : index to !emitc.size_t
    %c0 = arith.constant 0 : index
    %3 = builtin.unrealized_conversion_cast %c0 : index to !emitc.size_t
    %4 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.size_t>
    emitc.assign %3 : !emitc.size_t to %4 : <!emitc.size_t>
    emitc.for %arg3 = %2 to %1 step %0  : !emitc.size_t {
      %7 = load %4 : <!emitc.size_t>
      %8 = builtin.unrealized_conversion_cast %7 : !emitc.size_t to index
      %9 = arith.addi %8, %8 : index
      %10 = builtin.unrealized_conversion_cast %9 : index to !emitc.size_t
      assign %10 : !emitc.size_t to %4 : <!emitc.size_t>
    }
    %5 = emitc.load %4 : <!emitc.size_t>
    %6 = builtin.unrealized_conversion_cast %5 : !emitc.size_t to index
    return %6 : index
  }
}

