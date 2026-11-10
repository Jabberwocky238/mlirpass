module {
  func.func @if_load_only(%arg0: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %0 = scf.if %arg0 -> (i32) {
      scf.yield %c5_i32 : i32
    } else {
      scf.yield %c5_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @if_no_else_load(%arg0: i1) {
    %c5_i32 = arith.constant 5 : i32
    scf.if %arg0 {
      func.call @use(%c5_i32) : (i32) -> ()
    }
    call @use(%c5_i32) : (i32) -> ()
    return
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @if_no_else_store(%arg0: i1) {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %0 = scf.if %arg0 -> (i32) {
      scf.yield %c7_i32 : i32
    } else {
      scf.yield %c5_i32 : i32
    }
    call @use(%0) : (i32) -> ()
    return
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @if_nested_store(%arg0: i1, %arg1: i1) {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %0 = scf.if %arg0 -> (i32) {
      %1 = scf.if %arg1 -> (i32) {
        scf.yield %c7_i32 : i32
      } else {
        scf.yield %c5_i32 : i32
      }
      scf.yield %1 : i32
    } else {
      scf.yield %c5_i32 : i32
    }
    call @use(%0) : (i32) -> ()
    return
  }
}

// -----
module {
  func.func @if_load_into_store(%arg0: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %0 = scf.if %arg0 -> (i32) {
      scf.yield %c5_i32 : i32
    } else {
      scf.yield %c5_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @if_load_then_nested_if_store(%arg0: i1, %arg1: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %0 = scf.if %arg0 -> (i32) {
      %1 = scf.if %arg1 -> (i32) {
        scf.yield %c5_i32 : i32
      } else {
        scf.yield %c5_i32 : i32
      }
      scf.yield %1 : i32
    } else {
      scf.yield %c5_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @execute_region_load() {
    %c5_i32 = arith.constant 5 : i32
    scf.execute_region {
      func.call @use(%c5_i32) : (i32) -> ()
      scf.yield
    }
    return
  }
}

// -----
module {
  func.func @execute_region_store() -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %0 = scf.execute_region -> i32 {
      scf.yield %c7_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @execute_region_cfg(%arg0: i1, %arg1: i1) {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %c9_i32 = arith.constant 9 : i32
    %0 = scf.execute_region -> i32 {
      cf.cond_br %arg0, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      cf.br ^bb3(%c7_i32 : i32)
    ^bb2:  // pred: ^bb0
      cf.br ^bb3(%c9_i32 : i32)
    ^bb3(%1: i32):  // 2 preds: ^bb1, ^bb2
      scf.if %arg1 {
        func.call @use(%1) : (i32) -> ()
      }
      scf.yield %1 : i32
    }
    call @use(%0) : (i32) -> ()
    return
  }
  func.func @execute_region_cfg_no_use_at_all(%arg0: i1, %arg1: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %c9_i32 = arith.constant 9 : i32
    %0 = scf.execute_region -> i32 {
      cf.cond_br %arg0, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      cf.br ^bb3(%c7_i32 : i32)
    ^bb2:  // pred: ^bb0
      cf.br ^bb3(%c9_i32 : i32)
    ^bb3(%1: i32):  // 2 preds: ^bb1, ^bb2
      scf.yield %1 : i32
    }
    return %0 : i32
  }
  func.func @execute_region_cfg_with_store(%arg0: i1, %arg1: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %c9_i32 = arith.constant 9 : i32
    %c11_i32 = arith.constant 11 : i32
    %0 = scf.execute_region -> i32 {
      cf.cond_br %arg0, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      cf.br ^bb3
    ^bb2:  // pred: ^bb0
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      scf.yield %c11_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @execute_region_multiple_yields(%arg0: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %c9_i32 = arith.constant 9 : i32
    %0 = scf.execute_region -> i32 {
      cf.cond_br %arg0, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      scf.yield %c7_i32 : i32
    ^bb2:  // pred: ^bb0
      scf.yield %c9_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @execute_region_same_reaching_def(%arg0: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %0 = scf.execute_region -> i32 {
      cf.cond_br %arg0, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      scf.yield %c7_i32 : i32
    ^bb2:  // pred: ^bb0
      scf.yield %c7_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @execute_region_load_into_store_same_block() -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %0 = scf.execute_region -> i32 {
      scf.yield %c5_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @execute_region_load_into_store_diff_block(%arg0: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %0 = scf.execute_region -> i32 {
      cf.cond_br %arg0, ^bb1, ^bb2
    ^bb1:  // pred: ^bb0
      scf.yield %c5_i32 : i32
    ^bb2:  // pred: ^bb0
      scf.yield %c5_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @for_load_and_store(%arg0: index, %arg1: index, %arg2: index) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c1_i32 = arith.constant 1 : i32
    %0 = scf.for %arg3 = %arg0 to %arg1 step %arg2 iter_args(%arg4 = %c5_i32) -> (i32) {
      %1 = arith.addi %arg4, %c1_i32 : i32
      scf.yield %1 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @for_existing_iter_arg(%arg0: index, %arg1: index, %arg2: index, %arg3: i32) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c1_i32 = arith.constant 1 : i32
    %0:2 = scf.for %arg4 = %arg0 to %arg1 step %arg2 iter_args(%arg5 = %arg3, %arg6 = %c5_i32) -> (i32, i32) {
      %1 = arith.muli %arg5, %arg5 : i32
      %2 = arith.addi %arg6, %c1_i32 : i32
      scf.yield %1, %2 : i32, i32
    }
    return %0#1 : i32
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @for_load_only(%arg0: index, %arg1: index, %arg2: index) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    scf.for %arg3 = %arg0 to %arg1 step %arg2 {
      func.call @use(%c5_i32) : (i32) -> ()
    }
    return %c5_i32 : i32
  }
}

// -----
module {
  func.func @for_if_store(%arg0: index, %arg1: index, %arg2: index, %arg3: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %0 = scf.for %arg4 = %arg0 to %arg1 step %arg2 iter_args(%arg5 = %c5_i32) -> (i32) {
      %1 = scf.if %arg3 -> (i32) {
        scf.yield %c7_i32 : i32
      } else {
        scf.yield %arg5 : i32
      }
      scf.yield %1 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @for_load_into_store(%arg0: index, %arg1: index, %arg2: index) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %0 = scf.for %arg3 = %arg0 to %arg1 step %arg2 iter_args(%arg4 = %c5_i32) -> (i32) {
      scf.yield %arg4 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @forall_load(%arg0: index) {
    %c5_i32 = arith.constant 5 : i32
    scf.forall (%arg1) in (%arg0) {
      func.call @use(%c5_i32) : (i32) -> ()
    }
    return
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @forall_in_if(%arg0: index, %arg1: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %0 = scf.if %arg1 -> (i32) {
      scf.forall (%arg2) in (%arg0) {
        func.call @use(%c7_i32) : (i32) -> ()
      }
      scf.yield %c7_i32 : i32
    } else {
      scf.yield %c5_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @parallel_load(%arg0: index, %arg1: index, %arg2: index) {
    %c5_i32 = arith.constant 5 : i32
    scf.parallel (%arg3) = (%arg0) to (%arg1) step (%arg2) {
      func.call @use(%c5_i32) : (i32) -> ()
      scf.reduce 
    }
    return
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @parallel_in_if(%arg0: index, %arg1: index, %arg2: index, %arg3: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %0 = scf.if %arg3 -> (i32) {
      scf.parallel (%arg4) = (%arg0) to (%arg1) step (%arg2) {
        func.call @use(%c7_i32) : (i32) -> ()
        scf.reduce 
      }
      scf.yield %c7_i32 : i32
    } else {
      scf.yield %c5_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @parallel_reduce_load(%arg0: index, %arg1: index, %arg2: index) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c0_i32 = arith.constant 0 : i32
    %0 = scf.parallel (%arg3) = (%arg0) to (%arg1) step (%arg2) init (%c0_i32) -> i32 {
      %c1_i32 = arith.constant 1 : i32
      scf.reduce(%c1_i32 : i32) {
      ^bb0(%arg4: i32, %arg5: i32):
        %1 = arith.addi %arg4, %arg5 : i32
        %2 = arith.muli %1, %c5_i32 : i32
        scf.reduce.return %2 : i32
      }
    }
    return %0 : i32
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @while_load_before(%arg0: i1) {
    %c5_i32 = arith.constant 5 : i32
    scf.while : () -> () {
      func.call @use(%c5_i32) : (i32) -> ()
      scf.condition(%arg0)
    } do {
      scf.yield
    }
    return
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @while_load_after(%arg0: i1) {
    %c5_i32 = arith.constant 5 : i32
    scf.while : () -> () {
      scf.condition(%arg0)
    } do {
      func.call @use(%c5_i32) : (i32) -> ()
      scf.yield
    }
    return
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @while_store_before_load_after(%arg0: i1) {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %0 = scf.while (%arg1 = %c5_i32) : (i32) -> i32 {
      scf.condition(%arg0) %c7_i32 : i32
    } do {
    ^bb0(%arg1: i32):
      func.call @use(%arg1) : (i32) -> ()
      scf.yield %arg1 : i32
    }
    return
  }
}

// -----
module {
  func.func @while_store_before_load_after_loop(%arg0: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %0 = scf.while (%arg1 = %c5_i32) : (i32) -> i32 {
      scf.condition(%arg0) %c7_i32 : i32
    } do {
    ^bb0(%arg1: i32):
      scf.yield %arg1 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @while_store() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    %c10_i32 = arith.constant 10 : i32
    %0 = scf.while (%arg0 = %c0_i32) : (i32) -> i32 {
      %1 = arith.cmpi slt, %arg0, %c10_i32 : i32
      scf.condition(%1) %arg0 : i32
    } do {
    ^bb0(%arg0: i32):
      %1 = arith.addi %arg0, %c1_i32 : i32
      scf.yield %1 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @while_load_into_store_before(%arg0: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %0 = scf.while (%arg1 = %c5_i32) : (i32) -> i32 {
      scf.condition(%arg0) %arg1 : i32
    } do {
    ^bb0(%arg1: i32):
      scf.yield %arg1 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @while_load_into_store(%arg0: i1) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %0 = scf.while (%arg1 = %c5_i32) : (i32) -> i32 {
      scf.condition(%arg0) %arg1 : i32
    } do {
    ^bb0(%arg1: i32):
      scf.yield %arg1 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @index_switch_load_default(%arg0: index) {
    %c5_i32 = arith.constant 5 : i32
    scf.index_switch %arg0 
    default {
      func.call @use(%c5_i32) : (i32) -> ()
    }
    return
  }
}

// -----
module {
  func.func @index_switch_store_default(%arg0: index) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %0 = scf.index_switch %arg0 -> i32 
    default {
      scf.yield %c7_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func private @use(i32)
  func.func @index_switch_store_case_load_default(%arg0: index) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %c7_i32 = arith.constant 7 : i32
    %0 = scf.index_switch %arg0 -> i32 
    case 0 {
      scf.yield %c7_i32 : i32
    }
    default {
      func.call @use(%c5_i32) : (i32) -> ()
      scf.yield %c5_i32 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @index_switch_load_into_store(%arg0: index) -> i32 {
    %c5_i32 = arith.constant 5 : i32
    %0 = scf.index_switch %arg0 -> i32 
    case 0 {
      scf.yield %c5_i32 : i32
    }
    default {
      scf.yield %c5_i32 : i32
    }
    return %0 : i32
  }
}

