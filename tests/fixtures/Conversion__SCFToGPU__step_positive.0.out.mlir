module {
  func.func @step_var(%arg0: memref<?x?xf32>, %arg1: memref<?x?xf32>) {
    %c5 = arith.constant 5 : index
    %c15 = arith.constant 15 : index
    %0 = arith.subi %c15, %c5 : index
    %c4 = arith.constant 4 : index
    %1 = arith.ceildivsi %0, %c4 : index
    %c3 = arith.constant 3 : index
    %c19 = arith.constant 19 : index
    %2 = arith.subi %c19, %c3 : index
    %c7 = arith.constant 7 : index
    %3 = arith.ceildivsi %2, %c7 : index
    %c1 = arith.constant 1 : index
    gpu.launch blocks(%arg2, %arg3, %arg4) in (%arg8 = %1, %arg9 = %c1, %arg10 = %c1) threads(%arg5, %arg6, %arg7) in (%arg11 = %3, %arg12 = %c1, %arg13 = %c1) {
      %4 = arith.muli %c4, %arg2 : index
      %5 = arith.addi %c5, %4 : index
      %6 = arith.muli %c7, %arg5 : index
      %7 = arith.addi %c3, %6 : index
      %8 = memref.load %arg0[%5, %7] : memref<?x?xf32>
      memref.store %8, %arg1[%5, %7] : memref<?x?xf32>
      gpu.terminator
    }
    return
  }
}

