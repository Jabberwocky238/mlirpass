"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<?xbf16>, memref<?x?xbf16>, memref<?x?xbf16, strided<[64, 1]>>) -> (), sym_name = "tloadstore"}> ({
  ^bb0(%arg6: index, %arg7: memref<?xbf16>, %arg8: memref<?x?xbf16>, %arg9: memref<?x?xbf16, strided<[64, 1]>>):
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "arith.constant"() <{value = 64 : index}> : () -> index
    %16 = "amx.tile_load"(%arg7, %14, %arg6) <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (memref<?xbf16>, index, index) -> !amx.tile<16x32xbf16>
    %17 = "amx.tile_load"(%arg8, %14, %14, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 1>}> : (memref<?x?xbf16>, index, index, index) -> !amx.tile<16x32xbf16>
    %18 = "amx.tile_load"(%arg9, %14, %14) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xbf16, strided<[64, 1]>>, index, index) -> !amx.tile<16x32xbf16>
    "amx.tile_store"(%arg7, %14, %18, %arg6) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (memref<?xbf16>, index, !amx.tile<16x32xbf16>, index) -> ()
    "amx.tile_store"(%arg8, %14, %14, %16, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 1, 1>}> : (memref<?x?xbf16>, index, index, !amx.tile<16x32xbf16>, index) -> ()
    "amx.tile_store"(%arg9, %14, %14, %17) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xbf16, strided<[64, 1]>>, index, index, !amx.tile<16x32xbf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xbf16>) -> (), sym_name = "tzero"}> ({
  ^bb0(%arg5: memref<?x?xbf16>):
    %12 = "arith.constant"() <{value = 0 : index}> : () -> index
    %13 = "amx.tile_zero"() : () -> !amx.tile<16x16xbf16>
    "amx.tile_store"(%arg5, %12, %12, %13) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xbf16>, index, index, !amx.tile<16x16xbf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xbf16>, memref<?x?xf32>) -> (), sym_name = "tmulf"}> ({
  ^bb0(%arg3: memref<?x?xbf16>, %arg4: memref<?x?xf32>):
    %8 = "arith.constant"() <{value = 0 : index}> : () -> index
    %9 = "amx.tile_load"(%arg3, %8, %8) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xbf16>, index, index) -> !amx.tile<16x32xbf16>
    %10 = "amx.tile_load"(%arg4, %8, %8) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf32>, index, index) -> !amx.tile<16x16xf32>
    %11 = "amx.tile_mulf"(%9, %9, %10) : (!amx.tile<16x32xbf16>, !amx.tile<16x32xbf16>, !amx.tile<16x16xf32>) -> !amx.tile<16x16xf32>
    "amx.tile_store"(%arg4, %8, %8, %11) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xf32>, index, index, !amx.tile<16x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xi8>, memref<?x?xi8>, memref<?x?xi32>) -> (), sym_name = "tmuli"}> ({
  ^bb0(%arg0: memref<?x?xi8>, %arg1: memref<?x?xi8>, %arg2: memref<?x?xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "amx.tile_load"(%arg0, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xi8>, index, index) -> !amx.tile<16x64xi8>
    %2 = "amx.tile_load"(%arg1, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xi8>, index, index) -> !amx.tile<16x64xi8>
    %3 = "amx.tile_load"(%arg2, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xi32>, index, index) -> !amx.tile<16x16xi32>
    %4 = "amx.tile_muli"(%1, %2, %3) <{isZextLhs, isZextRhs}> : (!amx.tile<16x64xi8>, !amx.tile<16x64xi8>, !amx.tile<16x16xi32>) -> !amx.tile<16x16xi32>
    "amx.tile_store"(%arg2, %0, %0, %4) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xi32>, index, index, !amx.tile<16x16xi32>) -> ()
    %5 = "amx.tile_muli"(%1, %2, %3) <{isZextRhs}> : (!amx.tile<16x64xi8>, !amx.tile<16x64xi8>, !amx.tile<16x16xi32>) -> !amx.tile<16x16xi32>
    %6 = "amx.tile_muli"(%1, %2, %3) <{isZextLhs}> : (!amx.tile<16x64xi8>, !amx.tile<16x64xi8>, !amx.tile<16x16xi32>) -> !amx.tile<16x16xi32>
    %7 = "amx.tile_muli"(%1, %2, %3) : (!amx.tile<16x64xi8>, !amx.tile<16x64xi8>, !amx.tile<16x16xi32>) -> !amx.tile<16x16xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

