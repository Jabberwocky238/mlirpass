"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<8x16x32xf32>, index, index, index, vector<8xindex>, vector<8xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8xindex>, %arg6: vector<8xi1>):
      %0 = "arith.constant"() <{value = 512 : index}> : () -> index
      %1 = "arith.constant"() <{value = 32 : index}> : () -> index
      %2 = "arith.muli"(%arg2, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "arith.muli"(%arg3, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%4, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "vector.broadcast"(%5) : (index) -> vector<8xindex>
      %7 = "arith.addi"(%6, %arg5) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %8 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<8x16x32xf32>) -> index
      %9 = "arith.index_cast"(%8) : (index) -> i64
      "xegpu.store"(%arg0, %9, %7, %arg6) : (vector<8xf32>, i64, vector<8xindex>, vector<8xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_1D_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<8x32xf32>, index, index, vector<8xindex>, vector<8xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<8x32xf32>, %arg2: index, %arg3: index, %arg4: vector<8xindex>, %arg5: vector<8xi1>):
      %0 = "arith.constant"() <{value = 32 : index}> : () -> index
      %1 = "arith.muli"(%arg2, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %2 = "arith.addi"(%1, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "vector.broadcast"(%2) : (index) -> vector<8xindex>
      %4 = "arith.addi"(%3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %5 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<8x32xf32>) -> index
      %6 = "arith.index_cast"(%5) : (index) -> i64
      "xegpu.store"(%arg0, %6, %4, %arg5) : (vector<8xf32>, i64, vector<8xindex>, vector<8xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_2D_memref"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<8x16x32xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<8x16x32xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8x16xindex>, %arg6: vector<8x16xi1>):
      %0 = "arith.constant"() <{value = 512 : index}> : () -> index
      %1 = "arith.constant"() <{value = 32 : index}> : () -> index
      %2 = "arith.muli"(%arg2, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "arith.muli"(%arg3, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%4, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "vector.broadcast"(%5) : (index) -> vector<8x16xindex>
      %7 = "arith.addi"(%6, %arg5) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %8 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<8x16x32xf32>) -> index
      %9 = "arith.index_cast"(%8) : (index) -> i64
      "xegpu.store"(%arg0, %9, %7, %arg6) : (vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_2D_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<?x?x?xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8x16xindex>, %arg6: vector<8x16xi1>):
      %0:8 = "memref.extract_strided_metadata"(%arg1) : (memref<?x?x?xf32>) -> (memref<f32>, index, index, index, index, index, index, index)
      %1 = "arith.muli"(%arg2, %0#5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %2 = "arith.muli"(%arg3, %0#6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "arith.addi"(%1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "arith.addi"(%3, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "vector.broadcast"(%4) : (index) -> vector<8x16xindex>
      %6 = "arith.addi"(%5, %arg5) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %7 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<?x?x?xf32>) -> index
      %8 = "arith.index_cast"(%7) : (index) -> i64
      "xegpu.store"(%arg0, %8, %6, %arg6) : (vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_dynamic_source"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<?x8x16xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<?x8x16xf32>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8x16xindex>, %arg6: vector<8x16xi1>):
      %0 = "arith.constant"() <{value = 128 : index}> : () -> index
      %1 = "arith.constant"() <{value = 16 : index}> : () -> index
      %2 = "arith.muli"(%arg2, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "arith.muli"(%arg3, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%4, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "vector.broadcast"(%5) : (index) -> vector<8x16xindex>
      %7 = "arith.addi"(%6, %arg5) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %8 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<?x8x16xf32>) -> index
      %9 = "arith.index_cast"(%8) : (index) -> i64
      "xegpu.store"(%arg0, %9, %7, %arg6) : (vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_dynamic_source2"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<32xf32, strided<[?], offset: ?>>, index, vector<8xindex>, vector<8xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<32xf32, strided<[?], offset: ?>>, %arg2: index, %arg3: vector<8xindex>, %arg4: vector<8xi1>):
      %0:4 = "memref.extract_strided_metadata"(%arg1) : (memref<32xf32, strided<[?], offset: ?>>) -> (memref<f32>, index, index, index)
      %1 = "arith.muli"(%arg2, %0#3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %2 = "arith.addi"(%0#1, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "vector.broadcast"(%0#3) : (index) -> vector<8xindex>
      %4 = "arith.muli"(%3, %arg3) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %5 = "vector.broadcast"(%2) : (index) -> vector<8xindex>
      %6 = "arith.addi"(%5, %4) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %7 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<32xf32, strided<[?], offset: ?>>) -> index
      %8 = "arith.index_cast"(%7) : (index) -> i64
      "xegpu.store"(%arg0, %8, %6, %arg4) : (vector<8xf32>, i64, vector<8xindex>, vector<8xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "non_unit_inner_stride_1D"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>, index, index, index, vector<8xindex>, vector<8xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8xindex>, %arg6: vector<8xi1>):
      %0 = "arith.constant"() <{value = dense<2> : vector<8xindex>}> : () -> vector<8xindex>
      %1 = "arith.constant"() <{value = 128 : index}> : () -> index
      %2 = "arith.constant"() <{value = 2 : index}> : () -> index
      %3:8 = "memref.extract_strided_metadata"(%arg1) : (memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>) -> (memref<f32>, index, index, index, index, index, index, index)
      %4 = "arith.muli"(%arg2, %3#5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%3#1, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.muli"(%arg3, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.addi"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "arith.muli"(%arg4, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %9 = "arith.addi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %10 = "arith.muli"(%arg5, %0) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %11 = "vector.broadcast"(%9) : (index) -> vector<8xindex>
      %12 = "arith.addi"(%11, %10) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %13 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>) -> index
      %14 = "arith.index_cast"(%13) : (index) -> i64
      "xegpu.store"(%arg0, %14, %12, %arg6) : (vector<8xf32>, i64, vector<8xindex>, vector<8xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "non_unit_inner_stride_3D"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf16>, memref<4096x4096xf16>, index, index, index, vector<8xindex>, vector<8xi1>) -> ()}> ({
    ^bb0(%arg0: vector<8xf16>, %arg1: memref<4096x4096xf16>, %arg2: index, %arg3: index, %arg4: index, %arg5: vector<8xindex>, %arg6: vector<8xi1>):
      %0 = "arith.constant"() <{value = 4096 : index}> : () -> index
      %1 = "memref.subview"(%arg1, %arg2, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %2:6 = "memref.extract_strided_metadata"(%1) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> (memref<f16>, index, index, index, index, index)
      %3 = "arith.muli"(%arg3, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "arith.addi"(%2#1, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%4, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "vector.broadcast"(%5) : (index) -> vector<8xindex>
      %7 = "arith.addi"(%6, %arg5) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %8 = "memref.extract_aligned_pointer_as_index"(%1) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> index
      %9 = "arith.index_cast"(%8) : (index) -> i64
      "xegpu.store"(%arg0, %9, %7, %arg6) : (vector<8xf16>, i64, vector<8xindex>, vector<8xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "scatter_into_subview"} : () -> ()
  }) : () -> ()
}) : () -> ()

