module {
  gpu.module @xevm_module {
    gpu.func @store_1D_vector(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index) {
      %cst = arith.constant dense<true> : vector<8xi1>
      %c512 = arith.constant 512 : index
      %c32 = arith.constant 32 : index
      %0 = vector.step : vector<8xindex>
      %1 = arith.muli %arg2, %c512 : index
      %2 = arith.muli %arg2, %c32 : index
      %3 = arith.addi %1, %2 : index
      %4 = arith.addi %3, %arg2 : index
      %5 = vector.broadcast %4 : index to vector<8xindex>
      %6 = arith.addi %5, %0 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg1 : memref<8x16x32xf32> -> index
      %7 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %7[%6], %cst  : vector<8xf32>, i64, vector<8xindex>, vector<8xi1>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @store_2D_vector(%arg0: vector<8x16xf32>, %arg1: memref<8x16x32xf32>, %arg2: index) {
      %cst = arith.constant dense<true> : vector<8x16xi1>
      %cst_0 = arith.constant dense<32> : vector<8xindex>
      %c512 = arith.constant 512 : index
      %c32 = arith.constant 32 : index
      %0 = vector.step : vector<8xindex>
      %1 = vector.step : vector<16xindex>
      %2 = arith.muli %0, %cst_0 : vector<8xindex>
      %3 = vector.shape_cast %2 : vector<8xindex> to vector<8x1xindex>
      %4 = vector.broadcast %3 : vector<8x1xindex> to vector<8x16xindex>
      %5 = vector.broadcast %1 : vector<16xindex> to vector<8x16xindex>
      %6 = arith.addi %4, %5 : vector<8x16xindex>
      %7 = arith.muli %arg2, %c512 : index
      %8 = arith.muli %arg2, %c32 : index
      %9 = arith.addi %7, %8 : index
      %10 = arith.addi %9, %arg2 : index
      %11 = vector.broadcast %10 : index to vector<8x16xindex>
      %12 = arith.addi %11, %6 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg1 : memref<8x16x32xf32> -> index
      %13 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %13[%12], %cst  : vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @store_dynamic_source(%arg0: vector<8x16xf32>, %arg1: memref<?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index) {
      %cst = arith.constant dense<true> : vector<8x16xi1>
      %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg1 : memref<?x?x?xf32> -> memref<f32>, index, index, index, index, index, index, index
      %0 = vector.step : vector<8xindex>
      %1 = vector.step : vector<16xindex>
      %2 = vector.broadcast %strides#1 : index to vector<8xindex>
      %3 = arith.muli %0, %2 : vector<8xindex>
      %4 = vector.shape_cast %3 : vector<8xindex> to vector<8x1xindex>
      %5 = vector.broadcast %4 : vector<8x1xindex> to vector<8x16xindex>
      %6 = vector.broadcast %1 : vector<16xindex> to vector<8x16xindex>
      %7 = arith.addi %5, %6 : vector<8x16xindex>
      %8 = arith.muli %arg2, %strides#0 : index
      %9 = arith.muli %arg3, %strides#1 : index
      %10 = arith.addi %8, %9 : index
      %11 = arith.addi %10, %arg4 : index
      %12 = vector.broadcast %11 : index to vector<8x16xindex>
      %13 = arith.addi %12, %7 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg1 : memref<?x?x?xf32> -> index
      %14 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %14[%13], %cst  : vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @store_out_of_bounds(%arg0: vector<8x16xf32>, %arg1: memref<7x64xf32>, %arg2: index) {
      vector.transfer_write %arg0, %arg1[%arg2, %arg2] {in_bounds = [false, true]} : vector<8x16xf32>, memref<7x64xf32>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @no_store_transposed(%arg0: vector<8x16xf32>, %arg1: memref<32x64xf32>, %arg2: index) {
      %cst = arith.constant dense<true> : vector<8x16xi1>
      %cst_0 = arith.constant dense<64> : vector<16xindex>
      %c64 = arith.constant 64 : index
      %0 = vector.step : vector<8xindex>
      %1 = vector.step : vector<16xindex>
      %2 = arith.muli %1, %cst_0 : vector<16xindex>
      %3 = vector.shape_cast %0 : vector<8xindex> to vector<8x1xindex>
      %4 = vector.broadcast %3 : vector<8x1xindex> to vector<8x16xindex>
      %5 = vector.broadcast %2 : vector<16xindex> to vector<8x16xindex>
      %6 = arith.addi %4, %5 : vector<8x16xindex>
      %7 = arith.muli %arg2, %c64 : index
      %8 = arith.addi %arg2, %7 : index
      %9 = vector.broadcast %8 : index to vector<8x16xindex>
      %10 = arith.addi %9, %6 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg1 : memref<32x64xf32> -> index
      %11 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %11[%10], %cst  : vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @store_high_dim_vector(%arg0: vector<8x16x32xf32>, %arg1: memref<16x32x64xf32>, %arg2: index) {
      %cst = arith.constant dense<true> : vector<8x16x32xi1>
      %cst_0 = arith.constant dense<64> : vector<16xindex>
      %cst_1 = arith.constant dense<2048> : vector<8xindex>
      %c2048 = arith.constant 2048 : index
      %c64 = arith.constant 64 : index
      %0 = vector.step : vector<8xindex>
      %1 = vector.step : vector<16xindex>
      %2 = vector.step : vector<32xindex>
      %3 = arith.muli %0, %cst_1 : vector<8xindex>
      %4 = arith.muli %1, %cst_0 : vector<16xindex>
      %5 = vector.shape_cast %3 : vector<8xindex> to vector<8x1x1xindex>
      %6 = vector.shape_cast %4 : vector<16xindex> to vector<1x16x1xindex>
      %7 = vector.broadcast %5 : vector<8x1x1xindex> to vector<8x16x32xindex>
      %8 = vector.broadcast %6 : vector<1x16x1xindex> to vector<8x16x32xindex>
      %9 = vector.broadcast %2 : vector<32xindex> to vector<8x16x32xindex>
      %10 = arith.addi %7, %8 : vector<8x16x32xindex>
      %11 = arith.addi %10, %9 : vector<8x16x32xindex>
      %12 = arith.muli %arg2, %c2048 : index
      %13 = arith.muli %arg2, %c64 : index
      %14 = arith.addi %12, %13 : index
      %15 = arith.addi %14, %arg2 : index
      %16 = vector.broadcast %15 : index to vector<8x16x32xindex>
      %17 = arith.addi %16, %11 : vector<8x16x32xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg1 : memref<16x32x64xf32> -> index
      %18 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %18[%17], %cst  : vector<8x16x32xf32>, i64, vector<8x16x32xindex>, vector<8x16x32xi1>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @no_store_masked(%arg0: vector<4xf32>, %arg1: memref<4xf32>, %arg2: index) {
      %cst = arith.constant dense<[false, true, false, true]> : vector<4xi1>
      vector.transfer_write %arg0, %arg1[%arg2], %cst {in_bounds = [true]} : vector<4xf32>, memref<4xf32>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @no_store_tensor(%arg0: vector<8x16xf32>, %arg1: tensor<32x64xf32>, %arg2: index) -> tensor<32x64xf32> {
      %0 = vector.transfer_write %arg0, %arg1[%arg2, %arg2] {in_bounds = [true, true]} : vector<8x16xf32>, tensor<32x64xf32>
      gpu.return %0 : tensor<32x64xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @no_store_non_unit_inner_stride(%arg0: vector<8xf32>, %arg1: memref<32xf32, strided<[?], offset: ?>>, %arg2: index) {
      vector.transfer_write %arg0, %arg1[%arg2] {in_bounds = [true]} : vector<8xf32>, memref<32xf32, strided<[?], offset: ?>>
      gpu.return
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
module {
  gpu.module @xevm_module {
    gpu.func @no_store_unsupported_map(%arg0: vector<8x16xf32>, %arg1: memref<16x32x64xf32>, %arg2: index) {
      vector.transfer_write %arg0, %arg1[%arg2, %arg2, %arg2] {in_bounds = [true, true], permutation_map = #map} : vector<8x16xf32>, memref<16x32x64xf32>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @no_store_out_of_bounds_1D_vector(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index) {
      vector.transfer_write %arg0, %arg1[%arg2, %arg2, %arg2] : vector<8xf32>, memref<8x16x32xf32>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @store_to_subview(%arg0: vector<8xf16>, %arg1: memref<4096x4096xf16>, %arg2: index, %arg3: index) {
      %cst = arith.constant dense<true> : vector<8xi1>
      %c4096 = arith.constant 4096 : index
      %subview = memref.subview %arg1[%arg2, %arg3] [256, 256] [1, 1] : memref<4096x4096xf16> to memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> memref<f16>, index, index, index, index, index
      %0 = vector.step : vector<8xindex>
      %1 = arith.muli %arg3, %c4096 : index
      %2 = arith.addi %offset, %1 : index
      %3 = arith.addi %2, %arg3 : index
      %4 = vector.broadcast %3 : index to vector<8xindex>
      %5 = arith.addi %4, %0 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> index
      %6 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %6[%5], %cst  : vector<8xf16>, i64, vector<8xindex>, vector<8xi1>
      gpu.return
    }
  }
}

