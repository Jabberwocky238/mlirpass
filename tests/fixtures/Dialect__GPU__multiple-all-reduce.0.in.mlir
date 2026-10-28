"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x6xf32>
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    %3 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch"(%3, %3, %3, %3, %3, %3) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %4 = "memref.load"(%0, %arg0, %arg3) : (memref<2x6xf32>, index, index) -> f32
      %5 = "gpu.all_reduce"(%4) <{op = #gpu<all_reduce_op add>, uniform}> ({
      }) : (f32) -> f32
      "memref.store"(%5, %1, %arg0) : (f32, memref<2xf32>, index) -> ()
      %6 = "gpu.all_reduce"(%4) <{op = #gpu<all_reduce_op mul>, uniform}> ({
      }) : (f32) -> f32
      "memref.store"(%6, %2, %arg0) : (f32, memref<2xf32>, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

