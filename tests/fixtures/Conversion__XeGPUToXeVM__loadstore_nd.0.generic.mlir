"builtin.module"() ({
  "gpu.module"() <{sym_name = "load_store_check"}> ({
    "gpu.func"() <{function_type = (memref<8x16xf32, 1>, memref<8x16xf32, 1>) -> ()}> ({
    ^bb0(%arg0: memref<8x16xf32, 1>, %arg1: memref<8x16xf32, 1>):
      %0 = "arith.constant"() <{value = 64 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %2 = "arith.constant"() <{value = dense<0> : vector<4xi64>}> : () -> vector<4xi64>
      %3 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %4 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %5 = "memref.memory_space_cast"(%arg0) : (memref<8x16xf32, 1>) -> memref<8x16xf32>
      %6 = "memref.extract_aligned_pointer_as_index"(%5) : (memref<8x16xf32>) -> index
      %7 = "arith.index_castui"(%6) : (index) -> i64
      %8 = "memref.memory_space_cast"(%arg1) : (memref<8x16xf32, 1>) -> memref<8x16xf32>
      %9 = "memref.extract_aligned_pointer_as_index"(%8) : (memref<8x16xf32>) -> index
      %10 = "arith.index_castui"(%9) : (index) -> i64
      %11 = "vector.insert"(%7, %2) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %12 = "vector.bitcast"(%11) : (vector<4xi64>) -> vector<8xi32>
      %13 = "vector.insert"(%4, %12) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %14 = "vector.insert"(%3, %13) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %15 = "vector.insert"(%4, %14) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %16 = "vector.bitcast"(%15) : (vector<8xi32>) -> vector<4xi64>
      %17 = "vector.extract"(%16) <{static_position = array<i64: 0>}> : (vector<4xi64>) -> i64
      %18 = "llvm.inttoptr"(%17) : (i64) -> !llvm.ptr<1>
      %19 = "xevm.blockload2d"(%18, %0, %3, %0, %1, %1) <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3uc>, elem_size_in_bits = 32 : i32, pack_register = false, tile_height = 8 : i32, tile_width = 16 : i32, transpose = false, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi32>
      %20 = "vector.bitcast"(%19) : (vector<8xi32>) -> vector<8xf32>
      %21 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %22 = "arith.index_cast"(%21) : (index) -> i32
      %23 = "arith.sitofp"(%22) : (i32) -> f32
      %24 = "vector.insert"(%23, %20) <{static_position = array<i64: 0>}> : (f32, vector<8xf32>) -> vector<8xf32>
      %25 = "vector.insert"(%10, %2) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %26 = "vector.bitcast"(%25) : (vector<4xi64>) -> vector<8xi32>
      %27 = "vector.insert"(%4, %26) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %28 = "vector.insert"(%3, %27) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %29 = "vector.insert"(%4, %28) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %30 = "vector.bitcast"(%29) : (vector<8xi32>) -> vector<4xi64>
      %31 = "vector.extract"(%30) <{static_position = array<i64: 0>}> : (vector<4xi64>) -> i64
      %32 = "llvm.inttoptr"(%31) : (i64) -> !llvm.ptr<1>
      %33 = "vector.bitcast"(%24) : (vector<8xf32>) -> vector<8xi32>
      "xevm.blockstore2d"(%32, %0, %3, %0, %1, %1, %33) <{cache_control = #xevm.store_cache_control<L1wb_L2uc_L3uc>, elem_size_in_bits = 32 : i32, tile_height = 8 : i32, tile_width = 16 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32, vector<8xi32>) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "load_store", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

