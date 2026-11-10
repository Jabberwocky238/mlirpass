module {
  gpu.module @load_store_check {
    gpu.func @load_store_matrix_a(%arg0: memref<16x128xi4, 1>, %arg1: memref<16x128xi4, 1>) kernel {
      %c64_i32 = arith.constant 64 : i32
      %c8_i32 = arith.constant 8 : i32
      %cst = arith.constant dense<0> : vector<4xi64>
      %c16_i32 = arith.constant 16 : i32
      %c128_i32 = arith.constant 128 : i32
      %memspacecast = memref.memory_space_cast %arg0 : memref<16x128xi4, 1> to memref<16x128xi4>
      %intptr = memref.extract_aligned_pointer_as_index %memspacecast : memref<16x128xi4> -> index
      %0 = arith.index_castui %intptr : index to i64
      %memspacecast_0 = memref.memory_space_cast %arg1 : memref<16x128xi4, 1> to memref<16x128xi4>
      %intptr_1 = memref.extract_aligned_pointer_as_index %memspacecast_0 : memref<16x128xi4> -> index
      %1 = arith.index_castui %intptr_1 : index to i64
      %2 = vector.insert %0, %cst [0] : i64 into vector<4xi64>
      %3 = vector.bitcast %2 : vector<4xi64> to vector<8xi32>
      %4 = vector.insert %c128_i32, %3 [2] : i32 into vector<8xi32>
      %5 = vector.insert %c16_i32, %4 [3] : i32 into vector<8xi32>
      %6 = vector.insert %c128_i32, %5 [4] : i32 into vector<8xi32>
      %7 = vector.bitcast %6 : vector<8xi32> to vector<4xi64>
      %8 = vector.extract %7[0] : i64 from vector<4xi64>
      %9 = llvm.inttoptr %8 : i64 to !llvm.ptr<1>
      %10 = xevm.blockload2d %9, %c64_i32, %c16_i32, %c64_i32, %c16_i32, %c8_i32 <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>, elem_size_in_bits = 16 : i32, pack_register = false, tile_height = 8 : i32, tile_width = 16 : i32, transpose = false, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi16>
      %11 = vector.insert %1, %cst [0] : i64 into vector<4xi64>
      %12 = vector.bitcast %11 : vector<4xi64> to vector<8xi32>
      %13 = vector.insert %c128_i32, %12 [2] : i32 into vector<8xi32>
      %14 = vector.insert %c16_i32, %13 [3] : i32 into vector<8xi32>
      %15 = vector.insert %c128_i32, %14 [4] : i32 into vector<8xi32>
      %16 = vector.bitcast %15 : vector<8xi32> to vector<4xi64>
      %17 = vector.extract %16[0] : i64 from vector<4xi64>
      %18 = llvm.inttoptr %17 : i64 to !llvm.ptr<1>
      xevm.blockstore2d %18, %c64_i32, %c16_i32, %c64_i32, %c16_i32, %c8_i32, %10 <{cache_control = #xevm.store_cache_control<L1wb_L2uc_L3wb>, elem_size_in_bits = 16 : i32, tile_height = 8 : i32, tile_width = 16 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32, vector<8xi16>)
      gpu.return
    }
    gpu.func @load_matrix_b_request_pack(%arg0: memref<64x128xi4, 1>, %arg1: memref<64x128xi4, 1>) kernel {
      %c16_i32 = arith.constant 16 : i32
      %c32_i32 = arith.constant 32 : i32
      %cst = arith.constant dense<0> : vector<4xi64>
      %c64_i32 = arith.constant 64 : i32
      %c128_i32 = arith.constant 128 : i32
      %c32 = arith.constant 32 : index
      %c0 = arith.constant 0 : index
      %memspacecast = memref.memory_space_cast %arg0 : memref<64x128xi4, 1> to memref<64x128xi4>
      %intptr = memref.extract_aligned_pointer_as_index %memspacecast : memref<64x128xi4> -> index
      %0 = arith.index_castui %intptr : index to i64
      %memspacecast_0 = memref.memory_space_cast %arg1 : memref<64x128xi4, 1> to memref<64x128xi4>
      %1 = vector.insert %0, %cst [0] : i64 into vector<4xi64>
      %2 = vector.bitcast %1 : vector<4xi64> to vector<8xi32>
      %3 = vector.insert %c128_i32, %2 [2] : i32 into vector<8xi32>
      %4 = vector.insert %c64_i32, %3 [3] : i32 into vector<8xi32>
      %5 = vector.insert %c128_i32, %4 [4] : i32 into vector<8xi32>
      %6 = vector.bitcast %5 : vector<8xi32> to vector<4xi64>
      %7 = vector.extract %6[0] : i64 from vector<4xi64>
      %8 = llvm.inttoptr %7 : i64 to !llvm.ptr<1>
      %9 = xevm.blockload2d %8, %c64_i32, %c64_i32, %c64_i32, %c16_i32, %c32_i32 <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>, elem_size_in_bits = 8 : i32, pack_register = true, tile_height = 32 : i32, tile_width = 16 : i32, transpose = false, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi32>
      %10 = vector.bitcast %9 : vector<8xi32> to vector<64xi4>
      vector.store %10, %memspacecast_0[%c32, %c0] : memref<64x128xi4>, vector<64xi4>
      gpu.return
    }
  }
}

