module {
  func.func @brgemm_to_bf16dp(%arg0: vector<1x1x1x2xbf16>, %arg1: vector<1x1x16x2xbf16>, %arg2: vector<1x16xf32>) -> vector<1x16xf32> {
    %0 = vector.shape_cast %arg2 : vector<1x16xf32> to vector<16xf32>
    %1 = vector.shape_cast %arg1 : vector<1x1x16x2xbf16> to vector<32xbf16>
    %2 = vector.shape_cast %arg0 : vector<1x1x1x2xbf16> to vector<2xbf16>
    %3 = vector.bitcast %2 : vector<2xbf16> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<16xi32>
    %5 = vector.bitcast %4 : vector<16xi32> to vector<32xbf16>
    %6 = x86.avx512.dot %0, %5, %1 : vector<32xbf16> -> vector<16xf32>
    %7 = vector.shape_cast %6 : vector<16xf32> to vector<1x16xf32>
    return %7 : vector<1x16xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_to_bf16dp_bcst_B(%arg0: vector<1x16x1x2xbf16>, %arg1: vector<1x1x1x2xbf16>, %arg2: vector<16x1xf32>) -> vector<16x1xf32> {
    %0 = vector.shape_cast %arg2 : vector<16x1xf32> to vector<16xf32>
    %1 = vector.shape_cast %arg0 : vector<1x16x1x2xbf16> to vector<32xbf16>
    %2 = vector.shape_cast %arg1 : vector<1x1x1x2xbf16> to vector<2xbf16>
    %3 = vector.bitcast %2 : vector<2xbf16> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<16xi32>
    %5 = vector.bitcast %4 : vector<16xi32> to vector<32xbf16>
    %6 = x86.avx512.dot %0, %5, %1 : vector<32xbf16> -> vector<16xf32>
    %7 = vector.shape_cast %6 : vector<16xf32> to vector<16x1xf32>
    return %7 : vector<16x1xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_to_avx10int8dp(%arg0: vector<1x1x1x4xi8>, %arg1: vector<1x1x16x4xi8>, %arg2: vector<1x16xi32>) -> vector<1x16xi32> {
    %0 = vector.shape_cast %arg2 : vector<1x16xi32> to vector<16xi32>
    %1 = vector.shape_cast %arg1 : vector<1x1x16x4xi8> to vector<64xi8>
    %2 = vector.shape_cast %arg0 : vector<1x1x1x4xi8> to vector<4xi8>
    %3 = vector.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<16xi32>
    %5 = vector.bitcast %4 : vector<16xi32> to vector<64xi8>
    %6 = x86.avx10.dot.i8 %0, %5, %1 : vector<64xi8> -> vector<16xi32>
    %7 = vector.shape_cast %6 : vector<16xi32> to vector<1x16xi32>
    return %7 : vector<1x16xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @batch_matmul_avx10int8dp_bcst_B(%arg0: vector<1x16x1x4xi8>, %arg1: vector<1x1x1x4xi8>, %arg2: vector<1x16x1xi32>) -> vector<1x16x1xi32> {
    %0 = vector.shape_cast %arg2 : vector<1x16x1xi32> to vector<16xi32>
    %1 = vector.shape_cast %arg0 : vector<1x16x1x4xi8> to vector<64xi8>
    %2 = vector.shape_cast %arg1 : vector<1x1x1x4xi8> to vector<4xi8>
    %3 = vector.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<16xi32>
    %5 = vector.bitcast %4 : vector<16xi32> to vector<64xi8>
    %6 = x86.avx10.dot.i8 %0, %5, %1 : vector<64xi8> -> vector<16xi32>
    %7 = vector.shape_cast %6 : vector<16xi32> to vector<1x16x1xi32>
    return %7 : vector<1x16x1xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_to_int8dp(%arg0: vector<1x1x1x4xi8>, %arg1: vector<1x1x8x4xi8>, %arg2: vector<1x8xi32>) -> vector<1x8xi32> {
    %0 = vector.shape_cast %arg2 : vector<1x8xi32> to vector<8xi32>
    %1 = vector.shape_cast %arg1 : vector<1x1x8x4xi8> to vector<32xi8>
    %2 = vector.shape_cast %arg0 : vector<1x1x1x4xi8> to vector<4xi8>
    %3 = vector.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<8xi32>
    %5 = vector.bitcast %4 : vector<8xi32> to vector<32xi8>
    %6 = x86.avx.dot.i8 %0, %5, %1 : vector<32xi8> -> vector<8xi32>
    %7 = vector.shape_cast %6 : vector<8xi32> to vector<1x8xi32>
    return %7 : vector<1x8xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @batch_matmul_bf16dp(%arg0: vector<1x1x1x2xbf16>, %arg1: vector<1x1x16x2xbf16>, %arg2: vector<1x1x16xf32>) -> vector<1x1x16xf32> {
    %0 = vector.shape_cast %arg2 : vector<1x1x16xf32> to vector<16xf32>
    %1 = vector.shape_cast %arg1 : vector<1x1x16x2xbf16> to vector<32xbf16>
    %2 = vector.shape_cast %arg0 : vector<1x1x1x2xbf16> to vector<2xbf16>
    %3 = vector.bitcast %2 : vector<2xbf16> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<16xi32>
    %5 = vector.bitcast %4 : vector<16xi32> to vector<32xbf16>
    %6 = x86.avx512.dot %0, %5, %1 : vector<32xbf16> -> vector<16xf32>
    %7 = vector.shape_cast %6 : vector<16xf32> to vector<1x1x16xf32>
    return %7 : vector<1x1x16xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @batch_matmul_int8dp(%arg0: vector<1x1x1x4xi8>, %arg1: vector<1x1x8x4xi8>, %arg2: vector<1x1x8xi32>) -> vector<1x1x8xi32> {
    %0 = vector.shape_cast %arg2 : vector<1x1x8xi32> to vector<8xi32>
    %1 = vector.shape_cast %arg1 : vector<1x1x8x4xi8> to vector<32xi8>
    %2 = vector.shape_cast %arg0 : vector<1x1x1x4xi8> to vector<4xi8>
    %3 = vector.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<8xi32>
    %5 = vector.bitcast %4 : vector<8xi32> to vector<32xi8>
    %6 = x86.avx.dot.i8 %0, %5, %1 : vector<32xi8> -> vector<8xi32>
    %7 = vector.shape_cast %6 : vector<8xi32> to vector<1x1x8xi32>
    return %7 : vector<1x1x8xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @batch_matmul_int8dp_bcst_B(%arg0: vector<1x8x1x4xi8>, %arg1: vector<1x1x1x4xi8>, %arg2: vector<1x8x1xi32>) -> vector<1x8x1xi32> {
    %0 = vector.shape_cast %arg2 : vector<1x8x1xi32> to vector<8xi32>
    %1 = vector.shape_cast %arg0 : vector<1x8x1x4xi8> to vector<32xi8>
    %2 = vector.shape_cast %arg1 : vector<1x1x1x4xi8> to vector<4xi8>
    %3 = vector.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<8xi32>
    %5 = vector.bitcast %4 : vector<8xi32> to vector<32xi8>
    %6 = x86.avx.dot.i8 %0, %5, %1 : vector<32xi8> -> vector<8xi32>
    %7 = vector.shape_cast %6 : vector<8xi32> to vector<1x8x1xi32>
    return %7 : vector<1x8x1xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_outer_product_to_bf16dp(%arg0: vector<1x1x2xbf16>, %arg1: vector<1x16x2xbf16>, %arg2: vector<1x16xf32>) -> vector<1x16xf32> {
    %0 = vector.shape_cast %arg2 : vector<1x16xf32> to vector<16xf32>
    %1 = vector.shape_cast %arg1 : vector<1x16x2xbf16> to vector<32xbf16>
    %2 = vector.shape_cast %arg0 : vector<1x1x2xbf16> to vector<2xbf16>
    %3 = vector.bitcast %2 : vector<2xbf16> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<16xi32>
    %5 = vector.bitcast %4 : vector<16xi32> to vector<32xbf16>
    %6 = x86.avx512.dot %0, %5, %1 : vector<32xbf16> -> vector<16xf32>
    %7 = vector.shape_cast %6 : vector<16xf32> to vector<1x16xf32>
    return %7 : vector<1x16xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_outer_product_to_int8dp(%arg0: vector<1x1x4xi8>, %arg1: vector<1x8x4xi8>, %arg2: vector<1x8xi32>) -> vector<1x8xi32> {
    %0 = vector.shape_cast %arg2 : vector<1x8xi32> to vector<8xi32>
    %1 = vector.shape_cast %arg1 : vector<1x8x4xi8> to vector<32xi8>
    %2 = vector.shape_cast %arg0 : vector<1x1x4xi8> to vector<4xi8>
    %3 = vector.bitcast %2 : vector<4xi8> to vector<1xi32>
    %4 = vector.broadcast %3 : vector<1xi32> to vector<8xi32>
    %5 = vector.bitcast %4 : vector<8xi32> to vector<32xi8>
    %6 = x86.avx.dot.i8 %0, %5, %1 : vector<32xi8> -> vector<8xi32>
    %7 = vector.shape_cast %6 : vector<8xi32> to vector<1x8xi32>
    return %7 : vector<1x8xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_bf16dp_flat_layout(%arg0: memref<4x2xbf16>, %arg1: memref<2x32xbf16>, %arg2: memref<2x32xf32>) -> memref<2x32xf32> {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %0 = ub.poison : bf16
    %1 = ub.poison : f32
    %2 = vector.transfer_read %arg0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x2xbf16>, vector<1x2xbf16>
    %3 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x16xf32>
    %4 = vector.transfer_read %arg2[%c0, %c16], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x16xf32>
    %5 = vector.shape_cast %3 : vector<1x16xf32> to vector<16xf32>
    %6 = vector.shape_cast %4 : vector<1x16xf32> to vector<16xf32>
    %7 = vector.shuffle %5, %6 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
    %8 = vector.shuffle %5, %6 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
    %9 = vector.transfer_read %arg1[%c0, %c0], %0 {in_bounds = [true]} : memref<2x32xbf16>, vector<32xbf16>
    %10 = vector.transfer_read %arg1[%c1, %c0], %0 {in_bounds = [true]} : memref<2x32xbf16>, vector<32xbf16>
    %11 = vector.shuffle %9, %10 [0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59] : vector<32xbf16>, vector<32xbf16>
    %12 = vector.shuffle %9, %10 [4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63] : vector<32xbf16>, vector<32xbf16>
    %13 = vector.shape_cast %2 : vector<1x2xbf16> to vector<2xbf16>
    %14 = vector.bitcast %13 : vector<2xbf16> to vector<1xi32>
    %15 = vector.broadcast %14 : vector<1xi32> to vector<16xi32>
    %16 = vector.bitcast %15 : vector<16xi32> to vector<32xbf16>
    %17 = x86.avx512.dot %7, %16, %11 : vector<32xbf16> -> vector<16xf32>
    %18 = x86.avx512.dot %8, %16, %12 : vector<32xbf16> -> vector<16xf32>
    %19 = vector.shuffle %17, %18 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
    %20 = vector.shuffle %17, %18 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
    %21 = vector.shape_cast %19 : vector<16xf32> to vector<1x16xf32>
    %22 = vector.shape_cast %20 : vector<16xf32> to vector<1x16xf32>
    vector.transfer_write %21, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<1x16xf32>, memref<2x32xf32>
    vector.transfer_write %22, %arg2[%c0, %c16] {in_bounds = [true, true]} : vector<1x16xf32>, memref<2x32xf32>
    return %arg2 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_i8_avx10dp_flat_layout(%arg0: memref<4x4xi8>, %arg1: memref<4x64xi8>, %arg2: memref<4x64xi32>) -> memref<4x64xi32> {
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %0 = ub.poison : i8
    %1 = ub.poison : i32
    %2 = vector.transfer_read %arg0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x4xi8>, vector<1x4xi8>
    %3 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<4x64xi32>, vector<1x16xi32>
    %4 = vector.transfer_read %arg2[%c0, %c16], %1 {in_bounds = [true, true]} : memref<4x64xi32>, vector<1x16xi32>
    %5 = vector.shape_cast %3 : vector<1x16xi32> to vector<16xi32>
    %6 = vector.shape_cast %4 : vector<1x16xi32> to vector<16xi32>
    %7 = vector.shuffle %5, %6 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xi32>, vector<16xi32>
    %8 = vector.shuffle %5, %6 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xi32>, vector<16xi32>
    %9 = vector.transfer_read %arg1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x64xi8>, vector<2x32xi8>
    %10 = vector.shape_cast %9 : vector<2x32xi8> to vector<64xi8>
    %11 = vector.transfer_read %arg1[%c2, %c0], %0 {in_bounds = [true, true]} : memref<4x64xi8>, vector<2x32xi8>
    %12 = vector.shape_cast %11 : vector<2x32xi8> to vector<64xi8>
    %13 = vector.shuffle %10, %12 [0, 32, 64, 96, 1, 33, 65, 97, 2, 34, 66, 98, 3, 35, 67, 99, 8, 40, 72, 104, 9, 41, 73, 105, 10, 42, 74, 106, 11, 43, 75, 107, 16, 48, 80, 112, 17, 49, 81, 113, 18, 50, 82, 114, 19, 51, 83, 115, 24, 56, 88, 120, 25, 57, 89, 121, 26, 58, 90, 122, 27, 59, 91, 123] : vector<64xi8>, vector<64xi8>
    %14 = vector.shuffle %10, %12 [4, 36, 68, 100, 5, 37, 69, 101, 6, 38, 70, 102, 7, 39, 71, 103, 12, 44, 76, 108, 13, 45, 77, 109, 14, 46, 78, 110, 15, 47, 79, 111, 20, 52, 84, 116, 21, 53, 85, 117, 22, 54, 86, 118, 23, 55, 87, 119, 28, 60, 92, 124, 29, 61, 93, 125, 30, 62, 94, 126, 31, 63, 95, 127] : vector<64xi8>, vector<64xi8>
    %15 = vector.shape_cast %2 : vector<1x4xi8> to vector<4xi8>
    %16 = vector.bitcast %15 : vector<4xi8> to vector<1xi32>
    %17 = vector.broadcast %16 : vector<1xi32> to vector<16xi32>
    %18 = vector.bitcast %17 : vector<16xi32> to vector<64xi8>
    %19 = x86.avx10.dot.i8 %7, %18, %13 : vector<64xi8> -> vector<16xi32>
    %20 = x86.avx10.dot.i8 %8, %18, %14 : vector<64xi8> -> vector<16xi32>
    %21 = vector.shuffle %19, %20 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xi32>, vector<16xi32>
    %22 = vector.shuffle %19, %20 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xi32>, vector<16xi32>
    %23 = vector.shape_cast %21 : vector<16xi32> to vector<1x16xi32>
    %24 = vector.shape_cast %22 : vector<16xi32> to vector<1x16xi32>
    vector.transfer_write %23, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<1x16xi32>, memref<4x64xi32>
    vector.transfer_write %24, %arg2[%c0, %c16] {in_bounds = [true, true]} : vector<1x16xi32>, memref<4x64xi32>
    return %arg2 : memref<4x64xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_i8_avx2dp_flat_layout(%arg0: memref<4x4xi8>, %arg1: memref<4x64xi8>, %arg2: memref<4x64xi32>) -> memref<4x64xi32> {
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %0 = ub.poison : i8
    %1 = ub.poison : i32
    %2 = vector.transfer_read %arg0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x4xi8>, vector<1x4xi8>
    %3 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<4x64xi32>, vector<1x8xi32>
    %4 = vector.transfer_read %arg2[%c0, %c8], %1 {in_bounds = [true, true]} : memref<4x64xi32>, vector<1x8xi32>
    %5 = vector.shape_cast %3 : vector<1x8xi32> to vector<8xi32>
    %6 = vector.shape_cast %4 : vector<1x8xi32> to vector<8xi32>
    %7 = vector.shuffle %5, %6 [0, 1, 2, 3, 8, 9, 10, 11] : vector<8xi32>, vector<8xi32>
    %8 = vector.shuffle %5, %6 [4, 5, 6, 7, 12, 13, 14, 15] : vector<8xi32>, vector<8xi32>
    %9 = vector.transfer_read %arg1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x64xi8>, vector<2x16xi8>
    %10 = vector.shape_cast %9 : vector<2x16xi8> to vector<32xi8>
    %11 = vector.transfer_read %arg1[%c2, %c0], %0 {in_bounds = [true, true]} : memref<4x64xi8>, vector<2x16xi8>
    %12 = vector.shape_cast %11 : vector<2x16xi8> to vector<32xi8>
    %13 = vector.shuffle %10, %12 [0, 16, 32, 48, 1, 17, 33, 49, 2, 18, 34, 50, 3, 19, 35, 51, 8, 24, 40, 56, 9, 25, 41, 57, 10, 26, 42, 58, 11, 27, 43, 59] : vector<32xi8>, vector<32xi8>
    %14 = vector.shuffle %10, %12 [4, 20, 36, 52, 5, 21, 37, 53, 6, 22, 38, 54, 7, 23, 39, 55, 12, 28, 44, 60, 13, 29, 45, 61, 14, 30, 46, 62, 15, 31, 47, 63] : vector<32xi8>, vector<32xi8>
    %15 = vector.shape_cast %2 : vector<1x4xi8> to vector<4xi8>
    %16 = vector.bitcast %15 : vector<4xi8> to vector<1xi32>
    %17 = vector.broadcast %16 : vector<1xi32> to vector<8xi32>
    %18 = vector.bitcast %17 : vector<8xi32> to vector<32xi8>
    %19 = x86.avx.dot.i8 %7, %18, %13 : vector<32xi8> -> vector<8xi32>
    %20 = x86.avx.dot.i8 %8, %18, %14 : vector<32xi8> -> vector<8xi32>
    %21 = vector.shuffle %19, %20 [0, 1, 2, 3, 8, 9, 10, 11] : vector<8xi32>, vector<8xi32>
    %22 = vector.shuffle %19, %20 [4, 5, 6, 7, 12, 13, 14, 15] : vector<8xi32>, vector<8xi32>
    %23 = vector.shape_cast %21 : vector<8xi32> to vector<1x8xi32>
    %24 = vector.shape_cast %22 : vector<8xi32> to vector<1x8xi32>
    vector.transfer_write %23, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<1x8xi32>, memref<4x64xi32>
    vector.transfer_write %24, %arg2[%c0, %c8] {in_bounds = [true, true]} : vector<1x8xi32>, memref<4x64xi32>
    return %arg2 : memref<4x64xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_bf16dp_flat_layout_offset_args_and_read_after_vc(%arg0: memref<4x2xbf16>, %arg1: memref<2x32xbf16>, %arg2: memref<2x32xf32>, %arg3: index) -> memref<2x32xf32> {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %0 = ub.poison : bf16
    %1 = ub.poison : f32
    %2 = vector.transfer_read %arg0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x2xbf16>, vector<1x2xbf16>
    %3 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x16xf32>
    %4 = vector.transfer_read %arg2[%c0, %c16], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x16xf32>
    %5 = vector.shape_cast %3 : vector<1x16xf32> to vector<16xf32>
    %6 = vector.shape_cast %4 : vector<1x16xf32> to vector<16xf32>
    %7 = vector.shuffle %5, %6 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
    %8 = vector.shuffle %5, %6 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
    %9 = vector.transfer_read %arg1[%arg3, %c0], %0 {in_bounds = [true]} : memref<2x32xbf16>, vector<32xbf16>
    %10 = arith.addi %arg3, %c1 : index
    %11 = vector.transfer_read %arg1[%10, %c0], %0 {in_bounds = [true]} : memref<2x32xbf16>, vector<32xbf16>
    %12 = vector.shuffle %9, %11 [0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59] : vector<32xbf16>, vector<32xbf16>
    %13 = vector.shuffle %9, %11 [4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63] : vector<32xbf16>, vector<32xbf16>
    %14 = vector.shape_cast %2 : vector<1x2xbf16> to vector<2xbf16>
    %15 = vector.bitcast %14 : vector<2xbf16> to vector<1xi32>
    %16 = vector.broadcast %15 : vector<1xi32> to vector<16xi32>
    %17 = vector.bitcast %16 : vector<16xi32> to vector<32xbf16>
    %18 = x86.avx512.dot %7, %17, %12 : vector<32xbf16> -> vector<16xf32>
    %19 = x86.avx512.dot %8, %17, %13 : vector<32xbf16> -> vector<16xf32>
    %20 = vector.shuffle %18, %19 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
    %21 = vector.shuffle %18, %19 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
    %22 = vector.shape_cast %20 : vector<16xf32> to vector<1x16xf32>
    %23 = vector.shape_cast %21 : vector<16xf32> to vector<1x16xf32>
    vector.transfer_write %22, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<1x16xf32>, memref<2x32xf32>
    vector.transfer_write %23, %arg2[%c0, %c16] {in_bounds = [true, true]} : vector<1x16xf32>, memref<2x32xf32>
    return %arg2 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brmatmul_bf16dp_flat_layout_loop(%arg0: memref<16x64x32xbf16>, %arg1: memref<16x32x64xbf16>, %arg2: memref<64x64xf32>) -> memref<64x64xf32> {
    %0 = ub.poison : f32
    %1 = ub.poison : bf16
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    scf.for %arg3 = %c0 to %c64 step %c1 {
      scf.for %arg4 = %c0 to %c64 step %c32 {
        %subview = memref.subview %arg2[%arg3, %arg4] [1, 32] [1, 1] : memref<64x64xf32> to memref<1x32xf32, strided<[64, 1], offset: ?>>
        %2 = vector.transfer_read %subview[%c0, %c0], %0 {in_bounds = [true, true]} : memref<1x32xf32, strided<[64, 1], offset: ?>>, vector<1x16xf32>
        %3 = vector.transfer_read %subview[%c0, %c16], %0 {in_bounds = [true, true]} : memref<1x32xf32, strided<[64, 1], offset: ?>>, vector<1x16xf32>
        %4 = vector.shape_cast %2 : vector<1x16xf32> to vector<16xf32>
        %5 = vector.shape_cast %3 : vector<1x16xf32> to vector<16xf32>
        %6 = vector.shuffle %4, %5 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
        %7 = vector.shuffle %4, %5 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
        %8 = vector.shape_cast %6 : vector<16xf32> to vector<1x16xf32>
        %9 = vector.shape_cast %7 : vector<16xf32> to vector<1x16xf32>
        %10:2 = scf.for %arg5 = %c0 to %c16 step %c1 iter_args(%arg6 = %8, %arg7 = %9) -> (vector<1x16xf32>, vector<1x16xf32>) {
          %17:2 = scf.for %arg8 = %c0 to %c32 step %c2 iter_args(%arg9 = %arg6, %arg10 = %arg7) -> (vector<1x16xf32>, vector<1x16xf32>) {
            %subview_0 = memref.subview %arg0[%arg5, %arg3, %arg8] [1, 1, 2] [1, 1, 1] : memref<16x64x32xbf16> to memref<1x1x2xbf16, strided<[2048, 32, 1], offset: ?>>
            %subview_1 = memref.subview %arg1[%arg5, %arg8, %arg4] [1, 2, 32] [1, 1, 1] : memref<16x32x64xbf16> to memref<1x2x32xbf16, strided<[2048, 64, 1], offset: ?>>
            %18 = vector.transfer_read %subview_0[%c0, %c0, %c0], %1 {in_bounds = [true, true, true]} : memref<1x1x2xbf16, strided<[2048, 32, 1], offset: ?>>, vector<1x1x2xbf16>
            %19 = vector.transfer_read %subview_1[%c0, %c0, %c0], %1 {in_bounds = [true]} : memref<1x2x32xbf16, strided<[2048, 64, 1], offset: ?>>, vector<32xbf16>
            %20 = vector.transfer_read %subview_1[%c0, %c1, %c0], %1 {in_bounds = [true]} : memref<1x2x32xbf16, strided<[2048, 64, 1], offset: ?>>, vector<32xbf16>
            %21 = vector.shuffle %19, %20 [0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59] : vector<32xbf16>, vector<32xbf16>
            %22 = vector.shuffle %19, %20 [4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63] : vector<32xbf16>, vector<32xbf16>
            %23 = vector.shape_cast %arg9 : vector<1x16xf32> to vector<16xf32>
            %24 = vector.shape_cast %18 : vector<1x1x2xbf16> to vector<2xbf16>
            %25 = vector.bitcast %24 : vector<2xbf16> to vector<1xi32>
            %26 = vector.broadcast %25 : vector<1xi32> to vector<16xi32>
            %27 = vector.bitcast %26 : vector<16xi32> to vector<32xbf16>
            %28 = x86.avx512.dot %23, %27, %21 : vector<32xbf16> -> vector<16xf32>
            %29 = vector.shape_cast %28 : vector<16xf32> to vector<1x16xf32>
            %30 = vector.shape_cast %arg10 : vector<1x16xf32> to vector<16xf32>
            %31 = x86.avx512.dot %30, %27, %22 : vector<32xbf16> -> vector<16xf32>
            %32 = vector.shape_cast %31 : vector<16xf32> to vector<1x16xf32>
            scf.yield %29, %32 : vector<1x16xf32>, vector<1x16xf32>
          }
          scf.yield %17#0, %17#1 : vector<1x16xf32>, vector<1x16xf32>
        }
        %11 = vector.shape_cast %10#0 : vector<1x16xf32> to vector<16xf32>
        %12 = vector.shape_cast %10#1 : vector<1x16xf32> to vector<16xf32>
        %13 = vector.shuffle %11, %12 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
        %14 = vector.shuffle %11, %12 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
        %15 = vector.shape_cast %13 : vector<16xf32> to vector<1x16xf32>
        %16 = vector.shape_cast %14 : vector<16xf32> to vector<1x16xf32>
        vector.transfer_write %16, %subview[%c0, %c16] {in_bounds = [true, true]} : vector<1x16xf32>, memref<1x32xf32, strided<[64, 1], offset: ?>>
        vector.transfer_write %15, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<1x16xf32>, memref<1x32xf32, strided<[64, 1], offset: ?>>
      }
    }
    return %arg2 : memref<64x64xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_bf16dp_flat_layout_B_shuffled(%arg0: memref<4x2xbf16>, %arg1: memref<2x32xbf16>, %arg2: memref<2x32xf32>) -> memref<2x32xf32> {
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %0 = vector.load %arg0[%c0, %c0] : memref<4x2xbf16>, vector<1x2xbf16>
    %1 = vector.load %arg1[%c0, %c0] : memref<2x32xbf16>, vector<2x16xbf16>
    %2 = vector.load %arg1[%c0, %c16] : memref<2x32xbf16>, vector<2x16xbf16>
    %3 = vector.load %arg2[%c0, %c0] : memref<2x32xf32>, vector<1x16xf32>
    %4 = vector.load %arg2[%c0, %c16] : memref<2x32xf32>, vector<1x16xf32>
    %5 = vector.shape_cast %3 : vector<1x16xf32> to vector<16xf32>
    %6 = vector.shape_cast %4 : vector<1x16xf32> to vector<16xf32>
    %7 = vector.shuffle %5, %6 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
    %8 = vector.shuffle %5, %6 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
    %9 = vector.shape_cast %1 : vector<2x16xbf16> to vector<32xbf16>
    %10 = vector.shape_cast %2 : vector<2x16xbf16> to vector<32xbf16>
    %11 = vector.shuffle %9, %10 [0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59] : vector<32xbf16>, vector<32xbf16>
    %12 = vector.shuffle %9, %10 [4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63] : vector<32xbf16>, vector<32xbf16>
    %13 = vector.shape_cast %0 : vector<1x2xbf16> to vector<2xbf16>
    %14 = vector.bitcast %13 : vector<2xbf16> to vector<1xi32>
    %15 = vector.broadcast %14 : vector<1xi32> to vector<16xi32>
    %16 = vector.bitcast %15 : vector<16xi32> to vector<32xbf16>
    %17 = x86.avx512.dot %7, %16, %11 : vector<32xbf16> -> vector<16xf32>
    %18 = x86.avx512.dot %8, %16, %12 : vector<32xbf16> -> vector<16xf32>
    %19 = vector.shuffle %17, %18 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
    %20 = vector.shuffle %17, %18 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
    %21 = vector.shape_cast %19 : vector<16xf32> to vector<1x16xf32>
    %22 = vector.shape_cast %20 : vector<16xf32> to vector<1x16xf32>
    vector.store %21, %arg2[%c0, %c0] : memref<2x32xf32>, vector<1x16xf32>
    vector.store %22, %arg2[%c0, %c16] : memref<2x32xf32>, vector<1x16xf32>
    return %arg2 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_int8_flat_avx10(%arg0: memref<16x64x256xi8>, %arg1: memref<16x256x128xi8>, %arg2: memref<64x128xi32>) -> memref<64x128xi32> {
    %0 = ub.poison : i32
    %1 = ub.poison : i8
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c16 = arith.constant 16 : index
    %c256 = arith.constant 256 : index
    %c2 = arith.constant 2 : index
    %c32 = arith.constant 32 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    scf.for %arg3 = %c0 to %c64 step %c2 {
      scf.for %arg4 = %c0 to %c128 step %c32 {
        %subview = memref.subview %arg2[%arg3, %arg4] [2, 32] [1, 1] : memref<64x128xi32> to memref<2x32xi32, strided<[128, 1], offset: ?>>
        %2 = vector.transfer_read %subview[%c0, %c0], %0 {in_bounds = [true, true]} : memref<2x32xi32, strided<[128, 1], offset: ?>>, vector<1x16xi32>
        %3 = vector.transfer_read %subview[%c0, %c16], %0 {in_bounds = [true, true]} : memref<2x32xi32, strided<[128, 1], offset: ?>>, vector<1x16xi32>
        %4 = vector.shape_cast %2 : vector<1x16xi32> to vector<16xi32>
        %5 = vector.shape_cast %3 : vector<1x16xi32> to vector<16xi32>
        %6 = vector.shuffle %4, %5 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xi32>, vector<16xi32>
        %7 = vector.shuffle %4, %5 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xi32>, vector<16xi32>
        %8 = vector.shape_cast %6 : vector<16xi32> to vector<1x16xi32>
        %9 = vector.shape_cast %7 : vector<16xi32> to vector<1x16xi32>
        %10 = vector.transfer_read %subview[%c1, %c0], %0 {in_bounds = [true, true]} : memref<2x32xi32, strided<[128, 1], offset: ?>>, vector<1x16xi32>
        %11 = vector.transfer_read %subview[%c1, %c16], %0 {in_bounds = [true, true]} : memref<2x32xi32, strided<[128, 1], offset: ?>>, vector<1x16xi32>
        %12 = vector.shape_cast %10 : vector<1x16xi32> to vector<16xi32>
        %13 = vector.shape_cast %11 : vector<1x16xi32> to vector<16xi32>
        %14 = vector.shuffle %12, %13 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xi32>, vector<16xi32>
        %15 = vector.shuffle %12, %13 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xi32>, vector<16xi32>
        %16 = vector.shape_cast %14 : vector<16xi32> to vector<1x16xi32>
        %17 = vector.shape_cast %15 : vector<16xi32> to vector<1x16xi32>
        %18:4 = scf.for %arg5 = %c0 to %c16 step %c1 iter_args(%arg6 = %8, %arg7 = %9, %arg8 = %16, %arg9 = %17) -> (vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>) {
          %31:4 = scf.for %arg10 = %c0 to %c256 step %c4 iter_args(%arg11 = %arg6, %arg12 = %arg7, %arg13 = %arg8, %arg14 = %arg9) -> (vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>) {
            %subview_0 = memref.subview %arg0[%arg5, %arg3, %arg10] [1, 2, 4] [1, 1, 1] : memref<16x64x256xi8> to memref<1x2x4xi8, strided<[16384, 256, 1], offset: ?>>
            %subview_1 = memref.subview %arg1[%arg5, %arg10, %arg4] [1, 4, 32] [1, 1, 1] : memref<16x256x128xi8> to memref<1x4x32xi8, strided<[32768, 128, 1], offset: ?>>
            %32 = vector.transfer_read %subview_0[%c0, %c0, %c0], %1 {in_bounds = [true, true, true]} : memref<1x2x4xi8, strided<[16384, 256, 1], offset: ?>>, vector<1x1x4xi8>
            %33 = vector.transfer_read %subview_0[%c0, %c1, %c0], %1 {in_bounds = [true, true, true]} : memref<1x2x4xi8, strided<[16384, 256, 1], offset: ?>>, vector<1x1x4xi8>
            %34 = vector.transfer_read %subview_1[%c0, %c0, %c0], %1 {in_bounds = [true, true]} : memref<1x4x32xi8, strided<[32768, 128, 1], offset: ?>>, vector<2x32xi8>
            %35 = vector.shape_cast %34 : vector<2x32xi8> to vector<64xi8>
            %36 = vector.transfer_read %subview_1[%c0, %c2, %c0], %1 {in_bounds = [true, true]} : memref<1x4x32xi8, strided<[32768, 128, 1], offset: ?>>, vector<2x32xi8>
            %37 = vector.shape_cast %36 : vector<2x32xi8> to vector<64xi8>
            %38 = vector.shuffle %35, %37 [0, 32, 64, 96, 1, 33, 65, 97, 2, 34, 66, 98, 3, 35, 67, 99, 8, 40, 72, 104, 9, 41, 73, 105, 10, 42, 74, 106, 11, 43, 75, 107, 16, 48, 80, 112, 17, 49, 81, 113, 18, 50, 82, 114, 19, 51, 83, 115, 24, 56, 88, 120, 25, 57, 89, 121, 26, 58, 90, 122, 27, 59, 91, 123] : vector<64xi8>, vector<64xi8>
            %39 = vector.shuffle %35, %37 [4, 36, 68, 100, 5, 37, 69, 101, 6, 38, 70, 102, 7, 39, 71, 103, 12, 44, 76, 108, 13, 45, 77, 109, 14, 46, 78, 110, 15, 47, 79, 111, 20, 52, 84, 116, 21, 53, 85, 117, 22, 54, 86, 118, 23, 55, 87, 119, 28, 60, 92, 124, 29, 61, 93, 125, 30, 62, 94, 126, 31, 63, 95, 127] : vector<64xi8>, vector<64xi8>
            %40 = vector.shape_cast %arg11 : vector<1x16xi32> to vector<16xi32>
            %41 = vector.shape_cast %32 : vector<1x1x4xi8> to vector<4xi8>
            %42 = vector.bitcast %41 : vector<4xi8> to vector<1xi32>
            %43 = vector.broadcast %42 : vector<1xi32> to vector<16xi32>
            %44 = vector.bitcast %43 : vector<16xi32> to vector<64xi8>
            %45 = x86.avx10.dot.i8 %40, %44, %38 : vector<64xi8> -> vector<16xi32>
            %46 = vector.shape_cast %45 : vector<16xi32> to vector<1x16xi32>
            %47 = vector.shape_cast %arg12 : vector<1x16xi32> to vector<16xi32>
            %48 = x86.avx10.dot.i8 %47, %44, %39 : vector<64xi8> -> vector<16xi32>
            %49 = vector.shape_cast %48 : vector<16xi32> to vector<1x16xi32>
            %50 = vector.shape_cast %arg13 : vector<1x16xi32> to vector<16xi32>
            %51 = vector.shape_cast %33 : vector<1x1x4xi8> to vector<4xi8>
            %52 = vector.bitcast %51 : vector<4xi8> to vector<1xi32>
            %53 = vector.broadcast %52 : vector<1xi32> to vector<16xi32>
            %54 = vector.bitcast %53 : vector<16xi32> to vector<64xi8>
            %55 = x86.avx10.dot.i8 %50, %54, %38 : vector<64xi8> -> vector<16xi32>
            %56 = vector.shape_cast %55 : vector<16xi32> to vector<1x16xi32>
            %57 = vector.shape_cast %arg14 : vector<1x16xi32> to vector<16xi32>
            %58 = x86.avx10.dot.i8 %57, %54, %39 : vector<64xi8> -> vector<16xi32>
            %59 = vector.shape_cast %58 : vector<16xi32> to vector<1x16xi32>
            scf.yield %46, %49, %56, %59 : vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>
          }
          scf.yield %31#0, %31#1, %31#2, %31#3 : vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>, vector<1x16xi32>
        }
        %19 = vector.shape_cast %18#2 : vector<1x16xi32> to vector<16xi32>
        %20 = vector.shape_cast %18#3 : vector<1x16xi32> to vector<16xi32>
        %21 = vector.shuffle %19, %20 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xi32>, vector<16xi32>
        %22 = vector.shuffle %19, %20 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xi32>, vector<16xi32>
        %23 = vector.shape_cast %21 : vector<16xi32> to vector<1x16xi32>
        %24 = vector.shape_cast %22 : vector<16xi32> to vector<1x16xi32>
        vector.transfer_write %24, %subview[%c1, %c16] {in_bounds = [true, true]} : vector<1x16xi32>, memref<2x32xi32, strided<[128, 1], offset: ?>>
        vector.transfer_write %23, %subview[%c1, %c0] {in_bounds = [true, true]} : vector<1x16xi32>, memref<2x32xi32, strided<[128, 1], offset: ?>>
        %25 = vector.shape_cast %18#0 : vector<1x16xi32> to vector<16xi32>
        %26 = vector.shape_cast %18#1 : vector<1x16xi32> to vector<16xi32>
        %27 = vector.shuffle %25, %26 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xi32>, vector<16xi32>
        %28 = vector.shuffle %25, %26 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xi32>, vector<16xi32>
        %29 = vector.shape_cast %27 : vector<16xi32> to vector<1x16xi32>
        %30 = vector.shape_cast %28 : vector<16xi32> to vector<1x16xi32>
        vector.transfer_write %30, %subview[%c0, %c16] {in_bounds = [true, true]} : vector<1x16xi32>, memref<2x32xi32, strided<[128, 1], offset: ?>>
        vector.transfer_write %29, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<1x16xi32>, memref<2x32xi32, strided<[128, 1], offset: ?>>
      }
    }
    %alloc = memref.alloc() : memref<64x128xi32>
    memref.copy %arg2, %alloc : memref<64x128xi32> to memref<64x128xi32>
    return %alloc : memref<64x128xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brmatmul_bf16dp_flat_layout_loop_tensor_type(%arg0: tensor<16x64x32xbf16>, %arg1: tensor<16x32x64xbf16>, %arg2: tensor<64x64xf32>) -> tensor<64x64xf32> {
    %0 = ub.poison : f32
    %1 = ub.poison : bf16
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %2 = scf.for %arg3 = %c0 to %c64 step %c2 iter_args(%arg4 = %arg2) -> (tensor<64x64xf32>) {
      %3 = scf.for %arg5 = %c0 to %c64 step %c32 iter_args(%arg6 = %arg4) -> (tensor<64x64xf32>) {
        %extracted_slice = tensor.extract_slice %arg6[%arg3, %arg5] [2, 32] [1, 1] : tensor<64x64xf32> to tensor<2x32xf32>
        %4 = vector.transfer_read %extracted_slice[%c0, %c0], %0 {in_bounds = [true, true]} : tensor<2x32xf32>, vector<1x16xf32>
        %5 = vector.transfer_read %extracted_slice[%c0, %c16], %0 {in_bounds = [true, true]} : tensor<2x32xf32>, vector<1x16xf32>
        %6 = vector.shape_cast %4 : vector<1x16xf32> to vector<16xf32>
        %7 = vector.shape_cast %5 : vector<1x16xf32> to vector<16xf32>
        %8 = vector.shuffle %6, %7 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
        %9 = vector.shuffle %6, %7 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
        %10 = vector.shape_cast %8 : vector<16xf32> to vector<1x16xf32>
        %11 = vector.shape_cast %9 : vector<16xf32> to vector<1x16xf32>
        %12 = vector.transfer_read %extracted_slice[%c1, %c0], %0 {in_bounds = [true, true]} : tensor<2x32xf32>, vector<1x16xf32>
        %13 = vector.transfer_read %extracted_slice[%c1, %c16], %0 {in_bounds = [true, true]} : tensor<2x32xf32>, vector<1x16xf32>
        %14 = vector.shape_cast %12 : vector<1x16xf32> to vector<16xf32>
        %15 = vector.shape_cast %13 : vector<1x16xf32> to vector<16xf32>
        %16 = vector.shuffle %14, %15 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
        %17 = vector.shuffle %14, %15 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
        %18 = vector.shape_cast %16 : vector<16xf32> to vector<1x16xf32>
        %19 = vector.shape_cast %17 : vector<16xf32> to vector<1x16xf32>
        %20:4 = scf.for %arg7 = %c0 to %c16 step %c1 iter_args(%arg8 = %10, %arg9 = %11, %arg10 = %18, %arg11 = %19) -> (vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>) {
          %37:4 = scf.for %arg12 = %c0 to %c32 step %c2 iter_args(%arg13 = %arg8, %arg14 = %arg9, %arg15 = %arg10, %arg16 = %arg11) -> (vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>) {
            %extracted_slice_0 = tensor.extract_slice %arg0[%arg7, %arg3, %arg12] [1, 2, 2] [1, 1, 1] : tensor<16x64x32xbf16> to tensor<1x2x2xbf16>
            %extracted_slice_1 = tensor.extract_slice %arg1[%arg7, %arg12, %arg5] [1, 2, 32] [1, 1, 1] : tensor<16x32x64xbf16> to tensor<1x2x32xbf16>
            %38 = vector.transfer_read %extracted_slice_0[%c0, %c0, %c0], %1 {in_bounds = [true, true, true]} : tensor<1x2x2xbf16>, vector<1x1x2xbf16>
            %39 = vector.transfer_read %extracted_slice_0[%c0, %c1, %c0], %1 {in_bounds = [true, true, true]} : tensor<1x2x2xbf16>, vector<1x1x2xbf16>
            %40 = vector.transfer_read %extracted_slice_1[%c0, %c0, %c0], %1 {in_bounds = [true]} : tensor<1x2x32xbf16>, vector<32xbf16>
            %41 = vector.transfer_read %extracted_slice_1[%c0, %c1, %c0], %1 {in_bounds = [true]} : tensor<1x2x32xbf16>, vector<32xbf16>
            %42 = vector.shuffle %40, %41 [0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59] : vector<32xbf16>, vector<32xbf16>
            %43 = vector.shuffle %40, %41 [4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63] : vector<32xbf16>, vector<32xbf16>
            %44 = vector.shape_cast %arg13 : vector<1x16xf32> to vector<16xf32>
            %45 = vector.shape_cast %38 : vector<1x1x2xbf16> to vector<2xbf16>
            %46 = vector.bitcast %45 : vector<2xbf16> to vector<1xi32>
            %47 = vector.broadcast %46 : vector<1xi32> to vector<16xi32>
            %48 = vector.bitcast %47 : vector<16xi32> to vector<32xbf16>
            %49 = x86.avx512.dot %44, %48, %42 : vector<32xbf16> -> vector<16xf32>
            %50 = vector.shape_cast %49 : vector<16xf32> to vector<1x16xf32>
            %51 = vector.shape_cast %arg14 : vector<1x16xf32> to vector<16xf32>
            %52 = x86.avx512.dot %51, %48, %43 : vector<32xbf16> -> vector<16xf32>
            %53 = vector.shape_cast %52 : vector<16xf32> to vector<1x16xf32>
            %54 = vector.shape_cast %arg15 : vector<1x16xf32> to vector<16xf32>
            %55 = vector.shape_cast %39 : vector<1x1x2xbf16> to vector<2xbf16>
            %56 = vector.bitcast %55 : vector<2xbf16> to vector<1xi32>
            %57 = vector.broadcast %56 : vector<1xi32> to vector<16xi32>
            %58 = vector.bitcast %57 : vector<16xi32> to vector<32xbf16>
            %59 = x86.avx512.dot %54, %58, %42 : vector<32xbf16> -> vector<16xf32>
            %60 = vector.shape_cast %59 : vector<16xf32> to vector<1x16xf32>
            %61 = vector.shape_cast %arg16 : vector<1x16xf32> to vector<16xf32>
            %62 = x86.avx512.dot %61, %58, %43 : vector<32xbf16> -> vector<16xf32>
            %63 = vector.shape_cast %62 : vector<16xf32> to vector<1x16xf32>
            scf.yield %50, %53, %60, %63 : vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>
          }
          scf.yield %37#0, %37#1, %37#2, %37#3 : vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>, vector<1x16xf32>
        }
        %21 = vector.shape_cast %20#2 : vector<1x16xf32> to vector<16xf32>
        %22 = vector.shape_cast %20#3 : vector<1x16xf32> to vector<16xf32>
        %23 = vector.shuffle %21, %22 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
        %24 = vector.shuffle %21, %22 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
        %25 = vector.shape_cast %23 : vector<16xf32> to vector<1x16xf32>
        %26 = vector.shape_cast %24 : vector<16xf32> to vector<1x16xf32>
        %27 = vector.transfer_write %26, %extracted_slice[%c1, %c16] {in_bounds = [true, true]} : vector<1x16xf32>, tensor<2x32xf32>
        %28 = vector.transfer_write %25, %27[%c1, %c0] {in_bounds = [true, true]} : vector<1x16xf32>, tensor<2x32xf32>
        %29 = vector.shape_cast %20#0 : vector<1x16xf32> to vector<16xf32>
        %30 = vector.shape_cast %20#1 : vector<1x16xf32> to vector<16xf32>
        %31 = vector.shuffle %29, %30 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
        %32 = vector.shuffle %29, %30 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
        %33 = vector.shape_cast %31 : vector<16xf32> to vector<1x16xf32>
        %34 = vector.shape_cast %32 : vector<16xf32> to vector<1x16xf32>
        %35 = vector.transfer_write %34, %28[%c0, %c16] {in_bounds = [true, true]} : vector<1x16xf32>, tensor<2x32xf32>
        %36 = vector.transfer_write %33, %35[%c0, %c0] {in_bounds = [true, true]} : vector<1x16xf32>, tensor<2x32xf32>
        %inserted_slice = tensor.insert_slice %36 into %arg6[%arg3, %arg5] [2, 32] [1, 1] : tensor<2x32xf32> into tensor<64x64xf32>
        scf.yield %inserted_slice : tensor<64x64xf32>
      }
      scf.yield %3 : tensor<64x64xf32>
    }
    return %2 : tensor<64x64xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_invalid_vc_kind(%arg0: vector<1x1x2xbf16>, %arg1: vector<1x16x2xbf16>, %arg2: vector<1x16xf32>) -> vector<1x16xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<mul>} %arg0, %arg1, %arg2 : vector<1x1x2xbf16>, vector<1x16x2xbf16> into vector<1x16xf32>
    return %0 : vector<1x16xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
module {
  func.func @negative_false_vnni_bf16(%arg0: vector<1x1x1x4xbf16>, %arg1: vector<1x1x16x4xbf16>, %arg2: vector<1x16xf32>) -> vector<1x16xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x4xbf16>, vector<1x1x16x4xbf16> into vector<1x16xf32>
    return %0 : vector<1x16xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
module {
  func.func @negative_false_vnni_int8(%arg0: vector<1x1x1x2xi8>, %arg1: vector<1x1x8x2xi8>, %arg2: vector<1x8xi32>) -> vector<1x8xi32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x2xi8>, vector<1x1x8x2xi8> into vector<1x8xi32>
    return %0 : vector<1x8xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_batch_dimension(%arg0: vector<3x1x1x2xbf16>, %arg1: vector<3x1x16x2xbf16>, %arg2: vector<3x1x16xf32>) -> vector<3x1x16xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<3x1x1x2xbf16>, vector<3x1x16x2xbf16> into vector<3x1x16xf32>
    return %0 : vector<3x1x16xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d2, d4, d1)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d4, d3, d1)>
#map2 = affine_map<(d0, d1, d2, d3, d4) -> (d2, d3)>
module {
  func.func @negative_brgemm_dimension(%arg0: vector<2x1x1x4xi8>, %arg1: vector<2x1x8x4xi8>, %arg2: vector<1x8xi32>) -> vector<1x8xi32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<2x1x1x4xi8>, vector<2x1x8x4xi8> into vector<1x8xi32>
    return %0 : vector<1x8xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_float_acc_type(%arg0: vector<1x1x1x2xbf16>, %arg1: vector<1x1x16x2xbf16>, %arg2: vector<1x1x16xbf16>) -> vector<1x1x16xbf16> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x2xbf16>, vector<1x1x16x2xbf16> into vector<1x1x16xbf16>
    return %0 : vector<1x1x16xbf16>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_int_acc_type(%arg0: vector<1x1x1x4xi8>, %arg1: vector<1x1x8x4xi8>, %arg2: vector<1x1x8xi8>) -> vector<1x1x8xi8> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x4xi8>, vector<1x1x8x4xi8> into vector<1x1x8xi8>
    return %0 : vector<1x1x8xi8>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_wrong_vnni_blocking_factor_bf16(%arg0: vector<1x1x1x4xbf16>, %arg1: vector<1x1x16x4xbf16>, %arg2: vector<1x1x16xbf16>) -> vector<1x1x16xbf16> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x4xbf16>, vector<1x1x16x4xbf16> into vector<1x1x16xbf16>
    return %0 : vector<1x1x16xbf16>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d3, d2)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d1, d2)>
module {
  func.func @negative_brgemm_not_vnni(%arg0: vector<1x1x1xbf16>, %arg1: vector<1x1x32xbf16>, %arg2: vector<1x32xf32>) -> vector<1x32xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1xbf16>, vector<1x1x32xbf16> into vector<1x32xf32>
    return %0 : vector<1x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_wrong_vector_shape_int8(%arg0: vector<1x1x1x4xi8>, %arg1: vector<1x1x32x4xi8>, %arg2: vector<1x1x32xi32>) -> vector<1x1x32xi32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x4xi8>, vector<1x1x32x4xi8> into vector<1x1x32xi32>
    return %0 : vector<1x1x32xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_wrong_vector_shape_bf16(%arg0: vector<1x1x1x2xbf16>, %arg1: vector<1x1x32x2xbf16>, %arg2: vector<1x1x32xf32>) -> vector<1x1x32xf32> {
    %0 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %arg1, %arg2 : vector<1x1x1x2xbf16>, vector<1x1x32x2xbf16> into vector<1x1x32xf32>
    return %0 : vector<1x1x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_flat_other_dim_is_not_2(%arg0: memref<4x4xbf16>, %arg1: memref<4x32xbf16>, %arg2: memref<2x32xf32>) -> memref<2x32xf32> {
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %0 = ub.poison : bf16
    %1 = ub.poison : f32
    %2 = vector.transfer_read %arg0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x4xbf16>, vector<1x4xbf16>
    %3 = vector.transfer_read %arg1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x32xbf16>, vector<4x16xbf16>
    %4 = vector.transfer_read %arg1[%c0, %c16], %0 {in_bounds = [true, true]} : memref<4x32xbf16>, vector<4x16xbf16>
    %5 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x16xf32>
    %6 = vector.transfer_read %arg2[%c0, %c16], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x16xf32>
    %7 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %3, %5 : vector<1x4xbf16>, vector<4x16xbf16> into vector<1x16xf32>
    %8 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %4, %6 : vector<1x4xbf16>, vector<4x16xbf16> into vector<1x16xf32>
    vector.transfer_write %7, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<1x16xf32>, memref<2x32xf32>
    vector.transfer_write %8, %arg2[%c0, %c16] {in_bounds = [true, true]} : vector<1x16xf32>, memref<2x32xf32>
    return %arg2 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_flat_offset_diff_is_not16(%arg0: memref<4x2xbf16>, %arg1: memref<2x64xbf16>, %arg2: memref<2x32xf32>) -> memref<2x32xf32> {
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %0 = ub.poison : bf16
    %1 = ub.poison : f32
    %2 = vector.transfer_read %arg0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x2xbf16>, vector<1x2xbf16>
    %3 = vector.transfer_read %arg1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<2x64xbf16>, vector<2x16xbf16>
    %4 = vector.transfer_read %arg1[%c0, %c32], %0 {in_bounds = [true, true]} : memref<2x64xbf16>, vector<2x16xbf16>
    %5 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x16xf32>
    %6 = vector.transfer_read %arg2[%c0, %c16], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x16xf32>
    %7 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %3, %5 : vector<1x2xbf16>, vector<2x16xbf16> into vector<1x16xf32>
    %8 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %4, %6 : vector<1x2xbf16>, vector<2x16xbf16> into vector<1x16xf32>
    vector.transfer_write %7, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<1x16xf32>, memref<2x32xf32>
    vector.transfer_write %8, %arg2[%c0, %c16] {in_bounds = [true, true]} : vector<1x16xf32>, memref<2x32xf32>
    return %arg2 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_flat_dynamic_offset(%arg0: memref<4x2xbf16>, %arg1: memref<2x64xbf16>, %arg2: memref<2x32xf32>, %arg3: index) -> memref<2x32xf32> {
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %0 = ub.poison : bf16
    %1 = ub.poison : f32
    %2 = vector.transfer_read %arg0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x2xbf16>, vector<1x2xbf16>
    %3 = vector.transfer_read %arg1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<2x64xbf16>, vector<2x16xbf16>
    %4 = vector.transfer_read %arg1[%c0, %arg3], %0 {in_bounds = [true, true]} : memref<2x64xbf16>, vector<2x16xbf16>
    %5 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x16xf32>
    %6 = vector.transfer_read %arg2[%c0, %c16], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x16xf32>
    %7 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %3, %5 : vector<1x2xbf16>, vector<2x16xbf16> into vector<1x16xf32>
    %8 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %4, %6 : vector<1x2xbf16>, vector<2x16xbf16> into vector<1x16xf32>
    vector.transfer_write %7, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<1x16xf32>, memref<2x32xf32>
    vector.transfer_write %8, %arg2[%c0, %c16] {in_bounds = [true, true]} : vector<1x16xf32>, memref<2x32xf32>
    return %arg2 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_flat_read_after_contract(%arg0: memref<4x2xbf16>, %arg1: memref<2x64xbf16>, %arg2: memref<2x32xf32>) -> memref<2x32xf32> {
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %0 = ub.poison : bf16
    %1 = ub.poison : f32
    %2 = vector.transfer_read %arg0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x2xbf16>, vector<1x2xbf16>
    %3 = vector.transfer_read %arg1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<2x64xbf16>, vector<2x16xbf16>
    %4 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x16xf32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %3, %4 : vector<1x2xbf16>, vector<2x16xbf16> into vector<1x16xf32>
    %6 = vector.transfer_read %arg1[%c0, %c16], %0 {in_bounds = [true, true]} : memref<2x64xbf16>, vector<2x16xbf16>
    %7 = vector.transfer_read %arg2[%c0, %c16], %1 {in_bounds = [true, true]} : memref<2x32xf32>, vector<1x16xf32>
    %8 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %6, %7 : vector<1x2xbf16>, vector<2x16xbf16> into vector<1x16xf32>
    vector.transfer_write %5, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<1x16xf32>, memref<2x32xf32>
    vector.transfer_write %8, %arg2[%c0, %c16] {in_bounds = [true, true]} : vector<1x16xf32>, memref<2x32xf32>
    return %arg2 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_contracts_not_in_order(%arg0: memref<4x2xbf16>, %arg1: memref<2x64xbf16>, %arg2: memref<2x64xf32>) -> memref<2x64xf32> {
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %0 = vector.load %arg0[%c0, %c0] : memref<4x2xbf16>, vector<1x1xbf16>
    %1 = vector.load %arg1[%c0, %c0] : memref<2x64xbf16>, vector<1x16xbf16>
    %2 = vector.load %arg1[%c0, %c32] : memref<2x64xbf16>, vector<1x16xbf16>
    %3 = vector.load %arg2[%c0, %c0] : memref<2x64xf32>, vector<1x16xf32>
    %4 = vector.load %arg2[%c0, %c16] : memref<2x64xf32>, vector<1x16xf32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %2, %4 : vector<1x1xbf16>, vector<1x16xbf16> into vector<1x16xf32>
    %6 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %1, %3 : vector<1x1xbf16>, vector<1x16xbf16> into vector<1x16xf32>
    vector.store %6, %arg2[%c0, %c0] : memref<2x64xf32>, vector<1x16xf32>
    vector.store %5, %arg2[%c0, %c16] : memref<2x64xf32>, vector<1x16xf32>
    return %arg2 : memref<2x64xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_dim_is_32(%arg0: memref<4x2xbf16>, %arg1: memref<2x64xbf16>, %arg2: memref<2x64xf32>) -> memref<2x64xf32> {
    %c0 = arith.constant 0 : index
    %c32 = arith.constant 32 : index
    %0 = vector.load %arg0[%c0, %c0] : memref<4x2xbf16>, vector<1x1xbf16>
    %1 = vector.load %arg1[%c0, %c0] : memref<2x64xbf16>, vector<1x32xbf16>
    %2 = vector.load %arg1[%c0, %c32] : memref<2x64xbf16>, vector<1x32xbf16>
    %3 = vector.load %arg2[%c0, %c0] : memref<2x64xf32>, vector<1x32xf32>
    %4 = vector.load %arg2[%c0, %c32] : memref<2x64xf32>, vector<1x32xf32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %1, %3 : vector<1x1xbf16>, vector<1x32xbf16> into vector<1x32xf32>
    %6 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %2, %4 : vector<1x1xbf16>, vector<1x32xbf16> into vector<1x32xf32>
    vector.store %5, %arg2[%c0, %c0] : memref<2x64xf32>, vector<1x32xf32>
    vector.store %6, %arg2[%c0, %c32] : memref<2x64xf32>, vector<1x32xf32>
    return %arg2 : memref<2x64xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_offset_diff_is_32(%arg0: memref<4x2xbf16>, %arg1: memref<2x64xbf16>, %arg2: memref<2x64xf32>) -> memref<2x64xf32> {
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %0 = vector.load %arg0[%c0, %c0] : memref<4x2xbf16>, vector<1x1xbf16>
    %1 = vector.load %arg1[%c0, %c0] : memref<2x64xbf16>, vector<1x16xbf16>
    %2 = vector.load %arg1[%c0, %c32] : memref<2x64xbf16>, vector<1x16xbf16>
    %3 = vector.load %arg2[%c0, %c0] : memref<2x64xf32>, vector<1x16xf32>
    %4 = vector.load %arg2[%c0, %c16] : memref<2x64xf32>, vector<1x16xf32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %1, %3 : vector<1x1xbf16>, vector<1x16xbf16> into vector<1x16xf32>
    %6 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %2, %4 : vector<1x1xbf16>, vector<1x16xbf16> into vector<1x16xf32>
    vector.store %5, %arg2[%c0, %c0] : memref<2x64xf32>, vector<1x16xf32>
    vector.store %6, %arg2[%c0, %c16] : memref<2x64xf32>, vector<1x16xf32>
    return %arg2 : memref<2x64xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_dynamic_offset(%arg0: memref<4x2xbf16>, %arg1: memref<2x64xbf16>, %arg2: memref<2x64xf32>, %arg3: index) -> memref<2x64xf32> {
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %0 = vector.load %arg0[%c0, %c0] : memref<4x2xbf16>, vector<1x1xbf16>
    %1 = vector.load %arg1[%c0, %c0] : memref<2x64xbf16>, vector<1x16xbf16>
    %2 = vector.load %arg1[%c0, %arg3] : memref<2x64xbf16>, vector<1x16xbf16>
    %3 = vector.load %arg2[%c0, %c0] : memref<2x64xf32>, vector<1x16xf32>
    %4 = vector.load %arg2[%c0, %c16] : memref<2x64xf32>, vector<1x16xf32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %1, %3 : vector<1x1xbf16>, vector<1x16xbf16> into vector<1x16xf32>
    %6 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %0, %2, %4 : vector<1x1xbf16>, vector<1x16xbf16> into vector<1x16xf32>
    vector.store %5, %arg2[%c0, %c0] : memref<2x64xf32>, vector<1x16xf32>
    vector.store %6, %arg2[%c0, %c16] : memref<2x64xf32>, vector<1x16xf32>
    return %arg2 : memref<2x64xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
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
  func.func @negative_i8_avx2dp_flat_layout_offset_diff_16(%arg0: memref<4x4xi8>, %arg1: memref<4x64xi8>, %arg2: memref<4x64xi32>) -> memref<4x64xi32> {
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %0 = ub.poison : i8
    %1 = ub.poison : i32
    %2 = vector.transfer_read %arg0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x4xi8>, vector<1x4xi8>
    %3 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<4x64xi32>, vector<1x8xi32>
    %4 = vector.transfer_read %arg2[%c0, %c16], %1 {in_bounds = [true, true]} : memref<4x64xi32>, vector<1x8xi32>
    %5 = vector.transfer_read %arg1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<4x64xi8>, vector<4x8xi8>
    %6 = vector.transfer_read %arg1[%c0, %c16], %0 {in_bounds = [true, true]} : memref<4x64xi8>, vector<4x8xi8>
    %7 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %5, %3 : vector<1x4xi8>, vector<4x8xi8> into vector<1x8xi32>
    %8 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %6, %4 : vector<1x4xi8>, vector<4x8xi8> into vector<1x8xi32>
    vector.transfer_write %7, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<1x8xi32>, memref<4x64xi32>
    vector.transfer_write %8, %arg2[%c0, %c16] {in_bounds = [true, true]} : vector<1x8xi32>, memref<4x64xi32>
    return %arg2 : memref<4x64xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_packed_type_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

