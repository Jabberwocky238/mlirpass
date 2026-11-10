"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<8x16x32xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8xi1>}> : () -> vector<8xi1>
      %1 = "arith.constant"() <{value = 512 : index}> : () -> index
      %2 = "arith.constant"() <{value = 32 : index}> : () -> index
      %3 = "vector.step"() : () -> vector<8xindex>
      %4 = "arith.muli"(%arg2, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.muli"(%arg2, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.addi"(%6, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "vector.broadcast"(%7) : (index) -> vector<8xindex>
      %9 = "arith.addi"(%8, %3) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %10 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<8x16x32xf32>) -> index
      %11 = "arith.index_cast"(%10) : (index) -> i64
      "xegpu.store"(%arg0, %11, %9, %0) : (vector<8xf32>, i64, vector<8xindex>, vector<8xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_1D_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<8x16x32xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<8x16x32xf32>, %arg2: index):
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
      %11 = "arith.muli"(%arg2, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.muli"(%arg2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%11, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "arith.addi"(%13, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %15 = "vector.broadcast"(%14) : (index) -> vector<8x16xindex>
      %16 = "arith.addi"(%15, %10) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %17 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<8x16x32xf32>) -> index
      %18 = "arith.index_cast"(%17) : (index) -> i64
      "xegpu.store"(%arg0, %18, %16, %0) : (vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_2D_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<?x?x?xf32>, index, index, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<?x?x?xf32>, %arg2: index, %arg3: index, %arg4: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8x16xi1>}> : () -> vector<8x16xi1>
      %1:8 = "memref.extract_strided_metadata"(%arg1) : (memref<?x?x?xf32>) -> (memref<f32>, index, index, index, index, index, index, index)
      %2 = "vector.step"() : () -> vector<8xindex>
      %3 = "vector.step"() : () -> vector<16xindex>
      %4 = "vector.broadcast"(%1#6) : (index) -> vector<8xindex>
      %5 = "arith.muli"(%2, %4) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %6 = "vector.shape_cast"(%5) : (vector<8xindex>) -> vector<8x1xindex>
      %7 = "vector.broadcast"(%6) : (vector<8x1xindex>) -> vector<8x16xindex>
      %8 = "vector.broadcast"(%3) : (vector<16xindex>) -> vector<8x16xindex>
      %9 = "arith.addi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %10 = "arith.muli"(%arg2, %1#5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "arith.muli"(%arg3, %1#6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.addi"(%10, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%12, %arg4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "vector.broadcast"(%13) : (index) -> vector<8x16xindex>
      %15 = "arith.addi"(%14, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %16 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<?x?x?xf32>) -> index
      %17 = "arith.index_cast"(%16) : (index) -> i64
      "xegpu.store"(%arg0, %17, %15, %0) : (vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_dynamic_source"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<7x64xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<7x64xf32>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2, %arg2) <{in_bounds = [false, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8x16xf32>, memref<7x64xf32>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_out_of_bounds"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<32x64xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<32x64xf32>, %arg2: index):
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
      %10 = "arith.muli"(%arg2, %2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %11 = "arith.addi"(%10, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "vector.broadcast"(%11) : (index) -> vector<8x16xindex>
      %13 = "arith.addi"(%12, %9) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16xindex>, vector<8x16xindex>) -> vector<8x16xindex>
      %14 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<32x64xf32>) -> index
      %15 = "arith.index_cast"(%14) : (index) -> i64
      "xegpu.store"(%arg0, %15, %13, %0) : (vector<8x16xf32>, i64, vector<8x16xindex>, vector<8x16xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "no_store_transposed"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16x32xf32>, memref<16x32x64xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16x32xf32>, %arg1: memref<16x32x64xf32>, %arg2: index):
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
      %17 = "arith.muli"(%arg2, %3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %18 = "arith.muli"(%arg2, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %19 = "arith.addi"(%17, %18) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %20 = "arith.addi"(%19, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %21 = "vector.broadcast"(%20) : (index) -> vector<8x16x32xindex>
      %22 = "arith.addi"(%21, %16) <{overflowFlags = #arith.overflow<none>}> : (vector<8x16x32xindex>, vector<8x16x32xindex>) -> vector<8x16x32xindex>
      %23 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<16x32x64xf32>) -> index
      %24 = "arith.index_cast"(%23) : (index) -> i64
      "xegpu.store"(%arg0, %24, %22, %0) : (vector<8x16x32xf32>, i64, vector<8x16x32xindex>, vector<8x16x32xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_high_dim_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<2x2x2x2x2x2x2x2xf32>, memref<2x2x2x2x2x2x2x2xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<2x2x2x2x2x2x2x2xf32>, %arg1: memref<2x2x2x2x2x2x2x2xf32>, %arg2: index):
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
      %52 = "arith.muli"(%arg2, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %53 = "arith.muli"(%arg2, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %54 = "arith.addi"(%52, %53) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %55 = "arith.muli"(%arg2, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %56 = "arith.addi"(%54, %55) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %57 = "arith.muli"(%arg2, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %58 = "arith.addi"(%56, %57) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %59 = "arith.muli"(%arg2, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %60 = "arith.addi"(%58, %59) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %61 = "arith.muli"(%arg2, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %62 = "arith.addi"(%60, %61) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %63 = "arith.muli"(%arg2, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %64 = "arith.addi"(%62, %63) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %65 = "arith.addi"(%64, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %66 = "vector.broadcast"(%65) : (index) -> vector<2x2x2x2x2x2x2x2xindex>
      %67 = "arith.addi"(%66, %51) <{overflowFlags = #arith.overflow<none>}> : (vector<2x2x2x2x2x2x2x2xindex>, vector<2x2x2x2x2x2x2x2xindex>) -> vector<2x2x2x2x2x2x2x2xindex>
      %68 = "memref.extract_aligned_pointer_as_index"(%arg1) : (memref<2x2x2x2x2x2x2x2xf32>) -> index
      %69 = "arith.index_cast"(%68) : (index) -> i64
      "xegpu.store"(%arg0, %69, %67, %0) : (vector<2x2x2x2x2x2x2x2xf32>, i64, vector<2x2x2x2x2x2x2x2xindex>, vector<2x2x2x2x2x2x2x2xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_8D_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<4xf32>, memref<4xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<4xf32>, %arg1: memref<4xf32>, %arg2: index):
      %0 = "arith.constant"() <{value = dense<[false, true, false, true]> : vector<4xi1>}> : () -> vector<4xi1>
      "vector.transfer_write"(%arg0, %arg1, %arg2, %0) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 1>, permutation_map = #map}> : (vector<4xf32>, memref<4xf32>, index, vector<4xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "no_store_masked"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d0, d1)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, tensor<32x64xf32>, index) -> tensor<32x64xf32>}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: tensor<32x64xf32>, %arg2: index):
      %0 = "vector.transfer_write"(%arg0, %arg1, %arg2, %arg2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 2, 0>, permutation_map = #map}> : (vector<8x16xf32>, tensor<32x64xf32>, index, index) -> tensor<32x64xf32>
      "gpu.return"(%0) : (tensor<32x64xf32>) -> ()
    }) {sym_name = "no_store_tensor"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> (d0)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<32xf32, strided<[?], offset: ?>>, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<32xf32, strided<[?], offset: ?>>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2) <{in_bounds = [true], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<8xf32>, memref<32xf32, strided<[?], offset: ?>>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "no_store_non_unit_inner_stride"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d0, d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<16x32x64xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<16x32x64xf32>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2, %arg2, %arg2) <{in_bounds = [true, true], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<8x16xf32>, memref<16x32x64xf32>, index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "no_store_unsupported_map"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1, d2) -> (d2)>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<8x16x32xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<8x16x32xf32>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2, %arg2, %arg2) <{in_bounds = [false], operandSegmentSizes = array<i32: 1, 1, 3, 0>, permutation_map = #map}> : (vector<8xf32>, memref<8x16x32xf32>, index, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "no_store_out_of_bounds_1D_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf16>, memref<4096x4096xf16>, index, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf16>, %arg1: memref<4096x4096xf16>, %arg2: index, %arg3: index):
      %0 = "arith.constant"() <{value = dense<true> : vector<8xi1>}> : () -> vector<8xi1>
      %1 = "arith.constant"() <{value = 4096 : index}> : () -> index
      %2 = "memref.subview"(%arg1, %arg2, %arg3) <{operandSegmentSizes = array<i32: 1, 2, 0, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: 256, 256>, static_strides = array<i64: 1, 1>}> : (memref<4096x4096xf16>, index, index) -> memref<256x256xf16, strided<[4096, 1], offset: ?>>
      %3:6 = "memref.extract_strided_metadata"(%2) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> (memref<f16>, index, index, index, index, index)
      %4 = "vector.step"() : () -> vector<8xindex>
      %5 = "arith.muli"(%arg3, %1) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "arith.addi"(%3#1, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "arith.addi"(%6, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "vector.broadcast"(%7) : (index) -> vector<8xindex>
      %9 = "arith.addi"(%8, %4) <{overflowFlags = #arith.overflow<none>}> : (vector<8xindex>, vector<8xindex>) -> vector<8xindex>
      %10 = "memref.extract_aligned_pointer_as_index"(%2) : (memref<256x256xf16, strided<[4096, 1], offset: ?>>) -> index
      %11 = "arith.index_cast"(%10) : (index) -> i64
      "xegpu.store"(%arg0, %11, %9, %0) : (vector<8xf16>, i64, vector<8xindex>, vector<8xi1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_to_subview"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8x16xf32>, memref<16x32xf32, 3>, index) -> ()}> ({
    ^bb0(%arg0: vector<8x16xf32>, %arg1: memref<16x32xf32, 3>, %arg2: index):
      %0 = "xegpu.create_mem_desc"(%arg1) : (memref<16x32xf32, 3>) -> !xegpu.mem_desc<16x32xf32>
      "xegpu.store_matrix"(%arg0, %0, %arg2, %arg2) <{const_offsets = array<i64: -9223372036854775808, -9223372036854775808>}> : (vector<8x16xf32>, !xegpu.mem_desc<16x32xf32>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_2D_vector_addrspace3"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<8xf32>, memref<32xf32, 3>, index) -> ()}> ({
    ^bb0(%arg0: vector<8xf32>, %arg1: memref<32xf32, 3>, %arg2: index):
      %0 = "xegpu.create_mem_desc"(%arg1) : (memref<32xf32, 3>) -> !xegpu.mem_desc<32xf32>
      "xegpu.store_matrix"(%arg0, %0, %arg2) <{const_offsets = array<i64: -9223372036854775808>}> : (vector<8xf32>, !xegpu.mem_desc<32xf32>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_1D_vector_addrspace3"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0) -> ()>
"builtin.module"() ({
  "gpu.module"() <{sym_name = "xevm_module"}> ({
    "gpu.func"() <{function_type = (vector<f32>, memref<3xf32>, index) -> ()}> ({
    ^bb0(%arg0: vector<f32>, %arg1: memref<3xf32>, %arg2: index):
      "vector.transfer_write"(%arg0, %arg1, %arg2) <{in_bounds = [], operandSegmentSizes = array<i32: 1, 1, 1, 0>, permutation_map = #map}> : (vector<f32>, memref<3xf32>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_0D_vector_unsupported"} : () -> ()
  }) : () -> ()
}) : () -> ()

