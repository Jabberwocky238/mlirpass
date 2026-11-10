"builtin.module"() ({
  "gpu.module"() <{sym_name = "test_module"}> ({
    "func.func"() <{function_type = () -> (), sym_name = "barrier_default"}> ({
      "gpu.barrier"() <{scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "barrier_no_fence"}> ({
      "gpu.barrier"() <{address_spaces = [], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "barrier_workgroup_only"}> ({
      "gpu.barrier"() <{address_spaces = [#gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "barrier_global_only"}> ({
      "gpu.barrier"() <{address_spaces = [#gpu.address_space<global>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "barrier_both"}> ({
      "gpu.barrier"() <{address_spaces = [#gpu.address_space<global>, #gpu.address_space<workgroup>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "barrier_private_only"}> ({
      "gpu.barrier"() <{address_spaces = [#gpu.address_space<private>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "barrier_constant_only"}> ({
      "gpu.barrier"() <{address_spaces = [#gpu.address_space<constant>], scope = #gpu.barrier_scope<workgroup>}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "barrier_subgroup_scope"}> ({
      "gpu.barrier"() <{scope = #gpu.barrier_scope<subgroup>}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
    "func.func"() <{function_type = () -> (), sym_name = "barrier_subgroup_scope_no_fence"}> ({
      "gpu.barrier"() <{address_spaces = [], scope = #gpu.barrier_scope<subgroup>}> : () -> ()
      "func.return"() : () -> ()
    }) : () -> ()
  }) : () -> ()
}) : () -> ()
