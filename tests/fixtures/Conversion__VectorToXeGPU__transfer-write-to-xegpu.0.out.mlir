module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @store_1D_vector(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index) {
      %c4 = arith.constant 4 : index
      %subview = memref.subview %arg1[%arg2, %arg2, 0] [1, 1, 32] [1, 1, 1] : memref<8x16x32xf32> to memref<32xf32, strided<[1], offset: ?>>
      %base_buffer, %offset, %sizes, %strides = memref.extract_strided_metadata %subview : memref<32xf32, strided<[1], offset: ?>> -> memref<f32>, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer : memref<f32> -> index
      %0 = arith.muli %offset, %c4 : index
      %1 = arith.addi %intptr, %0 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = xegpu.create_nd_tdesc %2, shape : [32], strides : [1] : i64 -> !xegpu.tensor_desc<8xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      xegpu.store_nd %arg0, %3[%arg2]  : vector<8xf32>, !xegpu.tensor_desc<8xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @store_2D_vector(%arg0: vector<8x16xf32>, %arg1: memref<8x16x32xf32>, %arg2: index) {
      %c4 = arith.constant 4 : index
      %subview = memref.subview %arg1[%arg2, 0, 0] [1, 16, 32] [1, 1, 1] : memref<8x16x32xf32> to memref<16x32xf32, strided<[32, 1], offset: ?>>
      %base_buffer, %offset, %sizes:2, %strides:2 = memref.extract_strided_metadata %subview : memref<16x32xf32, strided<[32, 1], offset: ?>> -> memref<f32>, index, index, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer : memref<f32> -> index
      %0 = arith.muli %offset, %c4 : index
      %1 = arith.addi %intptr, %0 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = xegpu.create_nd_tdesc %2, shape : [16, 32], strides : [32, 1] : i64 -> !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      xegpu.store_nd %arg0, %3[%arg2, %arg2]  : vector<8x16xf32>, !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @store_dynamic_source(%arg0: vector<8x16xf32>, %arg1: memref<?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index) {
      %c4 = arith.constant 4 : index
      %base_buffer, %offset, %sizes:3, %strides:3 = memref.extract_strided_metadata %arg1 : memref<?x?x?xf32> -> memref<f32>, index, index, index, index, index, index, index
      %subview = memref.subview %arg1[%arg2, 0, 0] [1, %sizes#1, %sizes#2] [1, 1, 1] : memref<?x?x?xf32> to memref<?x?xf32, strided<[?, 1], offset: ?>>
      %base_buffer_0, %offset_1, %sizes_2:2, %strides_3:2 = memref.extract_strided_metadata %subview : memref<?x?xf32, strided<[?, 1], offset: ?>> -> memref<f32>, index, index, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer_0 : memref<f32> -> index
      %0 = arith.muli %offset_1, %c4 : index
      %1 = arith.addi %intptr, %0 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = xegpu.create_nd_tdesc %2, shape : [%sizes_2#0, %sizes_2#1], strides : [%strides_3#0, 1] : i64 -> !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      xegpu.store_nd %arg0, %3[%arg3, %arg4]  : vector<8x16xf32>, !xegpu.tensor_desc<8x16xf32, #xegpu.block_tdesc_attr<boundary_check = false>>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @store_out_of_bounds(%arg0: vector<8x16xf32>, %arg1: memref<7x64xf32>, %arg2: index) {
      %0 = xegpu.create_nd_tdesc %arg1 : memref<7x64xf32> -> !xegpu.tensor_desc<8x16xf32>
      xegpu.store_nd %arg0, %0[%arg2, %arg2]  : vector<8x16xf32>, !xegpu.tensor_desc<8x16xf32>
      gpu.return
    }
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_store_transposed(%arg0: vector<8x16xf32>, %arg1: memref<32x64xf32>, %arg2: index) {
      vector.transfer_write %arg0, %arg1[%arg2, %arg2] {in_bounds = [true, true], permutation_map = #map} : vector<8x16xf32>, memref<32x64xf32>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
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
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @store_8D_vector(%arg0: vector<2x2x2x2x2x2x2x2xf32>, %arg1: memref<2x2x2x2x2x2x2x2xf32>, %arg2: index) {
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
      %37 = arith.muli %arg2, %c128 : index
      %38 = arith.muli %arg2, %c64 : index
      %39 = arith.addi %37, %38 : index
      %40 = arith.muli %arg2, %c32 : index
      %41 = arith.addi %39, %40 : index
      %42 = arith.muli %arg2, %c16 : index
      %43 = arith.addi %41, %42 : index
      %44 = arith.muli %arg2, %c8 : index
      %45 = arith.addi %43, %44 : index
      %46 = arith.muli %arg2, %c4 : index
      %47 = arith.addi %45, %46 : index
      %48 = arith.muli %arg2, %c2 : index
      %49 = arith.addi %47, %48 : index
      %50 = arith.addi %49, %arg2 : index
      %51 = vector.broadcast %50 : index to vector<2x2x2x2x2x2x2x2xindex>
      %52 = arith.addi %51, %36 : vector<2x2x2x2x2x2x2x2xindex>
      %intptr = memref.extract_aligned_pointer_as_index %arg1 : memref<2x2x2x2x2x2x2x2xf32> -> index
      %53 = arith.index_cast %intptr : index to i64
      xegpu.store %arg0, %53[%52], %cst  : vector<2x2x2x2x2x2x2x2xf32>, i64, vector<2x2x2x2x2x2x2x2xindex>, vector<2x2x2x2x2x2x2x2xi1>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_store_masked(%arg0: vector<4xf32>, %arg1: memref<4xf32>, %arg2: index) {
      %cst = arith.constant dense<[false, true, false, true]> : vector<4xi1>
      vector.transfer_write %arg0, %arg1[%arg2], %cst {in_bounds = [true]} : vector<4xf32>, memref<4xf32>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_store_tensor(%arg0: vector<8x16xf32>, %arg1: tensor<32x64xf32>, %arg2: index) -> tensor<32x64xf32> {
      %0 = vector.transfer_write %arg0, %arg1[%arg2, %arg2] {in_bounds = [true, true]} : vector<8x16xf32>, tensor<32x64xf32>
      gpu.return %0 : tensor<32x64xf32>
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_store_non_unit_inner_stride(%arg0: vector<8xf32>, %arg1: memref<32xf32, strided<[?], offset: ?>>, %arg2: index) {
      vector.transfer_write %arg0, %arg1[%arg2] {in_bounds = [true]} : vector<8xf32>, memref<32xf32, strided<[?], offset: ?>>
      gpu.return
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_store_unsupported_map(%arg0: vector<8x16xf32>, %arg1: memref<16x32x64xf32>, %arg2: index) {
      vector.transfer_write %arg0, %arg1[%arg2, %arg2, %arg2] {in_bounds = [true, true], permutation_map = #map} : vector<8x16xf32>, memref<16x32x64xf32>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @no_store_out_of_bounds_1D_vector(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index) {
      vector.transfer_write %arg0, %arg1[%arg2, %arg2, %arg2] : vector<8xf32>, memref<8x16x32xf32>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @store_to_subview(%arg0: vector<8xf16>, %arg1: memref<4096x4096xf16>, %arg2: index, %arg3: index) {
      %c2 = arith.constant 2 : index
      %subview = memref.subview %arg1[%arg2, %arg3] [256, 256] [1, 1] : memref<4096x4096xf16> to memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %subview_0 = memref.subview %subview[%arg3, 0] [1, 256] [1, 1] : memref<256x256xf16, strided<[4096, 1], offset: ?>> to memref<256xf16, strided<[1], offset: ?>>
      %base_buffer, %offset, %sizes, %strides = memref.extract_strided_metadata %subview_0 : memref<256xf16, strided<[1], offset: ?>> -> memref<f16>, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer : memref<f16> -> index
      %0 = arith.muli %offset, %c2 : index
      %1 = arith.addi %intptr, %0 : index
      %2 = arith.index_cast %1 : index to i64
      %3 = xegpu.create_nd_tdesc %2, shape : [256], strides : [1] : i64 -> !xegpu.tensor_desc<8xf16, #xegpu.block_tdesc_attr<boundary_check = false>>
      xegpu.store_nd %arg0, %3[%arg3]  : vector<8xf16>, !xegpu.tensor_desc<8xf16, #xegpu.block_tdesc_attr<boundary_check = false>>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @store_2D_vector_addrspace3(%arg0: vector<8x16xf32>, %arg1: memref<16x32xf32, 3>, %arg2: index) {
      %0 = xegpu.create_mem_desc %arg1 : memref<16x32xf32, 3> -> !xegpu.mem_desc<16x32xf32>
      xegpu.store_matrix %arg0, %0[%arg2, %arg2] : vector<8x16xf32>, !xegpu.mem_desc<16x32xf32>, index, index
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @store_1D_vector_addrspace3(%arg0: vector<8xf32>, %arg1: memref<32xf32, 3>, %arg2: index) {
      %0 = xegpu.create_mem_desc %arg1 : memref<32xf32, 3> -> !xegpu.mem_desc<32xf32>
      xegpu.store_matrix %arg0, %0[%arg2] : vector<8xf32>, !xegpu.mem_desc<32xf32>, index
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @xevm_module [#xevm.target<O = 3, chip = "pvc">] {
    gpu.func @store_0D_vector_unsupported(%arg0: vector<f32>, %arg1: memref<3xf32>, %arg2: index) {
      vector.transfer_write %arg0, %arg1[%arg2] : vector<f32>, memref<3xf32>
      gpu.return
    }
  }
}

