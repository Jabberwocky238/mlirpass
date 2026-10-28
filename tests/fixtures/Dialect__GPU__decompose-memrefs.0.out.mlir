#map = affine_map<()[s0, s1, s2, s3, s4] -> (s0 * s1 + s2 * s3 + s4)>
module {
  func.func @decompose_store(%arg0: f32, %arg1: memref<?x?x?xf32>) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg1 : memref<?x?x?xf32> -> memref<f32>, index, index, index, index, index, index, index
    %dim = memref.dim %arg1, %c0 : memref<?x?x?xf32>
    %dim_0 = memref.dim %arg1, %c1 : memref<?x?x?xf32>
    %dim_1 = memref.dim %arg1, %c2 : memref<?x?x?xf32>
    gpu.launch blocks(%arg2, %arg3, %arg4) in (%arg8 = %c1, %arg9 = %c1, %arg10 = %c1) threads(%arg5, %arg6, %arg7) in (%arg11 = %dim, %arg12 = %dim_0, %arg13 = %dim_1) {
      %0 = affine.apply #map()[%arg5, %strides#0, %arg6, %strides#1, %arg7]
      %reinterpret_cast = memref.reinterpret_cast %base_buffer to offset: [%0], sizes: [], strides: [] : memref<f32> to memref<f32, strided<[], offset: ?>>
      memref.store %arg0, %reinterpret_cast[] : memref<f32, strided<[], offset: ?>>
      gpu.terminator
    }
    return
  }
}

// -----
#map = affine_map<()[s0, s1, s2, s3, s4, s5, s6] -> (s0 + s1 * s2 + s3 * s4 + s5 * s6)>
module {
  func.func @decompose_store_strided(%arg0: f32, %arg1: memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg1 : memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>> -> memref<f32>, index, index, index, index, index, index, index
    %dim = memref.dim %arg1, %c0 : memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %dim_0 = memref.dim %arg1, %c1 : memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %dim_1 = memref.dim %arg1, %c2 : memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    gpu.launch blocks(%arg2, %arg3, %arg4) in (%arg8 = %c1, %arg9 = %c1, %arg10 = %c1) threads(%arg5, %arg6, %arg7) in (%arg11 = %dim, %arg12 = %dim_0, %arg13 = %dim_1) {
      %0 = affine.apply #map()[%offset, %arg5, %strides#0, %arg6, %strides#1, %arg7, %strides#2]
      %reinterpret_cast = memref.reinterpret_cast %base_buffer to offset: [%0], sizes: [], strides: [] : memref<f32> to memref<f32, strided<[], offset: ?>>
      memref.store %arg0, %reinterpret_cast[] : memref<f32, strided<[], offset: ?>>
      gpu.terminator
    }
    return
  }
}

// -----
#map = affine_map<()[s0, s1, s2, s3, s4] -> (s0 * s1 + s2 * s3 + s4)>
module {
  func.func @decompose_load(%arg0: memref<?x?x?xf32>) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg0 : memref<?x?x?xf32> -> memref<f32>, index, index, index, index, index, index, index
    %dim = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
    %dim_1 = memref.dim %arg0, %c2 : memref<?x?x?xf32>
    gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %c1, %arg8 = %c1, %arg9 = %c1) threads(%arg4, %arg5, %arg6) in (%arg10 = %dim, %arg11 = %dim_0, %arg12 = %dim_1) {
      %0 = affine.apply #map()[%arg4, %strides#0, %arg5, %strides#1, %arg6]
      %reinterpret_cast = memref.reinterpret_cast %base_buffer to offset: [%0], sizes: [], strides: [] : memref<f32> to memref<f32, strided<[], offset: ?>>
      %1 = memref.load %reinterpret_cast[] : memref<f32, strided<[], offset: ?>>
      "test.test"(%1) : (f32) -> ()
      gpu.terminator
    }
    return
  }
}

// -----
#map = affine_map<()[s0, s1, s2, s3, s4] -> (s0 * s1 + s2 * s3 + s4)>
module {
  func.func @decompose_subview(%arg0: memref<?x?x?xf32>) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg0 : memref<?x?x?xf32> -> memref<f32>, index, index, index, index, index, index, index
    %dim = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
    %dim_1 = memref.dim %arg0, %c2 : memref<?x?x?xf32>
    gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %c1, %arg8 = %c1, %arg9 = %c1) threads(%arg4, %arg5, %arg6) in (%arg10 = %dim, %arg11 = %dim_0, %arg12 = %dim_1) {
      %0 = affine.apply #map()[%arg4, %strides#0, %arg5, %strides#1, %arg6]
      %reinterpret_cast = memref.reinterpret_cast %base_buffer to offset: [%0], sizes: [%c2, %c2, %c2], strides: [%strides#0, %strides#1, 1] : memref<f32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
      "test.test"(%reinterpret_cast) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
      gpu.terminator
    }
    return
  }
}

// -----
#map = affine_map<()[s0] -> (s0 * 2)>
#map1 = affine_map<()[s0] -> (s0 * 3)>
#map2 = affine_map<()[s0, s1, s2, s3, s4] -> (s0 * s1 + s2 * s3 + s4)>
module {
  func.func @decompose_subview_strided(%arg0: memref<?x?x?xf32>) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg0 : memref<?x?x?xf32> -> memref<f32>, index, index, index, index, index, index, index
    %dim = memref.dim %arg0, %c0 : memref<?x?x?xf32>
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?x?xf32>
    %dim_1 = memref.dim %arg0, %c2 : memref<?x?x?xf32>
    gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %c1, %arg8 = %c1, %arg9 = %c1) threads(%arg4, %arg5, %arg6) in (%arg10 = %dim, %arg11 = %dim_0, %arg12 = %dim_1) {
      %0 = affine.apply #map()[%strides#0]
      %1 = affine.apply #map1()[%strides#1]
      %2 = affine.apply #map2()[%arg4, %strides#0, %arg5, %strides#1, %arg6]
      %reinterpret_cast = memref.reinterpret_cast %base_buffer to offset: [%2], sizes: [%c2, %c2, %c2], strides: [%0, %1, 4] : memref<f32> to memref<?x?x?xf32, strided<[?, ?, 4], offset: ?>>
      "test.test"(%reinterpret_cast) : (memref<?x?x?xf32, strided<[?, ?, 4], offset: ?>>) -> ()
      gpu.terminator
    }
    return
  }
}

