"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x32x32xbf16>, memref<2x16x32xbf16>) -> memref<16x32xf32>, sym_name = "do_not_fold_tiles"}> ({
  ^bb0(%arg0: memref<2x32x32xbf16>, %arg1: memref<2x16x32xbf16>):
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xf32>
    %5 = "amx.tile_zero"() : () -> !amx.tile<16x16xf32>
    %6 = "amx.tile_zero"() : () -> !amx.tile<16x16xf32>
    %7:2 = "scf.for"(%1, %2, %0, %5, %6) ({
    ^bb0(%arg2: index, %arg3: !amx.tile<16x16xf32>, %arg4: !amx.tile<16x16xf32>):
      %8 = "amx.tile_load"(%arg0, %arg2, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !amx.tile<16x32xbf16>
      %9 = "amx.tile_load"(%arg0, %arg2, %3, %1) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x32x32xbf16>, index, index, index) -> !amx.tile<16x32xbf16>
      %10 = "amx.tile_load"(%arg1, %arg2, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x16x32xbf16>, index, index, index) -> !amx.tile<16x32xbf16>
      %11 = "amx.tile_load"(%arg1, %arg2, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 0>}> : (memref<2x16x32xbf16>, index, index, index) -> !amx.tile<16x32xbf16>
      %12 = "amx.tile_mulf"(%8, %10, %arg3) : (!amx.tile<16x32xbf16>, !amx.tile<16x32xbf16>, !amx.tile<16x16xf32>) -> !amx.tile<16x16xf32>
      %13 = "amx.tile_mulf"(%9, %11, %arg4) : (!amx.tile<16x32xbf16>, !amx.tile<16x32xbf16>, !amx.tile<16x16xf32>) -> !amx.tile<16x16xf32>
      "scf.yield"(%12, %13) : (!amx.tile<16x16xf32>, !amx.tile<16x16xf32>) -> ()
    }) : (index, index, index, !amx.tile<16x16xf32>, !amx.tile<16x16xf32>) -> (!amx.tile<16x16xf32>, !amx.tile<16x16xf32>)
    "amx.tile_store"(%4, %1, %1, %7#0) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x32xf32>, index, index, !amx.tile<16x16xf32>) -> ()
    "amx.tile_store"(%4, %1, %3, %7#1) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x32xf32>, index, index, !amx.tile<16x16xf32>) -> ()
    "func.return"(%4) : (memref<16x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

