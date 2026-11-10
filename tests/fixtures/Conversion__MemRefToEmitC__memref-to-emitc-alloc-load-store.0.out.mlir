module {
  emitc.func private @memref_alloc_store(%arg0: f32, %arg1: !emitc.size_t, %arg2: !emitc.size_t) attributes {specifiers = ["static"]} {
    %0 = call_opaque "sizeof"() <{args = [f32]}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 32 : index}> : () -> index
    %2 = mul %0, %1 : (!emitc.size_t, index) -> !emitc.size_t
    %3 = call_opaque "malloc"(%2)  : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = cast %3 : !emitc.ptr<!emitc.opaque<"void">> to !emitc.ptr<f32>
    %5 = "emitc.constant"() <{value = 8 : index}> : () -> !emitc.size_t
    %6 = mul %arg1, %5 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %7 = add %6, %arg2 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %8 = subscript %4[%7] : (!emitc.ptr<f32>, !emitc.size_t) -> !emitc.lvalue<f32>
    assign %arg0 : f32 to %8 : <f32>
    return
  }
  emitc.func private @memref_alloc_load(%arg0: !emitc.size_t, %arg1: !emitc.size_t) -> f32 attributes {specifiers = ["static"]} {
    %0 = call_opaque "sizeof"() <{args = [f32]}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 32 : index}> : () -> index
    %2 = mul %0, %1 : (!emitc.size_t, index) -> !emitc.size_t
    %3 = call_opaque "malloc"(%2)  : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = cast %3 : !emitc.ptr<!emitc.opaque<"void">> to !emitc.ptr<f32>
    %5 = "emitc.constant"() <{value = 8 : index}> : () -> !emitc.size_t
    %6 = mul %arg0, %5 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %7 = add %6, %arg1 : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %8 = subscript %4[%7] : (!emitc.ptr<f32>, !emitc.size_t) -> !emitc.lvalue<f32>
    %9 = load %8 : <f32>
    return %9 : f32
  }
  emitc.func @memref_load_store(%arg0: !emitc.array<2xf32>, %arg1: !emitc.array<4x8xf32>, %arg2: !emitc.size_t, %arg3: !emitc.size_t) {
    %0 = subscript %arg0[%arg2] : (!emitc.array<2xf32>, !emitc.size_t) -> !emitc.lvalue<f32>
    %1 = load %0 : <f32>
    %2 = subscript %arg1[%arg2, %arg3] : (!emitc.array<4x8xf32>, !emitc.size_t, !emitc.size_t) -> !emitc.lvalue<f32>
    assign %1 : f32 to %2 : <f32>
    return
  }
  emitc.func private @memref_alloc_store_rank0(%arg0: i32) attributes {specifiers = ["static"]} {
    %0 = call_opaque "sizeof"() <{args = [i32]}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 1 : index}> : () -> index
    %2 = mul %0, %1 : (!emitc.size_t, index) -> !emitc.size_t
    %3 = call_opaque "malloc"(%2)  : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = cast %3 : !emitc.ptr<!emitc.opaque<"void">> to !emitc.ptr<i32>
    %5 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %6 = subscript %4[%5] : (!emitc.ptr<i32>, index) -> !emitc.lvalue<i32>
    assign %arg0 : i32 to %6 : <i32>
    return
  }
  emitc.func private @memref_alloc_load_rank0() -> i32 attributes {specifiers = ["static"]} {
    %0 = call_opaque "sizeof"() <{args = [i32]}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 1 : index}> : () -> index
    %2 = mul %0, %1 : (!emitc.size_t, index) -> !emitc.size_t
    %3 = call_opaque "malloc"(%2)  : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = cast %3 : !emitc.ptr<!emitc.opaque<"void">> to !emitc.ptr<i32>
    %5 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %6 = subscript %4[%5] : (!emitc.ptr<i32>, index) -> !emitc.lvalue<i32>
    %7 = load %6 : <i32>
    return %7 : i32
  }
  emitc.func @memref_load_store_rank0(%arg0: !emitc.ptr<i32>, %arg1: !emitc.ptr<i32>) {
    %0 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %1 = subscript %arg0[%0] : (!emitc.ptr<i32>, index) -> !emitc.lvalue<i32>
    %2 = load %1 : <i32>
    %3 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %4 = subscript %arg1[%3] : (!emitc.ptr<i32>, index) -> !emitc.lvalue<i32>
    assign %2 : i32 to %4 : <i32>
    return
  }
}

