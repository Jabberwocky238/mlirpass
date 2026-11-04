"builtin.module"() ({
  "gpu.module"() <{sym_name = "prefetch_nd_check"}> ({
    "gpu.func"() <{function_type = (memref<8x16xf32, 1>, memref<8x16xf32, 1>) -> ()}> ({
    ^bb0(%arg0: memref<8x16xf32, 1>, %arg1: memref<8x16xf32, 1>):
      %0 = "memref.memory_space_cast"(%arg0) : (memref<8x16xf32, 1>) -> memref<8x16xf32>
      %1 = "xegpu.create_nd_tdesc"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (memref<8x16xf32>) -> !xegpu.tensor_desc<8x16xf32, #xegpu.layout<lane_layout = [1, 16], lane_data = [1, 1]>>
      "xegpu.prefetch_nd"(%1) <{const_offsets = array<i64: 0, 0>, l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>}> : (!xegpu.tensor_desc<8x16xf32, #xegpu.layout<lane_layout = [1, 16], lane_data = [1, 1]>>) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "prefetch_nd", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

