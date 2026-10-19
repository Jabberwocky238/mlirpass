"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "coro_id"}> ({
    %12 = "async.coro.id"() : () -> !async.coro.id
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "coro_begin"}> ({
    %10 = "async.coro.id"() : () -> !async.coro.id
    %11 = "async.coro.begin"(%10) : (!async.coro.id) -> !async.coro.handle
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "coro_free"}> ({
    %8 = "async.coro.id"() : () -> !async.coro.id
    %9 = "async.coro.begin"(%8) : (!async.coro.id) -> !async.coro.handle
    "async.coro.free"(%8, %9) : (!async.coro.id, !async.coro.handle) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "coro_end"}> ({
    %6 = "async.coro.id"() : () -> !async.coro.id
    %7 = "async.coro.begin"(%6) : (!async.coro.id) -> !async.coro.handle
    "async.coro.end"(%7) : (!async.coro.handle) -> ()
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "coro_save"}> ({
    %3 = "async.coro.id"() : () -> !async.coro.id
    %4 = "async.coro.begin"(%3) : (!async.coro.id) -> !async.coro.handle
    %5 = "async.coro.save"(%4) : (!async.coro.handle) -> !async.coro.state
    "func.return"() : () -> ()
  }) : () -> ()
  "func.func"() <{function_type = () -> (), sym_name = "coro_suspend"}> ({
    %0 = "async.coro.id"() : () -> !async.coro.id
    %1 = "async.coro.begin"(%0) : (!async.coro.id) -> !async.coro.handle
    %2 = "async.coro.save"(%1) : (!async.coro.handle) -> !async.coro.state
    "async.coro.suspend"(%2)[^bb3, ^bb1, ^bb2] : (!async.coro.state) -> ()
  ^bb1:  // pred: ^bb0
    "func.return"() {coro.resume} : () -> ()
  ^bb2:  // pred: ^bb0
    "func.return"() {coro.cleanup} : () -> ()
  ^bb3:  // pred: ^bb0
    "func.return"() {coro.suspend} : () -> ()
  }) : () -> ()
}) : () -> ()

