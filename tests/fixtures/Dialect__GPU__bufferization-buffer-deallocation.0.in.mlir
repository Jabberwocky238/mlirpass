"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "gpu_launch"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    "gpu.launch"(%0, %0, %0, %0, %0, %0) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index):
      %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
      "test.read_buffer"(%1) : (memref<2xf32>) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

