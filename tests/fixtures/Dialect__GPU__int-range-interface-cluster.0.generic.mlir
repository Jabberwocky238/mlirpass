"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "gpu.func"() <{function_type = () -> (), known_cluster_size = array<i32: 8, 4, 1>}> ({
      %0 = "arith.constant"() <{value = 1 : index}> : () -> index
      %1 = "arith.constant"() <{value = 4 : index}> : () -> index
      %2 = "arith.constant"() <{value = 8 : index}> : () -> index
      %3 = "arith.constant"() <{value = 0 : index}> : () -> index
      %4 = "gpu.cluster_block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %5 = "test.reflect_bounds"(%4) <{smax = 7 : index, smin = 0 : index, umax = 7 : index, umin = 0 : index}> : (index) -> index
      %6 = "gpu.cluster_block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %7 = "test.reflect_bounds"(%6) <{smax = 3 : index, smin = 0 : index, umax = 3 : index, umin = 0 : index}> : (index) -> index
      %8 = "test.reflect_bounds"(%3) <{smax = 0 : index, smin = 0 : index, umax = 0 : index, umin = 0 : index}> : (index) -> index
      %9 = "test.reflect_bounds"(%2) <{smax = 8 : index, smin = 8 : index, umax = 8 : index, umin = 8 : index}> : (index) -> index
      %10 = "test.reflect_bounds"(%1) <{smax = 4 : index, smin = 4 : index, umax = 4 : index, umin = 4 : index}> : (index) -> index
      %11 = "test.reflect_bounds"(%0) <{smax = 1 : index, smin = 1 : index, umax = 1 : index, umin = 1 : index}> : (index) -> index
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "test_cluster_ranges", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

