"builtin.module"() ({
  "gpu.module"() <{sym_name = "create_nd_tdesc"}> ({
    "gpu.func"() <{function_type = (memref<16x32xf32, 1>, ui64, index, index, index, index, index, index, memref<?x?xf16>) -> (), kernel}> ({
    ^bb0(%arg0: memref<16x32xf32, 1>, %arg1: ui64, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: memref<?x?xf16>):
      %0 = "xegpu.create_nd_tdesc"(%arg1, %arg2, %arg3, %arg4, %arg5) <{const_shape = array<i64: -9223372036854775808, -9223372036854775808>, const_strides = array<i64: -9223372036854775808, -9223372036854775808>, operandSegmentSizes = array<i32: 1, 2, 2>}> : (ui64, index, index, index, index) -> !xegpu.tensor_desc<8x16xf32>
      %1 = "memref.memory_space_cast"(%arg0) : (memref<16x32xf32, 1>) -> memref<16x32xf32>
      %2 = "xegpu.create_nd_tdesc"(%1) <{operandSegmentSizes = array<i32: 1, 0, 0>}> : (memref<16x32xf32>) -> !xegpu.tensor_desc<8x16xf32>
      %3 = "arith.constant"() <{value = 1 : index}> : () -> index
      %4 = "arith.constant"() <{value = 64 : index}> : () -> index
      %5 = "arith.constant"() <{value = 16 : index}> : () -> index
      %6 = "xegpu.create_nd_tdesc"(%arg8, %4, %5, %5, %3) <{const_shape = array<i64: -9223372036854775808, -9223372036854775808>, const_strides = array<i64: -9223372036854775808, -9223372036854775808>, operandSegmentSizes = array<i32: 1, 2, 2>}> : (memref<?x?xf16>, index, index, index, index) -> !xegpu.tensor_desc<16x16xf16>
      "gpu.return"() : () -> ()
    }) {sym_name = "create_nd_tdesc"} : () -> ()
  }) : () -> ()
}) : () -> ()

