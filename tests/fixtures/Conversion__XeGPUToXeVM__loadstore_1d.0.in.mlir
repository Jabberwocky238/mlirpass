"builtin.module"() ({
  "gpu.module"() <{sym_name = "load_store_check"}> ({
    "gpu.func"() <{function_type = (memref<512xf32, 1>, memref<256xf32, 1>) -> ()}> ({
    ^bb0(%arg0: memref<512xf32, 1>, %arg1: memref<256xf32, 1>):
      %0 = "memref.memory_space_cast"(%arg0) : (memref<512xf32, 1>) -> memref<512xf32>
      %1 = "memref.memory_space_cast"(%arg1) : (memref<256xf32, 1>) -> memref<256xf32>
      %2 = "xegpu.create_nd_tdesc"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (memref<512xf32>) -> !xegpu.tensor_desc<32xf32>
      %3 = "xegpu.load_nd"(%2) <{const_offsets = array<i64: 96>, l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>}> : (!xegpu.tensor_desc<32xf32>) -> vector<2xf32>
      %4 = "xegpu.create_nd_tdesc"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (memref<256xf32>) -> !xegpu.tensor_desc<32xf32>
      "xegpu.store_nd"(%3, %4) <{const_offsets = array<i64: 128>, l1_hint = #xegpu.cache_hint<write_back>, l2_hint = #xegpu.cache_hint<uncached>}> : (vector<2xf32>, !xegpu.tensor_desc<32xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "load_store", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

