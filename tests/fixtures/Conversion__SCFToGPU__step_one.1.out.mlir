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
    %c2 = arith.constant 2 : index
    %c16 = arith.constant 16 : index
    %2 = arith.subi %c16, %c2 : index
    %c1_2 = arith.constant 1 : index
    %c5 = arith.constant 5 : index
    %c17 = arith.constant 17 : index
    %3 = arith.subi %c17, %c5 : index
    %c1_3 = arith.constant 1 : index
    %c1_4 = arith.constant 1 : index
    gpu.launch blocks(%arg2, %arg3, %arg4) in (%arg8 = %0, %arg9 = %1, %arg10 = %c1_4) threads(%arg5, %arg6, %arg7) in (%arg11 = %2, %arg12 = %3, %arg13 = %c1_4) {
      %4 = arith.addi %c0, %arg2 : index
      %5 = arith.addi %c0_0, %arg3 : index
      %6 = arith.addi %c2, %arg5 : index
      %7 = arith.addi %c5, %arg6 : index
      %8 = memref.load %arg0[%4, %5, %6, %7] : memref<?x?x?x?xf32>
      memref.store %8, %arg1[%4, %5, %6, %7] : memref<?x?x?x?xf32>
      gpu.terminator
    }
    return
  }
}

