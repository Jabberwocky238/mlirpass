module {
  func.func @affine_vector_load(%arg0: index) {
    %alloc = memref.alloc() : memref<100xf32>
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %c1 = arith.constant 1 : index
    scf.for %arg1 = %c0 to %c16 step %c1 {
      %0 = arith.addi %arg1, %arg0 : index
      %c7 = arith.constant 7 : index
      %1 = arith.addi %0, %c7 : index
      %2 = vector.load %alloc[%1] : memref<100xf32>, vector<8xf32>
    }
    return
  }
}

// -----
module {
  func.func @affine_vector_store(%arg0: index) {
    %alloc = memref.alloc() : memref<100xf32>
    %cst = arith.constant dense<1.100000e+01> : vector<4xf32>
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %c1 = arith.constant 1 : index
    scf.for %arg1 = %c0 to %c16 step %c1 {
      %c-1 = arith.constant -1 : index
      %0 = arith.muli %arg0, %c-1 overflow<nsw> : index
      %1 = arith.addi %arg1, %0 : index
      %c7 = arith.constant 7 : index
      %2 = arith.addi %1, %c7 : index
      vector.store %cst, %alloc[%2] : memref<100xf32>, vector<4xf32>
    }
    return
  }
}

// -----
module {
  func.func @vector_load_2d() {
    %alloc = memref.alloc() : memref<100x100xf32>
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %c2 = arith.constant 2 : index
    scf.for %arg0 = %c0 to %c16 step %c2 {
      %c0_0 = arith.constant 0 : index
      %c16_1 = arith.constant 16 : index
      %c8 = arith.constant 8 : index
      scf.for %arg1 = %c0_0 to %c16_1 step %c8 {
        %0 = vector.load %alloc[%arg0, %arg1] : memref<100x100xf32>, vector<2x8xf32>
      }
    }
    return
  }
}

// -----
module {
  func.func @vector_store_2d() {
    %alloc = memref.alloc() : memref<100x100xf32>
    %cst = arith.constant dense<1.100000e+01> : vector<2x8xf32>
    %c0 = arith.constant 0 : index
    %c16 = arith.constant 16 : index
    %c2 = arith.constant 2 : index
    scf.for %arg0 = %c0 to %c16 step %c2 {
      %c0_0 = arith.constant 0 : index
      %c16_1 = arith.constant 16 : index
      %c8 = arith.constant 8 : index
      scf.for %arg1 = %c0_0 to %c16_1 step %c8 {
        vector.store %cst, %alloc[%arg0, %arg1] : memref<100x100xf32>, vector<2x8xf32>
      }
    }
    return
  }
}

