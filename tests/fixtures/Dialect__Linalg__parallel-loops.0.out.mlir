module {
  func.func @linalg_generic_sum(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>) {
    %c0 = arith.constant 0 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    scf.parallel (%arg3, %arg4) = (%c0, %c0) to (%c2, %c2) step (%c1, %c1) {
      %0 = memref.load %arg0[%arg3, %arg4] : memref<2x2xf32>
      %1 = memref.load %arg1[%arg3, %arg4] : memref<2x2xf32>
      %2 = arith.addf %0, %1 : f32
      memref.store %2, %arg2[%arg3, %arg4] : memref<2x2xf32>
      scf.reduce 
    }
    return
  }
}

// -----
module {
  func.func @lower_outer_parallel(%arg0: memref<?x?x?x?xf32>, %arg1: memref<?x?x?xf32>) {
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?x?x?xf32>
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?x?x?xf32>
    %dim_1 = memref.dim %arg0, %c2 : memref<?x?x?x?xf32>
    %dim_2 = memref.dim %arg0, %c3 : memref<?x?x?x?xf32>
    scf.parallel (%arg2, %arg3) = (%c0, %c0) to (%dim, %dim_0) step (%c1, %c1) {
      scf.for %arg4 = %c0 to %dim_1 step %c1 {
        scf.parallel (%arg5) = (%c0) to (%dim_2) step (%c1) {
          %0 = memref.load %arg0[%arg2, %arg3, %arg4, %arg5] : memref<?x?x?x?xf32>
          memref.store %0, %arg1[%arg2, %arg3, %arg5] : memref<?x?x?xf32>
          scf.reduce 
        }
      }
      scf.reduce 
    }
    return
  }
}

// -----
module {
  func.func @lower_mixed_parallel(%arg0: memref<?x?x?x?x?x?xf32>, %arg1: memref<?x?x?x?xf32>) {
    %c5 = arith.constant 5 : index
    %c4 = arith.constant 4 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?x?x?x?x?xf32>
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?x?x?x?x?xf32>
    %dim_1 = memref.dim %arg0, %c2 : memref<?x?x?x?x?x?xf32>
    %dim_2 = memref.dim %arg0, %c3 : memref<?x?x?x?x?x?xf32>
    %dim_3 = memref.dim %arg0, %c4 : memref<?x?x?x?x?x?xf32>
    %dim_4 = memref.dim %arg0, %c5 : memref<?x?x?x?x?x?xf32>
    scf.parallel (%arg2, %arg3) = (%c0, %c0) to (%dim, %dim_0) step (%c1, %c1) {
      scf.for %arg4 = %c0 to %dim_1 step %c1 {
        scf.parallel (%arg5, %arg6) = (%c0, %c0) to (%dim_2, %dim_3) step (%c1, %c1) {
          scf.for %arg7 = %c0 to %dim_4 step %c1 {
            %0 = memref.load %arg0[%arg2, %arg3, %arg4, %arg5, %arg6, %arg7] : memref<?x?x?x?x?x?xf32>
            memref.store %0, %arg1[%arg2, %arg3, %arg6, %arg5] : memref<?x?x?x?xf32>
          }
          scf.reduce 
        }
      }
      scf.reduce 
    }
    return
  }
}

