"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "multi_slot_alloca"}> ({
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %1 = "test.constant"() <{value = 42 : i32}> : () -> i32
    "func.return"(%1, %0) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>) -> (), sym_name = "consumer", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "multi_slot_alloca_only_second"}> ({
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %1 = "test.multi_slot_alloca"() : () -> memref<i32>
    "func.call"(%1) <{callee = @consumer}> : (memref<i32>) -> ()
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.return"(%2, %0) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "test.isolated_graph_region"() ({
    %0 = "test.multi_slot_alloca"() : () -> memref<i32>
    "memref.store"(%1, %0) : (i32, memref<i32>) -> ()
    %1 = "memref.load"(%0) : (memref<i32>) -> i32
    "test.foo"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i32, i32) -> i32, sym_name = "merge_point_arg_not_confused"}> ({
  ^bb0(%arg0: i1, %arg1: i32, %arg2: i32):
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%arg1)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "cf.br"(%arg2)[^bb3] : (i32) -> ()
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    "cf.cond_br"(%arg0)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    "cf.br"(%0)[^bb6] : (i32) -> ()
  ^bb5:  // pred: ^bb3
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "cf.br"(%1)[^bb6] : (i32) -> ()
  ^bb6(%2: i32):  // 2 preds: ^bb4, ^bb5
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "unknown_region_op_load"}> ({
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %1) : (i32, memref<i32>) -> ()
    "test.one_region_op"() ({
      %2 = "memref.load"(%1) : (memref<i32>) -> i32
      "test.finish"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1) -> i32, sym_name = "cyclic_unused_merge_points"}> ({
  ^bb0(%arg0: i1):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb3
    "cf.cond_br"(%arg0)[^bb3, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    "cf.cond_br"(%arg0)[^bb1, ^bb4] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f64) -> (), sym_name = "poison_insertion_point"}> ({
  ^bb0(%arg0: f64):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> f64
    "cf.br"(%0)[^bb1] : (f64) -> ()
  ^bb1(%1: f64):  // 2 preds: ^bb0, ^bb2
    %2 = "test.get"() : () -> i1
    "cf.cond_br"(%2)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %3 = "test.get"() : () -> i1
    %4 = "scf.if"(%3) ({
      "scf.yield"(%arg0) : (f64) -> ()
    }, {
      "scf.yield"(%1) : (f64) -> ()
    }) : (i1) -> f64
    "test.use"(%4) : (f64) -> ()
    "cf.br"(%4)[^bb1] : (f64) -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "promotable_through_alias"}> ({
  ^bb0(%arg0: i32, %arg1: i1):
    %0 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    "cf.cond_br"(%arg1, %0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    "cf.br"(%arg0)[^bb2] : (i32) -> ()
  ^bb2(%1: i32):  // 2 preds: ^bb0, ^bb1
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "promotable_through_cast_alias"}> ({
  ^bb0(%arg0: f32):
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> f32
    %2 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> f32
    %3 = "builtin.unrealized_conversion_cast"(%arg0) : (f32) -> i32
    %4 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> f32
    %5 = "builtin.unrealized_conversion_cast"(%3) : (i32) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, i1) -> f32, sym_name = "promotable_through_cast_alias_blocks"}> ({
  ^bb0(%arg0: f32, %arg1: i1):
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %2 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> f32
    %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> f32
    %4 = "builtin.unrealized_conversion_cast"(%1) : (f32) -> i32
    %5 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> f32
    "cf.cond_br"(%arg1, %4)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 1>}> : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    %6 = "builtin.unrealized_conversion_cast"(%4) : (i32) -> f32
    %7 = "builtin.unrealized_conversion_cast"(%4) : (i32) -> f32
    %8 = "builtin.unrealized_conversion_cast"(%arg0) : (f32) -> i32
    %9 = "builtin.unrealized_conversion_cast"(%4) : (i32) -> f32
    "cf.br"(%8)[^bb2] : (i32) -> ()
  ^bb2(%10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = "builtin.unrealized_conversion_cast"(%10) : (i32) -> f32
    "func.return"(%11) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i32) -> (), sym_name = "promotable_through_alias_across_regions"}> ({
  ^bb0(%arg0: i1, %arg1: i32):
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %1 = "scf.if"(%arg0) ({
      "scf.yield"(%arg1) : (i32) -> ()
    }, {
      "scf.yield"(%0) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, f32, i32) -> i32, sym_name = "alias_inside_region_parent_read_outside"}> ({
  ^bb0(%arg0: i1, %arg1: f32, %arg2: i32):
    %0 = "scf.if"(%arg0) ({
      %1 = "builtin.unrealized_conversion_cast"(%arg2) : (i32) -> f32
      %2 = "builtin.unrealized_conversion_cast"(%arg2) : (i32) -> f32
      %3 = "builtin.unrealized_conversion_cast"(%arg1) : (f32) -> i32
      %4 = "builtin.unrealized_conversion_cast"(%arg2) : (i32) -> f32
      "scf.yield"(%3) : (i32) -> ()
    }, {
      "scf.yield"(%arg2) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "promotable_through_chained_aliases"}> ({
  ^bb0(%arg0: f32):
    %0 = "test.constant"() <{value = 42 : i32}> : () -> i32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> f32
    %2 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> f32
    %3 = "builtin.unrealized_conversion_cast"(%arg0) : (f32) -> i32
    %4 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> f32
    %5 = "builtin.unrealized_conversion_cast"(%3) : (i32) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (si32) -> ui32, sym_name = "promotable_through_dual_alias"}> ({
  ^bb0(%arg0: si32):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> i32
    %1 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> si32
    %2 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> si32
    %3 = "builtin.unrealized_conversion_cast"(%arg0) : (si32) -> i32
    %4 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> si32
    %5 = "builtin.unrealized_conversion_cast"(%3) : (i32) -> ui32
    "func.return"(%5) : (ui32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "promotable_through_partial_alias"}> ({
  ^bb0(%arg0: f32):
    %0 = "ub.poison"() <{value = #ub.poison}> : () -> complex<f32>
    %1 = "builtin.unrealized_conversion_cast"(%0) : (complex<f32>) -> f32
    %2 = "builtin.unrealized_conversion_cast"(%0) : (complex<f32>) -> f32
    %3 = "builtin.unrealized_conversion_cast"(%arg0, %0) : (f32, complex<f32>) -> complex<f32>
    %4 = "builtin.unrealized_conversion_cast"(%0) : (complex<f32>) -> f32
    %5 = "builtin.unrealized_conversion_cast"(%3) : (complex<f32>) -> f32
    "func.return"(%5) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "tracker_basic"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    "test.tracked_value"(%arg0) <{name = "x"}> : (i32) -> ()
    "test.tracked_value"(%arg1) <{name = "x"}> : (i32) -> ()
    "func.return"(%arg1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "tracker_load_stored_back"}> ({
  ^bb0(%arg0: i32):
    "test.tracked_value"(%arg0) <{name = "y"}> : (i32) -> ()
    "test.tracked_value"(%arg0) <{name = "y"}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i1) -> i32, sym_name = "tracker_blocks"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i1):
    "cf.cond_br"(%arg2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "test.tracked_value"(%arg0) <{name = "z"}> : (i32) -> ()
    "cf.br"(%arg0)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "test.tracked_value"(%arg1) <{name = "z"}> : (i32) -> ()
    "cf.br"(%arg1)[^bb3] : (i32) -> ()
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "tracker_at_end"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    "test.tracked_value"(%arg0) <{name = "k"}> : (i32) -> ()
    "test.tracked_value"(%arg1) <{name = "k"}> : (i32) -> ()
    "func.return"(%arg1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i1) -> (), sym_name = "tracker_nested_region"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i1):
    "test.tracked_value"(%arg0) <{name = "w"}> : (i32) -> ()
    %0 = "scf.if"(%arg2) ({
      "test.tracked_value"(%arg1) <{name = "w"}> : (i32) -> ()
      "scf.yield"(%arg1) : (i32) -> ()
    }, {
      "scf.yield"(%arg0) : (i32) -> ()
    }) : (i1) -> i32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32, i1) -> (), sym_name = "tracker_inside_nested_region"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1):
    "test.tracked_value"(%arg0) <{name = "n"}> : (i32) -> ()
    %0 = "scf.if"(%arg3) ({
      "test.tracked_value"(%arg1) <{name = "n"}> : (i32) -> ()
      "scf.yield"(%arg1) : (i32) -> ()
    }, {
      "scf.yield"(%arg0) : (i32) -> ()
    }) : (i1) -> i32
    "test.tracked_value"(%arg2) <{name = "n"}> : (i32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

