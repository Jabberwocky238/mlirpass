"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x2xf32>, memref<2x2xf32>, memref<2x2xf32>) -> (), sym_name = "linalg_generic_sum"}> ({
  ^bb0(%arg0: memref<2x2xf32>, %arg1: memref<2x2xf32>, %arg2: memref<2x2xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    "scf.parallel"(%0, %0, %1, %1, %2, %2) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg3: index, %arg4: index):
      %3 = "memref.load"(%arg0, %arg3, %arg4) <{nontemporal = false}> : (memref<2x2xf32>, index, index) -> f32
      %4 = "memref.load"(%arg1, %arg3, %arg4) <{nontemporal = false}> : (memref<2x2xf32>, index, index) -> f32
      %5 = "arith.addf"(%3, %4) <{fastmath = #arith.fastmath<none>}> : (f32, f32) -> f32
      "memref.store"(%5, %arg2, %arg3, %arg4) <{nontemporal = false}> : (f32, memref<2x2xf32>, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?x?xf32>, memref<?x?x?xf32>) -> (), sym_name = "lower_outer_parallel"}> ({
  ^bb0(%arg0: memref<?x?x?x?xf32>, %arg1: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 3 : index}> : () -> index
    %1 = "arith.constant"() <{value = 2 : index}> : () -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "memref.dim"(%arg0, %3) : (memref<?x?x?x?xf32>, index) -> index
    %5 = "memref.dim"(%arg0, %2) : (memref<?x?x?x?xf32>, index) -> index
    %6 = "memref.dim"(%arg0, %1) : (memref<?x?x?x?xf32>, index) -> index
    %7 = "memref.dim"(%arg0, %0) : (memref<?x?x?x?xf32>, index) -> index
    "scf.parallel"(%3, %3, %4, %5, %2, %2) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg2: index, %arg3: index):
      "scf.for"(%3, %6, %2) ({
      ^bb0(%arg4: index):
        "scf.parallel"(%3, %7, %2) <{operandSegmentSizes = array<i32: 1, 1, 1, 0>}> ({
        ^bb0(%arg5: index):
          %8 = "memref.load"(%arg0, %arg2, %arg3, %arg4, %arg5) <{nontemporal = false}> : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
          "memref.store"(%8, %arg1, %arg2, %arg3, %arg5) <{nontemporal = false}> : (f32, memref<?x?x?xf32>, index, index, index) -> ()
          "scf.reduce"() : () -> ()
        }) : (index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?x?x?x?xf32>, memref<?x?x?x?xf32>) -> (), sym_name = "lower_mixed_parallel"}> ({
  ^bb0(%arg0: memref<?x?x?x?x?x?xf32>, %arg1: memref<?x?x?x?xf32>):
    %0 = "arith.constant"() <{value = 5 : index}> : () -> index
    %1 = "arith.constant"() <{value = 4 : index}> : () -> index
    %2 = "arith.constant"() <{value = 3 : index}> : () -> index
    %3 = "arith.constant"() <{value = 2 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    %5 = "arith.constant"() <{value = 0 : index}> : () -> index
    %6 = "memref.dim"(%arg0, %5) : (memref<?x?x?x?x?x?xf32>, index) -> index
    %7 = "memref.dim"(%arg0, %4) : (memref<?x?x?x?x?x?xf32>, index) -> index
    %8 = "memref.dim"(%arg0, %3) : (memref<?x?x?x?x?x?xf32>, index) -> index
    %9 = "memref.dim"(%arg0, %2) : (memref<?x?x?x?x?x?xf32>, index) -> index
    %10 = "memref.dim"(%arg0, %1) : (memref<?x?x?x?x?x?xf32>, index) -> index
    %11 = "memref.dim"(%arg0, %0) : (memref<?x?x?x?x?x?xf32>, index) -> index
    "scf.parallel"(%5, %5, %6, %7, %4, %4) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
    ^bb0(%arg2: index, %arg3: index):
      "scf.for"(%5, %8, %4) ({
      ^bb0(%arg4: index):
        "scf.parallel"(%5, %5, %9, %10, %4, %4) <{operandSegmentSizes = array<i32: 2, 2, 2, 0>}> ({
        ^bb0(%arg5: index, %arg6: index):
          "scf.for"(%5, %11, %4) ({
          ^bb0(%arg7: index):
            %12 = "memref.load"(%arg0, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7) <{nontemporal = false}> : (memref<?x?x?x?x?x?xf32>, index, index, index, index, index, index) -> f32
            "memref.store"(%12, %arg1, %arg2, %arg3, %arg6, %arg5) <{nontemporal = false}> : (f32, memref<?x?x?x?xf32>, index, index, index, index) -> ()
            "scf.yield"() : () -> ()
          }) : (index, index, index) -> ()
          "scf.reduce"() : () -> ()
        }) : (index, index, index, index, index, index) -> ()
        "scf.yield"() : () -> ()
      }) : (index, index, index) -> ()
      "scf.reduce"() : () -> ()
    }) : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

