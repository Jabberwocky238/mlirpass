"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> memref<?x42x?xf32>, sym_name = "mixed_alloc"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.alloc"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x42x?xf32>
    "func.return"(%0) : (memref<?x42x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x42x?xf32>) -> (), sym_name = "mixed_dealloc"}> ({
  ^bb0(%arg0: memref<?x42x?xf32>):
    "memref.dealloc"(%arg0) : (memref<?x42x?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> (), sym_name = "unranked_dealloc"}> ({
  ^bb0(%arg0: memref<*xf32>):
    "memref.dealloc"(%arg0) : (memref<*xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> memref<?x?xf32>, sym_name = "dynamic_alloc"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.alloc"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "func.return"(%0) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index) -> memref<?x?xf32>, sym_name = "dynamic_alloca"}> ({
  ^bb0(%arg0: index, %arg1: index):
    %0 = "memref.alloca"(%arg0, %arg1) <{operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    %1 = "memref.alloca"(%arg0, %arg1) <{alignment = 32 : i64, operandSegmentSizes = array<i32: 2, 0>}> : (index, index) -> memref<?x?xf32>
    "func.return"(%0) : (memref<?x?xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>) -> (), sym_name = "dynamic_dealloc"}> ({
  ^bb0(%arg0: memref<?x?xf32>):
    "memref.dealloc"(%arg0) : (memref<?x?xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index) -> memref<32x18xf32>, sym_name = "stdlib_aligned_alloc"}> ({
  ^bb0(%arg0: index):
    %0 = "memref.alloc"() <{alignment = 32 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x18xf32>
    %1 = "memref.alloc"() <{alignment = 64 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xf32>
    %2 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xvector<8xf32>>
    %3 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<4096xvector<2xf32>>
    %4 = "memref.alloc"() <{alignment = 8 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1024xvector<4xf32>>
    %5 = "memref.alloc"() <{alignment = 32 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<100xf32>
    %6 = "memref.alloc"(%arg0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xvector<18xf32>>
    "func.return"(%0) : (memref<32x18xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x?xf32>, index, index) -> (), sym_name = "mixed_load"}> ({
  ^bb0(%arg0: memref<42x?xf32>, %arg1: index, %arg2: index):
    %0 = "memref.load"(%arg0, %arg1, %arg2) : (memref<42x?xf32>, index, index) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> (), sym_name = "dynamic_load"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index):
    %0 = "memref.load"(%arg0, %arg1, %arg2) : (memref<?x?xf32>, index, index) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, index) -> (), sym_name = "prefetch"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index):
    "memref.prefetch"(%arg0, %arg1, %arg2) <{isDataCache = true, isWrite = true, localityHint = 3 : i32}> : (memref<?x?xf32>, index, index) -> ()
    "memref.prefetch"(%arg0, %arg1, %arg2) <{isDataCache = true, isWrite = false, localityHint = 0 : i32}> : (memref<?x?xf32>, index, index) -> ()
    "memref.prefetch"(%arg0, %arg1, %arg2) <{isDataCache = false, isWrite = false, localityHint = 2 : i32}> : (memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>, index, index, f32) -> (), sym_name = "dynamic_store"}> ({
  ^bb0(%arg0: memref<?x?xf32>, %arg1: index, %arg2: index, %arg3: f32):
    "memref.store"(%arg3, %arg0, %arg1, %arg2) : (f32, memref<?x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x?xf32>, index, index, f32) -> (), sym_name = "mixed_store"}> ({
  ^bb0(%arg0: memref<42x?xf32>, %arg1: index, %arg2: index, %arg3: f32):
    "memref.store"(%arg3, %arg0, %arg1, %arg2) : (f32, memref<42x?xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> memref<*xf32, 1>, sym_name = "memref_memory_space_cast"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "memref.memory_space_cast"(%arg0) : (memref<*xf32>) -> memref<*xf32, 1>
    "func.return"(%0) : (memref<*xf32, 1>) -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<!llvm.ptr = dense<64> : vector<3xi64>, !llvm.ptr<1> = dense<32> : vector<3xi64>>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x42xf32>) -> (), sym_name = "memref_cast_static_to_dynamic"}> ({
  ^bb0(%arg0: memref<10x42xf32>):
    %0 = "memref.cast"(%arg0) : (memref<10x42xf32>) -> memref<?x?xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x42xf32>) -> (), sym_name = "memref_cast_static_to_mixed"}> ({
  ^bb0(%arg0: memref<10x42xf32>):
    %0 = "memref.cast"(%arg0) : (memref<10x42xf32>) -> memref<?x42xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>) -> (), sym_name = "memref_cast_dynamic_to_static"}> ({
  ^bb0(%arg0: memref<?x?xf32>):
    %0 = "memref.cast"(%arg0) : (memref<?x?xf32>) -> memref<10x12xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xf32>) -> (), sym_name = "memref_cast_dynamic_to_mixed"}> ({
  ^bb0(%arg0: memref<?x?xf32>):
    %0 = "memref.cast"(%arg0) : (memref<?x?xf32>) -> memref<?x12xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x?xf32>) -> (), sym_name = "memref_cast_mixed_to_dynamic"}> ({
  ^bb0(%arg0: memref<42x?xf32>):
    %0 = "memref.cast"(%arg0) : (memref<42x?xf32>) -> memref<?x?xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x?xf32>) -> (), sym_name = "memref_cast_mixed_to_static"}> ({
  ^bb0(%arg0: memref<42x?xf32>):
    %0 = "memref.cast"(%arg0) : (memref<42x?xf32>) -> memref<42x1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x?xf32>) -> (), sym_name = "memref_cast_mixed_to_mixed"}> ({
  ^bb0(%arg0: memref<42x?xf32>):
    %0 = "memref.cast"(%arg0) : (memref<42x?xf32>) -> memref<?x1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x2x?xf32>) -> (), sym_name = "memref_cast_ranked_to_unranked"}> ({
  ^bb0(%arg0: memref<42x2x?xf32>):
    %0 = "memref.cast"(%arg0) : (memref<42x2x?xf32>) -> memref<*xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<*xf32>) -> (), sym_name = "memref_cast_unranked_to_ranked"}> ({
  ^bb0(%arg0: memref<*xf32>):
    %0 = "memref.cast"(%arg0) : (memref<*xf32>) -> memref<?x?x10x2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x?x?x13x?xf32>) -> (), sym_name = "mixed_memref_dim"}> ({
  ^bb0(%arg0: memref<42x?x?x13x?xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<42x?x?x13x?xf32>, index) -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %2) : (memref<42x?x?x13x?xf32>, index) -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "memref.dim"(%arg0, %4) : (memref<42x?x?x13x?xf32>, index) -> index
    %6 = "arith.constant"() <{value = 3 : index}> : () -> index
    %7 = "memref.dim"(%arg0, %6) : (memref<42x?x?x13x?xf32>, index) -> index
    %8 = "arith.constant"() <{value = 4 : index}> : () -> index
    %9 = "memref.dim"(%arg0, %8) : (memref<42x?x?x13x?xf32>, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<3x?xf32>, index) -> index, sym_name = "memref_dim_with_dyn_index"}> ({
  ^bb0(%arg0: memref<3x?xf32>, %arg1: index):
    %0 = "memref.dim"(%arg0, %arg1) : (memref<3x?xf32>, index) -> index
    "func.return"(%0) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x3xf32>) -> (), sym_name = "memref_reinterpret_cast_ranked_to_static_shape"}> ({
  ^bb0(%arg0: memref<2x3xf32>):
    %0 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 6, 1>, static_strides = array<i64: 1, 1>}> : (memref<2x3xf32>) -> memref<6x1xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (index, index, index, index, index, memref<*xf32>) -> (), sym_name = "memref_reinterpret_cast_unranked_to_dynamic_shape"}> ({
  ^bb0(%arg0: index, %arg1: index, %arg2: index, %arg3: index, %arg4: index, %arg5: memref<*xf32>):
    %0 = "memref.reinterpret_cast"(%arg5, %arg0, %arg1, %arg2, %arg3, %arg4) <{operandSegmentSizes = array<i32: 1, 1, 2, 2>, static_offsets = array<i64: -9223372036854775808>, static_sizes = array<i64: -9223372036854775808, -9223372036854775808>, static_strides = array<i64: -9223372036854775808, -9223372036854775808>}> : (memref<*xf32>, index, index, index, index, index) -> memref<?x?xf32, strided<[?, ?], offset: ?>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<2x3xf32>, memref<?xindex>) -> (), sym_name = "memref_reshape"}> ({
  ^bb0(%arg0: memref<2x3xf32>, %arg1: memref<?xindex>):
    %0 = "memref.reshape"(%arg0, %arg1) : (memref<2x3xf32>, memref<?xindex>) -> memref<*xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "memref_of_memref"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xmemref<1xf32>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "memref_of_memref_32"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xmemref<1xf32>>
    "func.return"() : () -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<index = 32 : i64>} : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "memref_of_memref_of_memref"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xmemref<2xmemref<3xf32>>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "ranked_unranked"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<1xmemref<*xf32>>
    %1 = "memref.cast"(%0) : (memref<1xmemref<*xf32>>) -> memref<*xmemref<*xf32>>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

