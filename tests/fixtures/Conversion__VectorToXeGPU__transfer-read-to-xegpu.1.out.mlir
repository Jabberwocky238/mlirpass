module {
  gpu.module @xevm_module {
    gpu.func @load_1D_vector(%arg0: memref<8x16x32xf32>, %arg1: index) -> vector<8xf32> {
      %cst = arith.constant dense<true> : vector<8xi1>
      %c512 = arith.constant 512 : index
      %c32 = arith.constant 32 : index
      %0 = vector.step : vector<8xindex>
      %1 = arith.muli %arg1, %c512 : index
      %2 = arith.muli %arg1, %c32 : index
      %3 = arith.addi %1, %2 : index
      %4 = arith.addi %3, %arg1 : index
      %5 = vector.broadcast %4 : index to vector<8xindex>
      %6 = arith.addi %5, %0 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<8x16x32xf32> -> index
      %7 = arith.index_cast %intptr : index to i64
      %8 = xegpu.load %7[%6], %cst  : i64, vector<8xindex>, vector<8xi1> -> vector<8xf32>
      gpu.return %8 : vector<8xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_2D_vector(%arg0: memref<8x16x32xf32>, %arg1: index) -> vector<8x16xf32> {
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
      %7 = arith.muli %arg1, %c512 : index
      %8 = arith.muli %arg1, %c32 : index
      %9 = arith.addi %7, %8 : index
      %10 = arith.addi %9, %arg1 : index
      %11 = vector.broadcast %10 : index to vector<8x16xindex>
      %12 = arith.addi %11, %6 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<8x16x32xf32> -> index
      %13 = arith.index_cast %intptr : index to i64
      %14 = xegpu.load %13[%12], %cst  : i64, vector<8x16xindex>, vector<8x16xi1> -> vector<8x16xf32>
      gpu.return %14 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_zero_pad_out_of_bounds(%arg0: memref<32x64xf32>, %arg1: index) -> vector<8x16xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg1], %cst {in_bounds = [false, true]} : memref<32x64xf32>, vector<8x16xf32>
      gpu.return %0 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_transposed(%arg0: memref<32x64xf32>, %arg1: index, %arg2: index) -> vector<8x16xf32> {
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
      %8 = arith.addi %arg1, %7 : index
      %9 = vector.broadcast %8 : index to vector<8x16xindex>
      %10 = arith.addi %9, %6 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<32x64xf32> -> index
      %11 = arith.index_cast %intptr : index to i64
      %12 = xegpu.load %11[%10], %cst  : i64, vector<8x16xindex>, vector<8x16xi1> -> vector<8x16xf32>
      gpu.return %12 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_dynamic_source(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index) -> vector<8x16xf32> {
      %cst = arith.constant dense<true> : vector<8x16xi1>
      %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg0 : memref<?x?x?xf32> -> memref<f32>, index, index, index, index, index, index, index
      %0 = vector.step : vector<8xindex>
      %1 = vector.step : vector<16xindex>
      %2 = vector.broadcast %strides#1 : index to vector<8xindex>
      %3 = arith.muli %0, %2 : vector<8xindex>
      %4 = vector.shape_cast %3 : vector<8xindex> to vector<8x1xindex>
      %5 = vector.broadcast %4 : vector<8x1xindex> to vector<8x16xindex>
      %6 = vector.broadcast %1 : vector<16xindex> to vector<8x16xindex>
      %7 = arith.addi %5, %6 : vector<8x16xindex>
      %8 = arith.muli %arg1, %strides#0 : index
      %9 = arith.muli %arg2, %strides#1 : index
      %10 = arith.addi %8, %9 : index
      %11 = arith.addi %10, %arg3 : index
      %12 = vector.broadcast %11 : index to vector<8x16xindex>
      %13 = arith.addi %12, %7 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<?x?x?xf32> -> index
      %14 = arith.index_cast %intptr : index to i64
      %15 = xegpu.load %14[%13], %cst  : i64, vector<8x16xindex>, vector<8x16xi1> -> vector<8x16xf32>
      gpu.return %15 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_dynamic_source2(%arg0: memref<?x8x16xf32>, %arg1: index, %arg2: index, %arg3: index) -> vector<8x16xf32> {
      %cst = arith.constant dense<16> : vector<8xindex>
      %cst_0 = arith.constant dense<true> : vector<8x16xi1>
      %c128 = arith.constant 128 : index
      %c16 = arith.constant 16 : index
      %0 = vector.step : vector<8xindex>
      %1 = vector.step : vector<16xindex>
      %2 = arith.muli %0, %cst : vector<8xindex>
      %3 = vector.shape_cast %2 : vector<8xindex> to vector<8x1xindex>
      %4 = vector.broadcast %3 : vector<8x1xindex> to vector<8x16xindex>
      %5 = vector.broadcast %1 : vector<16xindex> to vector<8x16xindex>
      %6 = arith.addi %4, %5 : vector<8x16xindex>
      %7 = arith.muli %arg1, %c128 : index
      %8 = arith.muli %arg2, %c16 : index
      %9 = arith.addi %7, %8 : index
      %10 = arith.addi %9, %arg3 : index
      %11 = vector.broadcast %10 : index to vector<8x16xindex>
      %12 = arith.addi %11, %6 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<?x8x16xf32> -> index
      %13 = arith.index_cast %intptr : index to i64
      %14 = xegpu.load %13[%12], %cst_0  : i64, vector<8x16xindex>, vector<8x16xi1> -> vector<8x16xf32>
      gpu.return %14 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_dynamic_source3(%arg0: memref<?x?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index) -> vector<2x4x8x16xf32> {
      %cst = arith.constant dense<true> : vector<2x4x8x16xi1>
      %base_buffer, %offset, %sizes:5, %strides:5 = memref.extract_strided_metadata %arg0 : memref<?x?x?x?x?xf32> -> memref<f32>, index, index, index, index, index, index, index, index, index, index, index
      %0 = vector.step : vector<2xindex>
      %1 = vector.step : vector<4xindex>
      %2 = vector.step : vector<8xindex>
      %3 = vector.step : vector<16xindex>
      %4 = vector.broadcast %strides#1 : index to vector<2xindex>
      %5 = arith.muli %0, %4 : vector<2xindex>
      %6 = vector.broadcast %strides#2 : index to vector<4xindex>
      %7 = arith.muli %1, %6 : vector<4xindex>
      %8 = vector.broadcast %strides#3 : index to vector<8xindex>
      %9 = arith.muli %2, %8 : vector<8xindex>
      %10 = vector.shape_cast %5 : vector<2xindex> to vector<2x1x1x1xindex>
      %11 = vector.shape_cast %7 : vector<4xindex> to vector<1x4x1x1xindex>
      %12 = vector.shape_cast %9 : vector<8xindex> to vector<1x1x8x1xindex>
      %13 = vector.broadcast %10 : vector<2x1x1x1xindex> to vector<2x4x8x16xindex>
      %14 = vector.broadcast %11 : vector<1x4x1x1xindex> to vector<2x4x8x16xindex>
      %15 = vector.broadcast %12 : vector<1x1x8x1xindex> to vector<2x4x8x16xindex>
      %16 = vector.broadcast %3 : vector<16xindex> to vector<2x4x8x16xindex>
      %17 = arith.addi %13, %14 : vector<2x4x8x16xindex>
      %18 = arith.addi %17, %15 : vector<2x4x8x16xindex>
      %19 = arith.addi %18, %16 : vector<2x4x8x16xindex>
      %20 = arith.muli %arg1, %strides#0 : index
      %21 = arith.muli %arg2, %strides#1 : index
      %22 = arith.addi %20, %21 : index
      %23 = arith.muli %arg3, %strides#2 : index
      %24 = arith.addi %22, %23 : index
      %25 = arith.muli %arg4, %strides#3 : index
      %26 = arith.addi %24, %25 : index
      %27 = arith.addi %26, %arg5 : index
      %28 = vector.broadcast %27 : index to vector<2x4x8x16xindex>
      %29 = arith.addi %28, %19 : vector<2x4x8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<?x?x?x?x?xf32> -> index
      %30 = arith.index_cast %intptr : index to i64
      %31 = xegpu.load %30[%29], %cst  : i64, vector<2x4x8x16xindex>, vector<2x4x8x16xi1> -> vector<2x4x8x16xf32>
      gpu.return %31 : vector<2x4x8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_high_dim_vector(%arg0: memref<16x32x64xf32>, %arg1: index, %arg2: index) -> vector<8x16x32xf32> {
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
      %12 = arith.muli %arg1, %c2048 : index
      %13 = arith.muli %arg2, %c64 : index
      %14 = arith.addi %12, %13 : index
      %15 = arith.addi %14, %arg1 : index
      %16 = vector.broadcast %15 : index to vector<8x16x32xindex>
      %17 = arith.addi %16, %11 : vector<8x16x32xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<16x32x64xf32> -> index
      %18 = arith.index_cast %intptr : index to i64
      %19 = xegpu.load %18[%17], %cst  : i64, vector<8x16x32xindex>, vector<8x16x32xi1> -> vector<8x16x32xf32>
      gpu.return %19 : vector<8x16x32xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_transpose_f16(%arg0: memref<32x64xf16>, %arg1: index) -> vector<8x16xf16> {
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
      %7 = arith.muli %arg1, %c64 : index
      %8 = arith.addi %arg1, %7 : index
      %9 = vector.broadcast %8 : index to vector<8x16xindex>
      %10 = arith.addi %9, %6 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<32x64xf16> -> index
      %11 = arith.index_cast %intptr : index to i64
      %12 = xegpu.load %11[%10], %cst  : i64, vector<8x16xindex>, vector<8x16xi1> -> vector<8x16xf16>
      gpu.return %12 : vector<8x16xf16>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @no_load_out_of_bounds_non_zero_pad(%arg0: memref<32x64xf32>, %arg1: index, %arg2: index, %arg3: f32) -> (vector<8x16xf32>, vector<8x16xf32>) {
      %cst = arith.constant 1.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg2], %cst {in_bounds = [true, false]} : memref<32x64xf32>, vector<8x16xf32>
      %1 = vector.transfer_read %arg0[%arg2, %arg1], %arg3 {in_bounds = [false, true]} : memref<32x64xf32>, vector<8x16xf32>
      gpu.return %0, %1 : vector<8x16xf32>, vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @no_load_out_of_bounds_1D_vector(%arg0: memref<8x16x32xf32>, %arg1: index) -> vector<8xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg1, %arg1], %cst : memref<8x16x32xf32>, vector<8xf32>
      gpu.return %0 : vector<8xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @no_load_masked(%arg0: memref<4xf32>, %arg1: index) -> vector<4xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %cst_0 = arith.constant dense<[false, true, false, true]> : vector<4xi1>
      %0 = vector.transfer_read %arg0[%arg1], %cst, %cst_0 {in_bounds = [true]} : memref<4xf32>, vector<4xf32>
      gpu.return %0 : vector<4xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @no_load_tensor(%arg0: tensor<32x64xf32>, %arg1: index, %arg2: index) -> vector<8x16xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg2], %cst {in_bounds = [true, true]} : tensor<32x64xf32>, vector<8x16xf32>
      gpu.return %0 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @no_load_non_unit_inner_stride(%arg0: memref<32xf32, strided<[?], offset: ?>>, %arg1: index) -> vector<8xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1], %cst {in_bounds = [true]} : memref<32xf32, strided<[?], offset: ?>>, vector<8xf32>
      gpu.return %0 : vector<8xf32>
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
module {
  gpu.module @xevm_module {
    gpu.func @no_load_unsupported_map(%arg0: memref<16x32x64xf32>, %arg1: index) -> vector<8x16xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg1, %arg1], %cst {in_bounds = [true, true], permutation_map = #map} : memref<16x32x64xf32>, vector<8x16xf32>
      gpu.return %0 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_from_subview_1D(%arg0: memref<4096x4096xf16>, %arg1: index, %arg2: index) -> vector<8xf16> {
      %cst = arith.constant dense<true> : vector<8xi1>
      %c4096 = arith.constant 4096 : index
      %subview = memref.subview %arg0[%arg1, %arg2] [256, 256] [1, 1] : memref<4096x4096xf16> to memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> memref<f16>, index, index, index, index, index
      %0 = vector.step : vector<8xindex>
      %1 = arith.muli %arg2, %c4096 : index
      %2 = arith.addi %offset, %1 : index
      %3 = arith.addi %2, %arg2 : index
      %4 = vector.broadcast %3 : index to vector<8xindex>
      %5 = arith.addi %4, %0 : vector<8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> index
      %6 = arith.index_cast %intptr : index to i64
      %7 = xegpu.load %6[%5], %cst  : i64, vector<8xindex>, vector<8xi1> -> vector<8xf16>
      gpu.return %7 : vector<8xf16>
    }
  }
}

// -----
module {
  gpu.module @xevm_module {
    gpu.func @load_from_subview_2D(%arg0: memref<4096x4096xf16>, %arg1: index, %arg2: index) -> vector<8x16xf16> {
      %cst = arith.constant dense<true> : vector<8x16xi1>
      %cst_0 = arith.constant dense<4096> : vector<8xindex>
      %c4096 = arith.constant 4096 : index
      %subview = memref.subview %arg0[%arg1, %arg2] [256, 256] [1, 1] : memref<4096x4096xf16> to memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> memref<f16>, index, index, index, index, index
      %0 = vector.step : vector<8xindex>
      %1 = vector.step : vector<16xindex>
      %2 = arith.muli %0, %cst_0 : vector<8xindex>
      %3 = vector.shape_cast %2 : vector<8xindex> to vector<8x1xindex>
      %4 = vector.broadcast %3 : vector<8x1xindex> to vector<8x16xindex>
      %5 = vector.broadcast %1 : vector<16xindex> to vector<8x16xindex>
      %6 = arith.addi %4, %5 : vector<8x16xindex>
      %7 = arith.muli %arg2, %c4096 : index
      %8 = arith.addi %offset, %7 : index
      %9 = arith.addi %8, %arg2 : index
      %10 = vector.broadcast %9 : index to vector<8x16xindex>
      %11 = arith.addi %10, %6 : vector<8x16xindex>
      %intptr = memref.extract_aligned_pointer_as_index %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> index
      %12 = arith.index_cast %intptr : index to i64
      %13 = xegpu.load %12[%11], %cst  : i64, vector<8x16xindex>, vector<8x16xi1> -> vector<8x16xf16>
      gpu.return %13 : vector<8x16xf16>
    }
  }
}

