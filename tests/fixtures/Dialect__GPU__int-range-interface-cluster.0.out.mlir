module {
  gpu.module @test_module {
    gpu.func @test_cluster_ranges() kernel attributes {known_cluster_size = array<i32: 8, 4, 1>} {
      %c1 = arith.constant 1 : index
      %c4 = arith.constant 4 : index
      %c8 = arith.constant 8 : index
      %c0 = arith.constant 0 : index
      %cluster_block_id_x = gpu.cluster_block_id  x
      %0 = test.reflect_bounds {smax = 7 : index, smin = 0 : index, umax = 7 : index, umin = 0 : index} %cluster_block_id_x : index
      %cluster_block_id_y = gpu.cluster_block_id  y
      %1 = test.reflect_bounds {smax = 3 : index, smin = 0 : index, umax = 3 : index, umin = 0 : index} %cluster_block_id_y : index
      %2 = test.reflect_bounds {smax = 0 : index, smin = 0 : index, umax = 0 : index, umin = 0 : index} %c0 : index
      %3 = test.reflect_bounds {smax = 8 : index, smin = 8 : index, umax = 8 : index, umin = 8 : index} %c8 : index
      %4 = test.reflect_bounds {smax = 4 : index, smin = 4 : index, umax = 4 : index, umin = 4 : index} %c4 : index
      %5 = test.reflect_bounds {smax = 1 : index, smin = 1 : index, umax = 1 : index, umin = 1 : index} %c1 : index
      gpu.return
    }
  }
}

