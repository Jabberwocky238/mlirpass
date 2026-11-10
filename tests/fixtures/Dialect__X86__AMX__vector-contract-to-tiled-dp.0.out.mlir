module {
  func.func @brgemm_int8(%arg0: memref<1x32x16x4xi8>, %arg1: memref<1x16x32x4xi8>, %arg2: memref<32x32xi32>) -> memref<32x32xi32> {
    %0 = ub.poison : i32
    %c0 = arith.constant 0 : index
    %collapse_shape = memref.collapse_shape %arg0 [[0], [1], [2, 3]] : memref<1x32x16x4xi8> into memref<1x32x64xi8>
    %collapse_shape_0 = memref.collapse_shape %arg1 [[0], [1], [2, 3]] : memref<1x16x32x4xi8> into memref<1x16x128xi8>
    %1 = x86.amx.tile_load %collapse_shape[%c0, %c0, %c0] : memref<1x32x64xi8> into !x86.amx.tile<16x64xi8>
    %2 = x86.amx.tile_load %collapse_shape_0[%c0, %c0, %c0] : memref<1x16x128xi8> into !x86.amx.tile<16x64xi8>
    %3 = x86.amx.tile_load %arg2[%c0, %c0] : memref<32x32xi32> into !x86.amx.tile<16x16xi32>
    %4 = x86.amx.tile_muli %1, %2, %3 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
    %alloca = memref.alloca() : memref<16x16xi32>
    x86.amx.tile_store %alloca[%c0, %c0], %4 : memref<16x16xi32>, !x86.amx.tile<16x16xi32>
    %5 = vector.transfer_read %alloca[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x16xi32>, vector<16x16xi32>
    vector.transfer_write %5, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<32x32xi32>
    return %arg2 : memref<32x32xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_int8(%arg0: memref<32x16x4xi8>, %arg1: memref<16x32x4xi8>, %arg2: memref<32x32xi32>) -> memref<32x32xi32> {
    %0 = ub.poison : i32
    %c0 = arith.constant 0 : index
    %collapse_shape = memref.collapse_shape %arg0 [[0], [1, 2]] : memref<32x16x4xi8> into memref<32x64xi8>
    %collapse_shape_0 = memref.collapse_shape %arg1 [[0], [1, 2]] : memref<16x32x4xi8> into memref<16x128xi8>
    %1 = x86.amx.tile_load %collapse_shape[%c0, %c0] : memref<32x64xi8> into !x86.amx.tile<16x64xi8>
    %2 = x86.amx.tile_load %collapse_shape_0[%c0, %c0] : memref<16x128xi8> into !x86.amx.tile<16x64xi8>
    %3 = x86.amx.tile_load %arg2[%c0, %c0] : memref<32x32xi32> into !x86.amx.tile<16x16xi32>
    %4 = x86.amx.tile_muli %1, %2, %3 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
    %alloca = memref.alloca() : memref<16x16xi32>
    x86.amx.tile_store %alloca[%c0, %c0], %4 : memref<16x16xi32>, !x86.amx.tile<16x16xi32>
    %5 = vector.transfer_read %alloca[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x16xi32>, vector<16x16xi32>
    vector.transfer_write %5, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<32x32xi32>
    return %arg2 : memref<32x32xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_bf16(%arg0: memref<1x32x16x2xbf16>, %arg1: memref<1x16x32x2xbf16>, %arg2: memref<32x32xf32>) -> memref<32x32xf32> {
    %0 = ub.poison : f32
    %c0 = arith.constant 0 : index
    %collapse_shape = memref.collapse_shape %arg0 [[0], [1], [2, 3]] : memref<1x32x16x2xbf16> into memref<1x32x32xbf16>
    %collapse_shape_0 = memref.collapse_shape %arg1 [[0], [1], [2, 3]] : memref<1x16x32x2xbf16> into memref<1x16x64xbf16>
    %1 = x86.amx.tile_load %collapse_shape[%c0, %c0, %c0] : memref<1x32x32xbf16> into !x86.amx.tile<16x32xbf16>
    %2 = x86.amx.tile_load %collapse_shape_0[%c0, %c0, %c0] : memref<1x16x64xbf16> into !x86.amx.tile<16x32xbf16>
    %3 = x86.amx.tile_load %arg2[%c0, %c0] : memref<32x32xf32> into !x86.amx.tile<16x16xf32>
    %4 = x86.amx.tile_mulf %1, %2, %3 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
    %alloca = memref.alloca() : memref<16x16xf32>
    x86.amx.tile_store %alloca[%c0, %c0], %4 : memref<16x16xf32>, !x86.amx.tile<16x16xf32>
    %5 = vector.transfer_read %alloca[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x16xf32>, vector<16x16xf32>
    vector.transfer_write %5, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32>
    return %arg2 : memref<32x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @batch_matmul_bf16(%arg0: memref<1x32x16x2xbf16>, %arg1: memref<1x16x32x2xbf16>, %arg2: memref<1x32x32xf32>) -> memref<1x32x32xf32> {
    %0 = ub.poison : f32
    %c0 = arith.constant 0 : index
    %collapse_shape = memref.collapse_shape %arg0 [[0], [1], [2, 3]] : memref<1x32x16x2xbf16> into memref<1x32x32xbf16>
    %collapse_shape_0 = memref.collapse_shape %arg1 [[0], [1], [2, 3]] : memref<1x16x32x2xbf16> into memref<1x16x64xbf16>
    %1 = x86.amx.tile_load %collapse_shape[%c0, %c0, %c0] : memref<1x32x32xbf16> into !x86.amx.tile<16x32xbf16>
    %2 = x86.amx.tile_load %collapse_shape_0[%c0, %c0, %c0] : memref<1x16x64xbf16> into !x86.amx.tile<16x32xbf16>
    %3 = x86.amx.tile_load %arg2[%c0, %c0, %c0] : memref<1x32x32xf32> into !x86.amx.tile<16x16xf32>
    %4 = x86.amx.tile_mulf %1, %2, %3 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
    %alloca = memref.alloca() : memref<16x16xf32>
    x86.amx.tile_store %alloca[%c0, %c0], %4 : memref<16x16xf32>, !x86.amx.tile<16x16xf32>
    %5 = vector.transfer_read %alloca[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x16xf32>, vector<16x16xf32>
    %6 = vector.shape_cast %5 : vector<16x16xf32> to vector<1x16x16xf32>
    vector.transfer_write %6, %arg2[%c0, %c0, %c0] {in_bounds = [true, true, true]} : vector<1x16x16xf32>, memref<1x32x32xf32>
    return %arg2 : memref<1x32x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_f8E5M2(%arg0: memref<1x32x16x4xf8E5M2>, %arg1: memref<1x16x32x4xf8E5M2>, %arg2: memref<32x32xf32>) -> memref<32x32xf32> {
    %0 = ub.poison : f32
    %c0 = arith.constant 0 : index
    %collapse_shape = memref.collapse_shape %arg0 [[0], [1], [2, 3]] : memref<1x32x16x4xf8E5M2> into memref<1x32x64xf8E5M2>
    %collapse_shape_0 = memref.collapse_shape %arg1 [[0], [1], [2, 3]] : memref<1x16x32x4xf8E5M2> into memref<1x16x128xf8E5M2>
    %1 = x86.amx.tile_load %collapse_shape[%c0, %c0, %c0] : memref<1x32x64xf8E5M2> into !x86.amx.tile<16x64xf8E5M2>
    %2 = x86.amx.tile_load %collapse_shape_0[%c0, %c0, %c0] : memref<1x16x128xf8E5M2> into !x86.amx.tile<16x64xf8E5M2>
    %3 = x86.amx.tile_load %arg2[%c0, %c0] : memref<32x32xf32> into !x86.amx.tile<16x16xf32>
    %4 = x86.amx.tile_mulf %1, %2, %3 : !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>
    %alloca = memref.alloca() : memref<16x16xf32>
    x86.amx.tile_store %alloca[%c0, %c0], %4 : memref<16x16xf32>, !x86.amx.tile<16x16xf32>
    %5 = vector.transfer_read %alloca[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x16xf32>, vector<16x16xf32>
    vector.transfer_write %5, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32>
    return %arg2 : memref<32x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @online_packing_int8(%arg0: memref<32x64xi8>, %arg1: memref<64x32xi8>, %arg2: memref<32x32xi32>) -> memref<32x32xi32> {
    %0 = ub.poison : i32
    %c32 = arith.constant 32 : index
    %c2 = arith.constant 2 : index
    %c64 = arith.constant 64 : index
    %c4 = arith.constant 4 : index
    %cst = arith.constant dense<13> : vector<16x16xi32>
    %c0 = arith.constant 0 : index
    %1 = x86.amx.tile_load %arg0[%c0, %c0] : memref<32x64xi8> into !x86.amx.tile<16x64xi8>
    %subview = memref.subview %arg1[%c0, %c0] [64, 16] [1, 1] : memref<64x32xi8> to memref<64x16xi8, strided<[32, 1], offset: ?>>
    %alloca = memref.alloca() : memref<16x64xi8>
    scf.for %arg3 = %c0 to %c64 step %c4 {
      %7 = arith.addi %arg3, %c2 : index
      %8 = vector.load %subview[%arg3, %c0] : memref<64x16xi8, strided<[32, 1], offset: ?>>, vector<32xi8>
      %9 = vector.load %subview[%7, %c0] : memref<64x16xi8, strided<[32, 1], offset: ?>>, vector<32xi8>
      %10 = vector.shuffle %8, %9 [0, 16, 32, 48, 1, 17, 33, 49, 2, 18, 34, 50, 3, 19, 35, 51, 4, 20, 36, 52, 5, 21, 37, 53, 6, 22, 38, 54, 7, 23, 39, 55] : vector<32xi8>, vector<32xi8>
      %11 = vector.shuffle %8, %9 [8, 24, 40, 56, 9, 25, 41, 57, 10, 26, 42, 58, 11, 27, 43, 59, 12, 28, 44, 60, 13, 29, 45, 61, 14, 30, 46, 62, 15, 31, 47, 63] : vector<32xi8>, vector<32xi8>
      %12 = arith.divui %arg3, %c4 : index
      vector.store %10, %alloca[%12, %c0] : memref<16x64xi8>, vector<32xi8>
      vector.store %11, %alloca[%12, %c32] : memref<16x64xi8>, vector<32xi8>
    }
    %2 = x86.amx.tile_load %alloca[%c0, %c0] : memref<16x64xi8> into !x86.amx.tile<16x64xi8>
    %3 = x86.amx.tile_load %arg2[%c0, %c0] : memref<32x32xi32> into !x86.amx.tile<16x16xi32>
    %4 = x86.amx.tile_muli %1, %2, %3 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
    %alloca_0 = memref.alloca() : memref<16x16xi32>
    x86.amx.tile_store %alloca_0[%c0, %c0], %4 : memref<16x16xi32>, !x86.amx.tile<16x16xi32>
    %5 = vector.transfer_read %alloca_0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x16xi32>, vector<16x16xi32>
    %6 = arith.addi %5, %cst : vector<16x16xi32>
    vector.transfer_write %6, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<32x32xi32>
    return %arg2 : memref<32x32xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @online_packing_bf16(%arg0: memref<1x32x32xbf16>, %arg1: memref<1x32x32xbf16>, %arg2: memref<32x32xf32>) -> memref<32x32xf32> {
    %0 = ub.poison : f32
    %c16 = arith.constant 16 : index
    %c1 = arith.constant 1 : index
    %c32 = arith.constant 32 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %1 = x86.amx.tile_load %arg0[%c0, %c0, %c0] : memref<1x32x32xbf16> into !x86.amx.tile<16x32xbf16>
    %subview = memref.subview %arg1[%c0, %c0, %c0] [1, 32, 16] [1, 1, 1] : memref<1x32x32xbf16> to memref<1x32x16xbf16, strided<[1024, 32, 1], offset: ?>>
    %alloca = memref.alloca() : memref<16x32xbf16>
    scf.for %arg3 = %c0 to %c32 step %c2 {
      %6 = arith.addi %arg3, %c1 : index
      %7 = vector.load %subview[%c0, %arg3, %c0] : memref<1x32x16xbf16, strided<[1024, 32, 1], offset: ?>>, vector<16xbf16>
      %8 = vector.load %subview[%c0, %6, %c0] : memref<1x32x16xbf16, strided<[1024, 32, 1], offset: ?>>, vector<16xbf16>
      %9 = vector.shuffle %7, %8 [0, 16, 1, 17, 2, 18, 3, 19, 4, 20, 5, 21, 6, 22, 7, 23] : vector<16xbf16>, vector<16xbf16>
      %10 = vector.shuffle %7, %8 [8, 24, 9, 25, 10, 26, 11, 27, 12, 28, 13, 29, 14, 30, 15, 31] : vector<16xbf16>, vector<16xbf16>
      %11 = arith.divui %arg3, %c2 : index
      vector.store %9, %alloca[%11, %c0] : memref<16x32xbf16>, vector<16xbf16>
      vector.store %10, %alloca[%11, %c16] : memref<16x32xbf16>, vector<16xbf16>
    }
    %2 = x86.amx.tile_load %alloca[%c0, %c0] : memref<16x32xbf16> into !x86.amx.tile<16x32xbf16>
    %3 = x86.amx.tile_load %arg2[%c0, %c0] : memref<32x32xf32> into !x86.amx.tile<16x16xf32>
    %4 = x86.amx.tile_mulf %1, %2, %3 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
    %alloca_0 = memref.alloca() : memref<16x16xf32>
    x86.amx.tile_store %alloca_0[%c0, %c0], %4 : memref<16x16xf32>, !x86.amx.tile<16x16xf32>
    %5 = vector.transfer_read %alloca_0[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x16xf32>, vector<16x16xf32>
    vector.transfer_write %5, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32>
    return %arg2 : memref<32x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_bf16_loop(%arg0: memref<16x64x64x2xbf16>, %arg1: memref<16x64x128x2xbf16>, %arg2: memref<64x128xf32>) -> memref<64x128xf32> {
    %0 = ub.poison : f32
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c64 step %c32 {
      scf.for %arg4 = %c0 to %c128 step %c32 {
        %subview = memref.subview %arg2[%arg3, %arg4] [32, 32] [1, 1] : memref<64x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
        %1 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %2 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %3 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %4 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %5:4 = scf.for %arg5 = %c0 to %c16 step %c1 iter_args(%arg6 = %1, %arg7 = %2, %arg8 = %3, %arg9 = %4) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
          %10:4 = scf.for %arg10 = %c0 to %c64 step %c16 iter_args(%arg11 = %arg6, %arg12 = %arg7, %arg13 = %arg8, %arg14 = %arg9) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
            %subview_0 = memref.subview %arg0[%arg5, %arg3, %arg10, 0] [1, 32, 16, 2] [1, 1, 1, 1] : memref<16x64x64x2xbf16> to memref<1x32x16x2xbf16, strided<[8192, 128, 2, 1], offset: ?>>
            %subview_1 = memref.subview %arg1[%arg5, %arg10, %arg4, 0] [1, 16, 32, 2] [1, 1, 1, 1] : memref<16x64x128x2xbf16> to memref<1x16x32x2xbf16, strided<[16384, 256, 2, 1], offset: ?>>
            %collapse_shape = memref.collapse_shape %subview_0 [[0], [1], [2, 3]] : memref<1x32x16x2xbf16, strided<[8192, 128, 2, 1], offset: ?>> into memref<1x32x32xbf16, strided<[8192, 128, 1], offset: ?>>
            %collapse_shape_2 = memref.collapse_shape %subview_1 [[0], [1], [2, 3]] : memref<1x16x32x2xbf16, strided<[16384, 256, 2, 1], offset: ?>> into memref<1x16x64xbf16, strided<[16384, 256, 1], offset: ?>>
            %11 = x86.amx.tile_load %collapse_shape[%c0, %c0, %c0] : memref<1x32x32xbf16, strided<[8192, 128, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
            %12 = x86.amx.tile_load %collapse_shape_2[%c0, %c0, %c0] : memref<1x16x64xbf16, strided<[16384, 256, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
            %13 = x86.amx.tile_mulf %11, %12, %arg11 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %14 = x86.amx.tile_load %collapse_shape_2[%c0, %c0, %c32] : memref<1x16x64xbf16, strided<[16384, 256, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
            %15 = x86.amx.tile_mulf %11, %14, %arg12 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %16 = x86.amx.tile_load %collapse_shape[%c0, %c16, %c0] : memref<1x32x32xbf16, strided<[8192, 128, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
            %17 = x86.amx.tile_mulf %16, %12, %arg13 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %18 = x86.amx.tile_mulf %16, %14, %arg14 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            scf.yield %13, %15, %17, %18 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
          }
          scf.yield %10#0, %10#1, %10#2, %10#3 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
        }
        %alloca = memref.alloca() : memref<32x32xf32>
        x86.amx.tile_store %alloca[%c0, %c0], %5#0 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        x86.amx.tile_store %alloca[%c0, %c16], %5#1 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        x86.amx.tile_store %alloca[%c16, %c0], %5#2 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        x86.amx.tile_store %alloca[%c16, %c16], %5#3 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        scf.for %arg5 = %c0 to %c32 step %c1 {
          %10 = vector.load %alloca[%arg5, %c0] : memref<32x32xf32>, vector<16xf32>
          %11 = vector.load %alloca[%arg5, %c16] : memref<32x32xf32>, vector<16xf32>
          %12 = vector.load %subview[%arg5, %c0] : memref<32x32xf32, strided<[128, 1], offset: ?>>, vector<16xf32>
          %13 = vector.load %subview[%arg5, %c16] : memref<32x32xf32, strided<[128, 1], offset: ?>>, vector<16xf32>
          %14 = arith.addf %10, %12 : vector<16xf32>
          %15 = arith.addf %11, %13 : vector<16xf32>
          vector.store %14, %alloca[%arg5, %c0] : memref<32x32xf32>, vector<16xf32>
          vector.store %15, %alloca[%arg5, %c16] : memref<32x32xf32>, vector<16xf32>
        }
        %6 = vector.transfer_read %alloca[%c0, %c0], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        %7 = vector.transfer_read %alloca[%c0, %c16], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        %8 = vector.transfer_read %alloca[%c16, %c0], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        %9 = vector.transfer_read %alloca[%c16, %c16], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        vector.transfer_write %9, %subview[%c16, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %8, %subview[%c16, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %7, %subview[%c0, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %6, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
      }
    }
    return %arg2 : memref<64x128xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_int8_loop(%arg0: memref<64x64x4xi8>, %arg1: memref<64x128x4xi8>, %arg2: memref<64x128xi32>) {
    %0 = ub.poison : i32
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    scf.for %arg3 = %c0 to %c64 step %c16 {
      scf.for %arg4 = %c0 to %c128 step %c32 {
        %subview = memref.subview %arg2[%arg3, %arg4] [16, 32] [1, 1] : memref<64x128xi32> to memref<16x32xi32, strided<[128, 1], offset: ?>>
        %1 = x86.amx.tile_zero : !x86.amx.tile<16x16xi32>
        %2 = x86.amx.tile_zero : !x86.amx.tile<16x16xi32>
        %3:2 = scf.for %arg5 = %c0 to %c64 step %c16 iter_args(%arg6 = %1, %arg7 = %2) -> (!x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>) {
          %subview_0 = memref.subview %arg0[%arg3, %arg5, 0] [16, 16, 4] [1, 1, 1] : memref<64x64x4xi8> to memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>>
          %subview_1 = memref.subview %arg1[%arg5, %arg4, 0] [16, 32, 4] [1, 1, 1] : memref<64x128x4xi8> to memref<16x32x4xi8, strided<[512, 4, 1], offset: ?>>
          %collapse_shape = memref.collapse_shape %subview_0 [[0], [1, 2]] : memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>> into memref<16x64xi8, strided<[256, 1], offset: ?>>
          %collapse_shape_2 = memref.collapse_shape %subview_1 [[0], [1, 2]] : memref<16x32x4xi8, strided<[512, 4, 1], offset: ?>> into memref<16x128xi8, strided<[512, 1], offset: ?>>
          %6 = x86.amx.tile_load %collapse_shape[%c0, %c0] : memref<16x64xi8, strided<[256, 1], offset: ?>> into !x86.amx.tile<16x64xi8>
          %7 = x86.amx.tile_load %collapse_shape_2[%c0, %c0] : memref<16x128xi8, strided<[512, 1], offset: ?>> into !x86.amx.tile<16x64xi8>
          %8 = x86.amx.tile_muli %6, %7, %arg6 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
          %9 = x86.amx.tile_load %collapse_shape_2[%c0, %c64] : memref<16x128xi8, strided<[512, 1], offset: ?>> into !x86.amx.tile<16x64xi8>
          %10 = x86.amx.tile_muli %6, %9, %arg7 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
          scf.yield %8, %10 : !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>
        }
        %alloca = memref.alloca() : memref<16x32xi32>
        x86.amx.tile_store %alloca[%c0, %c0], %3#0 : memref<16x32xi32>, !x86.amx.tile<16x16xi32>
        x86.amx.tile_store %alloca[%c0, %c16], %3#1 : memref<16x32xi32>, !x86.amx.tile<16x16xi32>
        scf.for %arg5 = %c0 to %c32 step %c1 {
          %6 = vector.load %alloca[%arg5, %c0] : memref<16x32xi32>, vector<16xi32>
          %7 = vector.load %alloca[%arg5, %c16] : memref<16x32xi32>, vector<16xi32>
          %8 = vector.load %subview[%arg5, %c0] : memref<16x32xi32, strided<[128, 1], offset: ?>>, vector<16xi32>
          %9 = vector.load %subview[%arg5, %c16] : memref<16x32xi32, strided<[128, 1], offset: ?>>, vector<16xi32>
          %10 = arith.addi %6, %8 : vector<16xi32>
          %11 = arith.addi %7, %9 : vector<16xi32>
          vector.store %10, %alloca[%arg5, %c0] : memref<16x32xi32>, vector<16xi32>
          vector.store %11, %alloca[%arg5, %c16] : memref<16x32xi32>, vector<16xi32>
        }
        %4 = vector.transfer_read %alloca[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x32xi32>, vector<16x16xi32>
        %5 = vector.transfer_read %alloca[%c0, %c16], %0 {in_bounds = [true, true]} : memref<16x32xi32>, vector<16x16xi32>
        vector.transfer_write %5, %subview[%c0, %c16] {in_bounds = [true, true]} : vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>
        vector.transfer_write %4, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>
      }
    }
    return
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @matmul_f8E4M3FN_loop(%arg0: memref<64x64x4xf8E4M3FN>, %arg1: memref<64x128x4xf8E4M3FN>, %arg2: memref<64x128xf32>) {
    %0 = ub.poison : f32
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    scf.for %arg3 = %c0 to %c64 step %c16 {
      scf.for %arg4 = %c0 to %c128 step %c32 {
        %subview = memref.subview %arg2[%arg3, %arg4] [16, 32] [1, 1] : memref<64x128xf32> to memref<16x32xf32, strided<[128, 1], offset: ?>>
        %1 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %2 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %3:2 = scf.for %arg5 = %c0 to %c64 step %c16 iter_args(%arg6 = %1, %arg7 = %2) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
          %subview_0 = memref.subview %arg0[%arg3, %arg5, 0] [16, 16, 4] [1, 1, 1] : memref<64x64x4xf8E4M3FN> to memref<16x16x4xf8E4M3FN, strided<[256, 4, 1], offset: ?>>
          %subview_1 = memref.subview %arg1[%arg5, %arg4, 0] [16, 32, 4] [1, 1, 1] : memref<64x128x4xf8E4M3FN> to memref<16x32x4xf8E4M3FN, strided<[512, 4, 1], offset: ?>>
          %collapse_shape = memref.collapse_shape %subview_0 [[0], [1, 2]] : memref<16x16x4xf8E4M3FN, strided<[256, 4, 1], offset: ?>> into memref<16x64xf8E4M3FN, strided<[256, 1], offset: ?>>
          %collapse_shape_2 = memref.collapse_shape %subview_1 [[0], [1, 2]] : memref<16x32x4xf8E4M3FN, strided<[512, 4, 1], offset: ?>> into memref<16x128xf8E4M3FN, strided<[512, 1], offset: ?>>
          %6 = x86.amx.tile_load %collapse_shape[%c0, %c0] : memref<16x64xf8E4M3FN, strided<[256, 1], offset: ?>> into !x86.amx.tile<16x64xf8E4M3FN>
          %7 = x86.amx.tile_load %collapse_shape_2[%c0, %c0] : memref<16x128xf8E4M3FN, strided<[512, 1], offset: ?>> into !x86.amx.tile<16x64xf8E4M3FN>
          %8 = x86.amx.tile_mulf %6, %7, %arg6 : !x86.amx.tile<16x64xf8E4M3FN>, !x86.amx.tile<16x64xf8E4M3FN>, !x86.amx.tile<16x16xf32>
          %9 = x86.amx.tile_load %collapse_shape_2[%c0, %c64] : memref<16x128xf8E4M3FN, strided<[512, 1], offset: ?>> into !x86.amx.tile<16x64xf8E4M3FN>
          %10 = x86.amx.tile_mulf %6, %9, %arg7 : !x86.amx.tile<16x64xf8E4M3FN>, !x86.amx.tile<16x64xf8E4M3FN>, !x86.amx.tile<16x16xf32>
          scf.yield %8, %10 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
        }
        %alloca = memref.alloca() : memref<16x32xf32>
        x86.amx.tile_store %alloca[%c0, %c0], %3#0 : memref<16x32xf32>, !x86.amx.tile<16x16xf32>
        x86.amx.tile_store %alloca[%c0, %c16], %3#1 : memref<16x32xf32>, !x86.amx.tile<16x16xf32>
        scf.for %arg5 = %c0 to %c32 step %c1 {
          %6 = vector.load %alloca[%arg5, %c0] : memref<16x32xf32>, vector<16xf32>
          %7 = vector.load %alloca[%arg5, %c16] : memref<16x32xf32>, vector<16xf32>
          %8 = vector.load %subview[%arg5, %c0] : memref<16x32xf32, strided<[128, 1], offset: ?>>, vector<16xf32>
          %9 = vector.load %subview[%arg5, %c16] : memref<16x32xf32, strided<[128, 1], offset: ?>>, vector<16xf32>
          %10 = arith.addf %6, %8 : vector<16xf32>
          %11 = arith.addf %7, %9 : vector<16xf32>
          vector.store %10, %alloca[%arg5, %c0] : memref<16x32xf32>, vector<16xf32>
          vector.store %11, %alloca[%arg5, %c16] : memref<16x32xf32>, vector<16xf32>
        }
        %4 = vector.transfer_read %alloca[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x32xf32>, vector<16x16xf32>
        %5 = vector.transfer_read %alloca[%c0, %c16], %0 {in_bounds = [true, true]} : memref<16x32xf32>, vector<16x16xf32>
        vector.transfer_write %5, %subview[%c0, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<16x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %4, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<16x32xf32, strided<[128, 1], offset: ?>>
      }
    }
    return
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @batch_matmul_int8_loop(%arg0: memref<16x64x64x4xi8>, %arg1: memref<16x64x128x4xi8>, %arg2: memref<16x64x128xi32>) {
    %0 = ub.poison : i32
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c64 step %c16 {
      scf.for %arg4 = %c0 to %c128 step %c32 {
        scf.for %arg5 = %c0 to %c16 step %c1 {
          %subview = memref.subview %arg2[%arg5, %arg3, %arg4] [1, 16, 32] [1, 1, 1] : memref<16x64x128xi32> to memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>
          %1 = x86.amx.tile_zero : !x86.amx.tile<16x16xi32>
          %2 = x86.amx.tile_zero : !x86.amx.tile<16x16xi32>
          %3:2 = scf.for %arg6 = %c0 to %c64 step %c16 iter_args(%arg7 = %1, %arg8 = %2) -> (!x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>) {
            %subview_0 = memref.subview %arg0[%arg5, %arg3, %arg6, 0] [1, 16, 16, 4] [1, 1, 1, 1] : memref<16x64x64x4xi8> to memref<1x16x16x4xi8, strided<[16384, 256, 4, 1], offset: ?>>
            %subview_1 = memref.subview %arg1[%arg5, %arg6, %arg4, 0] [1, 16, 32, 4] [1, 1, 1, 1] : memref<16x64x128x4xi8> to memref<1x16x32x4xi8, strided<[32768, 512, 4, 1], offset: ?>>
            %collapse_shape = memref.collapse_shape %subview_0 [[0], [1], [2, 3]] : memref<1x16x16x4xi8, strided<[16384, 256, 4, 1], offset: ?>> into memref<1x16x64xi8, strided<[16384, 256, 1], offset: ?>>
            %collapse_shape_2 = memref.collapse_shape %subview_1 [[0], [1], [2, 3]] : memref<1x16x32x4xi8, strided<[32768, 512, 4, 1], offset: ?>> into memref<1x16x128xi8, strided<[32768, 512, 1], offset: ?>>
            %8 = x86.amx.tile_load %collapse_shape[%c0, %c0, %c0] : memref<1x16x64xi8, strided<[16384, 256, 1], offset: ?>> into !x86.amx.tile<16x64xi8>
            %9 = x86.amx.tile_load %collapse_shape_2[%c0, %c0, %c0] : memref<1x16x128xi8, strided<[32768, 512, 1], offset: ?>> into !x86.amx.tile<16x64xi8>
            %10 = x86.amx.tile_muli %8, %9, %arg7 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
            %11 = x86.amx.tile_load %collapse_shape_2[%c0, %c0, %c64] : memref<1x16x128xi8, strided<[32768, 512, 1], offset: ?>> into !x86.amx.tile<16x64xi8>
            %12 = x86.amx.tile_muli %8, %11, %arg8 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
            scf.yield %10, %12 : !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>
          }
          %alloca = memref.alloca() : memref<16x32xi32>
          x86.amx.tile_store %alloca[%c0, %c0], %3#0 : memref<16x32xi32>, !x86.amx.tile<16x16xi32>
          x86.amx.tile_store %alloca[%c0, %c16], %3#1 : memref<16x32xi32>, !x86.amx.tile<16x16xi32>
          scf.for %arg6 = %c0 to %c32 step %c1 {
            %8 = vector.load %alloca[%arg6, %c0] : memref<16x32xi32>, vector<16xi32>
            %9 = vector.load %alloca[%arg6, %c16] : memref<16x32xi32>, vector<16xi32>
            %10 = vector.load %subview[%c0, %arg6, %c0] : memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>, vector<16xi32>
            %11 = vector.load %subview[%c0, %arg6, %c16] : memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>, vector<16xi32>
            %12 = arith.addi %8, %10 : vector<16xi32>
            %13 = arith.addi %9, %11 : vector<16xi32>
            vector.store %12, %alloca[%arg6, %c0] : memref<16x32xi32>, vector<16xi32>
            vector.store %13, %alloca[%arg6, %c16] : memref<16x32xi32>, vector<16xi32>
          }
          %4 = vector.transfer_read %alloca[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x32xi32>, vector<16x16xi32>
          %5 = vector.transfer_read %alloca[%c0, %c16], %0 {in_bounds = [true, true]} : memref<16x32xi32>, vector<16x16xi32>
          %6 = vector.shape_cast %4 : vector<16x16xi32> to vector<1x16x16xi32>
          %7 = vector.shape_cast %5 : vector<16x16xi32> to vector<1x16x16xi32>
          vector.transfer_write %7, %subview[%c0, %c0, %c16] {in_bounds = [true, true, true]} : vector<1x16x16xi32>, memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>
          vector.transfer_write %6, %subview[%c0, %c0, %c0] {in_bounds = [true, true, true]} : vector<1x16x16xi32>, memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>
        }
      }
    }
    return
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @online_packing_bf16_loop(%arg0: memref<16x64x96xbf16>, %arg1: memref<16x96x128xbf16>, %arg2: memref<64x128xf32>) -> memref<64x128xf32> {
    %0 = ub.poison : f32
    %1 = ub.poison : bf16
    %c2 = arith.constant 2 : index
    %c15 = arith.constant 15 : index
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c16 = arith.constant 16 : index
    %c96 = arith.constant 96 : index
    %c32 = arith.constant 32 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c64 step %c32 {
      scf.for %arg4 = %c0 to %c128 step %c32 {
        %subview = memref.subview %arg2[%arg3, %arg4] [32, 32] [1, 1] : memref<64x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
        %2 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %3 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %4 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %5 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %alloca = memref.alloca() : memref<2x32x32xbf16>
        %subview_0 = memref.subview %arg1[%c0, %c0, %arg4] [1, 32, 32] [1, 1, 1] : memref<16x96x128xbf16> to memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>
        scf.for %arg5 = %c0 to %c32 step %c2 {
          %12 = vector.transfer_read %subview_0[%c0, %arg5, %c0], %1 {in_bounds = [true]} : memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, vector<32xbf16>
          %13 = arith.addi %arg5, %c1 : index
          %14 = vector.transfer_read %subview_0[%c0, %13, %c0], %1 {in_bounds = [true]} : memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, vector<32xbf16>
          %15 = vector.shuffle %12, %14 [0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59] : vector<32xbf16>, vector<32xbf16>
          %16 = vector.shuffle %12, %14 [4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63] : vector<32xbf16>, vector<32xbf16>
          %17 = arith.divui %arg5, %c2 : index
          %18 = arith.addi %17, %c16 : index
          vector.store %15, %alloca[%c0, %17, %c0] : memref<2x32x32xbf16>, vector<32xbf16>
          vector.store %16, %alloca[%c0, %18, %c0] : memref<2x32x32xbf16>, vector<32xbf16>
        }
        %6:4 = scf.for %arg5 = %c0 to %c15 step %c1 iter_args(%arg6 = %2, %arg7 = %3, %arg8 = %4, %arg9 = %5) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
          %12:4 = scf.for %arg10 = %c0 to %c64 step %c32 iter_args(%arg11 = %arg6, %arg12 = %arg7, %arg13 = %arg8, %arg14 = %arg9) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
            %subview_2 = memref.subview %arg0[%arg5, %arg3, %arg10] [1, 32, 32] [1, 1, 1] : memref<16x64x96xbf16> to memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>
            %14 = arith.addi %arg10, %c32 : index
            %15 = arith.divui %14, %c32 : index
            %16 = arith.remui %15, %c2 : index
            %17 = arith.remui %arg5, %c2 : index
            %18 = arith.addi %16, %17 : index
            %19 = arith.remui %18, %c2 : index
            %20 = arith.addi %19, %c1 : index
            %21 = arith.remui %20, %c2 : index
            %subview_3 = memref.subview %arg1[%arg5, %14, %arg4] [1, 32, 32] [1, 1, 1] : memref<16x96x128xbf16> to memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>
            scf.for %arg15 = %c0 to %c32 step %c2 {
              %30 = vector.transfer_read %subview_3[%c0, %arg15, %c0], %1 {in_bounds = [true]} : memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, vector<32xbf16>
              %31 = arith.addi %arg15, %c1 : index
              %32 = vector.transfer_read %subview_3[%c0, %31, %c0], %1 {in_bounds = [true]} : memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, vector<32xbf16>
              %33 = vector.shuffle %30, %32 [0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59] : vector<32xbf16>, vector<32xbf16>
              %34 = vector.shuffle %30, %32 [4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63] : vector<32xbf16>, vector<32xbf16>
              %35 = arith.divui %arg15, %c2 : index
              %36 = arith.addi %35, %c16 : index
              vector.store %33, %alloca[%19, %35, %c0] : memref<2x32x32xbf16>, vector<32xbf16>
              vector.store %34, %alloca[%19, %36, %c0] : memref<2x32x32xbf16>, vector<32xbf16>
            }
            %22 = x86.amx.tile_load %alloca[%21, %c0, %c0] : memref<2x32x32xbf16> into !x86.amx.tile<16x32xbf16>
            %23 = x86.amx.tile_load %alloca[%21, %c16, %c0] : memref<2x32x32xbf16> into !x86.amx.tile<16x32xbf16>
            %24 = x86.amx.tile_load %subview_2[%c0, %c0, %c0] : memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
            %25 = x86.amx.tile_mulf %24, %22, %arg11 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %26 = x86.amx.tile_mulf %24, %23, %arg12 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %27 = x86.amx.tile_load %subview_2[%c0, %c16, %c0] : memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
            %28 = x86.amx.tile_mulf %27, %22, %arg13 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %29 = x86.amx.tile_mulf %27, %23, %arg14 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            scf.yield %25, %26, %28, %29 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
          }
          %13:4 = scf.for %arg10 = %c64 to %c96 step %c32 iter_args(%arg11 = %12#0, %arg12 = %12#1, %arg13 = %12#2, %arg14 = %12#3) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
            %subview_2 = memref.subview %arg0[%arg5, %arg3, %arg10] [1, 32, 32] [1, 1, 1] : memref<16x64x96xbf16> to memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>
            %14 = arith.addi %arg5, %c1 : index
            %15 = arith.remui %14, %c2 : index
            %16 = arith.addi %15, %c1 : index
            %17 = arith.remui %16, %c2 : index
            %subview_3 = memref.subview %arg1[%14, %c0, %arg4] [1, 32, 32] [1, 1, 1] : memref<16x96x128xbf16> to memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>
            scf.for %arg15 = %c0 to %c32 step %c2 {
              %26 = vector.transfer_read %subview_3[%c0, %arg15, %c0], %1 {in_bounds = [true]} : memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, vector<32xbf16>
              %27 = arith.addi %arg15, %c1 : index
              %28 = vector.transfer_read %subview_3[%c0, %27, %c0], %1 {in_bounds = [true]} : memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, vector<32xbf16>
              %29 = vector.shuffle %26, %28 [0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59] : vector<32xbf16>, vector<32xbf16>
              %30 = vector.shuffle %26, %28 [4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63] : vector<32xbf16>, vector<32xbf16>
              %31 = arith.divui %arg15, %c2 : index
              %32 = arith.addi %31, %c16 : index
              vector.store %29, %alloca[%15, %31, %c0] : memref<2x32x32xbf16>, vector<32xbf16>
              vector.store %30, %alloca[%15, %32, %c0] : memref<2x32x32xbf16>, vector<32xbf16>
            }
            %18 = x86.amx.tile_load %alloca[%17, %c0, %c0] : memref<2x32x32xbf16> into !x86.amx.tile<16x32xbf16>
            %19 = x86.amx.tile_load %alloca[%17, %c16, %c0] : memref<2x32x32xbf16> into !x86.amx.tile<16x32xbf16>
            %20 = x86.amx.tile_load %subview_2[%c0, %c0, %c0] : memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
            %21 = x86.amx.tile_mulf %20, %18, %arg11 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %22 = x86.amx.tile_mulf %20, %19, %arg12 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %23 = x86.amx.tile_load %subview_2[%c0, %c16, %c0] : memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
            %24 = x86.amx.tile_mulf %23, %18, %arg13 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %25 = x86.amx.tile_mulf %23, %19, %arg14 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            scf.yield %21, %22, %24, %25 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
          }
          scf.yield %13#0, %13#1, %13#2, %13#3 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
        }
        %7:4 = scf.for %arg5 = %c15 to %c16 step %c1 iter_args(%arg6 = %6#0, %arg7 = %6#1, %arg8 = %6#2, %arg9 = %6#3) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
          %12:4 = scf.for %arg10 = %c0 to %c64 step %c32 iter_args(%arg11 = %arg6, %arg12 = %arg7, %arg13 = %arg8, %arg14 = %arg9) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
            %subview_2 = memref.subview %arg0[%arg5, %arg3, %arg10] [1, 32, 32] [1, 1, 1] : memref<16x64x96xbf16> to memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>
            %14 = arith.addi %arg10, %c32 : index
            %15 = arith.divui %14, %c32 : index
            %16 = arith.remui %15, %c2 : index
            %17 = arith.remui %arg5, %c2 : index
            %18 = arith.addi %16, %17 : index
            %19 = arith.remui %18, %c2 : index
            %20 = arith.addi %19, %c1 : index
            %21 = arith.remui %20, %c2 : index
            %subview_3 = memref.subview %arg1[%arg5, %14, %arg4] [1, 32, 32] [1, 1, 1] : memref<16x96x128xbf16> to memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>
            scf.for %arg15 = %c0 to %c32 step %c2 {
              %30 = vector.transfer_read %subview_3[%c0, %arg15, %c0], %1 {in_bounds = [true]} : memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, vector<32xbf16>
              %31 = arith.addi %arg15, %c1 : index
              %32 = vector.transfer_read %subview_3[%c0, %31, %c0], %1 {in_bounds = [true]} : memref<1x32x32xbf16, strided<[12288, 128, 1], offset: ?>>, vector<32xbf16>
              %33 = vector.shuffle %30, %32 [0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59] : vector<32xbf16>, vector<32xbf16>
              %34 = vector.shuffle %30, %32 [4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63] : vector<32xbf16>, vector<32xbf16>
              %35 = arith.divui %arg15, %c2 : index
              %36 = arith.addi %35, %c16 : index
              vector.store %33, %alloca[%19, %35, %c0] : memref<2x32x32xbf16>, vector<32xbf16>
              vector.store %34, %alloca[%19, %36, %c0] : memref<2x32x32xbf16>, vector<32xbf16>
            }
            %22 = x86.amx.tile_load %alloca[%21, %c0, %c0] : memref<2x32x32xbf16> into !x86.amx.tile<16x32xbf16>
            %23 = x86.amx.tile_load %alloca[%21, %c16, %c0] : memref<2x32x32xbf16> into !x86.amx.tile<16x32xbf16>
            %24 = x86.amx.tile_load %subview_2[%c0, %c0, %c0] : memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
            %25 = x86.amx.tile_mulf %24, %22, %arg11 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %26 = x86.amx.tile_mulf %24, %23, %arg12 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %27 = x86.amx.tile_load %subview_2[%c0, %c16, %c0] : memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
            %28 = x86.amx.tile_mulf %27, %22, %arg13 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %29 = x86.amx.tile_mulf %27, %23, %arg14 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            scf.yield %25, %26, %28, %29 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
          }
          %13:4 = scf.for %arg10 = %c64 to %c96 step %c32 iter_args(%arg11 = %12#0, %arg12 = %12#1, %arg13 = %12#2, %arg14 = %12#3) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
            %subview_2 = memref.subview %arg0[%arg5, %arg3, %arg10] [1, 32, 32] [1, 1, 1] : memref<16x64x96xbf16> to memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>>
            %14 = arith.remui %arg5, %c2 : index
            %15 = arith.addi %14, %c1 : index
            %16 = arith.remui %15, %c2 : index
            %17 = x86.amx.tile_load %alloca[%16, %c0, %c0] : memref<2x32x32xbf16> into !x86.amx.tile<16x32xbf16>
            %18 = x86.amx.tile_load %alloca[%16, %c16, %c0] : memref<2x32x32xbf16> into !x86.amx.tile<16x32xbf16>
            %19 = x86.amx.tile_load %subview_2[%c0, %c0, %c0] : memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
            %20 = x86.amx.tile_mulf %19, %17, %arg11 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %21 = x86.amx.tile_mulf %19, %18, %arg12 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %22 = x86.amx.tile_load %subview_2[%c0, %c16, %c0] : memref<1x32x32xbf16, strided<[6144, 96, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
            %23 = x86.amx.tile_mulf %22, %17, %arg13 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            %24 = x86.amx.tile_mulf %22, %18, %arg14 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
            scf.yield %20, %21, %23, %24 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
          }
          scf.yield %13#0, %13#1, %13#2, %13#3 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
        }
        %alloca_1 = memref.alloca() : memref<32x32xf32>
        x86.amx.tile_store %alloca_1[%c0, %c0], %7#0 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        x86.amx.tile_store %alloca_1[%c0, %c16], %7#1 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        x86.amx.tile_store %alloca_1[%c16, %c0], %7#2 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        x86.amx.tile_store %alloca_1[%c16, %c16], %7#3 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        scf.for %arg5 = %c0 to %c32 step %c1 {
          %12 = vector.load %alloca_1[%arg5, %c0] : memref<32x32xf32>, vector<16xf32>
          %13 = vector.load %alloca_1[%arg5, %c16] : memref<32x32xf32>, vector<16xf32>
          %14 = vector.shuffle %12, %13 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
          %15 = vector.shuffle %12, %13 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
          %16 = vector.load %subview[%arg5, %c0] : memref<32x32xf32, strided<[128, 1], offset: ?>>, vector<16xf32>
          %17 = vector.load %subview[%arg5, %c16] : memref<32x32xf32, strided<[128, 1], offset: ?>>, vector<16xf32>
          %18 = arith.addf %14, %16 : vector<16xf32>
          %19 = arith.addf %15, %17 : vector<16xf32>
          vector.store %18, %alloca_1[%arg5, %c0] : memref<32x32xf32>, vector<16xf32>
          vector.store %19, %alloca_1[%arg5, %c16] : memref<32x32xf32>, vector<16xf32>
        }
        %8 = vector.transfer_read %alloca_1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        %9 = vector.transfer_read %alloca_1[%c0, %c16], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        %10 = vector.transfer_read %alloca_1[%c16, %c0], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        %11 = vector.transfer_read %alloca_1[%c16, %c16], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        vector.transfer_write %11, %subview[%c16, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %10, %subview[%c16, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %9, %subview[%c0, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %8, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
      }
    }
    %alloc = memref.alloc() : memref<64x128xf32>
    memref.copy %arg2, %alloc : memref<64x128xf32> to memref<64x128xf32>
    return %alloc : memref<64x128xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @online_packing_bf16_loop_lb_non_zero(%arg0: memref<64x96xbf16>, %arg1: memref<96x128xbf16>, %arg2: memref<64x128xf32>, %arg3: index, %arg4: index) -> memref<64x128xf32> {
    %0 = ub.poison : f32
    %1 = ub.poison : bf16
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    scf.for %arg5 = %c0 to %c64 step %c32 {
      scf.for %arg6 = %c0 to %c128 step %c32 {
        %subview = memref.subview %arg2[%arg5, %arg6] [32, 32] [1, 1] : memref<64x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
        %2 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %3 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %4 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %5 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %6 = arith.subi %arg4, %c32 : index
        %alloca = memref.alloca() : memref<2x32x32xbf16>
        %subview_0 = memref.subview %arg1[%arg3, %arg6] [32, 32] [1, 1] : memref<96x128xbf16> to memref<32x32xbf16, strided<[128, 1], offset: ?>>
        %7 = arith.divui %arg3, %c32 : index
        %8 = arith.remui %7, %c2 : index
        scf.for %arg7 = %c0 to %c32 step %c2 {
          %15 = vector.transfer_read %subview_0[%arg7, %c0], %1 {in_bounds = [true]} : memref<32x32xbf16, strided<[128, 1], offset: ?>>, vector<32xbf16>
          %16 = arith.addi %arg7, %c1 : index
          %17 = vector.transfer_read %subview_0[%16, %c0], %1 {in_bounds = [true]} : memref<32x32xbf16, strided<[128, 1], offset: ?>>, vector<32xbf16>
          %18 = vector.shuffle %15, %17 [0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59] : vector<32xbf16>, vector<32xbf16>
          %19 = vector.shuffle %15, %17 [4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63] : vector<32xbf16>, vector<32xbf16>
          %20 = arith.divui %arg7, %c2 : index
          %21 = arith.addi %20, %c16 : index
          vector.store %18, %alloca[%8, %20, %c0] : memref<2x32x32xbf16>, vector<32xbf16>
          vector.store %19, %alloca[%8, %21, %c0] : memref<2x32x32xbf16>, vector<32xbf16>
        }
        %9:4 = scf.for %arg7 = %arg3 to %6 step %c32 iter_args(%arg8 = %2, %arg9 = %3, %arg10 = %4, %arg11 = %5) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
          %subview_2 = memref.subview %arg0[%arg5, %arg7] [32, 32] [1, 1] : memref<64x96xbf16> to memref<32x32xbf16, strided<[96, 1], offset: ?>>
          %15 = arith.addi %arg7, %c32 : index
          %16 = arith.divui %15, %c32 : index
          %17 = arith.remui %16, %c2 : index
          %18 = arith.addi %17, %c1 : index
          %19 = arith.remui %18, %c2 : index
          %subview_3 = memref.subview %arg1[%15, %arg6] [32, 32] [1, 1] : memref<96x128xbf16> to memref<32x32xbf16, strided<[128, 1], offset: ?>>
          scf.for %arg12 = %c0 to %c32 step %c2 {
            %28 = vector.transfer_read %subview_3[%arg12, %c0], %1 {in_bounds = [true]} : memref<32x32xbf16, strided<[128, 1], offset: ?>>, vector<32xbf16>
            %29 = arith.addi %arg12, %c1 : index
            %30 = vector.transfer_read %subview_3[%29, %c0], %1 {in_bounds = [true]} : memref<32x32xbf16, strided<[128, 1], offset: ?>>, vector<32xbf16>
            %31 = vector.shuffle %28, %30 [0, 32, 1, 33, 2, 34, 3, 35, 8, 40, 9, 41, 10, 42, 11, 43, 16, 48, 17, 49, 18, 50, 19, 51, 24, 56, 25, 57, 26, 58, 27, 59] : vector<32xbf16>, vector<32xbf16>
            %32 = vector.shuffle %28, %30 [4, 36, 5, 37, 6, 38, 7, 39, 12, 44, 13, 45, 14, 46, 15, 47, 20, 52, 21, 53, 22, 54, 23, 55, 28, 60, 29, 61, 30, 62, 31, 63] : vector<32xbf16>, vector<32xbf16>
            %33 = arith.divui %arg12, %c2 : index
            %34 = arith.addi %33, %c16 : index
            vector.store %31, %alloca[%17, %33, %c0] : memref<2x32x32xbf16>, vector<32xbf16>
            vector.store %32, %alloca[%17, %34, %c0] : memref<2x32x32xbf16>, vector<32xbf16>
          }
          %20 = x86.amx.tile_load %alloca[%19, %c0, %c0] : memref<2x32x32xbf16> into !x86.amx.tile<16x32xbf16>
          %21 = x86.amx.tile_load %alloca[%19, %c16, %c0] : memref<2x32x32xbf16> into !x86.amx.tile<16x32xbf16>
          %22 = x86.amx.tile_load %subview_2[%c0, %c0] : memref<32x32xbf16, strided<[96, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
          %23 = x86.amx.tile_mulf %22, %20, %arg8 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
          %24 = x86.amx.tile_mulf %22, %21, %arg9 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
          %25 = x86.amx.tile_load %subview_2[%c16, %c0] : memref<32x32xbf16, strided<[96, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
          %26 = x86.amx.tile_mulf %25, %20, %arg10 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
          %27 = x86.amx.tile_mulf %25, %21, %arg11 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
          scf.yield %23, %24, %26, %27 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
        }
        %10:4 = scf.for %arg7 = %6 to %arg4 step %c32 iter_args(%arg8 = %9#0, %arg9 = %9#1, %arg10 = %9#2, %arg11 = %9#3) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
          %subview_2 = memref.subview %arg0[%arg5, %arg7] [32, 32] [1, 1] : memref<64x96xbf16> to memref<32x32xbf16, strided<[96, 1], offset: ?>>
          %15 = arith.divui %arg7, %c32 : index
          %16 = arith.remui %15, %c2 : index
          %17 = x86.amx.tile_load %alloca[%16, %c0, %c0] : memref<2x32x32xbf16> into !x86.amx.tile<16x32xbf16>
          %18 = x86.amx.tile_load %alloca[%16, %c16, %c0] : memref<2x32x32xbf16> into !x86.amx.tile<16x32xbf16>
          %19 = x86.amx.tile_load %subview_2[%c0, %c0] : memref<32x32xbf16, strided<[96, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
          %20 = x86.amx.tile_mulf %19, %17, %arg8 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
          %21 = x86.amx.tile_mulf %19, %18, %arg9 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
          %22 = x86.amx.tile_load %subview_2[%c16, %c0] : memref<32x32xbf16, strided<[96, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
          %23 = x86.amx.tile_mulf %22, %17, %arg10 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
          %24 = x86.amx.tile_mulf %22, %18, %arg11 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
          scf.yield %20, %21, %23, %24 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
        }
        %alloca_1 = memref.alloca() : memref<32x32xf32>
        x86.amx.tile_store %alloca_1[%c0, %c0], %10#0 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        x86.amx.tile_store %alloca_1[%c0, %c16], %10#1 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        x86.amx.tile_store %alloca_1[%c16, %c0], %10#2 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        x86.amx.tile_store %alloca_1[%c16, %c16], %10#3 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        scf.for %arg7 = %c0 to %c32 step %c1 {
          %15 = vector.load %alloca_1[%arg7, %c0] : memref<32x32xf32>, vector<16xf32>
          %16 = vector.load %alloca_1[%arg7, %c16] : memref<32x32xf32>, vector<16xf32>
          %17 = vector.shuffle %15, %16 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
          %18 = vector.shuffle %15, %16 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
          %19 = vector.load %subview[%arg7, %c0] : memref<32x32xf32, strided<[128, 1], offset: ?>>, vector<16xf32>
          %20 = vector.load %subview[%arg7, %c16] : memref<32x32xf32, strided<[128, 1], offset: ?>>, vector<16xf32>
          %21 = arith.addf %17, %19 : vector<16xf32>
          %22 = arith.addf %18, %20 : vector<16xf32>
          vector.store %21, %alloca_1[%arg7, %c0] : memref<32x32xf32>, vector<16xf32>
          vector.store %22, %alloca_1[%arg7, %c16] : memref<32x32xf32>, vector<16xf32>
        }
        %11 = vector.transfer_read %alloca_1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        %12 = vector.transfer_read %alloca_1[%c0, %c16], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        %13 = vector.transfer_read %alloca_1[%c16, %c0], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        %14 = vector.transfer_read %alloca_1[%c16, %c16], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        vector.transfer_write %14, %subview[%c16, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %13, %subview[%c16, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %12, %subview[%c0, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %11, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
      }
    }
    %alloc = memref.alloc() : memref<64x128xf32>
    memref.copy %arg2, %alloc : memref<64x128xf32> to memref<64x128xf32>
    return %alloc : memref<64x128xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @online_packing_f8E5M2_matmul_loop(%arg0: memref<64x256xf8E5M2>, %arg1: memref<256x128xf8E5M2>, %arg2: memref<64x128xf32>) -> memref<64x128xf32> {
    %0 = ub.poison : f32
    %c1 = arith.constant 1 : index
    %1 = ub.poison : f8E5M2
    %c2 = arith.constant 2 : index
    %c4 = arith.constant 4 : index
    %c192 = arith.constant 192 : index
    %c16 = arith.constant 16 : index
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c256 = arith.constant 256 : index
    %c32 = arith.constant 32 : index
    scf.for %arg3 = %c0 to %c64 step %c32 {
      scf.for %arg4 = %c0 to %c128 step %c32 {
        %subview = memref.subview %arg2[%arg3, %arg4] [32, 32] [1, 1] : memref<64x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
        %2 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %3 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %4 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %5 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
        %alloca = memref.alloca() : memref<2x32x64xf8E5M2>
        %subview_0 = memref.subview %arg1[%c0, %arg4] [64, 32] [1, 1] : memref<256x128xf8E5M2> to memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>
        scf.for %arg5 = %c0 to %c64 step %c4 {
          %12 = vector.transfer_read %subview_0[%arg5, %c0], %1 {in_bounds = [true, true]} : memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>, vector<2x32xf8E5M2>
          %13 = vector.shape_cast %12 : vector<2x32xf8E5M2> to vector<64xf8E5M2>
          %14 = arith.addi %arg5, %c2 : index
          %15 = vector.transfer_read %subview_0[%14, %c0], %1 {in_bounds = [true, true]} : memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>, vector<2x32xf8E5M2>
          %16 = vector.shape_cast %15 : vector<2x32xf8E5M2> to vector<64xf8E5M2>
          %17 = vector.shuffle %13, %16 [0, 32, 64, 96, 1, 33, 65, 97, 2, 34, 66, 98, 3, 35, 67, 99, 8, 40, 72, 104, 9, 41, 73, 105, 10, 42, 74, 106, 11, 43, 75, 107, 16, 48, 80, 112, 17, 49, 81, 113, 18, 50, 82, 114, 19, 51, 83, 115, 24, 56, 88, 120, 25, 57, 89, 121, 26, 58, 90, 122, 27, 59, 91, 123] : vector<64xf8E5M2>, vector<64xf8E5M2>
          %18 = vector.shuffle %13, %16 [4, 36, 68, 100, 5, 37, 69, 101, 6, 38, 70, 102, 7, 39, 71, 103, 12, 44, 76, 108, 13, 45, 77, 109, 14, 46, 78, 110, 15, 47, 79, 111, 20, 52, 84, 116, 21, 53, 85, 117, 22, 54, 86, 118, 23, 55, 87, 119, 28, 60, 92, 124, 29, 61, 93, 125, 30, 62, 94, 126, 31, 63, 95, 127] : vector<64xf8E5M2>, vector<64xf8E5M2>
          %19 = arith.divui %arg5, %c4 : index
          %20 = arith.addi %19, %c16 : index
          vector.store %17, %alloca[%c0, %19, %c0] : memref<2x32x64xf8E5M2>, vector<64xf8E5M2>
          vector.store %18, %alloca[%c0, %20, %c0] : memref<2x32x64xf8E5M2>, vector<64xf8E5M2>
        }
        %6:4 = scf.for %arg5 = %c0 to %c192 step %c64 iter_args(%arg6 = %2, %arg7 = %3, %arg8 = %4, %arg9 = %5) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
          %subview_2 = memref.subview %arg0[%arg3, %arg5] [32, 64] [1, 1] : memref<64x256xf8E5M2> to memref<32x64xf8E5M2, strided<[256, 1], offset: ?>>
          %12 = arith.addi %arg5, %c64 : index
          %13 = arith.divui %12, %c64 : index
          %14 = arith.remui %13, %c2 : index
          %15 = arith.addi %14, %c1 : index
          %16 = arith.remui %15, %c2 : index
          %subview_3 = memref.subview %arg1[%12, %arg4] [64, 32] [1, 1] : memref<256x128xf8E5M2> to memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>
          scf.for %arg10 = %c0 to %c64 step %c4 {
            %25 = vector.transfer_read %subview_3[%arg10, %c0], %1 {in_bounds = [true, true]} : memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>, vector<2x32xf8E5M2>
            %26 = vector.shape_cast %25 : vector<2x32xf8E5M2> to vector<64xf8E5M2>
            %27 = arith.addi %arg10, %c2 : index
            %28 = vector.transfer_read %subview_3[%27, %c0], %1 {in_bounds = [true, true]} : memref<64x32xf8E5M2, strided<[128, 1], offset: ?>>, vector<2x32xf8E5M2>
            %29 = vector.shape_cast %28 : vector<2x32xf8E5M2> to vector<64xf8E5M2>
            %30 = vector.shuffle %26, %29 [0, 32, 64, 96, 1, 33, 65, 97, 2, 34, 66, 98, 3, 35, 67, 99, 8, 40, 72, 104, 9, 41, 73, 105, 10, 42, 74, 106, 11, 43, 75, 107, 16, 48, 80, 112, 17, 49, 81, 113, 18, 50, 82, 114, 19, 51, 83, 115, 24, 56, 88, 120, 25, 57, 89, 121, 26, 58, 90, 122, 27, 59, 91, 123] : vector<64xf8E5M2>, vector<64xf8E5M2>
            %31 = vector.shuffle %26, %29 [4, 36, 68, 100, 5, 37, 69, 101, 6, 38, 70, 102, 7, 39, 71, 103, 12, 44, 76, 108, 13, 45, 77, 109, 14, 46, 78, 110, 15, 47, 79, 111, 20, 52, 84, 116, 21, 53, 85, 117, 22, 54, 86, 118, 23, 55, 87, 119, 28, 60, 92, 124, 29, 61, 93, 125, 30, 62, 94, 126, 31, 63, 95, 127] : vector<64xf8E5M2>, vector<64xf8E5M2>
            %32 = arith.divui %arg10, %c4 : index
            %33 = arith.addi %32, %c16 : index
            vector.store %30, %alloca[%14, %32, %c0] : memref<2x32x64xf8E5M2>, vector<64xf8E5M2>
            vector.store %31, %alloca[%14, %33, %c0] : memref<2x32x64xf8E5M2>, vector<64xf8E5M2>
          }
          %17 = x86.amx.tile_load %alloca[%16, %c0, %c0] : memref<2x32x64xf8E5M2> into !x86.amx.tile<16x64xf8E5M2>
          %18 = x86.amx.tile_load %alloca[%16, %c16, %c0] : memref<2x32x64xf8E5M2> into !x86.amx.tile<16x64xf8E5M2>
          %19 = x86.amx.tile_load %subview_2[%c0, %c0] : memref<32x64xf8E5M2, strided<[256, 1], offset: ?>> into !x86.amx.tile<16x64xf8E5M2>
          %20 = x86.amx.tile_mulf %19, %17, %arg6 : !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>
          %21 = x86.amx.tile_mulf %19, %18, %arg7 : !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>
          %22 = x86.amx.tile_load %subview_2[%c16, %c0] : memref<32x64xf8E5M2, strided<[256, 1], offset: ?>> into !x86.amx.tile<16x64xf8E5M2>
          %23 = x86.amx.tile_mulf %22, %17, %arg8 : !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>
          %24 = x86.amx.tile_mulf %22, %18, %arg9 : !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>
          scf.yield %20, %21, %23, %24 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
        }
        %7:4 = scf.for %arg5 = %c192 to %c256 step %c64 iter_args(%arg6 = %6#0, %arg7 = %6#1, %arg8 = %6#2, %arg9 = %6#3) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
          %subview_2 = memref.subview %arg0[%arg3, %arg5] [32, 64] [1, 1] : memref<64x256xf8E5M2> to memref<32x64xf8E5M2, strided<[256, 1], offset: ?>>
          %12 = arith.divui %arg5, %c64 : index
          %13 = arith.remui %12, %c2 : index
          %14 = x86.amx.tile_load %alloca[%13, %c0, %c0] : memref<2x32x64xf8E5M2> into !x86.amx.tile<16x64xf8E5M2>
          %15 = x86.amx.tile_load %alloca[%13, %c16, %c0] : memref<2x32x64xf8E5M2> into !x86.amx.tile<16x64xf8E5M2>
          %16 = x86.amx.tile_load %subview_2[%c0, %c0] : memref<32x64xf8E5M2, strided<[256, 1], offset: ?>> into !x86.amx.tile<16x64xf8E5M2>
          %17 = x86.amx.tile_mulf %16, %14, %arg6 : !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>
          %18 = x86.amx.tile_mulf %16, %15, %arg7 : !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>
          %19 = x86.amx.tile_load %subview_2[%c16, %c0] : memref<32x64xf8E5M2, strided<[256, 1], offset: ?>> into !x86.amx.tile<16x64xf8E5M2>
          %20 = x86.amx.tile_mulf %19, %14, %arg8 : !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>
          %21 = x86.amx.tile_mulf %19, %15, %arg9 : !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x64xf8E5M2>, !x86.amx.tile<16x16xf32>
          scf.yield %17, %18, %20, %21 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
        }
        %alloca_1 = memref.alloca() : memref<32x32xf32>
        x86.amx.tile_store %alloca_1[%c0, %c0], %7#0 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        x86.amx.tile_store %alloca_1[%c0, %c16], %7#1 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        x86.amx.tile_store %alloca_1[%c16, %c0], %7#2 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        x86.amx.tile_store %alloca_1[%c16, %c16], %7#3 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
        scf.for %arg5 = %c0 to %c32 step %c1 {
          %12 = vector.load %alloca_1[%arg5, %c0] : memref<32x32xf32>, vector<16xf32>
          %13 = vector.load %alloca_1[%arg5, %c16] : memref<32x32xf32>, vector<16xf32>
          %14 = vector.shuffle %12, %13 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xf32>, vector<16xf32>
          %15 = vector.shuffle %12, %13 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xf32>, vector<16xf32>
          %16 = vector.load %subview[%arg5, %c0] : memref<32x32xf32, strided<[128, 1], offset: ?>>, vector<16xf32>
          %17 = vector.load %subview[%arg5, %c16] : memref<32x32xf32, strided<[128, 1], offset: ?>>, vector<16xf32>
          %18 = arith.addf %14, %16 : vector<16xf32>
          %19 = arith.addf %15, %17 : vector<16xf32>
          vector.store %18, %alloca_1[%arg5, %c0] : memref<32x32xf32>, vector<16xf32>
          vector.store %19, %alloca_1[%arg5, %c16] : memref<32x32xf32>, vector<16xf32>
        }
        %8 = vector.transfer_read %alloca_1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        %9 = vector.transfer_read %alloca_1[%c0, %c16], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        %10 = vector.transfer_read %alloca_1[%c16, %c0], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        %11 = vector.transfer_read %alloca_1[%c16, %c16], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
        vector.transfer_write %11, %subview[%c16, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %10, %subview[%c16, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %9, %subview[%c0, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %8, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
      }
    }
    %alloc = memref.alloc() : memref<64x128xf32>
    memref.copy %arg2, %alloc : memref<64x128xf32> to memref<64x128xf32>
    return %alloc : memref<64x128xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @brgemm_bf16_with_cano(%arg0: memref<16x32x16x2xbf16>, %arg1: memref<16x16x32x2xbf16>, %arg2: memref<32x32xf32>) -> memref<32x32xf32> {
    %0 = ub.poison : f32
    %c32 = arith.constant 32 : index
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %c1 = arith.constant 1 : index
    %1 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
    %2 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
    %3 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
    %4 = x86.amx.tile_zero : !x86.amx.tile<16x16xf32>
    %5:4 = scf.for %arg3 = %c0 to %c16 step %c1 iter_args(%arg4 = %1, %arg5 = %2, %arg6 = %3, %arg7 = %4) -> (!x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>) {
      %subview = memref.subview %arg0[%arg3, 0, 0, 0] [1, 32, 16, 2] [1, 1, 1, 1] : memref<16x32x16x2xbf16> to memref<1x32x16x2xbf16, strided<[1024, 32, 2, 1], offset: ?>>
      %subview_0 = memref.subview %arg1[%arg3, 0, 0, 0] [1, 16, 32, 2] [1, 1, 1, 1] : memref<16x16x32x2xbf16> to memref<1x16x32x2xbf16, strided<[1024, 64, 2, 1], offset: ?>>
      %collapse_shape = memref.collapse_shape %subview [[0], [1], [2, 3]] : memref<1x32x16x2xbf16, strided<[1024, 32, 2, 1], offset: ?>> into memref<1x32x32xbf16, strided<[1024, 32, 1], offset: ?>>
      %collapse_shape_1 = memref.collapse_shape %subview_0 [[0], [1], [2, 3]] : memref<1x16x32x2xbf16, strided<[1024, 64, 2, 1], offset: ?>> into memref<1x16x64xbf16, strided<[1024, 64, 1], offset: ?>>
      %10 = x86.amx.tile_load %collapse_shape[%c0, %c0, %c0] : memref<1x32x32xbf16, strided<[1024, 32, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
      %11 = x86.amx.tile_load %collapse_shape_1[%c0, %c0, %c0] : memref<1x16x64xbf16, strided<[1024, 64, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
      %12 = x86.amx.tile_mulf %10, %11, %arg4 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
      %13 = x86.amx.tile_load %collapse_shape_1[%c0, %c0, %c32] : memref<1x16x64xbf16, strided<[1024, 64, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
      %14 = x86.amx.tile_mulf %10, %13, %arg5 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
      %15 = x86.amx.tile_load %collapse_shape[%c0, %c16, %c0] : memref<1x32x32xbf16, strided<[1024, 32, 1], offset: ?>> into !x86.amx.tile<16x32xbf16>
      %16 = x86.amx.tile_mulf %15, %11, %arg6 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
      %17 = x86.amx.tile_mulf %15, %13, %arg7 : !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x32xbf16>, !x86.amx.tile<16x16xf32>
      scf.yield %12, %14, %16, %17 : !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>, !x86.amx.tile<16x16xf32>
    }
    %alloca = memref.alloca() : memref<32x32xf32>
    x86.amx.tile_store %alloca[%c0, %c0], %5#0 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
    x86.amx.tile_store %alloca[%c0, %c16], %5#1 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
    x86.amx.tile_store %alloca[%c16, %c0], %5#2 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
    x86.amx.tile_store %alloca[%c16, %c16], %5#3 : memref<32x32xf32>, !x86.amx.tile<16x16xf32>
    scf.for %arg3 = %c0 to %c32 step %c1 {
      %10 = vector.load %alloca[%arg3, %c0] : memref<32x32xf32>, vector<16xf32>
      %11 = vector.load %alloca[%arg3, %c16] : memref<32x32xf32>, vector<16xf32>
      %12 = vector.load %arg2[%arg3, %c0] : memref<32x32xf32>, vector<16xf32>
      %13 = vector.load %arg2[%arg3, %c16] : memref<32x32xf32>, vector<16xf32>
      %14 = arith.addf %10, %12 : vector<16xf32>
      %15 = arith.addf %11, %13 : vector<16xf32>
      vector.store %14, %alloca[%arg3, %c0] : memref<32x32xf32>, vector<16xf32>
      vector.store %15, %alloca[%arg3, %c16] : memref<32x32xf32>, vector<16xf32>
    }
    %6 = vector.transfer_read %alloca[%c0, %c0], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
    %7 = vector.transfer_read %alloca[%c0, %c16], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
    %8 = vector.transfer_read %alloca[%c16, %c0], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
    %9 = vector.transfer_read %alloca[%c16, %c16], %0 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
    vector.transfer_write %9, %arg2[%c16, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32>
    vector.transfer_write %8, %arg2[%c16, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32>
    vector.transfer_write %7, %arg2[%c0, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32>
    vector.transfer_write %6, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32>
    %alloc = memref.alloc() : memref<32x32xf32>
    memref.copy %arg2, %alloc : memref<32x32xf32> to memref<32x32xf32>
    return %alloc : memref<32x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @online_packing_int8_matmul_loop(%arg0: memref<64x256xi8>, %arg1: memref<256x128xi8>, %arg2: memref<64x128xi32>) -> memref<64x128xi32> {
    %0 = ub.poison : i32
    %c1 = arith.constant 1 : index
    %1 = ub.poison : i8
    %c2 = arith.constant 2 : index
    %c4 = arith.constant 4 : index
    %c192 = arith.constant 192 : index
    %c16 = arith.constant 16 : index
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c256 = arith.constant 256 : index
    %c32 = arith.constant 32 : index
    %cst = arith.constant dense<13> : vector<16x16xi32>
    scf.for %arg3 = %c0 to %c64 step %c32 {
      scf.for %arg4 = %c0 to %c128 step %c32 {
        %subview = memref.subview %arg2[%arg3, %arg4] [32, 32] [1, 1] : memref<64x128xi32> to memref<32x32xi32, strided<[128, 1], offset: ?>>
        %2 = x86.amx.tile_zero : !x86.amx.tile<16x16xi32>
        %3 = x86.amx.tile_zero : !x86.amx.tile<16x16xi32>
        %4 = x86.amx.tile_zero : !x86.amx.tile<16x16xi32>
        %5 = x86.amx.tile_zero : !x86.amx.tile<16x16xi32>
        %alloca = memref.alloca() : memref<2x32x64xi8>
        %subview_0 = memref.subview %arg1[%c0, %arg4] [64, 32] [1, 1] : memref<256x128xi8> to memref<64x32xi8, strided<[128, 1], offset: ?>>
        scf.for %arg5 = %c0 to %c64 step %c4 {
          %16 = vector.transfer_read %subview_0[%arg5, %c0], %1 {in_bounds = [true, true]} : memref<64x32xi8, strided<[128, 1], offset: ?>>, vector<2x32xi8>
          %17 = vector.shape_cast %16 : vector<2x32xi8> to vector<64xi8>
          %18 = arith.addi %arg5, %c2 : index
          %19 = vector.transfer_read %subview_0[%18, %c0], %1 {in_bounds = [true, true]} : memref<64x32xi8, strided<[128, 1], offset: ?>>, vector<2x32xi8>
          %20 = vector.shape_cast %19 : vector<2x32xi8> to vector<64xi8>
          %21 = vector.shuffle %17, %20 [0, 32, 64, 96, 1, 33, 65, 97, 2, 34, 66, 98, 3, 35, 67, 99, 8, 40, 72, 104, 9, 41, 73, 105, 10, 42, 74, 106, 11, 43, 75, 107, 16, 48, 80, 112, 17, 49, 81, 113, 18, 50, 82, 114, 19, 51, 83, 115, 24, 56, 88, 120, 25, 57, 89, 121, 26, 58, 90, 122, 27, 59, 91, 123] : vector<64xi8>, vector<64xi8>
          %22 = vector.shuffle %17, %20 [4, 36, 68, 100, 5, 37, 69, 101, 6, 38, 70, 102, 7, 39, 71, 103, 12, 44, 76, 108, 13, 45, 77, 109, 14, 46, 78, 110, 15, 47, 79, 111, 20, 52, 84, 116, 21, 53, 85, 117, 22, 54, 86, 118, 23, 55, 87, 119, 28, 60, 92, 124, 29, 61, 93, 125, 30, 62, 94, 126, 31, 63, 95, 127] : vector<64xi8>, vector<64xi8>
          %23 = arith.divui %arg5, %c4 : index
          %24 = arith.addi %23, %c16 : index
          vector.store %21, %alloca[%c0, %23, %c0] : memref<2x32x64xi8>, vector<64xi8>
          vector.store %22, %alloca[%c0, %24, %c0] : memref<2x32x64xi8>, vector<64xi8>
        }
        %6:4 = scf.for %arg5 = %c0 to %c192 step %c64 iter_args(%arg6 = %2, %arg7 = %3, %arg8 = %4, %arg9 = %5) -> (!x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>) {
          %subview_2 = memref.subview %arg0[%arg3, %arg5] [32, 64] [1, 1] : memref<64x256xi8> to memref<32x64xi8, strided<[256, 1], offset: ?>>
          %16 = arith.addi %arg5, %c64 : index
          %17 = arith.divui %16, %c64 : index
          %18 = arith.remui %17, %c2 : index
          %19 = arith.addi %18, %c1 : index
          %20 = arith.remui %19, %c2 : index
          %subview_3 = memref.subview %arg1[%16, %arg4] [64, 32] [1, 1] : memref<256x128xi8> to memref<64x32xi8, strided<[128, 1], offset: ?>>
          scf.for %arg10 = %c0 to %c64 step %c4 {
            %29 = vector.transfer_read %subview_3[%arg10, %c0], %1 {in_bounds = [true, true]} : memref<64x32xi8, strided<[128, 1], offset: ?>>, vector<2x32xi8>
            %30 = vector.shape_cast %29 : vector<2x32xi8> to vector<64xi8>
            %31 = arith.addi %arg10, %c2 : index
            %32 = vector.transfer_read %subview_3[%31, %c0], %1 {in_bounds = [true, true]} : memref<64x32xi8, strided<[128, 1], offset: ?>>, vector<2x32xi8>
            %33 = vector.shape_cast %32 : vector<2x32xi8> to vector<64xi8>
            %34 = vector.shuffle %30, %33 [0, 32, 64, 96, 1, 33, 65, 97, 2, 34, 66, 98, 3, 35, 67, 99, 8, 40, 72, 104, 9, 41, 73, 105, 10, 42, 74, 106, 11, 43, 75, 107, 16, 48, 80, 112, 17, 49, 81, 113, 18, 50, 82, 114, 19, 51, 83, 115, 24, 56, 88, 120, 25, 57, 89, 121, 26, 58, 90, 122, 27, 59, 91, 123] : vector<64xi8>, vector<64xi8>
            %35 = vector.shuffle %30, %33 [4, 36, 68, 100, 5, 37, 69, 101, 6, 38, 70, 102, 7, 39, 71, 103, 12, 44, 76, 108, 13, 45, 77, 109, 14, 46, 78, 110, 15, 47, 79, 111, 20, 52, 84, 116, 21, 53, 85, 117, 22, 54, 86, 118, 23, 55, 87, 119, 28, 60, 92, 124, 29, 61, 93, 125, 30, 62, 94, 126, 31, 63, 95, 127] : vector<64xi8>, vector<64xi8>
            %36 = arith.divui %arg10, %c4 : index
            %37 = arith.addi %36, %c16 : index
            vector.store %34, %alloca[%18, %36, %c0] : memref<2x32x64xi8>, vector<64xi8>
            vector.store %35, %alloca[%18, %37, %c0] : memref<2x32x64xi8>, vector<64xi8>
          }
          %21 = x86.amx.tile_load %alloca[%20, %c0, %c0] : memref<2x32x64xi8> into !x86.amx.tile<16x64xi8>
          %22 = x86.amx.tile_load %alloca[%20, %c16, %c0] : memref<2x32x64xi8> into !x86.amx.tile<16x64xi8>
          %23 = x86.amx.tile_load %subview_2[%c0, %c0] : memref<32x64xi8, strided<[256, 1], offset: ?>> into !x86.amx.tile<16x64xi8>
          %24 = x86.amx.tile_muli %23, %21, %arg6 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
          %25 = x86.amx.tile_muli %23, %22, %arg7 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
          %26 = x86.amx.tile_load %subview_2[%c16, %c0] : memref<32x64xi8, strided<[256, 1], offset: ?>> into !x86.amx.tile<16x64xi8>
          %27 = x86.amx.tile_muli %26, %21, %arg8 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
          %28 = x86.amx.tile_muli %26, %22, %arg9 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
          scf.yield %24, %25, %27, %28 : !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>
        }
        %7:4 = scf.for %arg5 = %c192 to %c256 step %c64 iter_args(%arg6 = %6#0, %arg7 = %6#1, %arg8 = %6#2, %arg9 = %6#3) -> (!x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>) {
          %subview_2 = memref.subview %arg0[%arg3, %arg5] [32, 64] [1, 1] : memref<64x256xi8> to memref<32x64xi8, strided<[256, 1], offset: ?>>
          %16 = arith.divui %arg5, %c64 : index
          %17 = arith.remui %16, %c2 : index
          %18 = x86.amx.tile_load %alloca[%17, %c0, %c0] : memref<2x32x64xi8> into !x86.amx.tile<16x64xi8>
          %19 = x86.amx.tile_load %alloca[%17, %c16, %c0] : memref<2x32x64xi8> into !x86.amx.tile<16x64xi8>
          %20 = x86.amx.tile_load %subview_2[%c0, %c0] : memref<32x64xi8, strided<[256, 1], offset: ?>> into !x86.amx.tile<16x64xi8>
          %21 = x86.amx.tile_muli %20, %18, %arg6 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
          %22 = x86.amx.tile_muli %20, %19, %arg7 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
          %23 = x86.amx.tile_load %subview_2[%c16, %c0] : memref<32x64xi8, strided<[256, 1], offset: ?>> into !x86.amx.tile<16x64xi8>
          %24 = x86.amx.tile_muli %23, %18, %arg8 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
          %25 = x86.amx.tile_muli %23, %19, %arg9 : !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x64xi8>, !x86.amx.tile<16x16xi32>
          scf.yield %21, %22, %24, %25 : !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>, !x86.amx.tile<16x16xi32>
        }
        %alloca_1 = memref.alloca() : memref<32x32xi32>
        x86.amx.tile_store %alloca_1[%c0, %c0], %7#0 : memref<32x32xi32>, !x86.amx.tile<16x16xi32>
        x86.amx.tile_store %alloca_1[%c0, %c16], %7#1 : memref<32x32xi32>, !x86.amx.tile<16x16xi32>
        x86.amx.tile_store %alloca_1[%c16, %c0], %7#2 : memref<32x32xi32>, !x86.amx.tile<16x16xi32>
        x86.amx.tile_store %alloca_1[%c16, %c16], %7#3 : memref<32x32xi32>, !x86.amx.tile<16x16xi32>
        scf.for %arg5 = %c0 to %c32 step %c1 {
          %16 = vector.load %alloca_1[%arg5, %c0] : memref<32x32xi32>, vector<16xi32>
          %17 = vector.load %alloca_1[%arg5, %c16] : memref<32x32xi32>, vector<16xi32>
          %18 = vector.shuffle %16, %17 [0, 1, 2, 3, 16, 17, 18, 19, 4, 5, 6, 7, 20, 21, 22, 23] : vector<16xi32>, vector<16xi32>
          %19 = vector.shuffle %16, %17 [8, 9, 10, 11, 24, 25, 26, 27, 12, 13, 14, 15, 28, 29, 30, 31] : vector<16xi32>, vector<16xi32>
          %20 = vector.load %subview[%arg5, %c0] : memref<32x32xi32, strided<[128, 1], offset: ?>>, vector<16xi32>
          %21 = vector.load %subview[%arg5, %c16] : memref<32x32xi32, strided<[128, 1], offset: ?>>, vector<16xi32>
          %22 = arith.addi %18, %20 : vector<16xi32>
          %23 = arith.addi %19, %21 : vector<16xi32>
          vector.store %22, %alloca_1[%arg5, %c0] : memref<32x32xi32>, vector<16xi32>
          vector.store %23, %alloca_1[%arg5, %c16] : memref<32x32xi32>, vector<16xi32>
        }
        %8 = vector.transfer_read %alloca_1[%c0, %c0], %0 {in_bounds = [true, true]} : memref<32x32xi32>, vector<16x16xi32>
        %9 = vector.transfer_read %alloca_1[%c0, %c16], %0 {in_bounds = [true, true]} : memref<32x32xi32>, vector<16x16xi32>
        %10 = vector.transfer_read %alloca_1[%c16, %c0], %0 {in_bounds = [true, true]} : memref<32x32xi32>, vector<16x16xi32>
        %11 = vector.transfer_read %alloca_1[%c16, %c16], %0 {in_bounds = [true, true]} : memref<32x32xi32>, vector<16x16xi32>
        %12 = arith.addi %11, %cst : vector<16x16xi32>
        %13 = arith.addi %10, %cst : vector<16x16xi32>
        %14 = arith.addi %9, %cst : vector<16x16xi32>
        %15 = arith.addi %8, %cst : vector<16x16xi32>
        vector.transfer_write %12, %subview[%c16, %c16] {in_bounds = [true, true]} : vector<16x16xi32>, memref<32x32xi32, strided<[128, 1], offset: ?>>
        vector.transfer_write %13, %subview[%c16, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<32x32xi32, strided<[128, 1], offset: ?>>
        vector.transfer_write %14, %subview[%c0, %c16] {in_bounds = [true, true]} : vector<16x16xi32>, memref<32x32xi32, strided<[128, 1], offset: ?>>
        vector.transfer_write %15, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<32x32xi32, strided<[128, 1], offset: ?>>
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
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_invalid_vc_kind(%arg0: memref<1x32x16x4xi8>, %arg1: memref<1x16x32x4xi8>, %arg2: memref<32x32xi32>) -> memref<32x32xi32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : i8
    %1 = ub.poison : i32
    %2 = vector.transfer_read %arg0[%c0, %c0, %c0, %c0], %0 {in_bounds = [true, true, true, true]} : memref<1x32x16x4xi8>, vector<1x16x16x4xi8>
    %3 = vector.transfer_read %arg1[%c0, %c0, %c0, %c0], %0 {in_bounds = [true, true, true, true]} : memref<1x16x32x4xi8>, vector<1x16x16x4xi8>
    %4 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<32x32xi32>, vector<16x16xi32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<mul>} %2, %3, %4 : vector<1x16x16x4xi8>, vector<1x16x16x4xi8> into vector<16x16xi32>
    vector.transfer_write %5, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<32x32xi32>
    return %arg2 : memref<32x32xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_wrong_dimensions(%arg0: memref<1x32x16x2xbf16>, %arg1: memref<1x16x32x2xbf16>, %arg2: memref<1x32x32xf32>) -> memref<1x32x32xf32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : bf16
    %1 = ub.poison : f32
    %2 = vector.transfer_read %arg0[%c0, %c0, %c0, %c0], %0 {in_bounds = [true, true, true, true]} : memref<1x32x16x2xbf16>, vector<1x32x16x2xbf16>
    %3 = vector.transfer_read %arg1[%c0, %c0, %c0, %c0], %0 {in_bounds = [true, true, true, true]} : memref<1x16x32x2xbf16>, vector<1x16x32x2xbf16>
    %4 = vector.transfer_read %arg2[%c0, %c0, %c0], %1 {in_bounds = [true, true, true]} : memref<1x32x32xf32>, vector<1x32x32xf32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %3, %4 : vector<1x32x16x2xbf16>, vector<1x16x32x2xbf16> into vector<1x32x32xf32>
    vector.transfer_write %5, %arg2[%c0, %c0, %c0] {in_bounds = [true, true, true]} : vector<1x32x32xf32>, memref<1x32x32xf32>
    return %arg2 : memref<1x32x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_no_memref_source_LHS(%arg0: vector<16x16x4xi8>, %arg1: memref<16x32x4xi8>, %arg2: memref<32x32xi32>) -> memref<32x32xi32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : i8
    %1 = ub.poison : i32
    %2 = vector.transfer_read %arg1[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : memref<16x32x4xi8>, vector<16x16x4xi8>
    %3 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<32x32xi32>, vector<16x16xi32>
    %4 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %arg0, %2, %3 : vector<16x16x4xi8>, vector<16x16x4xi8> into vector<16x16xi32>
    vector.transfer_write %4, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<32x32xi32>
    return %arg2 : memref<32x32xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_wrong_dimensions_online_packing(%arg0: memref<1x32x32xbf16>, %arg1: memref<1x32x32xbf16>, %arg2: memref<32x32xf32>) -> memref<32x32xf32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : bf16
    %1 = ub.poison : f32
    %2 = vector.transfer_read %arg0[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : memref<1x32x32xbf16>, vector<1x16x32xbf16>
    %3 = vector.transfer_read %arg1[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : memref<1x32x32xbf16>, vector<1x32x32xbf16>
    %4 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x32xf32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %3, %4 : vector<1x16x32xbf16>, vector<1x32x32xbf16> into vector<16x32xf32>
    vector.transfer_write %5, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x32xf32>, memref<32x32xf32>
    return %arg2 : memref<32x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_VCs_LHS_src_differ(%arg0: memref<64x64x4xi8>, %arg1: memref<64x128x4xi8>, %arg2: memref<64x128xi32>, %arg3: memref<64x64x4xi8>) {
    %0 = ub.poison : i32
    %1 = ub.poison : i8
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    scf.for %arg4 = %c0 to %c64 step %c16 {
      scf.for %arg5 = %c0 to %c128 step %c32 {
        %subview = memref.subview %arg2[%arg4, %arg5] [16, 32] [1, 1] : memref<64x128xi32> to memref<16x32xi32, strided<[128, 1], offset: ?>>
        %2 = vector.transfer_read %subview[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x32xi32, strided<[128, 1], offset: ?>>, vector<16x16xi32>
        %3 = vector.transfer_read %subview[%c0, %c16], %0 {in_bounds = [true, true]} : memref<16x32xi32, strided<[128, 1], offset: ?>>, vector<16x16xi32>
        %4:2 = scf.for %arg6 = %c0 to %c64 step %c16 iter_args(%arg7 = %2, %arg8 = %3) -> (vector<16x16xi32>, vector<16x16xi32>) {
          %subview_0 = memref.subview %arg0[%arg4, %arg6, 0] [16, 16, 4] [1, 1, 1] : memref<64x64x4xi8> to memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>>
          %subview_1 = memref.subview %arg3[%arg4, %arg6, 0] [16, 16, 4] [1, 1, 1] : memref<64x64x4xi8> to memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>>
          %subview_2 = memref.subview %arg1[%arg6, %arg5, 0] [16, 32, 4] [1, 1, 1] : memref<64x128x4xi8> to memref<16x32x4xi8, strided<[512, 4, 1], offset: ?>>
          %5 = vector.transfer_read %subview_0[%c0, %c0, %c0], %1 {in_bounds = [true, true, true]} : memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>>, vector<16x16x4xi8>
          %6 = vector.transfer_read %subview_1[%c0, %c0, %c0], %1 {in_bounds = [true, true, true]} : memref<16x16x4xi8, strided<[256, 4, 1], offset: ?>>, vector<16x16x4xi8>
          %7 = vector.transfer_read %subview_2[%c0, %c0, %c0], %1 {in_bounds = [true, true, true]} : memref<16x32x4xi8, strided<[512, 4, 1], offset: ?>>, vector<16x16x4xi8>
          %8 = vector.transfer_read %subview_2[%c0, %c16, %c0], %1 {in_bounds = [true, true, true]} : memref<16x32x4xi8, strided<[512, 4, 1], offset: ?>>, vector<16x16x4xi8>
          %9 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %5, %7, %arg7 {unroll_shape = array<i64: 4, 16, 16, 16>} : vector<16x16x4xi8>, vector<16x16x4xi8> into vector<16x16xi32>
          %10 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %6, %8, %arg8 {unroll_shape = array<i64: 4, 16, 16, 16>} : vector<16x16x4xi8>, vector<16x16x4xi8> into vector<16x16xi32>
          scf.yield %9, %10 : vector<16x16xi32>, vector<16x16xi32>
        }
        vector.transfer_write %4#1, %subview[%c0, %c16] {in_bounds = [true, true]} : vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>
        vector.transfer_write %4#0, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>
      }
    }
    return
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_wrong_N_dim(%arg0: memref<16x64x64x4xi8>, %arg1: memref<16x64x128x4xi8>, %arg2: memref<16x64x128xi32>) {
    %0 = ub.poison : i32
    %1 = ub.poison : i8
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c64 step %c16 {
      scf.for %arg4 = %c0 to %c128 step %c32 {
        scf.for %arg5 = %c0 to %c16 step %c1 {
          %subview = memref.subview %arg2[%arg5, %arg3, %arg4] [1, 16, 32] [1, 1, 1] : memref<16x64x128xi32> to memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>
          %2 = vector.transfer_read %subview[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>, vector<1x16x32xi32>
          %3 = scf.for %arg6 = %c0 to %c64 step %c16 iter_args(%arg7 = %2) -> (vector<1x16x32xi32>) {
            %subview_0 = memref.subview %arg0[%arg5, %arg3, %arg6, 0] [1, 16, 16, 4] [1, 1, 1, 1] : memref<16x64x64x4xi8> to memref<1x16x16x4xi8, strided<[16384, 256, 4, 1], offset: ?>>
            %subview_1 = memref.subview %arg1[%arg5, %arg6, %arg4, 0] [1, 16, 32, 4] [1, 1, 1, 1] : memref<16x64x128x4xi8> to memref<1x16x32x4xi8, strided<[32768, 512, 4, 1], offset: ?>>
            %4 = vector.transfer_read %subview_0[%c0, %c0, %c0, %c0], %1 {in_bounds = [true, true, true, true]} : memref<1x16x16x4xi8, strided<[16384, 256, 4, 1], offset: ?>>, vector<1x16x16x4xi8>
            %5 = vector.transfer_read %subview_1[%c0, %c0, %c0, %c0], %1 {in_bounds = [true, true, true, true]} : memref<1x16x32x4xi8, strided<[32768, 512, 4, 1], offset: ?>>, vector<1x16x32x4xi8>
            %6 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %5, %arg7 {unroll_shape = array<i64: 1, 4, 16, 32, 16>} : vector<1x16x16x4xi8>, vector<1x16x32x4xi8> into vector<1x16x32xi32>
            scf.yield %6 : vector<1x16x32xi32>
          }
          vector.transfer_write %3, %subview[%c0, %c0, %c0] {in_bounds = [true, true, true]} : vector<1x16x32xi32>, memref<1x16x32xi32, strided<[8192, 128, 1], offset: ?>>
        }
      }
    }
    return
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_online_packing_bf16_dynamic_loop_step(%arg0: memref<64x96xbf16>, %arg1: memref<96x128xbf16>, %arg2: memref<64x128xf32>, %arg3: index) -> memref<64x128xf32> {
    %0 = ub.poison : f32
    %1 = ub.poison : bf16
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    scf.for %arg4 = %c0 to %c64 step %c32 {
      scf.for %arg5 = %c0 to %c128 step %c32 {
        %subview = memref.subview %arg2[%arg4, %arg5] [32, 32] [1, 1] : memref<64x128xf32> to memref<32x32xf32, strided<[128, 1], offset: ?>>
        %2 = vector.transfer_read %subview[%c0, %c0], %0 {in_bounds = [true, true]} : memref<32x32xf32, strided<[128, 1], offset: ?>>, vector<16x16xf32>
        %3 = vector.transfer_read %subview[%c0, %c16], %0 {in_bounds = [true, true]} : memref<32x32xf32, strided<[128, 1], offset: ?>>, vector<16x16xf32>
        %4 = vector.transfer_read %subview[%c16, %c0], %0 {in_bounds = [true, true]} : memref<32x32xf32, strided<[128, 1], offset: ?>>, vector<16x16xf32>
        %5 = vector.transfer_read %subview[%c16, %c16], %0 {in_bounds = [true, true]} : memref<32x32xf32, strided<[128, 1], offset: ?>>, vector<16x16xf32>
        %6:4 = scf.for %arg6 = %c0 to %c32 step %arg3 iter_args(%arg7 = %2, %arg8 = %3, %arg9 = %4, %arg10 = %5) -> (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) {
          %subview_0 = memref.subview %arg0[%arg4, %arg6] [32, 32] [1, 1] : memref<64x96xbf16> to memref<32x32xbf16, strided<[96, 1], offset: ?>>
          %subview_1 = memref.subview %arg1[%arg6, %arg5] [32, 32] [1, 1] : memref<96x128xbf16> to memref<32x32xbf16, strided<[128, 1], offset: ?>>
          %7 = vector.transfer_read %subview_0[%c0, %c0], %1 {in_bounds = [true, true]} : memref<32x32xbf16, strided<[96, 1], offset: ?>>, vector<16x32xbf16>
          %8 = vector.transfer_read %subview_0[%c16, %c0], %1 {in_bounds = [true, true]} : memref<32x32xbf16, strided<[96, 1], offset: ?>>, vector<16x32xbf16>
          %9 = vector.transfer_read %subview_1[%c0, %c0], %1 {in_bounds = [true, true]} : memref<32x32xbf16, strided<[128, 1], offset: ?>>, vector<32x16xbf16>
          %10 = vector.transfer_read %subview_1[%c0, %c16], %1 {in_bounds = [true, true]} : memref<32x32xbf16, strided<[128, 1], offset: ?>>, vector<32x16xbf16>
          %11 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %7, %9, %arg7 {unroll_shape = array<i64: 1, 16, 16, 32>} : vector<16x32xbf16>, vector<32x16xbf16> into vector<16x16xf32>
          %12 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %7, %10, %arg8 {unroll_shape = array<i64: 1, 16, 16, 32>} : vector<16x32xbf16>, vector<32x16xbf16> into vector<16x16xf32>
          %13 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %8, %9, %arg9 {unroll_shape = array<i64: 1, 16, 16, 32>} : vector<16x32xbf16>, vector<32x16xbf16> into vector<16x16xf32>
          %14 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %8, %10, %arg10 {unroll_shape = array<i64: 1, 16, 16, 32>} : vector<16x32xbf16>, vector<32x16xbf16> into vector<16x16xf32>
          scf.yield %11, %12, %13, %14 : vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>
        }
        vector.transfer_write %6#3, %subview[%c16, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %6#2, %subview[%c16, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %6#1, %subview[%c0, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
        vector.transfer_write %6#0, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32, strided<[128, 1], offset: ?>>
      }
    }
    %alloc = memref.alloc() : memref<64x128xf32>
    memref.copy %arg2, %alloc : memref<64x128xf32> to memref<64x128xf32>
    return %alloc : memref<64x128xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d3, d5, d2)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d5, d4, d2)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d3, d4)>
module {
  func.func @negative_reduction_loop_depth_3(%arg0: memref<2x16x64x64x4xi8>, %arg1: memref<2x16x64x128x4xi8>, %arg2: memref<64x128xi32>) attributes {dlti.target_system_spec = #dlti.target_system_spec<"CPU" = #dlti.target_device_spec<"reg_gemm_unroll" = [16, 16, 16]>>} {
    %0 = ub.poison : i32
    %1 = ub.poison : i8
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c2 = arith.constant 2 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c64 step %c16 {
      scf.for %arg4 = %c0 to %c128 step %c32 {
        %subview = memref.subview %arg2[%arg3, %arg4] [16, 32] [1, 1] : memref<64x128xi32> to memref<16x32xi32, strided<[128, 1], offset: ?>>
        %2 = vector.transfer_read %subview[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x32xi32, strided<[128, 1], offset: ?>>, vector<16x16xi32>
        %3 = vector.transfer_read %subview[%c0, %c16], %0 {in_bounds = [true, true]} : memref<16x32xi32, strided<[128, 1], offset: ?>>, vector<16x16xi32>
        %4:2 = scf.for %arg5 = %c0 to %c2 step %c1 iter_args(%arg6 = %2, %arg7 = %3) -> (vector<16x16xi32>, vector<16x16xi32>) {
          %5:2 = scf.for %arg8 = %c0 to %c16 step %c1 iter_args(%arg9 = %arg6, %arg10 = %arg7) -> (vector<16x16xi32>, vector<16x16xi32>) {
            %6:2 = scf.for %arg11 = %c0 to %c64 step %c16 iter_args(%arg12 = %arg9, %arg13 = %arg10) -> (vector<16x16xi32>, vector<16x16xi32>) {
              %subview_0 = memref.subview %arg0[%arg5, %arg8, %arg3, %arg11, 0] [1, 1, 16, 16, 4] [1, 1, 1, 1, 1] : memref<2x16x64x64x4xi8> to memref<1x1x16x16x4xi8, strided<[262144, 16384, 256, 4, 1], offset: ?>>
              %subview_1 = memref.subview %arg1[%arg5, %arg8, %arg11, %arg4, 0] [1, 1, 16, 32, 4] [1, 1, 1, 1, 1] : memref<2x16x64x128x4xi8> to memref<1x1x16x32x4xi8, strided<[524288, 32768, 512, 4, 1], offset: ?>>
              %7 = vector.transfer_read %subview_0[%c0, %c0, %c0, %c0, %c0], %1 {in_bounds = [true, true, true, true, true]} : memref<1x1x16x16x4xi8, strided<[262144, 16384, 256, 4, 1], offset: ?>>, vector<1x1x16x16x4xi8>
              %8 = vector.transfer_read %subview_1[%c0, %c0, %c0, %c0, %c0], %1 {in_bounds = [true, true, true, true, true]} : memref<1x1x16x32x4xi8, strided<[524288, 32768, 512, 4, 1], offset: ?>>, vector<1x1x16x16x4xi8>
              %9 = vector.transfer_read %subview_1[%c0, %c0, %c0, %c16, %c0], %1 {in_bounds = [true, true, true, true, true]} : memref<1x1x16x32x4xi8, strided<[524288, 32768, 512, 4, 1], offset: ?>>, vector<1x1x16x16x4xi8>
              %10 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "reduction", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %7, %8, %arg12 {unroll_shape = array<i64: 1, 1, 4, 16, 16, 16>} : vector<1x1x16x16x4xi8>, vector<1x1x16x16x4xi8> into vector<16x16xi32>
              %11 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "reduction", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %7, %9, %arg13 {unroll_shape = array<i64: 1, 1, 4, 16, 16, 16>} : vector<1x1x16x16x4xi8>, vector<1x1x16x16x4xi8> into vector<16x16xi32>
              scf.yield %10, %11 : vector<16x16xi32>, vector<16x16xi32>
            }
            scf.yield %6#0, %6#1 : vector<16x16xi32>, vector<16x16xi32>
          }
          scf.yield %5#0, %5#1 : vector<16x16xi32>, vector<16x16xi32>
        }
        vector.transfer_write %4#1, %subview[%c0, %c16] {in_bounds = [true, true]} : vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>
        vector.transfer_write %4#0, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>
      }
    }
    return
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_wrong_type_f16(%arg0: memref<1x32x16x2xf16>, %arg1: memref<1x16x32x2xf16>, %arg2: memref<32x32xf32>) -> memref<32x32xf32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : f16
    %1 = ub.poison : f32
    %2 = vector.transfer_read %arg0[%c0, %c0, %c0, %c0], %0 {in_bounds = [true, true, true, true]} : memref<1x32x16x2xf16>, vector<1x16x16x2xf16>
    %3 = vector.transfer_read %arg1[%c0, %c0, %c0, %c0], %0 {in_bounds = [true, true, true, true]} : memref<1x16x32x2xf16>, vector<1x16x16x2xf16>
    %4 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<32x32xf32>, vector<16x16xf32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %3, %4 : vector<1x16x16x2xf16>, vector<1x16x16x2xf16> into vector<16x16xf32>
    vector.transfer_write %5, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<32x32xf32>
    return %arg2 : memref<32x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_wrong_acc_type_bf16(%arg0: memref<1x32x16x2xbf16>, %arg1: memref<1x16x32x2xbf16>, %arg2: memref<32x32xbf16>) -> memref<32x32xbf16> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : bf16
    %1 = vector.transfer_read %arg0[%c0, %c0, %c0, %c0], %0 {in_bounds = [true, true, true, true]} : memref<1x32x16x2xbf16>, vector<1x16x16x2xbf16>
    %2 = vector.transfer_read %arg1[%c0, %c0, %c0, %c0], %0 {in_bounds = [true, true, true, true]} : memref<1x16x32x2xbf16>, vector<1x16x16x2xbf16>
    %3 = vector.transfer_read %arg2[%c0, %c0], %0 {in_bounds = [true, true]} : memref<32x32xbf16>, vector<16x16xbf16>
    %4 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %1, %2, %3 : vector<1x16x16x2xbf16>, vector<1x16x16x2xbf16> into vector<16x16xbf16>
    vector.transfer_write %4, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xbf16>, memref<32x32xbf16>
    return %arg2 : memref<32x32xbf16>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_vc_wrong_order_no_pair(%arg0: memref<64x256xi8>, %arg1: memref<256x128xi8>, %arg2: memref<64x128xi32>) -> memref<64x128xi32> {
    %0 = ub.poison : i32
    %1 = ub.poison : i8
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c256 = arith.constant 256 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    scf.for %arg3 = %c0 to %c64 step %c16 {
      scf.for %arg4 = %c0 to %c128 step %c32 {
        %subview = memref.subview %arg2[%arg3, %arg4] [16, 32] [1, 1] : memref<64x128xi32> to memref<16x32xi32, strided<[128, 1], offset: ?>>
        %2 = vector.transfer_read %subview[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x32xi32, strided<[128, 1], offset: ?>>, vector<16x16xi32>
        %3 = vector.transfer_read %subview[%c0, %c16], %0 {in_bounds = [true, true]} : memref<16x32xi32, strided<[128, 1], offset: ?>>, vector<16x16xi32>
        %4:2 = scf.for %arg5 = %c0 to %c256 step %c64 iter_args(%arg6 = %2, %arg7 = %3) -> (vector<16x16xi32>, vector<16x16xi32>) {
          %subview_0 = memref.subview %arg0[%arg3, %arg5] [16, 64] [1, 1] : memref<64x256xi8> to memref<16x64xi8, strided<[256, 1], offset: ?>>
          %subview_1 = memref.subview %arg1[%arg5, %arg4] [64, 32] [1, 1] : memref<256x128xi8> to memref<64x32xi8, strided<[128, 1], offset: ?>>
          %5 = vector.transfer_read %subview_0[%c0, %c0], %1 {in_bounds = [true, true]} : memref<16x64xi8, strided<[256, 1], offset: ?>>, vector<16x64xi8>
          %6 = vector.transfer_read %subview_1[%c0, %c0], %1 {in_bounds = [true, true]} : memref<64x32xi8, strided<[128, 1], offset: ?>>, vector<64x16xi8>
          %7 = vector.transfer_read %subview_1[%c0, %c16], %1 {in_bounds = [true, true]} : memref<64x32xi8, strided<[128, 1], offset: ?>>, vector<64x16xi8>
          %8 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %5, %7, %arg7 {unroll_shape = array<i64: 16, 16, 64>} : vector<16x64xi8>, vector<64x16xi8> into vector<16x16xi32>
          %9 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %5, %6, %arg6 {unroll_shape = array<i64: 16, 16, 64>} : vector<16x64xi8>, vector<64x16xi8> into vector<16x16xi32>
          scf.yield %9, %8 : vector<16x16xi32>, vector<16x16xi32>
        }
        vector.transfer_write %4#1, %subview[%c0, %c16] {in_bounds = [true, true]} : vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>
        vector.transfer_write %4#0, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<16x32xi32, strided<[128, 1], offset: ?>>
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
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_vc_no_pair(%arg0: memref<64x256xi8>, %arg1: memref<256x128xi8>, %arg2: memref<64x128xi32>) -> memref<64x128xi32> {
    %0 = ub.poison : i32
    %1 = ub.poison : i8
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c128 = arith.constant 128 : index
    %c256 = arith.constant 256 : index
    %c32 = arith.constant 32 : index
    %c16 = arith.constant 16 : index
    scf.for %arg3 = %c0 to %c64 step %c32 {
      scf.for %arg4 = %c0 to %c128 step %c16 {
        %subview = memref.subview %arg2[%arg3, %arg4] [32, 16] [1, 1] : memref<64x128xi32> to memref<32x16xi32, strided<[128, 1], offset: ?>>
        %2 = vector.transfer_read %subview[%c0, %c0], %0 {in_bounds = [true, true]} : memref<32x16xi32, strided<[128, 1], offset: ?>>, vector<16x16xi32>
        %3 = vector.transfer_read %subview[%c16, %c0], %0 {in_bounds = [true, true]} : memref<32x16xi32, strided<[128, 1], offset: ?>>, vector<16x16xi32>
        %4:2 = scf.for %arg5 = %c0 to %c256 step %c64 iter_args(%arg6 = %2, %arg7 = %3) -> (vector<16x16xi32>, vector<16x16xi32>) {
          %subview_0 = memref.subview %arg0[%arg3, %arg5] [32, 64] [1, 1] : memref<64x256xi8> to memref<32x64xi8, strided<[256, 1], offset: ?>>
          %subview_1 = memref.subview %arg1[%arg5, %arg4] [64, 16] [1, 1] : memref<256x128xi8> to memref<64x16xi8, strided<[128, 1], offset: ?>>
          %5 = vector.transfer_read %subview_0[%c0, %c0], %1 {in_bounds = [true, true]} : memref<32x64xi8, strided<[256, 1], offset: ?>>, vector<16x64xi8>
          %6 = vector.transfer_read %subview_0[%c16, %c0], %1 {in_bounds = [true, true]} : memref<32x64xi8, strided<[256, 1], offset: ?>>, vector<16x64xi8>
          %7 = vector.transfer_read %subview_1[%c0, %c0], %1 {in_bounds = [true, true]} : memref<64x16xi8, strided<[128, 1], offset: ?>>, vector<64x16xi8>
          %8 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %5, %7, %arg6 {unroll_shape = array<i64: 16, 16, 64>} : vector<16x64xi8>, vector<64x16xi8> into vector<16x16xi32>
          %9 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %6, %7, %arg7 {unroll_shape = array<i64: 16, 16, 64>} : vector<16x64xi8>, vector<64x16xi8> into vector<16x16xi32>
          scf.yield %8, %9 : vector<16x16xi32>, vector<16x16xi32>
        }
        vector.transfer_write %4#1, %subview[%c16, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<32x16xi32, strided<[128, 1], offset: ?>>
        vector.transfer_write %4#0, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<32x16xi32, strided<[128, 1], offset: ?>>
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
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_no_read_op_source(%arg0: memref<16x64x32xbf16>, %arg1: memref<16x32x128xbf16>, %arg2: memref<64x32xf32>) {
    %0 = ub.poison : f32
    %1 = ub.poison : bf16
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c16 = arith.constant 16 : index
    %c32 = arith.constant 32 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c64 step %c32 {
      %2 = vector.transfer_read %arg2[%arg3, %c0], %0 {in_bounds = [true, true]} : memref<64x32xf32>, vector<16x16xf32>
      %3 = vector.transfer_read %arg2[%arg3, %c16], %0 {in_bounds = [true, true]} : memref<64x32xf32>, vector<16x16xf32>
      %4 = arith.addi %arg3, %c16 : index
      %5 = vector.transfer_read %arg2[%4, %c0], %0 {in_bounds = [true, true]} : memref<64x32xf32>, vector<16x16xf32>
      %6 = vector.transfer_read %arg2[%4, %c16], %0 {in_bounds = [true, true]} : memref<64x32xf32>, vector<16x16xf32>
      %7:4 = scf.for %arg4 = %c0 to %c16 step %c1 iter_args(%arg5 = %2, %arg6 = %3, %arg7 = %5, %arg8 = %6) -> (vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>) {
        %8 = vector.transfer_read %arg0[%arg4, %arg3, %c0], %1 {in_bounds = [true, true, true]} : memref<16x64x32xbf16>, vector<1x16x32xbf16>
        %9 = vector.transfer_read %arg0[%arg4, %4, %c0], %1 {in_bounds = [true, true, true]} : memref<16x64x32xbf16>, vector<1x16x32xbf16>
        %10 = vector.transfer_read %arg1[%arg4, %c0, %c0], %1 {in_bounds = [true, true, true]} : memref<16x32x128xbf16>, vector<1x32x16xbf16>
        %11 = vector.transfer_read %arg1[%arg4, %c0, %c16], %1 {in_bounds = [true, true, true]} : memref<16x32x128xbf16>, vector<1x32x16xbf16>
        %12 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %8, %10, %arg5 : vector<1x16x32xbf16>, vector<1x32x16xbf16> into vector<16x16xf32>
        %13 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %8, %11, %arg6 : vector<1x16x32xbf16>, vector<1x32x16xbf16> into vector<16x16xf32>
        %14 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %9, %10, %arg7 : vector<1x16x32xbf16>, vector<1x32x16xbf16> into vector<16x16xf32>
        %15 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %9, %11, %arg8 : vector<1x16x32xbf16>, vector<1x32x16xbf16> into vector<16x16xf32>
        scf.yield %12, %13, %14, %15 : vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>, vector<16x16xf32>
      }
      vector.transfer_write %7#3, %arg2[%4, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<64x32xf32>
      vector.transfer_write %7#2, %arg2[%4, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<64x32xf32>
      vector.transfer_write %7#1, %arg2[%arg3, %c16] {in_bounds = [true, true]} : vector<16x16xf32>, memref<64x32xf32>
      vector.transfer_write %7#0, %arg2[%arg3, %c0] {in_bounds = [true, true]} : vector<16x16xf32>, memref<64x32xf32>
    }
    return
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_lhs_tensor(%arg0: tensor<32x16x4xi8>, %arg1: memref<16x32x4xi8>, %arg2: memref<32x32xi32>) -> memref<32x32xi32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : i8
    %1 = ub.poison : i32
    %2 = vector.transfer_read %arg0[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : tensor<32x16x4xi8>, vector<16x16x4xi8>
    %3 = vector.transfer_read %arg1[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : memref<16x32x4xi8>, vector<16x16x4xi8>
    %4 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<32x32xi32>, vector<16x16xi32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %3, %4 : vector<16x16x4xi8>, vector<16x16x4xi8> into vector<16x16xi32>
    vector.transfer_write %5, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<32x32xi32>
    return %arg2 : memref<32x32xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_rhs_tensor(%arg0: memref<32x16x4xi8>, %arg1: tensor<16x32x4xi8>, %arg2: memref<32x32xi32>) -> memref<32x32xi32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : i8
    %1 = ub.poison : i32
    %2 = vector.transfer_read %arg0[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : memref<32x16x4xi8>, vector<16x16x4xi8>
    %3 = vector.transfer_read %arg1[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : tensor<16x32x4xi8>, vector<16x16x4xi8>
    %4 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : memref<32x32xi32>, vector<16x16xi32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %3, %4 : vector<16x16x4xi8>, vector<16x16x4xi8> into vector<16x16xi32>
    vector.transfer_write %5, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, memref<32x32xi32>
    return %arg2 : memref<32x32xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
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
  func.func @negative_acc_tensor(%arg0: memref<32x16x4xi8>, %arg1: memref<16x32x4xi8>, %arg2: tensor<32x32xi32>) -> tensor<32x32xi32> {
    %c0 = arith.constant 0 : index
    %0 = ub.poison : i8
    %1 = ub.poison : i32
    %2 = vector.transfer_read %arg0[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : memref<32x16x4xi8>, vector<16x16x4xi8>
    %3 = vector.transfer_read %arg1[%c0, %c0, %c0], %0 {in_bounds = [true, true, true]} : memref<16x32x4xi8>, vector<16x16x4xi8>
    %4 = vector.transfer_read %arg2[%c0, %c0], %1 {in_bounds = [true, true]} : tensor<32x32xi32>, vector<16x16xi32>
    %5 = vector.contract {indexing_maps = [#map, #map1, #map2], iterator_types = ["reduction", "parallel", "parallel", "reduction"], kind = #vector.kind<add>} %2, %3, %4 : vector<16x16x4xi8>, vector<16x16x4xi8> into vector<16x16xi32>
    %6 = vector.transfer_write %5, %arg2[%c0, %c0] {in_bounds = [true, true]} : vector<16x16xi32>, tensor<32x32xi32>
    return %6 : tensor<32x32xi32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.x86.vector_contract_to_amx_dot_product
      } : !transform.any_op
      transform.yield 
    }
  }
}

