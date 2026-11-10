"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<8x16x32xf32>, index, index, index, vector<8xindex>, vector<8xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8xindex>, %arg6: vector<8xi1>):
      "vector.scatter"(%arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg0) : (memref<8x16x32xf32>, index, index, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_1D_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<8x32xf32>, index, index, vector<8xindex>, vector<8xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<8x32xf32>, %arg2: index, %arg3: index, %arg4: vector<8xindex>, %arg5: vector<8xi1>):
      "vector.scatter"(%arg1, %arg2, %arg3, %arg4, %arg5, %arg0) : (memref<8x32xf32>, index, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_2D_memref"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<8x16x32xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<8x16x32xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8x16xindex>, %arg6: vector<8x16xi1>):
      "vector.scatter"(%arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg0) : (memref<8x16x32xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_2D_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<?x?x?xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8x16xindex>, %arg6: vector<8x16xi1>):
      "vector.scatter"(%arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg0) : (memref<?x?x?xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_dynamic_source"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<?x8x16xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<?x8x16xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8x16xindex>, %arg6: vector<8x16xi1>):
      "vector.scatter"(%arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg0) : (memref<?x8x16xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_dynamic_source2"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<32xf32, strided<[?], offset: ?>>, index, vector<8xindex>, vector<8xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<32xf32, strided<[?], offset: ?>>, %arg2: index, %arg3: vector<8xindex>, %arg4: vector<8xi1>):
      "vector.scatter"(%arg1, %arg2, %arg3, %arg4, %arg0) : (memref<32xf32, strided<[?], offset: ?>>, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "non_unit_inner_stride_1D"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>, index, index, index, vector<8xindex>, vector<8xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8xindex>, %arg6: vector<8xi1>):
      "vector.scatter"(%arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg0) : (memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>, index, index, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "non_unit_inner_stride_3D"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf16>, memref<4096x4096xf16>, index, index, index, vector<8xindex>, vector<8xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8xf16>, %arg1: memref<4096x4096xf16>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8xindex>, %arg6: vector<8xi1>):
      %0 = "memref.subview"(%arg1, %arg2, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      "vector.scatter"(%0, %arg3, %arg4, %arg5, %arg6, %arg0) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>, index, index, vector<8xindex>, vector<8xi1>, vector<8xf16>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "scatter_into_subview"} : () -> ()
  }) : () -> ()
}) : () -> ()

