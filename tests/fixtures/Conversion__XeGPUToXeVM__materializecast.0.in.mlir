"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (memref<128xf32>) -> ()}> ({
    ^bb0(%arg0: memref<128xf32>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = true}> : () -> i1
      %2 = "xegpu.load"(%arg0, %0, %1) : (memref<128xf32>, index, i1) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "materialize_memref", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (ui64) -> ()}> ({
    ^bb0(%arg0: ui64):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = true}> : () -> i1
      %2 = "xegpu.load"(%arg0, %0, %1) : (ui64, index, i1) -> vector<1xf32>
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "materialize_ui64", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (ui32) -> ()}> ({
    ^bb0(%arg0: ui32):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = true}> : () -> i1
      %2 = "xegpu.load"(%arg0, %0, %1) : (ui32, index, i1) -> vector<1xf32>
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "materialize_ui32", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (memref<128xf32>) -> ()}> ({
    ^bb0(%arg0: memref<128xf32>):
      %0 = "arith.constant"() <{value = dense<0> : vector<1xindex>}> : () -> vector<1xindex>
      %1 = "arith.constant"() <{value = dense<true> : vector<1xi1>}> : () -> vector<1xi1>
      %2 = "xegpu.load"(%arg0, %0, %1) : (memref<128xf32>, vector<1xindex>, vector<1xi1>) -> vector<1xf32>
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "materialize_single_index_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

