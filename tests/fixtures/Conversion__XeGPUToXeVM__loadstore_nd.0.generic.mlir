"builtin.module"() ({
  "gpu.module"() <{sym_name = "load_store_check"}> ({
    "gpu.func"() <{function_type = (memref<8x16xf32, 1>, memref<8x16xf32, 1>) -> (), kernel}> ({
    ^bb0(%arg4: memref<8x16xf32, 1>, %arg5: memref<8x16xf32, 1>):
      %53 = "arith.constant"() <{value = 64 : i32}> : () -> i32
      %54 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %55 = "arith.constant"() <{value = dense<0> : vector<4xi64>}> : () -> vector<4xi64>
      %56 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %57 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %58 = "memref.memory_space_cast"(%arg4) : (memref<8x16xf32, 1>) -> memref<8x16xf32>
      %59 = "memref.extract_aligned_pointer_as_index"(%58) : (memref<8x16xf32>) -> index
      %60 = "arith.index_castui"(%59) : (index) -> i64
      %61 = "memref.memory_space_cast"(%arg5) : (memref<8x16xf32, 1>) -> memref<8x16xf32>
      %62 = "memref.extract_aligned_pointer_as_index"(%61) : (memref<8x16xf32>) -> index
      %63 = "arith.index_castui"(%62) : (index) -> i64
      %64 = "vector.insert"(%60, %55) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %65 = "vector.bitcast"(%64) : (vector<4xi64>) -> vector<8xi32>
      %66 = "vector.insert"(%57, %65) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %67 = "vector.insert"(%56, %66) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %68 = "vector.insert"(%57, %67) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %69 = "vector.bitcast"(%68) : (vector<8xi32>) -> vector<4xi64>
      %70 = "vector.extract"(%69) <{static_position = array<i64: 0>}> : (vector<4xi64>) -> i64
      %71 = "llvm.inttoptr"(%70) : (i64) -> !llvm.ptr<1>
      %72 = "xevm.blockload2d"(%71, %53, %56, %53, %54, %54) <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>, elem_size_in_bits = 32 : i32, pack_register = false, tile_height = 8 : i32, tile_width = 16 : i32, transpose = false, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi32>
      %73 = "vector.bitcast"(%72) : (vector<8xi32>) -> vector<8xf32>
      %74 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %75 = "arith.index_cast"(%74) : (index) -> i32
      %76 = "arith.sitofp"(%75) : (i32) -> f32
      %77 = "vector.insert"(%76, %73) <{static_position = array<i64: 0>}> : (f32, vector<8xf32>) -> vector<8xf32>
      %78 = "vector.insert"(%63, %55) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %79 = "vector.bitcast"(%78) : (vector<4xi64>) -> vector<8xi32>
      %80 = "vector.insert"(%57, %79) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %81 = "vector.insert"(%56, %80) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %82 = "vector.insert"(%57, %81) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %83 = "vector.bitcast"(%82) : (vector<8xi32>) -> vector<4xi64>
      %84 = "vector.extract"(%83) <{static_position = array<i64: 0>}> : (vector<4xi64>) -> i64
      %85 = "llvm.inttoptr"(%84) : (i64) -> !llvm.ptr<1>
      %86 = "vector.bitcast"(%77) : (vector<8xf32>) -> vector<8xi32>
      "xevm.blockstore2d"(%85, %53, %56, %53, %54, %54, %86) <{cache_control = #xevm.store_cache_control<L1wb_L2uc_L3wb>, elem_size_in_bits = 32 : i32, tile_height = 8 : i32, tile_width = 16 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32, vector<8xi32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "load_store"} : () -> ()
    "gpu.func"() <{function_type = (memref<8x16xf32, 1>, memref<8x16xf32, 1>) -> (), kernel}> ({
    ^bb0(%arg2: memref<8x16xf32, 1>, %arg3: memref<8x16xf32, 1>):
      %19 = "arith.constant"() <{value = 64 : i32}> : () -> i32
      %20 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %21 = "arith.constant"() <{value = dense<0> : vector<4xi64>}> : () -> vector<4xi64>
      %22 = "arith.constant"() <{value = 8 : i32}> : () -> i32
      %23 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %24 = "memref.memory_space_cast"(%arg2) : (memref<8x16xf32, 1>) -> memref<8x16xf32>
      %25 = "memref.extract_aligned_pointer_as_index"(%24) : (memref<8x16xf32>) -> index
      %26 = "arith.index_castui"(%25) : (index) -> i64
      %27 = "memref.memory_space_cast"(%arg3) : (memref<8x16xf32, 1>) -> memref<8x16xf32>
      %28 = "memref.extract_aligned_pointer_as_index"(%27) : (memref<8x16xf32>) -> index
      %29 = "arith.index_castui"(%28) : (index) -> i64
      %30 = "vector.insert"(%26, %21) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %31 = "vector.bitcast"(%30) : (vector<4xi64>) -> vector<8xi32>
      %32 = "vector.insert"(%23, %31) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %33 = "vector.insert"(%22, %32) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %34 = "vector.insert"(%23, %33) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %35 = "vector.bitcast"(%34) : (vector<8xi32>) -> vector<4xi64>
      %36 = "vector.extract"(%35) <{static_position = array<i64: 0>}> : (vector<4xi64>) -> i64
      %37 = "llvm.inttoptr"(%36) : (i64) -> !llvm.ptr<1>
      %38 = "xevm.blockload2d"(%37, %19, %22, %19, %20, %20) <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>, elem_size_in_bits = 32 : i32, pack_register = false, tile_height = 8 : i32, tile_width = 16 : i32, transpose = false, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi32>
      %39 = "vector.bitcast"(%38) : (vector<8xi32>) -> vector<8xf32>
      %40 = "gpu.thread_id"() <{dimension = #gpu<dim x>}> : () -> index
      %41 = "arith.index_cast"(%40) : (index) -> i32
      %42 = "arith.sitofp"(%41) : (i32) -> f32
      %43 = "vector.insert"(%42, %39) <{static_position = array<i64: 0>}> : (f32, vector<8xf32>) -> vector<8xf32>
      %44 = "vector.insert"(%29, %21) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %45 = "vector.bitcast"(%44) : (vector<4xi64>) -> vector<8xi32>
      %46 = "vector.insert"(%23, %45) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %47 = "vector.insert"(%22, %46) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %48 = "vector.insert"(%23, %47) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %49 = "vector.bitcast"(%48) : (vector<8xi32>) -> vector<4xi64>
      %50 = "vector.extract"(%49) <{static_position = array<i64: 0>}> : (vector<4xi64>) -> i64
      %51 = "llvm.inttoptr"(%50) : (i64) -> !llvm.ptr<1>
      %52 = "vector.bitcast"(%43) : (vector<8xf32>) -> vector<8xi32>
      "xevm.blockstore2d"(%51, %19, %22, %19, %20, %20, %52) <{cache_control = #xevm.store_cache_control<Use_Default>, elem_size_in_bits = 32 : i32, tile_height = 8 : i32, tile_width = 16 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32, vector<8xi32>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "load_store_with_partial_cache_hints"} : () -> ()
    "gpu.func"() <{function_type = (memref<32x16xi8, 1>, memref<32x16xi8, 1>) -> (), kernel}> ({
    ^bb0(%arg0: memref<32x16xi8, 1>, %arg1: memref<32x16xi8, 1>):
      %0 = "arith.constant"() <{value = 0 : i32}> : () -> i32
      %1 = "arith.constant"() <{value = dense<0> : vector<4xi64>}> : () -> vector<4xi64>
      %2 = "arith.constant"() <{value = 32 : i32}> : () -> i32
      %3 = "arith.constant"() <{value = 16 : i32}> : () -> i32
      %4 = "arith.constant"() <{value = 0 : index}> : () -> index
      %5 = "memref.memory_space_cast"(%arg0) : (memref<32x16xi8, 1>) -> memref<32x16xi8>
      %6 = "memref.extract_aligned_pointer_as_index"(%5) : (memref<32x16xi8>) -> index
      %7 = "arith.index_castui"(%6) : (index) -> i64
      %8 = "memref.memory_space_cast"(%arg1) : (memref<32x16xi8, 1>) -> memref<32x16xi8>
      %9 = "vector.insert"(%7, %1) <{static_position = array<i64: 0>}> : (i64, vector<4xi64>) -> vector<4xi64>
      %10 = "vector.bitcast"(%9) : (vector<4xi64>) -> vector<8xi32>
      %11 = "vector.insert"(%3, %10) <{static_position = array<i64: 2>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %12 = "vector.insert"(%2, %11) <{static_position = array<i64: 3>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %13 = "vector.insert"(%3, %12) <{static_position = array<i64: 4>}> : (i32, vector<8xi32>) -> vector<8xi32>
      %14 = "vector.bitcast"(%13) : (vector<8xi32>) -> vector<4xi64>
      %15 = "vector.extract"(%14) <{static_position = array<i64: 0>}> : (vector<4xi64>) -> i64
      %16 = "llvm.inttoptr"(%15) : (i64) -> !llvm.ptr<1>
      %17 = "xevm.blockload2d"(%16, %3, %2, %3, %0, %0) <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>, elem_size_in_bits = 8 : i32, pack_register = true, tile_height = 32 : i32, tile_width = 16 : i32, transpose = false, v_blocks = 1 : i32}> : (!llvm.ptr<1>, i32, i32, i32, i32, i32) -> vector<8xi32>
      %18 = "vector.bitcast"(%17) : (vector<8xi32>) -> vector<32xi8>
      "vector.store"(%18, %8, %4, %4) : (vector<32xi8>, memref<32x16xi8>, index, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "load_nd_8bit"} : () -> ()
  }) : () -> ()
}) : () -> ()

