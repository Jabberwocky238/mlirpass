"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "alloca_with_dynamic_shape"}> ({
    %0 = "index.constant"() <{value = 1 : index}> : () -> index
    %1 = "memref.alloca"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<4x?xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "alloca_with_alignment"}> ({
    %0 = "memref.alloca"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<999xi32>) -> (), sym_name = "alloc_and_dealloc_arg"}> ({
  ^bb0(%arg0: memref<999xi32>):
    "memref.dealloc"(%arg0) : (memref<999xi32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "alloca_and_dealloc"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf32>
    "memref.dealloc"(%0) : (memref<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{constant, initial_value = dense<[0.000000e+00, 1.000000e+00, 2.000000e+00, 3.000000e+00]> : tensor<4xf32>, sym_name = "g_dense", sym_visibility = "private", type = memref<4xf32>}> : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "get_global_dense_and_dealloc"}> ({
    %0 = "memref.get_global"() <{name = @g_dense}> : () -> memref<4xf32>
    "memref.dealloc"(%0) : (memref<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{initial_value, sym_name = "g_uninit", sym_visibility = "private", type = memref<4xf32>}> : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "get_global_uninit_and_dealloc"}> ({
    %0 = "memref.get_global"() <{name = @g_uninit}> : () -> memref<4xf32>
    "memref.dealloc"(%0) : (memref<4xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
#map = affine_map<(d0, d1) -> (d1, d0)>
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "non_identity_layout"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4x3xf32, #map>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "zero_dim_rank_1"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<0xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "zero_dim_rank_3"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2x0x4xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{constant, sym_name = "nested_global", sym_visibility = "nested", type = memref<3x7xf32>}> : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "unsupported_type_f128"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xf128>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "unsupported_type_i4"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4xi4>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

