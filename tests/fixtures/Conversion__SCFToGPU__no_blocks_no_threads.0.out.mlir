module {
  func.func @one_d_loop(%arg0: memref<?xf32>, %arg1: memref<?xf32>) {
    %c0 = arith.constant 0 : index
    %c42 = arith.constant 42 : index
    %0 = arith.subi %c42, %c0 : index
    %c1 = arith.constant 1 : index
    %c1_0 = arith.constant 1 : index
    gpu.launch blocks(%arg2, %arg3, %arg4) in (%arg8 = %c1_0, %arg9 = %c1_0, %arg10 = %c1_0) threads(%arg5, %arg6, %arg7) in (%arg11 = %0, %arg12 = %c1_0, %arg13 = %c1_0) {
      %1 = arith.addi %c0, %arg5 : index
      %2 = memref.load %arg0[%1] : memref<?xf32>
      memref.store %2, %arg1[%1] : memref<?xf32>
      gpu.terminator
    }
    return
  }
}

