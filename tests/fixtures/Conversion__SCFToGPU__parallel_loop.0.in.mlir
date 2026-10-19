"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "parallel_loop_bidy_bidx"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: memref<?x?xf32>, %arg6: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    "scf.parallel"(%arg0, %arg1, %arg2, %arg3, %arg4, %0) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg7: index, %arg8: index):
      %1 = "memref.load"(%arg5, %arg7, %arg8) : (memref<?x?xf32>, index, index) -> f32
      "memref.store"(%1, %arg6, %arg8, %arg7) : (f32, memref<?x?xf32>, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "parallel_loop_tiled"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    "scf.parallel"(%arg0, %arg1, %arg2, %arg3, %2, %2) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg6: index, %arg7: index):
      "scf.parallel"(%0, %0, %2, %2, %1, %1) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
      ^bb0(%arg8: index, %arg9: index):
        %3 = "arith.addi"(%arg6, %arg8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %4 = "arith.addi"(%arg7, %arg9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %5 = "memref.load"(%arg4, %3, %4) : (memref<?x?xf32>, index, index) -> f32
        "memref.store"(%5, %arg5, %4, %3) : (f32, memref<?x?xf32>, index, index) -> ()
        "scf.reduce"() : () -> ()
      }) {mapping = [#gpu.loop_dim_map<processor = thread_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "parallel_loop_bidy_seq"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: memref<?x?xf32>, %arg6: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    "scf.parallel"(%arg0, %arg1, %arg2, %arg3, %arg4, %0) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg7: index, %arg8: index):
      %1 = "memref.load"(%arg5, %arg7, %arg8) : (memref<?x?xf32>, index, index) -> f32
      "memref.store"(%1, %arg6, %arg8, %arg7) : (f32, memref<?x?xf32>, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = sequential, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "parallel_loop_tiled_seq"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    "scf.parallel"(%arg0, %arg1, %arg2, %arg3, %2, %2) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg6: index, %arg7: index):
      "scf.parallel"(%0, %0, %2, %2, %1, %1) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
      ^bb0(%arg8: index, %arg9: index):
        %3 = "arith.addi"(%arg6, %arg8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %4 = "arith.addi"(%arg7, %arg9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %5 = "memref.load"(%arg4, %3, %4) : (memref<?x?xf32>, index, index) -> f32
        "memref.store"(%5, %arg5, %4, %3) : (f32, memref<?x?xf32>, index, index) -> ()
        "scf.reduce"() : () -> ()
      }) {mapping = [#gpu.loop_dim_map<processor = thread_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = sequential, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = sequential, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0] -> (2, -d0 + s0)>
#map1 = affine_map<(d0)[s0] -> (3, -d0 + s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, 1], offset: ?>>, memref<?x?xf32, strided<[?, 1], offset: ?>>, memref<?x?xf32, strided<[?, 1], offset: ?>>) -> (), sym_name = "sum"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, 1], offset: ?>>, %arg1: memref<?x?xf32, strided<[?, 1], offset: ?>>, %arg2: memref<?x?xf32, strided<[?, 1], offset: ?>>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "memref.dim"(%arg0, %1) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
    %5 = "memref.dim"(%arg0, %0) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
    "scf.parallel"(%1, %1, %4, %5, %3, %2) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg3: index, %arg4: index):
      %6 = "memref.dim"(%arg0, %1) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
      %7 = "affine.min"(%arg3, %6) <{map = #map}> : (index, index) -> index
      %8 = "arith.muli"(%7, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %9 = "memref.dim"(%arg0, %0) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
      %10 = "arith.subi"(%9, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "arith.minsi"(%2, %10) : (index, index) -> index
      %12 = "memref.subview"(%arg0, %arg3, %arg4, %8, %11, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
      %13 = "memref.dim"(%arg1, %1) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
      %14 = "affine.min"(%arg3, %13) <{map = #map}> : (index, index) -> index
      %15 = "memref.dim"(%arg1, %0) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
      %16 = "affine.min"(%arg4, %15) <{map = #map1}> : (index, index) -> index
      %17 = "memref.subview"(%arg1, %arg3, %arg4, %14, %16, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
      %18 = "memref.dim"(%arg2, %1) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
      %19 = "affine.min"(%arg3, %18) <{map = #map}> : (index, index) -> index
      %20 = "memref.dim"(%arg2, %0) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
      %21 = "affine.min"(%arg4, %20) <{map = #map1}> : (index, index) -> index
      %22 = "memref.subview"(%arg2, %arg3, %arg4, %19, %21, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
      "scf.parallel"(%1, %1, %8, %11, %0, %0) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
      ^bb0(%arg5: index, %arg6: index):
        %23 = "memref.load"(%12, %arg5, %arg6) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> f32
        %24 = "memref.load"(%17, %arg5, %arg6) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> f32
        %25 = "memref.load"(%22, %arg5, %arg6) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> f32
        %26 = "arith.addf"(%23, %24) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "memref.store"(%26, %22, %arg5, %arg6) : (f32, memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> ()
        "scf.reduce"() : () -> ()
      }) {mapping = [#gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = thread_y, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_loop_optional_attr"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.parallel"(%0, %1, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg0: index):
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>], optional_attr = 1 : i64} : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "parallel_double_map"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    "scf.parallel"(%arg0, %arg1, %arg2, %arg3, %0, %0) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg6: index, %arg7: index):
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "parallel_loop_loop_variant_bound"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    "scf.parallel"(%arg0, %arg1, %arg2, %arg3, %2, %2) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg6: index, %arg7: index):
      "scf.parallel"(%0, %0, %arg6, %arg7, %1, %1) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
      ^bb0(%arg8: index, %arg9: index):
        %3 = "arith.addi"(%arg6, %arg8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %4 = "arith.addi"(%arg7, %arg9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
        %5 = "memref.load"(%arg4, %3, %4) : (memref<?x?xf32>, index, index) -> f32
        "memref.store"(%5, %arg5, %4, %3) : (f32, memref<?x?xf32>, index, index) -> ()
        "scf.reduce"() : () -> ()
      }) {mapping = [#gpu.loop_dim_map<processor = thread_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = sequential, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = sequential, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "parallel_no_annotations"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 4 : index}> : () -> index
    "scf.parallel"(%arg0, %arg1, %arg2, %arg3, %0, %0) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg6: index, %arg7: index):
      "scf.reduce"() : () -> ()
    }) : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "step_invariant"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x1xf64>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x1xf64>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x1xf64>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.parallel"(%3, %4, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg0: index):
      %6 = "arith.constant"() <{value = 0 : index}> : () -> index
      %7 = "arith.constant"() <{value = 1 : index}> : () -> index
      %8 = "arith.constant"() <{value = 1 : index}> : () -> index
      "scf.parallel"(%6, %7, %8) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
      ^bb0(%arg1: index):
        %9 = "memref.load"(%2, %arg0, %arg1) : (memref<1x1xf64>, index, index) -> f64
        %10 = "memref.load"(%1, %arg0, %arg1) : (memref<1x1xf64>, index, index) -> f64
        %11 = "arith.addf"(%9, %10) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
        "memref.store"(%11, %0, %arg0, %arg1) : (f64, memref<1x1xf64>, index, index) -> ()
        "scf.reduce"() : () -> ()
      }) {mapping = [#gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index) -> ()
    "memref.dealloc"(%2) : (memref<1x1xf64>) -> ()
    "memref.dealloc"(%1) : (memref<1x1xf64>) -> ()
    "memref.dealloc"(%0) : (memref<1x1xf64>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_reduction_1d"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xf32>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 64 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "scf.parallel"(%4, %2, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg0: index):
      %6 = "scf.parallel"(%4, %3, %2, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> ({
      ^bb0(%arg1: index):
        %7 = "memref.load"(%1, %arg1) : (memref<64xf32>, index) -> f32
        "scf.reduce"(%7) ({
        ^bb0(%arg2: f32, %arg3: f32):
          %8 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "scf.reduce.return"(%8) : (f32) -> ()
        }) : (f32) -> ()
      }) {mapping = [#gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, f32) -> f32
      "memref.store"(%6, %0) : (f32, memref<f32>) -> ()
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index) -> ()
    "memref.dealloc"(%0) : (memref<f32>) -> ()
    "memref.dealloc"(%1) : (memref<64xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_reduction_2d"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x8xf32>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 8 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    "scf.parallel"(%4, %2, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg0: index):
      %6 = "scf.parallel"(%4, %4, %3, %3, %2, %2, %5) <{operandSegmentSizes = array<i32: 2, 2, 2, 1>}> ({
      ^bb0(%arg1: index, %arg2: index):
        %7 = "memref.load"(%1, %arg1, %arg2) : (memref<8x8xf32>, index, index) -> f32
        "scf.reduce"(%7) ({
        ^bb0(%arg3: f32, %arg4: f32):
          %8 = "arith.addf"(%arg3, %arg4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "scf.reduce.return"(%8) : (f32) -> ()
        }) : (f32) -> ()
      }) {mapping = [#gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = thread_y, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index, f32) -> f32
      "memref.store"(%6, %0) : (f32, memref<f32>) -> ()
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index) -> ()
    "memref.dealloc"(%0) : (memref<f32>) -> ()
    "memref.dealloc"(%1) : (memref<8x8xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0 * 128)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_reduction_1d_tiled"}> ({
    %0 = "arith.constant"() <{value = 128 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 64 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8192xf32>
    %6 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xf32>
    "scf.parallel"(%3, %2, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg0: index):
      %7 = "memref.subview"(%6, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<64xf32>, index) -> memref<f32, strided<[], offset: ?>>
      %8 = "affine.apply"(%arg0) <{map = #map}> : (index) -> index
      %9 = "memref.subview"(%5, %8) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<8192xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
      %10 = "scf.parallel"(%3, %0, %1, %4) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> ({
      ^bb0(%arg1: index):
        %11 = "memref.load"(%9, %arg1) : (memref<128xf32, strided<[1], offset: ?>>, index) -> f32
        "scf.reduce"(%11) ({
        ^bb0(%arg2: f32, %arg3: f32):
          %12 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "scf.reduce.return"(%12) : (f32) -> ()
        }) : (f32) -> ()
      }) {mapping = [#gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, f32) -> f32
      "memref.store"(%10, %7) : (f32, memref<f32, strided<[], offset: ?>>) -> ()
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index) -> ()
    "memref.dealloc"(%5) : (memref<8192xf32>) -> ()
    "memref.dealloc"(%6) : (memref<64xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (ui32) -> (), sym_name = "parallel_reduction_1d_uint"}> ({
  ^bb0(%arg0: ui32):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<ui32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xui32>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 64 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    "scf.parallel"(%4, %2, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg1: index):
      %5 = "scf.parallel"(%4, %3, %2, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> ({
      ^bb0(%arg2: index):
        %6 = "memref.load"(%1, %arg2) : (memref<64xui32>, index) -> ui32
        "scf.reduce"(%6) ({
        ^bb0(%arg3: ui32, %arg4: ui32):
          "scf.reduce.return"(%arg3) : (ui32) -> ()
        }) : (ui32) -> ()
      }) {mapping = [#gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, ui32) -> ui32
      "memref.store"(%5, %0) : (ui32, memref<ui32>) -> ()
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index) -> ()
    "memref.dealloc"(%0) : (memref<ui32>) -> ()
    "memref.dealloc"(%1) : (memref<64xui32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_reduction_1d_outside"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xf32>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 64 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
    "scf.parallel"(%4, %2, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg0: index):
      %7 = "scf.parallel"(%4, %3, %2, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> ({
      ^bb0(%arg1: index):
        %8 = "memref.load"(%1, %arg1) : (memref<64xf32>, index) -> f32
        "scf.reduce"(%8) ({
        ^bb0(%arg2: f32, %arg3: f32):
          %9 = "arith.addf"(%arg2, %arg3) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          %10 = "arith.addf"(%9, %6) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "scf.reduce.return"(%10) : (f32) -> ()
        }) : (f32) -> ()
      }) {mapping = [#gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, f32) -> f32
      "memref.store"(%7, %0) : (f32, memref<f32>) -> ()
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index) -> ()
    "memref.dealloc"(%0) : (memref<f32>) -> ()
    "memref.dealloc"(%1) : (memref<64xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "nested_parallel_with_side_effect"}> ({
    %0 = "arith.constant"() <{value = 65536 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 256 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 4 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    %6 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x256x256xf32>
    %7 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x4x256x256xf32>
    %8 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x4xf32>
    %9 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x4xf32>
    "scf.parallel"(%3, %3, %3, %1, %4, %0, %5, %5, %5) <{operandSegmentSizes = array<i32: 3, 3, 3, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index):
      %10 = "arith.remsi"(%arg2, %2) : (index, index) -> index
      %11 = "arith.divsi"(%arg2, %2) : (index, index) -> index
      %12 = "memref.load"(%6, %arg0, %11, %10) : (memref<2x256x256xf32>, index, index, index) -> f32
      "memref.store"(%12, %7, %arg0, %arg1, %11, %10) : (f32, memref<2x4x256x256xf32>, index, index, index, index) -> ()
      "scf.parallel"(%3, %4, %5) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
      ^bb0(%arg3: index):
        %13 = "memref.load"(%8, %arg3, %3) : (memref<4x4xf32>, index, index) -> f32
        "memref.store"(%13, %9, %arg3, %3) : (f32, memref<4x4xf32>, index, index) -> ()
        "scf.reduce"() : () -> ()
      }) {mapping = [#gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_z, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "scf2gpu_index_creation_2d"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    "scf.parallel"(%0, %0, %2, %2, %1, %1) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg0: index, %arg1: index):
      %3 = "arith.addi"(%arg0, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "arith.addi"(%arg1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "scf2gpu_index_creation_1d"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 64 : index}> : () -> index
    "scf.parallel"(%0, %2, %1) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
    ^bb0(%arg0: index):
      %3 = "arith.addi"(%arg0, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.reduce"() : () -> ()
    }) {mapping = [#gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]} : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

