module {
  gpu.module @load_store_check {
    gpu.func @load_store(%arg0: memref<512xf32, 1>, %arg1: memref<256xf32, 1>) kernel {
      %c512_i64 = arith.constant 512 : i64
      %c384_i64 = arith.constant 384 : i64
      %memspacecast = memref.memory_space_cast %arg0 : memref<512xf32, 1> to memref<512xf32>
      %intptr = memref.extract_aligned_pointer_as_index %memspacecast : memref<512xf32> -> index
      %0 = arith.index_castui %intptr : index to i64
      %memspacecast_0 = memref.memory_space_cast %arg1 : memref<256xf32, 1> to memref<256xf32>
      %intptr_1 = memref.extract_aligned_pointer_as_index %memspacecast_0 : memref<256xf32> -> index
      %1 = arith.index_castui %intptr_1 : index to i64
      %2 = arith.addi %0, %c384_i64 : i64
      %3 = llvm.inttoptr %2 : i64 to !llvm.ptr<1>
      %4 = xevm.blockload %3 <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>}> : (!llvm.ptr<1>) -> vector<2xi32>
      %5 = arith.addi %1, %c512_i64 : i64
      %6 = llvm.inttoptr %5 : i64 to !llvm.ptr<1>
      xevm.blockstore %6, %4 <{cache_control = #xevm.store_cache_control<L1wb_L2uc_L3wb>}> : (!llvm.ptr<1>, vector<2xi32>)
      gpu.return
    }
  }
}

