"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<8x16x32xf32>, index, index, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8xindex>, %arg5: vector<8xi1>, %arg6: vector<8xf32>):
      %0 = "arith.constant"() <{value = 512 : index}> : () -> index
      %1 = "arith.constant"() <{value = 32 : index}> : () -> index
      %2 = "arith.muli"(%arg1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "arith.muli"(%arg2, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%4, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "vector.broadcast"(%5) : (index) -> vector<8xindex>
      %7 = "arith.addi"(%6, %arg4) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %8 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<8x16x32xf32>) -> index
      %9 = "arith.index_cast"(%8) : (index) -> i64
      %10 = "xegpu.load"(%9, %7, %arg5) : (i64, vector<8xindex>, vector<8xi1>) -> vector<8xf32>
      %11 = "arith.select"(%arg5, %10, %arg6) : (vector<8xi1>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
      "gpu.return"(%11) : (vector<8xf32>) -> ()
    }) {sym_name = "load_1D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<8x32xf32>, index, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<8x32xf32>, %arg1: index, %arg2: index, %arg3: vector<8xindex>, %arg4: vector<8xi1>, %arg5: vector<8xf32>):
      %0 = "arith.constant"() <{value = 32 : index}> : () -> index
      %1 = "arith.muli"(%arg1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %2 = "arith.addi"(%1, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "vector.broadcast"(%2) : (index) -> vector<8xindex>
      %4 = "arith.addi"(%3, %arg3) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %5 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<8x32xf32>) -> index
      %6 = "arith.index_cast"(%5) : (index) -> i64
      %7 = "xegpu.load"(%6, %4, %arg4) : (i64, vector<8xindex>, vector<8xi1>) -> vector<8xf32>
      %8 = "arith.select"(%arg4, %7, %arg5) : (vector<8xi1>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
      "gpu.return"(%8) : (vector<8xf32>) -> ()
    }) {sym_name = "load_2D_memref", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<8x16x32xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8x16xindex>, %arg5: vector<8x16xi1>, %arg6: vector<8x16xf32>):
      %0 = "arith.constant"() <{value = 512 : index}> : () -> index
      %1 = "arith.constant"() <{value = 32 : index}> : () -> index
      %2 = "arith.muli"(%arg1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "arith.muli"(%arg2, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%4, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "vector.broadcast"(%5) : (index) -> vector<8x16xindex>
      %7 = "arith.addi"(%6, %arg4) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %8 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<8x16x32xf32>) -> index
      %9 = "arith.index_cast"(%8) : (index) -> i64
      %10 = "xegpu.load"(%9, %7, %arg5) : (i64, vector<8x16xindex>, vector<8x16xi1>) -> vector<8x16xf32>
      %11 = "arith.select"(%arg5, %10, %arg6) : (vector<8x16xi1>, vector<8x16xf32>, vector<8x16xf32>) -> vector<8x16xf32>
      "gpu.return"(%11) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_2D_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<?x?x?xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8x16xindex>, %arg5: vector<8x16xi1>, %arg6: vector<8x16xf32>):
      %0:8 = "memref.extract_strided_metadata"(%arg0) : (memref<?x?x?xf32>) -> (memref<f32>, index, index, index, index, index, index, index)
      %1 = "arith.muli"(%arg1, %0#5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %2 = "arith.muli"(%arg2, %0#6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "arith.addi"(%1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "arith.addi"(%3, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "vector.broadcast"(%4) : (index) -> vector<8x16xindex>
      %6 = "arith.addi"(%5, %arg4) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %7 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<?x?x?xf32>) -> index
      %8 = "arith.index_cast"(%7) : (index) -> i64
      %9 = "xegpu.load"(%8, %6, %arg5) : (i64, vector<8x16xindex>, vector<8x16xi1>) -> vector<8x16xf32>
      %10 = "arith.select"(%arg5, %9, %arg6) : (vector<8x16xi1>, vector<8x16xf32>, vector<8x16xf32>) -> vector<8x16xf32>
      "gpu.return"(%10) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_dynamic_source", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<?x8x16xf32>, index, index, index, vector<8x16xindex>, vector<8x16xi1>, vector<8x16xf32>) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<?x8x16xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8x16xindex>, %arg5: vector<8x16xi1>, %arg6: vector<8x16xf32>):
      %0 = "arith.constant"() <{value = 128 : index}> : () -> index
      %1 = "arith.constant"() <{value = 16 : index}> : () -> index
      %2 = "arith.muli"(%arg1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "arith.muli"(%arg2, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%4, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "vector.broadcast"(%5) : (index) -> vector<8x16xindex>
      %7 = "arith.addi"(%6, %arg4) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %8 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<?x8x16xf32>) -> index
      %9 = "arith.index_cast"(%8) : (index) -> i64
      %10 = "xegpu.load"(%9, %7, %arg5) : (i64, vector<8x16xindex>, vector<8x16xi1>) -> vector<8x16xf32>
      %11 = "arith.select"(%arg5, %10, %arg6) : (vector<8x16xi1>, vector<8x16xf32>, vector<8x16xf32>) -> vector<8x16xf32>
      "gpu.return"(%11) : (vector<8x16xf32>) -> ()
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
      %0 = "arith.constant"() <{value = 4096 : index}> : () -> index
      %1 = "memref.subview"(%arg0, %arg1, %arg1) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %2:6 = "memref.extract_strided_metadata"(%1) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> (memref<f16>, index, index, index, index, index)
      %3 = "arith.muli"(%arg2, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %4 = "arith.addi"(%2#1, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%4, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "vector.broadcast"(%5) : (index) -> vector<8xindex>
      %7 = "arith.addi"(%6, %arg4) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %8 = "memref.extract_aligned_pointer_as_index"(%1) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> index
      %9 = "arith.index_cast"(%8) : (index) -> i64
      %10 = "xegpu.load"(%9, %7, %arg5) : (i64, vector<8xindex>, vector<8xi1>) -> vector<8xf16>
      %11 = "arith.select"(%arg5, %10, %arg6) : (vector<8xi1>, vector<8xf16>, vector<8xf16>) -> vector<8xf16>
      "gpu.return"(%11) : (vector<8xf16>) -> ()
    }) {sym_name = "gather_from_subview", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<32xf32, strided<[?], offset: ?>>, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<32xf32, strided<[?], offset: ?>>, %arg1: index, %arg2: vector<8xindex>, %arg3: vector<8xi1>, %arg4: vector<8xf32>):
      %0:4 = "memref.extract_strided_metadata"(%arg0) : (memref<32xf32, strided<[?], offset: ?>>) -> (memref<f32>, index, index, index)
      %1 = "arith.muli"(%arg1, %0#3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %2 = "arith.addi"(%0#1, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %3 = "vector.broadcast"(%0#3) : (index) -> vector<8xindex>
      %4 = "arith.muli"(%3, %arg2) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %5 = "vector.broadcast"(%2) : (index) -> vector<8xindex>
      %6 = "arith.addi"(%5, %4) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %7 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<32xf32, strided<[?], offset: ?>>) -> index
      %8 = "arith.index_cast"(%7) : (index) -> i64
      %9 = "xegpu.load"(%8, %6, %arg3) : (i64, vector<8xindex>, vector<8xi1>) -> vector<8xf32>
      %10 = "arith.select"(%arg3, %9, %arg4) : (vector<8xi1>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
      "gpu.return"(%10) : (vector<8xf32>) -> ()
    }) {sym_name = "non_unit_inner_stride_1D", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>, index, index, index, vector<8xindex>, vector<8xi1>, vector<8xf32>) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>, %arg1: index, %arg2: index, %arg3: index, %arg4: vector<8xindex>, %arg5: vector<8xi1>, %arg6: vector<8xf32>):
      %0 = "arith.constant"() <{value = dense<2> : vector<8xindex>}> : () -> vector<8xindex>
      %1 = "arith.constant"() <{value = 128 : index}> : () -> index
      %2 = "arith.constant"() <{value = 2 : index}> : () -> index
      %3:8 = "memref.extract_strided_metadata"(%arg0) : (memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>) -> (memref<f32>, index, index, index, index, index, index, index)
      %4 = "arith.muli"(%arg1, %3#5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.addi"(%3#1, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.muli"(%arg2, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.addi"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "arith.muli"(%arg3, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %9 = "arith.addi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %10 = "arith.muli"(%arg4, %0) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %11 = "vector.broadcast"(%9) : (index) -> vector<8xindex>
      %12 = "arith.addi"(%11, %10) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %13 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<4x8x32xf32, strided<[?, 128, 2], offset: ?>>) -> index
      %14 = "arith.index_cast"(%13) : (index) -> i64
      %15 = "xegpu.load"(%14, %12, %arg5) : (i64, vector<8xindex>, vector<8xi1>) -> vector<8xf32>
      %16 = "arith.select"(%arg5, %15, %arg6) : (vector<8xi1>, vector<8xf32>, vector<8xf32>) -> vector<8xf32>
      "gpu.return"(%16) : (vector<8xf32>) -> ()
    }) {sym_name = "non_unit_inner_stride_3D", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

