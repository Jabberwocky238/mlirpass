"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<f32>, sym_name = "zero_d_alloc"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<f32>
    "func.return"(%0) : (memref<f32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> (), sym_name = "zero_d_dealloc"}> ({
  ^bb0(%arg0: memref<f32>):
    "memref.dealloc"(%arg0) : (memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<42xf32>, sym_name = "aligned_1d_alloc"}> ({
    %0 = "memref.alloc"() <{alignment = 8 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<42xf32>
    "func.return"(%0) : (memref<42xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<32x18xf32>, sym_name = "static_alloc"}> ({
    %0 = "memref.alloc"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x18xf32>
    "func.return"(%0) : (memref<32x18xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<32x18xf32>, sym_name = "static_alloca"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x18xf32>
    %1 = "memref.alloca"() <{alignment = 32 : i64, operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x18xf32>
    "func.return"(%0) : (memref<32x18xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> memref<32x0x18xf32>, sym_name = "static_alloca_zero"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<32x0x18xf32>
    "func.return"(%0) : (memref<32x0x18xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x8xf32>) -> (), sym_name = "static_dealloc"}> ({
  ^bb0(%arg0: memref<10x8xf32>):
    "memref.dealloc"(%arg0) : (memref<10x8xf32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>) -> f32, sym_name = "zero_d_load"}> ({
  ^bb0(%arg0: memref<f32>):
    %0 = "memref.load"(%arg0) : (memref<f32>) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x42xf32>, index, index) -> (), sym_name = "static_load"}> ({
  ^bb0(%arg0: memref<10x42xf32>, %arg1: index, %arg2: index):
    %0 = "memref.load"(%arg0, %arg1, %arg2) : (memref<10x42xf32>, index, index) -> f32
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<f32>, f32) -> (), sym_name = "zero_d_store"}> ({
  ^bb0(%arg0: memref<f32>, %arg1: f32):
    "memref.store"(%arg1, %arg0) : (f32, memref<f32>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<10x42xf32>, index, index, f32) -> (), sym_name = "static_store"}> ({
  ^bb0(%arg0: memref<10x42xf32>, %arg1: index, %arg2: index, %arg3: f32):
    "memref.store"(%arg3, %arg0, %arg1, %arg2) : (f32, memref<10x42xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x32x15x13x27xf32>) -> (), sym_name = "static_memref_dim"}> ({
  ^bb0(%arg0: memref<42x32x15x13x27xf32>):
    %0 = "arith.constant"() <{value = 0 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<42x32x15x13x27xf32>, index) -> index
    %2 = "arith.constant"() <{value = 1 : index}> : () -> index
    %3 = "memref.dim"(%arg0, %2) : (memref<42x32x15x13x27xf32>, index) -> index
    %4 = "arith.constant"() <{value = 2 : index}> : () -> index
    %5 = "memref.dim"(%arg0, %4) : (memref<42x32x15x13x27xf32>, index) -> index
    %6 = "arith.constant"() <{value = 3 : index}> : () -> index
    %7 = "memref.dim"(%arg0, %6) : (memref<42x32x15x13x27xf32>, index) -> index
    %8 = "arith.constant"() <{value = 4 : index}> : () -> index
    %9 = "memref.dim"(%arg0, %8) : (memref<42x32x15x13x27xf32>, index) -> index
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<42x32x15x13x27xf32>) -> index, sym_name = "static_out_of_bound_memref_dim"}> ({
  ^bb0(%arg0: memref<42x32x15x13x27xf32>):
    %0 = "arith.constant"() <{value = -7 : index}> : () -> index
    %1 = "memref.dim"(%arg0, %0) : (memref<42x32x15x13x27xf32>, index) -> index
    "func.return"(%1) : (index) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "address"}> ({
    %0 = "arith.constant"() <{value = 1 : index}> : () -> index
    %1 = "memref.alloc"(%0) <{operandSegmentSizes = array<i32: 1, 0>}> : (index) -> memref<?xvector<2xf32>>
    "func.return"() : () -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<index = 32 : i64>} : () -> ()

// -----
"builtin.module"() ({
  "memref.global"() <{constant, initial_value = dense<[2, 6, 20]> : tensor<3xi64>, sym_name = "__constant_3xi64", sym_visibility = "private", type = memref<3xi64>}> : () -> ()
  "func.func"() <{function_type = (memref<4x5x6xf32>) -> memref<2x6x20xf32>, sym_name = "memref.reshape"}> ({
  ^bb0(%arg0: memref<4x5x6xf32>):
    %0 = "memref.get_global"() <{name = @__constant_3xi64}> : () -> memref<3xi64>
    %1 = "memref.reshape"(%arg0, %0) : (memref<4x5x6xf32>, memref<3xi64>) -> memref<2x6x20xf32>
    "func.return"(%1) : (memref<2x6x20xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?x?xf32>, memref<4xi64>) -> memref<?x?x12x32xf32>, sym_name = "memref.reshape.dynamic.dim"}> ({
  ^bb0(%arg0: memref<?x?x?xf32>, %arg1: memref<4xi64>):
    %0 = "memref.reshape"(%arg0, %arg1) : (memref<?x?x?xf32>, memref<4xi64>) -> memref<?x?x12x32xf32>
    "func.return"(%0) : (memref<?x?x12x32xf32>) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<?x?xi32>, memref<1xindex>) -> memref<?xi32>, sym_name = "memref.reshape_index"}> ({
  ^bb0(%arg1: memref<?x?xi32>, %arg2: memref<1xindex>):
    %1 = "memref.reshape"(%arg1, %arg2) : (memref<?x?xi32>, memref<1xindex>) -> memref<?xi32>
    "func.return"(%1) : (memref<?xi32>) -> ()
  }) : () -> ()
  "func.func"() <{function_type = (memref<?xf32>) -> memref<?xf32, 1>, sym_name = "memref_memory_space_cast"}> ({
  ^bb0(%arg0: memref<?xf32>):
    %0 = "memref.memory_space_cast"(%arg0) : (memref<?xf32>) -> memref<?xf32, 1>
    "func.return"(%0) : (memref<?xf32, 1>) -> ()
  }) : () -> ()
}) : () -> ()

