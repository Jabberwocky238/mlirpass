"builtin.module"() ({
  "func.func"() <{function_type = (index, memref<?xbf16>, memref<?x?xbf16>, memref<?x?xbf16, strided<[64, 1]>>) -> (), sym_name = "tloadstore"}> ({
  ^bb0(%arg6: index, %arg7: memref<?xbf16>, %arg8: memref<?x?xbf16>, %arg9: memref<?x?xbf16, strided<[64, 1]>>):
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "arith.constant"() <{value = 64 : index}> : () -> index
    %16 = "x86.amx.tile_load"(%arg7, %14, %arg6) <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (memref<?xbf16>, index, index) -> !x86.amx.tile<16x32xbf16>
    %17 = "x86.amx.tile_load"(%arg8, %14, %14, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 1>}> : (memref<?x?xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
    %18 = "x86.amx.tile_load"(%arg9, %14, %14) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xbf16, strided<[64, 1]>>, index, index) -> !x86.amx.tile<16x32xbf16>
    "x86.amx.tile_store"(%arg7, %14, %18, %arg6) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (memref<?xbf16>, index, !x86.amx.tile<16x32xbf16>, index) -> ()
    "x86.amx.tile_store"(%arg8, %14, %14, %16, %arg6) <{operandSegmentSizes = array<i32: 1, 2, 1, 1>}> : (memref<?x?xbf16>, index, index, !x86.amx.tile<16x32xbf16>, index) -> ()
    "x86.amx.tile_store"(%arg9, %14, %14, %17) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xbf16, strided<[64, 1]>>, index, index, !x86.amx.tile<16x32xbf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xbf16>) -> (), sym_name = "tzero"}> ({
  ^bb0(%arg5: memref<?x?xbf16>):
    %12 = "arith.constant"() <{value = 0 : index}> : () -> index
    %13 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x16xbf16>
    "x86.amx.tile_store"(%arg5, %12, %12, %13) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xbf16>, index, index, !x86.amx.tile<16x16xbf16>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xbf16>, memref<?x?xf32>) -> (), sym_name = "tmulf"}> ({
  ^bb0(%arg3: memref<?x?xbf16>, %arg4: memref<?x?xf32>):
    %8 = "arith.constant"() <{value = 0 : index}> : () -> index
    %9 = "x86.amx.tile_load"(%arg3, %8, %8) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xbf16>, index, index) -> !x86.amx.tile<16x32xbf16>
    %10 = "x86.amx.tile_load"(%arg4, %8, %8) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf32>, index, index) -> !x86.amx.tile<16x16xf32>
    %11 = "x86.amx.tile_mulf"(%9, %9, %10) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
    "x86.amx.tile_store"(%arg4, %8, %8, %11) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xi8>, memref<?x?xi8>, memref<?x?xi32>) -> (), sym_name = "tmuli"}> ({
  ^bb0(%arg0: memref<?x?xi8>, %arg1: memref<?x?xi8>, %arg2: memref<?x?xi32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "x86.amx.tile_load"(%arg0, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xi8>, index, index) -> !x86.amx.tile<16x64xi8>
    %2 = "x86.amx.tile_load"(%arg1, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xi8>, index, index) -> !x86.amx.tile<16x64xi8>
    %3 = "x86.amx.tile_load"(%arg2, %0, %0) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xi32>, index, index) -> !x86.amx.tile<16x16xi32>
    %4 = "x86.amx.tile_muli"(%1, %2, %3) <{isZextLhs, isZextRhs}> : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
    "x86.amx.tile_store"(%arg2, %0, %0, %4) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
    %5 = "x86.amx.tile_muli"(%1, %2, %3) <{isZextRhs}> : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
    %6 = "x86.amx.tile_muli"(%1, %2, %3) <{isZextLhs}> : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
    %7 = "x86.amx.tile_muli"(%1, %2, %3) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

