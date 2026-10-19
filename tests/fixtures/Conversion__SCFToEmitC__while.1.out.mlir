module {
  emitc.func @payload_one_result(%arg0: i32) -> i32 {
    %0 = add %arg0, %arg0 : (i32, i32) -> i32
    return %0 : i32
  }
  func.func @one_result() -> i32 {
    %0 = emitc.literal "1.0" : i32
    %1 = emitc.literal "1.0" : i32
    %2 = emitc.literal "10.0" : i32
    %3 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %4 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    emitc.assign %0 : i32 to %4 : <i32>
    %5 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i1>
    emitc.do {
      %7 = load %4 : <i32>
      %8 = add %7, %1 : (i32, i32) -> i32
      %9 = cmp lt, %8, %2 : (i32, i32) -> i1
      %10 = add %7, %7 : (i32, i32) -> i32
      assign %10 : i32 to %3 : <i32>
      assign %9 : i1 to %5 : <i1>
      if %9 {
        %11 = call @payload_one_result(%10) : (i32) -> i32
        assign %11 : i32 to %4 : <i32>
      }
    } while {
      %7 = expression %5 : (!emitc.lvalue<i1>) -> i1 {
        %8 = load %5 : <i1>
        yield %8 : i1
      }
      yield %7 : i1
    }
    %6 = emitc.load %3 : <i32>
    return %6 : i32
  }
  emitc.func @payload_two_results(%arg0: i32) -> i32 {
    %0 = add %arg0, %arg0 : (i32, i32) -> i32
    return %0 : i32
  }
  func.func @two_results() -> i32 {
    %0 = emitc.literal "1.0" : i32
    %1 = emitc.literal "10.0" : i32
    %2 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %3 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %4 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    emitc.assign %0 : i32 to %4 : <i32>
    %5 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    emitc.assign %0 : i32 to %5 : <i32>
    %6 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i1>
    emitc.do {
      %9 = load %4 : <i32>
      %10 = load %5 : <i32>
      %11 = add %9, %10 : (i32, i32) -> i32
      %12 = cmp lt, %11, %1 : (i32, i32) -> i1
      assign %0 : i32 to %2 : <i32>
      assign %10 : i32 to %3 : <i32>
      assign %12 : i1 to %6 : <i1>
      if %12 {
        %13 = call @payload_two_results(%0) : (i32) -> i32
        %14 = call @payload_two_results(%10) : (i32) -> i32
        assign %13 : i32 to %4 : <i32>
        assign %14 : i32 to %5 : <i32>
      }
    } while {
      %9 = expression %6 : (!emitc.lvalue<i1>) -> i1 {
        %10 = load %6 : <i1>
        yield %10 : i1
      }
      yield %9 : i1
    }
    %7 = emitc.load %2 : <i32>
    %8 = emitc.load %3 : <i32>
    return %7 : i32
  }
  emitc.func @payload_double_use(%arg0: i32) -> i32 {
    %0 = add %arg0, %arg0 : (i32, i32) -> i32
    return %0 : i32
  }
  emitc.func @foo_with_side_effect(%arg0: i32, %arg1: !emitc.ptr<i32>) -> i32 {
    %0 = add %arg0, %arg0 : (i32, i32) -> i32
    verbatim "{}[0] = {};" args %arg1, %0 : !emitc.ptr<i32>, i32
    return %0 : i32
  }
  func.func @double_use(%arg0: !emitc.ptr<i32>) -> i32 {
    %0 = emitc.literal "1.0" : i32
    %1 = emitc.literal "1.0" : i32
    %2 = emitc.literal "10.0" : i32
    %3 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %4 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    emitc.assign %0 : i32 to %4 : <i32>
    %5 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i1>
    emitc.do {
      %7 = load %4 : <i32>
      %8 = call @foo_with_side_effect(%7, %arg0) : (i32, !emitc.ptr<i32>) -> i32
      %9 = add %8, %8 : (i32, i32) -> i32
      %10 = add %7, %9 : (i32, i32) -> i32
      %11 = cmp lt, %10, %2 : (i32, i32) -> i1
      assign %7 : i32 to %3 : <i32>
      assign %11 : i1 to %5 : <i1>
      if %11 {
        %12 = call @payload_double_use(%7) : (i32) -> i32
        assign %12 : i32 to %4 : <i32>
      }
    } while {
      %7 = expression %5 : (!emitc.lvalue<i1>) -> i1 {
        %8 = load %5 : <i1>
        yield %8 : i1
      }
      yield %7 : i1
    }
    %6 = emitc.load %3 : <i32>
    return %6 : i32
  }
  emitc.func @payload_empty_after_region() -> i1 {
    %0 = literal "true" : i1
    return %0 : i1
  }
  func.func @empty_after_region() {
    %0 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i1>
    emitc.do {
      %1 = call @payload_empty_after_region() : () -> i1
      assign %1 : i1 to %0 : <i1>
    } while {
      %1 = expression %0 : (!emitc.lvalue<i1>) -> i1 {
        %2 = load %0 : <i1>
        yield %2 : i1
      }
      yield %1 : i1
    }
    return
  }
  emitc.func @payload_different_number_of_vars(%arg0: i32) -> i32 {
    %0 = add %arg0, %arg0 : (i32, i32) -> i32
    return %0 : i32
  }
  func.func @different_number_of_vars() -> (i32, i32) {
    %0 = emitc.literal "1.0" : i32
    %1 = emitc.literal "7.0" : i32
    %2 = emitc.literal "10.0" : i32
    %3 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %4 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    %5 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i32>
    emitc.assign %0 : i32 to %5 : <i32>
    %6 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<i1>
    emitc.do {
      %9 = load %5 : <i32>
      %10 = add %9, %1 : (i32, i32) -> i32
      %11 = cmp lt, %10, %2 : (i32, i32) -> i1
      %12 = add %9, %9 : (i32, i32) -> i32
      assign %12 : i32 to %3 : <i32>
      assign %10 : i32 to %4 : <i32>
      assign %11 : i1 to %6 : <i1>
      if %11 {
        %13 = call @payload_different_number_of_vars(%12) : (i32) -> i32
        assign %13 : i32 to %5 : <i32>
      }
    } while {
      %9 = expression %6 : (!emitc.lvalue<i1>) -> i1 {
        %10 = load %6 : <i1>
        yield %10 : i1
      }
      yield %9 : i1
    }
    %7 = emitc.load %3 : <i32>
    %8 = emitc.load %4 : <i32>
    return %7, %8 : i32, i32
  }
}

