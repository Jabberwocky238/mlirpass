module {
  func.func @brgemm_to_fma(%arg0: memref<1x4x1x2xbf16>, %arg1: memref<1x1x32x2xbf16>, %arg2: vector<1x8xf32>) -> vector<1x8xf32> {
    %c0 = arith.constant 0 : index
    %subview = memref.subview %arg0[%c0, %c0, %c0, 1] [1, 1, 1, 1] [1, 1, 1, 1] : memref<1x4x1x2xbf16> to memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %subview_0 = memref.subview %arg0[%c0, %c0, %c0, 0] [1, 1, 1, 1] [1, 1, 1, 1] : memref<1x4x1x2xbf16> to memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>>
    %subview_1 = memref.subview %arg1[%c0, %c0, %c0, %c0] [1, 1, 8, 2] [1, 1, 1, 1] : memref<1x1x32x2xbf16> to memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>>
    %0 = vector.shape_cast %arg2 : vector<1x8xf32> to vector<8xf32>
    %1 = x86.avx.bcst_to_f32.packed %subview : memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<1x8xf32>
    return %7 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
    %1 = x86.avx.bcst_to_f32.packed %subview : memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<1x8xf32>
    return %7 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
    %1 = x86.avx.bcst_to_f32.packed %subview : memref<1x1x1x1xbf16, strided<[8, 8, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x8x1x2xbf16, strided<[64, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1x1xbf16, strided<[8, 8, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x8x1x2xbf16, strided<[64, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<8x1xf32>
    return %7 : vector<8x1xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
    %1 = x86.avx.bcst_to_f32.packed %subview : memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1x1xbf16, strided<[8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x1x8x2xbf16, strided<[64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<1x1x8xf32>
    return %7 : vector<1x1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
    %1 = x86.avx.bcst_to_f32.packed %subview : memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<1x8xf32>
    return %7 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_to_fma_flat_layout(%arg0: memref<4x1xbf16>, %arg1: memref<1x32xbf16>, %arg2: memref<2x32xf32>) -> memref<2x32xf32> {
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %0 = ub.poison : f32
    %1 = vector.transfer_read %arg2[%c0, %c0], %0 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x8xf32>
    %2 = vector.transfer_read %arg2[%c0, %c8], %0 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x8xf32>
    %3 = vector.shape_cast %1 : vector<1x8xf32> to vector<8xf32>
    %4 = vector.shape_cast %2 : vector<1x8xf32> to vector<8xf32>
    %5 = vector.shuffle %3, %4 [0, 8, 1, 9, 2, 10, 3, 11] : vector<8xf32>, vector<8xf32>
    %6 = vector.shuffle %3, %4 [4, 12, 5, 13, 6, 14, 7, 15] : vector<8xf32>, vector<8xf32>
    %subview = memref.subview %arg0[%c0, %c0] [1, 1] [1, 1] : memref<4x1xbf16> to memref<1x1xbf16, strided<[1, 1], offset: ?>>
    %subview_0 = memref.subview %arg1[%c0, %c0] [1, 16] [1, 1] : memref<1x32xbf16> to memref<1x16xbf16, strided<[32, 1], offset: ?>>
    %7 = x86.avx.bcst_to_f32.packed %subview : memref<1x1xbf16, strided<[1, 1], offset: ?>> -> vector<8xf32>
    %8 = x86.avx.cvt.packed.even.indexed_to_f32 %subview_0 : memref<1x16xbf16, strided<[32, 1], offset: ?>> -> vector<8xf32>
    %9 = vector.fma %7, %8, %5 : vector<8xf32>
    %10 = x86.avx.cvt.packed.odd.indexed_to_f32 %subview_0 : memref<1x16xbf16, strided<[32, 1], offset: ?>> -> vector<8xf32>
    %11 = vector.fma %7, %10, %6 : vector<8xf32>
    %12 = vector.shuffle %9, %11 [0, 8, 1, 9, 2, 10, 3, 11] : vector<8xf32>, vector<8xf32>
    %13 = vector.shuffle %9, %11 [4, 12, 5, 13, 6, 14, 7, 15] : vector<8xf32>, vector<8xf32>
    %14 = vector.shape_cast %12 : vector<8xf32> to vector<1x8xf32>
    %15 = vector.shape_cast %13 : vector<8xf32> to vector<1x8xf32>
    vector.transfer_write %14, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<1x8xf32>, memref<2x32xf32>
    vector.transfer_write %15, %arg2[%c0, %c8] {in_bounds = [true, true]} : vector<1x8xf32>, memref<2x32xf32>
    return %arg2 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_to_fma_flat_layout_load(%arg0: memref<4x1xbf16>, %arg1: memref<1x32xbf16>, %arg2: memref<2x32xf32>) -> memref<2x32xf32> {
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %0 = vector.load %arg2[%c0, %c0] : memref<2x32xf32>, vector<1x8xf32>
    %1 = vector.load %arg2[%c0, %c8] : memref<2x32xf32>, vector<1x8xf32>
    %2 = vector.shape_cast %0 : vector<1x8xf32> to vector<8xf32>
    %3 = vector.shape_cast %1 : vector<1x8xf32> to vector<8xf32>
    %4 = vector.shuffle %2, %3 [0, 8, 1, 9, 2, 10, 3, 11] : vector<8xf32>, vector<8xf32>
    %5 = vector.shuffle %2, %3 [4, 12, 5, 13, 6, 14, 7, 15] : vector<8xf32>, vector<8xf32>
    %subview = memref.subview %arg0[%c0, %c0] [1, 1] [1, 1] : memref<4x1xbf16> to memref<1x1xbf16, strided<[1, 1], offset: ?>>
    %subview_0 = memref.subview %arg1[%c0, %c0] [1, 16] [1, 1] : memref<1x32xbf16> to memref<1x16xbf16, strided<[32, 1], offset: ?>>
    %6 = x86.avx.bcst_to_f32.packed %subview : memref<1x1xbf16, strided<[1, 1], offset: ?>> -> vector<8xf32>
    %7 = x86.avx.cvt.packed.even.indexed_to_f32 %subview_0 : memref<1x16xbf16, strided<[32, 1], offset: ?>> -> vector<8xf32>
    %8 = vector.fma %6, %7, %4 : vector<8xf32>
    %9 = x86.avx.cvt.packed.odd.indexed_to_f32 %subview_0 : memref<1x16xbf16, strided<[32, 1], offset: ?>> -> vector<8xf32>
    %10 = vector.fma %6, %9, %5 : vector<8xf32>
    %11 = vector.shuffle %8, %10 [0, 8, 1, 9, 2, 10, 3, 11] : vector<8xf32>, vector<8xf32>
    %12 = vector.shuffle %8, %10 [4, 12, 5, 13, 6, 14, 7, 15] : vector<8xf32>, vector<8xf32>
    %13 = vector.shape_cast %11 : vector<8xf32> to vector<1x8xf32>
    %14 = vector.shape_cast %12 : vector<8xf32> to vector<1x8xf32>
    vector.store %13, %arg2[%c0, %c0] : memref<2x32xf32>, vector<1x8xf32>
    vector.store %14, %arg2[%c0, %c8] : memref<2x32xf32>, vector<1x8xf32>
    return %arg2 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_to_fma_flat_layout_loop(%arg0: memref<16x64x32xbf16>, %arg1: memref<16x32x64xbf16>, %arg2: memref<64x64xf32>) -> memref<64x64xf32> {
    %c8 = arith.constant 8 : index
    %0 = ub.poison : f32
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c64 step %c1 {
      scf.for %arg4 = %c0 to %c64 step %c16 {
        %subview = memref.subview %arg2[%arg3, %arg4] [1, 16] [1, 1] : memref<64x64xf32> to memref<1x16xf32, strided<[64, 1], offset: ?>>
        %1 = vector.transfer_read %subview[%c0, %c0], %0 {in_bounds = [true, true]} : memref<1x16xf32, strided<[64, 1], offset: ?>>, vector<1x8xf32>
        %2 = vector.transfer_read %subview[%c0, %c8], %0 {in_bounds = [true, true]} : memref<1x16xf32, strided<[64, 1], offset: ?>>, vector<1x8xf32>
        %3 = vector.shape_cast %1 : vector<1x8xf32> to vector<8xf32>
        %4 = vector.shape_cast %2 : vector<1x8xf32> to vector<8xf32>
        %5 = vector.shuffle %3, %4 [0, 8, 1, 9, 2, 10, 3, 11] : vector<8xf32>, vector<8xf32>
        %6 = vector.shuffle %3, %4 [4, 12, 5, 13, 6, 14, 7, 15] : vector<8xf32>, vector<8xf32>
        %7 = vector.shape_cast %5 : vector<8xf32> to vector<1x8xf32>
        %8 = vector.shape_cast %6 : vector<8xf32> to vector<1x8xf32>
        %9:2 = scf.for %arg5 = %c0 to %c16 step %c1 iter_args(%arg6 = %7, %arg7 = %8) -> (vector<1x8xf32>, vector<1x8xf32>) {
          %16:2 = scf.for %arg8 = %c0 to %c32 step %c1 iter_args(%arg9 = %arg6, %arg10 = %arg7) -> (vector<1x8xf32>, vector<1x8xf32>) {
            %subview_0 = memref.subview %arg0[%arg5, %arg3, %arg8] [1, 1, 1] [1, 1, 1] : memref<16x64x32xbf16> to memref<1x1x1xbf16, strided<[2048, 32, 1], offset: ?>>
            %subview_1 = memref.subview %arg1[%arg5, %arg8, %arg4] [1, 1, 16] [1, 1, 1] : memref<16x32x64xbf16> to memref<1x1x16xbf16, strided<[2048, 64, 1], offset: ?>>
            %17 = vector.shape_cast %arg9 : vector<1x8xf32> to vector<8xf32>
            %18 = x86.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1xbf16, strided<[2048, 32, 1], offset: ?>> -> vector<8xf32>
            %19 = x86.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x1x16xbf16, strided<[2048, 64, 1], offset: ?>> -> vector<8xf32>
            %20 = vector.fma %18, %19, %17 : vector<8xf32>
            %21 = vector.shape_cast %20 : vector<8xf32> to vector<1x8xf32>
            %22 = vector.shape_cast %arg10 : vector<1x8xf32> to vector<8xf32>
            %23 = x86.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x1x16xbf16, strided<[2048, 64, 1], offset: ?>> -> vector<8xf32>
            %24 = vector.fma %18, %23, %22 : vector<8xf32>
            %25 = vector.shape_cast %24 : vector<8xf32> to vector<1x8xf32>
            scf.yield %21, %25 : vector<1x8xf32>, vector<1x8xf32>
          }
          scf.yield %16#0, %16#1 : vector<1x8xf32>, vector<1x8xf32>
        }
        %10 = vector.shape_cast %9#0 : vector<1x8xf32> to vector<8xf32>
        %11 = vector.shape_cast %9#1 : vector<1x8xf32> to vector<8xf32>
        %12 = vector.shuffle %10, %11 [0, 8, 1, 9, 2, 10, 3, 11] : vector<8xf32>, vector<8xf32>
        %13 = vector.shuffle %10, %11 [4, 12, 5, 13, 6, 14, 7, 15] : vector<8xf32>, vector<8xf32>
        %14 = vector.shape_cast %12 : vector<8xf32> to vector<1x8xf32>
        %15 = vector.shape_cast %13 : vector<8xf32> to vector<1x8xf32>
        vector.transfer_write %15, %subview[%c0, %c8] {in_bounds = [true, true]} : vector<1x8xf32>, memref<1x16xf32, strided<[64, 1], offset: ?>>
        vector.transfer_write %14, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<1x8xf32>, memref<1x16xf32, strided<[64, 1], offset: ?>>
      }
    }
    return %arg2 : memref<64x64xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_to_fma_flat_layout_bcstB(%arg0: memref<32x1xbf16>, %arg1: memref<1x4xbf16>, %arg2: memref<32x4xf32>) -> memref<32x4xf32> {
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %0 = ub.poison : f32
    %1 = vector.transfer_read %arg2[%c0, %c0], %0 {in_bounds = [true, true]} : memref<32x4xf32>, vector<8x1xf32>
    %2 = vector.transfer_read %arg2[%c8, %c0], %0 {in_bounds = [true, true]} : memref<32x4xf32>, vector<8x1xf32>
    %3 = vector.shape_cast %1 : vector<8x1xf32> to vector<8xf32>
    %4 = vector.shape_cast %2 : vector<8x1xf32> to vector<8xf32>
    %5 = vector.shuffle %3, %4 [0, 8, 1, 9, 2, 10, 3, 11] : vector<8xf32>, vector<8xf32>
    %6 = vector.shuffle %3, %4 [4, 12, 5, 13, 6, 14, 7, 15] : vector<8xf32>, vector<8xf32>
    %subview = memref.subview %arg1[%c0, %c0] [1, 1] [1, 1] : memref<1x4xbf16> to memref<1x1xbf16, strided<[4, 1], offset: ?>>
    %subview_0 = memref.subview %arg0[%c0, %c0] [16, 1] [1, 1] : memref<32x1xbf16> to memref<16x1xbf16, strided<[1, 1], offset: ?>>
    %7 = x86.avx.bcst_to_f32.packed %subview : memref<1x1xbf16, strided<[4, 1], offset: ?>> -> vector<8xf32>
    %8 = x86.avx.cvt.packed.even.indexed_to_f32 %subview_0 : memref<16x1xbf16, strided<[1, 1], offset: ?>> -> vector<8xf32>
    %9 = vector.fma %7, %8, %5 : vector<8xf32>
    %10 = x86.avx.cvt.packed.odd.indexed_to_f32 %subview_0 : memref<16x1xbf16, strided<[1, 1], offset: ?>> -> vector<8xf32>
    %11 = vector.fma %7, %10, %6 : vector<8xf32>
    %12 = vector.shuffle %9, %11 [0, 8, 1, 9, 2, 10, 3, 11] : vector<8xf32>, vector<8xf32>
    %13 = vector.shuffle %9, %11 [4, 12, 5, 13, 6, 14, 7, 15] : vector<8xf32>, vector<8xf32>
    %14 = vector.shape_cast %12 : vector<8xf32> to vector<8x1xf32>
    %15 = vector.shape_cast %13 : vector<8xf32> to vector<8x1xf32>
    vector.transfer_write %14, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<8x1xf32>, memref<32x4xf32>
    vector.transfer_write %15, %arg2[%c8, %c0] {in_bounds = [true, true]} : vector<8x1xf32>, memref<32x4xf32>
    return %arg2 : memref<32x4xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
    %1 = x86.avx.bcst_to_f32.packed %subview : memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1xbf16, strided<[2, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x8x2xbf16, strided<[64, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<1x8xf32>
    return %7 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
    %1 = x86.avx.bcst_to_f32.packed %subview : memref<1x1x1xbf16, strided<[8, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<8x1x2xbf16, strided<[2, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1xbf16, strided<[8, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<8x1x2xbf16, strided<[2, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<8x1xf32>
    return %7 : vector<8x1xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
    %1 = x86.avx.bcst_to_f32.packed %subview : memref<1x1x1x1x1xbf16, strided<[8, 8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %2 = x86.avx.cvt.packed.odd.indexed_to_f32 %subview_1 : memref<1x1x1x8x2xbf16, strided<[64, 64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %3 = vector.fma %1, %2, %0 : vector<8xf32>
    %4 = x86.avx.bcst_to_f32.packed %subview_0 : memref<1x1x1x1x1xbf16, strided<[8, 8, 2, 2, 1], offset: ?>> -> vector<8xf32>
    %5 = x86.avx.cvt.packed.even.indexed_to_f32 %subview_1 : memref<1x1x1x8x2xbf16, strided<[64, 64, 64, 2, 1], offset: ?>> -> vector<8xf32>
    %6 = vector.fma %4, %5, %3 : vector<8xf32>
    %7 = vector.shape_cast %6 : vector<8xf32> to vector<1x8xf32>
    return %7 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @negative_multiple_vc_users_flat(%arg0: memref<4x1xbf16>, %arg1: memref<1x32xbf16>, %arg2: memref<2x32xf32>) -> memref<2x32xf32> {
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %c16 = arith.constant 16 : index
    %0 = vector.load %arg0[%c0, %c0] : memref<4x1xbf16>, vector<1x1xbf16>
    %1 = vector.load %arg1[%c0, %c0] : memref<1x32xbf16>, vector<1x8xbf16>
    %2 = vector.load %arg1[%c0, %c8] : memref<1x32xbf16>, vector<1x8xbf16>
    %3 = vector.load %arg2[%c0, %c0] : memref<2x32xf32>, vector<1x8xf32>
    %4 = vector.load %arg2[%c0, %c8] : memref<2x32xf32>, vector<1x8xf32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %1, %3 : vector<1x1xbf16>, vector<1x8xbf16> into vector<1x8xf32>
    %6 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %2, %4 : vector<1x1xbf16>, vector<1x8xbf16> into vector<1x8xf32>
    vector.store %5, %arg2[%c0, %c0] : memref<2x32xf32>, vector<1x8xf32>
    vector.store %6, %arg2[%c0, %c8] : memref<2x32xf32>, vector<1x8xf32>
    %7 = arith.addf %5, %6 : vector<1x8xf32>
    vector.store %7, %arg2[%c0, %c16] : memref<2x32xf32>, vector<1x8xf32>
    return %arg2 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @negative_offset_diff_is_not_8(%arg0: memref<4x1xbf16>, %arg1: memref<1x32xbf16>, %arg2: memref<2x32xf32>) -> memref<2x32xf32> {
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %0 = vector.load %arg0[%c0, %c0] : memref<4x1xbf16>, vector<1x1xbf16>
    %1 = vector.load %arg1[%c0, %c0] : memref<1x32xbf16>, vector<1x8xbf16>
    %2 = vector.load %arg1[%c0, %c16] : memref<1x32xbf16>, vector<1x8xbf16>
    %3 = vector.load %arg2[%c0, %c0] : memref<2x32xf32>, vector<1x8xf32>
    %4 = vector.load %arg2[%c0, %c16] : memref<2x32xf32>, vector<1x8xf32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %1, %3 : vector<1x1xbf16>, vector<1x8xbf16> into vector<1x8xf32>
    %6 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %2, %4 : vector<1x1xbf16>, vector<1x8xbf16> into vector<1x8xf32>
    vector.store %5, %arg2[%c0, %c0] : memref<2x32xf32>, vector<1x8xf32>
    vector.store %6, %arg2[%c0, %c16] : memref<2x32xf32>, vector<1x8xf32>
    return %arg2 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @negative_vector_contracts_not_in_order(%arg0: memref<4x1xbf16>, %arg1: memref<1x32xbf16>, %arg2: memref<2x32xf32>) -> memref<2x32xf32> {
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %0 = ub.poison : bf16
    %1 = ub.poison : f32
    %2 = vector.transfer_read %arg0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x1xbf16>, vector<1x1xbf16>
    %3 = vector.transfer_read %arg1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<1x32xbf16>, vector<1x8xbf16>
    %4 = vector.transfer_read %arg1[%c0, %c8], %0 {in_bounds = [true, true]} : memref<1x32xbf16>, vector<1x8xbf16>
    %5 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x8xf32>
    %6 = vector.transfer_read %arg2[%c0, %c8], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x8xf32>
    %7 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %4, %6 : vector<1x1xbf16>, vector<1x8xbf16> into vector<1x8xf32>
    %8 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %3, %5 : vector<1x1xbf16>, vector<1x8xbf16> into vector<1x8xf32>
    vector.transfer_write %8, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<1x8xf32>, memref<2x32xf32>
    vector.transfer_write %7, %arg2[%c0, %c8] {in_bounds = [true, true]} : vector<1x8xf32>, memref<2x32xf32>
    return %arg2 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @negative_flat_layout_dynamic_index(%arg0: memref<32x1xbf16>, %arg1: memref<1x4xbf16>, %arg2: memref<32x4xf32>, %arg3: index) -> memref<32x4xf32> {
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %0 = ub.poison : bf16
    %1 = ub.poison : f32
    %2 = vector.transfer_read %arg0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<32x1xbf16>, vector<8x1xbf16>
    %3 = vector.transfer_read %arg0[%arg3, %c0], %0 {in_bounds = [true, true]} : memref<32x1xbf16>, vector<8x1xbf16>
    %4 = vector.transfer_read %arg1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<1x4xbf16>, vector<1x1xbf16>
    %5 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<32x4xf32>, vector<8x1xf32>
    %6 = vector.transfer_read %arg2[%c8, %c0], %1 {in_bounds = [true, true]} : memref<32x4xf32>, vector<8x1xf32>
    %7 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %4, %5 : vector<8x1xbf16>, vector<1x1xbf16> into vector<8x1xf32>
    %8 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %3, %4, %6 : vector<8x1xbf16>, vector<1x1xbf16> into vector<8x1xf32>
    vector.transfer_write %7, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<8x1xf32>, memref<32x4xf32>
    vector.transfer_write %8, %arg2[%c8, %c0] {in_bounds = [true, true]} : vector<8x1xf32>, memref<32x4xf32>
    return %arg2 : memref<32x4xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1)>
module {
  func.func @negative_non_unit_K_dim(%arg0: memref<32x2xbf16>, %arg1: memref<2x4xbf16>, %arg2: memref<32x4xf32>) -> memref<32x4xf32> {
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %0 = ub.poison : bf16
    %1 = ub.poison : f32
    %2 = vector.transfer_read %arg0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<32x2xbf16>, vector<8x2xbf16>
    %3 = vector.transfer_read %arg0[%c8, %c0], %0 {in_bounds = [true, true]} : memref<32x2xbf16>, vector<8x2xbf16>
    %4 = vector.transfer_read %arg1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<2x4xbf16>, vector<2x1xbf16>
    %5 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<32x4xf32>, vector<8x1xf32>
    %6 = vector.transfer_read %arg2[%c8, %c0], %1 {in_bounds = [true, true]} : memref<32x4xf32>, vector<8x1xf32>
    %7 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %4, %5 : vector<8x2xbf16>, vector<2x1xbf16> into vector<8x1xf32>
    %8 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %3, %4, %6 : vector<8x2xbf16>, vector<2x1xbf16> into vector<8x1xf32>
    vector.transfer_write %7, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<8x1xf32>, memref<32x4xf32>
    vector.transfer_write %8, %arg2[%c8, %c0] {in_bounds = [true, true]} : vector<8x1xf32>, memref<32x4xf32>
    return %arg2 : memref<32x4xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
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
        transform.apply_patterns.x86.vector_contract_bf16_to_fma
      } : !transform.any_op
      transform.yield 
    }
  }
}

