"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "gpu.func"() <{function_type = (i64, vector<1xindex>, memref<1xf16>, vector<1xi1>) -> ()}> ({
    ^bb0(%arg0: i64, %arg1: vector<1xindex>, %arg2: memref<1xf16>, %arg3: vector<1xi1>):
      %0 = "xegpu.load"(%arg0, %arg1, %arg3) <{l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>}> : (i64, vector<1xindex>, vector<1xi1>) -> vector<1xf16>
      %1 = "arith.constant"() <{value = 0 : index}> : () -> index
      "vector.store"(%0, %arg2, %1) : (vector<1xf16>, memref<1xf16>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "load_gather_i64_src_value_offset", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "gpu.func"() <{function_type = (i64, vector<1xindex>, memref<1xf16>, vector<1xi1>) -> ()}> ({
    ^bb0(%arg0: i64, %arg1: vector<1xindex>, %arg2: memref<1xf16>, %arg3: vector<1xi1>):
      %0 = "xegpu.load"(%arg0, %arg1, %arg3) <{l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>}> : (i64, vector<1xindex>, vector<1xi1>) -> vector<1xf16>
      %1 = "arith.constant"() <{value = 0 : index}> : () -> index
      "vector.store"(%0, %arg2, %1) : (vector<1xf16>, memref<1xf16>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "source_materialize_single_elem_vec", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "gpu.func"() <{function_type = (i64, vector<1xindex>, vector<1xi1>) -> ()}> ({
    ^bb0(%arg0: i64, %arg1: vector<1xindex>, %arg2: vector<1xi1>):
      %0 = "arith.constant"() <{value = dense<2.900000e+00> : vector<1xf32>}> : () -> vector<1xf32>
      "xegpu.store"(%0, %arg0, %arg1, %arg2) <{l1_hint = #xegpu.cache_hint<write_back>, l2_hint = #xegpu.cache_hint<uncached>}> : (vector<1xf32>, i64, vector<1xindex>, vector<1xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_scatter_i64_src_value_offset", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "gpu.func"() <{function_type = (i64, vector<1xindex>) -> ()}> ({
    ^bb0(%arg0: i64, %arg1: vector<1xindex>):
      "xegpu.prefetch"(%arg0, %arg1) <{l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>, offset_align_byte = 4 : i64}> : (i64, vector<1xindex>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "prefetch_i64_src_value_offset", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "gpu.func"() <{function_type = (memref<256xf32>, vector<1xindex>) -> ()}> ({
    ^bb0(%arg0: memref<256xf32>, %arg1: vector<1xindex>):
      "xegpu.prefetch"(%arg0, %arg1) <{l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>}> : (memref<256xf32>, vector<1xindex>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "prefetch_memref_src_value_offset", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "gpu.func"() <{function_type = (memref<?xf16>, vector<1xindex>, vector<1xi1>, memref<1xf16>) -> ()}> ({
    ^bb0(%arg0: memref<?xf16>, %arg1: vector<1xindex>, %arg2: vector<1xi1>, %arg3: memref<1xf16>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "gpu.subgroup_id"() : () -> index
      %2 = "memref.subview"(%arg0, %1) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 16>, static_strides = array<i64: 1>}> : (memref<?xf16>, index) -> memref<16xf16, strided<[1], offset: ?>>
      %3 = "xegpu.load"(%2, %arg1, %arg2) <{l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>}> : (memref<16xf16, strided<[1], offset: ?>>, vector<1xindex>, vector<1xi1>) -> vector<1xf16>
      "vector.store"(%3, %arg3, %0) : (vector<1xf16>, memref<1xf16>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "load_gather_from_dyn_memref_subview", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

