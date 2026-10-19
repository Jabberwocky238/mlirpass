module {
  func.func @step_1(%arg0: memref<?x?x?x?xf32>, %arg1: memref<?x?x?x?xf32>) {
    %c0 = arith.constant 0 : index
    %c42 = arith.constant 42 : index
    %0 = arith.subi %c42, %c0 : index
    %c1 = arith.constant 1 : index
    %c0_0 = arith.constant 0 : index
    %c10 = arith.constant 10 : index
    %1 = arith.subi %c10, %c0_0 : index
    %c1_1 = arith.constant 1 : index
    %c1_2 = arith.constant 1 : index
    gpu.launch blocks(%arg2, %arg3, %arg4) in (%arg8 = %0, %arg9 = %c1_2, %arg10 = %c1_2) threads(%arg5, %arg6, %arg7) in (%arg11 = %1, %arg12 = %c1_2, %arg13 = %c1_2) {
      %2 = arith.addi %c0, %arg2 : index
      %3 = arith.addi %c0_0, %arg5 : index
      affine.for %arg14 = 2 to 16 {
        affine.for %arg15 = 5 to 17 {
          %4 = memref.load %arg0[%2, %3, %arg14, %arg15] : memref<?x?x?x?xf32>
          memref.store %4, %arg1[%2, %3, %arg14, %arg15] : memref<?x?x?x?xf32>
        }
      }
      gpu.terminator
    }
    return
  }
}

