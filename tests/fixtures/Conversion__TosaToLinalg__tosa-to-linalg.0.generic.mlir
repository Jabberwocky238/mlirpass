#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>) -> tensor<f32>, sym_name = "test_abs_scalar"}> ({
  ^bb0(%arg0: tensor<f32>):
    %0 = "tensor.empty"() : () -> tensor<f32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %2 = "math.absf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<f32>, tensor<f32>) -> tensor<f32>
    "func.return"(%1) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>) -> tensor<?xf32>, sym_name = "test_abs_1d_cast_static_to_dynamic"}> ({
  ^bb0(%arg0: tensor<5xf32>):
    %0 = "tensor.empty"() : () -> tensor<5xf32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %3 = "math.absf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (tensor<5xf32>, tensor<5xf32>) -> tensor<5xf32>
    %2 = "tensor.cast"(%1) : (tensor<5xf32>) -> tensor<?xf32>
    "func.return"(%2) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<5xf32>, sym_name = "test_abs_1d_cast_dynamic_to_static"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?xf32>, index) -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<?xf32>
    %3 = "linalg.generic"(%arg0, %2) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %5 = "math.absf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    %4 = "tensor.cast"(%3) : (tensor<?xf32>) -> tensor<5xf32>
    "func.return"(%4) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> tensor<?xf32>, sym_name = "test_abs_1d_dynamic"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?xf32>, index) -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<?xf32>
    %3 = "linalg.generic"(%arg0, %2) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %4 = "math.absf"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%4) : (f32) -> ()
    }) : (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%3) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<f32>, tensor<f32>) -> tensor<f32>, sym_name = "test_add_0d"}> ({
  ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>):
    %0 = "tensor.empty"() : () -> tensor<f32>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %2 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<f32>, tensor<f32>, tensor<f32>) -> tensor<f32>
    "func.return"(%1) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x1xf32>, tensor<1x1xf32>) -> tensor<2x1xf32>, sym_name = "test_add_2d_broadcast"}> ({
  ^bb0(%arg0: tensor<2x1xf32>, %arg1: tensor<1x1xf32>):
    %0 = "tensor.empty"() : () -> tensor<2x1xf32>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map1, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %2 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<2x1xf32>, tensor<1x1xf32>, tensor<2x1xf32>) -> tensor<2x1xf32>
    "func.return"(%1) : (tensor<2x1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (0)>
#map1 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>, sym_name = "test_add_1d_all_dynamic"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?xf32>, index) -> index
    %2 = "tensor.dim"(%arg1, %0) : (tensor<?xf32>, index) -> index
    %3 = "arith.maxui"(%1, %2) : (index, index) -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "tensor.dim"(%arg0, %0) : (tensor<?xf32>, index) -> index
    %6 = "arith.cmpi"(%5, %4) <{predicate = 0 : i64}> : (index, index) -> i1
    %7 = "scf.if"(%6) ({
      %16 = "tensor.empty"(%3) : (index) -> tensor<?xf32>
      %17 = "linalg.generic"(%arg0, %16) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg7: f32, %arg8: f32):
        "linalg.yield"(%arg7) : (f32) -> ()
      }) : (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%17) : (tensor<?xf32>) -> ()
    }, {
      "scf.yield"(%arg0) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %8 = "tensor.dim"(%arg1, %0) : (tensor<?xf32>, index) -> index
    %9 = "arith.cmpi"(%8, %4) <{predicate = 0 : i64}> : (index, index) -> i1
    %10 = "scf.if"(%9) ({
      %14 = "tensor.empty"(%3) : (index) -> tensor<?xf32>
      %15 = "linalg.generic"(%arg1, %14) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        "linalg.yield"(%arg5) : (f32) -> ()
      }) : (tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
      "scf.yield"(%15) : (tensor<?xf32>) -> ()
    }, {
      "scf.yield"(%arg1) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %11 = "tensor.empty"(%3) : (index) -> tensor<?xf32>
    %12 = "linalg.generic"(%7, %10, %11) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %13 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%13) : (f32) -> ()
    }) : (tensor<?xf32>, tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%12) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (0)>
#map1 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, tensor<?xf32>) -> tensor<5xf32>, sym_name = "test_add_1d_broadcast_dynamic_to_static"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.dim"(%arg1, %1) : (tensor<?xf32>, index) -> index
    %3 = "arith.cmpi"(%2, %0) <{predicate = 0 : i64}> : (index, index) -> i1
    %4 = "scf.if"(%3) ({
      %8 = "tensor.empty"() : () -> tensor<5xf32>
      %9 = "linalg.generic"(%arg1, %8) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        "linalg.yield"(%arg5) : (f32) -> ()
      }) : (tensor<?xf32>, tensor<5xf32>) -> tensor<5xf32>
      %10 = "tensor.cast"(%9) : (tensor<5xf32>) -> tensor<?xf32>
      "scf.yield"(%10) : (tensor<?xf32>) -> ()
    }, {
      "scf.yield"(%arg1) : (tensor<?xf32>) -> ()
    }) : (i1) -> tensor<?xf32>
    %5 = "tensor.empty"() : () -> tensor<5xf32>
    %6 = "linalg.generic"(%arg0, %4, %5) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %7 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<5xf32>, tensor<?xf32>, tensor<5xf32>) -> tensor<5xf32>
    "func.return"(%6) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (0)>
#map1 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>, tensor<?xf32>) -> tensor<?xf32>, sym_name = "test_add_1d_broadcast_static_to_dynamic"}> ({
  ^bb0(%arg0: tensor<1xf32>, %arg1: tensor<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg1, %0) : (tensor<?xf32>, index) -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<?xf32>
    %3 = "linalg.generic"(%arg0, %arg1, %2) <{indexing_maps = [#map, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %4 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%4) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<?xf32>, tensor<?xf32>) -> tensor<?xf32>
    "func.return"(%3) : (tensor<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (0)>
#map1 = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>, tensor<3xf32>) -> tensor<3xf32>, sym_name = "test_add_1d_broadcast_static_to_static"}> ({
  ^bb0(%arg0: tensor<1xf32>, %arg1: tensor<3xf32>):
    %0 = "tensor.empty"() : () -> tensor<3xf32>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %2 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<3xf32>, tensor<3xf32>) -> tensor<3xf32>
    "func.return"(%1) : (tensor<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>, sym_name = "test_add_1d_matching_no_broadcast"}> ({
  ^bb0(%arg0: tensor<1xf32>, %arg1: tensor<1xf32>):
    %0 = "tensor.empty"() : () -> tensor<1xf32>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %2 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    "func.return"(%1) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3xf32>, tensor<3xf32>) -> tensor<3xf32>, sym_name = "test_add_1d_matching_static"}> ({
  ^bb0(%arg0: tensor<3xf32>, %arg1: tensor<3xf32>):
    %0 = "tensor.empty"() : () -> tensor<3xf32>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %2 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<3xf32>, tensor<3xf32>, tensor<3xf32>) -> tensor<3xf32>
    "func.return"(%1) : (tensor<3xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (0, d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1) -> (d0, 0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "test_add_2d_all_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x?xf32>, index) -> index
    %2 = "tensor.dim"(%arg1, %0) : (tensor<?x?xf32>, index) -> index
    %3 = "arith.maxui"(%1, %2) : (index, index) -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "tensor.dim"(%arg0, %4) : (tensor<?x?xf32>, index) -> index
    %6 = "tensor.dim"(%arg1, %4) : (tensor<?x?xf32>, index) -> index
    %7 = "arith.maxui"(%5, %6) : (index, index) -> index
    %8 = "tensor.dim"(%arg0, %0) : (tensor<?x?xf32>, index) -> index
    %9 = "arith.cmpi"(%8, %4) <{predicate = 0 : i64}> : (index, index) -> i1
    %10 = "scf.if"(%9) ({
      %35 = "arith.constant"() <{value = 1 : index}> : () -> index
      %36 = "tensor.dim"(%arg0, %35) : (tensor<?x?xf32>, index) -> index
      %37 = "tensor.empty"(%3, %36) : (index, index) -> tensor<?x?xf32>
      %38 = "linalg.generic"(%arg0, %37) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg11: f32, %arg12: f32):
        "linalg.yield"(%arg11) : (f32) -> ()
      }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
      "scf.yield"(%38) : (tensor<?x?xf32>) -> ()
    }, {
      "scf.yield"(%arg0) : (tensor<?x?xf32>) -> ()
    }) : (i1) -> tensor<?x?xf32>
    %11 = "tensor.dim"(%10, %4) : (tensor<?x?xf32>, index) -> index
    %12 = "arith.cmpi"(%11, %4) <{predicate = 0 : i64}> : (index, index) -> i1
    %13 = "scf.if"(%12) ({
      %31 = "arith.constant"() <{value = 0 : index}> : () -> index
      %32 = "tensor.dim"(%10, %31) : (tensor<?x?xf32>, index) -> index
      %33 = "tensor.empty"(%32, %7) : (index, index) -> tensor<?x?xf32>
      %34 = "linalg.generic"(%10, %33) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg9: f32, %arg10: f32):
        "linalg.yield"(%arg9) : (f32) -> ()
      }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
      "scf.yield"(%34) : (tensor<?x?xf32>) -> ()
    }, {
      "scf.yield"(%10) : (tensor<?x?xf32>) -> ()
    }) : (i1) -> tensor<?x?xf32>
    %14 = "tensor.dim"(%arg1, %0) : (tensor<?x?xf32>, index) -> index
    %15 = "arith.cmpi"(%14, %4) <{predicate = 0 : i64}> : (index, index) -> i1
    %16 = "scf.if"(%15) ({
      %27 = "arith.constant"() <{value = 1 : index}> : () -> index
      %28 = "tensor.dim"(%arg1, %27) : (tensor<?x?xf32>, index) -> index
      %29 = "tensor.empty"(%3, %28) : (index, index) -> tensor<?x?xf32>
      %30 = "linalg.generic"(%arg1, %29) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg7: f32, %arg8: f32):
        "linalg.yield"(%arg7) : (f32) -> ()
      }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
      "scf.yield"(%30) : (tensor<?x?xf32>) -> ()
    }, {
      "scf.yield"(%arg1) : (tensor<?x?xf32>) -> ()
    }) : (i1) -> tensor<?x?xf32>
    %17 = "tensor.dim"(%16, %4) : (tensor<?x?xf32>, index) -> index
    %18 = "arith.cmpi"(%17, %4) <{predicate = 0 : i64}> : (index, index) -> i1
    %19 = "scf.if"(%18) ({
      %23 = "arith.constant"() <{value = 0 : index}> : () -> index
      %24 = "tensor.dim"(%16, %23) : (tensor<?x?xf32>, index) -> index
      %25 = "tensor.empty"(%24, %7) : (index, index) -> tensor<?x?xf32>
      %26 = "linalg.generic"(%16, %25) <{indexing_maps = [#map2, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg5: f32, %arg6: f32):
        "linalg.yield"(%arg5) : (f32) -> ()
      }) : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
      "scf.yield"(%26) : (tensor<?x?xf32>) -> ()
    }, {
      "scf.yield"(%16) : (tensor<?x?xf32>) -> ()
    }) : (i1) -> tensor<?x?xf32>
    %20 = "tensor.empty"(%3, %7) : (index, index) -> tensor<?x?xf32>
    %21 = "linalg.generic"(%13, %19, %20) <{indexing_maps = [#map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %22 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%21) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, 0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x?xi1>, tensor<2x?xf32>, tensor<2x?xf32>) -> tensor<2x?xf32>, sym_name = "test_select_2d_one_dynamic"}> ({
  ^bb0(%arg0: tensor<2x?xi1>, %arg1: tensor<2x?xf32>, %arg2: tensor<2x?xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<2x?xi1>, index) -> index
    %2 = "tensor.dim"(%arg1, %0) : (tensor<2x?xf32>, index) -> index
    %3 = "arith.maxui"(%1, %2) : (index, index) -> index
    %4 = "tensor.dim"(%arg2, %0) : (tensor<2x?xf32>, index) -> index
    %5 = "arith.maxui"(%3, %4) : (index, index) -> index
    %6 = "tensor.dim"(%arg0, %0) : (tensor<2x?xi1>, index) -> index
    %7 = "arith.cmpi"(%6, %0) <{predicate = 0 : i64}> : (index, index) -> i1
    %8 = "scf.if"(%7) ({
      %22 = "tensor.empty"(%5) : (index) -> tensor<2x?xi1>
      %23 = "linalg.generic"(%arg0, %22) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg11: i1, %arg12: i1):
        "linalg.yield"(%arg11) : (i1) -> ()
      }) : (tensor<2x?xi1>, tensor<2x?xi1>) -> tensor<2x?xi1>
      "scf.yield"(%23) : (tensor<2x?xi1>) -> ()
    }, {
      "scf.yield"(%arg0) : (tensor<2x?xi1>) -> ()
    }) : (i1) -> tensor<2x?xi1>
    %9 = "tensor.dim"(%arg1, %0) : (tensor<2x?xf32>, index) -> index
    %10 = "arith.cmpi"(%9, %0) <{predicate = 0 : i64}> : (index, index) -> i1
    %11 = "scf.if"(%10) ({
      %20 = "tensor.empty"(%5) : (index) -> tensor<2x?xf32>
      %21 = "linalg.generic"(%arg1, %20) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg9: f32, %arg10: f32):
        "linalg.yield"(%arg9) : (f32) -> ()
      }) : (tensor<2x?xf32>, tensor<2x?xf32>) -> tensor<2x?xf32>
      "scf.yield"(%21) : (tensor<2x?xf32>) -> ()
    }, {
      "scf.yield"(%arg1) : (tensor<2x?xf32>) -> ()
    }) : (i1) -> tensor<2x?xf32>
    %12 = "tensor.dim"(%arg2, %0) : (tensor<2x?xf32>, index) -> index
    %13 = "arith.cmpi"(%12, %0) <{predicate = 0 : i64}> : (index, index) -> i1
    %14 = "scf.if"(%13) ({
      %18 = "tensor.empty"(%5) : (index) -> tensor<2x?xf32>
      %19 = "linalg.generic"(%arg2, %18) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
      ^bb0(%arg7: f32, %arg8: f32):
        "linalg.yield"(%arg7) : (f32) -> ()
      }) : (tensor<2x?xf32>, tensor<2x?xf32>) -> tensor<2x?xf32>
      "scf.yield"(%19) : (tensor<2x?xf32>) -> ()
    }, {
      "scf.yield"(%arg2) : (tensor<2x?xf32>) -> ()
    }) : (i1) -> tensor<2x?xf32>
    %15 = "tensor.empty"(%5) : (index) -> tensor<2x?xf32>
    %16 = "linalg.generic"(%8, %11, %14, %15) <{indexing_maps = [#map1, #map1, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg3: i1, %arg4: f32, %arg5: f32, %arg6: f32):
      %17 = "arith.select"(%arg3, %arg4, %arg5) : (i1, f32, f32) -> f32
      "linalg.yield"(%17) : (f32) -> ()
    }) : (tensor<2x?xi1>, tensor<2x?xf32>, tensor<2x?xf32>, tensor<2x?xf32>) -> tensor<2x?xf32>
    "func.return"(%16) : (tensor<2x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>) -> (), sym_name = "test_simple_f32"}> ({
  ^bb0(%arg0: tensor<1xf32>):
    %0 = "tensor.empty"() : () -> tensor<1xf32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg64: f32, %arg65: f32):
      %99 = "math.tanh"(%arg64) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%99) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %2 = "tensor.empty"() : () -> tensor<1xf32>
    %3 = "linalg.generic"(%arg0, %2) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg62: f32, %arg63: f32):
      %98 = "math.absf"(%arg62) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%98) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %4 = "tensor.empty"() : () -> tensor<1xf32>
    %5 = "linalg.generic"(%1, %1, %4) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg59: f32, %arg60: f32, %arg61: f32):
      %97 = "arith.addf"(%arg59, %arg60) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%97) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %6 = "tensor.empty"() : () -> tensor<1xf32>
    %7 = "linalg.generic"(%1, %3, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg56: f32, %arg57: f32, %arg58: f32):
      %96 = "arith.subf"(%arg56, %arg57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%96) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %8 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %9 = "tensor.empty"() : () -> tensor<1xf32>
    %10 = "linalg.generic"(%1, %3, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg53: f32, %arg54: f32, %arg55: f32):
      %95 = "arith.mulf"(%arg53, %arg54) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%95) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %11 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %12 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %13 = "tensor.empty"() : () -> tensor<1xf32>
    %14 = "linalg.generic"(%1, %13) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg51: f32, %arg52: f32):
      %94 = "arith.negf"(%arg51) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%94) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %15 = "tensor.empty"() : () -> tensor<1xf32>
    %16 = "linalg.generic"(%3, %5, %15) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg48: f32, %arg49: f32, %arg50: f32):
      %93 = "math.powf"(%arg48, %arg49) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%93) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %17 = "tensor.empty"() : () -> tensor<1xf32>
    %18 = "linalg.generic"(%3, %17) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg46: f32, %arg47: f32):
      %92 = "math.rsqrt"(%arg46) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%92) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %19 = "tensor.empty"() : () -> tensor<1xf32>
    %20 = "linalg.generic"(%arg0, %19) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg44: f32, %arg45: f32):
      %91 = "math.log"(%arg44) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%91) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %21 = "tensor.empty"() : () -> tensor<1xf32>
    %22 = "linalg.generic"(%arg0, %21) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg42: f32, %arg43: f32):
      %90 = "math.exp"(%arg42) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%90) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %23 = "tensor.empty"() : () -> tensor<1xi1>
    %24 = "linalg.generic"(%1, %3, %23) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg39: f32, %arg40: f32, %arg41: i1):
      %89 = "arith.cmpf"(%arg39, %arg40) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%89) : (i1) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xi1>) -> tensor<1xi1>
    %25 = "tensor.empty"() : () -> tensor<1xi1>
    %26 = "linalg.generic"(%1, %3, %25) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg36: f32, %arg37: f32, %arg38: i1):
      %88 = "arith.cmpf"(%arg36, %arg37) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%88) : (i1) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xi1>) -> tensor<1xi1>
    %27 = "tensor.empty"() : () -> tensor<1xi1>
    %28 = "linalg.generic"(%1, %3, %27) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg33: f32, %arg34: f32, %arg35: i1):
      %87 = "arith.cmpf"(%arg33, %arg34) <{fastmath = #arith.fastmath<none>, predicate = 1 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%87) : (i1) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xi1>) -> tensor<1xi1>
    %29 = "tensor.empty"() : () -> tensor<1xf32>
    %30 = "linalg.generic"(%24, %1, %3, %29) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg29: i1, %arg30: f32, %arg31: f32, %arg32: f32):
      %86 = "arith.select"(%arg29, %arg30, %arg31) : (i1, f32, f32) -> f32
      "linalg.yield"(%86) : (f32) -> ()
    }) : (tensor<1xi1>, tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %31 = "tensor.empty"() : () -> tensor<1xf32>
    %32 = "linalg.generic"(%1, %3, %31) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg26: f32, %arg27: f32, %arg28: f32):
      %85 = "arith.maximumf"(%arg26, %arg27) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%85) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %33 = "tensor.empty"() : () -> tensor<1xf32>
    %34 = "linalg.generic"(%1, %3, %33) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg23: f32, %arg24: f32, %arg25: f32):
      %84 = "arith.minimumf"(%arg23, %arg24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%84) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %35 = "tensor.empty"() : () -> tensor<1xf32>
    %36 = "linalg.generic"(%1, %35) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: f32, %arg22: f32):
      %83 = "math.ceil"(%arg21) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%83) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %37 = "tensor.empty"() : () -> tensor<1xf32>
    %38 = "linalg.generic"(%1, %37) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      %82 = "math.floor"(%arg19) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%82) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %39 = "tensor.empty"() : () -> tensor<1xf32>
    %40 = "linalg.generic"(%1, %39) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      %78 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %79 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
      %80 = "arith.minimumf"(%arg17, %79) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %81 = "arith.maximumf"(%80, %78) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%81) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %41 = "tensor.empty"() : () -> tensor<1xf32>
    %42 = "linalg.generic"(%1, %41) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      %73 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %74 = "arith.negf"(%arg15) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %75 = "math.exp"(%74) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %76 = "arith.addf"(%75, %73) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %77 = "arith.divf"(%73, %76) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%77) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %43 = "tensor.empty"() : () -> tensor<1xi32>
    %44 = "linalg.generic"(%1, %43) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: f32, %arg14: i32):
      %65 = "math.roundeven"(%arg13) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %66 = "arith.constant"() <{value = -2.14748365E+9 : f32}> : () -> f32
      %67 = "arith.constant"() <{value = 2.14748365E+9 : f32}> : () -> f32
      %68 = "arith.constant"() <{value = 2147483647 : i32}> : () -> i32
      %69 = "arith.maximumf"(%65, %66) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %70 = "arith.fptosi"(%69) : (f32) -> i32
      %71 = "arith.cmpf"(%65, %67) <{fastmath = #arith.fastmath<none>, predicate = 10 : i64}> : (f32, f32) -> i1
      %72 = "arith.select"(%71, %68, %70) : (i1, i32, i32) -> i32
      "linalg.yield"(%72) : (i32) -> ()
    }) : (tensor<1xf32>, tensor<1xi32>) -> tensor<1xi32>
    %45 = "tensor.empty"() : () -> tensor<1xi1>
    %46 = "linalg.generic"(%1, %45) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: i1):
      %63 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %64 = "arith.cmpf"(%arg11, %63) <{fastmath = #arith.fastmath<none>, predicate = 13 : i64}> : (f32, f32) -> i1
      "linalg.yield"(%64) : (i1) -> ()
    }) : (tensor<1xf32>, tensor<1xi1>) -> tensor<1xi1>
    %47 = "tensor.empty"() : () -> tensor<1xf16>
    %48 = "linalg.generic"(%1, %47) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: f32, %arg10: f16):
      %62 = "arith.truncf"(%arg9) : (f32) -> f16
      "linalg.yield"(%62) : (f16) -> ()
    }) : (tensor<1xf32>, tensor<1xf16>) -> tensor<1xf16>
    %49 = "tensor.empty"() : () -> tensor<1xf32>
    %50 = "linalg.generic"(%1, %49) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      %60 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %61 = "arith.divf"(%60, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%61) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %51 = "tensor.empty"() : () -> tensor<1xf32>
    %52 = "linalg.generic"(%1, %51) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      %59 = "math.erf"(%arg5) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%59) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %53 = "tensor.empty"() : () -> tensor<1xf32>
    %54 = "linalg.generic"(%arg0, %53) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      %58 = "math.sin"(%arg3) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%58) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    %55 = "tensor.empty"() : () -> tensor<1xf32>
    %56 = "linalg.generic"(%arg0, %55) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %57 = "math.cos"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      "linalg.yield"(%57) : (f32) -> ()
    }) : (tensor<1xf32>, tensor<1xf32>) -> tensor<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf16>) -> (), sym_name = "test_simple_f16"}> ({
  ^bb0(%arg0: tensor<1xf16>):
    %0 = "tensor.empty"() : () -> tensor<1xf32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f16, %arg6: f32):
      %22 = "arith.extf"(%arg5) : (f16) -> f32
      "linalg.yield"(%22) : (f32) -> ()
    }) : (tensor<1xf16>, tensor<1xf32>) -> tensor<1xf32>
    %2 = "tensor.empty"() : () -> tensor<1xi8>
    %3 = "linalg.generic"(%arg0, %2) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f16, %arg4: i8):
      %16 = "math.roundeven"(%arg3) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %17 = "arith.constant"() <{value = -1.280000e+02 : f16}> : () -> f16
      %18 = "arith.constant"() <{value = 1.270000e+02 : f16}> : () -> f16
      %19 = "arith.minimumf"(%16, %18) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
      %20 = "arith.maximumf"(%19, %17) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
      %21 = "arith.fptosi"(%20) : (f16) -> i8
      "linalg.yield"(%21) : (i8) -> ()
    }) : (tensor<1xf16>, tensor<1xi8>) -> tensor<1xi8>
    %4 = "tensor.empty"() : () -> tensor<1xi32>
    %5 = "linalg.generic"(%arg0, %4) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f16, %arg2: i32):
      %6 = "math.roundeven"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      %7 = "arith.fptosi"(%6) : (f16) -> i32
      %8 = "arith.constant"() <{value = 0x7C00 : f16}> : () -> f16
      %9 = "arith.constant"() <{value = 0xFC00 : f16}> : () -> f16
      %10 = "arith.cmpf"(%6, %8) <{fastmath = #arith.fastmath<none>, predicate = 8 : i64}> : (f16, f16) -> i1
      %11 = "arith.cmpf"(%6, %9) <{fastmath = #arith.fastmath<none>, predicate = 8 : i64}> : (f16, f16) -> i1
      %12 = "arith.constant"() <{value = -2147483648 : i32}> : () -> i32
      %13 = "arith.constant"() <{value = 2147483647 : i32}> : () -> i32
      %14 = "arith.select"(%10, %13, %7) : (i1, i32, i32) -> i32
      %15 = "arith.select"(%11, %12, %14) : (i1, i32, i32) -> i32
      "linalg.yield"(%15) : (i32) -> ()
    }) : (tensor<1xf16>, tensor<1xi32>) -> tensor<1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi16>) -> (), sym_name = "test_simple_i16"}> ({
  ^bb0(%arg0: tensor<1xi16>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tensor.empty"() : () -> tensor<1xi32>
    %2 = "linalg.generic"(%arg0, %arg0, %1) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg1: i16, %arg2: i16, %arg3: i32):
      %3 = "arith.extsi"(%arg1) : (i16) -> i32
      %4 = "arith.extsi"(%arg2) : (i16) -> i32
      %5 = "arith.muli"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%5) : (i32) -> ()
    }) : (tensor<1xi16>, tensor<1xi16>, tensor<1xi32>) -> tensor<1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xui8>) -> (), sym_name = "test_simple_ui8"}> ({
  ^bb0(%arg0: tensor<1xui8>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (tensor<1xui8>) -> tensor<1xi8>
    %1 = "tensor.empty"() : () -> tensor<1xf32>
    %2 = "linalg.generic"(%0, %1) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: f32):
      %3 = "builtin.unrealized_conversion_cast"(%arg1) : (i8) -> i8
      %4 = "arith.uitofp"(%3) : (i8) -> f32
      "linalg.yield"(%4) : (f32) -> ()
    }) : (tensor<1xi8>, tensor<1xf32>) -> tensor<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi32>, tensor<1xui32>, tensor<1xui64>) -> (), sym_name = "test_simple_i32"}> ({
  ^bb0(%arg0: tensor<1xi32>, %arg1: tensor<1xui32>, %arg2: tensor<1xui64>):
    %0 = "builtin.unrealized_conversion_cast"(%arg1) : (tensor<1xui32>) -> tensor<1xi32>
    %1 = "tensor.empty"() : () -> tensor<1xi32>
    %2 = "linalg.generic"(%arg0, %arg0, %1) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg70: i32, %arg71: i32, %arg72: i32):
      %111 = "arith.addi"(%arg70, %arg71) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%111) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %3 = "tensor.empty"() : () -> tensor<1xi32>
    %4 = "linalg.generic"(%arg0, %arg0, %3) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg67: i32, %arg68: i32, %arg69: i32):
      %110 = "arith.subi"(%arg67, %arg68) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%110) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %6 = "tensor.empty"() : () -> tensor<1xi32>
    %7 = "linalg.generic"(%arg0, %arg0, %6) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg64: i32, %arg65: i32, %arg66: i32):
      %109 = "arith.muli"(%arg64, %arg65) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%109) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %8 = "tosa.const"() <{values = dense<2> : tensor<1xi8>}> : () -> tensor<1xi8>
    %9 = "tensor.empty"() : () -> tensor<1xi32>
    %10 = "linalg.generic"(%arg0, %arg0, %9) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg61: i32, %arg62: i32, %arg63: i32):
      %107 = "arith.constant"() <{value = 2 : i8}> : () -> i8
      %108 = "tosa.apply_scale"(%arg61, %arg62, %107) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      "linalg.yield"(%108) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %11 = "tensor.empty"() : () -> tensor<1xi32>
    %12 = "linalg.generic"(%arg0, %arg0, %11) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg58: i32, %arg59: i32, %arg60: i32):
      %106 = "arith.divsi"(%arg58, %arg59) : (i32, i32) -> i32
      "linalg.yield"(%106) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %13 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %14 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %15 = "tensor.empty"() : () -> tensor<1xi32>
    %16 = "linalg.generic"(%arg0, %15) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg56: i32, %arg57: i32):
      %98 = "arith.constant"() <{value = 0 : i64}> : () -> i64
      %99 = "arith.extsi"(%arg56) : (i32) -> i64
      %100 = "arith.subi"(%98, %99) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %101 = "arith.constant"() <{value = -2147483648 : i64}> : () -> i64
      %102 = "arith.constant"() <{value = 2147483647 : i64}> : () -> i64
      %103 = "arith.maxsi"(%101, %100) : (i64, i64) -> i64
      %104 = "arith.minsi"(%102, %103) : (i64, i64) -> i64
      %105 = "arith.trunci"(%104) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      "linalg.yield"(%105) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %17 = "tensor.empty"() : () -> tensor<1xi32>
    %18 = "linalg.generic"(%arg0, %arg0, %17) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg53: i32, %arg54: i32, %arg55: i32):
      %97 = "arith.andi"(%arg53, %arg54) : (i32, i32) -> i32
      "linalg.yield"(%97) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %19 = "tensor.empty"() : () -> tensor<1xi32>
    %20 = "linalg.generic"(%arg0, %arg0, %19) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg50: i32, %arg51: i32, %arg52: i32):
      %96 = "arith.ori"(%arg50, %arg51) : (i32, i32) -> i32
      "linalg.yield"(%96) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %21 = "tensor.empty"() : () -> tensor<1xi32>
    %22 = "linalg.generic"(%arg0, %arg0, %21) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg47: i32, %arg48: i32, %arg49: i32):
      %95 = "arith.xori"(%arg47, %arg48) : (i32, i32) -> i32
      "linalg.yield"(%95) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %23 = "tensor.empty"() : () -> tensor<1xi32>
    %24 = "linalg.generic"(%arg0, %arg0, %23) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg44: i32, %arg45: i32, %arg46: i32):
      %94 = "arith.shli"(%arg44, %arg45) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%94) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %25 = "tensor.empty"() : () -> tensor<1xi32>
    %26 = "linalg.generic"(%arg0, %arg0, %25) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg41: i32, %arg42: i32, %arg43: i32):
      %93 = "arith.shrui"(%arg41, %arg42) : (i32, i32) -> i32
      "linalg.yield"(%93) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %27 = "tensor.empty"() : () -> tensor<1xi32>
    %28 = "linalg.generic"(%arg0, %arg0, %27) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg38: i32, %arg39: i32, %arg40: i32):
      %92 = "arith.shrsi"(%arg38, %arg39) : (i32, i32) -> i32
      "linalg.yield"(%92) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %29 = "tensor.empty"() : () -> tensor<1xi32>
    %30 = "linalg.generic"(%arg0, %arg0, %29) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg35: i32, %arg36: i32, %arg37: i32):
      %79 = "arith.shrsi"(%arg35, %arg36) : (i32, i32) -> i32
      %80 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %81 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %82 = "arith.constant"() <{value = false}> : () -> i1
      %83 = "arith.constant"() <{value = true}> : () -> i1
      %84 = "arith.cmpi"(%arg36, %81) <{predicate = 4 : i64}> : (i32, i32) -> i1
      %85 = "arith.subi"(%arg36, %80) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %86 = "arith.shrsi"(%arg35, %85) : (i32, i32) -> i32
      %87 = "arith.trunci"(%86) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i1
      %88 = "arith.andi"(%87, %83) : (i1, i1) -> i1
      %89 = "arith.select"(%84, %88, %82) : (i1, i1, i1) -> i1
      %90 = "arith.extui"(%89) : (i1) -> i32
      %91 = "arith.addi"(%79, %90) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%91) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %31 = "tensor.empty"() : () -> tensor<1xi32>
    %32 = "linalg.generic"(%arg0, %31) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg33: i32, %arg34: i32):
      %78 = "math.ctlz"(%arg33) : (i32) -> i32
      "linalg.yield"(%78) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %33 = "tensor.empty"() : () -> tensor<1xi1>
    %34 = "linalg.generic"(%2, %4, %33) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg30: i32, %arg31: i32, %arg32: i1):
      %77 = "arith.cmpi"(%arg30, %arg31) <{predicate = 4 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%77) : (i1) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi1>) -> tensor<1xi1>
    %35 = "tensor.empty"() : () -> tensor<1xi1>
    %36 = "linalg.generic"(%2, %4, %35) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg27: i32, %arg28: i32, %arg29: i1):
      %76 = "arith.cmpi"(%arg27, %arg28) <{predicate = 5 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%76) : (i1) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi1>) -> tensor<1xi1>
    %37 = "tensor.empty"() : () -> tensor<1xi32>
    %38 = "linalg.generic"(%34, %2, %4, %37) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg23: i1, %arg24: i32, %arg25: i32, %arg26: i32):
      %75 = "arith.select"(%arg23, %arg24, %arg25) : (i1, i32, i32) -> i32
      "linalg.yield"(%75) : (i32) -> ()
    }) : (tensor<1xi1>, tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %39 = "tensor.empty"() : () -> tensor<1xi32>
    %40 = "linalg.generic"(%2, %4, %39) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg20: i32, %arg21: i32, %arg22: i32):
      %74 = "arith.maxsi"(%arg20, %arg21) : (i32, i32) -> i32
      "linalg.yield"(%74) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %41 = "tensor.empty"() : () -> tensor<1xi32>
    %42 = "linalg.generic"(%2, %4, %41) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg17: i32, %arg18: i32, %arg19: i32):
      %73 = "arith.minsi"(%arg17, %arg18) : (i32, i32) -> i32
      "linalg.yield"(%73) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %43 = "tensor.empty"() : () -> tensor<1xi32>
    %44 = "linalg.generic"(%2, %43) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32):
      %69 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %70 = "arith.constant"() <{value = 5 : i32}> : () -> i32
      %71 = "arith.maxsi"(%69, %arg15) : (i32, i32) -> i32
      %72 = "arith.minsi"(%70, %71) : (i32, i32) -> i32
      "linalg.yield"(%72) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %45 = "tensor.empty"() : () -> tensor<1xi32>
    %46 = "linalg.generic"(%0, %45) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg13: i32, %arg14: i32):
      %65 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %66 = "arith.constant"() <{value = 32 : i32}> : () -> i32
      %67 = "arith.maxui"(%65, %arg13) : (i32, i32) -> i32
      %68 = "arith.minui"(%66, %67) : (i32, i32) -> i32
      "linalg.yield"(%68) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %47 = "tensor.empty"() : () -> tensor<1xi16>
    %48 = "linalg.generic"(%2, %47) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: i32, %arg12: i16):
      %64 = "arith.trunci"(%arg11) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i16
      "linalg.yield"(%64) : (i16) -> ()
    }) : (tensor<1xi32>, tensor<1xi16>) -> tensor<1xi16>
    %49 = "tensor.empty"() : () -> tensor<1xi64>
    %50 = "linalg.generic"(%2, %49) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg9: i32, %arg10: i64):
      %63 = "arith.extsi"(%arg9) : (i32) -> i64
      "linalg.yield"(%63) : (i64) -> ()
    }) : (tensor<1xi32>, tensor<1xi64>) -> tensor<1xi64>
    %51 = "tensor.empty"() : () -> tensor<1xi1>
    %52 = "linalg.generic"(%2, %51) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i32, %arg8: i1):
      %61 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %62 = "arith.cmpi"(%arg7, %61) <{predicate = 1 : i64}> : (i32, i32) -> i1
      "linalg.yield"(%62) : (i1) -> ()
    }) : (tensor<1xi32>, tensor<1xi1>) -> tensor<1xi1>
    %53 = "tensor.empty"() : () -> tensor<1xf32>
    %54 = "linalg.generic"(%2, %53) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: i32, %arg6: f32):
      %60 = "arith.sitofp"(%arg5) : (i32) -> f32
      "linalg.yield"(%60) : (f32) -> ()
    }) : (tensor<1xi32>, tensor<1xf32>) -> tensor<1xf32>
    %55 = "tensor.empty"() : () -> tensor<1xi32>
    %56 = "linalg.generic"(%arg0, %55) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i32, %arg4: i32):
      %57 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %58 = "arith.subi"(%57, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %59 = "arith.maxsi"(%arg3, %58) : (i32, i32) -> i32
      "linalg.yield"(%59) : (i32) -> ()
    }) : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi8>) -> (), sym_name = "test_simple_ui8"}> ({
  ^bb0(%arg0: tensor<1xi8>):
    %0 = "tensor.empty"() : () -> tensor<1xf32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: f32):
      %2 = "arith.sitofp"(%arg1) : (i8) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<1xi8>, tensor<1xf32>) -> tensor<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi8>) -> (), sym_name = "test_i8"}> ({
  ^bb0(%arg0: tensor<1xi8>):
    %0 = "tensor.empty"() : () -> tensor<1xi8>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: i8):
      %2 = "arith.constant"() <{value = -127 : i8}> : () -> i8
      %3 = "arith.constant"() <{value = 126 : i8}> : () -> i8
      %4 = "arith.maxsi"(%2, %arg1) : (i8, i8) -> i8
      %5 = "arith.minsi"(%3, %4) : (i8, i8) -> i8
      "linalg.yield"(%5) : (i8) -> ()
    }) : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi64>) -> (), sym_name = "test_i64"}> ({
  ^bb0(%arg0: tensor<1xi64>):
    %0 = "tensor.empty"() : () -> tensor<1xi64>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i64, %arg2: i64):
      %2 = "arith.constant"() <{value = -9223372036854775808 : i64}> : () -> i64
      %3 = "arith.constant"() <{value = 9223372036854775807 : i64}> : () -> i64
      %4 = "arith.maxsi"(%2, %arg1) : (i64, i64) -> i64
      %5 = "arith.minsi"(%3, %4) : (i64, i64) -> i64
      "linalg.yield"(%5) : (i64) -> ()
    }) : (tensor<1xi64>, tensor<1xi64>) -> tensor<1xi64>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf16>) -> (), sym_name = "test_clamp_f16"}> ({
  ^bb0(%arg0: tensor<1xf16>):
    %0 = "tensor.empty"() : () -> tensor<1xf16>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f16, %arg2: f16):
      %2 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
      %3 = "arith.constant"() <{value = 6.000000e+00 : f16}> : () -> f16
      %4 = "arith.minimumf"(%arg1, %3) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
      %5 = "arith.maximumf"(%4, %2) <{fastmath = #arith.fastmath<none>}> : (f16, f16) -> f16
      "linalg.yield"(%5) : (f16) -> ()
    }) : (tensor<1xf16>, tensor<1xf16>) -> tensor<1xf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi1>, tensor<1xi1>) -> (), sym_name = "test_bool"}> ({
  ^bb0(%arg0: tensor<1xi1>, %arg1: tensor<1xi1>):
    %0 = "tensor.empty"() : () -> tensor<1xi1>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg10: i1, %arg11: i1, %arg12: i1):
      %12 = "arith.andi"(%arg10, %arg11) : (i1, i1) -> i1
      "linalg.yield"(%12) : (i1) -> ()
    }) : (tensor<1xi1>, tensor<1xi1>, tensor<1xi1>) -> tensor<1xi1>
    %2 = "tensor.empty"() : () -> tensor<1xi1>
    %3 = "linalg.generic"(%arg0, %arg1, %2) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg7: i1, %arg8: i1, %arg9: i1):
      %11 = "arith.ori"(%arg7, %arg8) : (i1, i1) -> i1
      "linalg.yield"(%11) : (i1) -> ()
    }) : (tensor<1xi1>, tensor<1xi1>, tensor<1xi1>) -> tensor<1xi1>
    %4 = "tensor.empty"() : () -> tensor<1xi1>
    %5 = "linalg.generic"(%arg0, %arg1, %4) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg4: i1, %arg5: i1, %arg6: i1):
      %10 = "arith.xori"(%arg4, %arg5) : (i1, i1) -> i1
      "linalg.yield"(%10) : (i1) -> ()
    }) : (tensor<1xi1>, tensor<1xi1>, tensor<1xi1>) -> tensor<1xi1>
    %6 = "tensor.empty"() : () -> tensor<1xi1>
    %7 = "linalg.generic"(%arg0, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i1, %arg3: i1):
      %8 = "arith.constant"() <{value = true}> : () -> i1
      %9 = "arith.xori"(%arg2, %8) : (i1, i1) -> i1
      "linalg.yield"(%9) : (i1) -> ()
    }) : (tensor<1xi1>, tensor<1xi1>) -> tensor<1xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xi8>) -> (), sym_name = "test_negate_quantized"}> ({
  ^bb0(%arg0: tensor<1xi8>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<7> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tensor.empty"() : () -> tensor<1xi8>
    %3 = "linalg.generic"(%arg0, %2) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: i8, %arg6: i8):
      %28 = "arith.constant"() <{value = 7 : i16}> : () -> i16
      %29 = "arith.extsi"(%arg5) : (i8) -> i16
      %30 = "arith.subi"(%28, %29) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
      %31 = "arith.constant"() <{value = -128 : i16}> : () -> i16
      %32 = "arith.constant"() <{value = 127 : i16}> : () -> i16
      %33 = "arith.maxsi"(%31, %30) : (i16, i16) -> i16
      %34 = "arith.minsi"(%32, %33) : (i16, i16) -> i16
      %35 = "arith.trunci"(%34) <{overflowFlags = #arith.overflow<none>}> : (i16) -> i8
      "linalg.yield"(%35) : (i8) -> ()
    }) : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %4 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %6 = "tensor.empty"() : () -> tensor<1xi8>
    %7 = "linalg.generic"(%arg0, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i8, %arg4: i8):
      %20 = "arith.constant"() <{value = -128 : i16}> : () -> i16
      %21 = "arith.extsi"(%arg3) : (i8) -> i16
      %22 = "arith.subi"(%20, %21) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
      %23 = "arith.constant"() <{value = -128 : i16}> : () -> i16
      %24 = "arith.constant"() <{value = 127 : i16}> : () -> i16
      %25 = "arith.maxsi"(%23, %22) : (i16, i16) -> i16
      %26 = "arith.minsi"(%24, %25) : (i16, i16) -> i16
      %27 = "arith.trunci"(%26) <{overflowFlags = #arith.overflow<none>}> : (i16) -> i8
      "linalg.yield"(%27) : (i8) -> ()
    }) : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %8 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %9 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %10 = "tensor.empty"() : () -> tensor<1xi8>
    %11 = "linalg.generic"(%arg0, %10) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: i8):
      %12 = "arith.constant"() <{value = 0 : i16}> : () -> i16
      %13 = "arith.extsi"(%arg1) : (i8) -> i16
      %14 = "arith.subi"(%12, %13) <{overflowFlags = #arith.overflow<none>}> : (i16, i16) -> i16
      %15 = "arith.constant"() <{value = -128 : i16}> : () -> i16
      %16 = "arith.constant"() <{value = 127 : i16}> : () -> i16
      %17 = "arith.maxsi"(%15, %14) : (i16, i16) -> i16
      %18 = "arith.minsi"(%16, %17) : (i16, i16) -> i16
      %19 = "arith.trunci"(%18) <{overflowFlags = #arith.overflow<none>}> : (i16) -> i8
      "linalg.yield"(%19) : (i8) -> ()
    }) : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<50x42xf16>, tensor<1xf16>, tensor<1xf16>) -> tensor<*xf16>, sym_name = "test_negate_no_const_1"}> ({
  ^bb0(%arg0: tensor<50x42xf16>, %arg1: tensor<1xf16>, %arg2: tensor<1xf16>):
    %0 = "tensor.empty"() : () -> tensor<50x42xf16>
    %1 = "linalg.generic"(%arg0, %arg1, %arg2, %0) <{indexing_maps = [#map, #map1, #map1, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg3: f16, %arg4: f16, %arg5: f16, %arg6: f16):
      %3 = "arith.negf"(%arg3) <{fastmath = #arith.fastmath<none>}> : (f16) -> f16
      "linalg.yield"(%3) : (f16) -> ()
    }) : (tensor<50x42xf16>, tensor<1xf16>, tensor<1xf16>, tensor<50x42xf16>) -> tensor<50x42xf16>
    %2 = "tensor.cast"(%1) : (tensor<50x42xf16>) -> tensor<*xf16>
    "func.return"(%2) : (tensor<*xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<50x42xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<*xi16>, sym_name = "test_negate_no_const_2"}> ({
  ^bb0(%arg0: tensor<50x42xi16>, %arg1: tensor<1xi16>, %arg2: tensor<1xi16>):
    %0 = "tensor.empty"() : () -> tensor<50x42xi16>
    %1 = "linalg.generic"(%arg0, %arg1, %arg2, %0) <{indexing_maps = [#map, #map1, #map1, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg3: i16, %arg4: i16, %arg5: i16, %arg6: i16):
      %3 = "arith.extsi"(%arg4) : (i16) -> i64
      %4 = "arith.extsi"(%arg5) : (i16) -> i64
      %5 = "arith.addi"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %6 = "arith.extsi"(%arg3) : (i16) -> i64
      %7 = "arith.subi"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %8 = "arith.constant"() <{value = -32768 : i64}> : () -> i64
      %9 = "arith.constant"() <{value = 32767 : i64}> : () -> i64
      %10 = "arith.maxsi"(%8, %7) : (i64, i64) -> i64
      %11 = "arith.minsi"(%9, %10) : (i64, i64) -> i64
      %12 = "arith.trunci"(%11) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i16
      "linalg.yield"(%12) : (i16) -> ()
    }) : (tensor<50x42xi16>, tensor<1xi16>, tensor<1xi16>, tensor<50x42xi16>) -> tensor<50x42xi16>
    %2 = "tensor.cast"(%1) : (tensor<50x42xi16>) -> tensor<*xi16>
    "func.return"(%2) : (tensor<*xi16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>, tensor<1xi32>) -> (tensor<1xf32>, tensor<1xi32>), sym_name = "test_identity"}> ({
  ^bb0(%arg0: tensor<1xf32>, %arg1: tensor<1xi32>):
    "func.return"(%arg0, %arg1) : (tensor<1xf32>, tensor<1xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xbf16>) -> (), sym_name = "reduce_bf16"}> ({
  ^bb0(%arg0: tensor<5x4xbf16>):
    %0 = "tensor.empty"() : () -> tensor<4xf32>
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %3 = "linalg.reduce"(%arg0, %2) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg3: bf16, %arg4: f32):
      %8 = "arith.extf"(%arg3) : (bf16) -> f32
      %9 = "arith.addf"(%8, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%9) : (f32) -> ()
    }) : (tensor<5x4xbf16>, tensor<4xf32>) -> tensor<4xf32>
    %4 = "tensor.empty"() : () -> tensor<4xbf16>
    %5 = "linalg.generic"(%3, %4) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: bf16):
      %7 = "arith.truncf"(%arg1) : (f32) -> bf16
      "linalg.yield"(%7) : (bf16) -> ()
    }) : (tensor<4xf32>, tensor<4xbf16>) -> tensor<4xbf16>
    %6 = "tensor.expand_shape"(%5) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xbf16>) -> tensor<1x4xbf16>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>) -> (), sym_name = "reduce_float"}> ({
  ^bb0(%arg0: tensor<5x4xf32>):
    %0 = "tensor.empty"() : () -> tensor<4xf32>
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: f32, %arg20: f32):
      "linalg.yield"(%arg19) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %3 = "linalg.reduce"(%arg0, %2) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg17: f32, %arg18: f32):
      %29 = "arith.addf"(%arg17, %arg18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%29) : (f32) -> ()
    }) : (tensor<5x4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xf32>) -> tensor<1x4xf32>
    %5 = "tensor.empty"() : () -> tensor<5xf32>
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "linalg.fill"(%6, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: f32, %arg16: f32):
      "linalg.yield"(%arg15) : (f32) -> ()
    }) : (f32, tensor<5xf32>) -> tensor<5xf32>
    %8 = "linalg.reduce"(%arg0, %7) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg13: f32, %arg14: f32):
      %28 = "arith.addf"(%arg13, %arg14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%28) : (f32) -> ()
    }) : (tensor<5x4xf32>, tensor<5xf32>) -> tensor<5xf32>
    %9 = "tensor.expand_shape"(%8) <{reassociation = [[0, 1]], static_output_shape = array<i64: 5, 1>}> : (tensor<5xf32>) -> tensor<5x1xf32>
    %10 = "tensor.empty"() : () -> tensor<4xf32>
    %11 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %12 = "linalg.fill"(%11, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: f32, %arg12: f32):
      "linalg.yield"(%arg11) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %13 = "linalg.reduce"(%arg0, %12) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg9: f32, %arg10: f32):
      %27 = "arith.mulf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%27) : (f32) -> ()
    }) : (tensor<5x4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %14 = "tensor.expand_shape"(%13) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xf32>) -> tensor<1x4xf32>
    %15 = "tensor.empty"() : () -> tensor<4xf32>
    %16 = "arith.constant"() <{value = 3.40282347E+38 : f32}> : () -> f32
    %17 = "linalg.fill"(%16, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: f32, %arg8: f32):
      "linalg.yield"(%arg7) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %18 = "linalg.reduce"(%arg0, %17) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      %26 = "arith.minimumf"(%arg5, %arg6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%26) : (f32) -> ()
    }) : (tensor<5x4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %19 = "tensor.expand_shape"(%18) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xf32>) -> tensor<1x4xf32>
    %20 = "tensor.empty"() : () -> tensor<4xf32>
    %21 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %22 = "linalg.fill"(%21, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %23 = "linalg.reduce"(%arg0, %22) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %25 = "arith.maximumf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%25) : (f32) -> ()
    }) : (tensor<5x4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %24 = "tensor.expand_shape"(%23) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xf32>) -> tensor<1x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x5x4xf32>) -> (), sym_name = "reduce_float_dyn"}> ({
  ^bb0(%arg0: tensor<?x5x4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x5x4xf32>, index) -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<?x4xf32>
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "linalg.fill"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<?x4xf32>) -> tensor<?x4xf32>
    %5 = "linalg.reduce"(%arg0, %4) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %10 = "arith.addf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<?x5x4xf32>, tensor<?x4xf32>) -> tensor<?x4xf32>
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "tensor.dim"(%5, %6) : (tensor<?x4xf32>, index) -> index
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    %9 = "tensor.expand_shape"(%5, %7) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: -9223372036854775808, 1, 4>}> : (tensor<?x4xf32>, index) -> tensor<?x1x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>) -> (), sym_name = "reduce_float_dyn_rank_1"}> ({
  ^bb0(%arg0: tensor<?xf32>):
    %0 = "tensor.empty"() : () -> tensor<f32>
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %3 = "linalg.reduce"(%arg0, %2) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %5 = "arith.addf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<?xf32>, tensor<f32>) -> tensor<f32>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [], static_output_shape = array<i64: 1>}> : (tensor<f32>) -> tensor<1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x?x4xf32>) -> (), sym_name = "reduce_float_dyn_nonzero_batch"}> ({
  ^bb0(%arg0: tensor<5x?x4xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<5x?x4xf32>, index) -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<5x?xf32>
    %3 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %4 = "linalg.fill"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<5x?xf32>) -> tensor<5x?xf32>
    %5 = "linalg.reduce"(%arg0, %4) <{dimensions = array<i64: 2>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %10 = "arith.mulf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<5x?x4xf32>, tensor<5x?xf32>) -> tensor<5x?xf32>
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "tensor.dim"(%5, %6) : (tensor<5x?xf32>, index) -> index
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    %9 = "tensor.expand_shape"(%5, %7) <{reassociation = [[0], [1, 2]], static_output_shape = array<i64: 5, -9223372036854775808, 1>}> : (tensor<5x?xf32>, index) -> tensor<5x?x1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>) -> (), sym_name = "reduce_float_dyn_multiple"}> ({
  ^bb0(%arg0: tensor<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x?xf32>, index) -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<?xf32>
    %3 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %4 = "linalg.fill"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: f32, %arg4: f32):
      "linalg.yield"(%arg3) : (f32) -> ()
    }) : (f32, tensor<?xf32>) -> tensor<?xf32>
    %5 = "linalg.reduce"(%arg0, %4) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      %10 = "arith.maximumf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%10) : (f32) -> ()
    }) : (tensor<?x?xf32>, tensor<?xf32>) -> tensor<?xf32>
    %6 = "arith.constant"() <{value = 0 : index}> : () -> index
    %7 = "tensor.dim"(%5, %6) : (tensor<?xf32>, index) -> index
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    %9 = "tensor.expand_shape"(%5, %7) <{reassociation = [[0, 1]], static_output_shape = array<i64: -9223372036854775808, 1>}> : (tensor<?xf32>, index) -> tensor<?x1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi32>) -> (), sym_name = "reduce_int"}> ({
  ^bb0(%arg0: tensor<5x4xi32>):
    %0 = "tensor.empty"() : () -> tensor<4xi32>
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: i32, %arg20: i32):
      "linalg.yield"(%arg19) : (i32) -> ()
    }) : (i32, tensor<4xi32>) -> tensor<4xi32>
    %3 = "linalg.reduce"(%arg0, %2) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg17: i32, %arg18: i32):
      %29 = "arith.addi"(%arg17, %arg18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%29) : (i32) -> ()
    }) : (tensor<5x4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xi32>) -> tensor<1x4xi32>
    %5 = "tensor.empty"() : () -> tensor<5xi32>
    %6 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %7 = "linalg.fill"(%6, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg15: i32, %arg16: i32):
      "linalg.yield"(%arg15) : (i32) -> ()
    }) : (i32, tensor<5xi32>) -> tensor<5xi32>
    %8 = "linalg.reduce"(%arg0, %7) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg13: i32, %arg14: i32):
      %28 = "arith.addi"(%arg13, %arg14) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%28) : (i32) -> ()
    }) : (tensor<5x4xi32>, tensor<5xi32>) -> tensor<5xi32>
    %9 = "tensor.expand_shape"(%8) <{reassociation = [[0, 1]], static_output_shape = array<i64: 5, 1>}> : (tensor<5xi32>) -> tensor<5x1xi32>
    %10 = "tensor.empty"() : () -> tensor<4xi32>
    %11 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %12 = "linalg.fill"(%11, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg11: i32, %arg12: i32):
      "linalg.yield"(%arg11) : (i32) -> ()
    }) : (i32, tensor<4xi32>) -> tensor<4xi32>
    %13 = "linalg.reduce"(%arg0, %12) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg9: i32, %arg10: i32):
      %27 = "arith.muli"(%arg9, %arg10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%27) : (i32) -> ()
    }) : (tensor<5x4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %14 = "tensor.expand_shape"(%13) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xi32>) -> tensor<1x4xi32>
    %15 = "tensor.empty"() : () -> tensor<4xi32>
    %16 = "arith.constant"() <{value = 2147483647 : i32}> : () -> i32
    %17 = "linalg.fill"(%16, %15) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      "linalg.yield"(%arg7) : (i32) -> ()
    }) : (i32, tensor<4xi32>) -> tensor<4xi32>
    %18 = "linalg.reduce"(%arg0, %17) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg5: i32, %arg6: i32):
      %26 = "arith.minsi"(%arg5, %arg6) : (i32, i32) -> i32
      "linalg.yield"(%26) : (i32) -> ()
    }) : (tensor<5x4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %19 = "tensor.expand_shape"(%18) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xi32>) -> tensor<1x4xi32>
    %20 = "tensor.empty"() : () -> tensor<4xi32>
    %21 = "arith.constant"() <{value = -2147483648 : i32}> : () -> i32
    %22 = "linalg.fill"(%21, %20) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i32, %arg4: i32):
      "linalg.yield"(%arg3) : (i32) -> ()
    }) : (i32, tensor<4xi32>) -> tensor<4xi32>
    %23 = "linalg.reduce"(%arg0, %22) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg1: i32, %arg2: i32):
      %25 = "arith.maxsi"(%arg1, %arg2) : (i32, i32) -> i32
      "linalg.yield"(%25) : (i32) -> ()
    }) : (tensor<5x4xi32>, tensor<4xi32>) -> tensor<4xi32>
    %24 = "tensor.expand_shape"(%23) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xi32>) -> tensor<1x4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi1>) -> (), sym_name = "reduce_bool"}> ({
  ^bb0(%arg0: tensor<5x4xi1>):
    %0 = "tensor.empty"() : () -> tensor<4xi1>
    %1 = "arith.constant"() <{value = true}> : () -> i1
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i1, %arg8: i1):
      "linalg.yield"(%arg7) : (i1) -> ()
    }) : (i1, tensor<4xi1>) -> tensor<4xi1>
    %3 = "linalg.reduce"(%arg0, %2) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg5: i1, %arg6: i1):
      %11 = "arith.andi"(%arg5, %arg6) : (i1, i1) -> i1
      "linalg.yield"(%11) : (i1) -> ()
    }) : (tensor<5x4xi1>, tensor<4xi1>) -> tensor<4xi1>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xi1>) -> tensor<1x4xi1>
    %5 = "tensor.empty"() : () -> tensor<4xi1>
    %6 = "arith.constant"() <{value = false}> : () -> i1
    %7 = "linalg.fill"(%6, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i1, %arg4: i1):
      "linalg.yield"(%arg3) : (i1) -> ()
    }) : (i1, tensor<4xi1>) -> tensor<4xi1>
    %8 = "linalg.reduce"(%arg0, %7) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg1: i1, %arg2: i1):
      %10 = "arith.ori"(%arg1, %arg2) : (i1, i1) -> i1
      "linalg.yield"(%10) : (i1) -> ()
    }) : (tensor<5x4xi1>, tensor<4xi1>) -> tensor<4xi1>
    %9 = "tensor.expand_shape"(%8) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xi1>) -> tensor<1x4xi1>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>) -> (), sym_name = "rescale_i8"}> ({
  ^bb0(%arg0: tensor<2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "arith.constant"() <{value = 19689 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 15 : i8}> : () -> i8
    %6 = "tensor.empty"() : () -> tensor<2xi8>
    %7 = "linalg.generic"(%arg0, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: i8):
      %8 = "arith.constant"() <{value = 17 : i32}> : () -> i32
      %9 = "arith.constant"() <{value = 22 : i32}> : () -> i32
      %10 = "arith.extsi"(%arg1) : (i8) -> i32
      %11 = "arith.subi"(%10, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %12 = "tosa.apply_scale"(%11, %4, %5) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      %13 = "arith.addi"(%12, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %14 = "arith.constant"() <{value = -128 : i32}> : () -> i32
      %15 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %16 = "arith.maxsi"(%14, %13) : (i32, i32) -> i32
      %17 = "arith.minsi"(%15, %16) : (i32, i32) -> i32
      %18 = "arith.trunci"(%17) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%18) : (i8) -> ()
    }) : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>) -> (), sym_name = "rescale_i8_unsigned_output_explicit"}> ({
  ^bb0(%arg0: tensor<2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<-22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "arith.constant"() <{value = 19689 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 15 : i8}> : () -> i8
    %6 = "tensor.empty"() : () -> tensor<2xui8>
    %7 = "linalg.generic"(%arg0, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: ui8):
      %8 = "arith.constant"() <{value = 17 : i32}> : () -> i32
      %9 = "arith.constant"() <{value = 234 : i32}> : () -> i32
      %10 = "arith.extsi"(%arg1) : (i8) -> i32
      %11 = "arith.subi"(%10, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %12 = "tosa.apply_scale"(%11, %4, %5) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      %13 = "arith.addi"(%12, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %14 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %15 = "arith.constant"() <{value = 255 : i32}> : () -> i32
      %16 = "arith.maxsi"(%14, %13) : (i32, i32) -> i32
      %17 = "arith.minsi"(%15, %16) : (i32, i32) -> i32
      %18 = "arith.trunci"(%17) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      %19 = "builtin.unrealized_conversion_cast"(%18) : (i8) -> ui8
      "linalg.yield"(%19) : (ui8) -> ()
    }) : (tensor<2xi8>, tensor<2xui8>) -> tensor<2xui8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>) -> (), sym_name = "rescale_i8_unsigned_output_implicit"}> ({
  ^bb0(%arg0: tensor<2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<-22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "arith.constant"() <{value = 19689 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 15 : i8}> : () -> i8
    %6 = "tensor.empty"() : () -> tensor<2xi8>
    %7 = "linalg.generic"(%arg0, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: i8):
      %8 = "arith.constant"() <{value = 17 : i32}> : () -> i32
      %9 = "arith.constant"() <{value = 234 : i32}> : () -> i32
      %10 = "arith.extsi"(%arg1) : (i8) -> i32
      %11 = "arith.subi"(%10, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %12 = "tosa.apply_scale"(%11, %4, %5) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      %13 = "arith.addi"(%12, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %14 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %15 = "arith.constant"() <{value = 255 : i32}> : () -> i32
      %16 = "arith.maxsi"(%14, %13) : (i32, i32) -> i32
      %17 = "arith.minsi"(%15, %16) : (i32, i32) -> i32
      %18 = "arith.trunci"(%17) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%18) : (i8) -> ()
    }) : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi48>) -> (), sym_name = "rescale_i48_unsigned_output_implicit"}> ({
  ^bb0(%arg0: tensor<2xi48>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi48>}> : () -> tensor<1xi48>
    %3 = "tosa.const"() <{values = dense<-22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "arith.constant"() <{value = 19689 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 15 : i8}> : () -> i8
    %6 = "tensor.empty"() : () -> tensor<2xi8>
    %7 = "linalg.generic"(%arg0, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i48, %arg2: i8):
      %8 = "arith.constant"() <{value = 0 : i48}> : () -> i48
      %9 = "arith.constant"() <{value = 234 : i32}> : () -> i32
      %10 = "arith.subi"(%arg1, %8) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %11 = "tosa.apply_scale"(%10, %4, %5) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i48, i32, i8) -> i32
      %12 = "arith.addi"(%11, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %13 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %14 = "arith.constant"() <{value = 255 : i32}> : () -> i32
      %15 = "arith.maxsi"(%13, %12) : (i32, i32) -> i32
      %16 = "arith.minsi"(%14, %15) : (i32, i32) -> i32
      %17 = "arith.trunci"(%16) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%17) : (i8) -> ()
    }) : (tensor<2xi48>, tensor<2xi8>) -> tensor<2xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x2xi8>) -> (), sym_name = "rescale_i8_dyn_batch"}> ({
  ^bb0(%arg0: tensor<?x2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "tensor.dim"(%arg0, %4) : (tensor<?x2xi8>, index) -> index
    %6 = "arith.constant"() <{value = 19689 : i32}> : () -> i32
    %7 = "arith.constant"() <{value = 15 : i8}> : () -> i8
    %8 = "tensor.empty"(%5) : (index) -> tensor<?x2xi8>
    %9 = "linalg.generic"(%arg0, %8) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i8, %arg4: i8):
      %27 = "arith.constant"() <{value = 17 : i32}> : () -> i32
      %28 = "arith.constant"() <{value = 22 : i32}> : () -> i32
      %29 = "arith.extsi"(%arg3) : (i8) -> i32
      %30 = "arith.subi"(%29, %27) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %31 = "tosa.apply_scale"(%30, %6, %7) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      %32 = "arith.addi"(%31, %28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %33 = "arith.constant"() <{value = -128 : i32}> : () -> i32
      %34 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %35 = "arith.maxsi"(%33, %32) : (i32, i32) -> i32
      %36 = "arith.minsi"(%34, %35) : (i32, i32) -> i32
      %37 = "arith.trunci"(%36) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%37) : (i8) -> ()
    }) : (tensor<?x2xi8>, tensor<?x2xi8>) -> tensor<?x2xi8>
    %10 = "arith.constant"() <{value = 0 : index}> : () -> index
    %11 = "tensor.dim"(%arg0, %10) : (tensor<?x2xi8>, index) -> index
    %12 = "arith.constant"() <{value = 19689 : i32}> : () -> i32
    %13 = "arith.constant"() <{value = 15 : i8}> : () -> i8
    %14 = "tensor.empty"(%11) : (index) -> tensor<?x2xi8>
    %15 = "linalg.generic"(%arg0, %14) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: i8):
      %16 = "arith.constant"() <{value = 17 : i32}> : () -> i32
      %17 = "arith.constant"() <{value = 22 : i32}> : () -> i32
      %18 = "arith.extsi"(%arg1) : (i8) -> i32
      %19 = "arith.subi"(%18, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %20 = "tosa.apply_scale"(%19, %12, %13) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      %21 = "arith.addi"(%20, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %22 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %23 = "arith.constant"() <{value = 255 : i32}> : () -> i32
      %24 = "arith.maxsi"(%22, %21) : (i32, i32) -> i32
      %25 = "arith.minsi"(%23, %24) : (i32, i32) -> i32
      %26 = "arith.trunci"(%25) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%26) : (i8) -> ()
    }) : (tensor<?x2xi8>, tensor<?x2xi8>) -> tensor<?x2xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x?x?x32xi32>) -> (), sym_name = "rescale_dyn"}> ({
  ^bb0(%arg0: tensor<1x?x?x32xi32>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<1376784203> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<38> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "tensor.dim"(%arg0, %4) : (tensor<1x?x?x32xi32>, index) -> index
    %6 = "arith.constant"() <{value = 2 : index}> : () -> index
    %7 = "tensor.dim"(%arg0, %6) : (tensor<1x?x?x32xi32>, index) -> index
    %8 = "arith.constant"() <{value = 1376784203 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 38 : i8}> : () -> i8
    %10 = "tensor.empty"(%5, %7) : (index, index) -> tensor<1x?x?x32xi8>
    %11 = "linalg.generic"(%arg0, %10) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i32, %arg2: i8):
      %12 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %13 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %14 = "arith.subi"(%arg1, %12) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %15 = "tosa.apply_scale"(%14, %8, %9) <{rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>}> : (i32, i32, i8) -> i32
      %16 = "arith.addi"(%15, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %17 = "arith.constant"() <{value = -128 : i32}> : () -> i32
      %18 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %19 = "arith.maxsi"(%17, %16) : (i32, i32) -> i32
      %20 = "arith.minsi"(%18, %19) : (i32, i32) -> i32
      %21 = "arith.trunci"(%20) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%21) : (i8) -> ()
    }) : (tensor<1x?x?x32xi32>, tensor<1x?x?x32xi8>) -> tensor<1x?x?x32xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xui8>) -> (), sym_name = "rescale_i8_unsigned_input_explicit"}> ({
  ^bb0(%arg0: tensor<2xui8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "arith.constant"() <{value = 19689 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 15 : i8}> : () -> i8
    %6 = "tensor.empty"() : () -> tensor<2xi8>
    %7 = "linalg.generic"(%arg0, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: ui8, %arg2: i8):
      %8 = "arith.constant"() <{value = 17 : i32}> : () -> i32
      %9 = "arith.constant"() <{value = 22 : i32}> : () -> i32
      %10 = "builtin.unrealized_conversion_cast"(%arg1) : (ui8) -> i8
      %11 = "arith.extui"(%10) : (i8) -> i32
      %12 = "arith.subi"(%11, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %13 = "tosa.apply_scale"(%12, %4, %5) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      %14 = "arith.addi"(%13, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %15 = "arith.constant"() <{value = -128 : i32}> : () -> i32
      %16 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %17 = "arith.maxsi"(%15, %14) : (i32, i32) -> i32
      %18 = "arith.minsi"(%16, %17) : (i32, i32) -> i32
      %19 = "arith.trunci"(%18) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%19) : (i8) -> ()
    }) : (tensor<2xui8>, tensor<2xi8>) -> tensor<2xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>) -> (), sym_name = "rescale_i8_unsigned_input_implicit"}> ({
  ^bb0(%arg0: tensor<2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<-128> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "arith.constant"() <{value = 19689 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 15 : i8}> : () -> i8
    %6 = "tensor.empty"() : () -> tensor<2xi8>
    %7 = "linalg.generic"(%arg0, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: i8):
      %8 = "arith.constant"() <{value = 128 : i32}> : () -> i32
      %9 = "arith.constant"() <{value = 22 : i32}> : () -> i32
      %10 = "arith.extui"(%arg1) : (i8) -> i32
      %11 = "arith.subi"(%10, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %12 = "tosa.apply_scale"(%11, %4, %5) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      %13 = "arith.addi"(%12, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %14 = "arith.constant"() <{value = -128 : i32}> : () -> i32
      %15 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %16 = "arith.maxsi"(%14, %13) : (i32, i32) -> i32
      %17 = "arith.minsi"(%15, %16) : (i32, i32) -> i32
      %18 = "arith.trunci"(%17) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%18) : (i8) -> ()
    }) : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xui8>) -> (), sym_name = "rescale_i8_unsigned_input_output_explicit"}> ({
  ^bb0(%arg0: tensor<2xui8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi16>}> : () -> tensor<1xi16>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<17> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<22> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "arith.constant"() <{value = 19689 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 15 : i8}> : () -> i8
    %6 = "tensor.empty"() : () -> tensor<2xui8>
    %7 = "linalg.generic"(%arg0, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: ui8, %arg2: ui8):
      %8 = "arith.constant"() <{value = 17 : i32}> : () -> i32
      %9 = "arith.constant"() <{value = 22 : i32}> : () -> i32
      %10 = "builtin.unrealized_conversion_cast"(%arg1) : (ui8) -> i8
      %11 = "arith.extui"(%10) : (i8) -> i32
      %12 = "arith.subi"(%11, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %13 = "tosa.apply_scale"(%12, %4, %5) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      %14 = "arith.addi"(%13, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %15 = "arith.constant"() <{value = -128 : i32}> : () -> i32
      %16 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %17 = "arith.maxsi"(%15, %14) : (i32, i32) -> i32
      %18 = "arith.minsi"(%16, %17) : (i32, i32) -> i32
      %19 = "arith.trunci"(%18) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      %20 = "builtin.unrealized_conversion_cast"(%19) : (i8) -> ui8
      "linalg.yield"(%20) : (ui8) -> ()
    }) : (tensor<2xui8>, tensor<2xui8>) -> tensor<2xui8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3xi8>) -> tensor<3xi8>, sym_name = "rescale_per_channel"}> ({
  ^bb0(%arg0: tensor<3xi8>):
    %0 = "tosa.const"() <{values = dense<[42, 43, 44]> : tensor<3xi16>}> : () -> tensor<3xi16>
    %1 = "tosa.const"() <{values = dense<[14, 15, 64]> : tensor<3xi8>}> : () -> tensor<3xi8>
    %2 = "tosa.const"() <{values = dense<43> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<52> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "arith.constant"() <{value = dense<[42, 43, 0]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %5 = "arith.constant"() <{value = dense<[14, 15, 0]> : tensor<3xi8>}> : () -> tensor<3xi8>
    %6 = "tensor.empty"() : () -> tensor<3xi8>
    %7 = "linalg.generic"(%arg0, %4, %5, %6) <{indexing_maps = [#map, #map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg1: i8, %arg2: i32, %arg3: i8, %arg4: i8):
      %8 = "arith.constant"() <{value = 43 : i32}> : () -> i32
      %9 = "arith.constant"() <{value = 52 : i32}> : () -> i32
      %10 = "arith.extsi"(%arg1) : (i8) -> i32
      %11 = "arith.subi"(%10, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %12 = "tosa.apply_scale"(%11, %arg2, %arg3) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      %13 = "arith.addi"(%12, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %14 = "arith.constant"() <{value = -128 : i32}> : () -> i32
      %15 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %16 = "arith.maxsi"(%14, %13) : (i32, i32) -> i32
      %17 = "arith.minsi"(%15, %16) : (i32, i32) -> i32
      %18 = "arith.trunci"(%17) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%18) : (i8) -> ()
    }) : (tensor<3xi8>, tensor<3xi32>, tensor<3xi8>, tensor<3xi8>) -> tensor<3xi8>
    "func.return"(%7) : (tensor<3xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>) -> tensor<2xi8>, sym_name = "rescaleDoubleRound"}> ({
  ^bb0(%arg0: tensor<2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<33> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<43> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<52> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "arith.constant"() <{value = 19689 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 33 : i8}> : () -> i8
    %6 = "tensor.empty"() : () -> tensor<2xi8>
    %7 = "linalg.generic"(%arg0, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: i8):
      %8 = "arith.constant"() <{value = 43 : i32}> : () -> i32
      %9 = "arith.constant"() <{value = 52 : i32}> : () -> i32
      %10 = "arith.extsi"(%arg1) : (i8) -> i32
      %11 = "arith.subi"(%10, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %12 = "tosa.apply_scale"(%11, %4, %5) <{rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>}> : (i32, i32, i8) -> i32
      %13 = "arith.addi"(%12, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %14 = "arith.constant"() <{value = -128 : i32}> : () -> i32
      %15 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %16 = "arith.maxsi"(%14, %13) : (i32, i32) -> i32
      %17 = "arith.minsi"(%15, %16) : (i32, i32) -> i32
      %18 = "arith.trunci"(%17) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%18) : (i8) -> ()
    }) : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    "func.return"(%7) : (tensor<2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>) -> tensor<2xi8>, sym_name = "rescaleUnnecessaryDoubleRound"}> ({
  ^bb0(%arg0: tensor<2xi8>):
    %0 = "tosa.const"() <{values = dense<19689> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = "tosa.const"() <{values = dense<15> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<43> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<52> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = "arith.constant"() <{value = 19689 : i32}> : () -> i32
    %5 = "arith.constant"() <{value = 15 : i8}> : () -> i8
    %6 = "tensor.empty"() : () -> tensor<2xi8>
    %7 = "linalg.generic"(%arg0, %6) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: i8):
      %8 = "arith.constant"() <{value = 43 : i32}> : () -> i32
      %9 = "arith.constant"() <{value = 52 : i32}> : () -> i32
      %10 = "arith.extsi"(%arg1) : (i8) -> i32
      %11 = "arith.subi"(%10, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %12 = "tosa.apply_scale"(%11, %4, %5) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      %13 = "arith.addi"(%12, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %14 = "arith.constant"() <{value = -128 : i32}> : () -> i32
      %15 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %16 = "arith.maxsi"(%14, %13) : (i32, i32) -> i32
      %17 = "arith.minsi"(%15, %16) : (i32, i32) -> i32
      %18 = "arith.trunci"(%17) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%18) : (i8) -> ()
    }) : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    "func.return"(%7) : (tensor<2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>, tensor<1xi32>, tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xi8>, sym_name = "rescale_no_const"}> ({
  ^bb0(%arg0: tensor<2xi8>, %arg1: tensor<1xi32>, %arg2: tensor<1xi8>, %arg3: tensor<1xi8>, %arg4: tensor<1xi8>):
    %0 = "tensor.collapse_shape"(%arg1) <{reassociation = []}> : (tensor<1xi32>) -> tensor<i32>
    %1 = "tensor.collapse_shape"(%arg2) <{reassociation = []}> : (tensor<1xi8>) -> tensor<i8>
    %2 = "tensor.collapse_shape"(%arg3) <{reassociation = []}> : (tensor<1xi8>) -> tensor<i8>
    %3 = "tensor.collapse_shape"(%arg4) <{reassociation = []}> : (tensor<1xi8>) -> tensor<i8>
    %4 = "tensor.empty"() : () -> tensor<2xi8>
    %5 = "linalg.generic"(%arg0, %0, %1, %2, %3, %4) <{indexing_maps = [#map, #map1, #map1, #map1, #map1, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 5, 1>}> ({
    ^bb0(%arg5: i8, %arg6: i32, %arg7: i8, %arg8: i8, %arg9: i8, %arg10: i8):
      %6 = "arith.extsi"(%arg8) : (i8) -> i32
      %7 = "arith.extsi"(%arg9) : (i8) -> i32
      %8 = "arith.extsi"(%arg5) : (i8) -> i32
      %9 = "arith.subi"(%8, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %10 = "tosa.apply_scale"(%9, %arg6, %arg7) <{rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>}> : (i32, i32, i8) -> i32
      %11 = "arith.addi"(%10, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %12 = "arith.constant"() <{value = -128 : i32}> : () -> i32
      %13 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %14 = "arith.maxsi"(%12, %11) : (i32, i32) -> i32
      %15 = "arith.minsi"(%13, %14) : (i32, i32) -> i32
      %16 = "arith.trunci"(%15) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%16) : (i8) -> ()
    }) : (tensor<2xi8>, tensor<i32>, tensor<i8>, tensor<i8>, tensor<i8>, tensor<2xi8>) -> tensor<2xi8>
    "func.return"(%5) : (tensor<2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>, tensor<2xi32>, tensor<2xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<2xi8>, sym_name = "rescale_no_const_per_channel"}> ({
  ^bb0(%arg0: tensor<2xi8>, %arg1: tensor<2xi32>, %arg2: tensor<2xi8>, %arg3: tensor<1xi8>, %arg4: tensor<1xi8>):
    %0 = "tensor.collapse_shape"(%arg3) <{reassociation = []}> : (tensor<1xi8>) -> tensor<i8>
    %1 = "tensor.collapse_shape"(%arg4) <{reassociation = []}> : (tensor<1xi8>) -> tensor<i8>
    %2 = "tensor.empty"() : () -> tensor<2xi8>
    %3 = "linalg.generic"(%arg0, %arg1, %arg2, %0, %1, %2) <{indexing_maps = [#map, #map, #map, #map1, #map1, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 5, 1>}> ({
    ^bb0(%arg5: i8, %arg6: i32, %arg7: i8, %arg8: i8, %arg9: i8, %arg10: i8):
      %4 = "arith.extsi"(%arg8) : (i8) -> i32
      %5 = "arith.extsi"(%arg9) : (i8) -> i32
      %6 = "arith.extsi"(%arg5) : (i8) -> i32
      %7 = "arith.subi"(%6, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %8 = "tosa.apply_scale"(%7, %arg6, %arg7) <{rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>}> : (i32, i32, i8) -> i32
      %9 = "arith.addi"(%8, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %10 = "arith.constant"() <{value = -128 : i32}> : () -> i32
      %11 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %12 = "arith.maxsi"(%10, %9) : (i32, i32) -> i32
      %13 = "arith.minsi"(%11, %12) : (i32, i32) -> i32
      %14 = "arith.trunci"(%13) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      "linalg.yield"(%14) : (i8) -> ()
    }) : (tensor<2xi8>, tensor<2xi32>, tensor<2xi8>, tensor<i8>, tensor<i8>, tensor<2xi8>) -> tensor<2xi8>
    "func.return"(%3) : (tensor<2xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi8>, tensor<2xi32>, tensor<2xi8>, tensor<1xui8>, tensor<1xui8>) -> tensor<2xui8>, sym_name = "rescale_no_const_per_channel_input_output_zp_ui8"}> ({
  ^bb0(%arg0: tensor<2xi8>, %arg1: tensor<2xi32>, %arg2: tensor<2xi8>, %arg3: tensor<1xui8>, %arg4: tensor<1xui8>):
    %0 = "tensor.collapse_shape"(%arg3) <{reassociation = []}> : (tensor<1xui8>) -> tensor<ui8>
    %1 = "tensor.collapse_shape"(%arg4) <{reassociation = []}> : (tensor<1xui8>) -> tensor<ui8>
    %2 = "tensor.empty"() : () -> tensor<2xui8>
    %3 = "linalg.generic"(%arg0, %arg1, %arg2, %0, %1, %2) <{indexing_maps = [#map, #map, #map, #map1, #map1, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 5, 1>}> ({
    ^bb0(%arg5: i8, %arg6: i32, %arg7: i8, %arg8: ui8, %arg9: ui8, %arg10: ui8):
      %4 = "builtin.unrealized_conversion_cast"(%arg8) : (ui8) -> i8
      %5 = "arith.extui"(%4) : (i8) -> i32
      %6 = "builtin.unrealized_conversion_cast"(%arg9) : (ui8) -> i8
      %7 = "arith.extui"(%6) : (i8) -> i32
      %8 = "arith.extsi"(%arg5) : (i8) -> i32
      %9 = "arith.subi"(%8, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %10 = "tosa.apply_scale"(%9, %arg6, %arg7) <{rounding_mode = #tosa.rounding_mode<DOUBLE_ROUND>}> : (i32, i32, i8) -> i32
      %11 = "arith.addi"(%10, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %12 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %13 = "arith.constant"() <{value = 255 : i32}> : () -> i32
      %14 = "arith.maxsi"(%12, %11) : (i32, i32) -> i32
      %15 = "arith.minsi"(%13, %14) : (i32, i32) -> i32
      %16 = "arith.trunci"(%15) <{overflowFlags = #arith.overflow<none>}> : (i32) -> i8
      %17 = "builtin.unrealized_conversion_cast"(%16) : (i8) -> ui8
      "linalg.yield"(%17) : (ui8) -> ()
    }) : (tensor<2xi8>, tensor<2xi32>, tensor<2xi8>, tensor<ui8>, tensor<ui8>, tensor<2xui8>) -> tensor<2xui8>
    "func.return"(%3) : (tensor<2xui8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi32>) -> (), sym_name = "reverse"}> ({
  ^bb0(%arg0: tensor<5x4xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<5x4xi32>, index) -> index
    %2 = "tensor.empty"() : () -> tensor<5x4xi32>
    %3 = "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg2: i32):
      %14 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %15 = "arith.constant"() <{value = 1 : index}> : () -> index
      %16 = "arith.subi"(%1, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %17 = "arith.subi"(%16, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %18 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %19 = "tensor.extract"(%arg0, %17, %18) : (tensor<5x4xi32>, index, index) -> i32
      "linalg.yield"(%19) : (i32) -> ()
    }) : (tensor<5x4xi32>) -> tensor<5x4xi32>
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "tensor.dim"(%arg0, %4) : (tensor<5x4xi32>, index) -> index
    %6 = "tensor.empty"() : () -> tensor<5x4xi32>
    %7 = "linalg.generic"(%6) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg1: i32):
      %8 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %9 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %10 = "arith.constant"() <{value = 1 : index}> : () -> index
      %11 = "arith.subi"(%5, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.subi"(%11, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "tensor.extract"(%arg0, %8, %12) : (tensor<5x4xi32>, index, index) -> i32
      "linalg.yield"(%13) : (i32) -> ()
    }) : (tensor<5x4xi32>) -> tensor<5x4xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xi32>) -> (), sym_name = "reverse_dyn"}> ({
  ^bb0(%arg0: tensor<?xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?xi32>, index) -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<?xi32>, index) -> index
    %4 = "tensor.empty"(%1) : (index) -> tensor<?xi32>
    %5 = "linalg.generic"(%4) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg1: i32):
      %6 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %7 = "arith.constant"() <{value = 1 : index}> : () -> index
      %8 = "arith.subi"(%3, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %9 = "arith.subi"(%8, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %10 = "tensor.extract"(%arg0, %9) : (tensor<?xi32>, index) -> i32
      "linalg.yield"(%10) : (i32) -> ()
    }) : (tensor<?xi32>) -> tensor<?xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi8>) -> (), sym_name = "tile"}> ({
  ^bb0(%arg0: tensor<2x3xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "tensor.empty"() : () -> tensor<2x2x1x3xi8>
    %2 = "linalg.generic"(%arg0, %1) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: i8, %arg6: i8):
      "linalg.yield"(%arg5) : (i8) -> ()
    }) : (tensor<2x3xi8>, tensor<2x2x1x3xi8>) -> tensor<2x2x1x3xi8>
    %3 = "tosa.const_shape"() <{values = dense<[4, 3]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %4 = "tosa.reshape"(%2, %3) : (tensor<2x2x1x3xi8>, !tosa.shape<2>) -> tensor<4x3xi8>
    %5 = "tosa.const_shape"() <{values = dense<[1, 2]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %6 = "tensor.empty"() : () -> tensor<1x2x2x3xi8>
    %7 = "linalg.generic"(%arg0, %6) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i8, %arg4: i8):
      "linalg.yield"(%arg3) : (i8) -> ()
    }) : (tensor<2x3xi8>, tensor<1x2x2x3xi8>) -> tensor<1x2x2x3xi8>
    %8 = "tosa.const_shape"() <{values = dense<[2, 6]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %9 = "tosa.reshape"(%7, %8) : (tensor<1x2x2x3xi8>, !tosa.shape<2>) -> tensor<2x6xi8>
    %10 = "tosa.const_shape"() <{values = dense<[5, 7]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %11 = "tensor.empty"() : () -> tensor<5x2x7x3xi8>
    %12 = "linalg.generic"(%arg0, %11) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: i8):
      "linalg.yield"(%arg1) : (i8) -> ()
    }) : (tensor<2x3xi8>, tensor<5x2x7x3xi8>) -> tensor<5x2x7x3xi8>
    %13 = "tosa.const_shape"() <{values = dense<[10, 21]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %14 = "tosa.reshape"(%12, %13) : (tensor<5x2x7x3xi8>, !tosa.shape<2>) -> tensor<10x21xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x3xi8>) -> (), sym_name = "tile_dyn_input"}> ({
  ^bb0(%arg0: tensor<?x3xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<?x3xi8>, index) -> index
    %3 = "tensor.empty"(%2) : (index) -> tensor<2x?x1x3xi8>
    %4 = "linalg.generic"(%arg0, %3) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: i8):
      "linalg.yield"(%arg1) : (i8) -> ()
    }) : (tensor<?x3xi8>, tensor<2x?x1x3xi8>) -> tensor<2x?x1x3xi8>
    %5 = "tosa.const_shape"() <{values = dense<[-1, 3]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %6 = "tosa.reshape"(%4, %5) : (tensor<2x?x1x3xi8>, !tosa.shape<2>) -> tensor<?x3xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi8>) -> (), sym_name = "tile_dyn_multiples"}> ({
  ^bb0(%arg0: tensor<2x3xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, -1]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "tensor.dim"(%arg0, %1) : (tensor<2x3xi8>, index) -> index
    %3 = "tensor.empty"(%2) : (index) -> tensor<2x2x?x3xi8>
    %4 = "linalg.generic"(%arg0, %3) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: i8):
      "linalg.yield"(%arg1) : (i8) -> ()
    }) : (tensor<2x3xi8>, tensor<2x2x?x3xi8>) -> tensor<2x2x?x3xi8>
    %5 = "tosa.const_shape"() <{values = dense<[2, -1]> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %6 = "tosa.reshape"(%4, %5) : (tensor<2x2x?x3xi8>, !tosa.shape<2>) -> tensor<2x?xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
#map2 = affine_map<(d0, d1) -> (d0)>
#map3 = affine_map<(d0) -> (d0)>
#map4 = affine_map<(d0) -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x2xi32>, tensor<6xf32>) -> (), sym_name = "argmax"}> ({
  ^bb0(%arg0: tensor<3x2xi32>, %arg1: tensor<6xf32>):
    %0 = "tensor.empty"() : () -> tensor<2xi32>
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg21: i32, %arg22: i32):
      "linalg.yield"(%arg21) : (i32) -> ()
    }) : (i32, tensor<2xi32>) -> tensor<2xi32>
    %3 = "tensor.empty"() : () -> tensor<2xi32>
    %4 = "arith.constant"() <{value = -2147483648 : i32}> : () -> i32
    %5 = "linalg.fill"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg19: i32, %arg20: i32):
      "linalg.yield"(%arg19) : (i32) -> ()
    }) : (i32, tensor<2xi32>) -> tensor<2xi32>
    %6:2 = "linalg.generic"(%arg0, %2, %5) <{indexing_maps = [#map, #map1, #map1], iterator_types = [#linalg.iterator_type<reduction>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg16: i32, %arg17: i32, %arg18: i32):
      %33 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %34 = "arith.index_cast"(%33) : (index) -> i32
      %35 = "arith.cmpi"(%arg16, %arg18) <{predicate = 4 : i64}> : (i32, i32) -> i1
      %36 = "arith.select"(%35, %arg16, %arg18) : (i1, i32, i32) -> i32
      %37 = "arith.select"(%35, %34, %arg17) : (i1, i32, i32) -> i32
      "linalg.yield"(%37, %36) : (i32, i32) -> ()
    }) : (tensor<3x2xi32>, tensor<2xi32>, tensor<2xi32>) -> (tensor<2xi32>, tensor<2xi32>)
    %7 = "tensor.empty"() : () -> tensor<3xi32>
    %8 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %9 = "linalg.fill"(%8, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: i32, %arg15: i32):
      "linalg.yield"(%arg14) : (i32) -> ()
    }) : (i32, tensor<3xi32>) -> tensor<3xi32>
    %10 = "tensor.empty"() : () -> tensor<3xi32>
    %11 = "arith.constant"() <{value = -2147483648 : i32}> : () -> i32
    %12 = "linalg.fill"(%11, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: i32, %arg13: i32):
      "linalg.yield"(%arg12) : (i32) -> ()
    }) : (i32, tensor<3xi32>) -> tensor<3xi32>
    %13:2 = "linalg.generic"(%arg0, %9, %12) <{indexing_maps = [#map, #map2, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg9: i32, %arg10: i32, %arg11: i32):
      %28 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %29 = "arith.index_cast"(%28) : (index) -> i32
      %30 = "arith.cmpi"(%arg9, %arg11) <{predicate = 4 : i64}> : (i32, i32) -> i1
      %31 = "arith.select"(%30, %arg9, %arg11) : (i1, i32, i32) -> i32
      %32 = "arith.select"(%30, %29, %arg10) : (i1, i32, i32) -> i32
      "linalg.yield"(%32, %31) : (i32, i32) -> ()
    }) : (tensor<3x2xi32>, tensor<3xi32>, tensor<3xi32>) -> (tensor<3xi32>, tensor<3xi32>)
    %14 = "tensor.empty"() : () -> tensor<i32>
    %15 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %16 = "linalg.fill"(%15, %14) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      "linalg.yield"(%arg7) : (i32) -> ()
    }) : (i32, tensor<i32>) -> tensor<i32>
    %17 = "tensor.empty"() : () -> tensor<f32>
    %18 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %19 = "linalg.fill"(%18, %17) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<f32>) -> tensor<f32>
    %20:2 = "linalg.generic"(%arg1, %16, %19) <{indexing_maps = [#map3, #map4, #map4], iterator_types = [#linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg2: f32, %arg3: i32, %arg4: f32):
      %21 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %22 = "arith.index_cast"(%21) : (index) -> i32
      %23 = "arith.cmpf"(%arg2, %arg4) <{fastmath = #arith.fastmath<none>, predicate = 9 : i64}> : (f32, f32) -> i1
      %24 = "arith.cmpf"(%arg4, %arg4) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
      %25 = "arith.andi"(%23, %24) : (i1, i1) -> i1
      %26 = "arith.select"(%25, %arg2, %arg4) : (i1, f32, f32) -> f32
      %27 = "arith.select"(%25, %22, %arg3) : (i1, i32, i32) -> i32
      "linalg.yield"(%27, %26) : (i32, f32) -> ()
    }) : (tensor<6xf32>, tensor<i32>, tensor<f32>) -> (tensor<i32>, tensor<f32>)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x?xi32>) -> (), sym_name = "argmax_dyn_non_axis"}> ({
  ^bb0(%arg0: tensor<3x?xi32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<3x?xi32>, index) -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<?xi32>
    %3 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %4 = "linalg.fill"(%3, %2) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: i32, %arg7: i32):
      "linalg.yield"(%arg6) : (i32) -> ()
    }) : (i32, tensor<?xi32>) -> tensor<?xi32>
    %5 = "tensor.empty"(%1) : (index) -> tensor<?xi32>
    %6 = "arith.constant"() <{value = -2147483648 : i32}> : () -> i32
    %7 = "linalg.fill"(%6, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: i32, %arg5: i32):
      "linalg.yield"(%arg4) : (i32) -> ()
    }) : (i32, tensor<?xi32>) -> tensor<?xi32>
    %8:2 = "linalg.generic"(%arg0, %4, %7) <{indexing_maps = [#map, #map1, #map1], iterator_types = [#linalg.iterator_type<reduction>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32):
      %9 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %10 = "arith.index_cast"(%9) : (index) -> i32
      %11 = "arith.cmpi"(%arg1, %arg3) <{predicate = 4 : i64}> : (i32, i32) -> i1
      %12 = "arith.select"(%11, %arg1, %arg3) : (i1, i32, i32) -> i32
      %13 = "arith.select"(%11, %10, %arg2) : (i1, i32, i32) -> i32
      "linalg.yield"(%13, %12) : (i32, i32) -> ()
    }) : (tensor<3x?xi32>, tensor<?xi32>, tensor<?xi32>) -> (tensor<?xi32>, tensor<?xi32>)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x?xi32>) -> (), sym_name = "argmax_dyn_axis"}> ({
  ^bb0(%arg0: tensor<3x?xi32>):
    %0 = "tensor.empty"() : () -> tensor<3xi32>
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: i32, %arg7: i32):
      "linalg.yield"(%arg6) : (i32) -> ()
    }) : (i32, tensor<3xi32>) -> tensor<3xi32>
    %3 = "tensor.empty"() : () -> tensor<3xi32>
    %4 = "arith.constant"() <{value = -2147483648 : i32}> : () -> i32
    %5 = "linalg.fill"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: i32, %arg5: i32):
      "linalg.yield"(%arg4) : (i32) -> ()
    }) : (i32, tensor<3xi32>) -> tensor<3xi32>
    %6:2 = "linalg.generic"(%arg0, %2, %5) <{indexing_maps = [#map, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32):
      %7 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %8 = "arith.index_cast"(%7) : (index) -> i32
      %9 = "arith.cmpi"(%arg1, %arg3) <{predicate = 4 : i64}> : (i32, i32) -> i1
      %10 = "arith.select"(%9, %arg1, %arg3) : (i1, i32, i32) -> i32
      %11 = "arith.select"(%9, %8, %arg2) : (i1, i32, i32) -> i32
      "linalg.yield"(%11, %10) : (i32, i32) -> ()
    }) : (tensor<3x?xi32>, tensor<3xi32>, tensor<3xi32>) -> (tensor<3xi32>, tensor<3xi32>)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x2xf32>, tensor<2x3xi32>) -> (), sym_name = "gather_float"}> ({
  ^bb0(%arg0: tensor<2x3x2xf32>, %arg1: tensor<2x3xi32>):
    %0 = "tensor.empty"() : () -> tensor<2x3x2xf32>
    %1 = "linalg.generic"(%arg1, %0) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i32, %arg3: f32):
      %2 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %3 = "arith.index_cast"(%arg2) : (i32) -> index
      %4 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %5 = "tensor.extract"(%arg0, %2, %3, %4) : (tensor<2x3x2xf32>, index, index, index) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<2x3xi32>, tensor<2x3x2xf32>) -> tensor<2x3x2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x3x2xf32>, tensor<?x3xi32>) -> (), sym_name = "gather_float_dyn"}> ({
  ^bb0(%arg0: tensor<?x3x2xf32>, %arg1: tensor<?x3xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x3x2xf32>, index) -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<?x3x2xf32>
    %3 = "linalg.generic"(%arg1, %2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i32, %arg3: f32):
      %4 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %5 = "arith.index_cast"(%arg2) : (i32) -> index
      %6 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %7 = "tensor.extract"(%arg0, %4, %5, %6) : (tensor<?x3x2xf32>, index, index, index) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<?x3xi32>, tensor<?x3x2xf32>) -> tensor<?x3x2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, tensor<?x?xi32>) -> (), sym_name = "gather_float_all_dynamic"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x?x?xf32>, index) -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "tensor.dim"(%arg1, %2) : (tensor<?x?xi32>, index) -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "tensor.dim"(%arg0, %4) : (tensor<?x?x?xf32>, index) -> index
    %6 = "tensor.empty"(%1, %3, %5) : (index, index, index) -> tensor<?x?x?xf32>
    %7 = "linalg.generic"(%arg1, %6) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i32, %arg3: f32):
      %8 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %9 = "arith.index_cast"(%arg2) : (i32) -> index
      %10 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %11 = "tensor.extract"(%arg0, %8, %9, %10) : (tensor<?x?x?xf32>, index, index, index) -> f32
      "linalg.yield"(%11) : (f32) -> ()
    }) : (tensor<?x?xi32>, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3x2xi32>, tensor<2x3xi32>) -> (), sym_name = "gather_int"}> ({
  ^bb0(%arg0: tensor<2x3x2xi32>, %arg1: tensor<2x3xi32>):
    %0 = "tensor.empty"() : () -> tensor<2x3x2xi32>
    %1 = "linalg.generic"(%arg1, %0) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i32, %arg3: i32):
      %2 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %3 = "arith.index_cast"(%arg2) : (i32) -> index
      %4 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %5 = "tensor.extract"(%arg0, %2, %3, %4) : (tensor<2x3x2xi32>, index, index, index) -> i32
      "linalg.yield"(%5) : (i32) -> ()
    }) : (tensor<2x3xi32>, tensor<2x3x2xi32>) -> tensor<2x3x2xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6xi8>, tensor<512xi8>) -> (), sym_name = "table8"}> ({
  ^bb0(%arg0: tensor<6xi8>, %arg1: tensor<512xi8>):
    %0 = "tensor.empty"() : () -> tensor<6xi8>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i8, %arg3: i8):
      %2 = "arith.index_cast"(%arg2) : (i8) -> index
      %3 = "arith.constant"() <{value = 128 : index}> : () -> index
      %4 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "tensor.extract"(%arg1, %4) : (tensor<512xi8>, index) -> i8
      "linalg.yield"(%5) : (i8) -> ()
    }) : (tensor<6xi8>, tensor<6xi8>) -> tensor<6xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6xi16>, tensor<513xi16>) -> (), sym_name = "table16"}> ({
  ^bb0(%arg0: tensor<6xi16>, %arg1: tensor<513xi16>):
    %0 = "tensor.empty"() : () -> tensor<6xi32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i16, %arg3: i32):
      %2 = "arith.extsi"(%arg2) : (i16) -> i32
      %3 = "arith.constant"() <{value = 32768 : i32}> : () -> i32
      %4 = "arith.constant"() <{value = 7 : i32}> : () -> i32
      %5 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %6 = "arith.constant"() <{value = 127 : i32}> : () -> i32
      %7 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %8 = "arith.shrui"(%7, %4) : (i32, i32) -> i32
      %9 = "arith.andi"(%7, %6) : (i32, i32) -> i32
      %10 = "arith.addi"(%8, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %11 = "arith.index_cast"(%8) : (i32) -> index
      %12 = "arith.index_cast"(%10) : (i32) -> index
      %13 = "tensor.extract"(%arg1, %11) : (tensor<513xi16>, index) -> i16
      %14 = "tensor.extract"(%arg1, %12) : (tensor<513xi16>, index) -> i16
      %15 = "arith.extsi"(%13) : (i16) -> i32
      %16 = "arith.extsi"(%14) : (i16) -> i32
      %17 = "arith.shli"(%15, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %18 = "arith.subi"(%16, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %19 = "arith.muli"(%18, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %20 = "arith.addi"(%17, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%20) : (i32) -> ()
    }) : (tensor<6xi16>, tensor<6xi32>) -> tensor<6xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xi8>, tensor<512xi8>) -> (), sym_name = "table8_dyn"}> ({
  ^bb0(%arg0: tensor<?xi8>, %arg1: tensor<512xi8>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?xi8>, index) -> index
    %2 = "tensor.empty"(%1) : (index) -> tensor<?xi8>
    %3 = "linalg.generic"(%arg0, %2) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i8, %arg3: i8):
      %4 = "arith.index_cast"(%arg2) : (i8) -> index
      %5 = "arith.constant"() <{value = 128 : index}> : () -> index
      %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "tensor.extract"(%arg1, %6) : (tensor<512xi8>, index) -> i8
      "linalg.yield"(%7) : (i8) -> ()
    }) : (tensor<?xi8>, tensor<?xi8>) -> tensor<?xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<6xi8>, tensor<?xi8>) -> (), sym_name = "table8_dyn_table"}> ({
  ^bb0(%arg0: tensor<6xi8>, %arg1: tensor<?xi8>):
    %0 = "tensor.empty"() : () -> tensor<6xi8>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i8, %arg3: i8):
      %2 = "arith.index_cast"(%arg2) : (i8) -> index
      %3 = "arith.constant"() <{value = 128 : index}> : () -> index
      %4 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "tensor.extract"(%arg1, %4) : (tensor<?xi8>, index) -> i8
      "linalg.yield"(%5) : (i8) -> ()
    }) : (tensor<6xi8>, tensor<6xi8>) -> tensor<6xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d3, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4x8xf32>) -> (tensor<5x4x5xf32>, tensor<5x4x5xf32>), sym_name = "test_static_rfft2d"}> ({
  ^bb0(%arg0: tensor<5x4x8xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "arith.constant"() <{value = 4 : index}> : () -> index
    %4 = "arith.constant"() <{value = 5 : index}> : () -> index
    %5 = "tensor.empty"() : () -> tensor<5x4x5xf32>
    %6 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %7 = "linalg.fill"(%6, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<5x4x5xf32>) -> tensor<5x4x5xf32>
    %8 = "tensor.empty"() : () -> tensor<5x4x5xf32>
    %9 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %10 = "linalg.fill"(%9, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<5x4x5xf32>) -> tensor<5x4x5xf32>
    %11 = "arith.constant"() <{value = 1 : index}> : () -> index
    %12 = "arith.constant"() <{value = 4 : index}> : () -> index
    %13 = "arith.constant"() <{value = 2 : index}> : () -> index
    %14 = "arith.constant"() <{value = 8 : index}> : () -> index
    %15 = "arith.constant"() <{value = 6.28318548 : f32}> : () -> f32
    %16 = "arith.index_castui"(%12) : (index) -> i32
    %17 = "arith.uitofp"(%16) : (i32) -> f32
    %18 = "arith.index_castui"(%14) : (index) -> i32
    %19 = "arith.uitofp"(%18) : (i32) -> f32
    %20:2 = "linalg.generic"(%arg0, %7, %10) <{indexing_maps = [#map, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %21 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %22 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %23 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %24 = "linalg.index"() <{dim = 4 : i64}> : () -> index
      %25 = "index.mul"(%23, %21) : (index, index) -> index
      %26 = "index.mul"(%24, %22) : (index, index) -> index
      %27 = "index.remu"(%25, %12) : (index, index) -> index
      %28 = "index.remu"(%26, %14) : (index, index) -> index
      %29 = "arith.index_castui"(%27) : (index) -> i32
      %30 = "arith.uitofp"(%29) : (i32) -> f32
      %31 = "arith.index_castui"(%28) : (index) -> i32
      %32 = "arith.uitofp"(%31) : (i32) -> f32
      %33 = "arith.divf"(%30, %17) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %34 = "arith.divf"(%32, %19) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %35 = "arith.addf"(%33, %34) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %36 = "arith.mulf"(%15, %35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %37 = "math.cos"(%36) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %38 = "math.sin"(%36) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %39 = "arith.mulf"(%arg1, %37) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %40 = "arith.mulf"(%arg1, %38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %41 = "arith.addf"(%arg2, %39) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %42 = "arith.subf"(%arg3, %40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%41, %42) : (f32, f32) -> ()
    }) : (tensor<5x4x8xf32>, tensor<5x4x5xf32>, tensor<5x4x5xf32>) -> (tensor<5x4x5xf32>, tensor<5x4x5xf32>)
    "func.return"(%20#0, %20#1) : (tensor<5x4x5xf32>, tensor<5x4x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d3, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>), sym_name = "test_dynamic_rfft2d"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x?x?xf32>, index) -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<?x?x?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "tensor.dim"(%arg0, %4) : (tensor<?x?x?xf32>, index) -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.constant"() <{value = 2 : index}> : () -> index
    %8 = "arith.divui"(%5, %7) : (index, index) -> index
    %9 = "arith.addi"(%8, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %10 = "tensor.empty"(%1, %3, %9) : (index, index, index) -> tensor<?x?x?xf32>
    %11 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %12 = "linalg.fill"(%11, %10) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %13 = "tensor.empty"(%1, %3, %9) : (index, index, index) -> tensor<?x?x?xf32>
    %14 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %15 = "linalg.fill"(%14, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %16 = "arith.constant"() <{value = 1 : index}> : () -> index
    %17 = "tensor.dim"(%arg0, %16) : (tensor<?x?x?xf32>, index) -> index
    %18 = "arith.constant"() <{value = 2 : index}> : () -> index
    %19 = "tensor.dim"(%arg0, %18) : (tensor<?x?x?xf32>, index) -> index
    %20 = "arith.constant"() <{value = 6.28318548 : f32}> : () -> f32
    %21 = "arith.index_castui"(%17) : (index) -> i32
    %22 = "arith.uitofp"(%21) : (i32) -> f32
    %23 = "arith.index_castui"(%19) : (index) -> i32
    %24 = "arith.uitofp"(%23) : (i32) -> f32
    %25:2 = "linalg.generic"(%arg0, %12, %15) <{indexing_maps = [#map, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %26 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %27 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %28 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %29 = "linalg.index"() <{dim = 4 : i64}> : () -> index
      %30 = "index.mul"(%28, %26) : (index, index) -> index
      %31 = "index.mul"(%29, %27) : (index, index) -> index
      %32 = "index.remu"(%30, %17) : (index, index) -> index
      %33 = "index.remu"(%31, %19) : (index, index) -> index
      %34 = "arith.index_castui"(%32) : (index) -> i32
      %35 = "arith.uitofp"(%34) : (i32) -> f32
      %36 = "arith.index_castui"(%33) : (index) -> i32
      %37 = "arith.uitofp"(%36) : (i32) -> f32
      %38 = "arith.divf"(%35, %22) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %39 = "arith.divf"(%37, %24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %40 = "arith.addf"(%38, %39) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %41 = "arith.mulf"(%20, %40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %42 = "math.cos"(%41) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %43 = "math.sin"(%41) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %44 = "arith.mulf"(%arg1, %42) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %45 = "arith.mulf"(%arg1, %43) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %46 = "arith.addf"(%arg2, %44) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %47 = "arith.subf"(%arg3, %45) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%46, %47) : (f32, f32) -> ()
    }) : (tensor<?x?x?xf32>, tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>)
    "func.return"(%25#0, %25#1) : (tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d3, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x8x8xf32>, tensor<8x8x8xf32>) -> (tensor<8x8x8xf32>, tensor<8x8x8xf32>), sym_name = "test_static_fft2d"}> ({
  ^bb0(%arg0: tensor<8x8x8xf32>, %arg1: tensor<8x8x8xf32>):
    %0 = "tensor.empty"() : () -> tensor<8x8x8xf32>
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<8x8x8xf32>) -> tensor<8x8x8xf32>
    %3 = "tensor.empty"() : () -> tensor<8x8x8xf32>
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "linalg.fill"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<8x8x8xf32>) -> tensor<8x8x8xf32>
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "arith.constant"() <{value = 8 : index}> : () -> index
    %8 = "arith.constant"() <{value = 2 : index}> : () -> index
    %9 = "arith.constant"() <{value = 8 : index}> : () -> index
    %10 = "arith.constant"() <{value = 6.28318548 : f32}> : () -> f32
    %11 = "arith.index_castui"(%7) : (index) -> i32
    %12 = "arith.uitofp"(%11) : (i32) -> f32
    %13 = "arith.index_castui"(%9) : (index) -> i32
    %14 = "arith.uitofp"(%13) : (i32) -> f32
    %15:2 = "linalg.generic"(%arg0, %arg1, %2, %5) <{indexing_maps = [#map, #map, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 2, 2>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32, %arg5: f32):
      %16 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %17 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %18 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %19 = "linalg.index"() <{dim = 4 : i64}> : () -> index
      %20 = "index.mul"(%18, %16) : (index, index) -> index
      %21 = "index.mul"(%19, %17) : (index, index) -> index
      %22 = "index.remu"(%20, %7) : (index, index) -> index
      %23 = "index.remu"(%21, %9) : (index, index) -> index
      %24 = "arith.index_castui"(%22) : (index) -> i32
      %25 = "arith.uitofp"(%24) : (i32) -> f32
      %26 = "arith.index_castui"(%23) : (index) -> i32
      %27 = "arith.uitofp"(%26) : (i32) -> f32
      %28 = "arith.divf"(%25, %12) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %29 = "arith.divf"(%27, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %30 = "arith.addf"(%28, %29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %31 = "arith.mulf"(%10, %30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %32 = "math.cos"(%31) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %33 = "math.sin"(%31) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %34 = "arith.mulf"(%arg2, %32) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %35 = "arith.mulf"(%arg3, %33) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %36 = "arith.addf"(%34, %35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %37 = "arith.mulf"(%arg3, %32) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %38 = "arith.mulf"(%arg2, %33) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %39 = "arith.subf"(%37, %38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %40 = "arith.addf"(%arg4, %36) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %41 = "arith.addf"(%arg5, %39) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%40, %41) : (f32, f32) -> ()
    }) : (tensor<8x8x8xf32>, tensor<8x8x8xf32>, tensor<8x8x8xf32>, tensor<8x8x8xf32>) -> (tensor<8x8x8xf32>, tensor<8x8x8xf32>)
    "func.return"(%15#0, %15#1) : (tensor<8x8x8xf32>, tensor<8x8x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d3, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>), sym_name = "test_dynamic_fft2d"}> ({
  ^bb0(%arg0: tensor<?x?x?xf32>, %arg1: tensor<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "tensor.dim"(%arg0, %0) : (tensor<?x?x?xf32>, index) -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "tensor.dim"(%arg0, %2) : (tensor<?x?x?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "tensor.dim"(%arg0, %4) : (tensor<?x?x?xf32>, index) -> index
    %6 = "tensor.empty"(%1, %3, %5) : (index, index, index) -> tensor<?x?x?xf32>
    %7 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %8 = "linalg.fill"(%7, %6) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg8: f32, %arg9: f32):
      "linalg.yield"(%arg8) : (f32) -> ()
    }) : (f32, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %9 = "tensor.empty"(%1, %3, %5) : (index, index, index) -> tensor<?x?x?xf32>
    %10 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %11 = "linalg.fill"(%10, %9) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<?x?x?xf32>) -> tensor<?x?x?xf32>
    %12 = "arith.constant"() <{value = 1 : index}> : () -> index
    %13 = "tensor.dim"(%arg0, %12) : (tensor<?x?x?xf32>, index) -> index
    %14 = "arith.constant"() <{value = 2 : index}> : () -> index
    %15 = "tensor.dim"(%arg0, %14) : (tensor<?x?x?xf32>, index) -> index
    %16 = "arith.constant"() <{value = 6.28318548 : f32}> : () -> f32
    %17 = "arith.index_castui"(%13) : (index) -> i32
    %18 = "arith.uitofp"(%17) : (i32) -> f32
    %19 = "arith.index_castui"(%15) : (index) -> i32
    %20 = "arith.uitofp"(%19) : (i32) -> f32
    %21:2 = "linalg.generic"(%arg0, %arg1, %8, %11) <{indexing_maps = [#map, #map, #map1, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<reduction>, #linalg.iterator_type<reduction>], operandSegmentSizes = array<i32: 2, 2>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32, %arg5: f32):
      %22 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %23 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %24 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %25 = "linalg.index"() <{dim = 4 : i64}> : () -> index
      %26 = "index.mul"(%24, %22) : (index, index) -> index
      %27 = "index.mul"(%25, %23) : (index, index) -> index
      %28 = "index.remu"(%26, %13) : (index, index) -> index
      %29 = "index.remu"(%27, %15) : (index, index) -> index
      %30 = "arith.index_castui"(%28) : (index) -> i32
      %31 = "arith.uitofp"(%30) : (i32) -> f32
      %32 = "arith.index_castui"(%29) : (index) -> i32
      %33 = "arith.uitofp"(%32) : (i32) -> f32
      %34 = "arith.divf"(%31, %18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %35 = "arith.divf"(%33, %20) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %36 = "arith.addf"(%34, %35) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %37 = "arith.mulf"(%16, %36) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %38 = "arith.constant"() <{value = -1.000000e+00 : f32}> : () -> f32
      %39 = "arith.mulf"(%37, %38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %40 = "math.cos"(%39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %41 = "math.sin"(%39) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %42 = "arith.mulf"(%arg2, %40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %43 = "arith.mulf"(%arg3, %41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %44 = "arith.addf"(%42, %43) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %45 = "arith.mulf"(%arg3, %40) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %46 = "arith.mulf"(%arg2, %41) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %47 = "arith.subf"(%45, %46) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %48 = "arith.addf"(%arg4, %44) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %49 = "arith.addf"(%arg5, %47) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%48, %49) : (f32, f32) -> ()
    }) : (tensor<?x?x?xf32>, tensor<?x?x?xf32>, tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> (tensor<?x?x?xf32>, tensor<?x?x?xf32>)
    "func.return"(%21#0, %21#1) : (tensor<?x?x?xf32>, tensor<?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1xf32>) -> tensor<1xi64>, sym_name = "test_cast_fp32_i64"}> ({
  ^bb0(%arg0: tensor<1xf32>):
    %0 = "tensor.empty"() : () -> tensor<1xi64>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: i64):
      %2 = "math.roundeven"(%arg1) <{fastmath = #arith.fastmath<none>}> : (f32) -> f32
      %3 = "arith.constant"() <{value = -9.22337203E+18 : f32}> : () -> f32
      %4 = "arith.constant"() <{value = 9.22337203E+18 : f32}> : () -> f32
      %5 = "arith.constant"() <{value = 9223372036854775807 : i64}> : () -> i64
      %6 = "arith.maximumf"(%2, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.fptosi"(%6) : (f32) -> i64
      %8 = "arith.cmpf"(%2, %4) <{fastmath = #arith.fastmath<none>, predicate = 10 : i64}> : (f32, f32) -> i1
      %9 = "arith.select"(%8, %5, %7) : (i1, i64, i64) -> i64
      "linalg.yield"(%9) : (i64) -> ()
    }) : (tensor<1xf32>, tensor<1xi64>) -> tensor<1xi64>
    "func.return"(%1) : (tensor<1xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "reduce_min_nan_propagate"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tensor.empty"() : () -> tensor<4xf32>
    %1 = "arith.constant"() <{value = 3.40282347E+38 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %3 = "linalg.reduce"(%arg0, %2) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %5 = "arith.minimumf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<5x4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xf32>) -> tensor<1x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "reduce_max_nan_propagate"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tensor.empty"() : () -> tensor<4xf32>
    %1 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %3 = "linalg.reduce"(%arg0, %2) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %5 = "arith.maximumf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<5x4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xf32>) -> tensor<1x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi8>, tensor<5x4xi8>) -> (), sym_name = "reduce_min_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>):
    %0 = "tensor.empty"() : () -> tensor<4xi8>
    %1 = "arith.constant"() <{value = 127 : i8}> : () -> i8
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: i8, %arg5: i8):
      "linalg.yield"(%arg4) : (i8) -> ()
    }) : (i8, tensor<4xi8>) -> tensor<4xi8>
    %3 = "linalg.reduce"(%arg0, %2) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg2: i8, %arg3: i8):
      %5 = "arith.minsi"(%arg2, %arg3) : (i8, i8) -> i8
      "linalg.yield"(%5) : (i8) -> ()
    }) : (tensor<5x4xi8>, tensor<4xi8>) -> tensor<4xi8>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xi8>) -> tensor<1x4xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi8>, tensor<5x4xi8>) -> (), sym_name = "reduce_max_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>):
    %0 = "tensor.empty"() : () -> tensor<4xi8>
    %1 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: i8, %arg5: i8):
      "linalg.yield"(%arg4) : (i8) -> ()
    }) : (i8, tensor<4xi8>) -> tensor<4xi8>
    %3 = "linalg.reduce"(%arg0, %2) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg2: i8, %arg3: i8):
      %5 = "arith.maxsi"(%arg2, %arg3) : (i8, i8) -> i8
      "linalg.yield"(%5) : (i8) -> ()
    }) : (tensor<5x4xi8>, tensor<4xi8>) -> tensor<4xi8>
    %4 = "tensor.expand_shape"(%3) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xi8>) -> tensor<1x4xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "reduce_min_nan_ignore"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tensor.empty"() : () -> tensor<4xf32>
    %1 = "arith.constant"() <{value = 3.40282347E+38 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      "linalg.yield"(%arg14) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %3 = "arith.constant"() <{value = true}> : () -> i1
    %4 = "tensor.empty"() : () -> tensor<4xi1>
    %5 = "linalg.fill"(%3, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: i1, %arg13: i1):
      "linalg.yield"(%arg12) : (i1) -> ()
    }) : (i1, tensor<4xi1>) -> tensor<4xi1>
    %6:2 = "linalg.reduce"(%arg0, %arg0, %2, %5) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg8: f32, %arg9: f32, %arg10: f32, %arg11: i1):
      %14 = "arith.minimumf"(%arg8, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %15 = "arith.cmpf"(%arg8, %arg8) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
      %16 = "arith.select"(%15, %arg10, %14) : (i1, f32, f32) -> f32
      %17 = "arith.andi"(%arg11, %15) : (i1, i1) -> i1
      "linalg.yield"(%16, %17) : (f32, i1) -> ()
    }) : (tensor<5x4xf32>, tensor<5x4xf32>, tensor<4xf32>, tensor<4xi1>) -> (tensor<4xf32>, tensor<4xi1>)
    %7 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %8 = "tensor.empty"() : () -> tensor<4xf32>
    %9 = "linalg.fill"(%7, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %10 = "tensor.empty"() : () -> tensor<4xf32>
    %11 = "linalg.select"(%6#1, %9, %6#0, %10) <{operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg2: i1, %arg3: f32, %arg4: f32, %arg5: f32):
      %13 = "arith.select"(%arg2, %arg3, %arg4) : (i1, f32, f32) -> f32
      "linalg.yield"(%13) : (f32) -> ()
    }) : (tensor<4xi1>, tensor<4xf32>, tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %12 = "tensor.expand_shape"(%11) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xf32>) -> tensor<1x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "reduce_max_nan_ignore"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tensor.empty"() : () -> tensor<4xf32>
    %1 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg14: f32, %arg15: f32):
      "linalg.yield"(%arg14) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %3 = "arith.constant"() <{value = true}> : () -> i1
    %4 = "tensor.empty"() : () -> tensor<4xi1>
    %5 = "linalg.fill"(%3, %4) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg12: i1, %arg13: i1):
      "linalg.yield"(%arg12) : (i1) -> ()
    }) : (i1, tensor<4xi1>) -> tensor<4xi1>
    %6:2 = "linalg.reduce"(%arg0, %arg0, %2, %5) <{dimensions = array<i64: 0>}> ({
    ^bb0(%arg8: f32, %arg9: f32, %arg10: f32, %arg11: i1):
      %14 = "arith.maximumf"(%arg8, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %15 = "arith.cmpf"(%arg8, %arg8) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
      %16 = "arith.select"(%15, %arg10, %14) : (i1, f32, f32) -> f32
      %17 = "arith.andi"(%arg11, %15) : (i1, i1) -> i1
      "linalg.yield"(%16, %17) : (f32, i1) -> ()
    }) : (tensor<5x4xf32>, tensor<5x4xf32>, tensor<4xf32>, tensor<4xi1>) -> (tensor<4xf32>, tensor<4xi1>)
    %7 = "arith.constant"() <{value = 0x7FC00000 : f32}> : () -> f32
    %8 = "tensor.empty"() : () -> tensor<4xf32>
    %9 = "linalg.fill"(%7, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32):
      "linalg.yield"(%arg6) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %10 = "tensor.empty"() : () -> tensor<4xf32>
    %11 = "linalg.select"(%6#1, %9, %6#0, %10) <{operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg2: i1, %arg3: f32, %arg4: f32, %arg5: f32):
      %13 = "arith.select"(%arg2, %arg3, %arg4) : (i1, f32, f32) -> f32
      "linalg.yield"(%13) : (f32) -> ()
    }) : (tensor<4xi1>, tensor<4xf32>, tensor<4xf32>, tensor<4xf32>) -> tensor<4xf32>
    %12 = "tensor.expand_shape"(%11) <{reassociation = [[0, 1]], static_output_shape = array<i64: 1, 4>}> : (tensor<4xf32>) -> tensor<1x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "minimum_nan_propagate"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tensor.empty"() : () -> tensor<5x4xf32>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %2 = "arith.minimumf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<5x4xf32>, tensor<5x4xf32>, tensor<5x4xf32>) -> tensor<5x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "maximum_nan_propagate"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tensor.empty"() : () -> tensor<5x4xf32>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %2 = "arith.maximumf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (tensor<5x4xf32>, tensor<5x4xf32>, tensor<5x4xf32>) -> tensor<5x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi8>, tensor<5x4xi8>) -> (), sym_name = "minimum_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>):
    %0 = "tensor.empty"() : () -> tensor<5x4xi8>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: i8, %arg3: i8, %arg4: i8):
      %2 = "arith.minsi"(%arg2, %arg3) : (i8, i8) -> i8
      "linalg.yield"(%2) : (i8) -> ()
    }) : (tensor<5x4xi8>, tensor<5x4xi8>, tensor<5x4xi8>) -> tensor<5x4xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi8>, tensor<5x4xi8>) -> (), sym_name = "maximum_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>):
    %0 = "tensor.empty"() : () -> tensor<5x4xi8>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: i8, %arg3: i8, %arg4: i8):
      %2 = "arith.maxsi"(%arg2, %arg3) : (i8, i8) -> i8
      "linalg.yield"(%2) : (i8) -> ()
    }) : (tensor<5x4xi8>, tensor<5x4xi8>, tensor<5x4xi8>) -> tensor<5x4xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "minimum_nan_ignore"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tensor.empty"() : () -> tensor<5x4xf32>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %2 = "arith.minimumf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %3 = "arith.cmpf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
      %4 = "arith.cmpf"(%arg3, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
      %5 = "arith.select"(%3, %arg3, %2) : (i1, f32, f32) -> f32
      %6 = "arith.select"(%4, %arg2, %5) : (i1, f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<5x4xf32>, tensor<5x4xf32>, tensor<5x4xf32>) -> tensor<5x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "maximum_nan_ignore"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tensor.empty"() : () -> tensor<5x4xf32>
    %1 = "linalg.generic"(%arg0, %arg1, %0) <{indexing_maps = [#map, #map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32, %arg4: f32):
      %2 = "arith.maximumf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %3 = "arith.cmpf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
      %4 = "arith.cmpf"(%arg3, %arg3) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
      %5 = "arith.select"(%3, %arg3, %2) : (i1, f32, f32) -> f32
      %6 = "arith.select"(%4, %arg2, %5) : (i1, f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (tensor<5x4xf32>, tensor<5x4xf32>, tensor<5x4xf32>) -> tensor<5x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "argmax_nan_propagate"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tensor.empty"() : () -> tensor<4xi32>
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      "linalg.yield"(%arg7) : (i32) -> ()
    }) : (i32, tensor<4xi32>) -> tensor<4xi32>
    %3 = "tensor.empty"() : () -> tensor<4xf32>
    %4 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %5 = "linalg.fill"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %6:2 = "linalg.generic"(%arg0, %2, %5) <{indexing_maps = [#map, #map1, #map1], iterator_types = [#linalg.iterator_type<reduction>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg2: f32, %arg3: i32, %arg4: f32):
      %7 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %8 = "arith.index_cast"(%7) : (index) -> i32
      %9 = "arith.cmpf"(%arg2, %arg4) <{fastmath = #arith.fastmath<none>, predicate = 9 : i64}> : (f32, f32) -> i1
      %10 = "arith.cmpf"(%arg4, %arg4) <{fastmath = #arith.fastmath<none>, predicate = 7 : i64}> : (f32, f32) -> i1
      %11 = "arith.andi"(%9, %10) : (i1, i1) -> i1
      %12 = "arith.select"(%11, %arg2, %arg4) : (i1, f32, f32) -> f32
      %13 = "arith.select"(%11, %8, %arg3) : (i1, i32, i32) -> i32
      "linalg.yield"(%13, %12) : (i32, f32) -> ()
    }) : (tensor<5x4xf32>, tensor<4xi32>, tensor<4xf32>) -> (tensor<4xi32>, tensor<4xf32>)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi8>, tensor<5x4xi8>) -> (), sym_name = "argmax_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>):
    %0 = "tensor.empty"() : () -> tensor<4xi32>
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      "linalg.yield"(%arg7) : (i32) -> ()
    }) : (i32, tensor<4xi32>) -> tensor<4xi32>
    %3 = "tensor.empty"() : () -> tensor<4xi8>
    %4 = "arith.constant"() <{value = -128 : i8}> : () -> i8
    %5 = "linalg.fill"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: i8, %arg6: i8):
      "linalg.yield"(%arg5) : (i8) -> ()
    }) : (i8, tensor<4xi8>) -> tensor<4xi8>
    %6:2 = "linalg.generic"(%arg0, %2, %5) <{indexing_maps = [#map, #map1, #map1], iterator_types = [#linalg.iterator_type<reduction>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg2: i8, %arg3: i32, %arg4: i8):
      %7 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %8 = "arith.index_cast"(%7) : (index) -> i32
      %9 = "arith.cmpi"(%arg2, %arg4) <{predicate = 4 : i64}> : (i8, i8) -> i1
      %10 = "arith.select"(%9, %arg2, %arg4) : (i1, i8, i8) -> i8
      %11 = "arith.select"(%9, %8, %arg3) : (i1, i32, i32) -> i32
      "linalg.yield"(%11, %10) : (i32, i8) -> ()
    }) : (tensor<5x4xi8>, tensor<4xi32>, tensor<4xi8>) -> (tensor<4xi32>, tensor<4xi8>)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "argmax_nan_ignore"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tensor.empty"() : () -> tensor<4xi32>
    %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
    %2 = "linalg.fill"(%1, %0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg7: i32, %arg8: i32):
      "linalg.yield"(%arg7) : (i32) -> ()
    }) : (i32, tensor<4xi32>) -> tensor<4xi32>
    %3 = "tensor.empty"() : () -> tensor<4xf32>
    %4 = "arith.constant"() <{value = -3.40282347E+38 : f32}> : () -> f32
    %5 = "linalg.fill"(%4, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg5: f32, %arg6: f32):
      "linalg.yield"(%arg5) : (f32) -> ()
    }) : (f32, tensor<4xf32>) -> tensor<4xf32>
    %6:2 = "linalg.generic"(%arg0, %2, %5) <{indexing_maps = [#map, #map1, #map1], iterator_types = [#linalg.iterator_type<reduction>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 2>}> ({
    ^bb0(%arg2: f32, %arg3: i32, %arg4: f32):
      %7 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %8 = "arith.index_cast"(%7) : (index) -> i32
      %9 = "arith.cmpf"(%arg2, %arg4) <{fastmath = #arith.fastmath<none>, predicate = 2 : i64}> : (f32, f32) -> i1
      %10 = "arith.select"(%9, %arg2, %arg4) : (i1, f32, f32) -> f32
      %11 = "arith.select"(%9, %8, %arg3) : (i1, i32, i32) -> i32
      "linalg.yield"(%11, %10) : (i32, f32) -> ()
    }) : (tensor<5x4xf32>, tensor<4xi32>, tensor<4xf32>) -> (tensor<4xi32>, tensor<4xf32>)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "clamp_nan_propagate"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tensor.empty"() : () -> tensor<5x4xf32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %3 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
      %4 = "arith.minimumf"(%arg2, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %5 = "arith.maximumf"(%4, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%5) : (f32) -> ()
    }) : (tensor<5x4xf32>, tensor<5x4xf32>) -> tensor<5x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xi8>, tensor<5x4xi8>) -> (), sym_name = "clamp_nan_ignore_int"}> ({
  ^bb0(%arg0: tensor<5x4xi8>, %arg1: tensor<5x4xi8>):
    %0 = "tensor.empty"() : () -> tensor<5x4xi8>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: i8, %arg3: i8):
      %2 = "arith.constant"() <{value = 1 : i8}> : () -> i8
      %3 = "arith.constant"() <{value = 5 : i8}> : () -> i8
      %4 = "arith.maxsi"(%2, %arg2) : (i8, i8) -> i8
      %5 = "arith.minsi"(%3, %4) : (i8, i8) -> i8
      "linalg.yield"(%5) : (i8) -> ()
    }) : (tensor<5x4xi8>, tensor<5x4xi8>) -> tensor<5x4xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5x4xf32>, tensor<5x4xf32>) -> (), sym_name = "clamp_nan_ignore"}> ({
  ^bb0(%arg0: tensor<5x4xf32>, %arg1: tensor<5x4xf32>):
    %0 = "tensor.empty"() : () -> tensor<5x4xf32>
    %1 = "linalg.generic"(%arg0, %0) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %2 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %3 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
      %4 = "arith.minimumf"(%arg2, %3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %5 = "arith.maximumf"(%4, %2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %6 = "arith.cmpf"(%arg2, %arg2) <{fastmath = #arith.fastmath<none>, predicate = 14 : i64}> : (f32, f32) -> i1
      %7 = "arith.select"(%6, %2, %5) : (i1, f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (tensor<5x4xf32>, tensor<5x4xf32>) -> tensor<5x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> ()>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<i32>) -> (), sym_name = "test_0d_input"}> ({
  ^bb0(%arg0: tensor<i32>):
    %0 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tensor.empty"() : () -> tensor<i32>
    %2 = "linalg.generic"(%arg0, %arg0, %1) <{indexing_maps = [#map, #map, #map], iterator_types = [], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i32):
      %15 = "arith.muli"(%arg3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%15) : (i32) -> ()
    }) : (tensor<i32>, tensor<i32>, tensor<i32>) -> tensor<i32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = "tensor.empty"() : () -> tensor<i32>
    %6 = "linalg.generic"(%arg0, %5) <{indexing_maps = [#map, #map], iterator_types = [], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i32, %arg2: i32):
      %7 = "arith.constant"() <{value = 0 : i64}> : () -> i64
      %8 = "arith.extsi"(%arg1) : (i32) -> i64
      %9 = "arith.subi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %10 = "arith.constant"() <{value = -2147483648 : i64}> : () -> i64
      %11 = "arith.constant"() <{value = 2147483647 : i64}> : () -> i64
      %12 = "arith.maxsi"(%10, %9) : (i64, i64) -> i64
      %13 = "arith.minsi"(%11, %12) : (i64, i64) -> i64
      %14 = "arith.trunci"(%13) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      "linalg.yield"(%14) : (i32) -> ()
    }) : (tensor<i32>, tensor<i32>) -> tensor<i32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x3xi32>, tensor<2x3xi32>, tensor<1xi8>) -> tensor<2x3xi32>, sym_name = "mul_no_const_shift"}> ({
  ^bb0(%arg0: tensor<2x3xi32>, %arg1: tensor<2x3xi32>, %arg2: tensor<1xi8>):
    %0 = "tensor.empty"() : () -> tensor<2x3xi32>
    %1 = "linalg.generic"(%arg0, %arg1, %arg2, %0) <{indexing_maps = [#map, #map, #map1, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg3: i32, %arg4: i32, %arg5: i8, %arg6: i32):
      %2 = "tosa.apply_scale"(%arg3, %arg4, %arg5) <{rounding_mode = #tosa.rounding_mode<SINGLE_ROUND>}> : (i32, i32, i8) -> i32
      "linalg.yield"(%2) : (i32) -> ()
    }) : (tensor<2x3xi32>, tensor<2x3xi32>, tensor<1xi8>, tensor<2x3xi32>) -> tensor<2x3xi32>
    "func.return"(%1) : (tensor<2x3xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (0)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xi64>, tensor<1xi64>, tensor<1xi64>) -> tensor<4xi64>, sym_name = "negate_i64_no_noop_cast"}> ({
  ^bb0(%arg0: tensor<4xi64>, %arg1: tensor<1xi64>, %arg2: tensor<1xi64>):
    %0 = "tensor.empty"() : () -> tensor<4xi64>
    %1 = "linalg.generic"(%arg0, %arg1, %arg2, %0) <{indexing_maps = [#map, #map1, #map1, #map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 3, 1>}> ({
    ^bb0(%arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64):
      %2 = "arith.addi"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %3 = "arith.subi"(%2, %arg3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %4 = "arith.constant"() <{value = -9223372036854775808 : i64}> : () -> i64
      %5 = "arith.constant"() <{value = 9223372036854775807 : i64}> : () -> i64
      %6 = "arith.maxsi"(%4, %3) : (i64, i64) -> i64
      %7 = "arith.minsi"(%5, %6) : (i64, i64) -> i64
      "linalg.yield"(%7) : (i64) -> ()
    }) : (tensor<4xi64>, tensor<1xi64>, tensor<1xi64>, tensor<4xi64>) -> tensor<4xi64>
    "func.return"(%1) : (tensor<4xi64>) -> ()
  }) : () -> ()
}) : () -> ()

