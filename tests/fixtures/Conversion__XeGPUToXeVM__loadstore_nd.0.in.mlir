"builtin.module"() ({
  "gpu.module"() <{sym_name = "load_store_check"}> ({
    "gpu.func"() <{function_type = (memref<8x16xf32, 1>, memref<8x16xf32, 1>) -> ()}> ({
    ^bb0(%arg0: memref<8x16xf32, 1>, %arg1: memref<8x16xf32, 1>):
      %0 = "memref.memory_space_cast"(%arg0) : (memref<8x16xf32, 1>) -> memref<8x16xf32>
      %1 = "memref.memory_space_cast"(%arg1) : (memref<8x16xf32, 1>) -> memref<8x16xf32>
      %2 = "xegpu.create_nd_tdesc"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (memref<8x16xf32>) -> !xegpu.tensor_desc<8x16xf32>
      %3 = "xegpu.load_nd"(%2) <{const_offsets = array<i64: 0, 0>, l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>}> : (!xegpu.tensor_desc<8x16xf32>) -> vector<8xf32>
      %4 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %5 = "arith.index_cast"(%4) : (index) -> i32
      %6 = "arith.sitofp"(%5) : (i32) -> f32
      %7 = "vector.insert"(%6, %3) <{static_position = array<i64: 0>}> : (f32, vector<8xf32>) -> vector<8xf32>
      %8 = "xegpu.create_nd_tdesc"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (memref<8x16xf32>) -> !xegpu.tensor_desc<8x16xf32>
      "xegpu.store_nd"(%7, %8) <{const_offsets = array<i64: 0, 0>, l1_hint = #xegpu.cache_hint<write_back>, l2_hint = #xegpu.cache_hint<uncached>}> : (vector<8xf32>, !xegpu.tensor_desc<8x16xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "load_store", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

