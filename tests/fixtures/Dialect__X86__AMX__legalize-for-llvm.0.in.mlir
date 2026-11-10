"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xi8>, memref<?x?xi32>) -> (), sym_name = "muli"}> ({
  ^bb0(%arg19: memref<?x?xi8>, %arg20: memref<?x?xi32>):
    %39 = "arith.constant"() <{value = 0 : index}> : () -> index
    %40 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x64xi8>
    %41 = "x86.amx.tile_load"(%arg19, %39, %39) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xi8>, index, index) -> !x86.amx.tile<16x64xi8>
    %42 = "x86.amx.tile_load"(%arg20, %39, %39) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xi32>, index, index) -> !x86.amx.tile<16x16xi32>
    %43 = "x86.amx.tile_muli"(%40, %41, %42) <{isZextLhs, isZextRhs}> : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
    "x86.amx.tile_store"(%arg20, %39, %39, %43) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
    %44 = "x86.amx.tile_muli"(%40, %41, %42) : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
    "x86.amx.tile_store"(%arg20, %39, %39, %44) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
    %45 = "x86.amx.tile_muli"(%40, %41, %42) <{isZextLhs}> : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
    "x86.amx.tile_store"(%arg20, %39, %39, %45) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
    %46 = "x86.amx.tile_muli"(%40, %41, %42) <{isZextRhs}> : (!x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>) -> !x86.amx.tile<16x16xi32>
    "x86.amx.tile_store"(%arg20, %39, %39, %46) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xi32>, index, index, !x86.amx.tile<16x16xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xbf16>, memref<?x?xf32>) -> (), sym_name = "mulbf16"}> ({
  ^bb0(%arg17: memref<?x?xbf16>, %arg18: memref<?x?xf32>):
    %34 = "arith.constant"() <{value = 0 : index}> : () -> index
    %35 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x32xbf16>
    %36 = "x86.amx.tile_load"(%arg17, %34, %34) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xbf16>, index, index) -> !x86.amx.tile<16x32xbf16>
    %37 = "x86.amx.tile_load"(%arg18, %34, %34) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf32>, index, index) -> !x86.amx.tile<16x16xf32>
    %38 = "x86.amx.tile_mulf"(%35, %36, %37) : (!x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
    "x86.amx.tile_store"(%arg18, %34, %34, %38) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf16>, memref<?x?xf32>) -> (), sym_name = "mulfp16"}> ({
  ^bb0(%arg15: memref<?x?xf16>, %arg16: memref<?x?xf32>):
    %29 = "arith.constant"() <{value = 0 : index}> : () -> index
    %30 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x32xf16>
    %31 = "x86.amx.tile_load"(%arg15, %29, %29) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf16>, index, index) -> !x86.amx.tile<16x32xf16>
    %32 = "x86.amx.tile_load"(%arg16, %29, %29) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf32>, index, index) -> !x86.amx.tile<16x16xf32>
    %33 = "x86.amx.tile_mulf"(%30, %31, %32) : (!x86.amx.tile<16x32xf16>, !x86.amx.tile<16x32xf16>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
    "x86.amx.tile_store"(%arg16, %29, %29, %33) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf8E4M3FN>, memref<?x?xf32>) -> (), sym_name = "mulf8E4M3FN"}> ({
  ^bb0(%arg13: memref<?x?xf8E4M3FN>, %arg14: memref<?x?xf32>):
    %24 = "arith.constant"() <{value = 0 : index}> : () -> index
    %25 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x64xf8E4M3FN>
    %26 = "x86.amx.tile_load"(%arg13, %24, %24) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf8E4M3FN>, index, index) -> !x86.amx.tile<16x64xf8E4M3FN>
    %27 = "x86.amx.tile_load"(%arg14, %24, %24) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf32>, index, index) -> !x86.amx.tile<16x16xf32>
    %28 = "x86.amx.tile_mulf"(%25, %26, %27) : (!x86.amx.tile<16x64xf8E4M3FN>, !x86.amx.tile<16x64xf8E4M3FN>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
    "x86.amx.tile_store"(%arg14, %24, %24, %28) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf8E5M2>, memref<?x?xf32>) -> (), sym_name = "mulf8E4M3FNxf8E5M2"}> ({
  ^bb0(%arg11: memref<?x?xf8E5M2>, %arg12: memref<?x?xf32>):
    %19 = "arith.constant"() <{value = 0 : index}> : () -> index
    %20 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x64xf8E4M3FN>
    %21 = "x86.amx.tile_load"(%arg11, %19, %19) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf8E5M2>, index, index) -> !x86.amx.tile<16x64xf8E5M2>
    %22 = "x86.amx.tile_load"(%arg12, %19, %19) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf32>, index, index) -> !x86.amx.tile<16x16xf32>
    %23 = "x86.amx.tile_mulf"(%20, %21, %22) : (!x86.amx.tile<16x64xf8E4M3FN>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
    "x86.amx.tile_store"(%arg12, %19, %19, %23) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf8E4M3FN>, memref<?x?xf32>) -> (), sym_name = "mulf8E5M2xf8E4M3FN"}> ({
  ^bb0(%arg9: memref<?x?xf8E4M3FN>, %arg10: memref<?x?xf32>):
    %14 = "arith.constant"() <{value = 0 : index}> : () -> index
    %15 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x64xf8E5M2>
    %16 = "x86.amx.tile_load"(%arg9, %14, %14) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf8E4M3FN>, index, index) -> !x86.amx.tile<16x64xf8E4M3FN>
    %17 = "x86.amx.tile_load"(%arg10, %14, %14) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf32>, index, index) -> !x86.amx.tile<16x16xf32>
    %18 = "x86.amx.tile_mulf"(%15, %16, %17) : (!x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E4M3FN>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
    "x86.amx.tile_store"(%arg10, %14, %14, %18) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?x?xf8E5M2>, memref<?x?xf32>) -> (), sym_name = "mulf8E5M2"}> ({
  ^bb0(%arg7: memref<?x?xf8E5M2>, %arg8: memref<?x?xf32>):
    %9 = "arith.constant"() <{value = 0 : index}> : () -> index
    %10 = "x86.amx.tile_zero"() : () -> !x86.amx.tile<16x64xf8E5M2>
    %11 = "x86.amx.tile_load"(%arg7, %9, %9) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf8E5M2>, index, index) -> !x86.amx.tile<16x64xf8E5M2>
    %12 = "x86.amx.tile_load"(%arg8, %9, %9) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<?x?xf32>, index, index) -> !x86.amx.tile<16x16xf32>
    %13 = "x86.amx.tile_mulf"(%10, %11, %12) : (!x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>) -> !x86.amx.tile<16x16xf32>
    "x86.amx.tile_store"(%arg8, %9, %9, %13) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<?x?xf32>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<16x32xi8>, memref<32x32xbf16, strided<[64, 1]>>, memref<16x32xf32, strided<[?, 1]>>) -> (), sym_name = "strides_implicit"}> ({
  ^bb0(%arg4: memref<16x32xi8>, %arg5: memref<32x32xbf16, strided<[64, 1]>>, %arg6: memref<16x32xf32, strided<[?, 1]>>):
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "x86.amx.tile_load"(%arg4, %5, %5) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x32xi8>, index, index) -> !x86.amx.tile<16x32xi8>
    %7 = "x86.amx.tile_load"(%arg5, %5, %5) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<32x32xbf16, strided<[64, 1]>>, index, index) -> !x86.amx.tile<16x32xbf16>
    %8 = "x86.amx.tile_load"(%arg6, %5, %5) <{operandSegmentSizes = array<i32: 1, 2, 0>}> : (memref<16x32xf32, strided<[?, 1]>>, index, index) -> !x86.amx.tile<16x16xf32>
    "x86.amx.tile_store"(%arg4, %5, %5, %6) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x32xi8>, index, index, !x86.amx.tile<16x32xi8>) -> ()
    "x86.amx.tile_store"(%arg5, %5, %5, %7) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<32x32xbf16, strided<[64, 1]>>, index, index, !x86.amx.tile<16x32xbf16>) -> ()
    "x86.amx.tile_store"(%arg6, %5, %5, %8) <{operandSegmentSizes = array<i32: 1, 2, 1, 0>}> : (memref<16x32xf32, strided<[?, 1]>>, index, index, !x86.amx.tile<16x16xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, memref<?xi8>, memref<16x32xbf16>, memref<32x32xf32, strided<[64, 1]>>) -> (), sym_name = "strides_explicit"}> ({
  ^bb0(%arg0: index, %arg1: memref<?xi8>, %arg2: memref<16x32xbf16>, %arg3: memref<32x32xf32, strided<[64, 1]>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 64 : index}> : () -> index
    %2 = "x86.amx.tile_load"(%arg1, %0, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 1>}> : (memref<?xi8>, index, index) -> !x86.amx.tile<16x32xi8>
    %3 = "x86.amx.tile_load"(%arg2, %0, %0, %arg0) <{operandSegmentSizes = array<i32: 1, 2, 1>}> : (memref<16x32xbf16>, index, index, index) -> !x86.amx.tile<16x32xbf16>
    %4 = "x86.amx.tile_load"(%arg3, %0, %0, %1) <{operandSegmentSizes = array<i32: 1, 2, 1>}> : (memref<32x32xf32, strided<[64, 1]>>, index, index, index) -> !x86.amx.tile<16x16xf32>
    "x86.amx.tile_store"(%arg1, %0, %2, %arg0) <{operandSegmentSizes = array<i32: 1, 1, 1, 1>}> : (memref<?xi8>, index, !x86.amx.tile<16x32xi8>, index) -> ()
    "x86.amx.tile_store"(%arg2, %0, %0, %3, %arg0) <{operandSegmentSizes = array<i32: 1, 2, 1, 1>}> : (memref<16x32xbf16>, index, index, !x86.amx.tile<16x32xbf16>, index) -> ()
    "x86.amx.tile_store"(%arg3, %0, %0, %4, %1) <{operandSegmentSizes = array<i32: 1, 2, 1, 1>}> : (memref<32x32xf32, strided<[64, 1]>>, index, index, !x86.amx.tile<16x16xf32>, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

