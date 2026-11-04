"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> (), sym_name = "fill_inplace", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "linalg.fill"(%0, %arg0) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32):
      "linalg.yield"(%arg1) : (f32) -> ()
    }) : (f32, memref<?xf32, strided<[?], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32>, sym_name = "not_inplace"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %1) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
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
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> (), sym_name = "not_inplace", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %2) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index) -> index
    %4 = "memref.dim"(%arg0, %0) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index) -> index
    %5 = "memref.alloc"(%3, %4) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "linalg.fill"(%1, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg4: f32, %arg5: f32):
      "linalg.yield"(%arg4) : (f32) -> ()
    }) : (f32, memref<?x?xf32>) -> ()
    "linalg.matmul"(%5, %5, %arg0) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %6 = "arith.mulf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %7 = "arith.addf"(%arg3, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%7) : (f32) -> ()
    }) : (memref<?x?xf32>, memref<?x?xf32>, memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> memref<?x?xf32>, sym_name = "not_inplace"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %1) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index) -> index
    %3 = "memref.dim"(%arg0, %0) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index) -> index
    %4 = "memref.alloc"(%2, %3) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "memref.copy"(%arg0, %4) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?x?xf32>) -> ()
    "linalg.matmul"(%arg0, %arg0, %4) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):
      %5 = "arith.mulf"(%arg1, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      %6 = "arith.addf"(%arg3, %5) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%6) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?x?xf32>) -> ()
    "func.return"(%4) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, vector<4xf32>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "vec_inplace"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: vector<4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    "vector.transfer_write"(%arg1, %arg0, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<4xf32>, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
    "func.return"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, vector<4xf32>) -> (memref<?xf32>, memref<?xf32, strided<[?], offset: ?>>), sym_name = "vec_not_inplace"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: vector<4xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %3 = "memref.alloc"(%2) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %3) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
    "vector.transfer_write"(%arg1, %3, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<4xf32>, memref<?xf32>, index) -> ()
    "vector.transfer_write"(%arg1, %arg0, %1) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<4xf32>, memref<?xf32, strided<[?], offset: ?>>, index) -> ()
    "func.return"(%3, %arg0) : (memref<?xf32>, memref<?xf32, strided<[?], offset: ?>>) -> ()
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
    %8 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x16xf32>
    "scf.for"(%0, %4, %6) ({
    ^bb0(%arg3: index):
      %9 = "memref.subview"(%arg0, %arg3) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 8, 256>, static_strides = array<i64: 1, 1>}> : (memref<128x256xf32>, index) -> memref<8x256xf32, strided<[256, 1], offset: ?>>
      "scf.for"(%0, %5, %7) ({
      ^bb0(%arg4: index):
        %10 = "memref.subview"(%arg1, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 256, 16>, static_strides = array<i64: 1, 1>}> : (memref<256x192xf32>, index) -> memref<256x16xf32, strided<[192, 1], offset: ?>>
        "linalg.fill"(%3, %8) <{operandSegmentSizes = array<i32: 1, 1>}> ({
        ^bb0(%arg9: f32, %arg10: f32):
          "linalg.yield"(%arg9) : (f32) -> ()
        }) : (f32, memref<8x16xf32>) -> ()
        "scf.for"(%0, %1, %2) ({
        ^bb0(%arg5: index):
          %12 = "memref.subview"(%9, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: 0, -9223372036854775808>, static_sizes = array<i64: 8, 32>, static_strides = array<i64: 1, 1>}> : (memref<8x256xf32, strided<[256, 1], offset: ?>>, index) -> memref<8x32xf32, strided<[256, 1], offset: ?>>
          %13 = "memref.subview"(%10, %arg5) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0>, static_sizes = array<i64: 32, 16>, static_strides = array<i64: 1, 1>}> : (memref<256x16xf32, strided<[192, 1], offset: ?>>, index) -> memref<32x16xf32, strided<[192, 1], offset: ?>>
          "linalg.matmul"(%12, %13, %8) <{indexing_maps = [#map, #map1, #map2], operandSegmentSizes = array<i32: 2, 1>}> ({
          ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
            %14 = "arith.mulf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            %15 = "arith.addf"(%arg8, %14) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
            "linalg.yield"(%15) : (f32) -> ()
          }) : (memref<8x32xf32, strided<[256, 1], offset: ?>>, memref<32x16xf32, strided<[192, 1], offset: ?>>, memref<8x16xf32>) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        %11 = "memref.subview"(%arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 8, 16>, static_strides = array<i64: 1, 1>}> : (memref<128x192xf32>, index, index) -> memref<8x16xf32, strided<[192, 1], offset: ?>>
        "memref.copy"(%8, %11) : (memref<8x16xf32>, memref<8x16xf32, strided<[192, 1], offset: ?>>) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%arg2) : (memref<128x192xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>, index) -> memref<?x?xf32>, sym_name = "dominance_violation_bug_1"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: index):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %3 = "memref.subview"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    %4 = "memref.alloc"(%arg1, %arg1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "memref.copy"(%3, %4) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?x?xf32>) -> ()
    %5 = "memref.subview"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>) -> memref<4x4xf32, strided<[?, 1]>>
    "linalg.fill"(%2, %5) <{operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (f32, memref<4x4xf32, strided<[?, 1]>>) -> ()
    %6 = "memref.subview"(%4) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: 4, 4>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>) -> memref<4x4xf32, strided<[?, 1]>>
    "memref.copy"(%5, %6) : (memref<4x4xf32, strided<[?, 1]>>, memref<4x4xf32, strided<[?, 1]>>) -> ()
    %7 = "memref.dim"(%arg0, %1) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index) -> index
    %8 = "memref.dim"(%arg0, %0) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index) -> index
    %9 = "memref.alloc"(%7, %8) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "memref.copy"(%arg0, %9) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?x?xf32>) -> ()
    %10 = "memref.subview"(%9, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 0, 2, 0>, static_offsets = array<i64: 0, 0>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 1, 1>}> : (memref<?x?xf32>, index, index) -> memref<?x?xf32, strided<[?, 1]>>
    "memref.copy"(%4, %10) : (memref<?x?xf32>, memref<?x?xf32, strided<[?, 1]>>) -> ()
    "func.return"(%9) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?xi32, strided<[?], offset: ?>>, memref<?x?xf32, strided<[?, ?], offset: ?>>) -> (), sym_name = "gather_like", sym_visibility = "private"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: memref<?xi32, strided<[?], offset: ?>>, %arg2: memref<?x?xf32, strided<[?, ?], offset: ?>>):
    "linalg.generic"(%arg1, %arg2) <{indexing_maps = [#map, #map1], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 1, 1>}> ({
    ^bb0(%arg3: i32, %arg4: f32):
      %0 = "linalg.index"() <{dim = 1 : i64}> : () -> index
      %1 = "arith.index_cast"(%arg3) : (i32) -> index
      %2 = "memref.load"(%arg0, %1, %0) <{nontemporal = false}> : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> f32
      "linalg.yield"(%2) : (f32) -> ()
    }) : (memref<?xi32, strided<[?], offset: ?>>, memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index, f32) -> memref<?x?xf32, strided<[?, ?], offset: ?>>, sym_name = "linalg_op_bufferizes_inplace_with_input"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg1: memref<?xf32, strided<[?], offset: ?>>, %arg2: memref<?x?xf32, strided<[?, ?], offset: ?>>, %arg3: index, %arg4: index, %arg5: f32):
    "linalg.generic"(%arg0, %arg1, %arg2) <{indexing_maps = [#map, #map1, #map], iterator_types = [#linalg.iterator_type<parallel>, #linalg.iterator_type<parallel>], operandSegmentSizes = array<i32: 2, 1>}> ({
    ^bb0(%arg6: f32, %arg7: f32, %arg8: f32):
      %0 = "arith.addf"(%arg6, %arg7) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%0) : (f32) -> ()
    }) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>, memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
    "func.return"(%arg2) : (memref<?x?xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>, f32) -> memref<?xf32>, sym_name = "op_is_reading_but_following_ops_are_not"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>, %arg1: f32):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %2 = "memref.alloc"(%1) <{alignment = 64 : i64, operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %2) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32>) -> ()
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
  "func.func"() <{function_type = (memref<64xf32, strided<[?], offset: ?>>, memref<64xf32, strided<[?], offset: ?>>, memref<64xf32, strided<[?], offset: ?>>) -> memref<64xf32, strided<[?], offset: ?>>, sym_name = "map_binary"}> ({
  ^bb0(%arg0: memref<64xf32, strided<[?], offset: ?>>, %arg1: memref<64xf32, strided<[?], offset: ?>>, %arg2: memref<64xf32, strided<[?], offset: ?>>):
    "linalg.map"(%arg0, %arg1, %arg2) ({
    ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):
      %0 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%0) : (f32) -> ()
    }) : (memref<64xf32, strided<[?], offset: ?>>, memref<64xf32, strided<[?], offset: ?>>, memref<64xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%arg2) : (memref<64xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x32x64xf32, strided<[?, ?, ?], offset: ?>>, memref<16x64xf32, strided<[?, ?], offset: ?>>) -> memref<16x64xf32, strided<[?, ?], offset: ?>>, sym_name = "reduce"}> ({
  ^bb0(%arg0: memref<16x32x64xf32, strided<[?, ?, ?], offset: ?>>, %arg1: memref<16x64xf32, strided<[?, ?], offset: ?>>):
    "linalg.reduce"(%arg0, %arg1) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      %0 = "arith.addf"(%arg3, %arg2) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "linalg.yield"(%0) : (f32) -> ()
    }) : (memref<16x32x64xf32, strided<[?, ?, ?], offset: ?>>, memref<16x64xf32, strided<[?, ?], offset: ?>>) -> ()
    "func.return"(%arg1) : (memref<16x64xf32, strided<[?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<16x32x64xf32, strided<[?, ?, ?], offset: ?>>, memref<32x64x16xf32, strided<[?, ?, ?], offset: ?>>) -> memref<32x64x16xf32, strided<[?, ?, ?], offset: ?>>, sym_name = "transpose"}> ({
  ^bb0(%arg0: memref<16x32x64xf32, strided<[?, ?, ?], offset: ?>>, %arg1: memref<32x64x16xf32, strided<[?, ?, ?], offset: ?>>):
    "linalg.transpose"(%arg0, %arg1) <{permutation = array<i64: 1, 2, 0>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<16x32x64xf32, strided<[?, ?, ?], offset: ?>>, memref<32x64x16xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    "func.return"(%arg1) : (memref<32x64x16xf32, strided<[?, ?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<8x32xf32, strided<[?, ?], offset: ?>>, memref<8x16x32xf32, strided<[?, ?, ?], offset: ?>>) -> memref<8x16x32xf32, strided<[?, ?, ?], offset: ?>>, sym_name = "broadcast"}> ({
  ^bb0(%arg0: memref<8x32xf32, strided<[?, ?], offset: ?>>, %arg1: memref<8x16x32xf32, strided<[?, ?, ?], offset: ?>>):
    "linalg.broadcast"(%arg0, %arg1) <{dimensions = array<i64: 1>}> ({
    ^bb0(%arg2: f32, %arg3: f32):
      "linalg.yield"(%arg2) : (f32) -> ()
    }) : (memref<8x32xf32, strided<[?, ?], offset: ?>>, memref<8x16x32xf32, strided<[?, ?, ?], offset: ?>>) -> ()
    "func.return"(%arg1) : (memref<8x16x32xf32, strided<[?, ?, ?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 ceildiv 8)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, memref<8x18x32xf32, strided<[?, ?, ?], offset: ?>>) -> memref<?x1x6x8xf32>, sym_name = "depthwise_conv_1d_nwc_wc"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: memref<8x18x32xf32, strided<[?, ?, ?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 32 : index}> : () -> index
    %2 = "arith.constant"() <{value = 8 : index}> : () -> index
    %3 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x1x6x8xf32>
    %4 = "memref.cast"(%3) : (memref<4x1x6x8xf32>) -> memref<?x1x6x8xf32>
    %5 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x6x8xf32>
    "scf.for"(%0, %1, %2) ({
    ^bb0(%arg3: index):
      %6 = "affine.apply"(%arg3) <{map = #map}> : (index) -> index
      %7 = "memref.subview"(%3, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808, 0, 0, 0>, static_sizes = array<i64: 1, 1, 6, 8>, static_strides = array<i64: 1, 1, 1, 1>}> : (memref<4x1x6x8xf32>, index) -> memref<1x6x8xf32, strided<[48, 8, 1], offset: ?>>
      "memref.copy"(%5, %7) : (memref<1x6x8xf32>, memref<1x6x8xf32, strided<[48, 8, 1], offset: ?>>) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"(%4) : (memref<?x1x6x8xf32>) -> ()
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

