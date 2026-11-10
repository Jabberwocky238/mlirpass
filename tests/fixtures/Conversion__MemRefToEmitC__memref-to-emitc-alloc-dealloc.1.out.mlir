module {
  emitc.include <"stdlib.h">
  func.func @alloc_and_dealloc() {
    %0 = emitc.call_opaque "sizeof"() <{args = [i32]}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 999 : index}> : () -> index
    %2 = emitc.mul %0, %1 : (!emitc.size_t, index) -> !emitc.size_t
    %3 = emitc.call_opaque "malloc"(%2)  : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = emitc.cast %3 : !emitc.ptr<!emitc.opaque<"void">> to !emitc.ptr<i32>
    %5 = emitc.cast %4 : !emitc.ptr<i32> to !emitc.ptr<!emitc.opaque<"void">>
    emitc.call_opaque "free"(%5)  : (!emitc.ptr<!emitc.opaque<"void">>) -> ()
    return
  }
  func.func @alloc_and_dealloc_aligned() {
    %0 = emitc.call_opaque "sizeof"() <{args = [f32]}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 999 : index}> : () -> index
    %2 = emitc.mul %0, %1 : (!emitc.size_t, index) -> !emitc.size_t
    %3 = "emitc.constant"() <{value = 64 : index}> : () -> !emitc.size_t
    %4 = emitc.call_opaque "aligned_alloc"(%3, %2)  : (!emitc.size_t, !emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %5 = emitc.cast %4 : !emitc.ptr<!emitc.opaque<"void">> to !emitc.ptr<f32>
    %6 = emitc.cast %5 : !emitc.ptr<f32> to !emitc.ptr<!emitc.opaque<"void">>
    emitc.call_opaque "free"(%6)  : (!emitc.ptr<!emitc.opaque<"void">>) -> ()
    return
  }
  func.func @allocating_and_deallocating_multi() {
    %0 = emitc.call_opaque "sizeof"() <{args = [i32]}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 6993 : index}> : () -> index
    %2 = emitc.mul %0, %1 : (!emitc.size_t, index) -> !emitc.size_t
    %3 = emitc.call_opaque "malloc"(%2)  : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = emitc.cast %3 : !emitc.ptr<!emitc.opaque<"void">> to !emitc.ptr<i32>
    %5 = emitc.cast %4 : !emitc.ptr<i32> to !emitc.ptr<!emitc.opaque<"void">>
    emitc.call_opaque "free"(%5)  : (!emitc.ptr<!emitc.opaque<"void">>) -> ()
    return
  }
  func.func @alloc_and_dealloc_rank0() {
    %0 = emitc.call_opaque "sizeof"() <{args = [i32]}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 1 : index}> : () -> index
    %2 = emitc.mul %0, %1 : (!emitc.size_t, index) -> !emitc.size_t
    %3 = emitc.call_opaque "malloc"(%2)  : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = emitc.cast %3 : !emitc.ptr<!emitc.opaque<"void">> to !emitc.ptr<i32>
    %5 = emitc.cast %4 : !emitc.ptr<i32> to !emitc.ptr<!emitc.opaque<"void">>
    emitc.call_opaque "free"(%5)  : (!emitc.ptr<!emitc.opaque<"void">>) -> ()
    return
  }
}

