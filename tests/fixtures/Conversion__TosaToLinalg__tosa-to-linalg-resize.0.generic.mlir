"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xf32>) -> tensor<3x1x1x7xf32>, sym_name = "unary_resize_nearest_fp32"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    "func.return"(%arg0) : (tensor<3x1x1x7xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xbf16>) -> tensor<3x1x1x7xbf16>, sym_name = "unary_resize_nearest_bf16"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xbf16>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    "func.return"(%arg0) : (tensor<3x1x1x7xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xf16>) -> tensor<3x1x1x7xf16>, sym_name = "unary_resize_nearest_fp16"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xf16>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    "func.return"(%arg0) : (tensor<3x1x1x7xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xf32>) -> tensor<3x1x1x7xf32>, sym_name = "unary_resize_bilinear_fp32"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    "func.return"(%arg0) : (tensor<3x1x1x7xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xbf16>) -> tensor<3x1x1x7xbf16>, sym_name = "unary_resize_bilinear_bf16"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xbf16>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    "func.return"(%arg0) : (tensor<3x1x1x7xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xf16>) -> tensor<3x1x1x7xf16>, sym_name = "unary_resize_bilinear_fp16"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xf16>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 2, 1, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    "func.return"(%arg0) : (tensor<3x1x1x7xf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xi8>) -> tensor<3x1x1x7xi8>, sym_name = "unary_resize_nearest_i8"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1, 3, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    "func.return"(%arg0) : (tensor<3x1x1x7xi8>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xbf16>) -> tensor<3x1x5x7xbf16>, sym_name = "broadcast_resize_nearest_bf16"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xbf16>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1, 3, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0], [1, 2, 3]]}> : (tensor<3x1x1x7xbf16>) -> tensor<3x7xbf16>
    %4 = "tensor.empty"() : () -> tensor<3x1x5x7xbf16>
    %5 = "linalg.generic"(%3, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: bf16, %arg2: bf16):
      "linalg.yield"(%arg1) : (bf16) -> ()
    }) : (tensor<3x7xbf16>, tensor<3x1x5x7xbf16>) -> tensor<3x1x5x7xbf16>
    "func.return"(%5) : (tensor<3x1x5x7xbf16>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xf32>) -> tensor<3x1x5x7xf32>, sym_name = "broadcast_resize_nearest_f32"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1, 3, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0], [1, 2, 3]]}> : (tensor<3x1x1x7xf32>) -> tensor<3x7xf32>
    %4 = "tensor.empty"() : () -> tensor<3x1x5x7xf32>
    %5 = "linalg.generic"(%3, %4) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (tensor<3x7xf32>, tensor<3x1x5x7xf32>) -> tensor<3x1x5x7xf32>
    "func.return"(%5) : (tensor<3x1x5x7xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xi8>) -> tensor<3x4x5x7xi32>, sym_name = "broadcast_resize_bilinear_i8"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1, 3, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0], [1, 2, 3]]}> : (tensor<3x1x1x7xi8>) -> tensor<3x7xi8>
    %4 = "tensor.empty"() : () -> tensor<3x7xi32>
    %5 = "linalg.generic"(%3, %4) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i8, %arg4: i32):
      %10 = "arith.extsi"(%arg3) : (i8) -> i32
      %11 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %12 = "arith.muli"(%10, %11) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %13 = "arith.constant"() <{value = 3 : i32}> : () -> i32
      %14 = "arith.muli"(%12, %13) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%14) : (i32) -> ()
    }) : (tensor<3x7xi8>, tensor<3x7xi32>) -> tensor<3x7xi32>
    %6 = "tensor.expand_shape"(%5) <{reassociation = [[0], [1, 2, 3]], static_output_shape = array<i64: 3, 1, 1, 7>}> : (tensor<3x7xi32>) -> tensor<3x1x1x7xi32>
    %7 = "tensor.collapse_shape"(%6) <{reassociation = [[0], [1, 2, 3]]}> : (tensor<3x1x1x7xi32>) -> tensor<3x7xi32>
    %8 = "tensor.empty"() : () -> tensor<3x4x5x7xi32>
    %9 = "linalg.generic"(%7, %8) <{indexing_maps = [#map1, #map2], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i32, %arg2: i32):
      "linalg.yield"(%arg1) : (i32) -> ()
    }) : (tensor<3x7xi32>, tensor<3x4x5x7xi32>) -> tensor<3x4x5x7xi32>
    "func.return"(%9) : (tensor<3x4x5x7xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x1x7xi8>) -> tensor<3x1x1x7xi32>, sym_name = "unary_resize_bilinear_i32"}> ({
  ^bb0(%arg0: tensor<3x1x1x7xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1, 2, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0], [1, 2, 3]]}> : (tensor<3x1x1x7xi8>) -> tensor<3x7xi8>
    %4 = "tensor.empty"() : () -> tensor<3x7xi32>
    %5 = "linalg.generic"(%3, %4) <{indexing_maps = [#map, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: i8, %arg2: i32):
      %7 = "arith.extsi"(%arg1) : (i8) -> i32
      %8 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %9 = "arith.muli"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %10 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %11 = "arith.muli"(%9, %10) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%11) : (i32) -> ()
    }) : (tensor<3x7xi8>, tensor<3x7xi32>) -> tensor<3x7xi32>
    %6 = "tensor.expand_shape"(%5) <{reassociation = [[0], [1, 2, 3]], static_output_shape = array<i64: 3, 1, 1, 7>}> : (tensor<3x7xi32>) -> tensor<3x1x1x7xi32>
    "func.return"(%6) : (tensor<3x1x1x7xi32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x15x13x1xi8>) -> (), sym_name = "resize_nearest_int"}> ({
  ^bb0(%arg0: tensor<1x15x13x1xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[11, 7, 89, 6]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tensor.empty"() : () -> tensor<1x23x179x1xi8>
    %4 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg1: i8):
      %5 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %6 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %7 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %8 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %9 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %10 = "arith.constant"() <{value = 0 : i8}> : () -> i8
      %11 = "arith.constant"() <{value = 14 : i32}> : () -> i32
      %12 = "arith.constant"() <{value = 12 : i32}> : () -> i32
      %13 = "arith.index_cast"(%6) : (index) -> i32
      %14 = "arith.index_cast"(%7) : (index) -> i32
      %15 = "arith.constant"() <{value = 11 : i32}> : () -> i32
      %16 = "arith.constant"() <{value = 7 : i32}> : () -> i32
      %17 = "arith.constant"() <{value = 89 : i32}> : () -> i32
      %18 = "arith.constant"() <{value = 6 : i32}> : () -> i32
      %19 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %20 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %21 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %22 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %23 = "arith.muli"(%13, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %24 = "arith.addi"(%23, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %25 = "arith.floordivsi"(%24, %15) : (i32, i32) -> i32
      %26 = "arith.muli"(%25, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %27 = "arith.subi"(%24, %26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %28 = "arith.muli"(%14, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %29 = "arith.addi"(%28, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %30 = "arith.floordivsi"(%29, %17) : (i32, i32) -> i32
      %31 = "arith.muli"(%30, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %32 = "arith.subi"(%29, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %33 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %34 = "arith.shli"(%27, %33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %35 = "arith.cmpi"(%34, %15) <{predicate = 5 : i64}> : (i32, i32) -> i1
      %36 = "arith.select"(%35, %33, %9) : (i1, i32, i32) -> i32
      %37 = "arith.addi"(%25, %36) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %38 = "arith.maxsi"(%9, %37) : (i32, i32) -> i32
      %39 = "arith.minsi"(%11, %38) : (i32, i32) -> i32
      %40 = "arith.index_cast"(%39) : (i32) -> index
      %41 = "arith.shli"(%32, %33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %42 = "arith.cmpi"(%41, %17) <{predicate = 5 : i64}> : (i32, i32) -> i1
      %43 = "arith.select"(%42, %33, %9) : (i1, i32, i32) -> i32
      %44 = "arith.addi"(%30, %43) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %45 = "arith.maxsi"(%9, %44) : (i32, i32) -> i32
      %46 = "arith.minsi"(%12, %45) : (i32, i32) -> i32
      %47 = "arith.index_cast"(%46) : (i32) -> index
      %48 = "tensor.extract"(%arg0, %5, %40, %47, %8) : (tensor<1x15x13x1xi8>, index, index, index, index) -> i8
      "linalg.yield"(%48) : (i8) -> ()
    }) : (tensor<1x23x179x1xi8>) -> tensor<1x23x179x1xi8>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x19x20x1xi8>) -> (), sym_name = "resize_bilinear_int"}> ({
  ^bb0(%arg0: tensor<1x19x20x1xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[16, 1, 16, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tensor.empty"() : () -> tensor<1x289x305x1xi48>
    %4 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg1: i48):
      %5 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %6 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %7 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %8 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %9 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %10 = "arith.constant"() <{value = 0 : i48}> : () -> i48
      %11 = "arith.constant"() <{value = 18 : i32}> : () -> i32
      %12 = "arith.constant"() <{value = 19 : i32}> : () -> i32
      %13 = "arith.index_cast"(%6) : (index) -> i32
      %14 = "arith.index_cast"(%7) : (index) -> i32
      %15 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %16 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %17 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %18 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %19 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %20 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %21 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %22 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %23 = "arith.muli"(%13, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %24 = "arith.addi"(%23, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %25 = "arith.floordivsi"(%24, %15) : (i32, i32) -> i32
      %26 = "arith.muli"(%25, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %27 = "arith.subi"(%24, %26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %28 = "arith.muli"(%14, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %29 = "arith.addi"(%28, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %30 = "arith.floordivsi"(%29, %17) : (i32, i32) -> i32
      %31 = "arith.muli"(%30, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %32 = "arith.subi"(%29, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %33 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %34 = "arith.addi"(%25, %33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %35 = "arith.maxsi"(%9, %25) : (i32, i32) -> i32
      %36 = "arith.minsi"(%11, %35) : (i32, i32) -> i32
      %37 = "arith.maxsi"(%9, %34) : (i32, i32) -> i32
      %38 = "arith.minsi"(%11, %37) : (i32, i32) -> i32
      %39 = "arith.index_cast"(%36) : (i32) -> index
      %40 = "arith.index_cast"(%38) : (i32) -> index
      %41 = "arith.addi"(%30, %33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %42 = "arith.maxsi"(%9, %30) : (i32, i32) -> i32
      %43 = "arith.minsi"(%12, %42) : (i32, i32) -> i32
      %44 = "arith.maxsi"(%9, %41) : (i32, i32) -> i32
      %45 = "arith.minsi"(%12, %44) : (i32, i32) -> i32
      %46 = "arith.index_cast"(%43) : (i32) -> index
      %47 = "arith.index_cast"(%45) : (i32) -> index
      %48 = "tensor.extract"(%arg0, %5, %39, %46, %8) : (tensor<1x19x20x1xi8>, index, index, index, index) -> i8
      %49 = "tensor.extract"(%arg0, %5, %39, %47, %8) : (tensor<1x19x20x1xi8>, index, index, index, index) -> i8
      %50 = "tensor.extract"(%arg0, %5, %40, %46, %8) : (tensor<1x19x20x1xi8>, index, index, index, index) -> i8
      %51 = "tensor.extract"(%arg0, %5, %40, %47, %8) : (tensor<1x19x20x1xi8>, index, index, index, index) -> i8
      %52 = "arith.extsi"(%48) : (i8) -> i48
      %53 = "arith.extsi"(%49) : (i8) -> i48
      %54 = "arith.extsi"(%50) : (i8) -> i48
      %55 = "arith.extsi"(%51) : (i8) -> i48
      %56 = "arith.extsi"(%32) : (i32) -> i48
      %57 = "arith.extsi"(%27) : (i32) -> i48
      %58 = "arith.extsi"(%15) : (i32) -> i48
      %59 = "arith.extsi"(%17) : (i32) -> i48
      %60 = "arith.subi"(%59, %56) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %61 = "arith.muli"(%52, %60) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %62 = "arith.muli"(%53, %56) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %63 = "arith.addi"(%61, %62) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %64 = "arith.subi"(%59, %56) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %65 = "arith.muli"(%54, %64) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %66 = "arith.muli"(%55, %56) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %67 = "arith.addi"(%65, %66) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %68 = "arith.subi"(%58, %57) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %69 = "arith.muli"(%63, %68) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %70 = "arith.muli"(%67, %57) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %71 = "arith.addi"(%69, %70) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      "linalg.yield"(%71) : (i48) -> ()
    }) : (tensor<1x289x305x1xi48>) -> tensor<1x289x305x1xi48>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x50x48x1xf32>) -> (), sym_name = "resize_nearest_fp32"}> ({
  ^bb0(%arg0: tensor<1x50x48x1xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[64, 2, 64, 2]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<-31> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<31> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tensor.empty"() : () -> tensor<1x1600x1536x1xf32>
    %4 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg1: f32):
      %5 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %6 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %7 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %8 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %9 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %10 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %11 = "arith.constant"() <{value = 49 : i32}> : () -> i32
      %12 = "arith.constant"() <{value = 47 : i32}> : () -> i32
      %13 = "arith.index_cast"(%6) : (index) -> i32
      %14 = "arith.index_cast"(%7) : (index) -> i32
      %15 = "arith.constant"() <{value = 64 : i32}> : () -> i32
      %16 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %17 = "arith.constant"() <{value = 64 : i32}> : () -> i32
      %18 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %19 = "arith.constant"() <{value = -31 : i32}> : () -> i32
      %20 = "arith.constant"() <{value = -31 : i32}> : () -> i32
      %21 = "arith.constant"() <{value = 31 : i32}> : () -> i32
      %22 = "arith.constant"() <{value = 31 : i32}> : () -> i32
      %23 = "arith.muli"(%13, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %24 = "arith.addi"(%23, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %25 = "arith.floordivsi"(%24, %15) : (i32, i32) -> i32
      %26 = "arith.muli"(%25, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %27 = "arith.subi"(%24, %26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %28 = "arith.sitofp"(%27) : (i32) -> f32
      %29 = "arith.uitofp"(%15) : (i32) -> f32
      %30 = "arith.divf"(%28, %29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %31 = "arith.muli"(%14, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %32 = "arith.addi"(%31, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %33 = "arith.floordivsi"(%32, %17) : (i32, i32) -> i32
      %34 = "arith.muli"(%33, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %35 = "arith.subi"(%32, %34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %36 = "arith.sitofp"(%35) : (i32) -> f32
      %37 = "arith.uitofp"(%17) : (i32) -> f32
      %38 = "arith.divf"(%36, %37) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %39 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %40 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %41 = "arith.cmpf"(%30, %40) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (f32, f32) -> i1
      %42 = "arith.select"(%41, %39, %9) : (i1, i32, i32) -> i32
      %43 = "arith.addi"(%25, %42) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %44 = "arith.maxsi"(%9, %43) : (i32, i32) -> i32
      %45 = "arith.minsi"(%11, %44) : (i32, i32) -> i32
      %46 = "arith.index_cast"(%45) : (i32) -> index
      %47 = "arith.constant"() <{value = 5.000000e-01 : f32}> : () -> f32
      %48 = "arith.cmpf"(%38, %47) <{fastmath = #arith.fastmath<none>, predicate = 3 : i64}> : (f32, f32) -> i1
      %49 = "arith.select"(%48, %39, %9) : (i1, i32, i32) -> i32
      %50 = "arith.addi"(%33, %49) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %51 = "arith.maxsi"(%9, %50) : (i32, i32) -> i32
      %52 = "arith.minsi"(%12, %51) : (i32, i32) -> i32
      %53 = "arith.index_cast"(%52) : (i32) -> index
      %54 = "tensor.extract"(%arg0, %5, %46, %53, %8) : (tensor<1x50x48x1xf32>, index, index, index, index) -> f32
      "linalg.yield"(%54) : (f32) -> ()
    }) : (tensor<1x1600x1536x1xf32>) -> tensor<1x1600x1536x1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x23x24x1xf32>) -> (), sym_name = "resize_bilinear_fp"}> ({
  ^bb0(%arg0: tensor<1x23x24x1xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[4, 1, 4, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tensor.empty"() : () -> tensor<1x89x93x1xf32>
    %4 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg1: f32):
      %5 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %6 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %7 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %8 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %9 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %10 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %11 = "arith.constant"() <{value = 22 : i32}> : () -> i32
      %12 = "arith.constant"() <{value = 23 : i32}> : () -> i32
      %13 = "arith.index_cast"(%6) : (index) -> i32
      %14 = "arith.index_cast"(%7) : (index) -> i32
      %15 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %16 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %17 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %18 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %19 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %20 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %21 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %22 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %23 = "arith.muli"(%13, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %24 = "arith.addi"(%23, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %25 = "arith.floordivsi"(%24, %15) : (i32, i32) -> i32
      %26 = "arith.muli"(%25, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %27 = "arith.subi"(%24, %26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %28 = "arith.sitofp"(%27) : (i32) -> f32
      %29 = "arith.uitofp"(%15) : (i32) -> f32
      %30 = "arith.divf"(%28, %29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %31 = "arith.muli"(%14, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %32 = "arith.addi"(%31, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %33 = "arith.floordivsi"(%32, %17) : (i32, i32) -> i32
      %34 = "arith.muli"(%33, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %35 = "arith.subi"(%32, %34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %36 = "arith.sitofp"(%35) : (i32) -> f32
      %37 = "arith.uitofp"(%17) : (i32) -> f32
      %38 = "arith.divf"(%36, %37) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %39 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %40 = "arith.addi"(%25, %39) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %41 = "arith.maxsi"(%9, %25) : (i32, i32) -> i32
      %42 = "arith.minsi"(%11, %41) : (i32, i32) -> i32
      %43 = "arith.maxsi"(%9, %40) : (i32, i32) -> i32
      %44 = "arith.minsi"(%11, %43) : (i32, i32) -> i32
      %45 = "arith.index_cast"(%42) : (i32) -> index
      %46 = "arith.index_cast"(%44) : (i32) -> index
      %47 = "arith.addi"(%33, %39) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %48 = "arith.maxsi"(%9, %33) : (i32, i32) -> i32
      %49 = "arith.minsi"(%12, %48) : (i32, i32) -> i32
      %50 = "arith.maxsi"(%9, %47) : (i32, i32) -> i32
      %51 = "arith.minsi"(%12, %50) : (i32, i32) -> i32
      %52 = "arith.index_cast"(%49) : (i32) -> index
      %53 = "arith.index_cast"(%51) : (i32) -> index
      %54 = "tensor.extract"(%arg0, %5, %45, %52, %8) : (tensor<1x23x24x1xf32>, index, index, index, index) -> f32
      %55 = "tensor.extract"(%arg0, %5, %45, %53, %8) : (tensor<1x23x24x1xf32>, index, index, index, index) -> f32
      %56 = "tensor.extract"(%arg0, %5, %46, %52, %8) : (tensor<1x23x24x1xf32>, index, index, index, index) -> f32
      %57 = "tensor.extract"(%arg0, %5, %46, %53, %8) : (tensor<1x23x24x1xf32>, index, index, index, index) -> f32
      %58 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %59 = "arith.subf"(%58, %38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %60 = "arith.mulf"(%54, %59) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %61 = "arith.mulf"(%55, %38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %62 = "arith.addf"(%60, %61) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %63 = "arith.subf"(%58, %38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %64 = "arith.mulf"(%56, %63) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %65 = "arith.mulf"(%57, %38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %66 = "arith.addf"(%64, %65) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %67 = "arith.subf"(%58, %30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %68 = "arith.mulf"(%62, %67) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %69 = "arith.mulf"(%66, %30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %70 = "arith.addf"(%68, %69) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%70) : (f32) -> ()
    }) : (tensor<1x89x93x1xf32>) -> tensor<1x89x93x1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x2x2x1xi8>) -> (), sym_name = "resize_dyn"}> ({
  ^bb0(%arg0: tensor<?x2x2x1xi8>):
    %0 = "tosa.const_shape"() <{values = dense<[4, 2, 4, 2]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<-1> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<1> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "tensor.dim"(%arg0, %3) : (tensor<?x2x2x1xi8>, index) -> index
    %5 = "tensor.empty"(%4) : (index) -> tensor<?x4x4x1xi32>
    %6 = "linalg.generic"(%5) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg1: i32):
      %7 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %8 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %9 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %10 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %11 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %12 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %13 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %14 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %15 = "arith.index_cast"(%8) : (index) -> i32
      %16 = "arith.index_cast"(%9) : (index) -> i32
      %17 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %18 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %19 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %20 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %21 = "arith.constant"() <{value = -1 : i32}> : () -> i32
      %22 = "arith.constant"() <{value = -1 : i32}> : () -> i32
      %23 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %24 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %25 = "arith.muli"(%15, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %26 = "arith.addi"(%25, %21) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %27 = "arith.floordivsi"(%26, %17) : (i32, i32) -> i32
      %28 = "arith.muli"(%27, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %29 = "arith.subi"(%26, %28) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %30 = "arith.muli"(%16, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %31 = "arith.addi"(%30, %22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %32 = "arith.floordivsi"(%31, %19) : (i32, i32) -> i32
      %33 = "arith.muli"(%32, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %34 = "arith.subi"(%31, %33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %35 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %36 = "arith.addi"(%27, %35) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %37 = "arith.maxsi"(%11, %27) : (i32, i32) -> i32
      %38 = "arith.minsi"(%13, %37) : (i32, i32) -> i32
      %39 = "arith.maxsi"(%11, %36) : (i32, i32) -> i32
      %40 = "arith.minsi"(%13, %39) : (i32, i32) -> i32
      %41 = "arith.index_cast"(%38) : (i32) -> index
      %42 = "arith.index_cast"(%40) : (i32) -> index
      %43 = "arith.addi"(%32, %35) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %44 = "arith.maxsi"(%11, %32) : (i32, i32) -> i32
      %45 = "arith.minsi"(%14, %44) : (i32, i32) -> i32
      %46 = "arith.maxsi"(%11, %43) : (i32, i32) -> i32
      %47 = "arith.minsi"(%14, %46) : (i32, i32) -> i32
      %48 = "arith.index_cast"(%45) : (i32) -> index
      %49 = "arith.index_cast"(%47) : (i32) -> index
      %50 = "tensor.extract"(%arg0, %7, %41, %48, %10) : (tensor<?x2x2x1xi8>, index, index, index, index) -> i8
      %51 = "tensor.extract"(%arg0, %7, %41, %49, %10) : (tensor<?x2x2x1xi8>, index, index, index, index) -> i8
      %52 = "tensor.extract"(%arg0, %7, %42, %48, %10) : (tensor<?x2x2x1xi8>, index, index, index, index) -> i8
      %53 = "tensor.extract"(%arg0, %7, %42, %49, %10) : (tensor<?x2x2x1xi8>, index, index, index, index) -> i8
      %54 = "arith.extsi"(%50) : (i8) -> i32
      %55 = "arith.extsi"(%51) : (i8) -> i32
      %56 = "arith.extsi"(%52) : (i8) -> i32
      %57 = "arith.extsi"(%53) : (i8) -> i32
      %58 = "arith.subi"(%19, %34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %59 = "arith.muli"(%54, %58) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %60 = "arith.muli"(%55, %34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %61 = "arith.addi"(%59, %60) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %62 = "arith.subi"(%19, %34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %63 = "arith.muli"(%56, %62) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %64 = "arith.muli"(%57, %34) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %65 = "arith.addi"(%63, %64) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %66 = "arith.subi"(%17, %29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %67 = "arith.muli"(%61, %66) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %68 = "arith.muli"(%65, %29) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %69 = "arith.addi"(%67, %68) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%69) : (i32) -> ()
    }) : (tensor<?x4x4x1xi32>) -> tensor<?x4x4x1xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x19x19x1xi16>) -> (), sym_name = "resize_bilinear_int48"}> ({
  ^bb0(%arg0: tensor<1x19x19x1xi16>):
    %0 = "tosa.const_shape"() <{values = dense<[16, 1, 16, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tensor.empty"() : () -> tensor<1x289x289x1xi48>
    %4 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg1: i48):
      %5 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %6 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %7 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %8 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %9 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %10 = "arith.constant"() <{value = 0 : i48}> : () -> i48
      %11 = "arith.constant"() <{value = 18 : i32}> : () -> i32
      %12 = "arith.constant"() <{value = 18 : i32}> : () -> i32
      %13 = "arith.index_cast"(%6) : (index) -> i32
      %14 = "arith.index_cast"(%7) : (index) -> i32
      %15 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %16 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %17 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %18 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %19 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %20 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %21 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %22 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %23 = "arith.muli"(%13, %16) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %24 = "arith.addi"(%23, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %25 = "arith.floordivsi"(%24, %15) : (i32, i32) -> i32
      %26 = "arith.muli"(%25, %15) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %27 = "arith.subi"(%24, %26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %28 = "arith.muli"(%14, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %29 = "arith.addi"(%28, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %30 = "arith.floordivsi"(%29, %17) : (i32, i32) -> i32
      %31 = "arith.muli"(%30, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %32 = "arith.subi"(%29, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %33 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %34 = "arith.addi"(%25, %33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %35 = "arith.maxsi"(%9, %25) : (i32, i32) -> i32
      %36 = "arith.minsi"(%11, %35) : (i32, i32) -> i32
      %37 = "arith.maxsi"(%9, %34) : (i32, i32) -> i32
      %38 = "arith.minsi"(%11, %37) : (i32, i32) -> i32
      %39 = "arith.index_cast"(%36) : (i32) -> index
      %40 = "arith.index_cast"(%38) : (i32) -> index
      %41 = "arith.addi"(%30, %33) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %42 = "arith.maxsi"(%9, %30) : (i32, i32) -> i32
      %43 = "arith.minsi"(%12, %42) : (i32, i32) -> i32
      %44 = "arith.maxsi"(%9, %41) : (i32, i32) -> i32
      %45 = "arith.minsi"(%12, %44) : (i32, i32) -> i32
      %46 = "arith.index_cast"(%43) : (i32) -> index
      %47 = "arith.index_cast"(%45) : (i32) -> index
      %48 = "tensor.extract"(%arg0, %5, %39, %46, %8) : (tensor<1x19x19x1xi16>, index, index, index, index) -> i16
      %49 = "tensor.extract"(%arg0, %5, %39, %47, %8) : (tensor<1x19x19x1xi16>, index, index, index, index) -> i16
      %50 = "tensor.extract"(%arg0, %5, %40, %46, %8) : (tensor<1x19x19x1xi16>, index, index, index, index) -> i16
      %51 = "tensor.extract"(%arg0, %5, %40, %47, %8) : (tensor<1x19x19x1xi16>, index, index, index, index) -> i16
      %52 = "arith.extsi"(%48) : (i16) -> i48
      %53 = "arith.extsi"(%49) : (i16) -> i48
      %54 = "arith.extsi"(%50) : (i16) -> i48
      %55 = "arith.extsi"(%51) : (i16) -> i48
      %56 = "arith.extsi"(%32) : (i32) -> i48
      %57 = "arith.extsi"(%27) : (i32) -> i48
      %58 = "arith.extsi"(%15) : (i32) -> i48
      %59 = "arith.extsi"(%17) : (i32) -> i48
      %60 = "arith.subi"(%59, %56) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %61 = "arith.muli"(%52, %60) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %62 = "arith.muli"(%53, %56) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %63 = "arith.addi"(%61, %62) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %64 = "arith.subi"(%59, %56) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %65 = "arith.muli"(%54, %64) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %66 = "arith.muli"(%55, %56) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %67 = "arith.addi"(%65, %66) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %68 = "arith.subi"(%58, %57) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %69 = "arith.muli"(%63, %68) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %70 = "arith.muli"(%67, %57) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      %71 = "arith.addi"(%69, %70) <{overflowFlags = #arith.overflow<none>}> : (i48, i48) -> i48
      "linalg.yield"(%71) : (i48) -> ()
    }) : (tensor<1x289x289x1xi48>) -> tensor<1x289x289x1xi48>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<3x1x2x7xi8>) -> tensor<3x1x4x7xi32>, sym_name = "skip_interpolate_bilinear_i8"}> ({
  ^bb0(%arg2: tensor<3x1x2x7xi8>):
    %59 = "tosa.const_shape"() <{values = dense<[2, 1, 3, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %60 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %61 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %62 = "tensor.empty"() : () -> tensor<3x1x4x7xi32>
    %63 = "linalg.generic"(%62) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg3: i32):
      %64 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %65 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %66 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %67 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %68 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %69 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %70 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %71 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %72 = "arith.index_cast"(%65) : (index) -> i32
      %73 = "arith.index_cast"(%66) : (index) -> i32
      %74 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %75 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %76 = "arith.constant"() <{value = 3 : i32}> : () -> i32
      %77 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %78 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %79 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %80 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %81 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %82 = "arith.muli"(%73, %77) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %83 = "arith.addi"(%82, %79) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %84 = "arith.floordivsi"(%83, %76) : (i32, i32) -> i32
      %85 = "arith.muli"(%84, %76) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %86 = "arith.subi"(%83, %85) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %87 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %88 = "arith.addi"(%68, %87) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %89 = "arith.maxsi"(%68, %68) : (i32, i32) -> i32
      %90 = "arith.minsi"(%70, %89) : (i32, i32) -> i32
      %91 = "arith.maxsi"(%68, %88) : (i32, i32) -> i32
      %92 = "arith.minsi"(%70, %91) : (i32, i32) -> i32
      %93 = "arith.index_cast"(%90) : (i32) -> index
      %94 = "arith.index_cast"(%92) : (i32) -> index
      %95 = "arith.addi"(%84, %87) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %96 = "arith.maxsi"(%68, %84) : (i32, i32) -> i32
      %97 = "arith.minsi"(%71, %96) : (i32, i32) -> i32
      %98 = "arith.maxsi"(%68, %95) : (i32, i32) -> i32
      %99 = "arith.minsi"(%71, %98) : (i32, i32) -> i32
      %100 = "arith.index_cast"(%97) : (i32) -> index
      %101 = "arith.index_cast"(%99) : (i32) -> index
      %102 = "tensor.extract"(%arg2, %64, %93, %100, %67) : (tensor<3x1x2x7xi8>, index, index, index, index) -> i8
      %103 = "tensor.extract"(%arg2, %64, %93, %101, %67) : (tensor<3x1x2x7xi8>, index, index, index, index) -> i8
      %104 = "tensor.extract"(%arg2, %64, %94, %100, %67) : (tensor<3x1x2x7xi8>, index, index, index, index) -> i8
      %105 = "tensor.extract"(%arg2, %64, %94, %101, %67) : (tensor<3x1x2x7xi8>, index, index, index, index) -> i8
      %106 = "arith.extsi"(%102) : (i8) -> i32
      %107 = "arith.extsi"(%103) : (i8) -> i32
      %108 = "arith.extsi"(%104) : (i8) -> i32
      %109 = "arith.extsi"(%105) : (i8) -> i32
      %110 = "arith.subi"(%76, %86) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %111 = "arith.muli"(%106, %110) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %112 = "arith.muli"(%107, %86) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %113 = "arith.addi"(%111, %112) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %114 = "arith.subi"(%76, %86) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %115 = "arith.muli"(%108, %114) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %116 = "arith.muli"(%109, %86) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %117 = "arith.addi"(%115, %116) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %118 = "arith.muli"(%113, %74) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      "linalg.yield"(%118) : (i32) -> ()
    }) : (tensor<3x1x4x7xi32>) -> tensor<3x1x4x7xi32>
    "func.return"(%63) : (tensor<3x1x4x7xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (tensor<3x1x2x7xf32>) -> tensor<3x1x4x7xf32>, sym_name = "skip_interpolate_bilinear_f32"}> ({
  ^bb0(%arg0: tensor<3x1x2x7xf32>):
    %0 = "tosa.const_shape"() <{values = dense<[2, 1, 3, 1]> : tensor<4xindex>}> : () -> !tosa.shape<4>
    %1 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %2 = "tosa.const_shape"() <{values = dense<0> : tensor<2xindex>}> : () -> !tosa.shape<2>
    %3 = "tensor.empty"() : () -> tensor<3x1x4x7xf32>
    %4 = "linalg.generic"(%3) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg1: f32):
      %5 = "linalg.index"() <{dim = 0 : i64}> : () -> index
      %6 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %7 = "linalg.index"() <{dim = 2 : i64}> : () -> index
      %8 = "linalg.index"() <{dim = 3 : i64}> : () -> index
      %9 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %10 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %11 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %12 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %13 = "arith.index_cast"(%6) : (index) -> i32
      %14 = "arith.index_cast"(%7) : (index) -> i32
      %15 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %16 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %17 = "arith.constant"() <{value = 3 : i32}> : () -> i32
      %18 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %19 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %20 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %21 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %22 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %23 = "arith.muli"(%14, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %24 = "arith.addi"(%23, %20) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %25 = "arith.floordivsi"(%24, %17) : (i32, i32) -> i32
      %26 = "arith.muli"(%25, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %27 = "arith.subi"(%24, %26) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %28 = "arith.sitofp"(%27) : (i32) -> f32
      %29 = "arith.uitofp"(%17) : (i32) -> f32
      %30 = "arith.divf"(%28, %29) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %31 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %32 = "arith.addi"(%9, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %33 = "arith.maxsi"(%9, %9) : (i32, i32) -> i32
      %34 = "arith.minsi"(%11, %33) : (i32, i32) -> i32
      %35 = "arith.maxsi"(%9, %32) : (i32, i32) -> i32
      %36 = "arith.minsi"(%11, %35) : (i32, i32) -> i32
      %37 = "arith.index_cast"(%34) : (i32) -> index
      %38 = "arith.index_cast"(%36) : (i32) -> index
      %39 = "arith.addi"(%25, %31) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %40 = "arith.maxsi"(%9, %25) : (i32, i32) -> i32
      %41 = "arith.minsi"(%12, %40) : (i32, i32) -> i32
      %42 = "arith.maxsi"(%9, %39) : (i32, i32) -> i32
      %43 = "arith.minsi"(%12, %42) : (i32, i32) -> i32
      %44 = "arith.index_cast"(%41) : (i32) -> index
      %45 = "arith.index_cast"(%43) : (i32) -> index
      %46 = "tensor.extract"(%arg0, %5, %37, %44, %8) : (tensor<3x1x2x7xf32>, index, index, index, index) -> f32
      %47 = "tensor.extract"(%arg0, %5, %37, %45, %8) : (tensor<3x1x2x7xf32>, index, index, index, index) -> f32
      %48 = "tensor.extract"(%arg0, %5, %38, %44, %8) : (tensor<3x1x2x7xf32>, index, index, index, index) -> f32
      %49 = "tensor.extract"(%arg0, %5, %38, %45, %8) : (tensor<3x1x2x7xf32>, index, index, index, index) -> f32
      %50 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %51 = "arith.subf"(%50, %30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %52 = "arith.mulf"(%46, %51) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %53 = "arith.mulf"(%47, %30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %54 = "arith.addf"(%52, %53) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %55 = "arith.subf"(%50, %30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %56 = "arith.mulf"(%48, %55) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %57 = "arith.mulf"(%49, %30) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %58 = "arith.addf"(%56, %57) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%54) : (f32) -> ()
    }) : (tensor<3x1x4x7xf32>) -> tensor<3x1x4x7xf32>
    "func.return"(%4) : (tensor<3x1x4x7xf32>) -> ()
  }) : () -> ()
}) : () -> ()

