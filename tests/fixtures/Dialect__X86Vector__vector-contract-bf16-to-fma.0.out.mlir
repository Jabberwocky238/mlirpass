module {
  func.func @brgemm_to_fma(%arg0: memref<1x4x1x2xbf16>, %arg1: memref<1x1x32x2xbf16>, %arg2: vector<1x8xf32>) -> vector<1x8xf32> {
    %c0 = arith.constant 0 : index
    %subview = memref.subview %arg0[%c0, %c0, %c0, 1] [1, 1, 1, 1] [1, 1, 1, 1] : memref<1x4x1x2xbf16> to memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %subview_0 = memref.subview %arg0[%c0, %c0, %c0, 0] [1, 1, 1, 1] [1, 1, 1, 1] : memref<1x4x1x2xbf16> to memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %subview_1 = memref.subview %arg1[%c0, %c0, %c0, %c0] [1, 1, 8, 2] [1, 1, 1, 1] : memref<1x1x32x2xbf16> to memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>>
    %0 = vector.shape_cast %arg2 : vector<1x8xf32> to vector<8xf32>
    %1 = x86vector.avx.bcst_to_f32.packed %subview : memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86vector.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86vector.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86vector.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<1x8xf32>
    return %7 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_to_fma_load(%arg0: memref<1x4x1x2xbf16>, %arg1: memref<1x1x32x2xbf16>, %arg2: vector<1x8xf32>) -> vector<1x8xf32> {
    %c0 = arith.constant 0 : index
    %subview = memref.subview %arg0[%c0, %c0, %c0, 1] [1, 1, 1, 1] [1, 1, 1, 1] : memref<1x4x1x2xbf16> to memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %subview_0 = memref.subview %arg0[%c0, %c0, %c0, 0] [1, 1, 1, 1] [1, 1, 1, 1] : memref<1x4x1x2xbf16> to memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %subview_1 = memref.subview %arg1[%c0, %c0, %c0, %c0] [1, 1, 8, 2] [1, 1, 1, 1] : memref<1x1x32x2xbf16> to memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>>
    %0 = vector.shape_cast %arg2 : vector<1x8xf32> to vector<8xf32>
    %1 = x86vector.avx.bcst_to_f32.packed %subview : memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86vector.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86vector.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86vector.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<1x8xf32>
    return %7 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_to_fma_load_bcst_B(%arg0: memref<1x32x1x2xbf16>, %arg1: memref<1x1x4x2xbf16>, %arg2: vector<8x1xf32>) -> vector<8x1xf32> {
    %c0 = arith.constant 0 : index
    %subview = memref.subview %arg1[%c0, %c0, %c0, 1] [1, 1, 1, 1] [1, 1, 1, 1] : memref<1x1x4x2xbf16> to memref<1x1x1x1xbf16, strided<[8, 8, 2, 1], offset: ?>>
    %subview_0 = memref.subview %arg1[%c0, %c0, %c0, 0] [1, 1, 1, 1] [1, 1, 1, 1] : memref<1x1x4x2xbf16> to memref<1x1x1x1xbf16, strided<[8, 8, 2, 1], offset: ?>>
    %subview_1 = memref.subview %arg0[%c0, %c0, %c0, %c0] [1, 8, 1, 2] [1, 1, 1, 1] : memref<1x32x1x2xbf16> to memref<1x8x1x2xbf16, strided<[64, 2, 2, 1], offset: ?>>
    %0 = vector.shape_cast %arg2 : vector<8x1xf32> to vector<8xf32>
    %1 = x86vector.avx.bcst_to_f32.packed %subview : memref<1x1x1x1xbf16, strided<[8, 8, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86vector.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x8x1x2xbf16, strided<[64, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86vector.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1x1xbf16, strided<[8, 8, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86vector.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x8x1x2xbf16, strided<[64, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<8x1xf32>
    return %7 : vector<8x1xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @batch_matmul_fma_load(%arg0: memref<1x4x1x2xbf16>, %arg1: memref<1x1x32x2xbf16>, %arg2: vector<1x1x8xf32>) -> vector<1x1x8xf32> {
    %c0 = arith.constant 0 : index
    %subview = memref.subview %arg0[%c0, %c0, %c0, 1] [1, 1, 1, 1] [1, 1, 1, 1] : memref<1x4x1x2xbf16> to memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %subview_0 = memref.subview %arg0[%c0, %c0, %c0, 0] [1, 1, 1, 1] [1, 1, 1, 1] : memref<1x4x1x2xbf16> to memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %subview_1 = memref.subview %arg1[%c0, %c0, %c0, %c0] [1, 1, 8, 2] [1, 1, 1, 1] : memref<1x1x32x2xbf16> to memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>>
    %0 = vector.shape_cast %arg2 : vector<1x1x8xf32> to vector<8xf32>
    %1 = x86vector.avx.bcst_to_f32.packed %subview : memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86vector.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86vector.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86vector.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<1x1x8xf32>
    return %7 : vector<1x1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_outer_product_to_fma_load(%arg0: memref<4x1x2xbf16>, %arg1: memref<1x32x2xbf16>, %arg2: vector<1x8xf32>) -> vector<1x8xf32> {
    %c0 = arith.constant 0 : index
    %subview = memref.subview %arg0[%c0, %c0, 1] [1, 1, 1] [1, 1, 1] : memref<4x1x2xbf16> to memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>>
    %subview_0 = memref.subview %arg0[%c0, %c0, 0] [1, 1, 1] [1, 1, 1] : memref<4x1x2xbf16> to memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>>
    %subview_1 = memref.subview %arg1[%c0, %c0, %c0] [1, 8, 2] [1, 1, 1] : memref<1x32x2xbf16> to memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>>
    %0 = vector.shape_cast %arg2 : vector<1x8xf32> to vector<8xf32>
    %1 = x86vector.avx.bcst_to_f32.packed %subview : memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86vector.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86vector.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86vector.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<1x8xf32>
    return %7 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_dynamic_offset(%arg0: memref<4x1x2xbf16>, %arg1: memref<1x32x2xbf16>, %arg2: vector<1x8xf32>, %arg3: index) -> vector<1x8xf32> {
    %c0 = arith.constant 0 : index
    %subview = memref.subview %arg0[%arg3, %c0, 1] [1, 1, 1] [1, 1, 1] : memref<4x1x2xbf16> to memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>>
    %subview_0 = memref.subview %arg0[%arg3, %c0, 0] [1, 1, 1] [1, 1, 1] : memref<4x1x2xbf16> to memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>>
    %subview_1 = memref.subview %arg1[%c0, %c0, %c0] [1, 8, 2] [1, 1, 1] : memref<1x32x2xbf16> to memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>>
    %0 = vector.shape_cast %arg2 : vector<1x8xf32> to vector<8xf32>
    %1 = x86vector.avx.bcst_to_f32.packed %subview : memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86vector.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86vector.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86vector.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<1x8xf32>
    return %7 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_to_fma_load_bcst_B(%arg0: memref<32x1x2xbf16>, %arg1: memref<1x4x2xbf16>, %arg2: vector<8x1xf32>) -> vector<8x1xf32> {
    %c0 = arith.constant 0 : index
    %subview = memref.subview %arg1[%c0, %c0, 1] [1, 1, 1] [1, 1, 1] : memref<1x4x2xbf16> to memref<1x1x1xbf16, strided<[8, 2, 1], offset: ?>>
    %subview_0 = memref.subview %arg1[%c0, %c0, 0] [1, 1, 1] [1, 1, 1] : memref<1x4x2xbf16> to memref<1x1x1xbf16, strided<[8, 2, 1], offset: ?>>
    %subview_1 = memref.subview %arg0[%c0, %c0, %c0] [8, 1, 2] [1, 1, 1] : memref<32x1x2xbf16> to memref<8x1x2xbf16, strided<[2, 2, 1], offset: ?>>
    %0 = vector.shape_cast %arg2 : vector<8x1xf32> to vector<8xf32>
    %1 = x86vector.avx.bcst_to_f32.packed %subview : memref<1x1x1xbf16, strided<[8, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86vector.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<8x1x2xbf16, strided<[2, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86vector.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1xbf16, strided<[8, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86vector.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<8x1x2xbf16, strided<[2, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<8x1xf32>
    return %7 : vector<8x1xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @many_dimensions(%arg0: memref<1x1x4x1x2xbf16>, %arg1: memref<1x1x1x32x2xbf16>, %arg2: vector<1x8xf32>) -> vector<1x8xf32> {
    %c0 = arith.constant 0 : index
    %subview = memref.subview %arg0[%c0, %c0, %c0, %c0, 1] [1, 1, 1, 1, 1] [1, 1, 1, 1, 1] : memref<1x1x4x1x2xbf16> to memref<1x1x1x1x1xbf16, strided<[8, 8, 2, 2, 1], offset: ?>>
    %subview_0 = memref.subview %arg0[%c0, %c0, %c0, %c0, 0] [1, 1, 1, 1, 1] [1, 1, 1, 1, 1] : memref<1x1x4x1x2xbf16> to memref<1x1x1x1x1xbf16, strided<[8, 8, 2, 2, 1], offset: ?>>
    %subview_1 = memref.subview %arg1[%c0, %c0, %c0, %c0, %c0] [1, 1, 1, 8, 2] [1, 1, 1, 1, 1] : memref<1x1x1x32x2xbf16> to memref<1x1x1x8x2xbf16, strided<[64, 64, 64, 2, 1], offset: ?>>
    %0 = vector.shape_cast %arg2 : vector<1x8xf32> to vector<8xf32>
    %1 = x86vector.avx.bcst_to_f32.packed %subview : memref<1x1x1x1x1xbf16, strided<[8, 8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86vector.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x1x1x8x2xbf16, strided<[64, 64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86vector.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1x1x1xbf16, strided<[8, 8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86vector.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x1x1x8x2xbf16, strided<[64, 64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<1x8xf32>
    return %7 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
module {
  func.func @negative_tensor_type(%arg0: tensor<4x1x2xbf16>, %arg1: tensor<1x32x2xbf16>, %arg2: vector<1x8xf32>) -> vector<1x8xf32> {
    %0 = ub.poison : bf16
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %1 = vector.transfer_read %arg0[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : tensor<4x1x2xbf16>, vector<1x1x2xbf16>
    %2 = vector.transfer_read %arg1[%c0, %c8, %c0], %0 {in_bounds = [true, true, true]} : tensor<1x32x2xbf16>, vector<1x8x2xbf16>
    %3 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %1, %2, %arg2 : vector<1x1x2xbf16>, vector<1x8x2xbf16> into vector<1x8xf32>
    return %3 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d3)>
module {
  func.func @negative_no_memref_src(%arg0: vector<1x1x1x2xbf16>, %arg1: vector<1x1x16x2xbf16>, %arg2: vector<1x1x16xf32>) -> vector<1x1x16xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16> into vector<1x1x16xf32>
    return %0 : vector<1x1x16xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
module {
  func.func @negative_non_zero_vnni_offset(%arg0: memref<4x1x2xbf16>, %arg1: memref<1x32x2xbf16>, %arg2: vector<1x8xf32>) -> vector<1x8xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0 = vector.load %arg0[%c0, %c0, %c0] : memref<4x1x2xbf16>, vector<1x1x2xbf16>
    %1 = vector.load %arg1[%c0, %c0, %c1] : memref<1x32x2xbf16>, vector<1x8x2xbf16>
    %2 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %1, %arg2 : vector<1x1x2xbf16>, vector<1x8x2xbf16> into vector<1x8xf32>
    return %2 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d1, d0, d2)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
module {
  func.func @negative_perm_map_not_identity(%arg0: memref<4x1x2xbf16>, %arg1: memref<1x32x2xbf16>, %arg2: vector<1x8xf32>) -> vector<1x8xf32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : bf16
    %1 = vector.transfer_read %arg0[%c0, %c0, %c0], %0 {in_bounds = [true, true, true], permutation_map = #map} : memref<4x1x2xbf16>, vector<1x1x2xbf16>
    %2 = vector.transfer_read %arg1[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : memref<1x32x2xbf16>, vector<1x8x2xbf16>
    %3 = vector.contract {indexing_maps = [#map1, #map2, #map3], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %1, %2, %arg2 : vector<1x1x2xbf16>, vector<1x8x2xbf16> into vector<1x8xf32>
    return %3 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
module {
  func.func @negative_non_unit_stride(%arg0: memref<4x1x2xbf16>, %arg1: memref<1x32x2xbf16>, %arg2: vector<1x8xf32>) -> vector<1x8xf32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : bf16
    %subview = memref.subview %arg1[%c0, %c0, %c0] [1, 16, 2] [1, 1, 2] : memref<1x32x2xbf16> to memref<1x16x2xbf16, strided<[64, 2, 2], offset: ?>>
    %1 = vector.transfer_read %arg0[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : memref<4x1x2xbf16>, vector<1x1x2xbf16>
    %2 = vector.transfer_read %subview[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : memref<1x16x2xbf16, strided<[64, 2, 2], offset: ?>>, vector<1x8x2xbf16>
    %3 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %1, %2, %arg2 : vector<1x1x2xbf16>, vector<1x8x2xbf16> into vector<1x8xf32>
    return %3 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
module {
  func.func @negative_out_of_bound(%arg0: memref<4x1x2xbf16>, %arg1: memref<1x32x2xbf16>, %arg2: vector<1x8xf32>, %arg3: index) -> vector<1x8xf32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : bf16
    %1 = vector.transfer_read %arg0[%c0, %arg3, %c0], %0 {in_bounds = [true, false, true]} : memref<4x1x2xbf16>, vector<1x1x2xbf16>
    %2 = vector.transfer_read %arg1[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : memref<1x32x2xbf16>, vector<1x8x2xbf16>
    %3 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %1, %2, %arg2 : vector<1x1x2xbf16>, vector<1x8x2xbf16> into vector<1x8xf32>
    return %3 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d1, d3, d0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d3, d2, d0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
module {
  func.func @negative_no_dynamic_vnni_offset(%arg0: memref<4x1x2xbf16>, %arg1: memref<1x32x2xbf16>, %arg2: vector<1x8xf32>, %arg3: index) -> vector<1x8xf32> {
    %c0 = arith.constant 0 : index
    %0 = vector.load %arg0[%c0, %c0, %arg3] : memref<4x1x2xbf16>, vector<1x1x2xbf16>
    %1 = vector.load %arg1[%c0, %c0, %c0] : memref<1x32x2xbf16>, vector<1x8x2xbf16>
    %2 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %1, %arg2 : vector<1x1x2xbf16>, vector<1x8x2xbf16> into vector<1x8xf32>
    return %2 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86vector.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

