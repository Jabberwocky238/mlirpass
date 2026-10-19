"builtin.module"() ({
  "func.func"() <{function_type = (memref<?xf32>, memref<?xf32>) -> (), sym_name = "one_d_loop"}> ({
  ^bb0(%arg0: memref<?xf32>, %arg1: memref<?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 42 : index}> : () -> index
    %2 = "arith.subi"(%1, %0) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    %4 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch"(%2, %4, %4, %4, %4, %4) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index):
      %5 = "arith.addi"(%0, %arg2) <{overflowFlags = #arith.overflow<none>}> : (index, index) -> index
      %6 = "memref.load"(%arg0, %5) : (memref<?xf32>, index) -> f32
      "memref.store"(%6, %arg1, %5) : (f32, memref<?xf32>, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

