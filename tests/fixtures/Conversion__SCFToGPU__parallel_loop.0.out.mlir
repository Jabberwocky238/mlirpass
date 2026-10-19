#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module {
  func.func @parallel_loop_bidy_bidx(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: memref<?x?xf32>, %arg6: memref<?x?xf32>) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %0 = affine.apply #map(%arg2)[%arg0, %arg4]
    %1 = affine.apply #map(%arg3)[%arg1, %c2]
    gpu.launch blocks(%arg7, %arg8, %arg9) in (%arg13 = %1, %arg14 = %0, %arg15 = %c1) threads(%arg10, %arg11, %arg12) in (%arg16 = %c1, %arg17 = %c1, %arg18 = %c1) {
      %2 = affine.apply #map1(%arg8)[%arg4, %arg0]
      %3 = affine.apply #map1(%arg7)[%c2, %arg1]
      %4 = memref.load %arg5[%2, %3] : memref<?x?xf32>
      memref.store %4, %arg6[%3, %2] : memref<?x?xf32>
      gpu.terminator
    } {SCFToGPU_visited}
    return
  }
}

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module {
  func.func @parallel_loop_tiled(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %c1_0 = arith.constant 1 : index
    %0 = affine.apply #map(%arg2)[%arg0, %c4]
    %1 = affine.apply #map(%arg3)[%arg1, %c4]
    %2 = affine.apply #map(%c4)[%c0, %c1]
    %3 = affine.apply #map(%c4)[%c0, %c1]
    gpu.launch blocks(%arg6, %arg7, %arg8) in (%arg12 = %1, %arg13 = %0, %arg14 = %c1_0) threads(%arg9, %arg10, %arg11) in (%arg15 = %3, %arg16 = %2, %arg17 = %c1_0) {
      %4 = affine.apply #map1(%arg7)[%c4, %arg0]
      %5 = affine.apply #map1(%arg6)[%c4, %arg1]
      %6 = affine.apply #map1(%arg10)[%c1, %c0]
      %7 = affine.apply #map1(%arg9)[%c1, %c0]
      %8 = arith.addi %4, %6 : index
      %9 = arith.addi %5, %7 : index
      %10 = memref.load %arg4[%8, %9] : memref<?x?xf32>
      memref.store %10, %arg5[%9, %8] : memref<?x?xf32>
      gpu.terminator
    } {SCFToGPU_visited}
    return
  }
}

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module {
  func.func @parallel_loop_bidy_seq(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: memref<?x?xf32>, %arg6: memref<?x?xf32>) {
    %c2 = arith.constant 2 : index
    %c1 = arith.constant 1 : index
    %0 = affine.apply #map(%arg2)[%arg0, %arg4]
    gpu.launch blocks(%arg7, %arg8, %arg9) in (%arg13 = %c1, %arg14 = %0, %arg15 = %c1) threads(%arg10, %arg11, %arg12) in (%arg16 = %c1, %arg17 = %c1, %arg18 = %c1) {
      %1 = affine.apply #map1(%arg8)[%arg4, %arg0]
      scf.for %arg19 = %arg1 to %arg3 step %c2 {
        %2 = memref.load %arg5[%1, %arg19] : memref<?x?xf32>
        memref.store %2, %arg6[%arg19, %1] : memref<?x?xf32>
      }
      gpu.terminator
    } {SCFToGPU_visited}
    return
  }
}

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module {
  func.func @parallel_loop_tiled_seq(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %c1_0 = arith.constant 1 : index
    %0 = affine.apply #map(%arg2)[%arg0, %c4]
    %1 = affine.apply #map(%c4)[%c0, %c1]
    gpu.launch blocks(%arg6, %arg7, %arg8) in (%arg12 = %c1_0, %arg13 = %0, %arg14 = %c1_0) threads(%arg9, %arg10, %arg11) in (%arg15 = %c1_0, %arg16 = %1, %arg17 = %c1_0) {
      %2 = affine.apply #map1(%arg7)[%c4, %arg0]
      scf.for %arg18 = %arg1 to %arg3 step %c4 {
        %3 = affine.apply #map1(%arg10)[%c1, %c0]
        scf.for %arg19 = %c0 to %c4 step %c1 {
          %4 = arith.addi %2, %3 : index
          %5 = arith.addi %arg18, %arg19 : index
          %6 = memref.load %arg4[%4, %5] : memref<?x?xf32>
          memref.store %6, %arg5[%5, %4] : memref<?x?xf32>
        }
      }
      gpu.terminator
    } {SCFToGPU_visited}
    return
  }
}

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
#map2 = affine_map<(d0)[s0] -> (2, -d0 + s0)>
#map3 = affine_map<(d0)[s0] -> (3, -d0 + s0)>
module {
  func.func @sum(%arg0: memref<?x?xf32, strided<[?, 1], offset: ?>>, %arg1: memref<?x?xf32, strided<[?, 1], offset: ?>>, %arg2: memref<?x?xf32, strided<[?, 1], offset: ?>>) {
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %c3 = arith.constant 3 : index
    %c2 = arith.constant 2 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?xf32, strided<[?, 1], offset: ?>>
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?xf32, strided<[?, 1], offset: ?>>
    %c1_1 = arith.constant 1 : index
    %0 = affine.apply #map(%dim)[%c0, %c2]
    %1 = affine.apply #map(%dim_0)[%c0, %c3]
    %c2_2 = arith.constant 2 : index
    %c2_3 = arith.constant 2 : index
    %c4 = arith.constant 4 : index
    %2 = affine.apply #map(%c4)[%c0, %c1]
    %3 = affine.apply #map(%c3)[%c0, %c1]
    gpu.launch blocks(%arg3, %arg4, %arg5) in (%arg9 = %0, %arg10 = %1, %arg11 = %c1_1) threads(%arg6, %arg7, %arg8) in (%arg12 = %2, %arg13 = %3, %arg14 = %c1_1) {
      %4 = affine.apply #map1(%arg3)[%c2, %c0]
      %5 = affine.apply #map1(%arg4)[%c3, %c0]
      %dim_4 = memref.dim %arg0, %c0 : memref<?x?xf32, strided<[?, 1], offset: ?>>
      %6 = affine.min #map2(%4)[%dim_4]
      %7 = arith.muli %6, %6 : index
      %dim_5 = memref.dim %arg0, %c1 : memref<?x?xf32, strided<[?, 1], offset: ?>>
      %8 = arith.subi %dim_5, %5 : index
      %9 = arith.minsi %c3, %8 : index
      %subview = memref.subview %arg0[%4, %5] [%7, %9] [%c1, %c1] : memref<?x?xf32, strided<[?, 1], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
      %dim_6 = memref.dim %arg1, %c0 : memref<?x?xf32, strided<[?, 1], offset: ?>>
      %10 = affine.min #map2(%4)[%dim_6]
      %dim_7 = memref.dim %arg1, %c1 : memref<?x?xf32, strided<[?, 1], offset: ?>>
      %11 = affine.min #map3(%5)[%dim_7]
      %subview_8 = memref.subview %arg1[%4, %5] [%10, %11] [%c1, %c1] : memref<?x?xf32, strided<[?, 1], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
      %dim_9 = memref.dim %arg2, %c0 : memref<?x?xf32, strided<[?, 1], offset: ?>>
      %12 = affine.min #map2(%4)[%dim_9]
      %dim_10 = memref.dim %arg2, %c1 : memref<?x?xf32, strided<[?, 1], offset: ?>>
      %13 = affine.min #map3(%5)[%dim_10]
      %subview_11 = memref.subview %arg2[%4, %5] [%12, %13] [%c1, %c1] : memref<?x?xf32, strided<[?, 1], offset: ?>> to memref<?x?xf32, strided<[?, ?], offset: ?>>
      %14 = affine.apply #map1(%arg6)[%c1, %c0]
      %15 = arith.cmpi slt, %14, %7 : index
      scf.if %15 {
        %16 = affine.apply #map1(%arg7)[%c1, %c0]
        %17 = arith.cmpi slt, %16, %9 : index
        scf.if %17 {
          %18 = memref.load %subview[%14, %16] : memref<?x?xf32, strided<[?, ?], offset: ?>>
          %19 = memref.load %subview_8[%14, %16] : memref<?x?xf32, strided<[?, ?], offset: ?>>
          %20 = memref.load %subview_11[%14, %16] : memref<?x?xf32, strided<[?, ?], offset: ?>>
          %21 = arith.addf %18, %19 : f32
          memref.store %21, %subview_11[%14, %16] : memref<?x?xf32, strided<[?, ?], offset: ?>>
        }
      }
      gpu.terminator
    } {SCFToGPU_visited}
    return
  }
}

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module {
  func.func @parallel_loop_optional_attr() {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c1_0 = arith.constant 1 : index
    %0 = affine.apply #map(%c1)[%c0, %c1]
    gpu.launch blocks(%arg0, %arg1, %arg2) in (%arg6 = %0, %arg7 = %c1_0, %arg8 = %c1_0) threads(%arg3, %arg4, %arg5) in (%arg9 = %c1_0, %arg10 = %c1_0, %arg11 = %c1_0) {
      %1 = affine.apply #map1(%arg0)[%c1, %c0]
      gpu.terminator
    } {SCFToGPU_visited, optional_attr = 1 : i64}
    return
  }
}

// -----
module {
  func.func @parallel_double_map(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>) {
    %c4 = arith.constant 4 : index
    scf.parallel (%arg6, %arg7) = (%arg0, %arg1) to (%arg2, %arg3) step (%c4, %c4) {
      scf.reduce 
    } {mapping = [#gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>]}
    return
  }
}

// -----
module {
  func.func @parallel_loop_loop_variant_bound(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>) {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    scf.parallel (%arg6, %arg7) = (%arg0, %arg1) to (%arg2, %arg3) step (%c4, %c4) {
      scf.parallel (%arg8, %arg9) = (%c0, %c0) to (%arg6, %arg7) step (%c1, %c1) {
        %0 = arith.addi %arg6, %arg8 : index
        %1 = arith.addi %arg7, %arg9 : index
        %2 = memref.load %arg4[%0, %1] : memref<?x?xf32>
        memref.store %2, %arg5[%1, %0] : memref<?x?xf32>
        scf.reduce 
      } {mapping = [#gpu.loop_dim_map<processor = thread_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = sequential, map = (d0) -> (d0), bound = (d0) -> (d0)>]}
      scf.reduce 
    } {mapping = [#gpu.loop_dim_map<processor = block_y, map = (d0) -> (d0), bound = (d0) -> (d0)>, #gpu.loop_dim_map<processor = sequential, map = (d0) -> (d0), bound = (d0) -> (d0)>]}
    return
  }
}

// -----
module {
  func.func @parallel_no_annotations(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<?x?xf32>, %arg5: memref<?x?xf32>) {
    %c4 = arith.constant 4 : index
    scf.parallel (%arg6, %arg7) = (%arg0, %arg1) to (%arg2, %arg3) step (%c4, %c4) {
      scf.reduce 
    }
    return
  }
}

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module {
  func.func @step_invariant() {
    %alloc = memref.alloc() : memref<1x1xf64>
    %alloc_0 = memref.alloc() : memref<1x1xf64>
    %alloc_1 = memref.alloc() : memref<1x1xf64>
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c1_2 = arith.constant 1 : index
    %c1_3 = arith.constant 1 : index
    %0 = affine.apply #map(%c1)[%c0, %c1_2]
    %c1_4 = arith.constant 1 : index
    %c0_5 = arith.constant 0 : index
    %c1_6 = arith.constant 1 : index
    %1 = affine.apply #map(%c1_4)[%c0_5, %c1_6]
    gpu.launch blocks(%arg0, %arg1, %arg2) in (%arg6 = %0, %arg7 = %c1_3, %arg8 = %c1_3) threads(%arg3, %arg4, %arg5) in (%arg9 = %1, %arg10 = %c1_3, %arg11 = %c1_3) {
      %2 = affine.apply #map1(%arg0)[%c1_2, %c0]
      %c0_7 = arith.constant 0 : index
      %c1_8 = arith.constant 1 : index
      %c1_9 = arith.constant 1 : index
      %c1_10 = arith.constant 1 : index
      %c0_11 = arith.constant 0 : index
      %3 = affine.apply #map1(%arg3)[%c1_10, %c0_11]
      %4 = memref.load %alloc_1[%2, %3] : memref<1x1xf64>
      %5 = memref.load %alloc_0[%2, %3] : memref<1x1xf64>
      %6 = arith.addf %4, %5 : f64
      memref.store %6, %alloc[%2, %3] : memref<1x1xf64>
      gpu.terminator
    } {SCFToGPU_visited}
    memref.dealloc %alloc_1 : memref<1x1xf64>
    memref.dealloc %alloc_0 : memref<1x1xf64>
    memref.dealloc %alloc : memref<1x1xf64>
    return
  }
}

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module {
  func.func @parallel_reduction_1d() {
    %alloc = memref.alloc() : memref<f32>
    %alloc_0 = memref.alloc() : memref<64xf32>
    %c1 = arith.constant 1 : index
    %c64 = arith.constant 64 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1_1 = arith.constant 1 : index
    %0 = affine.apply #map(%c1)[%c0, %c1]
    %1 = affine.apply #map(%c64)[%c0, %c1]
    gpu.launch blocks(%arg0, %arg1, %arg2) in (%arg6 = %0, %arg7 = %c1_1, %arg8 = %c1_1) threads(%arg3, %arg4, %arg5) in (%arg9 = %1, %arg10 = %c1_1, %arg11 = %c1_1) {
      %2 = affine.apply #map1(%arg0)[%c1, %c0]
      %3 = affine.apply #map1(%arg3)[%c1, %c0]
      %4 = memref.load %alloc_0[%3] : memref<64xf32>
      %5 = gpu.all_reduce  %4 {
      ^bb0(%arg12: f32, %arg13: f32):
        %6 = arith.addf %arg12, %arg13 : f32
        gpu.yield %6 : f32
      } : (f32) -> f32
      memref.store %5, %alloc[] : memref<f32>
      gpu.terminator
    } {SCFToGPU_visited}
    memref.dealloc %alloc : memref<f32>
    memref.dealloc %alloc_0 : memref<64xf32>
    return
  }
}

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module {
  func.func @parallel_reduction_2d() {
    %alloc = memref.alloc() : memref<f32>
    %alloc_0 = memref.alloc() : memref<8x8xf32>
    %c1 = arith.constant 1 : index
    %c8 = arith.constant 8 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c1_1 = arith.constant 1 : index
    %0 = affine.apply #map(%c1)[%c0, %c1]
    %1 = affine.apply #map(%c8)[%c0, %c1]
    %2 = affine.apply #map(%c8)[%c0, %c1]
    gpu.launch blocks(%arg0, %arg1, %arg2) in (%arg6 = %0, %arg7 = %c1_1, %arg8 = %c1_1) threads(%arg3, %arg4, %arg5) in (%arg9 = %1, %arg10 = %2, %arg11 = %c1_1) {
      %3 = affine.apply #map1(%arg0)[%c1, %c0]
      %4 = affine.apply #map1(%arg3)[%c1, %c0]
      %5 = affine.apply #map1(%arg4)[%c1, %c0]
      %6 = memref.load %alloc_0[%4, %5] : memref<8x8xf32>
      %7 = gpu.all_reduce  %6 {
      ^bb0(%arg12: f32, %arg13: f32):
        %8 = arith.addf %arg12, %arg13 : f32
        gpu.yield %8 : f32
      } : (f32) -> f32
      memref.store %7, %alloc[] : memref<f32>
      gpu.terminator
    } {SCFToGPU_visited}
    memref.dealloc %alloc : memref<f32>
    memref.dealloc %alloc_0 : memref<8x8xf32>
    return
  }
}

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
#map2 = affine_map<(d0) -> (d0 * 128)>
module {
  func.func @parallel_reduction_1d_tiled() {
    %c128 = arith.constant 128 : index
    %c1 = arith.constant 1 : index
    %c64 = arith.constant 64 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %alloc = memref.alloc() : memref<8192xf32>
    %alloc_0 = memref.alloc() : memref<64xf32>
    %c1_1 = arith.constant 1 : index
    %0 = affine.apply #map(%c64)[%c0, %c1]
    %1 = affine.apply #map(%c128)[%c0, %c1]
    gpu.launch blocks(%arg0, %arg1, %arg2) in (%arg6 = %0, %arg7 = %c1_1, %arg8 = %c1_1) threads(%arg3, %arg4, %arg5) in (%arg9 = %1, %arg10 = %c1_1, %arg11 = %c1_1) {
      %2 = affine.apply #map1(%arg0)[%c1, %c0]
      %subview = memref.subview %alloc_0[%2] [1] [1] : memref<64xf32> to memref<f32, strided<[], offset: ?>>
      %3 = affine.apply #map2(%2)
      %subview_2 = memref.subview %alloc[%3] [128] [1] : memref<8192xf32> to memref<128xf32, strided<[1], offset: ?>>
      %4 = affine.apply #map1(%arg3)[%c1, %c0]
      %5 = memref.load %subview_2[%4] : memref<128xf32, strided<[1], offset: ?>>
      %6 = gpu.all_reduce  %5 {
      ^bb0(%arg12: f32, %arg13: f32):
        %7 = arith.addf %arg12, %arg13 : f32
        gpu.yield %7 : f32
      } : (f32) -> f32
      memref.store %6, %subview[] : memref<f32, strided<[], offset: ?>>
      gpu.terminator
    } {SCFToGPU_visited}
    memref.dealloc %alloc : memref<8192xf32>
    memref.dealloc %alloc_0 : memref<64xf32>
    return
  }
}

// -----
module {
  func.func @parallel_reduction_1d_uint(%arg0: ui32) {
    %alloc = memref.alloc() : memref<ui32>
    %alloc_0 = memref.alloc() : memref<64xui32>
    %c1 = arith.constant 1 : index
    %c64 = arith.constant 64 : index
    %c0 = arith.constant 0 : index
    scf.parallel (%arg1) = (%c0) to (%c1) step (%c1) {
      %0 = scf.parallel (%arg2) = (%c0) to (%c64) step (%c1) init (%arg0) -> ui32 {
        %1 = memref.load %alloc_0[%arg2] : memref<64xui32>
        scf.reduce(%1 : ui32) {
        ^bb0(%arg3: ui32, %arg4: ui32):
          scf.reduce.return %arg3 : ui32
        }
      } {mapping = [#gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]}
      memref.store %0, %alloc[] : memref<ui32>
      scf.reduce 
    } {mapping = [#gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]}
    memref.dealloc %alloc : memref<ui32>
    memref.dealloc %alloc_0 : memref<64xui32>
    return
  }
}

// -----
module {
  func.func @parallel_reduction_1d_outside() {
    %alloc = memref.alloc() : memref<f32>
    %alloc_0 = memref.alloc() : memref<64xf32>
    %c1 = arith.constant 1 : index
    %c64 = arith.constant 64 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %cst_1 = arith.constant 1.000000e+00 : f32
    scf.parallel (%arg0) = (%c0) to (%c1) step (%c1) {
      %0 = scf.parallel (%arg1) = (%c0) to (%c64) step (%c1) init (%cst) -> f32 {
        %1 = memref.load %alloc_0[%arg1] : memref<64xf32>
        scf.reduce(%1 : f32) {
        ^bb0(%arg2: f32, %arg3: f32):
          %2 = arith.addf %arg2, %arg3 : f32
          %3 = arith.addf %2, %cst_1 : f32
          scf.reduce.return %3 : f32
        }
      } {mapping = [#gpu.loop_dim_map<processor = thread_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]}
      memref.store %0, %alloc[] : memref<f32>
      scf.reduce 
    } {mapping = [#gpu.loop_dim_map<processor = block_x, map = (d0) -> (d0), bound = (d0) -> (d0)>]}
    memref.dealloc %alloc : memref<f32>
    memref.dealloc %alloc_0 : memref<64xf32>
    return
  }
}

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module {
  func.func @nested_parallel_with_side_effect() {
    %c65536 = arith.constant 65536 : index
    %c2 = arith.constant 2 : index
    %c256 = arith.constant 256 : index
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %alloc = memref.alloc() : memref<2x256x256xf32>
    %alloc_0 = memref.alloc() : memref<2x4x256x256xf32>
    %alloc_1 = memref.alloc() : memref<4x4xf32>
    %alloc_2 = memref.alloc() : memref<4x4xf32>
    %c1_3 = arith.constant 1 : index
    %0 = affine.apply #map(%c2)[%c0, %c1]
    %1 = affine.apply #map(%c4)[%c0, %c1]
    %2 = affine.apply #map(%c65536)[%c0, %c1]
    %3 = affine.apply #map(%c4)[%c0, %c1]
    gpu.launch blocks(%arg0, %arg1, %arg2) in (%arg6 = %2, %arg7 = %1, %arg8 = %0) threads(%arg3, %arg4, %arg5) in (%arg9 = %3, %arg10 = %c1_3, %arg11 = %c1_3) {
      %4 = affine.apply #map1(%arg2)[%c1, %c0]
      %5 = affine.apply #map1(%arg1)[%c1, %c0]
      %6 = affine.apply #map1(%arg0)[%c1, %c0]
      %7 = arith.remsi %6, %c256 : index
      %8 = arith.divsi %6, %c256 : index
      %9 = memref.load %alloc[%4, %8, %7] : memref<2x256x256xf32>
      memref.store %9, %alloc_0[%4, %5, %8, %7] : memref<2x4x256x256xf32>
      %10 = affine.apply #map1(%arg3)[%c1, %c0]
      %11 = memref.load %alloc_1[%10, %c0] : memref<4x4xf32>
      memref.store %11, %alloc_2[%10, %c0] : memref<4x4xf32>
      gpu.terminator
    } {SCFToGPU_visited}
    return
  }
}

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module {
  func.func @scf2gpu_index_creation_2d() {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c32 = arith.constant 32 : index
    %c1_0 = arith.constant 1 : index
    %0 = affine.apply #map(%c32)[%c0, %c1]
    %1 = affine.apply #map(%c32)[%c0, %c1]
    gpu.launch blocks(%arg0, %arg1, %arg2) in (%arg6 = %0, %arg7 = %c1_0, %arg8 = %c1_0) threads(%arg3, %arg4, %arg5) in (%arg9 = %1, %arg10 = %c1_0, %arg11 = %c1_0) {
      %2 = affine.apply #map1(%arg0)[%c1, %c0]
      %3 = affine.apply #map1(%arg3)[%c1, %c0]
      %4 = arith.addi %2, %c0 : index
      %5 = arith.addi %3, %c0 : index
      gpu.terminator
    } {SCFToGPU_visited}
    return
  }
}

// -----
#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module {
  func.func @scf2gpu_index_creation_1d() {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c64 = arith.constant 64 : index
    %c1_0 = arith.constant 1 : index
    %0 = affine.apply #map(%c64)[%c0, %c1]
    gpu.launch blocks(%arg0, %arg1, %arg2) in (%arg6 = %c1_0, %arg7 = %c1_0, %arg8 = %c1_0) threads(%arg3, %arg4, %arg5) in (%arg9 = %0, %arg10 = %c1_0, %arg11 = %c1_0) {
      %1 = affine.apply #map1(%arg3)[%c1, %c0]
      %2 = arith.addi %1, %c0 : index
      gpu.terminator
    } {SCFToGPU_visited}
    return
  }
}

