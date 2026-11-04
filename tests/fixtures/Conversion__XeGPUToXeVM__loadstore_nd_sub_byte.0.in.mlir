"builtin.module"() ({
  "gpu.module"() <{sym_name = "load_store_check"}> ({
    "gpu.func"() <{function_type = (memref<16x128xi4, 1>, memref<16x128xi4, 1>) -> ()}> ({
    ^bb0(%arg2: memref<16x128xi4, 1>, %arg3: memref<16x128xi4, 1>):
      %6 = "memref.memory_space_cast"(%arg2) : (memref<16x128xi4, 1>) -> memref<16x128xi4>
      %7 = "memref.memory_space_cast"(%arg3) : (memref<16x128xi4, 1>) -> memref<16x128xi4>
      %8 = "xegpu.create_nd_tdesc"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (memref<16x128xi4>) -> !xegpu.tensor_desc<8x64xi4>
      %9 = "xegpu.load_nd"(%8) <{const_offsets = array<i64: 8, 64>, l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>}> : (!xegpu.tensor_desc<8x64xi4>) -> vector<32xi4>
      %10 = "xegpu.create_nd_tdesc"(%7) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (memref<16x128xi4>) -> !xegpu.tensor_desc<8x64xi4>
      "xegpu.store_nd"(%9, %10) <{const_offsets = array<i64: 8, 64>, l1_hint = #xegpu.cache_hint<write_back>, l2_hint = #xegpu.cache_hint<uncached>}> : (vector<32xi4>, !xegpu.tensor_desc<8x64xi4>) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "load_store_matrix_a", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<64x128xi4, 1>, memref<64x128xi4, 1>) -> ()}> ({
    ^bb0(%arg0: memref<64x128xi4, 1>, %arg1: memref<64x128xi4, 1>):
      %0 = "memref.memory_space_cast"(%arg0) : (memref<64x128xi4, 1>) -> memref<64x128xi4>
      %1 = "memref.memory_space_cast"(%arg1) : (memref<64x128xi4, 1>) -> memref<64x128xi4>
      %2 = "xegpu.create_nd_tdesc"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>}> : (memref<64x128xi4>) -> !xegpu.tensor_desc<32x32xi4>
      %3 = "xegpu.load_nd"(%2) <{const_offsets = array<i64: 32, 32>, l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>, packed}> : (!xegpu.tensor_desc<32x32xi4>) -> vector<64xi4>
      %4 = "arith.constant"() <{value = 32 : index}> : () -> index
      %5 = "arith.constant"() <{value = 0 : index}> : () -> index
      "vector.store"(%3, %1, %4, %5) : (vector<64xi4>, memref<64x128xi4>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "load_matrix_b_request_pack", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

