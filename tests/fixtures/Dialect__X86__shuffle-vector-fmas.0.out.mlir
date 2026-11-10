module {
  func.func @shuffle_fma_with_rhs_as_even.index_to_f32(%arg0: memref<1x1x1xbf16>, %arg1: memref<1x1x1xbf16>, %arg2: memref<1x8x2xbf16>, %arg3: memref<1x1x1xbf16>, %arg4: memref<1x1x1xbf16>, %arg5: memref<1x8x2xbf16>, %arg6: vector<8xf32>) -> vector<8xf32> {
    %0 = x86.avx.bcst_to_f32.packed %arg0 : memref<1x1x1xbf16> -> vector<8xf32>
    %1 = x86.avx.cvt.packed.odd.indexed_to_f32 %arg2 : memref<1x8x2xbf16> -> vector<8xf32>
    %2 = vector.fma %0, %1, %arg6 : vector<8xf32>
    %3 = x86.avx.bcst_to_f32.packed %arg3 : memref<1x1x1xbf16> -> vector<8xf32>
    %4 = x86.avx.cvt.packed.odd.indexed_to_f32 %arg5 : memref<1x8x2xbf16> -> vector<8xf32>
    %5 = vector.fma %3, %4, %arg6 : vector<8xf32>
    %6 = x86.avx.bcst_to_f32.packed %arg4 : memref<1x1x1xbf16> -> vector<8xf32>
    %7 = x86.avx.cvt.packed.even.indexed_to_f32 %arg5 : memref<1x8x2xbf16> -> vector<8xf32>
    %8 = vector.fma %6, %7, %5 : vector<8xf32>
    %9 = x86.avx.bcst_to_f32.packed %arg1 : memref<1x1x1xbf16> -> vector<8xf32>
    %10 = x86.avx.cvt.packed.even.indexed_to_f32 %arg2 : memref<1x8x2xbf16> -> vector<8xf32>
    %11 = vector.fma %9, %10, %2 : vector<8xf32>
    %12 = vector.fma %11, %8, %arg6 : vector<8xf32>
    return %12 : vector<8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.shuffle_vector_fma_ops
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @shuffle_fma_with_lhs_as_even.index_to_f32(%arg0: memref<1x1x1xbf16>, %arg1: memref<1x1x1xbf16>, %arg2: memref<1x8x2xbf16>, %arg3: memref<1x1x1xbf16>, %arg4: memref<1x1x1xbf16>, %arg5: memref<1x8x2xbf16>, %arg6: vector<8xf32>) -> vector<8xf32> {
    %0 = x86.avx.bcst_to_f32.packed %arg0 : memref<1x1x1xbf16> -> vector<8xf32>
    %1 = x86.avx.cvt.packed.odd.indexed_to_f32 %arg2 : memref<1x8x2xbf16> -> vector<8xf32>
    %2 = vector.fma %0, %1, %arg6 : vector<8xf32>
    %3 = x86.avx.bcst_to_f32.packed %arg3 : memref<1x1x1xbf16> -> vector<8xf32>
    %4 = x86.avx.cvt.packed.odd.indexed_to_f32 %arg5 : memref<1x8x2xbf16> -> vector<8xf32>
    %5 = vector.fma %3, %4, %arg6 : vector<8xf32>
    %6 = x86.avx.bcst_to_f32.packed %arg4 : memref<1x1x1xbf16> -> vector<8xf32>
    %7 = x86.avx.cvt.packed.even.indexed_to_f32 %arg5 : memref<1x8x2xbf16> -> vector<8xf32>
    %8 = vector.fma %6, %7, %5 : vector<8xf32>
    %9 = x86.avx.cvt.packed.even.indexed_to_f32 %arg2 : memref<1x8x2xbf16> -> vector<8xf32>
    %10 = x86.avx.bcst_to_f32.packed %arg1 : memref<1x1x1xbf16> -> vector<8xf32>
    %11 = vector.fma %9, %10, %2 : vector<8xf32>
    %12 = vector.fma %11, %8, %arg6 : vector<8xf32>
    return %12 : vector<8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.shuffle_vector_fma_ops
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @shuffle_fma_with_shape_cast(%arg0: memref<1x1x1xbf16>, %arg1: memref<1x1x1xbf16>, %arg2: memref<1x8x2xbf16>, %arg3: memref<1x1x1xbf16>, %arg4: memref<1x1x1xbf16>, %arg5: memref<1x8x2xbf16>, %arg6: vector<8xf32>) -> vector<1x8xf32> {
    %0 = x86.avx.bcst_to_f32.packed %arg0 : memref<1x1x1xbf16> -> vector<8xf32>
    %1 = x86.avx.cvt.packed.odd.indexed_to_f32 %arg2 : memref<1x8x2xbf16> -> vector<8xf32>
    %2 = vector.fma %0, %1, %arg6 : vector<8xf32>
    %3 = x86.avx.bcst_to_f32.packed %arg3 : memref<1x1x1xbf16> -> vector<8xf32>
    %4 = x86.avx.cvt.packed.odd.indexed_to_f32 %arg5 : memref<1x8x2xbf16> -> vector<8xf32>
    %5 = vector.fma %3, %4, %arg6 : vector<8xf32>
    %6 = x86.avx.bcst_to_f32.packed %arg4 : memref<1x1x1xbf16> -> vector<8xf32>
    %7 = x86.avx.cvt.packed.even.indexed_to_f32 %arg5 : memref<1x8x2xbf16> -> vector<8xf32>
    %8 = vector.fma %6, %7, %5 : vector<8xf32>
    %9 = vector.shape_cast %8 : vector<8xf32> to vector<1x8xf32>
    %10 = x86.avx.bcst_to_f32.packed %arg1 : memref<1x1x1xbf16> -> vector<8xf32>
    %11 = x86.avx.cvt.packed.even.indexed_to_f32 %arg2 : memref<1x8x2xbf16> -> vector<8xf32>
    %12 = vector.fma %10, %11, %2 : vector<8xf32>
    %13 = vector.shape_cast %12 : vector<8xf32> to vector<1x8xf32>
    %14 = arith.addf %13, %9 : vector<1x8xf32>
    return %14 : vector<1x8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.shuffle_vector_fma_ops
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @negative_fma_operand_has_multiple_consumer(%arg0: memref<1x1x1xbf16>, %arg1: memref<1x1x1xbf16>, %arg2: memref<1x8x2xbf16>, %arg3: memref<1x1x1xbf16>, %arg4: memref<1x8x2xbf16>, %arg5: vector<8xf32>) -> vector<8xf32> {
    %0 = x86.avx.bcst_to_f32.packed %arg0 : memref<1x1x1xbf16> -> vector<8xf32>
    %1 = x86.avx.cvt.packed.odd.indexed_to_f32 %arg2 : memref<1x8x2xbf16> -> vector<8xf32>
    %2 = vector.fma %0, %1, %arg5 : vector<8xf32>
    %3 = x86.avx.bcst_to_f32.packed %arg1 : memref<1x1x1xbf16> -> vector<8xf32>
    %4 = x86.avx.cvt.packed.even.indexed_to_f32 %arg2 : memref<1x8x2xbf16> -> vector<8xf32>
    %5 = vector.fma %3, %4, %2 : vector<8xf32>
    %6 = x86.avx.cvt.packed.odd.indexed_to_f32 %arg4 : memref<1x8x2xbf16> -> vector<8xf32>
    %7 = vector.fma %3, %6, %arg5 : vector<8xf32>
    %8 = x86.avx.bcst_to_f32.packed %arg3 : memref<1x1x1xbf16> -> vector<8xf32>
    %9 = x86.avx.cvt.packed.even.indexed_to_f32 %arg4 : memref<1x8x2xbf16> -> vector<8xf32>
    %10 = vector.fma %8, %9, %7 : vector<8xf32>
    %11 = vector.fma %5, %10, %arg5 : vector<8xf32>
    return %11 : vector<8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.shuffle_vector_fma_ops
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @negative_fma_has_multiple_consumer(%arg0: memref<1x1x1xbf16>, %arg1: memref<1x1x1xbf16>, %arg2: memref<1x8x2xbf16>, %arg3: memref<1x1x1xbf16>, %arg4: memref<1x1x1xbf16>, %arg5: memref<1x8x2xbf16>, %arg6: vector<8xf32>) -> vector<8xf32> {
    %0 = x86.avx.bcst_to_f32.packed %arg0 : memref<1x1x1xbf16> -> vector<8xf32>
    %1 = x86.avx.cvt.packed.odd.indexed_to_f32 %arg2 : memref<1x8x2xbf16> -> vector<8xf32>
    %2 = vector.fma %0, %1, %arg6 : vector<8xf32>
    %3 = x86.avx.bcst_to_f32.packed %arg1 : memref<1x1x1xbf16> -> vector<8xf32>
    %4 = x86.avx.cvt.packed.even.indexed_to_f32 %arg2 : memref<1x8x2xbf16> -> vector<8xf32>
    %5 = vector.fma %3, %4, %2 : vector<8xf32>
    %6 = x86.avx.bcst_to_f32.packed %arg3 : memref<1x1x1xbf16> -> vector<8xf32>
    %7 = x86.avx.cvt.packed.odd.indexed_to_f32 %arg5 : memref<1x8x2xbf16> -> vector<8xf32>
    %8 = vector.fma %6, %7, %5 : vector<8xf32>
    %9 = x86.avx.bcst_to_f32.packed %arg4 : memref<1x1x1xbf16> -> vector<8xf32>
    %10 = x86.avx.cvt.packed.even.indexed_to_f32 %arg5 : memref<1x8x2xbf16> -> vector<8xf32>
    %11 = vector.fma %9, %10, %8 : vector<8xf32>
    %12 = vector.fma %5, %11, %arg6 : vector<8xf32>
    return %12 : vector<8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.shuffle_vector_fma_ops
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @negative_no_shuffle_outside_block(%arg0: memref<1x1x1xbf16>, %arg1: memref<1x1x1xbf16>, %arg2: memref<1x8x2xbf16>, %arg3: memref<1x1x1xbf16>, %arg4: memref<1x1x1xbf16>, %arg5: memref<1x8x2xbf16>, %arg6: vector<8xf32>, %arg7: i1) -> vector<8xf32> {
    %0 = x86.avx.bcst_to_f32.packed %arg0 : memref<1x1x1xbf16> -> vector<8xf32>
    %1 = x86.avx.cvt.packed.odd.indexed_to_f32 %arg2 : memref<1x8x2xbf16> -> vector<8xf32>
    %2 = vector.fma %0, %1, %arg6 : vector<8xf32>
    %3 = x86.avx.bcst_to_f32.packed %arg1 : memref<1x1x1xbf16> -> vector<8xf32>
    %4 = x86.avx.cvt.packed.even.indexed_to_f32 %arg2 : memref<1x8x2xbf16> -> vector<8xf32>
    %5 = vector.fma %3, %4, %2 : vector<8xf32>
    %6 = scf.if %arg7 -> (vector<8xf32>) {
      %7 = x86.avx.bcst_to_f32.packed %arg3 : memref<1x1x1xbf16> -> vector<8xf32>
      %8 = x86.avx.cvt.packed.odd.indexed_to_f32 %arg5 : memref<1x8x2xbf16> -> vector<8xf32>
      %9 = vector.fma %7, %8, %arg6 : vector<8xf32>
      %10 = x86.avx.bcst_to_f32.packed %arg4 : memref<1x1x1xbf16> -> vector<8xf32>
      %11 = x86.avx.cvt.packed.even.indexed_to_f32 %arg5 : memref<1x8x2xbf16> -> vector<8xf32>
      %12 = vector.fma %10, %11, %9 : vector<8xf32>
      %13 = vector.fma %5, %12, %arg6 : vector<8xf32>
      scf.yield %13 : vector<8xf32>
    } else {
      %7 = x86.avx.bcst_to_f32.packed %arg3 : memref<1x1x1xbf16> -> vector<8xf32>
      %8 = x86.avx.cvt.packed.odd.indexed_to_f32 %arg5 : memref<1x8x2xbf16> -> vector<8xf32>
      %9 = vector.fma %7, %8, %arg6 : vector<8xf32>
      %10 = x86.avx.bcst_to_f32.packed %arg4 : memref<1x1x1xbf16> -> vector<8xf32>
      %11 = x86.avx.cvt.packed.even.indexed_to_f32 %arg5 : memref<1x8x2xbf16> -> vector<8xf32>
      %12 = vector.fma %10, %11, %9 : vector<8xf32>
      %13 = vector.fma %5, %12, %arg6 : vector<8xf32>
      scf.yield %13 : vector<8xf32>
    }
    return %6 : vector<8xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.shuffle_vector_fma_ops
      } : !transform.any_op
      transform.yield 
    }
  }
}

