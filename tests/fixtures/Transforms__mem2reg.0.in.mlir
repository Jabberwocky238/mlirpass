"builtin.module"() ({
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "multi_slot_alloca"}> ({
    %0:2 = "test.multi_slot_alloca"() : () -> (memref<i32>, memref<i32>)
    %1 = "memref.load"(%0#0) : (memref<i32>) -> i32
    %2 = "memref.load"(%0#1) : (memref<i32>) -> i32
    "func.return"(%1, %2) : (i32, i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<i32>) -> (), sym_name = "consumer", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = () -> (i32, i32), sym_name = "multi_slot_alloca_only_second"}> ({
    %0:2 = "test.multi_slot_alloca"() : () -> (memref<i32>, memref<i32>)
    "func.call"(%0#0) <{callee = @consumer}> : (memref<i32>) -> ()
    %1 = "memref.load"(%0#0) : (memref<i32>) -> i32
    %2 = "memref.load"(%0#1) : (memref<i32>) -> i32
    "func.return"(%1, %2) : (i32, i32) -> ()
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
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg1, %0) : (i32, memref<i32>) -> ()
    "cf.cond_br"(%arg0)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "memref.store"(%arg2, %0) : (i32, memref<i32>) -> ()
    "cf.br"(%arg1)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "cf.br"(%arg2)[^bb3] : (i32) -> ()
  ^bb3(%1: i32):  // 2 preds: ^bb1, ^bb2
    "cf.cond_br"(%arg0)[^bb4, ^bb5] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb4:  // pred: ^bb3
    "memref.store"(%1, %0) : (i32, memref<i32>) -> ()
    "cf.br"()[^bb6] : () -> ()
  ^bb5:  // pred: ^bb3
    %2 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "memref.store"(%2, %0) : (i32, memref<i32>) -> ()
    "cf.br"()[^bb6] : () -> ()
  ^bb6:  // 2 preds: ^bb4, ^bb5
    %3 = "memref.load"(%0) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
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
    %2 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb3
    "cf.cond_br"(%arg0)[^bb3, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    "memref.store"(%1, %2) : (i32, memref<i32>) -> ()
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
    "cf.br"()[^bb1] : () -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f64>
    %1 = "test.get"() : () -> i1
    "cf.cond_br"(%1)[^bb2, ^bb3] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %2 = "test.get"() : () -> i1
    "scf.if"(%2) ({
      "memref.store"(%arg0, %0) : (f64, memref<f64>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    %3 = "memref.load"(%0) : (memref<f64>) -> f64
    "test.use"(%3) : (f64) -> ()
    "cf.br"()[^bb1] : () -> ()
  ^bb3:  // pred: ^bb1
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i1) -> i32, sym_name = "promotable_through_alias"}> ({
  ^bb0(%arg0: i32, %arg1: i1):
    %0 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %1 = "test.multi_slot_alloca"() : () -> memref<i32>
    %2 = "test.transparent_alias"(%1) : (memref<i32>) -> memref<i32>
    "memref.store"(%0, %2) : (i32, memref<i32>) -> ()
    "cf.cond_br"(%arg1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "memref.store"(%arg0, %2) : (i32, memref<i32>) -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %3 = "memref.load"(%2) : (memref<i32>) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "promotable_through_cast_alias"}> ({
  ^bb0(%arg0: f32):
    %0 = "test.multi_slot_alloca"() : () -> memref<i32>
    %1 = "test.transparent_cast_alias"(%0) : (memref<i32>) -> memref<f32>
    "memref.store"(%arg0, %1) : (f32, memref<f32>) -> ()
    %2 = "memref.load"(%1) : (memref<f32>) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, i1) -> f32, sym_name = "promotable_through_cast_alias_blocks"}> ({
  ^bb0(%arg0: f32, %arg1: i1):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "test.multi_slot_alloca"() : () -> memref<i32>
    %2 = "test.transparent_cast_alias"(%1) : (memref<i32>) -> memref<f32>
    "memref.store"(%0, %2) : (f32, memref<f32>) -> ()
    "cf.cond_br"(%arg1)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "memref.store"(%arg0, %2) : (f32, memref<f32>) -> ()
    "cf.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %3 = "memref.load"(%2) : (memref<f32>) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, i32) -> (), sym_name = "promotable_through_alias_across_regions"}> ({
  ^bb0(%arg0: i1, %arg1: i32):
    %0 = "test.multi_slot_alloca"() : () -> memref<i32>
    %1 = "test.transparent_alias"(%0) : (memref<i32>) -> memref<i32>
    "scf.if"(%arg0) ({
      "memref.store"(%arg1, %1) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i1, f32, i32) -> i32, sym_name = "alias_inside_region_parent_read_outside"}> ({
  ^bb0(%arg0: i1, %arg1: f32, %arg2: i32):
    %0 = "test.multi_slot_alloca"() : () -> memref<i32>
    "memref.store"(%arg2, %0) : (i32, memref<i32>) -> ()
    "scf.if"(%arg0) ({
      %2 = "test.transparent_cast_alias"(%0) : (memref<i32>) -> memref<f32>
      "memref.store"(%arg1, %2) : (f32, memref<f32>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    %1 = "memref.load"(%0) : (memref<i32>) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "promotable_through_chained_aliases"}> ({
  ^bb0(%arg0: f32):
    %0 = "test.multi_slot_alloca"() : () -> memref<i32>
    %1 = "test.transparent_alias"(%0) : (memref<i32>) -> memref<i32>
    %2 = "test.transparent_cast_alias"(%1) : (memref<i32>) -> memref<f32>
    "memref.store"(%arg0, %2) : (f32, memref<f32>) -> ()
    %3 = "memref.load"(%2) : (memref<f32>) -> f32
    "func.return"(%3) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (si32) -> ui32, sym_name = "promotable_through_dual_alias"}> ({
  ^bb0(%arg0: si32):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    %1:2 = "test.transparent_dual_alias"(%0) : (memref<i32>) -> (memref<si32>, memref<ui32>)
    "memref.store"(%arg0, %1#0) : (si32, memref<si32>) -> ()
    %2 = "memref.load"(%1#1) : (memref<ui32>) -> ui32
    "func.return"(%2) : (ui32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> f32, sym_name = "promotable_through_partial_alias"}> ({
  ^bb0(%arg0: f32):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<complex<f32>>
    %1 = "test.partial_alias"(%0) : (memref<complex<f32>>) -> memref<f32>
    "memref.store"(%arg0, %1) : (f32, memref<f32>) -> ()
    %2 = "memref.load"(%1) : (memref<f32>) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "tracker_basic"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "test.multi_slot_alloca"() : () -> memref<i32>
    "test.slot_tracker"(%0) <{name = "x"}> : (memref<i32>) -> ()
    "memref.store"(%arg0, %0) : (i32, memref<i32>) -> ()
    "memref.store"(%arg1, %0) : (i32, memref<i32>) -> ()
    %1 = "memref.load"(%0) : (memref<i32>) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32) -> (), sym_name = "tracker_load_stored_back"}> ({
  ^bb0(%arg0: i32):
    %0 = "test.multi_slot_alloca"() : () -> memref<i32>
    "test.slot_tracker"(%0) <{name = "y"}> : (memref<i32>) -> ()
    "memref.store"(%arg0, %0) : (i32, memref<i32>) -> ()
    %1 = "memref.load"(%0) : (memref<i32>) -> i32
    "memref.store"(%1, %0) : (i32, memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i1) -> i32, sym_name = "tracker_blocks"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i1):
    %0 = "test.multi_slot_alloca"() : () -> memref<i32>
    "test.slot_tracker"(%0) <{name = "z"}> : (memref<i32>) -> ()
    "cf.cond_br"(%arg2)[^bb1, ^bb2] <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "memref.store"(%arg0, %0) : (i32, memref<i32>) -> ()
    "cf.br"()[^bb3] : () -> ()
  ^bb2:  // pred: ^bb0
    "memref.store"(%arg1, %0) : (i32, memref<i32>) -> ()
    "cf.br"()[^bb3] : () -> ()
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %1 = "memref.load"(%0) : (memref<i32>) -> i32
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "tracker_at_end"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "test.multi_slot_alloca"() : () -> memref<i32>
    "memref.store"(%arg0, %0) : (i32, memref<i32>) -> ()
    "memref.store"(%arg1, %0) : (i32, memref<i32>) -> ()
    %1 = "memref.load"(%0) : (memref<i32>) -> i32
    "test.slot_tracker"(%0) <{name = "k"}> : (memref<i32>) -> ()
    "func.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i1) -> (), sym_name = "tracker_nested_region"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i1):
    %0 = "test.multi_slot_alloca"() : () -> memref<i32>
    "test.slot_tracker"(%0) <{name = "w"}> : (memref<i32>) -> ()
    "memref.store"(%arg0, %0) : (i32, memref<i32>) -> ()
    "scf.if"(%arg2) ({
      "memref.store"(%arg1, %0) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, i32, i1) -> (), sym_name = "tracker_inside_nested_region"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1):
    %0 = "test.multi_slot_alloca"() : () -> memref<i32>
    "memref.store"(%arg0, %0) : (i32, memref<i32>) -> ()
    "scf.if"(%arg3) ({
      "test.slot_tracker"(%0) <{name = "n"}> : (memref<i32>) -> ()
      "memref.store"(%arg1, %0) : (i32, memref<i32>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "memref.store"(%arg2, %0) : (i32, memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

