"builtin.module"() ({
  "func.func"() <{function_type = (f32, index, index) -> (), sym_name = "memref_alloc_store", sym_visibility = "private"}> ({
  ^bb0(%arg9: f32, %arg10: index, %arg11: index):
    %7 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x8xf32>
    "memref.store"(%arg9, %7, %arg10, %arg11) : (f32, memref<4x8xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (index, index) -> f32, sym_name = "memref_alloc_load", sym_visibility = "private"}> ({
  ^bb0(%arg7: index, %arg8: index):
    %5 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x8xf32>
    %6 = "memref.load"(%5, %arg7, %arg8) : (memref<4x8xf32>, index, index) -> f32
    "func.return"(%6) : (f32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<2xf32>, memref<4x8xf32>, index, index) -> (), sym_name = "memref_load_store"}> ({
  ^bb0(%arg3: memref<2xf32>, %arg4: memref<4x8xf32>, %arg5: index, %arg6: index):
    %4 = "memref.load"(%arg3, %arg5) : (memref<2xf32>, index) -> f32
    "memref.store"(%4, %arg4, %arg5, %arg6) : (f32, memref<4x8xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = (i32) -> (), sym_name = "memref_alloc_store_rank0", sym_visibility = "private"}> ({
  ^bb0(%arg2: i32):
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    "memref.store"(%arg2, %3) : (i32, memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> i32, sym_name = "memref_alloc_load_rank0", sym_visibility = "private"}> ({
    %1 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<i32>
    %2 = "memref.load"(%1) : (memref<i32>) -> i32
    "func.return"(%2) : (i32) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<i32>, memref<i32>) -> (), sym_name = "memref_load_store_rank0"}> ({
  ^bb0(%arg0: memref<i32>, %arg1: memref<i32>):
    %0 = "memref.load"(%arg0) : (memref<i32>) -> i32
    "memref.store"(%0, %arg1) : (i32, memref<i32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

