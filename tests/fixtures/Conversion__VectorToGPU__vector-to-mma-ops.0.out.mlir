module {
  func.func @matmul(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>) {
    %c0 = arith.constant 0 : index
    %0 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
    %1 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "COp">
    %2 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
    %3 = gpu.subgroup_mma_compute %0, %2, %1 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf16, "COp">
    gpu.subgroup_mma_store_matrix %3, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>
    return
  }
}

// -----
module {
  func.func @matmul_cst(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f16
    %0 = gpu.subgroup_mma_constant_matrix %cst : !gpu.mma_matrix<16x16xf16, "COp">
    %1 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
    %2 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
    %3 = gpu.subgroup_mma_compute %1, %2, %0 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf16, "COp">
    gpu.subgroup_mma_store_matrix %3, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>
    return
  }
}

// -----
module {
  func.func @matmul_broadcast(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>, %arg3: f16) {
    %c0 = arith.constant 0 : index
    %0 = gpu.subgroup_mma_constant_matrix %arg3 : !gpu.mma_matrix<16x16xf16, "COp">
    %1 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
    %2 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
    %3 = gpu.subgroup_mma_compute %1, %2, %0 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf16, "COp">
    gpu.subgroup_mma_store_matrix %3, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>
    return
  }
}

// -----
module {
  func.func @matmul_loop(%arg0: memref<128x128xf16>, %arg1: memref<128x128xf16>, %arg2: memref<128x128xf16>) {
    %c0 = arith.constant 0 : index
    %c128 = arith.constant 128 : index
    %c32 = arith.constant 32 : index
    %0 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 128 : index} : memref<128x128xf16> -> !gpu.mma_matrix<16x16xf16, "COp">
    %1 = scf.for %arg3 = %c0 to %c128 step %c32 iter_args(%arg4 = %0) -> (!gpu.mma_matrix<16x16xf16, "COp">) {
      %2 = gpu.subgroup_mma_load_matrix %arg0[%c0, %arg3] {leadDimension = 128 : index} : memref<128x128xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
      %3 = gpu.subgroup_mma_load_matrix %arg1[%arg3, %c0] {leadDimension = 128 : index} : memref<128x128xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
      %4 = gpu.subgroup_mma_compute %2, %3, %arg4 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf16, "COp">
      scf.yield %4 : !gpu.mma_matrix<16x16xf16, "COp">
    }
    gpu.subgroup_mma_store_matrix %1, %arg2[%c0, %c0] {leadDimension = 128 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<128x128xf16>
    return
  }
}

// -----
module {
  func.func @matmul_fused_elementwise(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 1.000000e+00 : f16
    %cst_0 = arith.constant 0.000000e+00 : f16
    %0 = gpu.subgroup_mma_constant_matrix %cst_0 : !gpu.mma_matrix<16x16xf16, "COp">
    %1 = gpu.subgroup_mma_constant_matrix %cst : !gpu.mma_matrix<16x16xf16, "COp">
    %2 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
    %3 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
    %4 = gpu.subgroup_mma_compute %2, %3, %0 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf16, "COp">
    %5 = gpu.subgroup_mma_elementwise  addf %4, %1 : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    gpu.subgroup_mma_store_matrix %5, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>
    return
  }
}

// -----
module {
  func.func @matmul_fused_broadcast(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>, %arg3: memref<16x16x16x16xf16>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f16
    %0 = gpu.subgroup_mma_constant_matrix %cst : !gpu.mma_matrix<16x16xf16, "COp">
    %1 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
    %2 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
    %3 = gpu.subgroup_mma_compute %1, %2, %0 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf16, "COp">
    %4 = gpu.subgroup_mma_load_matrix %arg3[%c0, %c0, %c0, %c0] {leadDimension = 0 : index} : memref<16x16x16x16xf16> -> !gpu.mma_matrix<16x16xf16, "COp">
    %5 = gpu.subgroup_mma_elementwise  divf %3, %4 : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    gpu.subgroup_mma_store_matrix %5, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>
    return
  }
}

// -----
module {
  func.func @matmul_3Dmemref(%arg0: memref<2x16x16xf16>, %arg1: memref<16xf16>, %arg2: memref<2x16x16xf16>) {
    %c0 = arith.constant 0 : index
    %0 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0, %c0] {leadDimension = 16 : index} : memref<2x16x16xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
    %1 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0, %c0] {leadDimension = 16 : index} : memref<2x16x16xf16> -> !gpu.mma_matrix<16x16xf16, "COp">
    %2 = gpu.subgroup_mma_load_matrix %arg1[%c0] {leadDimension = 0 : index} : memref<16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
    %3 = gpu.subgroup_mma_compute %0, %2, %1 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf16, "COp">
    gpu.subgroup_mma_store_matrix %3, %arg2[%c0, %c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<2x16x16xf16>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0 * 512 + d1 * 32 + d2)>
module {
  func.func @matmul_memref_strided(%arg0: memref<2x16x16xf16, #map>, %arg1: memref<16xf16>, %arg2: memref<2x16x16xf16>) {
    %c0 = arith.constant 0 : index
    %0 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0, %c0] {leadDimension = 32 : index} : memref<2x16x16xf16, #map> -> !gpu.mma_matrix<16x16xf16, "AOp">
    %1 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0, %c0] {leadDimension = 16 : index} : memref<2x16x16xf16> -> !gpu.mma_matrix<16x16xf16, "COp">
    %2 = gpu.subgroup_mma_load_matrix %arg1[%c0] {leadDimension = 0 : index} : memref<16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
    %3 = gpu.subgroup_mma_compute %0, %2, %1 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf16, "COp">
    gpu.subgroup_mma_store_matrix %3, %arg2[%c0, %c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<2x16x16xf16>
    return
  }
}

// -----
module {
  func.func @matmul_transposed(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>) {
    %c0 = arith.constant 0 : index
    %0 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
    %1 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "COp">
    %2 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 16 : index, transpose} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
    %3 = gpu.subgroup_mma_compute %0, %2, %1 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf16, "COp">
    gpu.subgroup_mma_store_matrix %3, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>
    return
  }
}

// -----
module {
  func.func @matmul_transposed_broadcasted_1d(%arg0: memref<16xf16>, %arg1: memref<16xf16>, %arg2: memref<16x16xf16>) {
    %c0 = arith.constant 0 : index
    %0 = gpu.subgroup_mma_load_matrix %arg0[%c0] {leadDimension = 0 : index, transpose} : memref<16xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
    %1 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "COp">
    %2 = gpu.subgroup_mma_load_matrix %arg1[%c0] {leadDimension = 0 : index} : memref<16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
    %3 = gpu.subgroup_mma_compute %0, %2, %1 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf16, "COp">
    gpu.subgroup_mma_store_matrix %3, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>
    return
  }
}

// -----
module {
  func.func @matmul_transposed_broadcasted_2d(%arg0: memref<32x32xf16>, %arg1: memref<32x32xf16>, %arg2: memref<16x16xf16>) {
    %c0 = arith.constant 0 : index
    %0 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 0 : index, transpose} : memref<32x32xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
    %1 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "COp">
    %2 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 0 : index} : memref<32x32xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
    %3 = gpu.subgroup_mma_compute %0, %2, %1 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf16, "COp">
    gpu.subgroup_mma_store_matrix %3, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @matmul_no_extend_int8(%arg0: memref<16x16xi8>, %arg1: memref<16x16xi8>, %arg2: memref<16x16xi32>) {
    %c0 = arith.constant 0 : index
    %c0_i8 = arith.constant 0 : i8
    %c0_i32 = arith.constant 0 : i32
    %0 = vector.transfer_read %arg0[%c0, %c0], %c0_i8 {in_bounds = [true, true]} : memref<16x16xi8>, vector<16x16xi8>
    %1 = vector.transfer_read %arg2[%c0, %c0], %c0_i32 {in_bounds = [true, true]} : memref<16x16xi32>, vector<16x16xi32>
    %2 = vector.transfer_read %arg1[%c0, %c0], %c0_i8 {in_bounds = [true, true]} : memref<16x16xi8>, vector<16x16xi8>
    %3 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %2, %1 : vector<16x16xi8>, vector<16x16xi8> into vector<16x16xi32>
    vector.transfer_write %3, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<16x16xi32>
    return
  }
}

// -----
module {
  func.func @matmul_int8(%arg0: memref<16x16xi8>, %arg1: memref<16x16xi8>, %arg2: memref<16x16xi32>) {
    %c0 = arith.constant 0 : index
    %0 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xi8> -> !gpu.mma_matrix<16x16xsi8, "AOp">
    %1 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xi32> -> !gpu.mma_matrix<16x16xi32, "COp">
    %2 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xi8> -> !gpu.mma_matrix<16x16xsi8, "BOp">
    %3 = gpu.subgroup_mma_compute %0, %2, %1 : !gpu.mma_matrix<16x16xsi8, "AOp">, !gpu.mma_matrix<16x16xsi8, "BOp"> -> !gpu.mma_matrix<16x16xi32, "COp">
    gpu.subgroup_mma_store_matrix %3, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xi32, "COp">, memref<16x16xi32>
    return
  }
}

// -----
module {
  func.func @matmul_mixed_signedness_int8(%arg0: memref<16x16xi8>, %arg1: memref<16x16xi8>, %arg2: memref<16x16xi32>) {
    %c0 = arith.constant 0 : index
    %0 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xi8> -> !gpu.mma_matrix<16x16xui8, "AOp">
    %1 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xi32> -> !gpu.mma_matrix<16x16xi32, "COp">
    %2 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xi8> -> !gpu.mma_matrix<16x16xsi8, "BOp">
    %3 = gpu.subgroup_mma_compute %0, %2, %1 : !gpu.mma_matrix<16x16xui8, "AOp">, !gpu.mma_matrix<16x16xsi8, "BOp"> -> !gpu.mma_matrix<16x16xi32, "COp">
    gpu.subgroup_mma_store_matrix %3, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xi32, "COp">, memref<16x16xi32>
    return
  }
}

// -----
module {
  func.func @matmul_mixed_signedness_int8(%arg0: memref<16x32xi8>, %arg1: memref<16x32xi8>, %arg2: memref<16x16xi32>) {
    %c0 = arith.constant 0 : index
    %0 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 32 : index} : memref<16x32xi8> -> !gpu.mma_matrix<16x32xui8, "AOp">
    %1 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xi32> -> !gpu.mma_matrix<16x16xi32, "COp">
    %2 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 32 : index} : memref<16x32xi8> -> !gpu.mma_matrix<32x16xsi8, "BOp">
    %3 = gpu.subgroup_mma_compute %0, %2, %1 : !gpu.mma_matrix<16x32xui8, "AOp">, !gpu.mma_matrix<32x16xsi8, "BOp"> -> !gpu.mma_matrix<16x16xi32, "COp">
    gpu.subgroup_mma_store_matrix %3, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xi32, "COp">, memref<16x16xi32>
    return
  }
}

// -----
module {
  func.func @cast_f16_to_f32_write(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>, %arg3: memref<16x16xf32>) {
    %c0 = arith.constant 0 : index
    %0 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
    %1 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "COp">
    %2 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 16 : index, transpose} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
    %3 = gpu.subgroup_mma_compute %0, %2, %1 : !gpu.mma_matrix<16x16xf16, "AOp">, !gpu.mma_matrix<16x16xf16, "BOp"> -> !gpu.mma_matrix<16x16xf16, "COp">
    %4 = gpu.subgroup_mma_elementwise  extf %3 : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
    gpu.subgroup_mma_store_matrix %4, %arg3[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @fold_transpose_into_transfer_read(%arg0: memref<64x128xf16>, %arg1: vector<32x128xf16>, %arg2: memref<32x64xf32>) {
    %cst = arith.constant dense<0.000000e+00> : vector<32x64xf32>
    %c0 = arith.constant 0 : index
    %cst_0 = arith.constant 0.000000e+00 : f16
    %0 = arith.extf %arg1 : vector<32x128xf16> to vector<32x128xf32>
    %1 = vector.transfer_read %arg0[%c0, %c0], %cst_0 {in_bounds = [true, true], permutation_map = #map} : memref<64x128xf16>, vector<128x64xf16>
    %2 = arith.extf %1 : vector<128x64xf16> to vector<128x64xf32>
    %3 = vector.contract {indexing_maps = [#map1, #map2, #map3], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %2, %cst : vector<32x128xf32>, vector<128x64xf32> into vector<32x64xf32>
    vector.transfer_write %3, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<32x64xf32>, memref<32x64xf32>
    return
  }
}

// -----
module {
  func.func @cast_f16_to_f32_read(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>, %arg3: memref<16x16xf32>) {
    %c0 = arith.constant 0 : index
    %0 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "AOp">
    %1 = gpu.subgroup_mma_load_matrix %arg2[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "COp">
    %2 = gpu.subgroup_mma_elementwise  extf %0 : (!gpu.mma_matrix<16x16xf16, "AOp">) -> !gpu.mma_matrix<16x16xf32, "AOp">
    %3 = gpu.subgroup_mma_elementwise  extf %1 : (!gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf32, "COp">
    %4 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 16 : index, transpose} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "BOp">
    %5 = gpu.subgroup_mma_elementwise  extf %4 : (!gpu.mma_matrix<16x16xf16, "BOp">) -> !gpu.mma_matrix<16x16xf32, "BOp">
    %6 = gpu.subgroup_mma_compute %2, %5, %3 : !gpu.mma_matrix<16x16xf32, "AOp">, !gpu.mma_matrix<16x16xf32, "BOp"> -> !gpu.mma_matrix<16x16xf32, "COp">
    gpu.subgroup_mma_store_matrix %6, %arg3[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf32, "COp">, memref<16x16xf32>
    return
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @test_unsupported(%arg0: vector<4x4xi32>, %arg1: vector<4x4xi32>, %arg2: vector<4x4xi64>) -> vector<4x4xi64> {
    %0 = arith.extui %arg0 : vector<4x4xi32> to vector<4x4xi64>
    %1 = arith.extui %arg1 : vector<4x4xi32> to vector<4x4xi64>
    %2 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %1, %arg2 : vector<4x4xi64>, vector<4x4xi64> into vector<4x4xi64>
    return %2 : vector<4x4xi64>
  }
}

// -----
module {
  func.func @addf(%arg0: memref<16x16xf16>, %arg1: memref<16x16xf16>, %arg2: memref<16x16xf16>) {
    %c0 = arith.constant 0 : index
    %0 = gpu.subgroup_mma_load_matrix %arg0[%c0, %c0] {leadDimension = 16 : index} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "COp">
    %1 = gpu.subgroup_mma_load_matrix %arg1[%c0, %c0] {leadDimension = 16 : index, transpose} : memref<16x16xf16> -> !gpu.mma_matrix<16x16xf16, "COp">
    %2 = gpu.subgroup_mma_elementwise  addf %0, %1 : (!gpu.mma_matrix<16x16xf16, "COp">, !gpu.mma_matrix<16x16xf16, "COp">) -> !gpu.mma_matrix<16x16xf16, "COp">
    gpu.subgroup_mma_store_matrix %2, %arg2[%c0, %c0] {leadDimension = 16 : index} : !gpu.mma_matrix<16x16xf16, "COp">, memref<16x16xf16>
    return
  }
}

