"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<8x16x32xf32>, index, index, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8xindex>, %arg5: vector<8xi1>, %arg6: vector<8xf32>):
      %0 = "vector.gather"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6) : (memref<8x16x32xf32>, index, index, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> vector<8xf32>
      "gpu.return"(%0) : (vector<8xf32>) -> ()
    }) {sym_name = "load_1D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<8x32xf32>, index, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<8x32xf32>, %arg1: index, %arg2: index, %arg3: vector<8xindex>, %arg4: vector<8xi1>, %arg5: vector<8xf32>):
      %0 = "vector.gather"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5) : (memref<8x32xf32>, index, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> vector<8xf32>
      "gpu.return"(%0) : (vector<8xf32>) -> ()
    }) {sym_name = "load_2D_memref", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<8x16x32xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8x16xindex>, %arg5: vector<8x16xi1>, %arg6: vector<8x16xf32>):
      %0 = "vector.gather"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6) : (memref<8x16x32xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> vector<8x16xf32>
      "gpu.return"(%0) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_2D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<?x?x?xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8x16xindex>, %arg5: vector<8x16xi1>, %arg6: vector<8x16xf32>):
      %0 = "vector.gather"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6) : (memref<?x?x?xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> vector<8x16xf32>
      "gpu.return"(%0) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_dynamic_source", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<?x8x16xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<?x8x16xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8x16xindex>, %arg5: vector<8x16xi1>, %arg6: vector<8x16xf32>):
      %0 = "vector.gather"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6) : (memref<?x8x16xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> vector<8x16xf32>
      "gpu.return"(%0) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_dynamic_source2", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (tensor<32x64xf32>, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: tensor<32x64xf32>, %arg1: index, %arg2: vector<8x16xindex>, %arg3: vector<8x16xi1>, %arg4: vector<8x16xf32>):
      %0 = "vector.gather"(%arg0, %arg1, %arg1, %arg2, %arg3, %arg4) : (tensor<32x64xf32>, index, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> vector<8x16xf32>
      "gpu.return"(%0) : (vector<8x16xf32>) -> ()
    }) {sym_name = "no_load_tensor", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<4096x4096xf16>, index, index, index, vector<8xindex>, vector<8xi1>, vector<8xf16>) -> vector<8xf16>}> ({
    ^bb0(%arg0: memref<4096x4096xf16>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8xindex>, %arg5: vector<8xi1>, %arg6: vector<8xf16>):
      %0 = "memref.subview"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %1 = "vector.gather"(%0, %arg2, %arg3, %arg4, %arg5, %arg6) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>, index, index, vector<8xindex>, vector<8xi1>, vector<8xf16>) -> vector<8xf16>
      "gpu.return"(%1) : (vector<8xf16>) -> ()
    }) {sym_name = "gather_from_subview", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<32xf32, strided<[?], offset: ?>>, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<32xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: vector<8xindex>, %arg3: vector<8xi1>, %arg4: vector<8xf32>):
      %0 = "vector.gather"(%arg0, %arg1, %arg2, %arg3, %arg4) : (memref<32xf32, strided<[?], offset: ?>>, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> vector<8xf32>
      "gpu.return"(%0) : (vector<8xf32>) -> ()
    }) {sym_name = "non_unit_inner_stride_1D", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>, index, index, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8xindex>, %arg5: vector<8xi1>, %arg6: vector<8xf32>):
      %0 = "vector.gather"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6) : (memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>, index, index, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> vector<8xf32>
      "gpu.return"(%0) : (vector<8xf32>) -> ()
    }) {sym_name = "non_unit_inner_stride_3D", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

