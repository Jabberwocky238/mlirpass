"builtin.module"() ({
  "gpu.module"() <{sym_name = "load_store_check"}> ({
    "gpu.func"() <{function_type = (memref<8x16xf32, 1>, memref<8x16xf32, 1>) -> (), kernel}> ({
    ^bb0(%arg4: memref<8x16xf32, 1>, %arg5: memref<8x16xf32, 1>):
      %14 = "memref.memory_space_cast"(%arg4) : (memref<8x16xf32, 1>) -> memref<8x16xf32>
      %15 = "memref.memory_space_cast"(%arg5) : (memref<8x16xf32, 1>) -> memref<8x16xf32>
      %16 = "xegpu.create_nd_tdesc"(%14) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<8x16xf32>) -> !xegpu.tensor_desc<8x16xf32>
      %17 = "xegpu.load_nd"(%16) <{const_offsets = array<i64: 0, 0>, l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>}> : (!xegpu.tensor_desc<8x16xf32>) -> vector<8xf32>
      %18 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %19 = "arith.index_cast"(%18) : (index) -> i32
      %20 = "arith.sitofp"(%19) : (i32) -> f32
      %21 = "vector.insert"(%20, %17) <{static_position = array<i64: 0>}> : (f32, vector<8xf32>) -> vector<8xf32>
      %22 = "xegpu.create_nd_tdesc"(%15) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<8x16xf32>) -> !xegpu.tensor_desc<8x16xf32>
      "xegpu.store_nd"(%21, %22) <{const_offsets = array<i64: 0, 0>, l1_hint = #xegpu.cache_hint<write_back>, l2_hint = #xegpu.cache_hint<uncached>}> : (vector<8xf32>, !xegpu.tensor_desc<8x16xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "load_store"} : () -> ()
    "gpu.func"() <{function_type = (memref<8x16xf32, 1>, memref<8x16xf32, 1>) -> (), kernel}> ({
    ^bb0(%arg2: memref<8x16xf32, 1>, %arg3: memref<8x16xf32, 1>):
      %5 = "memref.memory_space_cast"(%arg2) : (memref<8x16xf32, 1>) -> memref<8x16xf32>
      %6 = "memref.memory_space_cast"(%arg3) : (memref<8x16xf32, 1>) -> memref<8x16xf32>
      %7 = "xegpu.create_nd_tdesc"(%5) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<8x16xf32>) -> !xegpu.tensor_desc<8x16xf32>
      %8 = "xegpu.load_nd"(%7) <{const_offsets = array<i64: 0, 0>, l1_hint = #xegpu.cache_hint<cached>}> : (!xegpu.tensor_desc<8x16xf32>) -> vector<8xf32>
      %9 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "arith.index_cast"(%9) : (index) -> i32
      %11 = "arith.sitofp"(%10) : (i32) -> f32
      %12 = "vector.insert"(%11, %8) <{static_position = array<i64: 0>}> : (f32, vector<8xf32>) -> vector<8xf32>
      %13 = "xegpu.create_nd_tdesc"(%6) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<8x16xf32>) -> !xegpu.tensor_desc<8x16xf32>
      "xegpu.store_nd"(%12, %13) <{const_offsets = array<i64: 0, 0>}> : (vector<8xf32>, !xegpu.tensor_desc<8x16xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "load_store_with_partial_cache_hints"} : () -> ()
    "gpu.func"() <{function_type = (memref<32x16xi8, 1>, memref<32x16xi8, 1>) -> (), kernel}> ({
    ^bb0(%arg0: memref<32x16xi8, 1>, %arg1: memref<32x16xi8, 1>):
      %0 = "memref.memory_space_cast"(%arg0) : (memref<32x16xi8, 1>) -> memref<32x16xi8>
      %1 = "memref.memory_space_cast"(%arg1) : (memref<32x16xi8, 1>) -> memref<32x16xi8>
      %2 = "xegpu.create_nd_tdesc"(%0) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<32x16xi8>) -> !xegpu.tensor_desc<32x16xi8>
      %3 = "xegpu.load_nd"(%2) <{const_offsets = array<i64: 0, 0>, l1_hint = #xegpu.cache_hint<cached>, l2_hint = #xegpu.cache_hint<uncached>}> : (!xegpu.tensor_desc<32x16xi8>) -> vector<32xi8>
      %4 = "arith.constant"() <{value = 0 : index}> : () -> index
      "vector.store"(%3, %1, %4, %4) : (vector<32xi8>, memref<32x16xi8>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "load_nd_8bit"} : () -> ()
  }) : () -> ()
}) : () -> ()

