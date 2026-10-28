#map = affine_map<()[s0, s1, s2, s3, s4] -> (s0 * s1 + s2 * s3 + s4)>
"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<?x?x?xf32>) -> (), sym_name = "decompose_store"}> ({
  ^bb0(%arg0: f32, %arg1: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3:8 = "memref.extract_strided_metadata"(%arg1) : (memref<?x?x?xf32>) -> (memref<f32>, index, index, index, index, index, index, index)
    %4 = "memref.dim"(%arg1, %2) : (memref<?x?x?xf32>, index) -> index
    %5 = "memref.dim"(%arg1, %1) : (memref<?x?x?xf32>, index) -> index
    %6 = "memref.dim"(%arg1, %0) : (memref<?x?x?xf32>, index) -> index
    "gpu.launch"(%1, %1, %1, %4, %5, %6) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index):
      %7 = "affine.apply"(%arg5, %3#5, %arg6, %3#6, %arg7) <{map = #map}> : (index, index, index, index, index) -> index
      %8 = "memref.reinterpret_cast"(%3#0, %7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64>, static_strides = array<i64>}> : (memref<f32>, index) -> memref<f32, strided<[], offset: ?>>
      "memref.store"(%arg0, %8) : (f32, memref<f32, strided<[], offset: ?>>) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1, s2, s3, s4, s5, s6] -> (s0 + s1 * s2 + s3 * s4 + s5 * s6)>
"builtin.module"() ({
  "func.func"() <{function_type = (f32, memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> (), sym_name = "decompose_store_strided"}> ({
  ^bb0(%arg0: f32, %arg1: memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3:8 = "memref.extract_strided_metadata"(%arg1) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> (memref<f32>, index, index, index, index, index, index, index)
    %4 = "memref.dim"(%arg1, %2) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index) -> index
    %5 = "memref.dim"(%arg1, %1) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index) -> index
    %6 = "memref.dim"(%arg1, %0) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>, index) -> index
    "gpu.launch"(%1, %1, %1, %4, %5, %6) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index, %arg13: index):
      %7 = "affine.apply"(%3#1, %arg5, %3#5, %arg6, %3#6, %arg7, %3#7) <{map = #map}> : (index, index, index, index, index, index, index) -> index
      %8 = "memref.reinterpret_cast"(%3#0, %7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64>, static_strides = array<i64>}> : (memref<f32>, index) -> memref<f32, strided<[], offset: ?>>
      "memref.store"(%arg0, %8) : (f32, memref<f32, strided<[], offset: ?>>) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1, s2, s3, s4] -> (s0 * s1 + s2 * s3 + s4)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>) -> (), sym_name = "decompose_load"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3:8 = "memref.extract_strided_metadata"(%arg0) : (memref<?x?x?xf32>) -> (memref<f32>, index, index, index, index, index, index, index)
    %4 = "memref.dim"(%arg0, %2) : (memref<?x?x?xf32>, index) -> index
    %5 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf32>, index) -> index
    %6 = "memref.dim"(%arg0, %0) : (memref<?x?x?xf32>, index) -> index
    "gpu.launch"(%1, %1, %1, %4, %5, %6) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      %7 = "affine.apply"(%arg4, %3#5, %arg5, %3#6, %arg6) <{map = #map}> : (index, index, index, index, index) -> index
      %8 = "memref.reinterpret_cast"(%3#0, %7) <{operandSegmentSizes = array<i32: 1, 1, 0, 0>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64>, static_strides = array<i64>}> : (memref<f32>, index) -> memref<f32, strided<[], offset: ?>>
      %9 = "memref.load"(%8) : (memref<f32, strided<[], offset: ?>>) -> f32
      "test.test"(%9) : (f32) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0, s1, s2, s3, s4] -> (s0 * s1 + s2 * s3 + s4)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>) -> (), sym_name = "decompose_subview"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3:8 = "memref.extract_strided_metadata"(%arg0) : (memref<?x?x?xf32>) -> (memref<f32>, index, index, index, index, index, index, index)
    %4 = "memref.dim"(%arg0, %2) : (memref<?x?x?xf32>, index) -> index
    %5 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf32>, index) -> index
    %6 = "memref.dim"(%arg0, %0) : (memref<?x?x?xf32>, index) -> index
    "gpu.launch"(%1, %1, %1, %4, %5, %6) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      %7 = "affine.apply"(%arg4, %3#5, %arg5, %3#6, %arg6) <{map = #map}> : (index, index, index, index, index) -> index
      %8 = "memref.reinterpret_cast"(%3#0, %7, %0, %0, %0, %3#5, %3#6) <{operandSegmentSizes = array<i32: 1, 1, 3, 2>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, 1>}> : (memref<f32>, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>
      "test.test"(%8) : (memref<?x?x?xf32, strided<[?, ?, ?], offset: ?>>) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<()[s0] -> (s0 * 2)>
#map1 = affine_map<()[s0] -> (s0 * 3)>
#map2 = affine_map<()[s0, s1, s2, s3, s4] -> (s0 * s1 + s2 * s3 + s4)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>) -> (), sym_name = "decompose_subview_strided"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>):
    %0 = "arith.constant"() <{value = 2 : index}> : () -> index
    %1 = "arith.constant"() <{value = 1 : index}> : () -> index
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3:8 = "memref.extract_strided_metadata"(%arg0) : (memref<?x?x?xf32>) -> (memref<f32>, index, index, index, index, index, index, index)
    %4 = "memref.dim"(%arg0, %2) : (memref<?x?x?xf32>, index) -> index
    %5 = "memref.dim"(%arg0, %1) : (memref<?x?x?xf32>, index) -> index
    %6 = "memref.dim"(%arg0, %0) : (memref<?x?x?xf32>, index) -> index
    "gpu.launch"(%1, %1, %1, %4, %5, %6) <{operandSegmentSizes = array<i32: 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0>}> ({
    ^bb0(%arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: index, %arg6: index, %arg7: index, %arg8: index, %arg9: index, %arg10: index, %arg11: index, %arg12: index):
      %7 = "affine.apply"(%3#5) <{map = #map}> : (index) -> index
      %8 = "affine.apply"(%3#6) <{map = #map1}> : (index) -> index
      %9 = "affine.apply"(%arg4, %3#5, %arg5, %3#6, %arg6) <{map = #map2}> : (index, index, index, index, index) -> index
      %10 = "memref.reinterpret_cast"(%3#0, %9, %0, %0, %0, %7, %8) <{operandSegmentSizes = array<i32: 1, 1, 3, 2>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808, 4>}> : (memref<f32>, index, index, index, index, index, index) -> memref<?x?x?xf32, strided<[?, ?, 4], offset: ?>>
      "test.test"(%10) : (memref<?x?x?xf32, strided<[?, ?, 4], offset: ?>>) -> ()
      "gpu.terminator"() : () -> ()
    }) {workgroup_attributions = 0 : i64} : (index, index, index, index, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

