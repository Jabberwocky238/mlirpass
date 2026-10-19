#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "parallel_loop_bidy_bidx"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: memref<?x?xf32>, %arg6: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "affine.apply"(%arg2, %arg0, %arg4) <{map = #map}> : (index, index, index) -> index
    %3 = "affine.apply"(%arg3, %arg1, %0) <{map = #map}> : (index, index, index) -> index
    "gpu.launch"(%3, %2, %1, %1, %1, %1) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index, %arg18: index):
      %4 = "affine.apply"(%arg8, %arg4, %arg0) <{map = #map1}> : (index, index, index) -> index
      %5 = "affine.apply"(%arg7, %0, %arg1) <{map = #map1}> : (index, index, index) -> index
      %6 = "memref.load"(%arg5, %4, %5) : (memref<?x?xf32>, index, index) -> f32
      "memref.store"(%6, %arg6, %5, %4) : (f32, memref<?x?xf32>, index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "parallel_loop_tiled"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "affine.apply"(%arg2, %arg0, %2) <{map = #map}> : (index, index, index) -> index
    %5 = "affine.apply"(%arg3, %arg1, %2) <{map = #map}> : (index, index, index) -> index
    %6 = "affine.apply"(%2, %0, %1) <{map = #map}> : (index, index, index) -> index
    %7 = "affine.apply"(%2, %0, %1) <{map = #map}> : (index, index, index) -> index
    "gpu.launch"(%5, %4, %3, %7, %6, %3) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      %8 = "affine.apply"(%arg7, %2, %arg0) <{map = #map1}> : (index, index, index) -> index
      %9 = "affine.apply"(%arg6, %2, %arg1) <{map = #map1}> : (index, index, index) -> index
      %10 = "affine.apply"(%arg10, %1, %0) <{map = #map1}> : (index, index, index) -> index
      %11 = "affine.apply"(%arg9, %1, %0) <{map = #map1}> : (index, index, index) -> index
      %12 = "arith.addi"(%8, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%9, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "memref.load"(%arg4, %12, %13) : (memref<?x?xf32>, index, index) -> f32
      "memref.store"(%14, %arg5, %13, %12) : (f32, memref<?x?xf32>, index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "parallel_loop_bidy_seq"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: memref<?x?xf32>, %arg6: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "affine.apply"(%arg2, %arg0, %arg4) <{map = #map}> : (index, index, index) -> index
    "gpu.launch"(%1, %2, %1, %1, %1, %1) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index, %arg18: index):
      %3 = "affine.apply"(%arg8, %arg4, %arg0) <{map = #map1}> : (index, index, index) -> index
      "scf.for"(%arg1, %arg3, %0) ({
      ^bb0(%arg19: index):
        %4 = "memref.load"(%arg5, %3, %arg19) : (memref<?x?xf32>, index, index) -> f32
        "memref.store"(%4, %arg6, %arg19, %3) : (f32, memref<?x?xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, memref<?x?xf32>, memref<?x?xf32>) -> (), sym_name = "parallel_loop_tiled_seq"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 4 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "affine.apply"(%arg2, %arg0, %2) <{map = #map}> : (index, index, index) -> index
    %5 = "affine.apply"(%2, %0, %1) <{map = #map}> : (index, index, index) -> index
    "gpu.launch"(%3, %4, %3, %3, %5, %3) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index, %arg15: index, %arg16: index, %arg17: index):
      %6 = "affine.apply"(%arg7, %2, %arg0) <{map = #map1}> : (index, index, index) -> index
      "scf.for"(%arg1, %arg3, %2) ({
      ^bb0(%arg18: index):
        %7 = "affine.apply"(%arg10, %1, %0) <{map = #map1}> : (index, index, index) -> index
        "scf.for"(%0, %2, %1) ({
        ^bb0(%arg19: index):
          %8 = "arith.addi"(%6, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %9 = "arith.addi"(%arg18, %arg19) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
          %10 = "memref.load"(%arg4, %8, %9) : (memref<?x?xf32>, index, index) -> f32
          "memref.store"(%10, %arg5, %9, %8) : (f32, memref<?x?xf32>, index, index) -> ()
          "scf.yield"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
#map2 = affine_map<(d0)[s0] -> (2, -d0 + s0)>
#map3 = affine_map<(d0)[s0] -> (3, -d0 + s0)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32, strided<[?, 1], offset: ?>>, memref<?x?xf32, strided<[?, 1], offset: ?>>, memref<?x?xf32, strided<[?, 1], offset: ?>>) -> (), sym_name = "sum"}> ({
  ^bb0(%arg0: memref<?x?xf32, strided<[?, 1], offset: ?>>, %arg1: memref<?x?xf32, strided<[?, 1], offset: ?>>, %arg2: memref<?x?xf32, strided<[?, 1], offset: ?>>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "memref.dim"(%arg0, %1) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
    %5 = "memref.dim"(%arg0, %0) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "affine.apply"(%4, %1, %3) <{map = #map}> : (index, index, index) -> index
    %8 = "affine.apply"(%5, %1, %2) <{map = #map}> : (index, index, index) -> index
    %9 = "arith.constant"() <{value = 2 : index}> : () -> index
    %10 = "arith.constant"() <{value = 2 : index}> : () -> index
    %11 = "arith.constant"() <{value = 4 : index}> : () -> index
    %12 = "affine.apply"(%11, %1, %0) <{map = #map}> : (index, index, index) -> index
    %13 = "affine.apply"(%2, %1, %0) <{map = #map}> : (index, index, index) -> index
    "gpu.launch"(%7, %8, %6, %12, %13, %6) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index, %arg14: index):
      %14 = "affine.apply"(%arg3, %3, %1) <{map = #map1}> : (index, index, index) -> index
      %15 = "affine.apply"(%arg4, %2, %1) <{map = #map1}> : (index, index, index) -> index
      %16 = "memref.dim"(%arg0, %1) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
      %17 = "affine.min"(%14, %16) <{map = #map2}> : (index, index) -> index
      %18 = "arith.muli"(%17, %17) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %19 = "memref.dim"(%arg0, %0) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
      %20 = "arith.subi"(%19, %15) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %21 = "arith.minsi"(%2, %20) : (index, index) -> index
      %22 = "memref.subview"(%arg0, %14, %15, %18, %21, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
      %23 = "memref.dim"(%arg1, %1) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
      %24 = "affine.min"(%14, %23) <{map = #map2}> : (index, index) -> index
      %25 = "memref.dim"(%arg1, %0) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
      %26 = "affine.min"(%15, %25) <{map = #map3}> : (index, index) -> index
      %27 = "memref.subview"(%arg1, %14, %15, %24, %26, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
      %28 = "memref.dim"(%arg2, %1) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
      %29 = "affine.min"(%14, %28) <{map = #map2}> : (index, index) -> index
      %30 = "memref.dim"(%arg2, %0) : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index) -> index
      %31 = "affine.min"(%15, %30) <{map = #map3}> : (index, index) -> index
      %32 = "memref.subview"(%arg2, %14, %15, %29, %31, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 2, 2>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<?x?xf32, strided<[?, 1], offset: ?>>, index, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
      %33 = "affine.apply"(%arg6, %0, %1) <{map = #map1}> : (index, index, index) -> index
      %34 = "arith.cmpi"(%33, %18) <{predicate = 2 : i64}> : (index, index) -> i1
      "scf.if"(%34) ({
        %35 = "affine.apply"(%arg7, %0, %1) <{map = #map1}> : (index, index, index) -> index
        %36 = "arith.cmpi"(%35, %21) <{predicate = 2 : i64}> : (index, index) -> i1
        "scf.if"(%36) ({
          %37 = "memref.load"(%22, %33, %35) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> f32
          %38 = "memref.load"(%27, %33, %35) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> f32
          %39 = "memref.load"(%32, %33, %35) : (memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> f32
          %40 = "arith.addf"(%37, %38) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
          "memref.store"(%40, %32, %33, %35) : (f32, memref<?x?xf32, strided<[?, ?], offset: ?>>, index, index) -> ()
          "scf.yield"() : () -> ()
        }, {
        }) : (i1) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_loop_optional_attr"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "affine.apply"(%1, %0, %1) <{map = #map}> : (index, index, index) -> index
    "gpu.launch"(%3, %2, %2, %2, %2, %2) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %4 = "affine.apply"(%arg0, %1, %0) <{map = #map1}> : (index, index, index) -> index
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, optional_attr = 1 : i64, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
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
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "step_invariant"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x1xf64>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x1xf64>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1x1xf64>
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 1 : index}> : () -> index
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "affine.apply"(%4, %3, %5) <{map = #map}> : (index, index, index) -> index
    %8 = "arith.constant"() <{value = 1 : index}> : () -> index
    %9 = "arith.constant"() <{value = 0 : index}> : () -> index
    %10 = "arith.constant"() <{value = 1 : index}> : () -> index
    %11 = "affine.apply"(%8, %9, %10) <{map = #map}> : (index, index, index) -> index
    "gpu.launch"(%7, %6, %6, %11, %6, %6) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %12 = "affine.apply"(%arg0, %5, %3) <{map = #map1}> : (index, index, index) -> index
      %13 = "arith.constant"() <{value = 0 : index}> : () -> index
      %14 = "arith.constant"() <{value = 1 : index}> : () -> index
      %15 = "arith.constant"() <{value = 1 : index}> : () -> index
      %16 = "arith.constant"() <{value = 1 : index}> : () -> index
      %17 = "arith.constant"() <{value = 0 : index}> : () -> index
      %18 = "affine.apply"(%arg3, %16, %17) <{map = #map1}> : (index, index, index) -> index
      %19 = "memref.load"(%2, %12, %18) : (memref<1x1xf64>, index, index) -> f64
      %20 = "memref.load"(%1, %12, %18) : (memref<1x1xf64>, index, index) -> f64
      %21 = "arith.addf"(%19, %20) <{fastmath = #arith.fastmath<none>}> : (f64, f64) -> f64
      "memref.store"(%21, %0, %12, %18) : (f64, memref<1x1xf64>, index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "memref.dealloc"(%2) : (memref<1x1xf64>) -> ()
    "memref.dealloc"(%1) : (memref<1x1xf64>) -> ()
    "memref.dealloc"(%0) : (memref<1x1xf64>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_reduction_1d"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xf32>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 64 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "affine.apply"(%2, %4, %2) <{map = #map}> : (index, index, index) -> index
    %8 = "affine.apply"(%3, %4, %2) <{map = #map}> : (index, index, index) -> index
    "gpu.launch"(%7, %6, %6, %8, %6, %6) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %9 = "affine.apply"(%arg0, %2, %4) <{map = #map1}> : (index, index, index) -> index
      %10 = "affine.apply"(%arg3, %2, %4) <{map = #map1}> : (index, index, index) -> index
      %11 = "memref.load"(%1, %10) : (memref<64xf32>, index) -> f32
      %12 = "gpu.all_reduce"(%11) ({
      ^bb0(%arg12: f32, %arg13: f32):
        %13 = "arith.addf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "gpu.yield"(%13) : (f32) -> ()
      }) : (f32) -> f32
      "memref.store"(%12, %0) : (f32, memref<f32>) -> ()
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "memref.dealloc"(%0) : (memref<f32>) -> ()
    "memref.dealloc"(%1) : (memref<64xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_reduction_2d"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8x8xf32>
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 8 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %6 = "arith.constant"() <{value = 1 : index}> : () -> index
    %7 = "affine.apply"(%2, %4, %2) <{map = #map}> : (index, index, index) -> index
    %8 = "affine.apply"(%3, %4, %2) <{map = #map}> : (index, index, index) -> index
    %9 = "affine.apply"(%3, %4, %2) <{map = #map}> : (index, index, index) -> index
    "gpu.launch"(%7, %6, %6, %8, %9, %6) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %10 = "affine.apply"(%arg0, %2, %4) <{map = #map1}> : (index, index, index) -> index
      %11 = "affine.apply"(%arg3, %2, %4) <{map = #map1}> : (index, index, index) -> index
      %12 = "affine.apply"(%arg4, %2, %4) <{map = #map1}> : (index, index, index) -> index
      %13 = "memref.load"(%1, %11, %12) : (memref<8x8xf32>, index, index) -> f32
      %14 = "gpu.all_reduce"(%13) ({
      ^bb0(%arg12: f32, %arg13: f32):
        %15 = "arith.addf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "gpu.yield"(%15) : (f32) -> ()
      }) : (f32) -> f32
      "memref.store"(%14, %0) : (f32, memref<f32>) -> ()
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "memref.dealloc"(%0) : (memref<f32>) -> ()
    "memref.dealloc"(%1) : (memref<8x8xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
#map2 = affine_map<(d0) -> (d0 * 128)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "parallel_reduction_1d_tiled"}> ({
    %0 = "arith.constant"() <{value = 128 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 64 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<8192xf32>
    %6 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<64xf32>
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "affine.apply"(%2, %3, %1) <{map = #map}> : (index, index, index) -> index
    %9 = "affine.apply"(%0, %3, %1) <{map = #map}> : (index, index, index) -> index
    "gpu.launch"(%8, %7, %7, %9, %7, %7) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %10 = "affine.apply"(%arg0, %1, %3) <{map = #map1}> : (index, index, index) -> index
      %11 = "memref.subview"(%6, %10) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 1>, static_strides = array<i64: 1>}> : (memref<64xf32>, index) -> memref<f32, strided<[], offset: ?>>
      %12 = "affine.apply"(%10) <{map = #map2}> : (index) -> index
      %13 = "memref.subview"(%5, %12) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 128>, static_strides = array<i64: 1>}> : (memref<8192xf32>, index) -> memref<128xf32, strided<[1], offset: ?>>
      %14 = "affine.apply"(%arg3, %1, %3) <{map = #map1}> : (index, index, index) -> index
      %15 = "memref.load"(%13, %14) : (memref<128xf32, strided<[1], offset: ?>>, index) -> f32
      %16 = "gpu.all_reduce"(%15) ({
      ^bb0(%arg12: f32, %arg13: f32):
        %17 = "arith.addf"(%arg12, %arg13) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
        "gpu.yield"(%17) : (f32) -> ()
      }) : (f32) -> f32
      "memref.store"(%16, %11) : (f32, memref<f32, strided<[], offset: ?>>) -> ()
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
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
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
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
    %10 = "arith.constant"() <{value = 1 : index}> : () -> index
    %11 = "affine.apply"(%1, %3, %5) <{map = #map}> : (index, index, index) -> index
    %12 = "affine.apply"(%4, %3, %5) <{map = #map}> : (index, index, index) -> index
    %13 = "affine.apply"(%0, %3, %5) <{map = #map}> : (index, index, index) -> index
    %14 = "affine.apply"(%4, %3, %5) <{map = #map}> : (index, index, index) -> index
    "gpu.launch"(%13, %12, %11, %14, %10, %10) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %15 = "affine.apply"(%arg2, %5, %3) <{map = #map1}> : (index, index, index) -> index
      %16 = "affine.apply"(%arg1, %5, %3) <{map = #map1}> : (index, index, index) -> index
      %17 = "affine.apply"(%arg0, %5, %3) <{map = #map1}> : (index, index, index) -> index
      %18 = "arith.remsi"(%17, %2) : (index, index) -> index
      %19 = "arith.divsi"(%17, %2) : (index, index) -> index
      %20 = "memref.load"(%6, %15, %19, %18) : (memref<2x256x256xf32>, index, index, index) -> f32
      "memref.store"(%20, %7, %15, %16, %19, %18) : (f32, memref<2x4x256x256xf32>, index, index, index, index) -> ()
      %21 = "affine.apply"(%arg3, %5, %3) <{map = #map1}> : (index, index, index) -> index
      %22 = "memref.load"(%8, %21, %3) : (memref<4x4xf32>, index, index) -> f32
      "memref.store"(%22, %9, %21, %3) : (f32, memref<4x4xf32>, index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "scf2gpu_index_creation_2d"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 32 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "affine.apply"(%2, %0, %1) <{map = #map}> : (index, index, index) -> index
    %5 = "affine.apply"(%2, %0, %1) <{map = #map}> : (index, index, index) -> index
    "gpu.launch"(%4, %3, %3, %5, %3, %3) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %6 = "affine.apply"(%arg0, %1, %0) <{map = #map1}> : (index, index, index) -> index
      %7 = "affine.apply"(%arg3, %1, %0) <{map = #map1}> : (index, index, index) -> index
      %8 = "arith.addi"(%6, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %9 = "arith.addi"(%7, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "scf2gpu_index_creation_1d"}> ({
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 64 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "affine.apply"(%2, %0, %1) <{map = #map}> : (index, index, index) -> index
    "gpu.launch"(%3, %3, %3, %4, %3, %3) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %5 = "affine.apply"(%arg3, %1, %0) <{map = #map1}> : (index, index, index) -> index
      %6 = "arith.addi"(%5, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "gpu.terminator"() : () -> ()
    }) {SCFToGPU_visited, workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

