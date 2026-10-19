"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xf32>) -> memref<2xf32>, sym_name = "conversion_static"}> ({
  ^bb0(%arg0: memref<2xf32>):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "memref.copy"(%arg0, %0) : (memref<2xf32>, memref<2xf32>) -> ()
    "memref.dealloc"(%arg0) : (memref<2xf32>) -> ()
    "func.return"(%0) : (memref<2xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>) -> memref<?xf32>, sym_name = "conversion_dynamic"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32>, index) -> index
    %2 = "memref.alloc"(%1) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    "memref.copy"(%arg0, %2) : (memref<?xf32>, memref<?xf32>) -> ()
    "memref.dealloc"(%arg0) : (memref<?xf32>) -> ()
    "func.return"(%2) : (memref<?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> memref<*xf32>, sym_name = "conversion_unknown"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "memref.rank"(%arg0) : (memref<*xf32>) -> index
    %3 = "memref.alloca"(%2) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xindex>
    %4 = "scf.for"(%0, %2, %1, %1) ({
    ^bb0(%arg1: index, %arg2: index):
      %7 = "memref.dim"(%arg0, %arg1) : (memref<*xf32>, index) -> index
      "memref.store"(%7, %3, %arg1) <{nontemporal = false}> : (index, memref<?xindex>, index) -> ()
      %8 = "arith.muli"(%arg2, %7) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "scf.yield"(%8) : (index) -> ()
    }) : (index, index, index, index) -> index
    %5 = "memref.alloc"(%4) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    %6 = "memref.reshape"(%5, %3) : (memref<?xf32>, memref<?xindex>) -> memref<*xf32>
    "memref.copy"(%arg0, %6) : (memref<*xf32>, memref<*xf32>) -> ()
    "memref.dealloc"(%arg0) : (memref<*xf32>) -> ()
    "func.return"(%6) : (memref<*xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32, strided<[?], offset: ?>>) -> memref<?xf32, strided<[?], offset: ?>>, sym_name = "conversion_with_layout_map"}> ({
  ^bb0(%arg0: memref<?xf32, strided<[?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<?xf32, strided<[?], offset: ?>>, index) -> index
    %2 = "memref.alloc"(%1) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xf32>
    %3 = "memref.cast"(%2) : (memref<?xf32>) -> memref<?xf32, strided<[?], offset: ?>>
    "memref.copy"(%arg0, %3) : (memref<?xf32, strided<[?], offset: ?>>, memref<?xf32, strided<[?], offset: ?>>) -> ()
    "memref.dealloc"(%arg0) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
    "func.return"(%3) : (memref<?xf32, strided<[?], offset: ?>>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2xf32>, i1) -> (), sym_name = "conversion_dealloc_simple"}> ({
  ^bb0(%arg0: memref<2xf32>, %arg1: i1):
    "scf.if"(%arg1) ({
      "memref.dealloc"(%arg0) : (memref<2xf32>) -> ()
      "scf.yield"() : () -> ()
    }, {
    }) : (i1) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

