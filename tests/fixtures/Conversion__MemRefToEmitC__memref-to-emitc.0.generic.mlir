"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "alloca"}> ({
    %0 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.array<2xf32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, f32, index, index) -> (), sym_name = "memref_store"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: f32, %arg2: index, %arg3: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4x8xf32>) -> !emitc.array<4x8xf32>
    %1 = "emitc.subscript"(%0, %arg2, %arg3) : (!emitc.array<4x8xf32>, index, index) -> !emitc.lvalue<f32>
    "emitc.assign"(%1, %arg1) : (!emitc.lvalue<f32>, f32) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "func.func"() <{function_type = (memref<4x8xf32>, index, index) -> f32, sym_name = "memref_load"}> ({
  ^bb0(%arg0: memref<4x8xf32>, %arg1: index, %arg2: index):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<4x8xf32>) -> !emitc.array<4x8xf32>
    %1 = "emitc.subscript"(%0, %arg1, %arg2) : (!emitc.array<4x8xf32>, index, index) -> !emitc.lvalue<f32>
    %2 = "emitc.load"(%1) : (!emitc.lvalue<f32>) -> f32
    "func.return"(%2) : (f32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() <{sym_name = "globals"}> ({
  "emitc.global"() <{const_specifier, initial_value = dense<4.000000e+00> : tensor<3x7xf32>, static_specifier, sym_name = "internal_global", type = !emitc.array<3x7xf32>}> : () -> ()
  "emitc.global"() <{const_specifier, initial_value = -1 : i32, static_specifier, sym_name = "__constant_xi32", type = i32}> : () -> ()
  "emitc.global"() <{extern_specifier, sym_name = "public_global", type = !emitc.array<3x7xf32>}> : () -> ()
  "emitc.global"() <{extern_specifier, sym_name = "uninitialized_global", type = !emitc.array<3x7xf32>}> : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "use_global"}> ({
    %0 = "emitc.get_global"() <{name = @public_global}> : () -> !emitc.array<3x7xf32>
    %1 = "emitc.get_global"() <{name = @__constant_xi32}> : () -> !emitc.lvalue<i32>
    %2 = "emitc.address_of"(%1) : (!emitc.lvalue<i32>) -> !emitc.ptr<i32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

