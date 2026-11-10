"builtin.module"() ({
  "emitc.func"() <{function_type = (f32, !emitc.size_t, !emitc.size_t) -> (), specifiers = ["static"], sym_name = "memref_alloc_store"}> ({
  ^bb0(%arg9: f32, %arg10: !emitc.size_t, %arg11: !emitc.size_t):
    %33 = "emitc.call_opaque"() <{args = [f32], callee = "sizeof"}> : () -> !emitc.size_t
    %34 = "emitc.constant"() <{value = 32 : index}> : () -> index
    %35 = "emitc.mul"(%33, %34) : (!emitc.size_t, index) -> !emitc.size_t
    %36 = "emitc.call_opaque"(%35) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %37 = "emitc.cast"(%36) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<f32>
    %38 = "emitc.constant"() <{value = 8 : index}> : () -> !emitc.size_t
    %39 = "emitc.mul"(%arg10, %38) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %40 = "emitc.add"(%39, %arg11) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %41 = "emitc.subscript"(%37, %40) : (!emitc.ptr<f32>, !emitc.size_t) -> !emitc.lvalue<f32>
    "emitc.assign"(%41, %arg9) : (!emitc.lvalue<f32>, f32) -> ()
    "emitc.return"() : () -> ()
  }) {sym_visibility = "private"} : () -> ()
  "emitc.func"() <{function_type = (!emitc.size_t, !emitc.size_t) -> f32, specifiers = ["static"], sym_name = "memref_alloc_load"}> ({
  ^bb0(%arg7: !emitc.size_t, %arg8: !emitc.size_t):
    %23 = "emitc.call_opaque"() <{args = [f32], callee = "sizeof"}> : () -> !emitc.size_t
    %24 = "emitc.constant"() <{value = 32 : index}> : () -> index
    %25 = "emitc.mul"(%23, %24) : (!emitc.size_t, index) -> !emitc.size_t
    %26 = "emitc.call_opaque"(%25) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %27 = "emitc.cast"(%26) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<f32>
    %28 = "emitc.constant"() <{value = 8 : index}> : () -> !emitc.size_t
    %29 = "emitc.mul"(%arg7, %28) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %30 = "emitc.add"(%29, %arg8) : (!emitc.size_t, !emitc.size_t) -> !emitc.size_t
    %31 = "emitc.subscript"(%27, %30) : (!emitc.ptr<f32>, !emitc.size_t) -> !emitc.lvalue<f32>
    %32 = "emitc.load"(%31) : (!emitc.lvalue<f32>) -> f32
    "emitc.return"(%32) : (f32) -> ()
  }) {sym_visibility = "private"} : () -> ()
  "emitc.func"() <{function_type = (!emitc.array<2xf32>, !emitc.array<4x8xf32>, !emitc.size_t, !emitc.size_t) -> (), sym_name = "memref_load_store"}> ({
  ^bb0(%arg3: !emitc.array<2xf32>, %arg4: !emitc.array<4x8xf32>, %arg5: !emitc.size_t, %arg6: !emitc.size_t):
    %20 = "emitc.subscript"(%arg3, %arg5) : (!emitc.array<2xf32>, !emitc.size_t) -> !emitc.lvalue<f32>
    %21 = "emitc.load"(%20) : (!emitc.lvalue<f32>) -> f32
    %22 = "emitc.subscript"(%arg4, %arg5, %arg6) : (!emitc.array<4x8xf32>, !emitc.size_t, !emitc.size_t) -> !emitc.lvalue<f32>
    "emitc.assign"(%22, %21) : (!emitc.lvalue<f32>, f32) -> ()
    "emitc.return"() : () -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32) -> (), specifiers = ["static"], sym_name = "memref_alloc_store_rank0"}> ({
  ^bb0(%arg2: i32):
    %13 = "emitc.call_opaque"() <{args = [i32], callee = "sizeof"}> : () -> !emitc.size_t
    %14 = "emitc.constant"() <{value = 1 : index}> : () -> index
    %15 = "emitc.mul"(%13, %14) : (!emitc.size_t, index) -> !emitc.size_t
    %16 = "emitc.call_opaque"(%15) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %17 = "emitc.cast"(%16) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<i32>
    %18 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %19 = "emitc.subscript"(%17, %18) : (!emitc.ptr<i32>, index) -> !emitc.lvalue<i32>
    "emitc.assign"(%19, %arg2) : (!emitc.lvalue<i32>, i32) -> ()
    "emitc.return"() : () -> ()
  }) {sym_visibility = "private"} : () -> ()
  "emitc.func"() <{function_type = () -> i32, specifiers = ["static"], sym_name = "memref_alloc_load_rank0"}> ({
    %5 = "emitc.call_opaque"() <{args = [i32], callee = "sizeof"}> : () -> !emitc.size_t
    %6 = "emitc.constant"() <{value = 1 : index}> : () -> index
    %7 = "emitc.mul"(%5, %6) : (!emitc.size_t, index) -> !emitc.size_t
    %8 = "emitc.call_opaque"(%7) <{callee = "malloc"}> : (!emitc.size_t) -> !emitc.ptr<!emitc.opaque<"void">>
    %9 = "emitc.cast"(%8) : (!emitc.ptr<!emitc.opaque<"void">>) -> !emitc.ptr<i32>
    %10 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %11 = "emitc.subscript"(%9, %10) : (!emitc.ptr<i32>, index) -> !emitc.lvalue<i32>
    %12 = "emitc.load"(%11) : (!emitc.lvalue<i32>) -> i32
    "emitc.return"(%12) : (i32) -> ()
  }) {sym_visibility = "private"} : () -> ()
  "emitc.func"() <{function_type = (!emitc.ptr<i32>, !emitc.ptr<i32>) -> (), sym_name = "memref_load_store_rank0"}> ({
  ^bb0(%arg0: !emitc.ptr<i32>, %arg1: !emitc.ptr<i32>):
    %0 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %1 = "emitc.subscript"(%arg0, %0) : (!emitc.ptr<i32>, index) -> !emitc.lvalue<i32>
    %2 = "emitc.load"(%1) : (!emitc.lvalue<i32>) -> i32
    %3 = "emitc.constant"() <{value = 0 : index}> : () -> index
    %4 = "emitc.subscript"(%arg1, %3) : (!emitc.ptr<i32>, index) -> !emitc.lvalue<i32>
    "emitc.assign"(%4, %2) : (!emitc.lvalue<i32>, i32) -> ()
    "emitc.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

