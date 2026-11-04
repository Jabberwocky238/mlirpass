module {
  gpu.module @create_nd_tdesc {
    gpu.func @create_nd_tdesc(%arg0: memref<16x32xf32, 1>, %arg1: ui64, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: memref<?x?xf16>) kernel {
      %intptr = memref.extract_aligned_pointer_as_index %arg8 : memref<?x?xf16> -> index
      %c0 = arith.constant 0 : index
      %0 = arith.index_castui %intptr : index to i64
      %1 = arith.index_castui %c0 : index to i64
      %c2_i64 = arith.constant 2 : i64
      %2 = arith.muli %1, %c2_i64 : i64
      %3 = arith.addi %0, %2 : i64
      %4 = index.castu %arg1 : ui64 to index
      %5 = arith.index_castui %4 : index to i64
      %cst = arith.constant dense<0> : vector<8xi32>
      %6 = arith.index_cast %arg3 : index to i32
      %7 = arith.index_cast %arg2 : index to i32
      %8 = arith.index_cast %arg4 : index to i32
      %9 = vector.bitcast %cst : vector<8xi32> to vector<4xi64>
      %10 = vector.insert %5, %9 [0] : i64 into vector<4xi64>
      %11 = vector.bitcast %10 : vector<4xi64> to vector<8xi32>
      %12 = vector.insert %6, %11 [2] : i32 into vector<8xi32>
      %13 = vector.insert %7, %12 [3] : i32 into vector<8xi32>
      %14 = vector.insert %8, %13 [4] : i32 into vector<8xi32>
      %memspacecast = memref.memory_space_cast %arg0 : memref<16x32xf32, 1> to memref<16x32xf32>
      %intptr_0 = memref.extract_aligned_pointer_as_index %memspacecast : memref<16x32xf32> -> index
      %c0_1 = arith.constant 0 : index
      %15 = arith.index_castui %intptr_0 : index to i64
      %16 = arith.index_castui %c0_1 : index to i64
      %c4_i64 = arith.constant 4 : i64
      %17 = arith.muli %16, %c4_i64 : i64
      %18 = arith.addi %15, %17 : i64
      %cst_2 = arith.constant dense<0> : vector<8xi32>
      %c32_i64 = arith.constant 32 : i64
      %19 = arith.trunci %c32_i64 : i64 to i32
      %c16_i64 = arith.constant 16 : i64
      %20 = arith.trunci %c16_i64 : i64 to i32
      %c32_i64_3 = arith.constant 32 : i64
      %21 = arith.trunci %c32_i64_3 : i64 to i32
      %22 = vector.bitcast %cst_2 : vector<8xi32> to vector<4xi64>
      %23 = vector.insert %18, %22 [0] : i64 into vector<4xi64>
      %24 = vector.bitcast %23 : vector<4xi64> to vector<8xi32>
      %25 = vector.insert %19, %24 [2] : i32 into vector<8xi32>
      %26 = vector.insert %20, %25 [3] : i32 into vector<8xi32>
      %27 = vector.insert %21, %26 [4] : i32 into vector<8xi32>
      %c1 = arith.constant 1 : index
      %c64 = arith.constant 64 : index
      %c16 = arith.constant 16 : index
      %cst_4 = arith.constant dense<0> : vector<8xi32>
      %28 = arith.index_cast %c16 : index to i32
      %29 = arith.index_cast %c64 : index to i32
      %30 = arith.index_cast %c16 : index to i32
      %31 = vector.bitcast %cst_4 : vector<8xi32> to vector<4xi64>
      %32 = vector.insert %3, %31 [0] : i64 into vector<4xi64>
      %33 = vector.bitcast %32 : vector<4xi64> to vector<8xi32>
      %34 = vector.insert %28, %33 [2] : i32 into vector<8xi32>
      %35 = vector.insert %29, %34 [3] : i32 into vector<8xi32>
      %36 = vector.insert %30, %35 [4] : i32 into vector<8xi32>
      gpu.return
    }
  }
}

