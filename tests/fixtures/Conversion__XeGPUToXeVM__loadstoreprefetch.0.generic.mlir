"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "gpu.func"() <{function_type = (i64, vector<1xindex>, memref<1xf16>, vector<1xi1>) -> ()}> ({
    ^bb0(%arg0: i64, %arg1: vector<1xindex>, %arg2: memref<1xf16>, %arg3: vector<1xi1>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
      %2 = "arith.constant"() <{value = 2 : i64}> : () -> i64
      %3 = "vector.extract"(%arg3) <{static_position = array<i64: 0>}> : (vector<1xi1>) -> i1
      %4 = "vector.extract"(%arg1) <{static_position = array<i64: 0>}> : (vector<1xindex>) -> index
      %5 = "arith.index_castui"(%4) : (index) -> i64
      %6 = "arith.muli"(%5, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %7 = "arith.addi"(%arg0, %6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %8 = "llvm.inttoptr"(%7) : (i64) -> !llvm.ptr<1>
      %9 = "scf.if"(%3) ({
        %11 = "llvm.load"(%8) <{ordering = 0 : i64}> {cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>} : (!llvm.ptr<1>) -> f16
        "scf.yield"(%11) : (f16) -> ()
      }, {
        "scf.yield"(%1) : (f16) -> ()
      }) : (i1) -> f16
      %10 = "vector.broadcast"(%9) : (f16) -> vector<1xf16>
      "vector.store"(%10, %arg2, %0) : (vector<1xf16>, memref<1xf16>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "load_gather_i64_src_value_offset"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "gpu.func"() <{function_type = (i64, vector<1xindex>, memref<1xf16>, vector<1xi1>) -> ()}> ({
    ^bb0(%arg0: i64, %arg1: vector<1xindex>, %arg2: memref<1xf16>, %arg3: vector<1xi1>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
      %2 = "arith.constant"() <{value = 2 : i64}> : () -> i64
      %3 = "vector.extract"(%arg3) <{static_position = array<i64: 0>}> : (vector<1xi1>) -> i1
      %4 = "vector.extract"(%arg1) <{static_position = array<i64: 0>}> : (vector<1xindex>) -> index
      %5 = "arith.index_castui"(%4) : (index) -> i64
      %6 = "arith.muli"(%5, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %7 = "arith.addi"(%arg0, %6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %8 = "llvm.inttoptr"(%7) : (i64) -> !llvm.ptr<1>
      %9 = "scf.if"(%3) ({
        %11 = "llvm.load"(%8) <{ordering = 0 : i64}> {cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>} : (!llvm.ptr<1>) -> f16
        "scf.yield"(%11) : (f16) -> ()
      }, {
        "scf.yield"(%1) : (f16) -> ()
      }) : (i1) -> f16
      %10 = "vector.broadcast"(%9) : (f16) -> vector<1xf16>
      "vector.store"(%10, %arg2, %0) : (vector<1xf16>, memref<1xf16>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "source_materialize_single_elem_vec"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "gpu.func"() <{function_type = (i64, vector<1xindex>, vector<1xi1>) -> ()}> ({
    ^bb0(%arg0: i64, %arg1: vector<1xindex>, %arg2: vector<1xi1>):
      %0 = "arith.constant"() <{value = 2.900000e+00 : f32}> : () -> f32
      %1 = "arith.constant"() <{value = 4 : i64}> : () -> i64
      %2 = "vector.extract"(%arg2) <{static_position = array<i64: 0>}> : (vector<1xi1>) -> i1
      %3 = "vector.extract"(%arg1) <{static_position = array<i64: 0>}> : (vector<1xindex>) -> index
      %4 = "arith.index_castui"(%3) : (index) -> i64
      %5 = "arith.muli"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %6 = "arith.addi"(%arg0, %5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %7 = "llvm.inttoptr"(%6) : (i64) -> !llvm.ptr<1>
      "scf.if"(%2) ({
        "llvm.store"(%0, %7) <{ordering = 0 : i64}> {cache_control = #xevm.store_cache_control<L1wb_L2uc_L3wb>} : (f32, !llvm.ptr<1>) -> ()
        "scf.yield"() : () -> ()
      }, {
      }) : (i1) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "store_scatter_i64_src_value_offset"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "gpu.func"() <{function_type = (i64, vector<1xindex>) -> ()}> ({
    ^bb0(%arg0: i64, %arg1: vector<1xindex>):
      %0 = "arith.constant"() <{value = 4 : i64}> : () -> i64
      %1 = "vector.extract"(%arg1) <{static_position = array<i64: 0>}> : (vector<1xindex>) -> index
      %2 = "arith.index_castui"(%1) : (index) -> i64
      %3 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %4 = "arith.addi"(%arg0, %3) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %5 = "llvm.inttoptr"(%4) : (i64) -> !llvm.ptr<1>
      "xevm.prefetch"(%5) <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>}> : (!llvm.ptr<1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "prefetch_i64_src_value_offset"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "gpu.func"() <{function_type = (memref<256xf32>, vector<1xindex>) -> ()}> ({
    ^bb0(%arg0: memref<256xf32>, %arg1: vector<1xindex>):
      %0 = "arith.constant"() <{value = 4 : i64}> : () -> i64
      %1 = "vector.extract"(%arg1) <{static_position = array<i64: 0>}> : (vector<1xindex>) -> index
      %2 = "arith.index_castui"(%1) : (index) -> i64
      %3 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<256xf32>) -> index
      %4 = "arith.index_castui"(%3) : (index) -> i64
      %5 = "arith.muli"(%2, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %7 = "llvm.inttoptr"(%6) : (i64) -> !llvm.ptr<1>
      "xevm.prefetch"(%7) <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>}> : (!llvm.ptr<1>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "prefetch_memref_src_value_offset"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "test"}> ({
    "gpu.func"() <{function_type = (memref<?xf16>, vector<1xindex>, vector<1xi1>, memref<1xf16>) -> ()}> ({
    ^bb0(%arg0: memref<?xf16>, %arg1: vector<1xindex>, %arg2: vector<1xi1>, %arg3: memref<1xf16>):
      %0 = "arith.constant"() <{value = 0.000000e+00 : f16}> : () -> f16
      %1 = "arith.constant"() <{value = 2 : i64}> : () -> i64
      %2 = "arith.constant"() <{value = 0 : index}> : () -> index
      %3 = "vector.extract"(%arg2) <{static_position = array<i64: 0>}> : (vector<1xi1>) -> i1
      %4 = "vector.extract"(%arg1) <{static_position = array<i64: 0>}> : (vector<1xindex>) -> index
      %5 = "arith.index_castui"(%4) : (index) -> i64
      %6 = "gpu.subgroup_id"() : () -> index
      %7 = "memref.subview"(%arg0, %6) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: 16>, static_strides = array<i64: 1>}> : (memref<?xf16>, index) -> memref<16xf16, strided<[1], offset: ?>>
      %8:4 = "memref.extract_strided_metadata"(%7) : (memref<16xf16, strided<[1], offset: ?>>) -> (memref<f16>, index, index, index)
      %9 = "memref.extract_aligned_pointer_as_index"(%8#0) : (memref<f16>) -> index
      %10 = "arith.index_castui"(%9) : (index) -> i64
      %11 = "arith.index_castui"(%8#1) : (index) -> i64
      %12 = "arith.muli"(%11, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %13 = "arith.addi"(%10, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %14 = "arith.muli"(%5, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %15 = "arith.addi"(%13, %14) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %16 = "llvm.inttoptr"(%15) : (i64) -> !llvm.ptr<1>
      %17 = "scf.if"(%3) ({
        %19 = "llvm.load"(%16) <{ordering = 0 : i64}> {cache_control = #xevm.load_cache_control<L1c_L2uc_L3c>} : (!llvm.ptr<1>) -> f16
        "scf.yield"(%19) : (f16) -> ()
      }, {
        "scf.yield"(%0) : (f16) -> ()
      }) : (i1) -> f16
      %18 = "vector.broadcast"(%17) : (f16) -> vector<1xf16>
      "vector.store"(%18, %arg3, %2) : (vector<1xf16>, memref<1xf16>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "load_gather_from_dyn_memref_subview"} : () -> ()
  }) : () -> ()
}) : () -> ()

