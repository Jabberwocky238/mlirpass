#map = affine_map<()[s0] -> (s0 * 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 32) * 16)>
#map2 = affine_map<(d0)[s0] -> (d0 + s0)>
#map3 = affine_map<(d0) -> (d0 + 8)>
#map4 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @matmul(%arg0: memref<32x32xf32>, %arg1: memref<32x32xf32>, %arg2: memref<32x32xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<0.000000e+00> : vector<16x16xf32>
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %cst_0 = arith.constant 0.000000e+00 : f32
    %thread_id_x = gpu.thread_id  x
    %thread_id_y = gpu.thread_id  y
    %0 = affine.apply #map()[%thread_id_y]
    %1 = affine.apply #map1()[%thread_id_x]
    %2 = scf.for %arg3 = %c0 to %c32 step %c16 iter_args(%arg4 = %cst) -> (vector<16x16xf32>) {
      %5 = affine.apply #map2(%c0)[%0]
      %6 = affine.apply #map2(%c0)[%arg3]
      %7 = vector.transfer_read %arg0[%5, %6], %cst_0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x8xf32>
      %8 = affine.apply #map3(%6)
      %9 = vector.transfer_read %arg0[%5, %8], %cst_0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x8xf32>
      %10 = affine.apply #map2(%c0)[%1]
      %11 = affine.apply #map2(%c0)[%arg3]
      %12 = vector.transfer_read %arg1[%11, %10], %cst_0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<8x16xf32>
      %13 = affine.apply #map3(%11)
      %14 = vector.transfer_read %arg1[%13, %10], %cst_0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<8x16xf32>
      %15 = vector.contract {indexing_maps = [#map4, #map5, #map6], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %7, %12, %arg4 : vector<16x8xf32>, vector<8x16xf32> into vector<16x16xf32>
      %16 = vector.contract {indexing_maps = [#map4, #map5, #map6], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %9, %14, %15 : vector<16x8xf32>, vector<8x16xf32> into vector<16x16xf32>
      scf.yield %16 : vector<16x16xf32>
    }
    %3 = affine.apply #map2(%c0)[%0]
    %4 = affine.apply #map2(%c0)[%1]
    vector.transfer_write %2, %arg2[%3, %4] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32>
    return
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.op<"func.func">
      transform.apply_patterns to %0 {
        transform.apply_patterns.gpu.unroll_vectors_subgroup_mma[16, 16, 8]
      } : !transform.op<"func.func">
      transform.yield 
    }
  }
}

// -----
#map = affine_map<()[s0] -> (s0 * 16)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 32) * 16)>
#map2 = affine_map<(d0)[s0] -> (d0 + s0)>
#map3 = affine_map<(d0) -> (d0 + 4)>
#map4 = affine_map<(d0) -> (d0 + 8)>
#map5 = affine_map<(d0) -> (d0 + 12)>
#map6 = affine_map<(d0, d1, d2) -> (d0, d2)>
#map7 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map8 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @gathered_matmul(%arg0: memref<32x32xf32>, %arg1: memref<32x32xf32>, %arg2: memref<32x32xf32>) {
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<0.000000e+00> : vector<16x16xf32>
    %cst_0 = arith.constant dense<true> : vector<4x4xi1>
    %cst_1 = arith.constant dense<0.000000e+00> : vector<4x4xf32>
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %cst_2 = arith.constant 0.000000e+00 : f32
    %cst_3 = arith.constant dense<[0, 1, 2, 3]> : vector<4xindex>
    %cst_4 = arith.constant dense<1> : vector<4x4xindex>
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<32x32xf32>
    %thread_id_x = gpu.thread_id  x
    %thread_id_y = gpu.thread_id  y
    %0 = affine.apply #map()[%thread_id_y]
    %1 = affine.apply #map1()[%thread_id_x]
    %2 = scf.for %arg3 = %c0 to %c32 step %c16 iter_args(%arg4 = %cst) -> (vector<16x16xf32>) {
      %8 = vector.broadcast %arg3 : index to vector<4xindex>
      %9 = arith.addi %8, %cst_3 : vector<4xindex>
      %10 = vector.broadcast %9 : vector<4xindex> to vector<4x4xindex>
      %11 = arith.addi %10, %cst_4 : vector<4x4xindex>
      %12 = vector.gather %arg0[%c0, %c0] [%11], %cst_0, %cst_1 : memref<32x32xf32>, vector<4x4xindex>, vector<4x4xi1>, vector<4x4xf32> into vector<4x4xf32>
      vector.transfer_write %12, %alloc[%c0, %c0] {in_bounds = [true, true]} : vector<4x4xf32>, memref<32x32xf32>
      gpu.barrier
      %13 = affine.apply #map2(%c0)[%0]
      %14 = affine.apply #map2(%c0)[%arg3]
      %15 = vector.transfer_read %alloc[%13, %14], %cst_2 {in_bounds = [true, true]} : memref<32x32xf32>, vector<8x4xf32>
      %16 = affine.apply #map3(%14)
      %17 = vector.transfer_read %alloc[%13, %16], %cst_2 {in_bounds = [true, true]} : memref<32x32xf32>, vector<8x4xf32>
      %18 = affine.apply #map4(%14)
      %19 = vector.transfer_read %alloc[%13, %18], %cst_2 {in_bounds = [true, true]} : memref<32x32xf32>, vector<8x4xf32>
      %20 = affine.apply #map5(%14)
      %21 = vector.transfer_read %alloc[%13, %20], %cst_2 {in_bounds = [true, true]} : memref<32x32xf32>, vector<8x4xf32>
      %22 = affine.apply #map4(%13)
      %23 = vector.transfer_read %alloc[%22, %14], %cst_2 {in_bounds = [true, true]} : memref<32x32xf32>, vector<8x4xf32>
      %24 = affine.apply #map4(%13)
      %25 = affine.apply #map3(%14)
      %26 = vector.transfer_read %alloc[%24, %25], %cst_2 {in_bounds = [true, true]} : memref<32x32xf32>, vector<8x4xf32>
      %27 = affine.apply #map4(%13)
      %28 = affine.apply #map4(%14)
      %29 = vector.transfer_read %alloc[%27, %28], %cst_2 {in_bounds = [true, true]} : memref<32x32xf32>, vector<8x4xf32>
      %30 = affine.apply #map4(%13)
      %31 = affine.apply #map5(%14)
      %32 = vector.transfer_read %alloc[%30, %31], %cst_2 {in_bounds = [true, true]} : memref<32x32xf32>, vector<8x4xf32>
      %33 = affine.apply #map2(%c0)[%1]
      %34 = affine.apply #map2(%c0)[%arg3]
      %35 = vector.transfer_read %arg1[%34, %33], %cst_2 {in_bounds = [true, true]} : memref<32x32xf32>, vector<4x16xf32>
      %36 = affine.apply #map3(%34)
      %37 = vector.transfer_read %arg1[%36, %33], %cst_2 {in_bounds = [true, true]} : memref<32x32xf32>, vector<4x16xf32>
      %38 = affine.apply #map4(%34)
      %39 = vector.transfer_read %arg1[%38, %33], %cst_2 {in_bounds = [true, true]} : memref<32x32xf32>, vector<4x16xf32>
      %40 = affine.apply #map5(%34)
      %41 = vector.transfer_read %arg1[%40, %33], %cst_2 {in_bounds = [true, true]} : memref<32x32xf32>, vector<4x16xf32>
      %42 = vector.extract_strided_slice %arg4 {offsets = [0, 0], sizes = [8, 16], strides = [1, 1]} : vector<16x16xf32> to vector<8x16xf32>
      %43 = vector.contract {indexing_maps = [#map6, #map7, #map8], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %15, %35, %42 : vector<8x4xf32>, vector<4x16xf32> into vector<8x16xf32>
      %44 = vector.extract_strided_slice %arg4 {offsets = [8, 0], sizes = [8, 16], strides = [1, 1]} : vector<16x16xf32> to vector<8x16xf32>
      %45 = vector.contract {indexing_maps = [#map6, #map7, #map8], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %23, %35, %44 : vector<8x4xf32>, vector<4x16xf32> into vector<8x16xf32>
      %46 = vector.contract {indexing_maps = [#map6, #map7, #map8], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %17, %37, %43 : vector<8x4xf32>, vector<4x16xf32> into vector<8x16xf32>
      %47 = vector.contract {indexing_maps = [#map6, #map7, #map8], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %26, %37, %45 : vector<8x4xf32>, vector<4x16xf32> into vector<8x16xf32>
      %48 = vector.contract {indexing_maps = [#map6, #map7, #map8], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %19, %39, %46 : vector<8x4xf32>, vector<4x16xf32> into vector<8x16xf32>
      %49 = vector.contract {indexing_maps = [#map6, #map7, #map8], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %29, %39, %47 : vector<8x4xf32>, vector<4x16xf32> into vector<8x16xf32>
      %50 = vector.contract {indexing_maps = [#map6, #map7, #map8], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %21, %41, %48 : vector<8x4xf32>, vector<4x16xf32> into vector<8x16xf32>
      %51 = vector.contract {indexing_maps = [#map6, #map7, #map8], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %32, %41, %49 : vector<8x4xf32>, vector<4x16xf32> into vector<8x16xf32>
      %52 = vector.insert_strided_slice %50, %cst {offsets = [0, 0], strides = [1, 1]} : vector<8x16xf32> into vector<16x16xf32>
      %53 = vector.insert_strided_slice %51, %52 {offsets = [8, 0], strides = [1, 1]} : vector<8x16xf32> into vector<16x16xf32>
      scf.yield %53 : vector<16x16xf32>
    }
    %3 = affine.apply #map2(%c0)[%0]
    %4 = affine.apply #map2(%c0)[%1]
    %5 = vector.extract_strided_slice %2 {offsets = [0, 0], sizes = [8, 16], strides = [1, 1]} : vector<16x16xf32> to vector<8x16xf32>
    vector.transfer_write %5, %arg2[%3, %4] {in_bounds = [true, true]} : vector<8x16xf32>, memref<32x32xf32>
    %6 = vector.extract_strided_slice %2 {offsets = [8, 0], sizes = [8, 16], strides = [1, 1]} : vector<16x16xf32> to vector<8x16xf32>
    %7 = affine.apply #map4(%3)
    vector.transfer_write %6, %arg2[%7, %4] {in_bounds = [true, true]} : vector<8x16xf32>, memref<32x32xf32>
    return
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.op<"func.func">
      transform.apply_patterns to %0 {
        transform.apply_patterns.gpu.unroll_vectors_subgroup_mma[8, 16, 4]
      } : !transform.op<"func.func">
      transform.yield 
    }
  }
}

