"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (memref<128xf32>) -> (), kernel}> ({
    ^bb0(%arg0: memref<128xf32>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = true}> : () -> i1
      %2 = "xegpu.load"(%arg0, %0, %1) : (memref<128xf32>, index, i1) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "materialize_memref"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (ui64) -> (), kernel}> ({
    ^bb0(%arg0: ui64):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = true}> : () -> i1
      %2 = "xegpu.load"(%arg0, %0, %1) : (ui64, index, i1) -> vector<1xf32>
      "gpu.return"() : () -> ()
    }) {sym_name = "materialize_ui64"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (ui32) -> (), kernel}> ({
    ^bb0(%arg0: ui32):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = true}> : () -> i1
      %2 = "xegpu.load"(%arg0, %0, %1) : (ui32, index, i1) -> vector<1xf32>
      "gpu.return"() : () -> ()
    }) {sym_name = "materialize_ui32"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (memref<128xf32>) -> (), kernel}> ({
    ^bb0(%arg0: memref<128xf32>):
      %0 = "arith.constant"() <{value = dense<0> : vector<1xindex>}> : () -> vector<1xindex>
      %1 = "arith.constant"() <{value = dense<true> : vector<1xi1>}> : () -> vector<1xi1>
      %2 = "xegpu.load"(%arg0, %0, %1) : (memref<128xf32>, vector<1xindex>, vector<1xi1>) -> vector<1xf32>
      "gpu.return"() : () -> ()
    }) {sym_name = "materialize_single_index_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast", targets = [#xevm.target<chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<128xf32>) -> (), kernel}> ({
    ^bb0(%arg0: memref<128xf32>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xi8, 3>
      %2 = "xegpu.create_mem_desc"(%1) : (memref<512xi8, 3>) -> !xegpu.mem_desc<8x16xf32>
      %3 = "xegpu.load_matrix"(%2, %0, %0) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<8x16xf32>, index, index) -> vector<1x1xf32>
      %4 = "vector.shape_cast"(%3) : (vector<1x1xf32>) -> vector<1xf32>
      "vector.store"(%4, %arg0, %0) : (vector<1xf32>, memref<128xf32>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "materialize_element_to_2D_single_element_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast", targets = [#xevm.target<chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<512xi8, 3>) -> (), kernel}> ({
    ^bb0(%arg0: memref<512xi8, 3>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = dense<0.000000e+00> : vector<1x1xf32>}> : () -> vector<1x1xf32>
      %2 = "xegpu.create_mem_desc"(%arg0) : (memref<512xi8, 3>) -> !xegpu.mem_desc<8x16xf32>
      "xegpu.store_matrix"(%1, %2, %0, %0) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<1x1xf32>, !xegpu.mem_desc<8x16xf32>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "materialize_2D_single_element_vector_to_element"} : () -> ()
  }) : () -> ()
}) : () -> ()

