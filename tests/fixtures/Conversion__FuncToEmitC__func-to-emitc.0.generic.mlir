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

