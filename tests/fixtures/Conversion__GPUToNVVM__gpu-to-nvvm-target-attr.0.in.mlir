"builtin.module"() ({
  "gpu.module"() <{sym_name = "nvvm_module", targets = [#nvvm.target]}> ({
    "func.func"() <{function_type = () -> index, sym_name = "kernel_0"}> ({
      %3 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %4 = "gpu.lane_id"() : () -> index
      %5 = "index.add"(%3, %4) : (index, index) -> index
      "func.return"(%5) : (index) -> ()
    }) : () -> ()
    "gpu.func"() <{function_type = (memref<f32, #gpu.address_space<global>>) -> (), kernel, known_block_size = array<i32: 128, 1, 1>}> ({
    ^bb0(%arg1: memref<f32, #gpu.address_space<global>>):
      "gpu.return"() : () -> ()
    }) {sym_name = "kernel_1"} : () -> ()
  }) : () -> ()
  "gpu.module"() <{sym_name = "nvvm_module_2"}> ({
    "func.func"() <{function_type = () -> index, sym_name = "kernel_0"}> ({
      %0 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "gpu.lane_id"() : () -> index
      %2 = "index.add"(%0, %1) : (index, index) -> index
      "func.return"(%2) : (index) -> ()
    }) : () -> ()
    "gpu.func"() <{function_type = (memref<f32, #gpu.address_space<global>>) -> (), kernel, known_block_size = array<i32: 128, 1, 1>}> ({
    ^bb0(%arg0: memref<f32, #gpu.address_space<global>>):
      "gpu.return"() : () -> ()
    }) {sym_name = "kernel_1"} : () -> ()
  }) : () -> ()
}) : () -> ()

