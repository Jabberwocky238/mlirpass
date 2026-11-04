// -----
// -----
// -----
// -----
module {
  func.func @yield_alloc_dominance_test_2(%arg0: f32, %arg1: index, %arg2: index) -> f32 {
    %alloc = memref.alloc(%arg1) {alignment = 64 : i64} : memref<?xf32>
    %0 = scf.execute_region -> memref<?xf32> {
      scf.yield %alloc : memref<?xf32>
    }
    memref.store %arg0, %0[%arg1] : memref<?xf32>
    %1 = memref.load %0[%arg2] : memref<?xf32>
    return %1 : f32
  }
}

// -----
// -----
// -----
// -----
