module {
  func.func @blocks_3d(%arg0: memref<2x32xf32>, %arg1: memref<2x32xf32>, %arg2: memref<32xf32>, %arg3: f32, %arg4: !gpu.async.token) -> memref<2x32xf32> {
    %c9 = arith.constant 9 : index
    %c7 = arith.constant 7 : index
    %c1 = arith.constant 1 : index
    %c12 = arith.constant 12 : index
    %0 = gpu.launch async [%arg4] blocks(%arg5, %arg6, %arg7) in (%arg11 = %c12, %arg12 = %c9, %arg13 = %c1) threads(%arg8, %arg9, %arg10) in (%arg14 = %c1, %arg15 = %c1, %arg16 = %c1) {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %1 = arith.cmpi ult, %block_id_x, %c7 : index
      scf.if %1 {
        %2 = memref.load %arg0[%block_id_x, %block_id_y] : memref<2x32xf32>
        %3 = memref.load %arg1[%block_id_x, %block_id_y] : memref<2x32xf32>
        %4 = math.fma %arg3, %2, %3 : f32
        memref.store %4, %arg1[%block_id_x, %block_id_y] : memref<2x32xf32>
      }
      gpu.terminator
    }
    return %arg1 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["gpu.launch"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_forall_to_blocks %0 grid_dims = [12, 9, 1] : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<()[s0] -> (s0 floordiv 128)>
module {
  func.func @warpgroup_3d(%arg0: memref<2x32xf32>, %arg1: memref<2x32xf32>, %arg2: memref<32xf32>, %arg3: f32, %arg4: !gpu.async.token) -> memref<2x32xf32> {
    %c384 = arith.constant 384 : index
    %c1 = arith.constant 1 : index
    %c512 = arith.constant 512 : index
    %c2 = arith.constant 2 : index
    %0 = gpu.launch async [%arg4] blocks(%arg5, %arg6, %arg7) in (%arg11 = %c1, %arg12 = %c1, %arg13 = %c1) threads(%arg8, %arg9, %arg10) in (%arg14 = %c512, %arg15 = %c2, %arg16 = %c1) {
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %1 = affine.apply #map()[%thread_id_x]
      %2 = arith.cmpi ult, %thread_id_x, %c384 : index
      %3 = arith.cmpi ult, %thread_id_y, %c1 : index
      %4 = arith.andi %2, %3 : i1
      scf.if %4 {
        %5 = memref.load %arg0[%1, %thread_id_y] : memref<2x32xf32>
        %6 = memref.load %arg1[%1, %thread_id_y] : memref<2x32xf32>
        %7 = math.fma %arg3, %5, %6 : f32
        memref.store %7, %arg1[%1, %thread_id_y] : memref<2x32xf32>
      }
      gpu.barrier
      gpu.terminator
    }
    return %arg1 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["gpu.launch"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_nested_forall_to_threads %0 block_dims = [512, 2, 1] : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<()[s0] -> (s0 floordiv 16)>
module {
  func.func @warp_3d(%arg0: memref<2x32xf32>, %arg1: memref<2x32xf32>, %arg2: memref<32xf32>, %arg3: f32, %arg4: !gpu.async.token) -> memref<2x32xf32> {
    %c32 = arith.constant 32 : index
    %c3 = arith.constant 3 : index
    %c1 = arith.constant 1 : index
    %c64 = arith.constant 64 : index
    %c4 = arith.constant 4 : index
    %0 = gpu.launch async [%arg4] blocks(%arg5, %arg6, %arg7) in (%arg11 = %c1, %arg12 = %c1, %arg13 = %c1) threads(%arg8, %arg9, %arg10) in (%arg14 = %c64, %arg15 = %c4, %arg16 = %c3) {
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %1 = affine.apply #map()[%thread_id_x]
      %2 = arith.cmpi ult, %thread_id_x, %c32 : index
      %3 = arith.cmpi ult, %thread_id_y, %c3 : index
      %4 = arith.andi %2, %3 : i1
      scf.if %4 {
        %5 = memref.load %arg0[%1, %thread_id_y] : memref<2x32xf32>
        %6 = memref.load %arg1[%1, %thread_id_y] : memref<2x32xf32>
        %7 = math.fma %arg3, %5, %6 : f32
        memref.store %7, %arg1[%1, %thread_id_y] : memref<2x32xf32>
      }
      gpu.barrier
      gpu.terminator
    }
    return %arg1 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["gpu.launch"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_nested_forall_to_threads %0 block_dims = [64, 4, 3] warp_size = 16 : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @threads_3d(%arg0: memref<2x32xf32>, %arg1: memref<2x32xf32>, %arg2: memref<32xf32>, %arg3: f32, %arg4: !gpu.async.token) -> memref<2x32xf32> {
    %c1 = arith.constant 1 : index
    %c12 = arith.constant 12 : index
    %c9 = arith.constant 9 : index
    %c7 = arith.constant 7 : index
    %0 = gpu.launch async [%arg4] blocks(%arg5, %arg6, %arg7) in (%arg11 = %c1, %arg12 = %c1, %arg13 = %c1) threads(%arg8, %arg9, %arg10) in (%arg14 = %c12, %arg15 = %c9, %arg16 = %c1) {
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %1 = arith.cmpi ult, %thread_id_x, %c9 : index
      %2 = arith.cmpi ult, %thread_id_y, %c7 : index
      %3 = arith.andi %1, %2 : i1
      scf.if %3 {
        %5 = memref.load %arg0[%thread_id_y, %thread_id_x] : memref<2x32xf32>
        %6 = memref.load %arg1[%thread_id_y, %thread_id_x] : memref<2x32xf32>
        %7 = math.fma %arg3, %5, %6 : f32
        memref.store %7, %arg1[%thread_id_y, %thread_id_x] : memref<2x32xf32>
      }
      gpu.barrier
      %4 = arith.cmpi ult, %thread_id_y, %c1 : index
      scf.if %4 {
        %5 = memref.load %arg2[%thread_id_x] : memref<32xf32>
        %6 = arith.addf %arg3, %5 : f32
        memref.store %6, %arg2[%thread_id_x] : memref<32xf32>
      }
      gpu.barrier
      gpu.terminator
    }
    return %arg1 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["gpu.launch"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_nested_forall_to_threads %0 block_dims = [12, 9, 1] : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @saxpy4d(%arg0: memref<32x64x4x32xf32>, %arg1: memref<32x64x4x32xf32>, %arg2: f32) -> memref<32x64x4x32xf32> {
    %c32 = arith.constant 32 : index
    %c64 = arith.constant 64 : index
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    gpu.launch blocks(%arg3, %arg4, %arg5) in (%arg9 = %c32, %arg10 = %c64, %arg11 = %c1) threads(%arg6, %arg7, %arg8) in (%arg12 = %c32, %arg13 = %c4, %arg14 = %c1) {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %0 = memref.load %arg0[%block_id_x, %block_id_y, %thread_id_y, %thread_id_x] : memref<32x64x4x32xf32>
      %1 = memref.load %arg1[%block_id_x, %block_id_y, %thread_id_y, %thread_id_x] : memref<32x64x4x32xf32>
      %2 = math.fma %arg2, %0, %1 : f32
      memref.store %2, %arg1[%block_id_x, %block_id_y, %thread_id_y, %thread_id_x] : memref<32x64x4x32xf32>
      gpu.barrier
      gpu.terminator
    }
    return %arg1 : memref<32x64x4x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_forall_to_blocks %0 generate_gpu_launch : (!transform.any_op) -> !transform.any_op
      %2 = transform.gpu.map_nested_forall_to_threads %1 block_dims = [32, 4, 1] : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @saxpy2d_no_barrier(%arg0: memref<2x32xf32>, %arg1: memref<2x32xf32>, %arg2: memref<32xf32>, %arg3: f32, %arg4: !gpu.async.token) -> memref<2x32xf32> {
    %c1 = arith.constant 1 : index
    %c12 = arith.constant 12 : index
    %c9 = arith.constant 9 : index
    %c7 = arith.constant 7 : index
    %0 = gpu.launch async [%arg4] blocks(%arg5, %arg6, %arg7) in (%arg11 = %c1, %arg12 = %c1, %arg13 = %c1) threads(%arg8, %arg9, %arg10) in (%arg14 = %c12, %arg15 = %c9, %arg16 = %c1) {
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %1 = arith.cmpi ult, %thread_id_x, %c9 : index
      %2 = arith.cmpi ult, %thread_id_y, %c7 : index
      %3 = arith.andi %1, %2 : i1
      scf.if %3 {
        %4 = memref.load %arg0[%thread_id_y, %thread_id_x] : memref<2x32xf32>
        %5 = memref.load %arg1[%thread_id_y, %thread_id_x] : memref<2x32xf32>
        %6 = math.fma %arg3, %4, %5 : f32
        memref.store %6, %arg1[%thread_id_y, %thread_id_x] : memref<2x32xf32>
      }
      gpu.terminator
    }
    return %arg1 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["gpu.launch"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_nested_forall_to_threads %0 block_dims = [12, 9, 1] sync_after_distribute = false : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @saxpy2d_singleloop(%arg0: memref<32x32xf32>, %arg1: memref<32x32xf32>, %arg2: !gpu.async.token) -> memref<32x32xf32> {
    %c32 = arith.constant 32 : index
    %c1 = arith.constant 1 : index
    %0 = gpu.launch async [%arg2] blocks(%arg3, %arg4, %arg5) in (%arg9 = %c1, %arg10 = %c1, %arg11 = %c1) threads(%arg6, %arg7, %arg8) in (%arg12 = %c32, %arg13 = %c1, %arg14 = %c1) {
      %thread_id_x = gpu.thread_id  x
      %1 = memref.load %arg0[%thread_id_x, %thread_id_x] : memref<32x32xf32>
      %2 = memref.load %arg1[%thread_id_x, %thread_id_x] : memref<32x32xf32>
      %3 = arith.mulf %1, %2 : f32
      memref.store %3, %arg1[%thread_id_x, %thread_id_x] : memref<32x32xf32>
      gpu.barrier
      gpu.terminator
    }
    return %arg1 : memref<32x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["gpu.launch"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_nested_forall_to_threads %0 block_dims = [32, 1, 1] : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
module {
  func.func @saxpy3d_fold_id_z(%arg0: memref<3x2x32xf32>, %arg1: memref<3x2x32xf32>, %arg2: memref<32xf32>, %arg3: f32, %arg4: !gpu.async.token) -> memref<3x2x32xf32> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c12 = arith.constant 12 : index
    %c9 = arith.constant 9 : index
    %c7 = arith.constant 7 : index
    %0 = gpu.launch async [%arg4] blocks(%arg5, %arg6, %arg7) in (%arg11 = %c1, %arg12 = %c1, %arg13 = %c1) threads(%arg8, %arg9, %arg10) in (%arg14 = %c12, %arg15 = %c9, %arg16 = %c1) {
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %1 = arith.cmpi ult, %thread_id_x, %c9 : index
      %2 = arith.cmpi ult, %thread_id_y, %c7 : index
      %3 = arith.andi %1, %2 : i1
      scf.if %3 {
        %4 = memref.load %arg0[%c0, %thread_id_y, %thread_id_x] : memref<3x2x32xf32>
        %5 = memref.load %arg1[%c0, %thread_id_y, %thread_id_x] : memref<3x2x32xf32>
        %6 = math.fma %arg3, %4, %5 : f32
        memref.store %6, %arg1[%c0, %thread_id_y, %thread_id_x] : memref<3x2x32xf32>
      }
      gpu.terminator
    }
    return %arg1 : memref<3x2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["gpu.launch"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_nested_forall_to_threads %0 block_dims = [12, 9, 1] sync_after_distribute = false : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * 32 + s2 * 256)>
#map1 = affine_map<()[s0, s1] -> (((s0 + s1 * 32) floordiv 128) mod 2)>
#map2 = affine_map<()[s0, s1, s2] -> (s2 + ((s0 + s1 * 32) floordiv 128) floordiv 2)>
module {
  func.func @warpgroup_linear(%arg0: memref<2x32xf32>, %arg1: memref<2x32xf32>, %arg2: memref<32xf32>, %arg3: f32, %arg4: !gpu.async.token) -> memref<2x32xf32> {
    %c768 = arith.constant 768 : index
    %c1 = arith.constant 1 : index
    %c32 = arith.constant 32 : index
    %c8 = arith.constant 8 : index
    %c4 = arith.constant 4 : index
    %0 = gpu.launch async [%arg4] blocks(%arg5, %arg6, %arg7) in (%arg11 = %c1, %arg12 = %c1, %arg13 = %c1) threads(%arg8, %arg9, %arg10) in (%arg14 = %c32, %arg15 = %c8, %arg16 = %c4) {
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %1 = affine.apply #map()[%thread_id_x, %thread_id_y, %thread_id_z]
      %2 = affine.apply #map1()[%thread_id_x, %thread_id_y]
      %3 = affine.apply #map2()[%thread_id_x, %thread_id_y, %thread_id_z]
      %4 = arith.cmpi ult, %1, %c768 : index
      scf.if %4 {
        %5 = memref.load %arg0[%2, %3] : memref<2x32xf32>
        %6 = memref.load %arg1[%2, %3] : memref<2x32xf32>
        %7 = math.fma %arg3, %5, %6 : f32
        memref.store %7, %arg1[%2, %3] : memref<2x32xf32>
      }
      gpu.barrier
      gpu.terminator
    }
    return %arg1 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["gpu.launch"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_nested_forall_to_threads %0 block_dims = [32, 8, 4] : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * 32 + s2 * 256)>
#map1 = affine_map<()[s0, s1, s2] -> ((s1 + s2 * 8 + s0 floordiv 32) mod 2)>
#map2 = affine_map<()[s0, s1, s2] -> ((s1 + s2 * 8 + s0 floordiv 32) floordiv 2)>
module {
  func.func @warp_linear(%arg0: memref<2x32xf32>, %arg1: memref<2x32xf32>, %arg2: memref<32xf32>, %arg3: f32, %arg4: !gpu.async.token) -> memref<2x32xf32> {
    %c192 = arith.constant 192 : index
    %c1 = arith.constant 1 : index
    %c32 = arith.constant 32 : index
    %c8 = arith.constant 8 : index
    %c4 = arith.constant 4 : index
    %0 = gpu.launch async [%arg4] blocks(%arg5, %arg6, %arg7) in (%arg11 = %c1, %arg12 = %c1, %arg13 = %c1) threads(%arg8, %arg9, %arg10) in (%arg14 = %c32, %arg15 = %c8, %arg16 = %c4) {
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %1 = affine.apply #map()[%thread_id_x, %thread_id_y, %thread_id_z]
      %2 = affine.apply #map1()[%thread_id_x, %thread_id_y, %thread_id_z]
      %3 = affine.apply #map2()[%thread_id_x, %thread_id_y, %thread_id_z]
      %4 = arith.cmpi ult, %1, %c192 : index
      scf.if %4 {
        %5 = memref.load %arg0[%2, %3] : memref<2x32xf32>
        %6 = memref.load %arg1[%2, %3] : memref<2x32xf32>
        %7 = math.fma %arg3, %5, %6 : f32
        memref.store %7, %arg1[%2, %3] : memref<2x32xf32>
      }
      gpu.barrier
      gpu.terminator
    }
    return %arg1 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["gpu.launch"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_nested_forall_to_threads %0 block_dims = [32, 8, 4] : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 + s1 * 18)>
#map1 = affine_map<()[s0, s1] -> (((s0 + s1 * 18) floordiv 32) mod 3)>
#map2 = affine_map<()[s0, s1] -> ((((s0 + s1 * 18) floordiv 32) mod 6) floordiv 3)>
#map3 = affine_map<()[s0, s1] -> ((s0 + s1 * 18) mod 10)>
#map4 = affine_map<()[s0, s1] -> ((s0 + s1 * 18) floordiv 10)>
module {
  func.func @map_multi_level_linear(%arg0: memref<2x32xf32>, %arg1: memref<2x32xf32>, %arg2: memref<32xf32>, %arg3: f32, %arg4: !gpu.async.token) -> memref<2x32xf32> {
    %c20 = arith.constant 20 : index
    %c192 = arith.constant 192 : index
    %c1 = arith.constant 1 : index
    %c18 = arith.constant 18 : index
    %c11 = arith.constant 11 : index
    %c9 = arith.constant 9 : index
    %c7 = arith.constant 7 : index
    %0 = gpu.launch async [%arg4] blocks(%arg5, %arg6, %arg7) in (%arg11 = %c1, %arg12 = %c1, %arg13 = %c1) threads(%arg8, %arg9, %arg10) in (%arg14 = %c18, %arg15 = %c11, %arg16 = %c1) {
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %1 = arith.cmpi ult, %thread_id_x, %c9 : index
      %2 = arith.cmpi ult, %thread_id_y, %c7 : index
      %3 = arith.andi %1, %2 : i1
      scf.if %3 {
        %11 = memref.load %arg0[%thread_id_y, %thread_id_x] : memref<2x32xf32>
        %12 = memref.load %arg1[%thread_id_y, %thread_id_x] : memref<2x32xf32>
        %13 = math.fma %arg3, %11, %12 : f32
        memref.store %13, %arg1[%thread_id_y, %thread_id_x] : memref<2x32xf32>
      }
      gpu.barrier
      %4 = affine.apply #map()[%thread_id_x, %thread_id_y]
      %5 = affine.apply #map1()[%thread_id_x, %thread_id_y]
      %6 = affine.apply #map2()[%thread_id_x, %thread_id_y]
      %7 = arith.cmpi ult, %4, %c192 : index
      scf.if %7 {
        %11 = memref.load %arg0[%5, %6] : memref<2x32xf32>
        %12 = arith.addf %arg3, %11 : f32
        memref.store %12, %arg1[%5, %6] : memref<2x32xf32>
      }
      gpu.barrier
      %8 = affine.apply #map3()[%thread_id_x, %thread_id_y]
      %9 = affine.apply #map4()[%thread_id_x, %thread_id_y]
      %10 = arith.cmpi ult, %4, %c20 : index
      scf.if %10 {
        %11 = memref.load %arg2[%8] : memref<32xf32>
        %12 = arith.addf %arg3, %11 : f32
        memref.store %12, %arg2[%9] : memref<32xf32>
      }
      gpu.barrier
      gpu.terminator
    }
    return %arg1 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["gpu.launch"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_nested_forall_to_threads %0 block_dims = [18, 11, 1] : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<()[s0, s1, s2] -> (s0 + s1 * 12 + s2 * 108)>
#map1 = affine_map<()[s0, s1, s2] -> ((s0 + s1 * 12 + s2 * 108) mod 7)>
#map2 = affine_map<()[s0, s1, s2] -> ((s0 + s1 * 12 + s2 * 108) floordiv 7)>
module {
  func.func @block_linear_existing_launch(%arg0: memref<2x32xf32>, %arg1: memref<2x32xf32>, %arg2: memref<32xf32>, %arg3: f32, %arg4: !gpu.async.token) -> memref<2x32xf32> {
    %c63 = arith.constant 63 : index
    %c9 = arith.constant 9 : index
    %c1 = arith.constant 1 : index
    %c12 = arith.constant 12 : index
    %0 = gpu.launch async [%arg4] blocks(%arg5, %arg6, %arg7) in (%arg11 = %c12, %arg12 = %c9, %arg13 = %c1) threads(%arg8, %arg9, %arg10) in (%arg14 = %c1, %arg15 = %c1, %arg16 = %c1) {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %1 = affine.apply #map()[%block_id_x, %block_id_y, %block_id_z]
      %2 = affine.apply #map1()[%block_id_x, %block_id_y, %block_id_z]
      %3 = affine.apply #map2()[%block_id_x, %block_id_y, %block_id_z]
      %4 = arith.cmpi ult, %1, %c63 : index
      scf.if %4 {
        %5 = memref.load %arg0[%2, %3] : memref<2x32xf32>
        %6 = memref.load %arg1[%2, %3] : memref<2x32xf32>
        %7 = math.fma %arg3, %5, %6 : f32
        memref.store %7, %arg1[%2, %3] : memref<2x32xf32>
      }
      gpu.terminator
    }
    return %arg1 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["gpu.launch"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_forall_to_blocks %0 grid_dims = [12, 9, 1] : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<()[s0] -> (s0 mod 7)>
#map1 = affine_map<()[s0, s1, s2] -> (s1 + s2 * 9 + s0 floordiv 7)>
module {
  func.func @block_linear_generate_launch(%arg0: memref<2x32xf32>, %arg1: memref<2x32xf32>, %arg2: memref<32xf32>, %arg3: f32, %arg4: !gpu.async.token) -> memref<2x32xf32> {
    %c9 = arith.constant 9 : index
    %c7 = arith.constant 7 : index
    %c1 = arith.constant 1 : index
    gpu.launch blocks(%arg5, %arg6, %arg7) in (%arg11 = %c7, %arg12 = %c9, %arg13 = %c1) threads(%arg8, %arg9, %arg10) in (%arg14 = %c1, %arg15 = %c1, %arg16 = %c1) {
      %block_id_x = gpu.block_id  x
      %block_id_y = gpu.block_id  y
      %block_id_z = gpu.block_id  z
      %0 = affine.apply #map()[%block_id_x]
      %1 = affine.apply #map1()[%block_id_x, %block_id_y, %block_id_z]
      %2 = memref.load %arg0[%0, %1] : memref<2x32xf32>
      %3 = memref.load %arg1[%0, %1] : memref<2x32xf32>
      %4 = math.fma %arg3, %2, %3 : f32
      memref.store %4, %arg1[%0, %1] : memref<2x32xf32>
      gpu.terminator
    }
    return %arg1 : memref<2x32xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_forall_to_blocks %0 generate_gpu_launch : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<()[s0] -> (s0 * 128)>
#map1 = affine_map<()[s0, s1, s2] -> (s2 * 32 + ((s0 + s1 * 4) floordiv 32) * 32)>
module {
  func.func @simple_fill(%arg0: memref<128xf32>) -> memref<128xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<0.000000e+00> : vector<32xf32>
    %c1 = arith.constant 1 : index
    %c4 = arith.constant 4 : index
    %c8 = arith.constant 8 : index
    gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %c1, %arg8 = %c1, %arg9 = %c1) threads(%arg4, %arg5, %arg6) in (%arg10 = %c4, %arg11 = %c8, %arg12 = %c4) {
      %block_id_x = gpu.block_id  x
      %0 = affine.apply #map()[%block_id_x]
      %subview = memref.subview %arg0[%0] [128] [1] : memref<128xf32> to memref<128xf32, strided<[1], offset: ?>>
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %thread_id_z = gpu.thread_id  z
      %1 = affine.apply #map1()[%thread_id_x, %thread_id_y, %thread_id_z]
      %subview_0 = memref.subview %subview[%1] [32] [1] : memref<128xf32, strided<[1], offset: ?>> to memref<32xf32, strided<[1], offset: ?>>
      vector.transfer_write %cst, %subview_0[%c0] {in_bounds = [true]} : vector<32xf32>, memref<32xf32, strided<[1], offset: ?>>
      gpu.barrier
      gpu.terminator
    }
    return %arg0 : memref<128xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_forall_to_blocks %0 generate_gpu_launch : (!transform.any_op) -> !transform.any_op
      %2 = transform.gpu.map_nested_forall_to_threads %1 block_dims = [4, 8, 4] : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<()[s0] -> (s0 * 128)>
#map1 = affine_map<()[s0, s1] -> ((s0 + s1 * 73) mod 32)>
#map2 = affine_map<()[s0, s1] -> (s0 * 32 + s1 * 2336 - ((s0 + s1 * 73) floordiv 2) * 64)>
#map3 = affine_map<()[s0, s1] -> ((((s0 + s1 * 73) mod 32) floordiv 2) * 32)>
module {
  func.func @simple_fill(%arg0: memref<128x256xf32>) -> memref<128x256xf32> {
    %c6 = arith.constant 6 : index
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<0.000000e+00> : vector<16x32xf32>
    %c1 = arith.constant 1 : index
    %c73 = arith.constant 73 : index
    %c5 = arith.constant 5 : index
    gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %c1, %arg8 = %c1, %arg9 = %c1) threads(%arg4, %arg5, %arg6) in (%arg10 = %c73, %arg11 = %c5, %arg12 = %c1) {
      %block_id_x = gpu.block_id  x
      %0 = affine.apply #map()[%block_id_x]
      %subview = memref.subview %arg0[%0, 0] [128, 256] [1, 1] : memref<128x256xf32> to memref<128x256xf32, strided<[256, 1], offset: ?>>
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %1 = affine.apply #map1()[%thread_id_x, %thread_id_y]
      %2 = arith.cmpi ult, %1, %c6 : index
      scf.if %2 {
        %3 = affine.apply #map2()[%thread_id_x, %thread_id_y]
        %4 = affine.apply #map3()[%thread_id_x, %thread_id_y]
        %subview_0 = memref.subview %subview[%3, %4] [16, 32] [1, 1] : memref<128x256xf32, strided<[256, 1], offset: ?>> to memref<16x32xf32, strided<[256, 1], offset: ?>>
        vector.transfer_write %cst, %subview_0[%c0, %c0] {in_bounds = [true, true]} : vector<16x32xf32>, memref<16x32xf32, strided<[256, 1], offset: ?>>
      }
      gpu.barrier
      gpu.terminator
    }
    return %arg0 : memref<128x256xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_forall_to_blocks %0 generate_gpu_launch : (!transform.any_op) -> !transform.any_op
      %2 = transform.gpu.map_nested_forall_to_threads %1 block_dims = [73, 5, 1] : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

// -----
#map = affine_map<()[s0] -> (s0 * 128)>
#map1 = affine_map<()[s0, s1] -> ((s0 + s1 * 73) floordiv 32)>
#map2 = affine_map<()[s0] -> (s0 * 32 - (s0 floordiv 2) * 64)>
#map3 = affine_map<()[s0] -> ((s0 floordiv 2) * 32)>
module {
  func.func @simple_fill(%arg0: memref<128xf32>) -> memref<128xf32> {
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %c753_i64 = arith.constant 753 : i64
    %c0 = arith.constant 0 : index
    %cst = arith.constant dense<0.000000e+00> : vector<32xf32>
    %c1 = arith.constant 1 : index
    %c73 = arith.constant 73 : index
    %c5 = arith.constant 5 : index
    gpu.launch blocks(%arg1, %arg2, %arg3) in (%arg7 = %c1, %arg8 = %c1, %arg9 = %c1) threads(%arg4, %arg5, %arg6) in (%arg10 = %c73, %arg11 = %c5, %arg12 = %c1) {
      %block_id_x = gpu.block_id  x
      %0 = affine.apply #map()[%block_id_x]
      %subview = memref.subview %arg0[%0] [128] [1] : memref<128xf32> to memref<128xf32, strided<[1], offset: ?>>
      %thread_id_x = gpu.thread_id  x
      %thread_id_y = gpu.thread_id  y
      %1 = affine.apply #map1()[%thread_id_x, %thread_id_y]
      %2 = arith.index_castui %1 : index to i64
      %3 = arith.shli %c1_i64, %2 : i64
      %4 = arith.subi %3, %c1_i64 : i64
      %5 = arith.andi %4, %c753_i64 : i64
      %6 = math.ctpop %5 : i64
      %7 = arith.index_castui %6 : i64 to index
      %8 = arith.andi %3, %c753_i64 : i64
      %9 = arith.cmpi ne, %8, %c0_i64 : i64
      scf.if %9 {
        %10 = affine.apply #map2()[%7]
        %11 = affine.apply #map3()[%7]
        %subview_0 = memref.subview %subview[%10] [%11] [1] : memref<128xf32, strided<[1], offset: ?>> to memref<?xf32, strided<[1], offset: ?>>
        vector.transfer_write %cst, %subview_0[%c0] {in_bounds = [true]} : vector<32xf32>, memref<?xf32, strided<[1], offset: ?>>
      }
      gpu.barrier
      gpu.terminator
    }
    return %arg0 : memref<128xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["func.func"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %1 = transform.gpu.map_forall_to_blocks %0 generate_gpu_launch : (!transform.any_op) -> !transform.any_op
      %2 = transform.gpu.map_nested_forall_to_threads %1 block_dims = [73, 5, 1] : (!transform.any_op) -> !transform.any_op
      transform.yield 
    }
  }
}

