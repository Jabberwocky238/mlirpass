"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (memref<128xf32>) -> ()}> ({
    ^bb0(%arg0: memref<128xf32>):
      %0 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<128xf32>) -> index
      %1 = "arith.constant"() <{value = 0 : index}> : () -> index
      %2 = "arith.index_castui"(%0) : (index) -> i64
      %3 = "arith.index_castui"(%1) : (index) -> i64
      %4 = "arith.constant"() <{value = 4 : i64}> : () -> i64
      %5 = "arith.muli"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %6 = "arith.addi"(%2, %5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %7 = "arith.constant"() <{value = 0 : index}> : () -> index
      %8 = "builtin.unrealized_conversion_cast"(%7) : (index) -> i64
      %9 = "arith.constant"() <{value = true}> : () -> i1
      %10 = "arith.constant"() <{value = 4 : i64}> : () -> i64
      %11 = "arith.muli"(%8, %10) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %12 = "arith.addi"(%6, %11) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %13 = "llvm.inttoptr"(%12) : (i64) -> !llvm.ptr<1>
      %14 = "scf.if"(%9) ({
        %16 = "llvm.load"(%13) <{ordering = 0 : i64}> {cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>} : (!llvm.ptr<1>) -> f32
        "scf.yield"(%16) : (f32) -> ()
      }, {
        %15 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
        "scf.yield"(%15) : (f32) -> ()
      }) : (i1) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "materialize_memref", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (ui64) -> ()}> ({
    ^bb0(%arg0: ui64):
      %0 = "index.castu"(%arg0) : (ui64) -> index
      %1 = "arith.index_castui"(%0) : (index) -> i64
      %2 = "arith.constant"() <{value = 0 : index}> : () -> index
      %3 = "builtin.unrealized_conversion_cast"(%2) : (index) -> i64
      %4 = "arith.constant"() <{value = true}> : () -> i1
      %5 = "arith.constant"() <{value = 4 : i64}> : () -> i64
      %6 = "arith.muli"(%3, %5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %7 = "arith.addi"(%1, %6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %8 = "llvm.inttoptr"(%7) : (i64) -> !llvm.ptr<1>
      %9 = "scf.if"(%4) ({
        %11 = "llvm.load"(%8) <{ordering = 0 : i64}> {cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>} : (!llvm.ptr<1>) -> f32
        "scf.yield"(%11) : (f32) -> ()
      }, {
        %10 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
        "scf.yield"(%10) : (f32) -> ()
      }) : (i1) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "materialize_ui64", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (ui32) -> ()}> ({
    ^bb0(%arg0: ui32):
      %0 = "index.castu"(%arg0) : (ui32) -> index
      %1 = "arith.index_castui"(%0) : (index) -> i32
      %2 = "arith.constant"() <{value = 0 : index}> : () -> index
      %3 = "builtin.unrealized_conversion_cast"(%2) : (index) -> i64
      %4 = "arith.constant"() <{value = true}> : () -> i1
      %5 = "arith.extui"(%1) : (i32) -> i64
      %6 = "arith.constant"() <{value = 4 : i64}> : () -> i64
      %7 = "arith.muli"(%3, %6) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %8 = "arith.addi"(%5, %7) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %9 = "llvm.inttoptr"(%8) : (i64) -> !llvm.ptr<1>
      %10 = "scf.if"(%4) ({
        %12 = "llvm.load"(%9) <{ordering = 0 : i64}> {cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>} : (!llvm.ptr<1>) -> f32
        "scf.yield"(%12) : (f32) -> ()
      }, {
        %11 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
        "scf.yield"(%11) : (f32) -> ()
      }) : (i1) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "materialize_ui32", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (memref<128xf32>) -> ()}> ({
    ^bb0(%arg0: memref<128xf32>):
      %0 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<128xf32>) -> index
      %1 = "arith.constant"() <{value = 0 : index}> : () -> index
      %2 = "arith.index_castui"(%0) : (index) -> i64
      %3 = "arith.index_castui"(%1) : (index) -> i64
      %4 = "arith.constant"() <{value = 4 : i64}> : () -> i64
      %5 = "arith.muli"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %6 = "arith.addi"(%2, %5) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %7 = "arith.constant"() <{value = dense<0> : vector<1xindex>}> : () -> vector<1xindex>
      %8 = "vector.extract"(%7) <{static_position = array<i64: 0>}> : (vector<1xindex>) -> index
      %9 = "arith.index_castui"(%8) : (index) -> i64
      %10 = "arith.constant"() <{value = dense<true> : vector<1xi1>}> : () -> vector<1xi1>
      %11 = "vector.extract"(%10) <{static_position = array<i64: 0>}> : (vector<1xi1>) -> i1
      %12 = "arith.constant"() <{value = 4 : i64}> : () -> i64
      %13 = "arith.muli"(%9, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %14 = "arith.addi"(%6, %13) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
      %15 = "llvm.inttoptr"(%14) : (i64) -> !llvm.ptr<1>
      %16 = "scf.if"(%11) ({
        %18 = "llvm.load"(%15) <{ordering = 0 : i64}> {cache_control = #xevm.load_cache_control<L1uc_L2uc_L3uc>} : (!llvm.ptr<1>) -> f32
        "scf.yield"(%18) : (f32) -> ()
      }, {
        %17 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
        "scf.yield"(%17) : (f32) -> ()
      }) : (i1) -> f32
      "gpu.return"() : () -> ()
    }) {gpu.kernel, sym_name = "materialize_single_index_vector", workgroup_attributions = 0 : i64} : () -> ()
  }) : () -> ()
}) : () -> ()

