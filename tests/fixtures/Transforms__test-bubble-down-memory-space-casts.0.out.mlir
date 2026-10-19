#map = affine_map<(d0, d1)[s0] -> (d1 * s0 + d0)>
module {
  func.func @load_store(%arg0: memref<?xf32, 1>, %arg1: index) {
    %0 = memref.load %arg0[%arg1] : memref<?xf32, 1>
    memref.store %0, %arg0[%arg1] : memref<?xf32, 1>
    return
  }
  func.func @load_store_unfoldable(%arg0: memref<?xf32, 1>, %arg1: index) {
    %memspacecast = memref.memory_space_cast %arg0 : memref<?xf32, 1> to memref<?xf32, 2>
    %0 = memref.load %memspacecast[%arg1] : memref<?xf32, 2>
    memref.store %0, %memspacecast[%arg1] : memref<?xf32, 2>
    return
  }
  func.func @cast(%arg0: memref<2xf32, 1>, %arg1: memref<*xf32, 1>) -> (memref<*xf32>, memref<3x2xf32>) {
    %cast = memref.cast %arg0 : memref<2xf32, 1> to memref<*xf32, 1>
    %memspacecast = memref.memory_space_cast %cast : memref<*xf32, 1> to memref<*xf32>
    %cast_0 = memref.cast %arg1 : memref<*xf32, 1> to memref<3x2xf32, 1>
    %memspacecast_1 = memref.memory_space_cast %cast_0 : memref<3x2xf32, 1> to memref<3x2xf32>
    return %memspacecast, %memspacecast_1 : memref<*xf32>, memref<3x2xf32>
  }
  func.func @view(%arg0: memref<?xi8, 1>, %arg1: index, %arg2: index) -> memref<?x?xi8> {
    %c100 = arith.constant 100 : index
    %view = memref.view %arg0[%arg1][%arg2, %c100] : memref<?xi8, 1> to memref<?x?xi8, 1>
    %memspacecast = memref.memory_space_cast %view : memref<?x?xi8, 1> to memref<?x?xi8>
    return %memspacecast : memref<?x?xi8>
  }
  func.func @subview(%arg0: memref<?x?xf32, 1>, %arg1: index) -> memref<8x2xf32, strided<[?, 2], offset: ?>> {
    %subview = memref.subview %arg0[4, 2] [8, 2] [3, 2] : memref<?x?xf32, 1> to memref<8x2xf32, strided<[?, 2], offset: ?>, 1>
    %memspacecast = memref.memory_space_cast %subview : memref<8x2xf32, strided<[?, 2], offset: ?>, 1> to memref<8x2xf32, strided<[?, 2], offset: ?>>
    return %memspacecast : memref<8x2xf32, strided<[?, 2], offset: ?>>
  }
  func.func @reinterpret_cast(%arg0: memref<?xf32, 1>, %arg1: index) -> memref<10x?xf32, strided<[?, 1], offset: ?>> {
    %c10 = arith.constant 10 : index
    %c0 = arith.constant 0 : index
    %reinterpret_cast = memref.reinterpret_cast %arg0 to offset: [%c0], sizes: [10, %c10], strides: [%c10, 1] : memref<?xf32, 1> to memref<10x?xf32, strided<[?, 1], offset: ?>, 1>
    %memspacecast = memref.memory_space_cast %reinterpret_cast : memref<10x?xf32, strided<[?, 1], offset: ?>, 1> to memref<10x?xf32, strided<[?, 1], offset: ?>>
    return %memspacecast : memref<10x?xf32, strided<[?, 1], offset: ?>>
  }
  func.func @reshape(%arg0: memref<?x?xf32, 1>, %arg1: memref<1xindex>) -> memref<?xf32> {
    %reshape = memref.reshape %arg0(%arg1) : (memref<?x?xf32, 1>, memref<1xindex>) -> memref<?xf32, 1>
    %memspacecast = memref.memory_space_cast %reshape : memref<?xf32, 1> to memref<?xf32>
    return %memspacecast : memref<?xf32>
  }
  func.func @expand_shape(%arg0: memref<12xf32, 1>) -> memref<3x4xf32> {
    %expand_shape = memref.expand_shape %arg0 [[0, 1]] output_shape [3, 4] : memref<12xf32, 1> into memref<3x4xf32, 1>
    %memspacecast = memref.memory_space_cast %expand_shape : memref<3x4xf32, 1> to memref<3x4xf32>
    return %memspacecast : memref<3x4xf32>
  }
  func.func @collapse_shape(%arg0: memref<3x4xf32, 1>) -> memref<12xf32> {
    %collapse_shape = memref.collapse_shape %arg0 [[0, 1]] : memref<3x4xf32, 1> into memref<12xf32, 1>
    %memspacecast = memref.memory_space_cast %collapse_shape : memref<12xf32, 1> to memref<12xf32>
    return %memspacecast : memref<12xf32>
  }
  func.func @transpose(%arg0: memref<?x?xf32, 1>) -> memref<?x?xf32, #map> {
    %transpose = memref.transpose %arg0 (d0, d1) -> (d1, d0) : memref<?x?xf32, 1> to memref<?x?xf32, #map, 1>
    %memspacecast = memref.memory_space_cast %transpose : memref<?x?xf32, #map, 1> to memref<?x?xf32, #map>
    return %memspacecast : memref<?x?xf32, #map>
  }
  func.func @atomic_rmw(%arg0: memref<?xf32, 1>, %arg1: index, %arg2: f32) -> f32 {
    %0 = memref.atomic_rmw addf %arg2, %arg0[%arg1] : (f32, memref<?xf32, 1>) -> f32
    return %0 : f32
  }
  func.func @assume_alignment(%arg0: memref<?xf32, 1>) -> memref<?xf32> {
    %assume_align = memref.assume_alignment %arg0, 16 : memref<?xf32, 1>
    %memspacecast = memref.memory_space_cast %assume_align : memref<?xf32, 1> to memref<?xf32>
    return %memspacecast : memref<?xf32>
  }
  func.func @op_with_cast_sequence(%arg0: memref<4x4xf32, 1>, %arg1: index, %arg2: f32) -> memref<16xf32> {
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %expand_shape = memref.expand_shape %arg0 [[0], [1, 2]] output_shape [4, 2, 2] : memref<4x4xf32, 1> into memref<4x2x2xf32, 1>
    %collapse_shape = memref.collapse_shape %expand_shape [[0, 1, 2]] : memref<4x2x2xf32, 1> into memref<16xf32, 1>
    %memspacecast = memref.memory_space_cast %collapse_shape : memref<16xf32, 1> to memref<16xf32>
    %0 = memref.load %collapse_shape[%c0] : memref<16xf32, 1>
    %1 = arith.addf %0, %arg2 : f32
    memref.store %1, %collapse_shape[%c0] : memref<16xf32, 1>
    %2 = memref.atomic_rmw addf %arg2, %collapse_shape[%c4] : (f32, memref<16xf32, 1>) -> f32
    return %memspacecast : memref<16xf32>
  }
  func.func @transfer_read_write(%arg0: memref<?xf32, 1>, %arg1: index) {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = vector.transfer_read %arg0[%arg1], %cst : memref<?xf32, 1>, vector<4xf32>
    vector.transfer_write %0, %arg0[%arg1] : vector<4xf32>, memref<?xf32, 1>
    return
  }
  func.func @transfer_read_write_tensor(%arg0: tensor<?xf32>, %arg1: index) -> tensor<?xf32> {
    return %arg0 : tensor<?xf32>
  }
  func.func @vector_load_store(%arg0: memref<?xf32, 1>, %arg1: index) {
    %0 = vector.load %arg0[%arg1] : memref<?xf32, 1>, vector<4xf32>
    vector.store %0, %arg0[%arg1] : memref<?xf32, 1>, vector<4xf32>
    return
  }
  func.func @masked_load_store(%arg0: memref<?xf32, 1>, %arg1: index) {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %cst_0 = arith.constant dense<[true, true, false, false]> : vector<4xi1>
    %0 = vector.maskedload %arg0[%arg1], %cst_0, %cst : memref<?xf32, 1>, vector<4xi1>, vector<4xf32> into vector<4xf32>
    vector.maskedstore %arg0[%arg1], %cst_0, %0 : memref<?xf32, 1>, vector<4xi1>, vector<4xf32>
    return
  }
  func.func @gather_scatter(%arg0: memref<?xf32, 1>, %arg1: index) {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %cst_0 = arith.constant dense<true> : vector<4xi1>
    %cst_1 = arith.constant dense<[0, 1, 2, 3]> : vector<4xindex>
    %c0 = arith.constant 0 : index
    %0 = vector.gather %arg0[%c0] [%cst_1], %cst_0, %cst : memref<?xf32, 1>, vector<4xindex>, vector<4xi1>, vector<4xf32> into vector<4xf32>
    vector.scatter %arg0[%c0] [%cst_1], %cst_0, %0 : memref<?xf32, 1>, vector<4xindex>, vector<4xi1>, vector<4xf32>
    return
  }
  func.func @expandload_compressstore(%arg0: memref<?xf32, 1>, %arg1: index) {
    %cst = arith.constant dense<0.000000e+00> : vector<4xf32>
    %cst_0 = arith.constant dense<[true, true, false, false]> : vector<4xi1>
    %0 = vector.expandload %arg0[%arg1], %cst_0, %cst : memref<?xf32, 1>, vector<4xi1>, vector<4xf32> into vector<4xf32>
    vector.compressstore %arg0[%arg1], %cst_0, %0 : memref<?xf32, 1>, vector<4xi1>, vector<4xf32>
    return
  }
}

