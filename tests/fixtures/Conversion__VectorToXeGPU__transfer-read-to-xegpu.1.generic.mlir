"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<8x16x32xf32>, index) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8xi1>}> : () -> vector<8xi1>
      %1 = "arith.constant"() <{value = 512 : index}> : () -> index
      %2 = "arith.constant"() <{value = 32 : index}> : () -> index
      %3 = "vector.step"() : () -> vector<8xindex>
      %4 = "arith.muli"(%arg1, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.muli"(%arg1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.addi"(%6, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "vector.broadcast"(%7) : (index) -> vector<8xindex>
      %9 = "arith.addi"(%8, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %10 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<8x16x32xf32>) -> index
      %11 = "arith.index_cast"(%10) : (index) -> i64
      %12 = "xegpu.load"(%11, %9, %0) : (i64, vector<8xindex>, vector<8xi1>) -> vector<8xf32>
      "gpu.return"(%12) : (vector<8xf32>) -> ()
    }) {sym_name = "load_1D_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<8x16x32xf32>, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8x16xi1>}> : () -> vector<8x16xi1>
      %1 = "arith.constant"() <{value = dense<32> : vector<8xindex>}> : () -> vector<8xindex>
      %2 = "arith.constant"() <{value = 512 : index}> : () -> index
      %3 = "arith.constant"() <{value = 32 : index}> : () -> index
      %4 = "vector.step"() : () -> vector<8xindex>
      %5 = "vector.step"() : () -> vector<16xindex>
      %6 = "arith.muli"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %7 = "vector.shape_cast"(%6) : (vector<8xindex>) -> vector<8x1xindex>
      %8 = "vector.broadcast"(%7) : (vector<8x1xindex>) -> vector<8x16xindex>
      %9 = "vector.broadcast"(%5) : (vector<16xindex>) -> vector<8x16xindex>
      %10 = "arith.addi"(%8, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %11 = "arith.muli"(%arg1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.muli"(%arg1, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "arith.addi"(%13, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %15 = "vector.broadcast"(%14) : (index) -> vector<8x16xindex>
      %16 = "arith.addi"(%15, %10) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %17 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<8x16x32xf32>) -> index
      %18 = "arith.index_cast"(%17) : (index) -> i64
      %19 = "xegpu.load"(%18, %16, %0) : (i64, vector<8x16xindex>, vector<8x16xi1>) -> vector<8x16xf32>
      "gpu.return"(%19) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_2D_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<32x64xf32>, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<32x64xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %0) <{in_bounds = [false, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xf32>, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_zero_pad_out_of_bounds"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<32x64xf32>, index, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<32x64xf32>, %arg1: index, %arg2: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8x16xi1>}> : () -> vector<8x16xi1>
      %1 = "arith.constant"() <{value = dense<64> : vector<16xindex>}> : () -> vector<16xindex>
      %2 = "arith.constant"() <{value = 64 : index}> : () -> index
      %3 = "vector.step"() : () -> vector<8xindex>
      %4 = "vector.step"() : () -> vector<16xindex>
      %5 = "arith.muli"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (vector<16xindex>, vector<16xindex>) -> vector<16xindex>
      %6 = "vector.shape_cast"(%3) : (vector<8xindex>) -> vector<8x1xindex>
      %7 = "vector.broadcast"(%6) : (vector<8x1xindex>) -> vector<8x16xindex>
      %8 = "vector.broadcast"(%5) : (vector<16xindex>) -> vector<8x16xindex>
      %9 = "arith.addi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %10 = "arith.muli"(%arg1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "arith.addi"(%10, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "vector.broadcast"(%11) : (index) -> vector<8x16xindex>
      %13 = "arith.addi"(%12, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %14 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<32x64xf32>) -> index
      %15 = "arith.index_cast"(%14) : (index) -> i64
      %16 = "xegpu.load"(%15, %13, %0) : (i64, vector<8x16xindex>, vector<8x16xi1>) -> vector<8x16xf32>
      "gpu.return"(%16) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_transposed"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<32x64x128xf32>, index, index, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<32x64x128xf32>, %arg1: index, %arg2: index, %arg3: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8x16xi1>}> : () -> vector<8x16xi1>
      %1 = "arith.constant"() <{value = dense<128> : vector<16xindex>}> : () -> vector<16xindex>
      %2 = "arith.constant"() <{value = 8192 : index}> : () -> index
      %3 = "arith.constant"() <{value = 128 : index}> : () -> index
      %4 = "vector.step"() : () -> vector<8xindex>
      %5 = "vector.step"() : () -> vector<16xindex>
      %6 = "arith.muli"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (vector<16xindex>, vector<16xindex>) -> vector<16xindex>
      %7 = "vector.shape_cast"(%4) : (vector<8xindex>) -> vector<8x1xindex>
      %8 = "vector.broadcast"(%7) : (vector<8x1xindex>) -> vector<8x16xindex>
      %9 = "vector.broadcast"(%6) : (vector<16xindex>) -> vector<8x16xindex>
      %10 = "arith.addi"(%8, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %11 = "arith.muli"(%arg1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.muli"(%arg2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "arith.addi"(%13, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %15 = "vector.broadcast"(%14) : (index) -> vector<8x16xindex>
      %16 = "arith.addi"(%15, %10) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %17 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<32x64x128xf32>) -> index
      %18 = "arith.index_cast"(%17) : (index) -> i64
      %19 = "xegpu.load"(%18, %16, %0) : (i64, vector<8x16xindex>, vector<8x16xi1>) -> vector<8x16xf32>
      "gpu.return"(%19) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_transpose_3d_memref"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<?x?x?xf32>, index, index, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8x16xi1>}> : () -> vector<8x16xi1>
      %1:8 = "memref.extract_strided_metadata"(%arg0) : (memref<?x?x?xf32>) -> (memref<f32>, index, index, index, index, index, index, index)
      %2 = "vector.step"() : () -> vector<8xindex>
      %3 = "vector.step"() : () -> vector<16xindex>
      %4 = "vector.broadcast"(%1#6) : (index) -> vector<8xindex>
      %5 = "arith.muli"(%2, %4) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %6 = "vector.shape_cast"(%5) : (vector<8xindex>) -> vector<8x1xindex>
      %7 = "vector.broadcast"(%6) : (vector<8x1xindex>) -> vector<8x16xindex>
      %8 = "vector.broadcast"(%3) : (vector<16xindex>) -> vector<8x16xindex>
      %9 = "arith.addi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %10 = "arith.muli"(%arg1, %1#5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "arith.muli"(%arg2, %1#6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.addi"(%10, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%12, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "vector.broadcast"(%13) : (index) -> vector<8x16xindex>
      %15 = "arith.addi"(%14, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %16 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<?x?x?xf32>) -> index
      %17 = "arith.index_cast"(%16) : (index) -> i64
      %18 = "xegpu.load"(%17, %15, %0) : (i64, vector<8x16xindex>, vector<8x16xi1>) -> vector<8x16xf32>
      "gpu.return"(%18) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_dynamic_source"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<?x8x16xf32>, index, index, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<?x8x16xf32>, %arg1: index, %arg2: index, %arg3: index):
      %0 = "arith.constant"() <{value = dense<16> : vector<8xindex>}> : () -> vector<8xindex>
      %1 = "arith.constant"() <{value = dense<true> : vector<8x16xi1>}> : () -> vector<8x16xi1>
      %2 = "arith.constant"() <{value = 128 : index}> : () -> index
      %3 = "arith.constant"() <{value = 16 : index}> : () -> index
      %4 = "vector.step"() : () -> vector<8xindex>
      %5 = "vector.step"() : () -> vector<16xindex>
      %6 = "arith.muli"(%4, %0) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %7 = "vector.shape_cast"(%6) : (vector<8xindex>) -> vector<8x1xindex>
      %8 = "vector.broadcast"(%7) : (vector<8x1xindex>) -> vector<8x16xindex>
      %9 = "vector.broadcast"(%5) : (vector<16xindex>) -> vector<8x16xindex>
      %10 = "arith.addi"(%8, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %11 = "arith.muli"(%arg1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.muli"(%arg2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "arith.addi"(%13, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %15 = "vector.broadcast"(%14) : (index) -> vector<8x16xindex>
      %16 = "arith.addi"(%15, %10) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %17 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<?x8x16xf32>) -> index
      %18 = "arith.index_cast"(%17) : (index) -> i64
      %19 = "xegpu.load"(%18, %16, %1) : (i64, vector<8x16xindex>, vector<8x16xi1>) -> vector<8x16xf32>
      "gpu.return"(%19) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_dynamic_source2"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<?x?x?x?x?xf32>, index, index, index, index, index) -> vector<2x4x8x16xf32>}> ({
    ^bb0(%arg0: memref<?x?x?x?x?xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<2x4x8x16xi1>}> : () -> vector<2x4x8x16xi1>
      %1:12 = "memref.extract_strided_metadata"(%arg0) : (memref<?x?x?x?x?xf32>) -> (memref<f32>, index, index, index, index, index, index, index, index, index, index, index)
      %2 = "vector.step"() : () -> vector<2xindex>
      %3 = "vector.step"() : () -> vector<4xindex>
      %4 = "vector.step"() : () -> vector<8xindex>
      %5 = "vector.step"() : () -> vector<16xindex>
      %6 = "vector.broadcast"(%1#8) : (index) -> vector<2xindex>
      %7 = "arith.muli"(%2, %6) <{overflowFlags = #arith.overflow<none>}> : (vector<2xindex>, vector<2xindex>) -> vector<2xindex>
      %8 = "vector.broadcast"(%1#9) : (index) -> vector<4xindex>
      %9 = "arith.muli"(%3, %8) <{overflowFlags = #arith.overflow<none>}> : (vector<4xindex>, vector<4xindex>) -> vector<4xindex>
      %10 = "vector.broadcast"(%1#10) : (index) -> vector<8xindex>
      %11 = "arith.muli"(%4, %10) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %12 = "vector.shape_cast"(%7) : (vector<2xindex>) -> vector<2x1x1x1xindex>
      %13 = "vector.shape_cast"(%9) : (vector<4xindex>) -> vector<1x4x1x1xindex>
      %14 = "vector.shape_cast"(%11) : (vector<8xindex>) -> vector<1x1x8x1xindex>
      %15 = "vector.broadcast"(%12) : (vector<2x1x1x1xindex>) -> vector<2x4x8x16xindex>
      %16 = "vector.broadcast"(%13) : (vector<1x4x1x1xindex>) -> vector<2x4x8x16xindex>
      %17 = "vector.broadcast"(%14) : (vector<1x1x8x1xindex>) -> vector<2x4x8x16xindex>
      %18 = "vector.broadcast"(%5) : (vector<16xindex>) -> vector<2x4x8x16xindex>
      %19 = "arith.addi"(%15, %16) <{overflowFlags = #arith.overflow<none>}> : (vector<2x4x8x16xindex>, vector<2x4x8x16xindex>) -> vector<2x4x8x16xindex>
      %20 = "arith.addi"(%19, %17) <{overflowFlags = #arith.overflow<none>}> : (vector<2x4x8x16xindex>, vector<2x4x8x16xindex>) -> vector<2x4x8x16xindex>
      %21 = "arith.addi"(%20, %18) <{overflowFlags = #arith.overflow<none>}> : (vector<2x4x8x16xindex>, vector<2x4x8x16xindex>) -> vector<2x4x8x16xindex>
      %22 = "arith.muli"(%arg1, %1#7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %23 = "arith.muli"(%arg2, %1#8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %24 = "arith.addi"(%22, %23) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %25 = "arith.muli"(%arg3, %1#9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %26 = "arith.addi"(%24, %25) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %27 = "arith.muli"(%arg4, %1#10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %28 = "arith.addi"(%26, %27) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %29 = "arith.addi"(%28, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %30 = "vector.broadcast"(%29) : (index) -> vector<2x4x8x16xindex>
      %31 = "arith.addi"(%30, %21) <{overflowFlags = #arith.overflow<none>}> : (vector<2x4x8x16xindex>, vector<2x4x8x16xindex>) -> vector<2x4x8x16xindex>
      %32 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<?x?x?x?x?xf32>) -> index
      %33 = "arith.index_cast"(%32) : (index) -> i64
      %34 = "xegpu.load"(%33, %31, %0) : (i64, vector<2x4x8x16xindex>, vector<2x4x8x16xi1>) -> vector<2x4x8x16xf32>
      "gpu.return"(%34) : (vector<2x4x8x16xf32>) -> ()
    }) {sym_name = "load_dynamic_source3"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<16x32x64xf32>, index, index) -> vector<8x16x32xf32>}> ({
    ^bb0(%arg0: memref<16x32x64xf32>, %arg1: index, %arg2: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8x16x32xi1>}> : () -> vector<8x16x32xi1>
      %1 = "arith.constant"() <{value = dense<64> : vector<16xindex>}> : () -> vector<16xindex>
      %2 = "arith.constant"() <{value = dense<2048> : vector<8xindex>}> : () -> vector<8xindex>
      %3 = "arith.constant"() <{value = 2048 : index}> : () -> index
      %4 = "arith.constant"() <{value = 64 : index}> : () -> index
      %5 = "vector.step"() : () -> vector<8xindex>
      %6 = "vector.step"() : () -> vector<16xindex>
      %7 = "vector.step"() : () -> vector<32xindex>
      %8 = "arith.muli"(%5, %2) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %9 = "arith.muli"(%6, %1) <{overflowFlags = #arith.overflow<none>}> : (vector<16xindex>, vector<16xindex>) -> vector<16xindex>
      %10 = "vector.shape_cast"(%8) : (vector<8xindex>) -> vector<8x1x1xindex>
      %11 = "vector.shape_cast"(%9) : (vector<16xindex>) -> vector<1x16x1xindex>
      %12 = "vector.broadcast"(%10) : (vector<8x1x1xindex>) -> vector<8x16x32xindex>
      %13 = "vector.broadcast"(%11) : (vector<1x16x1xindex>) -> vector<8x16x32xindex>
      %14 = "vector.broadcast"(%7) : (vector<32xindex>) -> vector<8x16x32xindex>
      %15 = "arith.addi"(%12, %13) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16x32xindex>, vector<8x16x32xindex>) -> vector<8x16x32xindex>
      %16 = "arith.addi"(%15, %14) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16x32xindex>, vector<8x16x32xindex>) -> vector<8x16x32xindex>
      %17 = "arith.muli"(%arg1, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %18 = "arith.muli"(%arg2, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %19 = "arith.addi"(%17, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %20 = "arith.addi"(%19, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %21 = "vector.broadcast"(%20) : (index) -> vector<8x16x32xindex>
      %22 = "arith.addi"(%21, %16) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16x32xindex>, vector<8x16x32xindex>) -> vector<8x16x32xindex>
      %23 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<16x32x64xf32>) -> index
      %24 = "arith.index_cast"(%23) : (index) -> i64
      %25 = "xegpu.load"(%24, %22, %0) : (i64, vector<8x16x32xindex>, vector<8x16x32xi1>) -> vector<8x16x32xf32>
      "gpu.return"(%25) : (vector<8x16x32xf32>) -> ()
    }) {sym_name = "load_high_dim_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<2x2x2x2x2x2x2x2xf32>, index) -> vector<2x2x2x2x2x2x2x2xf32>}> ({
    ^bb0(%arg0: memref<2x2x2x2x2x2x2x2xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<2x2x2x2x2x2x2x2xi1>}> : () -> vector<2x2x2x2x2x2x2x2xi1>
      %1 = "arith.constant"() <{value = dense<2> : vector<2xindex>}> : () -> vector<2xindex>
      %2 = "arith.constant"() <{value = dense<4> : vector<2xindex>}> : () -> vector<2xindex>
      %3 = "arith.constant"() <{value = dense<8> : vector<2xindex>}> : () -> vector<2xindex>
      %4 = "arith.constant"() <{value = dense<16> : vector<2xindex>}> : () -> vector<2xindex>
      %5 = "arith.constant"() <{value = dense<32> : vector<2xindex>}> : () -> vector<2xindex>
      %6 = "arith.constant"() <{value = dense<64> : vector<2xindex>}> : () -> vector<2xindex>
      %7 = "arith.constant"() <{value = dense<128> : vector<2xindex>}> : () -> vector<2xindex>
      %8 = "arith.constant"() <{value = 128 : index}> : () -> index
      %9 = "arith.constant"() <{value = 64 : index}> : () -> index
      %10 = "arith.constant"() <{value = 32 : index}> : () -> index
      %11 = "arith.constant"() <{value = 16 : index}> : () -> index
      %12 = "arith.constant"() <{value = 8 : index}> : () -> index
      %13 = "arith.constant"() <{value = 4 : index}> : () -> index
      %14 = "arith.constant"() <{value = 2 : index}> : () -> index
      %15 = "vector.step"() : () -> vector<2xindex>
      %16 = "vector.step"() : () -> vector<2xindex>
      %17 = "vector.step"() : () -> vector<2xindex>
      %18 = "vector.step"() : () -> vector<2xindex>
      %19 = "vector.step"() : () -> vector<2xindex>
      %20 = "vector.step"() : () -> vector<2xindex>
      %21 = "vector.step"() : () -> vector<2xindex>
      %22 = "vector.step"() : () -> vector<2xindex>
      %23 = "arith.muli"(%15, %7) <{overflowFlags = #arith.overflow<none>}> : (vector<2xindex>, vector<2xindex>) -> vector<2xindex>
      %24 = "arith.muli"(%16, %6) <{overflowFlags = #arith.overflow<none>}> : (vector<2xindex>, vector<2xindex>) -> vector<2xindex>
      %25 = "arith.muli"(%17, %5) <{overflowFlags = #arith.overflow<none>}> : (vector<2xindex>, vector<2xindex>) -> vector<2xindex>
      %26 = "arith.muli"(%18, %4) <{overflowFlags = #arith.overflow<none>}> : (vector<2xindex>, vector<2xindex>) -> vector<2xindex>
      %27 = "arith.muli"(%19, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<2xindex>, vector<2xindex>) -> vector<2xindex>
      %28 = "arith.muli"(%20, %2) <{overflowFlags = #arith.overflow<none>}> : (vector<2xindex>, vector<2xindex>) -> vector<2xindex>
      %29 = "arith.muli"(%21, %1) <{overflowFlags = #arith.overflow<none>}> : (vector<2xindex>, vector<2xindex>) -> vector<2xindex>
      %30 = "vector.shape_cast"(%23) : (vector<2xindex>) -> vector<2x1x1x1x1x1x1x1xindex>
      %31 = "vector.shape_cast"(%24) : (vector<2xindex>) -> vector<1x2x1x1x1x1x1x1xindex>
      %32 = "vector.shape_cast"(%25) : (vector<2xindex>) -> vector<1x1x2x1x1x1x1x1xindex>
      %33 = "vector.shape_cast"(%26) : (vector<2xindex>) -> vector<1x1x1x2x1x1x1x1xindex>
      %34 = "vector.shape_cast"(%27) : (vector<2xindex>) -> vector<1x1x1x1x2x1x1x1xindex>
      %35 = "vector.shape_cast"(%28) : (vector<2xindex>) -> vector<1x1x1x1x1x2x1x1xindex>
      %36 = "vector.shape_cast"(%29) : (vector<2xindex>) -> vector<1x1x1x1x1x1x2x1xindex>
      %37 = "vector.broadcast"(%30) : (vector<2x1x1x1x1x1x1x1xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %38 = "vector.broadcast"(%31) : (vector<1x2x1x1x1x1x1x1xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %39 = "vector.broadcast"(%32) : (vector<1x1x2x1x1x1x1x1xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %40 = "vector.broadcast"(%33) : (vector<1x1x1x2x1x1x1x1xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %41 = "vector.broadcast"(%34) : (vector<1x1x1x1x2x1x1x1xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %42 = "vector.broadcast"(%35) : (vector<1x1x1x1x1x2x1x1xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %43 = "vector.broadcast"(%36) : (vector<1x1x1x1x1x1x2x1xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %44 = "vector.broadcast"(%22) : (vector<2xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %45 = "arith.addi"(%37, %38) <{overflowFlags = #arith.overflow<none>}> : (vector<2x2x2x2x2x2x2x2xindex>, vector<2x2x2x2x2x2x2x2xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %46 = "arith.addi"(%45, %39) <{overflowFlags = #arith.overflow<none>}> : (vector<2x2x2x2x2x2x2x2xindex>, vector<2x2x2x2x2x2x2x2xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %47 = "arith.addi"(%46, %40) <{overflowFlags = #arith.overflow<none>}> : (vector<2x2x2x2x2x2x2x2xindex>, vector<2x2x2x2x2x2x2x2xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %48 = "arith.addi"(%47, %41) <{overflowFlags = #arith.overflow<none>}> : (vector<2x2x2x2x2x2x2x2xindex>, vector<2x2x2x2x2x2x2x2xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %49 = "arith.addi"(%48, %42) <{overflowFlags = #arith.overflow<none>}> : (vector<2x2x2x2x2x2x2x2xindex>, vector<2x2x2x2x2x2x2x2xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %50 = "arith.addi"(%49, %43) <{overflowFlags = #arith.overflow<none>}> : (vector<2x2x2x2x2x2x2x2xindex>, vector<2x2x2x2x2x2x2x2xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %51 = "arith.addi"(%50, %44) <{overflowFlags = #arith.overflow<none>}> : (vector<2x2x2x2x2x2x2x2xindex>, vector<2x2x2x2x2x2x2x2xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %52 = "arith.muli"(%arg1, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %53 = "arith.muli"(%arg1, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %54 = "arith.addi"(%52, %53) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %55 = "arith.muli"(%arg1, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %56 = "arith.addi"(%54, %55) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %57 = "arith.muli"(%arg1, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %58 = "arith.addi"(%56, %57) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %59 = "arith.muli"(%arg1, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %60 = "arith.addi"(%58, %59) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %61 = "arith.muli"(%arg1, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %62 = "arith.addi"(%60, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %63 = "arith.muli"(%arg1, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %64 = "arith.addi"(%62, %63) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %65 = "arith.addi"(%64, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %66 = "vector.broadcast"(%65) : (index) -> vector<2x2x2x2x2x2x2x2xindex>
      %67 = "arith.addi"(%66, %51) <{overflowFlags = #arith.overflow<none>}> : (vector<2x2x2x2x2x2x2x2xindex>, vector<2x2x2x2x2x2x2x2xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %68 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<2x2x2x2x2x2x2x2xf32>) -> index
      %69 = "arith.index_cast"(%68) : (index) -> i64
      %70 = "xegpu.load"(%69, %67, %0) : (i64, vector<2x2x2x2x2x2x2x2xindex>, vector<2x2x2x2x2x2x2x2xi1>) -> vector<2x2x2x2x2x2x2x2xf32>
      "gpu.return"(%70) : (vector<2x2x2x2x2x2x2x2xf32>) -> ()
    }) {sym_name = "load_8D_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<32x64xf16>, index) -> vector<8x16xf16>}> ({
    ^bb0(%arg0: memref<32x64xf16>, %arg1: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8x16xi1>}> : () -> vector<8x16xi1>
      %1 = "arith.constant"() <{value = dense<64> : vector<16xindex>}> : () -> vector<16xindex>
      %2 = "arith.constant"() <{value = 64 : index}> : () -> index
      %3 = "vector.step"() : () -> vector<8xindex>
      %4 = "vector.step"() : () -> vector<16xindex>
      %5 = "arith.muli"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (vector<16xindex>, vector<16xindex>) -> vector<16xindex>
      %6 = "vector.shape_cast"(%3) : (vector<8xindex>) -> vector<8x1xindex>
      %7 = "vector.broadcast"(%6) : (vector<8x1xindex>) -> vector<8x16xindex>
      %8 = "vector.broadcast"(%5) : (vector<16xindex>) -> vector<8x16xindex>
      %9 = "arith.addi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %10 = "arith.muli"(%arg1, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "arith.addi"(%10, %arg1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "vector.broadcast"(%11) : (index) -> vector<8x16xindex>
      %13 = "arith.addi"(%12, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %14 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<32x64xf16>) -> index
      %15 = "arith.index_cast"(%14) : (index) -> i64
      %16 = "xegpu.load"(%15, %13, %0) : (i64, vector<8x16xindex>, vector<8x16xi1>) -> vector<8x16xf16>
      "gpu.return"(%16) : (vector<8x16xf16>) -> ()
    }) {sym_name = "load_transpose_f16"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<32x64xf32>, index, index, f32) -> (vector<8x16xf32>, vector<8x16xf32>)}> ({
    ^bb0(%arg0: memref<32x64xf32>, %arg1: index, %arg2: index, %arg3: f32):
      %0 = "arith.constant"() <{value = 1.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg2, %0) <{in_bounds = [true, false], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xf32>, index, index, f32) -> vector<8x16xf32>
      %2 = "vector.transfer_read"(%arg0, %arg2, %arg1, %arg3) <{in_bounds = [false, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (memref<32x64xf32>, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1, %2) : (vector<8x16xf32>, vector<8x16xf32>) -> ()
    }) {sym_name = "no_load_out_of_bounds_non_zero_pad"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<8x16x32xf32>, index) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<8x16x32xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %arg1, %0) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<8x16x32xf32>, index, index, index, f32) -> vector<8xf32>
      "gpu.return"(%1) : (vector<8xf32>) -> ()
    }) {sym_name = "no_load_out_of_bounds_1D_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<4xf32>, index) -> vector<4xf32>}> ({
    ^bb0(%arg0: memref<4xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "arith.constant"() <{value = dense<[false, true, false, true]> : vector<4xi1>}> : () -> vector<4xi1>
      %2 = "vector.transfer_read"(%arg0, %arg1, %0, %1) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (memref<4xf32>, index, f32, vector<4xi1>) -> vector<4xf32>
      "gpu.return"(%2) : (vector<4xf32>) -> ()
    }) {sym_name = "no_load_masked"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (tensor<32x64xf32>, index, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: tensor<32x64xf32>, %arg1: index, %arg2: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg2, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 2, 1, 0>, permutation_map = #map}> : (tensor<32x64xf32>, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "no_load_tensor"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<32xf32, strided<[?], offset: ?>>, index) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<32xf32, strided<[?], offset: ?>>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<32xf32, strided<[?], offset: ?>>, index, f32) -> vector<8xf32>
      "gpu.return"(%1) : (vector<8xf32>) -> ()
    }) {sym_name = "no_load_non_unit_inner_stride"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<16x32x64xf32>, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<16x32x64xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %arg1, %arg1, %0) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 3, 1, 0>, permutation_map = #map}> : (memref<16x32x64xf32>, index, index, index, f32) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "no_load_unsupported_map"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<4096x4096xf16>, index, index) -> vector<8xf16>}> ({
    ^bb0(%arg0: memref<4096x4096xf16>, %arg1: index, %arg2: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8xi1>}> : () -> vector<8xi1>
      %1 = "arith.constant"() <{value = 4096 : index}> : () -> index
      %2 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %3:6 = "memref.extract_strided_metadata"(%2) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> (memref<f16>, index, index, index, index, index)
      %4 = "vector.step"() : () -> vector<8xindex>
      %5 = "arith.muli"(%arg2, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.addi"(%3#1, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.addi"(%6, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "vector.broadcast"(%7) : (index) -> vector<8xindex>
      %9 = "arith.addi"(%8, %4) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %10 = "memref.extract_aligned_pointer_as_index"(%2) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> index
      %11 = "arith.index_cast"(%10) : (index) -> i64
      %12 = "xegpu.load"(%11, %9, %0) : (i64, vector<8xindex>, vector<8xi1>) -> vector<8xf16>
      "gpu.return"(%12) : (vector<8xf16>) -> ()
    }) {sym_name = "load_from_subview_1D"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<4096x4096xf16>, index, index) -> vector<8x16xf16>}> ({
    ^bb0(%arg0: memref<4096x4096xf16>, %arg1: index, %arg2: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8x16xi1>}> : () -> vector<8x16xi1>
      %1 = "arith.constant"() <{value = dense<4096> : vector<8xindex>}> : () -> vector<8xindex>
      %2 = "arith.constant"() <{value = 4096 : index}> : () -> index
      %3 = "memref.subview"(%arg0, %arg1, %arg2) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %4:6 = "memref.extract_strided_metadata"(%3) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> (memref<f16>, index, index, index, index, index)
      %5 = "vector.step"() : () -> vector<8xindex>
      %6 = "vector.step"() : () -> vector<16xindex>
      %7 = "arith.muli"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %8 = "vector.shape_cast"(%7) : (vector<8xindex>) -> vector<8x1xindex>
      %9 = "vector.broadcast"(%8) : (vector<8x1xindex>) -> vector<8x16xindex>
      %10 = "vector.broadcast"(%6) : (vector<16xindex>) -> vector<8x16xindex>
      %11 = "arith.addi"(%9, %10) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %12 = "arith.muli"(%arg2, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%4#1, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "arith.addi"(%13, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %15 = "vector.broadcast"(%14) : (index) -> vector<8x16xindex>
      %16 = "arith.addi"(%15, %11) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %17 = "memref.extract_aligned_pointer_as_index"(%3) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> index
      %18 = "arith.index_cast"(%17) : (index) -> i64
      %19 = "xegpu.load"(%18, %16, %0) : (i64, vector<8x16xindex>, vector<8x16xi1>) -> vector<8x16xf16>
      "gpu.return"(%19) : (vector<8x16xf16>) -> ()
    }) {sym_name = "load_from_subview_2D"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<16x32xf32, 3>, index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: memref<16x32xf32, 3>, %arg1: index):
      %0 = "xegpu.create_mem_desc"(%arg0) : (memref<16x32xf32, 3>) -> !xegpu.mem_desc<16x32xf32>
      %1 = "xegpu.load_matrix"(%0, %arg1, %arg1) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<16x32xf32>, index, index) -> vector<8x16xf32>
      "gpu.return"(%1) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_2D_vector_addrspace3"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<32xf32, 3>, index) -> vector<8xf32>}> ({
    ^bb0(%arg0: memref<32xf32, 3>, %arg1: index):
      %0 = "xegpu.create_mem_desc"(%arg0) : (memref<32xf32, 3>) -> !xegpu.mem_desc<32xf32>
      %1 = "xegpu.load_matrix"(%0, %arg1) <{const_offsets = array<i64: -9223372036854775808>}> : (!xegpu.mem_desc<32xf32>, index) -> vector<8xf32>
      "gpu.return"(%1) : (vector<8xf32>) -> ()
    }) {sym_name = "load_1D_vector_addrspace3"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (index) -> vector<8x16xf32>}> ({
    ^bb0(%arg0: index):
      %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16x32xf32, 3>
      %1 = "xegpu.create_mem_desc"(%0) : (memref<16x32xf32, 3>) -> !xegpu.mem_desc<16x32xf32>
      %2 = "xegpu.load_matrix"(%1, %arg0, %arg0) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (!xegpu.mem_desc<16x32xf32>, index, index) -> vector<8x16xf32>
      "gpu.return"(%2) : (vector<8x16xf32>) -> ()
    }) {sym_name = "load_2D_vector_alloca_promoted_to_slm"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (index) -> vector<8xf32>}> ({
    ^bb0(%arg0: index):
      %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<16xf32, 3>
      %1 = "xegpu.create_mem_desc"(%0) : (memref<16xf32, 3>) -> !xegpu.mem_desc<16xf32>
      %2 = "xegpu.load_matrix"(%1, %arg0) <{const_offsets = array<i64: -9223372036854775808>}> : (!xegpu.mem_desc<16xf32>, index) -> vector<8xf32>
      "gpu.return"(%2) : (vector<8xf32>) -> ()
    }) {sym_name = "load_1D_vector_alloca_promoted_to_slm"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<() -> ()>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<f16>) -> vector<f16>}> ({
    ^bb0(%arg0: memref<f16>):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
      %1 = "vector.transfer_read"(%arg0, %0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 0, 1, 0>, permutation_map = #map}> : (memref<f16>, f16) -> vector<f16>
      "gpu.return"(%1) : (vector<f16>) -> ()
    }) {sym_name = "load_0D_memref_unsupported"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> ()>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<3xf32>, index) -> vector<f32>}> ({
    ^bb0(%arg0: memref<3xf32>, %arg1: index):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
      %1 = "vector.transfer_read"(%arg0, %arg1, %0) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (memref<3xf32>, index, f32) -> vector<f32>
      "gpu.return"(%1) : (vector<f32>) -> ()
    }) {sym_name = "load_0D_vector_unsupported"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 * 16)>
#map1 = affine_map<()[s0] -> (s0 * 8)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (memref<1x1024x24x64xf16>, memref<1x24x1024x64xf16>) -> (), kernel, known_block_size = array<i32: 256, 1, 1>}> ({
    ^bb0(%arg0: memref<1x1024x24x64xf16>, %arg1: memref<1x24x1024x64xf16>):
      %0 = "arith.constant"() <{value = dense<64> : vector<16xindex>}> : () -> vector<16xindex>
      %1 = "arith.constant"() <{value = dense<65536> : vector<1xindex>}> : () -> vector<1xindex>
      %2 = "arith.constant"() <{value = 65536 : index}> : () -> index
      %3 = "arith.constant"() <{value = dense<true> : vector<1x1x16x8xi1>}> : () -> vector<1x1x16x8xi1>
      %4 = "arith.constant"() <{value = dense<1536> : vector<16xindex>}> : () -> vector<16xindex>
      %5 = "arith.constant"() <{value = dense<64> : vector<1xindex>}> : () -> vector<1xindex>
      %6 = "arith.constant"() <{value = dense<1572864> : vector<1xindex>}> : () -> vector<1xindex>
      %7 = "arith.constant"() <{value = 64 : index}> : () -> index
      %8 = "arith.constant"() <{value = 1536 : index}> : () -> index
      %9 = "gpu.block_id"() <{dimension = #gpu<dim x>}> : () -> index
      %10 = "gpu.block_id"() <{dimension = #gpu<dim y>}> : () -> index
      %11 = "gpu.block_id"() <{dimension = #gpu<dim z>}> : () -> index
      %12 = "affine.apply"(%10) <{map = #map}> : (index) -> index
      %13 = "affine.apply"(%11) <{map = #map1}> : (index) -> index
      %14 = "vector.step"() : () -> vector<1xindex>
      %15 = "vector.step"() : () -> vector<1xindex>
      %16 = "vector.step"() : () -> vector<16xindex>
      %17 = "vector.step"() : () -> vector<8xindex>
      %18 = "arith.muli"(%14, %6) <{overflowFlags = #arith.overflow<none>}> : (vector<1xindex>, vector<1xindex>) -> vector<1xindex>
      %19 = "arith.muli"(%15, %5) <{overflowFlags = #arith.overflow<none>}> : (vector<1xindex>, vector<1xindex>) -> vector<1xindex>
      %20 = "arith.muli"(%16, %4) <{overflowFlags = #arith.overflow<none>}> : (vector<16xindex>, vector<16xindex>) -> vector<16xindex>
      %21 = "vector.shape_cast"(%20) : (vector<16xindex>) -> vector<1x1x16x1xindex>
      %22 = "vector.broadcast"(%18) : (vector<1xindex>) -> vector<1x1x16x8xindex>
      %23 = "vector.broadcast"(%19) : (vector<1xindex>) -> vector<1x1x16x8xindex>
      %24 = "vector.broadcast"(%21) : (vector<1x1x16x1xindex>) -> vector<1x1x16x8xindex>
      %25 = "vector.broadcast"(%17) : (vector<8xindex>) -> vector<1x1x16x8xindex>
      %26 = "arith.addi"(%22, %23) <{overflowFlags = #arith.overflow<none>}> : (vector<1x1x16x8xindex>, vector<1x1x16x8xindex>) -> vector<1x1x16x8xindex>
      %27 = "arith.addi"(%26, %24) <{overflowFlags = #arith.overflow<none>}> : (vector<1x1x16x8xindex>, vector<1x1x16x8xindex>) -> vector<1x1x16x8xindex>
      %28 = "arith.addi"(%27, %25) <{overflowFlags = #arith.overflow<none>}> : (vector<1x1x16x8xindex>, vector<1x1x16x8xindex>) -> vector<1x1x16x8xindex>
      %29 = "arith.muli"(%12, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %30 = "arith.muli"(%9, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %31 = "arith.addi"(%29, %30) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %32 = "arith.addi"(%31, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %33 = "vector.broadcast"(%32) : (index) -> vector<1x1x16x8xindex>
      %34 = "arith.addi"(%33, %28) <{overflowFlags = #arith.overflow<none>}> : (vector<1x1x16x8xindex>, vector<1x1x16x8xindex>) -> vector<1x1x16x8xindex>
      %35 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<1x1024x24x64xf16>) -> index
      %36 = "arith.index_cast"(%35) : (index) -> i64
      %37 = "xegpu.load"(%36, %34, %3) : (i64, vector<1x1x16x8xindex>, vector<1x1x16x8xi1>) -> vector<1x1x16x8xf16>
      %38 = "vector.step"() : () -> vector<1xindex>
      %39 = "vector.step"() : () -> vector<1xindex>
      %40 = "vector.step"() : () -> vector<16xindex>
      %41 = "vector.step"() : () -> vector<8xindex>
      %42 = "arith.muli"(%38, %6) <{overflowFlags = #arith.overflow<none>}> : (vector<1xindex>, vector<1xindex>) -> vector<1xindex>
      %43 = "arith.muli"(%39, %1) <{overflowFlags = #arith.overflow<none>}> : (vector<1xindex>, vector<1xindex>) -> vector<1xindex>
      %44 = "arith.muli"(%40, %0) <{overflowFlags = #arith.overflow<none>}> : (vector<16xindex>, vector<16xindex>) -> vector<16xindex>
      %45 = "vector.shape_cast"(%44) : (vector<16xindex>) -> vector<1x1x16x1xindex>
      %46 = "vector.broadcast"(%42) : (vector<1xindex>) -> vector<1x1x16x8xindex>
      %47 = "vector.broadcast"(%43) : (vector<1xindex>) -> vector<1x1x16x8xindex>
      %48 = "vector.broadcast"(%45) : (vector<1x1x16x1xindex>) -> vector<1x1x16x8xindex>
      %49 = "vector.broadcast"(%41) : (vector<8xindex>) -> vector<1x1x16x8xindex>
      %50 = "arith.addi"(%46, %47) <{overflowFlags = #arith.overflow<none>}> : (vector<1x1x16x8xindex>, vector<1x1x16x8xindex>) -> vector<1x1x16x8xindex>
      %51 = "arith.addi"(%50, %48) <{overflowFlags = #arith.overflow<none>}> : (vector<1x1x16x8xindex>, vector<1x1x16x8xindex>) -> vector<1x1x16x8xindex>
      %52 = "arith.addi"(%51, %49) <{overflowFlags = #arith.overflow<none>}> : (vector<1x1x16x8xindex>, vector<1x1x16x8xindex>) -> vector<1x1x16x8xindex>
      %53 = "arith.muli"(%9, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %54 = "arith.muli"(%12, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %55 = "arith.addi"(%53, %54) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %56 = "arith.addi"(%55, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %57 = "vector.broadcast"(%56) : (index) -> vector<1x1x16x8xindex>
      %58 = "arith.addi"(%57, %52) <{overflowFlags = #arith.overflow<none>}> : (vector<1x1x16x8xindex>, vector<1x1x16x8xindex>) -> vector<1x1x16x8xindex>
      %59 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<1x24x1024x64xf16>) -> index
      %60 = "arith.index_cast"(%59) : (index) -> i64
      "xegpu.store"(%37, %60, %58, %3) : (vector<1x1x16x8xf16>, i64, vector<1x1x16x8xindex>, vector<1x1x16x8xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "transpose_1x1024x24x64"} : () -> ()
  }) : () -> ()
}) : () -> ()

