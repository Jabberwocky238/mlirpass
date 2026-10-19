#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (10)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "nested_loops_both_having_invariant_code"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %1 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg0: index):
      %3 = "arith.addf"(%1, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg1: index):
        %4 = "arith.addf"(%3, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "affine.store"(%3, %0, %arg0) <{map = #map}> : (f32, memref<10xf32>, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (10)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "nested_loops_code_invariant_to_both"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %1 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg0: index):
      "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
      ^bb0(%arg1: index):
        %3 = "arith.addf"(%1, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (10)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "single_loop_nothing_invariant"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg0: index):
      %2 = "affine.load"(%0, %arg0) <{map = #map}> : (memref<10xf32>, index) -> f32
      %3 = "affine.load"(%1, %arg0) <{map = #map}> : (memref<10xf32>, index) -> f32
      %4 = "arith.addf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "affine.store"(%4, %0, %arg0) <{map = #map}> : (f32, memref<10xf32>, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 + 1)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<() -> (0)>
#map3 = affine_map<() -> (10)>
#set = affine_set<(d0, d1) : (d1 - d0 >= 0)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "invariant_code_inside_affine_if"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %1 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    "affine.for"() <{lowerBoundMap = #map2, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map3}> ({
    ^bb0(%arg0: index):
      %2 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
      "affine.if"(%arg0, %2) <{condition = #set}> ({
        %3 = "arith.addf"(%1, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "affine.store"(%3, %0, %arg0) <{map = #map1}> : (f32, memref<10xf32>, index) -> ()
        "affine.yield"() : () -> ()
      }, {
      }) : (index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (20)>
#map2 = affine_map<() -> (10)>
#set = affine_set<(d0, d1) : (d1 - d0 >= 0)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "invariant_affine_if"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %1 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg0: index):
      "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
      ^bb0(%arg1: index):
        "affine.if"(%arg0, %arg0) <{condition = #set}> ({
          %2 = "arith.addf"(%1, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "affine.yield"() : () -> ()
        }, {
        }) : (index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0)>
#set = affine_set<() : (0 == 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "hoist_invariant_affine_if_success"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %2 = "affine.for"(%arg0, %arg1, %0) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 1, 1, 1>, step = 1 : index, upperBoundMap = #map}> ({
    ^bb0(%arg3: index, %arg4: i32):
      %3 = "affine.if"() <{condition = #set}> ({
        %6 = "arith.addi"(%1, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "affine.yield"(%6) : (i32) -> ()
      }, {
        %5 = "ub.poison"() <{value = #ub.poison}> : () -> i32
        "affine.yield"(%5) : (i32) -> ()
      }) : () -> i32
      %4 = "arith.addi"(%arg4, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "affine.yield"(%4) : (i32) -> ()
    }) : (index, index, i32) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0)>
#set = affine_set<(d0, d1) : (d1 - d0 >= 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "hoist_variant_affine_if_failure"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 7 : index}> : () -> index
    %3 = "affine.for"(%arg0, %arg1, %0) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 1, 1, 1>, step = 1 : index, upperBoundMap = #map}> ({
    ^bb0(%arg3: index, %arg4: i32):
      %4 = "affine.if"(%arg3, %2) <{condition = #set}> ({
        %7 = "arith.addi"(%1, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "affine.yield"(%7) : (i32) -> ()
      }, {
        %6 = "ub.poison"() <{value = #ub.poison}> : () -> i32
        "affine.yield"(%6) : (i32) -> ()
      }) : (index, index) -> i32
      %5 = "arith.addi"(%arg4, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "affine.yield"(%5) : (i32) -> ()
    }) : (index, index, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (10)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "hoist_affine_for_with_unknown_trip_count"}> ({
  ^bb0(%arg0: index, %arg1: index):
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg2: index):
      "affine.for"(%arg0, %arg1) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 1, 1, 0>, step = 1 : index, upperBoundMap = #map}> ({
      ^bb0(%arg3: index):
        "affine.yield"() : () -> ()
      }) : (index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (10)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "hoist_affine_for_with_unknown_trip_count_non_unit_step"}> ({
  ^bb0(%arg0: index, %arg1: index):
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg2: index):
      "affine.for"(%arg0, %arg1) <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 1, 1, 0>, step = 2 : index, upperBoundMap = #map}> ({
      ^bb0(%arg3: index):
        "affine.yield"() : () -> ()
      }) : (index, index) -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "hoist_scf_for_with_unknown_trip_count_unit_step"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%arg0, %arg1, %0) ({
    ^bb0(%arg2: index):
      "scf.for"(%arg0, %arg1, %0) ({
      ^bb0(%arg3: index):
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> (), sym_name = "hoist_scf_for_with_unknown_trip_count_non_unit_constant_step"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    "scf.for"(%arg0, %arg1, %0) ({
    ^bb0(%arg2: index):
      "scf.for"(%arg0, %arg1, %1) ({
      ^bb0(%arg3: index):
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "hoist_scf_for_with_unknown_trip_count_unknown_step"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%arg0, %arg1, %0) ({
    ^bb0(%arg3: index):
      "scf.for"(%arg0, %arg1, %arg2) ({
      ^bb0(%arg4: index):
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (10)>
#set = affine_set<(d0, d1) : (d1 - d0 >= 0)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "invariant_affine_if2"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %1 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg0: index):
      "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg1: index):
        "affine.if"(%arg0, %arg0) <{condition = #set}> ({
          %2 = "arith.addf"(%1, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "affine.store"(%2, %0, %arg1) <{map = #map}> : (f32, memref<10xf32>, index) -> ()
          "affine.yield"() : () -> ()
        }, {
        }) : (index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> (0)>
#map1 = affine_map<() -> (10)>
#set = affine_set<(d0, d1) : (d1 - d0 >= 0)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "invariant_affine_nested_if"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %1 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
    ^bb0(%arg0: index):
      "affine.for"() <{lowerBoundMap = #map, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map1}> ({
      ^bb0(%arg1: index):
        "affine.if"(%arg0, %arg0) <{condition = #set}> ({
          %2 = "arith.addf"(%1, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "affine.if"(%arg0, %arg0) <{condition = #set}> ({
            %3 = "arith.addf"(%2, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            "affine.yield"() : () -> ()
          }, {
          }) : (index, index) -> ()
          "affine.yield"() : () -> ()
        }, {
        }) : (index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (10)>
#set = affine_set<(d0, d1) : (d1 - d0 >= 0)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "invariant_affine_nested_if_else"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %1 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg0: index):
      "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg1: index):
        "affine.if"(%arg0, %arg0) <{condition = #set}> ({
          %2 = "arith.addf"(%1, %1) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "affine.store"(%2, %0, %arg0) <{map = #map}> : (f32, memref<10xf32>, index) -> ()
          "affine.if"(%arg0, %arg0) <{condition = #set}> ({
            %3 = "arith.addf"(%2, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            "affine.yield"() : () -> ()
          }, {
            "affine.store"(%2, %0, %arg1) <{map = #map}> : (f32, memref<10xf32>, index) -> ()
            "affine.yield"() : () -> ()
          }) : (index, index) -> ()
          "affine.yield"() : () -> ()
        }, {
        }) : (index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "invariant_loop_dialect"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 10 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    %4 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    "scf.for"(%0, %1, %2) ({
    ^bb0(%arg0: index):
      "scf.for"(%0, %1, %2) ({
      ^bb0(%arg1: index):
        %6 = "arith.addf"(%4, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "variant_loop_dialect"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 10 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<10xf32>
    "scf.for"(%0, %1, %2) ({
    ^bb0(%arg0: index):
      "scf.for"(%0, %1, %2) ({
      ^bb0(%arg1: index):
        %4 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_loop_with_invariant"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 10 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 7 : i32}> : () -> i32
    %4 = "arith.constant"() <{value = 8 : i32}> : () -> i32
    "scf.parallel"(%0, %0, %1, %1, %2, %2) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg0: index, %arg1: index):
      %5 = "arith.addi"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %6 = "arith.addi"(%arg0, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.reduce"() : () -> ()
    }) : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "hoist_invariant_scf_if_success"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = true}> : () -> i1
    %3 = "scf.for"(%arg0, %arg1, %arg2, %0) ({
    ^bb0(%arg3: index, %arg4: i32):
      %4 = "scf.if"(%2) ({
        %7 = "arith.addi"(%1, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "scf.yield"(%7) : (i32) -> ()
      }, {
        %6 = "ub.poison"() <{value = #ub.poison}> : () -> i32
        "scf.yield"(%6) : (i32) -> ()
      }) : (i1) -> i32
      %5 = "arith.addi"(%arg4, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%5) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> i32, sym_name = "hoist_variant_scf_if_failure"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "arith.constant"() <{value = 42 : i32}> : () -> i32
    %2 = "arith.constant"() <{value = 7 : index}> : () -> index
    %3 = "scf.for"(%arg0, %arg1, %arg2, %0) ({
    ^bb0(%arg3: index, %arg4: i32):
      %4 = "arith.cmpi"(%arg3, %2) <{predicate = 6 : i64}> : (index, index) -> i1
      %5 = "scf.if"(%4) ({
        %8 = "arith.addi"(%1, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "scf.yield"(%8) : (i32) -> ()
      }, {
        %7 = "ub.poison"() <{value = #ub.poison}> : () -> i32
        "scf.yield"(%7) : (i32) -> ()
      }) : (i1) -> i32
      %6 = "arith.addi"(%arg4, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%6) : (i32) -> ()
    }) : (index, index, index, i32) -> i32
    "func.return"(%3) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> index, sym_name = "make_val", sym_visibility = "private"}> ({
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "nested_uses_inside"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    "scf.for"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg3: index):
      %1 = "func.call"() <{callee = @make_val}> : () -> index
      %2 = "func.call"() <{callee = @make_val}> : () -> index
      %3 = "scf.if"(%0) ({
        "scf.yield"(%1) : (index) -> ()
      }, {
        "scf.yield"(%2) : (index) -> ()
      }) : (i1) -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, i32) -> (), sym_name = "invariant_subgraph"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: i32):
    "scf.for"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg4: index):
      %0 = "arith.addi"(%arg3, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %1 = "arith.addi"(%arg3, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "test.sink"(%1) : (i32) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "test_invariant_nested_loop"}> ({
    %0 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "test.graph_loop"() ({
      %1 = "arith.addi"(%0, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %2 = "arith.addi"(%1, %0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "test.graph_loop"() ({
      ^bb0(%arg0: i32):
        %3 = "arith.subi"(%arg0, %arg0) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "test.region_yield"(%3) : (i32) -> ()
      }) : () -> ()
      "test.region_yield"(%2) : (i32) -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "test_invariants_in_graph_region"}> ({
    "test.single_no_terminator_op"() ({
      "test.graph_loop"() ({
        %0 = "arith.addi"(%2, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %1 = "arith.addi"(%2, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %2 = "arith.constant"() <{value = 5 : i32}> : () -> i32
        "test.region_yield"(%0) : (i32) -> ()
      }) : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "test_invariant_backedge"}> ({
    "test.graph_loop"() ({
      %0 = "arith.addi"(%2, %1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %1 = "arith.addi"(%2, %2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %2 = "arith.constant"() <{value = 5 : i32}> : () -> i32
      "test.region_yield"(%0) : (i32) -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "test_invariant_cycle_not_hoisted"}> ({
    "test.graph_loop"() ({
      %0 = "test.a"(%1) : (i32) -> i32
      %1 = "test.b"(%0) : (i32) -> i32
      "test.region_yield"(%0) : (i32) -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "test_always_speculatable_op"}> ({
  ^bb0(%arg23: index, %arg24: index, %arg25: index):
    "scf.for"(%arg23, %arg24, %arg25) ({
    ^bb0(%arg26: index):
      %10 = "test.always_speculatable_op"() : () -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "test_never_speculatable_op"}> ({
  ^bb0(%arg19: index, %arg20: index, %arg21: index):
    "scf.for"(%arg19, %arg20, %arg21) ({
    ^bb0(%arg22: index):
      %9 = "test.never_speculatable_op"() : () -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index) -> (), sym_name = "test_conditionally_speculatable_op_success"}> ({
  ^bb0(%arg15: index, %arg16: index, %arg17: index):
    "scf.for"(%arg15, %arg16, %arg17) ({
    ^bb0(%arg18: index):
      %7 = "arith.constant"() <{value = 5 : i32}> : () -> i32
      %8 = "test.conditionally_speculatable_op"(%7) : (i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, i32) -> (), sym_name = "test_conditionally_speculatable_op_failure"}> ({
  ^bb0(%arg10: index, %arg11: index, %arg12: index, %arg13: i32):
    %4 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    %5 = "arith.addi"(%arg13, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
    "scf.for"(%arg10, %arg11, %arg12) ({
    ^bb0(%arg14: index):
      %6 = "test.conditionally_speculatable_op"(%5) : (i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, i32) -> (), sym_name = "test_recursively_speculatable_op_success"}> ({
  ^bb0(%arg5: index, %arg6: index, %arg7: index, %arg8: i32):
    "scf.for"(%arg5, %arg6, %arg7) ({
    ^bb0(%arg9: index):
      %2 = "test.recursively_speculatable_op"() ({
        %3 = "arith.addi"(%arg8, %arg8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "test.region_yield"(%3) : (i32) -> ()
      }) : () -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index, index, i32) -> (), sym_name = "test_recursively_speculatable_op_failure"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: i32):
    "scf.for"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg4: index):
      %0 = "test.recursively_speculatable_op"() ({
        %1 = "test.never_speculatable_op"() : () -> i32
        "test.region_yield"(%1) : (i32) -> ()
      }) : () -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, index, index, index, index) -> (), sym_name = "speculate_tensor_dim_unknown_rank_unknown_dim"}> ({
  ^bb0(%arg18: tensor<*xf32>, %arg19: index, %arg20: index, %arg21: index, %arg22: index):
    "scf.for"(%arg20, %arg21, %arg22) ({
    ^bb0(%arg23: index):
      %5 = "tensor.dim"(%arg18, %arg19) : (tensor<*xf32>, index) -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?x?x?x?xf32>, index, index, index, index) -> (), sym_name = "speculate_tensor_dim_known_rank_unknown_dim"}> ({
  ^bb0(%arg12: tensor<?x?x?x?xf32>, %arg13: index, %arg14: index, %arg15: index, %arg16: index):
    "scf.for"(%arg14, %arg15, %arg16) ({
    ^bb0(%arg17: index):
      %4 = "tensor.dim"(%arg12, %arg13) : (tensor<?x?x?x?xf32>, index) -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<*xf32>, index, index, index, index) -> (), sym_name = "speculate_tensor_dim_unknown_rank_known_dim"}> ({
  ^bb0(%arg6: tensor<*xf32>, %arg7: index, %arg8: index, %arg9: index, %arg10: index):
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    "scf.for"(%arg8, %arg9, %arg10) ({
    ^bb0(%arg11: index):
      %3 = "tensor.dim"(%arg6, %2) : (tensor<*xf32>, index) -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<?x?x?x?xf32>, index, index, index, index) -> (), sym_name = "speculate_tensor_dim_known_rank_known_dim_inbounds"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%arg2, %arg3, %arg4) ({
    ^bb0(%arg5: index):
      %1 = "tensor.dim"(%arg0, %0) : (tensor<?x?x?x?xf32>, index) -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>, index, index, index, index) -> (), sym_name = "speculate_memref_dim_unknown_rank_unknown_dim"}> ({
  ^bb0(%arg18: memref<*xf32>, %arg19: index, %arg20: index, %arg21: index, %arg22: index):
    "scf.for"(%arg20, %arg21, %arg22) ({
    ^bb0(%arg23: index):
      %5 = "memref.dim"(%arg18, %arg19) : (memref<*xf32>, index) -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?x?xf32>, index, index, index, index) -> (), sym_name = "speculate_memref_dim_known_rank_unknown_dim"}> ({
  ^bb0(%arg12: memref<?x?x?x?xf32>, %arg13: index, %arg14: index, %arg15: index, %arg16: index):
    "scf.for"(%arg14, %arg15, %arg16) ({
    ^bb0(%arg17: index):
      %4 = "memref.dim"(%arg12, %arg13) : (memref<?x?x?x?xf32>, index) -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<*xf32>, index, index, index, index) -> (), sym_name = "speculate_memref_dim_unknown_rank_known_dim"}> ({
  ^bb0(%arg6: memref<*xf32>, %arg7: index, %arg8: index, %arg9: index, %arg10: index):
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    "scf.for"(%arg8, %arg9, %arg10) ({
    ^bb0(%arg11: index):
      %3 = "memref.dim"(%arg6, %2) : (memref<*xf32>, index) -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?x?x?xf32>, index, index, index, index) -> (), sym_name = "speculate_memref_dim_known_rank_known_dim_inbounds"}> ({
  ^bb0(%arg0: memref<?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%arg2, %arg3, %arg4) ({
    ^bb0(%arg5: index):
      %1 = "memref.dim"(%arg0, %0) : (memref<?x?x?x?xf32>, index) -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "speculate_memref_dim_known_rank_known_dim_inbounds"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 22 : index}> : () -> index
    %3 = "memref.alloc"(%2) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xi1>
    "scf.for"(%0, %2, %1) ({
    ^bb0(%arg0: index):
      %4 = "memref.dim"(%3, %0) : (memref<?xi1>, index) -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "speculate_tensor_dim_known_rank_known_dim_inbounds"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 22 : index}> : () -> index
    %3 = "tensor.empty"(%2, %2) : (index, index) -> tensor<?x?xi1>
    "scf.for"(%0, %2, %1) ({
    ^bb0(%arg0: index):
      %4 = "tensor.dim"(%3, %1) : (tensor<?x?xi1>, index) -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "no_speculate_memref_dim_known_rank_known_dim_out_of_bounds"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 22 : index}> : () -> index
    %3 = "memref.alloc"(%2) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xi1>
    "scf.for"(%0, %2, %1) ({
    ^bb0(%arg0: index):
      %4 = "memref.dim"(%3, %1) : (memref<?xi1>, index) -> index
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "no_speculate_divui"}> ({
  ^bb0(%arg174: i32, %arg175: i32, %arg176: index, %arg177: index, %arg178: index):
    "scf.for"(%arg176, %arg177, %arg178) ({
    ^bb0(%arg179: index):
      %71 = "arith.divui"(%arg174, %arg175) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "no_speculate_udiv"}> ({
  ^bb0(%arg168: i32, %arg169: i32, %arg170: index, %arg171: index, %arg172: index):
    "scf.for"(%arg170, %arg171, %arg172) ({
    ^bb0(%arg173: index):
      %70 = "llvm.udiv"(%arg168, %arg169) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "no_speculate_divsi"}> ({
  ^bb0(%arg162: i32, %arg163: i32, %arg164: index, %arg165: index, %arg166: index):
    "scf.for"(%arg164, %arg165, %arg166) ({
    ^bb0(%arg167: index):
      %69 = "arith.divsi"(%arg162, %arg163) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "no_speculate_sdiv"}> ({
  ^bb0(%arg156: i32, %arg157: i32, %arg158: index, %arg159: index, %arg160: index):
    "scf.for"(%arg158, %arg159, %arg160) ({
    ^bb0(%arg161: index):
      %68 = "llvm.sdiv"(%arg156, %arg157) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "no_speculate_ceildivui"}> ({
  ^bb0(%arg150: i32, %arg151: i32, %arg152: index, %arg153: index, %arg154: index):
    "scf.for"(%arg152, %arg153, %arg154) ({
    ^bb0(%arg155: index):
      %67 = "arith.ceildivui"(%arg150, %arg151) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "no_speculate_ceildivsi"}> ({
  ^bb0(%arg144: i32, %arg145: i32, %arg146: index, %arg147: index, %arg148: index):
    "scf.for"(%arg146, %arg147, %arg148) ({
    ^bb0(%arg149: index):
      %66 = "arith.ceildivsi"(%arg144, %arg145) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, index, index, index) -> (), sym_name = "no_speculate_divui_const"}> ({
  ^bb0(%arg139: i32, %arg140: index, %arg141: index, %arg142: index):
    %64 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "scf.for"(%arg140, %arg141, %arg142) ({
    ^bb0(%arg143: index):
      %65 = "arith.divui"(%arg139, %64) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, index, index, index) -> (), sym_name = "no_speculate_udiv_const"}> ({
  ^bb0(%arg134: i32, %arg135: index, %arg136: index, %arg137: index):
    %62 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "scf.for"(%arg135, %arg136, %arg137) ({
    ^bb0(%arg138: index):
      %63 = "llvm.udiv"(%arg134, %62) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, index, index, index) -> (), sym_name = "speculate_divui_const"}> ({
  ^bb0(%arg129: i32, %arg130: index, %arg131: index, %arg132: index):
    %60 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "scf.for"(%arg130, %arg131, %arg132) ({
    ^bb0(%arg133: index):
      %61 = "arith.divui"(%arg129, %60) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, index, index, index) -> (), sym_name = "speculate_udiv_const"}> ({
  ^bb0(%arg124: i32, %arg125: index, %arg126: index, %arg127: index):
    %58 = "llvm.mlir.constant"() <{value = 5 : i32}> : () -> i32
    "scf.for"(%arg125, %arg126, %arg127) ({
    ^bb0(%arg128: index):
      %59 = "llvm.udiv"(%arg124, %58) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, index, index, index) -> (), sym_name = "no_speculate_ceildivui_const"}> ({
  ^bb0(%arg119: i32, %arg120: index, %arg121: index, %arg122: index):
    %56 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "scf.for"(%arg120, %arg121, %arg122) ({
    ^bb0(%arg123: index):
      %57 = "arith.ceildivui"(%arg119, %56) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, index, index, index) -> (), sym_name = "speculate_ceildivui_const"}> ({
  ^bb0(%arg114: i32, %arg115: index, %arg116: index, %arg117: index):
    %54 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "scf.for"(%arg115, %arg116, %arg117) ({
    ^bb0(%arg118: index):
      %55 = "arith.ceildivui"(%arg114, %54) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "no_speculate_divsi_const0"}> ({
  ^bb0(%arg108: i32, %arg109: i32, %arg110: index, %arg111: index, %arg112: index):
    %52 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "scf.for"(%arg110, %arg111, %arg112) ({
    ^bb0(%arg113: index):
      %53 = "arith.divsi"(%arg108, %52) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "no_speculate_sdiv_const0"}> ({
  ^bb0(%arg102: i32, %arg103: i32, %arg104: index, %arg105: index, %arg106: index):
    %50 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "scf.for"(%arg104, %arg105, %arg106) ({
    ^bb0(%arg107: index):
      %51 = "llvm.sdiv"(%arg102, %50) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "no_speculate_divsi_const_minus1"}> ({
  ^bb0(%arg96: i32, %arg97: i32, %arg98: index, %arg99: index, %arg100: index):
    %48 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    "scf.for"(%arg98, %arg99, %arg100) ({
    ^bb0(%arg101: index):
      %49 = "arith.divsi"(%arg96, %48) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "no_speculate_sdiv_const_minus1"}> ({
  ^bb0(%arg90: i32, %arg91: i32, %arg92: index, %arg93: index, %arg94: index):
    %46 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    "scf.for"(%arg92, %arg93, %arg94) ({
    ^bb0(%arg95: index):
      %47 = "llvm.sdiv"(%arg90, %46) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "speculate_divsi_const"}> ({
  ^bb0(%arg84: i32, %arg85: i32, %arg86: index, %arg87: index, %arg88: index):
    %44 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "scf.for"(%arg86, %arg87, %arg88) ({
    ^bb0(%arg89: index):
      %45 = "arith.divsi"(%arg84, %44) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "speculate_sdiv_const"}> ({
  ^bb0(%arg78: i32, %arg79: i32, %arg80: index, %arg81: index, %arg82: index):
    %42 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "scf.for"(%arg80, %arg81, %arg82) ({
    ^bb0(%arg83: index):
      %43 = "llvm.sdiv"(%arg78, %42) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "no_speculate_ceildivsi_const0"}> ({
  ^bb0(%arg72: i32, %arg73: i32, %arg74: index, %arg75: index, %arg76: index):
    %40 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    "scf.for"(%arg74, %arg75, %arg76) ({
    ^bb0(%arg77: index):
      %41 = "arith.ceildivsi"(%arg72, %40) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "no_speculate_ceildivsi_const_minus1"}> ({
  ^bb0(%arg66: i32, %arg67: i32, %arg68: index, %arg69: index, %arg70: index):
    %38 = "arith.constant"() <{value = -1 : i32}> : () -> i32
    "scf.for"(%arg68, %arg69, %arg70) ({
    ^bb0(%arg71: index):
      %39 = "arith.ceildivsi"(%arg66, %38) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32, i32, index, index, index) -> (), sym_name = "speculate_ceildivsi_const"}> ({
  ^bb0(%arg60: i32, %arg61: i32, %arg62: index, %arg63: index, %arg64: index):
    %36 = "arith.constant"() <{value = 5 : i32}> : () -> i32
    "scf.for"(%arg62, %arg63, %arg64) ({
    ^bb0(%arg65: index):
      %37 = "arith.ceildivsi"(%arg60, %36) : (i32, i32) -> i32
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, index, index, index) -> (), sym_name = "no_speculate_divui_range"}> ({
  ^bb0(%arg55: i8, %arg56: index, %arg57: index, %arg58: index):
    %34 = "test.with_bounds"() <{smax = 127 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    "scf.for"(%arg56, %arg57, %arg58) ({
    ^bb0(%arg59: index):
      %35 = "arith.divui"(%arg55, %34) : (i8, i8) -> i8
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, index, index, index) -> (), sym_name = "no_speculate_udiv_range"}> ({
  ^bb0(%arg50: i8, %arg51: index, %arg52: index, %arg53: index):
    %32 = "test.with_bounds"() <{smax = 127 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    "scf.for"(%arg51, %arg52, %arg53) ({
    ^bb0(%arg54: index):
      %33 = "llvm.udiv"(%arg50, %32) : (i8, i8) -> i8
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, index, index, index) -> (), sym_name = "no_speculate_divsi_range"}> ({
  ^bb0(%arg45: i8, %arg46: index, %arg47: index, %arg48: index):
    %28 = "test.with_bounds"() <{smax = -1 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    %29 = "test.with_bounds"() <{smax = 127 : i8, smin = 0 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    "scf.for"(%arg46, %arg47, %arg48) ({
    ^bb0(%arg49: index):
      %30 = "arith.divsi"(%arg45, %28) : (i8, i8) -> i8
      %31 = "arith.divsi"(%arg45, %29) : (i8, i8) -> i8
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, index, index, index) -> (), sym_name = "no_speculate_sdiv_range"}> ({
  ^bb0(%arg40: i8, %arg41: index, %arg42: index, %arg43: index):
    %24 = "test.with_bounds"() <{smax = -1 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    %25 = "test.with_bounds"() <{smax = 127 : i8, smin = 0 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    "scf.for"(%arg41, %arg42, %arg43) ({
    ^bb0(%arg44: index):
      %26 = "llvm.sdiv"(%arg40, %24) : (i8, i8) -> i8
      %27 = "llvm.sdiv"(%arg40, %25) : (i8, i8) -> i8
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, index, index, index) -> (), sym_name = "no_speculate_ceildivui_range"}> ({
  ^bb0(%arg35: i8, %arg36: index, %arg37: index, %arg38: index):
    %22 = "test.with_bounds"() <{smax = 127 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    "scf.for"(%arg36, %arg37, %arg38) ({
    ^bb0(%arg39: index):
      %23 = "arith.ceildivui"(%arg35, %22) : (i8, i8) -> i8
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, index, index, index) -> (), sym_name = "no_speculate_ceildivsi_range"}> ({
  ^bb0(%arg30: i8, %arg31: index, %arg32: index, %arg33: index):
    %18 = "test.with_bounds"() <{smax = -1 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    %19 = "test.with_bounds"() <{smax = 127 : i8, smin = 0 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    "scf.for"(%arg31, %arg32, %arg33) ({
    ^bb0(%arg34: index):
      %20 = "arith.ceildivsi"(%arg30, %18) : (i8, i8) -> i8
      %21 = "arith.ceildivsi"(%arg30, %19) : (i8, i8) -> i8
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, index, index, index) -> (), sym_name = "speculate_divui_range"}> ({
  ^bb0(%arg25: i8, %arg26: index, %arg27: index, %arg28: index):
    %16 = "test.with_bounds"() <{smax = 127 : i8, smin = -128 : i8, umax = -1 : i8, umin = 1 : i8}> : () -> i8
    "scf.for"(%arg26, %arg27, %arg28) ({
    ^bb0(%arg29: index):
      %17 = "arith.divui"(%arg25, %16) : (i8, i8) -> i8
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, index, index, index) -> (), sym_name = "speculate_udiv_range"}> ({
  ^bb0(%arg20: i8, %arg21: index, %arg22: index, %arg23: index):
    %14 = "test.with_bounds"() <{smax = 127 : i8, smin = -128 : i8, umax = -1 : i8, umin = 1 : i8}> : () -> i8
    "scf.for"(%arg21, %arg22, %arg23) ({
    ^bb0(%arg24: index):
      %15 = "llvm.udiv"(%arg20, %14) : (i8, i8) -> i8
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, index, index, index) -> (), sym_name = "speculate_divsi_range"}> ({
  ^bb0(%arg15: i8, %arg16: index, %arg17: index, %arg18: index):
    %10 = "test.with_bounds"() <{smax = 127 : i8, smin = 1 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    %11 = "test.with_bounds"() <{smax = -2 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    "scf.for"(%arg16, %arg17, %arg18) ({
    ^bb0(%arg19: index):
      %12 = "arith.divsi"(%arg15, %10) : (i8, i8) -> i8
      %13 = "arith.divsi"(%arg15, %11) : (i8, i8) -> i8
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, index, index, index) -> (), sym_name = "speculate_sdiv_range"}> ({
  ^bb0(%arg10: i8, %arg11: index, %arg12: index, %arg13: index):
    %6 = "test.with_bounds"() <{smax = 127 : i8, smin = 1 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    %7 = "test.with_bounds"() <{smax = -2 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    "scf.for"(%arg11, %arg12, %arg13) ({
    ^bb0(%arg14: index):
      %8 = "llvm.sdiv"(%arg10, %6) : (i8, i8) -> i8
      %9 = "llvm.sdiv"(%arg10, %7) : (i8, i8) -> i8
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, index, index, index) -> (), sym_name = "speculate_ceildivui_range"}> ({
  ^bb0(%arg5: i8, %arg6: index, %arg7: index, %arg8: index):
    %4 = "test.with_bounds"() <{smax = 127 : i8, smin = -128 : i8, umax = -1 : i8, umin = 1 : i8}> : () -> i8
    "scf.for"(%arg6, %arg7, %arg8) ({
    ^bb0(%arg9: index):
      %5 = "arith.ceildivui"(%arg5, %4) : (i8, i8) -> i8
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i8, index, index, index) -> (), sym_name = "speculate_ceildivsi_range"}> ({
  ^bb0(%arg0: i8, %arg1: index, %arg2: index, %arg3: index):
    %0 = "test.with_bounds"() <{smax = 127 : i8, smin = 1 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    %1 = "test.with_bounds"() <{smax = -2 : i8, smin = -128 : i8, umax = -1 : i8, umin = 0 : i8}> : () -> i8
    "scf.for"(%arg1, %arg2, %arg3) ({
    ^bb0(%arg4: index):
      %2 = "arith.ceildivsi"(%arg0, %0) : (i8, i8) -> i8
      %3 = "arith.ceildivsi"(%arg0, %1) : (i8, i8) -> i8
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128x256xf32>, tensor<4x16x32x16xf32>, index, index, index) -> (), sym_name = "speculate_static_pack_and_unpack"}> ({
  ^bb0(%arg0: tensor<128x256xf32>, %arg1: tensor<4x16x32x16xf32>, %arg2: index, %arg3: index, %arg4: index):
    "scf.for"(%arg2, %arg3, %arg4) ({
    ^bb0(%arg6: index):
      %1 = "linalg.pack"(%arg0, %arg1) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_inner_tiles = array<i64: 32, 16>}> : (tensor<128x256xf32>, tensor<4x16x32x16xf32>) -> tensor<4x16x32x16xf32>
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "scf.for"(%arg2, %arg3, %arg4) ({
    ^bb0(%arg5: index):
      %0 = "linalg.unpack"(%arg1, %arg0) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: 32, 16>}> : (tensor<4x16x32x16xf32>, tensor<128x256xf32>) -> tensor<128x256xf32>
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?x?x?xf32>, index, index, index, index, index, f32) -> (), sym_name = "speculate_dynamic_pack_and_unpack"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: f32):
    "scf.for"(%arg2, %arg3, %arg4) ({
    ^bb0(%arg10: index):
      %2 = "linalg.pack"(%arg0, %arg1, %arg6, %arg5) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 0, 2>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<?x?xf32>, tensor<?x?x?x?xf32>, index, index) -> tensor<?x?x?x?xf32>
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "scf.for"(%arg2, %arg3, %arg4) ({
    ^bb0(%arg9: index):
      %1 = "linalg.unpack"(%arg1, %arg0, %arg6, %arg5) <{inner_dims_pos = array<i64: 0, 1>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<?x?x?x?xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "scf.for"(%arg2, %arg3, %arg4) ({
    ^bb0(%arg8: index):
      %0 = "linalg.pack"(%arg0, %arg1, %arg7, %arg6, %arg5) <{inner_dims_pos = array<i64: 0, 1>, operandSegmentSizes = array<i32: 1, 1, 1, 2>, static_inner_tiles = array<i64: -9223372036854775808, -9223372036854775808>}> : (tensor<?x?xf32>, tensor<?x?x?x?xf32>, f32, index, index) -> tensor<?x?x?x?xf32>
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32) -> i32, sym_name = "hoist_from_scf_while"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "scf.while"(%arg1) ({
    ^bb0(%arg3: i32):
      %3 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %4 = "arith.constant"() <{value = 10 : i32}> : () -> i32
      %5 = "arith.addi"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %6 = "arith.cmpi"(%arg3, %5) <{predicate = 2 : i64}> : (i32, i32) -> i1
      "scf.condition"(%6, %arg3) : (i1, i32) -> ()
    }, {
    ^bb0(%arg2: i32):
      %1 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %2 = "arith.addi"(%1, %arg2) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "scf.yield"(%2) : (i32) -> ()
    }) : (i32) -> i32
    "func.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>, index, index, index, tensor<?x128xf32>) -> tensor<?x128xf32>, sym_name = "hoist_linalg_ops"}> ({
  ^bb0(%arg0: tensor<128x128xf32>, %arg1: tensor<128x128xf32>, %arg2: tensor<128x128xf32>, %arg3: index, %arg4: index, %arg5: index, %arg6: tensor<?x128xf32>):
    %0 = "scf.for"(%arg3, %arg4, %arg5, %arg6) ({
    ^bb0(%arg7: index, %arg8: tensor<?x128xf32>):
      %1 = "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
        %3 = "arith.mulf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        %4 = "arith.addf"(%3, %arg11) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "linalg.yield"(%arg11) : (f32) -> ()
      }) : (tensor<128x128xf32>, tensor<128x128xf32>, tensor<128x128xf32>) -> tensor<128x128xf32>
      %2 = "tensor.insert_slice"(%1, %arg6, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 128, 128>, static_strides = array<i64: 1, 1>}> : (tensor<128x128xf32>, tensor<?x128xf32>, index) -> tensor<?x128xf32>
      "scf.yield"(%2) : (tensor<?x128xf32>) -> ()
    }) : (index, index, index, tensor<?x128xf32>) -> tensor<?x128xf32>
    "func.return"(%0) : (tensor<?x128xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128x128xi32>, tensor<128x128xi32>, tensor<128x128xi32>, index, index, index, tensor<?x128xi32>) -> tensor<?x128xi32>, sym_name = "hoist_linalg_ops_div_by_zero"}> ({
  ^bb0(%arg0: tensor<128x128xi32>, %arg1: tensor<128x128xi32>, %arg2: tensor<128x128xi32>, %arg3: index, %arg4: index, %arg5: index, %arg6: tensor<?x128xi32>):
    %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %1 = "scf.for"(%arg3, %arg4, %arg5, %arg6) ({
    ^bb0(%arg7: index, %arg8: tensor<?x128xi32>):
      %2 = "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 2, 1>}> ({
      ^bb0(%arg9: i32, %arg10: i32, %arg11: i32):
        %4 = "arith.divui"(%arg9, %arg10) : (i32, i32) -> i32
        %5 = "arith.addi"(%4, %arg11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "linalg.yield"(%arg11) : (i32) -> ()
      }) : (tensor<128x128xi32>, tensor<128x128xi32>, tensor<128x128xi32>) -> tensor<128x128xi32>
      %3 = "tensor.insert_slice"(%2, %arg6, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 128, 128>, static_strides = array<i64: 1, 1>}> : (tensor<128x128xi32>, tensor<?x128xi32>, index) -> tensor<?x128xi32>
      "scf.yield"(%3) : (tensor<?x128xi32>) -> ()
    }) : (index, index, index, tensor<?x128xi32>) -> tensor<?x128xi32>
    "func.return"(%1) : (tensor<?x128xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128x128xf32>, index, index, index, index, index) -> vector<4x4xf32>, sym_name = "hoist_vector_transfer_ops"}> ({
  ^bb0(%arg0: tensor<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4x4xf32>}> : () -> vector<4x4xf32>
    %2 = "scf.for"(%arg1, %arg2, %arg3, %1) ({
    ^bb0(%arg6: index, %arg7: vector<4x4xf32>):
      %3 = "vector.transfer_read"(%arg0, %arg4, %arg5, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<128x128xf32>, index, index, f32) -> vector<4x4xf32>
      %4 = "arith.addf"(%3, %arg7) <{fastmath = #arith.fastmath<none>}> : (vector<4x4xf32>, vector<4x4xf32>) -> vector<4x4xf32>
      "scf.yield"(%4) : (vector<4x4xf32>) -> ()
    }) : (index, index, index, vector<4x4xf32>) -> vector<4x4xf32>
    "func.return"(%2) : (vector<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index) -> vector<4x4xf32>, sym_name = "hoist_vector_transfer_ops"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4x4xf32>}> : () -> vector<4x4xf32>
    %3 = "tensor.empty"() : () -> tensor<4x4xf32>
    %4 = "scf.for"(%arg0, %arg1, %arg2, %2) ({
    ^bb0(%arg5: index, %arg6: vector<4x4xf32>):
      %5 = "vector.transfer_write"(%2, %3, %0, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<4x4xf32>, tensor<4x4xf32>, index, index) -> tensor<4x4xf32>
      %6 = "vector.transfer_read"(%5, %0, %0, %1) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<4x4xf32>, index, index, f32) -> vector<4x4xf32>
      %7 = "arith.addf"(%6, %arg6) <{fastmath = #arith.fastmath<none>}> : (vector<4x4xf32>, vector<4x4xf32>) -> vector<4x4xf32>
      "scf.yield"(%7) : (vector<4x4xf32>) -> ()
    }) : (index, index, index, vector<4x4xf32>) -> vector<4x4xf32>
    "func.return"(%4) : (vector<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<128x128xf32>, index, index, index, index) -> vector<4x4xf32>, sym_name = "do_not_hoist_vector_transfer_ops_loop_dep"}> ({
  ^bb0(%arg0: tensor<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4x4xf32>}> : () -> vector<4x4xf32>
    %2 = "scf.for"(%arg1, %arg2, %arg3, %1) ({
    ^bb0(%arg5: index, %arg6: vector<4x4xf32>):
      %3 = "vector.transfer_read"(%arg0, %arg4, %arg5, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<128x128xf32>, index, index, f32) -> vector<4x4xf32>
      %4 = "arith.addf"(%3, %arg6) <{fastmath = #arith.fastmath<none>}> : (vector<4x4xf32>, vector<4x4xf32>) -> vector<4x4xf32>
      "scf.yield"(%4) : (vector<4x4xf32>) -> ()
    }) : (index, index, index, vector<4x4xf32>) -> vector<4x4xf32>
    "func.return"(%2) : (vector<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x128xf32>, index, index, index, index, index) -> vector<4x4xf32>, sym_name = "do_not_hoist_vector_transfer_ops_memref"}> ({
  ^bb0(%arg0: memref<128x128xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<4x4xf32>}> : () -> vector<4x4xf32>
    %2 = "scf.for"(%arg1, %arg2, %arg3, %1) ({
    ^bb0(%arg6: index, %arg7: vector<4x4xf32>):
      %3 = "vector.transfer_read"(%arg0, %arg4, %arg5, %0) <{in_bounds = [false, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<128x128xf32>, index, index, f32) -> vector<4x4xf32>
      %4 = "arith.addf"(%3, %arg7) <{fastmath = #arith.fastmath<none>}> : (vector<4x4xf32>, vector<4x4xf32>) -> vector<4x4xf32>
      "scf.yield"(%4) : (vector<4x4xf32>) -> ()
    }) : (index, index, index, vector<4x4xf32>) -> vector<4x4xf32>
    "func.return"(%2) : (vector<4x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

