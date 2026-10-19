"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?x?xf32>, memref<?x?x?x?xf32>) -> (), sym_name = "step_1"}> ({
  ^bb0(%arg0: memref<?x?x?x?xf32>, %arg1: memref<?x?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 42 : index}> : () -> index
    %2 = "arith.subi"(%1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 0 : index}> : () -> index
    %5 = "arith.constant"() <{value = 10 : index}> : () -> index
    %6 = "arith.subi"(%5, %4) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %7 = "arith.constant"() <{value = 1 : index}> : () -> index
    %8 = "arith.constant"() <{value = 2 : index}> : () -> index
    %9 = "arith.constant"() <{value = 16 : index}> : () -> index
    %10 = "arith.subi"(%9, %8) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %11 = "arith.constant"() <{value = 1 : index}> : () -> index
    %12 = "arith.constant"() <{value = 5 : index}> : () -> index
    %13 = "arith.constant"() <{value = 17 : index}> : () -> index
    %14 = "arith.subi"(%13, %12) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %15 = "arith.constant"() <{value = 1 : index}> : () -> index
    %16 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch"(%2, %6, %16, %10, %14, %16) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index):
      %17 = "arith.addi"(%0, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %18 = "arith.addi"(%4, %arg3) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %19 = "arith.addi"(%8, %arg5) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %20 = "arith.addi"(%12, %arg6) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %21 = "memref.load"(%arg0, %17, %18, %19, %20) : (memref<?x?x?x?xf32>, index, index, index, index) -> f32
      "memref.store"(%21, %arg1, %17, %18, %19, %20) : (f32, memref<?x?x?x?xf32>, index, index, index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

