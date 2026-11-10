"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "gpu.func"() <{function_type = () -> (), kernel, known_cluster_size = array<i32: 8, 4, 1>}> ({
      %12 = "arith.constant"() <{value = 1 : index}> : () -> index
      %13 = "arith.constant"() <{value = 4 : index}> : () -> index
      %14 = "arith.constant"() <{value = 8 : index}> : () -> index
      %15 = "arith.constant"() <{value = 0 : index}> : () -> index
      %16 = "gpu.cluster_block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %17 = "test.reflect_bounds"(%16) <{smax = 7 : index, smin = 0 : index, umax = 7 : index, umin = 0 : index}> : (index) -> index
      %18 = "gpu.cluster_block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %19 = "test.reflect_bounds"(%18) <{smax = 3 : index, smin = 0 : index, umax = 3 : index, umin = 0 : index}> : (index) -> index
      %20 = "test.reflect_bounds"(%15) <{smax = 0 : index, smin = 0 : index, umax = 0 : index, umin = 0 : index}> : (index) -> index
      %21 = "test.reflect_bounds"(%14) <{smax = 8 : index, smin = 8 : index, umax = 8 : index, umin = 8 : index}> : (index) -> index
      %22 = "test.reflect_bounds"(%13) <{smax = 4 : index, smin = 4 : index, umax = 4 : index, umin = 4 : index}> : (index) -> index
      %23 = "test.reflect_bounds"(%12) <{smax = 1 : index, smin = 1 : index, umax = 1 : index, umin = 1 : index}> : (index) -> index
      "gpu.return"() : () -> ()
    }) {sym_name = "test_cluster_ranges"} : () -> ()
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "gpu.cluster_block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "test.reflect_bounds"(%0) <{smax = 15 : index, smin = 0 : index, umax = 15 : index, umin = 0 : index}> : (index) -> index
      %2 = "gpu.cluster_block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %3 = "test.reflect_bounds"(%2) <{smax = 15 : index, smin = 0 : index, umax = 15 : index, umin = 0 : index}> : (index) -> index
      %4 = "gpu.cluster_block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %5 = "test.reflect_bounds"(%4) <{smax = 15 : index, smin = 0 : index, umax = 15 : index, umin = 0 : index}> : (index) -> index
      %6 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "test.reflect_bounds"(%6) <{smax = 16 : index, smin = 1 : index, umax = 16 : index, umin = 1 : index}> : (index) -> index
      %8 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim y>}> : () -> index
      %9 = "test.reflect_bounds"(%8) <{smax = 16 : index, smin = 1 : index, umax = 16 : index, umin = 1 : index}> : (index) -> index
      %10 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim z>}> : () -> index
      %11 = "test.reflect_bounds"(%10) <{smax = 16 : index, smin = 1 : index, umax = 16 : index, umin = 1 : index}> : (index) -> index
      "gpu.return"() : () -> ()
    }) {sym_name = "test_cluster_unknown"} : () -> ()
  }) : () -> ()
}) : () -> ()

