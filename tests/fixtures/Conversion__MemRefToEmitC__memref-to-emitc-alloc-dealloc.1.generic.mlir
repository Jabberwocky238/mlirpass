"builtin.module"() ({
  "emitc.include"() <{include = "stdlib.h", is_standard_include}> : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "alloc_and_dealloc"}> ({
    %19 = "emitc.call_opaque"() <{args = [i32], callee = "sizeof"}> : () -> !emitc.size_t
    %20 = "emitc.constant"() <{value = 999 : index}> : () -> index
    %21 = "emitc.mul"(%19, %20) : (!emitc.size_t, index) -> !emitc.size_t
    %22 = "emitc.call_opaque"(%21) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %23 = "emitc.cast"(%22) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<i32>
    %24 = "emitc.cast"(%23) : (!emitc.ptr<i32>) -> !emitc.ptr<!emitc.opaque<"void">>
    "emitc.call_opaque"(%24) <{callee = "free"}> : (!emitc.ptr<!emitc.opaque<"void">>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "alloc_and_dealloc_aligned"}> ({
    %12 = "emitc.call_opaque"() <{args = [f32], callee = "sizeof"}> : () -> !emitc.size_t
    %13 = "emitc.constant"() <{value = 999 : index}> : () -> index
    %14 = "emitc.mul"(%12, %13) : (!emitc.size_t, index) -> !emitc.size_t
    %15 = "emitc.constant"() <{value = 64 : index}> : () -> !emitc.size_t
    %16 = "emitc.call_opaque"(%15, %14) <{callee = "aligned_alloc"}> : (!emitc.size_t, !emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %17 = "emitc.cast"(%16) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<f32>
    %18 = "emitc.cast"(%17) : (!emitc.ptr<f32>) -> !emitc.ptr<!emitc.opaque<"void">>
    "emitc.call_opaque"(%18) <{callee = "free"}> : (!emitc.ptr<!emitc.opaque<"void">>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "allocating_and_deallocating_multi"}> ({
    %6 = "emitc.call_opaque"() <{args = [i32], callee = "sizeof"}> : () -> !emitc.size_t
    %7 = "emitc.constant"() <{value = 6993 : index}> : () -> index
    %8 = "emitc.mul"(%6, %7) : (!emitc.size_t, index) -> !emitc.size_t
    %9 = "emitc.call_opaque"(%8) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %10 = "emitc.cast"(%9) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<i32>
    %11 = "emitc.cast"(%10) : (!emitc.ptr<i32>) -> !emitc.ptr<!emitc.opaque<"void">>
    "emitc.call_opaque"(%11) <{callee = "free"}> : (!emitc.ptr<!emitc.opaque<"void">>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "alloc_and_dealloc_rank0"}> ({
    %0 = "emitc.call_opaque"() <{args = [i32], callee = "sizeof"}> : () -> !emitc.size_t
    %1 = "emitc.constant"() <{value = 1 : index}> : () -> index
    %2 = "emitc.mul"(%0, %1) : (!emitc.size_t, index) -> !emitc.size_t
    %3 = "emitc.call_opaque"(%2) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %4 = "emitc.cast"(%3) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<i32>
    %5 = "emitc.cast"(%4) : (!emitc.ptr<i32>) -> !emitc.ptr<!emitc.opaque<"void">>
    "emitc.call_opaque"(%5) <{callee = "free"}> : (!emitc.ptr<!emitc.opaque<"void">>) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

