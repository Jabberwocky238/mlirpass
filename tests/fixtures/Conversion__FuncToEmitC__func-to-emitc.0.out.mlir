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
    call_opaque "bar"(%arg0) : (i32) -> ()
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

