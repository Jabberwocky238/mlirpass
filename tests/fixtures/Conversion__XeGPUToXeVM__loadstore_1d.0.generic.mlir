"builtin.module"() ({
  "gpu.module"() <{sym_name = "load_store_check"}> ({
    "gpu.func"() <{function_type = (memref<512xf32, 1>, memref<256xf32, 1>) -> ()}> ({
    ^bb0(%arg0: memref<512xf32, 1>, %arg1: memref<256xf32, 1>):
      %0 = "arith.constant"() <{value = 512 : i64}> : () -> i64
      %1 = "arith.constant"() <{value = 384 : i64}> : () -> i64
      %2 = "memref.memory_space_cast"(%arg0) : (memref<512xf32, 1>) -> memref<512xf32>
      %3 = "memref.extract_aligned_pointer_as_index"(%2) : (memref<512xf32>) -> index
      %4 = "arith.index_castui"(%3) : (index) -> i64
      %5 = "memref.memory_space_cast"(%arg1) : (memref<256xf32, 1>) -> memref<256xf32>
      %6 = "memref.extract_aligned_pointer_as_index"(%5) : (memref<256xf32>) -> index
      %7 = "arith.index_castui"(%6) : (index) -> i64
      %8 = "arith.addi"(%4, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %9 = "llvm.inttoptr"(%8) : (i64) -> !llvm.ptr<1>
      %10 = "xevm.blockload"(%9) <{cache_control = #xevm.load_cache_control<L1c_L2uc_L3uc>}> : (!llvm.ptr<1>) -> vector<2xi32>
      %11 = "arith.addi"(%7, %0) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %12 = "llvm.inttoptr"(%11) : (i64) -> !llvm.ptr<1>
      "xevm.blockstore"(%12, %10) <{cache_control = #xevm.store_cache_control<L1wb_L2uc_L3uc>}> : (!llvm.ptr<1>, vector<2xi32>) -> ()
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "load_store", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

