module {
  gpu.module @xevm_module {
    gpu.func @store_1D_vector(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8xindex>, %arg6: vector<8xi1>) {
      %c512 = arith.constant 512 : index
      %c32 = arith.constant 32 : index
      %0 = arith.muli %arg2, %c512 : index
      %1 = arith.muli %arg3, %c32 : index
      %2 = arith.addi %0, %1 : index
      %3 = arith.addi %2, %arg4 : index
      %4 = vector.broadcast %3 : index to vector<8xindex>
      %5 = arith.addi %4, %arg5 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg1 : memref<8x16x32xf32> -> index
      %6 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %6[%5], %arg6  : vector<8xf32>, i64, vector<8xindex>, vector<8xi1>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @store_2D_memref(%arg0: vector<8xf32>, %arg1: memref<8x32xf32>, %arg2: index, %arg3: index, %arg4: vector<8xindex>, %arg5: vector<8xi1>) {
      %c32 = arith.constant 32 : index
      %0 = arith.muli %arg2, %c32 : index
      %1 = arith.addi %0, %arg3 : index
      %2 = vector.broadcast %1 : index to vector<8xindex>
      %3 = arith.addi %2, %arg4 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg1 : memref<8x32xf32> -> index
      %4 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %4[%3], %arg5  : vector<8xf32>, i64, vector<8xindex>, vector<8xi1>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @store_2D_vector(%arg0: vector<8x16xf32>, %arg1: memref<8x16x32xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8x16xindex>, %arg6: vector<8x16xi1>) {
      %c512 = arith.constant 512 : index
      %c32 = arith.constant 32 : index
      %0 = arith.muli %arg2, %c512 : index
      %1 = arith.muli %arg3, %c32 : index
      %2 = arith.addi %0, %1 : index
      %3 = arith.addi %2, %arg4 : index
      %4 = vector.broadcast %3 : index to vector<8x16xindex>
      %5 = arith.addi %4, %arg5 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg1 : memref<8x16x32xf32> -> index
      %6 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %6[%5], %arg6  : vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @store_dynamic_source(%arg0: vector<8x16xf32>, %arg1: memref<?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8x16xindex>, %arg6: vector<8x16xi1>) {
      %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg1 : memref<?x?x?xf32> -> memref<f32>, index, index, index, index, index, index, index
      %0 = arith.muli %arg2, %strides#0 : index
      %1 = arith.muli %arg3, %strides#1 : index
      %2 = arith.addi %0, %1 : index
      %3 = arith.addi %2, %arg4 : index
      %4 = vector.broadcast %3 : index to vector<8x16xindex>
      %5 = arith.addi %4, %arg5 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg1 : memref<?x?x?xf32> -> index
      %6 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %6[%5], %arg6  : vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @store_dynamic_source2(%arg0: vector<8x16xf32>, %arg1: memref<?x8x16xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8x16xindex>, %arg6: vector<8x16xi1>) {
      %c128 = arith.constant 128 : index
      %c16 = arith.constant 16 : index
      %0 = arith.muli %arg2, %c128 : index
      %1 = arith.muli %arg3, %c16 : index
      %2 = arith.addi %0, %1 : index
      %3 = arith.addi %2, %arg4 : index
      %4 = vector.broadcast %3 : index to vector<8x16xindex>
      %5 = arith.addi %4, %arg5 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg1 : memref<?x8x16xf32> -> index
      %6 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %6[%5], %arg6  : vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @non_unit_inner_stride_1D(%arg0: vector<8xf32>, %arg1: memref<32xf32, strided<[?], offset: ?>>, %arg2: index, %arg3: vector<8xindex>, %arg4: vector<8xi1>) {
      %base_buffer, %offset, %sizes, %strides = memref.extract_strided_metadata %arg1 : memref<32xf32, strided<[?], offset: ?>> -> memref<f32>, index, index, index
      %0 = arith.muli %arg2, %strides : index
      %1 = arith.addi %offset, %0 : index
      %2 = vector.broadcast %strides : index to vector<8xindex>
      %3 = arith.muli %2, %arg3 : vector<8xindex>
      %4 = vector.broadcast %1 : index to vector<8xindex>
      %5 = arith.addi %4, %3 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg1 : memref<32xf32, strided<[?], offset: ?>> -> index
      %6 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %6[%5], %arg4  : vector<8xf32>, i64, vector<8xindex>, vector<8xi1>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @non_unit_inner_stride_3D(%arg0: vector<8xf32>, %arg1: memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8xindex>, %arg6: vector<8xi1>) {
      %cst = arith.constant dense<2> : vector<8xindex>
      %c128 = arith.constant 128 : index
      %c2 = arith.constant 2 : index
      %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg1 : memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>> -> memref<f32>, index, index, index, index, index, index, index
      %0 = arith.muli %arg2, %strides#0 : index
      %1 = arith.addi %offset, %0 : index
      %2 = arith.muli %arg3, %c128 : index
      %3 = arith.addi %1, %2 : index
      %4 = arith.muli %arg4, %c2 : index
      %5 = arith.addi %3, %4 : index
      %6 = arith.muli %arg5, %cst : vector<8xindex>
      %7 = vector.broadcast %5 : index to vector<8xindex>
      %8 = arith.addi %7, %6 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg1 : memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>> -> index
      %9 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %9[%8], %arg6  : vector<8xf32>, i64, vector<8xindex>, vector<8xi1>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @scatter_into_subview(%arg0: vector<8xf16>, %arg1: memref<4096x4096xf16>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8xindex>, %arg6: vector<8xi1>) {
      %c4096 = arith.constant 4096 : index
      %subview = memref.subview %arg1[%arg2, %arg2] [256, 256] [1, 1] : memref<4096x4096xf16> to memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> memref<f16>, index, index, index, index, index
      %0 = arith.muli %arg3, %c4096 : index
      %1 = arith.addi %offset, %0 : index
      %2 = arith.addi %1, %arg4 : index
      %3 = vector.broadcast %2 : index to vector<8xindex>
      %4 = arith.addi %3, %arg5 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> index
      %5 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %5[%4], %arg6  : vector<8xf16>, i64, vector<8xindex>, vector<8xi1>
      gpu.return
    }
  }
}

