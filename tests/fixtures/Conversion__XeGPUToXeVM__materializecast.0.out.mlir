module {
  gpu.module @materializecast {
    gpu.func @materialize_memref(%arg0: memref<128xf32>) kernel {
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<128xf32> -> index
      %c0 = arith.constant 0 : index
      %0 = arith.index_castui %intptr : index to i64
      %1 = arith.index_castui %c0 : index to i64
      %c4_i64 = arith.constant 4 : i64
      %2 = arith.muli %1, %c4_i64 : i64
      %3 = arith.addi %0, %2 : i64
      %c0_0 = arith.constant 0 : index
      %4 = builtin.unrealized_conversion_cast %c0_0 : index to i64
      %true = arith.constant true
      %c4_i64_1 = arith.constant 4 : i64
      %5 = arith.muli %4, %c4_i64_1 : i64
      %6 = arith.addi %3, %5 : i64
      %7 = llvm.inttoptr %6 : i64 to !llvm.ptr<1>
      %8 = scf.if %true -> (f32) {
        %9 = llvm.load %7 {cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>} : !llvm.ptr<1> -> f32
        scf.yield %9 : f32
      } else {
        %cst = arith.constant 0.000000e+00 : f32
        scf.yield %cst : f32
      }
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @materializecast {
    gpu.func @materialize_ui64(%arg0: ui64) kernel {
      %0 = index.castu %arg0 : ui64 to index
      %1 = arith.index_castui %0 : index to i64
      %c0 = arith.constant 0 : index
      %2 = builtin.unrealized_conversion_cast %c0 : index to i64
      %true = arith.constant true
      %c4_i64 = arith.constant 4 : i64
      %3 = arith.muli %2, %c4_i64 : i64
      %4 = arith.addi %1, %3 : i64
      %5 = llvm.inttoptr %4 : i64 to !llvm.ptr<1>
      %6 = scf.if %true -> (f32) {
        %7 = llvm.load %5 {cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>} : !llvm.ptr<1> -> f32
        scf.yield %7 : f32
      } else {
        %cst = arith.constant 0.000000e+00 : f32
        scf.yield %cst : f32
      }
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @materializecast {
    gpu.func @materialize_ui32(%arg0: ui32) kernel {
      %0 = index.castu %arg0 : ui32 to index
      %1 = arith.index_castui %0 : index to i32
      %c0 = arith.constant 0 : index
      %2 = builtin.unrealized_conversion_cast %c0 : index to i64
      %true = arith.constant true
      %3 = arith.extui %1 : i32 to i64
      %c4_i64 = arith.constant 4 : i64
      %4 = arith.muli %2, %c4_i64 : i64
      %5 = arith.addi %3, %4 : i64
      %6 = llvm.inttoptr %5 : i64 to !llvm.ptr<1>
      %7 = scf.if %true -> (f32) {
        %8 = llvm.load %6 {cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>} : !llvm.ptr<1> -> f32
        scf.yield %8 : f32
      } else {
        %cst = arith.constant 0.000000e+00 : f32
        scf.yield %cst : f32
      }
      gpu.return
    }
  }
}

// -----
module {
  gpu.module @materializecast {
    gpu.func @materialize_single_index_vector(%arg0: memref<128xf32>) kernel {
      %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<128xf32> -> index
      %c0 = arith.constant 0 : index
      %0 = arith.index_castui %intptr : index to i64
      %1 = arith.index_castui %c0 : index to i64
      %c4_i64 = arith.constant 4 : i64
      %2 = arith.muli %1, %c4_i64 : i64
      %3 = arith.addi %0, %2 : i64
      %cst = arith.constant dense<0> : vector<1xindex>
      %4 = vector.extract %cst[0] : index from vector<1xindex>
      %5 = arith.index_castui %4 : index to i64
      %cst_0 = arith.constant dense<true> : vector<1xi1>
      %6 = vector.extract %cst_0[0] : i1 from vector<1xi1>
      %c4_i64_1 = arith.constant 4 : i64
      %7 = arith.muli %5, %c4_i64_1 : i64
      %8 = arith.addi %3, %7 : i64
      %9 = llvm.inttoptr %8 : i64 to !llvm.ptr<1>
      %10 = scf.if %6 -> (f32) {
        %11 = llvm.load %9 {cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>} : !llvm.ptr<1> -> f32
        scf.yield %11 : f32
      } else {
        %cst_2 = arith.constant 0.000000e+00 : f32
        scf.yield %cst_2 : f32
      }
      gpu.return
    }
  }
}

