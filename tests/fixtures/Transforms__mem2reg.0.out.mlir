module {
  func.func @multi_slot_alloca() -> (i32, i32) {
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %1 = "test.constant"() <{value = 42 : i32}> : () -> i32
    return %1, %0 : i32, i32
  }
}

// -----
module {
  func.func private @consumer(memref<i32>)
  func.func @multi_slot_alloca_only_second() -> (i32, i32) {
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %1 = test.multi_slot_alloca : () -> memref<i32>
    call @consumer(%1) : (memref<i32>) -> ()
    %2 = memref.load %1[] : memref<i32>
    return %2, %0 : i32, i32
  }
}

// -----
module {
  test.isolated_graph_region {
    %0 = test.multi_slot_alloca : () -> memref<i32>
    memref.store %1, %0[] : memref<i32>
    %1 = memref.load %0[] : memref<i32>
    "test.foo"() : () -> ()
  }
}

// -----
module {
  func.func @merge_point_arg_not_confused(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    cf.br ^bb3(%arg1 : i32)
  ^bb2:  // pred: ^bb0
    cf.br ^bb3(%arg2 : i32)
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    cf.cond_br %arg0, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    cf.br ^bb6(%0 : i32)
  ^bb5:  // pred: ^bb3
    %c0_i32 = arith.constant 0 : i32
    cf.br ^bb6(%c0_i32 : i32)
  ^bb6(%1: i32):  // 2 preds: ^bb4, ^bb5
    return %1 : i32
  }
}

// -----
module {
  func.func @unknown_region_op_load() {
    %c5_i32 = arith.constant 5 : i32
    %alloca = memref.alloca() : memref<i32>
    memref.store %c5_i32, %alloca[] : memref<i32>
    "test.one_region_op"() ({
      %0 = memref.load %alloca[] : memref<i32>
      "test.finish"() : () -> ()
    }) : () -> ()
    return
  }
}

// -----
module {
  func.func @cyclic_unused_merge_points(%arg0: i1) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    %c1_i32 = arith.constant 1 : i32
    cf.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb3
    cf.cond_br %arg0, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    cf.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    cf.cond_br %arg0, ^bb1, ^bb4
  ^bb4:  // pred: ^bb3
    return %c0_i32 : i32
  }
}

// -----
module {
  func.func @poison_insertion_point(%arg0: f64) {
    %0 = ub.poison : f64
    cf.br ^bb1(%0 : f64)
  ^bb1(%1: f64):  // 2 preds: ^bb0, ^bb2
    %2 = "test.get"() : () -> i1
    cf.cond_br %2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %3 = "test.get"() : () -> i1
    %4 = scf.if %3 -> (f64) {
      scf.yield %arg0 : f64
    } else {
      scf.yield %1 : f64
    }
    "test.use"(%4) : (f64) -> ()
    cf.br ^bb1(%4 : f64)
  ^bb3:  // pred: ^bb1
    return
  }
}

// -----
module {
  func.func @promotable_through_alias(%arg0: i32, %arg1: i1) -> i32 {
    %c42_i32 = arith.constant 42 : i32
    cf.cond_br %arg1, ^bb1, ^bb2(%c42_i32 : i32)
  ^bb1:  // pred: ^bb0
    cf.br ^bb2(%arg0 : i32)
  ^bb2(%0: i32):  // 2 preds: ^bb0, ^bb1
    return %0 : i32
  }
}

// -----
module {
  func.func @promotable_through_cast_alias(%arg0: f32) -> f32 {
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %1 = builtin.unrealized_conversion_cast %0 : i32 to f32
    %2 = builtin.unrealized_conversion_cast %0 : i32 to f32
    %3 = builtin.unrealized_conversion_cast %arg0 : f32 to i32
    %4 = builtin.unrealized_conversion_cast %0 : i32 to f32
    %5 = builtin.unrealized_conversion_cast %3 : i32 to f32
    return %5 : f32
  }
}

// -----
module {
  func.func @promotable_through_cast_alias_blocks(%arg0: f32, %arg1: i1) -> f32 {
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %cst = arith.constant 1.000000e+00 : f32
    %1 = builtin.unrealized_conversion_cast %0 : i32 to f32
    %2 = builtin.unrealized_conversion_cast %0 : i32 to f32
    %3 = builtin.unrealized_conversion_cast %cst : f32 to i32
    %4 = builtin.unrealized_conversion_cast %0 : i32 to f32
    cf.cond_br %arg1, ^bb1, ^bb2(%3 : i32)
  ^bb1:  // pred: ^bb0
    %5 = builtin.unrealized_conversion_cast %3 : i32 to f32
    %6 = builtin.unrealized_conversion_cast %3 : i32 to f32
    %7 = builtin.unrealized_conversion_cast %arg0 : f32 to i32
    %8 = builtin.unrealized_conversion_cast %3 : i32 to f32
    cf.br ^bb2(%7 : i32)
  ^bb2(%9: i32):  // 2 preds: ^bb0, ^bb1
    %10 = builtin.unrealized_conversion_cast %9 : i32 to f32
    return %10 : f32
  }
}

// -----
module {
  func.func @promotable_through_alias_across_regions(%arg0: i1, %arg1: i32) {
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %1 = scf.if %arg0 -> (i32) {
      scf.yield %arg1 : i32
    } else {
      scf.yield %0 : i32
    }
    return
  }
}

// -----
module {
  func.func @alias_inside_region_parent_read_outside(%arg0: i1, %arg1: f32, %arg2: i32) -> i32 {
    %0 = scf.if %arg0 -> (i32) {
      %1 = builtin.unrealized_conversion_cast %arg2 : i32 to f32
      %2 = builtin.unrealized_conversion_cast %arg2 : i32 to f32
      %3 = builtin.unrealized_conversion_cast %arg1 : f32 to i32
      %4 = builtin.unrealized_conversion_cast %arg2 : i32 to f32
      scf.yield %3 : i32
    } else {
      scf.yield %arg2 : i32
    }
    return %0 : i32
  }
}

// -----
module {
  func.func @promotable_through_chained_aliases(%arg0: f32) -> f32 {
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %1 = builtin.unrealized_conversion_cast %0 : i32 to f32
    %2 = builtin.unrealized_conversion_cast %0 : i32 to f32
    %3 = builtin.unrealized_conversion_cast %arg0 : f32 to i32
    %4 = builtin.unrealized_conversion_cast %0 : i32 to f32
    %5 = builtin.unrealized_conversion_cast %3 : i32 to f32
    return %5 : f32
  }
}

// -----
module {
  func.func @promotable_through_dual_alias(%arg0: si32) -> ui32 {
    %0 = ub.poison : i32
    %1 = builtin.unrealized_conversion_cast %0 : i32 to si32
    %2 = builtin.unrealized_conversion_cast %0 : i32 to si32
    %3 = builtin.unrealized_conversion_cast %arg0 : si32 to i32
    %4 = builtin.unrealized_conversion_cast %0 : i32 to si32
    %5 = builtin.unrealized_conversion_cast %3 : i32 to ui32
    return %5 : ui32
  }
}

// -----
module {
  func.func @promotable_through_partial_alias(%arg0: f32) -> f32 {
    %0 = ub.poison : complex<f32>
    %1 = builtin.unrealized_conversion_cast %0 : complex<f32> to f32
    %2 = builtin.unrealized_conversion_cast %0 : complex<f32> to f32
    %3 = builtin.unrealized_conversion_cast %arg0, %0 : f32, complex<f32> to complex<f32>
    %4 = builtin.unrealized_conversion_cast %0 : complex<f32> to f32
    %5 = builtin.unrealized_conversion_cast %3 : complex<f32> to f32
    return %5 : f32
  }
}

// -----
module {
  func.func @tracker_basic(%arg0: i32, %arg1: i32) -> i32 {
    test.tracked_value %arg0, "x" : i32
    test.tracked_value %arg1, "x" : i32
    return %arg1 : i32
  }
}

// -----
module {
  func.func @tracker_load_stored_back(%arg0: i32) {
    test.tracked_value %arg0, "y" : i32
    test.tracked_value %arg0, "y" : i32
    return
  }
}

// -----
module {
  func.func @tracker_blocks(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    cf.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    test.tracked_value %arg0, "z" : i32
    cf.br ^bb3(%arg0 : i32)
  ^bb2:  // pred: ^bb0
    test.tracked_value %arg1, "z" : i32
    cf.br ^bb3(%arg1 : i32)
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    return %0 : i32
  }
}

// -----
module {
  func.func @tracker_at_end(%arg0: i32, %arg1: i32) -> i32 {
    test.tracked_value %arg0, "k" : i32
    test.tracked_value %arg1, "k" : i32
    return %arg1 : i32
  }
}

// -----
module {
  func.func @tracker_nested_region(%arg0: i32, %arg1: i32, %arg2: i1) {
    test.tracked_value %arg0, "w" : i32
    %0 = scf.if %arg2 -> (i32) {
      test.tracked_value %arg1, "w" : i32
      scf.yield %arg1 : i32
    } else {
      scf.yield %arg0 : i32
    }
    return
  }
}

// -----
module {
  func.func @tracker_inside_nested_region(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) {
    test.tracked_value %arg0, "n" : i32
    %0 = scf.if %arg3 -> (i32) {
      test.tracked_value %arg1, "n" : i32
      scf.yield %arg1 : i32
    } else {
      scf.yield %arg0 : i32
    }
    test.tracked_value %arg2, "n" : i32
    return
  }
}

