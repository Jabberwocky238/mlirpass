module {
  func.func @func(%arg0: i64) {
    %0 = arith.index_cast %arg0 : i64 to index
    %alloc = memref.alloc() : memref<16xf32>
    scf.parallel (%arg1) = (%0) to (%0) step (%0) {
      %cst_f32 = spirv.Constant 1.000000e+00 : f32
      memref.store %cst_f32, %alloc[%arg1] : memref<16xf32>
      scf.reduce 
    }
    spirv.Return
  }
}

