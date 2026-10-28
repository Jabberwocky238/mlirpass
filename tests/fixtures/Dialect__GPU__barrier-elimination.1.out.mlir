module {
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      transform.apply_patterns to %0 {
        transform.apply_patterns.gpu.eliminate_barriers
      } : !transform.any_op
      transform.yield 
    }
  }
  func.func @read_read_write(%arg0: memref<?xf32>, %arg1: index) attributes {__parallel_region_boundary_for_test} {
    %0 = memref.load %arg0[%arg1] : memref<?xf32>
    %1 = memref.load %arg0[%arg1] : memref<?xf32>
    %2 = arith.addf %0, %1 : f32
    gpu.barrier
    memref.store %2, %arg0[%arg1] : memref<?xf32>
    return
  }
  func.func @write_read_read(%arg0: memref<?xf32>, %arg1: index, %arg2: f32) -> f32 attributes {__parallel_region_boundary_for_test} {
    memref.store %arg2, %arg0[%arg1] : memref<?xf32>
    gpu.barrier
    %0 = memref.load %arg0[%arg1] : memref<?xf32>
    %1 = memref.load %arg0[%arg1] : memref<?xf32>
    %2 = arith.addf %0, %1 : f32
    return %2 : f32
  }
  func.func @write_in_a_loop(%arg0: memref<?xf32>, %arg1: f32) attributes {__parallel_region_boundary_for_test} {
    %c0 = arith.constant 0 : index
    %c42 = arith.constant 42 : index
    %c1 = arith.constant 1 : index
    scf.for %arg2 = %c0 to %c42 step %c1 {
      memref.store %arg1, %arg0[%arg2] : memref<?xf32>
      gpu.barrier
    }
    return
  }
  func.func @read_read_write_loop(%arg0: memref<?xf32>, %arg1: f32) attributes {__parallel_region_boundary_for_test} {
    %c0 = arith.constant 0 : index
    %c42 = arith.constant 42 : index
    %c1 = arith.constant 1 : index
    scf.for %arg2 = %c0 to %c42 step %c1 {
      %0 = memref.load %arg0[%arg2] : memref<?xf32>
      gpu.barrier
      %1 = memref.load %arg0[%arg2] : memref<?xf32>
      %2 = arith.addf %0, %1 : f32
      gpu.barrier
      memref.store %2, %arg0[%arg2] : memref<?xf32>
    }
    return
  }
  func.func @read_read_write_loop_trailing_sync(%arg0: memref<?xf32>, %arg1: f32) attributes {__parallel_region_boundary_for_test} {
    %c0 = arith.constant 0 : index
    %c42 = arith.constant 42 : index
    %c1 = arith.constant 1 : index
    scf.for %arg2 = %c0 to %c42 step %c1 {
      %0 = memref.load %arg0[%arg2] : memref<?xf32>
      %1 = memref.load %arg0[%arg2] : memref<?xf32>
      %2 = arith.addf %0, %1 : f32
      gpu.barrier
      memref.store %2, %arg0[%arg2] : memref<?xf32>
      gpu.barrier
    }
    return
  }
  func.func @write_write_noalias(%arg0: index, %arg1: f32) -> (memref<42xf32>, memref<10xf32>) attributes {__parallel_region_boundary_for_test} {
    %alloc = memref.alloc() : memref<42xf32>
    %alloc_0 = memref.alloc() : memref<10xf32>
    memref.store %arg1, %alloc[%arg0] : memref<42xf32>
    memref.store %arg1, %alloc_0[%arg0] : memref<10xf32>
    return %alloc, %alloc_0 : memref<42xf32>, memref<10xf32>
  }
  func.func @write_write_alloc_arg_noalias(%arg0: index, %arg1: f32, %arg2: memref<?xf32>) -> memref<42xf32> attributes {__parallel_region_boundary_for_test} {
    %alloc = memref.alloc() : memref<42xf32>
    memref.store %arg1, %alloc[%arg0] : memref<42xf32>
    memref.store %arg1, %arg2[%arg0] : memref<?xf32>
    return %alloc : memref<42xf32>
  }
  func.func @repeated_barrier(%arg0: memref<?xf32>, %arg1: index, %arg2: f32) -> f32 attributes {__parallel_region_boundary_for_test} {
    %0 = memref.load %arg0[%arg1] : memref<?xf32>
    gpu.barrier
    memref.store %arg2, %arg0[%arg1] : memref<?xf32>
    return %0 : f32
  }
  func.func @symmetric_stop(%arg0: f32) -> (f32, f32, f32, f32, f32) attributes {__parallel_region_boundary_for_test} {
    %alloc = memref.alloc() : memref<f32>
    %alloc_0 = memref.alloc() : memref<f32>
    %alloc_1 = memref.alloc() : memref<f32>
    memref.store %arg0, %alloc[] : memref<f32>
    gpu.barrier
    %0 = memref.load %alloc[] : memref<f32>
    memref.store %arg0, %alloc_0[] : memref<f32>
    %1 = memref.load %alloc[] : memref<f32>
    memref.store %arg0, %alloc_1[] : memref<f32>
    gpu.barrier
    %2 = memref.load %alloc[] : memref<f32>
    %3 = memref.load %alloc_0[] : memref<f32>
    %4 = memref.load %alloc_1[] : memref<f32>
    return %0, %1, %2, %3, %4 : f32, f32, f32, f32, f32
  }
  func.func @nested_loop_barrier_only() attributes {__parallel_region_boundary_for_test} {
    return
  }
}

