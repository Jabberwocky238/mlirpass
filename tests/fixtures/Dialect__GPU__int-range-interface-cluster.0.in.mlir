"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "gpu.func"() <{function_type = () -> (), kernel, known_cluster_size = array<i32: 8, 4, 1>}> ({
      %12 = "gpu.cluster_block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %13 = "test.reflect_bounds"(%12) : (index) -> index
      %14 = "gpu.cluster_block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %15 = "test.reflect_bounds"(%14) : (index) -> index
      %16 = "gpu.cluster_block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %17 = "test.reflect_bounds"(%16) : (index) -> index
      %18 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim x>}> : () -> index
      %19 = "test.reflect_bounds"(%18) : (index) -> index
      %20 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim y>}> : () -> index
      %21 = "test.reflect_bounds"(%20) : (index) -> index
      %22 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim z>}> : () -> index
      %23 = "test.reflect_bounds"(%22) : (index) -> index
      "gpu.return"() : () -> ()
    }) {sym_name = "test_cluster_ranges"} : () -> ()
    "gpu.func"() <{function_type = () -> (), kernel}> ({
      %0 = "gpu.cluster_block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "test.reflect_bounds"(%0) : (index) -> index
      %2 = "gpu.cluster_block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %3 = "test.reflect_bounds"(%2) : (index) -> index
      %4 = "gpu.cluster_block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %5 = "test.reflect_bounds"(%4) : (index) -> index
      %6 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim x>}> : () -> index
      %7 = "test.reflect_bounds"(%6) : (index) -> index
      %8 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim y>}> : () -> index
      %9 = "test.reflect_bounds"(%8) : (index) -> index
      %10 = "gpu.cluster_dim_blocks"() <{dimension = #gpu<dim z>}> : () -> index
      %11 = "test.reflect_bounds"(%10) : (index) -> index
      "gpu.return"() : () -> ()
    }) {sym_name = "test_cluster_unknown"} : () -> ()
  }) : () -> ()
}) : () -> ()

