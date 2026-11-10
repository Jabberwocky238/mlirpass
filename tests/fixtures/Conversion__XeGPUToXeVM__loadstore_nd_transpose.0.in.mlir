"builtin.module"() ({
  "gpu.module"() <{sym_name = "load_check"}> ({
    "gpu.func"() <{function_type = (memref<16x16xf16, 1>, memref<16x16xf16, 1>) -> (), kernel}> ({
    ^bb0(%arg0: memref<16x16xf16, 1>, %arg1: memref<16x16xf16, 1>):
      %0 = "memref.memory_space_cast"(%arg0) : (memref<16x16xf16, 1>) -> memref<16x16xf16>
      %1 = "memref.memory_space_cast"(%arg1) : (memref<16x16xf16, 1>) -> memref<16x16xf16>
      %2 = "xegpu.create_nd_tdesc"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<16x16xf16>) -> !xegpu.tensor_desc<16x16xf16>
      %3 = "xegpu.load_nd"(%2) <{const_offsets = array<i64: 0, 16>, l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>, transpose = array<i64: 1, 0>}> : (!xegpu.tensor_desc<16x16xf16>) -> vector<16xf16>
      %4 = "arith.constant"() <{value = 0 : index}> : () -> index
      "vector.store"(%3, %1, %4, %4) : (vector<16xf16>, memref<16x16xf16>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "load_nd_transpose_f16"} : () -> ()
  }) : () -> ()
}) : () -> ()

