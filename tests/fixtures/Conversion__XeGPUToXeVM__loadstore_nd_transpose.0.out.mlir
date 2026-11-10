module {
  gpu.module @load_check {
    gpu.func @load_nd_transpose_f16(%arg0: memref<16x16xf16, 1>, %arg1: memref<16x16xf16, 1>) kernel {
      %memspacecast = memref.memory_space_cast %arg0 : memref<16x16xf16, 1> to memref<16x16xf16>
      %intptr = memref.extract_aligned_pointer_as_index %memspacecast : memref<16x16xf16> -> index
      %c0 = arith.constant 0 : index
      %0 = arith.index_castui %intptr : index to i64
      %1 = arith.index_castui %c0 : index to i64
      %c2_i64 = arith.constant 2 : i64
      %2 = arith.muli %1, %c2_i64 : i64
      %3 = arith.addi %0, %2 : i64
      %memspacecast_0 = memref.memory_space_cast %arg1 : memref<16x16xf16, 1> to memref<16x16xf16>
      %cst = arith.constant dense<0> : vector<8xi32>
      %c16_i64 = arith.constant 16 : i64
      %4 = arith.trunci %c16_i64 : i64 to i32
      %c16_i64_1 = arith.constant 16 : i64
      %5 = arith.trunci %c16_i64_1 : i64 to i32
      %c16_i64_2 = arith.constant 16 : i64
      %6 = arith.trunci %c16_i64_2 : i64 to i32
      %7 = vector.bitcast %cst : vector<8xi32> to vector<4xi64>
      %8 = vector.insert %3, %7 [0] : i64 into vector<4xi64>
      %9 = vector.bitcast %8 : vector<4xi64> to vector<8xi32>
      %10 = vector.insert %4, %9 [2] : i32 into vector<8xi32>
      %11 = vector.insert %5, %10 [3] : i32 into vector<8xi32>
      %12 = vector.insert %6, %11 [4] : i32 into vector<8xi32>
      %c2_i32 = arith.constant 2 : i32
      %13 = vector.bitcast %12 : vector<8xi32> to vector<4xi64>
      %14 = vector.extract %13[0] : i64 from vector<4xi64>
      %15 = vector.extract %12[2] : i32 from vector<8xi32>
      %16 = vector.extract %12[3] : i32 from vector<8xi32>
      %17 = vector.extract %12[4] : i32 from vector<8xi32>
      %c16_i64_3 = arith.constant 16 : i64
      %18 = arith.trunci %c16_i64_3 : i64 to i32
      %c0_i64 = arith.constant 0 : i64
      %19 = arith.trunci %c0_i64 : i64 to i32
      %20 = llvm.inttoptr %14 : i64 to !llvm.ptr<1>
      %21 = arith.muli %15, %c2_i32 : i32
      %22 = arith.muli %17, %c2_i32 : i32
      %c1_i32 = arith.constant 1 : i32
      %23 = arith.shrsi %18, %c1_i32 : i32
      %24 = xevm.blockload2d %20, %21, %16, %22, %23, %19 <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>, elem_size_in_bits = 32 : i32, pack_register = false, tile_height = 16 : i32, tile_width = 8 : i32, transpose = true, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi32>
      %25 = vector.bitcast %24 : vector<8xi32> to vector<16xf16>
      %c0_4 = arith.constant 0 : index
      vector.store %25, %memspacecast_0[%c0_4, %c0_4] : memref<16x16xf16>, vector<16xf16>
      gpu.return
    }
  }
}

