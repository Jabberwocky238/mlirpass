"builtin.module"() ({
  "gpu.module"() <{sym_name = "fence_check"}> ({
    "gpu.func"() <{function_type = (memref<8x16xf32, 1>) -> ()}> ({
    ^bb0(%arg0: memref<8x16xf32, 1>):
      %0 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %1 = "arith.index_cast"(%0) : (index) -> i32
      %2 = "arith.sitofp"(%1) : (i32) -> f32
      "xegpu.fence"() <{fence_scope = #xegpu<fence_scope workgroup>, memory_kind = #xegpu<memory_space global>}> : () -> ()
      %3 = "arith.constant"() <{value = 0 : index}> : () -> index
      "memref.store"(%2, %arg0, %3, %3) : (f32, memref<8x16xf32, 1>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "fence", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

