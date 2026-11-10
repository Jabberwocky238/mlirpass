"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> (), sym_name = "fill_inplace", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, memref<?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<?xf32>, sym_name = "not_inplace"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %1) : (memref<?xf32>, index) -> index
    %3 = "memref.alloc"(%2) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "linalg.fill"(%0, %3) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, memref<?xf32>) -> ()
    "func.return"(%3) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>) -> (), sym_name = "not_inplace", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %1) : (memref<?x?xf32>, index) -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "memref.dim"(%arg0, %3) : (memref<?x?xf32>, index) -> index
    %5 = "memref.alloc"(%2, %4) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "linalg.fill"(%0, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, memref<?x?xf32>) -> ()
    "linalg.matmul"(%5, %5, %arg0) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %6 = "arith.mulf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg3, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>) -> memref<?x?xf32>, sym_name = "not_inplace"}> ({
  ^bb0(%arg0: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?x?xf32>, index) -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %2) : (memref<?x?xf32>, index) -> index
    %4 = "memref.alloc"(%1, %3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "memref.copy"(%arg0, %4) : (memref<?x?xf32>, memref<?x?xf32>) -> ()
    "linalg.matmul"(%arg0, %arg0, %4) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %5 = "arith.mulf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %6 = "arith.addf"(%arg3, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32>) -> ()
    "func.return"(%4) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<4xf32>) -> memref<?xf32>, sym_name = "vec_inplace"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.transfer_write"(%arg1, %arg0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<4xf32>, memref<?xf32>, index) -> ()
    "func.return"(%arg0) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, vector<4xf32>) -> (memref<?xf32>, memref<?xf32>), sym_name = "vec_not_inplace"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: vector<4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %2) : (memref<?xf32>, index) -> index
    %4 = "memref.alloc"(%3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %4) : (memref<?xf32>, memref<?xf32>) -> ()
    "vector.transfer_write"(%arg1, %4, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<4xf32>, memref<?xf32>, index) -> ()
    "vector.transfer_write"(%arg1, %arg0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<4xf32>, memref<?xf32>, index) -> ()
    "func.return"(%4, %arg0) : (memref<?xf32>, memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<128x256xf32>, memref<256x192xf32>, memref<128x192xf32>) -> memref<128x192xf32>, sym_name = "matmul"}> ({
  ^bb0(%arg0: memref<128x256xf32>, %arg1: memref<256x192xf32>, %arg2: memref<128x192xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 256 : index}> : () -> index
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %4 = "arith.constant"() <{value = 128 : index}> : () -> index
    %5 = "arith.constant"() <{value = 192 : index}> : () -> index
    %6 = "arith.constant"() <{value = 8 : index}> : () -> index
    %7 = "arith.constant"() <{value = 16 : index}> : () -> index
    %8 = "scf.for"(%0, %4, %6, %arg2) ({
    ^bb0(%arg3: index, %arg4: memref<128x192xf32>):
      %9 = "memref.subview"(%arg0, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 8, 256>, static_strides = array<i64: 1, 1>}> : (memref<128x256xf32>, index) -> memref<8x256xf32, strided<[256, 1], offset: ?>>
      %10 = "scf.for"(%0, %5, %7, %arg4) ({
      ^bb0(%arg5: index, %arg6: memref<128x192xf32>):
        %11 = "memref.subview"(%arg1, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (memref<256x192xf32>, index) -> memref<256x16xf32, strided<[192, 1], offset: ?>>
        %12 = "memref.subview"(%arg2, %arg3, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 8, 16>, static_strides = array<i64: 1, 1>}> : (memref<128x192xf32>, index, index) -> memref<8x16xf32, strided<[192, 1], offset: ?>>
        %13 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x16xf32>
        "linalg.fill"(%3, %13) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg12: f32, %arg13: f32):
          "linalg.yield"(%arg12) : (f32) -> ()
        }) : (f32, memref<8x16xf32>) -> ()
        %14 = "scf.for"(%0, %1, %2, %13) ({
        ^bb0(%arg7: index, %arg8: memref<8x16xf32>):
          %16 = "memref.subview"(%9, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 8, 32>, static_strides = array<i64: 1, 1>}> : (memref<8x256xf32, strided<[256, 1], offset: ?>>, index) -> memref<8x32xf32, strided<[256, 1], offset: ?>>
          %17 = "memref.subview"(%11, %arg7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 32, 16>, static_strides = array<i64: 1, 1>}> : (memref<256x16xf32, strided<[192, 1], offset: ?>>, index) -> memref<32x16xf32, strided<[192, 1], offset: ?>>
          "linalg.matmul"(%16, %17, %arg8) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
          ^bb0(%arg9: f32, %arg10: f32, %arg11: f32):
            %18 = "arith.mulf"(%arg9, %arg10) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            %19 = "arith.addf"(%arg11, %18) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            "linalg.yield"(%19) : (f32) -> ()
          }) : (memref<8x32xf32, strided<[256, 1], offset: ?>>, memref<32x16xf32, strided<[192, 1], offset: ?>>, memref<8x16xf32>) -> ()
          "scf.yield"(%arg8) : (memref<8x16xf32>) -> ()
        }) : (index, index, index, memref<8x16xf32>) -> memref<8x16xf32>
        %15 = "memref.subview"(%arg6, %arg3, %arg5) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 8, 16>, static_strides = array<i64: 1, 1>}> : (memref<128x192xf32>, index, index) -> memref<8x16xf32, strided<[192, 1], offset: ?>>
        "memref.copy"(%14, %15) : (memref<8x16xf32>, memref<8x16xf32, strided<[192, 1], offset: ?>>) -> ()
        "scf.yield"(%arg6) : (memref<128x192xf32>) -> ()
      }) : (index, index, index, memref<128x192xf32>) -> memref<128x192xf32>
      "scf.yield"(%10) : (memref<128x192xf32>) -> ()
    }) : (index, index, index, memref<128x192xf32>) -> memref<128x192xf32>
    "func.return"(%8) : (memref<128x192xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index) -> memref<?x?xf32>, sym_name = "dominance_violation_bug_1"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "memref.subview"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>, index, index) -> memref<?x?xf32, strided<[?, 1]>>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%1, %2) : (memref<?x?xf32, strided<[?, 1]>>, index) -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "memref.dim"(%1, %4) : (memref<?x?xf32, strided<[?, 1]>>, index) -> index
    %6 = "memref.alloc"(%3, %5) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "memref.copy"(%1, %6) : (memref<?x?xf32, strided<[?, 1]>>, memref<?x?xf32>) -> ()
    %7 = "memref.subview"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>) -> memref<4x4xf32, strided<[?, 1]>>
    "linalg.fill"(%0, %7) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<4x4xf32, strided<[?, 1]>>) -> ()
    %8 = "memref.subview"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>) -> memref<4x4xf32, strided<[?, 1]>>
    "memref.copy"(%7, %8) : (memref<4x4xf32, strided<[?, 1]>>, memref<4x4xf32, strided<[?, 1]>>) -> ()
    %9 = "arith.constant"() <{value = 0 : index}> : () -> index
    %10 = "memref.dim"(%arg0, %9) : (memref<?x?xf32>, index) -> index
    %11 = "arith.constant"() <{value = 1 : index}> : () -> index
    %12 = "memref.dim"(%arg0, %11) : (memref<?x?xf32>, index) -> index
    %13 = "memref.alloc"(%10, %12) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "memref.copy"(%arg0, %13) : (memref<?x?xf32>, memref<?x?xf32>) -> ()
    %14 = "memref.subview"(%13, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>, index, index) -> memref<?x?xf32, strided<[?, 1]>>
    "memref.copy"(%6, %14) : (memref<?x?xf32>, memref<?x?xf32, strided<[?, 1]>>) -> ()
    "func.return"(%13) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, memref<?xi32>, memref<?x?xf32>) -> (), sym_name = "gather_like", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: memref<?xi32>, %arg2: memref<?x?xf32>):
    "linalg.generic"(%arg1, %arg2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i32, %arg4: f32):
      %0 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %1 = "arith.index_cast"(%arg3) : (i32) -> index
      %2 = "memref.load"(%arg0, %1, %0) <{invariant = false, nontemporal = false}> : (memref<?x?xf32>, index, index) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (memref<?xi32>, memref<?x?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, memref<?xf32>, memref<?x?xf32>, index, index, f32) -> memref<?x?xf32>, sym_name = "linalg_op_bufferizes_inplace_with_input"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: memref<?xf32>, %arg2: memref<?x?xf32>, %arg3: index, %arg4: index, %arg5: f32):
    "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %0 = "arith.addf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%0) : (f32) -> ()
    }) : (memref<?x?xf32>, memref<?xf32>, memref<?x?xf32>) -> ()
    "func.return"(%arg2) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, f32) -> memref<?xf32>, sym_name = "op_is_reading_but_following_ops_are_not"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %2) : (memref<?xf32>, memref<?xf32>) -> ()
    "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg3: f32):
      %3 = "arith.addf"(%arg1, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%3) : (f32) -> ()
    }) : (memref<?xf32>) -> ()
    "linalg.generic"(%2) <{indexing_maps = [#map], iterator_types = [#linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 0, 1>}> ({
    ^bb0(%arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (memref<?xf32>) -> ()
    "func.return"(%2) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<64xf32>, memref<64xf32>, memref<64xf32>) -> memref<64xf32>, sym_name = "map_binary"}> ({
  ^bb0(%arg0: memref<64xf32>, %arg1: memref<64xf32>, %arg2: memref<64xf32>):
    "linalg.map"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %0 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%0) : (f32) -> ()
    }) : (memref<64xf32>, memref<64xf32>, memref<64xf32>) -> ()
    "func.return"(%arg2) : (memref<64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x32x64xf32>, memref<16x64xf32>) -> memref<16x64xf32>, sym_name = "reduce"}> ({
  ^bb0(%arg0: memref<16x32x64xf32>, %arg1: memref<16x64xf32>):
    "linalg.reduce"(%arg0, %arg1) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %0 = "arith.addf"(%arg3, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%0) : (f32) -> ()
    }) : (memref<16x32x64xf32>, memref<16x64xf32>) -> ()
    "func.return"(%arg1) : (memref<16x64xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x32x64xf32>, memref<32x64x16xf32>) -> memref<32x64x16xf32>, sym_name = "transpose"}> ({
  ^bb0(%arg0: memref<16x32x64xf32>, %arg1: memref<32x64x16xf32>):
    "linalg.transpose"(%arg0, %arg1) <{permutation = array<i64: 1, 2, 0>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<16x32x64xf32>, memref<32x64x16xf32>) -> ()
    "func.return"(%arg1) : (memref<32x64x16xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x32xf32>, memref<8x16x32xf32>) -> memref<8x16x32xf32>, sym_name = "broadcast"}> ({
  ^bb0(%arg0: memref<8x32xf32>, %arg1: memref<8x16x32xf32>):
    "linalg.broadcast"(%arg0, %arg1) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<8x32xf32>, memref<8x16x32xf32>) -> ()
    "func.return"(%arg1) : (memref<8x16x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 ceildiv 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<8x18x32xf32>) -> memref<?x1x6x8xf32>, sym_name = "depthwise_conv_1d_nwc_wc"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<8x18x32xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 32 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x1x6x8xf32>
    %4 = "memref.cast"(%3) : (memref<4x1x6x8xf32>) -> memref<?x1x6x8xf32>
    %5 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x6x8xf32>
    %6 = "scf.for"(%0, %1, %2, %4) ({
    ^bb0(%arg3: index, %arg4: memref<?x1x6x8xf32>):
      %7 = "affine.apply"(%arg3) <{map = #map}> : (index) -> index
      %8 = "memref.subview"(%arg4, %7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0, 0>, static_sizes = array<i64: 1, 1, 6, 8>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<?x1x6x8xf32>, index) -> memref<1x6x8xf32, strided<[48, 8, 1], offset: ?>>
      "memref.copy"(%5, %8) : (memref<1x6x8xf32>, memref<1x6x8xf32, strided<[48, 8, 1], offset: ?>>) -> ()
      "scf.yield"(%arg4) : (memref<?x1x6x8xf32>) -> ()
    }) : (index, index, index, memref<?x1x6x8xf32>) -> memref<?x1x6x8xf32>
    "func.return"(%6) : (memref<?x1x6x8xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, f32, index) -> (memref<5xf32>, memref<5xf32>), sym_name = "do_not_copy_alloc_tensors"}> ({
  ^bb0(%arg0: f32, %arg1: f32, %arg2: index):
    %0 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<5xf32>
    "memref.store"(%arg0, %1, %arg2) <{nontemporal = false}> : (f32, memref<5xf32>, index) -> ()
    "memref.store"(%arg1, %0, %arg2) <{nontemporal = false}> : (f32, memref<5xf32>, index) -> ()
    "func.return"(%1, %0) : (memref<5xf32>, memref<5xf32>) -> ()
  }) : () -> ()
}) : () -> ()

