module {
  emitc.func @alloc_with_custom_element_type() {
    %0 = call_opaque "sizeof"() <{args = [!emitc.opaque<"TestElementT">]}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 10 : index}> : () -> index
    %2 = mul %0, %1 : (!emitc.size_t, index) -> !emitc.size_t
    %3 = call_opaque "malloc"(%2)  : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = cast %3 : !emitc.ptr<!emitc.opaque<"void">> to !emitc.ptr<!emitc.opaque<"TestElementT">>
    return
  }
}

// -----
module {
  emitc.func @copy_with_custom_element_type(%arg0: !emitc.array<10x!emitc.opaque<"TestElementT">>, %arg1: !emitc.array<10x!emitc.opaque<"TestElementT">>) {
    %0 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %1 = subscript %arg0[%0] : (!emitc.array<10x!emitc.opaque<"TestElementT">>, index) -> !emitc.lvalue<!emitc.opaque<"TestElementT">>
    %2 = address_of %1 : !emitc.lvalue<!emitc.opaque<"TestElementT">>
    %3 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %4 = subscript %arg1[%3] : (!emitc.array<10x!emitc.opaque<"TestElementT">>, index) -> !emitc.lvalue<!emitc.opaque<"TestElementT">>
    %5 = address_of %4 : !emitc.lvalue<!emitc.opaque<"TestElementT">>
    %6 = call_opaque "sizeof"() <{args = [!emitc.opaque<"TestElementT">]}> : () -> !emitc.size_t
    %7 = "emitc.constant"() <{value = 10 : index}> : () -> index
    %8 = mul %6, %7 : (!emitc.size_t, index) -> !emitc.size_t
    call_opaque "memcpy"(%5, %2, %8)  : (!emitc.ptr<!emitc.opaque<"TestElementT">>, !emitc.ptr<!emitc.opaque<"TestElementT">>, !emitc.size_t) -> ()
    return
  }
}

// -----
module {
  emitc.func @store_with_custom_element_type(%arg0: !emitc.opaque<"TestElementT">, %arg1: !emitc.size_t) {
    %0 = call_opaque "sizeof"() <{args = [!emitc.opaque<"TestElementT">]}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 4 : index}> : () -> index
    %2 = mul %0, %1 : (!emitc.size_t, index) -> !emitc.size_t
    %3 = call_opaque "malloc"(%2)  : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = cast %3 : !emitc.ptr<!emitc.opaque<"void">> to !emitc.ptr<!emitc.opaque<"TestElementT">>
    %5 = subscript %4[%arg1] : (!emitc.ptr<!emitc.opaque<"TestElementT">>, !emitc.size_t) -> !emitc.lvalue<!emitc.opaque<"TestElementT">>
    assign %arg0 : !emitc.opaque<"TestElementT"> to %5 : <!emitc.opaque<"TestElementT">>
    return
  }
}

// -----
module {
  emitc.func @load_with_custom_element_type(%arg0: !emitc.size_t) -> !emitc.opaque<"TestElementT"> {
    %0 = call_opaque "sizeof"() <{args = [!emitc.opaque<"TestElementT">]}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 4 : index}> : () -> index
    %2 = mul %0, %1 : (!emitc.size_t, index) -> !emitc.size_t
    %3 = call_opaque "malloc"(%2)  : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = cast %3 : !emitc.ptr<!emitc.opaque<"void">> to !emitc.ptr<!emitc.opaque<"TestElementT">>
    %5 = subscript %4[%arg0] : (!emitc.ptr<!emitc.opaque<"TestElementT">>, !emitc.size_t) -> !emitc.lvalue<!emitc.opaque<"TestElementT">>
    %6 = load %5 : <!emitc.opaque<"TestElementT">>
    return %6 : !emitc.opaque<"TestElementT">
  }
}

