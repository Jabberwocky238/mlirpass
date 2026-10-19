module {
  func.func @test_subi_zero(%arg0: i32) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
  func.func @test_subi_zero_vector(%arg0: vector<4xi32>) -> vector<4xi32> {
    %cst = arith.constant dense<0> : vector<4xi32>
    return %cst : vector<4xi32>
  }
  func.func @test_subi_zero_tensor(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    %cst = arith.constant dense<0> : tensor<4x5xi32>
    return %cst : tensor<4x5xi32>
  }
  func.func @dim(%arg0: tensor<8x4xf32>) -> index {
    %c4 = arith.constant 4 : index
    return %c4 : index
  }
  func.func @test_commutative(%arg0: i32) -> (i32, i32) {
    %c42_i32 = arith.constant 42 : i32
    %0 = arith.addi %arg0, %c42_i32 : i32
    %1 = arith.subi %c42_i32, %arg0 : i32
    return %0, %1 : i32, i32
  }
  func.func @trivial_dce(%arg0: tensor<8x4xf32>) {
    return
  }
  func.func @load_dce(%arg0: index) {
    return
  }
  func.func @addi_zero(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @addi_zero_index(%arg0: index) -> index {
    return %arg0 : index
  }
  func.func @addi_zero_vector(%arg0: vector<4xi32>) -> vector<4xi32> {
    return %arg0 : vector<4xi32>
  }
  func.func @addi_zero_tensor(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    return %arg0 : tensor<4x5xi32>
  }
  func.func @muli_zero(%arg0: i32) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
  func.func @muli_zero_index(%arg0: index) -> index {
    %c0 = arith.constant 0 : index
    return %c0 : index
  }
  func.func @muli_zero_vector(%arg0: vector<4xi32>) -> vector<4xi32> {
    %cst = arith.constant dense<0> : vector<4xi32>
    return %cst : vector<4xi32>
  }
  func.func @muli_zero_tensor(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    %cst = arith.constant dense<0> : tensor<4x5xi32>
    return %cst : tensor<4x5xi32>
  }
  func.func @muli_one(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @muli_one_index(%arg0: index) -> index {
    return %arg0 : index
  }
  func.func @muli_one_vector(%arg0: vector<4xi32>) -> vector<4xi32> {
    return %arg0 : vector<4xi32>
  }
  func.func @muli_one_tensor(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    return %arg0 : tensor<4x5xi32>
  }
  func.func @and_self(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @and_self_vector(%arg0: vector<4xi32>) -> vector<4xi32> {
    return %arg0 : vector<4xi32>
  }
  func.func @and_self_tensor(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    return %arg0 : tensor<4x5xi32>
  }
  func.func @and_zero(%arg0: i32) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
  func.func @and_zero_index(%arg0: index) -> index {
    %c0 = arith.constant 0 : index
    return %c0 : index
  }
  func.func @and_zero_vector(%arg0: vector<4xi32>) -> vector<4xi32> {
    %cst = arith.constant dense<0> : vector<4xi32>
    return %cst : vector<4xi32>
  }
  func.func @and_zero_tensor(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    %cst = arith.constant dense<0> : tensor<4x5xi32>
    return %cst : tensor<4x5xi32>
  }
  func.func @or_self(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @or_self_vector(%arg0: vector<4xi32>) -> vector<4xi32> {
    return %arg0 : vector<4xi32>
  }
  func.func @or_self_tensor(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    return %arg0 : tensor<4x5xi32>
  }
  func.func @or_zero(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @or_zero_index(%arg0: index) -> index {
    return %arg0 : index
  }
  func.func @or_zero_vector(%arg0: vector<4xi32>) -> vector<4xi32> {
    return %arg0 : vector<4xi32>
  }
  func.func @or_zero_tensor(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    return %arg0 : tensor<4x5xi32>
  }
  func.func @or_all_ones(%arg0: i1, %arg1: i4) -> (i1, i4) {
    %true = arith.constant true
    %c-1_i4 = arith.constant -1 : i4
    return %true, %c-1_i4 : i1, i4
  }
  func.func @xor_self(%arg0: i32) -> i32 {
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
  func.func @xor_self_vector(%arg0: vector<4xi32>) -> vector<4xi32> {
    %cst = arith.constant dense<0> : vector<4xi32>
    return %cst : vector<4xi32>
  }
  func.func @xor_self_tensor(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    %cst = arith.constant dense<0> : tensor<4x5xi32>
    return %cst : tensor<4x5xi32>
  }
  func.func @memref_cast_folding(%arg0: memref<4xf32>, %arg1: f32) -> (f32, f32) {
    %c0 = arith.constant 0 : index
    %0 = affine.load %arg0[3] : memref<4xf32>
    memref.store %arg1, %arg0[%c0] : memref<4xf32>
    %1 = memref.load %arg0[%c0] : memref<4xf32>
    memref.dealloc %arg0 : memref<4xf32>
    return %0, %1 : f32, f32
  }
  func.func @fold_memref_cast_in_memref_cast(%arg0: memref<42x42xf64>) {
    %cast = memref.cast %arg0 : memref<42x42xf64> to memref<?x?xf64>
    "test.user"(%cast) : (memref<?x?xf64>) -> ()
    return
  }
  func.func @fold_memref_cast_chain(%arg0: memref<42x42xf64>) {
    "test.user"(%arg0) : (memref<42x42xf64>) -> ()
    return
  }
  func.func @dead_alloc_fold() {
    return
  }
  func.func @dead_dealloc_fold() {
    return
  }
  func.func @dead_dealloc_fold_multi_use(%arg0: i1) {
    cf.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    return
  ^bb2:  // pred: ^bb0
    return
  }
  func.func @write_only_alloc_fold(%arg0: f32) {
    return
  }
  func.func @write_only_alloca_fold(%arg0: f32) {
    return
  }
  func.func @dead_block_elim() {
    builtin.module {
      func.func @nested() {
        return
      }
    }
    return
  }
  func.func @dyn_shape_fold(%arg0: index, %arg1: index) -> (memref<4x?x8x?x?xf32>, memref<?x?xi32>, memref<?x?xf32>, memref<4x?x8x?x?xf32>) {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc(%arg0) : memref<?x1024xf32>
    %alloc_0 = memref.alloc(%arg1) : memref<4x1024x8x512x?xf32>
    %cast = memref.cast %alloc_0 : memref<4x1024x8x512x?xf32> to memref<4x?x8x?x?xf32>
    %alloc_1 = memref.alloc() : memref<512x1024xi32>
    %cast_2 = memref.cast %alloc_1 : memref<512x1024xi32> to memref<?x?xi32>
    %alloc_3 = memref.alloc() : memref<9x9xf32>
    %cast_4 = memref.cast %alloc_3 : memref<9x9xf32> to memref<?x?xf32>
    %alloca = memref.alloca(%arg1) : memref<4x1024x8x512x?xf32>
    %cast_5 = memref.cast %alloca : memref<4x1024x8x512x?xf32> to memref<4x?x8x?x?xf32>
    affine.for %arg2 = 0 to %arg0 {
      affine.for %arg3 = 0 to 10 {
        %0 = memref.load %alloc[%arg2, %arg3] : memref<?x1024xf32>
        memref.store %0, %alloc_0[%c0, %c0, %arg2, %arg3, %c0] : memref<4x1024x8x512x?xf32>
      }
    }
    return %cast, %cast_2, %cast_4, %cast_5 : memref<4x?x8x?x?xf32>, memref<?x?xi32>, memref<?x?xf32>, memref<4x?x8x?x?xf32>
  }
  func.func @dim_op_fold(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<?xi8>, %arg4: index, %arg5: index, %arg6: index) {
    %c1 = arith.constant 1 : index
    affine.for %arg7 = 0 to %arg2 {
      affine.for %arg8 = 0 to %arg0 {
        affine.for %arg9 = %arg0 to %arg0 {
          "foo"() : () -> ()
        }
        scf.for %arg9 = %arg0 to %arg8 step %c1 {
          "foo"() : () -> ()
        }
      }
    }
    return
  }
  func.func @merge_constants() -> (index, index) {
    %c42 = arith.constant 42 : index
    return %c42, %c42 : index, index
  }
  func.func @hoist_constant(%arg0: memref<8xi32>) {
    %c42_i32 = arith.constant 42 : i32
    affine.for %arg1 = 0 to 8 {
      memref.store %c42_i32, %arg0[%arg1] : memref<8xi32>
    }
    return
  }
  func.func @const_fold_propagate() -> memref<?x?xf32> {
    %alloc = memref.alloc() : memref<64x32xf32>
    %cast = memref.cast %alloc : memref<64x32xf32> to memref<?x?xf32>
    return %cast : memref<?x?xf32>
  }
  func.func @indirect_target() {
    return
  }
  func.func @indirect_call_folding() {
    call @indirect_target() : () -> ()
    return
  }
  func.func @lowered_affine_mod() -> (index, index) {
    %c41 = arith.constant 41 : index
    %c1 = arith.constant 1 : index
    return %c41, %c1 : index, index
  }
  func.func @lowered_affine_floordiv() -> (index, index) {
    %c-2 = arith.constant -2 : index
    %c1 = arith.constant 1 : index
    return %c-2, %c1 : index, index
  }
  func.func @lowered_affine_ceildiv() -> (index, index) {
    %c-1 = arith.constant -1 : index
    %c2 = arith.constant 2 : index
    return %c-1, %c2 : index, index
  }
  func.func @cast_values(%arg0: memref<?xi32>) -> memref<2xi32> {
    %cast = memref.cast %arg0 : memref<?xi32> to memref<2xi32>
    return %cast : memref<2xi32>
  }
}

// -----
module {
  func.func @view(%arg0: index) -> (f32, f32, f32, f32) {
    %c15 = arith.constant 15 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<2048xi8>
    %view = memref.view %alloc[%c15][] : memref<2048xi8> to memref<7x11xf32>
    %0 = memref.load %view[%c0, %c0] : memref<7x11xf32>
    %view_0 = memref.view %alloc[%c15][%arg0, %arg0] : memref<2048xi8> to memref<?x?x7xf32>
    %1 = memref.load %view_0[%c0, %c0, %c0] : memref<?x?x7xf32>
    %view_1 = memref.view %alloc[%c15][] : memref<2048xi8> to memref<7x4xf32>
    %2 = memref.load %view_1[%c0, %c0] : memref<7x4xf32>
    %view_2 = memref.view %alloc[%c15][] : memref<2048xi8> to memref<15x7xf32>
    %3 = memref.load %view_2[%c0, %c0] : memref<15x7xf32>
    return %0, %1, %2, %3 : f32, f32, f32, f32
  }
}

// -----
#set = affine_set<(d0) : (d0 - 2 >= 0)>
module {
  func.func @subview(%arg0: index, %arg1: index) -> (index, index) {
    %c11 = arith.constant 11 : index
    %c7 = arith.constant 7 : index
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<128x96x64xf32, strided<[6144, 64, 1]>>
    %subview = memref.subview %alloc[0, 0, 0] [7, 11, 2] [1, 1, 1] : memref<128x96x64xf32, strided<[6144, 64, 1]>> to memref<7x11x2xf32, strided<[6144, 64, 1]>>
    %0 = memref.load %subview[%c0, %c0, %c0] : memref<7x11x2xf32, strided<[6144, 64, 1]>>
    %subview_0 = memref.subview %alloc[0, %arg0, 0] [7, 11, 15] [1, 1, 1] : memref<128x96x64xf32, strided<[6144, 64, 1]>> to memref<7x11x15xf32, strided<[6144, 64, 1], offset: ?>>
    memref.store %0, %subview_0[%c0, %c0, %c0] : memref<7x11x15xf32, strided<[6144, 64, 1], offset: ?>>
    %alloc_1 = memref.alloc(%arg0) : memref<?x16x4xf32, strided<[64, 4, 1]>>
    %subview_2 = memref.subview %alloc_1[0, 0, 0] [7, 11, 2] [1, 1, 1] : memref<?x16x4xf32, strided<[64, 4, 1]>> to memref<7x11x2xf32, strided<[64, 4, 1]>>
    memref.store %0, %subview_2[%c0, %c0, %c0] : memref<7x11x2xf32, strided<[64, 4, 1]>>
    %subview_3 = memref.subview %alloc[1, 2, 7] [7, 11, 2] [1, 1, 1] : memref<128x96x64xf32, strided<[6144, 64, 1]>> to memref<7x11x2xf32, strided<[6144, 64, 1], offset: 6279>>
    memref.store %0, %subview_3[%c0, %c0, %c0] : memref<7x11x2xf32, strided<[6144, 64, 1], offset: 6279>>
    %subview_4 = memref.subview %alloc[0, 0, 0] [7, 11, 2] [2, 7, 11] : memref<128x96x64xf32, strided<[6144, 64, 1]>> to memref<7x11x2xf32, strided<[12288, 448, 11]>>
    memref.store %0, %subview_4[%c0, %c0, %c0] : memref<7x11x2xf32, strided<[12288, 448, 11]>>
    %subview_5 = memref.subview %alloc[%arg0, %arg0, %arg0] [7, 11, 2] [%arg1, %arg1, %arg1] : memref<128x96x64xf32, strided<[6144, 64, 1]>> to memref<7x11x2xf32, strided<[?, ?, ?], offset: ?>>
    memref.store %0, %subview_5[%arg1, %arg1, %arg1] : memref<7x11x2xf32, strided<[?, ?, ?], offset: ?>>
    %subview_6 = memref.subview %alloc[%arg0, %arg0, %arg0] [%arg1, %arg1, %arg1] [2, 7, 11] : memref<128x96x64xf32, strided<[6144, 64, 1]>> to memref<?x?x?xf32, strided<[12288, 448, 11], offset: ?>>
    memref.store %0, %subview_6[%arg0, %arg0, %arg0] : memref<?x?x?xf32, strided<[12288, 448, 11], offset: ?>>
    %subview_7 = memref.subview %alloc[1, 2, 7] [%arg1, %arg1, %arg1] [%arg0, %arg0, %arg0] : memref<128x96x64xf32, strided<[6144, 64, 1]>> to memref<?x?x?xf32, strided<[?, ?, ?], offset: 6279>>
    memref.store %0, %subview_7[%arg1, %arg1, %arg1] : memref<?x?x?xf32, strided<[?, ?, ?], offset: 6279>>
    %alloc_8 = memref.alloc(%arg0, %arg0, %arg1) : memref<?x?x?xf32>
    %subview_9 = memref.subview %alloc_8[%arg0, %arg0, %arg0] [7, 11, 2] [%arg1, %arg1, %arg1] : memref<?x?x?xf32> to memref<7x11x2xf32, strided<[?, ?, ?], offset: ?>>
    memref.store %0, %subview_9[%arg1, %arg1, %arg1] : memref<7x11x2xf32, strided<[?, ?, ?], offset: ?>>
    %subview_10 = memref.subview %alloc_8[%arg0, %arg0, %arg0] [%arg1, %arg1, %arg1] [2, 2, 2] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, 2], offset: ?>>
    memref.store %0, %subview_10[%arg0, %arg0, %arg0] : memref<?x?x?xf32, strided<[?, ?, 2], offset: ?>>
    %subview_11 = memref.subview %alloc_8[1, 1, 1] [%arg0, %arg0, %arg0] [%arg1, %arg1, %arg1] : memref<?x?x?xf32> to memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    memref.store %0, %subview_11[%arg0, %arg0, %arg0] : memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
    %alloc_12 = memref.alloc() : memref<128x64xf32>
    %subview_13 = memref.subview %alloc_12[%arg1, %arg1] [2, 4] [1, 1] : memref<128x64xf32> to memref<2x4xf32, strided<[64, 1], offset: ?>>
    memref.store %0, %subview_13[%arg1, %arg1] : memref<2x4xf32, strided<[64, 1], offset: ?>>
    %subview_14 = memref.subview %alloc_12[2, 4] [12, 4] [1, 1] : memref<128x64xf32> to memref<12x4xf32, strided<[64, 1], offset: 132>>
    memref.store %0, %subview_14[%arg1, %arg1] : memref<12x4xf32, strided<[64, 1], offset: 132>>
    return %c7, %c11 : index, index
  }
  func.func @index_cast(%arg0: i16) -> i16 {
    return %arg0 : i16
  }
  func.func @index_cast_fold() -> (i16, index) {
    %c4_i16 = arith.constant 4 : i16
    %c4 = arith.constant 4 : index
    return %c4_i16, %c4 : i16, index
  }
  func.func @remove_dead_else(%arg0: memref<100xi32>) {
    affine.for %arg1 = 0 to 100 {
      affine.if #set(%arg1) {
        affine.for %arg2 = 0 to 100 {
          %0 = affine.load %arg0[%arg2] : memref<100xi32>
          "prevent.dce"(%0) : (i32) -> ()
        }
      }
    }
    return
  }
}

// -----
module {
  func.func @divi_signed_by_one(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @divi_unsigned_by_one(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @tensor_divi_signed_by_one(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    return %arg0 : tensor<4x5xi32>
  }
  func.func @tensor_divi_unsigned_by_one(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    return %arg0 : tensor<4x5xi32>
  }
}

// -----
module {
  func.func @arith.floordivsi_by_one(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @tensor_arith.floordivsi_by_one(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    return %arg0 : tensor<4x5xi32>
  }
  func.func @arith.floordivsi_by_one_overflow() -> i64 {
    %c-1_i64 = arith.constant -1 : i64
    %c-9223372036854775808_i64 = arith.constant -9223372036854775808 : i64
    %0 = arith.floordivsi %c-9223372036854775808_i64, %c-1_i64 : i64
    return %0 : i64
  }
}

// -----
module {
  func.func @arith.ceildivsi_by_one(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @tensor_arith.ceildivsi_by_one(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    return %arg0 : tensor<4x5xi32>
  }
}

// -----
module {
  func.func @arith.ceildivui_by_one(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
  func.func @tensor_arith.ceildivui_by_one(%arg0: tensor<4x5xi32>) -> tensor<4x5xi32> {
    return %arg0 : tensor<4x5xi32>
  }
}

// -----
module {
  func.func @memref_cast_folding_subview(%arg0: memref<4x5xf32>, %arg1: index) -> memref<?x?xf32, strided<[?, ?], offset: ?>> {
    %subview = memref.subview %arg0[%arg1, %arg1] [%arg1, %arg1] [%arg1, %arg1] : memref<4x5xf32> to memref<?x?xf32, strided<[?, ?], offset: ?>>
    return %subview : memref<?x?xf32, strided<[?, ?], offset: ?>>
  }
}

// -----
module {
  func.func @memref_cast_folding_subview_static(%arg0: memref<16x16xf32>, %arg1: index, %arg2: index) -> memref<3x4xf32, strided<[?, 1]>> {
    %subview = memref.subview %arg0[0, 0] [3, 4] [1, 1] : memref<16x16xf32> to memref<3x4xf32, strided<[16, 1]>>
    %cast = memref.cast %subview : memref<3x4xf32, strided<[16, 1]>> to memref<3x4xf32, strided<[?, 1]>>
    return %cast : memref<3x4xf32, strided<[?, 1]>>
  }
}

// -----
module {
  func.func @slice(%arg0: tensor<8x16x4xf32>, %arg1: index, %arg2: index) -> tensor<?x?x?xf32> {
    %extracted_slice = tensor.extract_slice %arg0[0, 0, 0] [7, 11, 2] [1, 1, 1] : tensor<8x16x4xf32> to tensor<7x11x2xf32>
    %extracted_slice_0 = tensor.extract_slice %extracted_slice[0, 0, 0] [2, %arg1, 2] [1, 1, 1] : tensor<7x11x2xf32> to tensor<2x?x2xf32>
    %cast = tensor.cast %extracted_slice_0 : tensor<2x?x2xf32> to tensor<?x?x?xf32>
    return %cast : tensor<?x?x?xf32>
  }
}

// -----
module {
  func.func @fold_trunci(%arg0: i1) -> i1 {
    return %arg0 : i1
  }
}

// -----
module {
  func.func @fold_trunci_vector(%arg0: vector<4xi1>) -> vector<4xi1> {
    return %arg0 : vector<4xi1>
  }
}

// -----
module {
  func.func @fold_trunci(%arg0: i1) -> i2 {
    %0 = arith.extui %arg0 : i1 to i2
    return %0 : i2
  }
}

// -----
module {
  func.func @fold_trunci_vector(%arg0: vector<4xi1>) -> vector<4xi2> {
    %0 = arith.extui %arg0 : vector<4xi1> to vector<4xi2>
    return %0 : vector<4xi2>
  }
}

// -----
module {
  func.func @fold_trunci_sexti(%arg0: i1) -> i1 {
    return %arg0 : i1
  }
  func.func @simple_clone_elimination() -> memref<5xf32> {
    %alloc = memref.alloc() : memref<5xf32>
    return %alloc : memref<5xf32>
  }
}

// -----
module {
  func.func @clone_loop_alloc(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<2xf32>, %arg4: memref<2xf32>) {
    %0 = bufferization.clone %arg3 : memref<2xf32> to memref<2xf32>
    %1 = scf.for %arg5 = %arg0 to %arg1 step %arg2 iter_args(%arg6 = %0) -> (memref<2xf32>) {
      memref.dealloc %arg6 : memref<2xf32>
      %alloc = memref.alloc() : memref<2xf32>
      scf.yield %alloc : memref<2xf32>
    }
    memref.copy %1, %arg4 : memref<2xf32> to memref<2xf32>
    memref.dealloc %1 : memref<2xf32>
    return
  }
}

// -----
module {
  func.func @clone_nested_region(%arg0: index, %arg1: index, %arg2: index) -> memref<?x?xf32> {
    %0 = arith.cmpi eq, %arg0, %arg1 : index
    %1 = arith.cmpi eq, %arg0, %arg1 : index
    %alloc = memref.alloc(%arg0, %arg0) : memref<?x?xf32>
    %2 = scf.if %1 -> (memref<?x?xf32>) {
      %3 = scf.if %0 -> (memref<?x?xf32>) {
        %4 = bufferization.clone %alloc : memref<?x?xf32> to memref<?x?xf32>
        scf.yield %4 : memref<?x?xf32>
      } else {
        %alloc_0 = memref.alloc(%arg0, %arg1) : memref<?x?xf32>
        scf.yield %alloc_0 : memref<?x?xf32>
      }
      scf.yield %3 : memref<?x?xf32>
    } else {
      %alloc_0 = memref.alloc(%arg1, %arg1) : memref<?x?xf32>
      scf.yield %alloc_0 : memref<?x?xf32>
    }
    memref.dealloc %alloc : memref<?x?xf32>
    return %2 : memref<?x?xf32>
  }
}

// -----
module {
  func.func @test_materialize_failure() -> i64 {
    %idx1234 = index.constant 1234
    %0 = index.castu %idx1234 : index to i64
    return %0 : i64
  }
}

