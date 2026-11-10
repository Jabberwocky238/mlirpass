module {
  emitc.func @foo() {
    return
  }
}

// -----
module {
  emitc.func private @foo() attributes {specifiers = ["static"]} {
    return
  }
}

// -----
module {
  emitc.func @foo(%arg0: i32) {
    call_opaque "bar"(%arg0)  : (i32) -> ()
    return
  }
}

// -----
module {
  emitc.func @foo(%arg0: i32) -> i32 {
    return %arg0 : i32
  }
}

// -----
module {
  emitc.func @foo(%arg0: i32, %arg1: i32) -> i32 {
    %0 = add %arg0, %arg1 : (i32, i32) -> i32
    return %0 : i32
  }
}

// -----
module {
  emitc.func private @return_i32(%arg0: i32) -> i32 attributes {specifiers = ["static"]} {
    return %arg0 : i32
  }
  emitc.func @call(%arg0: i32) -> i32 {
    %0 = call @return_i32(%arg0) : (i32) -> i32
    return %0 : i32
  }
}

// -----
module {
  emitc.func private @return_i32(i32) -> i32 attributes {specifiers = ["extern"]}
}

// -----
module {
  emitc.func private @return_void() attributes {specifiers = ["static"]} {
    return
  }
  emitc.func @call() {
    call @return_void() : () -> ()
    return
  }
}

// -----
module {
  emitc.class struct @return_i32_i32 {
    emitc.field @field0 : i32
    emitc.field @field1 : i32
  }
  emitc.func @return_two(%arg0: i32, %arg1: i32) -> !emitc.opaque<"struct return_i32_i32"> {
    %0 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>
    %1 = "emitc.member"(%0) <{member = "field0"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    assign %arg0 : i32 to %1 : <i32>
    %2 = "emitc.member"(%0) <{member = "field1"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    assign %arg1 : i32 to %2 : <i32>
    %3 = load %0 : <!emitc.opaque<"struct return_i32_i32">>
    return %3 : !emitc.opaque<"struct return_i32_i32">
  }
}

// -----
module {
  emitc.class struct @return_i32_i32 {
    emitc.field @field0 : i32
    emitc.field @field1 : i32
  }
  emitc.func @return_two(%arg0: i32, %arg1: i32) -> !emitc.opaque<"struct return_i32_i32"> {
    %0 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>
    %1 = "emitc.member"(%0) <{member = "field0"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    assign %arg0 : i32 to %1 : <i32>
    %2 = "emitc.member"(%0) <{member = "field1"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    assign %arg1 : i32 to %2 : <i32>
    %3 = load %0 : <!emitc.opaque<"struct return_i32_i32">>
    return %3 : !emitc.opaque<"struct return_i32_i32">
  }
  emitc.func @caller(%arg0: i32) -> i32 {
    %0 = call @return_two(%arg0, %arg0) : (i32, i32) -> !emitc.opaque<"struct return_i32_i32">
    %1 = "emitc.member"(%0) <{member = "field1"}> : (!emitc.opaque<"struct return_i32_i32">) -> i32
    return %1 : i32
  }
}

// -----
module {
  emitc.class struct @return_i32_i32 {
    emitc.field @field0 : i32
    emitc.field @field1 : i32
  }
  emitc.func @first(%arg0: i32) -> !emitc.opaque<"struct return_i32_i32"> {
    %0 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>
    %1 = "emitc.member"(%0) <{member = "field0"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    assign %arg0 : i32 to %1 : <i32>
    %2 = "emitc.member"(%0) <{member = "field1"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    assign %arg0 : i32 to %2 : <i32>
    %3 = load %0 : <!emitc.opaque<"struct return_i32_i32">>
    return %3 : !emitc.opaque<"struct return_i32_i32">
  }
  emitc.func @second(%arg0: i32) -> !emitc.opaque<"struct return_i32_i32"> {
    %0 = "emitc.variable"() <{value = #emitc.opaque<"">}> : () -> !emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>
    %1 = "emitc.member"(%0) <{member = "field0"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    assign %arg0 : i32 to %1 : <i32>
    %2 = "emitc.member"(%0) <{member = "field1"}> : (!emitc.lvalue<!emitc.opaque<"struct return_i32_i32">>) -> !emitc.lvalue<i32>
    assign %arg0 : i32 to %2 : <i32>
    %3 = load %0 : <!emitc.opaque<"struct return_i32_i32">>
    return %3 : !emitc.opaque<"struct return_i32_i32">
  }
}

// -----
module {
  emitc.func private @memref_callee(!emitc.array<4x8xf32>) attributes {specifiers = ["extern"]}
  emitc.func @memref_call(%arg0: !emitc.array<4x8xf32>) {
    call @memref_callee(%arg0) : (!emitc.array<4x8xf32>) -> ()
    return
  }
}

