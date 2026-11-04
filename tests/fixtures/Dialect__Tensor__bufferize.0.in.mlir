"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, index) -> index, sym_name = "dim"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: index):
    %0 = "tensor.dim"(%arg0, %arg1) : (tensor<*xf32>, index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>) -> index, sym_name = "rank"}> ({
  ^bb0(%arg0: tensor<*xf32>):
    %0 = "tensor.rank"(%arg0) : (tensor<*xf32>) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xindex>) -> tensor<2xindex>, sym_name = "tensor.cast"}> ({
  ^bb0(%arg0: tensor<?xindex>):
    %0 = "tensor.cast"(%arg0) : (tensor<?xindex>) -> tensor<2xindex>
    "func.return"(%0) : (tensor<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>) -> tensor<2xf32>, sym_name = "tensor.cast_from_unranked"}> ({
  ^bb0(%arg0: tensor<*xf32>):
    %0 = "tensor.cast"(%arg0) : (tensor<*xf32>) -> tensor<2xf32>
    "func.return"(%0) : (tensor<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xf32>) -> tensor<*xf32>, sym_name = "tensor.cast_to_unranked"}> ({
  ^bb0(%arg0: tensor<2xf32>):
    %0 = "tensor.cast"(%arg0) : (tensor<2xf32>) -> tensor<*xf32>
    "func.return"(%0) : (tensor<*xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> tensor<5xf32>, sym_name = "tensor.empty"}> ({
    %0 = "tensor.empty"() : () -> tensor<5xf32>
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index) -> f32, sym_name = "tensor.extract"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index):
    %0 = "tensor.extract"(%arg0, %arg1) : (tensor<?xf32>, index) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> tensor<index>, sym_name = "tensor.from_elements_0d"}> ({
  ^bb0(%arg0: index):
    %0 = "tensor.from_elements"(%arg0) : (index) -> tensor<index>
    "func.return"(%0) : (tensor<index>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> tensor<2xindex>, sym_name = "tensor.from_elements_1d"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "tensor.from_elements"(%arg0, %arg1) : (index, index) -> tensor<2xindex>
    "func.return"(%0) : (tensor<2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> tensor<3x2xindex>, sym_name = "tensor.from_elements_2d"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "tensor.from_elements"(%arg0, %arg1, %arg0, %arg1, %arg0, %arg1) : (index, index, index, index, index, index) -> tensor<3x2xindex>
    "func.return"(%0) : (tensor<3x2xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> tensor<3x2x2xf32>, sym_name = "tensor.from_elements_3d"}> ({
  ^bb0(%arg0: f32):
    %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 2.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 3.000000e+00 : f32}> : () -> f32
    %3 = "arith.constant"() <{value = 4.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 5.000000e+00 : f32}> : () -> f32
    %5 = "arith.constant"() <{value = 6.000000e+00 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 7.000000e+00 : f32}> : () -> f32
    %7 = "arith.constant"() <{value = 8.000000e+00 : f32}> : () -> f32
    %8 = "arith.constant"() <{value = 9.000000e+00 : f32}> : () -> f32
    %9 = "arith.constant"() <{value = 1.000000e+01 : f32}> : () -> f32
    %10 = "arith.constant"() <{value = 1.100000e+01 : f32}> : () -> f32
    %11 = "tensor.from_elements"(%arg0, %0, %1, %2, %3, %4, %5, %6, %7, %8, %9, %10) : (f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32, f32) -> tensor<3x2x2xf32>
    "func.return"(%11) : (tensor<3x2x2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<*xf32>, index) -> tensor<?xindex>, sym_name = "tensor.generate"}> ({
  ^bb0(%arg0: tensor<*xf32>, %arg1: index):
    %0 = "tensor.generate"(%arg1) ({
    ^bb0(%arg2: index):
      %1 = "tensor.dim"(%arg0, %arg2) : (tensor<*xf32>, index) -> index
      "tensor.yield"(%1) : (index) -> ()
    }) : (index) -> tensor<?xindex>
    "func.return"(%0) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> tensor<16x?xindex>, sym_name = "tensor.generate_static_and_dynamic"}> ({
  ^bb0(%arg0: index):
    %0 = "tensor.generate"(%arg0) ({
    ^bb0(%arg1: index, %arg2: index):
      %1 = "arith.addi"(%arg1, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "tensor.yield"(%1) : (index) -> ()
    }) : (index) -> tensor<16x?xindex>
    "func.return"(%0) : (tensor<16x?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> tensor<?xindex>, sym_name = "tensor.generate_unknown_ops_in_body"}> ({
  ^bb0(%arg0: index):
    %0 = "tensor.generate"(%arg0) ({
    ^bb0(%arg1: index):
      %1 = "test.source"() : () -> index
      "tensor.yield"(%1) : (index) -> ()
    }) : (index) -> tensor<?xindex>
    "func.return"(%0) : (tensor<?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, index, index) -> tensor<?x10xf32>, sym_name = "tensor.extract_slice"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.extract_slice"(%arg0, %arg2, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 5, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, 10>, static_strides = array<i64: 1, 1>}> : (tensor<?x?xf32>, index, index) -> tensor<?x10xf32>
    "func.return"(%0) : (tensor<?x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x10x?xf32>, index, index) -> tensor<?x15xf32>, sym_name = "tensor.extract_slice_rank_reducing"}> ({
  ^bb0(%arg0: tensor<?x10x?xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.extract_slice"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: 5, -9223372036854775808, 10>, static_sizes = array<i64: -9223372036854775808, 1, 15>, static_strides = array<i64: 1, 1, 1>}> : (tensor<?x10x?xf32>, index, index) -> tensor<?x15xf32>
    "func.return"(%0) : (tensor<?x15xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x10xf32>, index, index) -> tensor<?x?xf32>, sym_name = "tensor.insert_slice"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x10xf32>, %arg2: index, %arg3: index):
    %0 = "tensor.insert_slice"(%arg1, %arg0, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 5>, static_sizes = array<i64: -9223372036854775808, 10>, static_strides = array<i64: 1, 1>}> : (tensor<?x10xf32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<f32>, index, index) -> tensor<?x?xf32>, sym_name = "tensor.insert_slice_rank_reducing_1"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<f32>, %arg2: index, %arg3: index):
    %0 = "tensor.insert_slice"(%arg1, %arg0, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (tensor<f32>, tensor<?x?xf32>, index, index) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?x?x?x?xf32>, tensor<2x1x4x1x1xf32>, index) -> tensor<?x?x?x?x?x?x?xf32>, sym_name = "tensor.insert_slice_rank_reducing_2"}> ({
  ^bb0(%arg0: tensor<?x?x?x?x?x?x?xf32>, %arg1: tensor<2x1x4x1x1xf32>, %arg2: index):
    %0 = "tensor.insert_slice"(%arg1, %arg0, %arg2, %arg2, %arg2, %arg2, %arg2, %arg2, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 7, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 1, 2, 1, 4, 1, 1, 1>, static_strides = array<i64: 1, 1, 1, 1, 1, 1, 1>}> : (tensor<2x1x4x1x1xf32>, tensor<?x?x?x?x?x?x?xf32>, index, index, index, index, index, index, index) -> tensor<?x?x?x?x?x?x?xf32>
    "func.return"(%0) : (tensor<?x?x?x?x?x?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<5xf32>, index, f32) -> tensor<5xf32>, sym_name = "tensor.insert"}> ({
  ^bb0(%arg0: tensor<5xf32>, %arg1: index, %arg2: f32):
    %0 = "tensor.insert"(%arg2, %arg0, %arg1) : (f32, tensor<5xf32>, index) -> tensor<5xf32>
    "func.return"(%0) : (tensor<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x10xf32>, index) -> tensor<2x?x10xf32>, sym_name = "tensor.expand_shape"}> ({
  ^bb0(%arg0: tensor<?x10xf32>, %arg1: index):
    %0 = "tensor.expand_shape"(%arg0, %arg1) <{reassociation = [[0, 1], [2]], static_output_shape = array<i64: 2, -9223372036854775808, 10>}> : (tensor<?x10xf32>, index) -> tensor<2x?x10xf32>
    "func.return"(%0) : (tensor<2x?x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x20xf32>, index, index, index) -> tensor<?x7x2x5xf32>, sym_name = "tensor.expand_shape_of_slice"}> ({
  ^bb0(%arg0: tensor<?x20xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "tensor.extract_slice"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>, static_offsets = array<i64: -9223372036854775808, 5>, static_sizes = array<i64: -9223372036854775808, 10>, static_strides = array<i64: 1, 1>}> : (tensor<?x20xf32>, index, index) -> tensor<?x10xf32>
    %1 = "tensor.expand_shape"(%0, %arg3) <{reassociation = [[0, 1], [2, 3]], static_output_shape = array<i64: -9223372036854775808, 7, 2, 5>}> : (tensor<?x10xf32>, index) -> tensor<?x7x2x5xf32>
    "func.return"(%1) : (tensor<?x7x2x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?xf32>, index, index) -> tensor<1xf32>, sym_name = "tensor.expand_shape_of_scalar_slice"}> ({
  ^bb0(%arg0: tensor<?xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.extract_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<?xf32>, index) -> tensor<f32>
    %1 = "tensor.expand_shape"(%0) <{reassociation = [], static_output_shape = array<i64: 1>}> : (tensor<f32>) -> tensor<1xf32>
    "func.return"(%1) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x256xf32>, index, index, index) -> tensor<?x?x?x256xf32>, sym_name = "tensor.expand_shape_multiple_dynamic_indices"}> ({
  ^bb0(%arg0: tensor<?x256xf32>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "tensor.expand_shape"(%arg0, %arg1, %arg2, %arg3) <{reassociation = [[0, 1, 2], [3]], static_output_shape = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, 256>}> : (tensor<?x256xf32>, index, index, index) -> tensor<?x?x?x256xf32>
    "func.return"(%0) : (tensor<?x?x?x256xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x?x?xf32>) -> tensor<?x?xf32>, sym_name = "tensor.collapse_shape"}> ({
  ^bb0(%arg0: tensor<2x?x?xf32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = [[0, 1], [2]]}> : (tensor<2x?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x1x1xf32>) -> tensor<f32>, sym_name = "tensor.collapse_shape_to_scalar"}> ({
  ^bb0(%arg0: tensor<1x1x1xf32>):
    %0 = "tensor.collapse_shape"(%arg0) <{reassociation = []}> : (tensor<1x1x1xf32>) -> tensor<f32>
    "func.return"(%0) : (tensor<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2xi32>) -> tensor<i32>, sym_name = "tensor.collapse_shape_of_slice"}> ({
  ^bb0(%arg0: tensor<2xi32>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 1>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<2xi32>) -> tensor<1xi32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = []}> : (tensor<1xi32>) -> tensor<i32>
    "func.return"(%1) : (tensor<i32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?x?x?xi64>, index, index, index, index) -> tensor<87x63648xi64>, sym_name = "tensor.collapse_shape_of_slice2"}> ({
  ^bb0(%arg0: tensor<?x?x?x?xi64>, %arg1: index, %arg2: index, %arg3: index, %arg4: index):
    %0 = "tensor.extract_slice"(%arg0, %arg1, %arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 4, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 87, 78, 68, 12>, static_strides = array<i64: 1, 1, 1, 1>}> : (tensor<?x?x?x?xi64>, index, index, index, index) -> tensor<87x78x68x12xi64>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0], [1, 2, 3]]}> : (tensor<87x78x68x12xi64>) -> tensor<87x63648xi64>
    "func.return"(%1) : (tensor<87x63648xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<1x2xf32>) -> tensor<1xf32>, sym_name = "tensor.collapse_shape_of_slice3"}> ({
  ^bb0(%arg0: tensor<1x2xf32>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 1, 1>, static_strides = array<i64: 1, 1>}> : (tensor<1x2xf32>) -> tensor<1x1xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1]]}> : (tensor<1x1xf32>) -> tensor<1xf32>
    "func.return"(%1) : (tensor<1xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x2x4xf32>, index, index) -> tensor<8xf32>, sym_name = "tensor.collapse_shape_of_slice4"}> ({
  ^bb0(%arg0: tensor<?x2x4xf32>, %arg1: index, %arg2: index):
    %0 = "tensor.extract_slice"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, 0, -9223372036854775808>, static_sizes = array<i64: 4, 2, 1>, static_strides = array<i64: 1, 1, 1>}> : (tensor<?x2x4xf32>, index) -> tensor<4x2x1xf32>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1, 2]]}> : (tensor<4x2x1xf32>) -> tensor<8xf32>
    "func.return"(%1) : (tensor<8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<2x2x2xi64>) -> tensor<4xi64>, sym_name = "tensor.collapse_shape_of_slice5"}> ({
  ^bb0(%arg0: tensor<2x2x2xi64>):
    %0 = "tensor.extract_slice"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0, 0>, static_sizes = array<i64: 2, 1, 2>, static_strides = array<i64: 1, 1, 1>}> : (tensor<2x2x2xi64>) -> tensor<2x1x2xi64>
    %1 = "tensor.collapse_shape"(%0) <{reassociation = [[0, 1, 2]]}> : (tensor<2x1x2xi64>) -> tensor<4xi64>
    "func.return"(%1) : (tensor<4xi64>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x10xf32>) -> tensor<2x2x5xf32>, sym_name = "tensor.reshape"}> ({
  ^bb0(%arg0: tensor<?x10xf32>):
    %0 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %1 = "arith.constant"() <{value = 5 : i64}> : () -> i64
    %2 = "tensor.from_elements"(%0, %0, %1) : (i64, i64, i64) -> tensor<3xi64>
    %3 = "tensor.reshape"(%arg0, %2) : (tensor<?x10xf32>, tensor<3xi64>) -> tensor<2x2x5xf32>
    "func.return"(%3) : (tensor<2x2x5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x10xindex>, index, index, index) -> tensor<?x?xindex>, sym_name = "tensor.pad"}> ({
  ^bb0(%arg0: tensor<?x10xindex>, %arg1: index, %arg2: index, %arg3: index):
    %0 = "tensor.pad"(%arg0, %arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 2>, static_high = array<i64: -9223372036854775808, -9223372036854775808>, static_low = array<i64: 5, -9223372036854775808>}> ({
    ^bb0(%arg4: index, %arg5: index):
      %1 = "arith.muli"(%arg4, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "tensor.yield"(%1) : (index) -> ()
    }) : (tensor<?x10xindex>, index, index, index) -> tensor<?x?xindex>
    "func.return"(%0) : (tensor<?x?xindex>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32) -> tensor<10x2x4xf32>, sym_name = "tensor.splat"}> ({
  ^bb0(%arg0: f32):
    %0 = "tensor.splat"(%arg0) : (f32) -> tensor<10x2x4xf32>
    "func.return"(%0) : (tensor<10x2x4xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (!test.memref_element) -> tensor<10x2x4x!test.memref_element>, sym_name = "tensor.splat_other"}> ({
  ^bb0(%arg0: !test.memref_element):
    %0 = "tensor.splat"(%arg0) : (!test.memref_element) -> tensor<10x2x4x!test.memref_element>
    "func.return"(%0) : (tensor<10x2x4x!test.memref_element>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8xf32>) -> tensor<16xf32>, sym_name = "tensor.concat"}> ({
  ^bb0(%arg0: tensor<8xf32>):
    %0 = "tensor.concat"(%arg0, %arg0) <{dim = 0 : i64}> : (tensor<8xf32>, tensor<8xf32>) -> tensor<16xf32>
    "func.return"(%0) : (tensor<16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x4xf32>, tensor<8x5xf32>) -> tensor<8x9xf32>, sym_name = "tensor.concat_different_shapes"}> ({
  ^bb0(%arg0: tensor<8x4xf32>, %arg1: tensor<8x5xf32>):
    %0 = "tensor.concat"(%arg0, %arg1) <{dim = 1 : i64}> : (tensor<8x4xf32>, tensor<8x5xf32>) -> tensor<8x9xf32>
    "func.return"(%0) : (tensor<8x9xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x?xf32>, tensor<8x?xf32>) -> tensor<8x?xf32>, sym_name = "tensor.concat_dynamic"}> ({
  ^bb0(%arg0: tensor<8x?xf32>, %arg1: tensor<8x?xf32>):
    %0 = "tensor.concat"(%arg0, %arg1) <{dim = 1 : i64}> : (tensor<8x?xf32>, tensor<8x?xf32>) -> tensor<8x?xf32>
    "func.return"(%0) : (tensor<8x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>, sym_name = "tensor.concat_dynamic_nonconcat_dim"}> ({
  ^bb0(%arg0: tensor<?x?xf32>, %arg1: tensor<?x?xf32>):
    %0 = "tensor.concat"(%arg0, %arg1) <{dim = 1 : i64}> : (tensor<?x?xf32>, tensor<?x?xf32>) -> tensor<?x?xf32>
    "func.return"(%0) : (tensor<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<8x?xf32>, tensor<8x?xf32>, tensor<8x2xf32>) -> tensor<8x10xf32>, sym_name = "tensor.concat_mixed_dynamic_static"}> ({
  ^bb0(%arg0: tensor<8x?xf32>, %arg1: tensor<8x?xf32>, %arg2: tensor<8x2xf32>):
    %0 = "tensor.concat"(%arg0, %arg1, %arg2) <{dim = 1 : i64}> : (tensor<8x?xf32>, tensor<8x?xf32>, tensor<8x2xf32>) -> tensor<8x10xf32>
    "func.return"(%0) : (tensor<8x10xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, index, index) -> tensor<?x3x?xf32>, sym_name = "tensor.splat_dynamic"}> ({
  ^bb0(%arg0: f32, %arg1: index, %arg2: index):
    %0 = "tensor.splat"(%arg0, %arg1, %arg2) : (f32, index, index) -> tensor<?x3x?xf32>
    "func.return"(%0) : (tensor<?x3x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (tensor<4xf32>, tensor<4xf32>) -> (), sym_name = "parallel_insert_slice_copy_before_write"}> ({
  ^bb0(%arg0: tensor<4xf32>, %arg1: tensor<4xf32>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "scf.forall"(%1, %arg1) <{operandSegmentSizes = array<i32: 0, 1, 0, 1>, staticLowerBound = array<i64: 0>, staticStep = array<i64: 1>, staticUpperBound = array<i64: -9223372036854775808>}> ({
    ^bb0(%arg2: index, %arg3: tensor<4xf32>):
      %3 = "tensor.extract_slice"(%arg0, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<4xf32>, index) -> tensor<1xf32>
      "scf.forall.in_parallel"() ({
        "tensor.parallel_insert_slice"(%3, %arg3, %arg2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (tensor<1xf32>, tensor<4xf32>, index) -> ()
      }) : () -> ()
    }) : (index, tensor<4xf32>) -> tensor<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
^bb0:
}) : () -> ()

