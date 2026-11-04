module {
  gpu.module @test {
    gpu.func @load_gather_i64_src_value_offset(%arg0: i64, %arg1: vector<1xindex>, %arg2: memref<1xf16>, %arg3: vector<1xi1>) {
      %c0 = arith.constant 0 : index
      %cst = arith.constant 0.000000e+00 : f16
      %c2_i64 = arith.constant 2 : i64
      %0 = vector.extract %arg3[0] : i1 from vector<1xi1>
      %1 = vector.extract %arg1[0] : index from vector<1xindex>
      %2 = arith.index_castui %1 : index to i64
      %3 = arith.muli %2, %c2_i64 : i64
      %4 = arith.addi %arg0, %3 : i64
      %5 = llvm.inttoptr %4 : i64 to !llvm.ptr<1>
      %6 = scf.if %0 -> (f16) {
        %8 = llvm.load %5 {cache_control = #xevm.load_cache_control<L1c_L2uc_L3uc>} : !llvm.ptr<1> -> f16
        scf.yield %8 : f16
      } else {
        scf.yield %cst : f16
      }
      %7 = vector.broadcast %6 : f16 to vector<1xf16>
      vector.store %7, %arg2[%c0] : memref<1xf16>, vector<1xf16>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @test {
    gpu.func @source_materialize_single_elem_vec(%arg0: i64, %arg1: vector<1xindex>, %arg2: memref<1xf16>, %arg3: vector<1xi1>) {
      %c0 = arith.constant 0 : index
      %cst = arith.constant 0.000000e+00 : f16
      %c2_i64 = arith.constant 2 : i64
      %0 = vector.extract %arg3[0] : i1 from vector<1xi1>
      %1 = vector.extract %arg1[0] : index from vector<1xindex>
      %2 = arith.index_castui %1 : index to i64
      %3 = arith.muli %2, %c2_i64 : i64
      %4 = arith.addi %arg0, %3 : i64
      %5 = llvm.inttoptr %4 : i64 to !llvm.ptr<1>
      %6 = scf.if %0 -> (f16) {
        %8 = llvm.load %5 {cache_control = #xevm.load_cache_control<L1c_L2uc_L3uc>} : !llvm.ptr<1> -> f16
        scf.yield %8 : f16
      } else {
        scf.yield %cst : f16
      }
      %7 = vector.broadcast %6 : f16 to vector<1xf16>
      vector.store %7, %arg2[%c0] : memref<1xf16>, vector<1xf16>
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @test {
    gpu.func @store_scatter_i64_src_value_offset(%arg0: i64, %arg1: vector<1xindex>, %arg2: vector<1xi1>) {
      %cst = arith.constant 2.900000e+00 : f32
      %c4_i64 = arith.constant 4 : i64
      %0 = vector.extract %arg2[0] : i1 from vector<1xi1>
      %1 = vector.extract %arg1[0] : index from vector<1xindex>
      %2 = arith.index_castui %1 : index to i64
      %3 = arith.muli %2, %c4_i64 : i64
      %4 = arith.addi %arg0, %3 : i64
      %5 = llvm.inttoptr %4 : i64 to !llvm.ptr<1>
      scf.if %0 {
        llvm.store %cst, %5 {cache_control = #xevm.store_cache_control<L1wb_L2uc_L3uc>} : f32, !llvm.ptr<1>
      }
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @test {
    gpu.func @prefetch_i64_src_value_offset(%arg0: i64, %arg1: vector<1xindex>) {
      %c4_i64 = arith.constant 4 : i64
      %0 = vector.extract %arg1[0] : index from vector<1xindex>
      %1 = arith.index_castui %0 : index to i64
      %2 = arith.muli %1, %c4_i64 : i64
      %3 = arith.addi %arg0, %2 : i64
      %4 = llvm.inttoptr %3 : i64 to !llvm.ptr<1>
      xevm.prefetch %4 <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3uc>}> : (!llvm.ptr<1>)
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @test {
    gpu.func @prefetch_memref_src_value_offset(%arg0: memref<256xf32>, %arg1: vector<1xindex>) {
      %c4_i64 = arith.constant 4 : i64
      %0 = vector.extract %arg1[0] : index from vector<1xindex>
      %1 = arith.index_castui %0 : index to i64
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<256xf32> -> index
      %2 = arith.index_castui %intptr : index to i64
      %3 = arith.muli %1, %c4_i64 : i64
      %4 = arith.addi %2, %3 : i64
      %5 = llvm.inttoptr %4 : i64 to !llvm.ptr<1>
      xevm.prefetch %5 <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3uc>}> : (!llvm.ptr<1>)
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @test {
    gpu.func @load_gather_from_dyn_memref_subview(%arg0: memref<?xf16>, %arg1: vector<1xindex>, %arg2: vector<1xi1>, %arg3: memref<1xf16>) {
      %cst = arith.constant 0.000000e+00 : f16
      %c2_i64 = arith.constant 2 : i64
      %c0 = arith.constant 0 : index
      %0 = vector.extract %arg2[0] : i1 from vector<1xi1>
      %1 = vector.extract %arg1[0] : index from vector<1xindex>
      %2 = arith.index_castui %1 : index to i64
      %3 = gpu.subgroup_id : index
      %subview = memref.subview %arg0[%3] [16] [1] : memref<?xf16> to memref<16xf16, strided<[1], offset: ?>>
      %base_buffer, %offset, %sizes, %strides = memref.extract_strided_metadata %subview : memref<16xf16, strided<[1], offset: ?>> -> memref<f16>, index, index, index
      %intptr = memref.extract_aligned_pointer_as_index %base_buffer : memref<f16> -> index
      %4 = arith.index_castui %intptr : index to i64
      %5 = arith.index_castui %offset : index to i64
      %6 = arith.muli %5, %c2_i64 : i64
      %7 = arith.addi %4, %6 : i64
      %8 = arith.muli %2, %c2_i64 : i64
      %9 = arith.addi %7, %8 : i64
      %10 = llvm.inttoptr %9 : i64 to !llvm.ptr<1>
      %11 = scf.if %0 -> (f16) {
        %13 = llvm.load %10 {cache_control = #xevm.load_cache_control<L1c_L2uc_L3uc>} : !llvm.ptr<1> -> f16
        scf.yield %13 : f16
      } else {
        scf.yield %cst : f16
      }
      %12 = vector.broadcast %11 : f16 to vector<1xf16>
      vector.store %12, %arg3[%c0] : memref<1xf16>, vector<1xf16>
      gpu.return
    }
  }
}

