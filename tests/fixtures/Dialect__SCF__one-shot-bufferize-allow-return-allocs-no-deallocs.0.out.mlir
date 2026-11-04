module {
  memref.global "private" constant @__constant_xf32 : memref<f32> = dense<0.000000e+00> {alignment = 64 : i64}
  func.func @different_before_after_args() -> tensor<f32> {
    %true = arith.constant true
    %0 = memref.get_global @__constant_xf32 : memref<f32>
    %1 = scf.while (%arg0 = %true) : (i1) -> memref<f32> {
      %alloc = memref.alloc() {alignment = 64 : i64} : memref<f32>
      memref.copy %0, %alloc : memref<f32> to memref<f32>
      scf.condition(%true) %alloc : memref<f32>
    } do {
    ^bb0(%arg0: memref<f32>):
      scf.yield %true : i1
    }
    %2 = bufferization.to_tensor %1 : memref<f32> to tensor<f32>
    return %2 : tensor<f32>
  }
}

