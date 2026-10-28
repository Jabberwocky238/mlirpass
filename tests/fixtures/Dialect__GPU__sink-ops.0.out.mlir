module {
  func.func @extra_constants(%arg0: memref<?xf32>) {
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?xf32>
    gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %c8, %arg8 = %c8, %arg9 = %c8) threads(%arg4, %arg5, %arg6) in (%arg10 = %c8, %arg11 = %c8, %arg12 = %c8) {
      %c2_0 = arith.constant 2 : index
      %c0_1 = arith.constant 0 : index
      %dim_2 = memref.dim %arg0, %c0_1 : memref<?xf32>
      "use"(%c2_0, %arg0, %dim_2) : (index, memref<?xf32>, index) -> ()
      gpu.terminator
    }
    return
  }
}

// -----
module {
  func.func @extra_constants_not_inlined(%arg0: memref<?xf32>) {
    %c8 = arith.constant 8 : index
    %c2 = arith.constant 2 : index
    %c0 = arith.constant 0 : index
    %0 = "secret_constant"() : () -> index
    gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %c8, %arg8 = %c8, %arg9 = %c8) threads(%arg4, %arg5, %arg6) in (%arg10 = %c8, %arg11 = %c8, %arg12 = %c8) {
      %c2_0 = arith.constant 2 : index
      "use"(%c2_0, %arg0, %0) : (index, memref<?xf32>, index) -> ()
      gpu.terminator
    }
    return
  }
}

// -----
module {
  func.func @multiple_uses(%arg0: memref<?xf32>) {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %c1, %arg8 = %c1, %arg9 = %c1) threads(%arg4, %arg5, %arg6) in (%arg10 = %c1, %arg11 = %c1, %arg12 = %c1) {
      %c2_0 = arith.constant 2 : index
      "use1"(%c2_0, %c2_0) : (index, index) -> ()
      "use2"(%c2_0) : (index) -> ()
      gpu.terminator
    }
    return
  }
}

// -----
module {
  func.func @multiple_uses2(%arg0: memref<*xf32>) {
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %dim = memref.dim %arg0, %c2 : memref<*xf32>
    gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %c1, %arg8 = %c1, %arg9 = %c1) threads(%arg4, %arg5, %arg6) in (%arg10 = %c1, %arg11 = %c1, %arg12 = %c1) {
      %c2_0 = arith.constant 2 : index
      %dim_1 = memref.dim %arg0, %c2_0 : memref<*xf32>
      "use1"(%dim_1) : (index) -> ()
      "use2"(%c2_0, %c2_0) : (index, index) -> ()
      "use3"(%arg0) : (memref<*xf32>) -> ()
      gpu.terminator
    }
    return
  }
}

