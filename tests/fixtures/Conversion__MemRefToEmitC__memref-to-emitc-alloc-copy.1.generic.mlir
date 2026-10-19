"builtin.module"() ({
  "emitc.include"() <{include = "stdlib.h", is_standard_include}> : () -> ()
  "emitc.include"() <{include = "string.h", is_standard_include}> : () -> ()
  "func.func"() <{function_type = (memref<999xi32>) -> (), sym_name = "alloc_copy"}> ({
  ^bb0(%arg0: memref<999xi32>):
    %0 = "builtin.unrealized_conversion_cast"(%arg0) : (memref<999xi32>) -> !emitc.array<999xi32>
    %1 = "emitc.call_opaque"() <{args = [i32], callee = "sizeof"}> : () -> !emitc.size_t
    %2 = "emitc.constant"() <{value = 999 : index}> : () -> index
    %3 = "emitc.mul"(%1, %2) : (!emitc.size_t, index) -> !emitc.size_t
    %4 = "emitc.call_opaque"(%3) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %5 = "emitc.cast"(%4) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<i32>
    %6 = "builtin.unrealized_conversion_cast"(%5) : (!emitc.ptr<i32>) -> !emitc.array<999xi32>
    %7 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %8 = "emitc.subscript"(%0, %7) : (!emitc.array<999xi32>, index) -> !emitc.lvalue<i32>
    %9 = "emitc.address_of"(%8) : (!emitc.lvalue<i32>) -> !emitc.ptr<i32>
    %10 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %11 = "emitc.subscript"(%6, %10) : (!emitc.array<999xi32>, index) -> !emitc.lvalue<i32>
    %12 = "emitc.address_of"(%11) : (!emitc.lvalue<i32>) -> !emitc.ptr<i32>
    %13 = "emitc.call_opaque"() <{args = [i32], callee = "sizeof"}> : () -> !emitc.size_t
    %14 = "emitc.constant"() <{value = 999 : index}> : () -> index
    %15 = "emitc.mul"(%13, %14) : (!emitc.size_t, index) -> !emitc.size_t
    "emitc.call_opaque"(%12, %9, %15) <{callee = "memcpy"}> : (!emitc.ptr<i32>, !emitc.ptr<i32>, !emitc.size_t) -> ()
    %16 = "emitc.call_opaque"() <{args = [i32], callee = "sizeof"}> : () -> !emitc.size_t
    %17 = "emitc.constant"() <{value = 999 : index}> : () -> index
    %18 = "emitc.mul"(%16, %17) : (!emitc.size_t, index) -> !emitc.size_t
    %19 = "emitc.call_opaque"(%18) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %20 = "emitc.cast"(%19) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<i32>
    %21 = "builtin.unrealized_conversion_cast"(%20) : (!emitc.ptr<i32>) -> !emitc.array<999xi32>
    %22 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %23 = "emitc.subscript"(%0, %22) : (!emitc.array<999xi32>, index) -> !emitc.lvalue<i32>
    %24 = "emitc.address_of"(%23) : (!emitc.lvalue<i32>) -> !emitc.ptr<i32>
    %25 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %26 = "emitc.subscript"(%21, %25) : (!emitc.array<999xi32>, index) -> !emitc.lvalue<i32>
    %27 = "emitc.address_of"(%26) : (!emitc.lvalue<i32>) -> !emitc.ptr<i32>
    %28 = "emitc.call_opaque"() <{args = [i32], callee = "sizeof"}> : () -> !emitc.size_t
    %29 = "emitc.constant"() <{value = 999 : index}> : () -> index
    %30 = "emitc.mul"(%28, %29) : (!emitc.size_t, index) -> !emitc.size_t
    "emitc.call_opaque"(%27, %24, %30) <{callee = "memcpy"}> : (!emitc.ptr<i32>, !emitc.ptr<i32>, !emitc.size_t) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

