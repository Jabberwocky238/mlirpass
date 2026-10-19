module {
  func.func @simple_if() {
    %c0_i32 = arith.constant 0 : i32
    %0 = "test.test1"() : () -> i1
    scf.if %0 {
      "test.test2"() : () -> ()
    } else {
      "test.test3"() : () -> ()
    }
    "test.test4"() : () -> ()
    return
  }
}

// -----
module {
  func.func @if_with_block_args() -> index {
    %c0_i32 = arith.constant 0 : i32
    %0 = "test.test1"() : () -> i1
    %1 = scf.if %0 -> (index) {
      %2 = "test.test2"() : () -> index
      scf.yield %2 : index
    } else {
      %2 = "test.test3"() : () -> index
      scf.yield %2 : index
    }
    "test.test4"() : () -> ()
    return %1 : index
  }
}

// -----
module {
  func.func @empty_else() {
    %c0_i32 = arith.constant 0 : i32
    %0 = "test.test1"() : () -> i1
    scf.if %0 {
      "test.test2"() : () -> ()
    } else {
    }
    "test.test4"() : () -> ()
    return
  }
}

// -----
module {
  func.func @while_loop() {
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    "test.test1"() : () -> ()
    scf.while : () -> () {
      %0 = "test.test2"() : () -> i1
      %1:2 = scf.if %0 -> (i32, i32) {
        "test.test3"() : () -> ()
        scf.yield %c0_i32, %c1_i32 : i32, i32
      } else {
        scf.yield %c1_i32, %c0_i32 : i32, i32
      }
      %2 = arith.trunci %1#1 : i32 to i1
      scf.condition(%2)
    } do {
      scf.yield
    }
    "test.test4"() : () -> ()
    return
  }
}

// -----
module {
  func.func @while_loop_with_block_args() -> i64 {
    %0 = ub.poison : index
    %1 = ub.poison : i64
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %2 = "test.test1"() : () -> index
    %3:2 = scf.while (%arg0 = %2, %arg1 = %1) : (index, i64) -> (index, i64) {
      %4:2 = "test.test2"() : () -> (i1, i64)
      %5:4 = scf.if %4#0 -> (index, i64, i32, i32) {
        %7 = "test.test3"(%4#1) : (i64) -> index
        scf.yield %7, %1, %c0_i32, %c1_i32 : index, i64, i32, i32
      } else {
        scf.yield %0, %4#1, %c1_i32, %c0_i32 : index, i64, i32, i32
      }
      %6 = arith.trunci %5#3 : i32 to i1
      scf.condition(%6) %5#0, %5#1 : index, i64
    } do {
    ^bb0(%arg0: index, %arg1: i64):
      scf.yield %arg0, %arg1 : index, i64
    }
    "test.test4"() : () -> ()
    return %3#1 : i64
  }
}

// -----
module {
  func.func @multi_exit_loop() {
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    "test.test1"() : () -> ()
    scf.while : () -> () {
      %0 = "test.test2"() : () -> i1
      %1:2 = scf.if %0 -> (i32, i32) {
        %3 = "test.test3"() : () -> i1
        %4:2 = scf.if %3 -> (i32, i32) {
          scf.yield %c1_i32, %c0_i32 : i32, i32
        } else {
          scf.yield %c0_i32, %c1_i32 : i32, i32
        }
        scf.yield %4#0, %4#1 : i32, i32
      } else {
        scf.yield %c1_i32, %c0_i32 : i32, i32
      }
      %2 = arith.trunci %1#1 : i32 to i1
      scf.condition(%2)
    } do {
      scf.yield
    }
    "test.test4"() : () -> ()
    return
  }
}

// -----
module {
  func.func private @foo(f32) -> f32
  func.func private @bar(f32)
  func.func @switch_with_fallthrough(%arg0: i32, %arg1: f32, %arg2: f32) {
    %c1_i32 = arith.constant 1 : i32
    %0 = ub.poison : f32
    %c0_i32 = arith.constant 0 : i32
    %1 = arith.index_castui %arg0 : i32 to index
    %2:2 = scf.index_switch %1 -> f32, i32 
    case 0 {
      scf.yield %arg2, %c0_i32 : f32, i32
    }
    case 1 {
      scf.yield %0, %c1_i32 : f32, i32
    }
    default {
      %4 = func.call @foo(%arg1) : (f32) -> f32
      scf.yield %4, %c0_i32 : f32, i32
    }
    %3 = arith.index_castui %2#1 : i32 to index
    scf.index_switch %3 
    case 0 {
      func.call @bar(%2#0) : (f32) -> ()
      scf.yield
    }
    default {
    }
    return
  }
}

// -----
module {
  func.func private @bar(f32) -> (i1, f32)
  func.func @already_structured_loop(%arg0: f32) -> f32 {
    %0 = ub.poison : f32
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %1 = scf.while (%arg1 = %0) : (f32) -> f32 {
      %2:2 = func.call @bar(%arg0) : (f32) -> (i1, f32)
      %3:2 = scf.if %2#0 -> (i32, i32) {
        scf.yield %c1_i32, %c0_i32 : i32, i32
      } else {
        scf.yield %c0_i32, %c1_i32 : i32, i32
      }
      %4 = arith.trunci %3#1 : i32 to i1
      scf.condition(%4) %2#1 : f32
    } do {
    ^bb0(%arg1: f32):
      scf.yield %arg1 : f32
    }
    return %1 : f32
  }
}

// -----
module {
  func.func private @bar(f32) -> (i1, f32)
  func.func @exit_loop_iter_use(%arg0: f32) -> f32 {
    %0 = ub.poison : f32
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %1:2 = scf.while (%arg1 = %arg0, %arg2 = %0) : (f32, f32) -> (f32, f32) {
      %2:2 = func.call @bar(%arg1) : (f32) -> (i1, f32)
      %3:3 = scf.if %2#0 -> (f32, i32, i32) {
        scf.yield %0, %c1_i32, %c0_i32 : f32, i32, i32
      } else {
        scf.yield %2#1, %c0_i32, %c1_i32 : f32, i32, i32
      }
      %4 = arith.trunci %3#2 : i32 to i1
      scf.condition(%4) %3#0, %arg1 : f32, f32
    } do {
    ^bb0(%arg1: f32, %arg2: f32):
      scf.yield %arg1, %arg2 : f32, f32
    }
    return %1#1 : f32
  }
}

// -----
module {
  func.func private @bar(f32) -> f32
  func.func @infinite_loop(%arg0: f32) -> f32 {
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %0 = scf.while (%arg1 = %arg0) : (f32) -> f32 {
      %2 = func.call @bar(%arg1) : (f32) -> f32
      %3 = arith.trunci %c1_i32 : i32 to i1
      scf.condition(%3) %2 : f32
    } do {
    ^bb0(%arg1: f32):
      scf.yield %arg1 : f32
    }
    %1 = ub.poison : f32
    return %1 : f32
  }
}

// -----
module {
  func.func @multi_return() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %0 = "test.test1"() : () -> i1
    %1 = scf.if %0 -> (i32) {
      %2 = "test.test2"() : () -> i32
      scf.yield %2 : i32
    } else {
      %2 = "test.test4"() : () -> i32
      scf.yield %2 : i32
    }
    return %1 : i32
  }
}

// -----
module {
  func.func private @bar(f32) -> f32
  func.func @conditional_infinite_loop(%arg0: f32, %arg1: i1) -> f32 {
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %0 = scf.if %arg1 -> (f32) {
      %1 = scf.while (%arg2 = %arg0) : (f32) -> f32 {
        %3 = func.call @bar(%arg2) : (f32) -> f32
        %4 = arith.trunci %c1_i32 : i32 to i1
        scf.condition(%4) %3 : f32
      } do {
      ^bb0(%arg2: f32):
        scf.yield %arg2 : f32
      }
      %2 = ub.poison : f32
      scf.yield %2 : f32
    } else {
      scf.yield %arg0 : f32
    }
    return %0 : f32
  }
}

// -----
module {
  func.func private @bar(i32)
  func.func @mixing_return_like(%arg0: i1, %arg1: i1, %arg2: i1) {
    %c0_i32 = arith.constant 0 : i32
    %c0_i32_0 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = scf.if %arg1 -> (i32) {
      scf.yield %c0_i32_0 : i32
    } else {
      scf.yield %c1_i32 : i32
    }
    call @bar(%0) : (i32) -> ()
    "test.returnLike"() : () -> ()
  ^bb2:  // pred: ^bb0
    %1 = scf.if %arg2 -> (i32) {
      scf.yield %c1_i32 : i32
    } else {
      scf.yield %c0_i32_0 : i32
    }
    call @bar(%1) : (i32) -> ()
    return
  }
}

// -----
module {
  func.func @some_successors_with_different_return(%arg0: i32) -> i32 {
    %0 = ub.poison : i32
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %c5_i32 = arith.constant 5 : i32
    %c6_i32 = arith.constant 6 : i32
    %1 = arith.index_castui %arg0 : i32 to index
    %2:2 = scf.index_switch %1 -> i32, i32 
    case 0 {
      scf.yield %c5_i32, %c1_i32 : i32, i32
    }
    case 1 {
      scf.yield %c6_i32, %c1_i32 : i32, i32
    }
    default {
      scf.yield %0, %c0_i32 : i32, i32
    }
    cf.switch %2#1 : i32, [
      default: ^bb1(%2#0 : i32),
      0: ^bb2
    ]
  ^bb1(%3: i32):  // pred: ^bb0
    %4 = scf.while (%arg1 = %3) : (i32) -> i32 {
      %6 = arith.trunci %c1_i32 : i32 to i1
      scf.condition(%6) %arg1 : i32
    } do {
    ^bb0(%arg1: i32):
      scf.yield %arg1 : i32
    }
    %5 = ub.poison : i32
    return %5 : i32
  ^bb2:  // pred: ^bb0
    "test.returnLike"() : () -> ()
  }
}

// -----
module {
  func.func @select_like(%arg0: i1) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %c0_i32_0 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = scf.if %arg0 -> (i32) {
      scf.yield %c0_i32_0 : i32
    } else {
      scf.yield %c1_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @return_like_dominated_by_condition(%arg0: i1, %arg1: i1, %arg2: i1) {
    %0 = ub.poison : i32
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %1 = scf.if %arg0 -> (i32) {
      scf.yield %c0_i32 : i32
    } else {
      %2:2 = scf.if %arg1 -> (i32, i32) {
        scf.yield %0, %c0_i32 : i32, i32
      } else {
        %5:2 = scf.if %arg2 -> (i32, i32) {
          scf.yield %0, %c0_i32 : i32, i32
        } else {
          scf.yield %c0_i32, %c1_i32 : i32, i32
        }
        scf.yield %5#0, %5#1 : i32, i32
      }
      %3 = arith.index_castui %2#1 : i32 to index
      %4 = scf.index_switch %3 -> i32 
      case 0 {
        scf.yield %c1_i32 : i32
      }
      default {
        scf.yield %2#0 : i32
      }
      scf.yield %4 : i32
    }
    cf.switch %1 : i32, [
      default: ^bb2,
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    return
  ^bb2:  // pred: ^bb0
    "test.unreachable"() : () -> ()
  }
}

// -----
module {
  func.func @dominator_issue(%arg0: i1, %arg1: i1) -> i32 {
    %c1_i32 = arith.constant 1 : i32
    %0 = ub.poison : i32
    %c0_i32 = arith.constant 0 : i32
    %1:2 = scf.if %arg0 -> (i32, i32) {
      scf.yield %0, %c0_i32 : i32, i32
    } else {
      %3 = "test.def"() : () -> i32
      %4:2 = scf.if %arg1 -> (i32, i32) {
        scf.yield %0, %c0_i32 : i32, i32
      } else {
        scf.yield %3, %c1_i32 : i32, i32
      }
      scf.yield %4#0, %4#1 : i32, i32
    }
    cf.switch %1#1 : i32, [
      default: ^bb2(%1#0 : i32),
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    "test.unreachable"() : () -> ()
  ^bb2(%2: i32):  // pred: ^bb0
    return %2 : i32
  }
}

// -----
module {
  func.func private @bar(i32)
  func.func @dominator_issue_loop(%arg0: i1, %arg1: i1) -> i32 {
    %0 = ub.poison : i32
    %c2_i32 = arith.constant 2 : i32
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %c5_i32 = arith.constant 5 : i32
    %1:2 = scf.while (%arg2 = %0, %arg3 = %0) : (i32, i32) -> (i32, i32) {
      %4:3 = scf.if %arg0 -> (i32, i32, i32) {
        %6 = "test.def"() : () -> i32
        %7:3 = scf.if %arg1 -> (i32, i32, i32) {
          scf.yield %c0_i32, %c1_i32, %6 : i32, i32, i32
        } else {
          scf.yield %c1_i32, %c0_i32, %6 : i32, i32, i32
        }
        scf.yield %7#0, %7#1, %7#2 : i32, i32, i32
      } else {
        scf.yield %c2_i32, %c0_i32, %0 : i32, i32, i32
      }
      %5 = arith.trunci %4#1 : i32 to i1
      scf.condition(%5) %4#2, %4#0 : i32, i32
    } do {
    ^bb0(%arg2: i32, %arg3: i32):
      scf.yield %arg2, %arg3 : i32, i32
    }
    %2 = arith.index_castui %1#1 : i32 to index
    %3 = scf.index_switch %2 -> i32 
    case 1 {
      scf.yield %1#0 : i32
    }
    default {
      scf.yield %c5_i32 : i32
    }
    return %3 : i32
  }
}

// -----
module {
  func.func private @comp1(i32) -> i1
  func.func private @comp2(i32) -> i1
  func.func private @foo(i32)
  func.func @multi_entry_loop(%arg0: i1) {
    %0 = ub.poison : i32
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %c6_i32 = arith.constant 6 : i32
    %c5_i32 = arith.constant 5 : i32
    %1:2 = scf.if %arg0 -> (i32, i32) {
      scf.yield %c1_i32, %0 : i32, i32
    } else {
      scf.yield %c0_i32, %0 : i32, i32
    }
    %2:2 = scf.while (%arg1 = %1#0, %arg2 = %1#1) : (i32, i32) -> (i32, i32) {
      %3 = arith.index_castui %arg1 : i32 to index
      %4:4 = scf.index_switch %3 -> i32, i32, i32, i32 
      case 0 {
        %6 = func.call @comp2(%c5_i32) : (i32) -> i1
        %7:4 = scf.if %6 -> (i32, i32, i32, i32) {
          scf.yield %0, %c5_i32, %c1_i32, %c0_i32 : i32, i32, i32, i32
        } else {
          scf.yield %c1_i32, %0, %c0_i32, %c1_i32 : i32, i32, i32, i32
        }
        scf.yield %7#0, %7#1, %7#2, %7#3 : i32, i32, i32, i32
      }
      default {
        %6 = func.call @comp1(%c6_i32) : (i32) -> i1
        %7:4 = scf.if %6 -> (i32, i32, i32, i32) {
          scf.yield %0, %c6_i32, %c1_i32, %c0_i32 : i32, i32, i32, i32
        } else {
          scf.yield %c0_i32, %0, %c0_i32, %c1_i32 : i32, i32, i32, i32
        }
        scf.yield %7#0, %7#1, %7#2, %7#3 : i32, i32, i32, i32
      }
      %5 = arith.trunci %4#3 : i32 to i1
      scf.condition(%5) %4#0, %4#1 : i32, i32
    } do {
    ^bb0(%arg1: i32, %arg2: i32):
      scf.yield %arg1, %arg2 : i32, i32
    }
    call @foo(%2#1) : (i32) -> ()
    return
  }
}

// -----
module {
  func.func @nested_region() {
    scf.execute_region {
      %c0_i32 = arith.constant 0 : i32
      %0 = "test.test1"() : () -> i1
      scf.if %0 {
        "test.test2"() : () -> ()
      } else {
        "test.test3"() : () -> ()
      }
      "test.test4"() : () -> ()
      scf.yield
    }
    return
  }
}

// -----
module {
  func.func @nested_region_inside_loop_use() {
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    scf.while : () -> () {
      %0 = "test.test1"() : () -> i32
      scf.execute_region {
        "test.foo"(%0) : (i32) -> ()
        scf.yield
      }
      %1 = arith.trunci %c1_i32 : i32 to i1
      scf.condition(%1)
    } do {
      scf.yield
    }
    return
  }
}

// -----
module {
  func.func @nested_region_outside_loop_use() {
    %0 = ub.poison : i32
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %1 = scf.while (%arg0 = %0) : (i32) -> i32 {
      %2 = "test.test1"() : () -> i32
      %3 = "test.test2"() : () -> i1
      %4:2 = scf.if %3 -> (i32, i32) {
        scf.yield %c0_i32, %c1_i32 : i32, i32
      } else {
        scf.yield %c1_i32, %c0_i32 : i32, i32
      }
      %5 = arith.trunci %4#1 : i32 to i1
      scf.condition(%5) %2 : i32
    } do {
    ^bb0(%arg0: i32):
      scf.yield %arg0 : i32
    }
    scf.execute_region {
      "test.foo"(%1) : (i32) -> ()
      scf.yield
    }
    return
  }
}

