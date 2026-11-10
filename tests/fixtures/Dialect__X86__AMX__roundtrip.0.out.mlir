module {
  func.func @tloadstore(%arg0: index, %arg1: memref<?xbf16>, %arg2: memref<?x?xbf16>, %arg3: memref<?x?xbf16, strided<[64, 1]>>) {
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %0 = x86.amx.tile_load %arg1[%c0], %arg0 : memref<?xbf16> into !x86.amx.tile<16x32xbf16>
    %1 = x86.amx.tile_load %arg2[%c0, %c0], %arg0 : memref<?x?xbf16> into !x86.amx.tile<16x32xbf16>
    %2 = x86.amx.tile_load %arg3[%c0, %c0] : memref<?x?xbf16, strided<[64, 1]>> into !x86.amx.tile<16x32xbf16>
    x86.amx.tile_store %arg1[%c0], %2, %arg0 : memref<?xbf16>, !x86.amx.tile<16x32xbf16>
    x86.amx.tile_store %arg2[%c0, %c0], %0, %arg0 : memref<?x?xbf16>, !x86.amx.tile<16x32xbf16>
    x86.amx.tile_store %arg3[%c0, %c0], %1 : memref<?x?xbf16, strided<[64, 1]>>, !x86.amx.tile<16x32xbf16>
    return
  }
  func.func @tzero(%arg0: memref<?x?xbf16>) {
    %c0 = arith.constant 0 : index
    %0 = x86.amx.tile_zero : !x86.amx.tile<16x16xbf16>
    x86.amx.tile_store %arg0[%c0, %c0], %0 : memref<?x?xbf16>, !x86.amx.tile<16x16xbf16>
    return
  }
  func.func @tmulf(%arg0: memref<?x?xbf16>, %arg1: memref<?x?xf32>) {
    %c0 = arith.constant 0 : index
    %0 = x86.amx.tile_load %arg0[%c0, %c0] : memref<?x?xbf16> into !x86.amx.tile<16x32xbf16>
    %1 = x86.amx.tile_load %arg1[%c0, %c0] : memref<?x?xf32> into !x86.amx.tile<16x16xf32>
    %2 = x86.amx.tile_mulf %0, %0, %1 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
    x86.amx.tile_store %arg1[%c0, %c0], %2 : memref<?x?xf32>, !x86.amx.tile<16x16xf32>
    return
  }
  func.func @tmuli(%arg0: memref<?x?xi8>, %arg1: memref<?x?xi8>, %arg2: memref<?x?xi32>) {
    %c0 = arith.constant 0 : index
    %0 = x86.amx.tile_load %arg0[%c0, %c0] : memref<?x?xi8> into !x86.amx.tile<16x64xi8>
    %1 = x86.amx.tile_load %arg1[%c0, %c0] : memref<?x?xi8> into !x86.amx.tile<16x64xi8>
    %2 = x86.amx.tile_load %arg2[%c0, %c0] : memref<?x?xi32> into !x86.amx.tile<16x16xi32>
    %3 = x86.amx.tile_muli %0 zext, %1 zext, %2 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
    x86.amx.tile_store %arg2[%c0, %c0], %3 : memref<?x?xi32>, !x86.amx.tile<16x16xi32>
    %4 = x86.amx.tile_muli %0, %1 zext, %2 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
    %5 = x86.amx.tile_muli %0 zext, %1, %2 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
    %6 = x86.amx.tile_muli %0, %1, %2 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
    return
  }
}

