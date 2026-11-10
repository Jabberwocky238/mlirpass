module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
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
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_2D_vector(%arg0: memref<8x16x32xf32>, %arg1: index) -> vector<8x16xf32> {
      %c4 = arith.constant 4 : index
      %subview = memref.subview %arg0[%arg1, 0, 0] [1, 16, 32] [1, 1, 1] : memref<8x16x32xf32> to memref<16x32xf32, strided<[32, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<16x32xf32, strided<[32, 1], offset: ?>> -> memref<f32>, index, index, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer : memref<f32> -> index
      %0 = arith.muli %offset, %c4 : index
      %1 = arith.addi %intptr, %0 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = xegpu.create_nd_tdesc %2, shape : [16, 32], strides : [32, 1] : i64 -> !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      %4 = xegpu.load_nd %3[%arg1, %arg1]  : !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>> -> vector<8x16xf32>
      gpu.return %4 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_zero_pad_out_of_bounds(%arg0: memref<32x64xf32>, %arg1: index) -> vector<8x16xf32> {
      %0 = xegpu.create_nd_tdesc %arg0 : memref<32x64xf32> -> !xegpu.tensor_desc<8x16xf32>
      %1 = xegpu.load_nd %0[%arg1, %arg1]  : !xegpu.tensor_desc<8x16xf32> -> vector<8x16xf32>
      gpu.return %1 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_transposed(%arg0: memref<32x64xf32>, %arg1: index, %arg2: index) -> vector<8x16xf32> {
      %0 = xegpu.create_nd_tdesc %arg0 : memref<32x64xf32> -> !xegpu.tensor_desc<16x8xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      %1 = xegpu.load_nd %0[%arg1, %arg2]  : !xegpu.tensor_desc<16x8xf32, #xegpu.block_tdesc_attr<boundary_check = false>> -> vector<16x8xf32>
      %2 = vector.transpose %1, [1, 0] : vector<16x8xf32> to vector<8x16xf32>
      gpu.return %2 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_transpose_3d_memref(%arg0: memref<32x64x128xf32>, %arg1: index, %arg2: index, %arg3: index) -> vector<8x16xf32> {
      %c4 = arith.constant 4 : index
      %subview = memref.subview %arg0[%arg1, 0, 0] [1, 64, 128] [1, 1, 1] : memref<32x64x128xf32> to memref<64x128xf32, strided<[128, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<64x128xf32, strided<[128, 1], offset: ?>> -> memref<f32>, index, index, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer : memref<f32> -> index
      %0 = arith.muli %offset, %c4 : index
      %1 = arith.addi %intptr, %0 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = xegpu.create_nd_tdesc %2, shape : [64, 128], strides : [128, 1] : i64 -> !xegpu.tensor_desc<16x8xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      %4 = xegpu.load_nd %3[%arg2, %arg3]  : !xegpu.tensor_desc<16x8xf32, #xegpu.block_tdesc_attr<boundary_check = false>> -> vector<16x8xf32>
      %5 = vector.transpose %4, [1, 0] : vector<16x8xf32> to vector<8x16xf32>
      gpu.return %5 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_dynamic_source(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index) -> vector<8x16xf32> {
      %c4 = arith.constant 4 : index
      %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg0 : memref<?x?x?xf32> -> memref<f32>, index, index, index, index, index, index, index
      %subview = memref.subview %arg0[%arg1, 0, 0] [1, %sizes#1, %sizes#2] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?xf32, strided<[?, 1], offset: ?>>
      %base_buffer_0, %offset_1, %sizes_2:2, %strides_3:2 = memref.extract_strided_metadata %subview : memref<?x?xf32, strided<[?, 1], offset: ?>> -> memref<f32>, index, index, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer_0 : memref<f32> -> index
      %0 = arith.muli %offset_1, %c4 : index
      %1 = arith.addi %intptr, %0 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = xegpu.create_nd_tdesc %2, shape : [%sizes_2#0, %sizes_2#1], strides : [%strides_3#0, 1] : i64 -> !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      %4 = xegpu.load_nd %3[%arg2, %arg3]  : !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>> -> vector<8x16xf32>
      gpu.return %4 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_dynamic_source2(%arg0: memref<?x8x16xf32>, %arg1: index, %arg2: index, %arg3: index) -> vector<8x16xf32> {
      %c4 = arith.constant 4 : index
      %subview = memref.subview %arg0[%arg1, 0, 0] [1, 8, 16] [1, 1, 1] : memref<?x8x16xf32> to memref<8x16xf32, strided<[16, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<8x16xf32, strided<[16, 1], offset: ?>> -> memref<f32>, index, index, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer : memref<f32> -> index
      %0 = arith.muli %offset, %c4 : index
      %1 = arith.addi %intptr, %0 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = xegpu.create_nd_tdesc %2, shape : [8, 16], strides : [16, 1] : i64 -> !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      %4 = xegpu.load_nd %3[%arg2, %arg3]  : !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>> -> vector<8x16xf32>
      gpu.return %4 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
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
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
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
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_8D_vector(%arg0: memref<2x2x2x2x2x2x2x2xf32>, %arg1: index) -> vector<2x2x2x2x2x2x2x2xf32> {
      %cst = arith.constant dense<true> : vector<2x2x2x2x2x2x2x2xi1>
      %cst_0 = arith.constant dense<2> : vector<2xindex>
      %cst_1 = arith.constant dense<4> : vector<2xindex>
      %cst_2 = arith.constant dense<8> : vector<2xindex>
      %cst_3 = arith.constant dense<16> : vector<2xindex>
      %cst_4 = arith.constant dense<32> : vector<2xindex>
      %cst_5 = arith.constant dense<64> : vector<2xindex>
      %cst_6 = arith.constant dense<128> : vector<2xindex>
      %c128 = arith.constant 128 : index
      %c64 = arith.constant 64 : index
      %c32 = arith.constant 32 : index
      %c16 = arith.constant 16 : index
      %c8 = arith.constant 8 : index
      %c4 = arith.constant 4 : index
      %c2 = arith.constant 2 : index
      %0 = vector.step : vector<2xindex>
      %1 = vector.step : vector<2xindex>
      %2 = vector.step : vector<2xindex>
      %3 = vector.step : vector<2xindex>
      %4 = vector.step : vector<2xindex>
      %5 = vector.step : vector<2xindex>
      %6 = vector.step : vector<2xindex>
      %7 = vector.step : vector<2xindex>
      %8 = arith.muli %0, %cst_6 : vector<2xindex>
      %9 = arith.muli %1, %cst_5 : vector<2xindex>
      %10 = arith.muli %2, %cst_4 : vector<2xindex>
      %11 = arith.muli %3, %cst_3 : vector<2xindex>
      %12 = arith.muli %4, %cst_2 : vector<2xindex>
      %13 = arith.muli %5, %cst_1 : vector<2xindex>
      %14 = arith.muli %6, %cst_0 : vector<2xindex>
      %15 = vector.shape_cast %8 : vector<2xindex> to vector<2x1x1x1x1x1x1x1xindex>
      %16 = vector.shape_cast %9 : vector<2xindex> to vector<1x2x1x1x1x1x1x1xindex>
      %17 = vector.shape_cast %10 : vector<2xindex> to vector<1x1x2x1x1x1x1x1xindex>
      %18 = vector.shape_cast %11 : vector<2xindex> to vector<1x1x1x2x1x1x1x1xindex>
      %19 = vector.shape_cast %12 : vector<2xindex> to vector<1x1x1x1x2x1x1x1xindex>
      %20 = vector.shape_cast %13 : vector<2xindex> to vector<1x1x1x1x1x2x1x1xindex>
      %21 = vector.shape_cast %14 : vector<2xindex> to vector<1x1x1x1x1x1x2x1xindex>
      %22 = vector.broadcast %15 : vector<2x1x1x1x1x1x1x1xindex> to vector<2x2x2x2x2x2x2x2xindex>
      %23 = vector.broadcast %16 : vector<1x2x1x1x1x1x1x1xindex> to vector<2x2x2x2x2x2x2x2xindex>
      %24 = vector.broadcast %17 : vector<1x1x2x1x1x1x1x1xindex> to vector<2x2x2x2x2x2x2x2xindex>
      %25 = vector.broadcast %18 : vector<1x1x1x2x1x1x1x1xindex> to vector<2x2x2x2x2x2x2x2xindex>
      %26 = vector.broadcast %19 : vector<1x1x1x1x2x1x1x1xindex> to vector<2x2x2x2x2x2x2x2xindex>
      %27 = vector.broadcast %20 : vector<1x1x1x1x1x2x1x1xindex> to vector<2x2x2x2x2x2x2x2xindex>
      %28 = vector.broadcast %21 : vector<1x1x1x1x1x1x2x1xindex> to vector<2x2x2x2x2x2x2x2xindex>
      %29 = vector.broadcast %7 : vector<2xindex> to vector<2x2x2x2x2x2x2x2xindex>
      %30 = arith.addi %22, %23 : vector<2x2x2x2x2x2x2x2xindex>
      %31 = arith.addi %30, %24 : vector<2x2x2x2x2x2x2x2xindex>
      %32 = arith.addi %31, %25 : vector<2x2x2x2x2x2x2x2xindex>
      %33 = arith.addi %32, %26 : vector<2x2x2x2x2x2x2x2xindex>
      %34 = arith.addi %33, %27 : vector<2x2x2x2x2x2x2x2xindex>
      %35 = arith.addi %34, %28 : vector<2x2x2x2x2x2x2x2xindex>
      %36 = arith.addi %35, %29 : vector<2x2x2x2x2x2x2x2xindex>
      %37 = arith.muli %arg1, %c128 : index
      %38 = arith.muli %arg1, %c64 : index
      %39 = arith.addi %37, %38 : index
      %40 = arith.muli %arg1, %c32 : index
      %41 = arith.addi %39, %40 : index
      %42 = arith.muli %arg1, %c16 : index
      %43 = arith.addi %41, %42 : index
      %44 = arith.muli %arg1, %c8 : index
      %45 = arith.addi %43, %44 : index
      %46 = arith.muli %arg1, %c4 : index
      %47 = arith.addi %45, %46 : index
      %48 = arith.muli %arg1, %c2 : index
      %49 = arith.addi %47, %48 : index
      %50 = arith.addi %49, %arg1 : index
      %51 = vector.broadcast %50 : index to vector<2x2x2x2x2x2x2x2xindex>
      %52 = arith.addi %51, %36 : vector<2x2x2x2x2x2x2x2xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<2x2x2x2x2x2x2x2xf32> -> index
      %53 = arith.index_cast %intptr : index to i64
      %54 = xegpu.load %53[%52], %cst  : i64, vector<2x2x2x2x2x2x2x2xindex>, vector<2x2x2x2x2x2x2x2xi1> -> vector<2x2x2x2x2x2x2x2xf32>
      gpu.return %54 : vector<2x2x2x2x2x2x2x2xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_transpose_f16(%arg0: memref<32x64xf16>, %arg1: index) -> vector<8x16xf16> {
      %0 = xegpu.create_nd_tdesc %arg0 : memref<32x64xf16> -> !xegpu.tensor_desc<16x8xf16, #xegpu.block_tdesc_attr<boundary_check = false>>
      %1 = xegpu.load_nd %0[%arg1, %arg1]  : !xegpu.tensor_desc<16x8xf16, #xegpu.block_tdesc_attr<boundary_check = false>> -> vector<16x8xf16>
      %2 = vector.transpose %1, [1, 0] : vector<16x8xf16> to vector<8x16xf16>
      gpu.return %2 : vector<8x16xf16>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
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
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_load_out_of_bounds_1D_vector(%arg0: memref<8x16x32xf32>, %arg1: index) -> vector<8xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg1, %arg1], %cst : memref<8x16x32xf32>, vector<8xf32>
      gpu.return %0 : vector<8xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
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
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_load_tensor(%arg0: tensor<32x64xf32>, %arg1: index, %arg2: index) -> vector<8x16xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg2], %cst {in_bounds = [true, true]} : tensor<32x64xf32>, vector<8x16xf32>
      gpu.return %0 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
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
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_load_unsupported_map(%arg0: memref<16x32x64xf32>, %arg1: index) -> vector<8x16xf32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1, %arg1, %arg1], %cst {in_bounds = [true, true], permutation_map = #map} : memref<16x32x64xf32>, vector<8x16xf32>
      gpu.return %0 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
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
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_from_subview_2D(%arg0: memref<4096x4096xf16>, %arg1: index, %arg2: index) -> vector<8x16xf16> {
      %c2 = arith.constant 2 : index
      %subview = memref.subview %arg0[%arg1, %arg2] [256, 256] [1, 1] : memref<4096x4096xf16> to memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<256x256xf16, strided<[4096, 1], offset: ?>> -> memref<f16>, index, index, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer : memref<f16> -> index
      %0 = arith.muli %offset, %c2 : index
      %1 = arith.addi %intptr, %0 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = xegpu.create_nd_tdesc %2, shape : [256, 256], strides : [4096, 1] : i64 -> !xegpu.tensor_desc<8x16xf16, #xegpu.block_tdesc_attr<boundary_check = false>>
      %4 = xegpu.load_nd %3[%arg2, %arg2]  : !xegpu.tensor_desc<8x16xf16, #xegpu.block_tdesc_attr<boundary_check = false>> -> vector<8x16xf16>
      gpu.return %4 : vector<8x16xf16>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_2D_vector_addrspace3(%arg0: memref<16x32xf32, 3>, %arg1: index) -> vector<8x16xf32> {
      %0 = xegpu.create_mem_desc %arg0 : memref<16x32xf32, 3> -> !xegpu.mem_desc<16x32xf32>
      %1 = xegpu.load_matrix %0[%arg1, %arg1] : !xegpu.mem_desc<16x32xf32>, index, index -> vector<8x16xf32>
      gpu.return %1 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_1D_vector_addrspace3(%arg0: memref<32xf32, 3>, %arg1: index) -> vector<8xf32> {
      %0 = xegpu.create_mem_desc %arg0 : memref<32xf32, 3> -> !xegpu.mem_desc<32xf32>
      %1 = xegpu.load_matrix %0[%arg1] : !xegpu.mem_desc<32xf32>, index -> vector<8xf32>
      gpu.return %1 : vector<8xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_2D_vector_alloca_promoted_to_slm(%arg0: index) -> vector<8x16xf32> {
      %alloca = memref.alloca() : memref<16x32xf32, 3>
      %0 = xegpu.create_mem_desc %alloca : memref<16x32xf32, 3> -> !xegpu.mem_desc<16x32xf32>
      %1 = xegpu.load_matrix %0[%arg0, %arg0] : !xegpu.mem_desc<16x32xf32>, index, index -> vector<8x16xf32>
      gpu.return %1 : vector<8x16xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_1D_vector_alloca_promoted_to_slm(%arg0: index) -> vector<8xf32> {
      %alloca = memref.alloca() : memref<16xf32, 3>
      %0 = xegpu.create_mem_desc %alloca : memref<16xf32, 3> -> !xegpu.mem_desc<16xf32>
      %1 = xegpu.load_matrix %0[%arg0] : !xegpu.mem_desc<16xf32>, index -> vector<8xf32>
      gpu.return %1 : vector<8xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_0D_memref_unsupported(%arg0: memref<f16>) -> vector<f16> {
      %cst = arith.constant 0.000000e+00 : f16
      %0 = vector.transfer_read %arg0[], %cst : memref<f16>, vector<f16>
      gpu.return %0 : vector<f16>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @load_0D_vector_unsupported(%arg0: memref<3xf32>, %arg1: index) -> vector<f32> {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = vector.transfer_read %arg0[%arg1], %cst : memref<3xf32>, vector<f32>
      gpu.return %0 : vector<f32>
    }
  }
}

// -----
#map = affine_map<()[s0] -> (s0 * 16)>
#map1 = affine_map<()[s0] -> (s0 * 8)>
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @transpose_1x1024x24x64(%arg0: memref<1x1024x24x64xf16>, %arg1: memref<1x24x1024x64xf16>) kernel attributes {known_block_size = array<i32: 256, 1, 1>} {
      %cst = arith.constant dense<64> : vector<16xindex>
      %cst_0 = arith.constant dense<65536> : vector<1xindex>
      %c65536 = arith.constant 65536 : index
      %cst_1 = arith.constant dense<true> : vector<1x1x16x8xi1>
      %cst_2 = arith.constant dense<1536> : vector<16xindex>
      %cst_3 = arith.constant dense<64> : vector<1xindex>
      %cst_4 = arith.constant dense<1572864> : vector<1xindex>
      %c64 = arith.constant 64 : index
      %c1536 = arith.constant 1536 : index
      %block_id_x = gpu.block_id x
      %block_id_y = gpu.block_id y
      %block_id_z = gpu.block_id z
      %0 = affine.apply #map()[%block_id_y]
      %1 = affine.apply #map1()[%block_id_z]
      %2 = vector.step : vector<1xindex>
      %3 = vector.step : vector<1xindex>
      %4 = vector.step : vector<16xindex>
      %5 = vector.step : vector<8xindex>
      %6 = arith.muli %2, %cst_4 : vector<1xindex>
      %7 = arith.muli %3, %cst_3 : vector<1xindex>
      %8 = arith.muli %4, %cst_2 : vector<16xindex>
      %9 = vector.shape_cast %8 : vector<16xindex> to vector<1x1x16x1xindex>
      %10 = vector.broadcast %6 : vector<1xindex> to vector<1x1x16x8xindex>
      %11 = vector.broadcast %7 : vector<1xindex> to vector<1x1x16x8xindex>
      %12 = vector.broadcast %9 : vector<1x1x16x1xindex> to vector<1x1x16x8xindex>
      %13 = vector.broadcast %5 : vector<8xindex> to vector<1x1x16x8xindex>
      %14 = arith.addi %10, %11 : vector<1x1x16x8xindex>
      %15 = arith.addi %14, %12 : vector<1x1x16x8xindex>
      %16 = arith.addi %15, %13 : vector<1x1x16x8xindex>
      %17 = arith.muli %0, %c1536 : index
      %18 = arith.muli %block_id_x, %c64 : index
      %19 = arith.addi %17, %18 : index
      %20 = arith.addi %19, %1 : index
      %21 = vector.broadcast %20 : index to vector<1x1x16x8xindex>
      %22 = arith.addi %21, %16 : vector<1x1x16x8xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<1x1024x24x64xf16> -> index
      %23 = arith.index_cast %intptr : index to i64
      %24 = xegpu.load %23[%22], %cst_1  : i64, vector<1x1x16x8xindex>, vector<1x1x16x8xi1> -> vector<1x1x16x8xf16>
      %25 = vector.step : vector<1xindex>
      %26 = vector.step : vector<1xindex>
      %27 = vector.step : vector<16xindex>
      %28 = vector.step : vector<8xindex>
      %29 = arith.muli %25, %cst_4 : vector<1xindex>
      %30 = arith.muli %26, %cst_0 : vector<1xindex>
      %31 = arith.muli %27, %cst : vector<16xindex>
      %32 = vector.shape_cast %31 : vector<16xindex> to vector<1x1x16x1xindex>
      %33 = vector.broadcast %29 : vector<1xindex> to vector<1x1x16x8xindex>
      %34 = vector.broadcast %30 : vector<1xindex> to vector<1x1x16x8xindex>
      %35 = vector.broadcast %32 : vector<1x1x16x1xindex> to vector<1x1x16x8xindex>
      %36 = vector.broadcast %28 : vector<8xindex> to vector<1x1x16x8xindex>
      %37 = arith.addi %33, %34 : vector<1x1x16x8xindex>
      %38 = arith.addi %37, %35 : vector<1x1x16x8xindex>
      %39 = arith.addi %38, %36 : vector<1x1x16x8xindex>
      %40 = arith.muli %block_id_x, %c65536 : index
      %41 = arith.muli %0, %c64 : index
      %42 = arith.addi %40, %41 : index
      %43 = arith.addi %42, %1 : index
      %44 = vector.broadcast %43 : index to vector<1x1x16x8xindex>
      %45 = arith.addi %44, %39 : vector<1x1x16x8xindex>
      %intptr_5 = memref.extract_aligned_pointer_as_index %arg1 : memref<1x24x1024x64xf16> -> index
      %46 = arith.index_cast %intptr_5 : index to i64
      xegpu.store %24, %46[%45], %cst_1  : vector<1x1x16x8xf16>, i64, vector<1x1x16x8xindex>, vector<1x1x16x8xi1>
      gpu.return
    }
  }
}

