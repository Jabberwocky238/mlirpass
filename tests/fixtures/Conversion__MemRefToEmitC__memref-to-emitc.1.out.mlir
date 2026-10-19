module {
  func.func @alloca() {
    %0 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.array<2xf32>
    return
  }
}

// -----
module {
  func.func @memref_store(%arg0: memref<4x8xf32>, %arg1: f32, %arg2: index, %arg3: index) {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x8xf32> to !emitc.array<4x8xf32>
    %1 = emitc.subscript %0[%arg2, %arg3] : (!emitc.array<4x8xf32>, index, index) -> !emitc.lvalue<f32>
    emitc.assign %arg1 : f32 to %1 : <f32>
    return
  }
}

// -----
module {
  func.func @memref_load(%arg0: memref<4x8xf32>, %arg1: index, %arg2: index) -> f32 {
    %0 = builtin.unrealized_conversion_cast %arg0 : memref<4x8xf32> to !emitc.array<4x8xf32>
    %1 = emitc.subscript %0[%arg1, %arg2] : (!emitc.array<4x8xf32>, index, index) -> !emitc.lvalue<f32>
    %2 = emitc.load %1 : <f32>
    return %2 : f32
  }
}

// -----
module @globals {
  emitc.global static const @internal_global : !emitc.array<3x7xf32> = dense<4.000000e+00>
  emitc.global static const @__constant_xi32 : i32 = -1
  emitc.global extern @public_global : !emitc.array<3x7xf32>
  emitc.global extern @uninitialized_global : !emitc.array<3x7xf32>
  func.func @use_global() {
    %0 = emitc.get_global @public_global : !emitc.array<3x7xf32>
    %1 = emitc.get_global @__constant_xi32 : !emitc.lvalue<i32>
    %2 = emitc.address_of %1 : !emitc.lvalue<i32>
    return
  }
}

