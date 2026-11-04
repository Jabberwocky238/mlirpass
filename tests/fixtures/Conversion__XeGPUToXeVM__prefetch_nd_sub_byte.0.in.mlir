"builtin.module"() ({
  "gpu.module"() <{sym_name = "prefetch_check"}> ({
    "gpu.func"() <{function_type = (memref<16x128xi4, 1>) -> ()}> ({
    ^bb0(%arg0: memref<16x128xi4, 1>):
      %0 = "memref.memory_space_cast"(%arg0) : (memref<16x128xi4, 1>) -> memref<16x128xi4>
      %1 = "xegpu.create_nd_tdesc"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (memref<16x128xi4>) -> !xegpu.tensor_desc<8x64xi4>
      "xegpu.prefetch_nd"(%1) <{const_offsets = array<i64: 8, 64>, l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>}> : (!xegpu.tensor_desc<8x64xi4>) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "prefetch_matrix_a", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

