#map = affine_map<()[s0, s1] -> (s0 * s1)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  gpu.module @foo {
    gpu.func @memref3d(%arg0: memref<5x4xf32> {gpu.test_promote_workgroup}) workgroup(%arg1 : memref<5x4xf32, #gpu.address_space<workgroup>>) kernel {
      %c0 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      %c0_0 = arith.constant 0 : index
      %c5 = arith.constant 5 : index
      %c1_1 = arith.constant 1 : index
      %c4 = arith.constant 4 : index
      %thread_id_x = gpu.thread_id  x
      %block_dim_x = gpu.block_dim  x
      %thread_id_y = gpu.thread_id  y
      %block_dim_y = gpu.block_dim  y
      %thread_id_z = gpu.thread_id  z
      %block_dim_z = gpu.block_dim  z
      %0 = affine.apply #map()[%thread_id_z, %c1]
      %1 = affine.apply #map1()[%0, %c0]
      %2 = affine.apply #map()[%block_dim_z, %c1]
      scf.for %arg2 = %1 to %c1 step %2 {
        %6 = affine.apply #map()[%thread_id_y, %c1]
        %7 = affine.apply #map1()[%6, %c0]
        %8 = affine.apply #map()[%block_dim_y, %c1]
        scf.for %arg3 = %7 to %c5 step %8 {
          %9 = affine.apply #map()[%thread_id_x, %c1]
          %10 = affine.apply #map1()[%9, %c0]
          %11 = affine.apply #map()[%block_dim_x, %c1]
          scf.for %arg4 = %10 to %c4 step %11 {
            %12 = memref.load %arg0[%arg3, %arg4] : memref<5x4xf32>
            memref.store %12, %arg1[%arg3, %arg4] : memref<5x4xf32, #gpu.address_space<workgroup>>
          }
        }
      }
      gpu.barrier
      "use"(%arg1) : (memref<5x4xf32, #gpu.address_space<workgroup>>) -> ()
      gpu.barrier
      %c0_2 = arith.constant 0 : index
      %c1_3 = arith.constant 1 : index
      %c0_4 = arith.constant 0 : index
      %c5_5 = arith.constant 5 : index
      %c1_6 = arith.constant 1 : index
      %c4_7 = arith.constant 4 : index
      %thread_id_x_8 = gpu.thread_id  x
      %block_dim_x_9 = gpu.block_dim  x
      %thread_id_y_10 = gpu.thread_id  y
      %block_dim_y_11 = gpu.block_dim  y
      %thread_id_z_12 = gpu.thread_id  z
      %block_dim_z_13 = gpu.block_dim  z
      %3 = affine.apply #map()[%thread_id_z_12, %c1_3]
      %4 = affine.apply #map1()[%3, %c0_2]
      %5 = affine.apply #map()[%block_dim_z_13, %c1_3]
      scf.for %arg2 = %4 to %c1_3 step %5 {
        %6 = affine.apply #map()[%thread_id_y_10, %c1_3]
        %7 = affine.apply #map1()[%6, %c0_2]
        %8 = affine.apply #map()[%block_dim_y_11, %c1_3]
        scf.for %arg3 = %7 to %c5_5 step %8 {
          %9 = affine.apply #map()[%thread_id_x_8, %c1_3]
          %10 = affine.apply #map1()[%9, %c0_2]
          %11 = affine.apply #map()[%block_dim_x_9, %c1_3]
          scf.for %arg4 = %10 to %c4_7 step %11 {
            %12 = memref.load %arg1[%arg3, %arg4] : memref<5x4xf32, #gpu.address_space<workgroup>>
            memref.store %12, %arg0[%arg3, %arg4] : memref<5x4xf32>
          }
        }
      }
      gpu.return
    }
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 * s1)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  gpu.module @foo {
    gpu.func @memref5d(%arg0: memref<8x7x6x5x4xf32> {gpu.test_promote_workgroup}) workgroup(%arg1 : memref<8x7x6x5x4xf32, #gpu.address_space<workgroup>>) kernel {
      %c0 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      %c0_0 = arith.constant 0 : index
      %c8 = arith.constant 8 : index
      %c1_1 = arith.constant 1 : index
      %c7 = arith.constant 7 : index
      %c2 = arith.constant 2 : index
      %c6 = arith.constant 6 : index
      %c3 = arith.constant 3 : index
      %c5 = arith.constant 5 : index
      %c4 = arith.constant 4 : index
      %c4_2 = arith.constant 4 : index
      %thread_id_x = gpu.thread_id  x
      %block_dim_x = gpu.block_dim  x
      %thread_id_y = gpu.thread_id  y
      %block_dim_y = gpu.block_dim  y
      %thread_id_z = gpu.thread_id  z
      %block_dim_z = gpu.block_dim  z
      scf.for %arg2 = %c0 to %c8 step %c1 {
        scf.for %arg3 = %c0 to %c7 step %c1 {
          %0 = affine.apply #map()[%thread_id_z, %c1]
          %1 = affine.apply #map1()[%0, %c0]
          %2 = affine.apply #map()[%block_dim_z, %c1]
          scf.for %arg4 = %1 to %c6 step %2 {
            %3 = affine.apply #map()[%thread_id_y, %c1]
            %4 = affine.apply #map1()[%3, %c0]
            %5 = affine.apply #map()[%block_dim_y, %c1]
            scf.for %arg5 = %4 to %c5 step %5 {
              %6 = affine.apply #map()[%thread_id_x, %c1]
              %7 = affine.apply #map1()[%6, %c0]
              %8 = affine.apply #map()[%block_dim_x, %c1]
              scf.for %arg6 = %7 to %c4_2 step %8 {
                %9 = memref.load %arg0[%arg2, %arg3, %arg4, %arg5, %arg6] : memref<8x7x6x5x4xf32>
                memref.store %9, %arg1[%arg2, %arg3, %arg4, %arg5, %arg6] : memref<8x7x6x5x4xf32, #gpu.address_space<workgroup>>
              }
            }
          }
        }
      }
      gpu.barrier
      "use"(%arg1) : (memref<8x7x6x5x4xf32, #gpu.address_space<workgroup>>) -> ()
      gpu.barrier
      %c0_3 = arith.constant 0 : index
      %c1_4 = arith.constant 1 : index
      %c0_5 = arith.constant 0 : index
      %c8_6 = arith.constant 8 : index
      %c1_7 = arith.constant 1 : index
      %c7_8 = arith.constant 7 : index
      %c2_9 = arith.constant 2 : index
      %c6_10 = arith.constant 6 : index
      %c3_11 = arith.constant 3 : index
      %c5_12 = arith.constant 5 : index
      %c4_13 = arith.constant 4 : index
      %c4_14 = arith.constant 4 : index
      %thread_id_x_15 = gpu.thread_id  x
      %block_dim_x_16 = gpu.block_dim  x
      %thread_id_y_17 = gpu.thread_id  y
      %block_dim_y_18 = gpu.block_dim  y
      %thread_id_z_19 = gpu.thread_id  z
      %block_dim_z_20 = gpu.block_dim  z
      scf.for %arg2 = %c0_3 to %c8_6 step %c1_4 {
        scf.for %arg3 = %c0_3 to %c7_8 step %c1_4 {
          %0 = affine.apply #map()[%thread_id_z_19, %c1_4]
          %1 = affine.apply #map1()[%0, %c0_3]
          %2 = affine.apply #map()[%block_dim_z_20, %c1_4]
          scf.for %arg4 = %1 to %c6_10 step %2 {
            %3 = affine.apply #map()[%thread_id_y_17, %c1_4]
            %4 = affine.apply #map1()[%3, %c0_3]
            %5 = affine.apply #map()[%block_dim_y_18, %c1_4]
            scf.for %arg5 = %4 to %c5_12 step %5 {
              %6 = affine.apply #map()[%thread_id_x_15, %c1_4]
              %7 = affine.apply #map1()[%6, %c0_3]
              %8 = affine.apply #map()[%block_dim_x_16, %c1_4]
              scf.for %arg6 = %7 to %c4_14 step %8 {
                %9 = memref.load %arg1[%arg2, %arg3, %arg4, %arg5, %arg6] : memref<8x7x6x5x4xf32, #gpu.address_space<workgroup>>
                memref.store %9, %arg0[%arg2, %arg3, %arg4, %arg5, %arg6] : memref<8x7x6x5x4xf32>
              }
            }
          }
        }
      }
      gpu.return
    }
  }
}

// -----
#map = affine_map<()[s0, s1] -> (s0 * s1)>
#map1 = affine_map<()[s0, s1] -> (s0 + s1)>
module {
  gpu.module @foo {
    gpu.func @insert(%arg0: memref<4xf32> {gpu.test_promote_workgroup}) workgroup(%arg1 : memref<1x1xf64, #gpu.address_space<workgroup>>, %arg2 : memref<4xf32, #gpu.address_space<workgroup>>) private(%arg3 : memref<1x1xi64, 5>) kernel {
      %c0 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      %c0_0 = arith.constant 0 : index
      %c4 = arith.constant 4 : index
      %thread_id_x = gpu.thread_id  x
      %block_dim_x = gpu.block_dim  x
      %thread_id_y = gpu.thread_id  y
      %block_dim_y = gpu.block_dim  y
      %thread_id_z = gpu.thread_id  z
      %block_dim_z = gpu.block_dim  z
      %0 = affine.apply #map()[%thread_id_z, %c1]
      %1 = affine.apply #map1()[%0, %c0]
      %2 = affine.apply #map()[%block_dim_z, %c1]
      scf.for %arg4 = %1 to %c1 step %2 {
        %6 = affine.apply #map()[%thread_id_y, %c1]
        %7 = affine.apply #map1()[%6, %c0]
        %8 = affine.apply #map()[%block_dim_y, %c1]
        scf.for %arg5 = %7 to %c1 step %8 {
          %9 = affine.apply #map()[%thread_id_x, %c1]
          %10 = affine.apply #map1()[%9, %c0]
          %11 = affine.apply #map()[%block_dim_x, %c1]
          scf.for %arg6 = %10 to %c4 step %11 {
            %12 = memref.load %arg0[%arg6] : memref<4xf32>
            memref.store %12, %arg2[%arg6] : memref<4xf32, #gpu.address_space<workgroup>>
          }
        }
      }
      gpu.barrier
      "use"(%arg2) : (memref<4xf32, #gpu.address_space<workgroup>>) -> ()
      gpu.barrier
      %c0_1 = arith.constant 0 : index
      %c1_2 = arith.constant 1 : index
      %c0_3 = arith.constant 0 : index
      %c4_4 = arith.constant 4 : index
      %thread_id_x_5 = gpu.thread_id  x
      %block_dim_x_6 = gpu.block_dim  x
      %thread_id_y_7 = gpu.thread_id  y
      %block_dim_y_8 = gpu.block_dim  y
      %thread_id_z_9 = gpu.thread_id  z
      %block_dim_z_10 = gpu.block_dim  z
      %3 = affine.apply #map()[%thread_id_z_9, %c1_2]
      %4 = affine.apply #map1()[%3, %c0_1]
      %5 = affine.apply #map()[%block_dim_z_10, %c1_2]
      scf.for %arg4 = %4 to %c1_2 step %5 {
        %6 = affine.apply #map()[%thread_id_y_7, %c1_2]
        %7 = affine.apply #map1()[%6, %c0_1]
        %8 = affine.apply #map()[%block_dim_y_8, %c1_2]
        scf.for %arg5 = %7 to %c1_2 step %8 {
          %9 = affine.apply #map()[%thread_id_x_5, %c1_2]
          %10 = affine.apply #map1()[%9, %c0_1]
          %11 = affine.apply #map()[%block_dim_x_6, %c1_2]
          scf.for %arg6 = %10 to %c4_4 step %11 {
            %12 = memref.load %arg2[%arg6] : memref<4xf32, #gpu.address_space<workgroup>>
            memref.store %12, %arg0[%arg6] : memref<4xf32>
          }
        }
      }
      gpu.return
    }
  }
}

