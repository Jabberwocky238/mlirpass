"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "alloca"}> ({
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, f32, index, index) -> (), sym_name = "memref_store"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: f32, %arg2: index, %arg3: index):
    "memref.store"(%arg1, %arg0, %arg2, %arg3) : (f32, memref<4x8xf32>, index, index) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, index, index) -> f32, sym_name = "memref_load"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: index, %arg2: index):
    %0 = "memref.load"(%arg0, %arg1, %arg2) : (memref<4x8xf32>, index, index) -> f32
    "func.return"(%0) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "globals"}> ({
  "memref.global"() <{constant, initial_value = dense<4.000000e+00> : tensor<3x7xf32>, sym_name = "internal_global", sym_visibility = "private", type = memref<3x7xf32>}> : () -> ()
  "memref.global"() <{constant, initial_value = dense<-1> : tensor<i32>, sym_name = "__constant_xi32", sym_visibility = "private", type = memref<i32>}> : () -> ()
  "memref.global"() <{sym_name = "public_global", type = memref<3x7xf32>}> : () -> ()
  "memref.global"() <{initial_value, sym_name = "uninitialized_global", type = memref<3x7xf32>}> : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "use_global"}> ({
    %0 = "memref.get_global"() <{name = @public_global}> : () -> memref<3x7xf32>
    %1 = "memref.get_global"() <{name = @__constant_xi32}> : () -> memref<i32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

