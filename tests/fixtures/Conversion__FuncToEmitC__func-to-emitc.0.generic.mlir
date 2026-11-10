"builtin.module"() ({
  "emitc.func"() <{function_type = () -> (), sym_name = "foo"}> ({
    "emitc.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.func"() <{function_type = () -> (), specifiers = ["static"], sym_name = "foo"}> ({
    "emitc.return"() : () -> ()
  }) {sym_visibility = "private"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.func"() <{function_type = (i32) -> (), sym_name = "foo"}> ({
  ^bb0(%arg0: i32):
    "emitc.call_opaque"(%arg0) <{callee = "bar"}> : (i32) -> ()
    "emitc.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.func"() <{function_type = (i32) -> i32, sym_name = "foo"}> ({
  ^bb0(%arg0: i32):
    "emitc.return"(%arg0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.func"() <{function_type = (i32, i32) -> i32, sym_name = "foo"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "emitc.add"(%arg0, %arg1) : (i32, i32) -> i32
    "emitc.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.func"() <{function_type = (i32) -> i32, specifiers = ["static"], sym_name = "return_i32"}> ({
  ^bb0(%arg1: i32):
    "emitc.return"(%arg1) : (i32) -> ()
  }) {sym_visibility = "private"} : () -> ()
  "emitc.func"() <{function_type = (i32) -> i32, sym_name = "call"}> ({
  ^bb0(%arg0: i32):
    %0 = "emitc.call"(%arg0) <{callee = @return_i32}> : (i32) -> i32
    "emitc.return"(%0) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.func"() <{function_type = (i32) -> i32, specifiers = ["extern"], sym_name = "return_i32"}> ({
  }) {sym_visibility = "private"} : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.func"() <{function_type = () -> (), specifiers = ["static"], sym_name = "return_void"}> ({
    "emitc.return"() : () -> ()
  }) {sym_visibility = "private"} : () -> ()
  "emitc.func"() <{function_type = () -> (), sym_name = "call"}> ({
    "emitc.call"() <{callee = @return_void}> : () -> ()
    "emitc.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.class"() <{class_type = 1 : i32, sym_name = "return_i32_i32"}> ({
    "emitc.field"() <{sym_name = "field0", type = i32}> : () -> ()
    "emitc.field"() <{sym_name = "field1", type = i32}> : () -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32, i32) -> !emitc.opaque<"struct return_i32_i32">, sym_name = "return_two"}> ({
  ^bb0(%arg0: i32, %arg1: i32):
    %0 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>
    %1 = "emitc.member"(%0) <{member = "field0"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    "emitc.assign"(%1, %arg0) : (!emitc.lvalue<i32>, i32) -> ()
    %2 = "emitc.member"(%0) <{member = "field1"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    "emitc.assign"(%2, %arg1) : (!emitc.lvalue<i32>, i32) -> ()
    %3 = "emitc.load"(%0) : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.opaque<"struct return_i32_i32">
    "emitc.return"(%3) : (!emitc.opaque<"struct return_i32_i32">) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.class"() <{class_type = 1 : i32, sym_name = "return_i32_i32"}> ({
    "emitc.field"() <{sym_name = "field0", type = i32}> : () -> ()
    "emitc.field"() <{sym_name = "field1", type = i32}> : () -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32, i32) -> !emitc.opaque<"struct return_i32_i32">, sym_name = "return_two"}> ({
  ^bb0(%arg1: i32, %arg2: i32):
    %2 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>
    %3 = "emitc.member"(%2) <{member = "field0"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    "emitc.assign"(%3, %arg1) : (!emitc.lvalue<i32>, i32) -> ()
    %4 = "emitc.member"(%2) <{member = "field1"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    "emitc.assign"(%4, %arg2) : (!emitc.lvalue<i32>, i32) -> ()
    %5 = "emitc.load"(%2) : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.opaque<"struct return_i32_i32">
    "emitc.return"(%5) : (!emitc.opaque<"struct return_i32_i32">) -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32) -> i32, sym_name = "caller"}> ({
  ^bb0(%arg0: i32):
    %0 = "emitc.call"(%arg0, %arg0) <{callee = @return_two}> : (i32, i32) -> !emitc.opaque<"struct return_i32_i32">
    %1 = "emitc.member"(%0) <{member = "field1"}> : (!emitc.opaque<"struct return_i32_i32">) -> i32
    "emitc.return"(%1) : (i32) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.class"() <{class_type = 1 : i32, sym_name = "return_i32_i32"}> ({
    "emitc.field"() <{sym_name = "field0", type = i32}> : () -> ()
    "emitc.field"() <{sym_name = "field1", type = i32}> : () -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32) -> !emitc.opaque<"struct return_i32_i32">, sym_name = "first"}> ({
  ^bb0(%arg1: i32):
    %4 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>
    %5 = "emitc.member"(%4) <{member = "field0"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    "emitc.assign"(%5, %arg1) : (!emitc.lvalue<i32>, i32) -> ()
    %6 = "emitc.member"(%4) <{member = "field1"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    "emitc.assign"(%6, %arg1) : (!emitc.lvalue<i32>, i32) -> ()
    %7 = "emitc.load"(%4) : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.opaque<"struct return_i32_i32">
    "emitc.return"(%7) : (!emitc.opaque<"struct return_i32_i32">) -> ()
  }) : () -> ()
  "emitc.func"() <{function_type = (i32) -> !emitc.opaque<"struct return_i32_i32">, sym_name = "second"}> ({
  ^bb0(%arg0: i32):
    %0 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>
    %1 = "emitc.member"(%0) <{member = "field0"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    "emitc.assign"(%1, %arg0) : (!emitc.lvalue<i32>, i32) -> ()
    %2 = "emitc.member"(%0) <{member = "field1"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    "emitc.assign"(%2, %arg0) : (!emitc.lvalue<i32>, i32) -> ()
    %3 = "emitc.load"(%0) : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.opaque<"struct return_i32_i32">
    "emitc.return"(%3) : (!emitc.opaque<"struct return_i32_i32">) -> ()
  }) : () -> ()
}) : () -> ()

// -----
"builtin.module"() ({
  "emitc.func"() <{function_type = (!emitc.array<4x8xf32>) -> (), specifiers = ["extern"], sym_name = "memref_callee"}> ({
  }) {sym_visibility = "private"} : () -> ()
  "emitc.func"() <{function_type = (!emitc.array<4x8xf32>) -> (), sym_name = "memref_call"}> ({
  ^bb0(%arg0: !emitc.array<4x8xf32>):
    "emitc.call"(%arg0) <{callee = @memref_callee}> : (!emitc.array<4x8xf32>) -> ()
    "emitc.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

