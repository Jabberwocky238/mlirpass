"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<?x?x?xf32>) -> (), sym_name = "decompose_store"}> ({
  ^bb0(%arg0: f32, %arg1: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "memref.dim"(%arg1, %0) : (memref<?x?x?xf32>, index) -> index
    %4 = "memref.dim"(%arg1, %1) : (memref<?x?x?xf32>, index) -> index
    %5 = "memref.dim"(%arg1, %2) : (memref<?x?x?xf32>, index) -> index
    "gpu.launch"(%1, %1, %1, %3, %4, %5) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index):
      "memref.store"(%arg0, %arg1, %arg5, %arg6, %arg7) : (f32, memref<?x?x?xf32>, index, index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> (), sym_name = "decompose_store_strided"}> ({
  ^bb0(%arg0: f32, %arg1: memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "memref.dim"(%arg1, %0) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index) -> index
    %4 = "memref.dim"(%arg1, %1) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index) -> index
    %5 = "memref.dim"(%arg1, %2) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index) -> index
    "gpu.launch"(%1, %1, %1, %3, %4, %5) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index):
      "memref.store"(%arg0, %arg1, %arg5, %arg6, %arg7) : (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index, index, index) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>) -> (), sym_name = "decompose_load"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %0) : (memref<?x?x?xf32>, index) -> index
    %4 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf32>, index) -> index
    %5 = "memref.dim"(%arg0, %2) : (memref<?x?x?xf32>, index) -> index
    "gpu.launch"(%1, %1, %1, %3, %4, %5) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      %6 = "memref.load"(%arg0, %arg4, %arg5, %arg6) : (memref<?x?x?xf32>, index, index, index) -> f32
      "test.test"(%6) : (f32) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>) -> (), sym_name = "decompose_subview"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %0) : (memref<?x?x?xf32>, index) -> index
    %4 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf32>, index) -> index
    %5 = "memref.dim"(%arg0, %2) : (memref<?x?x?xf32>, index) -> index
    "gpu.launch"(%1, %1, %1, %3, %4, %5) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      %6 = "memref.subview"(%arg0, %arg4, %arg5, %arg6, %2, %2, %2, %1, %1, %1) <{operandSegmentSizes = array<i32: 1, 3, 3, 3>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>}> : (memref<?x?x?xf32>, index, index, index, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
      "test.test"(%6) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>) -> (), sym_name = "decompose_subview_strided"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 2 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %0) : (memref<?x?x?xf32>, index) -> index
    %4 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf32>, index) -> index
    %5 = "memref.dim"(%arg0, %2) : (memref<?x?x?xf32>, index) -> index
    "gpu.launch"(%1, %1, %1, %3, %4, %5) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      %6 = "memref.subview"(%arg0, %arg4, %arg5, %arg6, %2, %2, %2) <{operandSegmentSizes = array<i32: 1, 3, 3, 0>, static_offsets = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: 2, 3, 4>}> : (memref<?x?x?xf32>, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, 4], offset: ?>>
      "test.test"(%6) : (memref<?x?x?xf32, strided<[?, ?, 4], offset: ?>>) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

