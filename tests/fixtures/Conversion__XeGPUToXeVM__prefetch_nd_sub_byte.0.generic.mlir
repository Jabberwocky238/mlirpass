"builtin.module"() ({
  "gpu.module"() <{sym_name = "prefetch_check"}> ({
    "gpu.func"() <{function_type = (memref<16x128xi4, 1>) -> (), kernel}> ({
    ^bb0(%arg0: memref<16x128xi4, 1>):
      %0 = "arith.constant"() <{value = 64 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = dense<0> : vector<4xi64>}> : () -> vector<4xi64>
      %3 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %4 = "arith.constant"() <{value = 128 : i32}> : () -> i32
      %5 = "memref.memory_space_cast"(%arg0) : (memref<16x128xi4, 1>) -> memref<16x128xi4>
      %6 = "memref.extract_aligned_pointer_as_index"(%5) : (memref<16x128xi4>) -> index
      %7 = "arith.index_castui"(%6) : (index) -> i64
      %8 = "vector.insert"(%7, %2) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %9 = "vector.bitcast"(%8) : (vector<4xi64>) -> vector<8xi32>
      %10 = "vector.insert"(%4, %9) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %11 = "vector.insert"(%3, %10) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %12 = "vector.insert"(%4, %11) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %13 = "vector.bitcast"(%12) : (vector<8xi32>) -> vector<4xi64>
      %14 = "vector.extract"(%13) <{static_position = array<i64: 0>}> : (vector<4xi64>) -> i64
      %15 = "llvm.inttoptr"(%14) : (i64) -> !llvm.ptr<1>
      "xevm.blockprefetch2d"(%15, %0, %3, %0, %3, %1) <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>, elem_size_in_bits = 16 : i32, tile_height = 8 : i32, tile_width = 16 : i32, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "prefetch_matrix_a"} : () -> ()
  }) : () -> ()
}) : () -> ()

