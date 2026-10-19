"builtin.module"() ({
  "emitc.include"() <{include = "stdlib.h", is_standard_include}> : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "alloc"}> ({
    %11 = "emitc.call_opaque"() <{args = [i32], callee = "sizeof"}> : () -> !emitc.size_t
    %12 = "emitc.constant"() <{value = 999 : index}> : () -> index
    %13 = "emitc.mul"(%11, %12) : (!emitc.size_t, index) -> !emitc.size_t
    %14 = "emitc.call_opaque"(%13) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %15 = "emitc.cast"(%14) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<i32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "alloc_aligned"}> ({
    %5 = "emitc.call_opaque"() <{args = [f32], callee = "sizeof"}> : () -> !emitc.size_t
    %6 = "emitc.constant"() <{value = 999 : index}> : () -> index
    %7 = "emitc.mul"(%5, %6) : (!emitc.size_t, index) -> !emitc.size_t
    %8 = "emitc.constant"() <{value = 64 : index}> : () -> !emitc.size_t
    %9 = "emitc.call_opaque"(%8, %7) <{callee = "aligned_alloc"}> : (!emitc.size_t, !emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %10 = "emitc.cast"(%9) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<f32>
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "allocating_multi"}> ({
    %0 = "emitc.call_opaque"() <{args = [i32], callee = "sizeof"}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 6993 : index}> : () -> index
    %2 = "emitc.mul"(%0, %1) : (!emitc.size_t, index) -> !emitc.size_t
    %3 = "emitc.call_opaque"(%2) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = "emitc.cast"(%3) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<i32>
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

