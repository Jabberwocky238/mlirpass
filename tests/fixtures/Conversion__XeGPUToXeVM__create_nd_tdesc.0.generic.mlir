"builtin.module"() ({
  "gpu.module"() <{sym_name = "create_nd_tdesc"}> ({
    "gpu.func"() <{function_type = (memref<16x32xf32, 1>, ui64, index, index, index, index, index, index, memref<?x?xf16>) -> ()}> ({
    ^bb0(%arg0: memref<16x32xf32, 1>, %arg1: ui64, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: memref<?x?xf16>):
      %0 = "memref.extract_aligned_pointer_as_index"(%arg8) : (memref<?x?xf16>) -> index
      %1 = "arith.constant"() <{value = 0 : index}> : () -> index
      %2 = "arith.index_castui"(%0) : (index) -> i64
      %3 = "arith.index_castui"(%1) : (index) -> i64
      %4 = "arith.constant"() <{value = 2 : i64}> : () -> i64
      %5 = "arith.muli"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %6 = "arith.addi"(%2, %5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %7 = "index.castu"(%arg1) : (ui64) -> index
      %8 = "arith.index_castui"(%7) : (index) -> i64
      %9 = "arith.constant"() <{value = dense<0> : vector<8xi32>}> : () -> vector<8xi32>
      %10 = "arith.index_cast"(%arg3) : (index) -> i32
      %11 = "arith.index_cast"(%arg2) : (index) -> i32
      %12 = "arith.index_cast"(%arg4) : (index) -> i32
      %13 = "vector.bitcast"(%9) : (vector<8xi32>) -> vector<4xi64>
      %14 = "vector.insert"(%8, %13) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %15 = "vector.bitcast"(%14) : (vector<4xi64>) -> vector<8xi32>
      %16 = "vector.insert"(%10, %15) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %17 = "vector.insert"(%11, %16) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %18 = "vector.insert"(%12, %17) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %19 = "memref.memory_space_cast"(%arg0) : (memref<16x32xf32, 1>) -> memref<16x32xf32>
      %20 = "memref.extract_aligned_pointer_as_index"(%19) : (memref<16x32xf32>) -> index
      %21 = "arith.constant"() <{value = 0 : index}> : () -> index
      %22 = "arith.index_castui"(%20) : (index) -> i64
      %23 = "arith.index_castui"(%21) : (index) -> i64
      %24 = "arith.constant"() <{value = 4 : i64}> : () -> i64
      %25 = "arith.muli"(%23, %24) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %26 = "arith.addi"(%22, %25) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %27 = "arith.constant"() <{value = dense<0> : vector<8xi32>}> : () -> vector<8xi32>
      %28 = "arith.constant"() <{value = 32 : i64}> : () -> i64
      %29 = "arith.trunci"(%28) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %30 = "arith.constant"() <{value = 16 : i64}> : () -> i64
      %31 = "arith.trunci"(%30) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %32 = "arith.constant"() <{value = 32 : i64}> : () -> i64
      %33 = "arith.trunci"(%32) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %34 = "vector.bitcast"(%27) : (vector<8xi32>) -> vector<4xi64>
      %35 = "vector.insert"(%26, %34) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %36 = "vector.bitcast"(%35) : (vector<4xi64>) -> vector<8xi32>
      %37 = "vector.insert"(%29, %36) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %38 = "vector.insert"(%31, %37) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %39 = "vector.insert"(%33, %38) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %40 = "arith.constant"() <{value = 1 : index}> : () -> index
      %41 = "arith.constant"() <{value = 64 : index}> : () -> index
      %42 = "arith.constant"() <{value = 16 : index}> : () -> index
      %43 = "arith.constant"() <{value = dense<0> : vector<8xi32>}> : () -> vector<8xi32>
      %44 = "arith.index_cast"(%42) : (index) -> i32
      %45 = "arith.index_cast"(%41) : (index) -> i32
      %46 = "arith.index_cast"(%42) : (index) -> i32
      %47 = "vector.bitcast"(%43) : (vector<8xi32>) -> vector<4xi64>
      %48 = "vector.insert"(%6, %47) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %49 = "vector.bitcast"(%48) : (vector<4xi64>) -> vector<8xi32>
      %50 = "vector.insert"(%44, %49) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %51 = "vector.insert"(%45, %50) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %52 = "vector.insert"(%46, %51) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "create_nd_tdesc", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

