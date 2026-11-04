"builtin.module"() ({
  "gpu.module"() <{sym_name = "load_store_check"}> ({
    "gpu.func"() <{function_type = (memref<16x128xi4, 1>, memref<16x128xi4, 1>) -> ()}> ({
    ^bb0(%arg2: memref<16x128xi4, 1>, %arg3: memref<16x128xi4, 1>):
      %21 = "arith.constant"() <{value = 64 : i32}> : () -> i32
      %22 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %23 = "arith.constant"() <{value = dense<0> : vector<4xi64>}> : () -> vector<4xi64>
      %24 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %25 = "arith.constant"() <{value = 128 : i32}> : () -> i32
      %26 = "memref.memory_space_cast"(%arg2) : (memref<16x128xi4, 1>) -> memref<16x128xi4>
      %27 = "memref.extract_aligned_pointer_as_index"(%26) : (memref<16x128xi4>) -> index
      %28 = "arith.index_castui"(%27) : (index) -> i64
      %29 = "memref.memory_space_cast"(%arg3) : (memref<16x128xi4, 1>) -> memref<16x128xi4>
      %30 = "memref.extract_aligned_pointer_as_index"(%29) : (memref<16x128xi4>) -> index
      %31 = "arith.index_castui"(%30) : (index) -> i64
      %32 = "vector.insert"(%28, %23) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %33 = "vector.bitcast"(%32) : (vector<4xi64>) -> vector<8xi32>
      %34 = "vector.insert"(%25, %33) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %35 = "vector.insert"(%24, %34) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %36 = "vector.insert"(%25, %35) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %37 = "vector.bitcast"(%36) : (vector<8xi32>) -> vector<4xi64>
      %38 = "vector.extract"(%37) <{static_position = array<i64: 0>}> : (vector<4xi64>) -> i64
      %39 = "llvm.inttoptr"(%38) : (i64) -> !llvm.ptr<1>
      %40 = "xevm.blockload2d"(%39, %21, %24, %21, %24, %22) <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3uc>, elem_size_in_bits = 16 : i32, pack_register = false, tile_height = 8 : i32, tile_width = 16 : i32, transpose = false, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi16>
      %41 = "vector.insert"(%31, %23) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %42 = "vector.bitcast"(%41) : (vector<4xi64>) -> vector<8xi32>
      %43 = "vector.insert"(%25, %42) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %44 = "vector.insert"(%24, %43) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %45 = "vector.insert"(%25, %44) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %46 = "vector.bitcast"(%45) : (vector<8xi32>) -> vector<4xi64>
      %47 = "vector.extract"(%46) <{static_position = array<i64: 0>}> : (vector<4xi64>) -> i64
      %48 = "llvm.inttoptr"(%47) : (i64) -> !llvm.ptr<1>
      "xevm.blockstore2d"(%48, %21, %24, %21, %24, %22, %40) <{cache_control = #xevm.store_cache_control<L1wb_L2uc_L3uc>, elem_size_in_bits = 16 : i32, tile_height = 8 : i32, tile_width = 16 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32, vector<8xi16>) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "load_store_matrix_a", workgroup_attributions = 0 : i64} : () -> ()
    "gpu.func"() <{function_type = (memref<64x128xi4, 1>, memref<64x128xi4, 1>) -> ()}> ({
    ^bb0(%arg0: memref<64x128xi4, 1>, %arg1: memref<64x128xi4, 1>):
      %0 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 32 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = dense<0> : vector<4xi64>}> : () -> vector<4xi64>
      %3 = "arith.constant"() <{value = 64 : i32}> : () -> i32
      %4 = "arith.constant"() <{value = 128 : i32}> : () -> i32
      %5 = "arith.constant"() <{value = 32 : index}> : () -> index
      %6 = "arith.constant"() <{value = 0 : index}> : () -> index
      %7 = "memref.memory_space_cast"(%arg0) : (memref<64x128xi4, 1>) -> memref<64x128xi4>
      %8 = "memref.extract_aligned_pointer_as_index"(%7) : (memref<64x128xi4>) -> index
      %9 = "arith.index_castui"(%8) : (index) -> i64
      %10 = "memref.memory_space_cast"(%arg1) : (memref<64x128xi4, 1>) -> memref<64x128xi4>
      %11 = "vector.insert"(%9, %2) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %12 = "vector.bitcast"(%11) : (vector<4xi64>) -> vector<8xi32>
      %13 = "vector.insert"(%4, %12) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %14 = "vector.insert"(%3, %13) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %15 = "vector.insert"(%4, %14) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %16 = "vector.bitcast"(%15) : (vector<8xi32>) -> vector<4xi64>
      %17 = "vector.extract"(%16) <{static_position = array<i64: 0>}> : (vector<4xi64>) -> i64
      %18 = "llvm.inttoptr"(%17) : (i64) -> !llvm.ptr<1>
      %19 = "xevm.blockload2d"(%18, %3, %3, %3, %0, %1) <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3uc>, elem_size_in_bits = 8 : i32, pack_register = true, tile_height = 32 : i32, tile_width = 16 : i32, transpose = false, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi32>
      %20 = "vector.bitcast"(%19) : (vector<8xi32>) -> vector<64xi4>
      "vector.store"(%20, %10, %5, %6) : (vector<64xi4>, memref<64x128xi4>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "load_matrix_b_request_pack", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

