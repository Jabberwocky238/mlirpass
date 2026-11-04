module {
  gpu.module @prefetch_nd_check {
    gpu.func @prefetch_nd(%arg0: memref<8x16xf32, 1>, %arg1: memref<8x16xf32, 1>) kernel {
      %c64_i32 = arith.constant 64 : i32
      %c0_i32 = arith.constant 0 : i32
      %cst = arith.constant dense<0> : vector<4xi64>
      %c8_i32 = arith.constant 8 : i32
      %c16_i32 = arith.constant 16 : i32
      %memspacecast = memref.memory_space_cast %arg0 : memref<8x16xf32, 1> to memref<8x16xf32>
      %intptr = memref.extract_aligned_pointer_as_index %memspacecast : memref<8x16xf32> -> index
      %0 = arith.index_castui %intptr : index to i64
      %1 = vector.insert %0, %cst [0] : i64 into vector<4xi64>
      %2 = vector.bitcast %1 : vector<4xi64> to vector<8xi32>
      %3 = vector.insert %c16_i32, %2 [2] : i32 into vector<8xi32>
      %4 = vector.insert %c8_i32, %3 [3] : i32 into vector<8xi32>
      %5 = vector.insert %c16_i32, %4 [4] : i32 into vector<8xi32>
      %6 = vector.bitcast %5 : vector<8xi32> to vector<4xi64>
      %7 = vector.extract %6[0] : i64 from vector<4xi64>
      %8 = llvm.inttoptr %7 : i64 to !llvm.ptr<1>
      xevm.blockprefetch2d %8, %c64_i32, %c8_i32, %c64_i32, %c0_i32, %c0_i32 <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3uc>, elem_size_in_bits = 32 : i32, tile_height = 8 : i32, tile_width = 16 : i32, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32)
      gpu.return
    }
  }
}

