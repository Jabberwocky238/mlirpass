module {
  func.func @tloadstore(%arg0: index, %arg1: memref<?xbf16>, %arg2: memref<?x?xbf16>, %arg3: memref<?x?xbf16, strided<[64, 1]>>) {
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %0 = amx.tile_load %arg1[%c0], %arg0 : memref<?xbf16> into !amx.tile<16x32xbf16>
    %1 = amx.tile_load %arg2[%c0, %c0], %arg0 : memref<?x?xbf16> into !amx.tile<16x32xbf16>
    %2 = amx.tile_load %arg3[%c0, %c0] : memref<?x?xbf16, strided<[64, 1]>> into !amx.tile<16x32xbf16>
    amx.tile_store %arg1[%c0], %2, %arg0 : memref<?xbf16>, !amx.tile<16x32xbf16>
    amx.tile_store %arg2[%c0, %c0], %0, %arg0 : memref<?x?xbf16>, !amx.tile<16x32xbf16>
    amx.tile_store %arg3[%c0, %c0], %1 : memref<?x?xbf16, strided<[64, 1]>>, !amx.tile<16x32xbf16>
    return
  }
  func.func @tzero(%arg0: memref<?x?xbf16>) {
    %c0 = arith.constant 0 : index
    %0 = amx.tile_zero : !amx.tile<16x16xbf16>
    amx.tile_store %arg0[%c0, %c0], %0 : memref<?x?xbf16>, !amx.tile<16x16xbf16>
    return
  }
  func.func @tmulf(%arg0: memref<?x?xbf16>, %arg1: memref<?x?xf32>) {
    %c0 = arith.constant 0 : index
    %0 = amx.tile_load %arg0[%c0, %c0] : memref<?x?xbf16> into !amx.tile<16x32xbf16>
    %1 = amx.tile_load %arg1[%c0, %c0] : memref<?x?xf32> into !amx.tile<16x16xf32>
    %2 = amx.tile_mulf %0, %0, %1 : !amx.tile<16x32xbf16>, !amx.tile<16x32xbf16>, !amx.tile<16x16xf32>
    amx.tile_store %arg1[%c0, %c0], %2 : memref<?x?xf32>, !amx.tile<16x16xf32>
    return
  }
  func.func @tmuli(%arg0: memref<?x?xi8>, %arg1: memref<?x?xi8>, %arg2: memref<?x?xi32>) {
    %c0 = arith.constant 0 : index
    %0 = amx.tile_load %arg0[%c0, %c0] : memref<?x?xi8> into !amx.tile<16x64xi8>
    %1 = amx.tile_load %arg1[%c0, %c0] : memref<?x?xi8> into !amx.tile<16x64xi8>
    %2 = amx.tile_load %arg2[%c0, %c0] : memref<?x?xi32> into !amx.tile<16x16xi32>
    %3 = amx.tile_muli %0 zext, %1 zext, %2 : !amx.tile<16x64xi8>, !amx.tile<16x64xi8>, !amx.tile<16x16xi32>
    amx.tile_store %arg2[%c0, %c0], %3 : memref<?x?xi32>, !amx.tile<16x16xi32>
    %4 = amx.tile_muli %0, %1 zext, %2 : !amx.tile<16x64xi8>, !amx.tile<16x64xi8>, !amx.tile<16x16xi32>
    %5 = amx.tile_muli %0 zext, %1, %2 : !amx.tile<16x64xi8>, !amx.tile<16x64xi8>, !amx.tile<16x16xi32>
    %6 = amx.tile_muli %0, %1, %2 : !amx.tile<16x64xi8>, !amx.tile<16x64xi8>, !amx.tile<16x16xi32>
    return
  }
}

