"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = () -> index, sym_name = "subgroup_id"}> ({
      %2 = "gpu.subgroup_id"() : () -> index
      "func.return"(%2) : (index) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> index, sym_name = "subgroup_id_with_upper_bound"}> ({
      %1 = "gpu.subgroup_id"() <{upper_bound = 4 : index}> : () -> index
      "func.return"(%1) : (index) -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> index, sym_name = "subgroup_id_with_workgroup_sizes"}> ({
      %0 = "gpu.subgroup_id"() <{upper_bound = 4 : index}> : () -> index
      "func.return"(%0) : (index) -> ()
    }) {gpu.known_block_size = array<i32: 64, 4, 1>} : () -> ()
  }) : () -> ()
}) : () -> ()

