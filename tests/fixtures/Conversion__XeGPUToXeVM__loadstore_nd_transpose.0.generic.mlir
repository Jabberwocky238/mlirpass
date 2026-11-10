"builtin.module"() ({
  "gpu.module"() <{sym_name = "load_check"}> ({
    "gpu.func"() <{function_type = (memref<16x16xf16, 1>, memref<16x16xf16, 1>) -> (), kernel}> ({
    ^bb0(%arg0: memref<16x16xf16, 1>, %arg1: memref<16x16xf16, 1>):
      %0 = "memref.memory_space_cast"(%arg0) : (memref<16x16xf16, 1>) -> memref<16x16xf16>
      %1 = "memref.extract_aligned_pointer_as_index"(%0) : (memref<16x16xf16>) -> index
      %2 = "arith.constant"() <{value = 0 : index}> : () -> index
      %3 = "arith.index_castui"(%1) : (index) -> i64
      %4 = "arith.index_castui"(%2) : (index) -> i64
      %5 = "arith.constant"() <{value = 2 : i64}> : () -> i64
      %6 = "arith.muli"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %7 = "arith.addi"(%3, %6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %8 = "memref.memory_space_cast"(%arg1) : (memref<16x16xf16, 1>) -> memref<16x16xf16>
      %9 = "arith.constant"() <{value = dense<0> : vector<8xi32>}> : () -> vector<8xi32>
      %10 = "arith.constant"() <{value = 16 : i64}> : () -> i64
      %11 = "arith.trunci"(%10) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %12 = "arith.constant"() <{value = 16 : i64}> : () -> i64
      %13 = "arith.trunci"(%12) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %14 = "arith.constant"() <{value = 16 : i64}> : () -> i64
      %15 = "arith.trunci"(%14) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %16 = "vector.bitcast"(%9) : (vector<8xi32>) -> vector<4xi64>
      %17 = "vector.insert"(%7, %16) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %18 = "vector.bitcast"(%17) : (vector<4xi64>) -> vector<8xi32>
      %19 = "vector.insert"(%11, %18) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %20 = "vector.insert"(%13, %19) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %21 = "vector.insert"(%15, %20) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %22 = "arith.constant"() <{value = 2 : i32}> : () -> i32
      %23 = "vector.bitcast"(%21) : (vector<8xi32>) -> vector<4xi64>
      %24 = "vector.extract"(%23) <{static_position = array<i64: 0>}> : (vector<4xi64>) -> i64
      %25 = "vector.extract"(%21) <{static_position = array<i64: 2>}> : (vector<8xi32>) -> i32
      %26 = "vector.extract"(%21) <{static_position = array<i64: 3>}> : (vector<8xi32>) -> i32
      %27 = "vector.extract"(%21) <{static_position = array<i64: 4>}> : (vector<8xi32>) -> i32
      %28 = "arith.constant"() <{value = 16 : i64}> : () -> i64
      %29 = "arith.trunci"(%28) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %30 = "arith.constant"() <{value = 0 : i64}> : () -> i64
      %31 = "arith.trunci"(%30) <{overflowFlags = #arith.overflow<none>}> : (i64) -> i32
      %32 = "llvm.inttoptr"(%24) : (i64) -> !llvm.ptr<1>
      %33 = "arith.muli"(%25, %22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %34 = "arith.muli"(%27, %22) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %35 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %36 = "arith.shrsi"(%29, %35) : (i32, i32) -> i32
      %37 = "xevm.blockload2d"(%32, %33, %26, %34, %36, %31) <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>, elem_size_in_bits = 32 : i32, pack_register = false, tile_height = 16 : i32, tile_width = 8 : i32, transpose = true, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi32>
      %38 = "vector.bitcast"(%37) : (vector<8xi32>) -> vector<16xf16>
      %39 = "arith.constant"() <{value = 0 : index}> : () -> index
      "vector.store"(%38, %8, %39, %39) : (vector<16xf16>, memref<16x16xf16>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "load_nd_transpose_f16"} : () -> ()
  }) : () -> ()
}) : () -> ()

