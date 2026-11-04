module {
  gpu.module @xevm_module {
    gpu.func @load_1D_vector(%arg0: memref<8x16x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8xindex>, %arg5: vector<8xi1>, %arg6: vector<8xf32>) -> vector<8xf32> {
      %c512 = arith.constant 512 : index
      %c32 = arith.constant 32 : index
      %0 = arith.muli %arg1, %c512 : index
      %1 = arith.muli %arg2, %c32 : index
      %2 = arith.addi %0, %1 : index
      %3 = arith.addi %2, %arg3 : index
      %4 = vector.broadcast %3 : index to vector<8xindex>
      %5 = arith.addi %4, %arg4 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<8x16x32xf32> -> index
      %6 = arith.index_cast %intptr : index to i64
      %7 = xegpu.load %6[%5], %arg5  : i64, vector<8xindex>, vector<8xi1> -> vector<8xf32>
      %8 = arith.select %arg5, %7, %arg6 : vector<8xi1>, vector<8xf32>
      gpu.return %8 : vector<8xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_2D_memref(%arg0: memref<8x32xf32>, %arg1: index, %arg2: index, %arg3: vector<8xindex>, %arg4: vector<8xi1>, %arg5: vector<8xf32>) -> vector<8xf32> {
      %c32 = arith.constant 32 : index
      %0 = arith.muli %arg1, %c32 : index
      %1 = arith.addi %0, %arg2 : index
      %2 = vector.broadcast %1 : index to vector<8xindex>
      %3 = arith.addi %2, %arg3 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<8x32xf32> -> index
      %4 = arith.index_cast %intptr : index to i64
      %5 = xegpu.load %4[%3], %arg4  : i64, vector<8xindex>, vector<8xi1> -> vector<8xf32>
      %6 = arith.select %arg4, %5, %arg5 : vector<8xi1>, vector<8xf32>
      gpu.return %6 : vector<8xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_2D_vector(%arg0: memref<8x16x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8x16xindex>, %arg5: vector<8x16xi1>, %arg6: vector<8x16xf32>) -> vector<8x16xf32> {
      %c512 = arith.constant 512 : index
      %c32 = arith.constant 32 : index
      %0 = arith.muli %arg1, %c512 : index
      %1 = arith.muli %arg2, %c32 : index
      %2 = arith.addi %0, %1 : index
      %3 = arith.addi %2, %arg3 : index
      %4 = vector.broadcast %3 : index to vector<8x16xindex>
      %5 = arith.addi %4, %arg4 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<8x16x32xf32> -> index
      %6 = arith.index_cast %intptr : index to i64
      %7 = xegpu.load %6[%5], %arg5  : i64, vector<8x16xindex>, vector<8x16xi1> -> vector<8x16xf32>
      %8 = arith.select %arg5, %7, %arg6 : vector<8x16xi1>, vector<8x16xf32>
      gpu.return %8 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_dynamic_source(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8x16xindex>, %arg5: vector<8x16xi1>, %arg6: vector<8x16xf32>) -> vector<8x16xf32> {
      %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg0 : memref<?x?x?xf32> -> memref<f32>, index, index, index, index, index, index, index
      %0 = arith.muli %arg1, %strides#0 : index
      %1 = arith.muli %arg2, %strides#1 : index
      %2 = arith.addi %0, %1 : index
      %3 = arith.addi %2, %arg3 : index
      %4 = vector.broadcast %3 : index to vector<8x16xindex>
      %5 = arith.addi %4, %arg4 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<?x?x?xf32> -> index
      %6 = arith.index_cast %intptr : index to i64
      %7 = xegpu.load %6[%5], %arg5  : i64, vector<8x16xindex>, vector<8x16xi1> -> vector<8x16xf32>
      %8 = arith.select %arg5, %7, %arg6 : vector<8x16xi1>, vector<8x16xf32>
      gpu.return %8 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_dynamic_source2(%arg0: memref<?x8x16xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8x16xindex>, %arg5: vector<8x16xi1>, %arg6: vector<8x16xf32>) -> vector<8x16xf32> {
      %c128 = arith.constant 128 : index
      %c16 = arith.constant 16 : index
      %0 = arith.muli %arg1, %c128 : index
      %1 = arith.muli %arg2, %c16 : index
      %2 = arith.addi %0, %1 : index
      %3 = arith.addi %2, %arg3 : index
      %4 = vector.broadcast %3 : index to vector<8x16xindex>
      %5 = arith.addi %4, %arg4 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<?x8x16xf32> -> index
      %6 = arith.index_cast %intptr : index to i64
      %7 = xegpu.load %6[%5], %arg5  : i64, vector<8x16xindex>, vector<8x16xi1> -> vector<8x16xf32>
      %8 = arith.select %arg5, %7, %arg6 : vector<8x16xi1>, vector<8x16xf32>
      gpu.return %8 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @no_load_tensor(%arg0: tensor<32x64xf32>, %arg1: index, %arg2: vector<8x16xindex>, %arg3: vector<8x16xi1>, %arg4: vector<8x16xf32>) -> vector<8x16xf32> {
      %0 = vector.gather %arg0[%arg1, %arg1] [%arg2], %arg3, %arg4 : tensor<32x64xf32>, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32> into vector<8x16xf32>
      gpu.return %0 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @gather_from_subview(%arg0: memref<4096x4096xf16>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8xindex>, %arg5: vector<8xi1>, %arg6: vector<8xf16>) -> vector<8xf16> {
      %c4096 = arith.constant 4096 : index
      %subview = memref.subview %arg0[%arg1, %arg1] [256, 256] [1, 1] : memref<4096x4096xf16> to memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> memref<f16>, index, index, index, index, index
      %0 = arith.muli %arg2, %c4096 : index
      %1 = arith.addi %offset, %0 : index
      %2 = arith.addi %1, %arg3 : index
      %3 = vector.broadcast %2 : index to vector<8xindex>
      %4 = arith.addi %3, %arg4 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> index
      %5 = arith.index_cast %intptr : index to i64
      %6 = xegpu.load %5[%4], %arg5  : i64, vector<8xindex>, vector<8xi1> -> vector<8xf16>
      %7 = arith.select %arg5, %6, %arg6 : vector<8xi1>, vector<8xf16>
      gpu.return %7 : vector<8xf16>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @non_unit_inner_stride_1D(%arg0: memref<32xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: vector<8xindex>, %arg3: vector<8xi1>, %arg4: vector<8xf32>) -> vector<8xf32> {
      %base_buffer, %offset, %sizes, %strides = memref.extract_strided_metadata %arg0 : memref<32xf32, strided<[?], offset: ?>> -> memref<f32>, index, index, index
      %0 = arith.muli %arg1, %strides : index
      %1 = arith.addi %offset, %0 : index
      %2 = vector.broadcast %strides : index to vector<8xindex>
      %3 = arith.muli %2, %arg2 : vector<8xindex>
      %4 = vector.broadcast %1 : index to vector<8xindex>
      %5 = arith.addi %4, %3 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<32xf32, strided<[?], offset: ?>> -> index
      %6 = arith.index_cast %intptr : index to i64
      %7 = xegpu.load %6[%5], %arg3  : i64, vector<8xindex>, vector<8xi1> -> vector<8xf32>
      %8 = arith.select %arg3, %7, %arg4 : vector<8xi1>, vector<8xf32>
      gpu.return %8 : vector<8xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @non_unit_inner_stride_3D(%arg0: memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8xindex>, %arg5: vector<8xi1>, %arg6: vector<8xf32>) -> vector<8xf32> {
      %cst = arith.constant dense<2> : vector<8xindex>
      %c128 = arith.constant 128 : index
      %c2 = arith.constant 2 : index
      %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg0 : memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>> -> memref<f32>, index, index, index, index, index, index, index
      %0 = arith.muli %arg1, %strides#0 : index
      %1 = arith.addi %offset, %0 : index
      %2 = arith.muli %arg2, %c128 : index
      %3 = arith.addi %1, %2 : index
      %4 = arith.muli %arg3, %c2 : index
      %5 = arith.addi %3, %4 : index
      %6 = arith.muli %arg4, %cst : vector<8xindex>
      %7 = vector.broadcast %5 : index to vector<8xindex>
      %8 = arith.addi %7, %6 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>> -> index
      %9 = arith.index_cast %intptr : index to i64
      %10 = xegpu.load %9[%8], %arg5  : i64, vector<8xindex>, vector<8xi1> -> vector<8xf32>
      %11 = arith.select %arg5, %10, %arg6 : vector<8xi1>, vector<8xf32>
      gpu.return %11 : vector<8xf32>
    }
  }
}

