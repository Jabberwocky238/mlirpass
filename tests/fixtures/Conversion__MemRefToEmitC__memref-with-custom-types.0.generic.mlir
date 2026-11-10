"builtin.module"() ({
  "emitc.func"() <{function_type = () -> (), sym_name = "alloc_with_custom_element_type"}> ({
    %0 = "emitc.call_opaque"() <{args = [!emitc.opaque<"TestElementT">], callee = "sizeof"}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 10 : index}> : () -> index
    %2 = "emitc.mul"(%0, %1) : (!emitc.size_t, index) -> !emitc.size_t
    %3 = "emitc.call_opaque"(%2) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = "emitc.cast"(%3) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<!emitc.opaque<"TestElementT">>
    "emitc.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.func"() <{function_type = (!emitc.array<10x!emitc.opaque<"TestElementT">>, !emitc.array<10x!emitc.opaque<"TestElementT">>) -> (), sym_name = "copy_with_custom_element_type"}> ({
  ^bb0(%arg0: !emitc.array<10x!emitc.opaque<"TestElementT">>, %arg1: !emitc.array<10x!emitc.opaque<"TestElementT">>):
    %0 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %1 = "emitc.subscript"(%arg0, %0) : (!emitc.array<10x!emitc.opaque<"TestElementT">>, index) -> !emitc.lvalue<!emitc.opaque<"TestElementT">>
    %2 = "emitc.address_of"(%1) : (!emitc.lvalue<!emitc.opaque<"TestElementT">>) -> !emitc.ptr<!emitc.opaque<"TestElementT">>
    %3 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %4 = "emitc.subscript"(%arg1, %3) : (!emitc.array<10x!emitc.opaque<"TestElementT">>, index) -> !emitc.lvalue<!emitc.opaque<"TestElementT">>
    %5 = "emitc.address_of"(%4) : (!emitc.lvalue<!emitc.opaque<"TestElementT">>) -> !emitc.ptr<!emitc.opaque<"TestElementT">>
    %6 = "emitc.call_opaque"() <{args = [!emitc.opaque<"TestElementT">], callee = "sizeof"}> : () -> !emitc.size_t
    %7 = "emitc.constant"() <{value = 10 : index}> : () -> index
    %8 = "emitc.mul"(%6, %7) : (!emitc.size_t, index) -> !emitc.size_t
    "emitc.call_opaque"(%5, %2, %8) <{callee = "memcpy"}> : (!emitc.ptr<!emitc.opaque<"TestElementT">>, !emitc.ptr<!emitc.opaque<"TestElementT">>, !emitc.size_t) -> ()
    "emitc.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.func"() <{function_type = (!emitc.opaque<"TestElementT">, !emitc.size_t) -> (), sym_name = "store_with_custom_element_type"}> ({
  ^bb0(%arg0: !emitc.opaque<"TestElementT">, %arg1: !emitc.size_t):
    %0 = "emitc.call_opaque"() <{args = [!emitc.opaque<"TestElementT">], callee = "sizeof"}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 4 : index}> : () -> index
    %2 = "emitc.mul"(%0, %1) : (!emitc.size_t, index) -> !emitc.size_t
    %3 = "emitc.call_opaque"(%2) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = "emitc.cast"(%3) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<!emitc.opaque<"TestElementT">>
    %5 = "emitc.subscript"(%4, %arg1) : (!emitc.ptr<!emitc.opaque<"TestElementT">>, !emitc.size_t) -> !emitc.lvalue<!emitc.opaque<"TestElementT">>
    "emitc.assign"(%5, %arg0) : (!emitc.lvalue<!emitc.opaque<"TestElementT">>, !emitc.opaque<"TestElementT">) -> ()
    "emitc.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.func"() <{function_type = (!emitc.size_t) -> !emitc.opaque<"TestElementT">, sym_name = "load_with_custom_element_type"}> ({
  ^bb0(%arg0: !emitc.size_t):
    %0 = "emitc.call_opaque"() <{args = [!emitc.opaque<"TestElementT">], callee = "sizeof"}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 4 : index}> : () -> index
    %2 = "emitc.mul"(%0, %1) : (!emitc.size_t, index) -> !emitc.size_t
    %3 = "emitc.call_opaque"(%2) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = "emitc.cast"(%3) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<!emitc.opaque<"TestElementT">>
    %5 = "emitc.subscript"(%4, %arg0) : (!emitc.ptr<!emitc.opaque<"TestElementT">>, !emitc.size_t) -> !emitc.lvalue<!emitc.opaque<"TestElementT">>
    %6 = "emitc.load"(%5) : (!emitc.lvalue<!emitc.opaque<"TestElementT">>) -> !emitc.opaque<"TestElementT">
    "emitc.return"(%6) : (!emitc.opaque<"TestElementT">) -> ()
  }) : () -> ()
}) : () -> ()

