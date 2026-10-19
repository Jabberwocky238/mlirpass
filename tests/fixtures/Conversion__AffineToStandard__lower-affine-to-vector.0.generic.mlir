"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_vector_load"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%1, %2, %3) ({
    ^bb0(%arg1: index):
      %4 = "arith.addi"(%arg1, %arg0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %5 = "arith.constant"() <{value = 7 : index}> : () -> index
      %6 = "arith.addi"(%4, %5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %7 = "vector.load"(%0, %6) <{nontemporal = false}> : (memref<100xf32>, index) -> vector<8xf32>
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> (), sym_name = "affine_vector_store"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100xf32>
    %1 = "arith.constant"() <{value = dense<1.100000e+01> : vector<4xf32>}> : () -> vector<4xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.for"(%2, %3, %4) ({
    ^bb0(%arg1: index):
      %5 = "arith.constant"() <{value = -1 : index}> : () -> index
      %6 = "arith.muli"(%arg0, %5) <{overflowFlags = #arith.overflow<nsw>}> : (index, index) -> index
      %7 = "arith.addi"(%arg1, %6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %8 = "arith.constant"() <{value = 7 : index}> : () -> index
      %9 = "arith.addi"(%7, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      "vector.store"(%1, %0, %9) <{nontemporal = false}> : (vector<4xf32>, memref<100xf32>, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "vector_load_2d"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100x100xf32>
    %1 = "arith.constant"() <{value = 0 : index}> : () -> index
    %2 = "arith.constant"() <{value = 16 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    "scf.for"(%1, %2, %3) ({
    ^bb0(%arg0: index):
      %4 = "arith.constant"() <{value = 0 : index}> : () -> index
      %5 = "arith.constant"() <{value = 16 : index}> : () -> index
      %6 = "arith.constant"() <{value = 8 : index}> : () -> index
      "scf.for"(%4, %5, %6) ({
      ^bb0(%arg1: index):
        %7 = "vector.load"(%0, %arg0, %arg1) <{nontemporal = false}> : (memref<100x100xf32>, index, index) -> vector<2x8xf32>
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "vector_store_2d"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100x100xf32>
    %1 = "arith.constant"() <{value = dense<1.100000e+01> : vector<2x8xf32>}> : () -> vector<2x8xf32>
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = 16 : index}> : () -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    "scf.for"(%2, %3, %4) ({
    ^bb0(%arg0: index):
      %5 = "arith.constant"() <{value = 0 : index}> : () -> index
      %6 = "arith.constant"() <{value = 16 : index}> : () -> index
      %7 = "arith.constant"() <{value = 8 : index}> : () -> index
      "scf.for"(%5, %6, %7) ({
      ^bb0(%arg1: index):
        "vector.store"(%1, %0, %arg0, %arg1) <{nontemporal = false}> : (vector<2x8xf32>, memref<100x100xf32>, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.yield"() : () -> ()
    }) : (index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

