"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (memref<128xf32>) -> (), kernel}> ({
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
        %16 = "llvm.load"(%13) <{ordering = 0 : i64}> {cache_control = #xevm.load_cache_control<Use_Default>} : (!llvm.ptr<1>) -> f32
        "scf.yield"(%16) : (f32) -> ()
      }, {
        %15 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
        "scf.yield"(%15) : (f32) -> ()
      }) : (i1) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "materialize_memref"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (ui64) -> (), kernel}> ({
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
        %11 = "llvm.load"(%8) <{ordering = 0 : i64}> {cache_control = #xevm.load_cache_control<Use_Default>} : (!llvm.ptr<1>) -> f32
        "scf.yield"(%11) : (f32) -> ()
      }, {
        %10 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
        "scf.yield"(%10) : (f32) -> ()
      }) : (i1) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "materialize_ui64"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (ui32) -> (), kernel}> ({
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
        %12 = "llvm.load"(%9) <{ordering = 0 : i64}> {cache_control = #xevm.load_cache_control<Use_Default>} : (!llvm.ptr<1>) -> f32
        "scf.yield"(%12) : (f32) -> ()
      }, {
        %11 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
        "scf.yield"(%11) : (f32) -> ()
      }) : (i1) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "materialize_ui32"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast"}> ({
    "gpu.func"() <{function_type = (memref<128xf32>) -> (), kernel}> ({
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
        %18 = "llvm.load"(%15) <{ordering = 0 : i64}> {cache_control = #xevm.load_cache_control<Use_Default>} : (!llvm.ptr<1>) -> f32
        "scf.yield"(%18) : (f32) -> ()
      }, {
        %17 = "arith.constant"() <{value = 0.000000e+00 : f32}> : () -> f32
        "scf.yield"(%17) : (f32) -> ()
      }) : (i1) -> f32
      "gpu.return"() : () -> ()
    }) {sym_name = "materialize_single_index_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast", targets = [#xevm.target<chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<128xf32>) -> (), kernel}> ({
    ^bb0(%arg0: memref<128xf32>):
      %0 = "arith.constant"() <{value = 0 : index}> : () -> index
      %1 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<512xi8, 3>
      %2 = "memref.extract_aligned_pointer_as_index"(%1) : (memref<512xi8, 3>) -> index
      %3 = "arith.constant"() <{value = 0 : index}> : () -> index
      %4 = "arith.index_castui"(%2) : (index) -> i32
      %5 = "arith.index_castui"(%3) : (index) -> i32
      %6 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %7 = "arith.muli"(%5, %6) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %8 = "arith.addi"(%4, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %9 = "arith.constant"() <{value = 0 : index}> : () -> index
      %10 = "arith.constant"() <{value = 16 : index}> : () -> index
      %11 = "arith.muli"(%0, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %12 = "arith.addi"(%11, %9) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.constant"() <{value = 1 : index}> : () -> index
      %14 = "arith.muli"(%0, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %15 = "arith.addi"(%14, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %16 = "arith.index_castui"(%15) : (index) -> i32
      %17 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %18 = "arith.muli"(%16, %17) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %19 = "arith.addi"(%8, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %20 = "llvm.inttoptr"(%19) : (i32) -> !llvm.ptr<3>
      %21 = "llvm.load"(%20) <{ordering = 0 : i64}> : (!llvm.ptr<3>) -> f32
      %22 = "vector.broadcast"(%21) : (f32) -> vector<1x1xf32>
      %23 = "vector.shape_cast"(%22) : (vector<1x1xf32>) -> vector<1xf32>
      "vector.store"(%23, %arg0, %0) : (vector<1xf32>, memref<128xf32>, index) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "materialize_element_to_2D_single_element_vector"} : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "gpu.module"() <{sym_name = "materializecast", targets = [#xevm.target<chip = "pvc">]}> ({
    "gpu.func"() <{function_type = (memref<512xi8, 3>) -> (), kernel}> ({
    ^bb0(%arg0: memref<512xi8, 3>):
      %0 = "memref.extract_aligned_pointer_as_index"(%arg0) : (memref<512xi8, 3>) -> index
      %1 = "arith.constant"() <{value = 0 : index}> : () -> index
      %2 = "arith.index_castui"(%0) : (index) -> i32
      %3 = "arith.index_castui"(%1) : (index) -> i32
      %4 = "arith.constant"() <{value = 1 : i32}> : () -> i32
      %5 = "arith.muli"(%3, %4) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %6 = "arith.addi"(%2, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %7 = "arith.constant"() <{value = 0 : index}> : () -> index
      %8 = "arith.constant"() <{value = dense<0.000000e+00> : vector<1x1xf32>}> : () -> vector<1x1xf32>
      %9 = "vector.extract"(%8) <{static_position = array<i64: 0, 0>}> : (vector<1x1xf32>) -> f32
      %10 = "arith.constant"() <{value = 0 : index}> : () -> index
      %11 = "arith.constant"() <{value = 16 : index}> : () -> index
      %12 = "arith.muli"(%7, %11) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %13 = "arith.addi"(%12, %10) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %14 = "arith.constant"() <{value = 1 : index}> : () -> index
      %15 = "arith.muli"(%7, %14) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %16 = "arith.addi"(%15, %13) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %17 = "arith.index_castui"(%16) : (index) -> i32
      %18 = "arith.constant"() <{value = 4 : i32}> : () -> i32
      %19 = "arith.muli"(%17, %18) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %20 = "arith.addi"(%6, %19) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
      %21 = "llvm.inttoptr"(%20) : (i32) -> !llvm.ptr<3>
      "llvm.store"(%9, %21) <{ordering = 0 : i64}> : (f32, !llvm.ptr<3>) -> ()
      "gpu.return"() : () -> ()
    }) {sym_name = "materialize_2D_single_element_vector_to_element"} : () -> ()
  }) : () -> ()
}) : () -> ()

