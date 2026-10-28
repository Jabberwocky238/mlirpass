"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xi8>, memref<?x?xi32>) -> (), sym_name = "muli"}> ({
  ^bb0(%arg11: memref<?x?xi8>, %arg12: memref<?x?xi32>):
    %19 = "arith.constant"() <{value = 0 : index}> : () -> index
    %20 = "amx.tile_zero"() : () -> !amx.tile<16x64xi8>
    %21 = "amx.tile_load"(%arg11, %19, %19) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xi8>, index, index) -> !amx.tile<16x64xi8>
    %22 = "amx.tile_load"(%arg12, %19, %19) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xi32>, index, index) -> !amx.tile<16x16xi32>
    %23 = "amx.tile_muli"(%20, %21, %22) <{isZextLhs, isZextRhs}> : (!amx.tile<16x64xi8>, !amx.tile<16x64xi8>, !amx.tile<16x16xi32>) -> !amx.tile<16x16xi32>
    "amx.tile_store"(%arg12, %19, %19, %23) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xi32>, index, index, !amx.tile<16x16xi32>) -> ()
    %24 = "amx.tile_muli"(%20, %21, %22) : (!amx.tile<16x64xi8>, !amx.tile<16x64xi8>, !amx.tile<16x16xi32>) -> !amx.tile<16x16xi32>
    "amx.tile_store"(%arg12, %19, %19, %24) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xi32>, index, index, !amx.tile<16x16xi32>) -> ()
    %25 = "amx.tile_muli"(%20, %21, %22) <{isZextLhs}> : (!amx.tile<16x64xi8>, !amx.tile<16x64xi8>, !amx.tile<16x16xi32>) -> !amx.tile<16x16xi32>
    "amx.tile_store"(%arg12, %19, %19, %25) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xi32>, index, index, !amx.tile<16x16xi32>) -> ()
    %26 = "amx.tile_muli"(%20, %21, %22) <{isZextRhs}> : (!amx.tile<16x64xi8>, !amx.tile<16x64xi8>, !amx.tile<16x16xi32>) -> !amx.tile<16x16xi32>
    "amx.tile_store"(%arg12, %19, %19, %26) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xi32>, index, index, !amx.tile<16x16xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xbf16>, memref<?x?xf32>) -> (), sym_name = "mulbf16"}> ({
  ^bb0(%arg9: memref<?x?xbf16>, %arg10: memref<?x?xf32>):
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "amx.tile_zero"() : () -> !amx.tile<16x32xbf16>
    %16 = "amx.tile_load"(%arg9, %14, %14) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xbf16>, index, index) -> !amx.tile<16x32xbf16>
    %17 = "amx.tile_load"(%arg10, %14, %14) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf32>, index, index) -> !amx.tile<16x16xf32>
    %18 = "amx.tile_mulf"(%15, %16, %17) : (!amx.tile<16x32xbf16>, !amx.tile<16x32xbf16>, !amx.tile<16x16xf32>) -> !amx.tile<16x16xf32>
    "amx.tile_store"(%arg10, %14, %14, %18) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xf32>, index, index, !amx.tile<16x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf16>, memref<?x?xf32>) -> (), sym_name = "mulfp16"}> ({
  ^bb0(%arg7: memref<?x?xf16>, %arg8: memref<?x?xf32>):
    %9 = "arith.constant"() <{value = 0 : index}> : () -> index
    %10 = "amx.tile_zero"() : () -> !amx.tile<16x32xf16>
    %11 = "amx.tile_load"(%arg7, %9, %9) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf16>, index, index) -> !amx.tile<16x32xf16>
    %12 = "amx.tile_load"(%arg8, %9, %9) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf32>, index, index) -> !amx.tile<16x16xf32>
    %13 = "amx.tile_mulf"(%10, %11, %12) : (!amx.tile<16x32xf16>, !amx.tile<16x32xf16>, !amx.tile<16x16xf32>) -> !amx.tile<16x16xf32>
    "amx.tile_store"(%arg8, %9, %9, %13) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xf32>, index, index, !amx.tile<16x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16x32xi8>, memref<32x32xbf16, strided<[64, 1]>>, memref<16x32xf32, strided<[?, 1]>>) -> (), sym_name = "strides_implicit"}> ({
  ^bb0(%arg4: memref<16x32xi8>, %arg5: memref<32x32xbf16, strided<[64, 1]>>, %arg6: memref<16x32xf32, strided<[?, 1]>>):
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "amx.tile_load"(%arg4, %5, %5) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x32xi8>, index, index) -> !amx.tile<16x32xi8>
    %7 = "amx.tile_load"(%arg5, %5, %5) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x32xbf16, strided<[64, 1]>>, index, index) -> !amx.tile<16x32xbf16>
    %8 = "amx.tile_load"(%arg6, %5, %5) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x32xf32, strided<[?, 1]>>, index, index) -> !amx.tile<16x16xf32>
    "amx.tile_store"(%arg4, %5, %5, %6) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x32xi8>, index, index, !amx.tile<16x32xi8>) -> ()
    "amx.tile_store"(%arg5, %5, %5, %7) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xbf16, strided<[64, 1]>>, index, index, !amx.tile<16x32xbf16>) -> ()
    "amx.tile_store"(%arg6, %5, %5, %8) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x32xf32, strided<[?, 1]>>, index, index, !amx.tile<16x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, memref<?xi8>, memref<16x32xbf16>, memref<32x32xf32, strided<[64, 1]>>) -> (), sym_name = "strides_explicit"}> ({
  ^bb0(%arg0: index, %arg1: memref<?xi8>, %arg2: memref<16x32xbf16>, %arg3: memref<32x32xf32, strided<[64, 1]>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 64 : index}> : () -> index
    %2 = "amx.tile_load"(%arg1, %0, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (memref<?xi8>, index, index) -> !amx.tile<16x32xi8>
    %3 = "amx.tile_load"(%arg2, %0, %0, %arg0) <{operandSegmentSizes = array<i32: 1, 2, 1>}> : (memref<16x32xbf16>, index, index, index) -> !amx.tile<16x32xbf16>
    %4 = "amx.tile_load"(%arg3, %0, %0, %1) <{operandSegmentSizes = array<i32: 1, 2, 1>}> : (memref<32x32xf32, strided<[64, 1]>>, index, index, index) -> !amx.tile<16x16xf32>
    "amx.tile_store"(%arg1, %0, %2, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (memref<?xi8>, index, !amx.tile<16x32xi8>, index) -> ()
    "amx.tile_store"(%arg2, %0, %0, %3, %arg0) <{operandSegmentSizes = array<i32: 1, 2, 1, 1>}> : (memref<16x32xbf16>, index, index, !amx.tile<16x32xbf16>, index) -> ()
    "amx.tile_store"(%arg3, %0, %0, %4, %1) <{operandSegmentSizes = array<i32: 1, 2, 1, 1>}> : (memref<32x32xf32, strided<[64, 1]>>, index, index, !amx.tile<16x16xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

